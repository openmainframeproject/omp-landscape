#!/bin/bash

cd $(dirname $BASH_SOURCE)
cd hosted_logos

logo='international_business_machines_corporation.svg'
products=('IBM® Db2 Administration Foundation for z/OS' 'IBM® Remote System Explorer API' 'crc32-s390x' 'IBM® Z System Automation' 'IBM® Z Service Management Explorer' 'IBM® Z Workload Scheduler' 'Db2 DevOps Experience for z/OS' 'Service Automation Suite' 'Service Management Suite for z/OS' 'Service Management Unite' 'IBM® Z Netview' 'libica' 'qclib' 's390-tools' 'Shared Memory Communication Tools' 'snIPL' 'source VIPA' 'System Loader (sysload)' 'z/OS Connect EE' 'z/OS Node Accessor' 'z/OS Tools' 'zfcp HBA API library' 'Remote System Explorer API' 'Zowe CLI CICS Deploy')

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
  texttoadd="<text x=\"50%\" y=\"240\" style=\"font: 22px sans-serif;alignment-baseline: middle; text-anchor:middle;\">${product}</text></svg>"
  echo "Creating ${filename} for ${product}"
  cp $logo $filename
  sed -i'.original' 's/viewBox="0 0 400 245"/viewBox="0 0 400 300"/g' $filename
  sed -i'.original' "s|</svg>|${texttoadd}|g" $filename
  inkscape $filename --export-text-to-path --export-plain-svg --export-filename=$filename
done

rm *.original
