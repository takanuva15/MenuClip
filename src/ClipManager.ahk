;Primary clipboard manager class. Should only be one instance for the duration of the script
class ClipManager {
	static CLIP_TYPE_TEXT := 1
	static clipCache := new MenuClip.ClipCache()
	static MAX_CLIPS_TO_STORE
	static ALT_PASTE_APPS
	__New(configManager) {
		this.MAX_CLIPS_TO_STORE := configManager.getMaxClipsToStore()
		this.ALT_PASTE_APPS := configManager.getAltPasteApps()
		this.saveClipFn := ObjBindMethod(this, "saveClip")
		this.menuManager := new MenuClip.MenuManager(configManager,  ObjBindMethod(this, "pasteClip"))
	}
	
	monitorClipboardChanges() {
		OnClipboardChange(this.saveClipFn)
	}
	
	saveClip(clipType) {
		if (clipType = this.CLIP_TYPE_TEXT) {
			;avoid recording consecutive identical copies
			if(Clipboard = this.clipCache.getAtIndex(1)) {
				return
			} else if(this.clipCache.getSize() < this.MAX_CLIPS_TO_STORE) {
				this.clipCache.insertAtTop(Clipboard)
				this.menuManager.insertItemAtTop(Clipboard)
			} else {
				this.clipCache.deleteAtIndex(this.MAX_CLIPS_TO_STORE)
				this.menuManager.deleteItem(this.MAX_CLIPS_TO_STORE)
				this.clipCache.insertAtTop(Clipboard)
				this.menuManager.insertItemAtTop(Clipboard)
			}
		}
	}
	
	pasteClip(posClicked) {
		OnClipboardChange(this.saveClipFn, 0)
		Clipboard := this.clipCache.getAtIndex(posClicked)
		WinGet, activeWin, ProcessName, A
		if(InStr(this.ALT_PASTE_APPS, activeWin)) {
			Send, +{Insert}
		} else {
			Send, ^v
		}
		this.clipCache.moveToTop(posClicked)
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

