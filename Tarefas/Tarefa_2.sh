#!/usr/bin/env bash

for((i=0; i<=10; i++)); do
    [ "$((i%2))" = "0" ] && [ "$i" != "0" ] && echo "$i é divisível por 2"
done