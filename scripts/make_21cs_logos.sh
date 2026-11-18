#!/bin/bash

cd "$(dirname "$BASH_SOURCE")" || exit 1
cd ../hosted_logos || exit 1

logo='21cs_corporation.svg'
products=(
  'VERIFIn'
)

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
  texttoadd="<text x=\"50%\" y=\"760\" style=\"font: 100px sans-serif;alignment-baseline: middle; text-anchor:middle;\">${product}</text></svg>"
  echo "Creating ${filename} for ${product}"

  cp $logo $filename
  sed -i'.original' 's/height="652"/height="820"/g' $filename
  sed -i'.original' 's/viewBox="0 0 1232 652"/viewBox="0 0 1232 820"/g' $filename
  sed -i'.original' "s|</svg>|${texttoadd}|g" $filename
  inkscape $filename --actions="page-fit-to-selection" --export-text-to-path --export-plain-svg --export-filename=$filename
done

rm *.original
