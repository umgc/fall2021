#!/bin/sh
gpg --decrypt --passphrase="test" --output TestGPG_output.txt TestGPG.gpg

cat TestGPG_output.txt