#!/bin/sh
# gpg --decrypt --passphrase="$IOS_KEYS" --output ./.github/secrets/TestGPG_output.txt ./.github/secrets/TestGPG.gpg
echo "$IOS_KEYS" | gpg --batch --yes --passphrase-fd 0 --output ./.github/secrets/TestGPG_output.txt ./.github/secrets/TestGPG.gpg

cat ./.github/secrets/TestGPG_output.txt
