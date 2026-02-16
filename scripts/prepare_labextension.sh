#!/usr/bin/env bash
set -euo pipefail

mkdir -p jupyterlab_trillia_theme/labextension
rm -rf jupyterlab_trillia_theme/labextension/*
cp package.json jupyterlab_trillia_theme/labextension/
cp -r style jupyterlab_trillia_theme/labextension/
cp -r lib jupyterlab_trillia_theme/labextension/
