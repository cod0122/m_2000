$PBExportHeader$uo_exception.sru
forward
global type uo_exception from exception
end type
end forward

global type uo_exception from exception
end type
global uo_exception uo_exception

type variables
//
//--- struttura per errori
private st_uo_exception ki_st_uo_exception
public st_esito kist_esito

private string ki_titolo = "" // titolo del messaggio 

// valori possibili per TIPO di st_exception: Possibilmente uguali a quelli KKG_ESITO
constant string KK_st_uo_exception_tipo_OK="0"
constant string KK_st_uo_exception_tipo_db_ko="1"
constant string KK_st_uo_exception_tipo_dati_utente="2"
constant string KK_st_uo_exception_tipo_allerta="3"
constant string KK_st_uo_exception_tipo_dati_non_eseguito="4"
constant string KK_st_uo_exception_tipo_err_int="5"
constant string KK_st_uo_exception_tipo_interr_da_utente="6"
constant string KK_st_uo_exception_tipo_dati_insufficienti="7"
constant string KK_st_uo_exception_tipo_dati_insufficienti1="I" 
constant string KK_st_uo_exception_tipo_dati_anomali="8"
constant string KK_st_uo_exception_tipo_dati_wrn="W"
constant string KK_st_uo_exception_tipo_generico="9"
constant string KK_st_uo_exception_tipo_ko="A"
constant string KK_st_uo_exception_tipo_noAUT="B"
constant string KK_st_uo_exception_tipo_not_fnd="100"
constant string KK_st_uo_exception_tipo_trace="T"
constant string KK_st_uo_exception_tipo_SINO="N"

end variables

forward prototypes
public subroutine messaggio_utente ()
public function st_esito get_st_esito ()
public function string get_tipo ()
public subroutine set_nome_oggetto (string k_nome_oggetto)
public subroutine setmessage (string newmessage)
public function string getmessage ()
public subroutine scrivi_log ()
public subroutine inizializza ()
public subroutine set_esito_reset ()
public subroutine set_esito (st_esito ast_esito)
public subroutine set_tipo (string a_tipo)
public function string get_errtext ()
public function string get_esito_descrizione (st_esito ast_esito)
public subroutine setmessage (string a_titolo, string newmessage)
public function integer messaggio_utente (string a_titolo, string a_msg)
end prototypes

public subroutine messaggio_utente ();//---
//--- Espone messaggio di errore all'utente
//---
string k_msg, k_titolo
st_esito kst_esito


ki_st_uo_exception.tipo = get_tipo()


if trim(getmessage()) > ' ' then
else
	kst_esito = get_st_esito()
	if trim(kst_esito.sqlerrtext) > " " then
	else
		kst_esito.sqlerrtext = "Programma in anomalia."
	end if
	if kst_esito.sqlcode <> 0 then
		kst_esito.sqlerrtext = trim(kst_esito.sqlerrtext) + " ~n~rCodice: " + string(kst_esito.sqlcode)
	end if
	if trim(kst_esito.nome_oggetto) > " " then
		kst_esito.sqlerrtext = trim(kst_esito.sqlerrtext) + " ~n~rOggetto:  " + trim(kst_esito.nome_oggetto)
	end if
	setmessage(trim(kst_esito.sqlerrtext))
end if

//--- imposta il TITOLO
if ki_titolo > " " then
	k_titolo = ki_titolo
else
	choose case ki_st_uo_exception.tipo
		case KK_st_uo_exception_tipo_generico
			k_titolo = "Operazione non eseguita"
		case KK_st_uo_exception_tipo_dati_non_eseguito
			k_titolo = "Operazione non eseguita"
		case KK_st_uo_exception_tipo_dati_anomali, KK_st_uo_exception_tipo_dati_wrn
			k_titolo = "Dati Anomali"
		case KK_st_uo_exception_tipo_dati_utente &
			, KK_st_uo_exception_tipo_noAUT
			k_titolo = "Utente non Autorizzato"
		case KK_st_uo_exception_tipo_db_ko
			k_titolo = "Operazione su DB Fallita"
		case KK_st_uo_exception_tipo_ko
			k_titolo = "Esecuzione Fallita"
		case KK_st_uo_exception_tipo_not_fnd
			k_titolo = "Dati non Trovati"
		case KK_st_uo_exception_tipo_err_int
			k_titolo = "Errore Interno"
		case KK_st_uo_exception_tipo_allerta
			k_titolo = "Messaggio di ALLERTA"
		case KK_st_uo_exception_tipo_dati_insufficienti, KK_st_uo_exception_tipo_dati_insufficienti1
			k_titolo = "Dati Insufficienti"
		case KK_st_uo_exception_tipo_OK
			k_titolo = "Operazione Corretta"
		case else
			k_titolo = "Operazione Interrotta"
	end choose
