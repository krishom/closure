#/bin/bash
cd $(dirname $0)
if [[ -z "$(which gjslint)" ]]; then
  echo "This script requires the Closure Linter"
  echo "https://developers.google.com/closure/utilities/docs/linter_howto"
  sudo easy_install pip
  sudo pip install https://github.com/google/closure-linter/zipball/master
fi
gjslint --strict --closurized_namespaces=myproject --jslint_error=all -x start-compiled.js -r .
