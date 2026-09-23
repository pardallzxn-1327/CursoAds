#!/usr/bin/env bash
# Cria uma nova unidade (aula/tópico) dentro de uma disciplina.
# Uso: ./scripts/nova_unidade.sh "Disciplina" "01 - Nome do tópico"
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DISC="${1:?Uso: nova_unidade.sh \"Disciplina\" \"Unidade\"}"
UNID="${2:?Uso: nova_unidade.sh \"Disciplina\" \"Unidade\"}"

# --- localiza a pasta da disciplina ---
# Aceita caminho ("2026-01/poo") ou nome exato ("POO", sem diferenciar maiúsculas)
if [[ "$DISC" == */* ]]; then
  PASTA="$ROOT/${DISC%/}"
  [[ -d "$PASTA" ]] || { echo "Erro: disciplina '$DISC' não encontrada." >&2; exit 1; }
else
  ENCONTRADA=""
  for d in "$ROOT"/*/; do
    [[ -d "$d" ]] || continue
    nome="$(basename "$d")"
    if [[ "${nome,,}" == "${DISC,,}" ]]; then
      ENCONTRADA="$d"
      break
    fi
  done
  [[ -n "$ENCONTRADA" ]] || {
    echo "Erro: disciplina '$DISC' não encontrada. Crie com ./scripts/nova_disciplina.sh" >&2
    exit 1
  }
  PASTA="${ENCONTRADA%/}"
fi

# --- converte o nome da unidade em slug (NN-nome-curto) ---
SLUG="$(echo "$UNID" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g' | sed -E 's/^-|-$//g')"
[ -n "$SLUG" ] || SLUG="unidade"

DESTINO="$PASTA/Unidades/$SLUG"

if [[ -d "$DESTINO" ]]; then
  echo "Erro: a unidade '$DESTINO' já existe." >&2
  exit 1
fi

mkdir -p "$DESTINO"/exemplos "$DESTINO"/exercicios

cat > "$DESTINO/anotacoes.md" <<EOF
# $UNID

<!-- Anotações da aula: definições, exemplos, dúvidas, referências -->
EOF

cat > "$DESTINO/resumo.md" <<EOF
# Resumo — $UNID

<!-- Síntese final: principais conceitos, fórmulas, fluxos, mapa mental -->
EOF

find "$DESTINO" -type d -exec touch {}/.gitkeep \;

echo "✔ Unidade criada em: $DESTINO"
echo "  Abra anotacoes.md e resumo.md para começar."