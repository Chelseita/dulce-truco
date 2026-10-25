# Guion de facilitación — 4 horas

## Antes de empezar (checklist)

- [ ] Tener cuenta en Supabase y otra en Cloudflare.
- [ ] Haber comprobado Internet, SQL Editor y el acceso a `supabase.com` y `dash.cloudflare.com`.
- [ ] Descargar y descomprimir el paquete completo.
- [ ] Proyectar la aplicación base y reservar un navegador incógnito para demostrar competencia real.
- [ ] Crear un proyecto Supabase docente de prueba y ejecutar `db/01_esquema.sql`.
- [ ] Habilitar Anonymous Sign-Ins en Supabase Auth.
- [ ] Guardar los datos de la Project URL y publishable key; **no proyectar ni compartir claves secretas**.
- [ ] Preparar VS Code y Python 3 para servidor local (o `npx serve sitio` si se dispone de Node.js).
- [ ] Recomendar equipos de 3–4 con roles: modelador de datos, desarrollador frontend, probador/documentador y presentador.

## 00:00–00:20 | Apertura — ¿qué vamos a construir?

**Di:** «Hoy no vamos a aprender solamente botones y colores. Haremos un juego en Internet. Cuando alguien abra una puerta, los puntos no se guardarán en su computadora: se calcularán y registrarán en PostgreSQL; y sus compañeros verán el cambio en el ranking casi de inmediato».

**Pregunta:** «Si yo guardara los puntajes solo en JavaScript, ¿qué pasaría al actualizar o abrir desde otro dispositivo?»

Explica el flujo: navegador → Supabase Auth → función PostgreSQL → tablas → vista ranking → navegador/tiempo real.

**Verificación:** cada grupo dice una función de PostgreSQL, otra de Supabase y otra de Pages.

## 00:20–01:05 | Tablas y relaciones

**Di:** «Una tabla es como una hoja bien estructurada de Excel, pero con reglas que impiden datos incorrectos. El apodo vive en `players`, el catálogo de casas vive en `doors` y el histórico de visitas vive en `plays`».

Revisa columnas y tipos: `uuid`, `integer`, `text`, `boolean`, `timestamptz`. Presenta PK, FK, UNIQUE y CHECK. Ejecuten `01_esquema.sql` y localicen el catálogo de seis casas.

**Actividad:** cada equipo redacta qué significan los campos `player_id` y `door_id`. Pregunta por qué una tabla de jugadas depende de dos tablas.

## 01:05–01:40 | Consultas SQL y ranking

**Di:** «Guardar datos no es suficiente. El valor aparece cuando los consultamos: quién jugó, cuántos puntos obtuvo y quién va ganando».

Ejecuta los primeros cuatro ejercicios de `02_practicas_sql.sql`. Explica JOIN con un esquema dibujado. Explica SUM y GROUP BY; vuelve a las consultas cuando haya registros.

**Pregunta:** «¿Por qué el ranking no debe mostrar únicamente a quienes ya jugaron?» → `LEFT JOIN` conserva a los registrados sin jugadas.

**Verificación:** cada alumno propone una consulta de una frase: «Quiero contar casas», «Quiero ordenar jugadores», etc.

## 01:40–02:05 | Auth, RLS y la función segura

**Di:** «Un navegador no es de confianza. Un alumno podría editar JavaScript y enviarse un millón de puntos. Por eso PostgreSQL decide el resultado, verifica que nadie exceda tres visitas y aplica las reglas dentro de una función».

Muestra RLS y `play_door` del SQL: `auth.uid()`, unicidad por casa, límite 3, sorteo 70/30, INSERT seguro. Explica que una cuenta anónima de Supabase tiene identidad autenticada sin correo. Activa Anonymous Sign-Ins.

**Pregunta:** «¿Qué pasa si doy acceso directo a INSERT de `plays`?» → podrían enviar puntos manipulados. **Importante:** al consultar desde SQL Editor como administrador, RLS no se comporta como para un cliente; las políticas se prueban desde la web autenticada.

## 02:05–02:15 | Descanso

## 02:15–03:15 | Sitio web conectado

**Di:** «La interfaz solicita acciones, pero el control de las reglas permanece en la base de datos. Esa es una idea central de sistemas reales».

Divide en tareas paralelas: (a) config y auth; (b) HTML/CSS; (c) lecturas `.from().select()`; (d) `rpc('play_door')`.

Demuestra primero en pantalla compartida y después cada equipo repite. Haz que todos ingresen con apodo y jueguen. Dedica los últimos 15 minutos a la personalización obligatoria.

**Comprobaciones:** datos visibles en Table Editor, no permitir más de 3 casas, puertas jugadas deshabilitadas, no exponer claves secretas.

## 03:15–03:35 | Tiempo real y dos navegadores

**Di:** «El cambio se almacena en PostgreSQL y Realtime avisa a los navegadores conectados para consultar el nuevo ranking. Esto no equivale a actualizar manualmente la página».

Abre un navegador regular y otro incógnito. Registra apodos distintos y juega. Observa el ranking. Si los eventos no llegan, comprueba la publicación `supabase_realtime` y que `plays`/`players` estén habilitadas; recargar permite distinguir un fallo de Realtime de uno de base de datos.

## 03:35–04:00 | Despliegue y exposición

**Di:** «El código visual se servirá desde Cloudflare Pages; los registros siguen viviendo en Supabase. Publicar no equivale a copiar la base de datos dentro de HTML».

Arrastrar `sitio` a Pages, comprobar `index.html` en raíz y visitar la URL `*.pages.dev`. Cada equipo comparte enlace, abre una puerta y explica un concepto SQL. Usa la rúbrica de 20 puntos.

## Si falla algo — plan de contingencia

- **Auth falla:** verificar Anonymous Sign-Ins y keys; continuar con práctica SQL mientras se resuelve.
- **SQL falla:** comprobar proyecto elegido y ejecutar el script completo desde una nueva consulta; no borrar registros sin permiso.
- **Realtime falla:** demostrar la nueva puntuación recargando la página y explicar por separado el concepto de suscripción.
- **Despliegue demora por conectividad:** cada equipo deja `sitio` lista y demuestra el servidor local; el enlace público queda como evidencia pendiente (evalúa según lo realmente demostrado).
- **Tiempo insuficiente:** todos hacen la misma plantilla primero; la personalización adicional es reto, no prerequisito del MVP.

## Cierre en una frase

«Hoy usamos **PostgreSQL para modelar, proteger y calcular datos**, **Supabase para exponerlos de manera controlada** y **Cloudflare Pages para poner nuestro frontend en Internet**».
