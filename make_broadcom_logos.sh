#!/bin/bash

cd $(dirname $BASH_SOURCE)
cd hosted_logos

logo='broadcom_corporation.svg'
products=('CA NetMaster' 'Datacom DST API' 'CA Data Content Discovery' 'CA Mainframe Security Insights Platform' 'CA Workload Automation CA 7®' 'CA Database Management Solutions for Db2 for z/OS' 'CA Vantage™ Storage Resource Manager' 'CA IDMS' 'CA Endevor®' 'CA JCLCheck™ Workload Automation' 'CA View®' 'CA OPS/MVS®' 'CA z/OS Extended Jobs' 'CA z/OS Extended Files' 'CA MAT Detect' 'CA MAT Analyze' 'CA SYSVIEW® Performance Management' 'CA Endevor® Bridge For Git' 'CA Secure Credential Store' 'CA File Master™ Plus' 'CA Spool™' 'CA MAT')

for i in ${!products[@]};
do
  product=${products[$i]}
  filename="$(tr [A-Z] [a-z] <<< "$product")"
  filename="${filename// /-}"
  filename="${filename//\//}"
  filename="${filename//®/}"
  filename="${filename//™/}.svg"
  texttoadd="<text x=\"50%\" y=\"50\" style=\"font: 11px sans-serif;alignment-baseline: middle; text-anchor:middle;\">${product}</text></svg>"
  echo "Creating ${filename} for ${product}"
  cp $logo $filename
  sed -i'.original' 's/height="33"/height="70"/g' $filename
  sed -i'.original' "s|</svg>|${texttoadd}|g" $filename
  inkscape $filename --export-text-to-path --export-plain-svg --export-filename=$filename
done

rm *.original
