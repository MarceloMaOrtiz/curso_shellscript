#!/usr/bin/env bash

# tarefa_3.sh - Imprime no console uma escada invertida de *
# Autor:        Mateus Muller

# ------------------------------------------------------- #
# É impresso no console uma escada de * invertida, onde os
# degrais são definidos pela diferença entre as variáveis
# COMECA e ATE. E o tamanho do degrau vai diminuindo um a
# um, acompanhando a diferença entre o atual valor de i e
# ATE
# ------------------------------------------------------- #
# Histórico
#   v1.0 19/06/2024, Autor da Mudança: Mateus
#       - Primeira versão do código
#   v1.1 19/06/2024, Autor da Mudança: Marcelo
#       - Foram aplicadas técnicas de boas práticas
# ------------------------------------------------------- #
# Testado em:
#   bash 5.2.15
# ------------------------------------------------------- #

# -----------------------  Variáveis  ------------------- #

COMECA=0
ATE=100;

# ------------------------  Testes  --------------------- #

[ $COMECA -ge $ATE ] && exit 1

# -----------------------  Execução  -------------------- #

for i in $(seq $COMECA $ATE); do
    for j in $(seq $i $ATE); do
        printf "*"
    done
    printf "\n"
done