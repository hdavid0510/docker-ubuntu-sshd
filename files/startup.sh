#!/bin/bash
# Script runs on docker initialization

# SSH server run
exec /usr/sbin/sshd -D

# Keeps this script running
/bin/bash