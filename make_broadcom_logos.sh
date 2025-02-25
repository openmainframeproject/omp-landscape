#!/bin/bash

cd $(dirname $BASH_SOURCE)
cd hosted_logos

logo='broadcom_corporation.svg'
products=(
  'Endevor®'
  'IDMS'
  'Abend Analyzer for Mainframe'
  'COBOL Control Flow'
  'COBOL Language Support'
  'Code4z'
  'Data Editor for Mainframe'
  'Debugger for Mainframe'
  'HLASM Language Support'
  'JCLCheck™ Workload Automation'
  'MAT Analyze'
  'MAT Detect'
  'Output Management View™ for z/OS'
  'Workload Automation CA7®'
  'Alert Central'
  'API State Monitor for Zowe API ML'
  'IDMS Systems REST API'
  'Mainframe Security Insights Platform'
  'Test4z'
  'Vantage™ Storage Resource Manager'
  'Output Management Spool™ for z/OS'
  'Database Management Solutions for Db2 for z/OS'
  'ESP Workload Automation'
  'File Master™ Plus'
  'Mainframe Application Tuner'
  'Mainframe Operational Intelligence'
  'Mainframe Topology'
  'MAT REST API'
  'NetMaster'
  'OPS/MVS®'
  'SymDump'
  'SYSVIEW® Performance Management'
  'WatchTower Alert Insights'
  'WatchTower Data Insights'
  'WatchTower Metric Catalog'
  'Endevor® Bridge For Git'
  'Explorer for Endevor'
  'OPS/REXX Language Support Extension for VS Code'
  'Brightside'
  'Enterprise Support for Zowe'
  'MICS Rest API Server'
  'Datacom Systems REST API'
)

for i in ${!products[@]};
do
  product=${products[$i]}
  filename="$(tr [A-Z] [a-z] <<< "$product")"
  filename="${filename// /-}"
  filename="${filename//\//}"
  filename="${filename//®/}"
  filename="${filename//™/}.svg"
  texttoadd="<text x=\"50%\" y=\"50\" style=\"font: 10px sans-serif;alignment-baseline: middle; text-anchor:middle;\">${product}</text></svg>"
  echo "Creating ${filename} for ${product}"

  cp $logo $filename
  sed -i'.original' 's/height="33"/height="70"/g' $filename
  sed -i'.original' "s|</svg>|${texttoadd}|g" $filename
  inkscape $filename --actions="page-fit-to-selection" --export-text-to-path --export-plain-svg --export-filename=$filename
done

rm *.original
