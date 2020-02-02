;;License note by takanuva15: The 2 functions below this line is derived from a post by "SKAN" at (https://autohotkey.com/board/topic/33383-change-1-line-in-listbox-using-guicontrol/) and is NOT under the MIT license provided in the root directory of this repository.
LB_InsertItemAtIndex(HListBox, item, index) {
	static LB_INSERTSTRING := 0x181
	SendMessage, %LB_INSERTSTRING%, % index - 1, &item, , ahk_id %HListBox%
	Return ErrorLevel
}

LB_DeleteItem(HListBox, index) {
	static LB_DELETESTRING := 0x182
	SendMessage, %LB_DELETESTRING%, % index - 1, 0, , ahk_id %HListBox%
	Return ErrorLevel
}

;;License note by takanuva15: The code below this line is authored by "Just Me" (https://autohotkey.com/board/topic/89793-set-height-of-listbox-rows/#entry568445) and is NOT under the MIT license provided in the root directory of this repository. Please see the code comments for information on its license.
LB_AdjustItemHeight(HListBox, Adjust) {
   Return LB_SetItemHeight(HListBox, LB_GetItemHeight(HListBox) + Adjust)
}

LB_GetItemHeight(HListBox) {
   Static LB_GETITEMHEIGHT := 0x01A1
   SendMessage, %LB_GETITEMHEIGHT%, 0, 0, , ahk_id %HListBox%
   Return ErrorLevel
}

LB_SetItemHeight(HListBox, NewHeight) {
   Static LB_SETITEMHEIGHT := 0x01A0
   SendMessage, %LB_SETITEMHEIGHT%, 0, %NewHeight%, , ahk_id %HListBox%
   WinSet, Redraw, , ahk_id %HListBox%
   Return ErrorLevel
}