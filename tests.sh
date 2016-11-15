#! /bin/bash

DIR=$(pwd)

source $DIR/tests/functions

echo "  xxx " | trim
echo "$DIR"

sh $DIR/tests/authenticate_test.sh
sh $DIR/tests/applications_test.sh
sh $DIR/tests/assets_test.sh
