#! /usr/bin/env bash
# Download: https://domene.shop/expired
SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${SOURCE_DIR}"
source config.sh
DATA="${SOURCE_DIR}/data"
mkdir -p "$DATA"
DATE="$(date --iso)"
wget "$URL" -O "${DATA}/${DATE}.html" -o "${DATA}/${DATE}.log"
