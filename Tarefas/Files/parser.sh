#!/usr/bin/env bash

# -----------------------  Variáveis  ------------------- #

ARQUIVO_CONFIGURACAO="$1"

# ------------------------  Testes  --------------------- #

[ ! -e "$ARQUIVO_CONFIGURACAO" ] && \
echo "ERRO: Arquivo não existe" && exit 1
[ ! -r "$ARQUIVO_CONFIGURACAO" ] && \
echo "ERRO: Não temos acesso de leitura" && exit 1

# -----------------------  Execução  -------------------- #

while read -r linha
do
    [ "$(echo $linha | cut -c1)" = "#" ] && continue
    [ ! "$linha" ] && continue
    chave="$(echo $linha | cut -d = -f 1)"
    valor="$(echo $linha | cut -d = -f 2)"

    ### As variáveis criadas dessa forma só existem dentro
    ### desse PID, portanto um outro .sh que executa esse
    ### script não terá acesso a essas variáveis. Para
    ### solucionar esse problema podemos utilizar o EVAL
    ### ao achamar esse .sh
    echo "CONF_$chave=$valor"
done < "$ARQUIVO_CONFIGURACAO"

# ------------------------------------------------------- #