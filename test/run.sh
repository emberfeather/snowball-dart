#!/bin/bash

# bail on error
set -e

# Note: test.dart needs to be run from the root of the Dart checkout
DIR=$( cd $( dirname "${BASH_SOURCE[0]}" ) && pwd )

# Note: dart_analyzer needs to be run from the root directory for proper path
# canonicalization.
pushd $DIR/..

echo "=== Running unit tests for snowball."

dartanalyzer --fatal-warnings --fatal-type-errors lib/*.dart || echo "ignore analyzer errors"
popd

dart --enable-type-checks --enable-asserts test/all_test.dart $@
