#!/bin/bash
echo "Start cron"
cron
echo "cron started"

# Run forever
tail -f /dev/null