;Handles changes to the menu
class MenuGuiHandler {
	static totalScreenWidth
	static totalScreenHeight
	static guiWidth
	static guiHeight
	__New(menuGui) {
		this.menuGui := menuGui
		hideGuiOnOutsideClickFn := ObjBindMethod(this, "watchMouseClickAndHideGuiOnOutsideClick")
		Hotkey, LButton, % hideGuiOnOutsideClickFn
		Hotkey, LButton, Off
		hideGuiOnEscOrWinFn := ObjBindMethod(this, "hideGuiOnEscOrWin")
		Hotkey, Escape, % hideGuiOnEscOrWinFn
		Hotkey, Escape, Off
		Hotkey, LWin, % hideGuiOnEscOrWinFn
		Hotkey, LWin, Off
		;Hotkey, Tab, % hideGuiOnEscOrWinFn
		;Hotkey, Tab, Off
		
		SysGet, tmp, 78
		this.totalScreenWidth := tmp
		SysGet, tmp, 79
		this.totalScreenHeight := tmp
	}
	
	watchMouseClickAndHideGuiOnOutsideClick() {
		MouseGetPos, , , windowClicked, controlClicked
		Click
		Sleep, 50 ;allows time for Gui to show what was selected
		if(controlClicked = "ListBox1") {
			Gui ClipMenu:Hide
			this.menuGui.onItemClickFn.call(this.getControlValue(this.menuGui.HANDLE_CLIPS_VIEW))
		} else if(windowClicked = this.menuGui.HANDLE_GUI) {
			return
		} else {
			Gui ClipMenu:Hide
		}
		Hotkey, LButton, Off
		Send, {Ctrl up} ;depresses Ctrl if you're using Ctrl in the showMenu shortcut
	}
	
	pasteSelectedOnEnter() {
		Gui ClipMenu:Hide
		this.menuGui.onItemClickFn.call(this.getControlValue(this.menuGui.HANDLE_CLIPS_VIEW))
		Hotkey, LButton, Off
		Send, {Ctrl up}
	}
	
	getControlValue(hWnd) {
		GuiControlGet, tmp,, %hWnd%
		return tmp
	}
	
	hideGuiOnEscOrWin() {
		;WinGet, activeWin, , A
		Gui ClipMenu:Hide
		Hotkey, Escape, Off
		Hotkey, LWin, Off
	}
	
	showGui() {
		;GuiControl, Move, % this.menuGui.HANDLE_CLIPS_VIEW, h200
		GuiControl, Choose, % this.menuGui.HANDLE_CLIPS_VIEW, 1
		Hotkey, LButton, On
		Hotkey, Escape, On
		Hotkey, LWin, On
		
		MouseGetPos, mouseXPos, mouseYPos
		;this.getGuiSize(this.menuGui.HANDLE_GUI, guiWidth, guiHeight)
		dispXPos := % mouseXPos + this.guiWidth > this.totalScreenWidth ? mouseXPos - this.guiWidth : mouseXPos 
		dispYPos := % mouseYPos + this.guiHeight > this.totalScreenHeight ? mouseYPos - this.guiHeight : mouseYPos 
		Gui ClipMenu:Show, AutoSize x%dispXPos% y%dispYPos%
	}
	
	updateGuiDims() {
		this.getGuiSize(this.menuGui.HANDLE_GUI, guiWidth, guiHeight)
		this.guiWidth := guiWidth
		this.guiHeight := guiHeight
	}
	
	;This function came from https://autohotkey.com/board/topic/85172-solved-gui-width-height/. Not under MIT license
	getGuiSize(hwnd, ByRef w, ByRef h) {
		VarSetCapacity(rc, 16)
		DllCall("GetClientRect", "uint", hwnd, "uint", &rc)
		w := NumGet(rc, 8, "int"), h := NumGet(rc, 12, "int")
	}
}