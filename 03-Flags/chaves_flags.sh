#!/usr/bin/env bash

# chaves_flags.sh - Filtrar os usuários do /etc/passwd
# Autor:        Mateus Muller
# Manutenção:   Seu nome ou outro
#
# ------------------------------------------------------- #
# Filtrar e manipular os usuários do /etc/passwd, havendo
# a possibilidade de colocar em maiúsculo e ordem alfabética
#
# Exemplos:
#   $ ./chaves_flags.sh -s -m
#   Neste exemplo o -s colocará em ordem alfabética, e o -m
#   em maiúsculo
# ------------------------------------------------------- #
# Histórico:
#   v1.0 20/06/2024, Mateus:
#       - Adicionado -s, -h & -v
#   v1.1 20/06/2024, Mateus:
#       - Adicionado -m
#       - Refatorado os if's para o case
#   v1.2 20/06/2024, MATEUS:
#       - Adicionados flags para boas práticas
# ------------------------------------------------------- #
# Testado em:
#   bash 5.2.15
# ------------------------------------------------------- #

# -----------------------  Variáveis  ------------------- #

USUARIOS="$(cat /etc/passwd | cut -d : -f 1)"
MENSAGEM_USO="
    $(basename $0) - [OPÇÕES]

        -h - Menu de ajuda
        -v - Versão
        -s - Ordenar a saída
        -m - Deixar em maiusculo
"
VERSAO="v.1.0"
CHAVE_ORDENA=0
CHAVE_MAIUSCULO=0

# -----------------------  Execução  -------------------- #

# if [ "$1" = "-h" ]; then
#     echo "$MENSAGEM_USO" && exit 0
# fi
# if [ "$1" = "-v" ]; then
#     echo "$VERSAO" && exit 0
# fi
# if [ "$1" = "-s" ]; then
#     echo "$USUARIOS" | sort && exit 0
# fi
# if [ "$1" = "-m" ]; then
#     echo "$USUARIOS^^" && exit 0
# fi


# case "$1" in
#     -h) echo "$MENSAGEM_USO" && exit 0;;
#     -v) echo "$VERSAO" && exit 0;;
#     -s) echo "$USUARIOS" | sort && exit 0;;
#     -m) echo "${USUARIOS^^}" && exit 0;;
#     *) echo "$USUARIOS";;
# esac

case "$1" in
    -h) echo "$MENSAGEM_USO" && exit 0;;
    -v) echo "$VERSAO" && exit 0;;
    -s) CHAVE_ORDENA=1;;
    -m) CHAVE_MAIUSCULO=1;;
    *) echo "$USUARIOS";;
esac

[ $CHAVE_ORDENA ] && echo "$USUARIOS" | sort
[ $CHAVE_MAIUSCULO ] && echo "${USUARIOS^^}"

# ------------------------------------------------------- #