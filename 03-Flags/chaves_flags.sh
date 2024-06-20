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
# ------------------------------------------------------- #
# Testado em:
#   bash 5.2.15
# ------------------------------------------------------- #

# -----------------------  Variáveis  ------------------- #

USUARIOS="$(cat /etc/passwd | cut -d : -f 1)"
MENSAGEM_USO="
    $0 - [OPÇÕES]

        -h - Menu de ajuda
        -v - Versão
        -s - Ordenar a saída
        -m - Deixar em maiusculo
"
VERSAO="v.1.0"

# -----------------------  Execução  -------------------- #

if [ "$1" = "-h" ]; then
    echo "$MENSAGEM_USO" && exit 0
fi
if [ "$1" = "-v" ]; then
    echo "$VERSAO" && exit 0
fi
if [ "$1" = "-s" ]; then
    echo "$USUARIOS" | sort && exit 0
fi

echo "$USUARIOS"

# ------------------------------------------------------- #