#!/bin/sh

set -eo pipefail

gpg --quiet --batch --yes --decrypt --passphrase="$IOS_KEYS" --output ./.github/secrets/match_Apple-Store-UMGC_Profile.mobileprovision ./.github/secrets/match_Apple-Store-UMGC_Profile.mobileprovision.gpg