end if
//~n~r~n~r
//--- Espone il msg all'utente
choose case ki_st_uo_exception.tipo
	case KK_st_uo_exception_tipo_generico
		messaggio_utente (k_titolo,  getmessage())
	case KK_st_uo_exception_tipo_dati_non_eseguito
		messaggio_utente (k_titolo,  getmessage())
	case KK_st_uo_exception_tipo_dati_anomali, KK_st_uo_exception_tipo_dati_wrn
		messaggio_utente (k_titolo, getmessage())
	case KK_st_uo_exception_tipo_dati_utente , KK_st_uo_exception_tipo_noAUT
		messaggio_utente (k_titolo, getmessage())
	case KK_st_uo_exception_tipo_db_ko
		messaggio_utente (k_titolo, getmessage())
	case KK_st_uo_exception_tipo_ko
		messaggio_utente (k_titolo, getmessage())
	case KK_st_uo_exception_tipo_not_fnd
		messaggio_utente (k_titolo, getmessage())
	case KK_st_uo_exception_tipo_err_int
		messaggio_utente (k_titolo, getmessage())
	case KK_st_uo_exception_tipo_allerta
		messaggio_utente (k_titolo, getmessage())
	case KK_st_uo_exception_tipo_dati_insufficienti, KK_st_uo_exception_tipo_dati_insufficienti1
		messaggio_utente (k_titolo, getmessage())
	case KK_st_uo_exception_tipo_OK
		messaggio_utente (k_titolo,  trim(getmessage()))
	case else
		k_msg = getmessage()
		if LenA(trim(k_msg)) > 0 then 
			messaggio_utente (k_titolo,k_msg)
		else
			messaggio_utente (k_titolo, "Esecuzione anomala la funzione sara' terminata")
		end if
end choose

end subroutine

public function st_esito get_st_esito ();//
//---
//--- Ritorna il tipo di errore
//---
if isnull(kist_esito.esito) then kist_esito.esito = KK_st_uo_exception_tipo_generico

if isnull(kist_esito.scrivi_log) then kist_esito.scrivi_log = FALSE
	
if kist_esito.esito = kkg_esito.db_ko &
		or	kist_esito.esito = kkg_esito.DATI_INSUFF   &
		or	kist_esito.esito = kkg_esito.NO_ESECUZIONE   &
		or	kist_esito.esito = kkg_esito.blok   &
		or	kist_esito.esito = kkg_esito.ERR_LOGICO   &
		or	kist_esito.esito = kkg_esito.KO   &
		or	kist_esito.esito = kkg_esito.NO_AUT   &
		or	kist_esito.esito = kkg_esito.TRACE   then
	
	kist_esito.scrivi_log = TRUE

end if

return kist_esito 

end function

public function string get_tipo ();//
//---
//--- Ritorna il tipo di errore
//---
if trim(ki_st_uo_exception.tipo) > " " then
else
	ki_st_uo_exception.tipo = KK_st_uo_exception_tipo_generico
end if
return trim(ki_st_uo_exception.tipo)

end function

public subroutine set_nome_oggetto (string k_nome_oggetto);//
//---
//--- imposta il nome dell'oggetto in cui si è verificato l'errore
//---
if isnull(k_nome_oggetto) then  kist_esito.nome_oggetto = "*non indicato*"
kist_esito.nome_oggetto = k_nome_oggetto

end subroutine

public subroutine setmessage (string newmessage);//
kist_esito.sqlerrtext = trim(newmessage)

if trim(kist_esito.esito) > " " then
	kist_esito.esito = this.kk_st_uo_exception_tipo_dati_wrn
end if

scrivi_log( )

	

end subroutine

public function string getmessage ();//
	return trim(kist_esito.sqlerrtext)
	

end function

