$PBExportHeader$w_pl_barcode_dett.srw
forward
global type w_pl_barcode_dett from w_g_tab0
end type
type cb_chiudi from statictext within w_pl_barcode_dett
end type
type cb_togli from statictext within w_pl_barcode_dett
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
type dw_meca from uo_d_std_1 within w_pl_barcode_dett
end type
type dw_periodo from uo_d_std_1 within w_pl_barcode_dett
end type
end forward

global type w_pl_barcode_dett from w_g_tab0
boolean visible = true
integer width = 3739
integer height = 2320
string title = "Piano di Lavorazione"
boolean hscrollbar = true
boolean vscrollbar = true
long backcolor = 16777215
boolean ki_toolbar_window_presente = true
boolean ki_reset_dopo_save_ok = false
event u_check_troppi_barcode ( )
cb_chiudi cb_chiudi
cb_togli cb_togli
cb_aggiungi cb_aggiungi
cb_file cb_file
dw_modifica dw_modifica
dw_groupage dw_groupage
dw_barcode dw_barcode
dw_meca dw_meca
dw_periodo dw_periodo
end type
global w_pl_barcode_dett w_pl_barcode_dett

type variables

private constant long ki_dw_groupage_colore = rgb(173,174,222)
//private datastore kdsi_elenco
private datastore kids_meca_orig
//private datawindow kidw_selezionata
private datawindow kidw_x_modifica_giri
private boolean ki_dragdrop = false
//private boolean ki_modifica_cicli_enabled = false
private boolean ki_chiudi_PL_enabled = false
private boolean ki_PL_chiuso = false
private boolean ki_operazione_chiusura = false
private boolean ki_consenti_lavoraz_non_associati_wmf = false
//private constant char ki_modalita_modifica_scelta_fila="0"
//private constant char ki_modalita_modifica_giri_riga="1"
//private constant char ki_modalita_modifica_giri_righe="2"
//private constant char ki_modalita_modifica_giri_visualizza="3"
private date ki_data_ini 
private date ki_data_fin 

private boolean ki_lista_0_modifcato=false
private kuf_pl_barcode kiuf1_pl_barcode
private kuf_armo kiuf_armo

private boolean ki_autirizza_marca_stato_in_attenzione=false

private string ki_dw_fuoco_nome = ""  // datawindow da cui ho iniziato a fare il drag&drop

private long ki_riga_pos_dw_meca = 0
private long ki_id_meca_pos_dw_meca = 0

private kuf_e1_asn kiuf_e1_asn
private boolean ki_e1_enabled = false

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
private function integer check_modifica_giri ()
public subroutine aggiungi_barcode_singolo (ref datawindow kdw_1, ref datawindow kdw_2)
public subroutine aggiungi_barcode_tutti (ref datawindow kdw_1)
protected function string leggi_liste ()
private function st_esito screma_lista_riferimenti ()
private subroutine proteggi_campi ()
protected subroutine smista_funz (string k_par_in)
protected subroutine attiva_menu ()
private function boolean if_pl_barcode_chiuso ()
private subroutine set_dw_dett_0 (st_tab_pl_barcode kst_tab_pl_barcode)
private subroutine open_elenco_pilota_coda () throws uo_exception
private subroutine open_notepad_documento () throws uo_exception
public subroutine aggiungi_grp_rif_intero (ref datawindow kdw_1)
private subroutine togli_figli_al_dw_groupage (st_tab_barcode kst_tab_barcode)
private subroutine aggiungi_figli_al_dw_groupage (st_tab_barcode kst_tab_barcode)
public subroutine togli_barcode_padre (ref datawindow kdw_1)
public subroutine togli_barcode_figlio (ref datawindow kdw_1)
private subroutine scegli_padre_da_dw_lista (long k_riga_dw_groupage)
private subroutine call_elenco_barcode_padri_potenziali (long k_riga_dw_groupage)
private subroutine aggiungi_barcode_padre (st_tab_barcode kst_tab_barcode)
private function integer call_window_barcode ()
private subroutine aggiungi_figli_dal_dw_lista ()
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
public subroutine call_elenco_grp ()
protected function boolean if_programazione_ok () throws uo_exception
private subroutine chiudi_pl_elabora () throws uo_exception
private function integer chiudi_pl ()
private function integer apri_pl ()
private subroutine apri_pl_elabora () throws uo_exception
protected subroutine riempi_id ()
private subroutine modifica_giri (string a_modalita_modifica_file, long a_riga, string a_dw_fuoco_nome)
public subroutine u_marca_rif_file_davanti ()
private function long u_check_rif_file_davanti (long a_riga_inp)
protected function string inizializza_post ()
private subroutine u_autorizza_stato_in_attenzione ()
private function boolean u_autorizza_mod_consegna_data ()
public subroutine u_aggiorna_data_consegna (st_tab_meca kst_tab_meca, long k_riga)
private subroutine u_abilita_chiusura_pl ()
private subroutine u_abilita_modifica_giri ()
public subroutine u_mostra_proprieta (boolean k_forza_visible)
private subroutine copia_dw_barcode_to_dw_groupage (integer k_riga1, integer k_riga2)
private subroutine copia_dw_barcode_to_dw_lista_0 (integer k_riga1, integer k_riga2)
public subroutine aggiungi_grp_barcode_singolo (ref datawindow kdw_2)
private subroutine copia_dw_lista_0_to_dw_groupage (integer k_riga1, integer k_riga2)
private subroutine copia_dw_groupage_to_dw_barcode (integer k_riga1, integer k_riga2)
private subroutine copia_dw_lista_0_to_dw_barcode (integer k_riga1, integer k_riga2)
private subroutine oldcopia_dettaglio_dw_1_da_dw_2 (ref datawindow kdw_1, ref datawindow kdw_2, integer k_riga1, integer k_riga2)
private subroutine copia_dw_groupage_to_dw_lista_0 (integer k_riga1, integer k_riga2)
public subroutine u_rileggi_dw_meca ()
public subroutine u_riempi_dettaglio (long k_riga_meca)
public function boolean if_lotto_associato (ref st_tab_meca ast_tab_meca) throws uo_exception
public subroutine old_set_flag_lotto_wm_associato () throws uo_exception
public subroutine old_set_flag_lotto_e1_associato () throws uo_exception
protected function string aggiorna_dati ()
protected subroutine attiva_tasti_0 ()
public subroutine u_obj_visible_0 ()
public function boolean u_resize_predefinita ()
private subroutine u_check_troppi_barcode ()
public subroutine u_resize_1 ()
end prototypes

event u_check_troppi_barcode();//---
//--- Verifica se ci sono troppi bacode in programmazione
//---
int k_max_barcode = 3, k_n_barcode_presenti


k_n_barcode_presenti =  dw_lista_0.rowcount( )

if k_n_barcode_presenti > k_max_barcode then
	messagebox("Avvertimento",  string( k_n_barcode_presenti) + " barcode inseriti. Il Programma " + &
	               	"rischia di non essere caricato in Impianto. Si consiglia di Chiudere questo e di proseguire " + &
					"la programmazione in un nuovo programma.", stopsign!)
end if

	
end event

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

			k_errore = kGuf_data_base.db_commit()
			if Left(k_errore, 1) <> "0" then
				messagebox("Problemi durante la Cancellazione !!", &
						"Controllare i dati. " + Mid(k_errore, 2))

			else
				
				dw_dett_0.deleterow(k_riga)

			end if

			dw_dett_0.setfocus()

		else
			k_errore1 = k_errore
			k_errore = kGuf_data_base.db_rollback()

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


	ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento

//=== Pulizia della riga
	dw_lista_0.reset()
	dw_groupage.reset()

//--- Aggiunge una riga al dw delle proprietà
//--- setta i dati di default del pl_barcode
	kiuf1_pl_barcode.set_pl_barcode_nuovo_default(kst_tab_pl_barcode)
	set_dw_dett_0(kst_tab_pl_barcode)

//	dw_dett_0.setcolumn("data")


//=== Posiziona il cursore sul Data Windows
//	dw_dett_0.setfocus() 

	attiva_tasti()

	proteggi_campi()

//--- rilegge le liste utili al nuovo programma da fare
	ki_riga_pos_dw_meca = dw_meca.getrow( )  //cattura la riga selezionata
	if ki_riga_pos_dw_meca > 0 then
		ki_id_meca_pos_dw_meca = dw_meca.getitemnumber( ki_riga_pos_dw_meca, "id_meca")
	end if
	dw_meca.setfocus( )
	leggi_liste()


return (0)


end function

protected subroutine stampa ();//
string k_nome_controllo = " "
st_stampe kst_stampe
w_g_tab kwindow_1


//k_nome_controllo = kGuf_data_base.u_getfocus_nome()

k_nome_controllo = kidw_selezionata.dataobject 

choose case k_nome_controllo
	case "d_pl_barcode_dett_1"
	
		kwindow_1 = kGuf_data_base.prendi_win_attiva()
	
		kst_stampe.dw_print = dw_lista_0
		kst_stampe.titolo = ("Barcode in lavorazione nel P.L. " + string(dw_dett_0.getitemnumber(1, "codice")))
		kGuf_data_base.stampa_dw(kst_stampe)

	case "d_pl_barcode_dett_grp_all"
	
		kwindow_1 = kGuf_data_base.prendi_win_attiva()
	
		kst_stampe.dw_print = dw_groupage
		kst_stampe.titolo = ("Barcode in 'groupage' nel P.L. " + string(dw_dett_0.getitemnumber(1, "codice")))
		kGuf_data_base.stampa_dw(kst_stampe)

	case "d_meca_barcode_elenco_no_lav"
	
		kwindow_1 = kGuf_data_base.prendi_win_attiva()
	
		kst_stampe.dw_print = dw_meca
		kst_stampe.titolo = trim(dw_meca.title)
		kGuf_data_base.stampa_dw(kst_stampe)
		
	case "d_barcode_l_no_pl"
	
		kwindow_1 = kGuf_data_base.prendi_win_attiva()
	
		kst_stampe.dw_print = dw_barcode
		kst_stampe.titolo = trim(dw_barcode.title)
		kGuf_data_base.stampa_dw(kst_stampe)
		
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


ki_lista_0_modifcato = true
	
if dw_barcode.rowcount() > 0 then
		
	k_num_int = dw_barcode.getitemnumber(1, "barcode_num_int")	
		
	k_rc = dw_barcode.reset() 

	ki_riga_pos_dw_meca = 0  //cattura la riga selezionata
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


	if dw_dett_0.u_dati_modificati() &
			or ki_lista_0_modifcato then
//			or dw_groupage.u_dati_modificati() &
//			or dw_lista_0.u_dati_modificati() & 
		
		k_boolean = true
		
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


	kst_esito.nome_oggetto = this.classname()

	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
		dw_dett_0.setitemstatus(1, 0, primary!, NewModified!)
	end if
	
	kst_tab_pl_barcode.codice = dw_dett_0.getitemnumber(1, "codice")			
	kst_tab_pl_barcode.data = dw_dett_0.getitemdate(1, "data")			
	kst_tab_pl_barcode.data_chiuso = date(0) //dw_dett_0.getitemdate(1, "data_chiuso")			
	kst_tab_pl_barcode.data_sosp = dw_dett_0.getitemdate(1, "data_sosp")			
	kst_tab_pl_barcode.note_1 = dw_dett_0.getitemstring(1, "note_1")			
	kst_tab_pl_barcode.note_2 = dw_dett_0.getitemstring(1, "note_2")			
	kst_tab_pl_barcode.stato = dw_dett_0.getitemstring(1, "stato")			
	kst_tab_pl_barcode.priorita = dw_dett_0.getitemstring(1, "priorita")			
	kst_tab_pl_barcode.prima_del_barcode = dw_dett_0.getitemstring(1, "prima_del_barcode")			

	kuf1_pl_barcode = create kuf_pl_barcode
	kst_esito = kuf1_pl_barcode.tb_update( kst_tab_pl_barcode ) 
	
	if kst_tab_pl_barcode.codice > 0 then
		k_rc=dw_dett_0.setitem(1, "codice",kst_tab_pl_barcode.codice)	
	end if

	if kst_esito.esito <> kkg_esito.ok then

		if kst_esito.esito = "1" then
			k_return = trim(kst_esito.esito) + trim(kst_esito.sqlerrtext) + "~r~n(sqlcode=" + string(kst_esito.sqlcode) + ")" + "~r~nP.L. da aggiornare non trovato! "
		else
			k_return = trim(kst_esito.esito) + trim(kst_esito.sqlerrtext) + "~r~n(sqlcode=" + string(kst_esito.sqlcode) + ")" + "~r~ndurante aggiornamento P.L.! "
		end if

		kguo_sqlca_db_magazzino.db_rollback( )

	else

		kguo_sqlca_db_magazzino.db_commit( )

		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			k_return = "1" + string(kguo_sqlca_db_magazzino.sqlcode, "000") + trim(kguo_sqlca_db_magazzino.SQLErrText)
		end if					
		
//		dw_dett_0.resetupdate()
				
	end if
			
	if kst_esito.esito = kkg_esito.ok then
//		if Left(k_return,1) = "0" then
//		if dw_lista_0.getnextmodified ( 0, primary!) > 0 or &
//			dw_lista_0.getnextmodified ( 0, filter!) > 0 then		

			k_pl_barcode = dw_dett_0.getitemnumber(1, "codice")	
			if k_pl_barcode > 0 then
	
//				dw_dett_0.setitem(dw_dett_0.getrow(), "codice", k_pl_barcode)			
	
				kuf1_barcode = create kuf_barcode
	
				kst_tab_barcode.pl_barcode = k_pl_barcode		
				k_return = kuf1_barcode.togli_pl_barcode_all( kst_tab_barcode ) 
	
				if Left(k_return,1) = "0" then

					kst_esito = kst_esito_null
					kst_esito.esito =  kkg_esito.ok
					k_n_righe = dw_lista_0.rowcount()
					k_riga = 1 
					do while k_riga <= k_n_righe and kst_esito.esito = kkg_esito.ok
		
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
					do while k_riga <= k_n_righe and trim(kst_esito.esito) =  kkg_esito.ok
		
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

					k_return = trim(kst_esito.esito) + kst_esito.sqlerrtext + " (" + string(kst_esito.sqlcode) + ") "
					
				end if

	
				if Left(k_return,1) <> "0" then
				
					if Left(k_return,1) = "1" then
						k_return = k_return + "~r~n(Barcode da aggiornare non trovato!) "
					else
						k_return = k_return + "~r~n(durante aggiornamento Barcode!) "
					end if
					kguo_sqlca_db_magazzino.db_rollback( )
	
				else
					kguo_sqlca_db_magazzino.db_commit( )

					if kguo_sqlca_db_magazzino.sqlcode < 0 then
						k_return = "1" + string(kguo_sqlca_db_magazzino.sqlcode, "000") + trim(kguo_sqlca_db_magazzino.SQLErrText)
					else	
						ki_lista_0_modifcato = false
//						dw_lista_0.resetupdate()
//						dw_groupage.resetupdate()
						dati_modif_1()
					end if					
					
				end if
			else
	
				k_return = "1Errore. Aggiornamento Fallito: manca codice P.L."
	
			end if
//		end if		
	end if

	kguo_sqlca_db_magazzino.db_commit( )

	if isvalid(kuf1_pl_barcode) then	destroy kuf1_pl_barcode
	if isvalid(kuf1_barcode) then	destroy kuf1_barcode


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
date  k_dataoggi
int k_nr_errori, k_pl_barcode_progr 
long k_riga, k_nr_righe, k_riga_find, k_riga_find_1, k_riga_ds
st_esito kst_esito
st_tab_barcode kst_tab_barcode_padre, kst_tab_barcode_figlio, kst_tab_barcode
st_tab_meca kst_tab_meca
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

//--- controllo se PL ancora aperto altrimenti NISBA
	try 
		kst_tab_pl_barcode.codice = dw_dett_0.object.codice[1]
		if kst_tab_pl_barcode.codice > 0 then
			if not kiuf1_pl_barcode.if_pl_barcode_aperto(kst_tab_pl_barcode) then
				ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione   // forza visualizzazione
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

	try
//--- Controllo programmazione
		if_programazione_ok()
	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito( )
		k_return = k_return + trim(kst_esito.sqlerrtext) + "~n~r"
		k_errore = "1"
	end try


	if k_errore = "0" or k_errore = "4" then
		kst_tab_pl_barcode.data = dw_dett_0.getitemdate ( k_riga, "data") 
		if isnull(kst_tab_pl_barcode.data) or kst_tab_pl_barcode.data = date(0) then
			k_return = k_return + & 
				"Impostare la data di questo P.L.  " + "~n~r"
			k_errore = "3"
		end if
	
//--- se sono in CHIUSURA controlla la data	
		if ki_operazione_chiusura then 
	
			kst_tab_pl_barcode.data_chiuso = dw_dett_0.getitemdate ( k_riga, "data_chiuso") 
			if k_errore = "0" or k_errore = "4" then
				if kst_tab_pl_barcode.data_chiuso > date(0) then
					if kst_tab_pl_barcode.data > kst_tab_pl_barcode.data_chiuso then
						k_return = k_return + & 
				 "Data di Chiusura " + string(kst_tab_pl_barcode.data_chiuso) + " minore della data del Piano " + string(kst_tab_pl_barcode.data) + ". Prego sistemarla.~n~r" 
						k_errore = "3"
					end if
				end if
			end if
		end if
		
	end if

	if k_errore = "0" or k_errore = "4" then
		k_dataoggi = kg_dataoggi
		if k_dataoggi > KKG.DATA_ZERO then
			if kst_tab_pl_barcode.data <> k_dataoggi then
 				k_return = k_return + "Data del P.L. "  + string (kst_tab_pl_barcode.data) + ", diversa dalla data odierna ( " + string(k_dataoggi) +" )~n~r" 
				k_errore = "4"
			end if

//--- se sono in CHIUSURA controlla la data	
			if ki_operazione_chiusura then 
		
				if kst_tab_pl_barcode.data_chiuso > KKG.DATA_ZERO and kst_tab_pl_barcode.data_chiuso <> k_dataoggi then
					k_return = k_return + "Data Chiusura del P.L. " + string(kst_tab_pl_barcode.data_chiuso) + ", diversa dalla data odierna ( " + string(k_dataoggi) +" )~n~r" 
					k_errore = "4"
				end if
			end if
		end if
	end if

	if k_errore = "0" or k_errore = "4" then
		kst_tab_pl_barcode.data_sosp = dw_dett_0.getitemdate ( k_riga, "data_sosp")
		if kst_tab_pl_barcode.data_sosp > kst_tab_pl_barcode.data_chiuso then
 			k_return = k_return + "Data Sospensione " + string(kst_tab_pl_barcode.data_sosp) + " maggiore della data di Chiusura (" + string(kst_tab_pl_barcode.data_chiuso) + ") " + "~n~r" 
			k_errore = "4"
		end if
	end if

//--- controllo la priorita se congruente con il valore nel campo 'pima del barcode'
	if k_errore = "0" or k_errore = "4" then
		if trim(dw_dett_0.getitemstring ( k_riga, "priorita")) = kiuf1_pl_barcode.k_priorita_prima_del_barcode then
			if Len(trim(dw_dett_0.getitemstring ( k_riga, "prima_del_barcode"))) = 0 then
 				k_return = k_return + "Dati errati, indicare il campo 'Prima del Barcode'   " + "~n~r" 
				k_errore = "2"
			end if
		else
			dw_dett_0.setitem ( k_riga, "prima_del_barcode", " ")
		end if
	end if


//---- Controllo Barcode PADRI
	if k_errore = "0" or k_errore = "4" then

//--- Rileggo i dati di trattamento dei barcode figli
		kst_esito = retrieve_padri()
		if kst_esito.esito <> kkg_esito.ok then
			if kst_esito.esito = kkg_esito.db_wrn then
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
	
	if k_errore = "0" or k_errore = "4" then
//--- 04.02.2009 Controllo che i Barcode non siano già stati caricati con altro Piano di Trattamento
		k_riga = dw_lista_0.rowcount()
		k_nr_errori = 0
	
		do while k_nr_righe > 0 and k_nr_errori < 10

			try 
				k_pl_barcode_progr = dw_lista_0.getitemnumber ( k_riga, "barcode_pl_barcode_progr")
				k_barcode = string(dw_lista_0.getitemstring ( k_riga, "barcode_barcode"))

				kst_tab_barcode.barcode = k_barcode
				kst_tab_barcode.pl_barcode = kuf1_barcode.get_pl_barcode(kst_tab_barcode)

//---- se codice Piano presente è diverso da questo che sto caricando allora GRAVE! 
				if kst_tab_barcode.pl_barcode > 0 and kst_tab_barcode.pl_barcode <> kst_tab_pl_barcode.codice then
					
					k_return = k_return  & 
							  + "Il Barcode "+ trim(k_barcode) +" è già presente nel Piano " + string(kst_tab_barcode.pl_barcode) + ". Lo elimino dalla LISTA~n~r" 
					k_errore = "1"
					k_nr_errori++
					
					dw_lista_0.deleterow(k_riga)  // Elimino la riga gia associata ad altro Piano dalla Lista!!!
					
				end if
				
			catch (uo_exception kuo2_exception)
				kst_esito = kuo2_exception.get_st_esito()
				k_return = k_return  & 
						  + "Problemi durante controllo barcode "  + trim(k_barcode) + " se già pianificato, " + trim(kst_esito.sqlerrtext) + "~n~r"
				k_errore = "1"
			end try
			
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
	if k_errore = "0" or k_errore = "4" then

//--- Aggiungo eventuali Figli nati all'insaputa fuori da questo pianificazione
		aggiungi_figli_dal_dw_lista()

//--- Rileggo i dati di trattamento dei barcode figli
		kst_esito = retrieve_figli()
		if kst_esito.esito <> kkg_esito.ok then
			if kst_esito.esito = kkg_esito.db_wrn then
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

	if k_errore = "0" or k_errore = "4" then
		k_nr_righe = dw_groupage.rowcount()
		k_nr_errori = 0
		k_riga_find = 0 
		k_riga_find_1 = 0 
		k_riga = 1 
		do while k_nr_righe > k_riga and k_nr_errori < 10
	
			k_barcode = string(dw_groupage.getitemstring ( k_riga, "barcode_barcode"))

//--- Controllo codici doppi
			if k_riga_find = 0 then
				k_riga_find = dw_groupage.find("barcode_barcode = '" + trim(k_barcode) + "' ", k_riga + 1, dw_groupage.rowcount()) 
				if k_riga_find > 0  then
					k_return = k_return  & 
								  + "Stesso 'Figlio' presente su piu' righe, "  &
								  + "(Codice " + trim(k_barcode) + ") vedi alla riga " + string(k_riga_find) + "; ~n~r"
					k_errore = "1"
					k_nr_errori++
				end if
			end if

//--- Controllo che i figli siano già nello stato 20 di E1
			try
				if Left(k_errore,1) = "0" or Left(k_errore,1) = "4" then
					kst_tab_meca.id = dw_groupage.getitemnumber(k_riga, "id_meca")
					if kst_tab_meca.id > 0 then
						if not if_lotto_associato(kst_tab_meca) then
							if NOT ki_consenti_lavoraz_non_associati_wmf then
								k_return = k_return  & 
									  + "Barcode figlio " + trim(k_barcode) + " nello stato diverso da 'associato' ('20'), "  &
									  + " vedi alla riga " + string(k_riga) + "; ~n~r"
								k_errore = "1"
							end if
						end if
					end if	
				end if
				
			catch (uo_exception kuo3_exception)
				kst_esito = kuo3_exception.get_st_esito()
				k_return = k_return  & 
					  + "Problemi durante controllo stato 'Figlio' " + trim(k_barcode) + ", " + trim(kst_esito.sqlerrtext)
				k_errore = "1"
			end try
			
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

	if k_errore = "0" or k_errore = "4" then

//--- sistema il codice e i progressivi nella lista PADRI
		imposta_codice_progr( dw_lista_0 )
			
//--- Risistema l'utente di aggiornamento		
//		for k_riga = 1 to dw_lista_0.rowcount() 
//			dw_lista_0.setitem(k_riga, "barcode_x_datins", kGuf_data_base.prendi_x_datins())
//			dw_lista_0.setitem(k_riga, "barcode_x_utente", kGuf_data_base.prendi_x_utente())
//		next

//--- sistema il codice e i progressivi nella lista FIGLI
		imposta_codice_progr( dw_groupage )
			
