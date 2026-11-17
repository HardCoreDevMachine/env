# OMP policy

Global Oh My Pi policy, independent of an individual project.

## Owned configuration

- `agent/config.yml`: model roles, task policy, memory policy, UI defaults, and disabled bundled skills.
- `agent/RULES.md`: global engineering decision gates.
- `agent/agents/`: global custom agent profiles.
- `skills/`: custom reusable agent skills.

The repository does not contain session history, databases, caches, blobs, themes, plugins, project-local instructions, or private provider credentials.

## Local OMP configuration

Keep private OMP configuration beside the tracked Stow files:

- `agent/models.yml`: custom provider endpoints, API-key references, and model definitions. OMP loads this file automatically.
- `agent/mcp.json`: deployment-specific MCP server endpoints and enabled-server names.
- `agent/private.yml`: optional local `config.yml` overlay, passed with `omp --config "$HOME/.omp/agent/private.yml"`.

All three files are intentionally ignored. They are symlinked to `~/.omp/agent/` by the Stow command below, but never enter Git. `agent/models.yml.example` is the safe starting template.

## Install

Run from this repository root:

```sh
mkdir -p "$HOME/.agents/skills"
stow --dir "$PWD" --target "$HOME/.omp/agent" agent
stow --dir "$PWD" --target "$HOME/.agents/skills" skills
```

On first migration, back up conflicting regular files in `~/.omp/agent/` before invoking Stow. Runtime-owned files and other extensions remain untouched.

## Related repositories

- `theme-catppuccin-latte`, `theme-catppuccin-frappe`, `theme-nord`: standalone theme assets.
- `omp-beads-session-title`, `omp-snake`, `omp-uml-modeler`: custom OMP plugins.
