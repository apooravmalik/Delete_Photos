#!/bin/bash

# Prompt the user to enter the date range for deletion
read -r -p "Enter the start date (YYYYMMDD) of the photos you want to delete: " START_DATE
read -r -p "Enter the end date (YYYYMMDD) of the photos you want to delete: " END_DATE

# Validate the input
if [[ ! "$START_DATE" =~ ^[0-9]{8}$ ]] || [[ ! "$END_DATE" =~ ^[0-9]{8}$ ]]; then
  echo "Invalid date format. Please enter dates in YYYYMMDD format."
  exit 1
fi

# Confirm with the user
echo "You are about to delete photos from WhatsApp Images folder taken from $START_DATE to $END_DATE."
read -r -p "Are you sure? (y/n): " CONFIRM
if [ "$CONFIRM" != "y" ]; then
  echo "Operation cancelled."
  exit 0
fi

# Print debug information
echo "Debug: Checking ADB connection"
adb devices

# Define the path
ANDROID_PATH="/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/WhatsApp Images"

# Print the path being used
echo "Debug: Using path: $ANDROID_PATH"

# Check if the directory exists
echo "Debug: Checking if directory exists"
adb shell "if [ -d \"$ANDROID_PATH\" ]; then echo 'Directory exists'; else echo 'Directory does not exist'; fi"

# List files in the directory
echo "Debug: Listing files in directory (first 10)"
adb shell "ls -l \"$ANDROID_PATH\" | head -n 10"

# Show file naming pattern
echo "Debug: Showing file naming pattern (first 5 files)"
adb shell "ls \"$ANDROID_PATH\" | head -n 5"

# Use adb to find and count the photos without deleting
echo "Debug: Counting files to be deleted"
COUNT=$(adb shell "
cd \"$ANDROID_PATH\"
for file in IMG-*; do
  DATE=\${file:4:8}
  if [ \"\$DATE\" -ge \"$START_DATE\" ] && [ \"\$DATE\" -le \"$END_DATE\" ]; then
    echo \$file
  fi
done | wc -l
")
echo "Debug: $COUNT files would be deleted"

# Ask for final confirmation
read -r -p "Proceed with deletion? (y/n): " FINAL_CONFIRM
if [ "$FINAL_CONFIRM" != "y" ]; then
  echo "Operation cancelled."
  exit 0
fi

# Use adb to delete the photos
echo "Deleting photos..."
adb shell "
cd \"$ANDROID_PATH\"
for file in IMG-*; do
  DATE=\${file:4:8}
  if [ \"\$DATE\" -ge \"$START_DATE\" ] && [ \"\$DATE\" -le \"$END_DATE\" ]; then
    rm -f \"\$file\"
    echo \"Deleted: \$file\"
  fi
done
"

echo "Operation completed. Please check your device to confirm deletions."

# Verify deletions
echo "Verifying deletions..."
REMAINING=$(adb shell "
cd \"$ANDROID_PATH\"
for file in IMG-*; do
  DATE=\${file:4:8}
  if [ \"\$DATE\" -ge \"$START_DATE\" ] && [ \"\$DATE\" -le \"$END_DATE\" ]; then
    echo \$file
  fi
done | wc -l
")
echo "Remaining files in the specified date range: $REMAINING"

if [ "$REMAINING" -eq 0 ]; then
    echo "All specified files have been successfully deleted."
else
    echo "Some files may not have been deleted. Please check your device."
fi