//--- Risistema l'utente di aggiornamento		
//		for k_riga = 1 to dw_groupage.rowcount() 
//			dw_groupage.setitem(k_riga, "x_datins", kGuf_data_base.prendi_x_datins())
//			dw_groupage.setitem(k_riga, "x_utente", kGuf_data_base.prendi_x_utente())
//		next

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
	
//	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento then
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


//--- Se PL gia' chiuso allora nessuna modifica possibile, forza Visualizzazione		
	try
		ki_PL_chiuso = false
		kst_tab_pl_barcode.codice = long(trim(ki_st_open_w.key1))
		if kst_tab_pl_barcode.codice > 0 then
			if not kiuf1_pl_barcode.if_pl_barcode_aperto(kst_tab_pl_barcode) then
//--- se ero entrato per modificare ma non si può allora avvertimento				
				if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
					SetPointer(oldpointer)
					kguo_exception.inizializza( )
					kguo_exception.messaggio_utente("Modifica Piano bloccata", &
						"Il Piano è già stato chiuso cambio modalità in VISUALIZZAZIONE")
				end if
				ki_PL_chiuso = true
				ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
			end if
		end if
		
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
	end try
	

	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
		aggiungi_figli_dal_dw_lista()
		dw_lista_0.ki_attiva_dragdrop = true
		dw_barcode.ki_attiva_dragdrop = true
		dw_meca.ki_attiva_dragdrop = true
		dw_groupage.ki_attiva_dragdrop = true
	else
		dw_lista_0.ki_attiva_dragdrop = false
		dw_barcode.ki_attiva_dragdrop = false
		dw_meca.ki_attiva_dragdrop = false
		dw_groupage.ki_attiva_dragdrop = false
	end if
	
	if k_errore = 0 then

		if ki_st_open_w.flag_primo_giro = 'S' then

			ki_riga_pos_dw_meca = 0  //cattura la riga selezionata
			retrieve_figli( )   // verifica i figli
			leggi_liste()
			dw_lista_0.resetupdate()
			ki_lista_0_modifcato=false					
		end if

		proteggi_campi()
		
		dw_meca.setfocus()
		
	end if
	
	//dw_dett_0.bringtotop = true
	
	attiva_tasti()
		
	SetPointer(oldpointer)



return k_return



end function

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
							and dw_modifica.object.barcode_tipo_cicli.primary[k_riga] = kuf1_sl_pt.ki_tipo_cicli_a_scelta then
			dw_modifica.object.barcode_tipo_cicli.primary[k_riga] = kuf1_sl_pt.ki_tipo_cicli_singolo
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
//===   kdw_2 (dw_barcode/dw_groupage) -----> kdw_1 (dw_lista_0)
//
long k_riga_dw_lista_0, k_insertrow, k_riga_drag, k_riga_ultima=0, k_riga_find=0
long k_num_int, k_pl_barcode, k_riga_meca
date k_data_int
string k_find
int k_ctr, k_rc
boolean k_elabora=true, k_blocca_operazione=false
st_tab_barcode kst_tab_barcode, kst_tab_barcode_padre
st_tab_meca kst_tab_meca
kuf_barcode kuf1_barcode
kuf_sl_pt kuf1_sl_pt
	

kuf1_barcode = create kuf_barcode

ki_lista_0_modifcato = true

if kdw_2.rowcount() > 0 then
	
	if kdw_1.rowcount() > 0 &
		and kdw_1.getselectedrow(0) > 0 then
		k_insertrow = 1
		k_riga_dw_lista_0 = kdw_1.getselectedrow(0)
	else
		k_riga_dw_lista_0 = 0
		k_insertrow = 0
	end if

	k_riga_drag = kdw_2.getselectedrow(0)

	try 			

		do while k_riga_drag > 0 and k_elabora

			k_blocca_operazione = false

			kst_tab_barcode_padre.barcode = kdw_2.object.barcode_barcode[k_riga_drag]
			
//--- Controllo se Barcode ancora da Associare in WM
			kst_tab_meca.id = 0
			kst_tab_meca.num_int = kdw_2.object.barcode_num_int[k_riga_drag]   
			if kst_tab_meca.num_int > 0 then
				k_riga_meca = dw_meca.find( "meca_num_int = " + string(kst_tab_meca.num_int), 1, dw_meca.rowcount() )
				if k_riga_meca > 0 then
					kst_tab_meca.id = dw_meca.object.id_meca[k_riga_meca]
					kst_tab_meca.data_int = dw_meca.object.meca_data_int[k_riga_meca] 
				
					if dw_meca.getitemnumber(k_riga_meca, "stato_in_attenzione") = 1 then
						kguo_exception.inizializza( )
						kguo_exception.messaggio_utente( "AVVERTIMENTO", "Lotto " + string(dw_meca.getitemnumber(k_riga_meca, "meca_num_int")) + " è 'IN ATTENZIONE'  -   NON sarebbe ancora da TRATTARE.  Rimuoverlo dell'elenco")
					end if
				end if
			end if
				
//--- Controllo se Barcode ancora da Associare al barcode CLIENTE in WMF/E1
			if kst_tab_meca.id > 0 then
				if not if_lotto_associato(kst_tab_meca) then
				
					kst_tab_meca.num_int = kdw_2.object.barcode_num_int[k_riga_drag]
					kguo_exception.inizializza( )
					if ki_consenti_lavoraz_non_associati_wmf then
						kguo_exception.messaggio_utente( "Avvertimento", "Lotto " + string(kst_tab_meca.num_int ) + " non è stato 'Associato' ('20') - Operazione consentita grazie al consenso impostato a menu.")
					else
						k_blocca_operazione = true
						kguo_exception.messaggio_utente( "Operazione Bloccata", "Lotto " + string(kst_tab_meca.num_int ) + " non è stato 'Associato' ('20). Lotto non ancora trattabile!")
					end if
				end if
			end if
			
			if not k_blocca_operazione then 
				
//--- NON è possibile mettere tra i padri un FIGLIO!!!			
				if kuf1_barcode.if_barcode_figlio(kst_tab_barcode_padre) then
	
////--- leggo la successiva!
//					k_riga_ultima = k_riga
//					kdw_2.deleterow(k_riga_drag) 
//					k_riga_drag = kdw_2.getselectedrow(k_riga_drag - 1)
					
				else
					
//--- se ciclo normale a scelta devo effettuare prima la scelta
					kuf1_barcode.get_tipo_cicli(kst_tab_barcode_padre)
					if kst_tab_barcode_padre.tipo_cicli = kuf1_sl_pt.ki_tipo_cicli_a_scelta then
					
						k_elabora=false  // forzo uscita ciclo

//--- prima di pianificare scegliere i GIRI in modo puntale					
						modifica_giri(dw_modifica.ki_modalita_modifica_scelta_fila, k_riga_drag,  ki_dw_fuoco_nome)
					
					else
		
						k_riga_dw_lista_0 = kdw_1.insertrow(k_riga_dw_lista_0 + k_insertrow)
				
//--- copia la dw2 in dw1, il formato e' la solito dettaglio		
						if kdw_2.dataobject = dw_groupage.dataobject then
//							copia_dettaglio_dw1_da_dw_grp (kdw_1, kdw_2,  k_riga, k_riga_drag)	
							copia_dw_groupage_to_dw_lista_0(k_riga_dw_lista_0, k_riga_drag)
						else
							copia_dw_barcode_to_dw_lista_0(k_riga_dw_lista_0, k_riga_drag)
//							copia_dettaglio_dw_1_da_dw_2 (kdw_1, kdw_2, k_riga, k_riga_drag)
						end if
						
////--- leggo la successiva!
//						k_riga_ultima = k_riga
//						kdw_2.deleterow(k_riga_drag) 
//						k_riga_drag = kdw_2.getselectedrow(k_riga_drag - 1)
					
					
						kdw_2.deleterow(k_riga_drag) 
						k_riga_drag --

					end if
					
				end if
			end if

//--- leggo la successiva!
			if k_elabora then
				k_riga_ultima = k_riga_dw_lista_0 //k_riga_drag ultima riga caricata in dw di pianificazione
				k_riga_drag = kdw_2.getselectedrow(k_riga_drag)
			end if
		loop

	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()

	end try 

	if k_riga_ultima > 0 then
//--- sistema il codice e i progressivi nella lista
		imposta_codice_progr( kdw_1 )

		kdw_1.selectrow(0, false)
		kdw_1.setrow(k_riga_ultima)
		kdw_1.selectrow(k_riga_ultima, true)
		kdw_1.scrolltorow(k_riga_ultima)

//--- se i barcode in dw_lista hanno figli li aggiunge al dw_groupage			
		aggiungi_figli_dal_dw_lista()

		screma_lista_barcode()
		screma_lista_riferimenti()

		kdw_1.setcolumn(1)
		kdw_1.setfocus()
		
	end if
		
end if

if isvalid(kuf1_barcode) then destroy kuf1_barcode

attiva_tasti()


end subroutine

public subroutine aggiungi_barcode_tutti (ref datawindow kdw_1);//
//=== Aggiungi i BARCODE dell'intera entrata alla lista dei Pianificati
//===  dw_meca ------> dw_barcode -----> kdw_1 (dw_lista o dw_groupage)
//
long k_riga_kdw_1, k_insertrow, k_riga_drag, k_riga_meca, k_riga_meca_last, k_riga_pos_dw1, k_riga_max
long k_num_int, k_pl_barcode, k_riga_meca_fila_davanti=0, k_riga_meca_fila_davanti_prec=0
date k_data_int
int k_ctr, k_rc
boolean k_elaborazione=true, k_blocca_operazione=false

st_esito kst_esito
st_tab_barcode kst_tab_barcode
st_tab_meca kst_tab_meca
kuf_barcode kuf1_barcode
kuf_sl_pt kuf1_sl_pt


SetPointer(kkg.pointer_attesa)

kuf1_barcode = create kuf_barcode

ki_lista_0_modifcato = true

k_riga_pos_dw1 = 0
	
if dw_meca.rowcount() > 0 then

	k_riga_meca = dw_meca.getselectedrow(0)

	if k_riga_meca > 0 then	
		if kdw_1.rowcount() > 0 &
			and kdw_1.getselectedrow(0) > 0 then
			k_insertrow = 1
			k_riga_kdw_1 = kdw_1.getselectedrow(0)
//			k_riga_pos_dw1 = k_riga_kdw_1
		else
			k_riga_kdw_1 = -1
			k_riga_pos_dw1 = -1
			k_insertrow = 1
		end if
	else
		messagebox("Nessuna Operazione Eseguita", "Selezionare una riga dall'elenco." +"~n~r", StopSign!)
	end if	
	
	//--- Controllo se Riferimento 'IN ATTENZIONE' : probabile grp pertanto espongo un msg
	if k_riga_meca > 0 then 
		if dw_meca.getitemnumber(k_riga_meca, "stato_in_attenzione") = 1 then
			kguo_exception.inizializza( )
			kguo_exception.messaggio_utente( "AVVERTIMENTO", "Lotto " + string(dw_meca.getitemnumber(k_riga_meca, "meca_num_int")) + " è 'IN ATTENZIONE'  -   NON sarebbe ancora da TRATTARE.  Rimuoverlo manualmente dell'elenco")
		end if
	end if

	k_riga_meca_last = 0
	k_elaborazione=true	
	do while k_riga_meca > 0 and k_elaborazione
		
		k_blocca_operazione = false
		
		u_riempi_dettaglio(k_riga_meca)  // popola dw_barcode

		
		if dw_barcode.rowcount() > 0 then
			
			try 
			
//--- Controllo se Barcode ancora da Associare al barcode CLIENTE in WMF/E1
				kst_tab_meca.id = dw_barcode.object.id_meca[1]
				kst_tab_meca.data_int = dw_barcode.object.barcode_data_int[1] 
				if not if_lotto_associato(kst_tab_meca) then
					
					kst_tab_meca.num_int = dw_barcode.object.barcode_num_int[1]
					kguo_exception.inizializza( )
					if ki_consenti_lavoraz_non_associati_wmf then
						kguo_exception.messaggio_utente( "ATTENZIONE", "Lotto " + string(kst_tab_meca.num_int ) + " non nello stato 'Associato' (20) ma operazione consentita grazie al consenso impostato a menu.")
					else
						k_blocca_operazione = true
						kguo_exception.messaggio_utente( "Operazione Bloccata", "Lotto " + string(kst_tab_meca.num_int ) + " non nello stato 'Associato' ('20'). Pianificazione non consentita!")
					end if
					
				end if
			
				if not k_blocca_operazione then

					kst_tab_barcode.barcode = dw_barcode.object.barcode_barcode[1]
			
//--- se ciclo normale a scelta devo effettuare prima la scelta
					kuf1_barcode.get_tipo_cicli(kst_tab_barcode)
					if kst_tab_barcode.tipo_cicli =  kuf1_sl_pt.ki_tipo_cicli_a_scelta then
					
						kidw_selezionata = dw_meca

//--- Completo i GIRI se richiesto da: tipo cicli 				
						modifica_giri(dw_modifica.ki_modalita_modifica_scelta_fila, k_riga_meca,  ki_dw_fuoco_nome)
						
						dw_barcode.reset()
						
						k_elaborazione = false  // forzo uscita ciclo
						k_riga_meca = 0 
						
					else
	
	//--- Controlla SE c'è un Lotto in posizione Fila migliore in Magazzino			
						k_riga_meca_fila_davanti = u_check_rif_file_davanti(k_riga_meca)
						if k_riga_meca_fila_davanti > 0 then
							if k_riga_meca_fila_davanti_prec > 0 then // reset eventuale riga precedente
								dw_meca.selectrow(k_riga_meca_fila_davanti_prec, false)
							end if
							k_riga_meca_fila_davanti_prec = k_riga_meca_fila_davanti
							dw_meca.scrolltorow(k_riga_meca_fila_davanti)
							dw_meca.setrow(k_riga_meca_fila_davanti)
							dw_meca.selectrow(k_riga_meca_fila_davanti, true)
							dw_meca.selectrow(k_riga_meca, false)
							
							if messagebox("Trovato Lotto in Posizione migliore del n. " + string(dw_meca.getitemnumber(k_riga_meca, "meca_num_int")) &
										, "Lotto n. " + string(dw_meca.getitemnumber(k_riga_meca_fila_davanti, "meca_num_int")) &
										+ " in area " + trim(dw_meca.getitemstring(k_riga_meca_fila_davanti, "meca_area_mag")) &
										+ " di " + trim(dw_meca.getitemstring(k_riga_meca_fila_davanti, "k_fatturato")) &
										+ " alla riga n. " + string(k_riga_meca_fila_davanti) + " sembra essere in una fila davanti" &
										+ ". ~n~rVuoi comunque Continuare ?", Question!, yesno!, 1) = 2 then
								
								k_elaborazione = false  // forzo uscita ciclo
								k_blocca_operazione = true  // blocca l'operazione
								k_riga_meca = 0 
							else
								k_elaborazione = false  // forzo uscita ciclo
									
							end if
						end if
		
						if not k_blocca_operazione then
							
							k_riga_max = dw_barcode.rowcount()
							for k_riga_drag = 1 to k_riga_max
							 						//do while  <= dw_barcode.rowcount() 
			
								kst_tab_barcode.barcode = dw_barcode.object.barcode_barcode[k_riga_drag]

//--- NON è possibile mettere tra i padri un FIGLIO!!!			
								if NOT kuf1_barcode.if_barcode_figlio(kst_tab_barcode) then
		
									k_riga_kdw_1 = kdw_1.insertrow(k_riga_kdw_1 + k_insertrow)
	
//--- copia la barcode in kdw_1, il formato e' il solito dettaglio
									if kdw_1.dataobject = dw_groupage.dataobject then
										copia_dw_barcode_to_dw_groupage(k_riga_kdw_1, k_riga_drag)
									else
										copia_dw_barcode_to_dw_lista_0(k_riga_kdw_1, k_riga_drag)
									end if
//									copia_dw_barcode_to_dwxlavorazione( kdw_1, k_riga, k_riga_drag)
//									copia_dettaglio_dw_1_da_dw_2 ( kdw_1, dw_barcode, k_riga, k_riga_drag)
	
	//--- se il barcode ha Padri lo toglie			
	//								kuf1_barcode.tb_togli_da_groupage( kst_tab_barcode)
								end if
	
							//	k_riga_drag++
						
							next //loop
				
							if k_riga_kdw_1 > 0 then
							
								k_riga_pos_dw1 = k_riga_kdw_1
						
							end if
				
//--- Toglie le righe inserite
							dw_barcode.reset( )
//							for k_ctr = dw_barcode.rowcount() to 0 step -1   
//								dw_barcode.deleterow(k_ctr) 
//							next 

//--- Toglie la riga da elenco generale lotti
							dw_meca.deleterow(k_riga_meca) 
							k_riga_meca --
				
						end if
					end if
				end if
				
			catch(uo_exception kuo_exception)
				kuo_exception.messaggio_utente()
				
			end try 
			
		end if
	
		if k_elaborazione then
			k_riga_meca_last = k_riga_meca  // salva l'ultima riga trattata
			k_riga_meca = dw_meca.getselectedrow(k_riga_meca)
		end if
			
	loop

//--- Riposizionamento in elenco se ho elaborato qualcosa
	if k_riga_meca_last > 0 then

//--- copia in quella di appoggio così toglie eventuali rimozioni	
//		dw_meca.rowscopy(1, dw_meca.rowcount(), primary!, kids_meca_orig,1 , primary!)
	
		imposta_codice_progr( kdw_1 )  // imposta i progressivi nel dw barcode in programmazione

		if k_riga_meca_last > dw_meca.rowcount() then
			k_riga_meca_last = dw_meca.rowcount()
		end if
		if k_riga_meca_last > 0 then
			dw_meca.selectrow(0, false)
			dw_meca.selectrow(k_riga_meca_last, true)
			dw_meca.scrolltorow(k_riga_meca_last)
		end if
		

//--- se i barcode in dw_lista hanno figli li aggiunge al dw_groupage			
		aggiungi_figli_dal_dw_lista()

		screma_lista_riferimenti()

		kdw_1.setcolumn(1)
		kdw_1.setfocus()
		if k_riga_pos_dw1 > 0 then
			kdw_1.selectrow(0, false)
			kdw_1.setrow(k_riga_pos_dw1)
			kdw_1.scrolltorow(k_riga_pos_dw1) 
			kdw_1.selectrow(k_riga_pos_dw1, true)
		end if
	end if

end if

		
////--- Toglie dalla lista principale i riferimenti messi in lavorazione
//if k_elaborazione and (dw_lista_0.rowcount() > 0 or dw_groupage.rowcount() > 0) then
//
////--- se i barcode in dw_lista hanno figli li aggiunge al dw_groupage			
//	aggiungi_figli_dal_dw_lista()
//	
////--- se torna con qualche dubbio allora rifare le liste da DB
////	kst_esito = screma_lista_riferimenti()
//
//end if
		
	
attiva_tasti()

if isvalid(kuf1_barcode) then destroy kuf1_barcode

SetPointer(kkg.pointer_default)

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
long k_id_meca
date k_data_int



//=== Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa)

	if dw_dett_0.getrow() > 0 then
		k_pl_barcode = dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice")
	end if
	if isnull(k_pl_barcode)  then
		k_pl_barcode = 0
	end if

//--- cattura la riga corrente x riproporla dopo la retrieve
	k_riga_pos = ki_riga_pos_dw_meca  //cattura la riga selezionata
	ki_riga_pos_dw_meca = 0
//	k_riga_pos = dw_meca.getrow()
	if k_riga_pos > 0 then
		k_id_meca = ki_riga_pos_dw_meca
	end if

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
//		dw_meca.retrieve(k_data_int, 0, 0, 0, "no_pl", k_pl_barcode)
		dw_meca.retrieve(k_data_int, k_pl_barcode)
		
		dw_meca.selectrow(0, false)

//--- copia le righe in dw di appoggio		
		kids_meca_orig.reset()
		k_rc=dw_meca.rowscopy(1, dw_meca.rowcount(), primary!, kids_meca_orig,1 , primary!)

//=== Salva le righe del dw (saveas)
		kGuf_data_base.dw_saveas("no_pl", dw_meca)
		
	end if

//--- screma da elenco i Lotti e altro....
	screma_lista_riferimenti()

	if Len(trim(k_sort)) > 1 and trim(k_sort) <> "?" then
		dw_meca.setsort(k_sort)
		dw_meca.sort()
	end if

//--- cerca il riferimento su cui era posizionato		
	if dw_meca.rowcount() > 0 then
		k_riga = dw_meca.find( "id_meca = " + string(k_id_meca), 1, dw_meca.rowcount())
		if k_riga > 0 then
			k_riga_pos = k_riga
		end if
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

	SetPointer(kkg.pointer_default)

return k_return



end function

private function st_esito screma_lista_riferimenti ();//
//=== Toglie i BARCODE dalla lista se già messi in lavorazione nella dw_lista e dw_groupage
//=== torna numero barcode trovati 
//
long k_riga, k_riga_find=0, k_trovati_barcode, k_presenti_meca, k_num_loop_max
long k_ctr, k_rc, k_fila_1, k_fila_2, k_fila_1p, k_fila_2p, k_fila_mag_n
int k_tipo
boolean k_elabora
string k_find_txt, k_tipo_cicli, k_sort, k_area_mag, k_fila_mag
long k_id_meca, k_riga_pos, k_num_int
date k_data_int
datawindow kdw_1
st_esito kst_esito	


try
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlerrtext = " "

//--- Screma se c'e' qualche riga nei box di lavorazione
	if dw_lista_0.rowcount() > 0 or dw_groupage.rowcount()  > 0 then

//--- cattura la riga corrente x riposizionamento finale
	   k_riga_pos = dw_meca.getrow()

//--- ripristina righe cancellate e contatori originali in lista riferimenti
		dw_meca.setredraw(false)
		if isvalid(kids_meca_orig) then
			if kids_meca_orig.rowcount() > 0 then
				dw_meca.reset()

//--- acchiappa il sort della merce da trattare
				k_sort = dw_meca.Object.DataWindow.Table.Sort
				
				kids_meca_orig.rowscopy(1, kids_meca_orig.rowcount(), primary!, dw_meca,1 , primary!)
				
				if len(trim(k_sort)) > 1 and trim(k_sort) <> "?" then
					dw_meca.setsort(k_sort)
					dw_meca.sort()
				end if
			end if
		end if
	
		
		if dw_meca.rowcount() > 0 then

//--- elaborazione eseguita 2 volte: 1)in trattamento normale; 2)in trattam.Groupage
//? //--- 20.10.2009: attenzione i grp non sono conteggiati dentro "elenco da trattare" (dw_meca) x cui il giro sui figli non lo faccio più!
			k_tipo = 1
			for k_tipo = 1 to 2 
	
				if k_tipo = 1 then
					kdw_1 = dw_lista_0   //elenco padri
				else
					kdw_1 = dw_groupage  //elenco figli
				end if
			
//--- sottrae dai Riferimenti i barcode messi in questa pianficazione
				k_num_loop_max = kdw_1.rowcount() 
				
				for k_riga = 1 to k_num_loop_max
					
					k_elabora = true
					if k_tipo = 2 then // se elaboro GROUPAGE escludo quelli già con il PADRE
						if trim(kdw_1.getitemstring (k_riga, "barcode_lav")) > " " then 
							k_elabora = false
						end if
					end if
					
					if k_elabora then
				
						k_tipo_cicli = kdw_1.getitemstring (k_riga, "barcode_tipo_cicli")
						k_id_meca = kdw_1.getitemnumber (k_riga, "id_meca")
						k_num_int = kdw_1.getitemnumber (k_riga, "barcode_num_int")
						k_data_int = kdw_1.getitemdate (k_riga, "barcode_data_int")
						k_fila_1 = kdw_1.getitemnumber(k_riga, "barcode_fila_1")	
						k_fila_2 = kdw_1.getitemnumber(k_riga, "barcode_fila_2")	
						k_fila_1p = kdw_1.getitemnumber(k_riga, "barcode_fila_1p")	
						k_fila_2p = kdw_1.getitemnumber(k_riga, "barcode_fila_2p")	
						
