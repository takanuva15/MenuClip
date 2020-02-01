# Changelog

### v1.8.1
2020-02-01 Recolored dropdown list in config gui
## v1.8.0
2020-01-31 Added a gui window that opens when you edit config (rather than opening up the ini file directly)
### v1.7.3
2020-01-19 Converted code structure into MVC
### v1.7.2
2020-01-19 Added 1/4 sec delay before adding a clip to the menu, so if an application is rapidly changing the clipboard, only the latest clip will be saved. (Fixes issue when copying text from IntelliJ terminal)
### v1.7.1
2020-01-18 Config file is now generated if it doesn't exist
## v1.7.0
2020-01-18 Clip menu contents are now saved to a cache folder and will be restored on restart
### v1.6.2
2020-01-11 Separated the clips array into its own class
### v1.6.1
2020-01-06 Fixed bug that would show identical copies of the same string if it was copied repeatedly consecutively
## v1.6.0
2020-01-05 Added option to directly modify config from Tray Menu. (Also modified Tray Menu to custom settings)
## v1.5.0
2020-01-05 Added shortcut config option
## v1.4.0
2020-01-05 Added a dark theme config option
## v1.3.0
2020-01-04 Added support for ini files. Now all configurable variables are read from ini.
## v1.2.0
2020-01-04 Added config option to specify which exe processes use Shift+Insert for pasting, and the menu will execute that for those processes
## v1.1.0
2020-01-03 Added easily configurable variables to `main.ahk` to modify menu settings
# v1.0.0
2020-01-01 Refactored menu actions to its own class. Also put in limits to how much of long clips is shown in the menu. Renamed tray tooltip.
2019-12-29 
- Maximum storage size implemented. Currently set to 8 clips.
- Selected menu item now shifts to the top of the menu
2019-12-22 Clipboard manager now stores clips and displays them in a context menu when you press Ctrl+Shift+V or CapsLock+J. Credit to teadrinker in [this post](https://www.autohotkey.com/boards/viewtopic.php?p=306818&sid=fcabbee4a2f810fb8fe9544a7f8fa688#p306818) for developing that code!
2019-12-14 Created a UML diagram
2019-12-08 Repo created. Added a readme and license
