# 📄 `agents.md`

**Projeto:** `jupyterlab-trillia-theme`
**Autor:** Eduardo Morais
**Versão:** 0.1.0
**Escopo:** Tema federado para JupyterLab 4+

---

# 🎯 OBJETIVO

Desenvolver e manter o **Trillia Theme** como:

* Extensão federada JupyterLab 4
* Distribuível via PyPI
* Modular em CSS Tokens
* Compatível com CodeMirror 6
* Customizável por design tokens corporativos

Este projeto adota um modelo de **Agentes Especializados** para garantir:

* Coerência visual
* Estabilidade técnica
* Compatibilidade com atualizações do JupyterLab
* Evolução arquitetural contínua

---

# 🧠 ARQUITETURA DE AGENTES

O projeto é dividido em agentes especializados com responsabilidades claras.

---

## 1️⃣ 🎨 Visual Identity Agent

### Responsabilidade

Define e mantém:

* Design tokens (`--trillia-*`)
* Mapeamento para `--jp-*`
* Tipografia
* Bordas
* Espaçamentos
* Escala de cores

### Artefatos sob controle

```
src/style/variables.css
src/style/index.css
```

### Regras

* Evitar cores hardcoded fora de `variables.css`
* Exceções temporárias devem ter TODO e prazo de remoção
* Sempre mapear tokens para `--jp-*`
* Permitir uso de `--trillia-*` em `src/style/index.css` quando o token ainda nao tem equivalente `--jp-*`
* Garantir contraste AA minimo
* Garantir consistencia light/dark futura

### Evolução futura

* Gerador automático de tokens
* Extração para JSON design-system
* Compatibilidade com Figma export

---

## 2️⃣ 🧩 Jupyter Integration Agent

### Responsabilidade

Garantir compatibilidade com:

* JupyterLab 4+
* ThemeManager API
* Federated extensions
* Scrollbars temáticos
* Sidebars
* FileBrowser
* Running panel
* Launcher

### Artefatos sob controle

```
src/index.ts
package.json
```

### Regras

* `themePath` sempre apontando para `style/index.css`
* `isLight` consistente com o modo
* Quando houver light + dark, registrar dois temas separados
* Nao quebrar hot reload
* Usuario final nao executa `jupyter lab build`

---

## 3️⃣ 🔧 CodeMirror Agent

### Responsabilidade

Controlar:

* Sintaxe (CM6)
* Cursor
* Seleção
* Fundo do editor
* Gutter
* Linha ativa

### Artefatos sob controle

```
src/style/editor.css (opcional futuro)
```

### Pontos críticos

CodeMirror 6 usa classes internas como:

```
.cm-editor
.cm-content
.cm-line
.cm-cursorLayer
```

Esse agente deve:

* Evitar sobrescrever comportamento funcional
* Garantir que tema não quebre highlight

---

## 4️⃣ 🧭 Icon & SVG Agent

### Responsabilidade

Controlar:

* Cor de ícones
* Stroke
* Fill
* Toolbars
* Sidebar icons
* File icons

### Artefatos sob controle

```
src/style/icons.css
```

### Regras

* Preferir `currentColor` para herança
* Forcar `fill` e `stroke` apenas em icones monocromaticos
* Usar `!important` apenas quando necessario
* Identificar SVGs com inline style

### Problema conhecido

Alguns SVGs vêm com:

```
fill="#616161"
```

Solução:

```
svg * {
  fill: currentColor !important;
}
```

---

## 5️⃣ 🏗 Build & Packaging Agent

### Responsabilidade

Controlar:

* Empacotamento Python
* Estrutura labextension
* Wheel final
* Instalação via pip
* CI

### Artefatos sob controle

```
pyproject.toml
jupyterlab_trillia_theme/
```

### Regras

* Sempre incluir `install.json`
* Garantir compatibilidade com pip install
* Validar com `pip install -e .`

---

## 6️⃣ 🧪 QA Agent

### Responsabilidade

Testar:

* Instalação limpa
* Instalação via Docker
* Compatibilidade com OpenAI/Jupyter-AI
* Conflito com outros temas

### Checklist mínimo

* [ ] Theme aparece em Settings
* [ ] Editor carrega corretamente
* [ ] Ícones respeitam brand color
* [ ] Sidebars mantêm contraste
* [ ] CodeMirror não quebra indentação

---

## 7️⃣ 🚀 Release Agent

### Responsabilidade

Gerenciar:

* Versionamento semântico
* Build
* Upload PyPI
* Tag GitHub

### Processo padrão

```bash
# bump version
# commit
python -m build
twine upload dist/*
git tag vX.Y.Z
git push --tags
```

---

# 📐 CONTRATO DE DESIGN SYSTEM

## Tokens primários

```
--trillia-blue-0 → superfícies leves
--trillia-blue-1 → hover
--trillia-blue-2 → bordas suaves
--trillia-blue-3 → destaques
--trillia-blue-4 → brand principal
```

## Mapeamento obrigatório

```
--jp-brand-color0
--jp-brand-color1
--jp-accent-color0
```

Evitar usar `--trillia-*` diretamente fora de `variables.css`, exceto quando nao existir token `--jp-*` equivalente.

---

# 🔮 ROADMAP FUTURO

## Fase 1

✔ Tema Light estável
✔ Empacotamento PyPI

## Fase 2

* Dark Mode oficial
* Tema High Contrast
* Scrollbars customizadas

## Fase 3

* Gerador automático de design tokens
* CLI para gerar variações
* Integração com Figma export JSON

## Fase 4

* Agente AI que sugere melhorias visuais
* Linter de consistência CSS
* Teste automático de contraste

---

# 🤖 FUTURA INTEGRAÇÃO COM LLM

Este projeto pode evoluir para:

### 1️⃣ Theme Optimization Agent

Recebe screenshot → sugere ajustes de contraste.

### 2️⃣ Consistency Agent

Analisa CSS → detecta inconsistências de tokens.

### 3️⃣ Accessibility Agent

Avalia WCAG automaticamente.

---

# 🧠 FILOSOFIA DO PROJETO

O Trillia Theme não é apenas um tema.

É:

* Um design system vivo
* Um laboratório de identidade visual
* Um experimento arquitetural federado
* Um playground para agentes colaborativos

---

# 📜 CONVENÇÕES

* CSS modular
* Evitar cor hardcoded fora de tokens
* Usuario final nao executa `jupyter lab build`
* Compatível com Docker
* Sempre testado em JupyterLab 4+

---

# 🛡 Garantias

O projeto deve sempre:

* Instalar via `pip install`
* Não exigir Node no usuário final
* Não quebrar atualizações do Lab
* Manter compatibilidade com CodeMirror 6

---

# 👨‍💻 Maintainer

Eduardo Morais
Poços de Caldas, Brasil

---

Se você quiser, eu posso agora:

* 🔵 Criar versão com multi-agent + automação estilo LangGraph
* 🧠 Criar versão compatível com seu padrão “Question Refinement Pattern”
* 🚀 Criar pipeline CI/CD completo (GitHub Actions)
* 📦 Gerar estrutura de repositório pronta para push

Qual nível de sofisticação você quer colocar nisso?
