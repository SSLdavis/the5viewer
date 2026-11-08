THE 5 VIEWER - Vercel project (static site, no build step)

Deploy with the Vercel CLI:
  1. npm i -g vercel
  2. cd the5viewer-vercel
  3. vercel --prod
     (if asked: framework = Other, no build command, output directory = ./)

Or push this folder to a GitHub repo and import it at vercel.com/new.

CHAT SETUP (Supabase, free plan)
  1. Make a free project at supabase.com.
  2. SQL Editor > New query > paste chat-setup.sql > Run.
  3. Project Settings > API: copy the Project URL and the "anon public" key.
  4. In index.html find:  const CHAT = { url: "", anonKey: "" };
     and paste both values between the quotes. Redeploy.
  Remove bad messages in Supabase > Table Editor > messages.
