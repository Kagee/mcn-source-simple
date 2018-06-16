#! /usr/bin/env bash
# Download: https://domene.shop/expired
SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${SOURCE_DIR}"
source config.sh
DOWNLOADER="$PWD/get-expired.sh"
CT="$(cat download.crontab.template | sed -e "s#<PATH>#${DOWNLOADER}#" -e "s#<MARKER>#${CRONTAB_MARKER}#")"

crontab -l | grep -v "$CRONTAB_MARKER" | cat - <(echo "$CT") | crontab -

