# Test Scenarios
### This file lists the scenarios that should be tested prior to merging to develop

All scenarios assume:
- MAX_CLIPS_TO_STORE=3
- MAX_MENUITEM_LABEL_LENGTH=50
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
1. Menu items only show first 50 characters of clip-to-be-pasted
Copy this:

---------1---------2---------3---------4---------5---------6

Now show the menu. You should see: 

---------1---------2---------3---------4---------5...

And when you paste it, you should see:

---------1---------2---------3---------4---------5---------6

### Configurations
1. Change the configuration keys in `config.ini`. The property that each variable defines should adjust accordingly when the script is run.