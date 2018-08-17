$PBExportHeader$w_lotto.srw
forward
global type w_lotto from w_g_tab_3
end type
type dw_x_copia from uo_d_std_1 within w_lotto
end type
type dw_riga from uo_d_sped_riga within w_lotto
end type
end forward

global type w_lotto from w_g_tab_3
integer width = 4672
integer height = 3196
string title = "Documento "
boolean ki_toolbar_window_presente = true
boolean ki_esponi_msg_dati_modificati = false
boolean ki_sincronizza_window_consenti = false
boolean ki_fai_nuovo_dopo_update = false
boolean ki_fai_nuovo_dopo_insert = false
boolean ki_msg_dopo_update = false
dw_x_copia dw_x_copia
dw_riga dw_riga
end type
global w_lotto w_lotto

type variables
//
private kuf_armo kiuf_armo 	
private kuf_armo_nt kiuf_armo_nt 	
private kuf_armo_checkmappa kiuf_armo_checkmappa
private kuf_listino kiuf_listino
private kuf_contratti kiuf_contratti
private kuf_barcode_ini kiuf_barcode_ini
private kuf_ausiliari kiuf_ausiliari
private st_tab_meca kist_tab_meca, kist_tab_meca_orig
//private st_tab_armo kist_tab_armo, kist_tab_armo_orig

private boolean ki_stato_orig=false // campo con lo stato originale  
private boolean ki_lotto_pianificato=false
private boolean ki_lotto_spedito=false
//private boolean ki_armo_nt[]
//private st_tab_armo_nt kist_tab_armo_nt[]

//private kuf_sped kiuf_sped
//private st_tab_sped kist_tab_sped, kist_tab_sped_orig
private kuf_armo_inout kiuf_armo_inout

//private datastore kids_elenco_da_sped
private datastore kids_elenco_mrf
private datastore kids_elenco_mand

//kuf_report_merce_da_sped kiuf_report_merce_da_sped

private kuf_clienti kiuf_clienti  
private kuf_prodotti kiuf_prodotti

//private datastore kids_elenco_lotti
private datastore kids_elenco_input

//--- progressivo righe dettaglio, serve x identificare una riga quando sono in 'modfica'
//private int ki_progressivo_riga = 0

private st_tab_base kist_tab_base

private boolean ki_riga_rimossaxelencolotti=false
end variables

forward prototypes
protected function string aggiorna ()
protected subroutine attiva_tasti ()
protected function integer cancella ()
protected function string dati_modif (string k_titolo)
protected function string inizializza ()
protected function integer inserisci ()
protected subroutine pulizia_righe ()
protected subroutine riempi_id ()
protected subroutine open_start_window ()
protected subroutine attiva_menu ()
protected subroutine smista_funz (string k_par_in)
public function boolean get_dati_cliente (ref st_tab_clienti kst_tab_clienti)
private subroutine riga_modifica ()
protected subroutine inizializza_3 () throws uo_exception
private subroutine dragdrop_dw_esterna (uo_d_std_1 kdw_source, long k_riga)
public subroutine set_iniz_dati_cliente (ref st_tab_clienti kst_tab_clienti)
public subroutine set_dw_clienti_child ()
private subroutine run_app_lettera ()
protected function string check_dati ()
private function integer get_totale_colli ()
public subroutine u_allarme_lotto (st_tab_meca ast_tab_meca) throws uo_exception
public subroutine u_allarme_cliente (readonly st_tab_clienti ast_tab_clienti) throws uo_exception
private subroutine call_elenco_causali ()
private subroutine call_elenco_mandanti ()
private subroutine call_elenco_mrf ()
private subroutine put_video_clie_2 (st_tab_clienti kst_tab_clienti)
private subroutine put_video_clie_3 (st_tab_clienti kst_tab_clienti)
public subroutine u_inizializza (st_tab_meca ast_tab_meca)
private subroutine call_art_x_contratto ()
private subroutine riga_modifica_display_art (st_tab_armo kst_tab_armo, st_tab_prodotti kst_tab_prodotti)
private subroutine call_contratti_x_clie_1 ()
protected subroutine inizializza_4 () throws uo_exception
private function integer riga_nuova_in_lista (ref st_tab_armo ast_tab_armo, st_tab_armo_nt ast_tab_armo_nt) throws uo_exception
private function integer riga_modifica_in_lista (long a_riga, st_tab_armo ast_tab_armo, st_tab_prodotti ast_tab_prodotti, st_tab_armo_nt ast_tab_armo_nt) throws uo_exception
private subroutine put_video_clie_1 (st_tab_clienti ast_tab_clienti)
private function integer riga_gia_presente (st_tab_armo ast_tab_armo)
private subroutine riga_display_in_lista (integer a_riga, st_tab_armo ast_tab_armo, st_tab_prodotti ast_tab_prodotti, st_tab_armo_nt ast_tab_armo_nt) throws uo_exception
private subroutine call_art_x_no_contratto ()
private function boolean u_if_mrf_ok (st_tab_meca ast_tab_meca)
public subroutine u_genera_barcode ()
protected subroutine u_inizializza_3 () throws uo_exception
protected subroutine u_inizializza_4 () throws uo_exception
protected subroutine u_aggiorna () throws uo_exception
private function integer u_get_nr_colli_xbcode ()
private subroutine set_id_causale_da_contratto () throws uo_exception
private subroutine set_ricevente_fatturato () throws uo_exception
private subroutine set_contratto (st_tab_contratti ast_tab_contratti) throws uo_exception
private subroutine set_causale_lotto (st_tab_meca_causali ast_tab_meca_causali)
private subroutine set_dati_causale (st_tab_meca_causali ast_tab_meca_causali) throws uo_exception
private subroutine set_id_causale_da_clie_3 () throws uo_exception
private subroutine u_dw_riga_ricalcolo_1 (ref st_tab_armo ast_tab_armo, st_tab_listino ast_tab_listino)
private subroutine u_dw_riga_ricalcolo (ref st_tab_armo ast_tab_armo)
end prototypes

protected function string aggiorna ();//
//======================================================================
//=== Aggiorna tabelle 
//=== Ritorna 1 chr : 0=tutto OK; >0=errore grave I-O;
//===		dal char 2 in poi spiegazione dell'errore
//======================================================================

string k_return="0 "
st_esito kst_esito


try
	setpointer(kkg.pointer_attesa) 

	tab_1.selecttab(1)

	u_aggiorna()			// Lancia AGGIORNAMENTO su db

catch (uo_exception kuo_execption)
	setpointer(kkg.pointer_default)
	kst_esito = kuo_execption.get_st_esito()
	k_return = trim(kst_esito.esito) + trim(kst_esito.sqlerrtext)
	messagebox("Aggiornamento non Completatato", "Errore durante aggiornamento archivi" +"~n~r"+ trim(kst_esito.sqlerrtext))

finally
	attiva_tasti()
	setpointer(kkg.pointer_default)

end try


return k_return

end function

protected subroutine attiva_tasti ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================


super::attiva_tasti()

tab_1.tabpage_2.enabled = false
tab_1.tabpage_3.enabled = false
tab_1.tabpage_4.enabled = false

//=== Nr righe ne DW lista
if tab_1.tabpage_1.dw_1.rowcount() > 0 then

	if tab_1.tabpage_1.dw_1.getitemnumber(1, "clie_1") > 0 then
		tab_1.tabpage_4.enabled = true
	end if
	
	choose case ki_tab_1_index_new  //tab_1.selectedtab
		case 1, 5
			cb_aggiorna.enabled = true
		case 4 //righe
			if tab_1.tabpage_4.dw_4.rowcount( ) > 0 then
				cb_aggiorna.enabled = true
				cb_modifica.enabled = true
				cb_visualizza.enabled = true
				cb_cancella.enabled = not ki_lotto_pianificato
				cb_inserisci.enabled = true
			end if
	end choose

else
	
	cb_inserisci.enabled = true
	cb_inserisci.default = true
	
end if

if ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione or ki_st_open_w.flag_modalita = kkg_flag_modalita.cancellazione then
	cb_inserisci.enabled = false
	cb_aggiorna.enabled = false
	cb_cancella.enabled = false
	cb_modifica.enabled = false
end if

attiva_menu()

if tab_1.tabpage_4.enabled then
	tab_1.tabpage_4.text = "righe " + string(tab_1.tabpage_4.dw_4.rowcount())
else
	tab_1.tabpage_4.text = "righe "
end if
if tab_1.tabpage_5.enabled then
	tab_1.tabpage_5.text = "barcode " + string(tab_1.tabpage_5.dw_5.rowcount())
else
	tab_1.tabpage_5.text = "barcode "
end if



end subroutine

protected function integer cancella ();//
//=== Cancellazione rekord dal DB
//=== Ritorna : 0=OK 1=KO 2=non eseguita
//
int k_return=0
string k_record, k_record_1
string k_errore = "0 ", k_errore1 = "0 ", k_nro_fatt
long k_riga=0, k_seq, k_ctr, k_nr_barcode=0
st_tab_meca kst_tab_meca
st_tab_armo_nt kst_tab_armo_nt
st_tab_barcode kst_tab_barcode
st_esito kst_esito


try
	
	if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then
		kst_tab_meca.id = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_meca")
		
		choose case ki_tab_1_index_new
			case 1 
				k_record = " LOTTO  "
				k_riga = tab_1.tabpage_1.dw_1.getrow()	
				if k_riga > 0 then
					if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> new!  &
							and tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
						kst_tab_meca.num_int = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "num_int")
						kst_tab_meca.data_int = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "data_int")
						k_record_1 = &
							"Sei sicuro di voler eliminare il Riferimento~n~r" + &
							"numero " + string(kst_tab_meca.num_int, "#######") +  &
							" del " + string(kst_tab_meca.data_int) + " (id=" + string(kst_tab_meca.id) + ") ?"
					else
						tab_1.tabpage_1.dw_1.deleterow(k_riga)
						k_riga = 0
					end if
				end if
				
			case 4
				k_record = " Articolo "
				k_riga = tab_1.tabpage_4.dw_4.getselectedrow(0)	
				k_nr_barcode = 0
				kst_tab_barcode.id_armo = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_armo")
				if kst_tab_barcode.id_armo > 0 then 
					k_nr_barcode = kiuf_barcode_ini.get_nr_barcode_x_id_armo(kst_tab_barcode)
					if k_nr_barcode > 0 then
						k_record_1 = &
							"La rimozione della riga distrugge anche " + string(k_nr_barcode) + " Barcode " &
							+ "~n~rRimuoverli fisicamente se già affissi ai pallet. !! " 
					end if
				end if
		end choose	
		
	end if
	
	
	//=== Se righe in lista
	if k_riga > 0  then
		
	//=== Cancella la riga dal data windows di lista
		choose case ki_tab_1_index_new 
				
			case 1 
	//=== Richiesta di conferma della eliminazione del rek
				if messagebox("Elimina" + k_record, k_record_1, question!, yesno!, 2) = 1 then
					kst_tab_meca.st_tab_g_0.esegui_commit = "N"
					kst_esito = kiuf_armo.tb_delete_riferimento( kst_tab_meca )   // CANCELLA RIGA LOTTO
					
				else
					messagebox("Elimina" + k_record,  "Operazione Annullata !!")
					k_return = 2
				end if
				
			case 4
				if k_nr_barcode > 0 then
					if messagebox("Elimina" + k_record, k_record_1, question!, yesno!, 2) = 1 then
						kst_esito.esito = kkg_esito.ok  // QUANDO RICHIESTO AGGIORNAMENTO CANCELLERA' LA RIGA LOTTO
					else
						messagebox("Elimina" + k_record,  "Operazione Annullata !!")
						k_return = 2
					end if
				else
					kst_esito.esito = kkg_esito.ok
				end if
		end choose	
		
		if k_return <> 2 then
		
			if kst_esito.esito = kkg_esito.ok then
				k_return = 0 
			
	//--- Se tutto OK faccio la COMMIT		
				kst_esito = kguo_sqlca_db_magazzino.db_commit()
				if kst_esito.esito <> kkg_esito.ok then
					k_return = 1
					
					k_errore = "Operzione fallita (COMMIT)!! ~n~rErrore: " + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) 
					messagebox("Problemi durante la Cancellazione !!", k_errore)
	
		
				else
					
					choose case tab_1.selectedtab 
						case 1 
							tab_1.tabpage_1.dw_1.deleterow(k_riga)
						case 4 
							tab_1.tabpage_4.dw_4.deleterow(k_riga)
					end choose	
		
				end if
		
			else
				k_return = 1
				k_errore = "Operazione fallita !! ~n~r" + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) 
	
				kst_esito = kguo_sqlca_db_magazzino.db_rollback()
				if kst_esito.esito <> kkg_esito.ok then
					k_errore += k_errore + "~n~rErrore anche durante il recupero dell'errore: ~n~r" + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) + "~n~rControllare i dati. "
				end if
					
				messagebox("Problemi durante Cancellazione", k_errore ) 	
	
				attiva_tasti()
		
			end if
		end if
	end if
	
	if k_return = 0 then
	
		choose case tab_1.selectedtab 
			case 1 
				tab_1.tabpage_1.dw_1.setfocus()
				tab_1.tabpage_1.dw_1.setcolumn(1)
				tab_1.tabpage_1.dw_1.ResetUpdate ( ) 
				
			case 4
				tab_1.tabpage_4.dw_4.setfocus()
				if k_riga > 1 then
					if tab_1.tabpage_4.dw_4.rowcount() > k_riga then
						k_ctr = k_riga - 1
					else
						k_ctr = tab_1.tabpage_4.dw_4.rowcount()
					end if
					tab_1.tabpage_4.dw_4.selectrow( 0, false)
					tab_1.tabpage_4.dw_4.selectrow(k_ctr, true)
				else
					if tab_1.tabpage_4.dw_4.rowcount() > 0 then
						tab_1.tabpage_4.dw_4.selectrow(1, true)
					end if
				end if
					
				ki_riga_rimossaxelencolotti = true
		//		tab_1.tabpage_4.dw_4.setcolumn(1)
		//		tab_1.tabpage_4.dw_4.accepttext( )
		//		tab_1.tabpage_4.dw_4.ResetUpdate ( ) 
		end choose	
		
	end if
	
catch(uo_exception kuo_exception)
	kuo_exception.messaggio_utente()


end try	

return k_return

end function

protected function string dati_modif (string k_titolo);//
//=== Controllo se ci sono state modifiche di dati sui DW
string k_return="0 "
int k_msg=0


//=== Toglie le righe eventualmente da non registrare
	pulizia_righe()
	
	if (tab_1.tabpage_4.dw_4.getnextmodified(0, primary!) > 0  & 
				or tab_1.tabpage_4.dw_4.deletedcount() > 0)  & 
 		 		or tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0 & 
		then 

		if tab_1.tabpage_1.dw_1.rowcount( ) > 0  then
	
			if isnull(k_titolo) or len(trim(k_titolo)) = 0 then
				k_titolo = "Aggiorna Archivio"
			end if
	
			k_msg = messagebox(k_titolo, "Dati Modificati, vuoi Salvare gli Aggiornamenti ?", &
								question!, yesnocancel!, 1) 
		
			if k_msg = 1 then
				k_return = "1Dati Modificati"	
			else
				k_return = string(k_msg)			
			end if
		end if
	end if


return k_return
end function

protected function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
int k_err_ins, k_rc
boolean k_flag_numero_lotto_modificato = false
int k_colli_sped=0
st_tab_clienti kst_tab_clienti
st_tab_meca kst_tab_meca_attuale
st_esito kst_esito
kuf_base kuf1_base
kuf_sped kuf1_sped
kuf_utility kuf1_utility
datawindowchild  kdwc_1


//=== Puntatore Cursore da attesa.....
SetPointer(kkg.pointer_attesa)


if tab_1.tabpage_1.dw_1.rowcount() > 0 then 
	kst_tab_meca_attuale.id = tab_1.tabpage_1.dw_1.getitemnumber( 1, "id_meca")
end if
if isnull(kst_tab_meca_attuale.id) then kst_tab_meca_attuale.id = 0

if tab_1.tabpage_1.dw_1.rowcount() > 0 then 
	kst_tab_meca_attuale.num_int = tab_1.tabpage_1.dw_1.getitemnumber( 1, "num_int")
	kst_tab_meca_attuale.data_int = tab_1.tabpage_1.dw_1.getitemdate( 1, "data_int")
else
	kst_tab_meca_attuale.num_int = 0
	kst_tab_meca_attuale.data_int = date(0)
end if

if kist_tab_meca_orig.num_int <> kst_tab_meca_attuale.num_int &
         or year(kist_tab_meca_orig.data_int) <> year(kst_tab_meca_attuale.data_int) or tab_1.tabpage_1.dw_1.rowcount() = 0 then

	k_flag_numero_lotto_modificato = true

	kst_tab_meca_attuale.id = 0
	if kst_tab_meca_attuale.num_int > 0 then
		kst_esito = kiuf_armo.get_id_meca(kst_tab_meca_attuale)
		if kst_esito.esito = kkg_esito.not_fnd or kst_tab_meca_attuale.id = 0 then
			ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
		else
			if kst_esito.esito = kkg_esito.db_ko then
				kguo_exception.inizializza()
				kguo_exception.set_esito(kst_esito)
				kguo_exception.messaggio_utente( )
			end if
		end if
		kist_tab_meca_orig.id = kst_tab_meca_attuale.id
	end if

	tab_1.tabpage_4.dw_4.reset( ) // inizializzo le righe
	
//--- SE INSERIMENTO
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
		
		k_err_ins = inserisci()

//--- se in apertura ho un Mandante già indicato...	
		if kist_tab_meca.clie_1 > 0 then
			kst_tab_clienti.codice = kist_tab_meca.clie_1 
			get_dati_cliente(kst_tab_clienti)
			put_video_clie_1(kst_tab_clienti)
		end if
		
	else

		k_rc = tab_1.tabpage_1.dw_1.retrieve(kist_tab_meca_orig.id) 
		
		choose case k_rc

			case is < 0		
				SetPointer(kkg.pointer_default)
				kguo_exception.inizializza()
				kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_err_int )
				kguo_exception.setmessage(  &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(ID Documento cercato: " + string(kist_tab_meca_orig.id) + ") " )
				kguo_exception.messaggio_utente( )	
				post close(this)

			case 0
				tab_1.tabpage_1.dw_1.reset()
				attiva_tasti()

				if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
					ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento

					SetPointer(kkg.pointer_default)
					kguo_exception.inizializza()
					kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_not_fnd )
					kguo_exception.setmessage(  &
						"Mi spiace ma il Lotto cercato non e' in archivio ~n~r" + &
						"(ID Documento cercato: " + string(kist_tab_meca_orig.id) + ") " )
					kguo_exception.messaggio_utente( )	
					close(this)
					
				else
					k_err_ins = inserisci()
				end if

			case is > 0		
				kist_tab_meca_orig.id = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_meca")
				kist_tab_meca_orig.num_int = tab_1.tabpage_1.dw_1.getitemnumber(1, "num_int")
				kist_tab_meca_orig.data_int = tab_1.tabpage_1.dw_1.getitemdate(1, "data_int")
				kist_tab_meca.num_int = kist_tab_meca_orig.num_int
				kist_tab_meca.data_int = kist_tab_meca_orig.data_int
				
				if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
					SetPointer(kkg.pointer_default)
					kguo_exception.inizializza()
					kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_allerta )
					kguo_exception.setmessage(  &
						"Attenzione, il Lotto e' ga' stato Caricato ~n~r" + &
						"(ID lotto cercato: " + string(kist_tab_meca_orig.id) + ") " )
					kguo_exception.messaggio_utente( )	
			
					ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica

				end if

				try
