#!/usr/bin/env bash

# tarefa_10.sh - Sistema para gerenciamento de pokemons
# capturados
# Autor: Marcelo Ortiz
#
# ------------------------------------------------------- #
# Este programa permite gerenciar os pokemons capturados
# por determinado mestre pokemon
#
# Exemplos:
#       $ source tarefa_10.sh
#       $ ListaPokemonsDoMestre nome_mestre
#       $ PokemonCapturado nome_mestre numero_pokedex
#
# ------------------------------------------------------- #
# Histórico
#
#   v1.0 02/07/2024, Autor da Mudança: Marcelo
#       - ListaPokemonsDoMestre, PokemonCapturado
#   v1.1 03/07/2024, Autor da Mudança: Marcelo
#       - RemoverPokemonDoMestre
#
# ------------------------------------------------------- #
# Testado em:
#   bash 5.2.15
# ------------------------------------------------------- #

# -----------------------  Variáveis  ------------------- #

PATH_SH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
PATH_BANCO_DADOS="$PATH_SH/Files/bd_captured_pokemons.txt"
PATH_POKEDEX="$PATH_SH/Files/pokedex.txt"

POKEDEX="$(cat $PATH_POKEDEX)" 
POKEDEX_HEAD="$(sed 1q <<< "$POKEDEX")"
POKEDEX_BODY="$(tail -n +2 <<< "$POKEDEX")"

MAIOR_ID=

SEP=","
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

# ListaPokemonsDoMestre nome_mestre
ListaPokemonsDoMestre () {

    local banco_dados_filtrado="$(cat $PATH_BANCO_DADOS | grep $1)"
    echo -e "${VERDE}Mestre: ${VERMELHO}$1${CINZA}"

    while read -r linha
    do
        [ "$(cut -c1 <<< $linha)" = "#" ] && continue
        [ ! "$linha" ] && continue

        local numero_pokedex="$(cut -d , -f 3 <<< $linha)"
        cat Tarefas/Files/pokedex.txt | awk -F , -v search="$numero_pokedex" '$1 ~ search'
    done <<< "$banco_dados_filtrado"
}

# ValidaExistenciaPokemonPorNumero numero_pokedex
ValidaExistenciaPokemonPorNumero () {
    local re_pokedex_numero="^(0[0-9][0-9]|1[0-4][0-9]|15[0-1])$"

    if [[ "$1" =~ $re_pokedex_numero ]] && [[ "$1" != "000" ]]
    then
        return 0
    else
        echo "ERRO: Numero na pokedex inválido."
        return 1
    fi
}

PreencheMaiorId () {
    MAIOR_ID=$(sort -nrk1,1 $PATH_BANCO_DADOS | head -1 | cut -d , -f 1)
}

# PokemonCapturado nome_mestre numero_pokedex
PokemonCapturado () {
    if ValidaExistenciaPokemonPorNumero $2; then
        PreencheMaiorId
        local next_id=$(($MAIOR_ID+1))
        echo "$next_id,$1,$2" >> "$PATH_BANCO_DADOS"
        echo "Pokemon capturado com sucesso."
    fi
} 

ValidaExistenciaUsuarioPokemon () {
    grep -i -q "$SEP$1$SEP$2" "$PATH_BANCO_DADOS"
}

# RemoverPokemonDoMestre nome_mestre numero_pokedex
RemoverPokemonDoMestre () {
    ValidaExistenciaUsuarioPokemon "$1" "$2" || return
    
    grep -i -v "$SEP$1$SEP$2" "$PATH_BANCO_DADOS" > "$TEMP"
    mv "$TEMP" "$PATH_BANCO_DADOS"

    echo "Pokemon removido com sucesso!"
}
