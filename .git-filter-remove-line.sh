#!/bin/bash
# Remove whole lines containing certain text
sed '/\(^listenbrainz-token\b\|^room\(list\)\?|^trusteddomains\b\)/d' "$1"

