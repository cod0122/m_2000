$PBExportHeader$kuf_file_explorer.sru
forward
global type kuf_file_explorer from nonvisualobject
end type
end forward

global type kuf_file_explorer from nonvisualobject
end type
global kuf_file_explorer kuf_file_explorer

type prototypes
//
//Declaring the Win32 file manipulation API functions
//function long FindFirstFile (ref string sPathName, ref st_file_explorer_win32_find_data fd) LIBRARY "KERNEL32.DLL" alias for "FindFirstFileA"
//function long FindNextFile (long lFileHandle, ref st_file_explorer_win32_find_data fd) LIBRARY "KERNEL32.DLL" alias for "FindNextFileA"
FUNCTION ulong FindFirstFile(ref string lpszSearchFile, ref st_file_explorer_win32_find_data lpffd)  LIBRARY "kernel32.dll" ALIAS FOR "FindFirstFileA;Ansi"
FUNCTION boolean FindNextFile(ulong hfindfile, ref st_file_explorer_win32_find_data lpffd)  LIBRARY "kernel32.dll" ALIAS FOR "FindNextFileA;Ansi"

//--- per aprire un file con l'applicazione di default (come il doppio click)  
FUNCTION long ShellExecuteEx(REF st_file_explorer_shellexecute lpExecInfo) LIBRARY "shell32.dll" ALIAS FOR "ShellExecuteExA;Ansi"
//--- per aprire un file con l'applicazione di default (come il doppio click) forse un po' più veloce
FUNCTION long ShellExecuteW (long hwnd, string lpOperation, string lpFile, string lpParameters,  string lpDirectory, integer nShowCmd ) LIBRARY "shell32.dll"

//--- del directoty
//FUNCTION boolean RemoveDirectoryA( ref string path ) LIBRARY "KERNEL32.DLL" 
end prototypes

type variables
//
// MAX_PATH constant for file operations
Private constant long MAX_PATH = 260

public string ki_ds_dirlist = "ds_dirlist"

public constant string k_dirlist_tipo_folder = 'c'
public constant string k_dirlist_tipo_hidden = 'n'
public constant string k_dirlist_tipo_file = 'f'

end variables

forward prototypes
public function boolean of_execute (readonly string as_file, readonly string as_extension)
public function boolean of_execute (string k_file)
public function datastore dirlist (string path)
public function boolean of_print (string a_file, string a_printer)
public function boolean of_email (string a_address, string a_cc, string a_subject, string a_body, string a_attachement)
public subroutine of_removedirectory (string a_folder)
public function integer u_filemove (string a_src, string a_dst, boolean a_replace)
public function boolean u_directory_create (string k_path)
end prototypes

public function boolean of_execute (readonly string as_file, readonly string as_extension);//
//--- Lancia l'esecuzione con il file ed estensione passati
//

CONSTANT long SEE_MASK_CLASSNAME = 1
CONSTANT long SW_NORMAL = 1

string ls_class
long ll_ret
st_file_explorer_shellexecute  lnvos_shellexecuteinfo
Inet l_Inet

IF lower(as_extension) = "htm" OR lower(as_extension) = "html" THEN
   // Open html file with HyperlinkToURL
   // So, a new browser is launched
   // (with the code using ShellExecuteEx, it is not sure)
   GetContextService("Internet", l_Inet)
   ll_ret = l_Inet.HyperlinkToURL(as_file)
   IF ll_ret = 1 THEN
      RETURN true
   END IF
   RETURN false
END IF

// Search for the classname associated with extension
RegistryGet("HKEY_CLASSES_ROOT\." + as_extension, "", ls_class)
IF isNull(ls_class) OR trim(ls_class) = "" THEN
   // The class is not found, try with .txt (why not ?)
   RegistryGet("HKEY_CLASSES_ROOT\.txt", "", ls_class)
END IF

IF isNull(ls_class) OR Trim(ls_class) = "" THEN
   // No class : error
   RETURN false
END IF

lnvos_shellexecuteinfo.cbsize = 60
lnvos_shellexecuteinfo.fMask = SEE_MASK_CLASSNAME  // Use classname
lnvos_shellexecuteinfo.hwnd = 0
lnvos_shellexecuteinfo.lpVerb = "open"
lnvos_shellexecuteinfo.lpfile = as_file
lnvos_shellexecuteinfo.lpClass = ls_class
lnvos_shellexecuteinfo.nShow = SW_NORMAL

ll_ret = ShellExecuteEx(lnvos_shellexecuteinfo)
IF ll_ret = 0 THEN
   // Error
   RETURN false
END IF

RETURN true

end function

public function boolean of_execute (string k_file);
//
string ls_Null
long   ll_rc

integer SW_SHOWNORMAL = 1




SetNull(ls_Null)

