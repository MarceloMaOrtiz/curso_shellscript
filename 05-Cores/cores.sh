#!/usr/bin/env bash
 
# -----------------------  Variáveis  ------------------- #

CHAVE_DEBUG=0
NIVEL_DEBUG=0

ROXO_NEGRITO="\033[35;1m"
CIANO_NEGRITO="\033[36;1m"

# ------------------------  Testes  --------------------- #
#
#
# ------------------------  Funções  -------------------- #

Debug () {
    [ $1 -le $NIVEL_DEBUG ] && echo -e "${2}++ Debug $* ++"
}

Soma () {
    local total=0
    for i in $(seq 1 25); do
        Debug 1 "$ROXO_NEGRITO" "- Entrei no for com o valor: $i"
        total=$(($total+$i))
        Debug 2 "$CIANO_NEGRITO" "- Depois da soma: $total"
    done
    echo $total
}

# -----------------------  Execução  -------------------- #

case "$1" in
    -d) [ $2 ] && NIVEL_DEBUG=$2;;
    *) Soma
esac

Soma

# ------------------------------------------------------- #