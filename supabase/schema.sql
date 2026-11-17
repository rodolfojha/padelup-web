-- =====================================================================
--  PÁDEL UP · Tabla de leads
--  Responsable: INGENIOS NETWORKING S.A.S. · NIT 901.142.951-7
--
--  Pégalo completo en Supabase → SQL Editor → New query → Run.
--  Es idempotente: se puede correr varias veces sin romper nada.
-- =====================================================================

create table if not exists public.leads (
  id                  uuid primary key default gen_random_uuid(),
  created_at          timestamptz not null default now(),

  -- quién es
  tipo                text not null check (tipo in ('jugador','club')),
  nombre              text not null,
  telefono            text not null,

  -- campos de jugador
  ciudad              text,
  nivel               text,
  horario             text,

  -- campos de club
  club                text,
  canchas             text,
  ocupacion           text,
  prioridad           text,

  -- prueba de la autorización (Ley 1581 de 2012, art. 9)
  autorizacion        boolean not null default false,
  politica_version    text,

  -- trazabilidad
  origen              text,
  user_agent          text,

  -- gestión comercial
  estado              text not null default 'nuevo'
                      check (estado in ('nuevo','contactado','en_proceso','cerrado','descartado')),
  notas               text
);

create index if not exists leads_created_at_idx on public.leads (created_at desc);
create index if not exists leads_tipo_idx       on public.leads (tipo);
create index if not exists leads_estado_idx     on public.leads (estado);

-- =====================================================================
--  SEGURIDAD · Row Level Security
--
--  Esto es lo que importa. La clave "anon" viaja en el navegador de
--  cualquier visitante, así que cualquiera la puede leer. Con RLS
--  activo y SOLO una política de INSERT, esa clave puede escribir
--  pero NO puede leer, editar ni borrar nada.
--
--  Si alguien desactiva RLS o agrega una política de SELECT para anon,
--  toda la base de leads queda pública. No lo hagas.
--  Los leads se leen desde el panel de Supabase o con la service_role
--  key, que nunca va en el navegador.
-- =====================================================================

alter table public.leads enable row level security;

drop policy if exists "anon_insert_leads" on public.leads;
create policy "anon_insert_leads"
  on public.leads
  for insert
  to anon
  with check (
    autorizacion = true        -- sin autorización marcada, no entra
    and char_length(nombre)   between 2 and 120
    and char_length(telefono) between 7 and 20
    and tipo in ('jugador','club')
  );

-- Sin política de SELECT, UPDATE ni DELETE para anon: queda prohibido
-- por defecto. No agregar ninguna.

-- =====================================================================
--  CONSULTAS ÚTILES (correr desde el panel, no desde el navegador)
-- =====================================================================

-- Leads de la última semana
--   select created_at, tipo, nombre, telefono, ciudad, club, prioridad
--   from public.leads
--   where created_at > now() - interval '7 days'
--   order by created_at desc;

-- Cuántos clubes por prioridad declarada
--   select prioridad, count(*) from public.leads
--   where tipo = 'club' group by prioridad order by count(*) desc;

-- Jugadores por ciudad y nivel
--   select ciudad, nivel, count(*) from public.leads
--   where tipo = 'jugador' group by ciudad, nivel order by count(*) desc;
