#!/bin/bash

CURDIR=$(pwd)
KEYRING='eos-keyring.gpg'
KEY_DIR='keys'

GPG="gpg --homedir=${CURDIR} --no-default-keyring --keyring ${CURDIR}/${KEYRING}"

rm $CURDIR/${KEYRING}

for key_type in $KEY_DIR/*; do
  simple_type_name=$(basename $key_type)
  echo "Importing $simple_type_name keys"
  for key in $key_type/*.pub; do
    echo " - Importing $(basename $key) keys"
    $GPG --import $key
  done
done

echo
echo
$GPG --list-keys --with-colons
