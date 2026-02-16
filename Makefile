.PHONY: help install build prepare sync pip-install dev update clean

help:
	@echo "Targets:"
	@echo "  install      - jlpm install"
	@echo "  build        - jlpm run build"
	@echo "  prepare      - copy labextension files"
	@echo "  sync         - copy labextension into Jupyter data dir"
	@echo "  pip-install  - pip install . (force reinstall)"
	@echo "  update       - build + prepare + sync"
	@echo "  dev          - install + update"
	@echo "  clean        - remove generated artifacts"

install:
	jlpm install

build:
	jlpm run build

prepare:
	./scripts/prepare_labextension.sh

sync:
	./scripts/sync_labextension.py

pip-install:
	python -m pip install . --force-reinstall --no-deps

update: build prepare sync

dev: install update

clean:
	rm -rf lib style jupyterlab_trillia_theme/labextension static node_modules .yarn .pnp.cjs .pnp.loader.mjs
