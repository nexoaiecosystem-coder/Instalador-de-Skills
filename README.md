# Instalador de Skills

Repo personal para instalar y mantener [Skills de Claude Code](https://code.claude.com/docs/en/skills). Sirve como referencia: qué skills están instaladas, qué hacen, y cómo pedir lo mismo en un proyecto nuevo.

## Skills instaladas

| Skill | Qué hace | Fuente |
|---|---|---|
| [`graphify`](.claude/skills/graphify/SKILL.md) | Convierte cualquier proyecto (código, docs, PDFs, imágenes) en un grafo de conocimiento consultable con `/graphify`. Útil para entender codebases grandes sin leer archivo por archivo. | [Graphify-Labs/graphify](https://github.com/Graphify-Labs/graphify) |
| [`agent-browser`](.claude/skills/agent-browser/SKILL.md) | CLI de automatización de navegador: abrir páginas, llenar formularios, clicks, screenshots, scraping, testing de apps web (incluye Electron y Slack). | [vercel-labs/agent-browser](https://github.com/vercel-labs/agent-browser) |

Ambas quedan activas automáticamente cuando Claude Code trabaja dentro de este repo.

## Auto-instalación

`.claude/hooks/session-start.sh` corre al inicio de cada sesión y reinstala los CLIs (`graphify`, `agent-browser`) si faltan — porque cada sesión de Claude Code web arranca en un contenedor nuevo y vacío. Si ya están instalados, no hace nada (rápido, silencioso).

## Cómo usar esto en un proyecto nuevo

Estas skills **solo funcionan dentro de este repo** — no se aplican solas a otros proyectos. Cuando arranques uno nuevo, decile a Claude algo como:

> "Instalame en este repo las mismas skills que tengo en mi repo Instalador-de-Skills (graphify y agent-browser), con el hook de auto-instalación."

Con eso alcanza para que repita el mismo setup ahí.

## Agregar una skill nueva

Pasále a Claude la URL del repo de GitHub de la skill que quieras (o el nombre si es de un catálogo conocido) y que la instale acá. Después actualizá la tabla de arriba.
