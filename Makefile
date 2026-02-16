.PHONY: help install build prepare sync pip-install dev update clean docker-build start build-py publish publish-test

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
	@echo "  build-py     - python build (sdist + wheel)"
	@echo "  publish      - upload dist/* to PyPI (requires TWINE creds)"
	@echo "  publish-test - upload dist/* to TestPyPI (requires TWINE creds)"

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

build-py:
	python -m pip install --upgrade build
	python -m build

publish: build-py
	python -m pip install --upgrade twine
	python -m twine upload dist/*

publish-test: build-py
	python -m pip install --upgrade twine
	python -m twine upload --repository testpypi dist/*
