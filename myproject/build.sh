#!/bin/bash -e
cd $(dirname $0)
ROOT=${HOME}
BUILDER=${ROOT}/closure-library/closure/bin/build/closurebuilder.py
COMPILER=${ROOT}/closure-compiler/compiler.jar
if [[ ! -f "${BUILDER}" ]]; then
  echo "Expected Closure Builder at ${BUILDER}"
  git clone https://code.google.com/p/closure-library/ ${ROOT}/closure-library
fi
if [[ ! -f ${COMPILER} ]]; then
  echo "Expected Closure Compiler at ${COMPILER}"
  curl -O 'http://closure-compiler.googlecode.com/files/compiler-latest.zip'
  unzip compiler-latest.zip -d ~/closure-compiler
  rm compiler-latest.zip
fi
python ${BUILDER} \
  --compiler_flags="--compilation_level=ADVANCED_OPTIMIZATIONS" \
  --compiler_jar=${COMPILER} \
  --namespace="myproject.start" \
  --output_file=start-compiled.js \
  --output_mode=compiled \
  --root=. \
  --root=${ROOT}/closure-library/
