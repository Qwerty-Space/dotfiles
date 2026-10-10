#!/bin/bash
# Remove lines containing listenbrainz-token
sed '/^listenbrainz-token\b/d' "$1"
sed '/^room\(list\)\? =/d' "$1"
sed '/^trusteddomains\b/d' "$1"
sed 's/"password":"\w\+"//g' "$1"

