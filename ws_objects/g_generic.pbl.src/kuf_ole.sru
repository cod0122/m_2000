$PBExportHeader$kuf_ole.sru
forward
global type kuf_ole from nonvisualobject
end type
end forward

global type kuf_ole from nonvisualobject
end type
global kuf_ole kuf_ole

forward prototypes
public function st_esito open_doc (string k_file)
public function st_esito open_txt (string k_file)
end prototypes

public function st_esito open_doc (string k_file);//
//--- Open Documento Word
//
//
string k_errore = "0"
int k_rc
oleobject kole_1
pointer kpointer_old
st_esito kst_esito



	kpointer_old = SetPointer(HourGlass!)

	kst_esito.esito = "0"
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""

	if FileExists( k_file ) then

		kole_1 = create oleobject
	
	
		k_rc = kole_1.ConnectToNewObject("word.application")
		if k_rc = 0 then
			
			
			kole_1.documents.open(k_file)
			kole_1.visible = true
		
			kole_1.disconnectobject()
			destroy kole_1
		
		else
			kst_esito.esito = "1"
			kst_esito.sqlcode = k_rc
			kst_esito.SQLErrText = "Applicazione 'WORD' non Trovata (kuf_ole.open_doc) "
		end if
	else
		kst_esito.esito = "1"
		kst_esito.sqlcode = k_rc
		kst_esito.SQLErrText = "File non presente o occupato da altro utente (kuf_ole.open_doc) "
	end if


	if kst_esito.esito = "1" then
		kGuf_data_base.errori_scrivi_esito("W", kst_esito)
	end if

	SetPointer(kpointer_old)


return kst_esito

end function

public function st_esito open_txt (string k_file);//
//--- Open Documento TESTO con NOTEPAD
//
//
Integer  k_rc
string k_errore = "0"
boolean kboolean_1=false
oleobject kole_1
pointer kpointer_old
st_esito kst_esito



	kpointer_old = SetPointer(HourGlass!)

	kst_esito.esito = "0"
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""


	if FileExists( k_file ) then
		kole_1 = CREATE OleObject
		k_rc = kole_1.ConnectToNewObject( "WScript.Shell" )

//				kboolean_1 = kole_1.AppActivate("Untitled - Notepad")
	
		if k_rc = 0 then
			
			k_rc = kole_1.Run("wordpad " + trim(k_file))
//			k_rc = kole_1.Run("Notepad " + trim(k_file))
			if k_rc >= 0 then
				
//				Sleep(500)
				kboolean_1 = kole_1.AppActivate("Untitled - Notepad")
//				kboolean_1 = kole_1.SendKeys("%F") alt+F
				
//				k_rc = kole_1.documents.open(k_file)
//				kole_1.visible = true
			
				kole_1.disconnectobject()
				destroy kole_1
		
			else
				kst_esito.esito = "1"
				kst_esito.sqlcode = k_rc
				kst_esito.SQLErrText = "Applicazione 'NOTEPAD' non Trovata (kuf_ole.open_txt) "
			end if
		else
			kst_esito.esito = "1"
			kst_esito.sqlcode = k_rc
			kst_esito.SQLErrText = "Metodo 'Wscript.shell' non Trovato (kuf_ole.open_txt) "
		end if
	else
		kst_esito.esito = "1"
		kst_esito.sqlcode = k_rc
		kst_esito.SQLErrText = "File non presente o occupato da altro utente (kuf_ole.open_txt) "
	end if

	if kst_esito.esito = "1" then
		kGuf_data_base.errori_scrivi_esito("W", kst_esito)
	end if

	SetPointer(kpointer_old)


return kst_esito

end function

on kuf_ole.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_ole.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

