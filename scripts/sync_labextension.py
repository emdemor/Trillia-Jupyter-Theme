#!/usr/bin/env python3
import shutil
from pathlib import Path

try:
    from jupyter_core.paths import jupyter_data_dir
except Exception as exc:  # pragma: no cover
    raise SystemExit(f"Failed to import jupyter_core: {exc}")

root = Path(__file__).resolve().parents[1]
labext_src = root / "jupyterlab_trillia_theme" / "labextension"

if not labext_src.exists():
    raise SystemExit("labextension not found. Run ./scripts/prepare_labextension.sh first.")

data_dir = Path(jupyter_data_dir())
labext_dst = data_dir / "labextensions" / "jupyterlab-trillia-theme"

labext_dst.parent.mkdir(parents=True, exist_ok=True)
if labext_dst.exists():
    shutil.rmtree(labext_dst)

shutil.copytree(labext_src, labext_dst)

print(f"Synced labextension to {labext_dst}")
