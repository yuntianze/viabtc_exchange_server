#!/bin/bash

# Function to check if matchengine is running
check_process() {
    if pgrep -x "matchengine" > /dev/null; then
        return 0  # Process is running
    else
        return 1  # Process is not running
    fi
}

# Check if matchengine is running
if ! check_process; then
    echo "Matchengine is not running."
    exit 0
fi

# Stop matchengine gracefully using SIGQUIT
killall -s SIGQUIT matchengine

# Wait for a moment to let the process stop
sleep 2

# Check if process has stopped
if ! check_process; then
    echo "Successfully stopped matchengine server!"
    exit 0
else
    echo "Failed to stop matchengine server. You may need to force kill it."
    exit 1
fi