//--- legge gli archivi di dettaglio				
					u_inizializza_3( )
					u_inizializza_4( )

//--- controllo se c'e' un Lotto con Allarme MEMO			
					u_allarme_lotto(kist_tab_meca_orig)
					
				catch (uo_exception kuo_exception)
					kuo_exception.messaggio_utente()
					
				end try
//--- reset del flag di update 				
				tab_1.tabpage_1.dw_1.ResetUpdate ( ) 
				tab_1.tabpage_4.dw_4.ResetUpdate ( ) 

				tab_1.tabpage_1.dw_1.setfocus()

				attiva_tasti()
		
				tab_1.tabpage_1.dw_1.visible = true
		end choose

	end if	

else
	attiva_tasti()
end if


try
	kuf1_utility = create kuf_utility 

//--- se sono in CANCELLAZIONE....
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.cancellazione then
	
	//--- se sono entrato x cancellazione...				
		ki_esci_dopo_cancella = true
		kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_1.dw_1)
		cb_cancella.event clicked( )
	
	else
		//--- se primo giro imposta la data di competenza di default
//		if tab_1.tabpage_1.dw_1.rowcount() > 0 and ki_st_open_w.flag_primo_giro = 'S' then
//			tab_1.tabpage_1.dw_1.setitem( 1, "k_competenza_dal",  ki_data_competenza)
//		end if
		
		//===
		//--- se inserimento inabilito gli altri TAB, sono inutili
		if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
		
			tab_1.tabpage_2.enabled = false
			tab_1.tabpage_3.enabled = false
			tab_1.tabpage_4.enabled = false
			tab_1.tabpage_5.enabled = false
			
		end if
	
		ki_lotto_spedito = false
		ki_lotto_pianificato = false

//--- controlli particolari	
		if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica and kist_tab_meca.id <> kst_tab_meca_attuale.id then
			
			try 
//--- posso modificare il documento?
				if kiuf_armo.if_lotto_chiuso(kist_tab_meca) then
					ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
					kguo_exception.inizializza()
					kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_dati_non_eseguito )
					kguo_exception.setmessage(  &
						"Attenzione, il LOTTO è 'CHIUSO' e non può essere modificato. ~n~r" + &
						"(ID Documento cercato:" + string(kist_tab_meca.id) + ") " )
					kguo_exception.messaggio_utente( )	
				else
					kuf1_sped = create kuf_sped
					k_colli_sped = kuf1_sped.get_colli_sped_lotto(kist_tab_meca_orig.id)
					if k_colli_sped > 0 then
						ki_lotto_spedito = true
					end if
					ki_lotto_pianificato = kiuf_armo.if_lotto_pianificato(kist_tab_meca) 

//--- Lotto già Spedito niente modifiche!!!!!	
					if ki_lotto_spedito then 
						kguo_exception.inizializza()
						kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_allerta )
						kguo_exception.setmessage(  &
							"Attenzione, già Spediti " + string(k_colli_sped) + " colli per questo LOTTO. La Modifica potrebbe comprometterne l'integrità. ~n~r" + &
							"(ID Documento cercato:" + string(kist_tab_meca.id) + ") " )
						kguo_exception.messaggio_utente( )	
					else
//--- Lotto già PIANIFICATO allora ATTENZIONE alle Modifiche	!!!!!	
						if ki_lotto_pianificato then 
							kguo_exception.inizializza()
							kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_allerta )
							kguo_exception.setmessage(  &
								"Attenzione, LOTTO già Pianificato per il trattamento. La Modifica potrebbe comprometterne l'integrità. ~n~r" + &
								"(ID Documento cercato:" + string(kist_tab_meca.id) + ") " )
							kguo_exception.messaggio_utente( )	
						end if
					end if
				end if
				
			catch(uo_exception kuo1_exception)
				ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
				kuo1_exception.messaggio_utente()

			end try
		end if	

//--- Inabilita campi alla modifica se Visualizzazione
		if trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.modifica and trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.inserimento then
	
			tab_1.tabpage_1.dw_1.object.p_img_causale.visible = false 
//			tab_1.tabpage_1.dw_1.object.p_img_clie_1.visible = false 
			tab_1.tabpage_1.dw_1.object.p_img_mandanti.visible = false 
			tab_1.tabpage_1.dw_1.object.p_img_mrf.visible = false 
		
			kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_1.dw_1)
	
		else		
			
//--- Inabilita alcuni campi alla modifica se Funzione MODIFICA o righe già pianificate o spedite
			if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica or ki_lotto_pianificato or ki_lotto_spedito then
				kuf1_utility.u_proteggi_dw("1", "clie_1", tab_1.tabpage_1.dw_1)
				kuf1_utility.u_proteggi_dw("1", "rag_soc_10", tab_1.tabpage_1.dw_1)
//				kuf1_utility.u_proteggi_dw("1", "p_iva", tab_1.tabpage_1.dw_1)
//				kuf1_utility.u_proteggi_dw("1", "cf", tab_1.tabpage_1.dw_1)
//				tab_1.tabpage_1.dw_1.object.p_img_clie_1.visible = true 
				tab_1.tabpage_1.dw_1.object.p_img_mandanti.visible = false 
				if ki_lotto_pianificato then
					kuf1_utility.u_proteggi_dw("1", "contratti_sc_cf", tab_1.tabpage_1.dw_1)
					kuf1_utility.u_proteggi_dw("1", "contratti_mc_co", tab_1.tabpage_1.dw_1)
					kuf1_utility.u_proteggi_dw("1", "meca_blk_id_meca_causale", tab_1.tabpage_1.dw_1)
					kuf1_utility.u_proteggi_dw("1", "meca_blk_descrizione", tab_1.tabpage_1.dw_1)
					tab_1.tabpage_1.dw_1.object.p_img_mrf.visible = false 
					tab_1.tabpage_1.dw_1.object.p_img_causale.visible = false 
					tab_1.tabpage_1.dw_1.object.p_img_elenco_contratti.visible = false
				else                     
					tab_1.tabpage_1.dw_1.object.p_img_mrf.visible = true 
					tab_1.tabpage_1.dw_1.object.p_img_causale.visible = true 
					tab_1.tabpage_1.dw_1.object.p_img_elenco_contratti.visible = true
				end if
				tab_1.tabpage_1.dw_1.setcolumn("consegna_data")

			else
			
				tab_1.tabpage_1.dw_1.object.p_img_causale.visible = true 
//				tab_1.tabpage_1.dw_1.object.p_img_clie_1.visible = true 
				tab_1.tabpage_1.dw_1.object.p_img_mandanti.visible = true 
				tab_1.tabpage_1.dw_1.object.p_img_mrf.visible = true 
				
//--- S-protezione campi per riabilitare la modifica a parte la chiave
				kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)
				
//				tab_1.tabpage_1.dw_1.setcolumn("num_bolla_in")
			end if
			
//--- popola elenchi ddw
			if (ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione and ki_st_open_w.flag_modalita <> kkg_flag_modalita.cancellazione) &
					  and (kst_tab_meca_attuale.id = 0 or ki_st_open_w.flag_primo_giro = "S") then
			
				tab_1.tabpage_1.dw_1.getchild("area_mag", kdwc_1)
				kdwc_1.settransobject(sqlca)
				kdwc_1.reset() 
				if kdwc_1.rowcount() = 0 then
					kdwc_1.retrieve()
					kdwc_1.insertrow(1)
				end if
			end if
			
		end if
		destroy kuf1_utility

//--- calcola colli testata
		tab_1.tabpage_1.dw_1.setitem( 1, "colli", get_totale_colli() )

//---- azzera il flag delle modifiche
		tab_1.tabpage_1.dw_1.SetItemStatus( 1, 0, Primary!, NotModified!)
	
end if 

catch (uo_exception kuo2_exception)
	kuo_exception.messaggio_utente()

end try


SetPointer(kkg.pointer_default)

return "0"


end function

protected function integer inserisci ();//
int k_return=0
st_tab_caus kst_tab_caus
kuf_utility kuf1_utility


//if ki_tab_1_index_new <> 1 then 
//	tab_1.selectedtab = 1
//end if
try
	
//--- Aggiunge una riga al data windows
	choose case ki_tab_1_index_new 
		case  1 
			this.setredraw(false)
	
			if tab_1.tabpage_1.dw_1.rowcount() > 0 then
				kist_tab_meca.data_int = tab_1.tabpage_1.dw_1.getitemdate( 1, "data_int" ) 
//				ki_data_competenza = tab_1.tabpage_1.dw_1.getitemdate( 1, "k_competenza_dal" ) 
			end if
	
			tab_1.tabpage_4.dw_4.reset() 
			tab_1.tabpage_1.dw_1.reset() 
			
			tab_1.tabpage_1.dw_1.insertrow(0)
			
//--- S-protezione campi per riabilitare la modifica a parte la chiave
			kuf1_utility = create kuf_utility
			kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)
			
//			tab_1.tabpage_1.dw_1.setitem( 1, "k_competenza_dal",  ki_data_competenza)
			tab_1.tabpage_1.dw_1.setitem( 1, "stato", kiuf_armo.ki_meca_stato_ok )
			tab_1.tabpage_1.dw_1.setitem( 1, "data_int", kist_tab_meca.data_int )

			kist_tab_meca.num_int = kiuf_armo.get_numero_nuovo()
			tab_1.tabpage_1.dw_1.setitem( 1, "num_int", kist_tab_meca.num_int )

			tab_1.tabpage_1.dw_1.setitem( 1, "data_bolla_in", kist_tab_meca.data_int )

			ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento
			
			this.setredraw(true)

			tab_1.tabpage_1.dw_1.setfocus()
			tab_1.tabpage_1.dw_1.setcolumn("clie_1")

//---- azzera il flag delle modifiche
			tab_1.tabpage_1.dw_1.ResetUpdate ( ) 
			tab_1.tabpage_4.dw_4.ResetUpdate ( ) 

//--- popola dw child dw clienti 
			set_dw_clienti_child()

			kist_tab_meca_orig = kist_tab_meca		
			kist_tab_meca_orig.id = 0
		
		case 4 // 
			
//			if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then	
//				if tab_1.tabpage_1.dw_1.object.tipo_doc[1] <> kiuf_fatt.kki_tipo_doc_nota_di_credito &
//						and tab_1.tabpage_1.dw_1.object.fattura_da[1] = kiuf_clienti.kki_fattura_da_bolla then
//					elenco_armo_non_fatt()
//				else
//					if tab_1.tabpage_1.dw_1.object.tipo_doc[1] <> kiuf_fatt.kki_tipo_doc_nota_di_credito  &
//							and tab_1.tabpage_1.dw_1.object.fattura_da[1] = kiuf_clienti.kki_fattura_da_certif then
//						elenco_lotti_non_fatt()
//					else
//						if tab_1.tabpage_1.dw_1.object.tipo_doc[1] = kiuf_fatt.kki_tipo_doc_nota_di_credito then
//							kG_menu.m_strumenti.m_fin_gest_libero3.enabled = true
//						end if
//					end if
//				end if
//			end if
			

			
	end choose	

catch (uo_exception kuo_exception) 
	kuo_exception.messaggio_utente()
	

finally
	k_return = 0

	attiva_tasti()

end try

return (k_return)



end function

protected subroutine pulizia_righe ();//
long k_riga
long k_nr_righe


	if tab_1.tabpage_1.dw_1.rowcount() > 0 then
		tab_1.tabpage_1.dw_1.accepttext()
	end if
	if tab_1.tabpage_4.dw_4.rowcount() > 0 then
		tab_1.tabpage_4.dw_4.accepttext()
	end if

//=== Pulizia dei rek non validi sui vari TAB
	k_nr_righe = tab_1.tabpage_4.dw_4.rowcount()
	for k_riga = k_nr_righe to 1 step -1

		if tab_1.tabpage_4.dw_4.getitemstatus(k_riga, 0, primary!) = new! then 
			if tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "id_armo") > 0 then
			else
		
				tab_1.tabpage_4.dw_4.deleterow(k_riga)
//---- azzera il flag delle modifiche
				tab_1.tabpage_4.dw_4.SetItemStatus( k_riga, 0, Primary!, NotModified!)

			end if
		end if
	next

//--- se non ho caricato nessuna e sono in inserimento nessuna aggiornamento!
	if tab_1.tabpage_4.dw_4.rowcount() = 0 then
		if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
			tab_1.tabpage_1.dw_1.resetupdate( )
			tab_1.tabpage_4.dw_4.resetupdate( )
		end if
	end if
end subroutine

protected subroutine riempi_id ();//
//=== Imposta gli Effettivi ID degli archivi
long k_righe, k_ctr
long k_id_meca_1
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
st_esito kst_esito
//string k_ret_code
//kuf_base kuf1_base



if tab_1.tabpage_1.dw_1.rowcount() > 0 then
	k_ctr = 1
end if

if k_ctr > 0 then
	
//=== Salvo ID originale x piu' avanti
	k_id_meca_1 = tab_1.tabpage_1.dw_1.getitemnumber(k_ctr, "id_meca")

	if isnull(k_id_meca_1) then				
		tab_1.tabpage_1.dw_1.setitem(k_ctr, "id_meca", 0)
		k_id_meca_1 = 0
	end if

	
	k_righe = tab_1.tabpage_4.dw_4.rowcount()
	for k_ctr = 1 to k_righe 
		
		tab_1.tabpage_4.dw_4.setitem(k_ctr, "id_meca", k_id_meca_1)

//=== Se non sono in caricamento allora prelevo l'ID dalla dw
		if tab_1.tabpage_4.dw_4.getitemstatus(k_ctr, 0, primary!) = newmodified! then
			tab_1.tabpage_4.dw_4.setitem(k_ctr, "id_armo", 0)
		end if
	
	end for

end if

end subroutine

protected subroutine open_start_window ();//
	kiuf_armo = create kuf_armo
	kiuf_armo_inout = create kuf_armo_inout
	kiuf_armo_nt = create kuf_armo_nt
	kiuf_clienti = create kuf_clienti
	kiuf_prodotti = create kuf_prodotti
	kiuf_listino = create kuf_listino
	kiuf_contratti = create kuf_contratti
	kiuf_armo_checkmappa = create kuf_armo_checkmappa
	kiuf_barcode_ini = create kuf_barcode_ini
	kiuf_ausiliari = create kuf_ausiliari

	kids_elenco_input = create datastore

	ki_toolbar_window_presente=true
	
	tab_1.tabpage_5.picturename = "Barcode.ICO"
	
	kist_tab_meca.id  = 0
	kist_tab_meca.clie_1 = 0
	if isnumber(ki_st_open_w.key1) then
		kist_tab_meca.id = long(trim(ki_st_open_w.key1))
	end if
	if isnumber(ki_st_open_w.key2) then
		kist_tab_meca.clie_1 = long(trim(ki_st_open_w.key2))
	end if

	kist_tab_meca.data_int = kguo_g.get_dataoggi( )
	 
//	dw_anno_numero.insertrow( 0 )
//	dw_anno_numero.object.numero[1] = 0
//	if dw_anno_numero.object.anno[1] = 0 or isnull(dw_anno_numero.object.anno[1]) then
//		dw_anno_numero.object.anno[1]  = year(relativedate(kg_dataoggi, - 20))
//	end if

//--- popola struttura x mantenere memoria dell'origine	
	kist_tab_meca_orig = kist_tab_meca


end subroutine

protected subroutine attiva_menu ();//
//---
//
boolean k_attiva=false, k_attiva_bcode=false

//--- Attiva/Dis. Voci di menu
	super::attiva_menu()


//=== 
	if tab_1.tabpage_1.dw_1.rowcount() > 0 then	
		if (ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento &
				or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica) &
		       and tab_1.tabpage_1.dw_1.object.clie_1[1] > 0 and tab_1.tabpage_4.enabled then
			k_attiva = true
		end if
		if kG_menu.m_strumenti.m_fin_gest_libero1.enabled <> k_attiva or ki_st_open_w.flag_primo_giro = "S" then 
			kG_menu.m_strumenti.m_fin_gest_libero1.text = "Elenco articoli del Contratto " + trim(kG_menu.m_strumenti.m_fin_gest_libero1.tag)
			kG_menu.m_strumenti.m_fin_gest_libero1.microhelp = "Elenco articoli del Contratto indicato "
			kG_menu.m_strumenti.m_fin_gest_libero1.visible = true

			kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
			kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText = 	"Contratti, Articoli con Contratto"
			kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
			
			kG_menu.m_strumenti.m_fin_gest_libero1.enabled = k_attiva
			kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemname = "contrBianco32.png"  //kG_path_risorse + kkg.path_sep +
		end if
		if kG_menu.m_strumenti.m_fin_gest_libero2.enabled <> k_attiva or ki_st_open_w.flag_primo_giro = "S" then 
			kG_menu.m_strumenti.m_fin_gest_libero2.text = "Elenco articoli senza Contratto " + trim(kG_menu.m_strumenti.m_fin_gest_libero2.tag)
			kG_menu.m_strumenti.m_fin_gest_libero2.microhelp = "Elenco articoli senza Contratto "
			kG_menu.m_strumenti.m_fin_gest_libero2.visible = true

			kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true
			kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritemText = 	"Vari, Articoli senza Contratto"
			kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
			
			kG_menu.m_strumenti.m_fin_gest_libero2.enabled = k_attiva
			kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritemname = "contrNero32.png"
		end if
		
		if tab_1.tabpage_1.dw_1.object.id_meca[1] > 0 then
			if tab_1.tabpage_1.dw_1.object.stato[1] = 0 or tab_1.tabpage_1.dw_1.object.stato[1] = 2 or tab_1.tabpage_1.dw_1.object.stato[1] = 5 then 
				k_attiva_bcode = true
			end if
		end if
		if kG_menu.m_strumenti.m_fin_gest_libero9.enabled <> k_attiva_bcode or ki_st_open_w.flag_primo_giro = "S" then 
			kG_menu.m_strumenti.m_fin_gest_libero9.text = "Genera Barcode " + trim(kG_menu.m_strumenti.m_fin_gest_libero9.tag)
			kG_menu.m_strumenti.m_fin_gest_libero9.microhelp = "Genera Barcode "
			kG_menu.m_strumenti.m_fin_gest_libero9.visible = true

			kG_menu.m_strumenti.m_fin_gest_libero9.toolbaritemVisible = true
			kG_menu.m_strumenti.m_fin_gest_libero9.toolbaritemText = 	"Barcode, Genera Barcode"
			kG_menu.m_strumenti.m_fin_gest_libero9.toolbaritembarindex=2
			
			kG_menu.m_strumenti.m_fin_gest_libero9.enabled = k_attiva
			kG_menu.m_strumenti.m_fin_gest_libero9.toolbaritemname = "barcode.ico"
		end if

//		this.settoolbar( 2, true)
	else
//		this.settoolbar( 2, false)
		kG_menu.m_strumenti.m_fin_gest_libero1.visible = false
		kG_menu.m_strumenti.m_fin_gest_libero2.visible = false
		kG_menu.m_strumenti.m_fin_gest_libero9.visible = false
