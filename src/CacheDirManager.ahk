;Manages the cache directory which holds file backups for what's on the clip menu
class CacheDirManager {
	static cacheDir := "cache\"
	static cachedClipFileNames := []
	__New() {
		if(!InStr(FileExist(this.cacheDir), "D")) {
			FileCreateDir, cache
		}
	}
	
	;returns array of what was restored from cache
	restoreFromCache() {
		Loop, Files, % this.cacheDir . "*.txt"
			this.cachedClipFileNames.push(A_LoopFileName)
		
		tmp := []
		Loop, % index := this.cachedClipFileNames.maxIndex()
		{
			FileRead, clip, % this.cacheDir . this.cachedClipFileNames[index--]
			tmp.insertAt(1, clip)
		}
		return tmp
	}
	
	insertAtTopOfCache(clip) {
		Loop, % index := this.cachedClipFileNames.length()
		{
			fileName := this.cachedClipFileNames[index]
			RegExMatch(fileName, "^(?P<Num>\d+)\.", file)
			FileMove, % this.cacheDir . fileName, % this.cacheDir . fileNum + 1 . ".txt"
			this.cachedClipFileNames[fileNum + 1] := fileNum + 1 . ".txt"
			index--
		}
		this.cachedClipFileNames.removeAt(1)		
		FileAppend, %clip%, % this.cacheDir . "1.txt"
		this.cachedClipFileNames.insertAt(1, "1.txt")
	}
	
	moveToTopOfCache(index) {
		tmp := this.cachedClipFileNames[index]
		FileMove, % this.cacheDir . tmp, % this.cacheDir . tmp . ".tmp"
		Loop, % loopIndex := index - 1
		{
			fileName := this.cachedClipFileNames[loopIndex--]
			RegExMatch(fileName, "^(?P<Num>\d+)\.", file)
			FileMove, % this.cacheDir . fileName, % this.cacheDir . fileNum + 1 . ".txt"
			this.cachedClipFileNames[fileNum + 1] := fileNum + 1 . ".txt"
		}
		FileMove, % this.cacheDir . tmp . ".tmp", % this.cacheDir . "1.txt"
	}
	
	deleteFromCache(index) {
		;Works as of now because we only ever delete the last element in ClipManager. However, should be a loop available to rename files below this in the cache if we theoretically deleted from the middle of the menu.
		FileDelete, % this.cacheDir this.cachedClipFileNames[index]
		this.cachedClipFileNames.removeAt(index)
	}
}