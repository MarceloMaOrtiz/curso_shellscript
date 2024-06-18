#!/usr/bin/env bash

echo "######## for 1 ########"
for (( i=0; i<10; i++)); do
    echo "$i";
done

echo "######## for 2 - seq ########"
for i in $(seq 10); do
    echo "$i";
done

echo "######## for 3 - array ########"
Frutas=(
    'Laranja'
    'Ameixa'
    'Abacaxi'
    'Melancia'
)
for fruta in ${Frutas[@]}; do
    echo "$fruta"
done

echo "######## While ########"
contador=0
while [[ contador -lt ${#Frutas[@]} ]]; do
    echo "$contador - ${Frutas[$contador]}"
    contador=$((contador+1))
done