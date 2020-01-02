# MenuClip
MenuClip is a menu-based clipboard manager for Windows written in AutoHotkey.

When you press a hotkey, a small context menu will show up that indicates the last 10 things that were copied to your clipboard. 

### Features:
- Stores all text and filepath (from Explorer) clips into memory
- Displays stored clips in a context menu via Ctrl+Shift+V or CapsLock+F
- Stores up to 8 clips currently. (Afterwards, it will delete the oldest one and insert the newest clip at the top)

## Contributing
I welcome any contributions that fix bugs or provide additional functionality (please format the code cleanly). Please check with me before developing a PR that is out-of-scope of this application (eg a rotating clip-paste function which [ClipJump](https://github.com/aviaryan/Clipjump) already does, or something that assigns presets like [this](https://www.autohotkey.com/boards/viewtopic.php?t=65004) already does). 

In addition, if you are not restricted from downloading & running exe files on your computer, you can download [ClipClip](https://clipclip.com/) for Windows, which is a free, full-fledged clipboard manager that serves the same function as MenuClip but with better functionality. (If you're on a Mac, you can download [ClipMenu](http://www.clipmenu.com/) which has the same essential features)


## Notes
A [similar application](https://autohotkey.com/board/topic/69834-probably-yet-another-clipboard-manager/) was posted on the AutoHotkey forum by [spg SCOTT](https://www.autohotkey.com/boards/memberlist.php?mode=viewprofile&u=66846). It also fulfills the purpose of a context-based clipboard manager. 

You can check out the Trello board for tracking stories on the project [here](https://trello.com/b/wD95pQRR/menuclip-kanban-board). If you have an issue or bug, feel free to post it on GitHub.

You can view a UML diagram of the application [here](https://www.lucidchart.com/documents/view/8b32b807-f1e5-4cb6-afa5-1380075d861b). 

##Credits

Special thanks to the people who've helped me with coding obstacles by answering my questions on the AutoHotkey forums. You can see my various questions and people's responses [here](https://www.autohotkey.com/boards/search.php?author_id=117081&sr=posts)