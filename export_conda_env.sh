#!/bin/env bash

# Ensure Conda is initialized
if ! command -v conda &> /dev/null; then
    echo "Conda is not installed or not in the PATH. Please install Conda and try again."
    exit 1
fi

# Check if a custom name was provided
if [ -z "$1" ]; then
    echo "Usage: $0 <output_filename_prefix>"
    echo "Example: $0 minimal_v1.3"
    exit 1
fi

# Assign the prefix for the output files
OUTPUT_PREFIX="$1"

# Get the list of all Conda environments
ENV_LIST=$(conda env list | awk '{print $1}' | grep -vE '^(#|base)')

# Always include base environment
ENV_LIST="base $ENV_LIST"

echo "Found Conda environments: $ENV_LIST"

# Activate Conda
source "$(conda info --base)/etc/profile.d/conda.sh"

# Loop through each environment and export it
for ENV in $ENV_LIST; do
    OUTPUT_FILE="${OUTPUT_PREFIX}-${ENV}.yaml"
    
    echo "Exporting environment '$ENV' to $OUTPUT_FILE..."
    mamba env export --name "$ENV" > "$OUTPUT_FILE"

    if [ $? -eq 0 ]; then
        echo "Successfully exported: $OUTPUT_FILE"

        # Modify base environment file
        if [ "$ENV" == "base" ]; then
            echo "Modifying $OUTPUT_FILE for base environment..."
            sed -i "s|prefix: /opt/conda|prefix: /opt/conda/envs/${OUTPUT_PREFIX}-base|" "$OUTPUT_FILE"
            sed -i "s|name: base|name: ${OUTPUT_PREFIX}-base|" "$OUTPUT_FILE"
            echo "Base environment file modified successfully."
        fi
    else
        echo "Failed to export environment: $ENV"
    fi
done

echo "All environments exported successfully!"

