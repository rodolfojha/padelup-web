# PÁDEL UP — Sitio web

Landing inmersiva de PÁDEL UP: el mapa de clubes de Colombia, partidos por nivel
y ranking real.

## Qué hay aquí

Un solo archivo (`index.html`) sin build, sin dependencias de npm y sin backend.
Se puede abrir directo en el navegador o servir como sitio estático.

| Archivo | Qué es |
|---|---|
| `index.html` | El sitio completo: HTML, CSS y JS en un archivo |
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

## Formularios

Hay dos flujos multipaso (jugador y club) que **no envían nada a ningún servidor**.
Al terminar arman un mensaje de WhatsApp prellenado y abren `wa.me`.
Por eso el sitio puede vivir en hosting estático sin backend.

## Configuración antes de publicar

1. **Número de WhatsApp.** En `index.html`, busca la constante `WA` dentro del `<script>`:

   ```js
   var WA = "573000000000";
   ```

   Cámbialo por el número real de PÁDEL UP: código de país + número, sin `+` ni espacios.

2. **Política de tratamiento de datos.** En el pie hay un `[Enlace a la política]`
   sin destino. Los dos formularios capturan nombre y celular, así que esa política
   es obligatoria bajo la Ley 1581 de 2012.

3. **Dominio.** Si se publica con GitHub Pages y dominio propio, agregar un archivo
   `CNAME` en la raíz con el dominio (ej. `padelup.co`).

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
