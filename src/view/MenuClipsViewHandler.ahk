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
		if(this.menuGui.configManager.getConvSpecChar()) {
			item := this.prettifyClip(item)
		}
		LB_InsertItemAtIndex(this.menuGui.HANDLE_CLIPS_VIEW, item, 1)
		;MC-45 bugfix needed for new clips being added
		this.menuGui.menuSearchHandler.filterClipsByStr("")
	}
	
	deleteItemAtIndex(index) {
		LB_DeleteItem(this.menuGui.HANDLE_CLIPS_VIEW, index)
	}
	
	moveToTop(index) {
		this.deleteItemAtIndex(index)
		this.insertItemAtTop(this.clipStore.getAtIndex(1))
	}
	
	pasteSelectedClip() {
		selectedClipIndex := GetControlValue(this.menuGui.HANDLE_CLIPS_VIEW)
		origClipIndex := this.menuGui.menuSearchHandler.getOrigClipFromFilteredClipByIndex(selectedClipIndex)
		this.menuGui.onItemClickFn.call(origClipIndex)
	}
	
	prettifyClip(clip) {
		filteredClip := StrReplace(clip, A_Tab, "[\t]")
		filteredClip := StrReplace(filteredClip, "`r`n", "[\n]")
		filteredClip := StrReplace(filteredClip, "`r", "[\n]")
		filteredClip := StrReplace(filteredClip, "`n", "[\n]")
		return filteredClip
	}
}