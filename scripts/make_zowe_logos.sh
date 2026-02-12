#!/bin/bash

# Go to script directory
cd "$(dirname "$BASH_SOURCE")" || exit 1
cd ../hosted_logos || exit 1

logo='zowe.svg'
products=(
  "Zowe Explorer for IBM CICS Transaction Server"
  "Zowe Explorer for IBM z/OS FTP"
)

for product in "${products[@]}"; do
  # Create a normalized filename
  filename=$(tr '[:upper:]' '[:lower:]' <<< "$product")
  filename=${filename// /-}
  filename=${filename//\//}    # remove slashes
  filename=${filename//®/}     # remove registered mark
  filename=${filename//™/}     # remove trademark
  filename="${filename}.svg"

  echo "Creating ${filename} for ${product}"

  # Copy the base logo
  cp "$logo" "$filename" || exit 1

  # Increase height
  sed -i'.original' 's/height="33"/height="70"/g' "$filename"

# Inject text before closing </svg>
  texttoadd="<text x=\"50%\" y=\"90%\" style=\"font:32px sans-serif; fill:black; dominant-baseline:middle; text-anchor:middle;\">${product}</text>"
  sed -i'.original' "s|</svg>|${texttoadd}</svg>|g" "$filename"

  # Export using Inkscape
  inkscape "$filename" \
    --export-text-to-path \
    --export-plain-svg \
    --export-filename="$filename"

done

# Cleanup sed backups
rm -f *.original
