#!/bin/bash

# First argument: Client identifier
# Second argument (lin) for linux network manager

KEY_DIR=~/openvpn-ca/keys
OUTPUT_DIR=~/client-configs/files
BASE_CONFIG=~/client-configs/base.conf


if [[ "${2}" = "lin" ]]; then
	mkdir -p ${OUTPUT_DIR}/${1}
        cat ${BASE_CONFIG} \
        <(echo -e 'ca ca.crt') \
        <(echo -e 'cert ${1}.crt') \
        <(echo -e 'key ${1}.key') \
        <(echo -e 'tls-auth ta.key 1') \
        > ${OUTPUT_DIR}/${1}/${1}.ovpn
        cp ${KEY_DIR}/ca.crt ${OUTPUT_DIR}/${1}/
        cp ${KEY_DIR}/${1}.crt ${OUTPUT_DIR}/${1}/
        cp ${KEY_DIR}/${1}.key ${OUTPUT_DIR}/${1}/
        cp ${KEY_DIR}/ta.key ${OUTPUT_DIR}/${1}/
	zip ${OUTPUT_DIR}/${1}/${1}.zip ${OUTPUT_DIR}/${1}/${1}.ovpn ${OUTPUT_DIR}/${1}/ca.crt ${OUTPUT_DIR}/${1}/${1}.crt ${OUTPUT_DIR}/${1}/${1}.key ${OUTPUT_DIR}/${1}/ta.key
else

	mkdir -p ${OUTPUT_DIR}/${1}
        cat ${BASE_CONFIG} \
        <(echo -e '<ca>') \
        ${KEY_DIR}/ca.crt \
        <(echo -e '</ca>\n<cert>') \
        ${KEY_DIR}/${1}.crt \
        <(echo -e '</cert>\n<key>') \
        ${KEY_DIR}/${1}.key \
        <(echo -e '</key>\n<tls-auth>') \
        ${KEY_DIR}/ta.key \
        <(echo -e '</tls-auth>') \
        > ${OUTPUT_DIR}/${1}/${1}.ovpn
	zip ${OUTPUT_DIR}/${1}/${1}.zip ${OUTPUT_DIR}/${1}/${1}.ovpn
fi
