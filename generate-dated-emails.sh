#!/bin/bash

FRUIT=(apple banana cherry damson elderberry fig guava hawthorn ilama jackfruit kumquat lemon mango nectarine olive papaya quince raspberry strawberry tangerine ugli vanilla wolfberry xigua yew ziziphus)
COUNT=20
DICT="/usr/share/dict/words"

WORDS=($(grep "^[a-z]\{6\}$" "$DICT" | shuf | head -n $COUNT))

mkdir -p {cur,new,tmp}

function create_email()
{
	local SECONDS="$1"
	local WORD="$2"
	local TIME="${3:-12:00:00} +0000 (GMT)"

	local DATE TIDY FILE

	DATE=$(date -d "@$SECONDS" "+%a, %d %b %Y")
	TIDY=$(date -d "@$SECONDS" "+%F")
	if [ $((RANDOM%2)) -eq 1 ]; then
		FILE="cur/${SECONDS}.$RANDOM:2,S"
	else
		FILE="new/${SECONDS}.$RANDOM:2"
	fi
	cat > "$FILE" <<-EOF
		From: $WORD <$WORD@flatcap.org>
		To: rich@flatcap.org
		Subject: (date) $TIDY $TIME
		Date: $DATE $TIME

		apple
		banana
		cherry
	EOF
}


for ((i = 2; i < $COUNT; i++)); do
	W=${WORDS[$i]}
	SECONDS=$(date -d "$i days ago" "+%s")

	create_email $SECONDS $W
done

WORDS=($(grep "^[a-z]\{6\}$" "$DICT" | shuf | head -n 48))

for ((i = 1; i < 48; i++)); do
	W=${WORDS[$i]}
	SECONDS=$(date -d "$i hours ago" "+%s")
	TIME=$(date -d "@$SECONDS" "+%H:00:00")

	create_email $SECONDS $W $TIME
done

