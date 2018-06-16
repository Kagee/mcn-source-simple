#! /usr/bin/env bash
# Download: https://domene.shop/expired
SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${SOURCE_DIR}" || exit
source config.sh
DOWNLOADER="$PWD/get-expired.sh"
CT="$(sed -e "s#<PATH>#${DOWNLOADER}#" -e "s#<MARKER>#${CRONTAB_MARKER}#" download.crontab.template)"

crontab -l | grep -v "$CRONTAB_MARKER" | cat - <(echo "$CT") | crontab -

