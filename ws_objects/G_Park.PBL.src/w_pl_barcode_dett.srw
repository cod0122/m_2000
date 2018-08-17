﻿$PBExportHeader$w_pl_barcode_dett.srw
forward
global type w_pl_barcode_dett from w_g_tab0
end type
type cb_chiudi from statictext within w_pl_barcode_dett
end type
type cb_togli from statictext within w_pl_barcode_dett
end type
type cb_pilota_UFO from statictext within w_pl_barcode_dett
end type
type cb_aggiungi from statictext within w_pl_barcode_dett
end type
type cb_file from statictext within w_pl_barcode_dett
end type
type dw_modifica from uo_dw_modifica_giri_barcode within w_pl_barcode_dett
end type
type dw_groupage from uo_d_std_1 within w_pl_barcode_dett
end type
type dw_barcode from uo_d_std_1 within w_pl_barcode_dett
end type
type dw_periodo from uo_d_std_1 within w_pl_barcode_dett
end type
type dw_meca from uo_d_std_1 within w_pl_barcode_dett
end type
end forward

global type w_pl_barcode_dett from w_g_tab0
integer width = 4027
integer height = 2652
string title = "Piano di Lavorazione"
boolean hscrollbar = true
boolean vscrollbar = true
long backcolor = 16777215
boolean ki_toolbar_window_presente = true
boolean ki_reset_dopo_save_ok = false
cb_chiudi cb_chiudi
cb_togli cb_togli
cb_pilota_UFO cb_pilota_UFO
cb_aggiungi cb_aggiungi
cb_file cb_file
dw_modifica dw_modifica
dw_groupage dw_groupage
dw_barcode dw_barcode
dw_periodo dw_periodo
dw_meca dw_meca
end type
global w_pl_barcode_dett w_pl_barcode_dett

type variables
private string ki_path_risorse 
private constant long ki_dw_groupage_colore = rgb(173,174,222)
//private datastore kdsi_elenco
private datastore kids_meca_orig
//private datawindow kidw_selezionata
private datawindow kidw_x_modifica_giri
private boolean k_dragdrop = false
//private boolean ki_modifica_cicli_enabled = false
private boolean ki_chiudi_PL_enabled = false
private boolean ki_PL_chiuso = false
//private constant char ki_modalita_modifica_scelta_fila="0"
//private constant char ki_modalita_modifica_giri_riga="1"
//private constant char ki_modalita_modifica_giri_righe="2"
//private constant char ki_modalita_modifica_giri_visualizza="3"
private date ki_data_ini 
private date ki_data_fin = today()

private boolean ki_lista_0_modifcato=false
private kuf_pl_barcode kiuf1_pl_barcode

private boolean ki_autirizza_marca_stato_in_attenzione=false


end variables

forward prototypes
private function string cancella ()
private subroutine modifica_giri_riferimento ()
protected subroutine pulizia_righe ()
private subroutine proteggi_giri_barcode ()
protected function integer inserisci ()
protected subroutine stampa ()
private subroutine screma_lista_barcode ()
public subroutine togli_dettaglio ()
protected function boolean dati_modif_1 ()
protected function string dati_modif (string k_titolo)
public subroutine imposta_codice_progr (ref datawindow kdw_1)
private function string aggiorna_tabelle ()
protected subroutine dw_groupage_colore (ref datawindow k_dw)
protected function string check_dati ()
protected function string inizializza ()
private subroutine screma_lista_riferimenti_old ()
private subroutine copia_dettaglio_dw_1_da_dw_2 (ref datawindow kdw_1, ref datawindow kdw_2, integer k_riga1, integer k_riga2)
private function integer check_modifica_giri ()
public subroutine aggiungi_barcode_singolo (ref datawindow kdw_1, ref datawindow kdw_2)
public subroutine aggiungi_barcode_tutti (ref datawindow kdw_1)
protected function string leggi_liste ()
private function st_esito screma_lista_riferimenti ()
public function integer crea_file_pilota ()
private subroutine proteggi_campi ()
private subroutine abilita_chiusura_pl ()
protected subroutine attiva_tasti ()
public subroutine riempi_dettaglio ()
private subroutine abilita_modifica_giri ()
protected subroutine smista_funz (string k_par_in)
protected subroutine attiva_menu ()
private function boolean if_pl_barcode_chiuso ()
private subroutine set_dw_dett_0 (st_tab_pl_barcode kst_tab_pl_barcode)
private subroutine open_elenco_pilota_coda () throws uo_exception
private subroutine open_notepad_documento () throws uo_exception
private subroutine modifica_giri (string k_modalita_modifica_file)
public subroutine aggiungi_grp_rif_intero (ref datawindow kdw_1)
private subroutine copia_dettaglio_dw_grp_da_dw1 (ref datawindow kdw_1, ref datawindow kdw_2, integer k_riga1, integer k_riga2)
public subroutine aggiungi_grp_barcode_singolo (ref datawindow kdw_1, ref datawindow kdw_2)
private subroutine togli_figli_al_dw_groupage (st_tab_barcode kst_tab_barcode)
private subroutine aggiungi_figli_al_dw_groupage (st_tab_barcode kst_tab_barcode)
public subroutine togli_barcode_padre (ref datawindow kdw_1)
public subroutine togli_barcode_figlio (ref datawindow kdw_1)
private subroutine scegli_padre_da_dw_lista (long k_riga_dw_groupage)
private subroutine call_elenco_barcode_padri_potenziali (long k_riga_dw_groupage)
private subroutine aggiungi_barcode_padre (st_tab_barcode kst_tab_barcode)
private function integer call_window_barcode ()
private subroutine aggiungi_figli_dal_dw_lista ()
private subroutine copia_dettaglio_dw1_da_dw_grp (ref datawindow kdw_1, ref datawindow kdw_2, integer k_riga1, integer k_riga2)
private function st_esito retrieve_figlio_nel_dw_groupage (st_tab_barcode kst_tab_barcode)
private function st_esito retrieve_padre_nel_dw_lista (st_tab_barcode kst_tab_barcode)
private function st_esito retrieve_padri ()
private function st_esito retrieve_figli ()
private subroutine tasto_refresh ()
protected function st_esito aggiorna_window ()
private subroutine cambia_periodo_elenco ()
protected subroutine open_start_window ()
private subroutine rilegge_no_lav ()
public subroutine set_base_data_ini ()
private subroutine open_elenco_lettore_grp ()
public subroutine set_stato_in_attenzione ()
private subroutine autorizza_stato_in_attenzione ()
public subroutine call_elenco_grp ()
protected function boolean if_programazione_ok () throws uo_exception
private subroutine chiudi_pl_elabora () throws uo_exception
private function integer chiudi_pl ()
private function integer apri_pl ()
private subroutine apri_pl_elabora () throws uo_exception
end prototypes

private function string cancella ();//
string k_return="0 "
string k_desc
long k_codice
string k_errore = "0 ", k_errore1 = "0 "
long k_riga
kuf_pl_barcode  kuf1_pl_barcode
st_tab_pl_barcode kst_tab_pl_barcode

//=== Controllo se sul dettaglio c'e' qualche cosa
k_riga = dw_dett_0.rowcount()	
if k_riga > 0 then
	k_codice = dw_dett_0.getitemnumber(1, "codice")
	k_desc = dw_dett_0.getitemstring(1, "note_1")
end if

if k_riga > 0 and isnull(k_codice) = false then	
	if isnull(k_desc) = true or trim(k_desc) = "" then
		k_desc = "senza note " 
	end if
	
//=== Richiesta di conferma della eliminazione del rek

	if messagebox("Elimina Piano di Lavorazione", "Sei sicuro di voler Cancellare : ~n~r" + &
				string(k_codice, "####0") + " " + trim(k_desc), &
				question!, yesno!, 1) = 1 then
 
//=== Creo l'oggetto che ha la funzione x cancellare la tabella
		kuf1_pl_barcode = create kuf_pl_barcode
		
//=== Cancella la riga dal data windows di lista
		kst_tab_pl_barcode.codice = k_codice
		k_errore = kuf1_pl_barcode.tb_delete(kst_tab_pl_barcode) 
		if Left(k_errore, 1) = "0" then

			k_errore = kuf1_data_base.db_commit()
			if Left(k_errore, 1) <> "0" then
				messagebox("Problemi durante la Cancellazione !!", &
						"Controllare i dati. " + Mid(k_errore, 2))

			else
				
				dw_dett_0.deleterow(k_riga)

			end if

			dw_dett_0.setfocus()

		else
			k_errore1 = k_errore
			k_errore = kuf1_data_base.db_rollback()

			messagebox("Problemi durante Cancellazione - Operazione fallita !!", &
							Mid(k_errore1, 2) ) 	
			if Left(k_errore, 1) <> "0" then
				messagebox("Problemi durante il recupero dell'errore !!", &
					"Controllare i dati. " + Mid(k_errore, 2))
			end if

			attiva_tasti()
	

		end if

//=== Distruggo l'oggetto che ha avuto la funzione x cancellare la tabella
		destroy kuf1_pl_barcode

	else
		messagebox("Elimina P. L.", "Operazione Annullata !!")
	end if

	dw_dett_0.setcolumn(1)

end if

return(k_return)
end function

private subroutine modifica_giri_riferimento ();
end subroutine

protected subroutine pulizia_righe ();//
//=== STANDARD MODIFICABILE 
//=== Oltre a confermare ACCEPTTEXT toglie righe da non UPDATE
//
string k_key
long k_riga, k_ctr


dw_dett_0.accepttext()
dw_lista_0.accepttext()
dw_groupage.accepttext()


//=== Pulisco eventuali righe rimaste vuote e aggiusto campi a NULL
k_riga = dw_dett_0.rowcount ( )
for k_ctr = k_riga to 1 step -1

 	if (isnull(dw_dett_0.getitemnumber(k_ctr, "codice") ) or dw_dett_0.getitemnumber(k_ctr, "codice") = 0) and &
 		(isnull(dw_dett_0.getitemdate(k_ctr, "data") ) or dw_dett_0.getitemdate(k_ctr, "data") = date(0)) and &
 		(isnull(dw_dett_0.getitemstring(k_ctr, "note_1") ) or Len(trim(dw_dett_0.getitemstring(k_ctr, "note_1") )) = 0) and &
 		(isnull(dw_dett_0.getitemstring(k_ctr, "note_2") ) or Len(trim(dw_dett_0.getitemstring(k_ctr, "note_2") )) = 0) &
	 	then
		dw_dett_0.deleterow(k_ctr)
	end if
next
if dw_dett_0.rowcount( ) <= 0 then
	inserisci()
end if

//=== Pulisco eventuali righe rimaste vuote e aggiusto campi a NULL
k_riga = dw_lista_0.rowcount ( )
for k_ctr = k_riga to 1 step -1
	k_key = dw_lista_0.getitemstring(k_ctr, "barcode_barcode") 
 	if isnull(k_key) or Len(trim(k_key)) = 0 then
		dw_lista_0.deleterow(k_ctr)
	end if
next

//=== Pulisco eventuali righe rimaste vuote e aggiusto campi a NULL
k_riga = dw_groupage.rowcount ( )
for k_ctr = k_riga to 1 step -1
	k_key = dw_groupage.getitemstring(k_ctr, "barcode_barcode") 
 	if isnull(k_key) or Len(trim(k_key)) = 0 then
		dw_groupage.deleterow(k_ctr)
	end if
next



end subroutine

private subroutine proteggi_giri_barcode ();//
//=== Proteggo giri barcode in groupage
//dw_groupage.Object.barcode_fila_1.TabSequence='0'
//dw_groupage.Object.barcode_fila_2.TabSequence='0'

end subroutine

protected function integer inserisci ();//
st_tab_pl_barcode kst_tab_pl_barcode


	ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento

//=== Pulizia della riga
	dw_dett_0.reset()
	dw_lista_0.reset()
	dw_groupage.reset()

//=== Aggiunge una riga al data windows
	dw_dett_0.insertrow(0)

//--- setta i dati di default del pl_barcode
	kiuf1_pl_barcode.set_pl_barcode_nuovo_default(kst_tab_pl_barcode)
	set_dw_dett_0(kst_tab_pl_barcode)


	dw_dett_0.setcolumn("data")


//=== Posiziona il cursore sul Data Windows
	dw_dett_0.setfocus() 

	attiva_tasti()

	proteggi_campi()

//--- rilegge le liste utili al nuovo programma da fare
	dw_meca.setfocus( )
	leggi_liste()


return (0)


end function

protected subroutine stampa ();//
string k_nome_controllo = " "
st_stampe kst_stampe
w_g_tab kwindow_1


//k_nome_controllo = kuf1_data_base.u_getfocus_nome()

k_nome_controllo = kidw_selezionata.dataobject 

choose case k_nome_controllo
	case "d_pl_barcode_dett_1"
	
		kwindow_1 = kuf1_data_base.prendi_win_attiva()
	
		kst_stampe.dw_print = dw_lista_0
		kst_stampe.titolo = ("Barcode in lavorazione nel P.L. " + string(dw_dett_0.getitemnumber(1, "codice")))
		kuf1_data_base.stampa_dw(kst_stampe)

	case "d_pl_barcode_dett_grp_all"
	
		kwindow_1 = kuf1_data_base.prendi_win_attiva()
	
		kst_stampe.dw_print = dw_groupage
		kst_stampe.titolo = ("Barcode in 'groupage' nel P.L. " + string(dw_dett_0.getitemnumber(1, "codice")))
		kuf1_data_base.stampa_dw(kst_stampe)

	case "d_meca_barcode_elenco_no_lav"
	
		kwindow_1 = kuf1_data_base.prendi_win_attiva()
	
		kst_stampe.dw_print = dw_meca
		kst_stampe.titolo = trim(dw_meca.title)
		kuf1_data_base.stampa_dw(kst_stampe)
		
	case "d_barcode_l_no_pl"
	
		kwindow_1 = kuf1_data_base.prendi_win_attiva()
	
		kst_stampe.dw_print = dw_barcode
		kst_stampe.titolo = trim(dw_barcode.title)
		kuf1_data_base.stampa_dw(kst_stampe)
		
end choose

end subroutine

private subroutine screma_lista_barcode ();//
//=== Screma nella dw_barcode eventuali righe gia' presenti nella dw_lista e dw_groupage ma non ancora confermate
//===  
//
long k_riga, k_riga_find=0, k_trovati, k_presenti
int k_ctr, k_rc
string k_barcode

	
	
	k_riga = 1
	do while k_riga <= dw_barcode.rowcount() 
		
		k_barcode = trim(dw_barcode.getitemstring ( k_riga, "barcode_barcode"))

		k_riga_find = dw_lista_0.find("barcode_barcode = '" + trim(string(k_barcode)) + "' ", 1, dw_lista_0.rowcount()) 
//--- Conto i codici barcode
		if k_riga_find > 0 then 
			dw_barcode.deleterow( k_riga) 
		else

			k_riga_find = dw_groupage.find("barcode_barcode = '" + trim(string(k_barcode)) + "' ", 1, dw_groupage.rowcount()) 
//--- Conto i codici barcode
			if k_riga_find > 0 then 
				dw_barcode.deleterow( k_riga) 
			else
				k_riga++
			end if
		end if
		
	loop
	



end subroutine

public subroutine togli_dettaglio ();//
//=== 
//
long k_riga
long k_num_int
date k_data_int
int k_rc

if dw_barcode.rowcount() > 0 then
		
	k_num_int = dw_barcode.getitemnumber(1, "barcode_num_int")	
		
	k_rc = dw_barcode.reset() 

	leggi_liste()
	
	k_riga = dw_meca.find("meca_num_int = " + string(k_num_int), 1, dw_meca.rowcount()) 
	
	if k_riga > 0 then
		dw_meca.scrolltorow(k_riga)
		dw_meca.selectrow(0, false)
		dw_meca.selectrow(k_riga, true)
	end if
	
end if
	

//--- Riempe il titolo della dw di dettaglio
if dw_barcode.rowcount() > 0 then
	dw_barcode.title = "Dettaglio Riferimento: " + string(dw_barcode.getitemnumber(1, "barcode_num_int"))
else
	dw_barcode.title = "Dettaglio Riferimento " 
end if



end subroutine

protected function boolean dati_modif_1 ();//
//--- dati modificati?
//--- true=si; false=no
//
boolean k_boolean = false


	if dw_dett_0.dati_modificati() then
	if dw_lista_0.dati_modificati() then
	if dw_groupage.dati_modificati() then
	if ki_lista_0_modifcato then
		
		k_boolean = true
		
	end if
	end if
	end if
	end if
			
return k_boolean
	
end function

protected function string dati_modif (string k_titolo);//=== Controllo se ci sono state modifiche di dati sui DW
string k_return="0 "
int k_msg
string k_key


	dw_dett_0.accepttext()

//=== Toglie le righe eventualmente da non registrare
	pulizia_righe()

//	if cb_aggiorna.enabled then
		
//		if dw_dett_0.getnextmodified ( 0, primary!) > 0 or &
//			dw_dett_0.getnextmodified ( 0, filter!) > 0 or &		
//			dw_lista_0.getnextmodified ( 0, primary!) > 0 or &
//			dw_lista_0.getnextmodified ( 0, filter!) > 0 or & 
//			dw_groupage.getnextmodified ( 0, primary!) > 0 or &
//			dw_groupage.getnextmodified ( 0, filter!) > 0 then		

		if dati_modif_1() then
			
			k_return = "1"
	
			if isnull(k_titolo) or Len(trim(k_titolo)) = 0 then
				k_titolo = "Aggiorna Archivio"
			end if
	
			k_msg = messagebox(k_titolo, "Dati Modificati, vuoi Salvare gli Aggiornamenti ?", &
								question!, yesnocancel!, 1) 
		
			k_return = string(k_msg, "0")
			
		end if
//	end if

return k_return
end function

public subroutine imposta_codice_progr (ref datawindow kdw_1);//
//=== Imposta nella lista dw_lista i progressivi del dettaglio del P.L.
//
long k_riga, k_pl_barcode=0, k_progr, k_progr_old



						
//--- Risistema i progressivi		
	if dw_dett_0.getrow() > 0 then
		k_pl_barcode = dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice")
	end if
	if isnull(k_pl_barcode) then
		k_pl_barcode = 0
	end if
	
	for k_riga = 1 to kdw_1.rowcount() 
		kdw_1.setitem(k_riga, "barcode_pl_barcode", k_pl_barcode)
		k_progr = k_riga 
		k_progr_old = kdw_1.getitemnumber(k_riga, "barcode_pl_barcode_progr")
		if k_progr_old <> k_progr or isnull(k_progr_old) then
			ki_lista_0_modifcato = true
			kdw_1.setitem(k_riga, "barcode_pl_barcode_progr", k_progr)
		end if
	next


end subroutine

private function string aggiorna_tabelle ();//
//=== Update delle Tabelle
string k_return = "0 "
long k_riga, k_pl_barcode, k_n_righe
int k_rc
kuf_pl_barcode kuf1_pl_barcode
kuf_barcode kuf1_barcode
st_tab_pl_barcode kst_tab_pl_barcode
st_tab_barcode kst_tab_barcode
st_esito kst_esito, kst_esito_null



	if dw_dett_0.getnextmodified ( 0, primary!) > 0 or &
		dw_dett_0.getnextmodified ( 0, filter!) > 0 then		

		if ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento then
			dw_dett_0.setitemstatus(1, 0, primary!, NewModified!)
		end if
		
		kst_tab_pl_barcode.codice = dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice")			
		kst_tab_pl_barcode.data = dw_dett_0.getitemdate(dw_dett_0.getrow(), "data")			
		kst_tab_pl_barcode.data_chiuso = date(0) //dw_dett_0.getitemdate(dw_dett_0.getrow(), "data_chiuso")			
		kst_tab_pl_barcode.data_sosp = dw_dett_0.getitemdate(dw_dett_0.getrow(), "data_sosp")			
		kst_tab_pl_barcode.note_1 = dw_dett_0.getitemstring(dw_dett_0.getrow(), "note_1")			
		kst_tab_pl_barcode.note_2 = dw_dett_0.getitemstring(dw_dett_0.getrow(), "note_2")			
		kst_tab_pl_barcode.stato = dw_dett_0.getitemstring(dw_dett_0.getrow(), "stato")			
		kst_tab_pl_barcode.priorita = dw_dett_0.getitemstring(dw_dett_0.getrow(), "priorita")			
		kst_tab_pl_barcode.prima_del_barcode = dw_dett_0.getitemstring(dw_dett_0.getrow(), "prima_del_barcode")			
		kst_tab_pl_barcode.x_datins  = dw_dett_0.getitemdatetime(dw_dett_0.getrow(), "x_datins")			
		kst_tab_pl_barcode.x_utente = dw_dett_0.getitemstring(dw_dett_0.getrow(), "x_utente")			
		
		kuf1_pl_barcode = create kuf_pl_barcode
		kst_esito = kuf1_pl_barcode.tb_update( kst_tab_pl_barcode ) 
		destroy kuf1_pl_barcode
		
		if kst_tab_pl_barcode.codice > 0 then
			k_rc=dw_dett_0.setitem(dw_dett_0.getrow(), "codice",kst_tab_pl_barcode.codice)	
		end if

		if kst_esito.esito <> "0" then
	
			if kst_esito.esito = "1" then
				k_return = trim(kst_esito.esito) &
				           + trim(kst_esito.sqlerrtext) &
				           + "~r~n(sqlcode=" + string(kst_esito.sqlcode) + ")" &
							  + "~r~nP.L. da aggiornare non trovato! "
			else
				k_return = trim(kst_esito.esito) &
				           + trim(kst_esito.sqlerrtext) &
				           + "~r~n(sqlcode=" + string(kst_esito.sqlcode) + ")" &
							  + "~r~ndurante aggiornamento P.L.! "
			end if
	
			rollback using sqlca;
	
		else

			commit using sqlca;

			if sqlca.sqlcode <> 0 then
				k_return = "1" + string(sqlca.sqlcode, "000") + trim(SQLCA.SQLErrText)
			else	
				dw_dett_0.resetupdate()
			end if					
					
		end if
	end if
			
	if Left(k_return,1) = "0" then
//		if dw_lista_0.getnextmodified ( 0, primary!) > 0 or &
//			dw_lista_0.getnextmodified ( 0, filter!) > 0 then		

			k_pl_barcode = dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice")	
			if k_pl_barcode > 0 then
	
//				dw_dett_0.setitem(dw_dett_0.getrow(), "codice", k_pl_barcode)			
	
				kuf1_barcode = create kuf_barcode
	
				kst_tab_barcode.pl_barcode = k_pl_barcode		
				k_return = kuf1_barcode.togli_pl_barcode_all( kst_tab_barcode ) 
	
				if Left(k_return,1) = "0" then

					kst_esito = kst_esito_null
					kst_esito.esito = "0"
					k_n_righe = dw_lista_0.rowcount()
					k_riga = 1 
					do while k_riga <= k_n_righe and kst_esito.esito = kkg_esito_ok
		
						dw_lista_0.setitem(k_riga, "barcode_pl_barcode", k_pl_barcode)
		
						kst_tab_barcode.barcode = trim(dw_lista_0.getitemstring(k_riga, "barcode_barcode"))
//						kst_tab_barcode.data_lav_ini = kst_tab_pl_barcode.data_chiuso
//						kst_tab_barcode.groupage = "N" 
//						kst_tab_barcode.fila_1 = dw_lista_0.getitemnumber(k_riga, "barcode_fila_1")			
//						kst_tab_barcode.fila_2 = dw_lista_0.getitemnumber(k_riga, "barcode_fila_2")			
//						kst_tab_barcode.fila_1p = dw_lista_0.getitemnumber(k_riga, "barcode_fila_1p")			
//						kst_tab_barcode.fila_2p = dw_lista_0.getitemnumber(k_riga, "barcode_fila_2p")			
						kst_tab_barcode.pl_barcode = dw_lista_0.getitemnumber(k_riga, "barcode_pl_barcode")			
						kst_tab_barcode.pl_barcode_progr = dw_lista_0.getitemnumber(k_riga, "barcode_pl_barcode_progr")			
//						kst_tab_barcode.x_datins  = dw_lista_0.getitemdatetime(k_riga, "barcode_x_datins")			
//						kst_tab_barcode.x_utente = trim(dw_lista_0.getitemstring(k_riga, "barcode_x_utente"))
			
						kst_esito = kuf1_barcode.set_pl_barcode( kst_tab_barcode, "normale") 
						
						k_riga++ 
						 
					loop

					k_n_righe = dw_groupage.rowcount()
					k_riga = 1 
					do while k_riga <= k_n_righe and trim(kst_esito.esito) = "0"
		
						dw_groupage.setitem(k_riga, "barcode_pl_barcode", k_pl_barcode)
		
						kst_tab_barcode.barcode = trim(dw_groupage.getitemstring(k_riga, "barcode_barcode"))
//						kst_tab_barcode.data_lav_ini = kst_tab_pl_barcode.data_chiuso
//						kst_tab_barcode.groupage = "S" 
//						kst_tab_barcode.fila_1 = dw_groupage.getitemnumber(k_riga, "barcode_fila_1")			
//						kst_tab_barcode.fila_2 = dw_groupage.getitemnumber(k_riga, "barcode_fila_2")			
//						kst_tab_barcode.fila_1p = dw_groupage.getitemnumber(k_riga, "barcode_fila_1p")			
//						kst_tab_barcode.fila_2p = dw_groupage.getitemnumber(k_riga, "barcode_fila_2p")			
						kst_tab_barcode.pl_barcode = dw_groupage.getitemnumber(k_riga, "barcode_pl_barcode")			
						kst_tab_barcode.pl_barcode_progr = dw_groupage.getitemnumber(k_riga, "barcode_pl_barcode_progr")			
//						kst_tab_barcode.x_datins  = dw_groupage.getitemdatetime(k_riga, "x_datins")			
//						kst_tab_barcode.x_utente = trim(dw_groupage.getitemstring(k_riga, "x_utente"))
			
						kst_esito = kuf1_barcode.set_pl_barcode( kst_tab_barcode, "normale") 
						
						k_riga++ 
						
					loop

					k_return = trim(kst_esito.esito) + kst_esito.sqlerrtext &
					           + " (" + string(kst_esito.sqlcode) + ") "
					
					
				end if

				destroy kuf1_barcode
	
				if Left(k_return,1) <> "0" then
				
					if Left(k_return,1) = "1" then
						k_return = k_return + "~r~n(Barcode da aggiornare non trovato!) "
					else
						k_return = k_return + "~r~n(durante aggiornamento Barcode!) "
					end if
			
					rollback using sqlca;
	
				else
			
					commit using sqlca;

					if sqlca.sqlcode <> 0 then
						k_return = "1" + string(sqlca.sqlcode, "000") + trim(SQLCA.SQLErrText)
					else	
						ki_lista_0_modifcato = false
						dw_lista_0.resetupdate()
						dw_groupage.resetupdate()
					end if					
					
				end if
			else
	
				k_return = "1Errore aggiornamento Fallito: manca codice P.L."
	
			end if
//		end if		
	end if

return k_return


end function

protected subroutine dw_groupage_colore (ref datawindow k_dw);//---
//--- Cambia il colore della DW GROUPAGE
//---
int k_rc
int k_ctr, k_colcount
string  k_rcx, k_str, k_string
//long k_num


	
	k_dw.modify("DataWindow.Color='" + string(ki_dw_groupage_colore) + "' " )	
	k_dw.modify("k_contati.Background.Color='" + string(ki_dw_groupage_colore) + "' " )	
//	k_dw.modify("k_fila_1.Background.Color='" + string(ki_dw_groupage_colore) + "' " )	
//	k_dw.modify("k_fila_2.Background.Color='" + string(ki_dw_groupage_colore) + "' " )	
//	k_dw.modify("k_fila_1p.Background.Color='" + string(ki_dw_groupage_colore) + "' " )	
//	k_dw.modify("k_fila_2p.Background.Color='" + string(ki_dw_groupage_colore) + "' " )	
//	k_dw.modify("k_pedane.Background.Color='" + string(ki_dw_groupage_colore) + "' " )	

	k_colcount = integer(k_dw.Describe("DataWindow.Column.Count"))


	for k_ctr = 1 to k_colcount 

//--- estrae nome colonna
//		k_nome = trim(k_dw.Describe("#" + trim(string(k_ctr,"###")) + ".name"))

//--- copia Proprieta' VISIBLE
		k_rcx=k_dw.modify("#" + trim(string(k_ctr,"###")) + ".backgroundcolor = '" &
		                        + string(ki_dw_groupage_colore) &
										+ "' " )
		
	next




end subroutine

protected function string check_dati ();//=== Controllo congruenza dei dati caricati. 
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//
//=== Controllo dati inseriti
string k_return = " ", k_errore="0", k_barcode=""
date k_data, k_data_chiuso, k_dataoggi
int k_nr_errori, k_pl_barcode_progr 
long k_riga, k_nr_righe, k_riga_find, k_riga_find_1, k_riga_ds
st_esito kst_esito
st_tab_barcode kst_tab_barcode_padre, kst_tab_barcode_figlio, kst_tab_barcode
kuf_barcode kuf1_barcode
ds_pl_barcode_dett kds_pl_barcode_dett
st_tab_pl_barcode kst_tab_pl_barcode


	kds_pl_barcode_dett = create ds_pl_barcode_dett
	kuf1_barcode = create kuf_barcode

	dw_lista_0.accepttext()
	dw_groupage.accepttext()
	

	k_riga = dw_dett_0.getrow() 

	if isnull(dw_dett_0.getitemnumber(k_riga, "codice")) then
		dw_dett_0.setitem(k_riga, "codice", 0)
	end if



	k_data = dw_dett_0.getitemdate ( k_riga, "data") 
	if isnull(k_data) or k_data = date(0) then
		k_return = k_return + & 
		   "Manca la Data del P.L.  " + "~n~r"
		k_errore = "3"
	end if

//--- controllo se PL ancora aperto altrimenti NISBA
	try 
		kst_tab_pl_barcode.codice = dw_dett_0.object.codice[1]
		if kst_tab_pl_barcode.codice > 0 then
			if not kiuf1_pl_barcode.if_pl_barcode_aperto(kst_tab_pl_barcode) then
				ki_st_open_w.flag_modalita = kkg_flag_modalita_visualizzazione   // forza visualizzazione
				k_return = k_return + & 
					"Piano di Lavorazione NON APERTO, operazione bloccata! Prego uscire Immediatamente.  " + "~n~r"
				k_errore = "1"
			end if
		end if
	catch (uo_exception kuo1_exception)
		kst_esito = kuo1_exception.get_st_esito()
		k_return = k_return + "Errore: " + trim(kst_esito.sqlerrtext)  + "~n~r"
		k_errore = "1"
	end try
		

	k_data_chiuso = dw_dett_0.getitemdate ( k_riga, "data_chiuso") 
	if Left(k_errore,1) = "0" or Left(k_errore,1) = "4" then
		if isnull(k_data_chiuso) or k_data_chiuso = date(0) then
