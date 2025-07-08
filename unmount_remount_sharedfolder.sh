#!/bin/bash
# unmount_remount_sharedfolder.sh
# Automated shell script for unmounting and remounting a shared folder in your Linux machine connected to a Windows-hosted SMB share, removes the old mount directory (if any) and recreates it
# Ron Penones | July 8th 2025 - Feel free to share and reproduce, the core idea is mine with some assistance of AI. Padayon!

# VARS
MOUNT_DIR="/home/donnadell/Desktop/donnahp"
REMOTE="//192.168.137.97/donnahp"
USERNAME="donna"
PASSWORD="password"

echo ""
echo "=== Windows-hosted SMB share AutoMount Script ==="
echo "Checking if Windows Share is reachable"

# Check Windows-hosted SMB share if responding
ping -c 1 192.168.137.97 > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "Share is responding! Proceeding"

    echo "Deleting old directory if exists"
    sudo rm -rf "$MOUNT_DIR"

    echo "Creating fresh mount folder"
    sudo mkdir -p "$MOUNT_DIR"

    echo "Attempting to mount SMB share"
    sudo mount -t cifs "$REMOTE" "$MOUNT_DIR" -o username=$USERNAME,password=$PASSWORD,vers=3.0

    # Final checking
    if mountpoint -q "$MOUNT_DIR"; then
        echo "Mount successful! Files should now appear in: $MOUNT_DIR"
    else
        echo "Mount failed! Double check your credentials or network."
    fi
else
    echo "Windows-hosted SMB share is unreachable"
    echo "Try again later, please check Windows-hosted SMB share power or network"
fi

echo ""