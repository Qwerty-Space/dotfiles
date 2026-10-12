#!/bin/bash
# Remove parts of lines
sed -E 's/("enabled":)false(,"password":)"\w+"/\1false\2""/g'

