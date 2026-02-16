.PHONY: help install build prepare sync pip-install dev update clean docker-build start

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
	@echo "  docker-build - build JupyterLab 4.5.4 image with Trillia theme"
	@echo "  start        - run container with examples mounted"

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

docker-build:
	docker build --no-cache -f docker/Dockerfile -t trillia-jlab:4.5.4 .

start: update docker-build
	docker run --rm -p 8888:8888 -v $(PWD)/examples:/workspace/examples trillia-jlab:4.5.4
