# Resumo — 01 - Introdução e evolução

## 1. História do Linux

### Origens do Unix
- O **Unix** foi criado em **1969** por **Ken Thompson e Dennis Ritchie** (Bell Labs, AT&T).
- Primeira versão em assembler; depois reescrito em **linguagem C** (1973), criada por Dennis Ritchie e Brian Kernighan — isso tornou o Unix **portável** para diferentes máquinas.

### Sunto da evolução
- **Anos 1970–1980:** Unix se multiplica em diversas versões (BSD, System V) e universidades/empresas começam a criar suas próprias variantes.
- **GNU (1983):** Richard Stallman inicia o projeto **GNU** ("GNU's Not Unix"), com o objetivo de criar um sistema completo e **livre** (Software Livre — liberdade de usar, estudar, modificar e distribuir).
- **Linux (1991):** **Linus Torvalds**, então estudante na Universidade de Helsinque, cria o **núcleo (kernel) Linux** como hobby.
  - Distribuído como código aberto.
  - O kernel Linux **+ ferramentas GNU** = o sistema operacional GNU/Linux completo.

### Por que "Linux"?
- Mistura de "Linus" com "Unix". O nome foi sugerido por um usuário do grupo de notícias.

### Diferença entre Linux e GNU/Linux
- **Linux** isoladamente = apenas o **kernel** (núcleo do SO).
- **GNU/Linux** = distribuição completa (kernel + utilitários + aplicativos), como Ubuntu, Debian, Fedora, Arch.

### Distribuições (distros)
- Mesmo kernel, empacotado com conjuntos diferentes de software e gerenciadores de pacotes (apt, dnf, pacman).
- Exemplos: Ubuntu (popular para iniciantes), Debian (estável), Fedora, Arch (avançada), Kali (segurança).

## 2. Comandos básicos do terminal

### Característica do terminal
- O Linux é **multi-usuário** e a interface principal é o **shell** (interpretador de comandos), ex.: bash, zsh.
- Sintaxe geral: `comando [opções] [argumentos]`

### `pwd` — "Print Working Directory"
Mostra o **caminho absoluto** do diretório atual (onde você está agora).

```bash
pwd
# /home/usuario
```

### `ls` — "List"
Lista os arquivos e pastas do diretório.

```bash
ls          # lista o diretório atual
ls /etc     # lista o diretório especificado
ls -l       # lista com detalhes (permissões, dono, tamanho, data)
ls -a       # lista incluindo arquivos ocultos (que começam com .)
ls -la      # combina as duas opções (mais usado)
```

- **Arquivos ocultos** começam com `.` (ex.: `.gitignore`, `.bashrc`).

### `cd` — "Change Directory"
Muda de diretório (navega pelo sistema de arquivos).

```bash
cd          # vai para o diretório home do usuário
cd /var/log # vai para um caminho absoluto
cd documentos # desce para a subpasta "documentos" (caminho relativo)
cd ..       # sobe um nível (diretório pai)
cd ../..    # sobe dois níveis
cd ~        # volta para o home (equivalente a só "cd")
cd -        # volta para o último diretório visitado
```

- **Caminho absoluto:** começa em `/` (raiz) — `/home/usuario/arquivo.txt`
- **Caminho relativo:** parte do diretório atual — `documentos/trabalho.md`
- `.` = diretório atual · `..` = diretório pai · `~` = home do usuário

### `mkdir` — "Make Directory"
Cria um novo diretório (pasta).

```bash
mkdir projetos            # cria a pasta "projetos" no diretório atual
mkdir /tmp/teste          # cria em um caminho absoluto
mkdir -p a/b/c            # cria a estrutura inteira, inclusive pais ausentes
mkdir -p aula/{resumos,exercicios}  # cria várias de uma vez (expansão de chaves)
```

- `-p` (parents): cria diretórios **intermediários** automaticamente, sem erro se já existirem.

## 3. Recapitulando (macete)

| Comando | O que faz |
|---------|-----------|
| `pwd`   | Onde estou? (me mostra o caminho) |
| `ls`    | O que tem aqui? (lista conteúdo) |
| `cd`    | Vou para... (muda de diretório) |
| `mkdir` | Crio uma pasta aqui/lá (cria diretório) |

**Fluxo típico:** `pwd` → vejo onde estou · `ls` → vejo o que existe · `cd` → navego · `mkdir` → crio novas pastas.

## 4. Dúvidas comuns (Q&A)

1. **Diferença entre terminal e shell?** Terminal é o programa/interface; shell (bash) é quem interpreta os comandos digitados.
2. **Windows e Linux são iguais?** Não — Linux usa estrutura de diretórios hierárquica a partir da raiz `/`, sem "unidades" (C:, D:).
3. **Preciso decorar?** Com a prática os comandos ficam automáticos; o `man comando` mostra o manual de qualquer comando (`man ls`).