public subroutine scrivi_log ();//
//---
//--- Scrive struttura ESITO nel LOG
//---
if kist_esito.scrivi_log & 
	or (kist_esito.esito <> kkg_esito.ok and kist_esito.esito <> kkg_esito.db_wrn and kist_esito.esito <> kkg_esito.DATI_WRN) then

	if len(trim(kist_esito.esito)) = 0 or isnull(kist_esito.esito) then
		kist_esito.sqlerrtext = "........NESSUN MESSAGGIO DA SCRIVERE......  (chiamata errata, riempire prima ST_ESITO)"
		kist_esito.esito = kkg_esito.ko
	end if

	if kist_esito.esito = kkg_esito.ok or kist_esito.esito = kkg_esito.db_wrn then
		kGuf_data_base.errori_scrivi_esito("I", kist_esito) 
	else
		kGuf_data_base.errori_scrivi_esito("W", kist_esito) 
	end if

end if


end subroutine

public subroutine inizializza ();//---
//---
//---
ki_titolo = ""
ki_st_uo_exception.tipo = ""
set_esito_reset( )


end subroutine

public subroutine set_esito_reset ();//---
//--- Pulisce il campo ESITO dell'oggetto
//---
//---
st_esito kst_esito_null

kist_esito = kst_esito_null
kist_esito.esito = kkg_esito.ok
kist_esito.sqlcode = 0
kist_esito.SQLErrText = ""
kist_esito.nome_oggetto = this.classname()
end subroutine

public subroutine set_esito (st_esito ast_esito);//
//---
//--- imposta il tipo di errore nella struttura ESITO
//---
if ast_esito.esito > " " then 
else
	ast_esito.esito = KK_st_uo_exception_tipo_generico
end if

//--- prima lo piazza uguale poi decide puntuale
ki_st_uo_exception.tipo = ast_esito.esito
if ast_esito.esito = kkg_esito.ok then ki_st_uo_exception.tipo = KK_st_uo_exception_tipo_OK 
if ast_esito.esito = kkg_esito.DB_KO then ki_st_uo_exception.tipo = KK_st_uo_exception_tipo_db_ko 
if ast_esito.esito = kkg_esito.KO then ki_st_uo_exception.tipo = KK_st_uo_exception_tipo_ko
if ast_esito.esito = kkg_esito.NOT_FND then ki_st_uo_exception.tipo = KK_st_uo_exception_tipo_not_fnd 
if ast_esito.esito = kkg_esito.NO_AUT then ki_st_uo_exception.tipo = KK_st_uo_exception_tipo_dati_utente 
if ast_esito.esito = kkg_esito.DB_WRN then ki_st_uo_exception.tipo = KK_st_uo_exception_tipo_allerta 
if ast_esito.esito = kkg_esito.blok then ki_st_uo_exception.tipo = KK_st_uo_exception_tipo_err_int 
if ast_esito.esito = kkg_esito.NO_ESECUZIONE then ki_st_uo_exception.tipo = KK_st_uo_exception_tipo_interr_da_utente 
if ast_esito.esito = kkg_esito.ERR_FORMALE then ki_st_uo_exception.tipo = KK_st_uo_exception_tipo_dati_insufficienti 
if ast_esito.esito = kkg_esito.DATI_INSUFF then ki_st_uo_exception.tipo = KK_st_uo_exception_tipo_dati_insufficienti 
if ast_esito.esito = kkg_esito.ERR_LOGICO then ki_st_uo_exception.tipo = KK_st_uo_exception_tipo_dati_anomali 
if ast_esito.esito = kkg_esito.DATI_WRN then ki_st_uo_exception.tipo = KK_st_uo_exception_tipo_dati_wrn 
if ast_esito.esito = kkg_esito.TRACE then ki_st_uo_exception.tipo = KK_st_uo_exception_tipo_TRACE 

if isnull(ast_esito.scrivi_log) then ast_esito.scrivi_log = false

//--- recupera descrizione
if ast_esito.descrizione > " " then
else
	ast_esito.descrizione = get_esito_descrizione(ast_esito)
end if

//--- ultimi ritocchi alla sqlerrtext
if ast_esito.sqlerrtext > " " then
	ast_esito.sqlerrtext = trim(ast_esito.sqlerrtext) 
else
	if isnull(this.getmessage( )) then
	else
		ast_esito.sqlerrtext = trim(ast_esito.sqlerrtext) + " - " + trim(this.getmessage( ))
	end if
end if

//--- scrive LOG	
kist_esito = ast_esito
scrivi_log( )
		


