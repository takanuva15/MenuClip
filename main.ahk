﻿;[MenuClip Clipboard Manager]

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force

global VERSION := "v1.0.0"
global MAX_CLIPS_TO_STORE := 3
global MAX_MENUITEM_LABEL_LENGTH := 50

#Include src\MenuClip.ahk

;Modifies the tooltip in the System tray
Menu, Tray, Tip, MenuClip %VERSION%

clipManager := new MenuClip.ClipManager(MAX_CLIPS_TO_STORE)
clipManager.monitorClipboardChanges()

showMenu := ObjBindMethod(clipManager, "showContextMenu")
Hotkey, CapsLock & f, % showMenu
Hotkey, ^+v, % showMenu

return