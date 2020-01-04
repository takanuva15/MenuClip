;Primary clipboard manager class. Should only be one instance for the duration of the script
class ClipManager {
	static CLIP_TYPE_TEXT := 1
	static MAX_CLIPS_TO_STORE
	static ALT_PASTE_APPS
	__New(configManager, maxMenuItemLabelLength) {
		this.MAX_CLIPS_TO_STORE := configManager.getMaxClipsToStore()
		this.ALT_PASTE_APPS := configManager.getAltPasteApps()
		this.saveClipFn := ObjBindMethod(this, "saveClip")
		this.menuManager := new MenuClip.MenuManager(ObjBindMethod(this, "pasteClip"),maxMenuItemLabelLength)
	}
	
	monitorClipboardChanges() {
		OnClipboardChange(this.saveClipFn)
	}
	
	saveClip(clipType) {
		if (clipType = this.CLIP_TYPE_TEXT) {
			if(this.menuManager.getMenuItemCount() < this.MAX_CLIPS_TO_STORE) {
				this.menuManager.insertItemAtTop(Clipboard)
			} else {
				this.menuManager.deleteItem(this.MAX_CLIPS_TO_STORE)
				this.menuManager.insertItemAtTop(Clipboard)
			}
		}
	}
	
	pasteClip(textToPaste) {
		OnClipboardChange(this.saveClipFn, 0)
		Clipboard := textToPaste
		WinGet, activeWin, ProcessName, A
		if(InStr(this.ALT_PASTE_APPS, activeWin)) {
			Send, +{Insert}
		} else {
			Send, ^v
		}
		this.menuManager.moveLastSelectedItemToTop()
		OnClipboardChange(this.saveClipFn)
	}
	
	showContextMenu() {
		this.menuManager.showMenu()
	}
	
	__Delete() {
		OnClipboardChange(this.saveClipFn, 0)
	}
}

