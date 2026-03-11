# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**jupyterlab-trillia-theme** is a federated JupyterLab 4+ theme extension distributed via PyPI. End users install it with `pip install` — no Node.js required on their end.

## Commands

```bash
make dev          # Full setup from scratch: jlpm install + build + prepare + sync
make build        # Build TypeScript + styles (jlpm run build)
make update       # Rebuild + copy labextension files + sync to Jupyter data dir
make clean        # Remove all generated artifacts (lib, style, static, labextension, node_modules)
make pip-install  # Force reinstall Python package locally
make docker-build # Build Docker image (JupyterLab 4.5.4 + theme)
make start        # Run Docker container with examples/ mounted
make build-py     # Build Python sdist + wheel
make publish      # Upload to PyPI
make publish-test # Upload to TestPyPI
```

Individual JS build steps:
```bash
jlpm install        # Install Node dependencies
jlpm run build:lib  # Compile TypeScript → lib/
jlpm run build:style # Generate style wrapper + bundle extension assets
jlpm run watch      # Watch TypeScript for changes
```

There are no automated tests. QA is manual: verify theme appears in JupyterLab Settings, editor loads, icons respect brand color, and CodeMirror doesn't break indentation.

## Architecture

### Build Pipeline

1. **TypeScript** (`src/index.ts`) → compiled to `lib/` via `tsc`
2. **Style wrapper** (`scripts/ensure_style.js`) → generates `style/index.css` pointing to `src/style/index.css`
3. **JupyterLab extension build** (`jupyter labextension build .`) → bundles assets into `static/`
4. **Prepare** (`scripts/prepare_labextension.sh`) → copies `static/` into `jupyterlab_trillia_theme/labextension/`
5. **Sync** (`scripts/sync_labextension.py`) → copies to Jupyter data dir for live testing
6. **Python package** → built from `jupyterlab_trillia_theme/` with Hatchling

### CSS Architecture

CSS is split into three files in `src/style/`:

- **`variables.css`** — All design tokens. `--trillia-*` tokens are the source of truth; they must be mapped to `--jp-*` JupyterLab tokens here. **No hardcoded colors outside this file.**
- **`index.css`** — Main stylesheet. Imports the JupyterLab light theme base, registers B3 Sans font faces, and overrides JupyterLab component styles. May use `--trillia-*` only when no `--jp-*` equivalent exists.
- **`icons.css`** — SVG/icon overrides. Use `currentColor` for inheritance; use `fill` and `stroke` overrides only for monochromatic icons.

### Design Token Contract

```
--trillia-blue-0 → light surfaces
--trillia-blue-1 → hover states
--trillia-blue-2 → soft borders
--trillia-blue-3 → highlights
--trillia-blue-4 → main brand color
```

These map to `--jp-brand-color0`, `--jp-brand-color1`, `--jp-accent-color0`, etc.

### Plugin Registration (`src/index.ts`)

The plugin registers one light theme named `"Trillia"` via `IThemeManager`. Key constraints:
- `themePath` must point to `style/index.css`
- `isLight: true` must match the actual theme mode
- When adding a dark variant, register a separate plugin

### CodeMirror 6

CodeMirror uses internal classes (`.cm-editor`, `.cm-content`, `.cm-line`, `.cm-cursorLayer`). Style overrides must not break syntax highlighting or indentation behavior.

### CI/CD

GitHub Actions (`.github/workflows/publish.yml`) triggers on `v*` tags, syncs version from `jupyterlab_trillia_theme/__init__.py` to `pyproject.toml`, builds the extension and wheel, and publishes to PyPI via OIDC Trusted Publisher.

## Conventions

- No hardcoded colors outside `variables.css` (use TODO comments with deadline for temporary exceptions)
- Always maintain minimum AA contrast ratio
- Keep dark mode compatibility in mind for future — design tokens should support both modes
- `install.json` must always be present in the Python package
- End users must never need to run `jupyter lab build`
