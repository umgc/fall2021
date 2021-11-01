#!/bin/sh
gpg --decrypt --passphrase="test" --output ./.github/secrets/TestGPG_output.txt ./.github/secrets/TestGPG.gpg

cat ./.github/secrets/TestGPG_output.txt