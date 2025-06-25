#!/bin/bash

# Script to recursively rename files from .yml to .yaml extension

# Function to display usage
usage() {
    echo "Usage: $0 [directory_path]"
    echo "If no directory is specified, current directory is used"
    echo "Example: $0 /path/to/search"
    exit 1
}

# Set search directory (current directory if not specified)
SEARCH_DIR="${1:-.}"

# Check if the specified directory exists
if [ ! -d "$SEARCH_DIR" ]; then
    echo "Error: Directory '$SEARCH_DIR' does not exist"
    exit 1
fi

echo "Recursively searching for .yml files in: $SEARCH_DIR"
echo "----------------------------------------"

# Counter for renamed files
count=0

# Find all .yml files and process them
while IFS= read -r -d '' file; do
    # Get directory and filename without extension
    dir=$(dirname "$file")
    basename=$(basename "$file" .yml)
    new_name="$dir/$basename.yaml"
    
    echo "Found: $file"
    
    # Check if target file already exists
    if [ -f "$new_name" ]; then
        echo "  Warning: Target file '$new_name' already exists. Skipping."
        echo "  ----------------------------------------"
        continue
    fi
    
    # Rename the file
    if mv "$file" "$new_name"; then
        echo "  Renamed to: $new_name"
        ((count++))
    else
        echo "  Error: Failed to rename '$file'"
    fi
    
    echo "  ----------------------------------------"
    
done < <(find "$SEARCH_DIR" -type f -name "*.yml" -print0)

echo "Operation completed. Total files renamed: $count"

# If no files were found
if [ $count -eq 0 ]; then
    echo "No .yml files were found."
fi
