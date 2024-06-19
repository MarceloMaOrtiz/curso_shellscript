#!/usr/bin/env bash

find / -iname "*.so" \
    -user mmortiz \
    -type f \
    -size +1M \
    -exec ls {} \;