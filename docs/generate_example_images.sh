#!/bin/bash

echo "Generating example images from the compiled PDFs for the README..."
mkdir -p images/biso-example

echo "Clean output image directories"
rm images/biso-example/biso-example*
echo ""

echo "Generating png single images..."
gs -dNOPAUSE -sDEVICE=png16m -r50 -sOutputFile=images/biso-example/biso-example-%02d.png ../examples/biso-2024-draft/biso-example.pdf -c quit
echo "Done."
echo ""

echo "Generating matrix image with borders..."
montage images/biso-example/biso-example-[0-9][0-9].png -tile 2x -border 3 -geometry +10+10 images/biso-example/biso-example.png
echo "Done."
echo ""

echo "Clean temporary images..."
rm images/biso-example/biso-example-*
echo ""

echo "DONE. Example images generated."
