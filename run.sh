#!/bin/bash

set -aux

[[ $# = 1 ]] || exit 1

run() {
	b="$(cat)"
	echo "$b"
	echo
	echo '# Output:'
	b="$(nix-instantiate --eval --strict --json --expr "$b" 2>&1)"
	if [[ $? == 0 ]]; then
		jq . --tab <<<"$b"
	else
		grep -v '^$' <<<"$b"
	fi
	echo
}
export -f run

sed -e '/^# Output:$/ p; /^# Output:$/,/^$/ d' "$1" | \
	parallel \
		-j '200%' --pipe --keep-order \
		--regexp --recend '# Output:\n' --rrs \
		-N1 \
	-- run >"$1.tmp"
mv "$1"{.tmp,}