end subroutine

public subroutine set_tipo (string a_tipo);//
//---
//--- imposta il tipo di errore
//---
if isnull(a_tipo) then a_tipo = KK_st_uo_exception_tipo_generico
ki_st_uo_exception.tipo = a_tipo

if len(trim(kist_esito.esito)) = 0 or isnull(kist_esito.esito) then 
	kist_esito.esito = a_tipo

	choose case a_tipo

		case  KK_st_uo_exception_tipo_OK
			kist_esito.esito = kkg_esito.ok

		case  KK_st_uo_exception_tipo_db_ko
			kist_esito.esito = kkg_esito.db_ko
			
		case  KK_st_uo_exception_tipo_dati_utente
			kist_esito.esito = kkg_esito.DATI_INSUFF
			
		case  KK_st_uo_exception_tipo_allerta
			kist_esito.esito = kkg_esito.DATI_WRN
			
		case  KK_st_uo_exception_tipo_dati_non_eseguito
			kist_esito.esito = kkg_esito.NO_ESECUZIONE
			
		case  KK_st_uo_exception_tipo_err_int
			kist_esito.esito = kkg_esito.blok
			
		case  KK_st_uo_exception_tipo_interr_da_utente
			kist_esito.esito = kkg_esito.KO
			
		case  KK_st_uo_exception_tipo_dati_insufficienti
			kist_esito.esito = kkg_esito.DATI_INSUFF
			
		case  KK_st_uo_exception_tipo_dati_insufficienti1
			kist_esito.esito = kkg_esito.DATI_INSUFF
			
		case  KK_st_uo_exception_tipo_dati_anomali
			kist_esito.esito = kkg_esito.ERR_LOGICO
			
		case  KK_st_uo_exception_tipo_dati_wrn
			kist_esito.esito = kkg_esito.DATI_WRN
			
		case  KK_st_uo_exception_tipo_generico
			kist_esito.esito = kkg_esito.KO
			
		case  KK_st_uo_exception_tipo_ko
			kist_esito.esito = kkg_esito.KO
			
		case  KK_st_uo_exception_tipo_noAUT
			kist_esito.esito = kkg_esito.NO_AUT
			
		case  KK_st_uo_exception_tipo_not_fnd
			kist_esito.esito = kkg_esito.NOT_FND
	
		case else
			kist_esito.esito = kkg_esito.blok

	end choose
	
end if

end subroutine

public function string get_errtext ();
//
string k_return=""
		
		
		if  kist_esito.sqlerrtext > " " then
			k_return = trim(kist_esito.sqlerrtext)
		else
			k_return = "Errore generico"
		end if

return k_return

end function

public function string get_esito_descrizione (st_esito ast_esito);
//
string k_return=""
		
		
		choose case  ast_esito.esito
			case KK_st_uo_exception_tipo_generico
				k_return = " - Errore generico "
				
			case KK_st_uo_exception_tipo_dati_anomali
				k_return = " - Dati Anomali "
				
			case KK_st_uo_exception_tipo_dati_utente
				k_return = " - Utente non Autorizzato "
				
			case KK_st_uo_exception_tipo_db_ko
				k_return = " - Fallita Operazione su DB  "
				
			case KK_st_uo_exception_tipo_ko
				k_return = " - Errore durante l'esecuzione  "
				
			case KK_st_uo_exception_tipo_not_fnd
				k_return = " - Dati non Trovati "
				
			case KK_st_uo_exception_tipo_err_int
				k_return = " - Errore Interno di programmazione "
				
			case KK_st_uo_exception_tipo_allerta
				k_return = " - Allerta, attenzione sei dati "
				
			case KK_st_uo_exception_tipo_dati_insufficienti
				k_return = " - Dati insufficienti "
				
			case KK_st_uo_exception_tipo_OK
				k_return = " - Operazione Corretta "
				
			case KK_st_uo_exception_tipo_interr_da_utente
				k_return = " - Operazione interrotta da utente (o dal programma)"
				
			case KK_st_uo_exception_tipo_noAUT
				k_return = " - Accesso non autorizzato "
				
			case KK_st_uo_exception_tipo_TRACE
				k_return = " - Trace "
				
			case else
				k_return = " - *** da codificare *** = " + trim(ast_esito.esito)
				
		end choose


return k_return

end function

