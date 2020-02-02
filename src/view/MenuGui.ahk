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
		this.addInvisibleOKButton()
		this.populateMenuFromArray(this.clipStore.getClips())
		CoordMode, Mouse, Screen
		;this.showGui()
	}
	
	addClipsView() {
		LBS_NOINTEGRALHEIGHT := 0x0100
		Gui ClipMenu:Add, ListBox, xm ym w350 r11 hWndClipsView AltSubmit +0x0100
		this.HANDLE_CLIPS_VIEW := ClipsView
		LB_AdjustItemHeight(ClipsView, 5)
	}
	
	;handles user pressing Enter on the menu
	addInvisibleOKButton() {
		Gui ClipMenu:Add, Button, h0 w0 hWndPasteSelected +Default
		this.HANDLE_BUTTON_PASTE := PasteSelected
		pasteSelectedFn := ObjBindMethod(this, "pasteSelectedOnEnter")
		GuiControl +g, %PasteSelected%, % pasteSelectedFn
	}
	
	moveToTop(index) {
		this.deleteItemAtIndex(index)
		this.insertItemAtTop(this.clipStore.getAtIndex(1))
	}
	
	insertItemAtTop(item) {
		LB_InsertItemAtIndex(this.HANDLE_CLIPS_VIEW, item, 1)
	}
	
	deleteItemAtIndex(index) {
		LB_DeleteItem(this.HANDLE_CLIPS_VIEW, index)
	}
	
	populateMenuFromArray(arr) {
		GuiControl, -Redraw, % this.HANDLE_CLIPS_VIEW
		Loop, % loopIndex := arr.maxIndex()
			this.insertItemAtTop(arr[loopIndex--])
		GuiControl, +Redraw, % this.HANDLE_CLIPS_VIEW
	}
	
	getControlValue(hWnd) {
		GuiControlGet, tmp,, %hWnd%
		return tmp
	}
	
	showGui() {
		GuiControl, Choose, % this.HANDLE_CLIPS_VIEW, 1
		Hotkey, LButton, On
		MouseGetPos, mouseXPos, mouseYPos
		Gui ClipMenu:Show, x%mouseXPos% y%mouseYPos%
	}
	
	watchMouseClickAndHideGuiOnOutsideClick() {
		MouseGetPos, , , windowClicked
		Click
		Gui ClipMenu:Hide
		if(windowClicked = this.GUI_WINDOW_ID) {
			this.onItemClickFn.call(this.getControlValue(this.HANDLE_CLIPS_VIEW))
		}
		Hotkey, LButton, Off
		Send, {Ctrl up} ;depresses Ctrl if you're using Ctrl in the showMenu shortcut
	}
	
	pasteSelectedOnEnter() {
		Gui ClipMenu:Hide
		this.onItemClickFn.call(this.getControlValue(this.HANDLE_CLIPS_VIEW))
		Hotkey, LButton, Off
		Send, {Ctrl up}
	}
}