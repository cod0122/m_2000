$PBExportHeader$uo_path.sru
forward
global type uo_path from nonvisualobject
end type
end forward

global type uo_path from nonvisualobject
end type
global uo_path uo_path

type variables
//--- PATH generali
private:
string ki_PROCEDURA = "."  // path di lavoro delle procedura dove sta il confdb.ini
string ki_BASE_DEL_SERVER="" //path dove risiede il server, di solito la CONSOLE
string ki_BASE_DEL_SERVER_JOB="" //path dove risiedono i batch da lanciare dal Server (di solito li lancia la CONSOLE)
string ki_BASE=""   //path archivi BASE
string ki_arch_saveas=""   //path dove salvare le dw x accellerare le letture (ormai obsoleto)
string ki_risorse = ""  //path dei grafici
string ki_help = ""  //path file di HELP 
string ki_doc_root = ""  //path file di root dei documenti (impostato sul BASE) 
string ki_doc_root_interno = ""  //path file di root dei documenti x uso interno 
string ki_doc_root_esterno = ""  //path file di root dei documenti x uso esterno tipo WEB

string ki_app_extract_certif_E1_pdf="" //path + nome programma di Estrazione da file pdf stampati da E1 dei Certificati


//--- Root dei Documenti Elettronici 
constant string kki_doc_root_uso_interno = KKG.PATH_SEP + "interno"    //-- x uso interno 
constant string kki_doc_root_uso_esterno = KKG.PATH_SEP + "esterno"   //--- x uso esterno tipo WEB

constant string kki_nome_file_errori = "\m2000_errori_1"

end variables

forward prototypes
public subroutine set_path ()
public function string get_procedura ()
public function string get_base_del_server ()
public function string get_base_del_server_job ()
public function string get_base ()
public function string get_risorse ()
public function string get_help ()
public subroutine set_path_base_del_server ()
public function string get_temp ()
public function string get_nome_file_errori_txt ()
public function string get_nome_file_errori_xml ()
public function string get_nome_file_errori_txt_all ()
public function string get_nome_path_file_errori_xml ()
public function string get_doc_root ()
public function string get_doc_root_interno ()
public function string get_doc_root_esterno ()
public subroutine set_doc_root ()
public subroutine set_arch_saveas ()
public subroutine set_path_icone ()
public function string get_app_extract_certif_e1_pdf ()
public function st_esito set_path_base ()
end prototypes

public subroutine set_path ();//
string k_esito
st_esito kst_esito
uo_exception kuo_exception


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kuo_exception = create uo_exception

ki_PROCEDURA = kGuf_data_base.prendi_path_corrente()
if trim(ki_procedura) > " " then
	if not DirectoryExists(ki_procedura) then
		kst_esito.esito = kkg_esito.ko
		kst_esito.SQLErrText = "La cartella Principale della Procedura non è raggiungibile: " + ki_PROCEDURA
	end if
else
	kst_esito.esito = kkg_esito.ko
	kst_esito.SQLErrText = "La cartella Principale non è stata indicata in Proprietà della Procedura!!!  " 
end if

ki_help = trim(kGuf_data_base.profilestring_leggi_scrivi(kGuf_data_base.ki_profilestring_operazione_leggi, "path_help", " "))
if trim(ki_help) > " " then
	if not DirectoryExists(ki_help) then
		kst_esito.esito = kkg_esito.ko
		kst_esito.SQLErrText += "La cartella del documento di aiuto della Procedura non è raggiungibile: " + ki_help
	end if
end if

//if kst_esito.esito <> kkg_esito.ok then
//	kuo_exception.inizializza()
//	kuo_exception.set_esito(kst_esito)
//	kuo_exception.messaggio_utente( )
//end if

if isvalid(kuo_exception) then destroy kuo_exception

end subroutine

public function string get_procedura ();//
return trim(ki_procedura)

end function

public function string get_base_del_server ();//
return trim(ki_BASE_DEL_SERVER)

end function

public function string get_base_del_server_job ();//
return trim(ki_BASE_DEL_SERVER_JOB)

