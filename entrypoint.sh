#!/bin/sh
set -e
/update_blocked_hosts.sh
/usr/sbin/crond
/usr/sbin/dnsmasq --keep-in-foreground