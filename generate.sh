#!/bin/bash

echo $(dirname $0)

# Instala las dependencias
python3 -m pip install requests streamlink

# Descarga el certificado de la CA
CERT_PATH=$(dirname $0)/cacert.pem
curl -o $CERT_PATH https://curl.se/ca/cacert.pem

# Ejecuta el script de Python con verificación del certificado
python3 <<EOF
import os
import requests
import streamlink

# Configura la verificación del certificado
cert_path = os.path.join(os.path.dirname(__file__), 'cacert.pem')
os.environ['REQUESTS_CA_BUNDLE'] = cert_path

# Llama a tu script generator.py
exec(open(os.path.join(os.path.dirname(__file__), 'scripts/generator.py')).read())
EOF

echo Done!
