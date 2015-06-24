#!/bin/bash
# Utility script to run the docker image with the appropriate arguments.
# This is meant to be run from a directory in which the RPM structure exists,
# i.e. at least a SPECS directory, and optionally SOURCES.

## Configure these as needed
MOCK_CONFIG=epel-7-x86_64
IMAGENAME=zzamboni/mockrpmbuilder
##

SPEC=$1

docker run -i -t -e MOCK_CONFIG=$MOCK_CONFIG -e SOURCES=SOURCES  -e SPEC_FILE=$SPEC  -v $(pwd):/rpmbuild --privileged=true $IMAGENAME
