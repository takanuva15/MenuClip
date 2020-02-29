;Handles changes to the clips view

class MenuClipsViewHandler {
	static menuGui
	__New(menuGui) {
		this.menuGui := menuGui
	}
	
	populateMenuFromArray(arr) {
		if(this.menuGui.configManager.getConvSpecChar()) {
			prettifiedArr := []
			for index, element in arr {
				prettifiedArr.push(this.prettifyClip(element))
			}
		} else {
			prettifiedArr := arr
		}
		PopulateLBFromArray(this.menuGui.HANDLE_CLIPS_VIEW, prettifiedArr)
	}
	
	insertItemAtTop(item) {
		newItem := this.prettifyClip(item)
		LB_InsertItemAtIndex(this.menuGui.HANDLE_CLIPS_VIEW, newItem, 1)
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