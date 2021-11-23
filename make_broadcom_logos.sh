#!/bin/bash

cd $(dirname $BASH_SOURCE)
cd hosted_logos

logo='broadcom_corporation.svg'
products=('Zowe Explorer Extension for FTP' 'CA Compliance Event Manager' 'COBOL Language Support' 'Abend Analyzer for Mainframe' 'Debugger for Mainframe' 'Data Editor for Mainframe' 'HLASM Language Support'  'Explorer for Endevor' 'Code4z' 'COBOL Control Flow' 'Alert Central' 'JCL Language Support' 'Test4z' 'Brightside' 'CA SymDump' 'CA NetMaster' 'Datacom DST API' 'CA Data Content Discovery' 'CA Mainframe Security Insights Platform' 'CA Workload Automation CA 7®' 'CA Database Management Solutions for Db2 for z/OS' 'CA Vantage™ Storage Resource Manager' 'CA IDMS' 'CA Endevor®' 'CA JCLCheck™ Workload Automation' 'CA View®' 'CA OPS/MVS®' 'CA z/OS Extended Jobs' 'CA z/OS Extended Files' 'CA MAT Detect' 'CA MAT Analyze' 'CA SYSVIEW® Performance Management' 'CA Endevor® Bridge For Git' 'CA Secure Credential Store' 'CA File Master™ Plus' 'CA Spool™' 'CA MAT')

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
#  curl -X POST -H "Content-Type: application/json" -d "{\"svg\": `php -r 'echo json_encode(file_get_contents("${logo}"));'`, \"title\": \"${product} logo\", \"caption\": \"${product}\"}" https://autocrop.cncf.io/autocrop
#  echo ${response}
#  success=$( jq -r  '.success' <<< "${response}" )
#  echo ${success}
#  if [ ${success} ];
#  then
#    echo "$( jq -r  '.result' <<< \"${response}\" )"
#  fi


  cp $logo $filename
  sed -i'.original' 's/height="33"/height="70"/g' $filename
  sed -i'.original' "s|</svg>|${texttoadd}|g" $filename
  inkscape $filename --export-text-to-path --export-plain-svg --export-filename=$filename
done

rm *.original