//--- costruzione della FIND			
						k_find_txt = "id_meca = " + trim(string(k_id_meca)) + " "  
						if k_fila_1 > 0 then
							k_find_txt += " and barcode_fila_1 = " + trim(string(k_fila_1)) + " "  
						else
							k_find_txt += " and barcode_fila_1 = 0 "
						end if
						if k_fila_2 > 0 then
							k_find_txt += " and barcode_fila_2 = " + trim(string(k_fila_2)) + " "  
						else
							k_find_txt += " and barcode_fila_2 = 0 "
						end if
						if k_fila_1p > 0 then
							k_find_txt += " and barcode_fila_1p = " + trim(string(k_fila_1p)) + " "  
						else
							k_find_txt += " and barcode_fila_1p = 0 "
						end if
						if k_fila_2p > 0 then
							k_find_txt += " and barcode_fila_2p = " + trim(string(k_fila_2p)) + " "  
						else
							k_find_txt += " and barcode_fila_2p = 0 "
						end if
			
						if dw_meca.rowcount() = 0 then
				
							kst_esito.esito = kkg_esito.not_fnd
							kst_esito.sqlerrtext = classname(this) + " - screma_lista_rifer: Lista Riferimenti Lotto Vuota! " 
				
						else
			
//--- cerca il riferimento in lista				
							k_riga_find = dw_meca.find(k_find_txt, 1, dw_meca.rowcount()) 
			
//--- NON ho trovato un riferimento in lista, forse era già scremata o in elenco Pianificati 
							if k_riga_find = 0 then
		//						kst_esito.esito = kkg_esito.err_logico
		//						kst_esito.sqlerrtext = "w_pl_barcode:screma_lista_rifer:Stranamente non trovo riferim in lista: " &
		//												  + trim(string(k_num_int))
							else				
//--- 
								k_presenti_meca = dw_meca.getitemnumber( k_riga_find, "contati" )
								k_presenti_meca = k_presenti_meca - 1
								
//--- se azzero il contatore dei barcode tolgo il riferimento dalla lista				
								if k_presenti_meca <= 0 then
									dw_meca.deleterow( k_riga_find ) 
								else	
									dw_meca.setitem( k_riga_find, "contati", k_presenti_meca )
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
									kst_esito.esito = kkg_esito.err_logico
									kst_esito.sqlerrtext = classname(this) + " - screma_lista_rifer, trovato un Lotto più volte in elenco: " &
															  + trim(string(k_num_int)) + trim(string(k_data_int))
													
								end if
							end if
							
						end if
		
//--- se KO esco 
						if kst_esito.esito <> kkg_esito.ok then
							k_riga = k_num_loop_max + 1
						end if
					end if
					
				end for
			
			end for   // ciclo x fare sia elenco PADRI/FIGLI
		
		end if
	
	end if

//--- segnalino sul riferimento che ha un lotto davanti
	u_marca_rif_file_davanti()

////--- Controllo se Lotto e' ASSOCIATO in WMF o in E1
//	if ki_e1_enabled then
//		set_flag_lotto_e1_associato( )
//	else
//		set_flag_lotto_wm_associato( )
//	end if
	
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

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()

finally
	dw_meca.setredraw(true)		

end try

return kst_esito




end function

private subroutine proteggi_campi ();//
//======================================================================
//=== Protegge i campi della Windows
//======================================================================
//
kuf_utility kuf1_utility



//--- Inabilita campi alla modifica se Vsualizzazione
	kuf1_utility = create kuf_utility 
	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.visualizzazione &
	   or trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.cancellazione then
	
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

protected subroutine smista_funz (string k_par_in);//---
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//===
long k_riga = 0


choose case trim(k_par_in) 

//--- Personalizzo da qui
	case kkg_flag_richiesta.libero1		//dettaglio barcode
		call_window_barcode()
	case kkg_flag_richiesta.libero2		//modifica i cicli del riferimento
		if cb_file.enabled then
//--- controlle se consentito solo visualizzazione
			k_riga = kidw_selezionata.getrow() 
			if k_riga > 0 then
				if dw_modifica.ki_modifica_cicli_enabled = dw_modifica.ki_modifica_cicli_enabled_visualizzazione then
					modifica_giri(dw_modifica.ki_modalita_modifica_giri_visualizza, k_riga, kidw_selezionata.dataobject)
				else
					if dw_modifica.ki_modifica_cicli_enabled = dw_modifica.ki_modifica_cicli_enabled_modif then
						modifica_giri(dw_modifica.ki_modalita_modifica_giri_riga, k_riga, kidw_selezionata.dataobject)
					end if
				end if
			end if
		end if
	case kkg_flag_richiesta.libero3		//Imposta Flag 'Stato_in_attenzione'
		if cb_aggiungi.enabled then
			set_stato_in_attenzione( )
		end if
	case kkg_flag_richiesta.libero4		//Aggiungi riga
		if cb_aggiungi.enabled then
			cb_aggiungi.postevent(clicked!)
		end if
	case kkg_flag_richiesta.libero5		//Togli riga
		if cb_togli.enabled then
			cb_togli.postevent(clicked!)
		end if
	case kkg_flag_richiesta.libero6		//Riapre/Chiude Progetto
		if cb_chiudi.enabled then
			u_mostra_proprieta(true)
			//cb_chiudi.postevent(clicked!)
		end if
	case kkg_flag_richiesta.libero71		//Consenti di mettere in lavorazione Lotti NON associati in WMF 
		if not ki_PL_chiuso then
			ki_consenti_lavoraz_non_associati_wmf = not ki_consenti_lavoraz_non_associati_wmf  // setta True/False il flag
		end if
		
	case kkg_flag_richiesta.libero8  	//Crea Groupage prodotti da Palmare
		open_elenco_lettore_grp()

	case kkg_flag_richiesta.refresh		//Aggiorna Liste
		tasto_refresh()

	case kkg_flag_richiesta.libero9		//cambia date di estrazione
		cambia_periodo_elenco()

	case kkg_flag_richiesta.libero10		//finestra delle proprietà
		u_mostra_proprieta(false)


	case else // standard
		kigrf_x_trova = kidw_selezionata
		super::smista_funz(k_par_in)
		
end choose



end subroutine

protected subroutine attiva_menu ();//
if ki_st_open_w.flag_primo_giro <> "S" then
	
	ki_menu.m_trova.enabled = true
	ki_menu.m_trova.m_fin_ordina.enabled = true
	ki_menu.m_trova.m_fin_cerca.enabled = true
	ki_menu.m_trova.m_fin_cercaancora.enabled = true
	ki_menu.m_trova.m_fin_filtra.enabled = true
	ki_menu.m_finestra.m_aggiornalista.enabled = true
	ki_menu.m_finestra.m_riordinalista.enabled = true

//
//--- Attiva/Dis. Voci di menu personalizzate
//
	if not ki_menu.m_strumenti.m_fin_gest_libero1.visible then
		ki_menu.m_strumenti.m_fin_gest_libero1.text = "Dettaglio &Barcode"
		ki_menu.m_strumenti.m_fin_gest_libero1.microhelp = 	"Visualizza dettaglio del Barcode"
		ki_menu.m_strumenti.m_fin_gest_libero1.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemtext = "Barcode,"+ ki_menu.m_strumenti.m_fin_gest_libero1.text
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemvisible = true
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemname = "barcode.bmp"
	//	ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex = 2
		ki_menu.m_strumenti.m_fin_gest_libero1.visible = true
	end if
	
	if ki_menu.m_strumenti.m_fin_gest_libero2.enabled <> cb_file.enabled then
		ki_menu.m_strumenti.m_fin_gest_libero2.text = "&Cicli di Lavorazione"
		ki_menu.m_strumenti.m_fin_gest_libero2.microhelp = "Visualizza/Modifica i cicli di trattamento del Barcode/intero Riferimento di Entrata   "
		ki_menu.m_strumenti.m_fin_gest_libero2.enabled = cb_file.enabled
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemtext = "Giri,"+ ki_menu.m_strumenti.m_fin_gest_libero2.text
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemvisible = true
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemname = "cicli.bmp"
	//	ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex = 2
		ki_menu.m_strumenti.m_fin_gest_libero2.visible = true
	end if

//	if dw_meca.icon <> dw_meca.ki_icona_selezionata then
//		ki_menu.m_strumenti.m_fin_gest_libero3.enabled = false
//	else
		ki_menu.m_strumenti.m_fin_gest_libero3.enabled = ki_autirizza_marca_stato_in_attenzione
//	end if
	if not ki_menu.m_strumenti.m_fin_gest_libero3.visible then
		ki_menu.m_strumenti.m_fin_gest_libero3.text = "Marca/Ripristino Lotto 'in Attenzione '   F12"
		ki_menu.m_strumenti.m_fin_gest_libero3.microhelp =  "Marca/Ripristino Lotto 'in Attenzione'      F12"
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemVisible = false
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemText = "Marca,"+ki_menu.m_strumenti.m_fin_gest_libero3.text
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemName = "Exclamation!"
	//	ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero3.visible = true
	end if	
	
	if ki_menu.m_strumenti.m_fin_gest_libero4.enabled <> cb_aggiungi.enabled then
		ki_menu.m_strumenti.m_fin_gest_libero4.text = "Aggiungi Barcode (&+)"
		ki_menu.m_strumenti.m_fin_gest_libero4.microhelp = "Aggiunge Barcode da trattare a fine elenco   "
		ki_menu.m_strumenti.m_fin_gest_libero4.enabled = cb_aggiungi.enabled
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemtext = "Metti,"+ ki_menu.m_strumenti.m_fin_gest_libero4.text
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemvisible = false
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemName = "custom038!"
//		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritembarindex = 2
		ki_menu.m_strumenti.m_fin_gest_libero4.visible = true
	end if
	
	if ki_menu.m_strumenti.m_fin_gest_libero5.enabled <> cb_togli.enabled then
		ki_menu.m_strumenti.m_fin_gest_libero5.text = "Togli Barcode (&-)"
		ki_menu.m_strumenti.m_fin_gest_libero5.microhelp = "Toglie Barcode da trattare dall'elenco   "
		ki_menu.m_strumenti.m_fin_gest_libero5.enabled = cb_togli.enabled
		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemtext = "Leva,"+ ki_menu.m_strumenti.m_fin_gest_libero5.text
		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemvisible = false
		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemName = "custom080!"
//		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritembarindex = 2
		ki_menu.m_strumenti.m_fin_gest_libero5.visible = true
	end if

	if not ki_PL_chiuso then 
		ki_menu.m_strumenti.m_fin_gest_libero6.text = "Chiudi P.L."
		ki_menu.m_strumenti.m_fin_gest_libero6.microhelp = 	"Salva e Chiude il Piano di Lavorazione, NON SARA' PIU' possibile effettuare alcuna modifica     "
		ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritemtext = "Chiudi,"+ ki_menu.m_strumenti.m_fin_gest_libero6.text
		//ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritemname = kGuo_path.get_risorse() + "\lucch32.png"
		ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritemname = "lucch32.png"
	else
		ki_menu.m_strumenti.m_fin_gest_libero6.text = "Riapre P.L."
		ki_menu.m_strumenti.m_fin_gest_libero6.microhelp = 	"Riapre il Piano di Lavorazione appena inviato, SARA' di nuovo possibile effettuare le modifiche    "
		ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritemtext = "Apre,"+ ki_menu.m_strumenti.m_fin_gest_libero6.text
		ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritemname = "lucchOpen32.png"
	end if
	if ki_menu.m_strumenti.m_fin_gest_libero6.enabled <> cb_chiudi.enabled or not ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritemvisible then
		ki_menu.m_strumenti.m_fin_gest_libero6.enabled = cb_chiudi.enabled
//		ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritemname = kGuo_path.get_risorse() + "\lucchetto1.bmp"
		ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritemvisible = true
		ki_menu.m_strumenti.m_fin_gest_libero6.visible = true
	//	ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritembarindex = 2
	end if

		
//--- By-Passsa blocco Lotto ASSOCIATO (il menu 7 e' a tendina, quindi lo tratto diversamente)
	if ki_menu.m_strumenti.m_fin_gest_libero7.enabled = ki_PL_chiuso or ki_menu.m_strumenti.m_fin_gest_libero7.libero1.checked <> ki_consenti_lavoraz_non_associati_wmf then
		if  ki_consenti_lavoraz_non_associati_wmf then
			ki_menu.m_strumenti.m_fin_gest_libero7.text = "NON Consentire il Trattamento di Lotti non Associati in WMF"
		else
			ki_menu.m_strumenti.m_fin_gest_libero7.text = "Consentire il Trattamento di Lotti NON Associati in WMF"
		end if
		ki_menu.m_strumenti.m_fin_gest_libero7.microhelp = ki_menu.m_strumenti.m_fin_gest_libero7.text
		if ki_e1_enabled then  // Se è attivo E1 si possono mettere in trattamento solo lotti con lo stato a 20 (ASSOCIATI)
			ki_consenti_lavoraz_non_associati_wmf = false
		else
			ki_menu.m_strumenti.m_fin_gest_libero7.enabled = not ki_PL_chiuso
		end if
		ki_menu.m_strumenti.m_fin_gest_libero7.toolbaritemtext =  "WMF,"+ ki_menu.m_strumenti.m_fin_gest_libero7.text
		ki_menu.m_strumenti.m_fin_gest_libero7.toolbaritemvisible = false
//		ki_menu.m_strumenti.m_fin_gest_libero7.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero7.checked = ki_consenti_lavoraz_non_associati_wmf
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.text = ki_menu.m_strumenti.m_fin_gest_libero7.text
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.microhelp = ki_menu.m_strumenti.m_fin_gest_libero7.microhelp 
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.enabled =  ki_menu.m_strumenti.m_fin_gest_libero7.enabled
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.toolbaritemtext = ki_menu.m_strumenti.m_fin_gest_libero7.toolbaritemtext
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.toolbaritemvisible = ki_menu.m_strumenti.m_fin_gest_libero7.toolbaritemvisible
//		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.checked = ki_consenti_lavoraz_non_associati_wmf
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.visible = true
	end if
	
	
	if not ki_menu.m_strumenti.m_fin_gest_libero8.visible then
		ki_menu.m_strumenti.m_fin_gest_libero8.text = "Elenco Groupage da Palmare "
		ki_menu.m_strumenti.m_fin_gest_libero8.microhelp =  "Crea Groupage letti e inviati da Palmare"
		ki_menu.m_strumenti.m_fin_gest_libero8.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritemText = "Grp,"+ki_menu.m_strumenti.m_fin_gest_libero8.text
		ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritemName = "CheckIn5!"
	//	ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero8.visible = true
	end if	

	if not ki_menu.m_strumenti.m_fin_gest_libero9.visible then
		ki_menu.m_strumenti.m_fin_gest_libero9.text = "Cambia data inizio periodo estrazione elenco Lotti da Trattare"
		ki_menu.m_strumenti.m_fin_gest_libero9.microhelp =  "Cambia data estrazione elenco Lotti"
		ki_menu.m_strumenti.m_fin_gest_libero9.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero9.toolbaritemVisible = false
		ki_menu.m_strumenti.m_fin_gest_libero9.toolbaritemText = "Periodo,"+ki_menu.m_strumenti.m_fin_gest_libero9.text
		ki_menu.m_strumenti.m_fin_gest_libero9.toolbaritemName = "Custom015!"
//		ki_menu.m_strumenti.m_fin_gest_libero9.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero9.visible = true
	end if

	if not ki_menu.m_strumenti.m_fin_gest_libero10.visible then
		ki_menu.m_strumenti.m_fin_gest_libero10.text = "Proprità Piano di Lavorazione"
		ki_menu.m_strumenti.m_fin_gest_libero10.microhelp =  "Vedi Proprietà"
		ki_menu.m_strumenti.m_fin_gest_libero10.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero10.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero10.toolbaritemText = "Proprietà,"+ki_menu.m_strumenti.m_fin_gest_libero10.text
		ki_menu.m_strumenti.m_fin_gest_libero10.toolbaritemName = "property.png"
//		ki_menu.m_strumenti.m_fin_gest_libero10.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero10.visible = true
	end if

	super::attiva_menu()
	
end if

end subroutine

private function boolean if_pl_barcode_chiuso ();//--- 
//--- Controlla se PL_BARCODE e' gia' stato chiuso
//---
boolean k_return=false
st_tab_pl_barcode kst_tab_pl_barcode


//--- P.L. chiuso?
if dw_dett_0.getrow() > 0 then
	kst_tab_pl_barcode.codice = dw_dett_0.getitemnumber(1, "codice")			

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

dw_dett_0.reset()
dw_dett_0.insertrow(0)
k_riga = 1 //dw_dett_0.rowcount()

//if k_riga > 0 then
	
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


//end if



end subroutine

private subroutine open_elenco_pilota_coda () throws uo_exception;//
int k_rc
long k_riga, k_riga_max_queue, k_riga_max, k_riga_queue
date k_data_int
string k_rcx
st_tab_barcode kst_tab_barcode[]
//st_tab_meca kst_tab_meca
st_esito kst_esito
kds_barcode_x_pilota_queue kds1_barcode_x_pilota_queue
//kuf_armo kuf1_armo
//kuf_barcode kuf1_barcode

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
	
//	kguo_sqlca_db_pilota.db_connetti()

	kdsi_elenco_output.dataobject = "d_pilota_queue_table_h" 
//	k_rc = kdsi_elenco_output.settransobject ( kguo_sqlca_db_pilota )
	k_rc = kdsi_elenco_output.settrans ( kguo_sqlca_db_pilota )  // conn/disconn in automatico
	k_rc = kdsi_elenco_output.retrieve()

	kst_open_w.key1 = "Elenco Barcode in coda di Lavorazione nel Pilota " 
	
	if kdsi_elenco_output.rowcount() > 0 then
	
//--- piglia la data di consegna	
//		kuf1_armo = create kuf_armo
//		kuf1_barcode = create kuf_barcode
		k_riga_max_queue = kdsi_elenco_output.rowcount() 
		if k_riga_max_queue > 0 then
			for k_riga = 1 to k_riga_max_queue 
				kst_tab_barcode[k_riga].barcode = kdsi_elenco_output.getitemstring( k_riga, "barcode")
	//			kst_esito = kuf1_barcode.get_padre_id_meca(kst_tab_barcode)
	//			if kst_esito.esito = kkg_esito.ok then
	//				kst_tab_meca.id = kst_tab_barcode.id_meca
	//				kst_esito = kuf1_armo.get_consegna_data(kst_tab_meca)
	//				if kst_esito.esito = kkg_esito.ok then
	//					kdsi_elenco_output.setitem(k_riga, "consegna_data", string(kst_tab_meca.consegna_data, "dd/mm/yyyy" ))
	//				end if
	//			end if
			next
			kds1_barcode_x_pilota_queue = create kds_barcode_x_pilota_queue
			k_riga_max = kds1_barcode_x_pilota_queue.u_retrieve(kst_tab_barcode[])
			for k_riga = 1 to k_riga_max 
//				k_rcx = kds1_barcode_x_pilota_queue.describe("#1.name")
//				k_rcx = kds1_barcode_x_pilota_queue.describe("#2.name")
//				k_rcx = kds1_barcode_x_pilota_queue.describe("#3.name")
//				k_rcx = kds1_barcode_x_pilota_queue.describe("#4.name")
//				k_rcx = kds1_barcode_x_pilota_queue.describe("#5.name")
//				k_rcx = kds1_barcode_x_pilota_queue.describe("#6.name")
//				k_rcx = kds1_barcode_x_pilota_queue.describe("#7.name")
//				k_rcx = kds1_barcode_x_pilota_queue.describe("#8.name")
				k_riga_queue = kdsi_elenco_output.find("barcode = '" + kds1_barcode_x_pilota_queue.getitemstring(k_riga, "barcode") + "'" , 1, k_riga_max_queue)
				if kds1_barcode_x_pilota_queue.getitemdate(k_riga, "consegna_data") > kkg.data_zero then
					kdsi_elenco_output.setitem(k_riga_queue, "consegna_data", string(kds1_barcode_x_pilota_queue.getitemdate(k_riga, "consegna_data"), "dd mmm" ))
				end if
				kdsi_elenco_output.setitem(k_riga_queue, "id_meca", kds1_barcode_x_pilota_queue.getitemnumber(k_riga, "id_meca"))
				kdsi_elenco_output.setitem(k_riga_queue, "num_int", kds1_barcode_x_pilota_queue.getitemnumber(k_riga, "num_int"))
				kdsi_elenco_output.setitem(k_riga_queue, "e1ancodrs", kds1_barcode_x_pilota_queue.getitemstring(k_riga, "e1ancodrs"))
			next
		end if
//		destroy kuf1_armo
//		destroy kuf1_barcode
		
		k_window = kGuf_data_base.prendi_win_attiva()
		
	//--- chiamare la window di elenco
	
	//=== Parametri : 
	//=== struttura st_open_w
		kst_open_w.id_programma = kkg_id_programma_elenco
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
		kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
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

public subroutine aggiungi_grp_rif_intero (ref datawindow kdw_1);//
//=== Aggiungi i BARCODE dell'intera entrata alla lista dei Pianificati
//===  dw_meca ------> dw_barcode -----> kdw_1 (groupage)
//
long k_riga, k_insertrow, k_riga_drag, k_riga_meca, k_riga_meca_old, k_riga_posiziona
long k_num_int, k_pl_barcode
date k_data_int
int k_ctr, k_rc
boolean k_elaborazione=true
st_tab_meca kst_tab_meca
st_esito kst_esito
kuf_sl_pt kuf1_sl_pt


//=== Puntatore Cursore da attesa.....
SetPointer(kkg.pointer_attesa)

ki_lista_0_modifcato = true

k_riga_posiziona = 0
	
if dw_meca.rowcount() > 0 then

	k_riga_meca = dw_meca.getselectedrow(0)

	if k_riga_meca > 0 then	
		if kdw_1.rowcount() > 0 &
			and kdw_1.getselectedrow(0) > 0 then
			k_insertrow = 1
			k_riga = kdw_1.getselectedrow(0)
			//k_riga_posiziona = k_riga
		else
			k_riga = -1
			k_riga_posiziona = -1
			k_insertrow = 1
		end if
	else
		messagebox("Nessuna Operazione Eseguita", "Selezionare una riga dall'elenco." + "~n~r", StopSign!)
	end if	

	
	do while k_riga_meca > 0 and k_elaborazione

		try
			kst_tab_meca.id = dw_meca.getitemnumber(k_riga_meca, "id_meca")
			kst_tab_meca.num_int = dw_meca.getitemnumber(k_riga_meca, "meca_num_int") 
			kst_tab_meca.data_int = dw_meca.getitemdate(k_riga_meca, "meca_data_int") 
			if kst_tab_meca.id > 0 then
				if not if_lotto_associato(kst_tab_meca) then
				
					kguo_exception.inizializza( )
					if ki_consenti_lavoraz_non_associati_wmf then
						SetPointer(kkg.pointer_default)
						kguo_exception.messaggio_utente( "ATTENZIONE", "Lotto n. " + string(kst_tab_meca.num_int ) + " non è stato 'Associato' ('20') - Operazione consentita grazie al consenso impostato a menu.")
					else
						SetPointer(kkg.pointer_default)
						kguo_exception.messaggio_utente( "Operazione Bloccata", "Lotto n. " + string(kst_tab_meca.num_int ) + " non è stato 'Associato' ('20') - Pianificazione non consentita")
						exit
					end if
				end if
			end if
		catch (uo_exception kuo_exception)
			kuo_exception.messaggio_utente()
		end try

		
		u_riempi_dettaglio(k_riga_meca)

		if dw_barcode.rowcount() > 0 then
			
			k_riga_drag = 1

//--- se ciclo normale a scelta devo effettuare prima la scelta
			if not isnull(dw_barcode.getitemstring(k_riga_drag, "barcode_tipo_cicli")) &
						   and dw_barcode.getitemstring(k_riga_drag, "barcode_tipo_cicli") =  kuf1_sl_pt.ki_tipo_cicli_a_scelta then
				
				kidw_selezionata = dw_meca
				
				modifica_giri(dw_modifica.ki_modalita_modifica_scelta_fila, k_riga_meca,  ki_dw_fuoco_nome)
				
				dw_barcode.reset()
				
				k_elaborazione = false  // forzo uscita ciclo
				k_riga_meca = 0 
				k_riga_meca_old = 0
				
			else

				do while k_riga_drag <= dw_barcode.rowcount() 
		
					k_riga = kdw_1.insertrow(k_riga + k_insertrow)

