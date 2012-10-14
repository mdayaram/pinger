#/bin/bash

URLS="hithere-34215125:ihazasite:moovweb-pingpong:wiseley-organs:wiseley-steroids"

function ping_all {
	(IFS=:
		for f in $URLS
		do
			echo "Pinging $f.herokuapp.com ..."
			curl "$f.herokuapp.com" > /dev/null 2>&1
		done
		echo "Done pinging."
	)
	sleep 10s
	ping_all
}

ping_all
