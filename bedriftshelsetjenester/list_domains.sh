#! /usr/bin/env bash
# Info: http://data.norge.no/data/registerenheten-i-br%C3%B8nn%C3%B8ysund/enhetsregisteret
# Download: http://hotell.difi.no/download/brreg/enhetsregisteret?download
SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SOURCE_DIR"
source config.sh # MCN_TOOLS, DOMAINS

INPUT="bedriftshelsetjeneste.xml" # Updates daily: -mtime 1
if [ ! -e "$INPUT" ] || [ "x$1" = "x--update-src" ] || find "$INPUT" ! -mtime -1 | egrep '.*' >/dev/null; then
    echo "INFO: $INPUT was not found or older than X, downloading from arbeidstilsynet.no" 1>&2
    wget -O "$INPUT" "http://www.arbeidstilsynet.no/opendata/bedriftshelsetjeneste.xml"
else
    echo "INFO: $INPUT found. Use '$0 --update-src' to redownload." 1>&2
fi

YMD="$(date +%F)"

if [ ! -e "output/$YMD-$DOMAINS" ] || [ "x$1" = "x--update-list" ] || find "$INPUT" -mmin -1 | egrep '.*' >/dev/null; then
    echo "INFO: output/$YMD-$DOMAINS not found or $INPUT is modified in last minute, extracting ..." 1>&2
    mv output/* old/
    cat "$INPUT" old/*.list 2>/dev/null | "$MCN_TOOLS/default_extract" > "_tmp.list"
    mv "_tmp.list" "output/$YMD-$DOMAINS"
else
    echo "INFO: output/$YMD-$DOMAINS found. Use '$0 --update-list' to force new extraction." 1>&2
fi

