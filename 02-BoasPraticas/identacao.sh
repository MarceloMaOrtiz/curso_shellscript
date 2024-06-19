#!/usr/bin/env bash

PARAMETRO=1

# Errado
# if [ $PARAMETRO -gt 0 ]; then if [ $PARAMETRO -gt 1 ]; then if [ $PARAMETRO -gt 2 ]; then echo "oi"; fi fi fi

# Correto
if [ $PARAMETRO -gt 0 ]; then
    if [ $PARAMETRO -gt 1 ]; then
        if [ $PARAMETRO -gt 2 ]; then
            echo "oi";
        fi
    fi
fi