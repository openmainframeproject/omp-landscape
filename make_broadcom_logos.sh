#!/bin/bash

cd $(dirname $BASH_SOURCE)
cd hosted_logos

logo='broadcom_corporation.svg'
products=(
# Explorer for Visual Studio Code ZOWE V2
  'Abend Analyzer for Mainframe'
  'COBOL Control Flow'
  'COBOL Language Support'
  'Code4z'
  'Data Editor for Mainframe'
  'Debugger for Mainframe'
  'Endevor®'
  'Explorer for Endevor'
  'HLASM Language Support'
  'JCLCheck™ Workload Automation'
  'OPS/REXX Language Support Extension for VS Code'
# CLI ZOWE V2
  'Database Management Solutions for Db2 for z/OS'
  'Endevor® Bridge For Git'
  'File Master™ Plus'
  'IDMS'
  'MAT Analyze'
  'MAT Detect'
  'Output Management Spool™ for z/OS'
  'Output Management View™ for z/OS'
  'SYSVIEW® Performance Management'
  'Workload Automation CA7®'
# API Mediation Layer ZOWE V2
  'Alert Central'
  'API State Monitor for Zowe API ML'
  'ESP Workload Automation'
  'IDMS Systems REST API'
  'Mainframe Security Insights Platform'
  'Mainframe Topology'
  'MAT REST API'
  'NetMaster'
  'OPS/MVS®'
  'SymDump'
  'Test4z'
# App Framework ZOWE V2
  'Vantage™ Storage Resource Manager'
# CLI ZOWE V3
  'Mainframe Application Tuner'
  'ESP Workload Automation'
# API Mediation Layer ZOWE V3
  'Mainframe Operational Intelligence'
  'MICS Rest API Server'
  'WatchTower Alert Insights'
  'WatchTower Data Insights'
  'WatchTower Metric Catalog'
# Unused
  'Brightside'
  'Enterprise Support for Zowe'
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
