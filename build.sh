#!/bin/bash

# Define variables
SRC_DIR="src"
CHROME_DIR="$SRC_DIR/chrome"
FIREFOX_DIR="$SRC_DIR/firefox"
DIST_DIR="dist"

# Create the dist directory if it doesn't exist
mkdir -p $DIST_DIR

# Function to extract version number from manifest.json using grep and sed
get_version() {
  local manifest_file=$1
  if [[ -f $manifest_file ]]; then
    grep '"version"' $manifest_file | sed -E 's/.*"version": *"(.*)".*/\1/'
  else
    echo "Manifest file $manifest_file not found."
    exit 1
  fi
}

# Extract version numbers
CHROME_VERSION=$(get_version "$CHROME_DIR/manifest.json")
FIREFOX_VERSION=$(get_version "$FIREFOX_DIR/manifest.json")

# Check if versions were successfully extracted
if [[ -z "$CHROME_VERSION" ]]; then
  echo "Failed to extract Chrome version."
  exit 1
fi

if [[ -z "$FIREFOX_VERSION" ]]; then
  echo "Failed to extract Firefox version."
  exit 1
fi

# Define the extension name
EXT_NAME="WWSIV_Amazon_Tagger"

# Define ZIP file names with extension name, version, and browser
CHROME_ZIP="$DIST_DIR/${EXT_NAME}_v${CHROME_VERSION}_chrome.zip"
FIREFOX_ZIP="$DIST_DIR/${EXT_NAME}_v${FIREFOX_VERSION}_firefox.xpi"

# Function to create a ZIP file for a given directory
create_zip() {
  local dir=$1
  local zip_file=$2
  echo "Creating ZIP file: $zip_file"
  zip -j -r $zip_file $dir
}

# Build the Chrome extension
create_zip $CHROME_DIR $CHROME_ZIP

# Build the Firefox extension
create_zip $FIREFOX_DIR $FIREFOX_ZIP

echo "Build completed."
