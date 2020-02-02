# Test Scenarios
### This file lists the scenarios that should be tested prior to merging to develop

All scenarios assume:
- MAX_CLIPS_TO_STORE=3
- ALTERNATE_PASTE_APPS=mintty.exe

### Functionality Tests
1. Max limit on stored clips obeyed
Copy "four", "three", "two", "one", in that order. The menu should show "one", "two", "three", in that order.

1. Correct clip is pasted on selection
From previous, paste "one". Now, paste "two".

1. Selected clip shifts to top of menu
From previous, menu should show "two", "one", "three"

1. Pasting is correct in editors that use Shift+Insert for paste
Open up git bash. Paste "three" into it.

1. No repeated copies
Copy "five" multiple times. There should only be one entry of it at the top of the menu.

### Storage Tests
1. Clip order is preserved
 * Make sure cache is empty & restart the script. Copy "four", "three", "two", "one", in that order. The cache folder should show "1.txt", "2.txt", "3.txt", in that order, with file contents "one", "two", "three", respectively.
 * Paste "two" from the menu. The cache folder should show the same file names, but now the file contents should be "two", "one", "three", respectively.
 
2. Cache contents restored on script start
Exit the script and then run it. The menu should show "two", "one", "three", in that order. Paste "one". Check that the cache shows "1.txt", "2.txt", "3.txt" with file contents matching "one", "two", "three", respectively.

### Visual Tests
1. Try to open up the paste window with your mouse at the bottom-right of the screen. The window should not render off-screen.

### Configurations
1. Delete the config file. Restart the script and the config file should appear with default values.

2. Change the configuration keys in `config.ini`. The property that each variable defines should adjust accordingly when the script is restarted.

3. Change the configurations through the GUI that appears when selecting "Edit Configuration" from the System Tray icon's menu. Saving changes on the GUI should change it in the config.ini.

### Bugfix Tests
1. Open up Terminal in IntelliJ (download it if you don't have it). Try highlighting a word in command prompt; then open the menu. There should only be one entry with the word you highlighted.