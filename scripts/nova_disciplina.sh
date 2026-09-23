#!/usr/bin/env bash
# Cria uma nova disciplina na base de estudos.
# Uso: ./scripts/nova_disciplina.sh "NomeDaDisciplina"
#      ./scripts/nova_disciplina.sh "2026-02/NomeDaDisciplina"
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
NOME="${1:?Uso: nova_disciplina.sh \"NomeDaDisciplina\"}"

# --- converte o nome em um caminho PascalCase, preservando "/" ---
# "banco de dados"  -> "BancoDeDados"
# "2026-02/poo"     -> "2026-02/POO"  (prefixo ano-semestre intocado)
pascal() {
  echo "$1" | sed -E 's/[^a-zA-Z0-9]+/ /g' | awk '{
    for (i = 1; i <= NF; i++) { w = $i; printf "%s%s", toupper(substr(w,1,1)), substr(w,2) }
    print ""
  }'
}
IFS='/' read -ra PARTES <<< "$NOME"
SLUGS=()
for p in "${PARTES[@]}"; do
  if [[ "$p" =~ ^[0-9]{4}-[0-9]{2}$ ]]; then
    s="$p" # mantém padrão AAAA-SS
  else
    s="$(pascal "$p")"
  fi
  [ -n "$s" ] && SLUGS+=("$s")
done
PASTA=""
for s in "${SLUGS[@]}"; do PASTA="$PASTA$s/"; done
PASTA="${PASTA%/}"
[ -n "$PASTA" ] || PASTA="NovaDisciplina"

DESTINO="$ROOT/$PASTA"
TITULO="${SLUGS[-1]}" # nome da disciplina (última parte) para capa do README

if [[ -d "$DESTINO" ]]; then
  echo "Erro: a disciplina '$DESTINO' já existe." >&2
  exit 1
fi

# --- esqueleto da disciplina ---
mkdir -p "$DESTINO"/Unidades \
          "$DESTINO"/Exercicios \
          "$DESTINO"/Provas/anteriores \
          "$DESTINO"/Provas/simulados \
          "$DESTINO"/Projetos \
          "$DESTINO"/Recursos/livros \
          "$DESTINO"/Recursos/links \
          "$DESTINO"/Recursos/videos

cat > "$DESTINO/README.md" <<EOF
# $TITULO

<!-- Ementa, professor, semestre, links do Classroom etc. -->

## Unidades sugeridas
<!-- Liste aqui as unidades que pretende estudar:
\`\`\`bash
./scripts/nova_unidade.sh "$PASTA" "01 - Nome do tópico"
\`\`\`
-->

## Estrutura desta pasta
- **Unidades/** — uma subpasta por aula/tópico (\`scripts/nova_unidade.sh\`).
- **Exercicios/** — exercícios avulsos fora de unidades.
- **Provas/** — \`anteriores/\` e \`simulados/\`.
- **Projetos/** — trabalhos e projetos da disciplina.
- **Recursos/** — \`livros/\`, \`links/\` (lista .md) e \`videos/\` (lista .md).
EOF

# .gitkeep em todas as subpastas (a raiz da disciplina também recebe)
find "$DESTINO" -type d -exec touch {}/.gitkeep \;

echo "✔ Disciplina criada em: $DESTINO"
echo "  Próximo passo: ./scripts/nova_unidade.sh \"$PASTA\" \"01 - Primeira aula\""