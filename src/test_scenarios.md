(All scenarios assume MAX_CLIPS set to 2)

###This file lists the scenarios that should be tested prior to merging to develop

1. Max limit on stored clips obeyed
If the limit is 2, copying 3 things should cause only the most recent 2 clips to show in the menu

1. Correct clip is pasted on selection
Copy "one", then "two". Paste "two" from the menu. Now paste "one" from the menu.

1. Selected clip shifts to top of menu
If the menu has 2 clips, "one" and "two", in that order, then clicking "two" should shift it to the top of the menu. The resulting menu order is "two", "one".

1. Menu items only show first 35 characters of clip-to-be-pasted
Copy this: 
---------1---------2---------3---------4
Now show the menu. You should see: ---------1---------2---------3-----...
And when you paste it, you should see:
---------1---------2---------3---------4