//		kG_menu.m_strumenti.m_fin_gest_libero4.visible = false
//		kG_menu.m_strumenti.m_fin_gest_libero5.visible = false
//		kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = false
//		kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = false
//		kG_menu.m_strumenti.m_fin_gest_libero3.toolbaritemVisible = false
//		kG_menu.m_strumenti.m_fin_gest_libero4.toolbaritemVisible = false
//		kG_menu.m_strumenti.m_fin_gest_libero5.toolbaritemVisible = false
	end if
	

	
end subroutine

protected subroutine smista_funz (string k_par_in);//
//===
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//===


choose case LeftA(k_par_in, 2) 

	case kkg_flag_richiesta.libero1 		//Elenco art con contratto
		tab_1.tabpage_1.dw_1.accepttext( )
		call_art_x_contratto()
	case kkg_flag_richiesta.libero2 		//Elenco art senza contratto
		tab_1.tabpage_1.dw_1.accepttext( )
		call_art_x_no_contratto()

	case kkg_flag_richiesta.libero9 		//Genera BARCODE
		u_genera_barcode()

	case else
		super::smista_funz(k_par_in)

end choose

end subroutine

public function boolean get_dati_cliente (ref st_tab_clienti kst_tab_clienti);//
boolean k_return = false
st_esito kst_esito
kuf_clienti kuf1_clienti


try
	
	k_return = kiuf_clienti.leggi (kst_tab_clienti)
	
//--- Gestione di Allert per il cliente 	
	u_allarme_cliente(kst_tab_clienti)
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	

finally
	
end try

return k_return


end function

private subroutine riga_modifica ();//======================================================================
//=== 
//======================================================================
//
long k_riga=0, k_riga1=0, k_progressivo
st_tab_meca kst_tab_meca
st_tab_armo kst_tab_armo //, kst_tab_armo_entrati, kst_tab_armo_trattati, kst_tab_armo_nontrattare, kst_tab_armo_fatturati
st_tab_prodotti kst_tab_prodotti
st_tab_contratti kst_tab_contratti
st_tab_armo_nt kst_tab_armo_nt
st_tab_listino kst_tab_listino


try
	
	dw_riga.reset( )
	
	k_riga = tab_1.tabpage_4.dw_4.getselectedrow(0)
	if k_riga = 0 then
		messagebox("Operazione non eseguita", "Selezionare una riga dall'elenco", information!)
	else
		k_progressivo = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "k_progressivo")

		kiuf_armo.if_isnull_armo(kst_tab_armo)
		kst_tab_armo.stato = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "stato")
		kst_tab_armo.num_int = tab_1.tabpage_1.dw_1.getitemnumber(1, "num_int" )
		kst_tab_armo.data_int = tab_1.tabpage_1.dw_1.getitemdate(1, "data_int" )
		kst_tab_armo.id_meca = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_meca" )
		kst_tab_meca.contratto = tab_1.tabpage_1.dw_1.getitemnumber(1, "contratto" )
		kst_tab_contratti.sc_cf = tab_1.tabpage_1.dw_1.getitemstring(1, "contratti_sc_cf" )
		kst_tab_contratti.mc_co = tab_1.tabpage_1.dw_1.getitemstring(1, "contratti_mc_co" )
		
		kst_tab_armo.id_armo = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_armo" )
		kst_tab_armo.art = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "art" )
		kst_tab_armo.campione = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "campione" )
		kst_tab_prodotti.des = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "des")
		kst_tab_armo.magazzino = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "magazzino")
		kst_tab_armo.dose = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "dose" )
		kst_tab_armo.cod_sl_pt = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "cod_sl_pt" )
		kst_tab_armo.larg_2 = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "larg_2" )
		kst_tab_armo.lung_2 = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "lung_2" )
		kst_tab_armo.alt_2 = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "alt_2" )
		kst_tab_armo.colli_2 = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "colli_2")
		kst_tab_armo.pedane = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "pedane")
		kst_tab_armo.colli_fatt = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "colli_fatt")
		kst_tab_armo.peso_kg = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "peso_kg")
		kst_tab_armo.m_cubi = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "m_cubi")
		kst_tab_armo.note_1 = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "note_1" )
		kst_tab_armo.note_2 = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "note_2" )
		kst_tab_armo.note_3 = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "note_3" )
		kst_tab_armo.id_listino = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_listino" )
		
		kst_tab_armo_nt.note[1] = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "armo_nt_note_1" )  
		kst_tab_armo_nt.note[2] = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "armo_nt_note_2" )  
		kst_tab_armo_nt.note[3] = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "armo_nt_note_3" )  
		kst_tab_armo_nt.note[4] = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "armo_nt_note_4" )  
		kst_tab_armo_nt.note[5] = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "armo_nt_note_5" )  
		kst_tab_armo_nt.note[6] = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "armo_nt_note_6" )  
		kst_tab_armo_nt.note[7] = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "armo_nt_note_7" )  
		kst_tab_armo_nt.note[8] = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "armo_nt_note_8" )  
		kst_tab_armo_nt.note[9] = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "armo_nt_note_9" )  
		kst_tab_armo_nt.note[10] = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "armo_nt_note_10" )  

//--- get dati da listino
		kst_tab_listino.id = kst_tab_armo.id_listino
		kiuf_listino.get_dati_x_armo(kst_tab_listino)
		kst_tab_listino.cod_cli = kiuf_listino.get_cod_cli(kst_tab_listino)
	
		k_riga1=dw_riga.insertrow(0)
		dw_riga.setitem(k_riga1, "k_progressivo", k_progressivo)
		dw_riga.setitem( k_riga1, "cod_cli", kst_tab_listino.cod_cli )

		dw_riga.setitem( k_riga1, "listino_occup_ped", kst_tab_listino.occup_ped )
		dw_riga.setitem( k_riga1, "listino_peso_kg", kst_tab_listino.peso_kg )
		kst_tab_listino.m_cubi_f = (kst_tab_listino.mis_x/1000 * kst_tab_listino.mis_y/1000 * kst_tab_listino.mis_z/1000)
		dw_riga.setitem( k_riga1, "listino_m_cubi", kst_tab_listino.m_cubi_f )

		dw_riga.setitem( k_riga1, "num_int", kst_tab_armo.num_int )
		dw_riga.setitem( k_riga1, "data_int", kst_tab_armo.data_int )
		dw_riga.setitem( k_riga1, "stato", kst_tab_armo.stato )
		dw_riga.setitem( k_riga1, "id_meca", kst_tab_armo.id_meca )
		dw_riga.setitem( k_riga1, "id_armo", kst_tab_armo.id_armo )
		dw_riga.setitem( k_riga1, "id_listino", kst_tab_armo.id_listino )
		dw_riga.setitem( k_riga1, "contratto", kst_tab_meca.contratto )
		dw_riga.setitem( k_riga1, "contratti_sc_cf", kst_tab_contratti.sc_cf )
		dw_riga.setitem( k_riga1, "contratti_mc_co", kst_tab_contratti.mc_co )
		
		dw_riga.setitem( k_riga1, "colli_2", kst_tab_armo.colli_2 )
		dw_riga.setitem( k_riga1, "pedane", kst_tab_armo.pedane )
		dw_riga.setitem( k_riga1, "colli_fatt", kst_tab_armo.colli_fatt )
		dw_riga.setitem( k_riga1, "peso_kg", kst_tab_armo.peso_kg )
		dw_riga.setitem( k_riga1, "m_cubi", kst_tab_armo.m_cubi )

		dw_riga.setitem( k_riga1, "note_1", kst_tab_armo.note_1 )
		dw_riga.setitem( k_riga1, "note_2", kst_tab_armo.note_2 )
		dw_riga.setitem( k_riga1, "note_3", kst_tab_armo.note_3 )

		dw_riga.setitem( k_riga1, "armo_nt_note_1", kst_tab_armo_nt.note[1] )
		dw_riga.setitem( k_riga1, "armo_nt_note_2", kst_tab_armo_nt.note[2] )
		dw_riga.setitem( k_riga1, "armo_nt_note_3", kst_tab_armo_nt.note[3] )
		dw_riga.setitem( k_riga1, "armo_nt_note_4", kst_tab_armo_nt.note[4] )
		dw_riga.setitem( k_riga1, "armo_nt_note_5", kst_tab_armo_nt.note[5] )
		dw_riga.setitem( k_riga1, "armo_nt_note_6", kst_tab_armo_nt.note[6] )
		dw_riga.setitem( k_riga1, "armo_nt_note_7", kst_tab_armo_nt.note[7] )
		dw_riga.setitem( k_riga1, "armo_nt_note_8", kst_tab_armo_nt.note[8] )
		dw_riga.setitem( k_riga1, "armo_nt_note_9", kst_tab_armo_nt.note[9] )
		dw_riga.setitem( k_riga1, "armo_nt_note_10", kst_tab_armo_nt.note[10] )

		
		riga_modifica_display_art(kst_tab_armo, kst_tab_prodotti)   // visualizza solo i dati articolo
	
		if kst_tab_armo.id_armo > 0 then
			dw_riga.title = "Dettaglio riga " + string(k_riga) + " (id=" + string(kst_tab_armo.id_armo) + ") " 
		else
			dw_riga.title = "Compilazione riga " + string(k_riga) 
		end if
	
		dw_riga.object.b_ok.visible = false 
		dw_riga.object.b_esci.visible = false 
		
		dw_riga.visible = true		

	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try

	
end subroutine

protected subroutine inizializza_3 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 4 controllandone i valori se gia' presenti
//======================================================================


u_inizializza_3( )

tab_1.tabpage_4.dw_4.setfocus()

attiva_tasti()
	

end subroutine

private subroutine dragdrop_dw_esterna (uo_d_std_1 kdw_source, long k_riga);//
//
int k_rc
long  k_riga1, k_ind_selected, k_ind, k_riga_nuova_in_lista
st_tab_armo kst_tab_armo
st_tab_armo_nt kst_tab_armo_nt
st_tab_clienti kst_tab_clienti
st_tab_contratti kst_tab_contratti
st_tab_meca_causali kst_tab_meca_causali
st_esito kst_esito
datawindowchild kdwc_1


try
	
	if k_riga > 0 then 
	
	//--- Se dalla w di elenco (ZOOM) ho fatto doppio-click	 x scegliere la riga	
	
	//-- DROP nel TAB 1
		if ki_tab_1_index_new = 1 then
			choose case kdw_source.dataobject 
	//--- scelta da Causali di entrata
				case  "d_meca_causali_l"  
					if kdw_source.rowcount() > 0 then
//						tab_1.tabpage_1.dw_1.setitem(1, "meca_blk_id_meca_causale",  kdw_source.getitemnumber(long(k_riga), "id_meca_causale"))
//						tab_1.tabpage_1.dw_1.setitem(1, "meca_blk_descrizione",  kdw_source.getitemstring(long(k_riga), "descrizione"))
						kst_tab_meca_causali.id_meca_causale = kdw_source.getitemnumber(long(k_riga), "id_meca_causale")
						set_causale_lotto(kst_tab_meca_causali)
					end if
	
	//--- scelta da elenco Mandanti
				case "d_clienti_l_mandanti_contratti" 
					if kdw_source.rowcount() > 0 then
						kst_tab_clienti.codice = kdw_source.getitemnumber(long(k_riga), "id_cliente")
						kst_esito = kiuf_clienti.leggi_rag_soc(kst_tab_clienti)
						put_video_clie_1(kst_tab_clienti)
					end if
			
	//--- scelta da elenco Riceventi-Clienti
				case "d_m_r_f_l_3xcontratto" &
					 ,"d_m_r_f_l_3" 
					if kdw_source.rowcount() > 0 then
						kst_tab_clienti.codice = kdw_source.getitemnumber(long(k_riga), "clie_2")
						if tab_1.tabpage_1.dw_1.getitemnumber(1, "clie_2") = kst_tab_clienti.codice then
						else
							put_video_clie_2(kst_tab_clienti)
						end if
						kst_tab_clienti.codice = long(kdw_source.getitemnumber(long(k_riga), "clie_3"))
						if tab_1.tabpage_1.dw_1.getitemnumber(1, "clie_3") = kst_tab_clienti.codice then
						else
							put_video_clie_3(kst_tab_clienti)
							set_id_causale_da_clie_3()  // causale di blocco sul cliente ha la priorità
						end if
					end if
			
	//--- scelta da Contratti x Mandante
				case  "d_contratti_l_x_meca"  
					if kdw_source.rowcount() > 0 then
						if tab_1.tabpage_1.dw_1.getitemnumber(1, "contratto") = kdw_source.getitemnumber(long(k_riga), "contratti_codice") then
						else
							kst_esito = kiuf_clienti.leggi_rag_soc(kst_tab_clienti)
							
							kst_tab_contratti.codice = kdw_source.getitemnumber(long(k_riga), "contratti_codice")
							kst_tab_contratti.sc_cf = kdw_source.getitemstring(long(k_riga), "contratti_cf")
							kst_tab_contratti.mc_co = kdw_source.getitemstring(long(k_riga), "contratti_co")

							set_contratto(kst_tab_contratti)
							post call_art_x_contratto() // apre elenco articoli per il contratto indicato
							
						end if
					end if
	
			end choose
	
		end if
		
	//-- DROP nel TAB 4	
		if ki_tab_1_index_new = 4 then
			kst_tab_armo.id_listino = 0
	//--- Ritorno da Elenco Articoli 
			if kdw_source.dataobject = "d_listino_l_x_contratto" &
			       or kdw_source.dataobject = "d_listino_l_x_no_contratto" then
				if kdw_source.getselectedrow(0) > 0 then
					k_ind_selected = kdw_source.getselectedrow( 0 )
					kst_tab_armo.id_listino = kdw_source.getitemnumber(k_ind_selected, "id_listino")
				end if
			end if
	//--- devo avere passato il ID listino per fare la riga lotto
			if kst_tab_armo.id_listino > 0 then
				k_riga_nuova_in_lista = riga_nuova_in_lista(kst_tab_armo, kst_tab_armo_nt)
				if k_riga_nuova_in_lista > 0 then
					tab_1.tabpage_4.dw_4.setrow(k_riga_nuova_in_lista)
					cb_modifica.post event clicked( ) // apre la window con i dati della riga lotto appena caricata
//					post riga_modifica( )   
				else
					kguo_exception.inizializza( )
					kst_esito.sqlerrtext = "Nessuna riga caricata in elenco!"
					kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_non_eseguito)
					kguo_exception.set_esito( kst_esito )
					throw kguo_exception
				end if
			else
				kguo_exception.inizializza( )
				kst_esito.sqlerrtext = "Manca codice Listino, operazione interrotta!"
				kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_non_eseguito)
				kguo_exception.set_esito( kst_esito )
				throw kguo_exception
			end if
	
	//--- posiziona su ultima riga
			if tab_1.tabpage_4.dw_4.getrow() = 0 then
				tab_1.tabpage_4.dw_4.selectrow(0, false)
				tab_1.tabpage_4.dw_4.setrow(tab_1.tabpage_4.dw_4.rowcount())
				tab_1.tabpage_4.dw_4.selectrow(tab_1.tabpage_4.dw_4.rowcount() , true)
				tab_1.tabpage_4.dw_4.scrolltorow(tab_1.tabpage_4.dw_4.rowcount() )
			end if						
		end if
		
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try
	
	

end subroutine

public subroutine set_iniz_dati_cliente (ref st_tab_clienti kst_tab_clienti);//			
kst_tab_clienti.codice = 0
kst_tab_clienti.rag_soc_10 = " "
kst_tab_clienti.p_iva = " "
kst_tab_clienti.cf = " "
kst_tab_clienti.loc_1 = " "
kst_tab_clienti.prov_1 = " "
kst_tab_clienti.id_nazione_1 = " "

kst_tab_clienti.rag_soc_20  = " "
kst_tab_clienti.rag_soc_21  = " "
kst_tab_clienti.indi_2  = " "
kst_tab_clienti.cap_2 = " "
kst_tab_clienti.loc_2  = " "
kst_tab_clienti.prov_2  = " "
kst_tab_clienti.id_nazione_2  = ""



end subroutine

public subroutine set_dw_clienti_child ();//
int k_rc
string k_cadenza_fattura="", k_x=""
datawindowchild  kdwc_1, kdwc_2


	if ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento or ki_st_open_w.flag_modalita = kkg_flag_modalita_modifica then
		
		tab_1.tabpage_1.dw_1.getchild("clie_1", kdwc_1)
		kdwc_1.settransobject(sqlca)
		kdwc_1.reset() 
		k_x = "%"
		kdwc_1.retrieve(k_x)
		kdwc_1.SetSort("id_cliente A")
		kdwc_1.sort( )
		kdwc_1.insertrow(1)
		
		tab_1.tabpage_1.dw_1.getchild("rag_soc_10", kdwc_2)
		kdwc_2.settransobject(sqlca)
		kdwc_2.reset() 
		k_rc = kdwc_1.RowsCopy(1, kdwc_1.RowCount(), Primary!, kdwc_2, 1, Primary!)
		k_rc = kdwc_2.SetSort("rag_soc_1 A")
		k_rc = kdwc_2.sort( )
		
	end if

end subroutine

private subroutine run_app_lettera ();//
string k_file="", k_ext=""
kuf_utility kuf1_utility


try
	if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then
		k_file = trim(tab_1.tabpage_1.dw_1.getitemstring (1, "file_prodotto"))
		if len(k_file) > 0 then
			
			kuf1_utility = create kuf_utility
			kuf1_utility.u_open_app_file(k_file)
		
		else
			k_file=""
		end if
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try	

end subroutine

protected function string check_dati ();//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK ma errore non grave
//===                : 5=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================
//
string k_return = " "
string k_errore = "0"
long k_ctr
st_tab_meca kst_tab_meca
st_esito kst_esito,kst_esito1
datastore kds_inp_testa, kds_inp_righe


try

	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//--- Controllo i tab
	if tab_1.tabpage_1.dw_1.rowcount() > 0 then
		kds_inp_testa = create datastore
		kds_inp_testa.dataobject = tab_1.tabpage_1.dw_1.dataobject
		tab_1.tabpage_1.dw_1.rowscopy( 1,1,primary!, kds_inp_testa, 1, primary!)
		kds_inp_righe = create datastore
		kds_inp_righe.dataobject = tab_1.tabpage_4.dw_4.dataobject
		if tab_1.tabpage_4.dw_4.rowcount( ) = 0 and tab_1.tabpage_4.dw_4.deletedcount( ) = 0 then
			kst_tab_meca.id = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_meca")  
			if kst_tab_meca.id > 0 then
				tab_1.tabpage_4.dw_4.retrieve(kst_tab_meca.id)  // carica le righe del LOTTO !!!!!!
				for k_ctr = 1 to tab_1.tabpage_4.dw_4.rowcount( ) 
					tab_1.tabpage_4.dw_4.setitem(k_ctr, "k_progressivo", k_ctr)
				end for
			end if
		end if
		tab_1.tabpage_4.dw_4.rowscopy( 1,tab_1.tabpage_4.dw_4.rowcount( ) ,primary!, kds_inp_righe, 1, primary!)
		tab_1.tabpage_4.dw_4.rowscopy( 1,tab_1.tabpage_4.dw_4.rowcount( ) ,delete!, kds_inp_righe, 1, delete!)
		kst_esito = kiuf_armo_checkmappa.u_check_dati(kds_inp_testa, kds_inp_righe)
	end if
	
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()

