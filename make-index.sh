#!/bin/bash
# Generate the README.md file


echo "# ${PWD##*/}" > README.md 
cat DESCRIPTION >> README.md
echo "## Index" >> README.md 
for file in $(ls -1 *.sh | sort); do echo -n $file; sed -n 's/^#/ -/;2p' $file; done >> README.md
