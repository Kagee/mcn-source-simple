#! /usr/bin/env bash
# Info: http://data.norge.no/data/registerenheten-i-br%C3%B8nn%C3%B8ysund/enhetsregisteret
# Download: http://hotell.difi.no/download/brreg/enhetsregisteret?download
SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${SOURCE_DIR}"
source config.sh # MCN_TOOLS, DOMAINS

# Timestamping is turned off on the server, so we can't use it for wget
# Download if missing or --update-source
if [ ! -e 'enhetsregisteret.csv' ] || [ "x$1" = "x--update-src" ]; then
    echo "INFO: enhetsregisteret.csv was not found, downloading from hotell.difi.no" 1>&2
    wget -O enhetsregisteret.csv "http://hotell.difi.no/download/brreg/enhetsregisteret?download"
else
    echo "INFO: enhetsregisteret.csv found. Use '$0 ----update-src' to redownload." 1>&2
fi

if [ ! -e "${DOMAINS}" ] || [ "x$1" = "x--update-list" ]; then
    echo "INFO: ${DOMAINS} not found, extracting ..." 1>&2
    cat ./enhetsregisteret.csv | ${MCN_TOOLS}/default_extract > "${DOMAINS}"
else
    echo "INFO: ${DOMAINS} found. Use '$0 --update-list' to force new extraction." 1>&2
fi
cat "${DOMAINS}"

