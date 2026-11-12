# OMP policy

Global Oh My Pi policy, independent of an individual project.

## Owned configuration

- `agent/config.yml`: model roles, task policy, memory policy, UI defaults, and disabled bundled skills.
- `agent/RULES.md`: global engineering decision gates.
- `agent/agents/`: global custom agent profiles.
- `agent/models.yml`: provider discovery configuration.
- `skills/`: custom reusable agent skills.

The repository does not contain session history, databases, caches, blobs, themes, plugins, or project-local instructions.

## Local provider configuration

`agent/mcp.json` contains deployment-specific provider endpoints and enabled-server names. It is intentionally ignored. Copy `agent/mcp.json.example` to `agent/mcp.json`, fill it locally, and then run the Stow commands below.

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
