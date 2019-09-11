$PBExportHeader$w_email_funzione.srw
forward
global type w_email_funzione from w_g_tab0
end type
end forward

global type w_email_funzione from w_g_tab0
integer width = 2994
integer height = 1984
string title = ""
boolean maxbox = false
boolean ki_toolbar_window_presente = true
boolean ki_sincronizza_window_consenti = false
boolean ki_resize_dw_dett = true
end type
global w_email_funzione w_email_funzione

type variables
//
private kuf_email_funzioni kiuf_email_funzioni
private st_tab_email_funzioni ki_st_tab_email_funzioni


end variables

forward prototypes
public function string inizializza ()
private function string check_dati ()
private function string cancella ()
protected function integer visualizza ()
protected function integer inserisci ()
private function integer modifica ()
protected subroutine open_start_window ()
protected subroutine riempi_id ()
end prototypes

public function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Parametro IN : k_id_vettore
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
//string k_key
long k_riga
int k_importa = 0
pointer oldpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


//=== Legge le righe del dw salvate l'ultima volta (importfile)
		if ki_st_open_w.flag_primo_giro = "S" then 
	
			k_importa = kGuf_data_base.dw_importfile(trim(ki_syntaxquery), dw_lista_0)
	
		end if
			
		
		if k_importa <= 0 then // Nessuna importazione eseguita
	
	
			if dw_lista_0.retrieve() < 1 then
				k_return = "1Dati Non trovati  "
	
				SetPointer(oldpointer)
				messagebox("Elenco Vuoto", &
						"Nesun Codice Trovato per la richiesta fatta")
			else
				
				if ki_st_open_w.flag_primo_giro = "S" then 
					k_riga = 1
//--- se ho passato anche il ID allora....
					if ki_st_tab_email_funzioni.id_email > 0 then
						k_riga = dw_lista_0.find( "id_email_funzione = " + string(ki_st_tab_email_funzioni.id_email_funzione) + " ", 1, dw_lista_0.rowcount( ) )
					end if
					if k_riga > 0 then 
						dw_lista_0.selectrow( 0, false)
						dw_lista_0.scrolltorow( k_riga)
						dw_lista_0.setrow( k_riga)
						dw_lista_0.selectrow( k_riga, true)
					end if
					
//--- se entro per modificare allora....
					if ki_st_open_w.flag_modalita = KKG_FLAG_RICHIESTA.modifica then 
						cb_modifica.postevent(clicked!)
					end if
				end if
	
			end if		
		end if
	
//	end if
	
return k_return



end function

private function string check_dati ();//
//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK con errori non gravi
//===                		: 5=OK con avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================
//=== Controllo dati inseriti
string k_return = ""
string k_errore = "0"
int k_rc=0
long k_riga
string k_descr=""
st_esito kst_esito
st_tab_email_funzioni kst_tab_email_funzioni, kst_tab_email_funzioni_app

try
	k_riga = dw_dett_0.getrow()

	kst_tab_email_funzioni.id_email = dw_dett_0.getitemnumber( k_riga, "id_email") 
	if kst_tab_email_funzioni.id_email > 0 then
	else
		k_return = k_return + "Manca il Codice Prototipo E-mail " + "~n~r"
		k_errore = "3"
	end if
	
	kst_tab_email_funzioni.cod_funzione = trim(dw_dett_0.getitemstring(1, "cod_funzione"))  
	if trim(kst_tab_email_funzioni.cod_funzione) > " " then
//--- c'e' gia' il Codice?
		kst_tab_email_funzioni.id_email_funzione = dw_dett_0.getitemnumber( k_riga, "id_email_funzione") 
//		kst_tab_email_funzioni.cod_funzione = trim(dw_dett_0.getitemstring(1, "cod_funzione"))  
		kst_tab_email_funzioni_app.id_email_funzione = kiuf_email_funzioni.get_id_email_funzione_xidemail(kst_tab_email_funzioni)
		if kst_tab_email_funzioni_app.id_email_funzione > 0 &
			  and kst_tab_email_funzioni_app.id_email_funzione <> kst_tab_email_funzioni.id_email_funzione then
	
			k_return += "Prototipo " + string(kst_tab_email_funzioni.id_email) + &
						  " già utilizzato;~n~r" 
			k_errore = "1"
	
		end if		
	else
		k_return += "Manca il Codice Funzione " + "~n~r"
		k_errore = "3"
	end if
		
//
//	
////--- errori diversi
//   if trim(k_errore) = "0" or trim(k_errore) = "4"  or trim(k_errore) = "5" then
//		if isnull(dw_dett_0.getitemstring ( k_riga, "des")) &
//					   or len(trim(dw_dett_0.getitemstring(dw_dett_0.getrow(), "des"))) = 0 then 
//				k_return = k_return + "Manca la Descrizione " + "~n~r" 
//				k_errore = "3"
//		end if
//
//		if isnull(dw_dett_0.getitemstring(dw_dett_0.getrow(), "oggetto")) & 
//				   or len(trim(dw_dett_0.getitemstring(dw_dett_0.getrow(), "oggetto"))) = 0 then 
//			k_return = k_return + "Manca Oggetto " + "~n~r" 
//			k_errore = "3"
//		end if
//
//		if isnull(dw_dett_0.getitemstring(dw_dett_0.getrow(), "link_lettera")) & 
//				   or len(trim(dw_dett_0.getitemstring(dw_dett_0.getrow(), "link_lettera"))) = 0 then 
//			k_return = k_return + "Manca la Comunicazione " + "~n~r" 
//			k_errore = "3"
//		end if
//		
//	end if
//
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	k_errore = "1"
	k_return += kst_esito.sqlerrtext
	
