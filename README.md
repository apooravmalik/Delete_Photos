# Delete_Photos

This script allows users to delete WhatsApp images within a specified date range from their Android device. It's particularly useful for managing storage space and removing old or unwanted images from the WhatsApp Images folder.
I created this because my mother wanted to delete 70000+ images and her tablet would hang while deleting them.

## Features

- Delete WhatsApp images within a specified date range
- Works directly on Android devices using ADB (Android Debug Bridge)
- Provides debugging information and confirmation steps for safety
- Verifies deletions after the operation

## Prerequisites

Before you can use this script, you need to have the following installed on your computer:

1. ADB (Android Debug Bridge)
2. Bash shell (comes pre-installed on macOS and Linux, use Git Bash or WSL on Windows)

## Installation

1. Clone this repository:
   ```
   git clone https://github.com/apooravmalik/Delete_Photos.git
   ```
   or download `delete_photos.sh` directly.

2. Make the script executable:
   ```
   chmod +x delete_photos.sh
   ```

## Usage

1. Connect your Android device to your computer via USB and ensure USB debugging is enabled on your device.

2. Run the script:
   ```
   ./delete_photos.sh
   ```

3. Follow the prompts to enter the start and end dates for the images you want to delete.

4. Confirm the deletion when prompted.

5. Check your device to ensure the correct files were deleted.

## Important Notes

- This script deletes files permanently. Use with caution and ensure you have backups if needed.
- The script assumes WhatsApp images are stored in the directory: `/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/WhatsApp Images`
- Ensure your device is properly connected and recognized by ADB before running the script.

## Components Used

- Bash scripting language
- ADB (Android Debug Bridge) for communication with the Android device
- Basic Unix commands (ls, rm, find, etc.) executed on the Android device through ADB shell

## Contributing

Contributions, issues, and feature requests are welcome. Feel free to check [issues page](https://github.com/apooravmalik/Delete_Photos/issues) if you want to contribute.

## Disclaimer

This script is provided as-is, without any warranties. Always ensure you have backups of important data before running scripts that delete files.
