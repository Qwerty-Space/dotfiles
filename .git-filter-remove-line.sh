#!/bin/bash
# Remove whole lines containing certain text
sed -E '/^(listenbrainz-token|room(list)?|trusteddomains)\b/d'

