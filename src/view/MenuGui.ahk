;Handles changes to the menu
class MenuGui {
	static clipStore
	static HANDLE_CLIPS_VIEW
	static GUI_WINDOW_ID
	__New(configManager, clipStore, onItemClickFn) {
		this.configManager := configManager
		this.clipStore := clipStore
		this.onItemClickFn := onItemClickFn
		hideGuiOnOutsideClickFn := ObjBindMethod(this, "watchMouseClickAndHideGuiOnOutsideClick")
		Hotkey, LButton, % hideGuiOnOutsideClickFn
		Hotkey, LButton, Off
		
		Gui +hWndClipMenu
		Gui ClipMenu:-MinimizeBox -MaximizeBox -Caption +LastFound
		this.GUI_WINDOW_ID := WinExist()
		Gui ClipMenu:Margin, 5, 5
		Gui ClipMenu:Font, % (FontOptions := "s10"), % (FontName := "Segoe UI Regular")
		
		this.themeStyle := this.configManager.getTheme()
		if(this.themeStyle = "dark") {
			Gui ClipMenu:Color, 2B2B2B, 43474A
			Gui ClipMenu:Font, cCCCCCC
		}
		
		this.addClipsView()
		this.populateMenuFromArray(this.clipStore.getClips())
		CoordMode, Mouse, Screen
		;this.showGui()
	}
	
	addClipsView() {
		LBS_NOINTEGRALHEIGHT := 0x0100
		Gui ClipMenu:Add, ListBox, xm ym w350 r10 hWndClipsView AltSubmit +0x0100
		this.HANDLE_CLIPS_VIEW := ClipsView
		callOnItemClickWithValueFn := ObjBindMethod(this, "callOnItemClickWithValue")
		GuiControl +g, %ClipsView%, % callOnItemClickWithValueFn
		LB_AdjustItemHeight(ClipsView, 5)
	}
	
	moveToTop(index) {
		this.deleteItemAtIndex(index)
		this.insertItemAtTop(this.clipStore.getAtIndex(1))
	}
	
	insertItemAtTop(item) {
		SendMessage, (LB_INSERTSTRING:=0x181), 0, &item,, % "ahk_id " . this.HANDLE_CLIPS_VIEW
	}
	
	deleteItemAtIndex(index) {
		SendMessage, (LB_DELETESTRING:=0x182), % index - 1, 0,, % "ahk_id " . this.HANDLE_CLIPS_VIEW
	}
	
	populateMenuFromArray(arr) {
		GuiControl, -Redraw, % this.HANDLE_CLIPS_VIEW
		Loop, % loopIndex := arr.maxIndex()
			this.insertItemAtTop(arr[loopIndex--])
		GuiControl, +Redraw, % this.HANDLE_CLIPS_VIEW
	}
	
	callOnItemClickWithValue() {
		Gui ClipMenu:Hide
		this.onItemClickFn.call(this.getControlValue(this.HANDLE_CLIPS_VIEW))
	}
	
	getControlValue(hWnd) {
		GuiControlGet, tmp,, %hWnd%
		return tmp
	}
	
	showGui() {
		Hotkey, LButton, On
		MouseGetPos, mouseXPos, mouseYPos
		Gui ClipMenu:Show, x%mouseXPos% y%mouseYPos%
		;Gui ClipMenu:Show, xCenter yCenter w310 h205
	}
	
	watchMouseClickAndHideGuiOnOutsideClick() {
		MouseGetPos, , , windowClicked
		if(windowClicked != this.GUI_WINDOW_ID) {
			Gui ClipMenu:Hide
		}
		Click
		Hotkey, LButton, Off
		Send, {Ctrl up} ;depresses Ctrl if you're using Ctrl in the showMenu shortcut
	}
}