//ll_rc = ShellExecuteW ( handle( this ), "Open", k_file, ls_Null, ls_Null, SW_SHOWNORMAL)
ll_rc = ShellExecuteW ( handle( this ), ls_Null, k_file, ls_Null, ls_Null, SW_SHOWNORMAL)

//--- i ritorni
//SE_ERR_FNF              2       // file not found
//SE_ERR_PNF              3       // path not found
//SE_ERR_ACCESSDENIED     5       // access denied
//SE_ERR_OOM              8       // out of memory
//SE_ERR_DLLNOTFOUND      32
//SE_ERR_SHARE            26
//SE_ERR_ASSOCINCOMPLETE  27
//SE_ERR_DDETIMEOUT       28
//SE_ERR_DDEFAIL          29
//SE_ERR_DDEBUSY          30
//SE_ERR_NOASSOC          31

if ll_rc <= 32 or isnull(ll_rc) then
	return false
else
	return true
end if

end function

public function datastore dirlist (string path);//
//--- Torna un datastore con l'elenco dei file
//--- Inp: cartella con l'estensioni dei file da cercare es: c:\pippo\pluto\*.*
//--- Out: lista dei file
//
long lul_handle
st_file_explorer_win32_find_data str_find
boolean lb_fin
long k_riga
datastore kds_dirlist

kds_dirlist = create datastore
kds_dirlist.dataobject = ki_ds_dirlist

str_find.filename=space(MAX_PATH)
str_find.altfilename=space(14)
lul_handle = FindFirstFile(path, str_find)

if lul_handle > 0 then
	do
	
		if len(trim(str_find.filename)) > 0 then   // nome file maggiore di zero caratteri
	
			if left(trim(str_find.filename), 1) <> "."  then  //non puo' iniziare con un punto
				k_riga = kds_dirlist.insertrow(0)
				kds_dirlist.setitem(k_riga, "path", path)
				kds_dirlist.setitem(k_riga, "nome", str_find.filename)
				if str_find.fileattributes = 16 then
					kds_dirlist.setitem(k_riga, "tipo", k_dirlist_tipo_folder)  // è una cartella
				else
					if str_find.fileattributes = 38 then   // è un file nascosto
						kds_dirlist.setitem(k_riga, "tipo", k_dirlist_tipo_hidden)  
					else	
						kds_dirlist.setitem(k_riga, "tipo", k_dirlist_tipo_file)  // è un file
					end if					
				end if					
				kds_dirlist.setitem(k_riga, "size", str_find.filesizelow)
				kds_dirlist.setitem(k_riga, "dato1", string(str_find.lastwritetime))
			end if
	
		end if
		
		lb_fin = FindNextFile(lul_handle, str_find)
	
	loop while lb_fin
	
end if


return kds_dirlist



end function

public function boolean of_print (string a_file, string a_printer);
//
string ls_Null
long ll_null
longlong ll_rc

long SW_HIDE = 0
long SW_SHOWNORMAL = 1


SetNull(ls_Null)
SetNull(ll_null)

a_printer = "~"" + a_printer + "~""

//ll_rc = ShellExecuteW ( handle( this ), "print", a_file, a_printer, ls_Null, SW_SHOWNORMAL)   "~"EPSONFAFFE1 (WP-4535 Series)~""
ll_rc = ShellExecuteW ( ll_null, "printto", a_file, a_printer, ls_Null, SW_HIDE)


//--- i ritorni
//SE_ERR_FNF              2       // file not found
//SE_ERR_PNF              3       // path not found
//SE_ERR_ACCESSDENIED     5       // access denied
//SE_ERR_OOM              8       // out of memory
//SE_ERR_DLLNOTFOUND      32
//SE_ERR_SHARE            26
//SE_ERR_ASSOCINCOMPLETE  27
//SE_ERR_DDETIMEOUT       28
//SE_ERR_DDEFAIL          29
//SE_ERR_DDEBUSY          30
//SE_ERR_NOASSOC          31

if ll_rc <= 32 or isnull(ll_rc) then
	return false
else
	return true
end if

end function

public function boolean of_email (string a_address, string a_cc, string a_subject, string a_body, string a_attachement);//
//
string k_Null, k_mail_cmd
long k_null_n
longlong k_rc

long SW_HIDE = 0
long SW_SHOWNORMAL = 1


SetNull(k_Null)
SetNull(k_null_n)

if a_address > " " then
else
	a_address=""
end if
if a_subject > " " then
	k_mail_cmd = "&Subject=" + trim(a_subject)
end if
if a_body > " " then
	a_body = kguo_g.u_replace(a_body, "&", "%26")
	a_body = kguo_g.u_replace(a_body, " ", "%20")
	a_body = kguo_g.u_replace(a_body,  "~r", "%0D")
	a_body = kguo_g.u_replace(a_body,  "~n", "%0A")
	k_mail_cmd += "&Body=" + a_body + "%0D%0A"
