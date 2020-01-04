;[MenuClip Clipboard Manager]

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force

VERSION := "v1.2.0"
MAX_CLIPS_TO_STORE := 15
MAX_MENUITEM_LABEL_LENGTH := 50
ALT_PASTE_APPS := ""

#Include src\MenuClip.ahk

;Modifies the tooltip in the System tray
Menu, Tray, Tip, MenuClip %VERSION%

CONFIG_FILE_NAME := "config.ini"
configManager := new MenuClip.ConfigManager(CONFIG_FILE_NAME)

clipManager := new MenuClip.ClipManager(configManager,  MAX_MENUITEM_LABEL_LENGTH, ALT_PASTE_APPS)
clipManager.monitorClipboardChanges()

showMenu := ObjBindMethod(clipManager, "showContextMenu")
Hotkey, ^+v, % showMenu

return