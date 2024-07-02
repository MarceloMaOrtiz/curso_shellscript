#!/usr/bin/env bash
 
# -----------------------  Variáveis  ------------------- #

PATH_SH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
ARQUIVO_CONFIGURACAO="$PATH_SH/configs.cf"
ARQUIVO_PARSER="parser.sh"
USAR_MAIUSCULA=
USAR_CORES=
MENSAGEM="Mensagem de teste"

VERMELHO="\033[31;1m"

# -----------------------  Execução  -------------------- #

eval $(./$ARQUIVO_PARSER $ARQUIVO_CONFIGURACAO)

[ "$(echo $CONF_USAR_MAIUSCULA)" = 1 ] && \
    USAR_MAIUSCULA=1

[ "$(echo $CONF_USAR_CORES)" = 1 ] && \
    USAR_CORES=1

[ "$USAR_MAIUSCULA" = "1" ] && \
    MENSAGEM="$(echo -e $MENSAGEM | tr [a-z] [A-Z])"

[ "$USAR_CORES" = "1" ] && \
    MENSAGEM="$(echo -e ${VERMELHO}$MENSAGEM)"

echo -e "$MENSAGEM"

# ------------------------------------------------------- #