end try

return trim(k_errore) + trim(k_return)


end function

private function string cancella ();//
//--- Cancellazione rekord dal DB
//--- Ritorna : "0"=OK "1...."=KO 
//
string k_return=""
string k_errore = "0 "
long k_riga
string k_descr
string k_codice
st_tab_email_funzioni kst_tab_email_funzioni
st_esito kst_esito


//=== Controllo se sul dettaglio c'e' qualche cosa
if dw_dett_0.visible and dw_dett_0.rowcount() > 0 then
	k_codice = string(dw_dett_0.getitemnumber(1, "id_email_funzione"))
	k_descr = trim(dw_dett_0.getitemstring(1, "cod_funzione"))
	kst_tab_email_funzioni.id_email_funzione = dw_dett_0.getitemnumber(k_riga, "id_email_funzione") 
	k_riga = 1
else
//=== Se sul dw non c'e' nessuna riga o nessun codice allora pesco dalla lista
	k_riga = dw_lista_0.getselectedrow(0)	
	if k_riga > 0 then
		k_codice = string(dw_lista_0.getitemnumber(k_riga, "id_email_funzione"))
		k_descr = trim(dw_lista_0.getitemstring(k_riga, "cod_funzione"))
		kst_tab_email_funzioni.id_email_funzione = dw_lista_0.getitemnumber(k_riga, "id_email_funzione") 
	end if
end if

if isnull(k_codice) then
	k_codice = ". "
end if
if isnull(k_descr) = true or trim(k_descr) = "" then
	k_descr = "E-mail senza Funzione" 
end if

if k_riga > 0 and isnull(k_codice) = false then	
	
//=== Richiesta di conferma della eliminazione del rek

	if messagebox("Elimina " + this.title , "Sei sicuro di voler Cancellare : ~n~r" &
	             + trim(k_codice) + " " + trim(k_descr), &
				question!, yesno!, 2) = 1 then
 
		
//=== Cancella la riga dal data windows di lista
		try
			kiuf_email_funzioni.tb_delete(kst_tab_email_funzioni) 
		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()
		end try
		
		if kst_esito.esito = kkg_esito.ok then

//--- Se tutto OK faccio la COMMIT		
			kst_esito = kguo_sqlca_db_magazzino.db_commit()
			if kst_esito.esito <> kkg_esito.ok then
				
				k_errore = "1Operzione fallita (COMMIT)!! ~n~rErrore: " + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) 
				messagebox("Problemi durante la Cancellazione !!", k_errore)

			else

//--- cancello riga a video
				k_codice = " "
				if dw_dett_0.visible and dw_dett_0.rowcount() > 0 then
					k_codice = string(dw_dett_0.getitemnumber(1, "id_email_funzione"))
					dw_dett_0.deleterow(1)
					
					mostra_nascondi_dw()
					
				else
					if k_riga > 0 then
						dw_lista_0.deleterow(k_riga)
					end if
				end if

			end if

			dw_dett_0.setfocus()

		else
			k_errore = "1Operzione fallita!! ~n~rErrore: " + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) 
			kst_esito = kguo_sqlca_db_magazzino.db_rollback()
			if kst_esito.esito <> kkg_esito.ok then
				k_errore += k_errore + "~n~rErrore anche durante il recupero dell'errore: ~n~r" + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) + "~n~rControllare i dati. "
			end if
				
			messagebox("Problemi durante Cancellazione", MidA(k_errore, 2) ) 	

			attiva_tasti()
	

		end if

	else
		messagebox("Elimina " + this.title , "Operazione Annullata !!")
	end if

	dw_dett_0.setcolumn(1)

end if

k_return = k_errore

return(k_return)
//

end function

protected function integer visualizza ();//===
//=== Lettura del rek da modificare
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
int k_return, k_rc, k_taborder
long k_key
kuf_utility kuf1_utility


	k_key = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "id_email_funzione")
	
	ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione

	k_return = dw_dett_0.retrieve( k_key ) 

//
//--- protezione campi per impedire la modifica
	kuf1_utility = create kuf_utility
	kuf1_utility.u_proteggi_dw("1", 0, dw_dett_0)
	destroy kuf1_utility

	attiva_tasti()

return k_return

end function

