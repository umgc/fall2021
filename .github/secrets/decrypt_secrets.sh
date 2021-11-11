#!/bin/sh

#echo "$IOS_KEYS" | gpg --batch --yes --passphrase-fd 0 --output ./.github/secrets/TestGPG_output.txt ./.github/secrets/TestGPG.gpg
#cat ./.github/secrets/TestGPG_output.txt

#base64 -d ./.github/secrets/TestBase64.b64 > ./.github/secrets/TestBase64.txt
#cat ./.github/secrets/TestBase64.txt

#echo RELOADAGENT | gpg-connect-agent
echo "$IOS_KEYS" | gpg --batch --yes --passphrase-fd 0 --output ./.github/secrets/Apple-Store-UMGC_Profile.mobileprovision --decrypt ./.github/secrets/Apple-Store-UMGC_Profile.mobileprovision.gpg
echo "$IOS_KEYS" | gpg --batch --yes --passphrase-fd 0 --output ./.github/secrets/Apple-Store-UMGC-ios_distribution.p12 ./.github/secrets/Apple-Store-UMGC-ios_distribution.p12.gpg

mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles

cp ./.github/secrets/Apple-Store-UMGC_Profile.mobilepro#vision ~/Library/MobileDevice/Provisioning\ Profiles/Apple-Store-UMGC_Profile.mobileprovision

security create-keychain -p "" build.keychain
security import ./.github/secrets/Apple-Store-UMGC-ios_distribution.p12 -t agg -k ~/Library/Keychains/build.keychain -P "" -A

security list-keychains -s ~/Library/Keychains/build.keychain
security default-keychain -s ~/Library/Keychains/build.keychain
security unlock-keychain -p "" ~/Library/Keychains/build.keychain

security set-key-partition-list -S apple-tool:,apple: -s -k "" ~/Library/Keychains/build.keychain