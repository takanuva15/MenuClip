;Handles changes to the clips view

class MenuClipsViewHandler {
	static menuGui
	__New(menuGui) {
		this.menuGui := menuGui
	}
	
	populateMenuFromArray(arr) {
		;filteredClipsTextOnly := []
		;for index, element in arr {
			;filteredClipsTextOnly.push(this.prettifyClip(element.clip))
		;}
		PopulateLBFromArray(this.menuGui.HANDLE_CLIPS_VIEW, arr)
	}
	
	insertItemAtTop(item) {
		LB_InsertItemAtIndex(this.menuGui.HANDLE_CLIPS_VIEW, item, 1)
	}
	
	deleteItemAtIndex(index) {
		LB_DeleteItem(this.menuGui.HANDLE_CLIPS_VIEW, index)
	}
	
	moveToTop(index) {
		this.deleteItemAtIndex(index)
		this.insertItemAtTop(this.clipStore.getAtIndex(1))
	}
	
	pasteSelectedClip() {
		this.menuGui.onItemClickFn.call(this.menuGui.menuSearchHandler.getOrigClipFromFilteredClipByIndex(GetControlValue(this.menuGui.HANDLE_CLIPS_VIEW)))
	}
	
	prettifyClip(clip) {
		filteredClip := StrReplace(clip, A_Tab, "[\t]")
		filteredClip := StrReplace(filteredClip, "`r`n", "[\n]")
		filteredClip := StrReplace(filteredClip, "`r", "[\n]")
		filteredClip := StrReplace(filteredClip, "`n", "[\n]")
		return filteredClip
	}
}