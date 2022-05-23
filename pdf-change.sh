#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

PDF_NAME=$1
if [ $# -eq 0 ]; then
	echo -e "${RED}Error:${NC} No filename supplied, please use like: pdf-change.sh my_document_here.pdf"
	exit 1
fi

# Ensure temporary output folder exists and is empty
echo -e "${GREEN}Working:${NC} Ensuring temporary folder exists and is empty"
mkdir -p ./pdf-change-temporary
rm -f ./pdf-change-temporary/*

# Convert each page of the PDF to a 300dpi PNG image
echo -e "${GREEN}Working:${NC} Converting PDF to individual images"
convert -density 300 $PDF_NAME "./pdf-change-temporary/output-%03d.png"

# Replace each page's colour
page=1
for file in ./pdf-change-temporary/*.png; do
	echo -e "${GREEN}Working:${NC} Changing colours for page ${page}"
	convert $file -channel rgba -alpha set -fuzz 20% -fill "#FBF0D9" -opaque "#ffffff" $file
	convert $file -channel rgba -alpha set -fuzz 20% -fill "#1B9EFF" -opaque "#363737" $file
	convert $file -channel rgba -alpha set -fuzz 10% -fill "#1B9EFF" -opaque "#000000" $file

	page=$((page+1))
	# convert $file -background red -flatten $file
done

# Recombine
echo -e "${GREEN}Working:${NC} Converting back to a single PDF"
convert "./pdf-change-temporary/*.png" -quality 100 ${PDF_NAME%.pdf}.converted.pdf

echo -e "${GREEN}Working:${NC} Cleaning up"
rm -rf ./pdf-change-temporary
