# Test Scenarios
### This file lists the scenarios that should be tested prior to merging to develop

All scenarios assume:
- MAX_CLIPS_TO_STORE=3
- ALT_PASTE_APPS=mintty.exe

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

#### Gui-related functionality

1. Open the menu. Use the arrow keys to select a paste option and press "enter" to paste it.

1. Type some letters into the search filter. Then use the arrow keys to move the highlighted selection around. Both should work interchangeably. 

1. Filter the entries by a few letters. Click on an entry and paste it.

1. Filter the entries by a few letters. Use the arrow keys to select an entry and hit "enter" to paste.

1. Ensure the search box is cleared each time you open the gui

### Storage Tests
1. Clip order is preserved
 * Make sure cache is empty & restart the script. Copy "four", "three", "two", "one", in that order. The cache folder should show "1.txt", "2.txt", "3.txt", in that order, with file contents "one", "two", "three", respectively.
 * Paste "two" from the menu. The cache folder should show the same file names, but now the file contents should be "two", "one", "three", respectively.
 
1. Cache contents restored on script start
Exit the script and then run it. The menu should show "two", "one", "three", in that order. Paste "one". Check that the cache shows "1.txt", "2.txt", "3.txt" with file contents matching "one", "two", "three", respectively.

### Visual Tests
1. Try to open up the paste window with your mouse at the bottom-right of the screen. The window should not render off-screen.

1. Paste a clip. There should be no fade animation. Now click outside of the clips view window. The box should fade away.

### Config File
1. Delete the config file. Restart the script and the config file should appear with default values.

1. Change the configuration keys in `config.ini`. The property that each variable defines should adjust accordingly when the script is restarted.

1. Do the previous especially for the auto theme config. Test different times and different hours, and swap them around for weird situations

### Tray Menu Options
1. Change the configurations through the GUI that appears when selecting "Edit Configuration" from the System Tray icon's menu. Saving changes on the GUI should change it in the config.ini.

1. While the script is running, change the 1st text file in the cache and save. Then click "reload script" in the tray. The 1st entry in the clip menu should reflect the change made in the file.

1. With items in the clip menu, click the "clear cache & reload" option in the tray. Then open up the menu again and it should be empty. Check the cache dir to make sure it is also empty.

### Bugfix Tests
1. Open up Terminal in IntelliJ (download it if you don't have it). Try highlighting a word in command prompt; then open the menu. There should only be one entry with the word you highlighted.

1. Open up the menu and click outside of it. The menu should close and you should be able to click-drag random text.

1. Open up the menu and type in a random search term. Exit the gui using the Escape key. Reopen the menu. There should be no search term there