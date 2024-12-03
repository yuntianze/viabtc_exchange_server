#!/bin/bash

# Function to check if matchengine is running
check_process() {
    if pgrep -x "matchengine" > /dev/null; then
        return 0  # Process is running
    else
        return 1  # Process is not running
    fi
}

# Check if matchengine is already running
if check_process; then
    echo "Matchengine is already running."
    exit 0
fi

# Start matchengine
./matchengine config.json &

# Wait for a moment to let the process start
sleep 2

# Check if matchengine started successfully
if check_process; then
    echo "Successfully started matchengine server!"
    exit 0
else
    echo "Failed to start matchengine server. Please check the logs."
    exit 1
fi