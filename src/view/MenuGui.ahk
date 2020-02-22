#Include %A_ScriptDir%\src\view\MenuWindowHandler.ahk
#Include %A_ScriptDir%\src\view\MenuSearchHandler.ahk

;Represents the menu
class MenuGui {
	static clipStore
	static menuWindowHandler
	static HANDLE_CLIPS_VIEW
	static HANDLE_SEARCH_BOX
	static HANDLE_GUI
	__New(configManager, clipStore, onItemClickFn) {
		this.configManager := configManager
		this.clipStore := clipStore
		this.onItemClickFn := onItemClickFn
		this.menuWindowHandler := new MenuClip.View.MenuWindowHandler(this)
		this.menuSearchHandler := new MenuClip.View.MenuSearchHandler(this)
		
		Gui +hWndClipMenu
		Gui ClipMenu:-MinimizeBox -MaximizeBox -Caption +LastFound
		this.HANDLE_GUI := WinExist()
		Gui ClipMenu:Margin, 5, 5
		Gui ClipMenu:Font, % (FontOptions := "s10"), % (FontName := "Segoe UI Regular")
		
		this.themeStyle := this.configManager.getTheme()
		if(this.themeStyle = "dark") {
			Gui ClipMenu:Color, 2B2B2B, 43474A
			Gui ClipMenu:Font, cCCCCCC
		}
		
		this.addClipsView()
		this.addSearchBox()
		this.addInvisibleOKButton()
		CoordMode, Mouse, Screen
		Gui ClipMenu:Show, Hide ;Renders it once to give it dimensions for the handler to use
		this.menuWindowHandler.updateGuiDims()
		
		this.populateMenuFromArray(this.clipStore.getClips())
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
		hideMenuGuiAndPasteSelectedClipFn := ObjBindMethod(this.menuWindowHandler, "hideMenuGuiAndPasteSelectedClip")
		GuiControl +g, %PasteSelected%, % hideMenuGuiAndPasteSelectedClipFn
	}
	
	populateMenuFromArray(arr) {
		GuiControl, -Redraw, % this.HANDLE_CLIPS_VIEW
		Loop, % loopIndex := arr.maxIndex()
			this.insertItemAtTop(arr[loopIndex--])
		GuiControl, +Redraw, % this.HANDLE_CLIPS_VIEW
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
	
	showGui() {
		this.menuWindowHandler.showGui()
	}
}