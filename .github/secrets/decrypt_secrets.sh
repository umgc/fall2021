#!/bin/sh
export GPG_TTY=$(tty)
gpg --decrypt --passphrase="$IOS_KEYS" --output ./.github/secrets/TestGPG_output.txt ./.github/secrets/TestGPG.gpg

cat ./.github/secrets/TestGPG_output.txt