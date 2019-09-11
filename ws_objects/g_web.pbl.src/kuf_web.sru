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

type variables
//
Inet  kiInet_base

end variables

forward prototypes
public function boolean if_url_esiste (st_web kst_web)
public subroutine apre_url (st_web kst_web)
public subroutine url_aggiusta_http (ref st_web kst_web)
public function st_esito u_start_www (string k_sito) throws uo_exception
public function boolean u_call_mail_client (string k_mail, string k_oggetto, string k_corpo, string k_allegato)
end prototypes

public function boolean if_url_esiste (st_web kst_web);//---
//--- Controllo Esisenza del URL
//---
//--- Input: st_web.url valorizzato
//--- Out: TRUE=ok, False=URL errato

boolean k_return=true
int ki
InternetResult  kInternetResult



kInternetResult = CREATE InternetResult
//
//if GetContextService("Internet", kiInet_base) > 0 then
//	kI = kiinet_base.geturl(kst_web.url, kInternetResult)
//	
//	destroy kInternetResult
//	
//	If ki = 1 then
//		k_return = true
//	else
//		k_return = false
//	end if
//end if

return k_return

end function

public subroutine apre_url (st_web kst_web);//---
//--- Apre URL
//---
//--- Input: st_web.url valorizzato
//--- 
//

if GetContextService("Internet", kiInet_base) > 0 then
	kiinet_base.HyperlinkToURL(kst_web.url)
end if



end subroutine

public subroutine url_aggiusta_http (ref st_web kst_web);//---
//--- Completa URL http con i giusti caratteri 
//---
//--- Input: st_web.url valorizzato
//--- Out: st_web.url sistema queste cose:
//---                           se manca aggiunge "http://"
//---                           mette '/' al posto di '\'  
//---                           mette ',' al posto di '.'  
//---                           mette '_' al posto di spazio, 
//---                           mette tutto in minuscolo 
//---                           sostituisce le accentate
//---
long kstart_pos=1


if isnull(kst_web.url) then
	kst_web.url=""
