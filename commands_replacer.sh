#!/bin/bash

# Script to replace hardcoded directories in commands.md
# Usage: ./replace_directory.sh [output_file]

set -e  # Exit on any error

# Fixed values
INPUT_FILE="commands.md"
OUTPUT_FILE="commands_updated.md"
# Get directory one level above current working directory
CODING_DIRECTORY="$(dirname "$(pwd)")"

# Function to show usage
show_usage() {
    echo "Usage: $0 [output_file]"
    echo ""
    echo "This script replaces hardcoded directories in commands.md with \$coding_directory"
    echo ""
    echo "Arguments:"
    echo "  output_file     Output file (default: commands_updated.md)"
    echo ""
    echo "Examples:"
    echo "  $0                    # Use default output file"
    echo "  $0 my_output.md       # Custom output file"
    echo ""
    echo "What gets replaced:"
    echo "  ~/Coding              → $CODING_DIRECTORY"
    echo "  \$HOME/Coding          → $CODING_DIRECTORY"
    echo "  /Users/*/Coding       → $CODING_DIRECTORY"
    echo ""
    echo "Current coding directory: $CODING_DIRECTORY"
}

# Parse command line arguments
case "$1" in
    -h|--help)
        show_usage
        exit 0
        ;;
    "")
        # Use default output file
        ;;
    *)
        OUTPUT_FILE="$1"
        ;;
esac

# Validate input file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: Input file '$INPUT_FILE' not found!"
    echo "Make sure you're running this script in a directory that contains commands.md"
    echo ""
    show_usage
    exit 1
fi

# Create backup of original file
BACKUP_FILE="${INPUT_FILE}.backup.$(date +%Y%m%d_%H%M%S)"
cp "$INPUT_FILE" "$BACKUP_FILE"
echo "Created backup: $BACKUP_FILE"

# Find all hardcoded directory patterns
echo "Analyzing commands.md for hardcoded directories..."
HARDCODED_PATTERNS=$(grep -o -E '(~/Coding|\$HOME/Coding|/Users/[^/]*/Coding)' "$INPUT_FILE" | sort | uniq || true)

if [ -z "$HARDCODED_PATTERNS" ]; then
    echo "No hardcoded directories found in $INPUT_FILE"
    exit 0
fi

echo "Found hardcoded patterns:"
echo "$HARDCODED_PATTERNS"
echo ""
echo "Will replace with: $CODING_DIRECTORY"

# Perform replacements
echo "Replacing hardcoded directories..."

# Use sed to replace the patterns with the actual coding directory path
sed -e "s|~/Coding|$CODING_DIRECTORY|g" \
    -e "s|\$HOME/Coding|$CODING_DIRECTORY|g" \
    -e "s|/Users/[^/]*/Coding|$CODING_DIRECTORY|g" \
    "$INPUT_FILE" > "$OUTPUT_FILE"

# Verify changes were made
CHANGES_COUNT=$(diff "$INPUT_FILE" "$OUTPUT_FILE" | grep -c '^[<>]' || true)

if [ "$CHANGES_COUNT" -gt 0 ]; then
    echo "Successfully replaced directories in $OUTPUT_FILE"
    echo "Changes made: $((CHANGES_COUNT / 2)) locations updated"
    
    # Show a preview of changes
    echo ""
    echo "Preview of changes:"
    echo "==================="
    diff "$INPUT_FILE" "$OUTPUT_FILE" | head -20 || true
    
    # Option to replace original file
    if [ "$INPUT_FILE" != "$OUTPUT_FILE" ]; then
        echo ""
        read -p "Replace original commands.md with updated version? (y/N): " -r
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            mv "$OUTPUT_FILE" "$INPUT_FILE"
            echo "commands.md updated! Backup available at: $BACKUP_FILE"
        else
            echo "Updated file saved as: $OUTPUT_FILE"
            echo "Original commands.md unchanged"
        fi
    fi
else
    echo "No changes were made - no matching patterns found"
    rm "$OUTPUT_FILE"  # Remove empty output file
fi

echo ""
echo "Script completed successfully!"
echo ""
echo "All hardcoded paths have been replaced with: $CODING_DIRECTORY"
