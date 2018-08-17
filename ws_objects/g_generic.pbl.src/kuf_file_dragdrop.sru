$PBExportHeader$kuf_file_dragdrop.sru
forward
global type kuf_file_dragdrop from nonvisualobject
end type
end forward

global type kuf_file_dragdrop from nonvisualobject
event ue_dropmails pbm_custom01
end type
global kuf_file_dragdrop kuf_file_dragdrop

type prototypes
//
subroutine DragAcceptFiles(long l_hWnd,boolean fAccept) library "shell32.dll"
subroutine DragFinish(long hDrop) library "shell32.dll"
function int DragQueryFileW(long hDrop,int iFile,ref string szFileName,int cb) library "shell32.dll"

Function boolean OpenClipboard (long hWndNewOwner) Library "user32.dll"
Function boolean EmptyClipboard () Library "user32.dll"
Function boolean CloseClipboard () Library "user32.dll"
Function ulong SetClipboardData (uint uFormat,	ulong hMem) Library "user32.dll"
Function boolean IsClipboardFormatAvailable (long wFormat) Library "user32.dll"
FUNCTION ulong GetClipboardData(ulong uFormat) Library "user32.dll"

FUNCTION ulong GlobalLock(ulong hMem) Library "kernel32.dll"
FUNCTION ulong GlobalSize(ulong hMem) Library "kernel32.dll"
FUNCTION boolean GlobalUnlock(ulong hMem) Library "kernel32.dll"
SUBROUTINE ReadClipboardData(ref blob Destination, ulong Source, ulong Length) Library "KERNEL32.DLL" Alias for "RtlMoveMemory"

// Drag and Drop of Mail Messages
FUNCTION ulong RegisterDropTarget( ulong aul_Wnd ) LIBRARY "dddll.dll"
FUNCTION ulong RegisterDropTargetEx( ulong aul_Source, uint ui_Msg, ulong aul_Target ) LIBRARY "dddll.dll"
FUNCTION ulong RegisterDropTargetEx2( ulong aul_Source, uint ui_Msg, ulong aul_Target, string sDestination ) LIBRARY "dddll.dll" ALIAS FOR "RegisterDropTargetEx2;Ansi"
FUNCTION ulong RevokeDragDrop( ulong aul_Wnd ) LIBRARY "ole32.dll"

// File Stuff
Function long FindFirstFileW (string filename, ref st_finddata findfiledata) library "KERNEL32.DLL"
Function boolean FindNextFileW (long handle, ref st_finddata findfiledata) library "KERNEL32.DLL"
Function boolean FindClose (long handle) library "KERNEL32.DLL"
end prototypes

type variables
//
constant int kki_tipo_drag_dragdrop = 1 // attivo con il trascinamento dei file
constant int kki_tipo_drag_incolla = 2   // attivo con il ctrl+v

private long ki_handle //handle dell'oggetto dell'evento passato in u_get_file  (Windows Explorer)

//--- x il copia-incolla 
// Predefined Clipboard Formats
Private constant uint CF_TEXT = 1
Private constant uint CF_BITMAP = 2
Private constant uint CF_METAFILEPICT = 3
Private constant uint CF_SYLK = 4
Private constant uint CF_DIF = 5
Private constant uint CF_TIFF = 6
Private constant uint CF_OEMTEXT = 7
Private constant uint CF_DIB = 8
Private constant uint CF_PALETTE = 9
Private constant uint CF_PENDATA = 10
Private constant uint CF_RIFF = 11
Private constant uint CF_WAVE = 12
Private constant uint CF_UNICODETEXT = 13
Private constant uint CF_ENHMETAFILE = 14
Private constant uint CF_HDROP = 15
Private constant uint CF_LOCALE = 16
Private constant uint CF_MAX = 17


end variables

forward prototypes
public subroutine u_attiva (long a_handle_object)
public subroutine u_disattiva (long a_handle_object)
public subroutine u_dragdropstop ()
private function integer u_get_file_droppati (long a_handle, ref string a_out_file[])
public function integer u_get_file (integer a_k_tipo_drag, long a_handle, ref string a_out_file[])
public function long u_get_pastefile (long a_handlew, ref string a_out_file[])
public function integer u_get_outlookdroppato (unsignedlong lul_hcbd, string a_out_file[])
end prototypes

event ue_dropmails;// Called when Messages are dropped
string			ls_Message, ls_Files, ls_Header
string			ls_Pre, ls_Dir
st_finddata	lst_FindData
integer		li_Pos
long			ll_Handle

