-- Run this once in Supabase: SQL Editor > New query > paste > Run.

create table public.messages (
  id bigint generated always as identity primary key,
  created_at timestamptz not null default now(),
  nick text not null check (nick ~ '^[A-Za-z0-9_ .-]{2,20}$'),
  body text not null check (
    char_length(body) between 1 and 280
    and body !~* '(https?:|www\.|t\.me|discord\.gg|bit\.ly|\.com|\.io|\.xyz|\.ly|\.app|\.net|\.org)'
  )
);

alter table public.messages enable row level security;

-- anyone can read and post; nobody can edit or delete from the website
create policy "anyone can read" on public.messages for select using (true);
create policy "anyone can post" on public.messages for insert with check (true);

-- same nickname can't post more than once every 3 seconds
create function public.throttle() returns trigger language plpgsql as $$
begin
  if exists (select 1 from public.messages where nick = new.nick and created_at > now() - interval '3 seconds') then
    raise exception 'slow down';
  end if;
  return new;
end $$;
create trigger messages_throttle before insert on public.messages
  for each row execute function public.throttle();

-- To remove a message: Supabase > Table Editor > messages > delete the row.
