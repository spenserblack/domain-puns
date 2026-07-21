#!/bin/sh
ROOT_DIR="$(dirname "$(dirname "$(readlink -f "$0")")")"
URL="https://data.iana.org/TLD/tlds-alpha-by-domain.txt"
TARGET="$ROOT_DIR/src/domain_puns/domains.gleam"
echo "Generating \"$TARGET\"..."
mkdir -p "$(dirname "$TARGET")"
echo "// Generated - DO NOT EDIT" > "$TARGET"
echo "pub const domains: List(String) = [" >> "$TARGET"
curl -fsSL "$URL" | sed 's/^#.*$//gm' | while read line; do
	# NOTE: Skip blank lines (the sed above makes commented lines blank)
	if [ -z "$line" ]; then
		continue
	fi
	echo "  \"$line\"," >> "$TARGET"
done
echo "]" >> "$TARGET"
