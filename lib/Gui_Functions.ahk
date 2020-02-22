GetControlValue(hWnd) {
	GuiControlGet, tmp,, %hWnd%
	return tmp
}

;This function came from https://autohotkey.com/board/topic/85172-solved-gui-width-height/. Not under MIT license
GetGuiSize(hwnd, ByRef w, ByRef h) {
	VarSetCapacity(rc, 16)
	DllCall("GetClientRect", "uint", hwnd, "uint", &rc)
	w := NumGet(rc, 8, "int"), h := NumGet(rc, 12, "int")
}