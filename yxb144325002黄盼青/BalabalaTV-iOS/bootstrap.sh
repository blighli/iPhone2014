#!/bin/bash
PKG_URL="http://tv.askeasy.cn/download/MobileVLCKit.tar.gz"

FILE_PATH="./balabalaTV/Framework/MobileVLCKit.framework"

echo "Looking for MobileVLCKit.framework file in local....."

if [ -d "$FILE_PATH" ]; then
	echo "[NOTICE] MobileVLCKit.framework already existed!~"
else
	echo "[NOTICE] Can not find the MobileVLCKit.framework in local!"
	echo "Prepare download MobileVLCKit.framework!!"

	curl -o "MobileVLCKit.tar.gz" "$PKG_URL"

	if [ $? == 0 ]; then
		echo "Download Done!"
	fi

	if [ ! -f "MobileVLCKit.tar.gz" ]; then
		echo "[ERROR] MobileVLCKit.tar.gz doesn't exist!"
		exit -1;
	fi

	echo "Prepareing to extract...."
	mkdir -p ./balabalaTV/Framework
	tar -zxvf "MobileVLCKit.tar.gz" -C "./balabalaTV/Framework/"

	if [ $? != 0 ]; then
		echo "Extract failed!"
		exit -1;
	else
		echo "Extract done!"
		rm -rf MobileVLCKit.tar.gz
	fi
fi


echo "Checking Cocoapods Version...."

podversion=`pod --version`


if [ "$podversion" = "" ]; then
	echo "[ERROR] Please install cocopods first!"
	exit -1;
else
	echo "Cocoapods version:$podversion"
	echo ""
	echo "excute pod install...."

	pod install

	if [ $? != 0 ]; then
		echo "[ERROR] pod install failed!"
		exit -1;
	else
		echo "[FINISH] enjoy"
	fi
fi