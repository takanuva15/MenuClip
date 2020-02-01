﻿;Handles changes to the menu
class MenuGui {
	static clipStore
	static HANDLE_CLIPS_VIEW
	__New(clipStore, onItemClickFn) {
		this.clipStore := clipStore
		this.onItemClickFn := onItemClickFn
		
		Gui +hWndClipMenu
		Gui ClipMenu:-MinimizeBox -MaximizeBox
		Gui ClipMenu:Margin, 10, 10
		
		this.addClipsView()
		;Gui ClipMenu:Hide
		;tmp2 := this.HANDLE_CLIPS_VIEW
		;SendMessage, (LB_INSERTSTRING:=0x181),0,"Hi",, ahk_id %tmp2%
		;this.showGui()
	}
	
	addClipsView() {
		Gui ClipMenu:Add, ListBox, xm ym r8 w280 hWndClipsView AltSubmit, % this.convertArrayToListBoxString(this.clipStore.getClips())
		this.HANDLE_CLIPS_VIEW := ClipsView
		callOnItemClickWithValueFn := ObjBindMethod(this, "callOnItemClickWithValue")
		GuiControl +g, %ClipsView%, % callOnItemClickWithValueFn
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
	
	convertArrayToListBoxString(arr) {
		str := ""
		for index, element in arr {
			str := str . element . "|"
		}
		return str
	}
	
	callOnItemClickWithValue() {
		Gui ClipMenu:Hide
		this.onItemClickFn.call(this.getConfigOptionValue(this.HANDLE_CLIPS_VIEW))
	}
	
	getConfigOptionValue(hWnd) {
		GuiControlGet, tmp,, %hWnd%
		return tmp
	}
	
	showGui() {
		Gui ClipMenu:Show, w300 h200
	}
}