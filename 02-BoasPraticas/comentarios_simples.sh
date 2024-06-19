# #!/usr/bin/env bash

# Lynx instalado?
[ ! -x "$(which lynx)" ] && printf "${AMARELO}Precisamos instalar o
${VERDE} Lyns${AMARELO}, por favor, digite sua senha:${SEM_COR}\n" && sudo apt install lynx

# Sem parâmetros obrigatórios?
[ -z $1 ] && printf "${VERMELHO}[ERRO] - Informe os parâmetros obrigatórios.
Consule a opção -h.\n" && exit 1