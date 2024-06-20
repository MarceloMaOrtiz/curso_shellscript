#!/usr/bin/env bash

# tarefa_4.sh - Navega na pokedex
# Autor:        Marcelo Ortiz
#
# ------------------------------------------------------- #
# Possibilita acessar filtrar a pokedex, acessando
# o número, nome, tipo e status do pokemon
#
# Exemplos:
#   $ ./tarefa_4.sh -h
#   Mostra todas as opções disponíveis no programa
# ------------------------------------------------------- #
# Histórico
#
#   v1.0 DD/MM/AAAA, Autor da Mudança: Marcelo
#       - Adicionado -h, -v, -f <NOME>, -n, -t, -s
# ------------------------------------------------------- #
# Testado em:
#   bash 5.2.15
# ------------------------------------------------------- #
# 
# -----------------------  Variáveis  ------------------- #

PATH_SH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
PATH_POKEDEX="$PATH_SH/Files/pokedex.txt"

POKEDEX="$(cat $PATH_POKEDEX | sed 's/,/;/g')" 
POKEDEX_HEAD="$(sed 1q <<< "$POKEDEX")"
POKEDEX_BODY="$(tail -n +2 <<< "$POKEDEX")"
MENSAGEM_USO="
    $(basename $0) - [OPÇÕES]

        -h - Menu de ajuda
        -v - Versão
        -f <WORD> - Filtrar por <WORD>
        -n - Ordenar por nome
        -t - Ordenar por tipo
        -s - Ordenar por atributo
"
VERSAO="v.1.0"
CHAVE_FILTRO=0
CHAVE_NOMES=0
CHAVE_TYPES=0
CHAVE_STATUS=0
FILTER=""

# -----------------------  Execução  -------------------- #

while test -n "$1"; do
    case "$1" in
        -h) echo "$MENSAGEM_USO" && exit 0;;
        -v) echo "$VERSAO" && exit 0;;
        -f) CHAVE_FILTRO=1 && \
            shift && \
            FILTER="$1";;
        -n) CHAVE_NOMES=1;;
        -t) CHAVE_TYPES=1;;
        -s) CHAVE_STATUS=1;;
        *) echo "Opção inválida, valide o -h" && exit 1;;
    esac
    shift
done

[ $CHAVE_FILTRO -eq 1 ] && \
    POKEDEX_BODY="$(grep -i "$FILTER" <<< $POKEDEX_BODY)"
[ $CHAVE_NOMES -eq 1 ] && \
    POKEDEX_BODY="$(sort -t ";" -k2 <<< $POKEDEX_BODY)"
[ $CHAVE_TYPES -eq 1 ] && \
    POKEDEX_BODY="$(sort -t ";" -k3 -k4 <<< $POKEDEX_BODY)"
[ $CHAVE_STATUS -eq 1 ] && \
    POKEDEX_BODY="$(sort -n -t ";" -k5 -k6 -k7 -k8 -k9 -k10 <<< $POKEDEX_BODY)"

echo "$(sed 's/;/ -- /g' <<< "$POKEDEX_HEAD")"
echo "$(sed 's/;/ -- /g' <<< "$POKEDEX_BODY")"

# ------------------------------------------------------- #