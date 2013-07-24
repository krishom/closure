#!/bin/bash -e
cd $(dirname $0)
ROOT=${HOME}
LIB_DIR=${ROOT}/closure-library
BUILDER=${LIB_DIR}/closure/bin/build/closurebuilder.py
COMPILER=${ROOT}/closure-compiler/compiler.jar
if [[ ! -f "${BUILDER}" ]]; then
  echo "Downloading Closure Library"
  git clone https://code.google.com/p/closure-library/ ${ROOT}/closure-library
fi
if [[ ! -f ${COMPILER} ]]; then
  echo "Downloading Closure Compiler"
  curl -O 'http://closure-compiler.googlecode.com/files/compiler-latest.zip'
  unzip compiler-latest.zip -d ~/closure-compiler
  rm compiler-latest.zip
fi
if [[ " $* " == *" debug "* ]]; then
  echo "Compiling with debug flags"
  DEBUG_FLAGS='
    --compiler_flags=--formatting=PRETTY_PRINT
    --compiler_flags=--debug'
fi
python ${BUILDER} ${DEBUG_FLAGS} \
  --compiler_flags="--compilation_level=ADVANCED_OPTIMIZATIONS" \
  --compiler_flags="--warning_level=VERBOSE" \
  --compiler_jar=${COMPILER} \
  --namespace="myproject.start" \
  --output_file=start-compiled.js \
  --output_mode=compiled \
  --root=. \
  --root=${LIB_DIR}
