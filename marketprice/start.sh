#!/bin/bash

# Function to check if marketprice is running
check_process() {
    if pgrep -x "marketprice" > /dev/null; then
        return 0  # Process is running
    else
        return 1  # Process is not running
    fi
}

# Check if marketprice is already running
if check_process; then
    echo "Marketprice is already running."
    exit 0
fi

# Start marketprice
./marketprice config.json &

# Wait for a moment to let the process start
sleep 2

# Check if marketprice started successfully
if check_process; then
    echo "Successfully started marketprice server!"
    exit 0
else
    echo "Failed to start marketprice server. Please check the logs."
    exit 1
fi
