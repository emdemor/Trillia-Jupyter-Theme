.PHONY: help install build prepare pip-install dev update clean

help:
	@echo "Targets:"
	@echo "  install      - jlpm install"
	@echo "  build        - jlpm run build"
	@echo "  prepare      - copy labextension files"
	@echo "  pip-install  - pip install -e ."
	@echo "  update       - build + prepare + pip-install"
	@echo "  dev          - install + update"
	@echo "  clean        - remove generated artifacts"

install:
	jlpm install

build:
	jlpm run build

prepare:
	./scripts/prepare_labextension.sh

pip-install:
	python -m pip install -e .

update: build prepare pip-install

dev: install update

clean:
	rm -rf lib style jupyterlab_trillia_theme/labextension static node_modules .yarn .pnp.cjs .pnp.loader.mjs
