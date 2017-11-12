#! /usr/bin/env bash
# Info: http://data.norge.no/data/registerenheten-i-br%C3%B8nn%C3%B8ysund/enhetsregisteret
# Download: http://hotell.difi.no/download/brreg/enhetsregisteret?download
SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${SOURCE_DIR}"
source config.sh # MCN_TOOLS, DOMAINS

if [ ! -e 'alle.txt' ] || [ "x$1" = "x--update-src" ]; then
    echo "INFO: alle.txt was not found, downloading from mimesbronn.no" 1>&2
    wget -O alle.zip "https://www.mimesbronn.no/request/60/response/188/attach/2/alle.zip"
    unzip alle.zip
else
    echo "INFO: alle.txt found. Use '$0 ----update-src' to redownload." 1>&2
fi

if [ ! -e "${DOMAINS}" ] || [ "x$1" = "x--update-list" ]; then
    echo "INFO: ${DOMAINS} not found, extracting ..." 1>&2
    cat ./alle.txt | ${MCN_TOOLS}/default_extract > "${DOMAINS}"
else
    echo "INFO: ${DOMAINS} found. Use '$0 --update-list' to force new extraction." 1>&2
fi
cat "${DOMAINS}"

