FROM python:3.11-slim

ENV PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_NO_CACHE_DIR=1 \
    PYTHONUNBUFFERED=1

WORKDIR /workspace

RUN python -m pip install --upgrade pip \
    && python -m pip install jupyterlab==4.5.4

COPY . /workspace

RUN python -m pip install . --no-deps \
    && jupyter labextension list

# Set Trillia as the default theme inside the image
RUN mkdir -p /root/.jupyter/lab/user-settings/@jupyterlab/apputils-extension \
    && printf '%s\n' '{' \
      '  "@jupyterlab/apputils-extension:themes": {' \
      '    "theme": "Trillia"' \
      '  }' \
      '}' \
      > /root/.jupyter/lab/user-settings/@jupyterlab/apputils-extension/themes.jupyterlab-settings

EXPOSE 8888

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--no-browser", "--allow-root", "--IdentityProvider.token=", "--IdentityProvider.password=", "--ServerApp.root_dir=/workspace"]
