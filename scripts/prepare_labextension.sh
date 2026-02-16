#!/usr/bin/env bash
set -euo pipefail

mkdir -p jupyterlab_trillia_theme/labextension
rm -rf jupyterlab_trillia_theme/labextension/*

# Use the build output produced by `jupyter labextension build .`
cp static/package.json jupyterlab_trillia_theme/labextension/
cp -r static/static jupyterlab_trillia_theme/labextension/
cp -r static/themes jupyterlab_trillia_theme/labextension/
