#!/bin/bash

# Script to clean up older log messages in /var/log/clear_cache.log
LOG_FILE="/var/log/clear_cache.log"
MAX_LINES=10

# Function to log messages
log_message() {
    local message="$1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $message"
}

# Check if the log file exists
if [ ! -f "$LOG_FILE" ]; then
    log_message "Log file $LOG_FILE does not exist. Nothing to clean up."
    exit 0
fi

# Get the current line count of the log file
current_lines=$(wc -l < "$LOG_FILE")

# If the log file has more than MAX_LINES, truncate it to the last MAX_LINES lines
if [ "$current_lines" -gt "$MAX_LINES" ]; then
    # Backup the original file (optional, remove if unnecessary)
    cp "$LOG_FILE" "$LOG_FILE.bak"

    # Retain only the last MAX_LINES messages
    tail -n "$MAX_LINES" "$LOG_FILE" > "${LOG_FILE}.tmp"
    mv "${LOG_FILE}.tmp" "$LOG_FILE"

    log_message "Log file cleaned. Retained the most recent $MAX_LINES lines."
else
    log_message "Log file has $current_lines lines, no cleanup needed."
fi

exit 0
