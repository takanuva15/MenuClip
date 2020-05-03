# MenuClip
MenuClip is a menu-based clipboard manager written by takanuva15 in AutoHotkey. (Tested on Windows 10 with AHK v1.1.32.00)

When you press a hotkey, a small context menu will show up that indicates the last x things that were copied to your clipboard. 

#### _This project is in maintenance mode. No new features will be added; bugs may be fixed depending on bug severity and as time permits. (Please check the issue tracker to see if your bug was already raised)_

### Demo:
<img src="https://github.com/takanuva15/MenuClip/blob/master/resources/menuclip_demo_final.gif" width="400px" title="MenuClip functionality demo" alt="MenuClip functionality demo gif"/>

Dark theme:

<img src="https://github.com/takanuva15/MenuClip/blob/master/resources/menuclip_demo_dark_theme.jpg" title="MenuClip dark theme screenshot" alt="MenuClip dark theme screenshot"/>

### Features:
- Stores text clips into memory (doesn't support images or files)
- Displays stored clips in a context menu via `Ctrl+Shift+V`
- Stores 100 clips by default. (Afterwards, it will delete the oldest one and insert the newest clip at the top)
- Has configurable options (eg shortcut, number of clips to store, gui size)
- Can specify editors that use Shift+Insert for pasting instead of Ctrl+V
- Has a dark theme option (can be automatically swapped in at a specified time)
- Saves clips to file so that they are restored when the script is restarted
- Has a search box to filter clips list

## How to Run

1. Download a zip file of the latest [release](https://github.com/takanuva15/MenuClip/releases).
1. Extract it to a directory named "MenuClip" wherever you store your scripts.
1. Double click on `main.ahk` to run it.

## Configuring the Script
The configuration can be edited by right-clicking on MenuClip's system tray icon and selecting the `Edit Configuration` option. (Alternatively, you can directly edit the `config.ini` file, which is generated when you run the script for the first time.)
Note:
- When changing the shortcut to open the menu, you must use the AHK shortcut syntax (see [here](https://www.autohotkey.com/docs/Hotkeys.htm#Symbols) for a glossary). Example: To use `CapsLock` + `f` as the hotkey, you should write `CapsLock & f` for the hotkey config option.
- To add a certain editor to the "Shift+Insert pasting" list, add its exe filename to the Shift Ins paste list. (You must comma-separate each exe. eg: `mintty.exe,runemacs.exe` Do not use newlines.)

## Contributing
Please open up an issue if you see a bug. Depending on the situation, you can also make PRs, but check with me before starting work on a PR, especially if it is out-of-scope of this application. (eg a rotating clip-paste function which [ClipJump](https://github.com/aviaryan/Clipjump) already does, or something that assigns presets like [this](https://www.autohotkey.com/boards/viewtopic.php?t=65004) already does). 

In addition, if you are not restricted from downloading & running exe files on your computer, you should just download [Ditto](https://ditto-cp.sourceforge.io/) which does the same thing with orders of magnitude more functionality. You can also download [ClipClip](https://clipclip.com/) for Windows. (If you're on a Mac, you can download [ClipMenu](http://www.clipmenu.com/) which has the same essential features)

Random: I tried my best to structure the code OO-style.

## Notes
A [similar application](https://autohotkey.com/board/topic/69834-probably-yet-another-clipboard-manager/) was posted on the AutoHotkey forum by [spg SCOTT](https://www.autohotkey.com/boards/memberlist.php?mode=viewprofile&u=66846). It also fulfills the purpose of a context-based clipboard manager. 

You can check out the Trello board for tracking stories on the project [here](https://trello.com/b/wD95pQRR/menuclip-kanban-board). If you have an issue or bug, feel free to post it on GitHub.

You can view a UML diagram of the application [here](https://www.lucidchart.com/documents/view/8b32b807-f1e5-4cb6-afa5-1380075d861b). (Note: UML will occasionally be out-of-date)

## Credits
This program was developed in [AHK Studio](https://www.autohotkey.com/boards/viewtopic.php?t=300).

Special thanks to the people who've helped me with coding obstacles by answering my questions on the AutoHotkey forums. You can see my various questions and people's responses [here](https://www.autohotkey.com/boards/search.php?author_id=117081&sr=posts).

I used the following libraries for this script:
+ [`Class_CtlColors.ahk`](https://www.autohotkey.com/boards/viewtopic.php?t=2197)
+ [`Class_ImageButton.ahk`](https://www.autohotkey.com/boards/viewtopic.php?t=1103)
+ Misc listbox functions combined together in `Class_LB_Functions.ahk`. Please see the comments within the file for relevant links.
+ Misc gui functions combined together in `Gui_Functions.ahk`. Please see the comments within the file for relevant links. 

Please note that library files may not be covered under the MIT license. If such is the case, a comment will be placed at the top of the library file indicating its status.