#!/bin/bash
# Remove parts of lines
sed -E 's/("enabled":)\w+(,"password":)"\w+"/\1false\2""/g'

