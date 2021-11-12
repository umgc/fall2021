#!/bin/sh -x

xcodebuild -workspace ./ios/Runner.xcworkspace \
           -scheme CLI \
		   -sdk iphoneos \
		   -configuration AppStoreDistribution archive \
		   -archivePath ./build/CLI.xcarchive
		   
xcodebuild -exportArchive \
           -archivePath ./build/CLI.xcarchive \
		   -exportOptionsPlist ./ios/exportOptions.plist \
		   -exportPath ./build
		   
ls ./build