finally
	choose case kst_esito.esito
		case kkg_esito.OK
			k_errore = "0"
		case kkg_esito.ERR_LOGICO
			k_errore = "1"
		case kkg_esito.err_formale
			k_errore = "2"
		case kkg_esito.DATI_INSUFF
			k_errore = "3"
		case kkg_esito.DB_WRN
			k_errore = "4"
		case kkg_esito.DATI_WRN
			k_errore = "5"
		case else
			k_errore = "1"
	end choose

	k_return = trim(kst_esito.sqlerrtext)
//--- Attenzione se ho interesse di conoscere i campi in errore scorrere i TAG di ciascun campo nel DATASTORE dove c'e' il tipo di errore riscontrato 	
	
end try


return k_errore + k_return


end function

private function integer get_totale_colli ();//--
//---  Torna Totale Colli delle righe di questo documento 
//---
int k_return = 0, k_ctr=0, k_righe = 0
st_tab_armo kst_tab_armo

try
	
//--- calcolo il totale colli 	
	kst_tab_armo.colli_2=0
	k_righe = tab_1.tabpage_4.dw_4.rowcount( )
	if k_righe > 0 then
		for k_ctr= 1 to k_righe
			kst_tab_armo.colli_2 = tab_1.tabpage_4.dw_4.getitemnumber(k_ctr, "colli_2")
			if kst_tab_armo.colli_2 > 0 then
				k_return += kst_tab_armo.colli_2
			end if
		next
	else
		kst_tab_armo.id_meca = tab_1.tabpage_1.dw_1.getitemnumber( 1, "id_meca")
		if kst_tab_armo.id_meca > 0 then
			k_return = kiuf_armo.get_colli_lotto(kst_tab_armo)
		end if
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try


return k_return


end function

public subroutine u_allarme_lotto (st_tab_meca ast_tab_meca) throws uo_exception;//
boolean k_return = false
st_memo_allarme kst_memo_allarme
kuf_armo_inout kuf1_armo_inout

try
	
//--- Gestione di Allert per Lotto (id) 	
	if ast_tab_meca.id > 0 then
		kiuf_armo.get_num_int(ast_tab_meca)
		kst_memo_allarme.allarme = kguf_memo_allarme.kki_memo_allarme_meca
		kst_memo_allarme.st_memo.st_tab_meca_memo.id_meca = ast_tab_meca.id
		kst_memo_allarme.descr = "Avviso rilevato sul Lotto num. " + string(ast_tab_meca.num_int) + " del " + string(ast_tab_meca.data_int, "dd/mm/yy") + " id "+ string(ast_tab_meca.id) 
		if kguf_memo_allarme.set_allarme_lotto(kst_memo_allarme) then
			kguf_memo_allarme.u_attiva_memo_allarme()
		end if
	else
		kguf_memo_allarme.inizializza()
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	

finally
	
end try



end subroutine

public subroutine u_allarme_cliente (readonly st_tab_clienti ast_tab_clienti) throws uo_exception;//
boolean k_return = false
st_memo_allarme kst_memo_allarme


try
	
//--- Gestione di Allert per il cliente 	
	if ast_tab_clienti.codice > 0 then
		kst_memo_allarme.allarme = kguf_memo_allarme.kki_memo_allarme_meca
		kst_memo_allarme.st_memo.st_tab_clienti_memo.id_cliente = ast_tab_clienti.codice
		kst_memo_allarme.descr = "Avviso rilevato sul Cliente " + string(ast_tab_clienti.codice) + ", num. Lotto: " + string(tab_1.tabpage_1.dw_1.getitemnumber(1, "num_int"))
		if kguf_memo_allarme.set_allarme_cliente(kst_memo_allarme) then
			kguf_memo_allarme.u_attiva_memo_allarme()
		end if
	else
		kguf_memo_allarme.inizializza()
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	

finally
	
end try



end subroutine

private subroutine call_elenco_causali ();//
//--- Fa l'elenco Causale di carico
//
st_open_w kst_open_w
datastore kds_1	
kuf_elenco kuf1_elenco

