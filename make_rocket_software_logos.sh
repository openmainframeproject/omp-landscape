#!/bin/bash

cd $(dirname $BASH_SOURCE)
cd hosted_logos

logo='rocket_software_inc.svg'
products=('Rocket® PRO/JCL' 'Rocket™ BlueZone Web' 'Rocket Support for Zowe')

for i in ${!products[@]};
do
  product=${products[$i]}
  filename="$(tr [A-Z] [a-z] <<< "$product")"
  filename="${filename// /-}"
  filename="${filename//\//}"
  filename="${filename//®/}"
  filename="${filename//(/}"
  filename="${filename//)/}"
  filename="${filename//™/}.svg"
  texttoadd="<text x=\"50%\" y=\"260\" style=\"font: 40px sans-serif;alignment-baseline: middle; text-anchor:middle;\">${product}</text></svg>"
  echo "Creating ${filename} for ${product}"
  cp $logo $filename
  sed -i'.original' 's/viewBox="0 0 400 245"/viewBox="0 0 400 300"/g' $filename
  sed -i'.original' "s|</svg>|${texttoadd}|g" $filename
  inkscape $filename --export-area-drawing --export-text-to-path --export-plain-svg --export-filename=$filename
done

rm *.original
