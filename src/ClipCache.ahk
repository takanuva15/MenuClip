;Manages the stored clips. (Basically an array manager)
class ClipCache {
	static clips := []
	__New() {
		
	}
	
	write() {
		MsgBox, Hi
	}
	
	getAtIndex(index) {
		return this.clips[index]
	}
	
	insertAtTop(clip) {
		this.clips.insertAt(1, clip)
	}
	
	deleteAtIndex(index) {
		this.clips.removeAt(index)
	}
	
	getSize() {
		return this.clips.maxIndex()
	}
	
	printClips() {
		s := ""
		for index, element in this.clips {
			s := s . element . " ,"
		}
		MsgBox %s%
	}
}