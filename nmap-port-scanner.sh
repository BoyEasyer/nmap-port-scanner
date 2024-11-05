#!/bin/bash

# Check if the target IP is provided as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <target IP>"
    exit 1
fi

# Assign the target IP from the argument
TARGET=$1

# Run a full TCP port scan to detect open ports
echo "Running full TCP port scan on $TARGET..."
FULL_TCP_SCAN_OUTPUT=$(nmap -p- $TARGET -T5)

# Extract open TCP ports from the scan output
OPEN_TCP_PORTS=$(echo "$FULL_TCP_SCAN_OUTPUT" | grep '/open' | awk -F/ '{print $1}' | tr '\n' ',' | sed 's/,$//')

# Run a UDP scan on common ports (top 1000 by default)
echo "Running UDP scan on common ports on $TARGET..."
UDP_SCAN_OUTPUT=$(nmap -sU --top-ports 1000 $TARGET -T5)

# Extract open UDP ports from the scan output
OPEN_UDP_PORTS=$(echo "$UDP_SCAN_OUTPUT" | grep '/open' | awk -F/ '{print $1}' | tr '\n' ',' | sed 's/,$//')

# Display the results for TCP and UDP open ports
if [ -n "$OPEN_TCP_PORTS" ]; then
    echo "Open TCP ports found: $OPEN_TCP_PORTS"
else
    echo "No open TCP ports found on $TARGET."
fi

if [ -n "$OPEN_UDP_PORTS" ]; then
    echo "Open UDP ports found: $OPEN_UDP_PORTS"
else
    echo "No open UDP ports found on $TARGET."
fi

# Run a detailed scan with service and script detection on the open TCP ports (if any)
if [ -n "$OPEN_TCP_PORTS" ]; then
    echo "Running version and script scan on open TCP ports..."
    nmap -p $OPEN_TCP_PORTS -sV -sC $TARGET -T5
fi

# Run a detailed scan with service detection on the open UDP ports (if any)
if [ -n "$OPEN_UDP_PORTS" ]; then
    echo "Running version scan on open UDP ports..."
    nmap -sU -p $OPEN_UDP_PORTS -sV $TARGET -T5
fi
