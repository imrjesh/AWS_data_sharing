#!/bin/bash
#SBATCH --mem=10g 
#SBATCH --time=36:00:00 
#SBATCH --constraint=ibfdr
#SBATCH -o test_upload
#SBATCH -e test_upload

# Load the AWS module
module load aws

## Setting up the Access Key and Secret ID ##
export AWS_ACCESS_KEY_ID=####################
export AWS_SECRET_ACCESS_KEY=###########################
export AWS_DEFAULT_REGION=us-east-1
export AWS_DEFAULT_OUTPUT=json

## Configuring the profile ###
aws configure

## Set S3 parameters
aws configure set s3.max_concurrent_requests 400
aws configure set s3.max_bandwidth 280MB/s

## Specifying the S3 bucket name and local directory
bucket_name="s3:/#####################/"
local_directory="/path to directory where data is stored and which need to be upload"

# Upload entire directory to S3
echo "Uploading directory: ${local_directory}"
aws s3 cp "${local_directory}" "${bucket_name}" --recursive
