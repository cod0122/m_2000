$PBExportHeader$kuf_web.sru
forward
global type kuf_web from nonvisualobject
end type
end forward

global type kuf_web from nonvisualobject
end type
global kuf_web kuf_web

type prototypes
//
FUNCTION long ShellExecuteW (long hwnd, string lpOperation, string lpFile, string lpParameters,  string lpDirectory, integer nShowCmd ) LIBRARY "shell32"

end prototypes

forward prototypes
public function st_esito u_start_www (string k_sito) throws uo_exception
public function boolean u_call_mail_client (string k_mail, string k_oggetto, string k_corpo)
end prototypes

public function st_esito u_start_www (string k_sito) throws uo_exception;//---
//--- Lancia Navigatore Web associato
//--- Inp: k_sito = indirizzo web da aprire
//--- Rit: st_esito STANDARD
//---
//--- Lancia exception se errore (impostato st_esito)
//---
//---
//---
//--- I possibili RC sono:
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
//---
//---
string ls_Null
long   k_rc
st_esito kst_esito
uo_exception kuo_exception



	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


if len(trim(k_sito)) > 0 then
	SetNull(ls_Null)
	k_rc = ShellExecuteW ( handle( this ), "open", k_sito, ls_Null, ls_Null, 1)
	
	choose case k_rc
		case 0, 1
			kst_esito.esito = kkg_esito_ok
			kst_esito.sqlcode = k_rc
			kst_esito.sqlerrtext = "Operazione corretta, accesso al sito: ~n~r" + trim(k_sito)  
		case 5
			kst_esito.esito = kkg_esito_no_aut
			kst_esito.sqlcode = k_rc
			kst_esito.sqlerrtext = "Negato Accesso al Sito: ~n~r" + trim(k_sito) 
			kuo_exception = create uo_exception
			kuo_exception.set_esito(kst_esito)
			throw kuo_exception
		case 8
			kst_esito.esito = kkg_esito_no_esecuzione
			kst_esito.sqlcode = k_rc
			kst_esito.sqlerrtext = "Memoria Applicativa Non Disponibile (RAM) " 
			kuo_exception = create uo_exception
			kuo_exception.set_esito(kst_esito)
			throw kuo_exception
		case 32
			kst_esito.esito = kkg_esito_not_fnd
			kst_esito.sqlcode = k_rc
			kst_esito.sqlerrtext = "Browser Web non Trovato (errore DLL) " 
			kuo_exception = create uo_exception
			kuo_exception.set_esito(kst_esito)
			throw kuo_exception
		case 27, 31
			kst_esito.esito = kkg_esito_not_fnd
			kst_esito.sqlcode = k_rc
			kst_esito.sqlerrtext = "Nessu Browser Web Associato " 
			kuo_exception = create uo_exception
			kuo_exception.set_esito(kst_esito)
			throw kuo_exception
		case else
			kst_esito.esito = kkg_esito_no_esecuzione
			kst_esito.sqlcode = k_rc
			kst_esito.sqlerrtext = "Errore durante accesso al sito: ~n~r" + trim(k_sito)  
			kuo_exception = create uo_exception
			kuo_exception.set_esito(kst_esito)
			throw kuo_exception
	end choose
			  
end if
 
 return kst_esito
//
end function

public function boolean u_call_mail_client (string k_mail, string k_oggetto, string k_corpo);//
//--- Chiama il client di Posta (outlook)
//
boolean k_return = true
int k_rc


k_rc = run("rundll32 url.dll,FileProtocolHandler " + "mailto:" + k_mail + "&subject="+ k_oggetto)
if k_rc < 1 then
	k_return = false
end if

return k_return


end function

on kuf_web.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_web.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

