#!/bin/bash

# Script to clean up buffer/cache memory

# Function to log messages
log_message() {
    local message="$1"
    local log_file="/var/log/clear_cache.log"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $message" >> "$log_file"
}

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root."
    log_message "Failed attempt to run script without root privileges."
    exit 1
fi

# Clear pagecache, dentries, and inodes
echo "Clearing buffer/cache memory..."
sync && echo 3 > /proc/sys/vm/drop_caches

# Log the operation
log_message "Buffer/cache memory cleared successfully."

# Notify the user
echo "Buffer/cache memory cleared successfully. Check the log file at /var/log/clear_cache.log for details."