SetPointer(kkg.pointer_attesa )

	if not isvalid(kds_1) then
		kds_1 = create datastore
	end if
	kds_1.dataobject = "d_meca_causali_l" 
	kds_1.settransobject(sqlca) 
	kds_1.retrieve()
	if kds_1.rowcount() > 0 then
		kuf1_elenco = create kuf_elenco
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_modalita = kkg_flag_modalita_elenco
		kst_open_w.flag_adatta_win = KK_ADATTA_WIN
		kst_open_w.key1 = "Elenco Causali " 
		kst_open_w.key2 = trim(kds_1.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = trim(this.title)    //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key12_any = kds_1
		kuf1_elenco.u_open(kst_open_w)
	else
		messagebox("Elenco Dati", "Nessun valore disponibile. ")
			
	end if
						
				
SetPointer(kkg.pointer_default )

	



		
		
		


end subroutine

private subroutine call_elenco_mandanti ();//
//--- Fa l'elenco Mandanti
//
st_tab_meca kst_tab_meca
st_open_w kst_open_w 
kuf_elenco kuf1_elenco


	try
	
		SetPointer(kkg.pointer_attesa)
		
		if not isvalid(kids_elenco_mand) then 
			kids_elenco_mand = create datastore
			kids_elenco_mand.dataobject = "d_clienti_l_mandanti_contratti"
			kids_elenco_mand.settransobject(kguo_sqlca_db_magazzino)
		end if
		
		kst_tab_meca.data_int = tab_1.tabpage_1.dw_1.getitemdate(1, "data_int")
		
		kids_elenco_mand.reset()
		kids_elenco_mand.retrieve("%", kst_tab_meca.data_int)
		
		if kids_elenco_mand.rowcount() > 0 then

//--- chiamare la window di elenco
			kst_open_w.id_programma = kkg_id_programma.elenco
			kst_open_w.key1 = "Elenco Mandanti con Contratto e Listini Validi" 
			kst_open_w.key2 = trim(kids_elenco_mand.dataobject)
			kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
			kst_open_w.key4 = trim(kiw_this_window.title)   //--- Titolo della Window di chiamata per riconoscerla
			kst_open_w.key6 = " "    //--- nome del campo cliccato
			kst_open_w.key7 = "N"    //--- dopo la scelta NON chiudere la Window di elenco
			kst_open_w.key12_any = kids_elenco_mand
			kuf1_elenco = create kuf_elenco 
			kuf1_elenco.u_open(kst_open_w)
		else
			messagebox("Elenco Dati", "Nessun mandante trovato "  )
		end if

		SetPointer(kkg.pointer_default)

	
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
	
	end try


end subroutine

private subroutine call_elenco_mrf ();//
//--- Fa l'elenco dei Riceventi
//
long k_righe = 0
string k_dataobject = ""
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
kuf_elenco kuf1_elenco
st_open_w kst_open_w 
kuf_menu_window kuf1_menu_window


	try
	
		SetPointer(kkg.pointer_attesa)

		kst_tab_meca.contratto = tab_1.tabpage_1.dw_1.getitemnumber( 1, "contratto")
		kst_tab_meca.clie_1 = tab_1.tabpage_1.dw_1.getitemnumber( 1, "clie_1")
		if kst_tab_meca.contratto > 0 then
			k_dataobject = "d_m_r_f_l_3xcontratto"
		else
			k_dataobject = "d_m_r_f_l_3"
		end if
		
		if not isvalid(kids_elenco_mrf) then 
			kids_elenco_mrf = create datastore
			kids_elenco_mrf.dataobject = k_dataobject
			kids_elenco_mrf.settransobject(kguo_sqlca_db_magazzino)
		end if
		if kids_elenco_mrf.dataobject <> k_dataobject then
			kids_elenco_mrf.dataobject = k_dataobject
			kids_elenco_mrf.settransobject(kguo_sqlca_db_magazzino )
		end if
		kids_elenco_mrf.reset()
		if kst_tab_meca.clie_1 > 0 then
			if k_dataobject = "d_m_r_f_l_3" then
				k_righe = kids_elenco_mrf.retrieve(kst_tab_meca.clie_1)
			else
				if kst_tab_meca.contratto > 0 then
					k_righe = kids_elenco_mrf.retrieve(kst_tab_meca.clie_1, kst_tab_meca.contratto)
				end if
			end if
		end if

		if k_righe > 0 then
			kst_tab_meca.clie_2 = kids_elenco_mrf.getitemnumber( 1, "clie_2")
			kst_tab_meca.clie_3 = kids_elenco_mrf.getitemnumber( 1, "clie_3")
			if k_righe = 1 then
				
//--- se c'e' una sola scelta la imposta in automatico		
				kst_tab_clienti.codice = kst_tab_meca.clie_2
				put_video_clie_2(kst_tab_clienti)  
				kst_tab_clienti.codice = kst_tab_meca.clie_3
				put_video_clie_3(kst_tab_clienti)

			else

//--- chiamare la window di elenco
				kuf1_elenco = create kuf_elenco
				kst_open_w.flag_modalita = kkg_flag_modalita_elenco
				kst_open_w.key1 = "Elenco Riceventi-Clienti per il Mandante " + string(kst_tab_meca.clie_1) + " e Contratto " + string(kst_tab_meca.contratto) 
				kst_open_w.key2 = trim(kids_elenco_mrf.dataobject)
				kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
				kst_open_w.key4 = trim(this.title)    //--- Titolo della Window di chiamata per riconoscerla
				kst_open_w.key7 = "N"    //--- dopo la scelta NON chiudere la Window di elenco
				kst_open_w.key12_any = kids_elenco_mrf
				kuf1_elenco.u_open(kst_open_w)
			end if				
		else
			if kst_tab_meca.contratto > 0 then
				messagebox("Elenco Dati", "Nessuna associazione trovata per il Mandante " + string(kst_tab_meca.clie_1) + " e Contratto " + string(kst_tab_meca.contratto) )
			else
				messagebox("Elenco Dati", "Nessuna associazione trovata per il Mandante " + string(kst_tab_meca.clie_1) + " "  )
			end if
		end if

		SetPointer(kkg.pointer_default)

	
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
	
	end try


end subroutine

private subroutine put_video_clie_2 (st_tab_clienti kst_tab_clienti);//
//--- Visualizza dati Cliente Ricevente
//
st_esito kst_esito


kst_esito = kiuf_clienti.leggi_rag_soc(kst_tab_clienti)
kiuf_clienti.if_isnull(kst_tab_clienti)
tab_1.tabpage_1.dw_1.setitem( 1, "clie_2", kst_tab_clienti.codice)
tab_1.tabpage_1.dw_1.setitem( 1, "c2_rag_soc_10", kst_tab_clienti.rag_soc_10 )
tab_1.tabpage_1.dw_1.setitem( 1, "c2_rag_soc_11", kst_tab_clienti.rag_soc_11 )
tab_1.tabpage_1.dw_1.setitem( 1, "c2_p_iva", trim(kst_tab_clienti.p_iva) )
tab_1.tabpage_1.dw_1.setitem( 1, "c2_indi_1", kst_tab_clienti.indi_1 )
tab_1.tabpage_1.dw_1.setitem( 1, "c2_cap_1", kst_tab_clienti.cap_1 )
tab_1.tabpage_1.dw_1.setitem( 1, "c2_loc_1", kst_tab_clienti.loc_1 )
tab_1.tabpage_1.dw_1.setitem( 1, "c2_prov_1", trim(kst_tab_clienti.prov_1) )
tab_1.tabpage_1.dw_1.setitem( 1, "c2_id_nazione_1", kst_tab_clienti.id_nazione_2 )



end subroutine

private subroutine put_video_clie_3 (st_tab_clienti kst_tab_clienti);//
//--- Visualizza dati Cliente Fatturato
//
st_esito kst_esito


kst_esito = kiuf_clienti.leggi_rag_soc(kst_tab_clienti)
kiuf_clienti.if_isnull(kst_tab_clienti)
tab_1.tabpage_1.dw_1.setitem( 1, "clie_3", kst_tab_clienti.codice)
tab_1.tabpage_1.dw_1.setitem( 1, "c3_rag_soc_10", kst_tab_clienti.rag_soc_10 )
tab_1.tabpage_1.dw_1.setitem( 1, "c3_rag_soc_11", kst_tab_clienti.rag_soc_11 )
tab_1.tabpage_1.dw_1.setitem( 1, "c3_p_iva", trim(kst_tab_clienti.p_iva) )
tab_1.tabpage_1.dw_1.setitem( 1, "c3_indi_1", kst_tab_clienti.indi_1 )
tab_1.tabpage_1.dw_1.setitem( 1, "c3_cap_1", kst_tab_clienti.cap_1 )
tab_1.tabpage_1.dw_1.setitem( 1, "c3_loc_1", kst_tab_clienti.loc_1 )
tab_1.tabpage_1.dw_1.setitem( 1, "c3_prov_1", trim(kst_tab_clienti.prov_1) )
tab_1.tabpage_1.dw_1.setitem( 1, "c3_id_nazione_1", kst_tab_clienti.id_nazione_2 )


end subroutine

public subroutine u_inizializza (st_tab_meca ast_tab_meca);//
//---- azzera il flag delle modifiche
		tab_1.tabpage_4.dw_4.SetItemStatus( 1, 0, Primary!, NotModified!)

		kist_tab_meca.id = ast_tab_meca.id
		ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica
	
		tab_1.selecttab(1)
//	end if

end subroutine

private subroutine call_art_x_contratto ();//
//--- Fa l'elenco Articoli x contratto
//
long k_righe_articoli=0, k_riga_nuova_in_lista=0
st_tab_meca kst_tab_meca
st_tab_armo kst_tab_armo
st_tab_armo_nt kst_tab_armo_nt
st_open_w kst_open_w
datastore kds_1	
kuf_elenco kuf1_elenco


try
	
	SetPointer(kkg.pointer_attesa )

	if not isvalid(kds_1) then
		kds_1 = create datastore
	end if
	kst_tab_meca.contratto = tab_1.tabpage_1.dw_1.getitemnumber( 1, "contratto")
	kst_tab_meca.clie_3 = tab_1.tabpage_1.dw_1.getitemnumber( 1, "clie_3")
	if kst_tab_meca.contratto > 0 then
		if isnull(kst_tab_meca.clie_3) then kst_tab_meca.clie_3 = 0
		kds_1.dataobject = "d_listino_l_x_contratto" 
		kds_1.settransobject(sqlca) 
		k_righe_articoli = kds_1.retrieve(kst_tab_meca.contratto, kst_tab_meca.clie_3)
	end if
	if k_righe_articoli > 0 then
		tab_1.selectedtab = 4
		if k_righe_articoli = 1 and tab_1.tabpage_4.dw_4.rowcount( ) = 0 then
//--- se c'è una sola riga e non c'è ancora nulla effettua in automatico la selezione		
			kst_tab_armo.id_listino = kds_1.getitemnumber(1, "id_listino")
	//--- devo avere passato il ID listino per fare la riga lotto
			if kst_tab_armo.id_listino > 0 then
				k_riga_nuova_in_lista = riga_nuova_in_lista(kst_tab_armo, kst_tab_armo_nt)
				if k_riga_nuova_in_lista > 0 then
					tab_1.tabpage_4.dw_4.setrow(k_riga_nuova_in_lista)
					cb_modifica.post event clicked( ) // apre la window con i dati della riga lotto appena caricata
				end if
			end if
		else
//--- elenco righe contratto 	
			kuf1_elenco = create kuf_elenco
			kst_open_w.flag_primo_giro = "S"
			kst_open_w.flag_modalita = kkg_flag_modalita_elenco
			kst_open_w.flag_adatta_win = KK_ADATTA_WIN
			if kst_tab_meca.clie_3 > 0 then
				kst_open_w.key1 = "Elenco Articoli per il Contratto " + string(kst_tab_meca.contratto) + " e Cliente " + string(kst_tab_meca.clie_3)
			else
				kst_open_w.key1 = "Elenco Articoli per il Contratto " + string(kst_tab_meca.contratto) 
			end if
			kst_open_w.key2 = trim(kds_1.dataobject)
			kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
			kst_open_w.key4 = trim(this.title)    //--- Titolo della Window di chiamata per riconoscerla
			kst_open_w.key12_any = kds_1
			kuf1_elenco.u_open(kst_open_w)
		end if
	else
		messagebox("Elenco articoli contratto", "Nessun valore disponibile per il Contratto: " + string(kst_tab_meca.contratto) + " del Cliente " + string(kst_tab_meca.clie_3))
	end if
						
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally
	SetPointer(kkg.pointer_default )
	
end try


	



		
		
		


end subroutine

private subroutine riga_modifica_display_art (st_tab_armo kst_tab_armo, st_tab_prodotti kst_tab_prodotti);//======================================================================
//=== 
//======================================================================

		dw_riga.setitem( 1, "campione", kst_tab_armo.campione )
		dw_riga.setitem( 1, "art", kst_tab_armo.art )
		dw_riga.setitem( 1, "larg_2", kst_tab_armo.larg_2 )
		dw_riga.setitem( 1, "lung_2", kst_tab_armo.lung_2 )
		dw_riga.setitem( 1, "alt_2", kst_tab_armo.alt_2 )
		dw_riga.setitem( 1, "cod_sl_pt", kst_tab_armo.cod_sl_pt )
		dw_riga.setitem( 1, "dose", kst_tab_armo.dose )
		dw_riga.setitem( 1, "magazzino", kst_tab_armo.magazzino )
		dw_riga.setitem( 1, "des", kst_tab_prodotti.des )

	
end subroutine

private subroutine call_contratti_x_clie_1 ();//
//--- Fa elenco Contratti x Mandante
//
st_open_w kst_open_w
datastore kds_1	
kuf_elenco kuf1_elenco
st_tab_meca kst_tab_meca


SetPointer(kkg.pointer_attesa )

	if not isvalid(kds_1) then
		kds_1 = create datastore
	end if
	kds_1.dataobject = "d_contratti_l_x_meca"
	kds_1.settransobject(sqlca) 
	kst_tab_meca.data_int = tab_1.tabpage_1.dw_1.getitemdate( 1, "data_int")
	kst_tab_meca.clie_1 = tab_1.tabpage_1.dw_1.getitemnumber( 1, "clie_1")
	if kst_tab_meca.clie_1 > 0 then
		kds_1.retrieve(kst_tab_meca.data_int, kst_tab_meca.clie_1)
	end if
	if kds_1.rowcount() > 0 then
		kuf1_elenco = create kuf_elenco
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_modalita = kkg_flag_modalita_elenco
		kst_open_w.flag_adatta_win = KK_ADATTA_WIN
		kst_open_w.key1 = "Elenco Contratti per il Mandante " + string(kst_tab_meca.clie_1) + " (attivi in data " + string(kst_tab_meca.data_int) + ") "
		kst_open_w.key2 = trim(kds_1.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = trim(this.title)    //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key12_any = kds_1
		kuf1_elenco.u_open(kst_open_w)
	else
		messagebox("Elenco Dati", "Nessun contratto attivo per il Mandante " + string(kst_tab_meca.clie_1) + " in data " + string(kst_tab_meca.data_int))
			
	end if
						
				
SetPointer(kkg.pointer_default )

	



		
		
		


end subroutine

protected subroutine inizializza_4 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 5 controllandone i valori se gia' presenti
//======================================================================
//

u_inizializza_4( )

tab_1.tabpage_5.dw_5.setfocus()

attiva_tasti()
	

end subroutine

private function integer riga_nuova_in_lista (ref st_tab_armo ast_tab_armo, st_tab_armo_nt ast_tab_armo_nt) throws uo_exception;//---
//--- aggiunge una riga nel LOTTO
//--- Inp: id_armo
//--- out: numero di riga caricata
//---
long k_riga_elenco=0
st_tab_meca kst_tab_meca
st_tab_prodotti kst_tab_prodotti 
st_tab_listino kst_tab_listino
st_tab_contratti kst_tab_contratti
st_esito kst_esito


try
	
//--- Check se riga già presente in elenco
	k_riga_elenco = riga_gia_presente (ast_tab_armo) 
	if k_riga_elenco > 0 then
	else			
			
//--- DATI RIGA			
		
//---- Leggo dati da Listino per la riga Lotto
		kst_tab_listino.id = ast_tab_armo.id_listino
		kiuf_listino.get_dati_x_armo(kst_tab_listino)

	  	ast_tab_armo.art = kst_tab_listino.cod_art
	   	ast_tab_armo.magazzino = kst_tab_listino.magazzino
	  	ast_tab_armo.campione = kst_tab_listino.campione
	   	ast_tab_armo.dose = kst_tab_listino.dose
	   	ast_tab_armo.lung_2 = kst_tab_listino.mis_x
	  	ast_tab_armo.alt_2 = kst_tab_listino.mis_y
	 	ast_tab_armo.larg_2 = kst_tab_listino.mis_z

	 	ast_tab_armo.colli_fatt = 0

 		kst_tab_listino.m_cubi_f = (kst_tab_listino.mis_x * kst_tab_listino.mis_y * kst_tab_listino.mis_z) / 1000000000 
//	 	ast_tab_armo.peso_kg = kst_tab_listino.peso_kg
//	 	ast_tab_armo.m_cubi = kst_tab_armo.larg_2 * kst_tab_armo.alt_2 * kst_tab_armo.lung_2 / 1000000000 

//---- se ho il cod contratto lo leggo
		if kst_tab_listino.contratto > 0 then 
			kst_tab_contratti.codice = kst_tab_listino.contratto
			kst_esito = kiuf_contratti.get_sl_pt(kst_tab_contratti)
			if kst_esito.esito = kkg_esito.ok then
		 		ast_tab_armo.cod_sl_pt = kst_tab_contratti.sl_pt
			else
				if kst_esito.esito = kkg_esito.db_ko then
					kguo_exception.inizializza( )
					kguo_exception.set_esito( kst_esito )
					throw kguo_exception
				end if
			end if
		end if
		
//--- legge dati articolo	
		if len(trim(ast_tab_armo.art)) > 0 then 
			kst_tab_prodotti.des = " "
			kst_tab_prodotti.codice = ast_tab_armo.art
			kst_esito = kiuf_prodotti.get_des(kst_tab_prodotti)
//			select_riga(kst_tab_prodotti )
			if kst_esito.esito = kkg_esito.ok then
			else
				if kst_esito.esito = kkg_esito.db_ko then
					kguo_exception.inizializza( )
					kguo_exception.set_esito( kst_esito )
					throw kguo_exception
				end if
			end if
		end if	

		ast_tab_armo.id_meca = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_meca")
		if ast_tab_armo.id_meca > 0 then
			ast_tab_armo.num_int = tab_1.tabpage_1.dw_1.getitemnumber(1, "num_int")
			ast_tab_armo.data_int = tab_1.tabpage_1.dw_1.getitemdate(1, "data_int")
		end if

//////--- legge cliente a cui fatturare
////			kiuf_armo.get_clie(kst_tab_meca)
//
////--- controllo se c'e' un Lotto con Allarme MEMO			
//			u_allarme_lotto(kst_tab_meca)
//		end if

//--- se avevo aperto la window di modifica e non era un art già in elenco allora va in sost di questa 		
		if dw_riga.visible then
			if dw_riga.rowcount( ) > 0 then
				k_riga_elenco = dw_riga.getitemnumber( 1, "k_progressivo")
			end if
		end if
	
		if k_riga_elenco > 0 then
			ast_tab_armo.note_1 = dw_riga.getitemstring( 1, "note_1")
			ast_tab_armo.note_2 = dw_riga.getitemstring( 1, "note_2")
			ast_tab_armo.note_3 = dw_riga.getitemstring( 1, "note_3")
			ast_tab_armo.colli_2 = dw_riga.getitemnumber( 1, "colli_2")
			ast_tab_armo_nt.note[1] = dw_riga.getitemstring( 1, "armo_nt_note_1")
			ast_tab_armo_nt.note[2] = dw_riga.getitemstring( 1, "armo_nt_note_2")
			ast_tab_armo_nt.note[3] = dw_riga.getitemstring( 1, "armo_nt_note_3")
			ast_tab_armo_nt.note[4] = dw_riga.getitemstring( 1, "armo_nt_note_4")
			ast_tab_armo_nt.note[5] = dw_riga.getitemstring( 1, "armo_nt_note_5")
			ast_tab_armo_nt.note[6] = dw_riga.getitemstring( 1, "armo_nt_note_6")
			ast_tab_armo_nt.note[7] = dw_riga.getitemstring( 1, "armo_nt_note_7")
			ast_tab_armo_nt.note[8] = dw_riga.getitemstring( 1, "armo_nt_note_8")
			ast_tab_armo_nt.note[9] = dw_riga.getitemstring( 1, "armo_nt_note_9")
			ast_tab_armo_nt.note[10] = dw_riga.getitemstring( 1, "armo_nt_note_10")
		else			
			ast_tab_armo.colli_2 = 0
			k_riga_elenco = tab_1.tabpage_4.dw_4.insertrow(0)
			tab_1.tabpage_4.dw_4.setitem(k_riga_elenco, "k_progressivo", k_riga_elenco)
		end if
		
		
		if ast_tab_armo.colli_2 > 0 then
			u_dw_riga_ricalcolo_1(ast_tab_armo, kst_tab_listino)
		end if

//--- inserisce la riga in elenco	
		riga_display_in_lista (k_riga_elenco, ast_tab_armo, kst_tab_prodotti, ast_tab_armo_nt)  
		
	end if
	
	if k_riga_elenco > 0 then
		tab_1.tabpage_4.dw_4.selectrow(0, false)
		tab_1.tabpage_4.dw_4.setrow(k_riga_elenco)
		tab_1.tabpage_4.dw_4.selectrow(k_riga_elenco, true)
		tab_1.tabpage_4.dw_4.ScrollToRow(k_riga_elenco)
	end if	
	
catch(uo_exception kuo_exception)
	throw kuo_exception


end try	
		
	
return k_riga_elenco

	
end function

private function integer riga_modifica_in_lista (long a_riga, st_tab_armo ast_tab_armo, st_tab_prodotti ast_tab_prodotti, st_tab_armo_nt ast_tab_armo_nt) throws uo_exception;//
//--- aggiunge una riga 
//
//long k_riga=0


//k_riga = tab_1.tabpage_4.dw_4.find( "k_progressivo = " +  string(dw_riga.getitemnumber(dw_riga.getrow(), "k_progressivo")), 1,  tab_1.tabpage_4.dw_4.rowcount()) 

if a_riga > 0 then

//--- espone i dati circa l'articolo, ecc... 	
	riga_display_in_lista (a_riga, ast_tab_armo, ast_tab_prodotti, ast_tab_armo_nt)  

end if
	
	
return a_riga

	
end function

private subroutine put_video_clie_1 (st_tab_clienti ast_tab_clienti);//
//--- Visualizza dati Mandante 
//
st_esito kst_esito
st_tab_meca_causali kst_tab_meca_causali


try
	kiuf_clienti.if_isnull(ast_tab_clienti)
	
	tab_1.tabpage_1.dw_1.modify( "clie_1.Background.Color = '" + string(KK_COLORE_BIANCO) + "' " ) 
	tab_1.tabpage_1.dw_1.setitem( 1, "clie_1", ast_tab_clienti.codice )
	tab_1.tabpage_1.dw_1.modify( "rag_soc_10.Background.Color = '" + string(KK_COLORE_BIANCO) + "' " ) 
	tab_1.tabpage_1.dw_1.setitem( 1, "rag_soc_10", trim(ast_tab_clienti.rag_soc_10) )
	tab_1.tabpage_1.dw_1.modify( "rag_soc_11.Background.Color = '" + string(KK_COLORE_BIANCO) + "' " ) 
	tab_1.tabpage_1.dw_1.setitem( 1, "rag_soc_11", trim(ast_tab_clienti.rag_soc_11) )
	tab_1.tabpage_1.dw_1.modify( "p_iva.Background.Color = '" + string(KK_COLORE_BIANCO) + "' " ) 
	tab_1.tabpage_1.dw_1.setitem( 1, "p_iva", trim(ast_tab_clienti.p_iva) )
//	tab_1.tabpage_1.dw_1.modify( "cf.Background.Color = '" + string(KK_COLORE_BIANCO) + "' " ) 
	//tab_1.tabpage_1.dw_1.setitem( 1, "cf", trim(ast_tab_clienti.cf) )
	
	tab_1.tabpage_1.dw_1.setitem( 1, "indi_1", ast_tab_clienti.indi_1 )
	tab_1.tabpage_1.dw_1.setitem( 1, "cap_1", ast_tab_clienti.cap_1 )
	tab_1.tabpage_1.dw_1.setitem( 1, "loc_1", ast_tab_clienti.loc_1 )
	tab_1.tabpage_1.dw_1.setitem( 1, "prov_1", trim(ast_tab_clienti.prov_1) )
	tab_1.tabpage_1.dw_1.setitem( 1, "id_nazione_1", ast_tab_clienti.id_nazione_2 )
	
//--- se sto caricando un NUOVO lotto oppure nessuna causale presente allora vedo se è sul cliente la causale di blocco
	kst_tab_meca_causali.id_meca_causale = tab_1.tabpage_1.dw_1.getitemnumber(1, "meca_blk_id_meca_causale")
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento &
	       or kst_tab_meca_causali.id_meca_causale = 0 or isnull(kst_tab_meca_causali.id_meca_causale) then
		kst_tab_meca_causali.id_meca_causale = kiuf_clienti.get_id_meca_causale(ast_tab_clienti) // get causale sul cliente se c'e'
		if kst_tab_meca_causali.id_meca_causale > 0 then 
			tab_1.tabpage_1.dw_1.setitem( 1, "meca_blk_id_meca_causale", kst_tab_meca_causali.id_meca_causale )
		else
			tab_1.tabpage_1.dw_1.setitem( 1, "meca_blk_id_meca_causale", 0 )
		end if
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try


end subroutine

private function integer riga_gia_presente (st_tab_armo ast_tab_armo);//---
//--- Controllo se riga magazzino presente in questa fattura
//--- inp: kst_tab_armo.id_listino
//--- out: boolean:   true=presente, false=non trovata
//
long k_return = 0


	if ast_tab_armo.id_listino > 0 then

		choose case true

			case ast_tab_armo.id_listino > 0
				k_return = tab_1.tabpage_4.dw_4.find( "id_listino = " + string(ast_tab_armo.id_listino) , 1, tab_1.tabpage_4.dw_4.rowcount() ) 
				
		end choose		
		
	end if

		
return k_return 	


end function

private subroutine riga_display_in_lista (integer a_riga, st_tab_armo ast_tab_armo, st_tab_prodotti ast_tab_prodotti, st_tab_armo_nt ast_tab_armo_nt) throws uo_exception;//
//--- Visualizza la Riga in Elenco
//
st_esito kst_esito


	kiuf_armo.if_isnull_armo(ast_tab_armo)
	
	tab_1.tabpage_4.dw_4.setitem(a_riga, "stato"  ,ast_tab_armo.stato )

	tab_1.tabpage_4.dw_4.setitem(a_riga, "num_int"  ,ast_tab_armo.num_int )
	tab_1.tabpage_4.dw_4.setitem(a_riga, "data_int"  ,ast_tab_armo.data_int )

	tab_1.tabpage_4.dw_4.setitem(a_riga, "magazzino"  ,ast_tab_armo.magazzino )
	tab_1.tabpage_4.dw_4.setitem(a_riga, "campione"  ,ast_tab_armo.campione )
	tab_1.tabpage_4.dw_4.setitem(a_riga, "art"  ,ast_tab_armo.art )
	tab_1.tabpage_4.dw_4.setitem(a_riga, "dose"  ,ast_tab_armo.dose )
	tab_1.tabpage_4.dw_4.setitem(a_riga, "des"  ,ast_tab_prodotti.des )
	tab_1.tabpage_4.dw_4.setitem(a_riga, "larg_2"  ,ast_tab_armo.larg_2 )
	tab_1.tabpage_4.dw_4.setitem(a_riga, "lung_2"  ,ast_tab_armo.lung_2 )
	tab_1.tabpage_4.dw_4.setitem(a_riga, "alt_2"  ,ast_tab_armo.alt_2 )
	tab_1.tabpage_4.dw_4.setitem(a_riga, "cod_sl_pt"  ,ast_tab_armo.cod_sl_pt )
	tab_1.tabpage_4.dw_4.setitem(a_riga, "peso_kg"  ,ast_tab_armo.peso_kg )
	tab_1.tabpage_4.dw_4.setitem(a_riga, "id_listino"  ,ast_tab_armo.id_listino )
	
	tab_1.tabpage_4.dw_4.setitem(a_riga, "colli_2"  ,ast_tab_armo.colli_2 )
	tab_1.tabpage_4.dw_4.setitem(a_riga, "pedane"  ,ast_tab_armo.pedane )
	tab_1.tabpage_4.dw_4.setitem(a_riga, "m_cubi"  ,ast_tab_armo.m_cubi )
	tab_1.tabpage_4.dw_4.setitem(a_riga, "id_meca"  ,ast_tab_armo.id_meca )
	tab_1.tabpage_4.dw_4.setitem(a_riga, "id_armo"  ,ast_tab_armo.id_armo )
	tab_1.tabpage_4.dw_4.setitem(a_riga, "colli_fatt"  ,ast_tab_armo.colli_fatt )

	tab_1.tabpage_4.dw_4.setitem(a_riga, "note_1"  ,trim(ast_tab_armo.note_1))
	tab_1.tabpage_4.dw_4.setitem(a_riga, "note_2"  ,trim(ast_tab_armo.note_2))
	tab_1.tabpage_4.dw_4.setitem(a_riga, "note_3"  ,trim(ast_tab_armo.note_3))
	
	tab_1.tabpage_4.dw_4.setitem(a_riga, "armo_nt_note_1", trim(ast_tab_armo_nt.note[1]))
	tab_1.tabpage_4.dw_4.setitem(a_riga, "armo_nt_note_2", trim(ast_tab_armo_nt.note[2]))
	tab_1.tabpage_4.dw_4.setitem(a_riga, "armo_nt_note_3", trim(ast_tab_armo_nt.note[3]))
	tab_1.tabpage_4.dw_4.setitem(a_riga, "armo_nt_note_4", trim(ast_tab_armo_nt.note[4]))
	tab_1.tabpage_4.dw_4.setitem(a_riga, "armo_nt_note_5", trim(ast_tab_armo_nt.note[5]))
	tab_1.tabpage_4.dw_4.setitem(a_riga, "armo_nt_note_6", trim(ast_tab_armo_nt.note[6]))
	tab_1.tabpage_4.dw_4.setitem(a_riga, "armo_nt_note_7", trim(ast_tab_armo_nt.note[7]))
	tab_1.tabpage_4.dw_4.setitem(a_riga, "armo_nt_note_8", trim(ast_tab_armo_nt.note[8]))
	tab_1.tabpage_4.dw_4.setitem(a_riga, "armo_nt_note_9", trim(ast_tab_armo_nt.note[9]))
	tab_1.tabpage_4.dw_4.setitem(a_riga, "armo_nt_note_10", trim(ast_tab_armo_nt.note[10]))
	
//--- valorizzo il numero colli dell'intero lotto
	if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then
		tab_1.tabpage_1.dw_1.setitem(1, "colli", get_totale_colli( ))
	end if

	
end subroutine

private subroutine call_art_x_no_contratto ();//
//--- Fa l'elenco Articoli x contratto
//
st_open_w kst_open_w
datastore kds_1	
kuf_elenco kuf1_elenco
st_tab_meca kst_tab_meca


SetPointer(kkg.pointer_attesa )

	if not isvalid(kds_1) then
		kds_1 = create datastore
	end if

	kst_tab_meca.clie_3 = tab_1.tabpage_1.dw_1.getitemnumber( 1, "clie_3")
	if isnull(kst_tab_meca.clie_3) then kst_tab_meca.clie_3 = 0
	kds_1.dataobject = "d_listino_l_x_no_contratto" 
	kds_1.settransobject(sqlca) 
	kds_1.retrieve(kst_tab_meca.clie_3)
	if kds_1.rowcount() > 0 then
		tab_1.selectedtab = 4
		kuf1_elenco = create kuf_elenco
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_modalita = kkg_flag_modalita_elenco
		kst_open_w.flag_adatta_win = KK_ADATTA_WIN
		if kst_tab_meca.clie_3 > 0 then
			kst_open_w.key1 = "Elenco Articoli senza Contratto per il Cliente " + string(kst_tab_meca.clie_3) 
		else
			kst_open_w.key1 = "Elenco Articoli senza Contratto e Cliente " 
		end if
		kst_open_w.key2 = trim(kds_1.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = trim(this.title)    //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key12_any = kds_1
		kuf1_elenco.u_open(kst_open_w)
	else
		messagebox("Elenco Dati", "Nessun Articolo disponibile. ")
	end if
						
				
SetPointer(kkg.pointer_default )

	



		
		
		


end subroutine

private function boolean u_if_mrf_ok (st_tab_meca ast_tab_meca);//
//--- Controlla se Mandante Ricevente e Fatturato sono congruenti con il contratto indicato
//--- inp: st_tab_meca clie_1/2/3 + contratto
//--- rit: TRUE=ok congruente!
//
boolean k_return = false
datastore kds_mrf_ok

	try
	
		SetPointer(kkg.pointer_attesa)

//		ast_tab_meca.contratto = tab_1.tabpage_1.dw_1.getitemnumber( 1, "contratto")
//		ast_tab_meca.clie_1 = tab_1.tabpage_1.dw_1.getitemnumber( 1, "clie_1")
//		ast_tab_meca.clie_2 = tab_1.tabpage_1.dw_1.getitemnumber( 1, "clie_2")
//		ast_tab_meca.clie_3 = tab_1.tabpage_1.dw_1.getitemnumber( 1, "clie_3")
		
		if ast_tab_meca.clie_1 > 0 and ast_tab_meca.clie_2 > 0 and ast_tab_meca.clie_3 > 3 and ast_tab_meca.contratto > 0 then

//--- controllo se la M.R.F. sono congruenti
			kds_mrf_ok = create datastore
			kds_mrf_ok.dataobject = "ds_s_armo_da_fatt"
			kds_mrf_ok.settransobject(kguo_sqlca_db_magazzino)
			if kds_mrf_ok.retrieve(ast_tab_meca.clie_1, ast_tab_meca.clie_2, ast_tab_meca.clie_3, ast_tab_meca.contratto) > 0 then
				if kds_mrf_ok.getitemnumber(1, "k_ok") = 1 then
					k_return = true
				end if
			end if
		end if

		SetPointer(kkg.pointer_default)

	
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
	
	end try

return k_return

end function

public subroutine u_genera_barcode ();//--- 
//--- Genera Barcode
//---
//---
boolean k_elabora=false, k_stampati=false
int k_colli_caricati=0, k_barcode_da_generare=0, k_nr_elaborati=0, k_barcode_stampati = 0
string k_esito=""
st_esito kst_esito
st_tab_meca kst_tab_meca
//st_tab_armo kst_tab_armo 
st_tab_barcode kst_tab_barcode

try
	
	kst_tab_barcode.id_meca = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_meca")
	
	if kst_tab_barcode.id_meca > 0 then
		
		k_stampati = kiuf_barcode_ini.if_stampati(kst_tab_barcode)
		
		k_colli_caricati = u_get_nr_colli_xbcode()   // get dei colli caricati nell'elenco righe x fare i barcode
		k_barcode_stampati = kiuf_barcode_ini.get_nr_barcode_generati(kst_tab_barcode)  // get del nr barcode già generati
		k_barcode_da_generare = k_colli_caricati - k_barcode_stampati
		
		if k_barcode_da_generare = 0 then
			
			if k_stampati then
				if messagebox("Barcode già STAMPATI", "Confermare la RIGENERAZIONE barcode già STAMPATI per questo Lotto?", question!, yesno!, 1) = 1 then
					k_elabora = true
				end if
			else
				if messagebox("Barcode già generati", "Confermare la RIGENERAZIONE barcode per questo Lotto?", question!, yesno!, 1) = 1 then
					k_elabora = true
				end if
			end if
		else

//			kst_tab_armo.id_meca = kst_tab_barcode.id_meca
//			kst_esito = kiuf_armo.get_colli_entrati_xbcode(kst_tab_armo)  // get dei colli entrati no dose zero
//			if kst_esito.esito = kkg_esito.db_ko then
//				kguo_exception.set_esito( kst_esito )
//				throw kguo_exception
//			end if
//			kst_tab_armo.colli_2 = k_colli_caricati
			if k_barcode_da_generare = k_colli_caricati then
				if messagebox("Generazione Barcode", "Confermare la generazione di " + string(k_barcode_da_generare) + " barcode per questo Lotto?", question!, yesno!, 1) = 1 then
					k_elabora = true
				end if
			else
				if k_barcode_da_generare > 0 then
					if k_barcode_da_generare = 1 then
						if messagebox("Generazione Parziale Barcode", "Attenzione: sarà generato 1 barcode da aggiungere al LOTTO. Confermare?", question!, yesno!, 2) = 1 then
							k_elabora = true
						end if
					else
						if messagebox("Generazione Parziale Barcode", "Attenzione: saranno generati " + string(k_barcode_da_generare) + " barcode da aggiungere al LOTTO. Confermare?", question!, yesno!, 2) = 1 then
							k_elabora = true
						end if
					end if
				else
					if k_stampati then
						if messagebox("Distruzione Parziale Barcode", "Attenzione: saranno DISTRUTTI " + string(abs(k_barcode_da_generare)) + " barcode già STAMPATI dal LOTTO. Confermare?", question!, yesno!, 2) = 1 then
							k_elabora = true
						end if
					else
						if messagebox("Distruzione Parziale Barcode", "Attenzione: saranno DISTRUTTI " + string(abs(k_barcode_da_generare)) + " barcode dal LOTTO. Confermare?", question!, yesno!, 2) = 1 then
							k_elabora = true
						end if
					end if
				end if
			end if
		end if

//--- Elaborazione Barcode confermata?		
		if k_elabora then
		
			u_aggiorna()   // Aggiorna LOTTO
			
			kst_tab_barcode.st_tab_g_0.esegui_commit = "S"
			k_nr_elaborati = kiuf_barcode_ini.lotto_genera_barcode(kst_tab_barcode)  // GENERA BARCODE

//--- rilegge i barcode
			if k_nr_elaborati <> 0 then
				tab_1.tabpage_5.dw_5.reset( )
				u_inizializza_4( )
				attiva_tasti( )
				tab_1.selecttab(5)
			end if
			
			messagebox("Operazione conclusa", "Elaborazione corretta, sono stati trattati " + string(k_nr_elaborati) + " Barcode", information!) 

		end if
		
	end if

	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()

end try


end subroutine

protected subroutine u_inizializza_3 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 4 controllandone i valori se gia' presenti
//======================================================================
//
int k_rc, k_ctr //, k_nriga
st_tab_meca kst_tab_meca, kst_tab_meca_prec


if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then
	kst_tab_meca.id = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_meca")  
end if
if kst_tab_meca.id > 0 then

	if tab_1.tabpage_4.dw_4.rowcount() > 0 then
		kst_tab_meca_prec.id = tab_1.tabpage_4.dw_4.getitemnumber(1, "id_meca")  
	end if
	if isnull(kst_tab_meca_prec.id) then kst_tab_meca_prec.id = 0
	
	if kst_tab_meca.id <> kst_tab_meca_prec.id then

		if tab_1.tabpage_4.dw_4.retrieve(kst_tab_meca.id) > 0 then  // cerca le righe nel LOTTO !!!!!!
			if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
				tab_1.tabpage_4.dw_4.setrow(1)
				tab_1.tabpage_4.dw_4.selectrow(1,true)
			end if
			
			for k_ctr = 1 to tab_1.tabpage_4.dw_4.rowcount( ) 
				tab_1.tabpage_4.dw_4.setitem(k_ctr, "k_progressivo", k_ctr)
			end for

		end if				

//---- azzera il flag delle modifiche
		tab_1.tabpage_4.dw_4.SetItemStatus( 1, 0, Primary!, NotModified!)
		
	end if

else

//	inserisci()
	
end if

	

end subroutine

protected subroutine u_inizializza_4 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 4 controllandone i valori se gia' presenti
//======================================================================
//
int k_rc, k_ctr //, k_nriga
st_tab_meca kst_tab_meca, kst_tab_meca_prec



if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then
	kst_tab_meca.id = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_meca")  
end if
if kst_tab_meca.id > 0 then

	if tab_1.tabpage_5.dw_5.rowcount() > 0 then
		kst_tab_meca_prec.id = tab_1.tabpage_5.dw_5.getitemnumber(1, "id_meca")  
	end if
	if isnull(kst_tab_meca_prec.id) then kst_tab_meca_prec.id = 0
	
	if kst_tab_meca.id <> kst_tab_meca_prec.id then

		tab_1.tabpage_5.dw_5.retrieve(kst_tab_meca.id)

	end if

end if


end subroutine

protected subroutine u_aggiorna () throws uo_exception;//
//======================================================================
//=== Aggiorna tabelle 
//=== Ritorna 1 chr : 0=tutto OK; 1=errore grave I-O;
//=== 				  : 2=
//===					  : 3=Commit fallita
//===		dal char 2 in poi spiegazione dell'errore
//======================================================================

string k_return="0 ", k_errore="0 ", k_errore1="0 "
int k_ctr=0
long k_riga
st_tab_base kst_tab_base 
st_tab_armo kst_tab_armo
st_tab_meca kst_tab_meca_app, kst_tab_meca
st_tab_meca_causali kst_tab_meca_causali
st_tab_armo_nt kst_tab_armo_nt
st_tab_barcode kst_tab_barcode
st_esito kst_esito, kst_esito_BASE
kuf_base kuf1_base



try

	setpointer(kkg.pointer_attesa) 
	
	kuf1_base = create kuf_base
	
	k_riga = tab_1.tabpage_1.dw_1.getrow()

	//--- Se sono in Inserimento verifico se numero documento già usato
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
		kst_tab_meca_app.num_int = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "num_int")
		kist_tab_meca_orig.num_int = kst_tab_meca_app.num_int
		kst_tab_meca_app.data_int = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "data_int") 
		kst_tab_meca_app.id = 0
		kiuf_armo.get_id_meca( kst_tab_meca_app ) 
		if kst_tab_meca_app.id > 0 then	
			kst_tab_meca_app.clie_1 = 0
			kst_tab_meca_app.clie_2 = 0
			kst_tab_meca_app.clie_3 = 0
			kiuf_armo.get_ultimo_doc_ins ( kst_tab_meca_app ) 
			kst_tab_meca.num_int = kst_tab_meca_app.num_int + 1

			tab_1.tabpage_1.dw_1.setitem(k_riga, "num_int", kst_tab_meca.num_int )

		end if
	else
//--- se sono in Modifica e ho cambiato numero e data....			
		if ki_st_open_w.flag_modalita = kkg_flag_modalita_modifica then
			kst_tab_meca.num_int = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "num_int")
			kst_tab_meca.data_int = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "data_int")
			if kist_tab_meca_orig.num_int > 0 then
				if kist_tab_meca_orig.num_int <> kst_tab_meca.num_int or kist_tab_meca_orig.data_int <> kst_tab_meca.data_int then