IF wparam = 111 THEN
	ls_Message = String( lparam, "address" )

	li_Pos = Pos( ls_Message, "~r~n" )
	IF li_Pos > 0 THEN
		ls_Header = Mid( ls_Message, li_Pos + 2 )
		ls_Message = Left( ls_Message, li_Pos - 1 )
		
		ls_Header = "~r~nHeader:~r~n" + ls_Header
	END IF
	
	ls_Pre = Left( ls_Message, LastPos( ls_Message, "." ) - 1)
	ls_Dir = Left( ls_Message, LastPos( ls_Message, "\" ) - 1)
	
	// Check whether there are attachments available
	ll_Handle = FindFirstFileW(ls_Pre + "*.*", lst_FindData)
	If ll_Handle <= 0 Then Return -1
	Do
		ls_Files = ls_Files + "~r~n" + lst_FindData.ch_filename
	Loop Until Not  FindNextFileW(ll_Handle, lst_FindData)
	FindClose(ll_Handle)

	MessageBox( "Message dropped" , "Files located in " + ls_Dir + "~r~nFiles:" + ls_Files + ls_Header)
END IF


end event

public subroutine u_attiva (long a_handle_object);//
//--- Attiva l'ascolto dell'evento di Drag&Drop per l'oggetto inficato con il rifer. (handle)
//--- 
//
DragAcceptFiles(a_handle_object, true)

//--- x email da outlook
//RegisterDropTargetEx2(a_handle_object, 1024, a_handle_object, kguo_path.get_temp( ) )


end subroutine

public subroutine u_disattiva (long a_handle_object);//
//--- Disabilita l'ascolto dell'evento di Drag&Drop 
//--- 
//
DragAcceptFiles(a_handle_object, true)

//--- Cleanup ascolto email outlook
RevokeDragDrop(a_handle_object)

end subroutine

public subroutine u_dragdropstop ();//
//--- chiude l'evento con il rif. all'oggetto doppato (W.Explorer)
//
DragFinish(ki_handle)

end subroutine

private function integer u_get_file_droppati (long a_handle, ref string a_out_file[]);//
//--- Torna array con i file del drag&drop
//--- inp: handle del d&d
//--- out: array stringa dei file
//--- rit: numero dei file del d&d
//
int k_return = 0
integer	li_i, li_numFiles, li_rc
string 	ls_File


ki_handle = a_handle

ls_File = Space(1024)

// first call gets number of files dragged
// unicode API call
li_numFiles = DragQueryFileW(a_handle, 4294967295, ls_File, 1023)
// ansi API call
//li_numFiles = DragQueryFileA(handle, 4294967295, ls_File, 1023) 

FOR li_i = 0 To li_numFiles - 1
//	ls_File = Space(1024)
	// subsequent calls get file names from dragged object
	li_rc = DragQueryFileW( a_handle, li_i, ls_File, 1023 )
	// add file to listbox
//	lb_1.AddItem(ls_File)
	a_out_file[li_i+1] = ls_File
NEXT 

k_return = li_numFiles

return k_return 
end function

public function integer u_get_file (integer a_k_tipo_drag, long a_handle, ref string a_out_file[]);//
//--- Torna array con i file del drag&drop
//--- inp: handle del d&d
//--- out: array stringa dei file
//--- rit: numero dei file del d&d
//
int k_return = 0

if a_k_tipo_drag = kki_tipo_drag_dragdrop then
//--- acchiappa i file del drag&drp 
	k_return = u_get_file_droppati(a_handle, a_out_file[])

	u_dragdropstop( )   // ferma il d&d
else
	if a_k_tipo_drag = kki_tipo_drag_incolla then
//--- copia+incolla		
		k_return = u_get_pastefile(a_handle, a_out_file[])
	end if
end if

return k_return 
end function

public function long u_get_pastefile (long a_handlew, ref string a_out_file[]);//
//--- Recupera i nomi dei file per l'operazione CTRL-V (incolla)
//--- Input: handle della windows su cui è stato fatto il ctrl-v
//--- Out: arry con i nomi dei file
//--- Rit.: nr di file trovati
//
Long k_return=0
Long hDrop  

hDrop = GetClipboardData(CF_TEXT) //  (49161) // sono da outlook?
if hDrop > 0 then
	u_get_outlookdroppato(hDrop, a_out_file[])   // OUTLOOK
else
	
// Insure desired format is there, and open clipboard.
	If IsClipboardFormatAvailable(CF_HDROP) Then
		If OpenClipboard(a_handleW) Then

// Get handle to Dropped Filelist data, and number of files.
			hDrop = GetClipboardData(CF_HDROP)  // sono file?
			
//--- acchiappa i file del drag&drp 
			if not isnull(hDrop) then
				k_return = u_get_file_droppati(hDrop, a_out_file[])
			end if
// Clean up
		CloseClipboard()
		End If
	End If
end if


return k_return 

end function

public function integer u_get_outlookdroppato (unsignedlong lul_hcbd, string a_out_file[]);//--- Torna array con i file del drag&drop
//--- inp: handle dal  GetClipboardData
//--- out: array stringa dei file
//--- rit: numero dei file del d&d
//
int k_return = 0
integer	li_i, li_numFiles, li_rc
string 	ls_File
ulong lul_data, lul_data_size=0 
blob lblb_data
integer li_FileNum
//kuf_utility kuf1_utility


// Lock the global memory object and get a pointer to the first byte of the object's memory block
lul_data = GlobalLock(lul_hcbd)
if not ISNULL(lul_data) then
	// Get the exact size in bytes of the global memory object
	lul_data_size = GlobalSize(lul_hcbd)
end if
if lul_data_size <= 0 then
	GlobalUnlock(lul_hcbd)
else
	// Pre-allocate the necessary buffer
	lblb_data = blob(space(lul_data_size), EncodingAnsi!)
	// Now copy the entire contents of the global memory object to a blob variable
	ReadClipboardData(lblb_data, lul_data, lul_data_size)
	// Finally, unlock the global memory object ASAP
	GlobalUnlock(lul_hcbd)

//--- crea il nome file ed eventualmente la cartella se non esiste
	ls_File = Space(1024)
	ls_File = kguo_path.get_temp( ) + kkg.path_sep + "memo" + kkg.path_sep
//	kuf1_utility = create kuf_utility
	kguo_path.u_drectory_create(ls_File)
	ls_File += "memo.eml"

// Save the blob to a file (error checking is not implemented here!)
	li_FileNum = FileOpen(ls_File, StreamMode!, Write!, LockReadWrite!,Replace!)
	if li_FileNum <> -1 then
		FileWriteEx(li_FileNum, lblb_data)
		FileClose(li_FileNum)
		a_out_file[1] = ls_File
	end if	

	k_return = 1

end if

return k_return 
end function

on kuf_file_dragdrop.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_file_dragdrop.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

