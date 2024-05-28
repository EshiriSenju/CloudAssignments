#!/bin/bash

# Function to display error messages and exit
error_exit() {
    echo "$1" 1>&2
    exit 1
}

# Function to create a log entry
log_entry() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> backup_log.txt
}

# Function to cleanup old backups
cleanup_old_backups() {
    local backup_dir=$1
    local keep_count=$2
    ls -1t "$backup_dir" | tail -n +$((keep_count + 1)) | xargs -I {} rm -rf "$backup_dir/{}"
}

# User input for source and backup directories
read -p "Enter the source directory: " src_dir
read -p "Enter the backup directory: " backup_base_dir

# Check if source directory exists
if [ ! -d "$src_dir" ]; then
    error_exit "Source directory does not exist. Exiting script."
fi

# Create a timestamped backup directory
timestamp=$(date '+%Y%m%d%H%M%S')
backup_dir="$backup_base_dir/backup_$timestamp"
mkdir -p "$backup_dir" || error_exit "Failed to create backup directory."

# Copy contents from source to backup directory
cp -r "$src_dir"/* "$backup_dir" || error_exit "Failed to copy files to backup directory."

# Ask if the user wants to compress the backup directory
read -p "Do you want to compress the backup directory? (y/n): " compress
if [ "$compress" == "y" ]; then
    tar -czf "$backup_dir.tar.gz" -C "$backup_base_dir" "backup_$timestamp" || error_exit "Failed to compress backup directory."
    rm -rf "$backup_dir" # Remove the uncompressed directory after compression
    log_entry "Backup created and compressed: $backup_dir.tar.gz"
else
    log_entry "Backup created: $backup_dir"
fi

# Manage old backups
read -p "Enter the number of recent backups to keep: " keep_count
cleanup_old_backups "$backup_base_dir" "$keep_count"

echo "Backup completed successfully."

# Print log file location
echo "Log file is located at: $(pwd)/backup_log.txt"