public subroutine setmessage (string a_titolo, string newmessage);//
ki_titolo = trim(a_titolo)
setmessage(newmessage)
//kist_esito.sqlerrtext = trim(newmessage)


end subroutine

public function integer messaggio_utente (string a_titolo, string a_msg);//---
//---  Espone messaggio a Video
//---
//--- 
//---
int k_return = 0
st_esito kst_esito


//--- se il campo msg è vuoto allora tento di reperire da quello che ho già
kst_esito = get_st_esito()
if trim(kst_esito.sqlerrtext) > " " then
	if trim(a_msg) > " " then
	else
		a_msg = trim(kst_esito.sqlerrtext)
	end if
	if trim(kst_esito.nome_oggetto) > " " then
		a_msg += " ~n~r(" +  trim(kst_esito.nome_oggetto) + ") "
	end if
end if


//--- e il tipo x fare l'icona giusta
choose case get_tipo()
	case KK_st_uo_exception_tipo_generico
			messagebox (a_titolo, a_msg, information!)
	case KK_st_uo_exception_tipo_dati_anomali, KK_st_uo_exception_tipo_dati_wrn
			messagebox (a_titolo, a_msg, stopsign!)
	case KK_st_uo_exception_tipo_dati_utente &
		,KK_st_uo_exception_tipo_noaut
			messagebox (a_titolo, a_msg, StopSign!)
	case KK_st_uo_exception_tipo_db_ko
			messagebox (a_titolo, a_msg, stopsign!)
	case KK_st_uo_exception_tipo_ko
			messagebox (a_titolo, a_msg, stopsign!)
	case KK_st_uo_exception_tipo_not_fnd
			messagebox (a_titolo, a_msg, Exclamation!)
	case KK_st_uo_exception_tipo_err_int
			messagebox (a_titolo, a_msg, stopsign!)
	case KK_st_uo_exception_tipo_allerta
			messagebox (a_titolo, a_msg, stopsign!)
	case KK_st_uo_exception_tipo_dati_insufficienti, KK_st_uo_exception_tipo_dati_insufficienti1
			messagebox (a_titolo, a_msg, stopsign!)
	case KK_st_uo_exception_tipo_OK
			messagebox (a_titolo, a_msg, Information!)
	case KK_st_uo_exception_tipo_SINO
			k_return = messagebox (a_titolo, a_msg, Question!, YesNo!, 2)
	case else
			messagebox (a_titolo, a_msg, Information!)
end choose

//--- se ESITO non ancora impostato...
if trim(kist_esito.esito) > " " then
else
	choose case get_tipo()
		case KK_st_uo_exception_tipo_generico
				kist_esito.esito = kkg_esito.ko
		case KK_st_uo_exception_tipo_dati_anomali
				kist_esito.esito = kkg_esito.ko
		case KK_st_uo_exception_tipo_dati_wrn
				kist_esito.esito = kkg_esito.db_wrn
		case KK_st_uo_exception_tipo_dati_utente &
			,KK_st_uo_exception_tipo_noaut
				kist_esito.esito = kkg_esito.no_aut
		case KK_st_uo_exception_tipo_db_ko
				kist_esito.esito = kkg_esito.db_ko
		case KK_st_uo_exception_tipo_ko
				kist_esito.esito = kkg_esito.ko
		case KK_st_uo_exception_tipo_not_fnd
				kist_esito.esito = kkg_esito.not_fnd
		case KK_st_uo_exception_tipo_err_int
				kist_esito.esito = kkg_esito.ko
		case KK_st_uo_exception_tipo_allerta
				kist_esito.esito = kkg_esito.no_esecuzione
		case KK_st_uo_exception_tipo_dati_insufficienti, KK_st_uo_exception_tipo_dati_insufficienti1
				kist_esito.esito = kkg_esito.no_esecuzione
		case KK_st_uo_exception_tipo_OK
				kist_esito.esito = kkg_esito.OK
		case else
				kist_esito.esito = kkg_esito.no_esecuzione
	end choose
end if

kst_esito = get_st_esito()
if kst_esito.scrivi_log then
	kGuf_data_base.errori_scrivi_esito("W", kist_esito) 
end if


return k_return




end function

on uo_exception.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_exception.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//
//--- struttura per la gestione degli errori
st_uo_exception kist_uo_exception

//--- costanti x valori del tipo di errore
constant int kk_tipo_ex_generico = 1
end event

