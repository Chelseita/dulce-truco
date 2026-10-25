# Rúbrica de evaluación — 20 puntos

**Modalidad:** equipos de 3–4 integrantes, evidencia funcional, demostración breve y explicación oral.

| Criterio | Puntaje máximo | Logro completo | Logro parcial | Logro insuficiente |
|---|---:|---|---|---|
| **1. Modelo PostgreSQL** | 4 | 3 tablas relacionadas, PK/FK/UNIQUE/CHECK comprendidas y funcionales | Tablas funcionan, pero explica relaciones con errores menores | Sin relaciones o modelo incompleto |
| **2. Consultas SQL** | 4 | 3 consultas comprobadas, incluida 1 con JOIN, y explica GROUP BY/SUM | Presenta consultas, pero no justifica completamente resultados | No demuestra SQL ejecutable |
| **3. Seguridad y reglas de negocio** | 4 | Auth anónima, RLS activa, tres turnos y puntos calculados por RPC | Seguridad o reglas incompletas pero juego usable | Puntos manipulables o lógica crítica no funciona |
| **4. Interfaz y funcionamiento** | 4 | UI usable en PC/móvil, login, casas, resultados, ranking y una mejora propia | Opera parcialmente, errores visuales o sin mejora propia | No se puede jugar |
| **5. Publicación y exposición** | 4 | URL funcional en Pages, dos participantes, ranking y explicación clara | Enlace o demostración parcial | Sin enlace ni demostración |
| **TOTAL** | **20** |  |  |  |

### Escala sugerida por criterio (sobre 4)

- **4 puntos:** completo, correcto y el equipo puede explicar por qué funciona.
- **3 puntos:** correcto en lo esencial con una falla menor o explicación incompleta.
- **2 puntos:** funcionamiento parcial y conceptos básicos identificados.
- **1 punto:** evidencia mínima, insuficiente para validar el criterio.
- **0 puntos:** sin evidencia o no funciona.

### Entrega

1. Enlace `https://...pages.dev`.
2. Captura de las tablas y la vista de Supabase (no incluir secretos).
3. Captura de tres consultas SQL, una con JOIN.
4. Captura del ranking con dos usuarios.
5. Descripción en 4–6 líneas de la mejora realizada por el equipo.

### Preguntas de sustentación (el docente elige dos)

1. ¿Qué diferencia hay entre PRIMARY KEY y FOREIGN KEY?
2. ¿Por qué `plays` necesita dos referencias?
3. ¿Cómo se obtiene el ranking usando JOIN, GROUP BY y SUM?
4. ¿Qué controla RLS que no controla un botón deshabilitado?
5. ¿Por qué la función de PostgreSQL y no JavaScript asigna los puntos?
6. ¿Qué se aloja en Pages y qué queda en Supabase?
