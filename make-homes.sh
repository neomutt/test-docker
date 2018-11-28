#!/bin/bash

mkdir -p homefs
pushd homefs

for i in beltrano cicrano fulano; do
	mkdir -p $i
	pushd $i
	../../generate-dated-emails.sh
	popd
done
popd
