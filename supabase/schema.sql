-- Archivo Digital · Trámite Abastecimiento — base compartida SOLO PARA DEMO (datos ficticios)
-- Pega este archivo completo en Supabase → SQL Editor → Run.

create table if not exists public.registros (
  store      text not null,                 -- 'tramites', 'usuarios', 'auditoria', ...
  id         text not null,
  data       jsonb not null,                -- el objeto completo (los PDF van en base64)
  origen     text,                          -- ventana que escribió (evita avisarse a sí misma)
  actualizado timestamptz not null default now(),
  primary key (store, id)
);

create index if not exists registros_store_idx on public.registros (store, actualizado desc);

-- Acceso abierto con la clave pública: aceptable solo para una demo con datos ficticios.
-- Para datos reales hay que cambiar esto por inicio de sesión (Supabase Auth) y reglas por rol.
grant select, insert, update, delete on public.registros to anon;
alter table public.registros enable row level security;
drop policy if exists demo_todo on public.registros;
create policy demo_todo on public.registros for all to anon using (true) with check (true);

-- Actividad simultánea entre equipos (Realtime)
do $$ begin
  alter publication supabase_realtime add table public.registros;
exception when duplicate_object then null; end $$;

-- Archivos (PDF) en Supabase Storage: 1 GB en el plan gratuito. Bucket privado; acceso abierto solo para la demo.
insert into storage.buckets (id, name, public, file_size_limit)
values ('archivos', 'archivos', false, 20971520)
on conflict (id) do nothing;

drop policy if exists demo_archivos_leer on storage.objects;
create policy demo_archivos_leer on storage.objects for select to anon using (bucket_id = 'archivos');
drop policy if exists demo_archivos_subir on storage.objects;
create policy demo_archivos_subir on storage.objects for insert to anon with check (bucket_id = 'archivos');
