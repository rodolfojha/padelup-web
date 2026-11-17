# PÁDEL UP — Sitio web

Landing inmersiva de PÁDEL UP: el mapa de clubes de Colombia, partidos por nivel
y ranking real.

## Qué hay aquí

Un solo archivo (`index.html`) sin build, sin dependencias de npm y sin backend.
Se puede abrir directo en el navegador o servir como sitio estático.

| Archivo | Qué es |
|---|---|
| `index.html` | El sitio completo: HTML, CSS y JS en un archivo |
| `config.js` | **El único archivo que hay que tocar para configurar** |
| `politica-datos.html` | Política de tratamiento de datos (Ley 1581 de 2012) |
| `supabase/schema.sql` | Tabla de leads y políticas de seguridad |
| `img/logo.png` | Logo de PÁDEL UP |
| `robots.txt` / `sitemap.xml` | SEO básico |
| `404.html` | Página de error |

## Tecnología

- **Three.js r128** (desde CDN) para el campo de partículas del fondo.
  Shaders GLSL propios: las partículas mutan con el scroll entre tres estados
  — cancha de pádel → pines de mapa → red de jugadores.
- Degradación limpia: si no hay WebGL, el sitio funciona igual, solo sin fondo animado.
- Respeta `prefers-reduced-motion`.
- En móvil baja la cantidad de partículas y el pixel ratio.

## Formularios y guardado de leads

Hay dos flujos multipaso: jugador y club. Al terminar, cada uno hace dos cosas:

1. Guarda el lead en Supabase, con la fecha de autorización y la versión
   de la política vigente — prueba del consentimiento (Ley 1581, art. 9).
2. Abre WhatsApp con el mensaje ya escrito.

**Si Supabase no está configurado, el sitio funciona igual:** no guarda nada
y abre WhatsApp como siempre. El guardado también falla en silencio si no hay
red. El formulario nunca se bloquea por culpa del guardado.

### Activar el guardado

1. Crea un proyecto en [supabase.com](https://supabase.com) (plan gratis).
2. SQL Editor → New query → pega `supabase/schema.sql` completo → Run.
3. Project Settings → API, y copia en `config.js`:
   - **Project URL** → `supabaseUrl`
   - **anon public** → `supabaseKey`

Los leads se leen en Table Editor → `leads`, o se exportan a CSV desde ahí.

### Sobre la anon key

La `anon` key va en el navegador de cada visitante: es pública por diseño y no
es un secreto. Lo que protege la base son las políticas RLS del schema, que solo
permiten `INSERT`. Con esa clave **nadie puede leer, editar ni borrar leads**.

Dos cosas que romperían eso y no hay que hacer nunca:

- Desactivar RLS en la tabla `leads`.
- Agregar una política de `SELECT` para el rol `anon`.

La `service_role` key nunca va en `config.js` ni en ningún archivo del repo.

## Pendientes

1. **Dirección física del responsable** en `politica-datos.html`. El artículo 13
   del Decreto 1074 de 2015 la exige además del correo y el teléfono.
2. **Registro Nacional de Bases de Datos.** Verificar con el área legal si
   Ingenios Networking está dentro de los sujetos obligados a inscribir.
3. **Dominio.** Si se publica con GitHub Pages y dominio propio, agregar un
   archivo `CNAME` en la raíz con el dominio (ej. `padelup.co`).

## Si cambias la política de datos

Sube el número de `politicaVersion` en `config.js` y el de la cabecera de
`politica-datos.html`. Ese número se guarda con cada lead, así que sirve para
saber qué versión aceptó cada persona.

## Correr en local

```bash
python3 -m http.server 8080
# http://localhost:8080
```

No abras el archivo con `file://` si quieres probar el fondo WebGL:
algunos navegadores bloquean el CDN desde ese esquema.

## Publicar con GitHub Pages

Settings → Pages → Source: `Deploy from a branch` → Branch: `main` / `(root)`.

---

Ingenios Networking SAS · Cartagena de Indias
