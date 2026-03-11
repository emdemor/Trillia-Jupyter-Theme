# JupyterLab Trillia Theme

Tema visual para JupyterLab 4+.

## Instalação

Abra o **Anaconda Prompt** (Windows) ou o **Terminal** (Mac/Linux) e execute:

```bash
pip install jupyterlab-trillia-theme
```

Depois, reinicie o JupyterLab. O tema aparece em **Settings → Theme → Trillia**.

### Não encontrou o tema após instalar?

Execute o comando abaixo para confirmar que a extensão foi reconhecida:

```bash
jupyter labextension list
```

Se `jupyterlab-trillia-theme` não aparecer na lista, tente reinstalar:

```bash
pip install jupyterlab-trillia-theme --force-reinstall
```

## Desinstalar

```bash
pip uninstall jupyterlab_trillia_theme
```

---

## Desenvolvimento

<details>
<summary>Instruções para contribuidores</summary>

### Pré-requisitos

- Python 3.9+
- Node.js 18+
- `jlpm` (incluído ao instalar o JupyterLab)

### Setup

```bash
make dev     # instala dependências, faz build e sincroniza
make update  # rebuild após editar CSS ou TypeScript
make clean   # apaga artefatos gerados
```

### Build e publicação

```bash
make build-py   # gera sdist + wheel em dist/
make publish    # publica no PyPI
```

</details>
