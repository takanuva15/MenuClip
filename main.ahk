;[MenuClip Clipboard Manager]

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force

VERSION := "v1.5.0"

#Include src\MenuClip.ahk

;Modifies the tooltip in the System tray
trayManager := new MenuClip.TrayManager()
trayManager.configureTrayTooltip(VERSION)
trayManager.configureTrayOptions()

CONFIG_FILE_NAME := "config.ini"
configManager := new MenuClip.ConfigManager(CONFIG_FILE_NAME)

clipManager := new MenuClip.ClipManager(configManager)
clipManager.monitorClipboardChanges()

showMenu := ObjBindMethod(clipManager, "showContextMenu")
Hotkey, % configManager.getShowMenuHotkey(), % showMenu

return