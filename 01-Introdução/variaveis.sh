#!/usr/bin/env bash

echo "Teste"

NOME="Marcelo Ortiz"

echo $NOME

NOME="Marcelo
Ortiz"

echo $NOME
echo "$NOME"

NUMERO_1=24
NUMERO_2=45

TOTAL=$(($NUMERO_1+$NUMERO_2))

echo "$TOTAL"

SAIDA_CAT="$(cat /etc/passwd | grep mmortiz)"

echo "$SAIDA_CAT"

echo "------------------------------"

echo "Parametro 1: $1"
echo "Parametro 2: $2"
echo "Todos os parâmetros: $*"
echo "Quantos parâmetros: $#"
echo "Saída do último comando: $?"
echo "PID: $$"
echo "$0"