end if
if a_cc > " " then
	k_mail_cmd += "&CC=" + trim(a_cc)
end if
if a_attachement > " " then
	k_mail_cmd += "&Attachment=~""  + trim(a_attachement) + "~"" 
	// Char(34)
end if

k_mail_cmd = "mailto:" + a_Address + "?" + k_mail_cmd

//ll_rc = ShellExecuteW ( handle( this ), "print", a_file, a_printer, ls_Null, SW_SHOWNORMAL)   "~"EPSONFAFFE1 (WP-4535 Series)~""
k_rc = ShellExecuteW ( k_null_n, "open", k_mail_cmd, k_Null, k_Null, SW_SHOWNORMAL)


//--- i ritorni
//SE_ERR_FNF              2       // file not found
//SE_ERR_PNF              3       // path not found
//SE_ERR_ACCESSDENIED     5       // access denied
//SE_ERR_OOM              8       // out of memory
//SE_ERR_DLLNOTFOUND      32
//SE_ERR_SHARE            26
//SE_ERR_ASSOCINCOMPLETE  27
//SE_ERR_DDETIMEOUT       28
//SE_ERR_DDEFAIL          29
//SE_ERR_DDEBUSY          30
//SE_ERR_NOASSOC          31

if k_rc <= 32 or isnull(k_rc) then
	return false
else
	return true
end if

end function

public subroutine of_removedirectory (string a_folder);//
RemoveDirectory(a_folder)

end subroutine

public function integer u_filemove (string a_src, string a_dst, boolean a_replace);//
//--- sposta un file da una path a un altro
//--- inp: 	a_src = path sorgente + nome file
//--- 		a_dst = path destinatario + nome file
//--- 		a_replace = true replace file
//--- rit:	1 ok, -1 errore file input, -2 errore file output, -3 err in delete
//
int k_return
int k_rc_fileCopy


	k_rc_fileCopy = fileCopy(a_src, a_dst, a_replace) // copia il pdf 
	if k_rc_fileCopy = 1 then
		if FileDelete(a_src) then
			k_return = 1
		else
			k_return = -3
		end if
	else
		k_return = k_rc_fileCopy
	end if

return k_return
end function

public function boolean u_directory_create (string k_path);//---
//--- Creazione del path indicato (potrebbe creare anche l'intero percorso) se non esiste
//---
//--- Input: il PATH da creare se non esiste (NO il nome file!!!) es. \\syrio\datisyrio\gruppi\pippo con o senza slash finale
//--- Rit.: TRUE = OK
//---
boolean k_return=false, k_primo_giro=true, k_percorso_di_rete=false
int k_pos_ini, k_pos_fin, k_len_path, k_errore, k_len
string k_path_lav

if right(trim(k_path),1) <>  KKG.PATH_SEP then 
	k_path_lav = trim(k_path) + KKG.PATH_SEP   // aggiungo il separatore x la fine cartella
else
	k_path_lav = trim(k_path)
end if
k_len_path = len(k_path_lav) 

if k_len_path > 0 then
	
//--- se inizia con un path di rete quale ad esempio:  \\proxima   allora devo saperlo	
	if left(k_path_lav,1) = KKG.PATH_SEP and mid(k_path_lav,2,1) = KKG.PATH_SEP then
		k_percorso_di_rete = true
		k_pos_ini = 3
	else
		k_pos_ini = 1
	end if
	
//--- cerca il primo '\'
	k_pos_ini = pos(k_path_lav, KKG.PATH_SEP, k_pos_ini )
	
	k_errore = 1 // OK nel caso il PATH esista gia'
	do while k_pos_ini < k_len_path and k_errore > 0
		
		if mid(k_path_lav, k_pos_ini - 1, 1) <> KKG.PATH_SEP then
			k_pos_ini ++
			k_pos_fin = pos(k_path_lav, KKG.PATH_SEP, k_pos_ini )
			if k_pos_fin > k_pos_ini then
//				k_len = k_pos_fin - k_pos_ini
				
				if k_percorso_di_rete and k_primo_giro then  // se ad esempio sono su un path net es. \\proxima\pippo\pluto salto il '\\proxima'
					k_primo_giro = false
				else
					If not DirectoryExists ( mid(k_path_lav, 1, k_pos_fin) ) Then  // NON esiste la  sub-cartella
						k_errore = CreateDirectory( mid(k_path_lav, 1, k_pos_fin))   // crea la sub-cartella
					end if
				end if
				
			end if
		else
			k_pos_fin = k_pos_ini + 1
		end if
			
//--- Posizione sul fine cartella trovata prima  ('\')			
		k_pos_ini = k_pos_fin 
//		k_pos_ini = pos(k_path_lav, KKG.PATH_SEP, k_pos_ini )
				
	loop


	if k_errore > 0 then
		k_return = true
	end if

end if
	


return k_return

end function

on kuf_file_explorer.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_file_explorer.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