//			dw_dett_0.setitem ( k_riga, "data_chiuso", k_data)
		else
			if dw_dett_0.getitemdate ( k_riga, "data") > k_data_chiuso then
 				k_return = k_return + & 
			  "Data di Chiusura " + string(k_data_chiuso) + " minore della data del P.L. " + "~n~r" 
				k_errore = "3"
			end if
		end if
	end if

	if Left(k_errore,1) = "0" then
		k_dataoggi = kg_dataoggi
		if k_dataoggi > kkg_data_zero then
			if dw_dett_0.getitemdate ( k_riga, "data") <> k_dataoggi then
 				k_return = k_return + "Data del P.L. diversa dalla data odierna ( " + string(k_dataoggi) +" )~n~r" 
				k_errore = "4"
			end if
			k_data_chiuso = dw_dett_0.getitemdate ( k_riga, "data_chiuso") 
			if k_data_chiuso > kkg_data_zero and k_data_chiuso <> k_dataoggi then
 				k_return = k_return + "Data di Chiusura del P.L. diversa dalla data odierna ( " + string(k_dataoggi) +" )~n~r" 
				k_errore = "4"
			end if
		end if
	end if


	if Left(k_errore,1) = "0" then
		if dw_dett_0.getitemdate ( k_riga, "data_sosp") > k_data_chiuso then
 			k_return = k_return + "Data Sospensione maggiore della data di Chiusura  del " + string(k_data_chiuso) + " " + "~n~r" 
			k_errore = "4"
		end if
	end if

//--- controllo la priorita se congruente con il valore nel campo 'pima del barcode'
	if Left(k_errore,1) = "0" or Left(k_errore,1) = "4" then
		if trim(dw_dett_0.getitemstring ( k_riga, "priorita")) = kiuf1_pl_barcode.k_priorita_prima_del_barcode then
			if Len(trim(dw_dett_0.getitemstring ( k_riga, "prima_del_barcode"))) = 0 then
 				k_return = k_return + "Dati errati, indicare il campo 'Prima del Barcode'   " + "~n~r" 
				k_errore = "2"
			end if
		else
			dw_dett_0.setitem ( k_riga, "prima_del_barcode", " ")
		end if
	end if

	if Left(k_errore,1) = "0" or Left(k_errore,1) = "4" then
	
		dw_dett_0.setitem(k_riga, "x_datins", today())
		dw_dett_0.setitem(k_riga, "x_utente", "Pwd:"+string(kg_pwd, "##0"))
		
	end if



//---- Controllo Barcode PADRI
	if Left(k_errore,1) = "0" or Left(k_errore,1) = "4" then

//--- Rileggo i dati di trattamento dei barcode figli
		kst_esito = retrieve_padri()
		if kst_esito.esito <> kkg_esito_ok then
			if kst_esito.esito = kkg_esito_db_wrn then
				k_return = k_return  & 
									  + trim(kst_esito.sqlerrtext ) + ";~n~r" 
				k_errore = "4"
				k_nr_errori++
			else
				k_return = k_return  & 
									  + trim(kst_esito.sqlerrtext ) + ";~n~r" 
				k_errore = "1"
				k_nr_errori++
			end if
		end if
	end if
	
	if Left(k_errore,1) = "0" or Left(k_errore,1) = "4" then

//--- 04.02.2009 Controllo che i Barcode non siano già stati caricati con altro Piano di Trattamento
		k_riga = dw_lista_0.rowcount()
		k_nr_errori = 0
	
		do while k_nr_righe > 0 and k_nr_errori < 10
	
			k_pl_barcode_progr = dw_lista_0.getitemnumber ( k_riga, "barcode_pl_barcode_progr")
			k_barcode = string(dw_lista_0.getitemstring ( k_riga, "barcode_barcode"))

			kst_tab_barcode.barcode = k_barcode
			kst_esito = kuf1_barcode.get_pl_barcode(kst_tab_barcode)
			if kst_esito.esito <> kkg_esito_ok then
				k_return = k_return + trim(kst_esito.sqlerrtext) + "~n~r"
				k_errore = "1"
			else
//---- se codice Piano presente e diverso da questo che sto caricando allora GRAVE! 
				if kst_tab_barcode.pl_barcode > 0 and kst_tab_barcode.pl_barcode <> kst_tab_pl_barcode.codice then
					k_return = k_return  & 
							  + "Il Barcode "+ trim(k_barcode) +" è già presente nel Piano " + string(kst_tab_barcode.pl_barcode) + ". Lo elimino dalla LISTA~n~r" 
					k_errore = "1"
					k_nr_errori++
					
					dw_lista_0.deleterow(k_riga)  // Elimino la riga gia associata ad altro Piano dalla Lista!!!
					
				end if
				
			end if					
		
			k_riga --
	
		loop

			
//--- altri controlli
		k_nr_righe = dw_lista_0.rowcount()
		k_nr_errori = 0
		k_riga_find = 0 
		k_riga = 1 //dw_lista_0.getnextmodified(0, primary!)
	
		do while k_nr_righe > k_riga and k_nr_errori < 10
	
			k_pl_barcode_progr = dw_lista_0.getitemnumber ( k_riga, "barcode_pl_barcode_progr")

//--- Controllo codici doppi
			if k_riga_find = 0 then
				k_barcode = string(dw_lista_0.getitemstring ( k_riga, "barcode_barcode"))
				k_riga_find = dw_lista_0.find("barcode_barcode = '" + trim(k_barcode) + "' ", k_riga + 1, dw_lista_0.rowcount()) 
				if k_riga_find > 0  then
					k_return = k_return  & 
								  + "Stesso Barcode presente in piu' righe, " + "~n~r" &
								  + "(Codice " + trim(k_barcode) + ") vedi alla riga " + string(k_riga_find) + "; ~n~r"
					k_errore = "1"
					k_nr_errori++
				end if
			end if
			
//--- Tolgo valori a null dai giri
			if isnull(dw_lista_0.getitemnumber ( k_riga, "barcode_fila_1")) then
				dw_lista_0.setitem ( k_riga, "barcode_fila_1", 0)
			end if
			if isnull(dw_lista_0.getitemnumber ( k_riga, "barcode_fila_1p")) then
				dw_lista_0.setitem ( k_riga, "barcode_fila_1p", 0)
			end if
			if isnull(dw_lista_0.getitemnumber ( k_riga, "barcode_fila_2")) then
				dw_lista_0.setitem ( k_riga, "barcode_fila_2", 0)
			end if
			if isnull(dw_lista_0.getitemnumber ( k_riga, "barcode_fila_2p")) then
				dw_lista_0.setitem ( k_riga, "barcode_fila_2p", 0)
			end if

			k_riga++ // = dw_lista_0.getnextmodified(k_riga, primary!) 
	
		loop

	end if


//---- Controllo Barcode FIGLI ------------------------------------------------------------------------------------
	if Left(k_errore,1) = "0" or Left(k_errore,1) = "4" then

//--- Aggiungo eventuali Figli nati all'insaputa fuori da questo pianificazione
		aggiungi_figli_dal_dw_lista()

//--- Rileggo i dati di trattamento dei barcode figli
		kst_esito = retrieve_figli()
		if kst_esito.esito <> kkg_esito_ok then
			if kst_esito.esito = kkg_esito_db_wrn then
				k_return = k_return  & 
									  + trim(kst_esito.sqlerrtext ) + ";~n~r" 
				k_errore = "4"
				k_nr_errori++
			else
				k_return = k_return  & 
									  + trim(kst_esito.sqlerrtext ) + ";~n~r" 
				k_errore = "1"
				k_nr_errori++
			end if
		end if
		
	end if

	if Left(k_errore,1) = "0" or Left(k_errore,1) = "4" then
		k_nr_righe = dw_groupage.rowcount()
		k_nr_errori = 0
		k_riga_find = 0 
		k_riga_find_1 = 0 
		k_riga = 1 

	
		do while k_nr_righe > k_riga and k_nr_errori < 10
	
//--- Controllo codici doppi
			if k_riga_find = 0 then
				k_barcode = string(dw_groupage.getitemstring ( k_riga, "barcode_barcode"))
				k_riga_find = dw_groupage.find("barcode_barcode = '" + trim(k_barcode) + "' ", k_riga + 1, dw_groupage.rowcount()) 
				if k_riga_find > 0  then
					k_return = k_return  & 
								  + "Stesso 'Figlio' presente su piu' righe, "  &
								  + "(Codice " + trim(k_barcode) + ") vedi alla riga " + string(k_riga_find) + "; ~n~r"
					k_errore = "1"
					k_nr_errori++
				end if
			end if
			
//--- Tolgo valori a null dai giri
			if isnull(dw_groupage.getitemnumber ( k_riga, "barcode_fila_1")) then
				dw_groupage.setitem ( k_riga, "barcode_fila_1", 0)
			end if
			if isnull(dw_groupage.getitemnumber ( k_riga, "barcode_fila_1p")) then
				dw_groupage.setitem ( k_riga, "barcode_fila_1p", 0)
			end if
			if isnull(dw_groupage.getitemnumber ( k_riga, "barcode_fila_2")) then
				dw_groupage.setitem ( k_riga, "barcode_fila_2", 0)
			end if
			if isnull(dw_groupage.getitemnumber ( k_riga, "barcode_fila_2p")) then
				dw_groupage.setitem ( k_riga, "barcode_fila_2p", 0)
			end if

			k_riga++ // = dw_lista_0.getnextmodified(k_riga, primary!) 
	
		loop

	end if

		
	if Left(k_errore,1) = "0" or Left(k_errore,1) = "4" then

//--- sistema il codice e i progressivi nella lista PADRI
		imposta_codice_progr( dw_lista_0 )
			
//--- Risistema l'utente di aggiornamento		
		for k_riga = 1 to dw_lista_0.rowcount() 
			dw_lista_0.setitem(k_riga, "barcode_x_datins", kuf1_data_base.prendi_x_datins())
			dw_lista_0.setitem(k_riga, "barcode_x_utente", kuf1_data_base.prendi_x_utente())
		next

//--- sistema il codice e i progressivi nella lista FIGLI
		imposta_codice_progr( dw_groupage )
			
//--- Risistema l'utente di aggiornamento		
		for k_riga = 1 to dw_groupage.rowcount() 
			dw_groupage.setitem(k_riga, "x_datins", kuf1_data_base.prendi_x_datins())
			dw_groupage.setitem(k_riga, "x_utente", kuf1_data_base.prendi_x_utente())
		next

	end if

if isvalid(kuf1_barcode) then destroy kuf1_barcode
if isvalid(kds_pl_barcode_dett) then destroy kds_pl_barcode_dett

return k_errore + trim(k_return)



end function

protected function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Ritorna 1 chr : 0=Retrieve OK; 1 e 2=Retrieve fallita (2=uscita Window)
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
long k_key
int  k_rc, k_errore = 0
string k_fine_ciclo="", k_rcx
int k_ctr=0
int k_importa=0
date k_data_chiuso, k_data
kuf_utility kuf1_utility
st_tab_pl_barcode kst_tab_pl_barcode
kuf_pl_barcode kuf1_pl_barcode
pointer oldpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

	k_key = long(trim(ki_st_open_w.key1))
	

	dw_lista_0.reset()
	dw_groupage.reset()
	
