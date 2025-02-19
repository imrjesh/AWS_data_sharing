#!/bin/bash
module load aws
# Script to download contents from an S3 bucket
# Usage: ./download_s3_bucket.sh [destination_directory]

# Set strict mode
#set -euo pipefail

# Configuration
S3_BUCKET="s3://external-nci"
AWS_ACCESS_KEY_ID="######################"
AWS_SECRET_ACCESS_KEY="############################"
AWS_DEFAULT_REGION="us-east-1"  # Change this if your bucket is in a different region

# Log file
LOG_FILE="s3_download_$(date +%Y%m%d_%H%M%S).log"

# Function to log messages
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Check if destination directory is provided
if [ $# -eq 0 ]; then
    log_message "Error: Destination directory not provided."
    log_message "Usage: $0 [destination_directory]"
    exit 1
fi

DESTINATION_DIR="$1"

# Create destination directory if it doesn't exist
mkdir -p "$DESTINATION_DIR"

# Export AWS credentials as environment variables
export AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY
export AWS_DEFAULT_REGION

log_message "Starting download from $S3_BUCKET to $DESTINATION_DIR"

# Perform the sync operation
if aws s3 sync "$S3_BUCKET" "$DESTINATION_DIR"; then    
   log_message "Download completed successfully"
else
    log_message "Error: Download failed"
    exit 1
fi

log_message "Download process finished. Check $DESTINATION_DIR for downloaded files."
