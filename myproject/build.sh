#!/bin/bash -ex
cd $(dirname $0)
ROOT=${HOME}
LIB_DIR=${ROOT}/closure-library
BUILDER=${LIB_DIR}/closure/bin/build/closurebuilder.py
COMPILER=$(ls -1 ${ROOT}/closure-compiler/*.jar | sort -n | tail -n 1)
if [[ ! -f "${BUILDER}" ]]; then
  echo "Downloading Closure Library"
  git clone https://github.com/google/closure-library.git ${ROOT}/closure-library
fi
if [[ ! -f ${COMPILER} ]]; then
  echo "Downloading Closure Compiler"
  curl -O 'https://dl.google.com/closure-compiler/compiler-latest.zip'
  unzip compiler-latest.zip -d ~/closure-compiler
  rm compiler-latest.zip
fi
if [[ " $* " == *" debug "* ]]; then
  echo "Compiling with debug flags"
  DEBUG_FLAGS='
    --compiler_flags=--formatting=PRETTY_PRINT
    --compiler_flags=--debug'
fi
java -jar ${COMPILER} ${DEBUG_FLAGS} \
  --compilation_level=ADVANCED \
  --warning_level=VERBOSE \
  --js=start.js \
  --js=${LIB_DIR}/'**.js' \
  --js_output_file=start-compiled.js \
  --entry_point=myproject.start \
  --dependency_mode=STRICT
