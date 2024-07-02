#!/usr/bin/env bash

# sistema_usuarios.sh - Sistema para gerenciamento de
#   usuários
# Autor: Marcelo Ortiz
#
# ------------------------------------------------------- #
# Este programa faz todas as funções de gerenciamento de
# usuários, como: inserir, deletar e alterar.
#
# Exemplos:
#       $ source sistema_usuarios.sh
#       $ ListaUsuarios
#       $ InsereUsuario id:nome:email
#       $ ApagaUsuario nome
#
# ------------------------------------------------------- #
# Histórico
#
#   v1.0 02/07/2024, Autor da Mudança: Marcelo
#       - Tratamento de erros com relação ao arquivo do
#       banco de dados
#
# ------------------------------------------------------- #
# Testado em:
#   bash 5.2.15
# ------------------------------------------------------- #

# -----------------------  Variáveis  ------------------- #

PATH_SH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
PATH_BANCO_DADOS="$PATH_SH/BancoDados/banco_dados.txt"

SEP=":"
# Arquivo temporário que será utilizado para atualizar o
# banco_dados.txt. $$ -> PID do programa
TEMP="TEMP_$$"

VERDE="\033[32;1m"
VERMELHO="\033[31;1m"
CINZA="\033[0m"

# ------------------------------------------------------- #
# ------------------------  Testes  -------------------- #

[ ! -e "$PATH_BANCO_DADOS" ] && \
    echo "ERRO: Arquivo não existe" && exit 1
[ ! -r "$PATH_BANCO_DADOS" ] && \
    echo "ERRO: Arquivo sem permissão de leitura" && exit 1
[ ! -w "$PATH_BANCO_DADOS" ] && \
    echo "ERRO: Arquivo sem permissão de escrita" && exit 1

# ------------------------------------------------------- #
# ------------------------  Funções  -------------------- #

MostraUsuarioNaTela () {
    local id="$(echo $1 | cut -d $SEP -f 1)"
    local nome="$(echo $1 | cut -d $SEP -f 2)"
    local email="$(echo $1 | cut -d $SEP -f 3)"

    echo -e "${VERDE}ID: ${VERMELHO}$id${CINZA}"
    echo "Nome: $nome"
    echo "E-mail: $email"
}

ListaUsuarios () {
    while read -r linha
    do
        [ "$(echo $linha | cut -c1)" = "#" ] && continue
        [ ! "$linha" ] && continue

        MostraUsuarioNaTela "$linha"

    done < "$PATH_BANCO_DADOS"
}

ValidaExistenciaUsuario () {
    grep -i -q "$1$SEP" "$PATH_BANCO_DADOS"
}

InsereUsuario () {
    local nome="$(echo $1 | cut -d $SEP -f 2)"

    if ValidaExistenciaUsuario "$nome"; then
        echo "ERRO: Usuário já existente!"
    else
        # > Substitui o arquivo inteiro
        # >> Concatena no final do arquivo
        echo "$*" >> "$PATH_BANCO_DADOS"
        OrdenaBanco
        echo "Usuário cadastrado com sucesso!"
    fi
}

ApagaUsuario () {
    ValidaExistenciaUsuario "$1" || return
    
    grep -i -v "$1$SEP" "$PATH_BANCO_DADOS" > "$TEMP"
    mv "$TEMP" "$PATH_BANCO_DADOS"

    echo "Usuário removido com sucesso!"

    OrdenaBanco
}

OrdenaBanco () {
    sort "$PATH_BANCO_DADOS" > "$TEMP"
    mv "$TEMP" "$PATH_BANCO_DADOS"
}

# ------------------------------------------------------- #
# -----------------------  Execução  -------------------- #

# ListaUsuarios

# ------------------------------------------------------- #
# ------------------------------------------------------- #