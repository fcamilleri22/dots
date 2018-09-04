#!/usr/bin/env bash
ip link | grep ": wl" | cut -d " " -f 2 | sed "s/://"
