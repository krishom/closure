#/bin/bash
cd $(dirname $0)
if [[ -z "$(which gjslint)" ]]; then
  echo "This script requires the Closure Linter"
  echo "https://developers.google.com/closure/utilities/docs/linter_howto"
  echo
  echo "To install on Linux:"
  echo "$ sudo apt-get install python-setuptools"
  echo "$ cd /tmp"
  echo "$ sudo easy_install http://closure-linter.googlecode.com/files/closure_linter-latest.tar.gz"
  exit 1
fi
gjslint --strict --closurized_namespaces=myproject --jslint_error=all -x start-compiled.js -r .
