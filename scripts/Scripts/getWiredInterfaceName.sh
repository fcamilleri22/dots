#!/usr/bin/env bash
ip link | grep ": en" | cut -d " " -f 2 | sed "s/://"
