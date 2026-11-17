/* =====================================================================
   PÁDEL UP · Configuración del sitio
   Este es el único archivo que hay que tocar para configurar la página.
   ===================================================================== */

window.PADELUP_CONFIG = {

  /* WhatsApp al que llegan los formularios.
     Código de país + número, sin + ni espacios. */
  whatsapp: "573160550008",

  /* ------------------------------------------------------------------
     GUARDADO DE LEADS (Supabase)

     Déjalos vacíos y el sitio funciona igual: no guarda nada y abre
     WhatsApp como siempre. Nada se rompe.

     Para activarlo:
       1. Corre supabase/schema.sql en el SQL Editor de Supabase.
       2. Project Settings → API:
            Project URL        → supabaseUrl
            anon public key    → supabaseKey

     La anon key es pública por diseño: viaja en el navegador de cada
     visitante. La protección está en las políticas RLS del schema,
     que solo permiten INSERT. Nadie puede leer los leads con ella.

     NUNCA pongas aquí la service_role key.
     ------------------------------------------------------------------ */
  supabaseUrl: "",
  supabaseKey: "",

  /* Versión de la política de datos vigente al momento de la
     autorización. Se guarda con cada lead como prueba del
     consentimiento (Ley 1581 de 2012, art. 9).
     Si publicas una nueva versión de politica-datos.html, súbele
     el número aquí también. */
  politicaVersion: "1.1"
};
