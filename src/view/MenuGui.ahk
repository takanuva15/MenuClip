#Include %A_ScriptDir%\src\view\MenuWindowHandler.ahk
#Include %A_ScriptDir%\src\view\MenuClipsViewHandler.ahk
#Include %A_ScriptDir%\src\view\MenuSearchHandler.ahk

;Represents the menu gui
class MenuGui {
	static clipStore
	static menuWindowHandler
	static menuClipsViewHandler
	static menuSearchHandler
	static HANDLE_CLIPS_VIEW
	static HANDLE_SEARCH_BOX
	static HANDLE_GUI
	__New(configManager, clipStore, onItemClickFn) {
		this.configManager := configManager
		this.clipStore := clipStore
		this.onItemClickFn := onItemClickFn
		this.menuWindowHandler := new MenuClip.View.MenuWindowHandler(this)
		this.menuClipsViewHandler := new MenuClip.View.MenuClipsViewHandler(this)
		this.menuSearchHandler := new MenuClip.View.MenuSearchHandler(this)
		
		Gui +hWndClipMenu
		Gui ClipMenu:-MinimizeBox -MaximizeBox -Caption +LastFound AlwaysOnTop
		this.HANDLE_GUI := WinExist()
		Gui ClipMenu:Margin, 5, 5
		Gui ClipMenu:Font, % (FontOptions := "s10")
		
		this.themeStyle := this.configManager.getTheme()
		if(this.themeStyle = "dark") {
			Gui ClipMenu:Color, 2B2B2B, 43474A
			Gui ClipMenu:Font, cDDDDDD
		}
		
		this.addClipsView()
		this.addSearchBox()
		this.addInvisibleOKButton()
		this.menuWindowHandler.updateGuiDims()
		this.menuSearchHandler.handleSearch() ;called once to prefill the filtered menu
	}
	
	addClipsView() {
		LBS_NOINTEGRALHEIGHT := 0x0100
		Gui ClipMenu:Add, ListBox, % "xm ym w" . this.configManager.getMaxWidth() . " r" . this.configManager.getMaxHeight() . " hWndClipsView AltSubmit +0x0100"
		this.HANDLE_CLIPS_VIEW := ClipsView
		LB_AdjustItemHeight(ClipsView, 5)
	}
	
	addSearchBox() {
		Gui ClipMenu:Add, Edit, % "xm y+5 w" . this.configManager.getMaxWidth() . " hWndSearchBox"
		this.HANDLE_SEARCH_BOX := SearchBox
		handleSearchFn := ObjBindMethod(this.menuSearchHandler, "handleSearch")
		GuiControl +g, %SearchBox%, % handleSearchFn
	}
	
	;handles user pressing Enter on the menu
	addInvisibleOKButton() {
		Gui ClipMenu:Add, Button, h0 w0 hWndPasteSelected +Default
		this.HANDLE_BUTTON_PASTE := PasteSelected
		pasteOnEnterFn := ObjBindMethod(this, "pasteOnEnter")
		GuiControl +g, %PasteSelected%, % pasteOnEnterFn
	}
	
	pasteOnEnter() {
		this.menuWindowHandler.hideMenuGui()
		this.menuClipsViewHandler.pasteSelectedClip()
		this.menuWindowHandler.resetGuiState()
	}
	
	showGui() {
		this.menuWindowHandler.showGui()
	}
	
	recolorGui(themeStyle) {
		if(themeStyle = "light") {
			Gui ClipMenu:Color, Default, Default
			GuiControl, +cBlack, % this.HANDLE_CLIPS_VIEW
			GuiControl, +cBlack, % this.HANDLE_SEARCH_BOX
		} else {
			Gui ClipMenu:Color, 2B2B2B, 43474A
			GuiControl, +cDDDDDD, % this.HANDLE_CLIPS_VIEW
			GuiControl, +cDDDDDD, % this.HANDLE_SEARCH_BOX
		}
	}
	
	;if gui is open when theme change occurs, theme will swap immediately
	;once user closes gui, then we reload so that config gui reflects the
	;theme change as well
	initReloadOnMenuQuit() {
		if(WinExist("ahk_id " this.HANDLE_GUI)) {
			this.menuWindowHandler.reloadOnHide := True
		} else {
			Reload
		}
	}
}