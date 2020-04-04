;Primary clipboard manager class. Should only be one instance for the duration of the script
class ClipManager {
	static CLIP_TYPE_TEXT := 1
	static clipStore
	static MAX_CLIPS_TO_STORE
	static ALT_PASTE_APPS
	static lastSavedClipType
	__New() {
		this.configManager := new MenuClip.Config.ConfigManager(this)
		this.MAX_CLIPS_TO_STORE := this.configManager.getMaxClipsToStore()
		this.ALT_PASTE_APPS := this.configManager.getAltPasteApps()
		this.clipStore := new MenuClip.Model.ClipStore(this.configManager)
		this.postNewClipFn := ObjBindMethod(this, "postNewClip")
		this.saveClipFn := ObjBindMethod(this, "saveClip")
		
		this.menuGui := new MenuClip.View.MenuGui(this.configManager, this.clipStore, ObjBindMethod(this, "pasteClip"))
	}
	
	monitorClipboardChanges() {
		OnClipboardChange(this.postNewClipFn)
	}
	
	postNewClip(clipType) {
		this.lastSavedClipType := clipType
		saveClipFn := this.saveClipFn
		SetTimer, % saveClipFn, -250
	}
	
	saveClip() {
		clipType := this.lastSavedClipType
		if (clipType = this.CLIP_TYPE_TEXT) {
			;avoid recording consecutive identical copies
			if(Clipboard = this.clipStore.getAtIndex(1)) {
				return
			} else if(this.clipStore.getSize() < this.MAX_CLIPS_TO_STORE) {
				this.clipStore.insertAtTop(Clipboard)
				this.menuGui.menuClipsViewHandler.insertItemAtTop(Clipboard)
			} else {
				this.clipStore.deleteAtIndex(this.MAX_CLIPS_TO_STORE)
				this.menuGui.menuClipsViewHandler.deleteItemAtIndex(this.MAX_CLIPS_TO_STORE)
				this.clipStore.insertAtTop(Clipboard)
				this.menuGui.menuClipsViewHandler.insertItemAtTop(Clipboard)
			}
		}
	}
	
	pasteClip(posClicked) {
		OnClipboardChange(this.postNewClipFn, 0)
		Clipboard := this.clipStore.getAtIndex(posClicked)
		WinGet, activeWin, ProcessName, A
		if(InStr(this.ALT_PASTE_APPS, activeWin)) {
			Send, +{Insert}
		} else {
			Send, ^v
		}
		this.clipStore.moveToTop(posClicked)
		this.menuGui.menuClipsViewHandler.moveToTop(posClicked)
		OnClipboardChange(this.postNewClipFn)
	}
	
	showContextMenu() {
		this.menuGui.showGui()
	}
	
	__Delete() {
		OnClipboardChange(this.saveClipFn, 0)
	}
}

