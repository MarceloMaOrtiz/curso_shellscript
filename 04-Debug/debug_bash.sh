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
#   v1.2 20/06/2024, Mateus:
#       - Adicionados flags para boas práticas
#   v1.3 20/06/2024, Mateus:
#       - Adicionado while com shift e teste de variável
# ------------------------------------------------------- #
# Testado em:
#   bash 5.2.15
# ------------------------------------------------------- #

# -----------------------  Variáveis  ------------------- #

# Para debugar com -x, mostrando o compartamento do código
# de forma mais detalhada, possibilitando acompanhar mudanças
# de variáveis
# bash -x ./chaves_flags.sh

# Para debugar com -x -v, mostrando além do descrito acima,
# o código em si do script
# bash -x -v ./chaves_flags.sh

USUARIOS="$(cat /etc/passwd | cut -d : -f 1)"
MENSAGEM_USO="
    $(basename $0) - [OPÇÕES]

        -h - Menu de ajuda
        -v - Versão
        -s - Ordenar a saída
        -m - Deixar em maiusculo
"
VERSAO="v.1.3"
CHAVE_ORDENA=0
CHAVE_MAIUSCULO=0

# -----------------------  Execução  -------------------- #

while test -n "$1"; do
    case "$1" in
        -h) echo "$MENSAGEM_USO" && exit 0;;
        -v) echo "$VERSAO" && exit 0;;
        -s) CHAVE_ORDENA=1;;
        -m) CHAVE_MAIUSCULO=1;;
        *) echo "Opção inválida, valide o -h" && exit 1;;
    esac
    shift
done

[ $CHAVE_ORDENA -eq 1 ] && USUARIOS=$(echo "$USUARIOS" | sort)
[ $CHAVE_MAIUSCULO -eq 1 ] && USUARIOS=$(echo "${USUARIOS^^}")

echo "$USUARIOS"

# ------------------------------------------------------- #