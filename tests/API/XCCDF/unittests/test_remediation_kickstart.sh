#!/usr/bin/env bash
. $builddir/tests/test_common.sh

set -e -o pipefail

kickstart=$(mktemp)
stderr=$(mktemp)

$OSCAP xccdf generate fix --fix-type kickstart --output "$kickstart" --result-id xccdf_org.open-scap_testresult_xccdf_org.ssgproject.content_profile_ospp "$srcdir/test_remediation_kickstart.ds.xml" 2> "$stderr" || ret=$?

[ $ret = 1 ]
grep -q "It isn't possible to generate results-oriented Kickstarts." $stderr

rm -rf "$kickstart"
rm -rf "$stderr"


kickstart=$(mktemp)
stderr=$(mktemp)

$OSCAP xccdf generate fix --fix-type kickstart --output "$kickstart" --profile common "$srcdir/test_remediation_kickstart.ds.xml"

grep -q "# Kickstart for Common hardening profile" "$kickstart"

rm -rf "$kickstart"
rm -rf "$stderr"