//	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita_inserimento then
//		
//		k_errore = inserisci()
//		
//	else

		k_rc = dw_dett_0.retrieve(k_key) 

		choose case k_rc

			case is < 0				
				SetPointer(oldpointer)
				messagebox("Operazione fallita", &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(Codice cercato :" + string(k_key) + ")~n~r" )
				cb_ritorna.postevent(clicked!)

//--- nessun codice trovato
			case 0
				SetPointer(oldpointer)
				k_errore = 1
				messagebox("Piano di Lavorazione", &
					"Non e' stato trovato in archivio il P.L. ~n~r" + &
					"(Codice cercato :" + string(k_key) + ")~n~r" )
		
				cb_ritorna.postevent("clicked!")
					
//--- se codice trovato
			case is > 0		
				dw_dett_0.resetupdate()
				
				if dw_lista_0.retrieve(k_key, "N") > 0 then

//--- sistema il codice e i progressivi nella lista
					imposta_codice_progr( dw_lista_0 )
					for k_ctr = 1 to dw_lista_0.rowcount()
						dw_lista_0.setitemstatus(k_ctr, 0, Primary!, notmodified!)
					end for

					dw_lista_0.selectrow(0, false)
					dw_lista_0.setrow(dw_lista_0.rowcount())
					dw_lista_0.selectrow(dw_lista_0.rowcount(), true)
					dw_lista_0.scrolltorow(dw_lista_0.rowcount())
					dw_lista_0.resetupdate()
					ki_lista_0_modifcato=false					
					
				end if

				if dw_groupage.retrieve(k_key) > 0 then

//--- sistema il codice e i progressivi nella lista
					imposta_codice_progr( dw_groupage )
					for k_ctr = 1 to dw_groupage.rowcount()
						dw_groupage.setitemstatus(k_ctr, 0, Primary!, notmodified!)
					end for

					dw_groupage.selectrow(0, false)
					dw_groupage.setrow(dw_groupage.rowcount())
					dw_groupage.selectrow(dw_groupage.rowcount(), true)
					dw_groupage.scrolltorow(dw_groupage.rowcount())
					
				end if
				dw_groupage.resetupdate()
				

		end choose

//	end if


//--- Se PL gia' chiuso allora nessuna modifica possibile, forzo Visualizzazione		
	try
		ki_PL_chiuso = false
		kst_tab_pl_barcode.codice = long(trim(ki_st_open_w.key1))
		if kst_tab_pl_barcode.codice > 0 then
			if not kiuf1_pl_barcode.if_pl_barcode_aperto(kst_tab_pl_barcode) then
				ki_PL_chiuso = true
				ki_st_open_w.flag_modalita = kkg_flag_modalita_visualizzazione
			end if
		end if
		
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
	end try
	

	if ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento or ki_st_open_w.flag_modalita = kkg_flag_modalita_modifica then
		aggiungi_figli_dal_dw_lista()
	end if
	
	if k_errore = 0 then

		if ki_st_open_w.flag_primo_giro = 'S' then

			leggi_liste()
			dw_lista_0.resetupdate()
			ki_lista_0_modifcato=false					
		end if

		dw_meca.setfocus()
		
		attiva_tasti()
		
		proteggi_campi()
		
		
	end if
	
	dw_dett_0.bringtotop = true
	
	SetPointer(oldpointer)



return k_return



end function

private subroutine screma_lista_riferimenti_old ();////
////=== Toglie i BARCODE dalla lista se già messi in lavorazione nella dw_lista e dw_groupage
////=== torna numero barcode trovati 
////
//long k_riga, k_riga_find=0, k_trovati_barcode, k_presenti_meca
//int k_ctr, k_rc, k_fila_1, k_fila_2, k_fila_1p, k_fila_2p
//long k_dose
//long k_num_int
//date k_data_int
//	
//
//	k_trovati_barcode = 0
//
//	k_riga = 1
//	do while k_riga <= dw_meca.rowcount() 
//		
////		k_presenti_meca = dw_meca.getitemnumber( k_riga, "contati" )
//		k_presenti_meca = dw_meca.getitemnumber( k_riga, "contati_orig" )
//		k_num_int = dw_meca.getitemnumber ( k_riga, "meca_num_int")
//		k_data_int = dw_meca.getitemdate(k_riga, "meca_data_int")	
//		k_fila_1 = dw_meca.getitemnumber(k_riga, "barcode_fila_1")	
//		k_fila_2 = dw_meca.getitemnumber(k_riga, "barcode_fila_2")	
//		k_fila_1p = dw_meca.getitemnumber(k_riga, "barcode_fila_1p")	
//		k_fila_2p = dw_meca.getitemnumber(k_riga, "barcode_fila_2p")	
//		k_dose = dw_meca.getitemnumber(k_riga, "armo_dose") * 100	
//		if isnull(k_fila_1) then
//			k_fila_1 = 0
//		end if
//		if isnull(k_fila_2) then
//			k_fila_2 = 0
//		end if
//		if isnull(k_fila_1p) then
//			k_fila_1p = 0
//		end if
//		if isnull(k_fila_2p) then
//			k_fila_2p = 0
//		end if
//		if isnull(k_dose) then
//			k_dose = 0
//		end if
//
//		if dw_lista_0.rowcount() > 0 then
//			k_riga_find = dw_lista_0.find("barcode_num_int = " + trim(string(k_num_int)) + " and " & 
//							  + "barcode_data_int = date('" + string(k_data_int, "dd.mm.yyyy") + "') and " & 
//							  + "barcode_pl_barcode_progr > 0 and " & 
//							  + "armo_dose = " + trim(string(k_dose, "#####0")) + "/ 100 and " & 
//							  + "barcode_fila_1 = " + trim(string(k_fila_1)) + " and " & 
//							  + "barcode_fila_2 = " + trim(string(k_fila_2)) + " and " & 
//							  + "barcode_fila_1p = " + trim(string(k_fila_1p)) + " and " & 
//							  + "barcode_fila_2p = " + trim(string(k_fila_2p)) + "  " & 
//							  , 1, dw_lista_0.rowcount()) 
//
////--- Conto i codici barcode
//			do while k_riga_find > 0 and k_presenti_meca > k_trovati_barcode
//
//				dw_lista_0.setitem( k_riga_find, "barcode_pl_barcode_progr", 0 )
//
//				k_trovati_barcode++
//				k_riga_find++
//				
//				if k_riga_find <= dw_lista_0.rowcount() then
//					k_riga_find = dw_lista_0.find("barcode_num_int = " + trim(string(k_num_int)) + " and " & 
//							  + "barcode_data_int = date('" + string(k_data_int, "dd.mm.yyyy") + "') and " & 
//							  + "barcode_pl_barcode_progr > 0 and " & 
//							  + "armo_dose = " + trim(string(k_dose, "#####0")) + "/ 100 and " & 
//							  + "barcode_fila_1 = " + trim(string(k_fila_1)) + " and " & 
//							  + "barcode_fila_2 = " + trim(string(k_fila_2)) + " and " & 
//							  + "barcode_fila_1p = " + trim(string(k_fila_1p)) + " and " & 
//							  + "barcode_fila_2p = " + trim(string(k_fila_2p)) + "  " & 
//							  , k_riga_find, dw_lista_0.rowcount()) 
//				else
//					k_riga_find = 0
//				end if
//
//			loop
//		end if
//
////		k_trovati_barcode_groupage = 0
//
//		if k_presenti_meca > k_trovati_barcode then
//			if dw_groupage.rowcount() > 0 then
//				k_riga_find = dw_groupage.find("barcode_num_int = " + trim(string(k_num_int)) + " and " & 
//								  + "barcode_data_int = date('" + string(k_data_int, "dd.mm.yyyy") + "') and " & 
//								  + "barcode_pl_barcode_progr > 0 and " & 
//								  + "armo_dose = " + trim(string(k_dose, "#####0")) + "/ 100 and " & 
//								  + "barcode_fila_1 = " + trim(string(k_fila_1)) + " and " & 
//								  + "barcode_fila_2 = " + trim(string(k_fila_2)) + " and " & 
//								  + "barcode_fila_1p = " + trim(string(k_fila_1p)) + " and " & 
//								  + "barcode_fila_2p = " + trim(string(k_fila_2p)) + "  " & 
//								  , 1, dw_groupage.rowcount()) 
//		
//				do while k_riga_find > 0 and k_presenti_meca > k_trovati_barcode
//
//					dw_lista_0.setitem( k_riga_find, "barcode_pl_barcode_progr", 0 )
//
//					k_trovati_barcode++
//					k_riga_find++
//					if k_riga_find <= dw_groupage.rowcount() then
//						k_riga_find = dw_groupage.find("barcode_num_int = " + trim(string(k_num_int)) + " and " & 
//								  + "barcode_data_int = date('" + string(k_data_int, "dd.mm.yyyy") + "') and " & 
//								  + "barcode_pl_barcode_progr > 0 and " & 
//								  + "armo_dose = " + trim(string(k_dose, "#####0")) + "/ 100 and " & 
//								  + "barcode_fila_1 = " + trim(string(k_fila_1)) + " and " & 
//								  + "barcode_fila_2 = " + trim(string(k_fila_2)) + " and " & 
//								  + "barcode_fila_1p = " + trim(string(k_fila_1p)) + " and " & 
//								  + "barcode_fila_2p = " + trim(string(k_fila_2p)) + "  " & 
//								  , k_riga_find, dw_groupage.rowcount()) 
//					else
//						k_riga_find = 0
//					end if
//				loop
//			end if
//		end if
//		
////		k_trovati_barcode = k_trovati_barcode + k_trovati_barcode_groupage 
//		
//		if k_presenti_meca <= k_trovati_barcode then 
//			dw_meca.deleterow( k_riga) 
//		else
//			k_presenti_meca = k_presenti_meca - k_trovati_barcode
//			k_presenti_meca = dw_meca.setitem( k_riga, "contati", k_presenti_meca )
//			k_riga++
//			
//		end if
//
////--- sistema il codice e i progressivi nella lista
//		imposta_codice_progr( dw_lista_0 )
//		imposta_codice_progr( dw_groupage )
//		
//	loop
//	
//


end subroutine

private subroutine copia_dettaglio_dw_1_da_dw_2 (ref datawindow kdw_1, ref datawindow kdw_2, integer k_riga1, integer k_riga2);//---
//--- copia i soliti dati di dettaglio di questa window (barcode, groupage, lista_0) 
//--- parametri: dw1   riceve im dati (in cui copiare)
//---            dw2   da cui copiare
//---            riga1 riga della dw1
//---            riga2 riga della dw2
//---
	
	
			kdw_1.setitem(k_riga1, "barcode_barcode", &
						 kdw_2.getitemstring(k_riga2, "barcode_barcode"))
			kdw_1.setitem(k_riga1, "barcode_tipo_cicli", &
						 kdw_2.getitemstring(k_riga2, "barcode_tipo_cicli"))
			kdw_1.setitem(k_riga1, "barcode_fila_1", &
						 kdw_2.getitemnumber(k_riga2, "barcode_fila_1"))
			kdw_1.setitem(k_riga1, "barcode_fila_2", &
						 kdw_2.getitemnumber(k_riga2, "barcode_fila_2"))
			kdw_1.setitem(k_riga1, "barcode_fila_1p", &
						 kdw_2.getitemnumber(k_riga2, "barcode_fila_1p"))
			kdw_1.setitem(k_riga1, "barcode_fila_2p", &
						 kdw_2.getitemnumber(k_riga2, "barcode_fila_2p"))
			kdw_1.setitem(k_riga1, "barcode_num_int", &
						 kdw_2.getitemnumber(k_riga2, "barcode_num_int"))
			kdw_1.setitem(k_riga1, "barcode_data_int", &
						 kdw_2.getitemdate(k_riga2, "barcode_data_int"))
			kdw_1.setitem(k_riga1, "barcode_data_sosp", &
						 kdw_2.getitemdate(k_riga2, "barcode_data_sosp"))
			kdw_1.setitem(k_riga1, "barcode_data_lav_ini", &
						 kdw_2.getitemdate(k_riga2, "barcode_data_lav_ini"))
			kdw_1.setitem(k_riga1, "barcode_data_lav_fin", &
						 kdw_2.getitemdate(k_riga2, "barcode_data_lav_fin"))
			kdw_1.setitem(k_riga1, "barcode_data_lav_ok", &
						 kdw_2.getitemdate(k_riga2, "barcode_data_lav_ok"))
			kdw_1.setitem(k_riga1, "barcode_x_datins", &
						 kdw_2.getitemdatetime(k_riga2, "barcode_x_datins"))
			kdw_1.setitem(k_riga1, "barcode_x_utente", &
						 kdw_2.getitemstring(k_riga2, "barcode_x_utente"))
			kdw_1.setitem(k_riga1, "sl_pt_tipo_cicli", &
						 kdw_2.getitemstring(k_riga2, "sl_pt_tipo_cicli"))
			kdw_1.setitem(k_riga1, "sl_pt_fila_1", &
						 kdw_2.getitemnumber(k_riga2, "sl_pt_fila_1"))
			kdw_1.setitem(k_riga1, "sl_pt_fila_2", &
						 kdw_2.getitemnumber(k_riga2, "sl_pt_fila_2"))
			kdw_1.setitem(k_riga1, "sl_pt_fila_1p", &
						 kdw_2.getitemnumber(k_riga2, "sl_pt_fila_1p"))
			kdw_1.setitem(k_riga1, "sl_pt_fila_2p", &
						 kdw_2.getitemnumber(k_riga2, "sl_pt_fila_2p"))
			kdw_1.setitem(k_riga1, "armo_dose", &
						 kdw_2.getitemnumber(k_riga2, "armo_dose"))
			kdw_1.setitem(k_riga1, "armo_peso_kg", &
						 kdw_2.getitemnumber(k_riga2, "armo_peso_kg"))
			kdw_1.setitem(k_riga1, "armo_larg_2", &
						 kdw_2.getitemnumber(k_riga2, "armo_larg_2"))
			kdw_1.setitem(k_riga1, "armo_lung_2", &
						 kdw_2.getitemnumber(k_riga2, "armo_lung_2"))
			kdw_1.setitem(k_riga1, "armo_alt_2", &
						 kdw_2.getitemnumber(k_riga2, "armo_alt_2"))
			kdw_1.setitem(k_riga1, "armo_pedane", &
						 kdw_2.getitemnumber(k_riga2, "armo_pedane"))
			kdw_1.setitem(k_riga1, "armo_campione", &
						 kdw_2.getitemstring(k_riga2, "armo_campione"))
			kdw_1.setitem(k_riga1, "armo_art", &
						 kdw_2.getitemstring(k_riga2, "armo_art"))
			kdw_1.setitem(k_riga1, "armo_cod_sl_pt", &
						 kdw_2.getitemstring(k_riga2, "armo_cod_sl_pt"))
			kdw_1.setitem(k_riga1, "armo_id_armo", &
						 kdw_2.getitemnumber(k_riga2, "armo_id_armo"))
			kdw_1.setitem(k_riga1, "meca_area_mag", &
						 kdw_2.getitemstring(k_riga2, "meca_area_mag"))
			kdw_1.setitem(k_riga1, "meca_contratto", &
						 kdw_2.getitemnumber(k_riga2, "meca_contratto"))
			kdw_1.setitem(k_riga1, "meca_clie_3", &
						 kdw_2.getitemnumber(k_riga2, "meca_clie_3"))
			kdw_1.setitem(k_riga1, "contratti_mc_co", &
						 kdw_2.getitemstring(k_riga2, "contratti_mc_co"))
			kdw_1.setitem(k_riga1, "contratti_sc_cf", &
						 kdw_2.getitemstring(k_riga2, "contratti_sc_cf"))
			kdw_1.setitem(k_riga1, "contratti_descr", &
						 kdw_2.getitemstring(k_riga2, "contratti_descr"))
			kdw_1.setitem(k_riga1, "prodotti_des", &
						 kdw_2.getitemstring(k_riga2, "prodotti_des"))
			kdw_1.setitem(k_riga1, "clienti_rag_soc_10", &
						 kdw_2.getitemstring(k_riga2, "clienti_rag_soc_10"))
			kdw_1.setitem(k_riga1, "k_ricevente", &
						 kdw_2.getitemstring(k_riga2, "k_ricevente"))


end subroutine

private function integer check_modifica_giri ();//
//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================

string k_errore_txt = ""
integer k_errore = 0
int k_riga
st_esito kst_esito
st_tab_sl_pt kst_tab_sl_pt
kuf_sl_pt kuf1_sl_pt



//poi prevedere anche il ripristino dei dati originali
//
//=== Controllo il primo tab
	k_riga = dw_modifica.getrow()

	if k_riga > 0 then
		if kidw_x_modifica_giri.classname() <> "dw_meca" &
			and dw_modifica.object.barcode_tipo_cicli.primary[k_riga] = kkg_sl_pt_tipo_cicli_norm_1 &
			then
			dw_modifica.object.barcode_tipo_cicli.primary[k_riga] = kkg_sl_pt_tipo_cicli_norm
		end if
		kst_tab_sl_pt.tipo_cicli = dw_modifica.object.barcode_tipo_cicli.primary[k_riga]
		kst_tab_sl_pt.fila_1 = dw_modifica.object.barcode_fila_1.primary[k_riga]
		kst_tab_sl_pt.fila_2 = dw_modifica.object.barcode_fila_2.primary[k_riga]
		kst_tab_sl_pt.fila_1p = dw_modifica.object.barcode_fila_1p.primary[k_riga]
		kst_tab_sl_pt.fila_2p = dw_modifica.object.barcode_fila_2p.primary[k_riga]

//--- controllo di congruenza dei dati immessi
		kuf1_sl_pt = create kuf_sl_pt
		kst_esito=kuf1_sl_pt.check_formale_giri_in_lav(kst_tab_sl_pt)
		destroy kuf1_sl_pt	
	
		choose case kst_esito.esito
	
			case "1" //errore grave: incongruenze dati
				k_errore = 1 
				messagebox("Digitati dati incongruenti, operazione non eseguita", &
						  trim(kst_esito.sqlerrtext))
				
			case "2" //avvertenza: dati da rivedere
//				if messagebox("Controllare i dati immessi", &
//					trim(kst_esito.sqlerrtext) + &		
//					"~n~rVuoi eseguire comunque l'Aggiornamento ?", &
//					question!, yesno!, 1) = 2 then
//					k_errore = 1 
//				else
//					k_errore = 0
//				end if
				
		end choose

	end if

//
return k_errore 

end function

public subroutine aggiungi_barcode_singolo (ref datawindow kdw_1, ref datawindow kdw_2);//
//=== Aggiungi un BARCODE alla lista dei Pianificati
//===   kdw_2 -----> kdw_1
//
long k_riga, k_insertrow, k_riga_drag, k_riga_ultima=0, k_riga_find=0
long k_num_int, k_pl_barcode
date k_data_int
string k_find
int k_ctr, k_rc
boolean k_elabora=true
st_tab_barcode kst_tab_barcode, kst_tab_barcode_padre
kuf_barcode kuf1_barcode

	

kuf1_barcode = create kuf_barcode

if kdw_2.rowcount() > 0 then
	
	if kdw_1.rowcount() > 0 &
		and kdw_1.getselectedrow(0) > 0 then
		k_insertrow = 1
		k_riga = kdw_1.getselectedrow(0)
	else
		k_riga = 0
		k_insertrow = 0
	end if

	k_riga_drag = kdw_2.getselectedrow(0)

	try 			

		do while k_riga_drag > 0 

			kst_tab_barcode_padre.barcode = kdw_2.object.barcode_barcode[k_riga_drag]
			
//--- NON è possibile mettere tra i padri un FIGLIO!!!			
			if kuf1_barcode.if_barcode_figlio(kst_tab_barcode_padre) then
	
//--- leggo la successiva!
				k_riga_ultima = k_riga
				kdw_2.deleterow(k_riga_drag) 
				k_riga_drag = kdw_2.getselectedrow(k_riga_drag - 1)
				
			else
					
//--- se ciclo normale a scelta devo effettuare prima la scelta
				kuf1_barcode.get_tipo_cicli(kst_tab_barcode_padre)
				if kst_tab_barcode_padre.tipo_cicli = kkg_sl_pt_tipo_cicli_norm_1 then
				
					k_elabora=false

//--- prima di pianificare scegliere i GIRI in modo puntale					
					modifica_giri(dw_modifica.ki_modalita_modifica_scelta_fila)

					k_riga_drag = 0 // forzo uscita ciclo
				
				else
	
					k_riga = kdw_1.insertrow(k_riga + k_insertrow)
				
	//--- copia la dw2 in dw1, il formato e' la solito dettaglio		
					if kdw_2.dataobject = dw_groupage.dataobject then
						copia_dettaglio_dw1_da_dw_grp (kdw_1, kdw_2,  k_riga, k_riga_drag)			
					else
						copia_dettaglio_dw_1_da_dw_2 (kdw_1, kdw_2, k_riga, k_riga_drag)

					end if
					
	//--- se il barcode ha figli li aggiunge al dw_groupage			
	//				aggiungi_figli_al_dw_groupage(kst_tab_barcode_padre)
	
//--- tolgo eventuali legami di Padre (NON PUO' ESSERE FIGLIO!)   HO TOLTO QUESTO POICHE' E' MEGLIO NON METTERE UN FIGLIO QUI
//					kuf1_barcode.tb_togli_da_groupage( kst_tab_barcode_padre)
	
//--- leggo la successiva!
					k_riga_ultima = k_riga
					kdw_2.deleterow(k_riga_drag) 
					k_riga_drag = kdw_2.getselectedrow(k_riga_drag - 1)
				
				end if
			end if

		loop

	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()

	end try 

	if k_riga_ultima > 0 and k_elabora then
		
//--- sistema il codice e i progressivi nella lista
		imposta_codice_progr( kdw_1 )

		kdw_1.selectrow(0, false)
		kdw_1.setrow(k_riga_ultima)
		kdw_1.selectrow(k_riga_ultima, true)
		kdw_1.scrolltorow(k_riga_ultima)
	end if
		
	if k_elabora then

//--- se i barcode in dw_lista hanno figli li aggiunge al dw_groupage			
		aggiungi_figli_dal_dw_lista()
		
		screma_lista_riferimenti()
	end if
		

end if

		
destroy kuf1_barcode


kdw_1.setcolumn(1)
kdw_1.setfocus()

attiva_tasti()


end subroutine

public subroutine aggiungi_barcode_tutti (ref datawindow kdw_1);//
//=== Aggiungi i BARCODE dell'intera entrata alla lista dei Pianificati
//===  dw_meca ------> dw_barcode -----> kdw_1
//
long k_riga, k_insertrow, k_riga_drag, k_riga_meca, k_riga_meca_old, k_riga_posiziona
long k_num_int, k_pl_barcode
date k_data_int
int k_ctr, k_rc
boolean k_elaborazione=true
pointer oldpointer  // Declares a pointer variable
st_esito kst_esito
st_tab_barcode kst_tab_barcode
kuf_barcode kuf1_barcode


//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)

kuf1_barcode = create kuf_barcode

k_riga_posiziona = 0
	
if dw_meca.rowcount() > 0 then

	k_riga_meca = dw_meca.getselectedrow(0)

	if k_riga_meca > 0 then	
		if kdw_1.rowcount() > 0 &
			and kdw_1.getselectedrow(0) > 0 then
			k_insertrow = 1
			k_riga = kdw_1.getselectedrow(0)
			k_riga_posiziona = k_riga
		else
			k_riga = -1
			k_riga_posiziona = -1
			k_insertrow = 1
		end if
	else
		messagebox("Nessuna Operazione Eseguita", "Selezionare una riga dall'elenco." &
					  +"~n~r", StopSign!	  &
					 )

	end if	

	
	do while k_riga_meca > 0 and k_elaborazione
		
		riempi_dettaglio()

		
		if dw_barcode.rowcount() > 0 then
			
			k_riga_drag = 1

			try 

				kst_tab_barcode.barcode = dw_barcode.object.barcode_barcode[k_riga_drag]
			
//--- se ciclo normale a scelta devo effettuare prima la scelta
				kuf1_barcode.get_tipo_cicli(kst_tab_barcode)
				if kst_tab_barcode.tipo_cicli = kkg_sl_pt_tipo_cicli_norm_1 then
				
					k_elaborazione = false  // forzo uscita ciclo
					k_riga_meca = 0 
					k_riga_meca_old = 0
					
					kidw_selezionata = dw_meca

//--- Completo i GIRI se richiesto da: tipo cicli 				
					modifica_giri(dw_modifica.ki_modalita_modifica_scelta_fila)
					
					dw_barcode.reset()
					
				else


					do while k_riga_drag <= dw_barcode.rowcount() 
	
						kst_tab_barcode.barcode = dw_barcode.object.barcode_barcode[k_riga_drag]

//--- NON è possibile mettere tra i padri un FIGLIO!!!			
						if NOT kuf1_barcode.if_barcode_figlio(kst_tab_barcode) then
	
							k_riga = kdw_1.insertrow(k_riga + k_insertrow)
	
	//--- copia la barcode in kdw_1, il formato e' il solito dettaglio			
							copia_dettaglio_dw_1_da_dw_2 ( kdw_1, dw_barcode, k_riga, k_riga_drag)
	
	//--- se il barcode ha Padri lo toglie			
	//						kuf1_barcode.tb_togli_da_groupage( kst_tab_barcode)
						end if
	
						k_riga_drag++
						
					loop
				
					if k_riga > 0 then
						
						k_riga_posiziona = k_riga
					
					end if
				
		//--- Toglie le righe inserite
					for k_ctr = dw_barcode.rowcount() to 0 step -1   
						dw_barcode.deleterow(k_ctr) 
					next 
				
				end if
				
			catch(uo_exception kuo_exception)
				kuo_exception.messaggio_utente()
				
			end try 
			
		end if
	
		if k_riga_meca > 0 then

			dw_meca.deleterow(k_riga_meca) 

			k_riga_meca_old = k_riga_meca

			k_riga_meca = dw_meca.getselectedrow(k_riga_meca - 1)

		end if
			
	loop
	

//--- sistema il codice e i progressivi nella lista
	if k_riga_meca_old > 0 and k_elaborazione then
		imposta_codice_progr( kdw_1 )
	
		if k_riga_meca_old > dw_meca.rowcount() then
			k_riga_meca_old = dw_meca.rowcount()
		end if
		if k_riga_meca_old > 0 then
			dw_meca.selectrow(0, false)
			dw_meca.selectrow(k_riga_meca_old, true)
			dw_meca.scrolltorow(k_riga_meca_old)
		end if
	end if

end if

		
//--- Toglie dalla lista principale i riferimenti messi in lavorazione
if k_elaborazione and (dw_lista_0.rowcount() > 0 or dw_groupage.rowcount() > 0) then


//--- se i barcode in dw_lista hanno figli li aggiunge al dw_groupage			
	aggiungi_figli_dal_dw_lista()
	
//--- se torna con qualche dubbio allora rifare le liste da DB
	kst_esito = screma_lista_riferimenti()

end if
		
//--- Toglie dalla lista principale i riferimenti messi in lavorazione
//if dw_lista_0.rowcount() > 0 or dw_groupage.rowcount() > 0 then
////--- rilegge la lista riferimenti non lavorati
//	leggi_liste()
//end if

kdw_1.setcolumn(1)
kdw_1.setfocus()
if k_riga_posiziona > 0 then
	kdw_1.selectrow(0, false)
	kdw_1.setrow(k_riga_posiziona)
	kdw_1.scrolltorow(k_riga_posiziona) 
	kdw_1.selectrow(k_riga_posiziona, true)
end if
	
attiva_tasti()

destroy kuf1_barcode

SetPointer(oldpointer)

end subroutine

protected function string leggi_liste ();//
//======================================================================
//=== Liste Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
string k_errore="0", k_sort = " "
long k_pl_barcode=0, k_riga_pos=0, k_riga=0, k_ctr
int k_rc
date k_data_int
pointer oldpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

	if dw_dett_0.getrow() > 0 then
		k_pl_barcode = dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice")
	end if
	if isnull(k_pl_barcode)  then
		k_pl_barcode = 0
	end if

//--- cattura la riga corrente x riproporla dopo la retrieve
   k_riga_pos = dw_meca.getrow()

//=== acchiappa il sort della merce da trattare
	k_sort = dw_meca.Object.DataWindow.Table.Sort

//=== Se nonostante tutto la dw e' a zero allora: retrieve
	k_data_int = ki_data_ini 

//--- leggo righe 
	if kids_meca_orig.rowcount() > 0 then

//--- faccio prima a ripri la copia			
		dw_meca.setredraw(false)
		dw_meca.reset()
		kids_meca_orig.rowscopy(1, kids_meca_orig.rowcount(), primary!, dw_meca,1 , primary!)
	else
//--- leggo su DB
		dw_meca.title = "Elenco Riferimenti senza P.L. dal " + string(k_data_int, "dd.mm.yyyy")
		dw_meca.retrieve(k_data_int, 0, 0, 0, "no_pl", k_pl_barcode)

//--- copia le righe in dw di appoggio		
		kids_meca_orig.reset()
		k_rc=dw_meca.rowscopy(1, dw_meca.rowcount(), primary!, kids_meca_orig,1 , primary!)

//=== Salva le righe del dw (saveas)
		kuf1_data_base.dw_saveas("no_pl", dw_meca)
	end if

	if dw_lista_0.rowcount() > 0 or dw_groupage.rowcount()  > 0 then
		screma_lista_riferimenti()
	end if

	if Len(trim(k_sort)) > 1 and trim(k_sort) <> "?" then
		dw_meca.setsort(k_sort)
		dw_meca.sort()
	end if

//--- seleziono la riga prec a quella prima della retrieve
	if dw_meca.rowcount() > 0 and k_riga_pos > 0 then 
		if dw_meca.rowcount() < k_riga_pos then
			k_riga_pos = dw_meca.rowcount()
		end if   
		dw_meca.scrolltorow(k_riga_pos) // - 4)  
		dw_meca.selectrow(0, false)  
		dw_meca.selectrow(k_riga_pos, true)  
	end if

	dw_meca.setredraw(true)



	SetPointer(oldpointer)


return k_return



end function

private function st_esito screma_lista_riferimenti ();//
//=== Toglie i BARCODE dalla lista se già messi in lavorazione nella dw_lista e dw_groupage
//=== torna numero barcode trovati 
//
long k_riga, k_riga_find=0, k_trovati_barcode, k_presenti_meca, k_num_loop_max
long k_ctr, k_rc, k_fila_1, k_fila_2, k_fila_1p, k_fila_2p, k_elabora
string k_find_txt, k_tipo_cicli, k_sort
long k_num_int, k_riga_pos
date k_data_int
datawindow kdw_1
st_esito kst_esito	


	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlerrtext = " "

//--- cattura la riga corrente x riposizionamento finale
   k_riga_pos = dw_meca.getrow()

//--- ripristina righe cancellate e contatori originali in lista riferimenti
	dw_meca.setredraw(false)
	if isvalid(kids_meca_orig) then
		if kids_meca_orig.rowcount() > 0 then
			dw_meca.reset()

//=== acchiappa il sort della merce da trattare
			k_sort = dw_meca.Object.DataWindow.Table.Sort
			
			kids_meca_orig.rowscopy(1, kids_meca_orig.rowcount(), primary!, dw_meca,1 , primary!)
			
			if len(trim(k_sort)) > 1 and trim(k_sort) <> "?" then
				dw_meca.setsort(k_sort)
				dw_meca.sort()
			end if
		end if
	end if

//--- elaborazione eseguita 2 volte: 1)in trattamento normale; 2)in trattam.Groupage
//--- 20.10.2009: attenzione poichè i grp non sono conteggiati dentro "elenco da trattare" (dw_lista_0) x cui il giro sui figli non lo faccio più!
k_elabora = 1
//	for k_elabora = 1 to 2 

//		if k_elabora = 1 then
			kdw_1 = dw_lista_0
//		else
//			kdw_1 = dw_groupage
//		end if
		
//--- sottrae dai Riferimenti i barcode messi in questa pianficazione
		k_num_loop_max = kdw_1.rowcount() 
		
		for k_riga = 1 to k_num_loop_max
			
//			if k_elabora = 1 then
				k_tipo_cicli = kdw_1.getitemstring (k_riga, "barcode_tipo_cicli")
				k_num_int = kdw_1.getitemnumber (k_riga, "barcode_num_int")
				k_data_int = kdw_1.getitemdate(k_riga, "barcode_data_int")	
				k_fila_1 = kdw_1.getitemnumber(k_riga, "barcode_fila_1")	
				k_fila_2 = kdw_1.getitemnumber(k_riga, "barcode_fila_2")	
				k_fila_1p = kdw_1.getitemnumber(k_riga, "barcode_fila_1p")	
				k_fila_2p = kdw_1.getitemnumber(k_riga, "barcode_fila_2p")	
//			else
//				k_tipo_cicli = kdw_1.getitemstring (k_riga, "barcode_tipo_cicli")
//				k_num_int = kdw_1.getitemnumber (k_riga, "barcode_num_int")
//				k_data_int = kdw_1.getitemdate(k_riga, "barcode_data_int")	
//				k_fila_1 = kdw_1.getitemnumber(k_riga, "barcode_fila_1")	
//				k_fila_2 = kdw_1.getitemnumber(k_riga, "barcode_fila_2")	
//				k_fila_1p = kdw_1.getitemnumber(k_riga, "barcode_fila_1p")	
//				k_fila_2p = kdw_1.getitemnumber(k_riga, "barcode_fila_2p")	
//			end if
			
//--- costruzione della FIND			
			k_find_txt = "meca_num_int = " + trim(string(k_num_int)) + " "  & 
						  + " and meca_data_int = date('" + string(k_data_int, "d/m/yy") + "')  " 
			if isnull(k_fila_1) then
				k_fila_1 = 0
			else
				k_find_txt = k_find_txt + " and barcode_fila_1 = " + trim(string(k_fila_1)) + " "  
			end if
			if isnull(k_fila_2) then
				k_fila_2 = 0
			else
				k_find_txt = k_find_txt + " and barcode_fila_2 = " + trim(string(k_fila_2)) + " "  
			end if
			if isnull(k_fila_1p) then
				k_fila_1p = 0
			else
				k_find_txt = k_find_txt + " and barcode_fila_1p = " + trim(string(k_fila_1p)) + " "  
			end if
			if isnull(k_fila_2p) then
				k_fila_2p = 0
			else
				k_find_txt = k_find_txt + " and barcode_fila_2p = " + trim(string(k_fila_2p)) + " "  
			end if

	
			if dw_meca.rowcount() = 0 then
	
				kst_esito.esito = "1"
				kst_esito.sqlerrtext = "w_pl_barcode:screma_lista_rifer:Lista Riferimenti Vuota! " 
	
			else

//--- cerca il riferimento in lista				
				k_riga_find = dw_meca.find(k_find_txt, 1, dw_meca.rowcount()) 
	
//--- Errore! NON ho trovato un riferimento in lista
				if k_riga_find = 0 then
					kst_esito.esito = kkg_esito_err_logico
					kst_esito.sqlerrtext = "w_pl_barcode:screma_lista_rifer:Stranamente non trovo riferim in lista: " &
												  + trim(string(k_num_int))
				else				
//--- 
					k_presenti_meca = dw_meca.getitemnumber( k_riga_find, "contati" )
					k_presenti_meca = k_presenti_meca - 1
					dw_meca.setitem( k_riga_find, "contati", k_presenti_meca )
					
//--- se azzero il contatore dei barcode tolgo il riferimento dalla lista				
					if k_presenti_meca = 0 then
						dw_meca.deleterow( k_riga_find ) 
					else	
						k_riga_find++
					end if
					
//--- cerca il riferimento in lista				
					if k_riga_find <= dw_meca.rowcount() then
						k_riga_find = dw_meca.find(k_find_txt, k_riga_find, dw_meca.rowcount()) 
					else
						k_riga_find = 0
					end if
								  
//--- errore! ho trovato un altro riferimento in lista
					if k_riga_find > 0 then
						kst_esito.esito =  kkg_esito_err_logico
						kst_esito.sqlerrtext = "w_pl_barcode:screma_lista_rifer:Trovo riferim 2 volte in lista: " &
												  + trim(string(k_num_int))
										
					end if
				end if
				
			end if
	
	
//--- se KO esco 
			if kst_esito.esito <> kkg_esito_ok then
				k_riga = k_num_loop_max + 1
			end if

		end for
	
//	end for


//--- riposizionamento sulla riga come all'inizio
	if dw_meca.rowcount() > 0 and k_riga_pos > 0 then 
		if dw_meca.rowcount() < k_riga_pos then
			k_riga_pos = dw_meca.rowcount()
		end if   
		dw_meca.scrolltorow(k_riga_pos) // - 4)  
		dw_meca.selectrow(0, false)  
		dw_meca.selectrow(k_riga_pos, true)  
	end if

//--- sistema il codice e i progressivi nella lista
	imposta_codice_progr( dw_lista_0 )
	imposta_codice_progr( dw_groupage )

	dw_meca.setredraw(true)		


return kst_esito




end function

public function integer crea_file_pilota ();//
//=== Crea archivio Normalizzato per il Pilota
//--- ESEMPIO
//972D28892HMM00010001NN   ---> 972=CLIE;D2889=PROGR;2HMM/2BMM=FISSI ALTERN.;0001=F1+F2 X 2 VOLTE;NN=FISSI
//972D28902BMM00010001NN
//037D31002HMM11001100NN
//151D31752BMM11001100NN
//151D31753HMM11331133NN
//151D31754HMM11331133NN
//
//
//--- Torna 0=tutto ok; 3=elab senza agg.;
//---       2=elab non eseguita; 1=errore grave
//
//
long k_riga
int k_errore, k_nrc
string k_cost_alto = "2HMM", k_cost_basso = "2BMM", k_cost_fine = "NN"
string k_barcode, k_giri, k_giri_p
int k_fila_1, k_fila_2, k_fila_1p, k_fila_2p, k_filenum, k_byte
string k_rc, k_path, k_file, k_ext, k_nulla=" ", k_elab_effettiva=" ", k_record = " "
date k_dataoggi
boolean k_crea_pilota, k_pl_groupage
st_tab_barcode kst_tab_barcode
st_tab_pl_barcode kst_tab_pl_barcode
//st_tab_artr kst_tab_artr
st_tab_certif kst_tab_certif, kst_tab_certif_vuota 
st_esito kst_esito, kst_esito_err
kuf_barcode kuf1_barcode
kuf_pl_barcode kuf1_pl_barcode
kuf_base kuf1_base
//kuf_artr kuf1_artr
kuf_certif kuf1_certif
pointer oldpointer  // Declares a pointer variable


	
	k_errore = 0
	k_crea_pilota = false
	k_elab_effettiva = " "

//--- Reperisce la DATAOGGI	
	k_dataoggi = dw_dett_0.getitemdate(1, "data_chiuso")
	
	if k_dataoggi = date(0) or isnull(k_dataoggi) then
		
		messagebox("Creazione Archivio per il Pilota", &
				  "Prima di procedere, chiudere il Piano di Lavorazione.~n~r" &
				  + "Elaborazione interrotta.~n~r", &
				  Information!, ok!) 
					
		k_elab_effettiva = "F"
	end if

//--- Reperisce il nome della PATH del file Pilota
	if k_elab_effettiva <> "F" then
	
//--- Legge il nome-file pilota nel profilo
		k_path = trim(kuf1_data_base.profilestring_leggi_scrivi(1, "arch_pilota", k_nulla))
	
		k_elab_effettiva = " "

		do
			k_nrc = GetFileSaveName("Scegliere Nome Archivio normalizzato per il Pilota", &
								k_path, k_file, k_ext) 
								
			if k_nrc <= 0 then
				k_elab_effettiva = "F"
			else
				if fileexists(k_path) then
					k_nrc = messagebox("Selezionato archivio per il Pilota", &
						  "Archivio già presente:~n~r" &
						  + k_path + "~n~r" &
						  + "Vuoi ricoprirlo?", &
						  question!, yesnocancel!, 2) 
					
					if k_nrc = 3 then
						k_elab_effettiva = "F"
					end if
				else
					k_nrc = 1
				end if				
			end if
		
		loop while k_nrc = 2 and k_elab_effettiva = " "
	end if
	k_rc = kuf1_data_base.profilestring_leggi_scrivi(2, "arch_pilota", trim(k_path))

//--- Genera file pilota
	if k_errore = 0 and k_elab_effettiva <> "F" then
	
		k_FileNum = FileOpen(k_path, LineMode!, Write!, LockWrite!, Replace!)
		if k_FileNum < 0 then
			k_errore = 1
			messagebox("Apertura Archivio Pilota", "Operazione fallita, l'elaborazione e' stata interrotta")
		else

//=== Puntatore Cursore da attesa.....
			oldpointer = SetPointer(HourGlass!)
		
			for k_riga = 1 to dw_lista_0.rowcount() 
		
				dw_lista_0.selectrow(0, false)
				dw_lista_0.selectrow(k_riga, true)
				dw_lista_0.scrolltorow(k_riga)
		
				k_barcode = trim(dw_lista_0.getitemstring(k_riga, "barcode_barcode"))
				k_fila_1 = dw_lista_0.getitemnumber(k_riga, "barcode_fila_1")
				k_fila_2 = dw_lista_0.getitemnumber(k_riga, "barcode_fila_2")
				k_fila_1P = dw_lista_0.getitemnumber(k_riga, "barcode_fila_1p")
				k_fila_2P = dw_lista_0.getitemnumber(k_riga, "barcode_fila_2p")
			
				if isnull(k_fila_1) then
					k_fila_1 = 0
				end if
				if isnull(k_fila_2) then
					k_fila_2 = 0
				end if
				if isnull(k_fila_1p) then
					k_fila_1p = 0
				end if
				if isnull(k_fila_2p) then
					k_fila_2p = 0
				end if
				k_giri = string(k_fila_1, "00") + string(k_fila_2, "00")
				k_giri_P = string(k_fila_1p, "00") + string(k_fila_2p, "00")
	
//--- quando record e' dispari imballo Alto altrimenti Basso
				if mod(k_riga, 2) = 0 then 
					k_record = k_barcode + k_cost_basso + k_giri + k_giri_p + k_cost_fine 
				else
					k_record = k_barcode + k_cost_alto + k_giri + k_giri_p + k_cost_fine  
				end if
					
				k_byte = FileWrite(k_FileNum, k_record)
				if k_byte < 0 then
					k_riga = dw_lista_0.rowcount() + 1 // esco x errore
					k_errore = 1
				end if
				
			next
			
			k_byte = FileClose(k_FileNum)
			if k_byte < 0 then
				k_errore = 1
			end if

//=== riprisino Puntatore
			SetPointer(oldpointer)
			
		end if	

		if k_errore = 1 then
			k_elab_effettiva = "F"
			messagebox("Generazione Archivio Pilota", "Operazione fallita, l'elaborazione e' stata interrotta~n~r" &
		           + "Nessun aggiornamento eseguito!")
		end if
	end if // fine creazione file pilota se richiesto		

	if k_elab_effettiva <> "F" then 
		
//=== Puntatore Cursore da attesa.....
		oldpointer = SetPointer(HourGlass!)

//--- Aggiornamenti nella tabella P.L. 
		kuf1_pl_barcode = create kuf_pl_barcode
		kst_tab_pl_barcode.codice = dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice")

		if k_errore = 0 then
			
			kst_tab_pl_barcode.path_file_pilota = trim(k_path)
			kst_esito=kuf1_pl_barcode.tb_update_campo(kst_tab_pl_barcode, "path_file_pilota")
			if trim(kst_esito.esito) <> "0" then
				k_errore = 1
				kst_esito_err.esito = kst_esito.esito
				kst_esito_err.sqlcode = sqlca.sqlcode
				kst_esito_err.sqlerrtext ="Crea File P.L. Barcode Aggiornamento:" +  &
									", " + kst_esito.SQLErrText 
				kuf1_data_base.errori_scrivi_esito("W", kst_esito_err) 
				rollback using sqlca;
	//=== ripristino Puntatore
//				SetPointer(oldpointer)
//				messagebox("Aggiorna Archivio P.L.", "Operazione fallita, P.L. senza riferimento del File~n~r" &
//						  + "Cerca il File manualmente su disco")
			else
				commit using sqlca;
				
				dw_dett_0.setitem(dw_dett_0.getrow(), "path_file_pilota", kst_tab_pl_barcode.path_file_pilota)
				
			end if			  
		end if
		
//=== ripristino Puntatore
		SetPointer(oldpointer)

	end if


	
if k_errore = 0 and k_elab_effettiva <> "F" then
	messagebox("Elaborazione Terminata", &
			  "Operazione terminata correttamente.~n~r" &
			  + "Piano di Lavorazione con codice:" &
			  + trim(string(dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice"))) + "~n~r", &
			  Information! )
end if


if k_errore = 0  and k_elab_effettiva = "N" then
	k_errore = 3
end if


//--- Ripristina path di lavoro
kuf1_data_base.setta_path_default()

return k_errore

end function

private subroutine proteggi_campi ();//
//======================================================================
//=== Protegge i campi della Windows
//======================================================================
//
kuf_utility kuf1_utility



//--- Inabilita campi alla modifica se Vsualizzazione
	kuf1_utility = create kuf_utility 
	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita_visualizzazione &
	   or trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita_cancellazione then
	
		kuf1_utility.u_proteggi_dw("3", 0, dw_dett_0)
		kuf1_utility.u_proteggi_dw("3", 0, dw_lista_0)
		kuf1_utility.u_proteggi_dw("3", 0, dw_groupage)


	else		
		
//--- S-protezione campi per riabilitare la modifica a parte la chiave
		kuf1_utility.u_proteggi_dw("2", 0, dw_dett_0)
		kuf1_utility.u_proteggi_dw("2", 0, dw_lista_0)
		kuf1_utility.u_proteggi_dw("2", 0, dw_groupage)

//--- Inabilita campo codice
		kuf1_utility.u_proteggi_dw("3", 1, dw_dett_0)

	end if
	destroy kuf1_utility

	

	

end subroutine

private subroutine abilita_chiusura_pl ();//
//--- controllo autorizzazione x chiusura P.L.
//
st_esito kst_esito
kuf_pl_barcode kuf1_pl_barcode


kuf1_pl_barcode = create kuf_pl_barcode

kst_esito = kuf1_pl_barcode.consenti_chiusura() 

destroy kuf1_pl_barcode

if kst_esito.esito = kkg_esito_ok then
	ki_chiudi_PL_enabled = true
end if

end subroutine

protected subroutine attiva_tasti ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati

//=========================================================================
st_tab_pl_barcode kst_tab_pl_barcode
kuf_pl_barcode kuf1_pl_barcode

//--- lancia la funzione ereditata
super::attiva_tasti( )

cb_modifica.enabled = false
cb_visualizza.enabled = false
//cb_file.enabled = false
cb_pilota_UFO.enabled = false


if ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento &
   or ki_st_open_w.flag_modalita = kkg_flag_modalita_modifica then
	cb_aggiorna.enabled = true
	cb_togli.enabled = true
	cb_aggiungi.enabled = true
	cb_cancella.enabled = true
	cb_chiudi.enabled = ki_chiudi_PL_enabled 
//	cb_file.enabled = true
else
	cb_aggiorna.enabled = false
	cb_togli.enabled = false
	cb_chiudi.enabled = ki_chiudi_PL_enabled
	cb_cancella.enabled = false
end if

if dw_dett_0.getrow() > 0 then
	if dw_dett_0.getitemdate(dw_dett_0.getrow(), "data_chiuso") > date(0) and ki_chiudi_PL_enabled then 
		cb_pilota_UFO.enabled = true
	end if
end if

attiva_menu()


end subroutine

public subroutine riempi_dettaglio ();//
//=== 
//
long k_riga
long k_num_int
date k_data_int
int k_rc, k_fila_1, k_fila_2, k_fila_1p, k_fila_2p
double k_dose
long k_pl_barcode


if dw_meca.rowcount() > 0 then

//	k_riga = dw_meca.getrow()
	k_riga = dw_meca.getselectedrow(0)
		
	k_num_int = dw_meca.getitemnumber(k_riga, "meca_num_int")	
	k_data_int = dw_meca.getitemdate(k_riga, "meca_data_int")	
	k_fila_1 = dw_meca.getitemnumber(k_riga, "barcode_fila_1")	
	k_fila_2 = dw_meca.getitemnumber(k_riga, "barcode_fila_2")	
	k_fila_1p = dw_meca.getitemnumber(k_riga, "barcode_fila_1p")	
	k_fila_2p = dw_meca.getitemnumber(k_riga, "barcode_fila_2p")	
	k_dose = dw_meca.getitemnumber(k_riga, "armo_dose")	
	
	k_rc = dw_barcode.reset() 
	k_pl_barcode = dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice")

	if isnull(k_pl_barcode)  then
		k_pl_barcode = 0
	end if
	if isnull(k_fila_1) then
		k_fila_1 = 999
	end if
	if isnull(k_fila_2) then
		k_fila_2 = 999
	end if
	if isnull(k_fila_1p) then
		k_fila_1p = 999
	end if
	if isnull(k_fila_2p) then
		k_fila_2p = 999
	end if
	if isnull(k_dose) then
		k_dose = 0
	end if


//--- toglie la riga dai rif. da lavorare
//	dw_meca.deleterow( dw_meca.getrow() )
	
	k_rc = dw_barcode.retrieve(k_num_int, k_data_int,  k_pl_barcode) 
//	                           k_dose, k_pl_barcode) 
//	                           k_fila_1, k_fila_2, &
//	                           k_fila_1p, k_fila_2p, &
	
	if dw_barcode.rowcount() > 0 then

//---- filtra righe con la fila giusta ed eventualmente il barcode
		for k_riga = dw_barcode.rowcount() to 1 step -1
			
//			k_barcode = trim(dw_barcode.getitemstring ( k_riga, "barcode_barcode"))
	
			if (k_fila_1 <> 999 and dw_barcode.object.barcode_fila_1[k_riga] <> k_fila_1) &
					or (k_fila_1p <> 999 and dw_barcode.object.barcode_fila_1p[k_riga] <> k_fila_1p) &
					or (k_fila_2 <> 999 and dw_barcode.object.barcode_fila_2[k_riga] <> k_fila_2) &
					or (k_fila_2p <> 999 and dw_barcode.object.barcode_fila_2p[k_riga] <> k_fila_2p) &
		              or (k_dose <> 0 and dw_barcode.object.armo_dose[k_riga] <> k_dose ) &
				then 
				
//--- cancella barcode dall'elenco
				dw_barcode.deleterow( k_riga ) 
						
			end if 

		end for
	

		screma_lista_barcode()
		
		if dw_barcode.rowcount() > 0 then
			dw_barcode.setcolumn(1)
			dw_barcode.setfocus()
		end if
		
	end if

	//--- risistema la lista riferimenti non lavorati
//	leggi_liste()
	
end if


//--- Riempe il titolo della dw di dettaglio
if dw_barcode.rowcount() > 0 then
	dw_barcode.title = "Dettaglio Riferimento: " + string(dw_barcode.getitemnumber(1, "barcode_num_int"))
else
	dw_barcode.title = "Dettaglio Riferimento " 
end if


end subroutine

private subroutine abilita_modifica_giri ();//
//--- controllo autorizzazione x cambio giri di lavorazione
//

	try

		cb_file.enabled = dw_modifica.autorizza_modifica_giri()
	
		if dw_modifica.ki_modifica_cicli_enabled = dw_modifica.ki_modifica_cicli_enabled_modif &
			and trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita_inserimento &
			and trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita_modifica then
			dw_modifica.ki_modifica_cicli_enabled = dw_modifica.ki_modifica_cicli_enabled_visualizzazione
		end if


	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()			
		cb_file.enabled = false
		dw_modifica.ki_modifica_cicli_enabled = dw_modifica.ki_modifica_cicli_enabled_visualizzazione
		
	finally			
	end try

end subroutine

protected subroutine smista_funz (string k_par_in);//---
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//===

choose case Left(k_par_in, 2) 

//--- Personalizzo da qui
	case kkg_flag_richiesta_libero1		//dettaglio barcode
		call_window_barcode()
	case kkg_flag_richiesta_libero2		//modifica i cilci del riferimento
		if cb_file.enabled then
//--- controlle se consentito solo visualizzazione
			if dw_modifica.ki_modifica_cicli_enabled = dw_modifica.ki_modifica_cicli_enabled_visualizzazione then
				modifica_giri(dw_modifica.ki_modalita_modifica_giri_visualizza)
			else
				if dw_modifica.ki_modifica_cicli_enabled = dw_modifica.ki_modifica_cicli_enabled_modif then
					modifica_giri(dw_modifica.ki_modalita_modifica_giri_riga)
				end if
			end if
		end if
	case kkg_flag_richiesta_libero3		//Imposta Flag 'Stato_in_attenzione'
		if cb_aggiungi.enabled = true then
			set_stato_in_attenzione( )
		end if
	case kkg_flag_richiesta_libero4		//Aggiungi riga
		if cb_aggiungi.enabled = true then
			cb_aggiungi.postevent(clicked!)
		end if
	case kkg_flag_richiesta_libero5		//Togli riga
		if cb_togli.enabled = true then
			cb_togli.postevent(clicked!)
		end if
	case kkg_flag_richiesta_libero6		//Chiude Progetto
		if cb_chiudi.enabled = true then
			cb_chiudi.postevent(clicked!)
		end if
//	case kkg_flag_richiesta_libero6		//crea file pilota
//		if cb_pilota_UFO.enabled = true then
//			cb_pilota_UFO.postevent(clicked!) 
//		end if
		
	case kkg_flag_richiesta_libero8  	//Crea Groupage prodotti da Palmare
		open_elenco_lettore_grp()

	case kkg_flag_richiesta_refresh		//Aggiorna Liste
		tasto_refresh()

	case kkg_flag_richiesta_libero9		//cambia date di estrazione
		cambia_periodo_elenco()


	case else // standard
		super::smista_funz(k_par_in)
		
end choose



end subroutine

protected subroutine attiva_menu ();

	super::attiva_menu()

	kG_menu.m_finestra.m_trova.enabled = true
	kG_menu.m_finestra.m_trova.m_fin_ordina.enabled = true
	kG_menu.m_finestra.m_trova.m_fin_cerca.enabled = true
	kG_menu.m_finestra.m_trova.m_fin_cercaancora.enabled = true
	kG_menu.m_finestra.m_trova.m_fin_filtra.enabled = true
	kG_menu.m_finestra.m_aggiornalista.enabled = true
	kG_menu.m_finestra.m_riordinalista.enabled = true

//
//--- Attiva/Dis. Voci di menu personalizzate
//
	if not kG_menu.m_strumenti.m_fin_gest_libero1.visible then
		kG_menu.m_strumenti.m_fin_gest_libero1.text = "Dettaglio &Barcode"
		kG_menu.m_strumenti.m_fin_gest_libero1.microhelp = 	"Visualizza dettaglio del Barcode"
		kG_menu.m_strumenti.m_fin_gest_libero1.enabled = true
		kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemtext = "Barcode,"+ kG_menu.m_strumenti.m_fin_gest_libero1.text
		kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemvisible = true
		kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemname = ki_path_risorse + "\barcode.bmp"
	//	kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex = 2
		kG_menu.m_strumenti.m_fin_gest_libero1.visible = true
	end if
	
	if kG_menu.m_strumenti.m_fin_gest_libero2.enabled <> cb_file.enabled then
		kG_menu.m_strumenti.m_fin_gest_libero2.text = "&Cicli di Lavorazione"
		kG_menu.m_strumenti.m_fin_gest_libero2.microhelp = "Visualizza/Modifica i cicli di trattamento del Barcode/intero Riferimento di Entrata   "
		kG_menu.m_strumenti.m_fin_gest_libero2.enabled = cb_file.enabled
		kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritemtext = "Giri,"+ kG_menu.m_strumenti.m_fin_gest_libero2.text
		kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritemvisible = true
		kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritemname = ki_path_risorse + "\cicli.bmp"
	//	kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex = 2
		kG_menu.m_strumenti.m_fin_gest_libero2.visible = true
	end if

	if dw_meca.icon <> dw_meca.ki_icona_selezionata then
		kG_menu.m_strumenti.m_fin_gest_libero3.enabled = false
	else
		kG_menu.m_strumenti.m_fin_gest_libero3.enabled = ki_autirizza_marca_stato_in_attenzione
	end if
	if not kG_menu.m_strumenti.m_fin_gest_libero3.visible then
		kG_menu.m_strumenti.m_fin_gest_libero3.text = "Marca/Ripristino Lotto 'in Attenzione '   F12"
		kG_menu.m_strumenti.m_fin_gest_libero3.microhelp =  "Marca/Ripristino Lotto 'in Attenzione'      F12"
		kG_menu.m_strumenti.m_fin_gest_libero3.toolbaritemVisible = true
		kG_menu.m_strumenti.m_fin_gest_libero3.toolbaritemText = "Marca,"+kG_menu.m_strumenti.m_fin_gest_libero3.text
		kG_menu.m_strumenti.m_fin_gest_libero3.toolbaritemName = "Exclamation!"
	//	kG_menu.m_strumenti.m_fin_gest_libero3.toolbaritembarindex=2
		kG_menu.m_strumenti.m_fin_gest_libero3.visible = true
	end if	
	
	if kG_menu.m_strumenti.m_fin_gest_libero4.enabled <> cb_aggiungi.enabled then
		kG_menu.m_strumenti.m_fin_gest_libero4.text = "Aggiungi Barcode (&+)"
		kG_menu.m_strumenti.m_fin_gest_libero4.microhelp = "Aggiunge Barcode da trattare a fine elenco   "
		kG_menu.m_strumenti.m_fin_gest_libero4.enabled = cb_aggiungi.enabled
		kG_menu.m_strumenti.m_fin_gest_libero4.toolbaritemtext = "Metti,"+ kG_menu.m_strumenti.m_fin_gest_libero4.text
		kG_menu.m_strumenti.m_fin_gest_libero4.toolbaritemvisible = false
		kG_menu.m_strumenti.m_fin_gest_libero4.toolbaritemName = "custom038!"
//		kG_menu.m_strumenti.m_fin_gest_libero4.toolbaritembarindex = 2
		kG_menu.m_strumenti.m_fin_gest_libero4.visible = true
	end if
	
	if kG_menu.m_strumenti.m_fin_gest_libero5.enabled <> cb_togli.enabled then
		kG_menu.m_strumenti.m_fin_gest_libero5.text = "Togli Barcode (&-)"
		kG_menu.m_strumenti.m_fin_gest_libero5.microhelp = "Toglie Barcode da trattare dall'elenco   "
		kG_menu.m_strumenti.m_fin_gest_libero5.enabled = cb_togli.enabled
		kG_menu.m_strumenti.m_fin_gest_libero5.toolbaritemtext = "Leva,"+ kG_menu.m_strumenti.m_fin_gest_libero5.text
		kG_menu.m_strumenti.m_fin_gest_libero5.toolbaritemvisible = false
		kG_menu.m_strumenti.m_fin_gest_libero5.toolbaritemName = "custom080!"
//		kG_menu.m_strumenti.m_fin_gest_libero5.toolbaritembarindex = 2
		kG_menu.m_strumenti.m_fin_gest_libero5.visible = true
	end if

//	if kG_menu.m_strumenti.m_fin_gest_libero6.enabled <> cb_chiudi.enabled then
		if not ki_PL_chiuso then 
			kG_menu.m_strumenti.m_fin_gest_libero6.text = "Chiudi P.L."
			kG_menu.m_strumenti.m_fin_gest_libero6.microhelp = 	"Salva e Chiude il Piano di Lavorazione, NON SARA' PIU' possibile effettuare alcuna modifica     "
			kG_menu.m_strumenti.m_fin_gest_libero6.toolbaritemtext = "Chiudi,"+ kG_menu.m_strumenti.m_fin_gest_libero6.text
		else
			kG_menu.m_strumenti.m_fin_gest_libero6.text = "Riapre P.L."
			kG_menu.m_strumenti.m_fin_gest_libero6.microhelp = 	"Riapre il Piano di Lavorazione appena inviato, SARA' di nuovo possibile effettuare le modifiche    "
			kG_menu.m_strumenti.m_fin_gest_libero6.toolbaritemtext = "Apre,"+ kG_menu.m_strumenti.m_fin_gest_libero6.text
		end if
		kG_menu.m_strumenti.m_fin_gest_libero6.enabled = cb_chiudi.enabled
		kG_menu.m_strumenti.m_fin_gest_libero6.toolbaritemvisible = true
		kG_menu.m_strumenti.m_fin_gest_libero6.toolbaritemname = ki_path_risorse + "\lucchetto1.bmp"
	//	kG_menu.m_strumenti.m_fin_gest_libero6.toolbaritembarindex = 2
		kG_menu.m_strumenti.m_fin_gest_libero6.visible = true
//	end if
	
	if not kG_menu.m_strumenti.m_fin_gest_libero8.visible then
		kG_menu.m_strumenti.m_fin_gest_libero8.text = "Elenco Groupage da Palmare "
		kG_menu.m_strumenti.m_fin_gest_libero8.microhelp =  "Crea Groupage letti e inviati da Palmare"
		kG_menu.m_strumenti.m_fin_gest_libero8.enabled = true
		kG_menu.m_strumenti.m_fin_gest_libero8.toolbaritemVisible = true
		kG_menu.m_strumenti.m_fin_gest_libero8.toolbaritemText = "Grp,"+kG_menu.m_strumenti.m_fin_gest_libero8.text
		kG_menu.m_strumenti.m_fin_gest_libero8.toolbaritemName = "CheckIn5!"
	//	kG_menu.m_strumenti.m_fin_gest_libero8.toolbaritembarindex=2
		kG_menu.m_strumenti.m_fin_gest_libero8.visible = true
	end if	

	if not kG_menu.m_strumenti.m_fin_gest_libero9.visible then
		kG_menu.m_strumenti.m_fin_gest_libero9.text = "Cambia data inizio periodo estrazione elenco Lotti da Trattare"
		kG_menu.m_strumenti.m_fin_gest_libero9.microhelp =  "Cambia data estrazione elenco Lotti"
		kG_menu.m_strumenti.m_fin_gest_libero9.enabled = true
		kG_menu.m_strumenti.m_fin_gest_libero9.toolbaritemVisible = false
		kG_menu.m_strumenti.m_fin_gest_libero9.toolbaritemText = "Periodo,"+kG_menu.m_strumenti.m_fin_gest_libero9.text
		kG_menu.m_strumenti.m_fin_gest_libero9.toolbaritemName = "Custom015!"
//		kG_menu.m_strumenti.m_fin_gest_libero9.toolbaritembarindex=2
		kG_menu.m_strumenti.m_fin_gest_libero9.visible = true
	end if

	


end subroutine

private function boolean if_pl_barcode_chiuso ();//--- 
//--- Controlla se PL_BARCODE e' gia' stato chiuso
//---
boolean k_return=false
st_tab_pl_barcode kst_tab_pl_barcode


//--- P.L. chiuso?
if dw_dett_0.getrow() > 0 then
	kst_tab_pl_barcode.codice = dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice")			

	try
		if kst_tab_pl_barcode.codice > 0 then
			
			if kiuf1_pl_barcode.if_esiste(kst_tab_pl_barcode) then
				if kiuf1_pl_barcode.if_pl_barcode_aperto(kst_tab_pl_barcode) then
					k_return=false
				else
					k_return=true
				end if
				
			end if
		end if

	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
	end try
	
end if


return k_return
end function

private subroutine set_dw_dett_0 (st_tab_pl_barcode kst_tab_pl_barcode);//---
//---
int k_riga = 0
k_riga = dw_dett_0.rowcount()

if k_riga > 0 then
	
	setnull(kst_tab_pl_barcode.data_chiuso)
	setnull(kst_tab_pl_barcode.data_sosp)
	
	dw_dett_0.setitem(k_riga, "codice", kst_tab_pl_barcode.codice)
	dw_dett_0.setitem(k_riga, "data", kst_tab_pl_barcode.data) 
	dw_dett_0.setitem(k_riga, "priorita", kst_tab_pl_barcode.priorita)
	dw_dett_0.setitem(k_riga, "stato", kst_tab_pl_barcode.stato)
	dw_dett_0.setitem(k_riga, "data_chiuso", kst_tab_pl_barcode.data_chiuso)
	dw_dett_0.setitem(k_riga, "data_sosp", kst_tab_pl_barcode.data_sosp)
	dw_dett_0.setitem(k_riga, "note_1", kst_tab_pl_barcode.note_1)
	dw_dett_0.setitem(k_riga, "note_2", kst_tab_pl_barcode.note_2)
	dw_dett_0.setitem(k_riga, "path_file_pilota", kst_tab_pl_barcode.path_file_pilota)

	dw_dett_0.SetItemStatus(k_riga, 0, Primary!, NotModified!)


end if



end subroutine

private subroutine open_elenco_pilota_coda () throws uo_exception;//
int k_rc
long k_riga
date k_data_int
st_tab_barcode kst_tab_barcode
st_tab_meca kst_tab_meca
st_esito kst_esito
kuf_armo kuf1_armo
kuf_barcode kuf1_barcode

window k_window
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window 
datawindowchild kdwc_barcode
uo_exception kuo_exception
pointer kpointer_old


//--- popolo il datasore (dw non visuale) per appoggio elenco
if not isvalid(kdsi_elenco_output) then 
	kdsi_elenco_output = create datastore
end if

try
	
	kpointer_old = setpointer(hourglass!)
	
	kguo_sqlca_db_pilota.db_connetti()

	kdsi_elenco_output.dataobject = "d_pilota_queue_table_h" 
	k_rc = kdsi_elenco_output.settransobject ( kguo_sqlca_db_pilota )
	k_rc = kdsi_elenco_output.retrieve    ()

	kst_open_w.key1 = "Elenco Barcode in coda di Lavorazione nel Pilota " 
	
	if kdsi_elenco_output.rowcount() > 0 then
	
//--- piglia la data di consegna	
		kuf1_armo = create kuf_armo
		kuf1_barcode = create kuf_barcode
		for k_riga = 1 to kdsi_elenco_output.rowcount() 
			kst_tab_barcode.barcode = kdsi_elenco_output.getitemstring( k_riga, "barcode")
			kst_esito = kuf1_barcode.get_padre_id_meca(kst_tab_barcode)
			if kst_esito.esito = kkg_esito_ok then
				kst_tab_meca.id = kst_tab_barcode.id_meca
				kst_esito = kuf1_armo.get_consegna_data(kst_tab_meca)
				if kst_esito.esito = kkg_esito_ok then
					kdsi_elenco_output.setitem(k_riga, "consegna_data", string(kst_tab_meca.consegna_data, "dd/mm/yyyy" ))
				end if
			end if
		next
		destroy kuf1_armo
		destroy kuf1_barcode
		
		k_window = kuf1_data_base.prendi_win_attiva()
		
	//--- chiamare la window di elenco
	
	//=== Parametri : 
	//=== struttura st_open_w
		kst_open_w.id_programma = kkg_id_programma_elenco
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_modalita = kkg_flag_modalita_elenco
		kst_open_w.flag_adatta_win = KK_ADATTA_WIN
		kst_open_w.flag_leggi_dw = " "
		kst_open_w.flag_cerca_in_lista = " "
		kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = k_window.title    //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key12_any = kdsi_elenco_output
		kst_open_w.flag_where = " "
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(kst_open_w)
		destroy kuf1_menu_window
	
	else
	
		kuo_exception = create uo_exception
		kuo_exception.set_tipo(kuo_exception.KK_st_uo_exception_tipo_not_fnd)
		kuo_exception.setmessage("Nessun valore disponibile per l'elenco richiesto. ")
		throw kuo_exception
		
		
	end if

catch (uo_exception k1uo_exception)
	throw k1uo_exception

finally 
	setpointer(kpointer_old)
end try
//





end subroutine

private subroutine open_notepad_documento () throws uo_exception;//
string k_file
kuf_ole kuf1_ole
st_esito kst_esito
uo_exception kuo_exception


	k_file = dw_dett_0.getitemstring(dw_dett_0.getrow(), "path_file_pilota") 
	
	if Len(trim(k_file)) > 0 then 
	
		kuf1_ole = create kuf_ole
		kst_esito = kuf1_ole.open_txt( k_file )
		if kst_esito.esito <> "0" then
			kst_esito = kuf1_ole.open_doc( k_file )
		end if
		destroy kuf1_ole
		if kst_esito.esito <> "0" then
			kuo_exception = create uo_exception
			kuo_exception.set_tipo(kuo_exception.KK_st_uo_exception_tipo_generico)
			kuo_exception.setmessage("Impossibile aprire il Documento" + trim(k_file)+ "~n~r" +trim(kst_esito.sqlerrtext) )
			throw kuo_exception
		end if
	else
	
		kuo_exception = create uo_exception
		kuo_exception.set_tipo(kuo_exception.KK_st_uo_exception_tipo_not_fnd)
		kuo_exception.setmessage("Nessun Documento Associato a questo P.L.!" )
		throw kuo_exception
		
	end if
	





end subroutine

private subroutine modifica_giri (string k_modalita_modifica_file);//
//--- k_modalita_modifica_file: 1=modalità modifica giri fila 1 e 2 
//
integer k_rec, k_riga
string k_dw_fuoco_nome
string k_aggiorna_rif
line kline_1
st_esito kst_esito
st_tab_barcode kst_tab_barcode
kuf_barcode kuf1_barcode
datawindow kidw_barcode_da_non_modificare



if ki_st_open_w.flag_modalita = kkg_flag_modalita_modifica &
   or ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento then

//--- valorizza la dw sulla quale fare la modifica
	kidw_x_modifica_giri = kidw_selezionata
	kidw_barcode_da_non_modificare = dw_lista_0
	dw_modifica.ki_modif_tutto_riferimento = dw_modifica.ki_modif_tutto_riferimento_no
	
//	k_dw_fuoco_nome = kidw_x_modifica_giri.classname() 
	k_dw_fuoco_nome = kidw_selezionata.dataobject 

	choose case k_dw_fuoco_nome

		case "d_meca_barcode_elenco_no_lav"
			dw_modifica.ki_modif_tutto_riferimento =dw_modifica.ki_modif_tutto_riferimento_si
			k_riga = dw_meca.getrow() 
			if k_riga > 0 then
				kst_tab_barcode.barcode = " "
				kst_tab_barcode.pl_barcode = dw_dett_0.object.codice.primary[dw_dett_0.getrow()]
				if isnull(kst_tab_barcode.pl_barcode) then kst_tab_barcode.pl_barcode = 0
				kst_tab_barcode.num_int = dw_meca.object.meca_num_int.primary[k_riga]
				kst_tab_barcode.data_int = dw_meca.object.meca_data_int.primary[k_riga]
				kst_tab_barcode.fila_1 = dw_meca.object.barcode_fila_1.primary[k_riga]
				kst_tab_barcode.fila_1p = dw_meca.object.barcode_fila_1p.primary[k_riga]
				kst_tab_barcode.fila_2 = dw_meca.object.barcode_fila_2.primary[k_riga]
				kst_tab_barcode.fila_2p = dw_meca.object.barcode_fila_2p.primary[k_riga]
				
				kuf1_barcode = create kuf_barcode
				kuf1_barcode.kist_tab_barcode = kst_tab_barcode
				kuf1_barcode.kist_tab_barcode.barcode = "*"
				kst_esito = kuf1_barcode.kicursor_barcode_1_open()
				if kst_esito.esito = kkg_esito_ok then
					kst_esito = kuf1_barcode.kicursor_barcode_1_fetch()
					if kst_esito.esito = kkg_esito_ok then
						kst_tab_barcode.barcode = kuf1_barcode.kist_tab_barcode.barcode 
					end if
				end if
				kst_esito = kuf1_barcode.kicursor_barcode_1_close ()
				destroy kuf1_barcode

				kst_tab_barcode.pl_barcode = dw_dett_0.getitemnumber(1, "codice") 
				if isnull(kst_tab_barcode.pl_barcode) then kst_tab_barcode.pl_barcode = 0
	
			end if			

		case "d_barcode_l_no_pl"
//--- se sono in modalita di modifica riga e ho selezionato piu' righe passo alla modalita
//--- modifica piu' righe
			if k_modalita_modifica_file = dw_modifica.ki_modalita_modifica_giri_riga then
			   k_riga = dw_barcode.getselectedrow(0)
				if k_riga > 0 then
				   k_riga = dw_barcode.getselectedrow(k_riga)
					if k_riga > 0 then
						k_modalita_modifica_file = dw_modifica.ki_modalita_modifica_giri_righe
					end if
				end if
			end if
			k_riga = dw_barcode.getrow() 
			if k_riga > 0 then		
				kst_tab_barcode.pl_barcode = 0
				kst_tab_barcode.barcode = dw_barcode.object.barcode_barcode.primary[k_riga]
				kst_tab_barcode.num_int = dw_barcode.object.barcode_num_int.primary[k_riga]
				kst_tab_barcode.data_int = dw_barcode.object.barcode_data_int.primary[k_riga]
				kst_tab_barcode.fila_1 = dw_barcode.object.barcode_fila_1.primary[k_riga]
				kst_tab_barcode.fila_1p = dw_barcode.object.barcode_fila_1p.primary[k_riga]
				kst_tab_barcode.fila_2 = dw_barcode.object.barcode_fila_2.primary[k_riga]
				kst_tab_barcode.fila_2p = dw_barcode.object.barcode_fila_2p.primary[k_riga]
			end if	

		case "d_pl_barcode_dett_grp_all" 
//--- se sono in modalita di modifica riga e ho selezionato piu' righe passo alla modalita
//--- modifica piu' righe
			if k_modalita_modifica_file = dw_modifica.ki_modalita_modifica_giri_riga then
			   k_riga = dw_groupage.getselectedrow(0)
				if k_riga > 0 then
				   k_riga = dw_groupage.getselectedrow(k_riga)
					if k_riga > 0 then
						k_modalita_modifica_file = dw_modifica.ki_modalita_modifica_giri_righe
					end if
				end if
			end if
			k_riga = dw_groupage.getrow() 
			if k_riga > 0 then		
				kst_tab_barcode.pl_barcode = 0
				kst_tab_barcode.barcode = dw_groupage.object.barcode_barcode.primary[k_riga]
				kst_tab_barcode.num_int = dw_groupage.object.barcode_num_int.primary[k_riga]
				kst_tab_barcode.data_int = dw_groupage.object.barcode_data_int.primary[k_riga]
				kst_tab_barcode.fila_1 = dw_groupage.object.barcode_fila_1.primary[k_riga]
				kst_tab_barcode.fila_1p = dw_groupage.object.barcode_fila_1p.primary[k_riga]
				kst_tab_barcode.fila_2 = dw_groupage.object.barcode_fila_2.primary[k_riga]
				kst_tab_barcode.fila_2p = dw_groupage.object.barcode_fila_2p.primary[k_riga]
			end if	


		case "d_pl_barcode_dett_1"
			
			setnull(kidw_barcode_da_non_modificare)
//--- se sono in modalita di modifica riga e ho selezionato piu' righe passo alla modalita
//--- modifica piu' righe
			if k_modalita_modifica_file = dw_modifica.ki_modalita_modifica_giri_riga then
			   k_riga = dw_lista_0.getselectedrow(0)
				if k_riga > 0 then
				   k_riga = dw_lista_0.getselectedrow(k_riga)
					if k_riga > 0 then
						k_modalita_modifica_file = dw_modifica.ki_modalita_modifica_giri_righe
					end if
				end if
			end if
			k_riga = dw_lista_0.getrow() 
			if k_riga > 0 then		
				kst_tab_barcode.pl_barcode = 0
				kst_tab_barcode.barcode = dw_lista_0.object.barcode_barcode.primary[k_riga]
				kst_tab_barcode.num_int = dw_lista_0.object.barcode_num_int.primary[k_riga]
				kst_tab_barcode.data_int = dw_lista_0.object.barcode_data_int.primary[k_riga]
				kst_tab_barcode.fila_1 = dw_lista_0.object.barcode_fila_1.primary[k_riga]
				kst_tab_barcode.fila_1p = dw_lista_0.object.barcode_fila_1p.primary[k_riga]
				kst_tab_barcode.fila_2 = dw_lista_0.object.barcode_fila_2.primary[k_riga]
				kst_tab_barcode.fila_2p = dw_lista_0.object.barcode_fila_2p.primary[k_riga]
			end if	

	end choose

	if k_riga > 0 then

		dw_modifica.modifica_giri(&
										kst_tab_barcode &
										,k_modalita_modifica_file &
										,dw_modifica.ki_modif_tutto_riferimento &
										,kidw_x_modifica_giri &
										,kidw_barcode_da_non_modificare &
										)
										
		
//		if len(trim(kst_tab_barcode.barcode)) > 0 &
//			and not isnull(kst_tab_barcode.barcode) then
//
//			dw_modifica.settransobject (sqlca)
//		
//		//	ki_st_open_w.flag_primo_giro = ''
//			dw_modifica.setredraw(false)
//
//// non faccio + questo controllo xche' mi e' stato detto che se in sl-pt 
//// allora non importa, l'operatore puo' fare le modifiche
//////--- consentito solo la visualizzazione
////			if not ki_modifica_cicli_enabled then
////				k_modalita_modifica_file = ki_modalita_modifica_giri_visualizza
////			end if
//			if isnull(kst_tab_barcode.fila_1) then
//				kst_tab_barcode.fila_1 = 999
//			end if
//			if isnull(kst_tab_barcode.fila_1p) then
//				kst_tab_barcode.fila_1p = 999
//			end if
//			if isnull(kst_tab_barcode.fila_2) then
//				kst_tab_barcode.fila_2 = 999
//			end if
//			if isnull(kst_tab_barcode.fila_2p) then
//				kst_tab_barcode.fila_2p = 999
//			end if
//		
//			dw_modifica.reset()
//			k_rec = dw_modifica.retrieve(kst_tab_barcode.barcode, &
//			                             kst_tab_barcode.num_int, &
//												  kst_tab_barcode.data_int, &
//												  kst_tab_barcode.fila_1, &
//												  kst_tab_barcode.fila_2, &
//												  kst_tab_barcode.fila_1p, &
//												  kst_tab_barcode.fila_2p, &
//												  kst_tab_barcode.pl_barcode)
//
//			if k_rec > 0 then
//				dw_modifica.setitem ( k_rec, "modalita_modifica", k_modalita_modifica_file)
//
////--- imposto dati di dafault  
////--- modalita' modifica giri  
//				if k_modalita_modifica_file <> ki_modalita_modifica_scelta_fila then
//					if dw_modifica.object.barcode_fila_1.primary[k_rec] > 0 &
//					   or dw_modifica.object.barcode_fila_1p.primary[k_rec] > 0 &
//						then
//						dw_modifica.object.scelta_fila_1.primary[k_rec]="1"
//					else
//						dw_modifica.object.scelta_fila_1.primary[k_rec]="0"
//					end if
//					if dw_modifica.object.barcode_fila_2.primary[k_rec] > 0 &
//					   or dw_modifica.object.barcode_fila_2p.primary[k_rec] > 0 &
//						then
//						dw_modifica.object.scelta_fila_2.primary[k_rec]="1"
//					else
//						dw_modifica.object.scelta_fila_2.primary[k_rec]="0"
//					end if
//					dw_modifica.object.aggiorna_righe_selezionate.primary[k_rec]="0"
//					
//				else
////--- modalita' scelta tra fila 1 o fila 2
//					dw_modifica.object.scelta_fila_1.primary[k_rec] = "0"
//					dw_modifica.object.scelta_fila_2.primary[k_rec] = "0"
//					dw_modifica.object.barcode_tipo_cicli.primary[k_rec] = kkg_sl_pt_tipo_cicli_norm
//				end if
//				if k_dw_fuoco_nome = "dw_meca" then
////--- toglie la specififca del barcode 					
//					dw_modifica.object.barcode_barcode.primary[k_rec] = "*"
////--- modifica l'intero Riferimento					
//					dw_modifica.object.aggiorna_rif.primary[k_rec] = "1"
//				end if
//				
//				dw_modifica.visible = true
//				dw_modifica.setredraw(true)
//			
//			else
//			
//				messagebox("Modifica Cicli di Trattamento", &
//								"Barcode non trovato in archivio!!")
//			end if
//		
//		else
//			
//			messagebox("Modifica Cicli di Trattamento", &
//						"Dati selezionati non validi")
//		end if
	else
		messagebox("Modifica Cicli di Trattamento", &
						"Selezionare una riga nella lista")
	end if	

else
	messagebox("Modifica non permessa", &
						"In questa modalita' non e' consentita la modifica dei dati")
end if
	 

//st_open_w kst_open_w
//kuf_menu_window kuf1_menu_window
// //--- chiamare la window di elenco
////
////=== Parametri : 
////=== struttura st_open_w
//			kst_open_w.id_programma = "brcd_rifer_f"
//			kst_open_w.flag_primo_giro = "S"
//			if ki_st_open_w.flag_modalita = "mo" or ki_st_open_w.flag_modalita = "in" then

//				kst_open_w.flag_modalita= "mo"
//			else
//				kst_open_w.flag_modalita= "vi"
//			end if
//			kst_open_w.flag_adatta_win = KK_ADATTA_WIN
//			kst_open_w.flag_leggi_dw = " "
//			kst_open_w.flag_cerca_in_lista = " "
//			kst_open_w.key1 = string(kst_tab_barcode.num_int)
//			kst_open_w.key2 = string(kst_tab_barcode.data_int, "dd.mm.yyyy")
//			kst_open_w.key3 = "S"
//			kst_open_w.flag_where = " "
//			
//			kuf1_menu_window = create kuf_menu_window 
//			kuf1_menu_window.open_w_tabelle(kst_open_w)
//			destroy kuf1_menu_window

 

end subroutine

public subroutine aggiungi_grp_rif_intero (ref datawindow kdw_1);//
//=== Aggiungi i BARCODE dell'intera entrata alla lista dei Pianificati
//===  dw_meca ------> dw_barcode -----> kdw_1
//
long k_riga, k_insertrow, k_riga_drag, k_riga_meca, k_riga_meca_old, k_riga_posiziona
long k_num_int, k_pl_barcode
date k_data_int
int k_ctr, k_rc
boolean k_elaborazione=true
pointer oldpointer  // Declares a pointer variable
st_esito kst_esito


//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)

k_riga_posiziona = 0
	
if dw_meca.rowcount() > 0 then

	k_riga_meca = dw_meca.getselectedrow(0)

	if k_riga_meca > 0 then	
		if kdw_1.rowcount() > 0 &
			and kdw_1.getselectedrow(0) > 0 then
			k_insertrow = 1
			k_riga = kdw_1.getselectedrow(0)
			k_riga_posiziona = k_riga
		else
			k_riga = -1
			k_riga_posiziona = -1
			k_insertrow = 1
		end if
	else
		messagebox("Nessuna Operazione Eseguita", "Selezionare una riga dall'elenco." &
					  +"~n~r", StopSign!	  &
					 )

	end if	

	
	do while k_riga_meca > 0 and k_elaborazione
		
		riempi_dettaglio()

		if dw_barcode.rowcount() > 0 then
			
			k_riga_drag = 1

//--- se ciclo normale a scelta devo effettuare prima la scelta
			if not isnull(dw_barcode.getitemstring(k_riga_drag, "barcode_tipo_cicli")) &
			   and dw_barcode.getitemstring(k_riga_drag, "barcode_tipo_cicli") &
				= kkg_sl_pt_tipo_cicli_norm_1 then
				
				k_elaborazione = false  // forzo uscita ciclo
				k_riga_meca = 0 
				k_riga_meca_old = 0
				
				kidw_selezionata = dw_meca
				
				modifica_giri(dw_modifica.ki_modalita_modifica_scelta_fila)
				
				dw_barcode.reset()
				
			else


				do while k_riga_drag <= dw_barcode.rowcount() 
		
					k_riga = kdw_1.insertrow(k_riga + k_insertrow)

//--- copia la barcode in kdw_1, il formato e' il solito dettaglio			
					copia_dettaglio_dw_grp_da_dw1 ( kdw_1, dw_barcode, k_riga, k_riga_drag)

					k_riga_drag++
					
				loop
				
				if k_riga > 0 then
					
					k_riga_posiziona = k_riga
				
				end if
				
		//--- Toglie le righe inserite
				for k_ctr = dw_barcode.rowcount() to 0 step -1   
					dw_barcode.deleterow(k_ctr) 
				next 
				
			end if
		end if
	
		if k_riga_meca > 0 then

			dw_meca.deleterow(k_riga_meca) 

			k_riga_meca_old = k_riga_meca

			k_riga_meca = dw_meca.getselectedrow(k_riga_meca - 1)
		end if
			
	loop
	

//--- sistema il codice e i progressivi nella lista
	if k_riga_meca_old > 0 and k_elaborazione then
		imposta_codice_progr( kdw_1 )
	
		if k_riga_meca_old > dw_meca.rowcount() then
			k_riga_meca_old = dw_meca.rowcount()
		end if
		if k_riga_meca_old > 0 then
			dw_meca.selectrow(0, false)
			dw_meca.selectrow(k_riga_meca_old, true)
			dw_meca.scrolltorow(k_riga_meca_old)
		end if
	end if

end if

		
//--- Toglie dalla lista principale i riferimenti messi in lavorazione
if k_elaborazione and dw_lista_0.rowcount() > 0 or dw_groupage.rowcount() > 0 then
//--- se torna con qualche dubbio allora rifare le liste da DB
	kst_esito = screma_lista_riferimenti()
end if
		

kdw_1.setcolumn(1)
kdw_1.setfocus()
if k_riga_posiziona > 0 then
	kdw_1.selectrow(0, false)
	kdw_1.setrow(k_riga_posiziona)
	kdw_1.scrolltorow(k_riga_posiziona) 
	kdw_1.selectrow(k_riga_posiziona, true)
end if
	
attiva_tasti()

SetPointer(oldpointer)

end subroutine

private subroutine copia_dettaglio_dw_grp_da_dw1 (ref datawindow kdw_1, ref datawindow kdw_2, integer k_riga1, integer k_riga2);//---
//--- copia dalla dw solita alla dw del groupage 
//--- parametri: dw1   riceve i dati (in cui copiare)
//---            dw2   da cui copiare
//---            riga1 riga della dw1
//---            riga2 riga della dw2
//---
st_tab_barcode kst_tab_barcode
st_esito kst_esito
kuf_barcode kuf1_barcode
	
	
	try 
		kuf1_barcode = create kuf_barcode
		kst_tab_barcode.barcode = kdw_2.getitemstring(k_riga2, "barcode_barcode")
		if not kuf1_barcode.get_padre(kst_tab_barcode) then
			kst_tab_barcode.barcode_lav = " "
		end if
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
	finally 
		destroy kuf1_barcode
	end try
	
			kdw_1.setitem(k_riga1, "barcode_lav",  kst_tab_barcode.barcode_lav)
			kdw_1.setitem(k_riga1, "barcode_barcode", &
						 kdw_2.getitemstring(k_riga2, "barcode_barcode"))
			kdw_1.setitem(k_riga1, "barcode_tipo_cicli", &
						 kdw_2.getitemstring(k_riga2, "barcode_tipo_cicli"))
			kdw_1.setitem(k_riga1, "barcode_fila_1", &
						 kdw_2.getitemnumber(k_riga2, "barcode_fila_1"))
			kdw_1.setitem(k_riga1, "barcode_fila_2", &
						 kdw_2.getitemnumber(k_riga2, "barcode_fila_2"))
			kdw_1.setitem(k_riga1, "barcode_fila_1p", &
						 kdw_2.getitemnumber(k_riga2, "barcode_fila_1p"))
			kdw_1.setitem(k_riga1, "barcode_fila_2p", &
						 kdw_2.getitemnumber(k_riga2, "barcode_fila_2p"))
			kdw_1.setitem(k_riga1, "barcode_num_int", &
						 kdw_2.getitemnumber(k_riga2, "barcode_num_int"))
			kdw_1.setitem(k_riga1, "barcode_data_int", &
						 kdw_2.getitemdate(k_riga2, "barcode_data_int"))
			kdw_1.setitem(k_riga1, "dose", &
						 kdw_2.getitemnumber(k_riga2, "armo_dose"))
			kdw_1.setitem(k_riga1, "peso_kg", &
						 kdw_2.getitemnumber(k_riga2, "armo_peso_kg"))
			kdw_1.setitem(k_riga1, "larg_2", &
						 kdw_2.getitemnumber(k_riga2, "armo_larg_2"))
			kdw_1.setitem(k_riga1, "lung_2", &
						 kdw_2.getitemnumber(k_riga2, "armo_lung_2"))
			kdw_1.setitem(k_riga1, "alt_2", &
						 kdw_2.getitemnumber(k_riga2, "armo_alt_2"))
			kdw_1.setitem(k_riga1, "pedane", &
						 kdw_2.getitemnumber(k_riga2, "armo_pedane"))
			kdw_1.setitem(k_riga1, "campione", &
						 kdw_2.getitemstring(k_riga2, "armo_campione"))
			kdw_1.setitem(k_riga1, "art", &
						 kdw_2.getitemstring(k_riga2, "armo_art"))
//			kdw_1.setitem(k_riga1, "armo_cod_sl_pt", &
//						 kdw_2.getitemstring(k_riga2, "armo_cod_sl_pt"))
			kdw_1.setitem(k_riga1, "id_armo", &
						 kdw_2.getitemnumber(k_riga2, "armo_id_armo"))
			kdw_1.setitem(k_riga1, "area_mag", &
						 kdw_2.getitemstring(k_riga2, "meca_area_mag"))
			kdw_1.setitem(k_riga1, "clie_2", &
						 kdw_2.getitemnumber(k_riga2, "meca_clie_2"))
			kdw_1.setitem(k_riga1, "des", &
						 kdw_2.getitemstring(k_riga2, "prodotti_des"))
			kdw_1.setitem(k_riga1, "rag_soc_10", &
						 kdw_2.getitemstring(k_riga2, "k_ricevente"))


end subroutine

public subroutine aggiungi_grp_barcode_singolo (ref datawindow kdw_1, ref datawindow kdw_2);//
//=== Aggiungi un BARCODE alla lista dei Pianificati in Groupage
//===   kdw_2 -----> kdw_1
//
long k_riga, k_insertrow, k_riga_drag, k_riga_ultima=0, k_riga_find=0
long k_num_int, k_pl_barcode
date k_data_int
string k_find
int k_ctr, k_rc
boolean k_elabora=true

	
	if kdw_2.rowcount() > 0 then
		
		if kdw_1.rowcount() > 0 &
			and kdw_1.getselectedrow(0) > 0 then
			k_insertrow = 1
			k_riga = kdw_1.getselectedrow(0)
		else
			k_riga = 0
			k_insertrow = 0
		end if

		k_riga_drag = kdw_2.getselectedrow(0)

		do while k_riga_drag > 0 

//--- se ciclo normale a scelta devo effettuare prima la scelta
			if kdw_2.getitemstring(k_riga_drag, "barcode_tipo_cicli") &
				= kkg_sl_pt_tipo_cicli_norm_1 then
				
				k_elabora=false
				
				modifica_giri(dw_modifica.ki_modalita_modifica_scelta_fila)
				

				k_riga_drag = 0 // forzo uscita ciclo
				
			else

				k_riga = kdw_1.insertrow(k_riga + k_insertrow)
			
//--- copia la in groupage (dw1) la dw2 			
				copia_dettaglio_dw_grp_da_dw1 (kdw_1, kdw_2, k_riga, k_riga_drag)

				k_riga_ultima = k_riga
			
				kdw_2.deleterow(k_riga_drag) 

				k_riga_drag = kdw_2.getselectedrow(k_riga_drag - 1)
				
			end if

		loop

		if k_riga_ultima > 0 and k_elabora then
			
//--- sistema il codice e i progressivi nella lista
			imposta_codice_progr( kdw_1 )

			kdw_1.selectrow(0, false)
			kdw_1.setrow(k_riga_ultima)
			kdw_1.selectrow(k_riga_ultima, true)
			kdw_1.scrolltorow(k_riga_ultima)
		end if
			
		if k_elabora then
			screma_lista_riferimenti()
		end if
			

	end if


kdw_1.setcolumn(1)
kdw_1.setfocus()

attiva_tasti()


end subroutine

private subroutine togli_figli_al_dw_groupage (st_tab_barcode kst_tab_barcode);//
//--- Verifica del barcode se ha figli  
//--- se il barcode ha figli li TOLGO dalla dw
//--- Input kst_tab_barcode.barcode
//
long k_riga_grp_copia, k_riga_grp
datastore kds_1
kuf_barcode kuf1_barcode
datawindow kdw_ds


	if dw_groupage.rowcount( ) > 0 then
		k_riga_grp=1
		do while k_riga_grp <= dw_groupage.rowcount() 
		
			if dw_groupage.object.barcode_lav[k_riga_grp] = kst_tab_barcode.barcode then
				dw_groupage.deleterow(k_riga_grp)
			else
				k_riga_grp++
			end if
		loop
	end if


end subroutine

private subroutine aggiungi_figli_al_dw_groupage (st_tab_barcode kst_tab_barcode);//
//--- Verifica del barcode se ha figli  
//--- se il barcode ha figli li AGGIUNGO dalla dw
//--- Input kst_tab_barcode.barcode
//
long k_riga_grp_copia, k_riga_grp, k_riga_find
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
st_tab_prodotti kst_tab_prodotti
st_tab_armo kst_tab_armo
datastore kds_1
kuf_barcode kuf1_barcode
kuf_armo kuf1_armo
kuf_clienti kuf1_clienti
kuf_prodotti kuf1_prodotti



	try
		kuf1_barcode = create kuf_barcode
		kuf1_armo = create kuf_armo
		kuf1_clienti = create kuf_clienti
		kuf1_prodotti = create kuf_prodotti

		kds_1 = kuf1_barcode.get_figli_barcode(kst_tab_barcode)
		if kds_1.rowcount( ) > 0 then
//			kdw_ds = create datawindow
//			kdw_ds.dataobject = dw_groupage.dataobject
//			kdw_ds.rowscopy( 1, kds_1.rowcount( ), primary!, kds_1, 1, primary!)
			k_riga_grp = dw_groupage.rowcount( )
			k_riga_grp_copia=1
			
			do while k_riga_grp_copia <= kds_1.rowcount() 

				kst_tab_barcode.barcode = kds_1.object.barcode[k_riga_grp_copia]

//--- Cerco il barcode tra i filgi gia' presenti
				k_riga_find = dw_groupage.find("barcode_barcode = '" + trim(kst_tab_barcode.barcode) + "' ", 1, dw_groupage.rowcount()) 

//--- se il barcode non c'e' ancora tra i figli allora lo aggiungo
				if k_riga_find < 1  then
					
					k_riga_grp = dw_groupage.insertrow(k_riga_grp+1)
					
					kuf1_barcode.select_barcode( kst_tab_barcode )
					kst_tab_armo.id_armo = kst_tab_barcode.id_armo
					kuf1_armo.leggi_riga( " ", kst_tab_armo )
					kst_tab_armo.peso_kg = kst_tab_armo.peso_kg / kst_tab_armo.colli_2 // ricavo il peso x collo
					kst_tab_meca.id = kst_tab_armo.id_meca
					kuf1_armo.leggi_testa("P", kst_tab_meca )
					kst_tab_clienti.codice = kst_tab_meca.clie_2
					kuf1_clienti.leggi_rag_soc( kst_tab_clienti )
					kst_tab_prodotti.codice = kst_tab_armo.art
					kuf1_prodotti.select_riga( kst_tab_prodotti )
	
					if dw_dett_0.object.codice[1] > 0 then
						dw_groupage.setitem(k_riga_grp, "barcode_pl_barcode",dw_dett_0.object.codice[1])
					else
						dw_groupage.setitem(k_riga_grp, "barcode_pl_barcode",0)
					end if
					dw_groupage.setitem(k_riga_grp, "barcode_lav",kst_tab_barcode.barcode_lav)
					dw_groupage.setitem(k_riga_grp, "barcode_barcode",kst_tab_barcode.barcode)
					dw_groupage.setitem(k_riga_grp, "barcode_tipo_cicli",kst_tab_barcode.tipo_cicli)
					dw_groupage.setitem(k_riga_grp, "barcode_fila_1",kst_tab_barcode.fila_1)
					dw_groupage.setitem(k_riga_grp, "barcode_fila_2",kst_tab_barcode.fila_2)
					dw_groupage.setitem(k_riga_grp, "barcode_fila_1p",kst_tab_barcode.fila_1p)
					dw_groupage.setitem(k_riga_grp, "barcode_fila_2p",kst_tab_barcode.fila_2p)
	
					dw_groupage.setitem(k_riga_grp, "dose",kst_tab_armo.dose)
					dw_groupage.setitem(k_riga_grp, "peso_kg",kst_tab_armo.peso_kg)
					dw_groupage.setitem(k_riga_grp, "larg_2",kst_tab_armo.larg_2)
					dw_groupage.setitem(k_riga_grp, "lung_2",kst_tab_armo.lung_2)
					dw_groupage.setitem(k_riga_grp, "alt_2",kst_tab_armo.alt_2)
					dw_groupage.setitem(k_riga_grp, "pedane",kst_tab_armo.pedane)
					dw_groupage.setitem(k_riga_grp, "art",kst_tab_armo.art)
					dw_groupage.setitem(k_riga_grp, "id_armo",kst_tab_armo.id_armo)
					dw_groupage.setitem(k_riga_grp, "area_mag",kst_tab_meca.area_mag)
					dw_groupage.setitem(k_riga_grp, "campione",kst_tab_armo.campione)
					dw_groupage.setitem(k_riga_grp, "barcode_num_int",kst_tab_meca.num_int)
					dw_groupage.setitem(k_riga_grp, "barcode_data_int",kst_tab_meca.data_int)
					dw_groupage.setitem(k_riga_grp, "clie_2",kst_tab_meca.clie_2)
					dw_groupage.setitem(k_riga_grp, "rag_soc_10",kst_tab_clienti.rag_soc_10)
					dw_groupage.setitem(k_riga_grp, "dose",kst_tab_armo.dose)
				end if
				
				k_riga_grp_copia++
				
			loop
		end if
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
	finally
		destroy kuf1_barcode
		destroy kuf1_armo 
		destroy kuf1_clienti
		destroy kuf1_prodotti
		
	end try


end subroutine

public subroutine togli_barcode_padre (ref datawindow kdw_1);//
//=== Toglie i BARCODE selezionati della lista dei Pianificati
//===  
//
long k_riga, k_riga_drag, k_riga_prima, k_riga_meca, k_riga_find
int k_ctr, k_rc
string k_rc_x
long k_num_int
date k_data_int
boolean k_rileggi_lista_da_db = false
st_tab_barcode kst_tab_barcode, kst_tab_barcode_figlio
st_esito kst_esito
kuf_barcode kuf1_barcode
datastore kds_1
	

	kuf1_barcode = create kuf_barcode

	k_rc = dw_barcode.reset() 
	
	k_riga_drag = kdw_1.getselectedrow(0)
	k_riga_prima = k_riga_drag
	
	k_riga = 1
	do while k_riga_drag > 0

		k_riga = dw_barcode.insertrow(0)

		kst_tab_barcode.barcode = trim(kdw_1.getitemstring(k_riga_drag, "barcode_barcode"))
		kst_esito = kuf1_barcode.tb_prendi_campo( kst_tab_barcode, "fila_1_e_fila_2" ) 
		if kst_esito.esito <> "0" then
			messagebox("Ripristina Giri come da Origine", "Operazione di lettura dati fallita, ~n~r" &
							  + "Barcode: " + trim(kst_tab_barcode.barcode)+"~n~r" &
							  + "Errore: " + trim(kst_esito.sqlerrtext))
		else
			if kdw_1.getitemnumber(k_riga_drag, "barcode_fila_1") <> kst_tab_barcode.fila_1 &
				or kdw_1.getitemnumber(k_riga_drag, "barcode_fila_2") <> kst_tab_barcode.fila_2 &
			   or kdw_1.getitemnumber(k_riga_drag, "barcode_fila_1p") <> kst_tab_barcode.fila_1p &
				or kdw_1.getitemnumber(k_riga_drag, "barcode_fila_2p") <> kst_tab_barcode.fila_2p &
				or kdw_1.getitemstring(k_riga_drag, "barcode_tipo_cicli") <> kst_tab_barcode.tipo_cicli &
				then
				k_rc = messagebox("Ripristina Giri e Tipo Trattamento come da Origine ", &
						  "Barcode: " + trim(kst_tab_barcode.barcode)+"~n~r" &
						  + "ripristino dei seguenti dati del Barcode  ~n~r"  &
						  + "imposto tipo trattamento a: " + KKG_SL_PT_TIPO_CICLI_DESCR[integer(kst_tab_barcode.tipo_cicli)] +" ~n~r" &
						  + "imposto n.giri in fila 1 a: " + string(kst_tab_barcode.fila_1) +" ~n~r" &
						  + "imposto n.giri in fila 1 permutata a: " + string(kst_tab_barcode.fila_1p) +"~n~r" &
						  + "imposto n.giri in fila 2 a: " + string(kst_tab_barcode.fila_2) +"~n~r" &
						  + "imposto n.giri in fila 2 permutata a: " + string(kst_tab_barcode.fila_2p) +"~n~r" &
						  + "(sono i valori letti dal 'SL-PT' di origine) "+"~n~r~n~r" &
						  + "Inoltre il Barcode sara' TOLTO definitivamente da questa Pianificazione. ~n~r", &
						  Information!) // yesno!, 1) 
				k_rc = 1
					
				if k_rc = 1 then
					if isnull(kst_tab_barcode.tipo_cicli) then
						kst_tab_barcode.tipo_cicli = " "
					end if
					if isnull(kst_tab_barcode.fila_1) then
						kst_tab_barcode.fila_1 = 0
					end if
					if isnull(kst_tab_barcode.fila_1p) then
						kst_tab_barcode.fila_1p = 0
					end if
					if isnull(kst_tab_barcode.fila_2) then
						kst_tab_barcode.fila_2 = 0
					end if
					if isnull(kst_tab_barcode.fila_2p) then
						kst_tab_barcode.fila_2p = 0

					end if
					kst_esito = kuf1_barcode.tb_update_campo( kst_tab_barcode, "ripri_fila_orig" ) 
					if kst_esito.esito <> "0" then
						messagebox("Ripristino Giri come da Origine", "Operazione di aggiornamento fallita, ~n~r" &
							  + "Barcode: " + trim(kst_tab_barcode.barcode)+"~n~r" &
							  + "Errore: " + string(kst_esito.sqlcode) + "-" + trim(kst_esito.sqlerrtext))
					else
						kdw_1.setitem(k_riga_drag, "barcode_tipo_cicli", kst_tab_barcode.tipo_cicli)			
						kdw_1.setitem(k_riga_drag, "barcode_fila_1", kst_tab_barcode.fila_1)			
						kdw_1.setitem(k_riga_drag, "barcode_fila_2", kst_tab_barcode.fila_2)			
						kdw_1.setitem(k_riga_drag, "barcode_fila_1p", kst_tab_barcode.fila_1p)			
						kdw_1.setitem(k_riga_drag, "barcode_fila_2p", kst_tab_barcode.fila_2p)	
						
						k_rileggi_lista_da_db = true //--- x forzare la rilettura della lista

//--- cerca eventuale figlio e lo toglie ---------------------------------------------------------------------------------------------
						try 
							kds_1 = kuf1_barcode.get_figli_barcode(kst_tab_barcode)
							for k_ctr = 1 to  kds_1.rowcount()
								kst_tab_barcode_figlio = kst_tab_barcode
								kst_tab_barcode_figlio.barcode = kds_1.object.barcode[k_ctr]
								kst_esito = kuf1_barcode.tb_update_campo( kst_tab_barcode_figlio, "ripri_fila_orig" ) 
								if kst_esito.esito <> "0" then
									messagebox("Ripristino Giri come da Origine", "Operazione di aggiornamento fallita, ~n~r" &
										  + "Barcode FIGLIO: " + trim(kst_tab_barcode_figlio.barcode)+"~n~r" &
										  + "Errore: " + string(kst_esito.sqlcode) + "-" + trim(kst_esito.sqlerrtext))
								else
//--- Cerco il barcode tra i figli gia' presenti
									k_riga_find = dw_groupage.find("barcode_barcode = '" + trim(kst_tab_barcode_figlio.barcode) + "' ", 1, dw_groupage.rowcount()) 
									if k_riga_find > 0 then
										dw_groupage.setitem(k_riga_find, "barcode_tipo_cicli", kst_tab_barcode.tipo_cicli)			
										dw_groupage.setitem(k_riga_find, "barcode_fila_1", kst_tab_barcode.fila_1)			
										dw_groupage.setitem(k_riga_find, "barcode_fila_2", kst_tab_barcode.fila_2)			
										dw_groupage.setitem(k_riga_find, "barcode_fila_1p", kst_tab_barcode.fila_1p)			
										dw_groupage.setitem(k_riga_find, "barcode_fila_2p", kst_tab_barcode.fila_2p)	
									end if
								end if
		
//--- tolgo il codice PL_BARCODE dal figlio					
								kst_esito = kuf1_barcode.tb_update_campo( kst_tab_barcode_figlio, "ripri_pl_barcode" ) 
								if kst_esito.esito <> "0" then
									messagebox("Rimozione del Barcode FIGLIO", "Operazione di aggiornamento fallita, ~n~r" &
									  + "Non e' grave, ma consiglio di 'salvare' questo Piano x evitare incongruenze nel prosieguo. " + trim(kst_tab_barcode.barcode)+"~n~r" &
									  + "Barcode: " + trim(kst_tab_barcode_figlio.barcode)+"~n~r" &
									  + "Errore: " + string(kst_esito.sqlcode) + "-" + trim(kst_esito.sqlerrtext))
								end if
								
							end for
						catch (uo_exception kuo_exception)
							kuo_exception.messaggio_utente()
						end try
//----------------------------------------------------------------------------------------------------------------------------------------
						
					end if
					
					kst_esito = kuf1_barcode.tb_update_campo( kst_tab_barcode, "ripri_pl_barcode" ) 
					if kst_esito.esito <> "0" then
						messagebox("Rimozione del Barcode", "Operazione di aggiornamento fallita, ~n~r" &
						  + "Non e' grave, ma consiglio di 'salvare' questo Piano x evitare incongruenze nel prosieguo. " + trim(kst_tab_barcode.barcode)+"~n~r" &
						  + "Barcode: " + trim(kst_tab_barcode.barcode)+"~n~r" &
						  + "Errore: " + string(kst_esito.sqlcode) + "-" + trim(kst_esito.sqlerrtext))
					end if
					
				end if
				
			end if

//--- posizionamento sul riferimento della riga trattata	
			if dw_meca.rowcount() > 0 then	

				k_num_int = kdw_1.getitemnumber(k_riga_drag, "barcode_num_int")
				k_data_int = kdw_1.getitemdate(k_riga_drag, "barcode_data_int")
				
				k_riga_meca = dw_meca.find("meca_num_int = " + trim(string(k_num_int)) + " " &
								 + "and meca_data_int = date('" &
								 + trim(string(k_data_int)) + "') " &
								 , 1, dw_meca.rowcount())
//--- Se riferimento mancante accendo flag x rilettura da DB
				if k_riga_meca = 0 then
					k_rileggi_lista_da_db = true //--- x forzare la rilettura della lista
				end if
			else
				k_rileggi_lista_da_db = true //--- x forzare la rilettura della lista
			end if						 
			
		end if

//--- copia la dw1 in barcode, il formato e' la solito dettaglio			
		copia_dettaglio_dw_1_da_dw_2 (dw_barcode, kdw_1, k_riga, k_riga_drag)

		k_riga_drag = kdw_1.getselectedrow( k_riga_drag )
		
		k_riga++
		
	loop
	dw_barcode.scrolltorow(dw_barcode.rowcount())

	destroy kuf1_barcode
					
//--- Tolgo le righe selezionata dalla lista Barcode Padri o Figli (groupage)
	k_riga = kdw_1.getselectedrow(0)
	do while k_riga > 0
		kst_tab_barcode.barcode = kdw_1.object.barcode_barcode[k_riga]
		togli_figli_al_dw_groupage (kst_tab_barcode) //se ce ne sono toglie anche i figli		
		kdw_1.deleterow( k_riga )
		k_riga = kdw_1.getselectedrow(0)
	loop
		
//--- sistema il codice e i progressivi nella lista
	imposta_codice_progr( kdw_1 )

//--- rilegge la lista riferimenti non lavorati
	if k_rileggi_lista_da_db then
		dw_meca.reset()
	end if
	leggi_liste()

//--- posizionamento sul riferimento della riga trattata	
	if dw_meca.rowcount() > 0 then	
		k_riga_meca = dw_meca.find("meca_num_int = " + trim(string(k_num_int)) + " " &
						 + "and meca_data_int = date('" &
						 + trim(string(k_data_int)) + "') " &
						 , 1, dw_meca.rowcount())
//--- Seleziono riferimento 
		if k_riga_meca > 0 then
			dw_meca.selectrow(0, false)
			dw_meca.setrow(k_riga_meca)
			dw_meca.selectrow(k_riga_meca, true)
			dw_meca.scrolltorow(k_riga_meca)
		end if
	end if

//--- posizionamento sulla riga precednte al barcode tolto
	if kdw_1.rowcount() > 0 then
	
		if k_riga_prima > 1 then
			k_riga_prima = k_riga_prima - 1
		end if
		if k_riga_prima > kdw_1.rowcount() then
			k_riga_prima = kdw_1.rowcount()
		end if
		if k_riga_prima > 0 then
			kdw_1.setrow(k_riga_prima)
			kdw_1.selectrow(k_riga_prima, true)
			kdw_1.scrolltorow(k_riga_prima)
		end if
		
		kdw_1.setcolumn(1)
		kdw_1.setfocus()
		
	end if	


//--- Riempe il titolo della dw di dettaglio
if dw_barcode.rowcount() > 0 then
	dw_barcode.title = "Dettaglio Riferimento: " + string(dw_barcode.getitemnumber(1, "barcode_num_int"))
else
	dw_barcode.title = "Dettaglio Riferimento " 
end if

attiva_tasti()

end subroutine

public subroutine togli_barcode_figlio (ref datawindow kdw_1);//
//=== Toglie i BARCODE FIGLI selezionati della lista dei Pianificati
//===  
//
long k_riga, k_riga_drag, k_riga_prima, k_riga_meca
int k_ctr, k_rc
string k_rc_x
long k_num_int
date k_data_int
boolean k_rileggi_lista_da_db = false
st_tab_barcode kst_tab_barcode, kst_tab_barcode_lav
st_esito kst_esito
kuf_barcode kuf1_barcode
	

	kuf1_barcode = create kuf_barcode

	k_rc = dw_barcode.reset() 
	
	k_riga_drag = kdw_1.getselectedrow(0)
	k_riga_prima = k_riga_drag
	
	k_riga = 1
	do while k_riga_drag > 0

		k_riga = dw_barcode.insertrow(0)

		kst_tab_barcode.barcode = trim(kdw_1.getitemstring(k_riga_drag, "barcode_barcode"))
		kst_tab_barcode.barcode_lav = trim(kdw_1.getitemstring(k_riga_drag, "barcode_lav"))
		if isnull(kst_tab_barcode.barcode_lav) then kst_tab_barcode.barcode_lav = " "
		
		kst_esito = kuf1_barcode.tb_prendi_campo( kst_tab_barcode, "fila_1_e_fila_2" ) 
		if kst_esito.esito <> "0" then
			messagebox("Ripristina Giri come da Origine", "Operazione di lettura dati fallita, ~n~r" &
							  + "Barcode: " + trim(kst_tab_barcode.barcode)+"~n~r" &
							  + "Errore: " + trim(kst_esito.sqlerrtext))
		else
			if kdw_1.getitemnumber(k_riga_drag, "barcode_fila_1") <> kst_tab_barcode.fila_1 &
				or kdw_1.getitemnumber(k_riga_drag, "barcode_fila_2") <> kst_tab_barcode.fila_2 &
			   or kdw_1.getitemnumber(k_riga_drag, "barcode_fila_1p") <> kst_tab_barcode.fila_1p &
				or kdw_1.getitemnumber(k_riga_drag, "barcode_fila_2p") <> kst_tab_barcode.fila_2p &
				or kdw_1.getitemstring(k_riga_drag, "barcode_tipo_cicli") <> kst_tab_barcode.tipo_cicli &
				then
				k_rc = messagebox("Ripristina Giri e Tipo Trattamento come da Origine ", &
						  "Barcode: " + trim(kst_tab_barcode.barcode)+"~n~r" &
						  + "ripristino dei seguenti dati del Barcode  ~n~r"  &
						  + "imposto tipo trattamento a: " + KKG_SL_PT_TIPO_CICLI_DESCR[integer(kst_tab_barcode.tipo_cicli)] +" ~n~r" &
						  + "imposto n.giri in fila 1 a: " + string(kst_tab_barcode.fila_1) +" ~n~r" &
						  + "imposto n.giri in fila 1 permutata a: " + string(kst_tab_barcode.fila_1p) +"~n~r" &
						  + "imposto n.giri in fila 2 a: " + string(kst_tab_barcode.fila_2) +"~n~r" &
						  + "imposto n.giri in fila 2 permutata a: " + string(kst_tab_barcode.fila_2p) +"~n~r" &
						  + "(sono i valori letti dal 'SL-PT' di origine) "+"~n~r~n~r" &
						  + "Il Barcode sara' TOLTO definitivamente da questa Pianificazione. ~n~r" &
						  + "Al Barcode sara' TOLTO anche l'eventuale legame con il Padre ("+trim(kst_tab_barcode.barcode_lav)+") ~n~r", &
						  Information!) // yesno!, 1) 
				k_rc = 1
					
				if k_rc = 1 then
					if isnull(kst_tab_barcode.tipo_cicli) then
						kst_tab_barcode.tipo_cicli = " "
					end if
					if isnull(kst_tab_barcode.fila_1) then
						kst_tab_barcode.fila_1 = 0
					end if
					if isnull(kst_tab_barcode.fila_1p) then
						kst_tab_barcode.fila_1p = 0
					end if
					if isnull(kst_tab_barcode.fila_2) then
						kst_tab_barcode.fila_2 = 0
					end if
					if isnull(kst_tab_barcode.fila_2p) then
						kst_tab_barcode.fila_2p = 0

					end if
					kst_esito = kuf1_barcode.tb_update_campo( kst_tab_barcode, "ripri_fila_orig" ) 
					if kst_esito.esito <> "0" then
						messagebox("Ripristino Giri come da Origine", "Operazione di aggiornamento fallita, ~n~r" &
							  + "Barcode: " + trim(kst_tab_barcode.barcode)+"~n~r" &
							  + "Errore: " + string(kst_esito.sqlcode) + "-" + trim(kst_esito.sqlerrtext))
					else
						kdw_1.setitem(k_riga_drag, "barcode_tipo_cicli", kst_tab_barcode.tipo_cicli)			
						kdw_1.setitem(k_riga_drag, "barcode_fila_1", kst_tab_barcode.fila_1)			
						kdw_1.setitem(k_riga_drag, "barcode_fila_2", kst_tab_barcode.fila_2)			
						kdw_1.setitem(k_riga_drag, "barcode_fila_1p", kst_tab_barcode.fila_1p)			
						kdw_1.setitem(k_riga_drag, "barcode_fila_2p", kst_tab_barcode.fila_2p)	
						
						k_rileggi_lista_da_db = true //--- x forzare la rilettura della lista

					end if
				end if

			else
			
				k_rc = messagebox("Ripristina Giri e Tipo Trattamento come da Origine ", &
						  "Barcode: " + trim(kst_tab_barcode.barcode)+"~n~r" &
						  + "ripristino dei seguenti dati del Barcode  ~n~r"  &
						  + "Il Barcode sara' TOLTO definitivamente da questa Pianificazione. ~n~r" &
						  + "Al Barcode sara' TOLTO anche l'eventuale legame con il Padre ("+trim(kst_tab_barcode.barcode_lav)+") ~n~r", &
						  Information!) 
			end if


			kst_esito = kuf1_barcode.tb_update_campo( kst_tab_barcode, "ripri_pl_barcode" ) 
			if kst_esito.esito <> "0" then
				messagebox("Rimozione del Barcode", "Operazione di aggiornamento fallita, ~n~r" &
				  + "Non e' grave, ma consiglio di 'salvare' questo Piano x evitare incongruenze nel prosieguo. " + trim(kst_tab_barcode.barcode)+"~n~r" &
				  + "Barcode: " + trim(kst_tab_barcode.barcode)+"~n~r" &
				  + "Errore: " + string(kst_esito.sqlcode) + "-" + trim(kst_esito.sqlerrtext))
			end if

			kst_esito = kuf1_barcode.tb_togli_da_groupage( kst_tab_barcode ) 
			if kst_esito.esito <> "0" then
				messagebox("Rimozione del Padre dal Barcode", "Operazione di aggiornamento fallita, ~n~r" &
				  + "ATTENZIONE: entrare nel Barcode ed eliminare il legame con il 'Padre'  " + trim(kst_tab_barcode.barcode_lav)+" manualmente!! ~n~r" &
				  + "Barcode: " + trim(kst_tab_barcode.barcode)+"~n~r" &
				  + "Errore: " + string(kst_esito.sqlcode) + "-" + trim(kst_esito.sqlerrtext))
			end if

//--- verifica se il Padre ha ancora figli se non e' cosi' lo resetta
			try
				kst_tab_barcode_lav.barcode = kst_tab_barcode.barcode_lav 
				if kuf1_barcode.get_conta_figli( kst_tab_barcode_lav ) = 0 then
					kst_esito = kuf1_barcode.tb_togli_da_groupage( kst_tab_barcode_lav ) 
				end if
			catch (uo_exception kuo_exception)
				kuo_exception.messaggio_utente()
			end try


//--- posizionamento sul riferimento della riga trattata	
			if dw_meca.rowcount() > 0 then	

				k_num_int = kdw_1.getitemnumber(k_riga_drag, "barcode_num_int")
				k_data_int = kdw_1.getitemdate(k_riga_drag, "barcode_data_int")
				
				k_riga_meca = dw_meca.find("meca_num_int = " + trim(string(k_num_int)) + " " &
								 + "and meca_data_int = date('" &
								 + trim(string(k_data_int)) + "') " &
								 , 1, dw_meca.rowcount())
//--- Se riferimento mancante accendo flag x rilettura da DB
				if k_riga_meca = 0 then
					k_rileggi_lista_da_db = true //--- x forzare la rilettura della lista
				end if
			else
				k_rileggi_lista_da_db = true //--- x forzare la rilettura della lista
			end if						 
			
		end if

			
//--- copia la dw1 in barcode, il formato e' la solito dettaglio			
		copia_dettaglio_dw1_da_dw_grp (dw_barcode, kdw_1, k_riga, k_riga_drag)

		k_riga_drag = kdw_1.getselectedrow( k_riga_drag )
		
		k_riga++
		
	loop
	dw_barcode.scrolltorow(dw_barcode.rowcount())

	destroy kuf1_barcode
					
//--- Tolgo le righe selezionata dalla lista Barcode Padri o Figli (groupage)
	k_riga = kdw_1.getselectedrow(0)
	do while k_riga > 0
		kdw_1.deleterow( k_riga )
		k_riga = kdw_1.getselectedrow(0)
	loop
		
//--- sistema il codice e i progressivi nella lista
	imposta_codice_progr( kdw_1 )

//--- rilegge la lista riferimenti non lavorati
	if k_rileggi_lista_da_db then
		dw_meca.reset()
	end if
	leggi_liste()

//--- posizionamento sul riferimento della riga trattata	
	if dw_meca.rowcount() > 0 then	
		k_riga_meca = dw_meca.find("meca_num_int = " + trim(string(k_num_int)) + " " &
						 + "and meca_data_int = date('" &
						 + trim(string(k_data_int)) + "') " &
						 , 1, dw_meca.rowcount())
//--- Seleziono riferimento 
		if k_riga_meca > 0 then
			dw_meca.selectrow(0, false)
			dw_meca.setrow(k_riga_meca)
			dw_meca.selectrow(k_riga_meca, true)
			dw_meca.scrolltorow(k_riga_meca)
		end if
	end if

//--- posizionamento sulla riga precednte al barcode tolto
	if kdw_1.rowcount() > 0 then
	
		if k_riga_prima > 1 then
			k_riga_prima = k_riga_prima - 1
		end if
		if k_riga_prima > kdw_1.rowcount() then
			k_riga_prima = kdw_1.rowcount()
		end if
		if k_riga_prima > 0 then
			kdw_1.setrow(k_riga_prima)
			kdw_1.selectrow(k_riga_prima, true)
			kdw_1.scrolltorow(k_riga_prima)
		end if
		
		kdw_1.setcolumn(1)
		kdw_1.setfocus()
		
	end if	


//--- Riempe il titolo della dw di dettaglio
if dw_barcode.rowcount() > 0 then
	dw_barcode.title = "Dettaglio Riferimento: " + string(dw_barcode.getitemnumber(1, "barcode_num_int"))
else
	dw_barcode.title = "Dettaglio Riferimento " 
end if

attiva_tasti()

end subroutine

private subroutine scegli_padre_da_dw_lista (long k_riga_dw_groupage);//
//=== Premuto pulsante nella DW
//
boolean k_aperto = true
int k_rc
long k_riga, k_riga_lista
st_tab_barcode kst_tab_barcode
st_tab_pl_barcode kst_tab_pl_barcode
st_esito kst_esito
//window k_window
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window


//--- Devo poter essere in inserimento o modifca x fare questa operazione...

if ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento &
   or ki_st_open_w.flag_modalita = kkg_flag_modalita_modifica then


	try
		
	//--- controllo se PL ancora aperto altrimenti NISBA
		kst_tab_pl_barcode.codice = dw_dett_0.object.codice[1]
	
		if kst_tab_pl_barcode.codice > 0 then
			k_aperto = kiuf1_pl_barcode.if_pl_barcode_aperto(kst_tab_pl_barcode) 
		else
			k_aperto = true
		end if
		
		if k_aperto then		
	//--- popolo il datasore (dw non visuale) per appoggio elenco
			if not isvalid(kdsi_elenco_output) then kdsi_elenco_output = create datastore
		
		
			kst_tab_barcode.barcode = dw_groupage.object.barcode_barcode[k_riga_dw_groupage]
			kst_tab_barcode.fila_1 = dw_groupage.object.barcode_fila_1[k_riga_dw_groupage]
			kst_tab_barcode.fila_1p = dw_groupage.object.barcode_fila_1p[k_riga_dw_groupage]
			kst_tab_barcode.fila_2 = dw_groupage.object.barcode_fila_2[k_riga_dw_groupage]
			kst_tab_barcode.fila_2p = dw_groupage.object.barcode_fila_2p[k_riga_dw_groupage]
			k_riga=0
			kdsi_elenco_output.dataobject = dw_lista_0.dataobject
			for k_riga_lista = 1 to dw_lista_0.rowcount()
				
				if kst_tab_barcode.fila_1 = dw_lista_0.object.barcode_fila_1[k_riga_lista] &
						and kst_tab_barcode.fila_1p = dw_lista_0.object.barcode_fila_1p[k_riga_lista] &
						and kst_tab_barcode.fila_2 = dw_lista_0.object.barcode_fila_2[k_riga_lista] &
						and kst_tab_barcode.fila_2p = dw_lista_0.object.barcode_fila_2p[k_riga_lista] &
						then
						k_riga++
						k_rc = dw_lista_0.rowscopy( k_riga_lista, k_riga_lista, primary!, kdsi_elenco_output, k_riga, primary!)					
				end if
			next
			kst_open_w.key1 = "Scegli 'Padre' per il Barcode: " + trim(string(kst_tab_barcode.barcode,"@@@ @@@@@@@@@")) 
				
				
			if kdsi_elenco_output.rowcount() > 0 then
		
//				k_window = kuf1_data_base.prendi_win_attiva()
				
		//--- chiamare la window di elenco
		//
		//=== Parametri : 
		//=== struttura st_open_w
				kst_open_w.id_programma =kkg_id_programma_elenco
				kst_open_w.flag_primo_giro = "S"
				kst_open_w.flag_modalita = kkg_flag_modalita_elenco
				kst_open_w.flag_adatta_win = KK_ADATTA_WIN
				kst_open_w.flag_leggi_dw = " "
				kst_open_w.flag_cerca_in_lista = " "
				kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
				kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
				kst_open_w.key4 = kiw_this_window.title    //--- Titolo della Window di chiamata per riconoscerla
				kst_open_w.key12_any = kdsi_elenco_output
				kst_open_w.flag_where = " "
				kuf1_menu_window = create kuf_menu_window 
				kuf1_menu_window.open_w_tabelle(kst_open_w)
				destroy kuf1_menu_window
		
			else
				
				messagebox("Elenco Dati", &
							"Nessun valore disponibile. ")
				
				
			end if
		else
			messagebox("Operazione non permessa", &
							"Piano di Lavoro " + string(kst_tab_pl_barcode.codice)+" gia' chiuso. ")
		end if
	
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
	
	finally
		
	end try
end if


end subroutine

private subroutine call_elenco_barcode_padri_potenziali (long k_riga_dw_groupage);//
//=== Elenco dei Barcode per associazione figli
//
int k_rc
date k_data, k_data_int
long  k_riga
st_tab_barcode kst_tab_barcode
st_esito kst_esito
window k_window
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window
kuf_barcode kuf1_barcode


//	k_riga = tab_1.tabpage_2.dw_2.rowcount()
//	if k_riga = 0 then

	if k_riga_dw_groupage > 0 then
	
//--- popolo il datasore (dw non visuale) per appoggio elenco
		if not isvalid(kdsi_elenco_output) then kdsi_elenco_output = create datastore
		
	

		kdsi_elenco_output.dataobject = kuf1_barcode.kk_dw_nome_barcode_l_padri_potenziali
		k_rc = kdsi_elenco_output.settransobject ( sqlca )
		kst_tab_barcode.barcode = dw_groupage.getitemstring( k_riga_dw_groupage, "barcode_barcode")
		kst_tab_barcode.fila_1 = dw_groupage.getitemnumber(k_riga_dw_groupage, "barcode_fila_1")
		kst_tab_barcode.fila_2 = dw_groupage.getitemnumber(k_riga_dw_groupage, "barcode_fila_2")
		kst_tab_barcode.fila_1p = dw_groupage.getitemnumber(k_riga_dw_groupage, "barcode_fila_1p")
		kst_tab_barcode.fila_2p = dw_groupage.getitemnumber(k_riga_dw_groupage, "barcode_fila_2p")
		if isnull(kst_tab_barcode.fila_1) then kst_tab_barcode.fila_1 = 0
		if isnull(kst_tab_barcode.fila_1p) then kst_tab_barcode.fila_1p = 0
		if isnull(kst_tab_barcode.fila_2) then kst_tab_barcode.fila_2 = 0
		if isnull(kst_tab_barcode.fila_2p) then kst_tab_barcode.fila_2p = 0
		k_rc = kdsi_elenco_output.retrieve(kst_tab_barcode.barcode, kst_tab_barcode.fila_1, kst_tab_barcode.fila_2, kst_tab_barcode.fila_1p, kst_tab_barcode.fila_2p)
		kst_open_w.key1 = "Elenco Barcode con uguale Trattamento, scegliere il 'Padre' " 

					
		if kdsi_elenco_output.rowcount() > 0 then
	
			k_window = kuf1_data_base.prendi_win_attiva()
			
	//--- chiamare la window di elenco
	//
	//=== Parametri : 
	//=== struttura st_open_w
			kst_open_w.id_programma =kkg_id_programma_elenco
			kst_open_w.flag_primo_giro = "S"
			kst_open_w.flag_modalita = kkg_flag_modalita_f_elenco
			kst_open_w.flag_adatta_win = KK_ADATTA_WIN
			kst_open_w.flag_leggi_dw = " "
			kst_open_w.flag_cerca_in_lista = " "
			kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
			kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
			kst_open_w.key4 = k_window.title    //--- Titolo della Window di chiamata per riconoscerla
			kst_open_w.key12_any = kdsi_elenco_output
			kst_open_w.flag_where = " "
			kuf1_menu_window = create kuf_menu_window 
			kuf1_menu_window.open_w_tabelle(kst_open_w)
			destroy kuf1_menu_window
	
		else
			
			messagebox("Elenco Dati", &
						"Nessun valore disponibile. ")
			
			
		end if
//	else
//				
//		messagebox("Operazione non possibile", &
//							"Sono già presenti 'Figli' per questo Barcode. ")
//				
	end if
////
end subroutine

private subroutine aggiungi_barcode_padre (st_tab_barcode kst_tab_barcode);//---
//---   Aggiunge il Barcode padre su questo Barcode
//---
long k_riga
st_tab_barcode kst_tab_barcode_save
st_esito kst_esito
kuf_barcode kuf1_barcode
uo_exception kuo_exception

k_riga = dw_groupage.getrow()

if k_riga > 0 then
	kuf1_barcode = create kuf_barcode
	
	if Len(trim(dw_groupage.object.barcode_lav[k_riga])) > 0 then
		kst_tab_barcode_save.barcode = trim(dw_groupage.object.barcode_lav[k_riga])
	else
		kst_tab_barcode_save.barcode = ""
	end if
	
	dw_groupage.object.barcode_lav[k_riga] = kst_tab_barcode.barcode
	kst_tab_barcode.barcode_lav = kst_tab_barcode.barcode
	kst_tab_barcode.barcode = dw_groupage.object.barcode_barcode[k_riga]
	
//--- aggiorno sul Figlio l'indicazione del PADRE
	kst_esito = kuf1_barcode.tb_aggiungi_figlio(kst_tab_barcode)	
	
	if kst_esito.esito <> kkg_esito_ok and  kst_esito.esito <> kkg_esito_db_wrn then
		kuo_exception = create uo_exception
		kuo_exception.set_esito(kst_esito)
		kuo_exception.messaggio_utente()
		destroy kuo_exception
	else
		
//--- tolgo dall'eventuale vecchio padre il flag di GROUPAGE
		if Len(trim(kst_tab_barcode_save.barcode)) > 0 then
	
			kst_esito = kuf1_barcode.tb_togli_figlio_al_padre(kst_tab_barcode_save)	
			
			if kst_esito.esito <> kkg_esito_ok and  kst_esito.esito <> kkg_esito_db_wrn then
				kuo_exception = create uo_exception
				kuo_exception.set_esito(kst_esito)
				kuo_exception.messaggio_utente()
				destroy kuo_exception
			end if
		end if
		
//--- aggiorno sul padre il flag di GROUPAGE
		kst_tab_barcode.barcode = kst_tab_barcode.barcode_lav
		kst_esito = kuf1_barcode.tb_set_padre(kst_tab_barcode)	
		
		if kst_esito.esito <> kkg_esito_ok and  kst_esito.esito <> kkg_esito_db_wrn then
			kuo_exception = create uo_exception
			kuo_exception.set_esito(kst_esito)
			kuo_exception.messaggio_utente()
			destroy kuo_exception
		end if
		
	end if
	
	destroy kuf1_barcode
end if

end subroutine

private function integer call_window_barcode ();//
//--- Chiama finestra di dettaglio
//
integer k_return = 0
long k_riga=0
st_tab_barcode kst_tab_barcode
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window



	if kidw_selezionata.dataobject = "d_pl_barcode_dett_1" then
		if dw_lista_0.getrow() > 0 then		
			k_riga = dw_lista_0.getrow() 
		else
			if dw_lista_0.rowcount() = 1 then
				k_riga = 1
			else
				k_riga = 0
			end if
		end if
		if k_riga > 0 then		
			kst_tab_barcode.barcode = dw_lista_0.getitemstring(k_riga, "barcode_barcode")
		end if
	end if

	if kidw_selezionata.dataobject = "d_pl_barcode_dett_grp_all" then
		if dw_groupage.getrow() > 0 then		
			k_riga = dw_groupage.getrow() 
		else
			if dw_groupage.rowcount() = 1 then
				k_riga = 1
			else
				k_riga = 0
			end if
		end if
		if k_riga > 0 then		
			kst_tab_barcode.barcode = dw_groupage.getitemstring(k_riga, "barcode_barcode")
		end if
	end if
	
	if kidw_selezionata.dataobject = "d_barcode_l_no_pl" then
		if dw_barcode.getrow() > 0 then		
			k_riga = dw_barcode.getrow() 
		else
			if dw_barcode.rowcount() = 1 then
				k_riga = 1
			else
				k_riga = 0
			end if
		end if
		if k_riga > 0 then		
			kst_tab_barcode.barcode = dw_barcode.getitemstring(k_riga, "barcode_barcode")
		end if
	end if

	if k_riga > 0 then		
	

		if Len(trim(kst_tab_barcode.barcode)) > 0 &
			and not isnull(kst_tab_barcode.barcode) then

			
//--- chiamare la window di elenco
//
//=== Parametri : 
//=== struttura st_open_w
			if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita_inserimento &
				or trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita_modifica then
				kst_open_w.flag_modalita= kkg_flag_modalita_modifica
			else
				kst_open_w.flag_modalita= kkg_flag_modalita_visualizzazione
			end if
				
			kst_open_w.id_programma = kkg_id_programma_barcode
			kst_open_w.flag_primo_giro = "S"
			kst_open_w.flag_adatta_win = KK_ADATTA_WIN
			kst_open_w.flag_leggi_dw = " "
			kst_open_w.flag_cerca_in_lista = " "
			kst_open_w.key1 = trim(kst_tab_barcode.barcode)
			kst_open_w.key2 = " "
			kst_open_w.flag_where = " "
			
			kuf1_menu_window = create kuf_menu_window 
			kuf1_menu_window.open_w_tabelle(kst_open_w)
			destroy kuf1_menu_window
		
		else
			
			messagebox("Dettaglio Codice a Barre", &
						"Codice a barre selezionato non valido")
			
		end if
			
	else
			
		messagebox("Dettaglio Codice a Barre", &
						"Selezionare un codice a barre in elenco")

	
	end if
 
 
return k_return

end function

private subroutine aggiungi_figli_dal_dw_lista ();//---
//---   Verifica se nella dw_lista  ci sono Padri e aggiunge i figli nella dw_groupage
//---
long k_riga
st_tab_barcode kst_tab_barcode

for k_riga = 1 to dw_lista_0.rowcount()
	kst_tab_barcode.barcode = dw_lista_0.object.barcode_barcode[k_riga]
	aggiungi_figli_al_dw_groupage ( kst_tab_barcode )
next

screma_lista_riferimenti()

end subroutine

private subroutine copia_dettaglio_dw1_da_dw_grp (ref datawindow kdw_1, ref datawindow kdw_2, integer k_riga1, integer k_riga2);//---
//--- copia dalla  dw del groupage  alla solita DW 
//--- parametri: dw1   su cui copiare
//---            dw2   dw_groupage
//---            riga1 riga della dw1
//---            riga2 riga della dw2
//---
st_tab_barcode kst_tab_barcode
st_tab_armo kst_tab_armo
st_esito kst_esito
kuf_barcode kuf1_barcode
	
	
	
//			kdw_1.setitem(k_riga1, "barcode_barcode_lav",  "")
			kdw_1.setitem(k_riga1, "barcode_barcode", &
						 kdw_2.getitemstring(k_riga2, "barcode_barcode"))
			kdw_1.setitem(k_riga1, "barcode_tipo_cicli", &
						 kdw_2.getitemstring(k_riga2, "barcode_tipo_cicli"))
			kdw_1.setitem(k_riga1, "barcode_fila_1", &
						 kdw_2.getitemnumber(k_riga2, "barcode_fila_1"))
			kdw_1.setitem(k_riga1, "barcode_fila_2", &
						 kdw_2.getitemnumber(k_riga2, "barcode_fila_2"))
			kdw_1.setitem(k_riga1, "barcode_fila_1p", &
						 kdw_2.getitemnumber(k_riga2, "barcode_fila_1p"))
			kdw_1.setitem(k_riga1, "barcode_fila_2p", &
						 kdw_2.getitemnumber(k_riga2, "barcode_fila_2p"))
			kdw_1.setitem(k_riga1, "barcode_num_int", &
						 kdw_2.getitemnumber(k_riga2, "barcode_num_int"))
			kdw_1.setitem(k_riga1, "barcode_data_int", &
						 kdw_2.getitemdate(k_riga2, "barcode_data_int"))
			kdw_1.setitem(k_riga1, "armo_dose", kdw_2.getitemnumber(k_riga2, "dose"))
			kdw_1.setitem(k_riga1, "armo_peso_kg", &
						 kdw_2.getitemnumber(k_riga2, "peso_kg"))
			kdw_1.setitem(k_riga1, "armo_larg_2", &
						 kdw_2.getitemnumber(k_riga2, "larg_2"))
			kdw_1.setitem(k_riga1, "armo_lung_2", &
						 kdw_2.getitemnumber(k_riga2, "lung_2"))
			kdw_1.setitem(k_riga1, "armo_alt_2", &
						 kdw_2.getitemnumber(k_riga2, "alt_2"))
			kdw_1.setitem(k_riga1, "armo_pedane", &
						 kdw_2.getitemnumber(k_riga2, "pedane"))
			kdw_1.setitem(k_riga1, "armo_campione", &
						 kdw_2.getitemstring(k_riga2, "campione"))
			kdw_1.setitem(k_riga1, "armo_art", &
						 kdw_2.getitemstring(k_riga2, "art"))
//			kdw_1.setitem(k_riga1, "armo_cod_sl_pt", &
//						 kdw_2.getitemstring(k_riga2, "armo_cod_sl_pt"))
			kdw_1.setitem(k_riga1, "armo_id_armo", &
						 kdw_2.getitemnumber(k_riga2, "id_armo"))
			kdw_1.setitem(k_riga1, "meca_area_mag", &
						 kdw_2.getitemstring(k_riga2, "area_mag"))
			kdw_1.setitem(k_riga1, "meca_clie_2", &
						 kdw_2.getitemnumber(k_riga2, "clie_2"))
			kdw_1.setitem(k_riga1, "prodotti_des", &
						 kdw_2.getitemstring(k_riga2, "des"))
			kdw_1.setitem(k_riga1, "clienti_rag_soc_10", &
						 kdw_2.getitemstring(k_riga2, "rag_soc_10") + " " + string(kdw_2.getitemnumber(k_riga2, "clie_2")))


end subroutine

private function st_esito retrieve_figlio_nel_dw_groupage (st_tab_barcode kst_tab_barcode);//
//--- Aggiorna i dati del Figlio nel dw_groupage  
//--- 
//--- Input kst_tab_barcode.barcode il FIGLIO da rileggere 
//
long k_riga_find
kuf_barcode kuf1_barcode
st_esito kst_esito 


	
	
	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()



	try
		kuf1_barcode = create kuf_barcode


//--- Cerco il barcode tra i filgi gia' presenti
		k_riga_find = dw_groupage.find("barcode_barcode = '" + trim(kst_tab_barcode.barcode) + "' ", 1, dw_groupage.rowcount()) 

//--- se  barcode Trovato procedo nella lettura dei dati su DB non c'e' ancora tra i figli allora lo aggiungo
		if k_riga_find > 0  then
			
			kuf1_barcode.select_barcode( kst_tab_barcode )

			dw_groupage.setitem(k_riga_find, "barcode_lav",kst_tab_barcode.barcode_lav)
			dw_groupage.setitem(k_riga_find, "barcode_tipo_cicli",kst_tab_barcode.tipo_cicli)
			dw_groupage.setitem(k_riga_find, "barcode_fila_1",kst_tab_barcode.fila_1)
			dw_groupage.setitem(k_riga_find, "barcode_fila_2",kst_tab_barcode.fila_2)
			dw_groupage.setitem(k_riga_find, "barcode_fila_1p",kst_tab_barcode.fila_1p)
			dw_groupage.setitem(k_riga_find, "barcode_fila_2p",kst_tab_barcode.fila_2p)

		else
			kst_esito.esito = kkg_esito_err_logico
			kst_esito.sqlerrtext = "Errore durante ricerca 'Figlio' " +  trim(kst_tab_barcode.barcode) + " in " + trim(this.classname())
		end if
		
	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito()
		
	finally
		destroy kuf1_barcode
		
	end try

return kst_esito


end function

private function st_esito retrieve_padre_nel_dw_lista (st_tab_barcode kst_tab_barcode);//
//--- Aggiorna i dati del Padre nel dw_lista_0  
//--- 
//--- Input kst_tab_barcode.barcode il FIGLIO da rileggere 
//
long k_riga_find
kuf_barcode kuf1_barcode
st_esito kst_esito 


	
	
	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	try
		kuf1_barcode = create kuf_barcode


//--- Cerco il barcode tra i filgi gia' presenti
		k_riga_find = dw_lista_0.find("barcode_barcode = '" + trim(kst_tab_barcode.barcode) + "' ", 1, dw_lista_0.rowcount()) 

//--- se  barcode Trovato procedo nella lettura dei dati su DB non c'e' ancora tra i figli allora lo aggiungo
		if k_riga_find > 0  then
			
			kuf1_barcode.select_barcode( kst_tab_barcode )

			dw_lista_0.setitem(k_riga_find, "barcode_tipo_cicli",kst_tab_barcode.tipo_cicli)
			dw_lista_0.setitem(k_riga_find, "barcode_fila_1",kst_tab_barcode.fila_1)
			dw_lista_0.setitem(k_riga_find, "barcode_fila_2",kst_tab_barcode.fila_2)
			dw_lista_0.setitem(k_riga_find, "barcode_fila_1p",kst_tab_barcode.fila_1p)
			dw_lista_0.setitem(k_riga_find, "barcode_fila_2p",kst_tab_barcode.fila_2p)

		else
			kst_esito.esito = kkg_esito_err_logico
			kst_esito.sqlerrtext = "Errore durante ricerca 'Padre' " +  trim(kst_tab_barcode.barcode) + " in " + trim(this.classname())
		end if
		
	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito()
		
	finally
		destroy kuf1_barcode
		
	end try

return kst_esito


end function

private function st_esito retrieve_padri ();//
//---- Rilegge tutti i padri da db2 contenuti nel dw_lista_0
//
long k_riga
st_tab_barcode kst_tab_barcode
st_esito kst_esito, kst1_esito 


	
	
	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	for k_riga = 1 to dw_lista_0.rowcount()
	
		kst_tab_barcode.barcode = dw_lista_0.object.barcode_barcode[k_riga]
		kst1_esito = retrieve_padre_nel_dw_lista(kst_tab_barcode)
		if kst1_esito.esito <> kkg_esito_ok and kst1_esito.esito <> kkg_esito_db_wrn then
			kst_esito.esito = kst1_esito.esito
			kst_esito.sqlerrtext += "~n~r" + trim(kst1_esito.sqlerrtext)
		end if
		
	end for


return kst_esito

end function

private function st_esito retrieve_figli ();//
//---- Rilegge tutti i figli da db2 contenuti nel dw_groupage
//
long k_riga
st_tab_barcode kst_tab_barcode
st_esito kst_esito, kst1_esito 


	
	
	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	for k_riga = 1 to dw_groupage.rowcount()
	
		kst_tab_barcode.barcode = dw_groupage.object.barcode_barcode[k_riga]
		kst1_esito = retrieve_figlio_nel_dw_groupage(kst_tab_barcode)
		if kst1_esito.esito <> kkg_esito_ok and kst1_esito.esito <> kkg_esito_db_wrn then
			kst_esito.esito = kst1_esito.esito
			kst_esito.sqlerrtext += "~n~r" + trim(kst1_esito.sqlerrtext)
		end if
		
	end for


return kst_esito

end function

private subroutine tasto_refresh ();//
st_esito kst_esito
uo_exception kuo_exception

choose case  kidw_selezionata.dataobject 

	case "d_meca_barcode_elenco_no_lav" &
			,"d_barcode_l_no_pl"
		rilegge_no_lav()


	case "d_pl_barcode_dett_1"
		kst_esito = retrieve_padri()
		if kst_esito.esito <> kkg_esito_ok and kst_esito.esito <> kkg_esito_db_wrn  then
			kuo_exception.set_esito( kst_esito)
			kuo_exception.messaggio_utente()
		end if

	case "d_pl_barcode_dett_grp_all"
		kst_esito = retrieve_figli()
		if kst_esito.esito <> kkg_esito_ok and kst_esito.esito <> kkg_esito_db_wrn  then
			kuo_exception.set_esito( kst_esito)
			kuo_exception.messaggio_utente()
		end if
		
end choose

dw_barcode.reset()

end subroutine

protected function st_esito aggiorna_window ();//
st_esito kst_esito
uo_exception kuo_exception


//--- Aggiungo eventuali Figli nati all'insaputa fuori da questo pianificazione
		aggiungi_figli_dal_dw_lista()

//--- Al ritorno da una window di aggiornamento, per sicurezza rileggo PADRI e FIGLI
//--- Rileggo i dati di trattamento dei barcode figli
		kst_esito = retrieve_padri()
		if kst_esito.esito = kkg_esito_ok or kst_esito.esito = kkg_esito_db_wrn  then
			kst_esito = retrieve_figli()
		end if
		if kst_esito.esito <> kkg_esito_ok and kst_esito.esito <> kkg_esito_db_wrn  then
			kuo_exception.set_esito( kst_esito)
			kuo_exception.messaggio_utente()
		end if
		
		attiva_tasti()

return kst_esito
end function

private subroutine cambia_periodo_elenco ();//---
//--- Visualizza il box x il cambio del Periodo di elenco fatture 
//---


dw_periodo.triggerevent("ue_visibile")

end subroutine

protected subroutine open_start_window ();//
st_tab_pl_barcode kst_tab_pl_barcode
kuf_base kuf1_base


kiuf1_pl_barcode = create kuf_pl_barcode								

date k_data_minima = relativedate(KG_dataoggi, -30)

ki_toolbar_window_presente=true
	
kuf1_base = create kuf_base
ki_data_ini = date(Mid(kuf1_base.prendi_dato_base("barcode_dt_no_lav"),2))
if isnull(ki_data_ini) then
	ki_data_ini = date(0)
end if 
//--- la data deve essere almeno 30 gg prima
if ki_data_ini > k_data_minima then
	ki_data_ini = k_data_minima
end if

destroy kuf1_base

//--- controlla se utente autorizzato a cambiare lo stato in attenzione del lotto
autorizza_stato_in_attenzione()

//--- attivo il timer ogni mezzo secondo	
timer( 0.5 )


end subroutine

private subroutine rilegge_no_lav ();		
	kids_meca_orig.reset()
	dw_meca.reset()
	leggi_liste()

end subroutine

public subroutine set_base_data_ini ();//
//--- Imposta sul BASE la data di inizio Elenco così da ricordarla al prx rientro
//
date k_data_inizio
int k_ctr=0
kuf_base kuf1_base
st_tab_base kst_tab_base


	k_data_inizio = ki_data_ini

	for k_ctr = dw_meca.rowcount() to 1 step -1
		
		if ki_data_ini > dw_meca.getitemdate(k_ctr, "meca_data_int") then
			ki_data_ini = dw_meca.getitemdate(k_ctr, "meca_data_int")
		end if
		
	end for

	if k_data_inizio <> ki_data_ini then
		kuf1_base = create kuf_base
		kst_tab_base.key = trim("barcode_dt_no_lav")
		kst_tab_base.key1 = string(ki_data_ini)
		kuf1_base.metti_dato_base(kst_tab_base)
		destroy kuf1_base
	end if
	
end subroutine

private subroutine open_elenco_lettore_grp ();//
int k_rc
window k_window
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window 
kuf_lettore_grp kuf1_lettore_grp
datawindowchild kdwc_barcode
uo_exception kuo_exception
pointer kpointer_old


	kpointer_old = setpointer(hourglass!)

	kuf1_lettore_grp = create kuf_lettore_grp

//=== Parametri : 
//=== struttura st_open_w
	kst_open_w.flag_modalita = kkg_flag_modalita_elenco
	kst_open_w.id_programma = kuf1_lettore_grp.get_id_programma(kst_open_w.flag_modalita)
	kst_open_w.flag_primo_giro = "S"
	kst_open_w.flag_adatta_win = KK_ADATTA_WIN
	kst_open_w.flag_leggi_dw = " "
	kst_open_w.flag_cerca_in_lista = " "
	kst_open_w.key2 = " "
	kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
	kst_open_w.key4 = ""
	kst_open_w.key12_any = kdsi_elenco_output
	kst_open_w.flag_where = " "
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(kst_open_w)
	destroy kuf1_menu_window
	
	destroy kuf1_lettore_grp

	setpointer (kpointer_old)


end subroutine

public subroutine set_stato_in_attenzione ();//
//--- Cambia il flag dello 'stato in attenzione' sul Lotto
//
long k_riga=0
kuf_armo kuf1_armo
st_tab_meca kst_tab_meca



	k_riga = dw_meca.getselectedrow(0) 

	if k_riga > 0 then
		kst_tab_meca.id = dw_meca.getitemnumber(k_riga, "id_meca")
		
		kuf1_armo = create kuf_armo
		kuf1_armo.set_stato_in_attenzione_cambia(kst_tab_meca)
		destroy kuf1_armo
		
		dw_meca.setitem(k_riga, "stato_in_attenzione", kst_tab_meca.stato_in_attenzione)
		
	else
		kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_dati_insufficienti )
		kguo_exception.setmessage("Prego, selezionare una riga dall'elenco.")
		kguo_exception.messaggio_utente( )
	end if
		
	
end subroutine

private subroutine autorizza_stato_in_attenzione ();//---
//--- Funzione: Autorizzazione a MARCARE il glag in Attenzione del LOTTO
//--- 
//--- Input:
//---
//--- Ritorno: no
//---
//---
boolean k_autorizza
kuf_armo kuf1_armo
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza

kuf1_armo = create  kuf_armo
kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita_inserimento
kst_open_w.id_programma = kuf1_armo.get_id_programma(kst_open_w.flag_modalita) //kkg_id_programma_riferimenti
destroy kuf1_armo

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	ki_autirizza_marca_stato_in_attenzione = false

else

	ki_autirizza_marca_stato_in_attenzione = true
	
end if



end subroutine

public subroutine call_elenco_grp ();//
kuf_barcode_tree kuf1_barcode_tree



	try
		
		kuf1_barcode_tree = create kuf_barcode_tree
		kuf1_barcode_tree.link_call( dw_meca, "grp" )
		
	catch (uo_exception kuo_exception)
		
		
	finally 
		destroy kuf1_barcode_tree
		k_dragdrop = false
		dw_meca.drag(cancel!)
		
	end try

end subroutine

protected function boolean if_programazione_ok () throws uo_exception;//---
//--- Controlla Programmazione
//---      
//--- Ritorna TRUE=OK
//---      
//
boolean k_return = false, k_errore=false
string k_barcode, k_errore_msg = ""
date k_data, k_data_chiuso, k_dataoggi
int k_nr_errori, k_pl_barcode_progr 
long k_riga, k_nr_righe, k_riga_find, k_riga_find_1, k_riga_ds
st_esito kst_esito
st_tab_barcode kst_tab_barcode_padre, kst_tab_barcode_figlio, kst_tab_barcode
kuf_barcode kuf1_barcode
ds_pl_barcode_dett kds_pl_barcode_dett, kds_pl_barcode_dett_figli
st_tab_pl_barcode kst_tab_pl_barcode


try
	
	kds_pl_barcode_dett = create ds_pl_barcode_dett
	kds_pl_barcode_dett_figli = create ds_pl_barcode_dett
	kuf1_barcode = create kuf_barcode

	dw_lista_0.accepttext()
	dw_groupage.accepttext()

	k_nr_righe = dw_lista_0.rowcount()
	k_nr_errori = 0
	k_riga_find = 0 
	k_riga = 1 //dw_lista_0.getnextmodified(0, primary!)

	do while k_nr_righe >= k_riga and k_nr_errori < 10

		k_pl_barcode_progr = dw_lista_0.getitemnumber ( k_riga, "barcode_pl_barcode_progr")

			
//--- Tolgo valori a null dai giri
		if isnull(dw_lista_0.getitemnumber ( k_riga, "barcode_fila_1")) then
			dw_lista_0.setitem ( k_riga, "barcode_fila_1", 0)
		end if
		if isnull(dw_lista_0.getitemnumber ( k_riga, "barcode_fila_1p")) then
			dw_lista_0.setitem ( k_riga, "barcode_fila_1p", 0)
		end if
		if isnull(dw_lista_0.getitemnumber ( k_riga, "barcode_fila_2")) then
			dw_lista_0.setitem ( k_riga, "barcode_fila_2", 0)
		end if
		if isnull(dw_lista_0.getitemnumber ( k_riga, "barcode_fila_2p")) then
			dw_lista_0.setitem ( k_riga, "barcode_fila_2p", 0)
		end if

//--- Popolo il Datastore x il controllo della Programmazione
		k_riga_ds = kds_pl_barcode_dett.insertrow(0)
		kds_pl_barcode_dett.object.pl_barcode_progr[k_riga_ds] = dw_lista_0.getitemnumber ( k_riga, "barcode_pl_barcode_progr")
		kds_pl_barcode_dett.object.barcode[k_riga_ds] = dw_lista_0.getitemstring ( k_riga, "barcode_barcode")
		kds_pl_barcode_dett.object.fila_1[k_riga_ds] = dw_lista_0.getitemnumber ( k_riga, "barcode_fila_1")
		kds_pl_barcode_dett.object.fila_2[k_riga_ds] = dw_lista_0.getitemnumber ( k_riga, "barcode_fila_2")
		kds_pl_barcode_dett.object.fila_1p[k_riga_ds] = dw_lista_0.getitemnumber ( k_riga, "barcode_fila_1p")
		kds_pl_barcode_dett.object.fila_2p[k_riga_ds] = dw_lista_0.getitemnumber ( k_riga, "barcode_fila_2p")
		kds_pl_barcode_dett.object.tipo_cicli[k_riga_ds] = dw_lista_0.getitemstring ( k_riga, "barcode_tipo_cicli")
	
		k_riga++ // = dw_lista_0.getnextmodified(k_riga, primary!) 

	loop

//--- Controllo programmazione
	kiuf1_pl_barcode.if_pianificazione_ok(kds_pl_barcode_dett)

//---- Controllo Barcode FIGLI ------------------------------------------------------------------------------------
	if not k_errore then

//--- Aggiungo eventuali Figli nati all'insaputa fuori da questo pianificazione
		aggiungi_figli_dal_dw_lista()

//--- Rileggo i dati di trattamento dei barcode figli
		kst_esito = retrieve_figli()
		if kst_esito.esito <> kkg_esito_ok then
//			if kst_esito.esito = kkg_esito_db_wrn then
//				k_errore_msg = k_errore_msg  & 
//									  + trim(kst_esito.sqlerrtext ) + ";~n~r" 
//				k_errore = "4"
//				k_nr_errori++
//			else
				k_errore_msg = k_errore_msg  & 
									  + trim(kst_esito.sqlerrtext ) + ";~n~r" 
				k_errore = true
				k_nr_errori++
//			end if
		end if
		
	end if

	if not k_errore  then
		k_nr_righe = dw_groupage.rowcount()
		k_nr_errori = 0
		k_riga_find = 0 
		k_riga_find_1 = 0 
		k_riga = 1 

	
		do while k_nr_righe >= k_riga and k_nr_errori < 10
	

//--- Popolo il Datastore x il controllo della Programmazione
			k_riga_ds = kds_pl_barcode_dett.insertrow(0)
			kds_pl_barcode_dett.object.pl_barcode_progr[k_riga_ds] = dw_groupage.getitemnumber ( k_riga, "barcode_pl_barcode_progr")
			kds_pl_barcode_dett.object.barcode[k_riga_ds] = dw_groupage.getitemstring ( k_riga, "barcode_barcode")
			kds_pl_barcode_dett.object.fila_1[k_riga_ds] = dw_groupage.getitemnumber ( k_riga, "barcode_fila_1")
			kds_pl_barcode_dett.object.fila_2[k_riga_ds] = dw_groupage.getitemnumber ( k_riga, "barcode_fila_2")
			kds_pl_barcode_dett.object.fila_1p[k_riga_ds] = dw_groupage.getitemnumber ( k_riga, "barcode_fila_1p")
			kds_pl_barcode_dett.object.fila_2p[k_riga_ds] = dw_groupage.getitemnumber ( k_riga, "barcode_fila_2p")
			kds_pl_barcode_dett.object.tipo_cicli[k_riga_ds] = dw_groupage.getitemstring ( k_riga, "barcode_tipo_cicli")
			
			k_riga++ // = dw_lista_0.getnextmodified(k_riga, primary!) 
	
		loop

//--- controlla pianificazione figli
		kiuf1_pl_barcode.if_pianificazione_figli_ok(kds_pl_barcode_dett, kds_pl_barcode_dett_figli)

	end if


		
	if not k_errore then

//--- sistema il codice e i progressivi nella lista PADRI
		imposta_codice_progr( dw_lista_0 )
			
//--- Risistema l'utente di aggiornamento		
		for k_riga = 1 to dw_lista_0.rowcount() 
			dw_lista_0.setitem(k_riga, "barcode_x_datins", kuf1_data_base.prendi_x_datins())
			dw_lista_0.setitem(k_riga, "barcode_x_utente", kuf1_data_base.prendi_x_utente())
		next

//--- sistema il codice e i progressivi nella lista FIGLI
		imposta_codice_progr( dw_groupage )
			
//--- Risistema l'utente di aggiornamento		
		for k_riga = 1 to dw_groupage.rowcount() 
			dw_groupage.setitem(k_riga, "x_datins", kuf1_data_base.prendi_x_datins())
			dw_groupage.setitem(k_riga, "x_utente", kuf1_data_base.prendi_x_utente())
		next

	end if

	if k_errore then
		kguo_exception.inizializza( )
		kguo_exception.setmessage(k_errore_msg)
		throw kguo_exception
	end if

	k_return = TRUE   //sembra tutto OK!

catch (uo_exception kuo1_exception)
	throw kuo1_exception

finally
	if isvalid(kuf1_barcode) then destroy kuf1_barcode
	if isvalid(kds_pl_barcode_dett) then destroy kds_pl_barcode_dett
	if isvalid(kds_pl_barcode_dett_figli) then destroy kds_pl_barcode_dett_figli
	
end try

return k_return



end function

private subroutine chiudi_pl_elabora () throws uo_exception;//---
//--- Chiude Piano di Lavorazione (chiamato da chiudi_pl)
//---
//--- lancia EXCEPTION
//---
long k_riga
int k_errore=0
st_tab_pl_barcode kst_tab_pl_barcode
st_esito kst_esito, kst_esito_err

pointer oldpointer  // Declares a pointer variable


k_errore = 0
	
	try	

		kst_tab_pl_barcode.codice = dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice")
	
//--- prima di Chiudere RIPRISTINA gli archivi da eventuali chiusure passate
		kst_tab_pl_barcode.st_tab_g_0.esegui_commit = "N"
		kiuf1_pl_barcode.riapre_pl_barcode(kst_tab_pl_barcode)
			
//--- Controllo se Tutto OK			
		if_programazione_ok()

//--- Chiude PL: inizio delle fasi di chiusura del PL 
		kst_tab_pl_barcode.data_chiuso = kg_dataoggi
		kst_tab_pl_barcode.st_tab_g_0.esegui_commit = "S"
		kst_esito = kiuf1_pl_barcode.tb_update_campo(kst_tab_pl_barcode, "data_chiuso")
		
		if kst_esito.esito <> kkg_esito_ok then
			k_errore = 1
			kst_esito_err.esito = kst_esito.esito
			kst_esito_err.sqlcode = kst_esito.sqlcode
			kst_esito_err.sqlerrtext = "Errore durante Chiusura del P.L.. ~n~rErrore " + trim(kst_esito.sqlerrtext)
			kuf1_data_base.errori_scrivi_esito("W", kst_esito_err) 
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito_err)
			throw kguo_exception
		end if			  
	
	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito()
		kst_esito_err.esito = kst_esito.esito
		kst_esito_err.sqlcode = kst_esito.sqlcode
		kst_esito_err.sqlerrtext = "Errore durante Chiusura Piano di Lavorazione Barcode (chiudi_pl_elabora): ~n~r" + trim(kst_esito.sqlerrtext)
		kuf1_data_base.errori_scrivi_esito("W", kst_esito_err) 
		
		kguo_sqlca_db_magazzino.db_rollback( ) 
		
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito_err)
		throw kguo_exception
		
	finally
		SetPointer(oldpointer)  // ripristino Puntatore

	end try
		





