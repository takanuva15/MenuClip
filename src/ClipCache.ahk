;Manages the stored clips. (Basically an array manager)
class ClipCache {
	static clips := []
	__New() {
		
	}
	
	getAtIndex(index) {
		return this.clips[index]
	}
	
	insertAtTop(clip) {
		this.clips.insertAt(1, clip)
	}
	
	moveToTop(index) {
		tmp := this.clips[index]
		Loop, % loopIndex := index - 1
		{
			this.clips[loopIndex + 1] := this.clips[loopIndex]
		}
		this.clips[1] := tmp
	}
	
	deleteAtIndex(index) {
		this.clips.removeAt(index)
	}
	
	getSize() {
		return this.clips.maxIndex() ? this.clips.maxIndex() : 0
	}
	
	printClips() {
		s := ""
		for index, element in this.clips {
			s := s . element . ", "
		}
		MsgBox %s%
	}
}