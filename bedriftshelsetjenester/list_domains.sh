#! /usr/bin/env bash
# Info: http://data.norge.no/data/registerenheten-i-br%C3%B8nn%C3%B8ysund/enhetsregisteret
# Download: http://hotell.difi.no/download/brreg/enhetsregisteret?download
SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${SOURCE_DIR}"
source config.sh # MCN_TOOLS, DOMAINS

INPUT="bedriftshelsetjeneste.xml" # Updates daily: -mtime 1
if [ ! -e "${INPUT}" ] || [ "x$1" = "x--update-src" ] || [ "`find $INPUT -mtime 1`" ]; then
    echo "INFO: ${INPUT} was not found or older than X, downloading from arbeidstilsynet.no" 1>&2
    wget -O ${INPUT} "http://www.arbeidstilsynet.no/opendata/bedriftshelsetjeneste.xml"
else
    echo "INFO: ${INPUT} found. Use '$0 --update-src' to redownload." 1>&2
fi

if [ ! -e "${DOMAINS}" ] || [ "x$1" = "x--update-list" ] || [ "`find $INPUT ! -mmin +1`"  ]; then
    echo "INFO: ${DOMAINS} not found or $INPUT is fresh, extracting ..." 1>&2
    cat "${INPUT}" | ${MCN_TOOLS}/default_extract > "${DOMAINS}"
else
    echo "INFO: ${DOMAINS} found. Use '$0 --update-list' to force new extraction." 1>&2
fi
#cat "${DOMAINS}"

