;Handles changes to the clips view

class MenuClipsViewHandler {
	static menuGui
	__New(menuGui) {
		this.menuGui := menuGui
	}
	
	populateMenuFromArray(arr) {
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
}