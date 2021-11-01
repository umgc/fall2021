#!/bin/sh
echo "pinentry-program /usr/local/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
gpg --decrypt --passphrase="$IOS_KEYS" --output ./.github/secrets/TestGPG_output.txt ./.github/secrets/TestGPG.gpg

cat ./.github/secrets/TestGPG_output.txt