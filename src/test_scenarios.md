# Test Scenarios
### This file lists the scenarios that should be tested prior to merging to develop

All scenarios assume:
- MAX_CLIPS_TO_STORE := 2
- MAX_MENUITEM_LABEL_LENGTH := 50

##### Functionality Tests
1. Max limit on stored clips obeyed
If the limit is 2, copying 3 things should cause only the most recent 2 clips to show in the menu

1. Correct clip is pasted on selection
Copy "one", then "two". Paste "two" from the menu. Now paste "one" from the menu.

1. Selected clip shifts to top of menu
If the menu has 2 clips, "one" and "two" (with "one" being at the top of the list), in that order, then clicking "two" should shift it to the top of the menu. The resulting menu order is "two", "one".

##### Visual Tests
1. Menu items only show first 50 characters of clip-to-be-pasted
Copy this: 
---------1---------2---------3---------4---------5---------6
Now show the menu. You should see: ---------1---------2---------3---------4---------5...
And when you paste it, you should see:
---------1---------2---------3---------4---------5---------6

##### Configurations
1. Change the configuration variables in `main.ahk`. The property that each variable defines should adjust accordingly when the script is run.