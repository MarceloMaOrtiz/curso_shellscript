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
#   v2.0 03/07/2024, Autor da Mudança: Marcelo
#       - Acrescentando Dialog ao sistema
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
[ -x "$(which dialog)" ] && sudo apt install dialog \
    1> /dev/null 2>&1
 
# ------------------------------------------------------- #
# ------------------------  Funções  -------------------- #

ListaUsuarios () {
    egrep -v "^#|^$" "$PATH_BANCO_DADOS" | tr : ' ' > "$TEMP"
    dialog --title "Lista de Usuários" --textbox "$TEMP" 20 40
    rm -f "$TEMP"
}

ValidaExistenciaUsuario () {
    grep -i -q "$1$SEP" "$PATH_BANCO_DADOS"
}

InsereUsuario () {
    local ultimo_id="$(egrep -v "^#|^$" "$PATH_BANCO_DADOS" | \
        sort | tail -n 1 | cut -d $SEP -f 1)"
    local proximo_id=$(($ultimo_id+1))

    # Nesse caso não se usa "" (Aspas), pois será passa uma
    # string para a linha de comando
    local nome=$(dialog --title "Cadastro de Usuários" \
        --stdout --inputbox "Digite o seu nome" 0 0)

    ValidaExistenciaUsuario "$nome" && {
        dialog --title "ERRO" --msgbox "Usuário já cadastrado!" 6 40
        exit 1
    }

    local email=$(dialog --title "Cadastro de Usuários" \
        --stdout --inputbox "Digite o seu e-mail" 0 0)
    
    echo "$proximo_id$SEP$nome$SEP$email" >> "$PATH_BANCO_DADOS"

    dialog --title "SUCESSO!" \
        --msgbox "Usuário cadastrado com sucesso!" 6 40

    OrdenaBanco

    ListaUsuarios
}

OrdenaBanco () {
    sort "$PATH_BANCO_DADOS" > "$TEMP"
    mv "$TEMP" "$PATH_BANCO_DADOS"
}

RemoveUsuario () {
    local usuarios=$(egrep "^#|^$" -v $PATH_BANCO_DADOS | \
        sort -h | cut -d $SEP -f 1,2 | sed 's/:/ "/;s/$/"/')
    
    # ATENÇÃO -> A variável $usuario dentro do dialog deve ser
    # interpretada como uma string, porém normalmente isso não
    # acontece. Para resolver é necessário utilizar o EVAL.
    # Com o EVAL tudo é interpretado como uma string, porém as
    # "" (Aspas) do "Escolha um ..." não deveriam ser interpretada
    # como string, por isso é necessário utilizar \ (escape)
    local id_usuario=$(eval dialog --stdout \
        --menu \"Escolha um usuário:\" 0 0 0 $usuarios)

    grep -v "^$id_usuario$SEP" "$PATH_BANCO_DADOS" > "$TEMP"
    mv "$TEMP" "$PATH_BANCO_DADOS"

    dialog --title "SUCESSO!" \
        --msgbox "Usuário removido com sucesso!" 6 40

    OrdenaBanco

    ListaUsuarios
}

FecharPrograma () {
    dialog --title "Adeus!" \
        --msgbox "Obrigado por utilizar nosso sistema!" 6 40
    
    exit 0
}

# ------------------------------------------------------- #
# -----------------------  Execução  -------------------- #

# Loop infinito
while :
do
    acao=$(dialog --title "Gerenciamento de Usuários 2.0" \
        --stdout --menu "Escolha uma das opções abaixo:" 0 0 0 \
        listar "Listar todos os usuários" \
        inserir "Inserir um novo usuário" \
        remover "Remover um usuário")
    
    case $acao in
        listar) ListaUsuarios;;
        inserir) InsereUsuario;;
        remover) RemoveUsuario;;
        *) FecharPrograma;;
    esac
done
# ------------------------------------------------------- #
# ------------------------------------------------------- #