end subroutine

private function integer chiudi_pl ();//
//=== Chiude Piano di Lavorazione
//
//--- Torna 0=tutto ok; 
//---       1=errore grave
//---       2=elab non eseguita; 
//
//
int k_errore=0, k_nrc
string k_rc
long k_riga
boolean k_elabora=true
st_sv_eventi_sked kst_sv_eventi_sked
st_esito kst_esito, kst_esito_err
kuf_sv_skedula kuf1_sv_skedula

pointer oldpointer  // Declares a pointer variable



//--- se pl barcode gia' chiuso non fa un bel niente
if if_pl_barcode_chiuso() then

	messagebox("Elaborazione non eseguita", &
				  "Il Piano di Lavorazione e' gia' Chiuso.~n~r" &
				  + "Codice: " &
				  + trim(string(dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice"))) + "~n~r", &
				  Information! )

else

	if k_elabora then
		
		k_nrc = messagebox("Chiudi P.L. - Elaborazione Definitiva ", &
					  "ATTENZIONE~n~rquesta elaborazione Aggiorna e Chiude il P.L..~n~r" &
					  + "Dopo l'aggiornamento non sara' piu' possibile eseguire alcuna~n~r" &
					  + "modifica nel Piano di Lavorazione~n~r~n~r" &
					  + "Proseguire?", &
					  question!, YesNo!, 2) 
	
		if k_nrc = 2 then
			k_elabora = false
			k_errore = 2
		else
			k_elabora = true
		end if
			
	end if
	
	try 

		if k_elabora then 
			
//--- Salva il PL
			k_rc = aggiorna_dati()		
			
			if Left(k_rc, 1) <> "0" then //Aggiornamento fallito
				k_errore = 1 
				k_elabora = false 
	
				kst_esito_err.esito = Left(k_rc, 1)
				kst_esito_err.sqlcode = sqlca.sqlcode
				kst_esito_err.sqlerrtext = trim(Mid(k_rc, 2))
				kuf1_data_base.errori_scrivi_esito("W", kst_esito_err) 
				
			end if
		end if
		
		if k_elabora and k_errore = 0 then 
		
			oldpointer = SetPointer(HourGlass!)   // Puntatore Cursore da attesa.....

//--- Chiudi PL effettivamente !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!			
			chiudi_pl_elabora( )
//-------------------------------------------------------			

//--- Verifica se l'invio è fatto in automatico
			kuf1_sv_skedula = create kuf_sv_skedula
			kst_sv_eventi_sked.id_menu_window = kkg_id_programma_pilota_esporta_pl
			kst_esito = kuf1_sv_skedula.get_time_evento( kst_sv_eventi_sked )
			if isvalid(kuf1_sv_skedula) then destroy kuf1_sv_skedula
			
			if kst_esito.esito = kkg_esito_ok then
				messagebox("Chiusura Piano di Lavorazione" &
						  ,"Operazione terminata correttamente.~n~r" &
						  + "Chiuso Piano di Lavorazione con codice: " &
						  + trim(string(dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice")))  &
						  + "~n~r~n~r" + "Il piano sara' inviato in automatico alle " &
						  + string(kst_sv_eventi_sked.run_ora ) + " del " + string(kst_sv_eventi_sked.run_giorno )  &
						  ,Information! )
		
			else
				if kst_esito.esito = kkg_esito_not_fnd then
					
					messagebox("Chiusura Piano di Lavorazione", &
						  "Operazione terminata correttamente.~n~r" &
						  + "Chiuso Piano di Lavorazione con codice: " &
						  + trim(string(dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice")))  &
						  + "~n~r~n~r" + "Effettuare l'invio del Piano in modo Manuale dal Menu 'Magazzino'!  ~n~r" &
						  ,Information! )
				else
					messagebox("Chiusura Piano di Lavorazione", &
						  "Operazione terminata correttamente.~n~r" &
						  + "Chiuso Piano di Lavorazione con codice: " &
						  + trim(string(dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice"))) + "~n~r", &
						  Information! )
				end if
			end if
		
		end if
		
	catch (uo_exception kuo_exception)
		k_errore = 1
		kst_esito = kguo_exception.get_st_esito( )
		kguo_exception.inizializza( )
		kguo_exception.messaggio_utente("Chiusura Piano di Lavorazione", &
						  "Operazione di aggiornamento fallita!! ~n~r" &
						  + "~n~r" &
						  + trim(kst_esito.sqlerrtext) &
						  + "~n~r" )

	finally
		SetPointer(oldpointer)  // ripristino Puntatore

	end try
		
end if



return k_errore

end function

private function integer apri_pl ();//
//=== Ri-apre Piano di Lavorazione
//
//--- Torna 0=tutto ok; 
//---       1=errore grave
//---       2=elab non eseguita; 
//
//
int k_errore=0, k_nrc
string k_rc
boolean k_elabora=FALSE
st_tab_barcode kst_tab_barcode
st_tab_pl_barcode kst_tab_pl_barcode
st_esito kst_esito
kuf_barcode kuf1_barcode
pointer oldpointer  



try 


	kuf1_barcode = create kuf_barcode

//--- se anche solo un barcode ha già iniziato il trattamento NO!
	kst_tab_barcode.pl_barcode = dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice")
	if kuf1_barcode.get_nr_barcode_in_lav_x_pl(kst_tab_barcode) > 0  then

		k_errore = 2
		ki_chiudi_PL_enabled = false
		messagebox("Elaborazione non eseguita", &
				  "Il Piano di Lavorazione e' gia' in TRATTAMENTO quindi non può essere Riaperto.~n~r" &
				  + "Codice: " &
				  + trim(string(dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice"))) + "~n~r", &
				  Information! )

	else

//--- se anche solo un barcode è già stato trasferito al PILOTA allora NON si può APRIRE
		kst_tab_pl_barcode.codice = dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice")
		if kiuf1_pl_barcode.if_pl_trasferito_al_pilota(kst_tab_pl_barcode) then
			
			ki_chiudi_PL_enabled = false
			messagebox("Elaborazione non eseguita", &
				  "Il Piano di Lavorazione e' gia' Trasferito al Pilota e non può essere Riaperto.~n~r" &
				  + "Codice: " &
				  + trim(string(dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice"))) + "~n~r", &
				  Information! )

		else

			k_nrc = messagebox("Chiudi P.L. - Elaborazione CRITICA ", &
					  "RIAPERTURA!!! ~n~rquesta elaborazione Rapre il P.L..~n~r" &
					  + "Se il Piano è già stato caricato nel PILOTA (magari in ritardo), potranno verificarsi delle Incongruenze GRAVI " &
					  + "nei dati dei BARCODE di questo Piano di Lavorazione!!! ~n~r~n~r" &
					  + "Proseguire comunque?", &
					  question!, YesNo!, 2) 
	
			if k_nrc = 2 then
				k_errore = 2
			else
				k_elabora = true  // OK APRIAMO!
			end if
				
		end if
	end if
	

	if k_elabora then 
			
		
		oldpointer = SetPointer(HourGlass!)   // Puntatore Cursore da attesa.....

//--- RI-APRE il PL effettivamente !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!			
		apri_pl_elabora( )
//-------------------------------------------------------			

		try 
			
			kst_tab_pl_barcode.codice = dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice")
			kiuf1_pl_barcode.get_path_file_pilota(kst_tab_pl_barcode)
			kiuf1_pl_barcode.cancella_file_pilota(kst_tab_pl_barcode)
			
		catch (uo_exception kuo1_exception)
			kuo1_exception.messaggio_utente()
			
		end try


	end if

catch (uo_exception kuo_exception)
	k_errore = 1
	kst_esito = kguo_exception.get_st_esito( )
	kguo_exception.inizializza( )
	kguo_exception.messaggio_utente("Riapertura Piano di Lavorazione", &
					  "Operazione di aggiornamento fallita. Il Piano è rimasto chiuso!! ~n~r" &
					  + "~n~r" &
					  + trim(kst_esito.sqlerrtext) &
					  + "~n~r" )
finally
	if IsValid(kuf1_barcode) then destroy kuf1_barcode
	SetPointer(oldpointer)  // ripristino Puntatore

end try


return k_errore

end function

private subroutine apri_pl_elabora () throws uo_exception;//---
//--- Apre Piano di Lavorazione (chiamato da apri_pl)
//---
//--- lancia EXCEPTION
//---
long k_riga
int k_errore=0
st_tab_pl_barcode kst_tab_pl_barcode
st_esito kst_esito, kst_esito_err

pointer oldpointer  // Declares a pointer variable


k_errore = 0
	
	try	

		kst_tab_pl_barcode.codice = dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice")
	
//--- RIPRISTINA gli archivi da eventuali chiusure passate
		kst_tab_pl_barcode.st_tab_g_0.esegui_commit = "N"
		kiuf1_pl_barcode.riapre_pl_barcode(kst_tab_pl_barcode)
			
	
	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito()
		kst_esito_err.esito = kst_esito.esito
		kst_esito_err.sqlcode = kst_esito.sqlcode
		kst_esito_err.sqlerrtext = "Errore durante Riapertura del Piano di Lavorazione (apri_pl_elabora): ~n~r" + trim(kst_esito.sqlerrtext)
		kuf1_data_base.errori_scrivi_esito("W", kst_esito_err) 
		
		kguo_sqlca_db_magazzino.db_rollback( ) 
		
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito_err)
		throw kguo_exception
		
	finally
		SetPointer(oldpointer)  // ripristino Puntatore

	end try
		





end subroutine

on w_pl_barcode_dett.create
int iCurrent
call super::create
this.cb_chiudi=create cb_chiudi
this.cb_togli=create cb_togli
this.cb_pilota_UFO=create cb_pilota_UFO
this.cb_aggiungi=create cb_aggiungi
this.cb_file=create cb_file
this.dw_modifica=create dw_modifica
this.dw_groupage=create dw_groupage
this.dw_barcode=create dw_barcode
this.dw_periodo=create dw_periodo
this.dw_meca=create dw_meca
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_chiudi
this.Control[iCurrent+2]=this.cb_togli
this.Control[iCurrent+3]=this.cb_pilota_UFO
this.Control[iCurrent+4]=this.cb_aggiungi
this.Control[iCurrent+5]=this.cb_file
this.Control[iCurrent+6]=this.dw_modifica
this.Control[iCurrent+7]=this.dw_groupage
this.Control[iCurrent+8]=this.dw_barcode
this.Control[iCurrent+9]=this.dw_periodo
this.Control[iCurrent+10]=this.dw_meca
end on

on w_pl_barcode_dett.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_chiudi)
destroy(this.cb_togli)
destroy(this.cb_pilota_UFO)
destroy(this.cb_aggiungi)
destroy(this.cb_file)
destroy(this.dw_modifica)
destroy(this.dw_groupage)
destroy(this.dw_barcode)
destroy(this.dw_periodo)
destroy(this.dw_meca)
end on

event resize;//---
int k_dist_bordi, k_spess_bordi_x, k_spess_bordi_y

	this.setredraw(false)
	
//	if ki_st_open_w.flag_adatta_win = KK_ADATTA_WIN 
	if ki_st_open_w.flag_adatta_win = KK_ADATTA_WIN &
		and not(ki_personalizza_pos_controlli) &
		then

		
		k_dist_bordi = 5
		k_spess_bordi_x = 145
		k_spess_bordi_y = 180
		
		dw_meca.width = this.width * 0.62 
		dw_dett_0.width = this.width - dw_meca.width - k_dist_bordi * 3 - k_spess_bordi_x
		dw_barcode.width = dw_meca.width * 0.57 
		dw_lista_0.width = dw_dett_0.width 
		dw_groupage.width = this.width - dw_barcode.width - dw_lista_0.width - k_dist_bordi * 3 - k_spess_bordi_x
	
		dw_meca.height = this.height * 0.53
		dw_barcode.height = this.height - dw_meca.height - k_dist_bordi * 3 - k_spess_bordi_y
		dw_groupage.height = dw_barcode.height 
	
		dw_dett_0.height = this.height * 0.23 
		dw_lista_0.height = this.height - dw_dett_0.height - k_dist_bordi * 3 - k_spess_bordi_y
	
//=== Posiziona dw nella window 
		dw_meca.x = 5
		dw_meca.y = 5
		dw_barcode.x = dw_meca.x
		dw_barcode.y = dw_meca.height + k_dist_bordi 
		dw_groupage.x = dw_meca.x + dw_barcode.width + k_dist_bordi
		dw_groupage.y = dw_meca.height + k_dist_bordi 

		dw_dett_0.x = dw_meca.x + dw_meca.width + k_dist_bordi
		dw_dett_0.y = dw_meca.y 
		dw_lista_0.x = dw_meca.x + dw_meca.width + k_dist_bordi
		dw_lista_0.y = dw_dett_0.height + k_dist_bordi 
		
		
		
	end if
//end if

	this.setredraw(true)



end event

event open;call super::open;//


//---
//This.WindowState = Maximized!

//=== set transobject per il datawindows di dettaglio
	dw_barcode.settransobject ( sqlca )
	dw_meca.settransobject ( sqlca )
	dw_groupage.settransobject ( sqlca )

//--- path per reperire le ico del drag e drop
	ki_path_risorse = trim(kuf1_data_base.profilestring_leggi_scrivi(1, "arch_graf", " "))

//--- cambia colore alla dw del groupage x distinguerla da quella normale
	dw_groupage_colore(dw_groupage)

//--- abilita i campi x modificare im giri delle lavorazioni
//	abilita_modifica_giri()

//--- abilita la funzione di Chiusura del PL
	abilita_chiusura_pl()	

//--- crea dw di appoggio per lettura orginale dei rif da lavorare
	kids_meca_orig = create datastore
	kids_meca_orig.dataobject = dw_meca.dataobject 

//--- abilita i campi x modificare i giri delle lavorazioni
	abilita_modifica_giri()
	if cb_file.enabled then 
//=== Dimensiona e Posiziona la dw di modifica giri nella window 
//		dw_modifica.object.cb_dettaglio.text = "Dettaglio >>" 
		dw_modifica.object.cb_dettaglio.text = "Nascondi" 
		dw_modifica.width = long(dw_modifica.object.b_linea.x) + &
						 long(dw_modifica.object.b_linea.width) * 1.2
		dw_modifica.height = 105 + long(dw_modifica.object.b_linea.y) 
		dw_modifica.x = (this.width - dw_modifica.width) / 2
		dw_modifica.y = (this.height - dw_modifica.height) / 7
	end if
	
//---- imposta le icone nei pulsanti della dw
dw_dett_0.Modify("b_queue_pilota.filename='" + ki_path_risorse + "\pilota.bmp" + "'")
dw_dett_0.Modify("b_file_pilota.filename='" + ki_path_risorse + "\apri_file1.bmp" + "'")
	
//dw_meca.dragicon = ki_path_risorse + "\drag1.ico"
//dw_barcode.dragicon = ki_path_risorse + "\drag1.ico"
//dw_lista_0.dragicon = ki_path_risorse + "\drag1.ico"




end event

event timer;call super::timer;//

dw_lista_0.title = Mid(dw_lista_0.title,2) + Left(dw_lista_0.title,1) 
dw_groupage.title = Mid(dw_groupage.title,2) + Left(dw_groupage.title,1) 

end event

event close;call super::close;//

//=== Salva le righe del dw (saveas)
kuf1_data_base.dw_saveas("no_pl", dw_meca)

//--- registra la data piu' indietro su BASE cosi' da recuperarla al pross. giro 
set_base_data_ini()


if isvalid(kids_meca_orig) then destroy kids_meca_orig
if isvalid(kiuf1_pl_barcode) then destroy kiuf1_pl_barcode								



end event

event rbuttondown;//
string k_stringa=""
long k_riga=0
string k_tag_old=""
string k_tag=""
m_popup m_menu



//=== Se sono sulla lista con il mouse allora posiziono il punt sul rek puntato

//=== Salvo il Tag attuale per reimpostarlo a fine routine
		k_tag_old = this.tag
		this.tag = " "

//=== Creo menu Popup 
		m_menu = create m_popup

		m_menu.m_pop_lib_1.text = "Rilettura elenco veloce "
		m_menu.m_pop_lib_1.enabled = true
		m_menu.m_pop_lib_1.visible = true
		m_menu.m_t_pop_lib_1.visible = true
		
		m_menu.m_lib_1.text = kG_menu.m_strumenti.m_fin_gest_libero1.text 
		m_menu.m_lib_1.visible = kG_menu.m_strumenti.m_fin_gest_libero1.visible
		m_menu.m_lib_1.enabled = kG_menu.m_strumenti.m_fin_gest_libero1.enabled
//		m_menu.m_t_lib_1.visible = m_menu.m_lib_1.visible
		m_menu.m_lib_2.text = kG_menu.m_strumenti.m_fin_gest_libero2.text 
		m_menu.m_lib_2.visible = kG_menu.m_strumenti.m_fin_gest_libero2.visible
		m_menu.m_lib_2.enabled = kG_menu.m_strumenti.m_fin_gest_libero2.enabled
//		m_menu.m_t_lib_2.visible = m_menu.m_lib_2.visible
		m_menu.m_lib_3.text = kG_menu.m_strumenti.m_fin_gest_libero3.text 
		m_menu.m_lib_3.visible = kG_menu.m_strumenti.m_fin_gest_libero3.visible
		m_menu.m_lib_3.enabled = kG_menu.m_strumenti.m_fin_gest_libero3.enabled
//		m_menu.m_t_lib_3.visible = m_menu.m_lib_3.visible
		m_menu.m_lib_4.text = kG_menu.m_strumenti.m_fin_gest_libero4.text 
		m_menu.m_lib_4.visible = kG_menu.m_strumenti.m_fin_gest_libero4.visible
		m_menu.m_lib_4.enabled = kG_menu.m_strumenti.m_fin_gest_libero4.enabled
		m_menu.m_t_lib_4.visible = m_menu.m_lib_4.visible

		m_menu.m_inserisci.visible = cb_inserisci.enabled
		m_menu.m_modifica.visible = cb_modifica.enabled
		m_menu.m_t_modifica.visible = cb_modifica.enabled
		m_menu.m_cancella.visible = cb_cancella.enabled
		m_menu.m_t_cancella.visible = cb_cancella.enabled
		m_menu.m_visualizza.visible = cb_visualizza.enabled

		m_menu.m_agglista.visible = true
		m_menu.m_t_agglista.visible = true
//		if dw_lista_0.rowcount() > 0 or dw_filtra.rowcount() > 0 then
//			m_menu.m_filtro.visible = true
//			m_menu.m_t_filtro.visible = false
//		end if
		m_menu.m_stampa.visible = st_stampa.enabled
		m_menu.m_t_stampa.visible = st_stampa.enabled
		m_menu.m_conferma.visible = cb_aggiorna.enabled
		m_menu.m_ritorna.visible = true

//=== Attivo il menu Popup
		m_menu.visible = true
		m_menu.popmenu(this.x + pointerx(), this.y + pointery())
		m_menu.visible = false

		destroy m_menu

		k_tag = this.tag 

		this.tag = k_tag_old 

		if trim(k_tag) <> "" then
			smista_funz(k_tag)
		end if
		


end event

event u_ricevi_da_elenco;call super::u_ricevi_da_elenco;//
//
int k_rc
long k_num_int, k_riga
date k_data_int
window k_window
st_esito kst_esito
st_tab_pl_barcode kst_tab_pl_barcode
st_tab_barcode kst_tab_barcode
kuf_barcode kuf1_barcode


//st_open_w kst_open_w

//kst_open_w = Message.PowerObjectParm	

if isvalid(kst_open_w) then

//--- Dalla finestra di Elenco Valori
	if kst_open_w.id_programma = kkg_id_programma_elenco and long(kst_open_w.key3) > 0 then
	
//--- vale solo se sono in aggiornamento	
 		if ki_st_open_w.flag_modalita =  kkg_flag_modalita_inserimento or ki_st_open_w.flag_modalita = kkg_flag_modalita_modifica then

			if not isvalid(kdsi_elenco_input) then kdsi_elenco_input = create datastore
	
//--- Se dalla w di elenco doppio-click		
			choose case kst_open_w.key2
					
				case "d_pilota_queue_table_h" 
			
					kdsi_elenco_input = kst_open_w.key12_any 
				
					if kdsi_elenco_input.rowcount() > 0 then
				
						kst_tab_pl_barcode.prima_del_barcode = trim( kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "barcode") )
		
						if Len(trim(kst_tab_pl_barcode.prima_del_barcode)) > 0 then
							
		//--- imposta il dato selezioato in elenco nel campo
							dw_dett_0.setitem(dw_dett_0.getrow(), "prima_del_barcode", kst_tab_pl_barcode.prima_del_barcode) 				
						end if					
						
					end if

//--- scelto Padre potenziale
				case  dw_lista_0.dataobject
					kdsi_elenco_input = kst_open_w.key12_any 
				
					if kdsi_elenco_input.rowcount() > 0 then
						kst_tab_barcode.barcode = kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "barcode_barcode")
						aggiungi_barcode_padre(kst_tab_barcode)
						
					end if


				case "d_pl_barcode_dett_1"
					kdsi_elenco_input = kst_open_w.key12_any 
				
					if kdsi_elenco_input.rowcount() > 0 then
						kst_tab_barcode.barcode = kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "barcode_barcode")
						aggiungi_barcode_padre(kst_tab_barcode)
						
					end if
					
							
			end choose
		end if

	end if

end if
//


end event

event deactivate;call super::deactivate;//
//--- Disattivo il timer 
	timer( 0 )
//

end event

event activate;call super::activate;//--- attivo il timer ogni mezzo secondo	
	timer( 0.5 )
//

end event

event closequery;call super::closequery;
//--- disattivo il timer
timer( 0 )


end event

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_pl_barcode_dett
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_pl_barcode_dett
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_pl_barcode_dett
integer x = 37
integer y = 544
integer taborder = 0
end type

type st_stampa from w_g_tab0`st_stampa within w_pl_barcode_dett
integer x = 37
integer y = 352
end type

type st_ritorna from w_g_tab0`st_ritorna within w_pl_barcode_dett
integer x = 37
integer y = 256
end type

type dw_trova from w_g_tab0`dw_trova within w_pl_barcode_dett
integer x = 800
integer y = 28
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_pl_barcode_dett
integer x = 37
integer y = 1248
integer taborder = 90
end type

type cb_modifica from w_g_tab0`cb_modifica within w_pl_barcode_dett
integer x = 37
integer y = 640
integer taborder = 0
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_pl_barcode_dett
integer x = 37
integer y = 832
integer taborder = 0
end type

event cb_aggiorna::clicked;//
string k_return


	k_return = aggiorna_dati( )
	
	if Left(k_return, 1) = "0" then
		messagebox("Operazione eseguita", "Dati aggiornati correttamente")
	end if
	
	
end event

type cb_cancella from w_g_tab0`cb_cancella within w_pl_barcode_dett
integer x = 37
integer y = 736
integer taborder = 0
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_pl_barcode_dett
integer x = 37
integer y = 1152
integer taborder = 0
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_pl_barcode_dett
event ue_mousemove pbm_mousemove
boolean visible = true
integer x = 2277
integer y = 28
integer width = 1751
integer height = 872
integer taborder = 10
boolean enabled = true
boolean titlebar = true
string title = "Proprieta~'  Piano di Lavorazione"
string dataobject = "d_pl_barcode_testa_1"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
end type

event dw_dett_0::buttonclicked;call super::buttonclicked;//
string k_file 
st_esito kst_esito
kuf_ole kuf1_ole


try
		
	choose case dwo.name
		case "b_file_pilota"
			open_notepad_documento()

		case "b_queue_pilota"
			open_elenco_pilota_coda()
	end choose

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
end try

	
end event

event dw_dett_0::getfocus;call super::getfocus;//
//--- evitare lo script standard
//
end event

type st_orizzontal from w_g_tab0`st_orizzontal within w_pl_barcode_dett
boolean visible = false
boolean enabled = false
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_pl_barcode_dett
event ue_mousemove pbm_mousemove
event ue_lbuttonup pbm_lbuttonup
event ue_lbuttondown pbm_lbuttondown
integer x = 2240
integer y = 924
integer width = 1755
integer height = 704
integer taborder = 20
boolean titlebar = true
string title = "Pianificazione per l~'irraggiamento della merce entrata. Trascina con il mouse il Riferimento o il singolo Barcode ~'Padre~' all~'interno di questa area, automaticamente sarà aggiunto a fine lista.                              "
string dataobject = "d_pl_barcode_dett_1"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
boolean ki_d_std_1_attiva_sort = false
boolean ki_attiva_dragdrop = true
boolean ki_in_drag = true
end type

event dw_lista_0::ue_lbuttonup;//
	k_dragdrop = false
	this.drag(cancel!)
	

end event

event dw_lista_0::ue_lbuttondown;//
long k_ctr = 0
long k_Height

if isnumber(this.Describe("#1.Height")) then
	k_Height = long(this.Describe("#1.Height"))

	if ypos > k_Height then

		if this.rowcount() > 1 then
			k_ctr = this.getselectedrow( 0 )
		else
			if this.rowcount() = 1 then
				this.selectRow (1, true)
				k_ctr = 1
			end if
		end if
		
		//--- flags = 1 pulsante sinistro pigiato 
		if k_ctr > 0 and (ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento &
			or ki_st_open_w.flag_modalita = kkg_flag_modalita_modifica) then
		
			k_ctr = this.getselectedrow( 0 )
			if this.getselectedrow( k_ctr ) > 0 then
				this.dragicon = ki_path_risorse + "\drag2.ico"
			else
				this.dragicon = ki_path_risorse + "\drag1.ico"
			end if
			
			k_dragdrop = true
			this.drag(begin!)
		
		end if
	end if
end if

end event

event dw_lista_0::dragdrop;call super::dragdrop;//
datawindow kdw_1
string k_nome




CHOOSE CASE TypeOf(source)

	CASE datawindow!

   		kdw_1 = source
		kdw_1.Drag(cancel!)

		if ki_st_open_w.flag_modalita = kkg_flag_modalita_modifica or ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento then

			choose case kdw_1.classname()
					
				case "dw_meca" 
					aggiungi_barcode_tutti(dw_lista_0)
	
				case "dw_barcode" 
					aggiungi_barcode_singolo(dw_lista_0, dw_barcode)
					
				case "dw_groupage" 
					aggiungi_barcode_singolo(dw_lista_0, dw_groupage)
					
				case "dw_lista_0" 
//--- sistema il codice e i progressivi nella lista
					imposta_codice_progr( kdw_1 )
					attiva_tasti()
				
			end choose
			
		end if
		
		k_dragdrop = false
		
END CHOOSE

end event

event dw_lista_0::doubleclicked;//
if this.rowcount() < 2 then
	beep(1)
else
	call_window_barcode()
end if

attiva_tasti ()


end event

event dw_lista_0::getfocus;//
this.icon = this.ki_icona_selezionata
kidw_selezionata = this
 
end event

event dw_lista_0::rowfocuschanged;//
if not k_dragdrop then
	Super::EVENT rowfocuschanged(currentrow)
end if

end event

event dw_lista_0::clicked;call super::clicked;if row > 0 then
//
//--- scompare la dw_modifica se perdo il fuoco
//
	dw_modifica.visible = false
end if

end event

type dw_guida from w_g_tab0`dw_guida within w_pl_barcode_dett
end type

type cb_chiudi from statictext within w_pl_barcode_dett
boolean visible = false
integer x = 37
integer y = 416
integer width = 160
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "chiudi"
boolean focusrectangle = false
end type

event clicked;//
//
integer k_elaborazione_ok=0
string k_errore = "0"
date k_data_chiuso, k_dataoggi



	if dw_lista_0.rowcount() <= 0 and dw_groupage.rowcount() <= 0 then
		messagebox("Operazione fallita", &
					"Nessun Barcode immesso nella pianificazione.~n~r" + &
					"~n~r" )

	else


		dw_dett_0.accepttext()
		dw_lista_0.accepttext()

			
		if ki_chiudi_PL_enabled then
			if ki_PL_chiuso then   

				k_elaborazione_ok = apri_pl()  // RIAPRE IL PIANO
				
			else
			
				k_data_chiuso = dw_dett_0.getitemdate ( dw_dett_0.getrow(), "data_chiuso") 
				if isnull(k_data_chiuso) or k_data_chiuso <= date(0) then
					k_dataoggi = kg_dataoggi
					dw_dett_0.setitem ( dw_dett_0.getrow(), "data_chiuso", k_dataoggi)
				end if
			
				k_elaborazione_ok = chiudi_pl()    // CHIUDE IL PIANO DI LAVORAZIONE
					
			end if
					
			if k_elaborazione_ok = 0 then

				kiuf1_sync_window.u_window_set_funzione_aggiornata(ki_st_open_w) // setta x sicronizzare il ritorno
				
				if ki_PL_chiuso then 
					messagebox("Operazione Conclusa", "Il Piano di Lavorazione è stato Riaperto correttamente.")
					
					smista_funz( kkg_flag_richiesta_esci )  // Esce!
//						ki_st_open_w.flag_modalita = kkg_flag_modalita_modifica
				else
					ki_chiudi_PL_enabled = false
					ki_st_open_w.flag_modalita = kkg_flag_modalita_visualizzazione
					ki_st_open_w.key1 = string( dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice")) 
			
					proteggi_campi()
					
					inizializza() 
//					attiva_tasti ()
				end if
				
			end if
		else
			messagebox("Operazione non Autorizzata", &
				"Utente non autorizzato al Chiudere/Riaprire il Piano di Lavorazione.~n~r" + &
				"~n~r" )
			
		end if
	end if



end event

type cb_togli from statictext within w_pl_barcode_dett
boolean visible = false
integer x = 37
integer y = 192
integer width = 105
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "sub"
boolean focusrectangle = false
end type

event clicked;//

	if kuf1_data_base.u_getfocus_nome() = "dw_lista_0" then
		
		if dw_lista_0.rowcount() <= 0 then 
			
			messagebox("Operazione fallita", &
						  "Nessuna Barcode presente in lista 'barcode da trattare'.~n~r")
		
		else
			if dw_lista_0.getselectedrow(0) <= 0 then
		
				messagebox("Operazione fallita", &
						"Selezionare almeno un Barcode dalla lista 'barcode da trattare'.~n~r")
			else
	
				togli_barcode_padre(dw_lista_0)
			end if
		end if
		
	else
		if dw_lista_0.rowcount() <= 0 then 
			
			messagebox("Operazione fallita", &
						  "Nessuna Barcode presente in lista 'barcode in GROUPAGE'.~n~r")
		
		else
			if dw_lista_0.getselectedrow(0) <= 0 then
		
				messagebox("Operazione fallita", &
						"Selezionare almeno un Barcode dalla lista 'barcode in GROUPAGE'.~n~r")
			else
	
				togli_barcode_figlio(dw_groupage)
			end if
		end if
	end if

	attiva_tasti ()

	dw_lista_0.setfocus ()
	

end event

type cb_pilota_UFO from statictext within w_pl_barcode_dett
boolean visible = false
integer x = 37
integer y = 480
integer width = 146
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "pilota"
boolean focusrectangle = false
end type

event clicked;//
//
string k_errore = "0"



//	if dw_lista_0.rowcount() <= 0 then
//		messagebox("Operazione fallita", &
//					"Nessun Barcode in lista da mettere in lavorazione.~n~r" + &
//					"(Aggiungi almeno 2 Barcode in lista)~n~r" )
//
//	else

			
		if crea_file_pilota() = 0 then
		
//			ki_st_open_w.flag_modalita = "vi"
//			ki_st_open_w.key1 = string( dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice")) 
//			
//			inizializza()
			
		end if			
//			dw_dett_0.retrieve(dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice")) 
			
//		else
//			messagebox("Operazione non eseguita", &
//					"Nessun File di Lavorazione creato per il Pilota.~n~r" + &
//					trim(mid(k_errore,2)) )
//		end if
//
//	end if
//
	attiva_tasti ()


end event

type cb_aggiungi from statictext within w_pl_barcode_dett
boolean visible = false
integer x = 37
integer y = 128
integer width = 101
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "add"
boolean focusrectangle = false
end type

event clicked;//
	if dw_barcode.getselectedrow(0) > 0 then
		if kuf1_data_base.u_getfocus_nome() = "dw_lista_0" then
			aggiungi_barcode_singolo(dw_lista_0, dw_barcode)
		else
			aggiungi_barcode_singolo(dw_groupage, dw_barcode)
		end if
		dw_barcode.setfocus( ) 
	else
		if dw_meca.getselectedrow(0) > 0 then
			if kuf1_data_base.u_getfocus_nome() = "dw_lista_0" then
				aggiungi_barcode_tutti(dw_lista_0)
			else
				aggiungi_barcode_tutti(dw_groupage)
			end if
			dw_meca.setfocus()
		end if
	end if


	attiva_tasti ()
	

end event

type cb_file from statictext within w_pl_barcode_dett
boolean visible = false
integer x = 37
integer y = 64
integer width = 146
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "cicli"
boolean focusrectangle = false
end type

type dw_modifica from uo_dw_modifica_giri_barcode within w_pl_barcode_dett
integer x = 27
integer y = 2100
integer width = 3479
integer height = 688
integer taborder = 100
boolean bringtotop = true
boolean enabled = true
end type

type dw_groupage from uo_d_std_1 within w_pl_barcode_dett
event ue_lbuttondown pbm_lbuttondown
event ue_lbuttonup pbm_lbuttonup
boolean visible = true
integer x = 1673
integer y = 1256
integer width = 869
integer height = 832
integer taborder = 50
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string title = "Per completare un Groupage trascina il riferimento/barcode ~'Figlio~' in questa area...       "
string dataobject = "d_pl_barcode_dett_grp_all"
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean ki_d_std_1_attiva_sort = false
end type

event ue_lbuttondown;//
long k_ctr = 0
long k_Height


if isnumber(this.Describe("#1.Height")) then
	k_Height = long(this.Describe("#1.Height"))

	if ypos > k_Height then

		if this.rowcount() > 1 then
			k_ctr = this.getselectedrow( 0 )
		else
			if this.rowcount() = 1 then
				this.selectRow (1, true)
				k_ctr = 1
			end if
		end if
		
		//--- flags = 1 pulsante sinistro pigiato 
		if k_ctr > 0 and (ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento &
			or ki_st_open_w.flag_modalita = kkg_flag_modalita_modifica) then
		
			k_ctr = this.getselectedrow( 0 )
			if this.getselectedrow( k_ctr ) > 0 then
				this.dragicon = ki_path_risorse + "\drag2.ico"
			else
				this.dragicon = ki_path_risorse + "\drag1.ico"
			end if
			
			k_dragdrop = true
			this.drag(begin!)
		
		end if
	end if
end if

end event

event ue_lbuttonup;//
	k_dragdrop = false
	this.drag(cancel!)
	

end event

event dragdrop;call super::dragdrop;//
datawindow kdw_1
string k_nome

CHOOSE CASE TypeOf(source)

	CASE datawindow!

		kdw_1 = source
	 
		if ki_st_open_w.flag_modalita = kkg_flag_modalita_modifica or ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento then
			
			choose case kdw_1.classname()
					
				case "dw_meca"  
					aggiungi_grp_rif_intero(dw_groupage)
	
				case "dw_barcode" 
					aggiungi_grp_barcode_singolo(dw_groupage, dw_barcode)
					
				case "dw_lista_0" 
					aggiungi_grp_barcode_singolo(dw_groupage, dw_lista_0)
					
			end choose
			
		end if
		k_dragdrop = false
		kdw_1.Drag(cancel!)

		
END CHOOSE

attiva_tasti ()


end event

event doubleclicked;//
if this.rowcount() < 2 then
	beep(1)
else
	call_window_barcode()
end if

attiva_tasti ()


end event

event getfocus;//
this.icon = this.ki_icona_selezionata
kidw_selezionata = this


end event

event rowfocuschanged;////
//if not k_dragdrop then
//	Super::EVENT rowfocuschanged(currentrow)
//end if
//
end event

event clicked;call super::clicked;//
if row > 0 then
//
//--- scompare la dw_modifica se perdo il fuoco
//
	dw_modifica.visible = false
end if


//
	if dwo.name = "scegli_padre" or dwo.name = "b_scegli_padre"  then
		post scegli_padre_da_dw_lista(row)
	end if

//
end event

event itemchanged;call super::itemchanged;//
attiva_tasti ()

end event

type dw_barcode from uo_d_std_1 within w_pl_barcode_dett
event ue_lbuttondown pbm_lbuttondown
event ue_lbuttonup pbm_lbuttonup
boolean visible = true
integer x = 133
integer y = 1368
integer width = 1390
integer taborder = 30
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string title = "Dettaglio Riferimento"
string dataobject = "d_barcode_l_no_pl"
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
end type

event ue_lbuttondown;//
long k_ctr
long k_Height


if isnumber(this.Describe("#1.Height")) then
	k_Height = long(this.Describe("#1.Height"))

	if ypos > k_Height then
	
		k_ctr = this.getselectedrow( 0 )
		
		//--- flags = 1 pulsante sinistro pigiato 
		if k_ctr > 0 and (ki_st_open_w.flag_modalita = "in" or ki_st_open_w.flag_modalita = "mo") then
		
			k_ctr = this.getselectedrow( 0 )
			
			if this.getselectedrow( k_ctr ) > 0 then
				this.dragicon = ki_path_risorse + "\drag2.ico" 
			else		
				this.dragicon = ki_path_risorse + "\drag1.ico"
			end if
			
			k_dragdrop = true
			this.drag(begin!)
		end if
	end if
end if
end event

event ue_lbuttonup;//
	k_dragdrop = false
	this.drag(cancel!)
	

end event

event u_doppio_click;//
if ki_st_open_w.flag_modalita = kkg_flag_modalita_modifica or ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento then
	aggiungi_barcode_singolo(dw_lista_0, dw_barcode )
end if



end event

event dragdrop;call super::dragdrop;//
datawindow kdw_1


CHOOSE CASE TypeOf(source)

	CASE datawindow!

   	kdw_1 = source

	if kdw_1.DataObject = "d_pl_barcode_dett_1" then
		togli_barcode_padre(dw_lista_0)
	else
		if kdw_1.DataObject = "d_pl_barcode_dett_grp_all" then
			togli_barcode_figlio(dw_groupage)
		else
			
			if kdw_1.DataObject = "d_meca_barcode_elenco_no_lav" then
				riempi_dettaglio( )
			end if
		end if
	end if
		
	
	k_dragdrop = false
	source.Drag(cancel!)
		

END CHOOSE

end event

event getfocus;call super::getfocus;////
//
//this.icon = "Exclamation!"
kidw_selezionata = this

if this.rowcount() > 0 then
	this.title = "Dettaglio Riferimento: " + string(this.getitemnumber(1, "barcode_num_int"))
else
	this.title = "Dettaglio Riferimento " 
end if

end event

event losefocus;call super::losefocus;//
if this.rowcount() > 0 then
	this.title = "Dettaglio Riferimento: " + string(this.getitemnumber(1, "barcode_num_int"))
else
	this.title = "Dettaglio Riferimento " 
end if

end event

event rowfocuschanged;//

if k_dragdrop = false then
	
	super::EVENT rowfocuschanged(currentrow)

end if

end event

event clicked;call super::clicked;//
//--- scompare la dw_modifica se perdo il fuoco
//
	dw_modifica.visible = false
 
end event

type dw_periodo from uo_d_std_1 within w_pl_barcode_dett
integer y = 848
integer width = 955
integer height = 504
integer taborder = 70
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string title = "Periodo di estrazione"
string dataobject = "d_periodo"
boolean controlmenu = true
boolean hsplitscroll = false
boolean livescroll = false
end type

event buttonclicked;call super::buttonclicked;//
st_stampe kst_stampe
pointer oldpointer  // Declares a pointer variable

	
//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)
	

if dwo.name = "b_ok" then
	
	
	this.visible = false
	
	ki_data_ini  = this.getitemdate( 1, "data_dal")
	ki_data_fin  = this.getitemdate( 1, "data_al")
	rilegge_no_lav()

else
	if dwo.name = "b_annulla" then

		this.visible = false
	
	
	end if
end if

SetPointer(oldpointer)


end event

event ue_visibile;call super::ue_visibile;//
int k_rc

	this.width = long(this.object.data_al.x) + long(this.object.data_al.width) + 100
	this.height = long(this.object.b_ok.y) + long(this.object.b_ok.height) + 160

	this.x = (kiw_this_window.width  - this.width) / 4
	this.y = (kiw_this_window.height - this.height) / 4

	this.reset()
	k_rc = this.insertrow(0)
	k_rc = this.setitem(1, "data_dal", ki_data_ini)
	k_rc = this.setitem(1, "data_al", ki_data_fin)
	this.object.data_al.Edit.DisplayOnly='Yes'
	this.object.data_al.Background.Color=KK_COLORE_CAMPO_DISATTIVO
	this.object.data_al.TabSequence='0'
	this.visible = true
	this.setfocus()
	
end event

type dw_meca from uo_d_std_1 within w_pl_barcode_dett
event ue_lbuttondown pbm_lbuttondown
event ue_lbuttondown_post ( )
boolean visible = true
integer x = 151
integer y = 488
integer width = 2103
integer height = 592
integer taborder = 40
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string title = "Elenco Riferimenti senza P.L."
string dataobject = "d_meca_barcode_elenco_no_lav"
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
end type

event ue_lbuttondown;//
long k_ctr
long k_Height


if isnumber(this.Describe("#1.Height")) then
	k_Height = long(this.Describe("#1.Height"))

	if ypos > k_Height then
	
		this.postevent ("ue_lbuttondown_post")
		
		
	end if
end if
end event

event ue_lbuttondown_post();//
long k_ctr


		k_ctr = this.getselectedrow( 0 )
		
		//--- flags = 1 pulsante sinistro pigiato 
		if k_ctr > 0 and (ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento or ki_st_open_w.flag_modalita = kkg_flag_modalita_modifica) then
		
			k_ctr = this.getselectedrow( 0 )
			
			if this.getselectedrow( k_ctr ) > 0 then
				this.dragicon = ki_path_risorse + "\drag2.ico" 
			else		
				this.dragicon = ki_path_risorse + "\drag1.ico"
			end if
			
			k_dragdrop = true
			this.drag(begin!)
		end if

end event

event dragdrop;call super::dragdrop;//
datawindow kdw_1


CHOOSE CASE TypeOf(source)

	CASE datawindow!

   	kdw_1 = source

END CHOOSE

if k_dragdrop then
	if kdw_1.DataObject = "d_pl_barcode_dett_1" then
		togli_barcode_padre(dw_lista_0)
	else
		if kdw_1.DataObject = "d_pl_barcode_dett_grp_all" then
			togli_barcode_figlio(dw_groupage)
		else
			if kdw_1.DataObject = "d_barcode_l" then
				togli_dettaglio()
			end if
		end if
	end if
end if

k_dragdrop = false
source.Drag(cancel!)

this.setcolumn(1)


end event

event getfocus;call super::getfocus;////
//
//this.icon = "Exclamation!"
//

kidw_selezionata = this

dw_barcode.SelectRow(0, FALSE)

//
attiva_menu( )

end event

event rowfocuschanged;//

if k_dragdrop = false then
	
	super::EVENT rowfocuschanged(currentrow)

end if

end event

event u_doppio_click;//
	riempi_dettaglio()

end event

event ue_lbuttonup;

	k_dragdrop = false
	this.drag(cancel!)
	



end event

event losefocus;call super::losefocus;//
attiva_menu( )

end event

event clicked;//
//--- scompare la dw_modifica se perdo il fuoco
//

	dw_modifica.visible = false


	if dwo.name = "grp" then
		
		super::event ue_selectrow (row)
		
		post call_elenco_grp()
		
	else
		
		super::event clicked( xpos, ypos, row, dwo)
		
	end if
	
	
end event

event ue_dwnkey;call super::ue_dwnkey;//
if key = keyF12! then
	
	smista_funz( kkg_flag_richiesta_libero3 )  // attiva/disattiva Lotto "in Attenzione"
	
end if

end event