protected function integer inserisci ();//
int k_rc, k_ctr, k_taborder
string k_rc1, k_style
long k_riga
st_tab_clienti kst_tab_clienti
kuf_clienti kuf1_clienti
kuf_utility kuf1_utility
st_esito kst_esito
datawindowchild kdwc_clienti_d



	ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento 

	dw_dett_0.reset()
	dw_dett_0.insertrow(0)
	
	dw_dett_0.setitem(dw_dett_0.getrow(), "id_email_funzione", 0 )
	dw_dett_0.setitem(dw_dett_0.getrow(), "id_email", 0 )
	dw_dett_0.setitem(dw_dett_0.getrow(), "cod_funzione", "" )

	dw_dett_0.setcolumn(1)
	
//--- S-protezione campi per riabilitare la modifica a parte la chiave
	kuf1_utility = create kuf_utility
	kuf1_utility.u_proteggi_dw("0", 0, dw_dett_0)
	destroy kuf1_utility  

	attiva_tasti()

//=== Posiziona il cursore sul Data Windows
	dw_dett_0.ResetUpdate ( ) 
	dw_dett_0.setfocus() 


return (0)


end function

private function integer modifica ();//===
//=== Lettura del rek da modificare
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
int k_return, k_rc,  k_ctr, k_taborder
string k_style, k_rc1
long k_key
datawindowchild kdwc_clienti_d
kuf_utility kuf1_utility


	k_key = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "id_email_funzione")
	
	ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica 

	k_return = dw_dett_0.retrieve( k_key ) 

//--- S-protezione campi per riabilitare la modifica a parte la chiave
	kuf1_utility = create kuf_utility
   	kuf1_utility.u_proteggi_dw("0", 0, dw_dett_0)

//--- Inabilita campo cliente per la modifica se Funzione MODIFICA
	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
		kuf1_utility.u_proteggi_dw("1", 1, dw_dett_0)
	end if


	attiva_tasti()

//=== Posiziona il cursore sul Data Windows
	dw_dett_0.SetColumn(1)
	dw_dett_0.ResetUpdate ( ) 
	dw_dett_0.setfocus() 


return k_return

end function

protected subroutine open_start_window ();//---
string k_esito
datawindowchild kdwc_1

	kiuf_email_funzioni = create kuf_email_funzioni


//--- Salva Argomenti programma chiamante
//	if Len(trim(ki_st_open_w.key1)) = 0 then // ID
//		ki_st_tab_email.id_email = 0
//	else
//		ki_st_tab_email.id_email = long(trim(ki_st_open_w.key1))
//	end if

	dw_dett_0.getchild("id_email", kdwc_1)
	kdwc_1.settransobject(kguo_sqlca_db_magazzino )
	kdwc_1.retrieve("%")
	kdwc_1.insertrow(0)
	
	
	
end subroutine

protected subroutine riempi_id ();//

if dw_dett_0.rowcount() > 0 then
	dw_dett_0.setitem(1, "x_datins", kGuf_data_base.prendi_x_datins())
	dw_dett_0.setitem(1, "x_utente", kGuf_data_base.prendi_x_utente())
end if
end subroutine

on w_email_funzione.create
call super::create
end on

on w_email_funzione.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;//
if isvalid(kiuf_email_funzioni) then destroy kiuf_email_funzioni

end event

type st_ritorna from w_g_tab0`st_ritorna within w_email_funzione
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_email_funzione
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_email_funzione
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_email_funzione
integer x = 2350
integer y = 1348
end type

type st_stampa from w_g_tab0`st_stampa within w_email_funzione
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_email_funzione
integer x = 2350
integer y = 656
end type

type cb_modifica from w_g_tab0`cb_modifica within w_email_funzione
integer x = 2350
integer y = 908
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_email_funzione
integer x = 2350
integer y = 1200
end type

type cb_cancella from w_g_tab0`cb_cancella within w_email_funzione
integer x = 2350
integer y = 1052
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_email_funzione
integer x = 2350
integer y = 768
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_email_funzione
integer y = 1032
integer width = 2747
integer height = 688
boolean enabled = true
string dataobject = "d_email_funzione"
end type

event dw_dett_0::editchanged;//soppressione codice del padre
end event

event dw_dett_0::itemchanged;call super::itemchanged;//
long k_riga=0
datawindowchild kdwc_1


try
	choose case dwo.name 
	
		case "id_email" 
			if len(trim(data)) > 0 then 
				this.getchild(dwo.name, kdwc_1)
				k_riga = kdwc_1.find( "id_email = " + trim(data) + " " , 1, kdwc_1.rowcount())
				if k_riga > 0 then
					this.setitem(1, "email_des", kdwc_1.getitemstring(k_riga, "des"))
				else
					this.modify( dwo.name + ".Background.Color = '" + string(kkg_colore.ERR_DATO) + "' ") 
				end if
			else
				this.setitem(1, "email_des", "")
			end if
			
	end choose 

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()

end try
	
end event

type st_orizzontal from w_g_tab0`st_orizzontal within w_email_funzione
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_email_funzione
integer y = 32
integer width = 2866
integer height = 864
string dataobject = "d_email_funzione_l"
end type

type dw_guida from w_g_tab0`dw_guida within w_email_funzione
integer x = 59
integer y = 0
end type

type st_duplica from w_g_tab0`st_duplica within w_email_funzione
end type

