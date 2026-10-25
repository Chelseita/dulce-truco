# Guía del alumno | Taller Dulce o Truco

**Producto:** una web de Halloween con juego de 3 intentos, usuarios anónimos y puntuación/ranking guardados en PostgreSQL.

**Forma de trabajo sugerida:** equipos de 3–4 participantes; cada equipo configura un proyecto Supabase propio para evitar sobrescribir el trabajo de otros. El profesor puede mostrar un proyecto común como demostración colectiva.

## Misión 1 (20 min): Entiende antes de programar

Piensa en tres entidades: **Jugador**, **Casa** y **Jugada**. Responde: ¿un jugador puede tener muchas jugadas? ¿una casa puede aparecer en muchas jugadas? ¿qué dato conecta las tres entidades? ¿por qué no deberíamos guardar todos los nombres y puntos en una sola columna?

Dibuja este modelo en tu cuaderno:

```text
PLAYERS (id UUID, nickname TEXT)
    1 ──────── N
              PLAYS (id, player_id FK, door_id FK, outcome, points)
    N ──────── 1
DOORS (id INTEGER, title TEXT, emoji TEXT)
```

## Misión 2 (45 min): Aprende PostgreSQL

1. Crea un proyecto Supabase. Entra al **SQL Editor**.
2. El profesor explica `CREATE TABLE`, `PRIMARY KEY`, `REFERENCES`, `UNIQUE` y `CHECK` usando `db/01_esquema.sql`.
3. Ejecuta el script completo. Comprueba las tablas `players`, `doors`, `plays` y la vista `leaderboard`.
4. Escribe y ejecuta por separado:

```sql
select * from public.doors;
select title, emoji from public.doors where active = true;
select count(*) as cantidad from public.doors;
```

5. Abre `db/02_practicas_sql.sql` y resuelve las consultas restantes cuando existan jugadores.

**Comprueba:** ¿qué pasa si se intenta repetir `id=1` en `doors`? ¿por qué PostgreSQL lo evita?

## Misión 3 (35 min): Convierte los datos en información

Conceptos: `SELECT`, `WHERE`, `ORDER BY`, `COUNT`, `JOIN`, `LEFT JOIN`, `GROUP BY`, `SUM`, `COALESCE`, `HAVING`.

```sql
-- Por qué JOIN: el nombre está en players y los puntos en plays.
select p.nickname, g.points
from public.players p
join public.plays g on g.player_id = p.id;
```

Antes de la primera jugada esta consulta no devuelve filas: **no es un error**. Repítela después de que jueguen dos personas.

**Pregunta:** ¿qué diferencia hay entre `JOIN` y `LEFT JOIN` si un estudiante aún tiene cero jugadas?

## Misión 4 (25 min): Seguridad y reglas

**A. Autenticación:** con `signInAnonymously()` el visitante obtiene un UUID de Supabase Auth sin registrarse con correo. Activa Anonymous Sign-Ins en el Dashboard.

**B. RLS:** permite insertar únicamente el propio perfil, evita que el navegador agregue puntos directamente y solo muestra datos permitidos.

**C. Función SQL:** `play_door(door_id)` bloquea jugadas repetidas, impide más de tres y calcula los puntos de manera centralizada.

```js
const {data, error} = await supa.rpc('play_door', {p_door_id: 2});
```

**Explicación obligatoria:** ¿por qué sería incorrecto usar `Math.random()` en JavaScript y luego enviar `{points:1000}` a la base de datos?

## Descanso (10 min)

## Misión 5 (60 min): Construye la web

1. Abre los cinco archivos de la carpeta `sitio` en VS Code o editor equivalente.
2. **HTML**: identifica encabezado, formulario del apodo, sección de seis casas y ranking.
3. **CSS**: cambia al menos un color o estilo de tarjetas sin romper la accesibilidad.
4. **JavaScript**: localiza `onJoin()`, `onDoorClick()`, `refreshAll()` y `subscribeToLiveScores()`.
5. En `config.js` pega la Project URL y **publishable key** de tu proyecto (nunca `service_role`).
6. Ejecuta `python3 -m http.server 5500 --directory sitio` desde la raíz y abre `http://localhost:5500`.
7. Registra un apodo y prueba 1–3 casas. Regresa al Table Editor y verifica las filas en `plays`.

### Reto mínimo por equipo (elige uno)

- **Opción A — SQL:** agrega una séptima casa desde SQL Editor y verifica que aparece automáticamente al recargar el juego.
- **Opción B — UI:** personaliza paleta de colores, nombre del juego y textos de las tarjetas.
- **Opción C — Datos:** crea y explica una consulta que identifique la casa más visitada.
- **Opción D — Lógica:** explica y ajusta en SQL la probabilidad de obtener `dulce` (por ejemplo del 70 % al 60 %) manteniendo la seguridad.

## Misión 6 (20 min): Prueba el ranking

1. Abre otro navegador o pestaña incógnita.
2. Registra un segundo apodo.
3. Juega una vez y verifica que el ranking se refresca en el primer navegador sin recargar.
4. Explica: ¿qué significan `JOIN`, `SUM` y `GROUP BY` en la vista `leaderboard`?
5. Intenta jugar una cuarta vez. ¿Qué capa impide el cambio: HTML, JavaScript o PostgreSQL? (Respuesta: la base de datos asegura la regla; el frontend solo ayuda a guiar al usuario.)

## Misión 7 (25 min): Publica

1. Entra en **https://dash.cloudflare.com/** y abre **Workers & Pages**.
2. Crea una aplicación con **Direct Upload / Drag and drop**.
3. Arrastra la carpeta `sitio` (o su ZIP, con `index.html` en la raíz del ZIP).
4. Obtén una URL `*.pages.dev`, comprueba que abre en tu teléfono y crea un participante.
5. Comparte el enlace con el docente para la demostración.

**Atención:** `db/` y los archivos `.md` no son necesarios dentro del sitio desplegado. Solo los archivos de `sitio`.

## Evidencia final

- Diagrama de las tres tablas relacionadas.
- Evidencia de tres consultas SQL diferentes, una con `JOIN`.
- Enlace público Pages.
- Captura de dos participantes y ranking.
- Explicación de una personalización propia.

## Preguntas para la exposición (2 minutos por equipo)

1. ¿Cuál es la diferencia entre Supabase y PostgreSQL?
2. ¿Qué utilidad tienen la clave primaria y las claves foráneas?
3. ¿Por qué el ranking usa JOIN y GROUP BY?
4. ¿Por qué la clave publicable puede estar en frontend, pero no la secret/service_role?
5. ¿Qué sucede si un participante intenta abrir la misma casa dos veces?

**Criterio:** explicar decisiones y mostrar que funcionan vale más que presentar solo una pantalla bonita.