end function

public function string get_base ();//
return trim(ki_BASE)

end function

public function string get_risorse ();//
return trim(ki_risorse)

end function

public function string get_help ();//
return trim(ki_help)

end function

public subroutine set_path_base_del_server ();//
//=== Imposta il PATH digitato sul DB circa il SERVER 
//
string k_path=" "
kuf_base kuf1_base
st_esito kst_esito
pointer kpointer
uo_exception kuo_exception


	kpointer = setpointer(hourglass!)
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kuo_exception = create uo_exception

	kuf1_base = create kuf_base
	
//--- get la path centrale sul SERVER
	k_path = kuf1_base.prendi_dato_base( "path_centrale")
	if left(k_path,1) <> "0" then
		ki_base_del_server = ""
	else
		ki_base_del_server = trim(mid(k_path,2))
		ki_BASE_DEL_SERVER_JOB = ki_base_del_server + kkg.path_sep + "job" 
	end if

	destroy kuf1_base
	
	if trim(ki_base_del_server) > " " then
		if not DirectoryExists(ki_base_del_server) then
			kst_esito.esito = kkg_esito.ko
			kst_esito.SQLErrText = "La cartella Principale del Server della Procedura non è raggiungibile: " + ki_base_del_server
		else
			
			set_path_icone( )
			
		end if
	end if

//	kuf_utility kuf1_utility
//	if not directoryexists(kGuo_path.get_base_del_server( ) ) then 
//		kuf1_utility = create kuf_utility
//		k_path_ok=kuf1_utility.u_drectory_create(kGuo_path.get_base_del_server( ) )
//		destroy kuf1_utility
//	end if
//
	setpointer(kpointer)

if kst_esito.esito <> kkg_esito.ok then
	kuo_exception.inizializza()
	kuo_exception.set_esito(kst_esito)
	kuo_exception.messaggio_utente( )
end if

if isvalid(kuo_exception) then destroy kuo_exception

end subroutine

public function string get_temp ();//
//--- torna Cartella pr il file temporanei:  c:\at_m2000\temp
//
string k_temp = "tempM2000"
string k_base = ""

k_base = get_base( )
if trim(k_base) > " " then
	k_temp = get_base( ) + kkg.path_sep + k_temp

	//u_drectory_create(k_temp)

end if


return k_temp

end function

public function string get_nome_file_errori_txt ();//
return get_base( ) + kki_nome_file_errori + ".txt"

end function

public function string get_nome_file_errori_xml ();//---
//--- restituisce il nome del File errori di tutti gli utenti in formato XML
//---

return kki_nome_file_errori + ".xml"

end function

public function string get_nome_file_errori_txt_all ();//---
//--- File errori di tutti gli utenti formato TXT
//---
string k_path = ""

k_path = get_procedura( )
if not directoryexists(k_path) then 
	k_path = get_base( )
end if

return k_path + kki_nome_file_errori + ".txt"

end function

public function string get_nome_path_file_errori_xml ();//---
//--- restituisce il nome + path del File errori di tutti gli utenti in formato XML
//---

string k_path = ""

k_path = get_base_del_server( )
if not directoryexists(k_path) then 
	k_path = get_base( )
end if

return k_path + get_nome_file_errori_xml() 

end function

public function string get_doc_root ();//
return trim(ki_doc_root)

end function

public function string get_doc_root_interno ();//
return trim(ki_doc_root) + kki_doc_root_uso_interno

end function

public function string get_doc_root_esterno ();//
return trim(ki_doc_root) + kki_doc_root_uso_esterno

end function

public subroutine set_doc_root ();//
//--- Imposta il PATH root dei documenti elettronici
//
string k_esito
kuf_base kuf1_base


kuf1_base = create kuf_base
k_esito = kuf1_base.prendi_dato_base( "doc_root")
if left(k_esito,1) <> "0" then
	ki_doc_root = ""
else
	ki_doc_root = trim(mid(k_esito,2)) 
end if

if isvalid(kuf1_base) then destroy kuf1_base


