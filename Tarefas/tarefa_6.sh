#!/usr/bin/env bash

# tarefa_5.sh - Navega na pokedex com debug imbutido
# Autor:        Marcelo Ortiz
#
# ------------------------------------------------------- #
# Possibilita acessar, filtrar a pokedex, acessando
# o número, nome, tipo e status do pokemon. Além de ter modo
# debug
#
# Exemplos:
#   $ ./tarefa_5.sh -h
#   Mostra todas as opções disponíveis no programa
# ------------------------------------------------------- #
# Histórico
#
#   v1.0 20/06/2024, Autor da Mudança: Marcelo
#       - Adicionado -h, -v, -f <NOME>, -n, -t, -s
#   v1.1 21/06/2024, Autor da Mudança: Marcelo
#       - Adicionado -d, possibilitando debugar em dois
#       níveis
#       - Adicionado função para printar a pokedex
#   v2.2 21/06/2024, Autor da Mudança: Marcelo
#       - Adicionando cores
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
        -d <NIVEL> - Debuga em dois níveis
            1 - Mostra a info antes da alteração
            2 - Mostra a info antes e depois da alteração
"
VERSAO="v.1.0"
CHAVE_FILTRO=0
FILTER=""
CHAVE_NOMES=0
CHAVE_TYPES=0
CHAVE_STATUS=0
CHAVE_DEBUG=0
NIVEL_DEBUG=0

CINZA="\033[37;0m"
AMARELO="\033[33m"
CIANO="\033[36m"

# ------------------------  Funções  -------------------- #

Debug () {
    [ $1 -le $NIVEL_DEBUG ] && echo -e "++ ${2}Debug $* $CINZA\n++"
}

PrintPokedex () {
    echo -e "$(sed 's/;/ -- /g' <<< "$POKEDEX_HEAD")"
    echo -e "$(sed 's/;/ -- /g' <<< "${1}")"
}

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
        -d) CHAVE_DEBUG=1 && \
            shift && \
            case "$1" in
                [1,2]) NIVEL_DEBUG="$1";;
                *) echo "Nivel inválido, valide o -h" && exit 1;;
            esac ;;
        *) echo "Opção inválida, valide o -h" && exit 1;;
    esac
    shift
done

if [[ $CHAVE_FILTRO -eq 1 ]]; then
    Debug 1 "$AMARELO"\
        "- Pokedex antes do filtro:\n"\
        "$(PrintPokedex "$POKEDEX_BODY")"
    POKEDEX_BODY="$(grep -i "$FILTER" <<< $POKEDEX_BODY)"
    Debug 2 "$CIANO"\
        "- Pokedex depois do filtro:\n"\
        "$(PrintPokedex "$POKEDEX_BODY")"
fi
if [[ $CHAVE_NOMES -eq 1 ]]; then
    Debug 1 "$AMARELO"\
        "- Pokedex antes de ordenar por nome:\n"\
        "$(PrintPokedex "$POKEDEX_BODY")"
    POKEDEX_BODY="$(sort -t ";" -k2 <<< $POKEDEX_BODY)"
    Debug 2 "$CIANO"\
        "- Pokedex depois de ordenar por nome:\n"\
        "$(PrintPokedex "$POKEDEX_BODY")"
fi
if [[ $CHAVE_TYPES -eq 1 ]]; then
    Debug 1 "$AMARELO"\
        "- Pokedex antes de ordenar por tipo:\n"\
        "$(PrintPokedex "$POKEDEX_BODY")"
    POKEDEX_BODY="$(sort -t ";" -k3 -k4 <<< $POKEDEX_BODY)"
    Debug 2 "$CIANO"\
        "- Pokedex depois de ordenar por tipo:\n"\
        "$(PrintPokedex "$POKEDEX_BODY")"
fi
if [[ $CHAVE_STATUS -eq 1 ]]; then
    Debug 1 "$AMARELO"\
        "- Pokedex antes de ordenar por atributos:\n"\
        "$(PrintPokedex "$POKEDEX_BODY")"
    POKEDEX_BODY="$(sort -n -t ";" -k5 -k6 -k7 -k8 -k9 -k10 <<< $POKEDEX_BODY)"
    Debug 2 "$CIANO"\
        "- Pokedex depois de ordenar por atributos:\n""$(PrintPokedex "$POKEDEX_BODY")"
fi

PrintPokedex "$POKEDEX_BODY"

# ------------------------------------------------------- #