#!/bin/bash

ROOT_FOLDER="$(dirname `dirname $0`)"
DIAGRAM_FOLDER=${1:-$ROOT_FOLDER}
DIAGRAM_FOLDER=${DIAGRAM_FOLDER%/}

PLANTUML="/usr/local/bin/plantuml"


[[ ! -e ${PLANTUML} ]] && {
  echo "Instaling PlantUML"
  brew install plantuml
}

echo "Generating images for"
find $DIAGRAM_FOLDER -name "*.puml"

PLANTUML -o img "${DIAGRAM_FOLDER}/**.puml"
