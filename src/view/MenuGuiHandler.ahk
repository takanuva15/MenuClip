;Handles changes to the menu
class MenuGuiHandler {
	static totalScreenWidth
	static totalScreenHeight
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
		
		SysGet, tmp, 78
		this.totalScreenWidth := tmp
		SysGet, tmp, 79
		this.totalScreenHeight := tmp
	}
	
	populateMenuFromArray(arr) {
		GuiControl, -Redraw, % this.menuGui.HANDLE_CLIPS_VIEW
		Loop, % loopIndex := arr.maxIndex()
			this.menuGui.insertItemAtTop(arr[loopIndex--])
		GuiControl, +Redraw, % this.menuGui.HANDLE_CLIPS_VIEW
	}
	
	watchMouseClickAndHideGuiOnOutsideClick() {
		MouseGetPos, , , windowClicked
		Click
		Gui ClipMenu:Hide
		if(windowClicked = this.HANDLE_GUI) {
			this.menuGui.onItemClickFn.call(this.getControlValue(this.menuGui.HANDLE_CLIPS_VIEW))
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
		this.getGuiSize(this.menuGui.HANDLE_GUI, guiWidth, guiHeight)
		dispXPos := % mouseXPos + guiWidth > this.totalScreenWidth ? mouseXPos - guiWidth : mouseXPos 
		dispYPos := % mouseYPos + guiHeight > this.totalScreenHeight ? mouseYPos - guiHeight : mouseYPos 
		Gui ClipMenu:Show, AutoSize x%dispXPos% y%dispYPos%
	}
	
	;This fucntion came from https://autohotkey.com/board/topic/85172-solved-gui-width-height/. Not under MIT license
	getGuiSize(hwnd, ByRef w, ByRef h) {
		VarSetCapacity(rc, 16)
		DllCall("GetClientRect", "uint", hwnd, "uint", &rc)
		w := NumGet(rc, 8, "int"), h := NumGet(rc, 12, "int")
	}
}