//--- copia la barcode in kdw_1, il formato e' il solito dettaglio			
					copia_dw_barcode_to_dw_groupage(k_riga, k_riga_drag)

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

//--- Controllo se Riferimento 'IN ATTENZIONE'
			if dw_meca.getitemnumber(k_riga_meca, "stato_in_attenzione") = 1 then
				SetPointer(kkg.pointer_default)
				kguo_exception.inizializza( )
				kguo_exception.messaggio_utente( "AVVERTIMENTO", "Lotto " + string(dw_meca.getitemnumber(k_riga_meca, "meca_num_int")) + " è 'IN ATTENZIONE'  -   NON sarebbe ancora da TRATTARE.  Rimuoverlo dell'elenco")
			end if

			dw_meca.deleterow(k_riga_meca) 

			k_riga_meca_old = k_riga_meca
			k_riga_meca = dw_meca.getselectedrow(k_riga_meca - 1)
			
		end if
			
	loop
	

//--- sistema il codice e i progressivi nella lista
//	if k_riga_meca_old > 0 and k_elaborazione then
	if k_riga_posiziona > 0 then
		
		imposta_codice_progr( kdw_1 )
	
		if k_riga_meca_old > dw_meca.rowcount() then
			k_riga_meca_old = dw_meca.rowcount()
		end if
		if k_riga_meca_old > 0 then
			dw_meca.selectrow(0, false)
			dw_meca.selectrow(k_riga_meca_old, true)
			dw_meca.scrolltorow(k_riga_meca_old)
		end if
		
		screma_lista_riferimenti()
		
		kdw_1.setcolumn(1)
		kdw_1.setfocus()
		if k_riga_posiziona > 0 then
			kdw_1.selectrow(0, false)
			kdw_1.setrow(k_riga_posiziona)
			kdw_1.scrolltorow(k_riga_posiziona) 
			kdw_1.selectrow(k_riga_posiziona, true)
		end if
		
	end if

end if

////--- Toglie dalla lista principale i riferimenti messi in lavorazione
//if k_elaborazione and dw_lista_0.rowcount() > 0 or dw_groupage.rowcount() > 0 then
////--- se torna con qualche dubbio allora rifare le liste da DB
//	kst_esito = screma_lista_riferimenti()
//end if

attiva_tasti()

SetPointer(kkg.pointer_default)

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


	ki_lista_0_modifcato = true
	
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


ki_lista_0_modifcato = true

	try
		kuf1_barcode = create kuf_barcode
		kuf1_armo = create kuf_armo
		kuf1_clienti = create kuf_clienti
		kuf1_prodotti = create kuf_prodotti

		kds_1 = kuf1_barcode.get_figli_barcode(kst_tab_barcode)  //get figli del barcode per aggiungerli
		if kds_1.rowcount( ) > 0 then
//			kdw_ds = create datawindow
//			kdw_ds.dataobject = dw_groupage.dataobject
//			kdw_ds.rowscopy( 1, kds_1.rowcount( ), primary!, kds_1, 1, primary!)
			k_riga_grp = dw_groupage.rowcount( )
			k_riga_grp_copia=1
			
			do while k_riga_grp_copia <= kds_1.rowcount() 

				kst_tab_barcode.barcode = kds_1.object.barcode[k_riga_grp_copia]

//--- Cerco il barcode tra i filgi e padri gia' presenti (non ci possono essere NONNI)
				k_riga_find = dw_groupage.find("barcode_barcode = '" + trim(kst_tab_barcode.barcode) + "' or barcode_lav = '" + trim(kst_tab_barcode.barcode) + "'", 1, dw_groupage.rowcount()) 

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
					dw_groupage.setitem(k_riga_grp, "id_meca",kst_tab_armo.id_meca)
					dw_groupage.setitem(k_riga_grp, "area_mag",kst_tab_meca.area_mag)
					dw_groupage.setitem(k_riga_grp, "campione",kst_tab_armo.campione)
					dw_groupage.setitem(k_riga_grp, "barcode_num_int",kst_tab_meca.num_int)
					dw_groupage.setitem(k_riga_grp, "barcode_data_int",kst_tab_meca.data_int)
//					dw_groupage.setitem(k_riga_grp, "clie_2",kst_tab_meca.clie_2)
//					dw_groupage.setitem(k_riga_grp, "rag_soc_10",kst_tab_clienti.rag_soc_10)
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
kuf_sl_pt kuf1_sl_pt
datastore kds_1
	

	kuf1_barcode = create kuf_barcode
	kuf1_sl_pt = create kuf_sl_pt

	ki_lista_0_modifcato = true
	
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
						  + "imposto tipo trattamento a: " + kuf1_sl_pt.KI_SL_PT_TIPO_CICLI_DESCR[integer(kst_tab_barcode.tipo_cicli)] +" ~n~r" &
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

////--- posizionamento sul riferimento della riga trattata	
			k_rileggi_lista_da_db = true //---07122015 Forza la rilettura della lista SEMPRE
//07122015			if dw_meca.rowcount() > 0 then	
//
			k_num_int = kdw_1.getitemnumber(k_riga_drag, "barcode_num_int")
			k_data_int = kdw_1.getitemdate(k_riga_drag, "barcode_data_int")
//				
//				k_riga_meca = dw_meca.find("meca_num_int = " + trim(string(k_num_int)) + " " &
//								 + "and year(meca_data_int) = " &
//								 + string(k_data_int, "yyyy") + " " &
//								 , 1, dw_meca.rowcount())
////--- Se riferimento mancante accendo flag x rilettura da DB
//				if k_riga_meca = 0 then
//					k_rileggi_lista_da_db = true //--- x forzare la rilettura della lista
//				end if
//			else
//				k_rileggi_lista_da_db = true //--- x forzare la rilettura della lista
//07122015			end if						 
			
		end if

//--- copia la dw1 in barcode, il formato e' la solito dettaglio		
		copia_dw_lista_0_to_dw_barcode(k_riga, k_riga_drag)
//		copia_dettaglio_dw_1_da_dw_2(dw_barcode, kdw_1, k_riga, k_riga_drag)

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

	ki_riga_pos_dw_meca = 0  //cattura la riga selezionata
//--- rilegge la lista riferimenti non lavorati
	if k_rileggi_lista_da_db then
		u_rileggi_dw_meca()
	else
		leggi_liste()
	end if

