#!/bin/bash

manifest_list=$(ls manifest*tsv)

cd data
for manifest in ${manifest_list}; do
  echo "Downloading from ${manifest}"
  mkdir ${manifest}
  cd ${manifest}
  gdc-client download --manifest "../../${manifest}"
  cd ..
done
cd ..

