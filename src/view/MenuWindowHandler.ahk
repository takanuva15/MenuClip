;Handles changes to the menu
class MenuWindowHandler {
	static menuGui
	static totalScreenWidth
	static totalScreenHeight
	static guiWidth
	static guiHeight
	__New(menuGui) {
		this.menuGui := menuGui
		hideGuiOnOutsideClickFn := ObjBindMethod(this, "watchMouseClickAndHideGuiOnOutsideClick")
		Hotkey, LButton, % hideGuiOnOutsideClickFn
		Hotkey, LButton, Off
		
		CoordMode, Mouse, Screen
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
			this.hideMenuGuiAndPasteSelectedClip()
		} else if(windowClicked = this.menuGui.HANDLE_GUI) {
			return
		} else {
			this.hideMenuGui()
			this.resetGuiState()
		}
	}
	
	hideMenuGuiAndPasteSelectedClip() {
		this.hideMenuGui()
		this.pasteSelectedClip()
		this.resetGuiState()
	}
	
	pasteSelectedClip() {
		this.menuGui.onItemClickFn.call(this.menuGui.clipStore.filteredClips[GetControlValue(this.menuGui.HANDLE_CLIPS_VIEW)].origIndex)
	}
	
	showGui() {
		GuiControl, Focus, % this.menuGui.HANDLE_SEARCH_BOX
		GuiControl, Choose, % this.menuGui.HANDLE_CLIPS_VIEW, 1
		Hotkey, LButton, On
		
		MouseGetPos, mouseXPos, mouseYPos
		dispXPos := % mouseXPos + this.guiWidth > this.totalScreenWidth ? mouseXPos - this.guiWidth : mouseXPos 
		dispYPos := % mouseYPos + this.guiHeight > this.totalScreenHeight ? mouseYPos - this.guiHeight : mouseYPos 
		Gui ClipMenu:Show, AutoSize x%dispXPos% y%dispYPos%
		this.handleKeyPresses()
	}
	
	handleKeyPresses() {
		Input, tmp, V, {Esc}{LWin}{RWin}{AppsKey}{LAlt}{RAlt}{Up}{Down}
		if(InStr(ErrorLevel, "EndKey:")) {
			if(InStr(ErrorLevel, "Up")) {
				GuiControl, Focus, % this.menuGui.HANDLE_CLIPS_VIEW
				Send, {Up}
				GuiControl, Focus, % this.menuGui.HANDLE_SEARCH_BOX
			} else if(InStr(ErrorLevel, "Down")) {
				GuiControl, Focus, % this.menuGui.HANDLE_CLIPS_VIEW
				Send, {Down}
				GuiControl, Focus, % this.menuGui.HANDLE_SEARCH_BOX
			} else {
				this.hideMenuGui()
				return
			}
			this.handleKeyPresses()
		}
	}
	
	hideMenuGui() {
		Gui ClipMenu:Hide
	}
	
	resetGuiState() {
		GuiControl, , % this.menuGui.HANDLE_SEARCH_BOX
		Input
		Hotkey, LButton, Off
		Send, {Ctrl up} ;depresses Ctrl if you're using Ctrl in the showMenu shortcut
	}
	
	updateGuiDims() {
		Gui ClipMenu:Show, Hide ;Renders it once to give it dimensions for the handler to use
		GetGuiSize(this.menuGui.HANDLE_GUI, guiWidth, guiHeight)
		this.guiWidth := guiWidth
		this.guiHeight := guiHeight
	}
}