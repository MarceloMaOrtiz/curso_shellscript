#!/usr/bin/env bash

# extrai_titulos.sh - Extrai titulos de uma paǵina web
# Autor:        Mateus Muller
#
# ------------------------------------------------------- #
# Script responsável por extrair determinado padrão de um
# blog, Lxer, colocar em um arquivo e ler mostrando com
# cores na tela
#
# ------------------------------------------------------- #
# Histórico:
#   v1.0 01/07/2024, Mateus:
#       - Expressão regular com fator em comum criada
#   v1.1 01/07/2024, Mateus:
#       - Criado primeiro código com cores

# ------------------------------------------------------- #
# Testado em:
#   bash 5.2.15
# ------------------------------------------------------- #

# ------------------------  Testes  --------------------- #

# Lynx instalado
[ ! -x "$(which lynx)" ] && sudo apt install lynx -y 

# ------------------------------------------------------- #
# -----------------------  Variáveis  ------------------- #

PATH_SH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
ARQUIVO_TITULOS="$PATH_SH/Files/titulos.txt"

VERDE="\033[32;1m"
VERMELHO="\033[31;1m"

# ------------------------------------------------------- #
# -----------------------  Execução  -------------------- #

lynx -source http://lxer.com/ | \
    grep blurb | \
    sed 's/<div.*line">//;s/<\/span.*meta">//;s/$/\n/' \
    > $ARQUIVO_TITULOS

# A cada iteração uma linha do arquivo é colocada na variável
# item
while read -r titulo_lxer
do
    [ -n "$titulo_lxer" ] && \
        echo -e "${VERMELHO}Título: ${VERDE}$titulo_lxer"
done < "$ARQUIVO_TITULOS"

# ------------------------------------------------------- #