//--- Cambio numero e data....			
					kst_tab_meca.st_tab_g_0.esegui_commit = "N"
					kst_tab_meca.id = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_meca")
					kiuf_armo.set_num_data_int( kst_tab_meca )
				end if
			end if
		end if
	end if

//--- se sono sullo stato di SBLOCCATO allora metto NORMALE	
	kst_tab_meca.stato = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "stato")
	if kst_tab_meca.stato = kiuf_armo.ki_meca_stato_sblk then
		tab_1.tabpage_1.dw_1.setitem(k_riga, "stato", kiuf_armo.ki_meca_stato_ok)
	end if
		
	kst_tab_meca.id = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_meca")
	if isnull(kst_tab_meca.id) then kst_tab_meca.id = 0
	kst_tab_meca.num_int = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "num_int")
	kst_tab_meca.data_int = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "data_int")
	kst_tab_meca.stato = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "stato")
	kst_tab_meca.id_meca_causale = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "meca_blk_id_meca_causale")
	kst_tab_meca.meca_blk_descrizione  =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "meca_blk_descrizione")
	kst_tab_meca.clie_1 = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "clie_1")
	kst_tab_meca.clie_2 = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "clie_2")
	kst_tab_meca.clie_3 = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "clie_3")
	kst_tab_meca.data_bolla_in = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "data_bolla_in")
	kst_tab_meca.num_bolla_in  =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "num_bolla_in")
	kst_tab_meca.area_mag  =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "area_mag")
	kst_tab_meca.id_wm_pklist = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_wm_pklist")
	kst_tab_meca.contratto = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "contratto")
	kst_tab_meca.consegna_data = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "consegna_data")
	kst_tab_meca.data_lav_fin = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "data_lav_fin")
		
//--- espone in testata il toto colli 
	kst_tab_armo.colli_2 = get_totale_colli( )
	tab_1.tabpage_1.dw_1.setitem(k_riga, "colli", kst_tab_armo.colli_2)
		
//=== Aggiorna, se modificato, la TAB_1	
	if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0	then
	
//--- Aggiorna la testa
		kst_tab_meca.st_tab_g_0.esegui_commit = "N"
		kst_tab_meca.id = kiuf_armo.tb_update_meca( kst_tab_meca )
		if kst_tab_meca.id > 0 then
			kist_tab_meca.id = kst_tab_meca.id
			
//--- carico Causale Lotto 	
			if kst_tab_meca.id_meca_causale > 0 then
				kst_tab_meca.st_tab_g_0.esegui_commit = "N"
				kst_tab_meca_causali.id_meca_causale = kst_tab_meca.id_meca_causale
				kst_esito = kiuf_ausiliari.tb_select(kst_tab_meca_causali)
				if kst_esito.esito <> kkg_esito.ok then
					kguo_exception.inizializza( )
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
				end if
				kst_tab_meca.meca_blk_rich_autorizz = trim(kst_tab_meca_causali.rich_autorizz)
				kiuf_armo.tb_update_meca_blk(kst_tab_meca)  // aggiorna MECA_BLK
			end if
			tab_1.tabpage_1.dw_1.setitem (k_riga, "id_meca", kst_tab_meca.id )
		else
			kst_esito.sqlcode = 0
			kst_esito.esito = kkg_esito.db_ko  // fermo la registrazione  ROLLBACK!
			kst_esito.sqlerrtext = "Identificativo (id lotto) non generato, ~n~r" + "Impossibile proseguire con la registrazione del Lotto!"
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
	end if
	

//--- Se tutto OK carico le righe di dettaglio 	
	kst_tab_armo.st_tab_g_0.esegui_commit = "N"
	
//---- Prima rimuove le righe da CANCELLARE DAL DB (se ce ne sono)
	k_riga = 1
	do while k_riga <= tab_1.tabpage_4.dw_4.DeletedCount ( ) 
		
		kst_tab_armo.id_armo = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_armo", delete!, false) 
		
//--- Cancella righe dal DB
		if kst_tab_armo.id_armo > 0 then
			kiuf_armo.tb_delete_riga( kst_tab_armo )   // Cancella la RIGA
			kst_tab_barcode.id_armo = kst_tab_armo.id_armo
			kiuf_barcode_ini.u_distruggi_barcode(kst_tab_barcode, 0)  // Cancella i BARCODE!
		end if
			
		k_riga++
	loop

//--- carica le righe sul DB	
	k_riga = 1
	do while k_riga <= tab_1.tabpage_4.dw_4.rowcount() 

		kst_tab_armo.id_meca = kst_tab_meca.id
		kst_tab_armo.data_int = kst_tab_meca.data_int
		kst_tab_armo.num_int = kst_tab_meca.num_int
		kst_tab_armo.stato = kst_tab_meca.stato
		
		kst_tab_armo.id_armo = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_armo")
		kst_tab_armo.magazzino = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "magazzino") 
		kst_tab_armo.art = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "art") 
		kst_tab_armo.campione = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "campione") 
		kst_tab_armo.dose = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "dose") 
		kst_tab_armo.colli_1 = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "colli_2") 
		kst_tab_armo.colli_2 = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "colli_2") 
		kst_tab_armo.colli_fatt = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "colli_fatt") 
		kst_tab_armo.pedane = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "pedane") 
		kst_tab_armo.larg_1 = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "larg_2") 
		kst_tab_armo.larg_2 = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "larg_2") 
		kst_tab_armo.lung_1 = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "lung_2") 
		kst_tab_armo.lung_2 = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "lung_2") 
		kst_tab_armo.alt_1 = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "alt_2") 
		kst_tab_armo.alt_2 = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "alt_2") 
		kst_tab_armo.peso_kg = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "peso_kg") 
		kst_tab_armo.m_cubi = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "m_cubi") 
		kst_tab_armo.cod_sl_pt = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "cod_sl_pt") 
		kst_tab_armo.id_listino = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_listino") 
		kst_tab_armo.note_1 = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "note_1") 
		kst_tab_armo.note_2 = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "note_2") 
		kst_tab_armo.note_3 = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "note_3") 
		kst_tab_armo.travaso = "N"

//--- Aggiorna le righe 
		kst_tab_armo.id_armo = kiuf_armo.tb_update_armo( kst_tab_armo )
		tab_1.tabpage_4.dw_4.setitem (k_riga, "id_armo", kst_tab_armo.id_armo )
		
//--- Aggiorna le NOTE 
		for k_ctr = 1 to 10
			kst_tab_armo_nt.note[k_ctr] = trim(tab_1.tabpage_4.dw_4.getitemstring(k_riga, "armo_nt_note_" + string(k_ctr)))
		next
		kst_tab_armo_nt.id_armo = kst_tab_armo.id_armo
		kiuf_armo_nt.tb_update_armo_nt( kst_tab_armo_nt )

		k_riga++

	loop


//--- Se tutto OK faccio la COMMIT		
	kguo_sqlca_db_magazzino.db_commit( )    

	if tab_1.tabpage_1.dw_1.getitemnumber(1, "num_int") <> kist_tab_meca_orig.num_int then
		kguo_exception.setmessage( "Modificato il numero iniziale impostato per questo LOTTO")
		kguo_exception.messaggio_utente( )
	end if

//---- azzera il flag delle modifiche
	tab_1.tabpage_1.dw_1.ResetUpdate ( ) 
	tab_1.tabpage_4.dw_4.ResetUpdate ( ) 
		
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then

//--- modalità diventa a modifica
		ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica

//--- aggiorna nel BASE il num. se sono in inserimento e + grande di quello presente
		kst_tab_base.st_tab_g_0.esegui_commit = "S" 
		kst_tab_base.key = "num_int"
		kst_tab_base.num_int = integer(mid(kuf1_base.prendi_dato_base( kst_tab_base.key ),2 ))
		kst_tab_base.key = "data_int"
		kst_tab_base.data_int = date(mid(kuf1_base.prendi_dato_base( kst_tab_base.key ),2 ))
		if kst_tab_meca.num_int > kst_tab_base.num_int and year(kst_tab_meca.data_int) = year(kst_tab_base.data_int) then
			kst_tab_base.key = "num_int"
			kst_tab_base.key1 = string(kst_tab_meca.num_int )
			kst_esito_base = kuf1_base.metti_dato_base( kst_tab_base )
			if kst_esito_BASE.esito = kkg_esito.ok then 
				kst_tab_base.key = "data_int"
				kst_tab_base.key1 = string(kst_tab_meca.data_int )
				kst_esito_base = kuf1_base.metti_dato_base( kst_tab_base )
			end if
			if kst_esito_BASE.esito <> kkg_esito.ok then 
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlerrtext = "Fallito aggiornamento Proprietà Azienda del Numero LOTTO, procedere manualmene!! " + "~n~r" + trim(kst_esito_base.sqlerrtext) 
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	end if
		
catch (uo_exception kuo_exception)
	kguo_sqlca_db_magazzino.db_rollback()   // ROLLBACK
	throw kuo_exception
//	kst_esito = kuo_exception.get_st_esito( )
//	kst_esito.esito = kkg_esito.db_ko
//	kst_esito.sqlerrtext = "Fallito aggiornamento archivio LOTTI! " + "~n~r" + trim(kst_esito.sqlerrtext) 
	

finally
	setpointer(kkg.pointer_default)
	
end try


end subroutine

private function integer u_get_nr_colli_xbcode ();//---
//--- Calcola il nr colli per generare i barcode dall'elenco righe
//--- 
//--- out: nr colli
//
int k_return = 0
int k_righe = 0, k_riga = 0


	k_righe = tab_1.tabpage_4.dw_4.rowcount()

	for k_riga = 1 to k_righe
		if tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "magazzino") <> 1 then
			
			if trim(tab_1.tabpage_4.dw_4.getitemstring(k_riga, "cod_sl_pt")) > " " then
				k_return += tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "colli_2")
			end if
		end if
	end for
		
return k_return 	


end function

private subroutine set_id_causale_da_contratto () throws uo_exception;//
//--- Imposta CAUSALE se indicato su Contratto
//
st_tab_contratti kst_tab_contratti
st_tab_meca_causali kst_tab_meca_causali
st_esito kst_esito


	try
	
		SetPointer(kkg.pointer_attesa)

		kst_tab_contratti.codice = tab_1.tabpage_1.dw_1.getitemnumber( 1, "contratto")
		
		if kst_tab_contratti.codice > 0 then
			kst_tab_meca_causali.id_meca_causale = kiuf_contratti.get_id_meca_causale(kst_tab_contratti)

//--- set dei dati della CAUSALE
			set_dati_causale(kst_tab_meca_causali)
			
		end if

		SetPointer(kkg.pointer_default)

	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
	
	end try


end subroutine

