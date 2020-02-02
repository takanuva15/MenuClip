;Handles changes to the menu
class MenuGuiHandler {
	__New(menuGui) {
		this.menuGui := menuGui
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
		if(windowClicked = this.GUI_WINDOW_ID) {
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
}