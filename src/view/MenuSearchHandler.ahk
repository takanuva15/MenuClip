;Handles changes to the search box
class MenuSearchHandler {
	static menuGui
	static filteredClips := []
	__New(menuGui) {
		this.menuGui := menuGui
	}
	
	handleSearch() {
		searchStr := GetControlValue(this.menuGui.HANDLE_SEARCH_BOX)
		this.filterClipsByStr(searchStr)
		GuiControl, , % this.menuGui.HANDLE_CLIPS_VIEW, |
		this.menuGui.menuClipsViewHandler.populateMenuFromArray(this.convertFilteredClipsToStrArr())
		GuiControl, Choose, % this.menuGui.HANDLE_CLIPS_VIEW, 1
	}
	
	filterClipsByStr(searchStr) {
		this.filteredClips := []
		for index, element in this.menuGui.clipStore.getClips() {
			if(InStr(element, searchStr)) {
				this.filteredClips.push({"origIndex": index, "clip": element})
			}
		}
	}
	
	convertFilteredClipsToStrArr() {
		filteredClipsTextOnly := []
		for index, element in this.filteredClips {
			filteredClipsTextOnly.push(element.clip)
		}
		return filteredClipsTextOnly
	}
	
	getOrigClipFromFilteredClipByIndex(filteredClipIndex) {
		return this.filteredClips[filteredClipIndex].origIndex
	}
}