private subroutine set_ricevente_fatturato () throws uo_exception;//
//--- Imposta Ricevente e Fatturato se ci riesce
//
long k_righe=0
string k_dataobject = ""
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
kuf_elenco kuf1_elenco
st_open_w kst_open_w 
//kuf_menu_window kuf1_menu_window
datastore kds_mrf_ok

	try
	
		SetPointer(kkg.pointer_attesa)

		kst_tab_meca.contratto = tab_1.tabpage_1.dw_1.getitemnumber( 1, "contratto")
		kst_tab_meca.clie_1 = tab_1.tabpage_1.dw_1.getitemnumber( 1, "clie_1")
		if kst_tab_meca.contratto > 0 then
			k_dataobject = "d_m_r_f_l_3xcontratto"
		else
			k_dataobject = "d_m_r_f_l_3"
		end if
		
		if not isvalid(kids_elenco_mrf) then 
			kids_elenco_mrf = create datastore
			kids_elenco_mrf.dataobject = k_dataobject
			kids_elenco_mrf.settransobject(kguo_sqlca_db_magazzino)
		end if
		if kids_elenco_mrf.dataobject <> k_dataobject then
			kids_elenco_mrf.dataobject = k_dataobject
			kids_elenco_mrf.settransobject(kguo_sqlca_db_magazzino )
		end if
		kids_elenco_mrf.reset()
		if kst_tab_meca.clie_1 > 0 then
			if k_dataobject = "d_m_r_f_l_3" then
				k_righe = kids_elenco_mrf.retrieve(kst_tab_meca.clie_1)
			else
				if kst_tab_meca.contratto > 0 then
					k_righe = kids_elenco_mrf.retrieve(kst_tab_meca.clie_1, kst_tab_meca.contratto)
				end if
			end if
		end if

		if k_righe > 0 then
			kst_tab_meca.clie_2 = kids_elenco_mrf.getitemnumber( 1, "clie_2")
			kst_tab_meca.clie_3 = kids_elenco_mrf.getitemnumber( 1, "clie_3")
			if k_righe = 1 then
				
//--- se c'e' una sola scelta la imposta in automatico		
				kst_tab_clienti.codice = kst_tab_meca.clie_2
				put_video_clie_2(kst_tab_clienti)  
				kst_tab_clienti.codice = kst_tab_meca.clie_3
				put_video_clie_3(kst_tab_clienti)

			else
			
//---- test x verificare che le anagrafiche gia' impostate non siano gia' contenute in elenco ovvero saranno lasciate così			
				if u_if_mrf_ok(kst_tab_meca) then 
					
					kst_tab_clienti.codice = kst_tab_meca.clie_2
					put_video_clie_2(kst_tab_clienti)
					kst_tab_clienti.codice = kst_tab_meca.clie_3
					put_video_clie_3(kst_tab_clienti)
					
				else	// se non congruente attiva l'elenco				
					kst_tab_meca.clie_2 = 0  // se triade non congruente con il contratto azzera 
					kst_tab_meca.clie_3 = 0  // se triade non congruente con il contratto azzera 
				end if

//--- se ricevente ancora a ZERO faccio vedere l'leneco per sceglere				
				if kst_tab_meca.clie_2 = 0 then
					kuf1_elenco = create kuf_elenco
					kst_open_w.flag_modalita = kkg_flag_modalita_elenco
					kst_open_w.key1 = "Elenco Riceventi-Clienti per Mandante " + string(kst_tab_meca.clie_1) + " e Contratto " + string(kst_tab_meca.contratto) 
					kst_open_w.key2 = trim(kids_elenco_mrf.dataobject)
					kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
					kst_open_w.key4 = trim(this.title)    //--- Titolo della Window di chiamata per riconoscerla
					kst_open_w.key7 = "N"    //--- dopo la scelta NON chiudere la Window di elenco
					kst_open_w.key12_any = kids_elenco_mrf
					kuf1_elenco.u_open(kst_open_w)
				end if
			end if
			
		else
			kguo_exception.inizializza( )	
			kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_not_fnd)
			if kst_tab_meca.contratto > 0 then
				kguo_exception.setmessage("Nessuna associazione trovata per il Mandante " + string(kst_tab_meca.clie_1) + " e Contratto " + string(kst_tab_meca.contratto) )
			else
				kguo_exception.setmessage("Nessuna associazione trovata per il Mandante " + string(kst_tab_meca.clie_1) + " "  )
			end if
			throw kguo_exception
		end if

		SetPointer(kkg.pointer_default)

	
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
	
	end try


end subroutine

private subroutine set_contratto (st_tab_contratti ast_tab_contratti) throws uo_exception;//
//--- Trova il Contratto
//--- Imput sc_cf e mc_co oppure il codice contratto
//
st_tab_contratti kst_tab_contratti
st_esito kst_esito


	try
		if ast_tab_contratti.codice > 0 then
		else
			if trim(ast_tab_contratti.mc_co) > " " then
				if isnull(ast_tab_contratti.sc_cf) then ast_tab_contratti.sc_cf = ""
				ast_tab_contratti.data_scad = tab_1.tabpage_1.dw_1.getitemdate(1, "data_int")
				ast_tab_contratti.codice = kiuf_contratti.get_contratto_da_cf_co(ast_tab_contratti)
			else
				ast_tab_contratti.codice = 0
			end if
		end if
		if ast_tab_contratti.codice > 0 then
	
			tab_1.tabpage_1.dw_1.setitem(1, "contratto", ast_tab_contratti.codice)
			tab_1.tabpage_1.dw_1.setitem(1, "contratti_sc_cf", trim(ast_tab_contratti.sc_cf))
			tab_1.tabpage_1.dw_1.setitem(1, "contratti_mc_co", trim(ast_tab_contratti.mc_co))

			set_ricevente_fatturato()
			set_id_causale_da_clie_3()  // causale di blocco sul cliente ha la priorità
			set_id_causale_da_contratto()
		else
			tab_1.tabpage_1.dw_1.setitem(1, "contratto", 0)
			tab_1.tabpage_1.dw_1.setitem(1, "contratti_sc_cf", "")
			tab_1.tabpage_1.dw_1.setitem(1, "contratti_mc_co", "")
		end if
	
		SetPointer(kkg.pointer_attesa)

	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
	
	end try


end subroutine

private subroutine set_causale_lotto (st_tab_meca_causali ast_tab_meca_causali);//
//--- Imposta i dati CAUSALE compreso il BLOCCO del LOTTO
//
long k_riga=0
st_esito kst_esito
st_tab_meca kst_tab_meca
st_tab_meca_causali kst_tab_meca_causali

tab_1.tabpage_1.dw_1.modify( "meca_blk_id_meca_causale.Background.Color = '" + string(KK_COLORE_BIANCO) + "' " ) 
tab_1.tabpage_1.dw_1.setitem( 1, "meca_blk_id_meca_causale", ast_tab_meca_causali.id_meca_causale )


kst_esito = kiuf_ausiliari.tb_select(ast_tab_meca_causali)
if kst_esito.esito = kkg_esito.ok then
	
	if trim(kst_tab_meca_causali.descrizione) > " " then 
	else
		kst_tab_meca_causali.descrizione = tab_1.tabpage_1.dw_1.getitemstring( 1, "meca_blk_descrizione")
		tab_1.tabpage_1.dw_1.setitem(1, "meca_blk_descrizione", trim(ast_tab_meca_causali.descrizione))
	end if

	kst_tab_meca.id = tab_1.tabpage_1.dw_1.getitemnumber( 1, "id_meca")

//--- codice BLOCCO da attivare?
	if ast_tab_meca_causali.cod_blk > 0 then 
		kst_tab_meca.stato = 0
		if kst_tab_meca.id > 0 then
			kst_esito = kiuf_armo.get_stato(kst_tab_meca)
			if kst_esito.esito <> kkg_esito.ok then
				kst_tab_meca.stato = 0
			end if
		end if
		if kst_tab_meca.stato > 0 then
		else
			tab_1.tabpage_1.dw_1.setitem(1, "stato", kiuf_armo.ki_meca_stato_blk)
		end if
	end if

//--- Cliente da causale da impostare?
	if ast_tab_meca_causali.clie_1 > 0 then 
		tab_1.tabpage_1.dw_1.setitem(1, "clie_1", ast_tab_meca_causali.clie_1)
	end if
	
end if
		
end subroutine

private subroutine set_dati_causale (st_tab_meca_causali ast_tab_meca_causali) throws uo_exception;//
//--- Set dati CAUSALE 
//
st_tab_meca kst_tab_meca
st_esito kst_esito


	try
	
		SetPointer(kkg.pointer_attesa)

//--- get dei dati della CAUSALE
		if ast_tab_meca_causali.id_meca_causale > 0 then
			kst_esito = kiuf_ausiliari.tb_select(ast_tab_meca_causali)
			if kst_esito.esito <> kkg_esito.ok then
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
			if ast_tab_meca_causali.cod_blk > 0 then  // se sulla causale ho trovato che lo stato è da bloccare
				kst_tab_meca.stato = tab_1.tabpage_1.dw_1.getitemnumber( 1, "stato")
				if kst_tab_meca.stato = kiuf_armo.ki_meca_stato_ok then
					tab_1.tabpage_1.dw_1.setitem(1, "stato", kiuf_armo.ki_meca_stato_blk ) // BLOCCA!!
					tab_1.tabpage_1.dw_1.setitem(1, "meca_blk_id_meca_causale", ast_tab_meca_causali.id_meca_causale)
					tab_1.tabpage_1.dw_1.setitem(1, "meca_blk_descrizione", trim(ast_tab_meca_causali.descrizione))
				end if
			end if

		end if

		SetPointer(kkg.pointer_default)

	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
	
	end try


end subroutine

private subroutine set_id_causale_da_clie_3 () throws uo_exception;//
//--- Imposta CAUSALE se indicato su CLIENTE
//
st_tab_clienti kst_tab_clienti
st_tab_meca_causali kst_tab_meca_causali
st_esito kst_esito


	try
	
		SetPointer(kkg.pointer_attesa)

		kst_tab_clienti.codice = tab_1.tabpage_1.dw_1.getitemnumber( 1, "clie_3")
		
		if kst_tab_clienti.codice > 0 then
			kst_tab_meca_causali.id_meca_causale = kiuf_clienti.get_id_meca_causale(kst_tab_clienti) 

//--- set dei dati della CAUSALE
			set_dati_causale(kst_tab_meca_causali)

		end if

		SetPointer(kkg.pointer_default)

	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
	
	end try


end subroutine

private subroutine u_dw_riga_ricalcolo_1 (ref st_tab_armo ast_tab_armo, st_tab_listino ast_tab_listino);//--
//---  Ricalcolo dei campi in base al numero colli indicato in INPUT
//---

	
	if ast_tab_armo.colli_2 > 0 then
		if ast_tab_listino.occup_ped > 0 then
			ast_tab_armo.pedane = ast_tab_armo.colli_2 * ast_tab_listino.occup_ped / 100
		else
			ast_tab_armo.pedane = 0
		end if
		if ast_tab_listino.peso_kg > 0 then
			ast_tab_armo.peso_kg = ast_tab_armo.colli_2 * ast_tab_listino.peso_kg
		else
			ast_tab_armo.peso_kg = 0
		end if
		if ast_tab_listino.m_cubi_f > 0 then
			ast_tab_armo.m_cubi = ast_tab_armo.colli_2 * ast_tab_listino.m_cubi_f
		else
			ast_tab_armo.m_cubi = 0
		end if
	else
		ast_tab_listino.occup_ped = 0
		ast_tab_listino.peso_kg = 0
		ast_tab_armo.m_cubi = 0
	end if
	




end subroutine

private subroutine u_dw_riga_ricalcolo (ref st_tab_armo ast_tab_armo);//--
//---  Ricalcolo dei campi in base al numero colli indicato in INPUT
//---
st_tab_listino kst_tab_listino

try
	if ast_tab_armo.colli_2 > 0 then

		kst_tab_listino.occup_ped = dw_riga.getitemnumber(1, "listino_occup_ped")
		kst_tab_listino.peso_kg = dw_riga.getitemnumber(1, "listino_peso_kg")
		kst_tab_listino.m_cubi_f = dw_riga.getitemnumber(1, "listino_m_cubi")
		u_dw_riga_ricalcolo_1(ast_tab_armo, kst_tab_listino)

		if ast_tab_armo.pedane > 0 then
		else
			ast_tab_armo.pedane = dw_riga.getitemnumber(1, "pedane")
		end if
		if ast_tab_armo.peso_kg > 0 then
		else
			ast_tab_armo.peso_kg = dw_riga.getitemnumber(1, "peso_kg")
		end if
		if ast_tab_armo.m_cubi > 0 then
		else
			ast_tab_armo.m_cubi = dw_riga.getitemnumber(1, "m_cubi")
		end if
		
	else
		kst_tab_listino.occup_ped = 0
		kst_tab_listino.peso_kg = 0
		ast_tab_armo.m_cubi = 0
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try




end subroutine

on w_lotto.create
int iCurrent
call super::create
this.dw_x_copia=create dw_x_copia
this.dw_riga=create dw_riga
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_x_copia
this.Control[iCurrent+2]=this.dw_riga
end on

on w_lotto.destroy
call super::destroy
destroy(this.dw_x_copia)
destroy(this.dw_riga)
end on

event u_ricevi_da_elenco;call super::u_ricevi_da_elenco;//
//
int k_rc
long  k_riga, k_righe
datastore kds_elenco_input_appo


if isvalid(kst_open_w) then

		if isnumber(kst_open_w.key3) then
			if long(kst_open_w.key3) > 0 then 
		
				if not isvalid(kds_elenco_input_appo) then kds_elenco_input_appo = create datastore
				kds_elenco_input_appo = kst_open_w.key12_any 
				kids_elenco_input.dataobject = kds_elenco_input_appo.dataobject
				kids_elenco_input.reset()
				if not isvalid(kids_elenco_input) then kids_elenco_input = create datastore
				kds_elenco_input_appo.rowscopy( 1, kds_elenco_input_appo.rowcount( ) , primary!,kids_elenco_input, 1,primary!)
				
//				kids_elenco_input = kst_open_w.key12_any 
				k_riga = long(kst_open_w.key3)

//--- Valorizza l'oggetto DW per passarli all'evento di DROP
				dw_x_copia.dataobject = kids_elenco_input.dataobject
				dw_x_copia.reset( )
				k_righe = kids_elenco_input.rowcount()
				if k_righe > 0 then
				
					k_rc = kids_elenco_input.rowscopy(1, k_righe, Primary!, dw_x_copia, 1, Primary! )
					dw_x_copia.selectrow(0, true)  //--- seleziono tutte le righe tanto devo trattarle tutte
					dragdrop_dw_esterna( dw_x_copia, k_riga )
					
				end if
			end if
		end if
		
end if



attiva_tasti()



end event

type st_ritorna from w_g_tab_3`st_ritorna within w_lotto
integer y = 1808
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_lotto
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_lotto
integer y = 1804
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_lotto
integer y = 1640
end type

type st_stampa from w_g_tab_3`st_stampa within w_lotto
integer y = 1732
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_lotto
integer y = 1612
end type

event cb_visualizza::clicked;//


	choose case tab_1.selectedtab
		case 1
		case 4
			if tab_1.tabpage_4.dw_4.getselectedrow(0) > 0 then
				riga_modifica()		
				dw_riga.event u_visualizza()
			end if
			
	end choose



end event

type cb_modifica from w_g_tab_3`cb_modifica within w_lotto
integer y = 1708
integer weight = 700
fontcharset fontcharset = ansi!
end type

event cb_modifica::clicked;//


	choose case ki_tab_1_index_new
		case 1
		case 4
			if tab_1.tabpage_4.dw_4.getselectedrow(0) > 0 then
				riga_modifica()		
				dw_riga.event u_modifica()
			end if
			
	end choose



end event

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_lotto
integer y = 1708
end type

event cb_aggiorna::clicked;//
string k_esito
int k_nr_barcode = 0
st_tab_barcode kst_tab_barcode
st_tab_meca kst_tab_meca


try
	k_esito = aggiorna_dati( )    // Aggiorna LOTTO

	if trim(k_esito) = "0" then // OK aggiornamento
		kst_tab_meca.id = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_meca")
		kst_tab_meca.stato = tab_1.tabpage_1.dw_1.getitemnumber(1, "stato")
//--- se STATO 'normale' ...
		if kst_tab_meca.stato = kiuf_armo.ki_meca_stato_ok then
			kst_tab_barcode.id_meca = kst_tab_meca.id
//			if kiuf_barcode_ini.if_da_generare(kst_tab_barcode) then
//				kst_tab_barcode.st_tab_g_0.esegui_commit = "S"
//				k_nr_barcode = kiuf_barcode_ini.lotto_genera_barcode(kst_tab_barcode)  // GENERA BARCODE
//			end if
			k_nr_barcode = u_get_nr_colli_xbcode( ) - kiuf_barcode_ini.get_nr_barcode_generati(kst_tab_barcode) // Ottiene la differenza dei barcode tra eventuale prima e attuale
			if k_nr_barcode > 0 then
				messagebox("Aggiornamento Lotto", "Operazione completata correttamente. Ricorda di generare " + string(k_nr_barcode) + " barcode.", information!)
			else
				if k_nr_barcode < 0 then
					messagebox("Aggiornamento Lotto", "Operazione completata correttamente. Ricorda di rigenerare i barcode per distruggerne " + string(k_nr_barcode) + ".", information!)
				else
					messagebox("Aggiornamento Lotto", "Operazione completata correttamente.", information!)
				end if
			end if
		else
			messagebox("Aggiornamento Lotto", "Operazione Completata, ma lo stato '" + string(kst_tab_meca.stato) + "' non consente ancora di generare i Barcode!!", information!)

		end if

		inizializza()
//		attiva_tasti()

	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try

end event

type cb_cancella from w_g_tab_3`cb_cancella within w_lotto
integer y = 1708
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_lotto
integer y = 1708
integer height = 92
end type

