#!/bin/bash
# Remove lines containing listenbrainz-token
grep -v 'listenbrainz-token' "$1"

