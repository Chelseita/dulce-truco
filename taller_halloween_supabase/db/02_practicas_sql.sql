-- PRÁCTICAS GUIADAS PARA EL TALLER (ejecutar una por una en SQL Editor)
-- NOTA: al inicio no habrá jugadas; las últimas consultas mostrarán
-- resultados después de que los alumnos hayan participado.

-- PRÁCTICA 1 | SELECT: ver todas las casas.
select * from public.doors;

-- PRÁCTICA 2 | WHERE: filtrar casas habilitadas.
select id, title from public.doors where active = true;

-- PRÁCTICA 3 | ORDER BY: ordenar por título.
select title, emoji from public.doors order by title asc;

-- PRÁCTICA 4 | COUNT: contar cuántas casas existen.
select count(*) as cantidad_casas from public.doors;

-- PRÁCTICA 5 | INSERT: crear una séptima casa (opcional, una vez).
-- Ejecuta este bloque solo después de la explicación de INSERT.
-- insert into public.doors (id, title, emoji, description, active)
-- values (7, 'Mansión de Caramelos', '🍬', 'Una puerta repleta de caramelos.', true)
-- on conflict (id) do update set title = excluded.title;

-- PRÁCTICA 6 | JOIN: enlazar cada jugada con participante y casa.
select p.nickname, d.title as casa, g.outcome, g.points
from public.plays as g
join public.players as p on p.id = g.player_id
join public.doors as d on d.id = g.door_id
order by g.created_at desc;

-- PRÁCTICA 7 | GROUP BY: sumar puntos por participante.
select p.nickname, sum(g.points) as puntuacion
from public.players as p
join public.plays as g on g.player_id = p.id
group by p.id, p.nickname
order by puntuacion desc;

-- PRÁCTICA 8 | LEFT JOIN y COALESCE: también participantes con 0 jugadas.
select p.nickname, coalesce(sum(g.points), 0) as puntuacion
from public.players as p
left join public.plays as g on g.player_id = p.id
group by p.id, p.nickname
order by puntuacion desc;

-- PRÁCTICA 9 | HAVING: participantes que acumularon al menos 10 puntos.
select p.nickname, sum(g.points) as puntuacion
from public.players as p
join public.plays as g on g.player_id = p.id
group by p.id, p.nickname
having sum(g.points) >= 10;

-- PRÁCTICA 10 | Consulta a la vista que consume la aplicación.
select nickname, score, turns
from public.leaderboard
order by score desc, turns asc;

-- RETO | ¿Qué casa fue la más visitada?
select d.title, count(g.id) as visitas
from public.doors as d
left join public.plays as g on g.door_id = d.id
group by d.id, d.title
order by visitas desc, d.title;

-- RETO | ¿Hubo más dulces o trucos?
select outcome, count(*) as cantidad, coalesce(sum(points),0) as puntos_totales
from public.plays
group by outcome
order by cantidad desc;