//--- posizionamento sul riferimento della riga trattata	
	if dw_meca.rowcount() > 0 then	
		k_riga_meca = dw_meca.find("meca_num_int = " + string(k_num_int) + " " &
						 + "and year(meca_data_int) = " &
						 + string(k_data_int, "yyyy") + " " &
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
kuf_sl_pt kuf1_sl_pt	

	kuf1_barcode = create kuf_barcode
	kuf1_sl_pt = create kuf_sl_pt

	ki_lista_0_modifcato = true
	
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
						  + "imposto tipo trattamento a: " + kuf1_sl_pt.KI_SL_PT_TIPO_CICLI_DESCR[integer(kst_tab_barcode.tipo_cicli)] +" ~n~r" &
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
//		copia_dettaglio_dw1_da_dw_grp (dw_barcode, kdw_1, k_riga, k_riga_drag)
		copia_dw_groupage_to_dw_barcode(k_riga, k_riga_drag)
	
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

	ki_riga_pos_dw_meca = 0  //cattura la riga selezionata
//--- rilegge la lista riferimenti non lavorati
	if k_rileggi_lista_da_db then
		u_rileggi_dw_meca()
	else
		leggi_liste()
	end if

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
if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento &
  					 or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then

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
			kdsi_elenco_output.dataobject = "d_barcode_l_rid"  //dw_lista_0.dataobject
			for k_riga_lista = 1 to dw_lista_0.rowcount()
				
				if kst_tab_barcode.fila_1 = dw_lista_0.object.barcode_fila_1[k_riga_lista] &
						and kst_tab_barcode.fila_1p = dw_lista_0.object.barcode_fila_1p[k_riga_lista] &
						and kst_tab_barcode.fila_2 = dw_lista_0.object.barcode_fila_2[k_riga_lista] &
						and kst_tab_barcode.fila_2p = dw_lista_0.object.barcode_fila_2p[k_riga_lista] &
						then
						if dw_groupage.find("barcode_barcode = " + "'" + dw_lista_0.object.barcode_barcode[k_riga_lista] + "'", 1, dw_lista_0.rowcount()) = 0 then
							k_riga = kdsi_elenco_output.insertrow(0)
							kdsi_elenco_output.setitem( k_riga, "barcode", dw_lista_0.object.barcode_barcode[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "fila_1", dw_lista_0.object.barcode_fila_1[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "fila_1p", dw_lista_0.object.barcode_fila_1p[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "fila_2", dw_lista_0.object.barcode_fila_2[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "fila_2p", dw_lista_0.object.barcode_fila_2p[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "dose", dw_lista_0.object.dose[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "num_int", dw_lista_0.object.barcode_num_int[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "meca_area_mag", dw_lista_0.object.area_mag[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "armo_peso_kg", dw_lista_0.object.peso_kg[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "armo_larg_2", dw_lista_0.object.larg_2[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "armo_lung_2", dw_lista_0.object.lung_2[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "armo_alt_2", dw_lista_0.object.alt_2[k_riga_lista])
//							kdsi_elenco_output.setitem( k_riga, "armo_cod_sl_pt", dw_lista_0.object.cod_sl_pt[k_riga_lista])
//							kdsi_elenco_output.setitem( k_riga, "sl_pt_fila_1", dw_lista_0.object.sl_pt_fila_1[k_riga_lista])
//							kdsi_elenco_output.setitem( k_riga, "sl_pt_fila_1p", dw_lista_0.object.sl_pt_fila_1p[k_riga_lista])
//							kdsi_elenco_output.setitem( k_riga, "sl_pt_fila_2", dw_lista_0.object.sl_pt_fila_2[k_riga_lista])
//							kdsi_elenco_output.setitem( k_riga, "sl_pt_fila_2p", dw_lista_0.object.sl_pt_fila_2p[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "armo_art", dw_lista_0.object.art[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "id_armo", dw_lista_0.object.id_armo[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "id_meca", dw_lista_0.object.id_meca[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "data_int", dw_lista_0.object.barcode_data_int[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "e1ancodrs", dw_lista_0.object.e1ancodrs[k_riga_lista])
						end if
						//k_rc = dw_lista_0.rowscopy( k_riga_lista, k_riga_lista, primary!, kdsi_elenco_output, k_riga, primary!)					
				end if
			next
			
			for k_riga_lista = 1 to dw_barcode.rowcount()
				
				if kst_tab_barcode.fila_1 = dw_barcode.object.barcode_fila_1[k_riga_lista] &
						and kst_tab_barcode.fila_1p = dw_barcode.object.barcode_fila_1p[k_riga_lista] &
						and kst_tab_barcode.fila_2 = dw_barcode.object.barcode_fila_2[k_riga_lista] &
						and kst_tab_barcode.fila_2p = dw_barcode.object.barcode_fila_2p[k_riga_lista] &
						then
						if dw_groupage.find("barcode_barcode = " + "'" + dw_barcode.object.barcode_barcode[k_riga_lista] + "'", 1, dw_barcode.rowcount()) = 0 then
							k_riga = kdsi_elenco_output.insertrow(0)
							kdsi_elenco_output.setitem( k_riga, "barcode", dw_barcode.object.barcode_barcode[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "fila_1", dw_barcode.object.barcode_fila_1[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "fila_1p", dw_barcode.object.barcode_fila_1p[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "fila_2", dw_barcode.object.barcode_fila_2[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "fila_2p", dw_barcode.object.barcode_fila_2p[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "dose", dw_barcode.object.armo_dose[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "num_int", dw_barcode.object.barcode_num_int[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "meca_area_mag", dw_barcode.object.meca_area_mag[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "armo_peso_kg", dw_barcode.object.armo_peso_kg[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "armo_larg_2", dw_barcode.object.armo_larg_2[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "armo_lung_2", dw_barcode.object.armo_lung_2[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "armo_alt_2", dw_barcode.object.armo_alt_2[k_riga_lista])
//							kdsi_elenco_output.setitem( k_riga, "armo_cod_sl_pt", dw_barcode.object.armo_cod_sl_pt[k_riga_lista])
//							kdsi_elenco_output.setitem( k_riga, "sl_pt_fila_1", dw_barcode.object.sl_pt_fila_1[k_riga_lista])
//							kdsi_elenco_output.setitem( k_riga, "sl_pt_fila_1p", dw_barcode.object.sl_pt_fila_1p[k_riga_lista])
//							kdsi_elenco_output.setitem( k_riga, "sl_pt_fila_2", dw_barcode.object.sl_pt_fila_2[k_riga_lista])
//							kdsi_elenco_output.setitem( k_riga, "sl_pt_fila_2p", dw_barcode.object.sl_pt_fila_2p[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "armo_art", dw_barcode.object.armo_art[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "id_armo", dw_barcode.object.armo_id_armo[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "id_meca", dw_barcode.object.id_meca[k_riga_lista])
							kdsi_elenco_output.setitem( k_riga, "data_int", dw_barcode.object.barcode_data_int[k_riga_lista])
							//k_rc = dw_barcode.rowscopy( k_riga_lista, k_riga_lista, primary!, kdsi_elenco_output, k_riga, primary!)					
							kdsi_elenco_output.setitem( k_riga, "e1ancodrs", dw_barcode.object.e1ancodrs[k_riga_lista])
					end if
				end if
			next
			kdsi_elenco_output.sort( )
			
			kst_open_w.key1 = "Scegli 'Padre' per il Barcode: " + trim(string(kst_tab_barcode.barcode,"@@@ @@@@@@@@@")) 
				
				
			if kdsi_elenco_output.rowcount() > 0 then
		
//				k_window = kGuf_data_base.prendi_win_attiva()
				
		//--- chiamare la window di elenco
		//
		//=== Parametri : 
		//=== struttura st_open_w
				kst_open_w.id_programma =kkg_id_programma_elenco
				kst_open_w.flag_primo_giro = "S"
				kst_open_w.flag_modalita = kkg_flag_modalita.elenco
				kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
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
							"Nessun barcode padre disponibile dagli elenchi di 'Dettaglio' e 'Pianificazione' per il trattamento  F1=" &
							      + string(kst_tab_barcode.fila_1) + "/" + string(kst_tab_barcode.fila_1p) &
								 + " e F2=" + string(kst_tab_barcode.fila_2) + "/" + string(kst_tab_barcode.fila_2p))
				
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
	
			k_window = kGuf_data_base.prendi_win_attiva()
			
	//--- chiamare la window di elenco
	//
	//=== Parametri : 
	//=== struttura st_open_w
			kst_open_w.id_programma =kkg_id_programma.elenco
			kst_open_w.flag_primo_giro = "S"
			kst_open_w.flag_modalita = kkg_flag_modalita.elenco
			kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
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

ki_lista_0_modifcato = true

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
	
	if kst_esito.esito <> kkg_esito.ok and  kst_esito.esito <> kkg_esito.db_wrn then
		kuo_exception = create uo_exception
		kuo_exception.set_esito(kst_esito)
		kuo_exception.messaggio_utente()
		destroy kuo_exception
	else
		
//--- tolgo dall'eventuale vecchio padre il flag di GROUPAGE
		if Len(trim(kst_tab_barcode_save.barcode)) > 0 then
	
			kst_esito = kuf1_barcode.tb_togli_figlio_al_padre(kst_tab_barcode_save)	
			
			if kst_esito.esito <> kkg_esito.ok and  kst_esito.esito <> kkg_esito.db_wrn then
				kuo_exception = create uo_exception
				kuo_exception.set_esito(kst_esito)
				kuo_exception.messaggio_utente()
				destroy kuo_exception
			end if
		end if
		
//--- aggiorno sul padre il flag di GROUPAGE
		kst_tab_barcode.barcode = kst_tab_barcode.barcode_lav
		kst_esito = kuf1_barcode.tb_set_padre(kst_tab_barcode)	
		
		if kst_esito.esito <> kkg_esito.ok and  kst_esito.esito <> kkg_esito.db_wrn then
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
			if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento &
				or trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
				kst_open_w.flag_modalita= kkg_flag_modalita.modifica
			else
				kst_open_w.flag_modalita= kkg_flag_modalita.visualizzazione
			end if
				
			kst_open_w.id_programma = kkg_id_programma_barcode
			kst_open_w.flag_primo_giro = "S"
			kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
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

ki_lista_0_modifcato = true

for k_riga = 1 to dw_lista_0.rowcount()
	kst_tab_barcode.barcode = dw_lista_0.object.barcode_barcode[k_riga]
	aggiungi_figli_al_dw_groupage ( kst_tab_barcode )
next

//screma_lista_riferimenti()

end subroutine

private function st_esito retrieve_figlio_nel_dw_groupage (st_tab_barcode kst_tab_barcode);//
//--- Aggiorna i dati del Figlio nel dw_groupage  
//--- 
//--- Input kst_tab_barcode.barcode il FIGLIO da rileggere 
//
long k_riga_find, k_riga_find_padre
kuf_barcode kuf1_barcode
st_esito kst_esito 


	
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()



	try
		kuf1_barcode = create kuf_barcode


//--- Cerco il barcode tra i figli gia' presenti
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

//--- Cerco il barcode PADRE 
			k_riga_find_padre = dw_lista_0.find("barcode_barcode = '" + trim(kst_tab_barcode.barcode_lav) + "' ", 1, dw_lista_0.rowcount()) 
			if k_riga_find_padre > 0  then
				if dw_lista_0.getitemnumber(k_riga_find_padre, "barcode_fila_1") = kst_tab_barcode.fila_1 &
						and dw_lista_0.getitemnumber(k_riga_find_padre, "barcode_fila_2") = kst_tab_barcode.fila_2 &
						and dw_lista_0.getitemnumber(k_riga_find_padre, "barcode_fila_1p") = kst_tab_barcode.fila_1p &
						and dw_lista_0.getitemnumber(k_riga_find_padre, "barcode_fila_2p") = kst_tab_barcode.fila_2p then
					dw_groupage.setitem(k_riga_find, "k_errore", '0')
				else
					dw_groupage.setitem(k_riga_find, "k_errore", '1')
				end if
			end if
			
		else
			kst_esito.esito = kkg_esito.err_logico
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


	
	
	kst_esito.esito = kkg_esito.ok
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
			kst_esito.esito = kkg_esito.err_logico
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


	
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	for k_riga = 1 to dw_lista_0.rowcount()
	
		kst_tab_barcode.barcode = dw_lista_0.object.barcode_barcode[k_riga]
		kst1_esito = retrieve_padre_nel_dw_lista(kst_tab_barcode)
		if kst1_esito.esito <> kkg_esito.ok and kst1_esito.esito <> kkg_esito.db_wrn then
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


	
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	for k_riga = 1 to dw_groupage.rowcount()
	
		kst_tab_barcode.barcode = dw_groupage.object.barcode_barcode[k_riga]
		kst1_esito = retrieve_figlio_nel_dw_groupage(kst_tab_barcode)
		if kst1_esito.esito <> kkg_esito.ok and kst1_esito.esito <> kkg_esito.db_wrn then
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


	case "d_pl_barcode_dett_1"
		kst_esito = retrieve_padri()
		if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.db_wrn  then
			kuo_exception.set_esito( kst_esito)
			kuo_exception.messaggio_utente()
		end if

	case "d_pl_barcode_dett_grp_all"
		kst_esito = retrieve_figli()
		if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.db_wrn  then
			kuo_exception.set_esito( kst_esito)
			kuo_exception.messaggio_utente()
		end if

	case else
	//case "d_meca_barcode_elenco_no_lav" &
	//		,"d_barcode_l_no_pl"
		rilegge_no_lav()


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
		if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn  then
			kst_esito = retrieve_figli()
		end if
		if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.db_wrn  then
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


try
	
	kuf1_base = create kuf_base
	kiuf1_pl_barcode = create kuf_pl_barcode								
	kiuf_armo = create kuf_armo								
	kiuf_e1_asn = create kuf_e1_asn
	
	ki_toolbar_window_presente=true
	
	//--- cambia colore alla dw del groupage x distinguerla da quella normale
	dw_groupage_colore(dw_groupage)
	
	ki_e1_enabled = kguo_g.if_e1_enabled( )			// interfaccia E1 attiva?
	
	//--- abilita i campi x modificare im giri delle lavorazioni
	//	abilita_modifica_giri()
	
	//--- abilita la funzione di Chiusura del PL
	u_abilita_chiusura_pl()	
	
	//--- crea dw di appoggio per lettura orginale dei rif da lavorare
	kids_meca_orig = create datastore
	kids_meca_orig.dataobject = dw_meca.dataobject 
	
	//--- abilita i campi x modificare i giri delle lavorazioni
	u_abilita_modifica_giri()
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
	dw_dett_0.Modify("b_queue_pilota.filename='" + "pilota_16.bmp" + "'")
	dw_dett_0.Modify("b_file_pilota.filename='" + "apri_file1.bmp" + "'")
	
	ki_data_ini = date(Mid(kuf1_base.prendi_dato_base("barcode_dt_no_lav"),2))
	if isnull(ki_data_ini) then
		ki_data_ini = date(0)
	end if 
	//--- la data deve essere compresa inizialmente tra 30 e 160 gg prima
	if ki_data_ini > relativedate(kguo_g.get_dataoggi( ), -30) then
		ki_data_ini = relativedate(kguo_g.get_dataoggi( ), -30)
	else	
		if ki_data_ini < relativedate(kguo_g.get_dataoggi( ), -160) then
			ki_data_ini = relativedate(kguo_g.get_dataoggi( ), -160)
		end if
	end if
	
	ki_data_fin = kguo_g.get_dataoggi()
	
	//--- controlla se utente autorizzato a cambiare lo stato in attenzione del lotto
	u_autorizza_stato_in_attenzione()
	
	//--- controlla se utente autorizzato a cambiare la data di consegna
	if u_autorizza_mod_consegna_data( ) then
		dw_meca.Modify("meca_consegna_data.protect='0'")
	end if
	
	if isvalid(kuf1_base) then destroy kuf1_base
	
	//--- attivo il timer ogni mezzo secondo	
	timer( 0.5 )
	
catch (uo_exception ki_e1_enabled)
	ki_e1_enabled.messaggio_utente()
	cb_chiudi.post event clicked( )
	
end try
end subroutine

private subroutine rilegge_no_lav ();		
	ki_riga_pos_dw_meca = dw_meca.getrow( )  //cattura la riga selezionata
	if ki_riga_pos_dw_meca > 0 then
		ki_id_meca_pos_dw_meca = dw_meca.getitemnumber( ki_riga_pos_dw_meca, "id_meca")
	end if
	u_rileggi_dw_meca()

end subroutine

public subroutine set_base_data_ini ();//
//--- Imposta sul BASE la data di inizio Elenco così da ricordarla al prx rientro
//
date k_data_inizio
int k_ctr=0, k_ind
kuf_base kuf1_base
st_tab_base kst_tab_base


	k_data_inizio = ki_data_ini

	k_ctr = dw_meca.rowcount()
	if k_ctr > 0 then
		ki_data_ini = dw_meca.getitemdate(1, "meca_data_int")
	end if
	for k_ind = 2 to k_ctr
		
		if ki_data_ini > dw_meca.getitemdate(k_ind, "meca_data_int") then
			ki_data_ini = dw_meca.getitemdate(k_ind, "meca_data_int")
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
	kst_open_w.flag_modalita = kkg_flag_modalita.elenco
	kst_open_w.id_programma = kuf1_lettore_grp.get_id_programma(kst_open_w.flag_modalita)
	kst_open_w.flag_primo_giro = "S"
	kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
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
		
		do
			
			kst_tab_meca.id = dw_meca.getitemnumber(k_riga, "id_meca")
			
			kuf1_armo = create kuf_armo
			kuf1_armo.set_stato_in_attenzione_cambia(kst_tab_meca)
			destroy kuf1_armo
			
			dw_meca.setitem(k_riga, "stato_in_attenzione", kst_tab_meca.stato_in_attenzione)

			k_riga = dw_meca.getselectedrow(k_riga) 
			
		loop while k_riga > 0

	else
		kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_dati_insufficienti )
		kguo_exception.setmessage("Prego, selezionare una riga dall'elenco.")
		kguo_exception.messaggio_utente( )
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
		ki_dragdrop = false
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
//int k_nr_errori, , k_rc 
long k_riga, k_nr_righe, k_riga_ds, k_pl_barcode_progr
st_esito kst_esito
st_tab_barcode kst_tab_barcode_padre, kst_tab_barcode_figlio, kst_tab_barcode
kuf_barcode kuf1_barcode
ds_pl_barcode_dett kds_pl_barcode_dett, kds_pl_barcode_dett_figli
st_tab_pl_barcode kst_tab_pl_barcode


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kds_pl_barcode_dett = create ds_pl_barcode_dett
	kds_pl_barcode_dett_figli = create ds_pl_barcode_dett
	kuf1_barcode = create kuf_barcode

	dw_lista_0.accepttext()
	dw_groupage.accepttext()

	k_nr_righe = dw_lista_0.rowcount()

	for k_riga = 1 to k_nr_righe 

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
	
	next

//--- Controllo programmazione
	kiuf1_pl_barcode.if_pianificazione_ok(kds_pl_barcode_dett, "inserimento")

//---- Controllo Barcode FIGLI ------------------------------------------------------------------------------------
	if not k_errore then

//--- Aggiungo eventuali Figli nati all'insaputa fuori da questo pianificazione
		aggiungi_figli_dal_dw_lista()

//--- Rileggo i dati di trattamento dei barcode figli
		kst_esito = retrieve_figli()
		if kst_esito.esito <> kkg_esito.ok then
			k_errore_msg = k_errore_msg  & 
								  + trim(kst_esito.sqlerrtext ) + ";~n~r" 
			k_errore = true
		end if
		
	end if

	if not k_errore  then

		k_nr_righe = dw_groupage.rowcount()
		for k_riga = 1 to k_nr_righe

//--- Popolo il Datastore Figli x il controllo della Programmazione
			k_riga_ds = kds_pl_barcode_dett_figli.insertrow(0)
			kds_pl_barcode_dett_figli.object.pl_barcode_progr[k_riga_ds] = dw_groupage.getitemnumber ( k_riga, "barcode_pl_barcode_progr")
			kds_pl_barcode_dett_figli.object.barcode[k_riga_ds] = dw_groupage.getitemstring ( k_riga, "barcode_barcode")
			kds_pl_barcode_dett_figli.object.barcode_lav[k_riga_ds] = dw_groupage.getitemstring ( k_riga, "barcode_lav")
			kds_pl_barcode_dett_figli.object.fila_1[k_riga_ds] = dw_groupage.getitemnumber ( k_riga, "barcode_fila_1")
			kds_pl_barcode_dett_figli.object.fila_2[k_riga_ds] = dw_groupage.getitemnumber ( k_riga, "barcode_fila_2")
			kds_pl_barcode_dett_figli.object.fila_1p[k_riga_ds] = dw_groupage.getitemnumber ( k_riga, "barcode_fila_1p")
			kds_pl_barcode_dett_figli.object.fila_2p[k_riga_ds] = dw_groupage.getitemnumber ( k_riga, "barcode_fila_2p")
			kds_pl_barcode_dett_figli.object.tipo_cicli[k_riga_ds] = dw_groupage.getitemstring ( k_riga, "barcode_tipo_cicli")
			
		next
	
//--- controlla pianificazione figli
		kiuf1_pl_barcode.if_pianificazione_figli_ok(kds_pl_barcode_dett, kds_pl_barcode_dett_figli, "inserimento")

	end if


		
	if not k_errore then

//--- sistema il codice e i progressivi nella lista PADRI
		imposta_codice_progr( dw_lista_0 )
			
//--- sistema il codice e i progressivi nella lista FIGLI
		imposta_codice_progr( dw_groupage )
			
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
		
		if kst_esito.esito <> kkg_esito.ok then
			k_errore = 1
			kst_esito_err.esito = kst_esito.esito
			kst_esito_err.sqlcode = kst_esito.sqlcode
			kst_esito_err.sqlerrtext = "Errore durante Chiusura del P.L.. ~n~rErrore " + trim(kst_esito.sqlerrtext)
			kGuf_data_base.errori_scrivi_esito("W", kst_esito_err) 
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito_err)
			throw kguo_exception
		end if			  
	
	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito()
		kst_esito_err.esito = kst_esito.esito
		kst_esito_err.sqlcode = kst_esito.sqlcode
		kst_esito_err.sqlerrtext = "Errore durante Chiusura Piano di Lavorazione Barcode (chiudi_pl_elabora): ~n~r" + trim(kst_esito.sqlerrtext)
		kGuf_data_base.errori_scrivi_esito("W", kst_esito_err) 
		
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
st_sv_eventi_sked kst_sv_eventi_sked
st_esito kst_esito, kst_esito_err
kuf_sv_skedula kuf1_sv_skedula


	
try 

	
	//--- se pl barcode gia' chiuso non fa un bel niente
	if if_pl_barcode_chiuso() then
	
		messagebox("Elaborazione non eseguita", &
					  "Il Piano di Lavorazione e' gia' Chiuso.~n~r" &
					  + "Codice: " &
					  + trim(string(dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice"))) + "~n~r", &
					  Information! )
	
	else
			
		k_nrc = messagebox("Chiudi P.L. - Elaborazione Definitiva ", &
					  "ATTENZIONE~n~rquesta elaborazione Aggiorna e Chiude il P.L..~n~r" &
					  + "Dopo l'aggiornamento non sara' piu' possibile eseguire alcuna~n~r" &
					  + "modifica al Piano di Lavorazione~n~r~n~r" &
					  + "Proseguire?", &
					  question!, YesNo!, 2) 
	
		if k_nrc = 2 then
			ki_operazione_chiusura = false
			k_errore = 2
		else
			ki_operazione_chiusura = true
		end if
				

		if ki_operazione_chiusura then 
			
//--- Salva il PL
			k_rc = aggiorna_dati()		
			
			if Left(k_rc, 1) <> "0" then //Aggiornamento fallito
//				k_errore = 1 
//				ki_operazione_chiusura = false 
				kst_esito_err.esito = Left(k_rc, 1)
				kst_esito_err.sqlcode = 0
				kst_esito_err.sqlerrtext = trim(Mid(k_rc, 2))
				kst_esito_err.nome_oggetto = this.classname()
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito_err)
				throw kguo_exception
				//kGuf_data_base.errori_scrivi_esito("W", kst_esito_err) 
				
			end if
//		end if		
		
//		if ki_operazione_chiusura and k_errore = 0 then 
		
			SetPointer(kkg.pointer_attesa)   // Puntatore Cursore da attesa.....

//--- Chiudi PL effettivamente !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!			
			chiudi_pl_elabora( )
//-------------------------------------------------------			

//--- Verifica se l'invio del pl è fatto in automatico
			kuf1_sv_skedula = create kuf_sv_skedula
			kst_sv_eventi_sked.id_menu_window = kkg_id_programma_pilota_esporta_pl
			kst_esito = kuf1_sv_skedula.get_time_evento( kst_sv_eventi_sked )
			if isvalid(kuf1_sv_skedula) then destroy kuf1_sv_skedula
			
			if kst_esito.esito = kkg_esito.ok then
				messagebox("Chiusura Piano di Lavorazione" ,"Operazione terminata correttamente.~n~r" + "Chiuso Piano di Lavorazione n.: " &
						  + (string(dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice")))  &
						  + "~n~r~n~r" + "Il piano sara' inviato in automatico alle " &
						  + string(kst_sv_eventi_sked.run_ora ) + " del " + string(kst_sv_eventi_sked.run_giorno )  &
						  ,Information! )
		
			else
				if kst_esito.esito = kkg_esito.not_fnd then
					
					messagebox("Chiusura Piano di Lavorazione", "Operazione terminata correttamente.~n~r"  + "Chiuso Piano di Lavorazione n.: " &
						  + (string(dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice")))  &
						  + "~n~r~n~r" + "Effettuare l'invio del Piano in modo Manuale dal Menu 'Magazzino'!  ~n~r" &
						  ,Information! )
				else
					messagebox("Chiusura Piano di Lavorazione", "Operazione terminata correttamente.~n~r" + "Chiuso Piano di Lavorazione n: " &
						  + (string(dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice"))) + "~n~r", &
						  Information! )
				end if
			end if
		
		end if

	end if
		
catch (uo_exception kuo_exception)
	k_errore = 1
	kst_esito = kguo_exception.get_st_esito( )
	kguo_exception.inizializza( )
	kguo_exception.messaggio_utente("Chiusura Piano di Lavorazione", "Operazione non eseguita!!" + "~n~r" + trim(kst_esito.sqlerrtext) + "~n~rPiano non chiuso, esecuzione Interrotta." )

finally
	ki_operazione_chiusura = false
	SetPointer(kkg.pointer_default)  // ripristino Puntatore

end try
		

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
				  "Il Piano di Lavorazione è già in TRATTAMENTO quindi non può essere Riaperto.~n~r" &
				  + "Codice: " &
				  + trim(string(dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice"))) + "~n~r", &
				  Information! )

	else

//--- se anche solo un barcode è già stato trasferito al PILOTA allora NON si può APRIRE
		kst_tab_pl_barcode.codice = dw_dett_0.getitemnumber(dw_dett_0.getrow(), "codice")
		if kiuf1_pl_barcode.if_pl_trasferito_al_pilota(kst_tab_pl_barcode) then
			
			ki_chiudi_PL_enabled = false
			messagebox("Elaborazione non eseguita", &
				  "Il Piano di Lavorazione è già stato Trasferito al Pilota e non può essere Riaperto.~n~r" &
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
			
		kguo_sqlca_db_magazzino.db_commit( ) 
	
	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito()
		kst_esito_err.esito = kst_esito.esito
		kst_esito_err.sqlcode = kst_esito.sqlcode
		kst_esito_err.sqlerrtext = "Errore durante Riapertura del Piano di Lavorazione (apri_pl_elabora): ~n~r" + trim(kst_esito.sqlerrtext)
		kGuf_data_base.errori_scrivi_esito("W", kst_esito_err) 
		
		kguo_sqlca_db_magazzino.db_rollback( ) 
		
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito_err)
		throw kguo_exception
		
	finally
		SetPointer(oldpointer)  // ripristino Puntatore

	end try
		





end subroutine

protected subroutine riempi_id ();

end subroutine

private subroutine modifica_giri (string a_modalita_modifica_file, long a_riga, string a_dw_fuoco_nome);//
//--- a_modalita_modifica_file: 1=modalità modifica giri fila 1 e 2 
//--- a_riga = riga sulla quale modificare
//--- a_dw_fuoco_nome = dw su cui fare la modifica giri
//
integer k_rec , k_riga
//string k_dw_fuoco_nome
string k_aggiorna_rif
line kline_1
st_esito kst_esito
st_tab_barcode kst_tab_barcode
kuf_barcode kuf1_barcode
datawindow kidw_barcode_da_non_modificare



if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica  or ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then

//--- valorizza la dw sulla quale fare la modifica
	kidw_x_modifica_giri = kidw_selezionata
	kidw_barcode_da_non_modificare = dw_lista_0
	dw_modifica.ki_modif_tutto_riferimento = dw_modifica.ki_modif_tutto_riferimento_no
	
	//k_dw_fuoco_nome = kidw_selezionata.dataobject 

	choose case a_dw_fuoco_nome

		case "d_meca_barcode_elenco_no_lav"
			dw_modifica.ki_modif_tutto_riferimento = dw_modifica.ki_modif_tutto_riferimento_si
			//k_riga = dw_meca.getrow() 
			if a_riga > 0 then
				kst_tab_barcode.barcode = " "
				kst_tab_barcode.pl_barcode = dw_dett_0.getitemnumber(1, "codice")
				if isnull(kst_tab_barcode.pl_barcode) then kst_tab_barcode.pl_barcode = 0
				kst_tab_barcode.num_int = dw_meca.getitemnumber(a_riga, "meca_num_int")
				kst_tab_barcode.data_int = dw_meca.getitemdate(a_riga, "meca_data_int")
				kst_tab_barcode.fila_1 = dw_meca.getitemnumber(a_riga, "barcode_fila_1")
				kst_tab_barcode.fila_1p = dw_meca.getitemnumber(a_riga, "barcode_fila_1p")
				kst_tab_barcode.fila_2 = dw_meca.getitemnumber(a_riga, "barcode_fila_2")
				kst_tab_barcode.fila_2p = dw_meca.getitemnumber(a_riga, "barcode_fila_2p")
				
				kuf1_barcode = create kuf_barcode
				kuf1_barcode.kist_tab_barcode = kst_tab_barcode
				kuf1_barcode.kist_tab_barcode.barcode = "*"
				kst_esito = kuf1_barcode.kicursor_barcode_1_open()
				if kst_esito.esito = kkg_esito.ok then
					kst_esito = kuf1_barcode.kicursor_barcode_1_fetch()
					if kst_esito.esito = kkg_esito.ok then
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
			if a_modalita_modifica_file = dw_modifica.ki_modalita_modifica_giri_riga then
			     k_riga = dw_barcode.getselectedrow(0)
				if a_riga > 0 then
				   k_riga = dw_barcode.getselectedrow(k_riga)
					if k_riga > 0 then
						a_modalita_modifica_file = dw_modifica.ki_modalita_modifica_giri_righe
					end if
				end if
			end if
			//k_riga = dw_barcode.getrow() 
			if a_riga > 0 then		
				kst_tab_barcode.pl_barcode = dw_dett_0.getitemnumber(1, "codice")
				kst_tab_barcode.barcode = dw_barcode.getitemstring(a_riga, "barcode_barcode")
				kst_tab_barcode.num_int = dw_barcode.getitemnumber(a_riga, "barcode_num_int")
				kst_tab_barcode.data_int = dw_barcode.getitemdate(a_riga, "barcode_data_int")
				kst_tab_barcode.fila_1 = dw_barcode.getitemnumber(a_riga, "barcode_fila_1")
				kst_tab_barcode.fila_1p = dw_barcode.getitemnumber(a_riga, "barcode_fila_1p")
				kst_tab_barcode.fila_2 = dw_barcode.getitemnumber(a_riga, "barcode_fila_2")
				kst_tab_barcode.fila_2p = dw_barcode.getitemnumber(a_riga, "barcode_fila_2p")
			end if	

		case "d_pl_barcode_dett_grp_all" 
//--- se sono in modalita di modifica riga e ho selezionato piu' righe passo alla modalita
//--- modifica piu' righe
			if a_modalita_modifica_file = dw_modifica.ki_modalita_modifica_giri_riga then
			    k_riga = dw_groupage.getselectedrow(0)
				if k_riga > 0 then
				   k_riga = dw_groupage.getselectedrow(k_riga)
					if k_riga > 0 then
						a_modalita_modifica_file = dw_modifica.ki_modalita_modifica_giri_righe
					end if
				end if
			end if
			//k_riga = dw_groupage.getrow() 
			if a_riga > 0 then		
				kst_tab_barcode.pl_barcode = dw_dett_0.getitemnumber(1, "codice")
				kst_tab_barcode.barcode = dw_groupage.getitemstring(a_riga, "barcode_barcode")
				kst_tab_barcode.num_int = dw_groupage.getitemnumber(a_riga, "barcode_num_int")
				kst_tab_barcode.data_int = dw_groupage.getitemdate(a_riga, "barcode_data_int")
				kst_tab_barcode.fila_1 = dw_groupage.getitemnumber(a_riga, "barcode_fila_1")
				kst_tab_barcode.fila_1p = dw_groupage.getitemnumber(a_riga, "barcode_fila_1p")
				kst_tab_barcode.fila_2 = dw_groupage.getitemnumber(a_riga, "barcode_fila_2")
				kst_tab_barcode.fila_2p = dw_groupage.getitemnumber(a_riga, "barcode_fila_2p")
			end if	


		case "d_pl_barcode_dett_1"
			
			setnull(kidw_barcode_da_non_modificare)
//--- se sono in modalita di modifica riga e ho selezionato piu' righe passo alla modalita
//--- modifica piu' righe
			if a_modalita_modifica_file = dw_modifica.ki_modalita_modifica_giri_riga then
			    k_riga = dw_lista_0.getselectedrow(0)
				if k_riga > 0 then
				   k_riga = dw_lista_0.getselectedrow(k_riga)
					if k_riga > 0 then
						a_modalita_modifica_file = dw_modifica.ki_modalita_modifica_giri_righe
					end if
				end if
			end if
			//k_riga = dw_lista_0.getrow() 
			if a_riga > 0 then		
				kst_tab_barcode.pl_barcode = dw_dett_0.getitemnumber(1, "codice")
				kst_tab_barcode.barcode = dw_lista_0.getitemstring(a_riga, "barcode_barcode")
				kst_tab_barcode.num_int = dw_lista_0.getitemnumber(a_riga, "barcode_num_int")
				kst_tab_barcode.data_int = dw_lista_0.getitemdate(a_riga, "barcode_data_int")
				kst_tab_barcode.fila_1 = dw_lista_0.getitemnumber(a_riga, "barcode_fila_1")
				kst_tab_barcode.fila_1p = dw_lista_0.getitemnumber(a_riga, "barcode_fila_1p")
				kst_tab_barcode.fila_2 = dw_lista_0.getitemnumber(a_riga, "barcode_fila_2")
				kst_tab_barcode.fila_2p = dw_lista_0.getitemnumber(a_riga, "barcode_fila_2p")
			end if	

	end choose

	if a_riga > 0 then

		dw_modifica.modifica_giri(&
										kst_tab_barcode &
										,a_modalita_modifica_file &
										,dw_modifica.ki_modif_tutto_riferimento &
										,kidw_x_modifica_giri &
										,kidw_barcode_da_non_modificare &
										)
										
		retrieve_figli( )  // aggiorna elenco figli 
		
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
//			kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
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

public subroutine u_marca_rif_file_davanti ();//
long k_riga, k_presenti_meca, k_num_loop_max, k_riga_find
long k_ctr, k_rc, k_fila_mag_n
string k_area_mag, k_fila_mag


//--- Evidenzia i Lotti con Fila davanti (la fila ZERO è quella a Muro la 1 davanti alla zero la 2 davanti alla 1 e così via) AREA_MAG il carattere 6 e' la fila
	k_num_loop_max	= dw_meca.rowcount()
	for k_riga = 1 to k_num_loop_max
		k_area_mag =  trim(dw_meca.getitemstring(k_riga, "meca_area_mag") )
		dw_meca.setitem(k_riga, "evidenzia_area_mag_value", 0)
		if len(k_area_mag) > 5 then
			k_fila_mag = mid(k_area_mag,6,1)
			k_area_mag = left(k_area_mag,5)
			if isnumber(k_fila_mag) then
				k_fila_mag_n = integer(k_fila_mag) + 1
				for k_ctr = k_fila_mag_n  to 9 // cerca AREA_MAG dietro al lotto (fila + bassa)
					k_riga_find = dw_meca.find("meca_area_mag = '" +k_area_mag + string(k_ctr)+"'", 0, dw_meca.rowcount())
					if k_riga_find > 0 then 
						dw_meca.setitem(k_riga, "evidenzia_area_mag_value", dw_meca.getitemnumber(k_riga_find, "meca_num_int"))
						EXIT
					end if
				next
			end if
		end if
	next



end subroutine

private function long u_check_rif_file_davanti (long a_riga_inp);//
//--- Controlla in elenco riferimenti che non ci sia qlc pallet in posizione migliore fila 0=a muro, 1=prima della fila zero, 2=prima della fila 1 e così via
//--- input: num riga elenco da confrontare
//--- torna riga elenco che fa rif al numero Lotto trovato in pos migliore;  ZERO per nessun lotto trovato
//
long k_return = 0
long k_riga_pos_migliore=0, k_righe, k_riga_find
string k_area_mag_pos, k_area_mag, k_area, k_area_input
int k_area_mag_pos_n,  k_pos_migliore, k_pos_input


k_righe = dw_meca.rowcount() 

if a_riga_inp > 0 and a_riga_inp < k_righe then
	
//--- preleva il valore della posizione da confrontare	
//	k_area_mag_pos = dw_meca.getitemstring( a_riga_inp, "area_mag_pos" )

	k_area_mag =  trim(dw_meca.getitemstring(a_riga_inp, "meca_area_mag") )
	if len(k_area_mag) > 5 then
		k_area_mag_pos = mid(k_area_mag,6,1)
		k_area_mag = left(k_area_mag,5)
		if isnumber(k_area_mag_pos) then
			k_area_mag_pos_n = integer(k_area_mag_pos) + 1
			for k_pos_migliore = k_area_mag_pos_n  to 9 // cerca AREA_MAG davanti al lotto (fila + alta)
					k_riga_find = dw_meca.find("meca_area_mag = '" +k_area_mag + string(k_pos_migliore)+"'", 0, dw_meca.rowcount())
					if k_riga_find > 0 then 
						k_return = k_riga_find    // trovato pallet in posizione migliore
						EXIT
					end if
				next
			end if
		end if

//	if isnumber(k_area_mag_pos) then
//		k_pos_input = integer(k_area_mag_pos)
//		k_pos_migliore = k_pos_input
//		k_area_mag = dw_meca.getitemstring( a_riga_inp, "meca_area_mag" )
//		k_area_input = mid(k_area_mag, 3,2)
//		
//		k_riga_find = 1
////--- cerca la fila 			
//		k_riga_find = dw_lista_0.find("Pos(meca_area_mag,'" + k_area_input + "') > 0", k_riga_find, k_righe)
//		do while k_riga_find > 0
//
////--- get della posizione
//			k_area_mag_pos = dw_meca.getitemstring( k_riga_find, "area_mag_pos" )
//			if isnumber(k_area_mag_pos) then
//				k_area_mag_pos_n = integer(k_area_mag_pos)
//				if k_area_mag_pos_n > k_pos_migliore then
////--- set della posizione migliore
//					k_pos_migliore = k_area_mag_pos_n
//					k_riga_pos_migliore = k_riga_find
//				end if
//			end if
//			
////--- cerca la fila 			
//			k_riga_find++
//			k_riga_find = dw_lista_0.find("Pos(meca_area_mag,'" + k_area_input + "') > 0", k_riga_find, k_righe)
//
//		loop
//		
////--- ho trovato una riga con la pos del pallet migliore?
//		if k_pos_migliore <> k_pos_input then
//			k_return = k_riga_pos_migliore
//		end if
//		
//	end if
end if		


return k_return

end function

protected function string inizializza_post ();if not ki_exit_si then

	
	attiva_tasti()

	if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima volta il tasto e' false 
		dw_meca.setfocus( )
	end if
	
end if

return "0"

end function

private subroutine u_autorizza_stato_in_attenzione ();//---
//--- Funzione: Autorizzazione a MARCARE il glag in Attenzione del LOTTO
//--- 
//--- Input:
//---
//--- Ritorno: no
//---
//---


try

	ki_autirizza_marca_stato_in_attenzione = true

	kiuf_armo.if_sicurezza(kkg_flag_modalita.inserimento) 

catch (uo_exception kuo_exception)
	ki_autirizza_marca_stato_in_attenzione = false

end try
	



end subroutine

private function boolean u_autorizza_mod_consegna_data ();//---
//--- Funzione: Autorizzazione a modificare la DATA di CONSEGNA
//--- 
//--- Input:
//---
//--- Ritorno: no
//---
//---
boolean k_autorizza=true


k_autorizza = ki_chiudi_PL_enabled 

//try
//	kiuf_armo.if_sicurezza(kkg_flag_modalita.modifica)
//
//catch (uo_exception kuo_exception)
//	k_autorizza = false
//	
//end try

return k_autorizza

end function

public subroutine u_aggiorna_data_consegna (st_tab_meca kst_tab_meca, long k_riga);//
try
	
	
	kiuf_armo.set_consegna_data(kst_tab_meca)

	dw_meca.setitem(k_riga, "meca_consegna_data", kst_tab_meca.consegna_data)

catch (uo_exception kuo_exception)

	kuo_exception.messaggio_utente()
	
end try

end subroutine

private subroutine u_abilita_chiusura_pl ();//
//--- controllo autorizzazione x chiusura P.L.
//
st_esito kst_esito
kuf_pl_barcode kuf1_pl_barcode


kuf1_pl_barcode = create kuf_pl_barcode

kst_esito = kuf1_pl_barcode.consenti_chiusura() 

destroy kuf1_pl_barcode

if kst_esito.esito = kkg_esito.ok then
	ki_chiudi_PL_enabled = true
end if

end subroutine

private subroutine u_abilita_modifica_giri ();//
//--- controllo autorizzazione x cambio giri di lavorazione
//

	try

		cb_file.enabled = dw_modifica.autorizza_modifica_giri()
	
		if dw_modifica.ki_modifica_cicli_enabled = dw_modifica.ki_modifica_cicli_enabled_modif &
			and trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.inserimento &
			and trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.modifica then
			dw_modifica.ki_modifica_cicli_enabled = dw_modifica.ki_modifica_cicli_enabled_visualizzazione
		end if


	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()			
		cb_file.enabled = false
		dw_modifica.ki_modifica_cicli_enabled = dw_modifica.ki_modifica_cicli_enabled_visualizzazione
		
	finally			
	end try

end subroutine

public subroutine u_mostra_proprieta (boolean k_forza_visible);//---
//--- Mostra finestra Proprietà
//---
st_tab_pl_barcode kst_tab_pl_barcode


//--- se non è visibile o è da forzare la visibilita allora VISIBLE!
if not dw_dett_0.visible or k_forza_visible then

	if dw_dett_0.rowcount() = 0 then
		kiuf1_pl_barcode.set_pl_barcode_nuovo_default(kst_tab_pl_barcode)
		set_dw_dett_0(kst_tab_pl_barcode)
	end if

//--- determina lo stato del pulsante (CHIUDI APRI il PL)	
	if not ki_PL_chiuso then 
		dw_dett_0.object.b_chiudi.text = "CHIUDE PL"
	else
		dw_dett_0.object.b_chiudi.text = "RIAPRE PL"
	end if
	dw_dett_0.object.b_chiudi.enabled = cb_chiudi.enabled
	
	dw_dett_0.width = 2587
	dw_dett_0.height = 936
	dw_dett_0.X = (this.width - dw_dett_0.width) / 2
	dw_dett_0.y = (this.height - dw_dett_0.height) / 3
	
	dw_dett_0.visible = true
	dw_dett_0.bringtotop = true
else
	dw_dett_0.visible = false
end if

end subroutine

private subroutine copia_dw_barcode_to_dw_groupage (integer k_riga1, integer k_riga2);//---
//--- copia dalla dw_barcode in dw del groupage 
//--- parametri: riga1 riga della dw1
//---            riga2 riga della dw2
//---
st_tab_barcode kst_tab_barcode
st_esito kst_esito
kuf_barcode kuf1_barcode
	
	
	try 
		kuf1_barcode = create kuf_barcode
		kst_tab_barcode.barcode = dw_barcode.getitemstring(k_riga2, "barcode_barcode")
		if not kuf1_barcode.get_padre(kst_tab_barcode) then
			kst_tab_barcode.barcode_lav = " "
		end if
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
	finally 
		destroy kuf1_barcode
	end try
	
			dw_groupage.setitem(k_riga1, "barcode_lav",  kst_tab_barcode.barcode_lav)
			dw_groupage.setitem(k_riga1, "barcode_barcode", &
						 dw_barcode.getitemstring(k_riga2, "barcode_barcode"))
			dw_groupage.setitem(k_riga1, "barcode_tipo_cicli", &
						 dw_barcode.getitemstring(k_riga2, "barcode_tipo_cicli"))
			dw_groupage.setitem(k_riga1, "barcode_fila_1", &
						 dw_barcode.getitemnumber(k_riga2, "barcode_fila_1"))
			dw_groupage.setitem(k_riga1, "barcode_fila_2", &
						 dw_barcode.getitemnumber(k_riga2, "barcode_fila_2"))
			dw_groupage.setitem(k_riga1, "barcode_fila_1p", &
						 dw_barcode.getitemnumber(k_riga2, "barcode_fila_1p"))
			dw_groupage.setitem(k_riga1, "barcode_fila_2p", &
						 dw_barcode.getitemnumber(k_riga2, "barcode_fila_2p"))
			dw_groupage.setitem(k_riga1, "barcode_num_int", &
						 dw_barcode.getitemnumber(k_riga2, "barcode_num_int"))
			dw_groupage.setitem(k_riga1, "barcode_data_int", &
						 dw_barcode.getitemdate(k_riga2, "barcode_data_int"))
			dw_groupage.setitem(k_riga1, "dose", &
						 dw_barcode.getitemnumber(k_riga2, "armo_dose"))
			dw_groupage.setitem(k_riga1, "peso_kg", &
						 dw_barcode.getitemnumber(k_riga2, "armo_peso_kg"))
			dw_groupage.setitem(k_riga1, "larg_2", &
						 dw_barcode.getitemnumber(k_riga2, "armo_larg_2"))
			dw_groupage.setitem(k_riga1, "lung_2", &
						 dw_barcode.getitemnumber(k_riga2, "armo_lung_2"))
			dw_groupage.setitem(k_riga1, "alt_2", &
						 dw_barcode.getitemnumber(k_riga2, "armo_alt_2"))
			dw_groupage.setitem(k_riga1, "pedane", &
						 dw_barcode.getitemnumber(k_riga2, "armo_pedane"))
			dw_groupage.setitem(k_riga1, "campione", &
						 dw_barcode.getitemstring(k_riga2, "armo_campione"))
			dw_groupage.setitem(k_riga1, "art", &
						 dw_barcode.getitemstring(k_riga2, "armo_art"))
//			dw_groupage.setitem(k_riga1, "armo_cod_sl_pt", &
//						 dw_barcode.getitemstring(k_riga2, "armo_cod_sl_pt"))
			dw_groupage.setitem(k_riga1, "area_mag", &
						 dw_barcode.getitemstring(k_riga2, "meca_area_mag"))
			dw_groupage.setitem(k_riga1, "id_armo", &
						 dw_barcode.getitemnumber(k_riga2, "armo_id_armo"))
			dw_groupage.setitem(k_riga1, "id_meca", &
						 dw_barcode.getitemnumber(k_riga2, "id_meca"))

			dw_groupage.setitem(k_riga1, "e1ancodrs", &
						 dw_barcode.getitemstring(k_riga2, "e1ancodrs"))

//			dw_groupage.setitem(k_riga1, "clie_2", &
//						 dw_barcode.getitemnumber(k_riga2, "meca_clie_2"))
//			dw_groupage.setitem(k_riga1, "des", &
//						 dw_barcode.getitemstring(k_riga2, "prodotti_des"))
//			dw_groupage.setitem(k_riga1, "rag_soc_10", &
//						 dw_barcode.getitemstring(k_riga2, "k_ricevente"))


end subroutine

private subroutine copia_dw_barcode_to_dw_lista_0 (integer k_riga1, integer k_riga2);//---
//--- copia dati dal DW di dettaglio (dw_bacode) al dw di lavoro (dw_lista_0) 
//--- parametri:
//---            riga1 riga della dw1
//---            riga2 riga della dw2
//---
	
	
		dw_lista_0.setitem(k_riga1, "barcode_barcode", &
					 dw_barcode.getitemstring(k_riga2, "barcode_barcode"))
		dw_lista_0.setitem(k_riga1, "barcode_tipo_cicli", &
					 dw_barcode.getitemstring(k_riga2, "barcode_tipo_cicli"))
		dw_lista_0.setitem(k_riga1, "barcode_fila_1", &
					 dw_barcode.getitemnumber(k_riga2, "barcode_fila_1"))
		dw_lista_0.setitem(k_riga1, "barcode_fila_2", &
					 dw_barcode.getitemnumber(k_riga2, "barcode_fila_2"))
		dw_lista_0.setitem(k_riga1, "barcode_fila_1p", &
					 dw_barcode.getitemnumber(k_riga2, "barcode_fila_1p"))
		dw_lista_0.setitem(k_riga1, "barcode_fila_2p", &
					 dw_barcode.getitemnumber(k_riga2, "barcode_fila_2p"))
		dw_lista_0.setitem(k_riga1, "barcode_num_int", &
					 dw_barcode.getitemnumber(k_riga2, "barcode_num_int"))
		dw_lista_0.setitem(k_riga1, "barcode_data_int", &
					 dw_barcode.getitemdate(k_riga2, "barcode_data_int"))
//		dw_lista_0.setitem(k_riga1, "barcode_data_sosp", &
//					 dw_barcode.getitemdate(k_riga2, "barcode_data_sosp"))
//		dw_lista_0.setitem(k_riga1, "barcode_data_lav_ini", &
//					 dw_barcode.getitemdate(k_riga2, "barcode_data_lav_ini"))
//		dw_lista_0.setitem(k_riga1, "barcode_data_lav_fin",  dw_barcode.getitemdate(k_riga2, "barcode_data_lav_fin"))
//			
//		if dw_lista_0.dataobject = "dw_barcode" or dw_barcode.dataobject = "dw_barcode" then
//		else
//			dw_lista_0.setitem(k_riga1, "barcode_data_lav_ok", &
//						 dw_barcode.getitemdate(k_riga2, "barcode_data_lav_ok"))
//			dw_lista_0.setitem(k_riga1, "barcode_x_datins", &
//						 dw_barcode.getitemdatetime(k_riga2, "barcode_x_datins"))
//			dw_lista_0.setitem(k_riga1, "barcode_x_utente", &
//						 dw_barcode.getitemstring(k_riga2, "barcode_x_utente"))
//			dw_lista_0.setitem(k_riga1, "sl_pt_tipo_cicli", &
//						 dw_barcode.getitemstring(k_riga2, "sl_pt_tipo_cicli"))
//			dw_lista_0.setitem(k_riga1, "sl_pt_fila_1", &
//						 dw_barcode.getitemnumber(k_riga2, "sl_pt_fila_1"))
//			dw_lista_0.setitem(k_riga1, "sl_pt_fila_2", &
//						 dw_barcode.getitemnumber(k_riga2, "sl_pt_fila_2"))
//			dw_lista_0.setitem(k_riga1, "sl_pt_fila_1p", &
//						 dw_barcode.getitemnumber(k_riga2, "sl_pt_fila_1p"))
//			dw_lista_0.setitem(k_riga1, "sl_pt_fila_2p", &
//						 dw_barcode.getitemnumber(k_riga2, "sl_pt_fila_2p"))
			dw_lista_0.setitem(k_riga1, "dose", &
						 dw_barcode.getitemnumber(k_riga2, "armo_dose"))
			dw_lista_0.setitem(k_riga1, "peso_kg", &
						 dw_barcode.getitemnumber(k_riga2, "armo_peso_kg"))
			dw_lista_0.setitem(k_riga1, "larg_2", &
						 dw_barcode.getitemnumber(k_riga2, "armo_larg_2"))
			dw_lista_0.setitem(k_riga1, "lung_2", &
						 dw_barcode.getitemnumber(k_riga2, "armo_lung_2"))
			dw_lista_0.setitem(k_riga1, "alt_2", &
						 dw_barcode.getitemnumber(k_riga2, "armo_alt_2"))
			dw_lista_0.setitem(k_riga1, "pedane", &
						 dw_barcode.getitemnumber(k_riga2, "armo_pedane"))
			dw_lista_0.setitem(k_riga1, "campione", &
						 dw_barcode.getitemstring(k_riga2, "armo_campione"))
			dw_lista_0.setitem(k_riga1, "art", &
						 dw_barcode.getitemstring(k_riga2, "armo_art"))
//			dw_lista_0.setitem(k_riga1, "armo_cod_sl_pt", &
//						 dw_barcode.getitemstring(k_riga2, "armo_cod_sl_pt"))
			dw_lista_0.setitem(k_riga1, "area_mag", &
						 dw_barcode.getitemstring(k_riga2, "meca_area_mag"))
			dw_lista_0.setitem(k_riga1, "id_armo", &
						 dw_barcode.getitemnumber(k_riga2, "armo_id_armo"))
			dw_lista_0.setitem(k_riga1, "id_meca", &
						 dw_barcode.getitemnumber(k_riga2, "id_meca"))

			dw_lista_0.setitem(k_riga1, "e1ancodrs", &
						 dw_barcode.getitemstring(k_riga2, "e1ancodrs"))

//			dw_lista_0.setitem(k_riga1, "meca_contratto", &
//						 dw_barcode.getitemnumber(k_riga2, "meca_contratto"))
//			dw_lista_0.setitem(k_riga1, "meca_clie_3", &
//						 dw_barcode.getitemnumber(k_riga2, "meca_clie_3"))
//			dw_lista_0.setitem(k_riga1, "contratti_mc_co", &
//						 dw_barcode.getitemstring(k_riga2, "contratti_mc_co"))
//			dw_lista_0.setitem(k_riga1, "contratti_sc_cf", &
//						 dw_barcode.getitemstring(k_riga2, "contratti_sc_cf"))
//			dw_lista_0.setitem(k_riga1, "contratti_descr", &
//						 dw_barcode.getitemstring(k_riga2, "contratti_descr"))
//			dw_lista_0.setitem(k_riga1, "prodotti_des", &
//						 dw_barcode.getitemstring(k_riga2, "prodotti_des"))
//			dw_lista_0.setitem(k_riga1, "clienti_rag_soc_10", &
//						 dw_barcode.getitemstring(k_riga2, "clienti_rag_soc_10"))
//			dw_lista_0.setitem(k_riga1, "k_ricevente", &
//						 dw_barcode.getitemstring(k_riga2, "k_ricevente"))
//		end if

end subroutine

public subroutine aggiungi_grp_barcode_singolo (ref datawindow kdw_2);//
//=== Aggiungi un BARCODE alla lista dei Pianificati in Groupage
//===   kdw_2 -----> dw_groupage
//
long k_riga, k_insertrow, k_riga_drag, k_riga_ultima=0, k_riga_find=0, k_riga_meca
long k_pl_barcode
date k_data_int
string k_find
int k_ctr, k_rc
boolean k_elabora=true, k_blocca_operazione=false
st_tab_meca kst_tab_meca
st_tab_barcode kst_tab_barcode
kuf_sl_pt kuf1_sl_pt
kuf_barcode kuf1_barcode

try
	
	
	if kdw_2.rowcount() > 0 then
	
		if dw_groupage.rowcount() > 0 and dw_groupage.getselectedrow(0) > 0 then
			k_insertrow = 1
			k_riga = dw_groupage.getselectedrow(0)
		else
			k_riga = 0
			k_insertrow = 0
		end if

		k_riga_drag = kdw_2.getselectedrow(0)
		if k_riga_drag > 0 then
			ki_lista_0_modifcato = true
			kuf1_barcode = create kuf_barcode
		end if
		
		do while k_riga_drag > 0 
	
//--- Controllo che barcode non abbia figli
			kst_tab_barcode.barcode = kdw_2.getitemstring(k_riga_drag, "barcode_barcode")
			if kuf1_barcode.if_barcode_padre(kst_tab_barcode) then
				kguo_exception.inizializza( )
				kguo_exception.setmessage( "ATTENZIONE", "Il Barcode " + trim(kst_tab_barcode.barcode ) + " è 'PADRE' non è possibile aggiungerlo come 'FIGLIO' - Operazione bloccata!")
				throw kguo_exception
			end if

//--- Controllo se Riferimento 'IN ATTENZIONE'
			kst_tab_meca.num_int = kdw_2.getitemnumber(k_riga_drag, "barcode_num_int")
			k_riga_meca = dw_meca.find( "meca_num_int = " + string(kst_tab_meca.num_int), 1, dw_meca.rowcount() )
			if k_riga_meca > 0 then 

				kst_tab_meca.id = dw_meca.getitemnumber(k_riga_meca, "id_meca")
				kst_tab_meca.num_int = dw_meca.getitemnumber(k_riga_meca, "meca_num_int") 
				kst_tab_meca.data_int = dw_meca.getitemdate(k_riga_meca, "meca_data_int") 
				if kst_tab_meca.id > 0 then
					if not if_lotto_associato(kst_tab_meca) then
					
						kguo_exception.inizializza( )
						if ki_consenti_lavoraz_non_associati_wmf then
							kguo_exception.messaggio_utente( "ATTENZIONE", "Lotto n. " + string(kst_tab_meca.num_int ) + " non è stato 'Associato' ('20') - Operazione consentita grazie al consenso impostato a menu.")
						else
							k_blocca_operazione = true
							kguo_exception.messaggio_utente( "Operazione Bloccata", "Lotto n. " + string(kst_tab_meca.num_int ) + " non è stato 'Associato' ('20') - Pianificazione non consentita")
						end if
					end if
				end if
				
				if not k_blocca_operazione then
					if dw_meca.getitemnumber(k_riga_meca, "stato_in_attenzione") = 1 then
						kguo_exception.inizializza( )
						kguo_exception.messaggio_utente( "AVVERTIMENTO", "Lotto " + string(dw_meca.getitemnumber(k_riga_meca, "meca_num_int")) + " è 'IN ATTENZIONE'  -   NON sarebbe ancora da TRATTARE.  Rimuoverlo dell'elenco")
					end if
				end if
			end if

			if k_blocca_operazione then
				k_riga_drag = kdw_2.getselectedrow(k_riga_drag)  // continua la ricerca di altre righe selezionate
				
			else
//--- se ciclo normale a scelta devo effettuare prima la scelta
				if kdw_2.getitemstring(k_riga_drag, "barcode_tipo_cicli") = kuf1_sl_pt.ki_tipo_cicli_a_scelta then
					
					k_elabora=false
					
					modifica_giri(dw_modifica.ki_modalita_modifica_scelta_fila, k_riga_drag,  ki_dw_fuoco_nome)
					
	
					k_riga_drag = 0 // forzo uscita ciclo
					
				else
	
					k_riga = dw_groupage.insertrow(k_riga + k_insertrow)
			
//--- copia in dw_groupage la dw2 (dw_barcode/dw_lista_0) 			
					if kdw_2.dataobject = dw_lista_0.dataobject then
						copia_dw_lista_0_to_dw_groupage(k_riga, k_riga_drag)
					else
						copia_dw_barcode_to_dw_groupage(k_riga, k_riga_drag)			
//					else
//						copia_dw_barcode_to_dwxlavorazione(dw_groupage, k_riga, k_riga_drag)
////						copia_dettaglio_dw_grp_da_dw1 (dw_groupage, kdw_2, k_riga, k_riga_drag)
					end if
	
					kdw_2.deleterow(k_riga_drag) 
	
					k_riga_drag = kdw_2.getselectedrow(k_riga_drag - 1)
					
					k_riga_ultima = k_riga
					
				end if
			end if

		loop

		if k_riga_ultima > 0 and k_elabora then
			
//--- sistema il codice e i progressivi nella lista
			imposta_codice_progr( dw_groupage )

			dw_groupage.selectrow(0, false)
			dw_groupage.setrow(k_riga_ultima)
			dw_groupage.selectrow(k_riga_ultima, true)
			dw_groupage.scrolltorow(k_riga_ultima)
		end if
			
		if k_elabora then
			screma_lista_riferimenti()
		end if
			

	end if

	attiva_tasti()

	dw_groupage.setcolumn(1)
	dw_groupage.setfocus()

	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
	
finally 
	if isvalid(kuf1_barcode) then destroy kuf1_barcode
	
	
end try

end subroutine

private subroutine copia_dw_lista_0_to_dw_groupage (integer k_riga1, integer k_riga2);//---
//--- copia dalla dw_lista in dw del groupage 
//--- parametri: 
//---            riga1 riga della dw1
//---            riga2 riga della dw2
//---
	
	
//			dw_groupage.setitem(k_riga1, "barcode_barcode_lav",  "")
			dw_groupage.setitem(k_riga1, "barcode_barcode", &
						 dw_lista_0.getitemstring(k_riga2, "barcode_barcode"))
			dw_groupage.setitem(k_riga1, "barcode_tipo_cicli", &
						 dw_lista_0.getitemstring(k_riga2, "barcode_tipo_cicli"))
			dw_groupage.setitem(k_riga1, "barcode_fila_1", &
						 dw_lista_0.getitemnumber(k_riga2, "barcode_fila_1"))
			dw_groupage.setitem(k_riga1, "barcode_fila_2", &
						 dw_lista_0.getitemnumber(k_riga2, "barcode_fila_2"))
			dw_groupage.setitem(k_riga1, "barcode_fila_1p", &
						 dw_lista_0.getitemnumber(k_riga2, "barcode_fila_1p"))
			dw_groupage.setitem(k_riga1, "barcode_fila_2p", &
						 dw_lista_0.getitemnumber(k_riga2, "barcode_fila_2p"))
			dw_groupage.setitem(k_riga1, "barcode_num_int", &
						 dw_lista_0.getitemnumber(k_riga2, "barcode_num_int"))
			dw_groupage.setitem(k_riga1, "barcode_data_int", &
						 dw_lista_0.getitemdate(k_riga2, "barcode_data_int"))
			dw_groupage.setitem(k_riga1, "dose", dw_lista_0.getitemnumber(k_riga2, "dose"))
			dw_groupage.setitem(k_riga1, "peso_kg", &
						 dw_lista_0.getitemnumber(k_riga2, "peso_kg"))
			dw_groupage.setitem(k_riga1, "larg_2", &
						 dw_lista_0.getitemnumber(k_riga2, "larg_2"))
			dw_groupage.setitem(k_riga1, "lung_2", &
						 dw_lista_0.getitemnumber(k_riga2, "lung_2"))
			dw_groupage.setitem(k_riga1, "alt_2", &
						 dw_lista_0.getitemnumber(k_riga2, "alt_2"))
			dw_groupage.setitem(k_riga1, "pedane", &
						 dw_lista_0.getitemnumber(k_riga2, "pedane"))
			dw_groupage.setitem(k_riga1, "campione", &
						 dw_lista_0.getitemstring(k_riga2, "campione"))
			dw_groupage.setitem(k_riga1, "art", &
						 dw_lista_0.getitemstring(k_riga2, "art"))
//			dw_groupage.setitem(k_riga1, "armo_cod_sl_pt", &
//						 dw_lista_0.getitemstring(k_riga2, "armo_cod_sl_pt"))
			dw_groupage.setitem(k_riga1, "area_mag", &
						 dw_lista_0.getitemstring(k_riga2, "area_mag"))
			dw_groupage.setitem(k_riga1, "id_armo", &
						 dw_lista_0.getitemnumber(k_riga2, "id_armo"))
			dw_groupage.setitem(k_riga1, "id_meca", &
						 dw_lista_0.getitemnumber(k_riga2, "id_meca"))

			dw_groupage.setitem(k_riga1, "e1ancodrs", &
						 dw_lista_0.getitemstring(k_riga2, "e1ancodrs"))

//			dw_groupage.setitem(k_riga1, "meca_clie_2", &
//						 dw_lista_0.getitemnumber(k_riga2, "clie_2"))
//			dw_groupage.setitem(k_riga1, "prodotti_des", &
//						 dw_lista_0.getitemstring(k_riga2, "des"))
//			dw_groupage.setitem(k_riga1, "clienti_rag_soc_10", &
//						 dw_lista_0.getitemstring(k_riga2, "rag_soc_10") + " " + string(dw_lista_0.getitemnumber(k_riga2, "clie_2")))


end subroutine

private subroutine copia_dw_groupage_to_dw_barcode (integer k_riga1, integer k_riga2);//---
//--- copia dati dal dw del groupage (dw_groupage) al DW di dettaglio (dw_barcode)
//--- parametri: 
//---            riga1 riga della dw1
//---            riga2 riga della dw2
//---
	
	
		dw_barcode.setitem(k_riga1, "barcode_barcode", &
					 dw_groupage.getitemstring(k_riga2, "barcode_barcode"))
		dw_barcode.setitem(k_riga1, "barcode_tipo_cicli", &
					 dw_groupage.getitemstring(k_riga2, "barcode_tipo_cicli"))
		dw_barcode.setitem(k_riga1, "barcode_fila_1", &
					 dw_groupage.getitemnumber(k_riga2, "barcode_fila_1"))
		dw_barcode.setitem(k_riga1, "barcode_fila_2", &
					 dw_groupage.getitemnumber(k_riga2, "barcode_fila_2"))
		dw_barcode.setitem(k_riga1, "barcode_fila_1p", &
					 dw_groupage.getitemnumber(k_riga2, "barcode_fila_1p"))
		dw_barcode.setitem(k_riga1, "barcode_fila_2p", &
					 dw_groupage.getitemnumber(k_riga2, "barcode_fila_2p"))
		dw_barcode.setitem(k_riga1, "barcode_num_int", &
					 dw_groupage.getitemnumber(k_riga2, "barcode_num_int"))
		dw_barcode.setitem(k_riga1, "barcode_data_int", &
					 dw_groupage.getitemdate(k_riga2, "barcode_data_int"))
//		dw_barcode.setitem(k_riga1, "barcode_data_sosp", &
//					 dw_groupage.getitemdate(k_riga2, "barcode_data_sosp"))
//		dw_barcode.setitem(k_riga1, "barcode_data_lav_ini", &
//					 dw_groupage.getitemdate(k_riga2, "barcode_data_lav_ini"))
//		dw_barcode.setitem(k_riga1, "barcode_data_lav_fin",  dw_groupage.getitemdate(k_riga2, "barcode_data_lav_fin"))
//			
//		if dw_barcode.dataobject = "dw_barcode" or dw_groupage.dataobject = "dw_barcode" then
//		else
//			dw_barcode.setitem(k_riga1, "barcode_data_lav_ok", &
//						 dw_groupage.getitemdate(k_riga2, "barcode_data_lav_ok"))
//			dw_barcode.setitem(k_riga1, "barcode_x_datins", &
//						 dw_groupage.getitemdatetime(k_riga2, "barcode_x_datins"))
//			dw_barcode.setitem(k_riga1, "barcode_x_utente", &
//						 dw_groupage.getitemstring(k_riga2, "barcode_x_utente"))
//			dw_barcode.setitem(k_riga1, "sl_pt_tipo_cicli", &
//						 dw_groupage.getitemstring(k_riga2, "sl_pt_tipo_cicli"))
//			dw_barcode.setitem(k_riga1, "sl_pt_fila_1", &
//						 dw_groupage.getitemnumber(k_riga2, "sl_pt_fila_1"))
//			dw_barcode.setitem(k_riga1, "sl_pt_fila_2", &
//						 dw_groupage.getitemnumber(k_riga2, "sl_pt_fila_2"))
//			dw_barcode.setitem(k_riga1, "sl_pt_fila_1p", &
//						 dw_groupage.getitemnumber(k_riga2, "sl_pt_fila_1p"))
//			dw_barcode.setitem(k_riga1, "sl_pt_fila_2p", &
//						 dw_groupage.getitemnumber(k_riga2, "sl_pt_fila_2p"))
			dw_barcode.setitem(k_riga1, "armo_dose", &
						 dw_groupage.getitemnumber(k_riga2, "dose"))
			dw_barcode.setitem(k_riga1, "armo_peso_kg", &
						 dw_groupage.getitemnumber(k_riga2, "peso_kg"))
			dw_barcode.setitem(k_riga1, "armo_larg_2", &
						 dw_groupage.getitemnumber(k_riga2, "larg_2"))
			dw_barcode.setitem(k_riga1, "armo_lung_2", &
						 dw_groupage.getitemnumber(k_riga2, "lung_2"))
			dw_barcode.setitem(k_riga1, "armo_alt_2", &
						 dw_groupage.getitemnumber(k_riga2, "alt_2"))
			dw_barcode.setitem(k_riga1, "armo_pedane", &
						 dw_groupage.getitemnumber(k_riga2, "pedane"))
			dw_barcode.setitem(k_riga1, "armo_campione", &
						 dw_groupage.getitemstring(k_riga2, "campione"))
			dw_barcode.setitem(k_riga1, "armo_art", &
						 dw_groupage.getitemstring(k_riga2, "art"))
//			dw_barcode.setitem(k_riga1, "armo_cod_sl_pt", &
//						 dw_groupage.getitemstring(k_riga2, "armo_cod_sl_pt"))
			dw_barcode.setitem(k_riga1, "meca_area_mag", &
						 dw_groupage.getitemstring(k_riga2, "area_mag"))
			dw_barcode.setitem(k_riga1, "armo_id_armo", &
						 dw_groupage.getitemnumber(k_riga2, "id_armo"))
			dw_barcode.setitem(k_riga1, "id_meca", &
						 dw_groupage.getitemnumber(k_riga2, "id_meca"))

			dw_barcode.setitem(k_riga1, "e1ancodrs", &
						 dw_groupage.getitemstring(k_riga2, "e1ancodrs"))

//			dw_barcode.setitem(k_riga1, "meca_contratto", &
//						 dw_groupage.getitemnumber(k_riga2, "meca_contratto"))
//			dw_barcode.setitem(k_riga1, "meca_clie_3", &
//						 dw_groupage.getitemnumber(k_riga2, "meca_clie_3"))
//			dw_barcode.setitem(k_riga1, "contratti_mc_co", &
//						 dw_groupage.getitemstring(k_riga2, "contratti_mc_co"))
//			dw_barcode.setitem(k_riga1, "contratti_sc_cf", &
//						 dw_groupage.getitemstring(k_riga2, "contratti_sc_cf"))
//			dw_barcode.setitem(k_riga1, "contratti_descr", &
//						 dw_groupage.getitemstring(k_riga2, "contratti_descr"))
//			dw_barcode.setitem(k_riga1, "prodotti_des", &
//						 dw_groupage.getitemstring(k_riga2, "prodotti_des"))
//			dw_barcode.setitem(k_riga1, "clienti_rag_soc_10", &
//						 dw_groupage.getitemstring(k_riga2, "clienti_rag_soc_10"))
//			dw_barcode.setitem(k_riga1, "k_ricevente", &
//						 dw_groupage.getitemstring(k_riga2, "k_ricevente"))
//		end if

end subroutine

private subroutine copia_dw_lista_0_to_dw_barcode (integer k_riga1, integer k_riga2);//---
//--- copia dati dal dw del groupage (dw_lista_0) al DW di dettaglio (dw_barcode)
//--- parametri: 
//---            riga1 riga della dw1
//---            riga2 riga della dw2
//---
	
	
		dw_barcode.setitem(k_riga1, "barcode_barcode", &
					 dw_lista_0.getitemstring(k_riga2, "barcode_barcode"))
		dw_barcode.setitem(k_riga1, "barcode_tipo_cicli", &
					 dw_lista_0.getitemstring(k_riga2, "barcode_tipo_cicli"))
		dw_barcode.setitem(k_riga1, "barcode_fila_1", &
					 dw_lista_0.getitemnumber(k_riga2, "barcode_fila_1"))
		dw_barcode.setitem(k_riga1, "barcode_fila_2", &
					 dw_lista_0.getitemnumber(k_riga2, "barcode_fila_2"))
		dw_barcode.setitem(k_riga1, "barcode_fila_1p", &
					 dw_lista_0.getitemnumber(k_riga2, "barcode_fila_1p"))
		dw_barcode.setitem(k_riga1, "barcode_fila_2p", &
					 dw_lista_0.getitemnumber(k_riga2, "barcode_fila_2p"))
		dw_barcode.setitem(k_riga1, "barcode_num_int", &
					 dw_lista_0.getitemnumber(k_riga2, "barcode_num_int"))
		dw_barcode.setitem(k_riga1, "barcode_data_int", &
					 dw_lista_0.getitemdate(k_riga2, "barcode_data_int"))
//		dw_barcode.setitem(k_riga1, "barcode_data_sosp", &
//					 dw_lista_0.getitemdate(k_riga2, "barcode_data_sosp"))
//		dw_barcode.setitem(k_riga1, "barcode_data_lav_ini", &
//					 dw_lista_0.getitemdate(k_riga2, "barcode_data_lav_ini"))
//		dw_barcode.setitem(k_riga1, "barcode_data_lav_fin",  dw_lista_0.getitemdate(k_riga2, "barcode_data_lav_fin"))
//			
//		if dw_barcode.dataobject = "dw_barcode" or dw_lista_0.dataobject = "dw_barcode" then
//		else
//			dw_barcode.setitem(k_riga1, "barcode_data_lav_ok", &
//						 dw_lista_0.getitemdate(k_riga2, "barcode_data_lav_ok"))
//			dw_barcode.setitem(k_riga1, "barcode_x_datins", &
//						 dw_lista_0.getitemdatetime(k_riga2, "barcode_x_datins"))
//			dw_barcode.setitem(k_riga1, "barcode_x_utente", &
//						 dw_lista_0.getitemstring(k_riga2, "barcode_x_utente"))
//			dw_barcode.setitem(k_riga1, "sl_pt_tipo_cicli", &
//						 dw_lista_0.getitemstring(k_riga2, "sl_pt_tipo_cicli"))
//			dw_barcode.setitem(k_riga1, "sl_pt_fila_1", &
//						 dw_lista_0.getitemnumber(k_riga2, "sl_pt_fila_1"))
//			dw_barcode.setitem(k_riga1, "sl_pt_fila_2", &
//						 dw_lista_0.getitemnumber(k_riga2, "sl_pt_fila_2"))
//			dw_barcode.setitem(k_riga1, "sl_pt_fila_1p", &
//						 dw_lista_0.getitemnumber(k_riga2, "sl_pt_fila_1p"))
//			dw_barcode.setitem(k_riga1, "sl_pt_fila_2p", &
//						 dw_lista_0.getitemnumber(k_riga2, "sl_pt_fila_2p"))
			dw_barcode.setitem(k_riga1, "armo_dose", &
						 dw_lista_0.getitemnumber(k_riga2, "dose"))
			dw_barcode.setitem(k_riga1, "armo_peso_kg", &
						 dw_lista_0.getitemnumber(k_riga2, "peso_kg"))
			dw_barcode.setitem(k_riga1, "armo_larg_2", &
						 dw_lista_0.getitemnumber(k_riga2, "larg_2"))
			dw_barcode.setitem(k_riga1, "armo_lung_2", &
						 dw_lista_0.getitemnumber(k_riga2, "lung_2"))
			dw_barcode.setitem(k_riga1, "armo_alt_2", &
						 dw_lista_0.getitemnumber(k_riga2, "alt_2"))
			dw_barcode.setitem(k_riga1, "armo_pedane", &
						 dw_lista_0.getitemnumber(k_riga2, "pedane"))
			dw_barcode.setitem(k_riga1, "armo_campione", &
						 dw_lista_0.getitemstring(k_riga2, "campione"))
			dw_barcode.setitem(k_riga1, "armo_art", &
						 dw_lista_0.getitemstring(k_riga2, "art"))
//			dw_barcode.setitem(k_riga1, "armo_cod_sl_pt", &
//						 dw_lista_0.getitemstring(k_riga2, "armo_cod_sl_pt"))
			dw_barcode.setitem(k_riga1, "meca_area_mag", &
						 dw_lista_0.getitemstring(k_riga2, "area_mag"))
			dw_barcode.setitem(k_riga1, "armo_id_armo", &
						 dw_lista_0.getitemnumber(k_riga2, "id_armo"))
			dw_barcode.setitem(k_riga1, "id_meca", &
						 dw_lista_0.getitemnumber(k_riga2, "id_meca"))
						 
			dw_barcode.setitem(k_riga1, "e1ancodrs", &
						 dw_lista_0.getitemstring(k_riga2, "e1ancodrs"))
						 
//			dw_barcode.setitem(k_riga1, "meca_contratto", &
//						 dw_lista_0.getitemnumber(k_riga2, "meca_contratto"))
//			dw_barcode.setitem(k_riga1, "meca_clie_3", &
//						 dw_lista_0.getitemnumber(k_riga2, "meca_clie_3"))
//			dw_barcode.setitem(k_riga1, "contratti_mc_co", &
//						 dw_lista_0.getitemstring(k_riga2, "contratti_mc_co"))
//			dw_barcode.setitem(k_riga1, "contratti_sc_cf", &
//						 dw_lista_0.getitemstring(k_riga2, "contratti_sc_cf"))
//			dw_barcode.setitem(k_riga1, "contratti_descr", &
//						 dw_lista_0.getitemstring(k_riga2, "contratti_descr"))
//			dw_barcode.setitem(k_riga1, "prodotti_des", &
//						 dw_lista_0.getitemstring(k_riga2, "prodotti_des"))
//			dw_barcode.setitem(k_riga1, "clienti_rag_soc_10", &
//						 dw_lista_0.getitemstring(k_riga2, "clienti_rag_soc_10"))
//			dw_barcode.setitem(k_riga1, "k_ricevente", &
//						 dw_lista_0.getitemstring(k_riga2, "k_ricevente"))
//		end if

end subroutine

private subroutine oldcopia_dettaglio_dw_1_da_dw_2 (ref datawindow kdw_1, ref datawindow kdw_2, integer k_riga1, integer k_riga2);//---
//--- copia i soliti dati di dettaglio di questa window (barcode, groupage, lista_0) 
//--- parametri: dw1   riceve i dati (in cui copiare)
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
		kdw_1.setitem(k_riga1, "barcode_data_lav_fin",  kdw_2.getitemdate(k_riga2, "barcode_data_lav_fin"))
			
		if kdw_1.dataobject = "dw_barcode" or kdw_2.dataobject = "dw_barcode" then
		else
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
		end if

end subroutine

private subroutine copia_dw_groupage_to_dw_lista_0 (integer k_riga1, integer k_riga2);//---
//--- copia dalla dw_lista in dw del groupage 
//--- parametri: 
//---            riga1 riga della dw1
//---            riga2 riga della dw2
//---
	
	
	
//			dw_lista_0.setitem(k_riga1, "barcode_barcode_lav",  "")
			dw_lista_0.setitem(k_riga1, "barcode_barcode", &
						 dw_groupage.getitemstring(k_riga2, "barcode_barcode"))
			dw_lista_0.setitem(k_riga1, "barcode_tipo_cicli", &
						 dw_groupage.getitemstring(k_riga2, "barcode_tipo_cicli"))
			dw_lista_0.setitem(k_riga1, "barcode_fila_1", &
						 dw_groupage.getitemnumber(k_riga2, "barcode_fila_1"))
			dw_lista_0.setitem(k_riga1, "barcode_fila_2", &
						 dw_groupage.getitemnumber(k_riga2, "barcode_fila_2"))
			dw_lista_0.setitem(k_riga1, "barcode_fila_1p", &
						 dw_groupage.getitemnumber(k_riga2, "barcode_fila_1p"))
			dw_lista_0.setitem(k_riga1, "barcode_fila_2p", &
						 dw_groupage.getitemnumber(k_riga2, "barcode_fila_2p"))
			dw_lista_0.setitem(k_riga1, "barcode_num_int", &
						 dw_groupage.getitemnumber(k_riga2, "barcode_num_int"))
			dw_lista_0.setitem(k_riga1, "barcode_data_int", &
						 dw_groupage.getitemdate(k_riga2, "barcode_data_int"))
			dw_lista_0.setitem(k_riga1, "dose", dw_groupage.getitemnumber(k_riga2, "dose"))
			dw_lista_0.setitem(k_riga1, "peso_kg", &
						 dw_groupage.getitemnumber(k_riga2, "peso_kg"))
			dw_lista_0.setitem(k_riga1, "larg_2", &
						 dw_groupage.getitemnumber(k_riga2, "larg_2"))
			dw_lista_0.setitem(k_riga1, "lung_2", &
						 dw_groupage.getitemnumber(k_riga2, "lung_2"))
			dw_lista_0.setitem(k_riga1, "alt_2", &
						 dw_groupage.getitemnumber(k_riga2, "alt_2"))
			dw_lista_0.setitem(k_riga1, "pedane", &
						 dw_groupage.getitemnumber(k_riga2, "pedane"))
			dw_lista_0.setitem(k_riga1, "campione", &
						 dw_groupage.getitemstring(k_riga2, "campione"))
			dw_lista_0.setitem(k_riga1, "art", &
						 dw_groupage.getitemstring(k_riga2, "art"))
//			dw_lista_0.setitem(k_riga1, "armo_cod_sl_pt", &
//						 dw_groupage.getitemstring(k_riga2, "armo_cod_sl_pt"))
			dw_lista_0.setitem(k_riga1, "area_mag", &
						 dw_groupage.getitemstring(k_riga2, "area_mag"))
			dw_lista_0.setitem(k_riga1, "id_armo", &
						 dw_groupage.getitemnumber(k_riga2, "id_armo"))
			dw_lista_0.setitem(k_riga1, "id_meca", &
						 dw_groupage.getitemnumber(k_riga2, "id_meca"))

			dw_lista_0.setitem(k_riga1, "e1ancodrs", &
						 dw_groupage.getitemstring(k_riga2, "e1ancodrs"))
						 
//			dw_lista_0.setitem(k_riga1, "meca_clie_2", &
//						 dw_groupage.getitemnumber(k_riga2, "clie_2"))
//			dw_lista_0.setitem(k_riga1, "prodotti_des", &
//						 dw_groupage.getitemstring(k_riga2, "des"))
//			dw_lista_0.setitem(k_riga1, "clienti_rag_soc_10", &
//						 dw_groupage.getitemstring(k_riga2, "rag_soc_10") + " " + string(dw_groupage.getitemnumber(k_riga2, "clie_2")))


end subroutine

public subroutine u_rileggi_dw_meca ();//---
//--- Rilegge completamente elenco dei Lotti da Trattare 
//---
		
	kids_meca_orig.reset()
	dw_meca.reset()
	leggi_liste()

end subroutine

public subroutine u_riempi_dettaglio (long k_riga_meca);//
//=== 
//
long k_riga
int k_rc //, kst_tab_barcode.fila_1, kst_tab_barcode.fila_2, kst_tab_barcode.fila_1p, kst_tab_barcode.fila_2p
//double k_dose
//long k_pl_barcode
st_tab_barcode kst_tab_barcode

if k_riga_meca > 0 then

//	k_riga = dw_meca.getselectedrow(0)
		
	kst_tab_barcode.id_meca = dw_meca.getitemnumber(k_riga_meca, "id_meca")	
//	k_num_int = dw_meca.getitemnumber(k_riga, "meca_num_int")	
//	k_data_int = dw_meca.getitemdate(k_riga, "meca_data_int")	
	kst_tab_barcode.fila_1 = dw_meca.getitemnumber(k_riga_meca, "barcode_fila_1")	
	kst_tab_barcode.fila_2 = dw_meca.getitemnumber(k_riga_meca, "barcode_fila_2")	
	kst_tab_barcode.fila_1p = dw_meca.getitemnumber(k_riga_meca, "barcode_fila_1p")	
	kst_tab_barcode.fila_2p = dw_meca.getitemnumber(k_riga_meca, "barcode_fila_2p")	
//	k_dose = dw_meca.getitemnumber(k_riga, "armo_dose")	
	
	k_rc = dw_barcode.reset() 
	kst_tab_barcode.pl_barcode = dw_dett_0.getitemnumber(1, "codice")

	if isnull(kst_tab_barcode.pl_barcode)  then
		kst_tab_barcode.pl_barcode = 0
	end if
	if isnull(kst_tab_barcode.fila_1) then
		kst_tab_barcode.fila_1 = 999
	end if
	if isnull(kst_tab_barcode.fila_2) then
		kst_tab_barcode.fila_2 = 999
	end if
	if isnull(kst_tab_barcode.fila_1p) then
		kst_tab_barcode.fila_1p = 999
	end if
	if isnull(kst_tab_barcode.fila_2p) then
		kst_tab_barcode.fila_2p = 999
	end if
//	if isnull(k_dose) then
//		k_dose = 0
//	end if


//--- toglie la riga dai rif. da lavorare
//	dw_meca.deleterow( dw_meca.getrow() )
	
	k_rc = dw_barcode.retrieve(kst_tab_barcode.id_meca, kst_tab_barcode.pl_barcode) 
	
	if dw_barcode.rowcount() > 0 then

//---- rimuove le righe con la fila diversa e se il barcode è già messo in elenco da trattare (kdw_lista_0) o groupage (kdw_groupage)
		for k_riga = dw_barcode.rowcount() to 1 step -1
			
			if (kst_tab_barcode.fila_1 <> 999 and dw_barcode.getitemnumber(k_riga, "barcode_fila_1") <> kst_tab_barcode.fila_1) &
					or (kst_tab_barcode.fila_1p <> 999 and dw_barcode.getitemnumber(k_riga, "barcode_fila_1p") <> kst_tab_barcode.fila_1p) &
					or (kst_tab_barcode.fila_2 <> 999 and dw_barcode.getitemnumber(k_riga, "barcode_fila_2") <> kst_tab_barcode.fila_2) &
					or (kst_tab_barcode.fila_2p <> 999 and dw_barcode.getitemnumber(k_riga, "barcode_fila_2p") <> kst_tab_barcode.fila_2p) &
					or dw_lista_0.find("barcode_barcode = '" + dw_barcode.getitemstring(k_riga, "barcode_barcode") + "' ", 0, dw_lista_0.rowcount( ) ) > 0 &
					or dw_groupage.find("barcode_barcode = '" + dw_barcode.getitemstring(k_riga, "barcode_barcode") + "' ", 0, dw_groupage.rowcount()) > 0 &
				then 
//		              or (k_dose <> 0 and dw_barcode.object.armo_dose[k_riga] <> k_dose ) &

//--- cancella barcode dall'elenco
				dw_barcode.deleterow( k_riga ) 
						
			end if 

		end for
	

//		screma_lista_barcode()
		
		if dw_barcode.rowcount() > 0 then
			dw_barcode.setcolumn(1)
			dw_barcode.setfocus()
		end if
		
	end if

end if


//--- Riempe il titolo della dw di dettaglio
if dw_barcode.rowcount() > 0 then
	dw_barcode.title = "Dettaglio Riferimento: " + string(dw_barcode.getitemnumber(1, "barcode_num_int"))
else
	dw_barcode.title = "Dettaglio Riferimento " 
end if


end subroutine

public function boolean if_lotto_associato (ref st_tab_meca ast_tab_meca) throws uo_exception;//
//--- Controllo se Lotto gia' associato in WMF/E1
//--- inp: st_tab_meca.id
//--- torna: TRUE=associato
boolean k_return=false

	
try
	
	if ki_e1_enabled then
		
		//--- 031017 nella fase iniziale di passaggio a E1 meglio forzare a ASSOCIATI quelli precedenti
		if ast_tab_meca.data_int < kkg.DATA_START_E1 then
			k_return = true
		else
//			if kiuf_armo.if_lotto_pianificato(ast_tab_meca) then  // se qlc barcode del Lotto già messo in pianificazione allora significa già ASSOCIATO!
//				k_return = true
//			else
//		//--- controllo su E1 se lotto ASSOCIATO		
//		
//				if kiuf_e1_asn.kids_e1_asn_x_schedule_l.find( "waapid = '" + string(ast_tab_meca.id) + "'", 1, kiuf_e1_asn.kids_e1_asn_x_schedule_l.rowcount( ) ) > 0 then
//					k_return = true
//				end if
//			end if
		
			k_return = kiuf_armo.if_lotto_associato(ast_tab_meca)
		end if

	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally

end try
			
return k_return
end function

public subroutine old_set_flag_lotto_wm_associato () throws uo_exception;//
//--- Set del flag per i Lotti Associati (barcode di lav - barcode cliente)
//
long k_riga=0
kuf_armo kuf1_armo
st_tab_meca kst_tab_meca


try

	kuf1_armo = create kuf_armo

	for k_riga = 1 to dw_meca.rowcount( ) 

		kst_tab_meca.id = dw_meca.getitemnumber(k_riga, "id_meca")
		
		if not kuf1_armo.if_lotto_associato(kst_tab_meca) then
		
			dw_meca.setitem(k_riga, "k_wm_associato", "N")
		else
			dw_meca.setitem(k_riga, "k_wm_associato", "A")
			
		end if
	end for
	
catch (uo_exception kuo_exception)
	throw kuo_exception
		
finally
	if isvalid(kuf1_armo) then destroy kuf1_armo

end try

	
end subroutine

public subroutine old_set_flag_lotto_e1_associato () throws uo_exception;//
//--- Set del flag per i Lotti Associati (barcode di lav - barcode cliente)
//
long k_riga=0, k_asn_righe, k_asn_find
st_tab_meca kst_tab_meca


try

	//--- se E1 è abilitato i Lotti devono essere nello stato 20 per essere abilitati al trattamento 
	k_asn_righe = kiuf_e1_asn.u_get_ready_to_schedule()


	for k_riga = 1 to dw_meca.rowcount( ) 

		kst_tab_meca.id = dw_meca.getitemnumber(k_riga, "id_meca")
		kst_tab_meca.data_int = dw_meca.getitemdate(k_riga, "meca_data_int")
		
		//--- 031017 nella fase iniziale di passaggio a E1 meglio forzare a ASSOCIATI quelli precedenti
		if kst_tab_meca.data_int < kkg.DATA_START_E1 then
			dw_meca.setitem(k_riga, "k_wm_associato", "A")
		else		
			if kiuf_armo.if_lotto_pianificato(kst_tab_meca) then  // se qlc barcode del Lotto già messo in pianificazione allora significa già ASSOCIATO!
				dw_meca.setitem(k_riga, "k_wm_associato", "A")
			else
		//--- controllo si E1 se lotto ASSOCIATO		
				k_asn_find = kiuf_e1_asn.kids_e1_asn_x_schedule_l.find( "waapid = '" + string(kst_tab_meca.id) + "'", 1, k_asn_righe)
				if k_asn_find > 0 then
					dw_meca.setitem(k_riga, "k_wm_associato", "A")
				else
					dw_meca.setitem(k_riga, "k_wm_associato", "N")
				end if
			end if
		end if
	end for
	
catch (uo_exception kuo_exception)
	throw kuo_exception
		
finally

end try

	
end subroutine

protected function string aggiorna_dati ();//
string k_return = "0 "


try
	dw_dett_0.accepttext()
	if dw_dett_0.rowcount() > 0 then
	
	//--- Aggiornamento dei dati inseriti/modificati
		k_return = super::aggiorna_dati()

	end if
	
catch (uo_exception kuo_exception)
	
end try

return k_return 

end function

protected subroutine attiva_tasti_0 ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati

//=========================================================================
st_tab_pl_barcode kst_tab_pl_barcode
kuf_pl_barcode kuf1_pl_barcode

//--- lancia la funzione ereditata
super::attiva_tasti_0( )

cb_modifica.enabled = false
cb_visualizza.enabled = false
//cb_file.enabled = false


if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento &
   or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
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



end subroutine

public subroutine u_obj_visible_0 ();//
dw_meca.visible = true
dw_barcode.visible = true
dw_groupage.visible = true
dw_lista_0.visible = true

end subroutine

public function boolean u_resize_predefinita ();//---
int k_dist_bordi, k_spess_bordi_x, k_spess_bordi_y

	this.setredraw(false)
//	
////--- dimensione+posizione box delle Proprietà
//	if ki_st_open_w.flag_primo_giro = "S" then
//		dw_dett_0.width = 2600
//		dw_dett_0.height = 1000
//		dw_dett_0.x = (this.width - dw_dett_0.width) / 2
//		dw_dett_0.y = (this.height - dw_dett_0.height) / 2
//	end if
//	
//	if ki_st_open_w.flag_adatta_win = KKG.ADATTA_WIN &
//						and not(ki_personalizza_pos_controlli) &
//		then

		
		k_dist_bordi = 5
		k_spess_bordi_x = 0 //145
		k_spess_bordi_y = 0 //210 //180
		
		dw_meca.width = this.width * 0.62 
//		dw_dett_0.width = this.width - dw_meca.width - k_dist_bordi * 3 - k_spess_bordi_x
		dw_barcode.width = dw_meca.width * 0.57 
		dw_lista_0.width = this.width - dw_meca.width - k_dist_bordi * 3 - k_spess_bordi_x 
		dw_groupage.width = this.width - dw_barcode.width - dw_lista_0.width - k_dist_bordi * 3 - k_spess_bordi_x
	
		dw_meca.height = this.height * 0.53
		dw_barcode.height = this.height - dw_meca.height - k_dist_bordi * 3 - k_spess_bordi_y
		dw_groupage.height = dw_barcode.height 
	
		//dw_dett_0.height = this.height * 0.23 
		dw_lista_0.height = this.height - k_dist_bordi * 3 - k_spess_bordi_y
	
//=== Posiziona dw nella window 
		dw_meca.x = 5
		dw_meca.y = 5
		dw_barcode.x = dw_meca.x
		dw_barcode.y = dw_meca.height + k_dist_bordi 
		dw_groupage.x = dw_meca.x + dw_barcode.width + k_dist_bordi
		dw_groupage.y = dw_meca.height + k_dist_bordi 

		//dw_dett_0.x = dw_meca.x + dw_meca.width + k_dist_bordi
		//dw_dett_0.y = dw_meca.y 
		dw_lista_0.x = dw_meca.x + dw_meca.width + k_dist_bordi
		dw_lista_0.y = k_dist_bordi  //dw_dett_0.height + k_dist_bordi 
		
		
		
//	end if

	this.setredraw(true)

return TRUE

end function

private subroutine u_check_troppi_barcode ();//---
//--- Verifica se ci sono troppi bacode in programmazione
//---
int k_max_barcode = 300, k_n_barcode_presenti


k_n_barcode_presenti =  dw_lista_0.rowcount( )

if k_n_barcode_presenti > k_max_barcode then
	messagebox("Avvertimento",  string( k_n_barcode_presenti) + " barcode inseriti sembrano troppi. Il Programma " + &
	               	"rischia di non essere caricato in Impianto. Si consiglia di Chiuderlo e di proseguire " + &
					"la programmazione con un nuovo Programma.", stopsign!)
end if

	
end subroutine

public subroutine u_resize_1 ();//
//--- evita evento padre
//
end subroutine

on w_pl_barcode_dett.create
int iCurrent
call super::create
this.cb_chiudi=create cb_chiudi
this.cb_togli=create cb_togli
this.cb_aggiungi=create cb_aggiungi
this.cb_file=create cb_file
this.dw_modifica=create dw_modifica
this.dw_groupage=create dw_groupage
this.dw_barcode=create dw_barcode
this.dw_meca=create dw_meca
this.dw_periodo=create dw_periodo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_chiudi
this.Control[iCurrent+2]=this.cb_togli
this.Control[iCurrent+3]=this.cb_aggiungi
this.Control[iCurrent+4]=this.cb_file
this.Control[iCurrent+5]=this.dw_modifica
this.Control[iCurrent+6]=this.dw_groupage
this.Control[iCurrent+7]=this.dw_barcode
this.Control[iCurrent+8]=this.dw_meca
this.Control[iCurrent+9]=this.dw_periodo
end on

on w_pl_barcode_dett.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_chiudi)
destroy(this.cb_togli)
destroy(this.cb_aggiungi)
destroy(this.cb_file)
destroy(this.dw_modifica)
destroy(this.dw_groupage)
destroy(this.dw_barcode)
destroy(this.dw_meca)
destroy(this.dw_periodo)
end on

event timer;call super::timer;////
//
//dw_lista_0.title = Mid(dw_lista_0.title,2) + Left(dw_lista_0.title,1) 
//dw_groupage.title = Mid(dw_groupage.title,2) + Left(dw_groupage.title,1) 
//
end event

event close;call super::close;//

//=== Salva le righe del dw (saveas)
//kGuf_data_base.dw_saveas("no_pl", dw_meca)


//--- disattivo il timer
timer( 0 )
//dw_meca.accepttext( )


//--- registra la data piu' indietro su BASE cosi' da recuperarla al pross. giro 
set_base_data_ini()


if isvalid(kids_meca_orig) then destroy kids_meca_orig
if isvalid(kiuf1_pl_barcode) then destroy kiuf1_pl_barcode								
if isvalid(kiuf_armo) then destroy kiuf_armo								
if isvalid(kiuf_e1_asn) then destroy kiuf_e1_asn


end event

event rbuttondown;//
string k_stringa=""
long k_riga=0
string k_tag_old=""
string k_tag=""
m_popup m_menu


//---
		attiva_menu( )
		
//--- Se sono sulla lista con il mouse allora posiziono il punt sul rek puntato

//--- Salvo il Tag attuale per reimpostarlo a fine routine
		k_tag_old = this.tag
		this.tag = " "

//--- Creo menu Popup 
		m_menu = create m_popup

		m_menu.m_pop_lib_1.text = "Rilettura elenco veloce "
		m_menu.m_pop_lib_1.enabled = true
		m_menu.m_pop_lib_1.visible = true
		m_menu.m_t_pop_lib_1.visible = true
		
		m_menu.m_lib_1.text = ki_menu.m_strumenti.m_fin_gest_libero1.text 
		m_menu.m_lib_1.visible = ki_menu.m_strumenti.m_fin_gest_libero1.visible
		m_menu.m_lib_1.enabled = ki_menu.m_strumenti.m_fin_gest_libero1.enabled
//
		m_menu.m_lib_2.text = ki_menu.m_strumenti.m_fin_gest_libero2.text 
		m_menu.m_lib_2.visible = ki_menu.m_strumenti.m_fin_gest_libero2.visible
		m_menu.m_lib_2.enabled = ki_menu.m_strumenti.m_fin_gest_libero2.enabled
//
		m_menu.m_lib_3.text = ki_menu.m_strumenti.m_fin_gest_libero3.text 
		m_menu.m_lib_3.visible = ki_menu.m_strumenti.m_fin_gest_libero3.visible
		m_menu.m_lib_3.enabled = ki_menu.m_strumenti.m_fin_gest_libero3.enabled
//
		m_menu.m_lib_4.text = ki_menu.m_strumenti.m_fin_gest_libero4.text 
		m_menu.m_lib_4.visible = ki_menu.m_strumenti.m_fin_gest_libero4.visible
		m_menu.m_lib_4.enabled = ki_menu.m_strumenti.m_fin_gest_libero4.enabled
		m_menu.m_t_lib_4.visible = m_menu.m_lib_4.visible

		m_menu.m_inserisci.visible = cb_inserisci.enabled
		m_menu.m_modifica.visible = cb_modifica.enabled
		m_menu.m_t_modifica.visible = cb_modifica.enabled
		m_menu.m_cancella.visible = cb_cancella.enabled
		m_menu.m_t_cancella.visible = cb_cancella.enabled
		m_menu.m_visualizza.visible = cb_visualizza.enabled

		m_menu.m_agglista.visible = true
		m_menu.m_t_agglista.visible = true

		m_menu.m_stampa.visible = st_stampa.enabled
		m_menu.m_t_stampa.visible = st_stampa.enabled
		m_menu.m_conferma.visible = cb_aggiorna.enabled
		m_menu.m_ritorna.visible = true

//--- Attivo il menu Popup
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
st_tab_pl_barcode kst_tab_pl_barcode
st_tab_barcode kst_tab_barcode



if isvalid(kst_open_w) then

//--- Dalla finestra di Elenco Valori
	if kst_open_w.id_programma = kkg_id_programma_elenco and long(kst_open_w.key3) > 0 then
	
//--- vale solo se sono in aggiornamento	
 		if ki_st_open_w.flag_modalita =  kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then

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
				case  "d_barcode_l_rid" //dw_lista_0.dataobject
					kdsi_elenco_input = kst_open_w.key12_any 
				
					if kdsi_elenco_input.rowcount() > 0 then
						kst_tab_barcode.barcode = kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "barcode")
						aggiungi_barcode_padre(kst_tab_barcode)
						u_check_troppi_barcode( )
					end if


				case "d_pl_barcode_dett_1"
					kdsi_elenco_input = kst_open_w.key12_any 
				
					if kdsi_elenco_input.rowcount() > 0 then
						kst_tab_barcode.barcode = kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "barcode_barcode")
						aggiungi_barcode_padre(kst_tab_barcode)
						u_check_troppi_barcode( )
					end if
					
							
			end choose
		end if

	end if

end if
//


end event

event deactivate;call super::deactivate;//
//--- Disattivo il timer 
//	timer( 0 )
//

end event

event activate;call super::activate;//--- attivo il timer ogni mezzo secondo	
//	timer( 0.5 )
//

end event

type st_ritorna from w_g_tab0`st_ritorna within w_pl_barcode_dett
integer x = 37
integer y = 256
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_pl_barcode_dett
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_pl_barcode_dett
integer x = 1664
integer y = 724
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


	dw_dett_0.accepttext()

	k_return = aggiorna_dati( )
	
	if Left(k_return, 1) = "0" then
		dw_lista_0.resetupdate()
		dw_groupage.resetupdate()
		dw_dett_0.resetupdate()
		ki_lista_0_modifcato = false
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
integer x = 873
integer y = 872
integer width = 2587
integer height = 936
integer taborder = 10
boolean enabled = true
boolean titlebar = true
string title = "Proprieta~'  Piano di Lavorazione"
string dataobject = "d_pl_barcode_testa_1"
boolean controlmenu = true
boolean hsplitscroll = false
boolean ki_colora_riga_aggiornata = false
boolean ki_d_std_1_attiva_sort = false
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
			
		case "b_chiudi"
			cb_chiudi.event clicked( ) //postevent(clicked!)
			this.visible = false

	end choose

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
end try

	
end event

event dw_dett_0::getfocus;//
//--- evitare lo script standard
//
 attiva_tasti( ) 
 
end event

event dw_dett_0::clicked;//

end event

type st_orizzontal from w_g_tab0`st_orizzontal within w_pl_barcode_dett
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_pl_barcode_dett
event ue_mousemove pbm_mousemove
integer x = 1797
integer y = 0
integer width = 1755
integer height = 1404
integer taborder = 20
boolean titlebar = true
string title = "Pianificazione irraggiamento - Trascina qui il Riferimento o Barcode."
string dataobject = "d_pl_barcode_dett_1"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
boolean ki_colora_riga_aggiornata = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_attiva_dragdrop = true
boolean ki_in_drag = true
end type

event dw_lista_0::dragdrop;call super::dragdrop;//
datawindow kdw_1
string k_nome




CHOOSE CASE TypeOf(source)

	CASE datawindow!

   	kdw_1 = source
		kdw_1.Drag(cancel!)

		if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica or ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then

			choose case kdw_1.classname()
					
				case "dw_meca" 
					aggiungi_barcode_tutti(dw_lista_0)
					u_check_troppi_barcode( )
	
				case "dw_barcode" 
					aggiungi_barcode_singolo(dw_lista_0, dw_barcode)
					u_check_troppi_barcode( )
					
				case "dw_groupage" 
					aggiungi_barcode_singolo(dw_lista_0, dw_groupage)
					u_check_troppi_barcode( )
					
				case "dw_lista_0" 
//--- sistema il codice e i progressivi nella lista
					imposta_codice_progr( kdw_1 )
					attiva_tasti()
				
			end choose
			
		end if
		
		ki_dragdrop = false
		
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
attiva_tasti( ) 
end event

event dw_lista_0::rowfocuschanged;//
if not ki_dragdrop then
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

event dw_lista_0::ue_lbuttondown;call super::ue_lbuttondown;//
if this.ki_attiva_DRAGDROP then
	ki_dragdrop = true
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


if dw_dett_0.rowcount( ) > 0 then

	if dw_lista_0.rowcount() <= 0 and dw_groupage.rowcount() <= 0 then
		messagebox("Operazione fallita", &
					"Nessun Barcode immesso nella pianificazione.~n~r" + &
					"~n~r" )

	else


		dw_dett_0.accepttext()
		dw_lista_0.accepttext()

		if cb_chiudi.enabled then
			cb_chiudi.enabled = false
	
				
			if ki_chiudi_PL_enabled then
				if ki_PL_chiuso then   
	
					k_elaborazione_ok = apri_pl()  // RIAPRE IL PIANO
					
				else
				
					k_data_chiuso = dw_dett_0.getitemdate ( 1, "data_chiuso") 
					if isnull(k_data_chiuso) or k_data_chiuso <= date(0) then
						k_dataoggi = kg_dataoggi
						dw_dett_0.setitem (1, "data_chiuso", k_dataoggi)
					end if
				
					k_elaborazione_ok = chiudi_pl()    // CHIUDE IL PIANO DI LAVORAZIONE
						
				end if
						
				if k_elaborazione_ok = 0 then
	
					kiuf1_sync_window.u_window_set_funzione_aggiornata(ki_st_open_w) // setta x sicronizzare il ritorno
					
					if ki_PL_chiuso then 
						messagebox("Operazione Conclusa", "Il Piano di Lavorazione è stato Riaperto correttamente.")
						
						smista_funz( KKG_FLAG_RICHIESTA.esci )  // Esce!
	//						ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica
					else
						ki_chiudi_PL_enabled = false
						ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
						ki_st_open_w.key1 = string( dw_dett_0.getitemnumber(1, "codice")) 
				
						proteggi_campi()
						
						inizializza() 
						//attiva_tasti ()
					end if
					
				end if
			else
				messagebox("Operazione non Autorizzata", &
					"Utente non autorizzato al Chiudere/Riaprire il Piano di Lavorazione.~n~r" + &
					"~n~r" )
				
			end if
		end if
	end if
end if

cb_chiudi.enabled = true


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

	if kGuf_data_base.u_getfocus_nome() = "dw_lista_0" then
		
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
		if kGuf_data_base.u_getfocus_nome() = "dw_lista_0" then
			aggiungi_barcode_singolo(dw_lista_0, dw_barcode)
			u_check_troppi_barcode( )
		else
			aggiungi_barcode_singolo(dw_groupage, dw_barcode)
		end if
		dw_barcode.setfocus( ) 
	else
		if dw_meca.getselectedrow(0) > 0 then
			if kGuf_data_base.u_getfocus_nome() = "dw_lista_0" then
				aggiungi_barcode_tutti(dw_lista_0)
				u_check_troppi_barcode( )
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
integer y = 1148
integer width = 3479
integer height = 688
integer taborder = 100
boolean bringtotop = true
boolean enabled = true
boolean ki_link_standard_sempre_possibile = true
boolean ki_colora_riga_aggiornata = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_d_std_1_attiva_cerca = false
end type

event resize;//

end event

event ue_mostra_aggiornamenti_dw;call super::ue_mostra_aggiornamenti_dw;//
u_rileggi_dw_meca( )
end event

type dw_groupage from uo_d_std_1 within w_pl_barcode_dett
integer x = 1157
integer y = 1184
integer width = 869
integer height = 832
integer taborder = 50
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string title = "Groupage trascina il barcode per identificarlo come Figlio"
string dataobject = "d_pl_barcode_dett_grp_all"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
boolean hsplitscroll = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_attiva_dragdrop = true
end type

event ue_lbuttondown;call super::ue_lbuttondown;//
ki_dw_fuoco_nome = this.dataobject
//
if this.ki_attiva_DRAGDROP then
	ki_dragdrop = true
end if

end event

event ue_lbuttonup;call super::ue_lbuttonup;////
//	k_dragdrop = false
//	this.drag(cancel!)
//	
//
end event

event dragdrop;call super::dragdrop;//
datawindow kdw_1
string k_nome

CHOOSE CASE TypeOf(source)

	CASE datawindow!

		kdw_1 = source
	 
		if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica or ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
			
			choose case kdw_1.classname()
					
				case "dw_meca"  
					aggiungi_grp_rif_intero(dw_groupage)
	
				case "dw_barcode" 
					aggiungi_grp_barcode_singolo(dw_barcode)
					
				case "dw_lista_0" 
					aggiungi_grp_barcode_singolo(dw_lista_0)
					
			end choose
			
		end if
		ki_dragdrop = false
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

attiva_tasti( ) 
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
   ki_dw_fuoco_nome = this.dataobject

end if


//
	if dwo.name = "scegli_padre" or dwo.name = "img_b_scegli_padre"  then
		post scegli_padre_da_dw_lista(row)
	end if

//
end event

event itemchanged;call super::itemchanged;//
attiva_tasti ()

end event

type dw_barcode from uo_d_std_1 within w_pl_barcode_dett
integer x = 59
integer y = 1064
integer width = 1390
integer taborder = 30
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string title = "Dettaglio Riferimento"
string dataobject = "d_barcode_l_no_pl"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
boolean hsplitscroll = false
boolean ki_link_standard_attivi = false
boolean ki_colora_riga_aggiornata = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_attiva_dragdrop = true
end type

event ue_lbuttondown;call super::ue_lbuttondown;//
ki_dw_fuoco_nome = this.dataobject
//
if this.ki_attiva_DRAGDROP then
	ki_dragdrop = true
end if

end event

event ue_lbuttonup;call super::ue_lbuttonup;////
//	k_dragdrop = false
//	this.drag(cancel!)
//	
//
end event

event u_doppio_click;//
if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica or ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
	aggiungi_barcode_singolo(dw_lista_0, dw_barcode )
	u_check_troppi_barcode( )
end if



end event

event dragdrop;call super::dragdrop;//
long k_riga
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
					k_riga = kdw_1.getselectedrow(0)
					u_riempi_dettaglio(k_riga)
	//--- toglie la riga dai rif. da lavorare
	//				dw_meca.deleterow(k_riga)
				end if
			end if
		end if
			
		
		ki_dragdrop = false
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

 attiva_tasti( ) 
end event

event losefocus;call super::losefocus;//
if this.rowcount() > 0 then
	this.title = "Dettaglio Riferimento: " + string(this.getitemnumber(1, "barcode_num_int"))
else
	this.title = "Dettaglio Riferimento " 
end if

end event

event rowfocuschanged;//

if ki_dragdrop = false then
	
	super::EVENT rowfocuschanged(currentrow)

end if

end event

event clicked;call super::clicked;//
//--- scompare la dw_modifica se perdo il fuoco
//
	dw_modifica.visible = false
   ki_dw_fuoco_nome = this.dataobject
 

end event

type dw_meca from uo_d_std_1 within w_pl_barcode_dett
event ue_lbuttondown_postold ( )
integer x = 5
integer width = 2103
integer height = 1040
integer taborder = 40
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string title = "Elenco Riferimenti senza P.L."
string dataobject = "d_meca_barcode_elenco_no_lav"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
boolean ki_attiva_dragdrop = true
end type

event ue_lbuttondown_postold();//
long k_ctr


		k_ctr = this.getselectedrow( 0 )
		
		//--- flags = 1 pulsante sinistro pigiato 
		if k_ctr > 0 and (ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica) then
		
			k_ctr = this.getselectedrow( 0 )
			
			if this.getselectedrow( k_ctr ) > 0 then
				//this.dragicon = kGuo_path.get_risorse() + "\drag2.ico" 
				this.dragicon = "drag2.ico" 
			else		
				this.dragicon = "drag1.ico"
			end if
			
			ki_dragdrop = true
			this.drag(begin!)
		end if

end event

event ue_lbuttondown;call super::ue_lbuttondown;//
ki_dw_fuoco_nome = this.dataobject
//
if this.ki_attiva_DRAGDROP then
	ki_dragdrop = true
end if

end event

event dragdrop;call super::dragdrop;//
datawindow kdw_1


CHOOSE CASE TypeOf(source)

	CASE datawindow!

   	kdw_1 = source

END CHOOSE

if ki_dragdrop then
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

ki_dragdrop = false
//source.Drag(cancel!)

this.setcolumn(1)


end event

event getfocus;call super::getfocus;////
//
//this.icon = "Exclamation!"
//

kidw_selezionata = this

dw_barcode.SelectRow(0, FALSE)

//
//attiva_menu( )
attiva_tasti( ) 
end event

event rowfocuschanged;//

if ki_dragdrop = false then
	
	super::EVENT rowfocuschanged(currentrow)

end if

end event

event u_doppio_click;//
long k_riga


	k_riga = this.getrow()
	u_riempi_dettaglio(k_riga)
//	this.deleterow(k_riga)

end event

event losefocus;call super::losefocus;//
this.accepttext( )
//attiva_menu( )

end event

event clicked;//
//--- scompare la dw_modifica se perdo il fuoco
//
long k_riga= 0



   ki_dw_fuoco_nome = this.dataobject
	dw_modifica.visible = false


	if dwo.name = "grp" then
		
//		super::event ue_selectrow (row)
		k_riga = this.u_selectrow(row)
		if k_riga > 0 then this.setrow(k_riga)
		
		post call_elenco_grp()
		
	else
		
		super::event clicked( xpos, ypos, row, dwo)
		
	end if
	
	
end event

event ue_dwnkey;call super::ue_dwnkey;//
if key = keyF12! then
	
	smista_funz( KKG_FLAG_RICHIESTA.libero3 )  // attiva/disattiva Lotto "in Attenzione"
	
end if

end event

event itemchanged;call super::itemchanged;//
//
st_tab_meca kst_tab_meca


choose case dwo.name 

	case "meca_consegna_data" 

		kst_tab_meca.id = this.getitemnumber(row, "id_meca")
		kst_tab_meca.consegna_data = this.getitemdate(row, string(dwo.name))
		post u_aggiorna_data_consegna(kst_tab_meca, row)		

end choose
end event

type dw_periodo from uo_d_std_1 within w_pl_barcode_dett
integer y = 848
integer width = 955
integer height = 504
integer taborder = 70
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
	this.object.data_al.Background.Color=kkg_colore.CAMPO_DISATTIVO
	this.object.data_al.TabSequence='0'
	this.visible = true
	this.setfocus()
	
end event