end subroutine

public subroutine set_arch_saveas ();//
//--- Imposta il PATH di salvataggio dei dati della DW es. c:\at_m2000\save_dw
//
//
st_esito kst_esito
uo_exception kuo_exception


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kuo_exception = create uo_exception


	ki_arch_saveas = kGuf_data_base.profilestring_leggi_scrivi (1, "arch_saveas", "")

	if trim(ki_arch_saveas) > " " then
		if not DirectoryExists(ki_arch_saveas) then
			kst_esito.esito = kkg_esito.not_fnd
			kst_esito.SQLErrText = "La cartella 'Salvataggio dati generici' non è raggiungibile: " + ki_base
//			if not u_drectory_create(ki_arch_saveas) then
//				kst_esito.esito = kkg_esito.ko
//				kst_esito.SQLErrText = "La cartella di salvatggio 'dati elenco' (DW) della Procedura non è raggiungibile: " + ki_arch_saveas
//			end if
		end if
	else
		ki_arch_saveas = "."
		kst_esito.esito = kkg_esito.ko
		kst_esito.SQLErrText = "Manca nel file di configurazione '" + trim(kGuf_data_base.kki_nome_profile_base) + "' la chiave 'arch_saveas' dove indicare la cartella di 'Salvataggio dati generici' !!  " 
	end if



end subroutine

public subroutine set_path_icone ();//
//=== Imposta il PATH digitato sul DB circa il SERVER 
//
//string k_path=" "
//kuf_base kuf1_base
st_esito kst_esito
uo_exception kuo_exception


	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kuo_exception = create uo_exception

//	kuf1_base = create kuf_base

	ki_risorse = trim(kGuf_data_base.profilestring_leggi_scrivi(kGuf_data_base.ki_profilestring_operazione_leggi, "arch_graf", " "))
	if trim(ki_risorse) > " " then
		if not DirectoryExists(ki_risorse) then
			kst_esito.esito = kkg_esito.ko
			kst_esito.SQLErrText += "La cartella delle Risorse grafiche quali le ICONE della Procedura non è raggiungibile: " + ki_risorse
		end if
	else
		kst_esito.esito = kkg_esito.ko
		kst_esito.SQLErrText += "La cartella delle Risorse grafiche quali le ICONE non è stata indicata in Proprietà della Procedura!!!  " 
	end if
	

	if kst_esito.esito <> kkg_esito.ok then
		kuo_exception.inizializza()
		kuo_exception.set_esito(kst_esito)
		kuo_exception.messaggio_utente( )
	end if

if isvalid(kuo_exception) then destroy kuo_exception

end subroutine

public function string get_app_extract_certif_e1_pdf ();//
return trim(ki_BASE_DEL_SERVER_JOB) + KKG.PATH_SEP + "mCertE1ChangeName" + KKG.PATH_SEP + "mCertE1ChangeName.exe"

end function

public function st_esito set_path_base ();//
//--- Imposta il PATH dell'utente (in cui è installato M2000) es. c:\at_m2000\db
//
//
st_esito kst_esito

	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	ki_base = kGuf_data_base.profilestring_leggi_scrivi (1, "arch_base", "")

	if trim(ki_base) > " " then
		if not DirectoryExists(ki_base) then
			kst_esito.esito = kkg_esito.not_fnd
			kst_esito.SQLErrText = "La cartella 'Archivi Base' non è raggiungibile: " + ki_base
//			if not u_drectory_create(ki_base) then
//				kst_esito.esito = kkg_esito.ko
//				kst_esito.SQLErrText = "La cartella 'Archivi Base' (DB) della Procedura non è raggiungibile: " + ki_base
//			end if
		end if
	else
		ki_base = "."
		kst_esito.esito = kkg_esito.ko
		kst_esito.SQLErrText = "Manca nel file di configurazione '" + trim(kGuf_data_base.kki_nome_profile_base) + "' la chiave 'arch_base' dove indicare la cartella 'Archivi Base' !!  " 
	end if


return kst_esito


end function

on uo_path.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_path.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

