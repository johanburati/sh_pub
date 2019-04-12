#!/bin/bash
# Generate the README.md file

if [ -f DESCRIPTION ]; then
		echo "# ${PWD##*/}" > README.md 
		cat DESCRIPTION >> README.md
		echo "## Index" >> README.md 

#	case "${PWD##*/}" in
	case "${1}" in
		sh )
			echo "Generating index for shell scripts"
			for file in $(ls -1 *.sh | sort); do echo -n "* **$file**"; sed -n 's/^#/ -/;2p' $file; done >> README.md
			;;
		go)
			echo "Generating index for go programs"
			for dir in $(ls -1d */ | sed 's;/$;;' | sort | egrep -v "tmp|bak"); do echo -n "* **[$dir]($dir)** - "; sed -n '2p' $dir/README.md; done >> README.md
			;;
	esac
else
		echo "Error: DESCRIPTION file is missing !"
fi
echo "Done"
