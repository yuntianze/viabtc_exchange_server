#!/bin/bash

# Function to check if marketprice is running
check_process() {
    if pgrep -x "marketprice" > /dev/null; then
        return 0  # Process is running
    else
        return 1  # Process is not running
    fi
}

# Check if marketprice is running
if ! check_process; then
    echo "Marketprice is not running."
    exit 0
fi

# Stop marketprice gracefully using SIGQUIT
killall -s SIGQUIT marketprice

# Wait for a moment to let the process stop
sleep 2

# Check if process has stopped
if ! check_process; then
    echo "Successfully stopped marketprice server!"
    exit 0
else
    echo "Failed to stop marketprice server. You may need to force kill it."
    exit 1
fi
