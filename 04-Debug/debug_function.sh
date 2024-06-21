#!/usr/bin/env bash
 
# -----------------------  Variáveis  ------------------- #

CHAVE_DEBUG=0
NIVEL_DEBUG=0

# ------------------------  Testes  --------------------- #
#
#
# ------------------------  Funções  -------------------- #

Debug () {
    # O $1 não é o mesmo $1 que o script recebe ao ser
    # invocado, mas sim o primeiro parâmetro recebido pela
    # função
    [ $1 -le $NIVEL_DEBUG ] && echo -e "++ Debug $* ++"
}

Soma () {
    local total=0
    for i in $(seq 1 25); do
        Debug 1 "- Entrei no for com o valor: $i"
        total=$(($total+$i))
        Debug 2 "- Depois da soma: $total"
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