else
	
	kst_web.url = lower(trim(kst_web.url))  // Tutto minuscolo!
	if len(kst_web.url) > 0 then


	//--- sostituisce le barre rovesciate con quelle giuste
		kstart_pos = Pos(kst_web.url, "\", 1)
		DO WHILE kstart_pos > 0
			 // Replace old_str with new_str.
			 kst_web.url = Replace(kst_web.url, kstart_pos, 1, "/")
			 kstart_pos = Pos(kst_web.url, "\", kstart_pos+1)
		LOOP
	
	//--- sostituisce virgole con punti
		kstart_pos = Pos(kst_web.url, ",", 1)
		DO WHILE kstart_pos > 0
			 // Replace old_str with new_str.
			 kst_web.url = Replace(kst_web.url, kstart_pos, 1, ".")
			 kstart_pos = Pos(kst_web.url, ",", kstart_pos+1)
		LOOP
		
	//--- sostituisce SPAZIO con '_'
		kstart_pos = Pos(kst_web.url, " ", 1)
		DO WHILE kstart_pos > 0
			 // Replace old_str with new_str.
			 kst_web.url = Replace(kst_web.url, kstart_pos, 1, "_")
			 kstart_pos = Pos(kst_web.url, " ", kstart_pos+1)
		LOOP
		
	//--- sostituisce à con a
		kstart_pos = Pos(kst_web.url, "à", 1)
		DO WHILE kstart_pos > 0
			 // Replace old_str with new_str.
			 kst_web.url = Replace(kst_web.url, kstart_pos, 1, "a")
			 kstart_pos = Pos(kst_web.url, "à", kstart_pos+1)
		LOOP
	//--- sostituisce è con e
		kstart_pos = Pos(kst_web.url, "è", 1)
		DO WHILE kstart_pos > 0
			 // Replace old_str with new_str.
			 kst_web.url = Replace(kst_web.url, kstart_pos, 1, "e")
			 kstart_pos = Pos(kst_web.url, "è", kstart_pos+1)
		LOOP
	//--- sostituisce é con e
		kstart_pos = Pos(kst_web.url, "é", 1)
		DO WHILE kstart_pos > 0
			 // Replace old_str with new_str.
			 kst_web.url = Replace(kst_web.url, kstart_pos, 1, "e")
			 kstart_pos = Pos(kst_web.url, "é", kstart_pos+1)
		LOOP
	//--- sostituisce ù con u
		kstart_pos = Pos(kst_web.url, "ù", 1)
		DO WHILE kstart_pos > 0
			 // Replace old_str with new_str.
			 kst_web.url = Replace(kst_web.url, kstart_pos, 1, "u")
			 kstart_pos = Pos(kst_web.url, "ù", kstart_pos+1)
		LOOP
	//--- sostituisce ì con i
		kstart_pos = Pos(kst_web.url, "ì", 1)
		DO WHILE kstart_pos > 0
			 // Replace old_str with new_str.
			 kst_web.url = Replace(kst_web.url, kstart_pos, 1, "i")
			 kstart_pos = Pos(kst_web.url, "ì", kstart_pos+1)
		LOOP
	


		choose case mid(kst_web.url,1,1)
			case "." 
				kst_web.url = "http://www" + kst_web.url
			case ","
				kst_web.url = "http://www." + mid(kst_web.url,2)
			case "1" to "9"
				kst_web.url = "http://www." + kst_web.url
			case "h"
				if mid(kst_web.url,1,4) = "http" then
					if mid(kst_web.url,1,5) = "http:" then
						if mid(kst_web.url,1,6) = "http:/" then
							if mid(kst_web.url,1,7) <> "http://" then
								kst_web.url = "http://" + mid(kst_web.url, 7)  
							end if
						else
							kst_web.url = "http://" + mid(kst_web.url, 6) 
						end if
					else
						kst_web.url = "http://" + mid(kst_web.url, 5) 
					end if
				else
					kst_web.url = "http://" + kst_web.url
				end if				
			case else
					kst_web.url = "http://" + kst_web.url
		end choose
	

	end if
end if


end subroutine

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



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


if len(trim(k_sito)) > 0 then
	SetNull(ls_Null)
	k_rc = ShellExecuteW ( handle( this ), "open", k_sito, ls_Null, ls_Null, 1)
	
	choose case k_rc
		case 0, 1, 33 to 99
			kst_esito.esito = kkg_esito.ok
			kst_esito.sqlcode = k_rc
			kst_esito.sqlerrtext = "Operazione corretta, accesso al sito: ~n~r" + trim(k_sito)  
		case 5
			kst_esito.esito = kkg_esito.no_aut
			kst_esito.sqlcode = k_rc
			kst_esito.sqlerrtext = "Negato Accesso al Sito: ~n~r" + trim(k_sito) 
			kuo_exception = create uo_exception
			kuo_exception.set_esito(kst_esito)
			throw kuo_exception
		case 8
			kst_esito.esito = kkg_esito.no_esecuzione
			kst_esito.sqlcode = k_rc
			kst_esito.sqlerrtext = "Memoria Applicativa Non Disponibile (RAM) " 
			kuo_exception = create uo_exception
			kuo_exception.set_esito(kst_esito)
			throw kuo_exception
		case 32
			kst_esito.esito = kkg_esito.not_fnd
			kst_esito.sqlcode = k_rc
			kst_esito.sqlerrtext = "Browser Web non Trovato (errore DLL) " 
			kuo_exception = create uo_exception
			kuo_exception.set_esito(kst_esito)
			throw kuo_exception
		case 27, 31
			kst_esito.esito = kkg_esito.not_fnd
			kst_esito.sqlcode = k_rc
			kst_esito.sqlerrtext = "Nessu Browser Web Associato " 
			kuo_exception = create uo_exception
			kuo_exception.set_esito(kst_esito)
			throw kuo_exception
		case else
			kst_esito.esito = kkg_esito.no_esecuzione
			kst_esito.sqlcode = k_rc
			kst_esito.sqlerrtext = "Errore durante accesso al sito ("+string(k_rc)+"): ~n~r" + trim(k_sito)  
			kuo_exception = create uo_exception
			kuo_exception.set_esito(kst_esito)
			throw kuo_exception
	end choose
			  
end if
 
 return kst_esito
//
end function

public function boolean u_call_mail_client (string k_mail, string k_oggetto, string k_corpo, string k_allegato);//
//--- Chiama il client di Posta (outlook)
//
boolean k_return = true
int k_rc
string k_msg=""
kuf_utility kuf1_utility


kuf1_utility = create kuf_utility
k_msg = "mailto:"
if len(trim(k_mail)) > 0 then
	k_msg += k_mail 
end if	
if len(trim(k_oggetto)) > 0 then
	k_msg += ";&subject="+ trim(k_oggetto)
end if	
if len(trim(k_allegato)) > 0 then
	k_msg += ";&attachment=" + trim(k_allegato)
end if
k_rc = kuf1_utility.u_apri_programma_esterno (k_msg)
//k_rc = run("rundll32 url.dll,FileProtocolHandler " + "mailto:" + k_mail + "&subject="+ k_oggetto)
if k_rc < 1 then
	k_return = false
end if

destroy kuf1_utility

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