type tab_1 from w_g_tab_3`tab_1 within w_lotto
boolean visible = true
integer x = 55
integer width = 3195
integer height = 1556
end type

on tab_1.create
call super::create
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6,&
this.tabpage_7,&
this.tabpage_8,&
this.tabpage_9}
end on

on tab_1.destroy
call super::destroy
end on

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
integer width = 3159
integer height = 1428
long backcolor = 32435950
string text = "Testata"
string picturename = "Custom081!"
long picturemaskcolor = 32435950
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
event u_enter ( )
boolean visible = true
integer x = 0
integer y = 28
integer width = 2953
integer height = 1308
string dataobject = "d_meca_testata"
boolean ki_link_standard_sempre_possibile = true
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_d_std_1_attiva_cerca = false
boolean ki_abilita_ddw_proposta = true
end type

event dw_1::itemchanged;call super::itemchanged;//
string k_nome
long k_riga, k_return=0
st_tab_clienti kst_tab_clienti, kst_tab_clienti3
st_tab_meca kst_tab_meca
st_tab_meca_causali kst_tab_meca_causali
st_tab_contratti kst_tab_contratti
st_esito kst_esito
datawindowchild kdwc_1


try
	choose case dwo.name 

		case "num_int", "data_int"
			if dwo.name = "num_int" then
				kst_tab_meca.num_int = long(data)
				kst_tab_meca.data_int = this.getitemdate( row, "data_int")
				u_inizializza(kst_tab_meca)
			else
				kst_tab_meca.data_int = date(data)
				kst_tab_meca.num_int = this.getitemnumber( row, "num_int")
				if year(this.getitemdate( row, "data_int")) <> year(kst_tab_meca.data_int) then
					u_inizializza(kst_tab_meca)
				end if
			end if
////--- se trovo già un altro LOTTO lo visualizzo			
//			kst_esito = kiuf_armo.get_id_meca(kst_tab_meca)
//			if kst_esito.esito <> kkg_esito.ok then
//			else
////--- se non trovo LOTTO ripristino il corretto valore di DATA e NUMERO
//				if dwo.name = "num_int" then
//					kist_tab_meca.num_int = kiuf_armo.get_numero_nuovo()
//					this.setitem( row, "num_int", kist_tab_meca.num_int)
//				else
//					kist_tab_meca.data_int = kguo_g.get_dataoggi( )
//					this.setitem( row, "data_int", kist_tab_meca.data_int)
//				end if
//			end if
			
			
		case "rag_soc_10" 
			if len(trim(data)) > 0 then 
				this.getchild(dwo.name, kdwc_1)
				k_riga = kdwc_1.find( "rag_soc_1 like '" + trim(data) + "%" +"'" , 1, kdwc_1.rowcount())
				if k_riga > 0 then
					kst_tab_clienti.codice = kdwc_1.getitemnumber( k_riga, "id_cliente")
					get_dati_cliente(kst_tab_clienti)
					post put_video_clie_1(kst_tab_clienti)
				else
					this.object.id_cliente[1] = 0
					this.modify( dwo.name + ".Background.Color = '" + string(KK_COLORE_ERR_DATO) + "' ") 
				end if
			else
				set_iniz_dati_cliente(kst_tab_clienti)
				post put_video_clie_1(kst_tab_clienti)
			end if
	
		case "clie_1" 
			if len(trim(data)) > 0 then 
				this.getchild(dwo.name, kdwc_1)
				k_riga = kdwc_1.find( "id_cliente = " + trim(data) + " " , 1, kdwc_1.rowcount())
				if k_riga > 0 then
					kst_tab_clienti.codice = long(trim(data))
					get_dati_cliente(kst_tab_clienti)
					post put_video_clie_1(kst_tab_clienti)
				else
					this.modify( dwo.name + ".Background.Color = '" + string(KK_COLORE_ERR_DATO) + "' ") 
				end if
			else
				set_iniz_dati_cliente(kst_tab_clienti)
				post put_video_clie_1(kst_tab_clienti)
			end if
	
		case "p_iva", "cf" 
			if len(trim(data)) > 0 then 
				this.getchild("clie_1", kdwc_1)
				k_nome = dwo.name + " like '" + trim(data) + "%" +"' " 
				k_riga = kdwc_1.find( k_nome, 1, kdwc_1.rowcount())
				if k_riga > 0 then
					kst_tab_clienti.codice = kdwc_1.getitemnumber( k_riga, "id_cliente")
					get_dati_cliente(kst_tab_clienti)
					post put_video_clie_1(kst_tab_clienti)
				else
					this.object.id_cliente[1] = 0
					this.modify( dwo.name + ".Background.Color = '" + string(KK_COLORE_ERR_DATO) + "' ") 
				end if
			else
				set_iniz_dati_cliente(kst_tab_clienti)
				post put_video_clie_1(kst_tab_clienti)
			end if
	
		case "meca_blk_id_meca_causale" 
			if len(trim(data)) > 0 then 
				this.getchild(dwo.name, kdwc_1)
				k_riga = kdwc_1.find( "id_meca_causale = '" + trim(data) + "' " , 1, kdwc_1.rowcount())
				if k_riga > 0 then
					kst_tab_meca_causali.id_meca_causale = long(trim(data))
					post set_causale_lotto(kst_tab_meca_causali)
				else
					this.setitem(1, "meca_blk_id_meca_causale", " " )
					this.modify( dwo.name + ".Background.Color = '" + string(KK_COLORE_ERR_DATO) + "' ") 
				end if
			else
				this.setitem(1, "meca_blk_id_meca_causale", " " )
			end if
	
//--- Verifica Campi contratto 
		case "contratti_sc_cf"
			kst_tab_contratti.sc_cf = trim(data)
			kst_tab_contratti.mc_co = this.getitemstring(row, "contratti_mc_co")
			kst_tab_contratti.codice = 0
			post set_contratto(kst_tab_contratti)
		case "contratti_mc_co"
			kst_tab_contratti.sc_cf = this.getitemstring(row, "contratti_sc_cf")
			kst_tab_contratti.mc_co = trim(data)
			kst_tab_contratti.codice = 0
			post set_contratto(kst_tab_contratti)
			
	end choose 

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()

end try
	
end event

event dw_1::ue_drop_out;call super::ue_drop_out;//
		dragdrop_dw_esterna( kdw_source, k_droprow )
		
return 1

end event

event dw_1::clicked;call super::clicked;//
//=== Premuto pulsante nella DW
//
string k_nome

	this.accepttext( )

	k_nome = lower(trim(dwo.name))
	choose case k_nome

//--- elenco Causali
		case "p_img_causale"
			if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita =  kkg_flag_modalita.modifica then
				call_elenco_causali()
			else
				messagebox("Operazione bloccata", "Funzione non attiva per questa modalità", Information!)
			end if

//--- elenco Mandanti
		case "p_img_mandanti"
			if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita =  kkg_flag_modalita.modifica then
				call_elenco_mandanti()
			else
				messagebox("Operazione bloccata", "Funzione non attiva per questa modalità", Information!)
			end if

//--- elenco riceventi-fatt per il mandante-contratto indicato
		case "p_img_mrf"
			if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita =  kkg_flag_modalita.modifica then
				call_elenco_mrf()
			else
				messagebox("Operazione bloccata", "Funzione non attiva per questa modalità", Information!)
			end if

		case "p_img_elenco_contratti"
			if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita =  kkg_flag_modalita.modifica then
				call_contratti_x_clie_1()
			else
				messagebox("Operazione bloccata", "Funzione non attiva per questa modalità", Information!)
			end if
		
			
////--- pdf
//		case "p_img_lettera_vedi" 
//			run_app_lettera()
				
	end choose


	post attiva_tasti()

end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
boolean visible = false
integer width = 3159
integer height = 1428
boolean enabled = false
string text = "no"
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
integer width = 2939
integer height = 1320
end type

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
integer width = 3159
integer height = 1428
boolean enabled = false
long backcolor = 33026800
string text = "no"
long tabbackcolor = 32435950
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
boolean visible = true
integer x = 0
integer y = 28
integer width = 3141
integer height = 752
boolean enabled = true
boolean hscrollbar = false
boolean vscrollbar = false
boolean hsplitscroll = false
boolean livescroll = false
end type

event dw_3::buttonclicked;call super::buttonclicked;//
//=== Attivo/Disattivo visione grafico
if this.object.kgr_1.visible = "1" then
	tab_1.tabpage_3.dw_3.object.kcb_gr.text = "Grafico"
	tab_1.tabpage_3.dw_3.object.kgr_1.visible = "0" 
else
	tab_1.tabpage_3.dw_3.object.kcb_gr.text = "Dati"
	tab_1.tabpage_3.dw_3.object.kgr_1.visible = "1"
end if
//

end event

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
integer x = 229
integer y = 1220
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
boolean visible = true
integer width = 3159
integer height = 1428
long backcolor = 32435950
string text = "righe"
string picturename = "DataWindow5!"
end type

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
boolean visible = true
integer x = 41
integer y = 12
integer width = 3054
boolean enabled = true
string dataobject = "d_armo_l_righe"
boolean ki_in_drag = true
end type

event dw_4::ue_drop_out;//
		dragdrop_dw_esterna( kdw_source, k_droprow )
		
return 1

end event

event dw_4::doubleclicked;//

if this.ki_flag_modalita = kkg_flag_modalita_inserimento or this.ki_flag_modalita = kkg_flag_modalita_modifica then

	cb_modifica.event clicked( )
	
else
	
	cb_visualizza.event clicked( )	
	
end if
	
	
end event

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
boolean visible = true
integer width = 3159
integer height = 1428
string text = "barcode"
long picturemaskcolor = 553648127
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
boolean visible = true
integer width = 2153
integer height = 1296
boolean enabled = true
string dataobject = "d_barcode_l_2"
boolean ki_link_standard_sempre_possibile = true
end type

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
integer width = 3159
integer height = 1428
string text = "no"
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
integer width = 2761
integer height = 1280
end type

event dw_6::buttonclicked;call super::buttonclicked;//
//=== Attivo/Disattivo visione grafico
if this.object.kgr_1.visible = "1" then
	tab_1.tabpage_6.dw_6.object.kcb_gr.text = "Grafico"
	tab_1.tabpage_6.dw_6.object.kgr_1.visible = "0" 
else
	tab_1.tabpage_6.dw_6.object.kcb_gr.text = "Dati"
	tab_1.tabpage_6.dw_6.object.kgr_1.visible = "1"
end if
//

end event

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
integer width = 3159
integer height = 1428
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
end type

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
integer width = 3159
integer height = 1428
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
integer width = 3159
integer height = 1428
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
end type

type dw_x_copia from uo_d_std_1 within w_lotto
integer x = 123
integer y = 1808
integer width = 338
integer height = 368
integer taborder = 70
boolean bringtotop = true
boolean hsplitscroll = false
boolean livescroll = false
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_attivi = false
boolean ki_button_standard_attivi = false
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_cerca = false
end type

type dw_riga from uo_d_sped_riga within w_lotto
event u_posiziona ( )
event u_visualizza ( )
event u_modifica ( )
event type integer u_aggiorna ( long a_riga )
integer x = 101
integer y = 1256
integer width = 4279
integer taborder = 50
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string title = "Dettaglio Riga"
string dataobject = "d_armo_riga"
boolean controlmenu = true
boolean hsplitscroll = false
boolean ki_disattiva_moment_cb_aggiorna = false
end type

event u_posiziona();//
//--- posizione
//
this.x = parent.width / 5
this.y = parent.height / 4
//


end event

event u_visualizza();//======================================================================
//=== 
//======================================================================
//
kuf_utility kuf1_utility


	kuf1_utility = create kuf_utility
	this.object.b_ok.visible = false 
	this.object.b_esci.visible = false 
     kuf1_utility.u_proteggi_dw("1", 0, dw_riga)
//     kuf1_utility.u_proteggi_dw("1", "iva", dw_riga)
//     kuf1_utility.u_proteggi_dw("1", "art", dw_riga)
	this.visible = true
	destroy kuf1_utility

end event

event u_modifica();//======================================================================
//=== 
//======================================================================
//
st_tab_armo kst_tab_armo
st_tab_arsp kst_tab_arsp 
kuf_sped kuf1_sped
kuf_utility kuf1_utility


try
	this.object.b_ok.visible = true 
	this.object.b_esci.visible = true 
	
	kuf1_utility = create kuf_utility 
	kuf1_sped = create kuf_sped

	kuf1_utility.u_proteggi_dw("0", 0, dw_riga)   // sproteggo tutto
	
	kst_tab_armo.id_armo = this.getitemnumber(1, "id_armo")

	if kst_tab_armo.id_armo > 0 then

//--- se riga spedita non possiamo cambiare il numero colli		
		kst_tab_arsp.id_armo = kst_tab_armo.id_armo
		if kuf1_sped.get_colli_x_id_armo(kst_tab_arsp) > 0 then
			kuf1_utility.u_proteggi_dw("1", "colli_2", dw_riga)
			kuf1_utility.u_proteggi_dw("1", "pedane", dw_riga)
		else	
//--- se riga pianificata non possiamo cambiare il numero colli	
			if kiuf_armo.if_lotto_pianificato_xriga(kst_tab_armo) then
				kuf1_utility.u_proteggi_dw("1", "colli_2", dw_riga)
				kuf1_utility.u_proteggi_dw("1", "pedane", dw_riga)
			else
				kuf1_utility.u_proteggi_dw("0", "colli_2", dw_riga)
				kuf1_utility.u_proteggi_dw("0", "pedane", dw_riga)
			end if
		end if

//--- se sono in inserimento riga di certo non posso impostare i colli fatturati	
		kuf1_utility.u_proteggi_dw("1", "colli_fatt", dw_riga)
	else
		kuf1_utility.u_proteggi_dw("0", "colli_fatt", dw_riga)
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try

	
end event

event type integer u_aggiorna(long a_riga);//======================================================================
//=== 
//======================================================================
//
long k_riga, k_progressivo
st_tab_armo kst_tab_armo
st_tab_armo_nt kst_tab_armo_nt
st_tab_prodotti kst_tab_prodotti


	try

		tab_1.selectedtab = 4
		this.setfocus( )

		kiuf_armo.if_isnull_armo( kst_tab_armo )
		kiuf_armo_nt.if_isnull_armo_nt( kst_tab_armo_nt )
	
		k_riga = this.getrow( )
		if k_riga > 0 then
			kst_tab_armo.stato = this.getitemnumber(k_riga, "stato")
			kst_tab_armo.magazzino = this.getitemnumber(k_riga, "magazzino")
			kst_tab_armo.art = this.getitemstring(k_riga, "art")
			kst_tab_prodotti.des = this.getitemstring(k_riga, "des")
			kst_tab_armo.dose = this.getitemnumber(k_riga, "dose")
			kst_tab_armo.larg_2 = this.getitemnumber(k_riga, "larg_2")
			kst_tab_armo.lung_2 = this.getitemnumber(k_riga, "lung_2")
			kst_tab_armo.alt_2 = this.getitemnumber(k_riga, "alt_2")
			kst_tab_armo.cod_sl_pt = this.getitemstring(k_riga, "cod_sl_pt")
			kst_tab_armo.peso_kg = this.getitemnumber(k_riga, "peso_kg")
			kst_tab_armo.colli_2 = this.getitemnumber(k_riga, "colli_2")
			kst_tab_armo.pedane = this.getitemnumber( k_riga, "pedane")
			kst_tab_armo.colli_fatt = this.getitemnumber(k_riga, "colli_fatt")
			kst_tab_armo.m_cubi = this.getitemnumber( k_riga, "m_cubi")
			kst_tab_armo.id_listino = this.getitemnumber( k_riga, "id_listino")
			kst_tab_armo.id_armo = this.getitemnumber( k_riga, "id_armo")
			kst_tab_armo.id_meca = this.getitemnumber( k_riga, "id_meca")
			kst_tab_armo.num_int = this.getitemnumber( k_riga, "num_int")
			kst_tab_armo.data_int = this.getitemdate( k_riga, "data_int")
			kst_tab_armo.note_1 = this.getitemstring(k_riga, "note_1")
			kst_tab_armo.note_2 = this.getitemstring(k_riga, "note_2")
			kst_tab_armo.note_3 = this.getitemstring(k_riga, "note_3")
			k_progressivo = this.getitemnumber(k_riga, "k_progressivo")

			kst_tab_armo_nt.note[1] = this.getitemstring(k_riga, "armo_nt_note_1")
			kst_tab_armo_nt.note[2] = this.getitemstring(k_riga, "armo_nt_note_2")
			kst_tab_armo_nt.note[3] = this.getitemstring(k_riga, "armo_nt_note_3")
			kst_tab_armo_nt.note[4] = this.getitemstring(k_riga, "armo_nt_note_4")
			kst_tab_armo_nt.note[5] = this.getitemstring(k_riga, "armo_nt_note_5")
			kst_tab_armo_nt.note[6] = this.getitemstring(k_riga, "armo_nt_note_6")
			kst_tab_armo_nt.note[7] = this.getitemstring(k_riga, "armo_nt_note_7")
			kst_tab_armo_nt.note[8] = this.getitemstring(k_riga, "armo_nt_note_8")
			kst_tab_armo_nt.note[9] = this.getitemstring(k_riga, "armo_nt_note_9")
			kst_tab_armo_nt.note[10] = this.getitemstring(k_riga, "armo_nt_note_10")

			if k_progressivo = 0 then
//--- Riga NUOVA
				riga_nuova_in_lista(kst_tab_armo, kst_tab_armo_nt)  
				this.visible = false  // dopo la aggiunta Nascondo la DW
					
			else
//--- Riga MODIFICATA
				riga_modifica_in_lista(k_progressivo, kst_tab_armo, kst_tab_prodotti, kst_tab_armo_nt)  
				this.visible = false  // dopo la modifica Nascondo la DW
					
			end if
		end if
			
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()

	finally
//		attiva_tasti()
	
	end try
	
return 0




end event

event u_constructor;call super::u_constructor;//
post event u_posiziona()

end event

event itemchanged;call super::itemchanged;//
st_tab_armo kst_tab_armo

	choose case dwo.name 

		case "colli_2"
			this.modify( dwo.name + ".Background.Color = '" + string(kkg_colore.bianco ) + "' ") 
			this.modify( "pedane.Background.Color = '" + string(kkg_colore.bianco ) + "' ") 
			kst_tab_armo.colli_2 = integer(data)
			if kst_tab_armo.colli_2 = 0 then
				this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
				messagebox ("Verifica dati fallita", "Attenzione non è possibile caricare ZERO colli, prego verificare", StopSign!)
				return 1
			end if
			u_dw_riga_ricalcolo(kst_tab_armo)
			this.setitem(row, "pedane", kst_tab_armo.pedane)
			this.setitem(row, "peso_kg", kst_tab_armo.peso_kg)
			this.setitem(row, "m_cubi", kst_tab_armo.m_cubi)
//			if kst_tab_armo.colli_2 <> this.getitemnumber(row, "pedane") then
//				this.modify("pedane.Background.Color = '" + string(KKG_COLORE.BLU_CHIARO ) + "' ") 
//			end if
			
		case "pedane"
			this.modify( dwo.name + ".Background.Color = '" + string(kkg_colore.bianco ) + "' ") 
			if integer(data) = 0 then
				this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
				if messagebox ("Verifica dati anomala", "Attenzione sono stati indicati ZERO pedane, proseguire?", Question!, YesNo!, 2 ) = 2 then
					return 1
				end if
			else
				if integer(data) <> this.getitemnumber(row, "colli_2") then
					this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.BLU_CHIARO) + "' ") 
				end if
			end if
	end choose

end event

event getfocus;////
//st_tab_armo_nt kst_tab_armo_nt
//
//try
//	if this.rowcount( ) > 0 then
//		kst_tab_armo_nt.id_armo = this.getitemnumber(1, "id_armo")
//		if kst_tab_armo_nt.id_armo > 0 then
//			kiuf_armo_nt.get_note(kst_tab_armo_nt)
//			riga_modifica_display_note(kst_tab_armo_nt)
//		end if
//	end if
//	
//catch (uo_exception kuo_exception)
//	kuo_exception.messaggio_utente()
//	
//end try
end event

event clicked;call super::clicked;//
//=== Premuto pulsante nella DW
//
string k_nome

	this.accepttext( )

	k_nome = lower(trim(dwo.name))
	choose case k_nome

//--- elenco Articoli
		case "p_img_listino_1"
			if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita =  kkg_flag_modalita.modifica then
				call_art_x_contratto()
			else
				messagebox("Operazione bloccata", "Funzione non attiva per questa modalità", Information!)
			end if

//--- torna con agg riga
		case "b_ok"
			if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita =  kkg_flag_modalita.modifica then
				event u_aggiorna(row)
			else
				messagebox("Operazione bloccata", "Funzione non attiva per questa modalità", Information!)
			end if

//--- chiude
		case "b_esci"
			this.visible = false

		
	end choose


	post attiva_tasti()

end event

