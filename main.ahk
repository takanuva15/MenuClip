;[MenuClip Clipboard Manager]

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force

VERSION := "v1.9.1"

#Include <Class_OD_Colors>
#Include <Class_LB_AdjustHeight>
#Include src\MenuClip.ahk

configManager := new MenuClip.Controller.ConfigManager(VERSION)
configManager.readAllConfigOptionsFromFile()

trayManager := new MenuClip.Controller.TrayManager(configManager)
trayManager.configureTrayTooltip()
trayManager.configureTrayOptions()

clipManager := new MenuClip.Controller.ClipManager(configManager)
clipManager.monitorClipboardChanges()

showMenu := ObjBindMethod(clipManager, "showContextMenu")
Hotkey, % configManager.getShowMenuHotkey(), % showMenu

return