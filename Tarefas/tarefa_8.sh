#!/usr/bin/env bash

# tarefa_8.sh - Extrai os itens do dota de uma página
# Autor: Marcelo
#
# ------------------------------------------------------- #
# Script responsável por extrair determinado padrão html
# de um arquivo txt
#
# ------------------------------------------------------- #
# Histórico:
#   v1.0 01/07/2024, Marcelo:
#       - Leitura do arquivo, expressão regular e print
#        finalizado
#
# ------------------------------------------------------- #
# Testado em:
#   bash 5.2.15
# ------------------------------------------------------- #

# -----------------------  Variáveis  ------------------- #

PATH_SH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
ARQUIVO_ITENS_READ="$PATH_SH/Files/itens_dota_full_html.txt"
ARQUIVO_ITENS_WRITE="$PATH_SH/Files/itens_dota.txt"

VERDE="\033[32;1m"
VERMELHO="\033[31;1m"

# ------------------------------------------------------- #
# -----------------------  Execução  -------------------- #

# Script feito na linha de comando
### cat Tarefas/Files/itens_dota.txt | \
### grep --color Mostrar\(\&quot\;\<br\>\<strong\> | \
### sed 's/<\/strong><br><br>&quot;)\"/\n/g' | \
### grep --color onmouseover\=\"Mostrar\(\&quot\;\<br\>\<strong\> | \
### sed 's/.*onmouseover="Mostrar(&quot;<br><strong>//'

cat $ARQUIVO_ITENS_READ | \
    grep Mostrar\(\&quot\;\<br\>\<strong\> | \
    sed 's/<\/strong><br><br>&quot;)\"/\n/g' | \
    grep onmouseover\=\"Mostrar\(\&quot\;\<br\>\<strong\> | \
    sed 's/.*onmouseover="Mostrar(&quot;<br><strong>//' > $ARQUIVO_ITENS_WRITE

while read -r item
do
    [ -n "$item" ] && \
        echo -e "${VERMELHO}Item: ${VERDE}$item"
done < "$ARQUIVO_ITENS_WRITE"

# ------------------------------------------------------- #