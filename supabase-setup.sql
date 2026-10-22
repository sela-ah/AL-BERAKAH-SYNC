-- Paste ALL of this into Supabase > SQL Editor > New query, then press Run.
create table if not exists public.reminders (
  id text primary key,
  user_id uuid not null default auth.uid(),
  data jsonb not null,
  updated_at timestamptz not null default now()
);
alter table public.reminders enable row level security;
create policy "owner can do everything" on public.reminders
  for all to authenticated
  using (user_id = auth.uid())
  with check (user_id = auth.uid());
alter publication supabase_realtime add table public.reminders;
