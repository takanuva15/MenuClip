;[MenuClip Clipboard Manager]

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force

VERSION := "v1.14.1"

#Include <Class_CtlColors>
#Include <Class_LB_AdjustHeight>
#Include <Class_ImageButton>
#Include <Gui_Functions>
#Include src\MenuClip.ahk

configManager := new MenuClip.Controller.ConfigManager(VERSION)

clipManager := new MenuClip.Controller.ClipManager(configManager)

trayManager := new MenuClip.Controller.TrayManager(configManager, clipManager)
trayManager.configureTrayTooltip()
trayManager.configureTrayOptions()

clipManager.monitorClipboardChanges()

showMenu := ObjBindMethod(clipManager, "showContextMenu")
Hotkey, % configManager.getShowMenuHotkey(), % showMenu

return