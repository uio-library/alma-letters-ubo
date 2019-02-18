#!/bin/bash

if [[ $1 == "" ]]; then
	echo "Usage: ./anonymize.sh test-data/*/*.xml"
else
	for filename in "$@"; do
		echo "$filename"
		xsltproc anonymize.xsl "$filename" >| tmp.xml
		mv -f "tmp.xml" "$filename"
	done
fi