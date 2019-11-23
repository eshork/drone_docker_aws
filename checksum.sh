#!/bin/sh
cat $@ | md5sum | awk '{print $1}'
