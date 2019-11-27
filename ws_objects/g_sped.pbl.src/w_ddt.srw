$PBExportHeader$w_ddt.srw
forward
global type w_ddt from w_g_tab_3
end type
type dw_riga_0 from uo_d_sped_riga within tabpage_4
end type
type st_orizzontal from statictext within tabpage_4
end type
type dw_anno_numero from datawindow within w_ddt
end type
type dw_x_copia from uo_d_std_1 within w_ddt
end type
end forward

global type w_ddt from w_g_tab_3
integer width = 2446
integer height = 2448
string title = "DDT"
boolean ki_toolbar_window_presente = true
boolean ki_sincronizza_window_consenti = false
boolean ki_fai_nuovo_dopo_update = false
boolean ki_fai_nuovo_dopo_insert = false
dw_anno_numero dw_anno_numero
dw_x_copia dw_x_copia
end type
global w_ddt w_ddt

type variables
//
private kuf_sped kiuf_sped
private kuf_sped_checkmappa kiuf_sped_checkmappa
private st_tab_sped kist_tab_sped, kist_tab_sped_orig
private kuf_armo_inout kiuf_armo_inout

private datastore kids_elenco_da_sped
private datastore kids_elenco_da_sped_dosezero
private datastore kids_elenco_riceventi
private datastore kids_elenco_fatt

kuf_report_merce_da_sped kiuf_report_merce_da_sped

private kuf_armo kiuf_armo 	
private kuf_armo_nt kiuf_armo_nt 	
private kuf_clienti kiuf_clienti  
private kuf_prodotti kiuf_prodotti
private kuf_ausiliari kiuf_ausiliari
private kuf_barcode kiuf_barcode

//private datastore kids_elenco_lotti
private datastore kids_elenco_input

private date ki_data_competenza //data periodo inizio estrazioni

//--- progressivo righe dettaglio, serve x identificare una riga quando sono in 'modfica'
//private int ki_progressivo_riga = 0

private st_tab_base kist_tab_base

private boolean ki_riga_rimossaxelencolotti=false

private string ki_righe_titolo
private string ki_memo_titolo


end variables

forward prototypes
protected function string aggiorna ()
protected function integer cancella ()
protected function string dati_modif (string k_titolo)
protected function string inizializza ()
protected function integer inserisci ()
protected subroutine pulizia_righe ()
protected subroutine riempi_id ()
protected subroutine open_start_window ()
protected subroutine attiva_menu ()
protected subroutine smista_funz (string k_par_in)
private subroutine put_video_clie_2 (st_tab_clienti kst_tab_clienti)
public function boolean get_dati_cliente (ref st_tab_clienti kst_tab_clienti)
private subroutine put_video_nazioni (st_tab_clienti kst_tab_clienti)
private subroutine riga_modifica ()
protected subroutine inizializza_3 () throws uo_exception
private subroutine dragdrop_dw_esterna (uo_d_std_1 kdw_source, long k_riga)
private subroutine call_elenco_note ()
public subroutine set_iniz_dati_cliente (ref st_tab_clienti kst_tab_clienti)
public subroutine set_dw_clienti_child ()
private subroutine run_app_lettera ()
private subroutine put_video_vett (st_tab_sped_vettori ast_tab_sped_vettori)
private subroutine put_video_caus (st_tab_caus ast_tab_caus)
private subroutine put_video_clie_3 (st_tab_clienti kst_tab_clienti)
protected function string check_dati ()
private function integer riga_nuova_in_lista (ref st_tab_armo kst_tab_armo) throws uo_exception
private function integer riga_gia_presente (st_tab_arsp kst_tab_arsp)
private subroutine elenco_lotti_da_sped ()
private function integer get_totale_colli ()
private subroutine call_elenco_riceventi ()
private subroutine call_elenco_fatt ()
public function integer get_colli_da_sped (st_tab_armo ast_tab_armo) throws uo_exception
public function boolean stampa_ddt ()
private subroutine riga_display_in_lista (integer k_riga, st_tab_arsp kst_tab_arsp, st_tab_armo kst_tab_armo, st_tab_prodotti kst_tab_prodotti, st_tab_meca kst_tab_meca) throws uo_exception
private function integer riga_nuova_in_lista_1 (ref st_tab_arsp ast_tab_arsp, st_tab_armo ast_tab_armo, st_tab_prodotti kst_tab_prodotti, st_tab_meca kst_tab_meca) throws uo_exception
private function integer riga_modifica_in_lista (long a_riga, st_tab_arsp ast_tab_arsp, st_tab_armo ast_tab_armo, st_tab_prodotti ast_tab_prodotti, st_tab_meca kst_tab_meca) throws uo_exception
private subroutine riga_modifica_display_note (st_tab_armo_nt ast_tab_armo_nt)
public subroutine u_allarme_cliente (readonly st_tab_clienti ast_tab_clienti) throws uo_exception
public subroutine u_get_numero_lotto ()
private function long riga_nuova_in_lista_meca (st_tab_armo ast_tab_armo)
private subroutine call_indirizzi_storici ()
private subroutine elenco_lotti_da_sped_dosezero ()
private subroutine set_video_vett (st_tab_sped ast_tab_sped)
private function integer set_totale_colli ()
private subroutine get_cliente_da_armo (st_tab_meca kst_tab_meca) throws uo_exception
public subroutine add_lotto_da_id_meca (st_tab_meca kst_tab_meca) throws uo_exception
private function long elenco_lotti_da_sped_1 ()
public function st_esito u_aggiorna_base (st_tab_sped ast_tab_sped)
public function st_esito u_aggiorna_base_cancella (st_tab_sped ast_tab_sped)
private function boolean if_anag_attiva (st_tab_clienti ast_tab_clienti)
private subroutine put_video_data_rit (st_tab_sped ast_tab_sped)
protected function string aggiorna_dati ()
protected subroutine attiva_tasti_0 ()
public subroutine u_num_bolla_inp_changed ()
public subroutine u_message (uo_exception auo_exception)
public subroutine u_if_allarme_memo ()
protected subroutine inizializza_4 () throws uo_exception
public function integer u_ddt_rows_retrieve ()
public function integer u_allarme_lotto () throws uo_exception
end prototypes

protected function string aggiorna ();//
//======================================================================
//=== Aggiorna tabelle 
//=== Ritorna 1 chr : 0=tutto OK; 1=errore grave I-O;
//=== 				  : 2=
//===					  : 3=Commit fallita
//===		dal char 2 in poi spiegazione dell'errore
//======================================================================

string k_return="0 ", k_errore="0 ", k_errore1="0 "
long k_riga, k_colli, k_righe
st_tab_sped kst_tab_sped, kst_tab_sped_app, kst_tab_sped_orig
st_tab_base kst_tab_base 
st_tab_armo kst_tab_armo
st_tab_arsp kst_tab_arsp
st_tab_armo_prezzi kst_tab_armo_prezzi
st_esito kst_esito, kst_esito_BASE
pointer kpointer_1


kpointer_1 = setpointer(hourglass!) 


//	if tab_1.tabpage_1.dw_1.GetItemStatus(tab_1.tabpage_1.dw_1.getrow(), 0,  primary!) = NewModified!	then
//		k_new_rec = true
//	else
//		k_new_rec = false
//	end if

tab_1.selecttab(1)

k_riga = 1 //tab_1.tabpage_1.dw_1.getrow()

//=== Aggiorna, se modificato, la TAB_1 o TAB_4	
//if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0	or tab_1.tabpage_4.dw_4.getnextmodified(0, primary!) > 0 or  tab_1.tabpage_4.dw_4.deletedcount() > 0 then

	try
	//--- Se sono in Inserimento salva il Numero e Data del DDT per riproporlo alla fine             //verifico se numero documento già usato
		if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
			kst_tab_sped_app.num_bolla_out = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "num_bolla_out")
			kst_tab_sped_app.data_bolla_out = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "data_bolla_out") 
			kst_tab_sped_orig.num_bolla_out = kst_tab_sped_app.num_bolla_out
			kst_tab_sped_orig.data_bolla_out = kst_tab_sped_app.data_bolla_out
		else
//--- se sono in Modifica e ho cambiato numero e data....			
			if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
				kst_tab_sped.id_sped = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_sped")
				kst_tab_sped_orig.id_sped = kst_tab_sped.id_sped
				if kst_tab_sped_orig.id_sped > 0 then
					kiuf_sped.get_numero_da_id(kst_tab_sped_orig)
					kst_tab_sped.num_bolla_out = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "num_bolla_out")
					kst_tab_sped.data_bolla_out = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "data_bolla_out")
					if kst_tab_sped_orig.num_bolla_out > 0 then
						if kst_tab_sped_orig.num_bolla_out <> kst_tab_sped.num_bolla_out or kst_tab_sped_orig.data_bolla_out <> kst_tab_sped.data_bolla_out then
	//--- Cambio numero e data....			
							kst_tab_sped.st_tab_g_0.esegui_commit = "S"
							kiuf_sped.tb_update_numero_data( kst_tab_sped )
							kst_tab_sped_orig.num_bolla_out = kst_tab_sped.num_bolla_out
							kst_tab_sped_orig.data_bolla_out = kst_tab_sped.data_bolla_out
						end if
					end if
				end if
			end if
		end if
		
		kst_tab_sped.id_sped = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_sped")
		if isnull(kst_tab_sped.id_sped) then kst_tab_sped.id_sped = 0
		//--- se in Inserimento azzera temporaneamente il NUM DDT
		//if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
		//	kst_tab_sped.num_bolla_out = 0
		//else
			kst_tab_sped.num_bolla_out = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "num_bolla_out")
		//end if
		kst_tab_sped.data_bolla_out = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "data_bolla_out")
		kst_tab_sped.clie_2 = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "clie_2")
		kst_tab_sped.clie_3 = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "clie_3")
		kst_tab_sped.stampa = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "stampa")
		if isnull(kst_tab_sped.stampa) then kst_tab_sped.stampa = "N"
		kst_tab_sped.data_rit = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "data_rit")
		kst_tab_sped.ora_rit  =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "ora_rit")
		kst_tab_sped.rag_soc_1  =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "rag_soc_1")
		kst_tab_sped.rag_soc_2 =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "rag_soc_2")
		kst_tab_sped.indi =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "indi")
		kst_tab_sped.loc =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "loc")
		kst_tab_sped.cap =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "cap")
		kst_tab_sped.prov =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "prov")
		kst_tab_sped.id_nazione =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "id_nazione")
		kst_tab_sped.caus_codice =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "caus_codice")
		kst_tab_sped.causale =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "causale")
		kst_tab_sped.aspetto =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "aspetto")
		kst_tab_sped.cura_trasp =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "cura_trasp")
		kst_tab_sped.porto =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "porto")
		kst_tab_sped.mezzo =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "mezzo")
		kst_tab_sped.note_1 =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "note_1")
		kst_tab_sped.vett_1 =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "vett_1")
		kst_tab_sped.vett_2 =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "vett_2")
		kst_tab_sped.sv_call_vettore = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "sv_call_vettore")
		
//--- valorizzo il cliente dalla prima riga lotto valida
		
//--- imposta il numero colli dell'intero ddt
		kst_tab_sped.colli = set_totale_colli( )
		
	//=== Aggiorna, se modificato, la TAB_1	
		if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0	then
	
		//--- Aggiorna la testa
			kst_tab_sped.st_tab_g_0.esegui_commit = "N"
			if kst_tab_sped.id_sped = 0 then
				kst_tab_sped.id_sped = kiuf_sped.tb_insert_testa( kst_tab_sped )
				if kst_tab_sped.id_sped > 0 then
					kist_tab_sped.id_sped = kst_tab_sped.id_sped
					tab_1.tabpage_1.dw_1.setitem (k_riga, "id_sped", kst_tab_sped.id_sped )
				else
					kst_esito.esito = kkg_esito.db_ko  // fermo la registrazione  ROLLBACK!
					kst_esito.sqlerrtext = "Non è stato generato il Contatore del Documento (id_sped), ~n~r" + "impossibile proseguire con la registrazione!"
					kst_esito.sqlcode = 0
				end if
			else
				kiuf_sped.tb_update_testa( kst_tab_sped )
			end if
		
		end if
	

//--- Se tutto OK carico le righe di dettaglio 	
		if kst_esito.esito <> kkg_esito.db_ko then
	
			kst_tab_arsp.st_tab_g_0.esegui_commit = "N"
	
//---- Prima rimuove le righe da CANCELLARE DAL DB 
			k_riga = 1
			k_righe = tab_1.tabpage_4.dw_4.DeletedCount ( ) 
			do while k_riga <= k_righe and kst_esito.esito <> kkg_esito.db_ko
				
				kst_tab_arsp.id_arsp = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_arsp", delete!, false) 
				
//--- Cancella righe da DDT
				if kst_tab_arsp.id_arsp > 0 then
					kiuf_sped.tb_delete_riga( kst_tab_arsp )
				end if
			
				k_riga++

			loop
	
			k_riga = 1
			k_righe = tab_1.tabpage_4.dw_4.rowcount ( ) 
			do while k_riga <= k_righe and kst_esito.esito <> kkg_esito.db_ko

				kst_tab_arsp.id_sped = kst_tab_sped.id_sped
				kst_tab_arsp.data_bolla_out = kst_tab_sped.data_bolla_out
				kst_tab_arsp.num_bolla_out = kst_tab_sped.num_bolla_out
				
				kst_tab_arsp.nriga = k_riga
				kst_tab_arsp.id_armo = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_armo")
				kst_tab_arsp.id_arsp = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_arsp") 
				kst_tab_arsp.colli = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "colli") 
				kst_tab_arsp.colli_out = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "colli_out") 
				kst_tab_arsp.peso_kg_out = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "peso_kg_out") 
				kst_tab_arsp.note_1 = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "note_1") 
				kst_tab_arsp.note_2 = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "note_2") 
				kst_tab_arsp.note_3 = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "note_3") 
				kst_tab_arsp.stampa = kst_tab_sped.stampa 
	
//--- Aggiorna le righe 
				if kst_tab_arsp.id_arsp = 0 then
					kst_tab_arsp.id_arsp = kiuf_sped.tb_insert_riga( kst_tab_arsp )
					tab_1.tabpage_4.dw_4.setitem (k_riga, "id_arsp", kst_tab_arsp.id_arsp )
				else
					kiuf_sped.tb_update_riga( kst_tab_arsp )
				end if

				k_riga++
	
			loop

		end if
		
//--- ESITO

//=== Se tutto OK faccio la COMMIT		
		if kst_esito.esito = kkg_esito.db_ko then
			kguo_sqlca_db_magazzino.db_rollback()
		else
			kguo_sqlca_db_magazzino.db_commit( )
			k_return ="0 "

//--- Se Inserimento: Verifica che il n.ddt sia congruente
			if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
				kst_tab_sped_app = kst_tab_sped
				kst_tab_sped_app.id_sped = kiuf_sped.if_num_bolla_out_exists( kst_tab_sped_app )
				if kst_tab_sped_app.id_sped > 0 then   // Verifica se  n.DDT già utilizzato, non dovrei trovare un ID sono in inserimento!!
					if kst_tab_sped_app.id_sped <> kst_tab_sped.id_sped then    // se ID trovato è diverso da ddt che sto elaborando, ne cerco uno nuovo!!
						kst_tab_sped_app.num_bolla_out = kiuf_sped.get_numero_nuovo(kst_tab_sped, 0)   // get nuovo numero ddt
   						//get_ultimo_doc ( kst_tab_sped_app ) 
						//kst_tab_sped_app.num_bolla_out = kst_tab_sped_app.num_bolla_out + 1
					end if
					kst_tab_sped.num_bolla_out = kst_tab_sped_app.num_bolla_out 
				else
					if kst_tab_sped.num_bolla_out > 9000000 then // se sono su un DDT BIS allora non faccio controlli sul nr
					else
					// verifica che il nr non sia oltre al numero da assegnare
						kst_tab_sped_app.num_bolla_out = kiuf_sped.get_numero_nuovo(kst_tab_sped, 0)   // get nuovo numero ddt
						if kst_tab_sped.num_bolla_out > kst_tab_sped_app.num_bolla_out then
							kst_tab_sped.num_bolla_out = kst_tab_sped_app.num_bolla_out 
						end if
					end if
				end if
				tab_1.tabpage_1.dw_1.setitem(1, "num_bolla_out", kst_tab_sped.num_bolla_out )   //  Imposta il DDT 'definitivo' sul documento 
				
				kst_esito_BASE = u_aggiorna_base(kst_tab_sped)  // Aggiorna su BASE in n.DDT se questo è maggiore dell'ultimo registrato
				if kst_esito_BASE.esito <> kkg_esito.ok then 
					//k_return="1Fallito aggiornamento in Proprietà Azienda del Numero DDT " + string(kst_tab_sped.num_bolla_out) + ", procedere manualmene!! " + " ~n~r" + trim(kst_esito_base.sqlerrtext) 
					k_return="1"+ trim(kst_esito_base.sqlerrtext) 
				end if
				
				kst_tab_sped.st_tab_g_0.esegui_commit = "S"
				kiuf_sped.set_num_bolla_out_all(kst_tab_sped)  // AGGIORNA NUM DDT SU TESTATA E RIGHE
				
			end if

			if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then
				tab_1.tabpage_1.text = " DDT n. " + string(tab_1.tabpage_1.dw_1.getitemnumber(1, "num_bolla_out")) + "/" + string(year(tab_1.tabpage_1.dw_1.getitemdate(1, "data_bolla_out")))
			end if

			if kst_tab_sped.num_bolla_out <> kst_tab_sped_orig.num_bolla_out then
				kguo_exception.setmessage( "Modificato il numero iniziale '"+ string(kst_tab_sped_orig.num_bolla_out) + "' per questo DDT a '" + string(kst_tab_sped.num_bolla_out) + "'" )
				kguo_exception.messaggio_utente( )
			end if

//---- azzera il flag delle modifiche
			tab_1.tabpage_1.dw_1.ResetUpdate ( ) 
			tab_1.tabpage_4.dw_4.ResetUpdate ( ) 
			
//--- aggiorna nel BASE il num.  se + grande di quello presente
//			if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
//				kst_esito_BASE = u_aggiorna_base(kst_tab_sped)
//				if kst_esito_BASE.esito <> kkg_esito.ok then 
//					k_return="1Fallito aggiornamento Proprietà Azienda del Numero DDT, procedere manualmene!! " + " ~n~r" + trim(kst_esito_base.sqlerrtext) 
//				end if
//			end if
			
//--- Infine la modalità diventa a modifica
			ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica
		end if
		
	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito( )
		kst_esito.esito = kkg_esito.db_ko

		kguo_sqlca_db_magazzino.db_rollback()
		k_return="1Fallito aggiornamento archivio DDT spediti! " + " ~n~r" + trim(kst_esito.sqlerrtext) 
		
	end try
//end if

setpointer(kpointer_1)

//=== errore : 0=tutto OK o NON RICHIESTA; 1=errore grave I-O;
//=== 		 : 2=LIBERO
//===			 : 3=Commit fallita

if left(k_return, 1) = "1" then
	messagebox("Operazione di Aggiornamento Non Completata !!", &
		mid(k_return, 2))
else
	if left(k_return, 1) = "3" then
		messagebox("Registrazione dati : problemi nella 'Commit' !!", &
			"Consiglio : chiudere e ripetere le operazioni eseguite")
	end if
end if


attiva_tasti()

return k_return

end function

protected function integer cancella ();//
//=== Cancellazione rekord dal DB
//=== Ritorna : 0=OK 1=KO 2=non eseguita
//
int k_return=0
string k_record, k_record_1
string k_errore = "0 ", k_errore1 = "0 ", k_nro_fatt
long k_riga=0, k_seq, k_ctr
st_tab_sped kst_tab_sped
st_esito kst_esito


try

	tab_1.tabpage_4.dw_riga_0.visible = false   //questa finestra di dettaglio è meglio chiuderla 
	
	if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then
		kst_tab_sped.id_sped = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_sped")
		if kst_tab_sped.id_sped > 0 then  // se è una fattura già caricata...
	//--- posso cancellare il DDT? se exception NO!
			kiuf_sped.if_cancella(kst_tab_sped) 
		end if
		
		choose case ki_tab_1_index_new 
			case 1 
				k_record = " DDT di Spedizione "
				k_riga = tab_1.tabpage_1.dw_1.getrow()	
				if k_riga > 0 then
					if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> new!  &
							and tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
						kst_tab_sped.num_bolla_out = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "num_bolla_out")
						kst_tab_sped.data_bolla_out = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "data_bolla_out")
						k_record_1 = &
							"Sei sicuro di voler eliminare il DDT di Spedizione~n~r" + &
							"numero " + string(kst_tab_sped.num_bolla_out, "#######") +  &
							" del " + string(kst_tab_sped.data_bolla_out) + " (id " + string(kst_tab_sped.id_sped) + ") ?"
					else
						tab_1.tabpage_1.dw_1.deleterow(k_riga)
						k_riga = 0
					end if
				end if
			case 4
				k_record = " Riga di dettaglio "
				k_riga = tab_1.tabpage_4.dw_4.getselectedrow(0)	
		end choose	
		
	end if
	
	
	//=== Se righe in lista
	if k_riga > 0  then
		
	//=== Cancella la riga dal data windows di lista
		choose case ki_tab_1_index_new 
			case 1 
	//=== Richiesta di conferma della eliminazione del rek
				if messagebox("Elimina" + k_record, k_record_1, question!, yesno!, 2) = 1 then
					kst_esito = kiuf_sped.tb_delete_testa( kst_tab_sped )   // CANCELLA DDT
					if kst_esito.esito = kkg_esito.ok then
						u_aggiorna_base_cancella( kst_tab_sped ) // aggiorna il contatore del BASE
					end if
				else
					messagebox("Elimina" + k_record,  "Operazione Annullata !!")
					k_return = 2
				end if
			case 4
	//				k_errore = kiuf_sped.tb_delete_riga( kst_tab_sped )   
				kst_esito.esito = kkg_esito.ok
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
							
						//--- nascone e resetta eventuale dettaglio
							tab_1.tabpage_4.dw_riga_0.hide( )
							tab_1.tabpage_4.dw_riga_0.reset( )  
							
						//--- imposta il numero colli dell'intero ddt
							set_totale_colli( )
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
	
		choose case ki_tab_1_index_new 
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
int k_row


//=== Toglie le righe eventualmente da non registrare
	pulizia_righe()
	
//	k_row = tab_1.tabpage_1.dw_1.getnextmodified(0, primary!)
//	k_row = tab_1.tabpage_4.dw_4.getnextmodified(0, primary!)
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
int k_err_ins, k_rc, k_nr
string k_rcx
//boolean k_flag_numero_ddt_modificato = false
date k_data2gg
st_tab_clienti kst_tab_clienti
st_tab_sped kst_tab_sped_attuale
st_tab_meca kst_tab_meca
st_esito kst_esito
kuf_base kuf1_base
kuf_utility kuf1_utility
datawindowchild kdwc_1, kdwc_2, kdwc_3


//=== Puntatore Cursore da attesa.....
SetPointer(kkg.pointer_attesa)


if tab_1.tabpage_1.dw_1.rowcount() > 0 then 
	kst_tab_sped_attuale.id_sped = tab_1.tabpage_1.dw_1.getitemnumber( 1, "id_sped")
	kst_tab_sped_attuale.num_bolla_out = tab_1.tabpage_1.dw_1.getitemnumber( 1, "num_bolla_out")
	kst_tab_sped_attuale.data_bolla_out = tab_1.tabpage_1.dw_1.getitemdate( 1, "data_bolla_out")
else
	kst_tab_sped_attuale.id_sped = 0
	kst_tab_sped_attuale.num_bolla_out = 0
	kst_tab_sped_attuale.data_bolla_out = date(0)
end if
//if kist_tab_sped_orig.num_bolla_out <> kst_tab_sped_attuale.num_bolla_out &
//         or kist_tab_sped_orig.data_bolla_out <> kst_tab_sped_attuale.data_bolla_out or tab_1.tabpage_1.dw_1.rowcount() = 0 then
if tab_1.tabpage_1.dw_1.rowcount() = 0 then

//	k_flag_numero_ddt_modificato = true
//	kst_tab_sped_attuale.id_sped = 0
//
//	if kst_tab_sped_attuale.num_bolla_out > 0 then
//		try
//			kiuf_sped.get_id_sped(kst_tab_sped_attuale)
//			if kst_tab_sped_attuale.id_sped = 0 then
//				ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
//			end if
//		catch (uo_exception kuo_exception)
//			kuo_exception.messaggio_utente()
//		end try
//		kist_tab_sped_orig.id_sped = kst_tab_sped_attuale.id_sped
//	end if

	tab_1.tabpage_4.text = ki_righe_titolo
	tab_1.tabpage_4.dw_4.reset( ) // inizializzo le righe
	tab_1.tabpage_4.text = "righe"
	tab_1.tabpage_5.dw_5.visible = false
	tab_1.tabpage_5.text = ki_memo_titolo
	tab_1.tabpage_5.dw_5.reset( ) // inizializzo le righe
	tab_1.tabpage_5.text = "Allarmi Memo"

//--- SE INSERIMENTO
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
		
		k_err_ins = inserisci()

//--- potrei entrare con key3 valorizzato ovvero con un ID_MECA specifico allora popola da sola il DDT
		if isnumber(ki_st_open_w.key3) and ki_st_open_w.flag_primo_giro = "S" then
			try
				kst_tab_meca.id = long(trim(ki_st_open_w.key3))
				add_lotto_da_id_meca(kst_tab_meca)
				ki_st_open_w.key3=""
			catch (uo_exception kuo_exception)
				kuo_exception.messaggio_utente()
			end try
		else
//--- se in apertura ho un ricevente già indicato...	
			if kist_tab_sped_orig.clie_2 > 0 and tab_1.tabpage_1.dw_1.rowcount( ) > 0 then
				kst_tab_clienti.codice = kist_tab_sped_orig.clie_2 
				get_dati_cliente(kst_tab_clienti)
				put_video_clie_2(kst_tab_clienti)
			end if
		end if
		
	else

		k_rc = tab_1.tabpage_1.dw_1.retrieve(kist_tab_sped_orig.id_sped) 
		
		choose case k_rc

			case is < 0		
				SetPointer(kkg.pointer_default)
				kguo_exception.inizializza()
				kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_err_int )
				kguo_exception.setmessage(  &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(ID Documento cercato: " + string(kist_tab_sped_orig.id_sped) + ") " )
				kguo_exception.messaggio_utente( )	
				return ki_exitNow
				//post close(this)

			case 0
				//tab_1.tabpage_1.dw_1.reset()

				if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
					ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento

					SetPointer(kkg.pointer_default)
					kguo_exception.inizializza()
					kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_not_fnd )
					kguo_exception.setmessage(  &
						"Mi spiace ma il Documento cercato non e' in archivio ~n~r" + &
						"(ID Documento cercato: " + string(kist_tab_sped_orig.id_sped) + ") " )
					post u_message(kguo_exception)
//					kguo_exception.messaggio_utente( )	
					//post close(this)
					
				end if
				if tab_1.tabpage_1.dw_1.rowcount() = 0 then
					k_err_ins = inserisci()
				end if
				//attiva_tasti()

			case is > 0		
				kist_tab_sped_orig.num_bolla_out = tab_1.tabpage_1.dw_1.getitemnumber(1, "num_bolla_out")
				kist_tab_sped_orig.data_bolla_out = tab_1.tabpage_1.dw_1.getitemdate(1, "data_bolla_out")
				kist_tab_sped.num_bolla_out = kist_tab_sped_orig.num_bolla_out
				kist_tab_sped.data_bolla_out = kist_tab_sped_orig.data_bolla_out
				
				if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
					tab_1.tabpage_1.visible = true
					SetPointer(kkg.pointer_default)
					kguo_exception.inizializza()
					kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_allerta )
					kguo_exception.setmessage(  &
						"Attenzione, il Documento e' ga' stato Caricato ~n~r" + &
						"(ID documento cercato: " + string(kist_tab_sped_orig.id_sped) + ") " )
//					kguo_exception.messaggio_utente( )	
					post u_message(kguo_exception)
			
					ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica

				end if

				u_ddt_rows_retrieve()   // carica le righe nel DDT !!!!!!

				tab_1.tabpage_1.dw_1.setfocus()
//				tab_1.tabpage_1.dw_1.setcolumn("fat1_note_1")

			//	attiva_tasti()
		
				tab_1.tabpage_1.dw_1.visible = true
		end choose

	end if	

else
	//attiva_tasti()
end if


try
	kuf1_utility = create kuf_utility 

//--- se sono in CANCELLAZIONE....
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.cancellazione then
	
	//--- se sono entrato x cancellazione...				
		ki_esci_dopo_cancella = true
		kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_1.dw_1)
		cb_cancella.post event clicked( )
	
	else
		//--- se primo giro imposta la data di competenza di default
		if tab_1.tabpage_1.dw_1.rowcount() > 0 then
			tab_1.tabpage_1.dw_1.setitem( 1, "k_competenza_dal",  ki_data_competenza)
		end if
		
		//===
		//--- se inserimento inabilito gli altri TAB, sono inutili
		if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
		
			tab_1.tabpage_2.enabled = false
			tab_1.tabpage_3.enabled = false
			tab_1.tabpage_4.enabled = false
			
		end if
	

//--- controlli particolari	
		if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then //and k_flag_numero_ddt_modificato then
			
			try 
				
				if kist_tab_sped.id_sped > 0 then
				else
					kiuf_sped.get_id_sped(kist_tab_sped)
				end if

//--- posso modificare il documento?
				if not kiuf_sped.if_modifica(kist_tab_sped) then
					ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
					kguo_exception.inizializza()
					kguo_exception.set_tipo( kguo_exception.KK_st_uo_exception_tipo_non_eseguito )
					kguo_exception.setmessage(  &
						"Attenzione, il DDT non può essere Modificato (ad esempio il lotto è già stato Chiuso). ~n~r" + &
						"(ID Documento cercato:" + string(kist_tab_sped_orig.id_sped) + ") " )
					post u_message(kguo_exception)
					//kguo_exception.messaggio_utente( )	
				else
	//--- documento già STAMPATO allora ATTENZIONE alle Modifiche	!!!!!	
					if kiuf_sped.if_stampato(kist_tab_sped) then 
						kguo_exception.inizializza()
						kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_allerta )
						kguo_exception.setmessage(  &
							"Attenzione, DDT ga' stato Stampato. La Modifica potrebbe comprometterne l'integrità. ~n~r" + &
							"(ID Documento cercato:" + string(kist_tab_sped_orig.id_sped) + ") " )
						post u_message(kguo_exception)
	//					kguo_exception.messaggio_utente( )	
					end if
					
//--- get del numero indirizzi
					if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then
						kist_tab_sped_orig.clie_2 = tab_1.tabpage_1.dw_1.getitemnumber(1, "clie_2")
						k_nr = kiuf_sped.get_nr_indirizzi_ddt(kist_tab_sped_orig)
						if k_nr > 1 then
							tab_1.tabpage_1.dw_1.setitem( 1, "k_nr_ind_ddt", k_nr )
						else
							tab_1.tabpage_1.dw_1.setitem( 1, "k_nr_ind_ddt", 0 )
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
	
			tab_1.tabpage_1.dw_1.object.p_img_fatturati_x_clie_2.visible = false 
			tab_1.tabpage_1.dw_1.object.p_img_meca_clie_2.visible = false 
			tab_1.tabpage_1.dw_1.object.p_img_indi.visible = false 
			tab_1.tabpage_1.dw_1.object.p_img_note.visible = false 
		
			kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_1.dw_1)
//			kuf1_utility.u_proteggi_dw("1", "caus_codice", tab_1.tabpage_1.dw_1)
//			kuf1_utility.u_proteggi_dw("1", "causale", tab_1.tabpage_1.dw_1)
	
		else		
			
			tab_1.tabpage_1.dw_1.object.p_img_fatturati_x_clie_2.visible = true 
			tab_1.tabpage_1.dw_1.object.p_img_meca_clie_2.visible = true 
//			tab_1.tabpage_1.dw_1.object.p_img_indi.visible = true 
			tab_1.tabpage_1.dw_1.object.p_img_note.visible = true 
			
//--- Inabilita alcuni campi alla modifica se Funzione MODIFICA e giorno di inserimento più vecchio di 2 giorni
			k_data2gg = relativedate(kguo_g.get_dataoggi( ), -2)
			if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica and kist_tab_sped_orig.data_bolla_out < k_data2gg then
				kuf1_utility.u_proteggi_dw("1", "clie_2", tab_1.tabpage_1.dw_1)
				kuf1_utility.u_proteggi_dw("1", "rag_soc_10", tab_1.tabpage_1.dw_1)
				kuf1_utility.u_proteggi_dw("1", "p_iva", tab_1.tabpage_1.dw_1)
				kuf1_utility.u_proteggi_dw("1", "cf", tab_1.tabpage_1.dw_1)
			else
				
//--- S-protezione campi per riabilitare la modifica a parte la chiave
				kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)
				
			end if
			
//--- popola elenchi ddw
			if (ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione and ki_st_open_w.flag_modalita <> kkg_flag_modalita.cancellazione) &
					  and (kst_tab_sped_attuale.id_sped = 0 or ki_st_open_w.flag_primo_giro = "S") then
			
				tab_1.tabpage_1.dw_1.getchild("id_nazione", kdwc_1)
				kdwc_1.settransobject(sqlca)
				kdwc_1.reset() 
				if kdwc_1.rowcount() = 0 then
					kdwc_1.retrieve()
					kdwc_1.insertrow(1)
				end if
				tab_1.tabpage_1.dw_1.getchild("vett_1", kdwc_1)
				kdwc_1.settransobject(sqlca)
				kdwc_1.reset() 
				if kdwc_1.rowcount() = 0 then
					kdwc_1.retrieve()
					kdwc_1.insertrow(1)
				end if
				tab_1.tabpage_1.dw_1.getchild("id_vettore", kdwc_1)
				kdwc_1.settransobject(sqlca)
				kdwc_1.reset() 
				if kdwc_1.rowcount() = 0 then
					kdwc_1.retrieve()
					kdwc_1.setsort("id asc")
					kdwc_1.sort()
					kdwc_1.insertrow(1)
				end if
			end if
		
		end if
		destroy kuf1_utility

//--- imposta i campi vettore
		kst_tab_sped_attuale.cura_trasp = tab_1.tabpage_1.dw_1.getitemstring(1, "cura_trasp")
		set_video_vett(kst_tab_sped_attuale)
//--- calcola colli testata
		set_totale_colli( )

//---- azzera il flag delle modifiche
		tab_1.tabpage_1.dw_1.resetupdate( )
	
	end if 

	tab_1.tabpage_1.dw_1.setfocus()

catch (uo_exception kuo2_exception)
	kuo2_exception.messaggio_utente()

end try

post attiva_tasti()
if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then
	tab_1.tabpage_1.text = " DDT n. " + string(tab_1.tabpage_1.dw_1.getitemnumber(1, "num_bolla_out")) + "/" + string(year(tab_1.tabpage_1.dw_1.getitemdate(1, "data_bolla_out")))
end if

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
//				kist_tab_sped.data_bolla_out = tab_1.tabpage_1.dw_1.getitemdate( 1, "data_bolla_out" ) 
				kist_tab_sped.data_bolla_out = kguo_g.get_dataoggi( )
				ki_data_competenza = tab_1.tabpage_1.dw_1.getitemdate( 1, "k_competenza_dal" ) 
			end if
	
			tab_1.tabpage_4.text = ki_righe_titolo
			tab_1.tabpage_4.dw_4.reset() 
			tab_1.tabpage_5.text = ki_memo_titolo
			tab_1.tabpage_5.dw_5.reset() 
			tab_1.tabpage_1.dw_1.reset() 
			
			tab_1.tabpage_1.dw_1.insertrow(0)
			
//--- S-protezione campi per riabilitare la modifica a parte la chiave
			kuf1_utility = create kuf_utility
			kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)
			
			tab_1.tabpage_1.dw_1.setitem( 1, "k_competenza_dal",  ki_data_competenza)
			tab_1.tabpage_1.dw_1.setitem( 1, "stampa", kiuf_sped.kki_sped_flg_stampa_bolla_da_stamp)
			tab_1.tabpage_1.dw_1.setitem( 1, "data_bolla_out", kist_tab_sped.data_bolla_out )
			tab_1.tabpage_1.dw_1.setitem( 1, "data_rit", kguo_g.get_dataoggi( ))
			tab_1.tabpage_1.dw_1.setitem( 1, "ora_rit", "" )
			tab_1.tabpage_1.dw_1.setitem( 1, "sv_call_vettore", 0 )
//			tab_1.tabpage_1.dw_1.setitem( 1, "data_rit", kguo_g.get_dataoggi( ))
//			tab_1.tabpage_1.dw_1.setitem( 1, "ora_rit", string(kguo_g.get_ora( )) + ":" + string(kguo_g.get_minuti( )) )

			kist_tab_sped.num_bolla_out = kiuf_sped.get_numero_nuovo(kist_tab_sped, 0)   // get nuovo numero ddt
			
			tab_1.tabpage_1.dw_1.setitem( 1, "num_bolla_out", kist_tab_sped.num_bolla_out )

			if tab_1.tabpage_1.dw_1.getitemstring(1, "aspetto") > " " then
			else
				tab_1.tabpage_1.dw_1.setitem( 1, "aspetto", "SCATOLE SU PEDANE")
			end if
			if tab_1.tabpage_1.dw_1.getitemstring(1, "cura_trasp") > " " then
			else
				tab_1.tabpage_1.dw_1.setitem( 1, "cura_trasp", "V")
			end if
			if tab_1.tabpage_1.dw_1.getitemstring(1, "porto") > " " then
			else
				//tab_1.tabpage_1.dw_1.setitem( 1, "porto", "ASS.TO")
				tab_1.tabpage_1.dw_1.setitem( 1, "porto", " ")
			end if
			if tab_1.tabpage_1.dw_1.getitemstring(1, "mezzo") > " " then
			else
				tab_1.tabpage_1.dw_1.setitem( 1, "mezzo", "")
			end if
			if tab_1.tabpage_1.dw_1.getitemstring(1, "causale") > " " then
			else
				tab_1.tabpage_1.dw_1.setitem( 1, "caus_codice", "1")
				kst_tab_caus.codice = tab_1.tabpage_1.dw_1.getitemstring( 1, "caus_codice")
				put_video_caus(kst_tab_caus)
			end if
			
			ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
			
			this.setredraw(true)

			tab_1.tabpage_1.dw_1.setfocus()
			tab_1.tabpage_1.dw_1.setcolumn("clie_2")

//---- azzera il flag delle modifiche
			tab_1.tabpage_1.dw_1.ResetUpdate ( ) 
			tab_1.tabpage_4.dw_4.ResetUpdate ( ) 

//--- popola dw child dw clienti 
			set_dw_clienti_child()
	
			kist_tab_sped_orig = kist_tab_sped		
			kist_tab_sped_orig.id_sped = 0

		case 4 // 
			
//			if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then	
//				if tab_1.tabpage_1.dw_1.object.tipo_doc[1] <> kiuf_fatt.kki_tipo_doc_nota_di_credito &
//						and tab_1.tabpage_1.dw_1.object.fattura_da[1] = kiuf_clienti.kki_fattura_da_bolla then
//					elenco_sped_non_fatt()
//				else
//					if tab_1.tabpage_1.dw_1.object.tipo_doc[1] <> kiuf_fatt.kki_tipo_doc_nota_di_credito  &
//							and tab_1.tabpage_1.dw_1.object.fattura_da[1] = kiuf_clienti.kki_fattura_da_certif then
//						elenco_lotti_non_fatt()
//					else
//						if tab_1.tabpage_1.dw_1.object.tipo_doc[1] = kiuf_fatt.kki_tipo_doc_nota_di_credito then
//							ki_menu.m_strumenti.m_fin_gest_libero3.enabled = true
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

	if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then
		tab_1.tabpage_1.text = " DDT n. " + string(tab_1.tabpage_1.dw_1.getitemnumber(1, "num_bolla_out")) + "/" + string(year(tab_1.tabpage_1.dw_1.getitemdate(1, "data_bolla_out")))
	end if

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
//				tab_1.tabpage_4.dw_4.SetItemStatus( k_riga, 0, Primary!, NotModified!)

			end if
		end if
		
	next


end subroutine

protected subroutine riempi_id ();//
//=== Imposta gli Effettivi ID degli archivi
long k_righe, k_ctr
long k_id_sped_1
st_tab_sped kst_tab_sped
st_tab_arsp kst_tab_arsp
st_tab_clienti kst_tab_clienti
st_esito kst_esito
//string k_ret_code
//kuf_base kuf1_base



if tab_1.tabpage_1.dw_1.rowcount() > 0 then
	k_ctr = 1
end if

if k_ctr > 0 then
	
//=== Salvo ID originale x piu' avanti
	k_id_sped_1 = tab_1.tabpage_1.dw_1.getitemnumber(k_ctr, "id_sped")
	if isnull(k_id_sped_1) then				
		tab_1.tabpage_1.dw_1.setitem(k_ctr, "id_sped", 0)
		k_id_sped_1 = 0
	end if

//--- get del cliente 
	kst_tab_sped.clie_3 = tab_1.tabpage_1.dw_1.getitemnumber(k_ctr, "clie_3")
	if isnull(kst_tab_sped.clie_3) then kst_tab_sped.clie_3 = 0
	
	k_righe = tab_1.tabpage_4.dw_4.rowcount()
	for k_ctr = 1 to k_righe 
		
//--- se cliente non impostato lo imposta dalle righe 
		if kst_tab_sped.clie_3 > 0 then
		else
			kst_tab_sped.clie_3 = tab_1.tabpage_4.dw_4.getitemnumber(k_ctr, "clie_3")
			kst_tab_clienti.codice = kst_tab_sped.clie_3
			kst_esito = kiuf_clienti.leggi_rag_soc(kst_tab_clienti)
			if kst_esito.esito = kkg_esito.ok then
				tab_1.tabpage_1.dw_1.setitem( 1, "clie3_rag_soc", trim(kst_tab_clienti.rag_soc_10) + " " &
									+ trim(kst_tab_clienti.rag_soc_11) + " " &
									+ trim(kst_tab_clienti.indi_1) + " " &
									+ trim(kst_tab_clienti.loc_1) + " " &
									+ trim(kst_tab_clienti.prov_1) + " " &
									+ string(kst_tab_clienti.id_nazione_1)  )
			end if													
		end if

//--- imposta eventuale ID_SPED sulle righe
		tab_1.tabpage_4.dw_4.setitem(k_ctr, "id_sped", k_id_sped_1)

//--- imposta eventuale ID_ARSP sulle righe
		kst_tab_arsp.id_arsp = tab_1.tabpage_4.dw_4.getitemnumber(k_ctr, "id_arsp")
		if kst_tab_arsp.id_arsp > 0 then 
		else
			tab_1.tabpage_4.dw_4.setitem(k_ctr, "id_arsp", 0)
		end if
	
	end for

//--- imposta il cliente a cui fatturare
	tab_1.tabpage_1.dw_1.setitem(1, "clie_3", kst_tab_sped.clie_3)

end if

end subroutine

protected subroutine open_start_window ();//
	kiuf_sped = create kuf_sped
	kiuf_armo = create kuf_armo
	kiuf_armo_inout = create kuf_armo_inout
	kiuf_armo_nt = create kuf_armo_nt
	kiuf_clienti = create kuf_clienti
	kiuf_prodotti = create kuf_prodotti
	kiuf_ausiliari = create kuf_ausiliari
	kiuf_report_merce_da_sped = create kuf_report_merce_da_sped
	kiuf_sped_checkmappa = create kuf_sped_checkmappa
	kiuf_barcode = create kuf_barcode
	
	kids_elenco_da_sped_dosezero = create datastore
	kids_elenco_da_sped_dosezero.dataobject = "d_arsp_l_dosezerodasped"
	kids_elenco_da_sped_dosezero.settransobject(kguo_sqlca_db_magazzino)

	kids_elenco_input = create datastore

	ki_toolbar_window_presente=true

	ki_righe_titolo = tab_1.tabpage_4.text
	ki_memo_titolo = tab_1.tabpage_5.text

	//tab_1.tabpage_5.picturename = 
	
	kist_tab_sped.id_sped  = 0
	kist_tab_sped.clie_2 = 0
	if isnumber(ki_st_open_w.key1) then
		kist_tab_sped.id_sped = long(trim(ki_st_open_w.key1))
	end if
	if isnumber(ki_st_open_w.key2) then
		kist_tab_sped.clie_2 = long(trim(ki_st_open_w.key2))
	end if
	
	kist_tab_sped.data_bolla_out = kguo_g.get_dataoggi( )
	ki_data_competenza = relativedate(kist_tab_sped.data_bolla_out, - 90)
	 
	dw_anno_numero.insertrow( 0 )
	dw_anno_numero.object.numero[1] = 0
	if dw_anno_numero.object.anno[1] = 0 or isnull(dw_anno_numero.object.anno[1]) then
		dw_anno_numero.object.anno[1]  = year(relativedate(kg_dataoggi, - 20))
	end if
	
//--- popola struttura x mantenere memoria dell'origine	
	kist_tab_sped_orig = kist_tab_sped

end subroutine

protected subroutine attiva_menu ();//
//---
//
boolean k_attiva



//=== 
	if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then	

		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione &
				and ki_st_open_w.flag_modalita <> kkg_flag_modalita.cancellazione &
		       and tab_1.tabpage_1.dw_1.object.clie_2[1] > 0 and tab_1.tabpage_4.enabled then
//				and tab_1.tabpage_4.enabled then
			k_attiva = true
		else
			k_attiva = false
		end if
		if ki_menu.m_strumenti.m_fin_gest_libero1.enabled <> k_attiva or ki_st_open_w.flag_primo_giro = "S" then 
			ki_menu.m_strumenti.m_fin_gest_libero1.text = "Elenco Lotti da Spedire " 
			ki_menu.m_strumenti.m_fin_gest_libero1.microhelp = "Elenco lotti entrati da spedire per il Ricevete indicato "
			ki_menu.m_strumenti.m_fin_gest_libero1.visible = true

			ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
			ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText = "Lotti, Lotti da Spedire  "
			ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
			
			ki_menu.m_strumenti.m_fin_gest_libero1.enabled = k_attiva
			ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemname = kGuo_path.get_risorse() + kkg.path_sep + "lotto16x16.gif"
		end if

		if ki_menu.m_strumenti.m_fin_gest_libero2.enabled <> k_attiva or ki_st_open_w.flag_primo_giro = "S" then 
			ki_menu.m_strumenti.m_fin_gest_libero2.text = "Elenco Materiale da non trattare da Spedire " 
			ki_menu.m_strumenti.m_fin_gest_libero2.microhelp = "Elenco materiale entrato per non essere trattato da spedire "
			ki_menu.m_strumenti.m_fin_gest_libero2.visible = true

			ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true
			ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemText = "Materiale, Lotti di Materiale da non trattare da Spedire  "
			ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
			
			ki_menu.m_strumenti.m_fin_gest_libero2.enabled = k_attiva
			ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemname = kGuo_path.get_risorse() + kkg.path_sep + "lotto16x16_red.gif"
		end if

		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione &
				and ki_st_open_w.flag_modalita <> kkg_flag_modalita.cancellazione then
			k_attiva = true
		else
			k_attiva = false
		end if
		if ki_menu.m_strumenti.m_fin_gest_libero3.enabled <> k_attiva or ki_st_open_w.flag_primo_giro = "S" then
			ki_menu.m_strumenti.m_fin_gest_libero3.text = "Indica il numero Lotto " 
			ki_menu.m_strumenti.m_fin_gest_libero3.microhelp = "Compila il ddt con il numero Lotto da spedire"
			ki_menu.m_strumenti.m_fin_gest_libero3.visible = true

			ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemVisible = true
			ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemText = 	"Trova, Indica il num. Lotto da spedire"
			ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritembarindex=2

			ki_menu.m_strumenti.m_fin_gest_libero3.enabled = k_attiva
			ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemName = kGuo_path.get_risorse() + kkg.path_sep + "find16.png"
		end if

		if tab_1.tabpage_1.dw_1.object.id_sped[1] > 0 then
			k_attiva = true
		else
			k_attiva = false
		end if
		if ki_menu.m_strumenti.m_fin_gest_libero4.enabled <> k_attiva or ki_st_open_w.flag_primo_giro = "S" then
			ki_menu.m_strumenti.m_fin_gest_libero4.text = "Stampa ddt"
			ki_menu.m_strumenti.m_fin_gest_libero4.microhelp =  "Stampa ddt"
			ki_menu.m_strumenti.m_fin_gest_libero4.visible = true
			ki_menu.m_strumenti.m_fin_gest_libero4.enabled = k_attiva
			ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemText = "Stampa,"+ki_menu.m_strumenti.m_fin_gest_libero4.text
			ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemName = kGuo_path.get_risorse() + kkg.path_sep + "printer16x16.gif"
			ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritembarindex=2
			ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemVisible = true
		end if

//		this.settoolbar( 2, false) //true)
	else
//		this.settoolbar( 2, false)
		ki_menu.m_strumenti.m_fin_gest_libero1.visible = false
		ki_menu.m_strumenti.m_fin_gest_libero2.visible = false
		ki_menu.m_strumenti.m_fin_gest_libero3.visible = false
		ki_menu.m_strumenti.m_fin_gest_libero4.visible = false
		ki_menu.m_strumenti.m_fin_gest_libero5.visible = false
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = false
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = false
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemVisible = false
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemVisible = false
		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemVisible = false
	end if

//--- Attiva/Dis. Voci di menu
	super::attiva_menu()
	
end subroutine

protected subroutine smista_funz (string k_par_in);//
//===
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//===


choose case LeftA(k_par_in, 2) 

	case kkg_flag_richiesta.libero1 		//Elenco lotti da Spedire
		tab_1.tabpage_1.dw_1.accepttext( )
		elenco_lotti_da_sped()
		
	case kkg_flag_richiesta.libero2 		//Elenco lotti da NON trattare (DOSE=0) da Spedire
		tab_1.tabpage_1.dw_1.accepttext( )
		elenco_lotti_da_sped_dosezero( )

	case kkg_flag_richiesta.libero3 		//Richiesta del numero lotto
		u_get_numero_lotto()

	case kkg_flag_richiesta.libero4 		//Stampa ddt
		stampa_ddt()

	case else
		super::smista_funz(k_par_in)

end choose

end subroutine

private subroutine put_video_clie_2 (st_tab_clienti kst_tab_clienti);//
//--- Visualizza dati Cliente 
//
int k_colli, k_nr
st_esito kst_esito
st_tab_sped kst_tab_sped
//st_tab_nazioni kst_tab_nazioni
//st_tab_pagam kst_tab_pagam
//kuf_ausiliari kuf1_ausiliari


//--- imposta il numero colli dell'intero ddt
set_totale_colli( )

tab_1.tabpage_1.dw_1.modify( "clie_2.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
tab_1.tabpage_1.dw_1.setitem( 1, "clie_2", kst_tab_clienti.codice )
tab_1.tabpage_1.dw_1.modify( "rag_soc_10.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
tab_1.tabpage_1.dw_1.setitem( 1, "rag_soc_10", trim(kst_tab_clienti.rag_soc_10) )
tab_1.tabpage_1.dw_1.modify( "p_iva.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
tab_1.tabpage_1.dw_1.setitem( 1, "p_iva", trim(kst_tab_clienti.p_iva) )
tab_1.tabpage_1.dw_1.modify( "cf.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
tab_1.tabpage_1.dw_1.setitem( 1, "cf", trim(kst_tab_clienti.cf) )

//tab_1.tabpage_1.dw_1.setitem( 1, "clie_2", kst_tab_clienti.codice)
//tab_1.tabpage_1.dw_1.setitem( 1, "rag_soc_10", kst_tab_clienti.rag_soc_10 )
tab_1.tabpage_1.dw_1.setitem( 1, "loc_1", kst_tab_clienti.loc_1 )
tab_1.tabpage_1.dw_1.setitem( 1, "prov_1", trim(kst_tab_clienti.prov_1) )

tab_1.tabpage_1.dw_1.setitem( 1, "meca_clie_2", kst_tab_clienti.codice) // <--- anagrafica da cui beccare i Lotti
tab_1.tabpage_1.dw_1.setitem( 1, "meca_rag_soc_10", kst_tab_clienti.rag_soc_10 )

//--- se non è stato indicato nulla in anagrafe su indirizzo di spedizione piglia la sede
if trim(kst_tab_clienti.rag_soc_20) > " " then
	tab_1.tabpage_1.dw_1.setitem( 1, "rag_soc_1", kst_tab_clienti.rag_soc_20 )
	tab_1.tabpage_1.dw_1.setitem( 1, "rag_soc_2", kst_tab_clienti.rag_soc_21 )
else
	tab_1.tabpage_1.dw_1.setitem( 1, "rag_soc_1", kst_tab_clienti.rag_soc_10 )
	tab_1.tabpage_1.dw_1.setitem( 1, "rag_soc_2", kst_tab_clienti.rag_soc_11 )
end if
if trim(kst_tab_clienti.indi_2) > " " then
	tab_1.tabpage_1.dw_1.setitem( 1, "indi", kst_tab_clienti.indi_2 )
	tab_1.tabpage_1.dw_1.setitem( 1, "cap", kst_tab_clienti.cap_2 )
	tab_1.tabpage_1.dw_1.setitem( 1, "loc", kst_tab_clienti.loc_2 )
	tab_1.tabpage_1.dw_1.setitem( 1, "prov", kst_tab_clienti.prov_2 )
	tab_1.tabpage_1.dw_1.setitem( 1, "id_nazione", kst_tab_clienti.id_nazione_2 )
else
	tab_1.tabpage_1.dw_1.setitem( 1, "indi", kst_tab_clienti.indi_1 )
	tab_1.tabpage_1.dw_1.setitem( 1, "cap", kst_tab_clienti.cap_1 )
	tab_1.tabpage_1.dw_1.setitem( 1, "loc", kst_tab_clienti.loc_1 )
	tab_1.tabpage_1.dw_1.setitem( 1, "prov", kst_tab_clienti.prov_1 )
	tab_1.tabpage_1.dw_1.setitem( 1, "id_nazione", kst_tab_clienti.id_nazione_1 )
end if

//--- get del numero indirizzi
kst_tab_sped.clie_2 = kst_tab_clienti.codice
k_nr = kiuf_sped.get_nr_indirizzi_ddt(kst_tab_sped)
if k_nr > 1 then
	tab_1.tabpage_1.dw_1.setitem( 1, "k_nr_ind_ddt", k_nr )
else
	tab_1.tabpage_1.dw_1.setitem( 1, "k_nr_ind_ddt", 0 )
end if

//put_video_pagam(kst_tab_clienti)

attiva_tasti()


end subroutine

public function boolean get_dati_cliente (ref st_tab_clienti kst_tab_clienti);//
boolean k_return = false
st_esito kst_esito
kuf_clienti kuf1_clienti


try
	
	k_return = kiuf_clienti.leggi (kst_tab_clienti)
	
//--- Gestione di Allert per il cliente 	
//	post u_allarme_cliente(kst_tab_clienti)
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	

finally
	
end try

return k_return


end function

private subroutine put_video_nazioni (st_tab_clienti kst_tab_clienti);//
//--- Visualizza dati NAZIONE
//
long k_riga=0
datawindowchild kdwc_1


tab_1.tabpage_1.dw_1.modify( "id_nazione.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
tab_1.tabpage_1.dw_1.setitem( 1, "id_nazione", kst_tab_clienti.id_nazione_1 )

tab_1.tabpage_1.dw_1.getchild("id_nazione", kdwc_1)
k_riga = kdwc_1.find( "id_nazione = '" + trim(kst_tab_clienti.id_nazione_1) + "' " , 1, kdwc_1.rowcount())
if k_riga > 0 then
	tab_1.tabpage_1.dw_1.setitem(1, "nazioni_nome", kdwc_1.getitemstring(k_riga, "nome" ))
else
	tab_1.tabpage_1.dw_1.setitem(1, "nazioni_nome", " " )
end if

end subroutine

private subroutine riga_modifica ();//======================================================================
//=== 
//======================================================================
//
long k_riga=0, k_riga1=0, k_colli=0
st_tab_meca kst_tab_meca
st_tab_armo kst_tab_armo, kst_tab_armo_entrati, kst_tab_armo_trattati, kst_tab_armo_nontrattare, kst_tab_armo_fatturati
st_tab_arsp kst_tab_arsp, kst_tab_arsp_spediti, kst_tab_arsp_spedmax
st_tab_prodotti kst_tab_prodotti
st_tab_armo_nt kst_tab_armo_nt
st_tab_barcode kst_tab_barcode


try
	
	tab_1.tabpage_4.dw_riga_0.reset( )
	
	k_riga = tab_1.tabpage_4.dw_4.getselectedrow(0)
	if k_riga = 0 then
		messagebox("Operazione non eseguita", "Selezionare una riga dall'elenco", information!)
	else
		kiuf_sped.if_isnull_riga(kst_tab_arsp)
		kst_tab_meca.num_int = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "num_int" )
		kst_tab_meca.data_int = tab_1.tabpage_4.dw_4.getitemdate(k_riga, "data_int" )
		kst_tab_meca.id = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_meca" )
		kst_tab_armo.art = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "art" )
		kst_tab_armo.alt_2 = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "alt_2" )
		kst_tab_prodotti.des = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "des")
		kst_tab_arsp.stampa = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "stampa")
		kst_tab_arsp.colli = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "colli")
		kst_tab_arsp.colli_out = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "colli_out" )
		kst_tab_arsp.peso_kg_out = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "peso_kg_out")
		kst_tab_arsp.note_1 = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "note_1" )
		kst_tab_arsp.note_2 = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "note_2" )
		kst_tab_arsp.note_3 = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "note_3" )

		kst_tab_arsp.id_sped = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_sped")
		kst_tab_arsp.id_arsp = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_arsp")
		kst_tab_arsp.id_armo = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_armo" )

		kst_tab_meca.data_ent = tab_1.tabpage_4.dw_4.getitemdatetime(k_riga, "data_ent" )
		kst_tab_meca.e1doco = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "e1doco" )
		kst_tab_meca.e1rorn = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "e1rorn" )
		kst_tab_meca.e1srst = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "e1srst" )

		kst_tab_armo.id_armo = kst_tab_arsp.id_armo

//--- se serve get dei colli da spedire		
		kst_tab_arsp_spedmax.colli = get_colli_da_sped(kst_tab_armo)
		if kst_tab_arsp.colli > 0 then
		else
			kst_tab_arsp.colli = kst_tab_arsp_spedmax.colli
			kst_tab_arsp.colli_out = kst_tab_arsp_spedmax.colli
		end if

//--- get di una serie di dati da esporre 
		kst_tab_armo_entrati.id_armo = kst_tab_armo.id_armo
		kiuf_armo.get_altri_dati(kst_tab_armo_entrati)
		kst_tab_barcode.id_armo = kst_tab_armo.id_armo
		kst_tab_armo_trattati.colli_2 = kiuf_barcode.get_nr_barcode_trattati(kst_tab_barcode)
		kst_tab_armo_nontrattare.colli_2 = kiuf_barcode.get_nr_barcode_da_non_trattare_x_id_armo(kst_tab_barcode)
		kst_tab_arsp_spediti.id_armo = kst_tab_armo.id_armo
		kst_tab_arsp_spediti.colli = kiuf_sped.get_colli_sped(kst_tab_arsp_spediti)
		kst_tab_armo_fatturati.id_armo = kst_tab_armo.id_armo
		kiuf_armo.get_colli_fatturati(kst_tab_armo_fatturati)
		kst_tab_armo_nt.id_armo = kst_tab_armo.id_armo
//		kiuf_sped.get_note(kst_tab_arsp)
		kiuf_armo_nt.get_note(kst_tab_armo_nt)
	
		k_riga1=tab_1.tabpage_4.dw_riga_0.insertrow(0)
		tab_1.tabpage_4.dw_riga_0.setitem( k_riga1, "num_int", kst_tab_meca.num_int )
		tab_1.tabpage_4.dw_riga_0.setitem( k_riga1, "data_int", kst_tab_meca.data_int )
		tab_1.tabpage_4.dw_riga_0.setitem( k_riga1, "id_meca", kst_tab_meca.id )
		tab_1.tabpage_4.dw_riga_0.setitem( k_riga1, "id_armo", kst_tab_arsp.id_armo )
		tab_1.tabpage_4.dw_riga_0.setitem( k_riga1, "id_arsp", kst_tab_arsp.id_arsp )
		tab_1.tabpage_4.dw_riga_0.setitem( k_riga1, "stampa", kst_tab_arsp.stampa )
		tab_1.tabpage_4.dw_riga_0.setitem( k_riga1, "art", kst_tab_armo.art )
		tab_1.tabpage_4.dw_riga_0.setitem( k_riga1, "alt_2", kst_tab_armo.alt_2 )
		tab_1.tabpage_4.dw_riga_0.setitem( k_riga1, "dose", kst_tab_armo_entrati.dose )
		tab_1.tabpage_4.dw_riga_0.setitem( k_riga1, "magazzino", kst_tab_armo_entrati.magazzino )
		tab_1.tabpage_4.dw_riga_0.setitem( k_riga1, "armo_art_1", kst_tab_armo.art )
		tab_1.tabpage_4.dw_riga_0.setitem( k_riga1, "des", kst_tab_prodotti.des )
		tab_1.tabpage_4.dw_riga_0.setitem( k_riga1, "colli", kst_tab_arsp.colli )
		tab_1.tabpage_4.dw_riga_0.setitem( k_riga1, "colli_orig", kst_tab_arsp.colli )
		tab_1.tabpage_4.dw_riga_0.setitem( k_riga1, "colli_da_sped_max", kst_tab_arsp_spedmax.colli )
		tab_1.tabpage_4.dw_riga_0.setitem( k_riga1, "colli_out", kst_tab_arsp.colli_out )
		tab_1.tabpage_4.dw_riga_0.setitem( k_riga1, "peso_kg_out", kst_tab_arsp.peso_kg_out )
		tab_1.tabpage_4.dw_riga_0.setitem( k_riga1, "note_1", trim(kst_tab_arsp.note_1) )
		tab_1.tabpage_4.dw_riga_0.setitem( k_riga1, "note_2", trim(kst_tab_arsp.note_2) )
		tab_1.tabpage_4.dw_riga_0.setitem( k_riga1, "note_3", trim(kst_tab_arsp.note_3) )
		tab_1.tabpage_4.dw_riga_0.setitem( k_riga1, "stampa", kst_tab_arsp.stampa )
	
		tab_1.tabpage_4.dw_riga_0.setitem( k_riga1, "armo_colli_2", kst_tab_armo_entrati.colli_2 )
		tab_1.tabpage_4.dw_riga_0.setitem( k_riga1, "colli_trattati", kst_tab_armo_trattati.colli_2 )
		tab_1.tabpage_4.dw_riga_0.setitem( k_riga1, "colli_danontrattare", kst_tab_armo_nontrattare.colli_2 )
		tab_1.tabpage_4.dw_riga_0.setitem( k_riga1, "colli_spediti", kst_tab_arsp_spediti.colli )
		tab_1.tabpage_4.dw_riga_0.setitem( k_riga1, "colli_fatturati", kst_tab_armo_fatturati.colli_2 )
		tab_1.tabpage_4.dw_riga_0.setitem( k_riga1, "armo_peso_kg_in", kst_tab_armo_entrati.peso_kg )

		tab_1.tabpage_4.dw_riga_0.setitem( k_riga1, "data_ent", kst_tab_meca.data_ent )
		tab_1.tabpage_4.dw_riga_0.setitem( k_riga1, "e1doco", kst_tab_meca.e1doco )
		tab_1.tabpage_4.dw_riga_0.setitem( k_riga1, "e1rorn", kst_tab_meca.e1rorn )
		tab_1.tabpage_4.dw_riga_0.setitem( k_riga1, "e1srst", kst_tab_meca.e1srst )
		
		riga_modifica_display_note(kst_tab_armo_nt)
	
		tab_1.tabpage_4.dw_riga_0.setitem(k_riga1, "k_progressivo", tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "k_progressivo"))
	
		if kst_tab_arsp.id_arsp > 0 then
			tab_1.tabpage_4.dw_riga_0.title = "Dettaglio riga " + string(k_riga) + " (id=" + string(kst_tab_arsp.id_arsp) + ") " 
		else
			tab_1.tabpage_4.dw_riga_0.title = "Compilazione riga " + string(k_riga) 
		end if
	
//		tab_1.tabpage_4.dw_riga_0.object.b_ok.visible = false 
//		tab_1.tabpage_4.dw_riga_0.object.b_esci.visible = false 
//		tab_1.tabpage_4.dw_riga_0.object.b_armo_note.enabled = true
//		
//		tab_1.tabpage_4.dw_riga_0.visible = true		

	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try

	
end subroutine

protected subroutine inizializza_3 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 4 controllandone i valori se gia' presenti
//======================================================================
//
//string k_scelta
//string k_cadenza_fattura
int k_rc, k_ctr //, k_nriga
st_tab_sped kst_tab_sped, kst_tab_sped_prec
kuf_utility kuf1_utility 
uo_exception kuo_exception

if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then
	kst_tab_sped.id_sped = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_sped")  
end if
if kst_tab_sped.id_sped > 0 then

	if tab_1.tabpage_4.dw_4.rowcount() > 0 then
		kst_tab_sped_prec.id_sped = tab_1.tabpage_4.dw_4.getitemnumber(1, "id_sped")  
	end if
	if isnull(kst_tab_sped_prec.id_sped) then kst_tab_sped_prec.id_sped = 0
	
	if kst_tab_sped.id_sped <> kst_tab_sped_prec.id_sped then

		u_ddt_rows_retrieve()   // carica le righe nel DDT !!!!!!

//---- azzera il flag delle modifiche
		tab_1.tabpage_4.dw_4.resetupdate( )
		
	end if

else

//	inserisci()
	
end if

tab_1.tabpage_4.dw_4.setfocus()

attiva_tasti()
	

end subroutine

private subroutine dragdrop_dw_esterna (uo_d_std_1 kdw_source, long k_riga);//
//
int k_rc
long  k_riga1, k_ind_selected, k_ind
st_tab_sped kst_tab_sped
//st_tab_meca kst_tab_meca
st_tab_armo kst_tab_armo
st_tab_artr kst_tab_artr
//st_tab_armo kst_tab_armo_1[]
st_tab_clienti kst_tab_clienti
st_esito kst_esito
datawindowchild kdwc_1
//uo_exception kuo_exception1
//window k_window
//kuf_menu_window kuf1_menu_window 
///kuf_artr kuf1_artr



if k_riga > 0 then 

//--- Se dalla w di elenco 'prevista'  ho fatto doppio-click	 x scegliere la riga	
	if ki_tab_1_index_new = 1 then
		choose case kdw_source.dataobject 

//-- DROP nel TAB 1

//--- scelta da elenco Indirizzo
			case  kiuf_sped.kki_dw_elenco_indirizzi 
			
				if kdw_source.rowcount() > 0 then
		
					tab_1.tabpage_1.dw_1.setitem(1, "rag_soc_1", &
									 kdw_source.getitemstring(long(k_riga), "rag_soc_1"))
					tab_1.tabpage_1.dw_1.setitem(1, "rag_soc_2", &
									 kdw_source.getitemstring(long(k_riga), "rag_soc_2"))
					tab_1.tabpage_1.dw_1.setitem(1, "indi", &
									 kdw_source.getitemstring(long(k_riga), "indi"))
					tab_1.tabpage_1.dw_1.setitem(1, "cap", &
									 kdw_source.getitemstring(long(k_riga), "cap"))
					tab_1.tabpage_1.dw_1.setitem(1, "loc", &
									 kdw_source.getitemstring(long(k_riga), "loc"))
					tab_1.tabpage_1.dw_1.setitem(1, "prov", &
									 kdw_source.getitemstring(long(k_riga), "prov"))
					tab_1.tabpage_1.dw_1.setitem(1, "id_nazione", &
									 kdw_source.getitemstring(long(k_riga), "id_nazione"))
					tab_1.tabpage_1.dw_1.getchild("id_nazione", kdwc_1)
					k_riga1 = kdwc_1.find( "id_nazione = " + trim(kdw_source.getitemstring(long(k_riga), "id_nazione")) + " " , 1, kdwc_1.rowcount())
					if k_riga1 > 0 then
						tab_1.tabpage_1.dw_1.setitem(1, "nazioni_nome", kdwc_1.getitemstring(k_riga1, "nome" ) ) 
					else
						tab_1.tabpage_1.dw_1.setitem(1, "nazioni_nome", " " )
					end if
									 
				end if
		
//--- scelta da elenco NOTE
			case  kiuf_sped.kki_dw_elenco_note 
			
				if kdw_source.rowcount() > 0 then
					tab_1.tabpage_1.dw_1.setitem(1, "note_1",  kdw_source.getitemstring(long(k_riga), "note_1"))
				end if
		
//--- scelta da elenco Riceventi
			case "d_clienti_l_riceventi_xclie13" 
				if kdw_source.rowcount() > 0 then
					kst_tab_clienti.codice = long(kdw_source.getitemnumber(long(k_riga), "id_cliente"))
					kst_esito = kiuf_clienti.leggi_rag_soc(kst_tab_clienti)
					if kst_esito.esito = kkg_esito.ok then
						tab_1.tabpage_1.dw_1.setitem( 1, "meca_clie_2", kst_tab_clienti.codice)
						tab_1.tabpage_1.dw_1.setitem( 1, "meca_rag_soc_10", trim(kst_tab_clienti.rag_soc_10) + " " &
																	+ trim(kst_tab_clienti.rag_soc_11) + " " &
															+ trim(kst_tab_clienti.indi_1) + " " &
															+ trim(kst_tab_clienti.loc_1) + " " &
															+ trim(kst_tab_clienti.prov_1) + " " &
															+ string(kst_tab_clienti.id_nazione_1)  &
																	) 
					else
						tab_1.tabpage_1.dw_1.setitem( 1, "meca_clie_2", 0)
						tab_1.tabpage_1.dw_1.setitem( 1, "meca_rag_soc_10", "")
					end if
				end if
		
//--- scelta da elenco Clienti
			case "d_clienti_l_fatturati_xclie_2" 
				if kdw_source.rowcount() > 0 then
					kst_tab_clienti.codice = long(kdw_source.getitemnumber(long(k_riga), "id_cliente"))
					kst_esito = kiuf_clienti.leggi_rag_soc(kst_tab_clienti)
					if kst_esito.esito = kkg_esito.ok then
						tab_1.tabpage_1.dw_1.setitem( 1, "clie_3", kst_tab_clienti.codice)
						tab_1.tabpage_1.dw_1.setitem( 1, "clie3_rag_soc", trim(kst_tab_clienti.rag_soc_10) + " " &
															+ trim(kst_tab_clienti.rag_soc_11) + " " &
															+ trim(kst_tab_clienti.indi_1) + " " &
															+ trim(kst_tab_clienti.loc_1) + " " &
															+ trim(kst_tab_clienti.prov_1) + " " &
															+ string(kst_tab_clienti.id_nazione_1)  &
																	) 
					else
						tab_1.tabpage_1.dw_1.setitem( 1, "clie_3", 0)
						tab_1.tabpage_1.dw_1.setitem( 1, "clie3_rag_soc", "")
					end if
				end if

//--- scelta Ricevente alternativo per casi particolari
			case "d_m_r_f_l_2"
				if kdw_source.rowcount() > 0 then
					kst_tab_clienti.codice = long(kdw_source.getitemnumber(long(k_riga), "clie_2"))
					kst_esito = kiuf_clienti.leggi_rag_soc(kst_tab_clienti)
					if kst_esito.esito = kkg_esito.ok then
						tab_1.tabpage_1.dw_1.setitem( 1, "meca_clie_2", kst_tab_clienti.codice)
						tab_1.tabpage_1.dw_1.setitem( 1, "meca_rag_soc_10", trim(kst_tab_clienti.rag_soc_10) + " " &
															+ trim(kst_tab_clienti.rag_soc_11) + " " &
															+ trim(kst_tab_clienti.indi_1) + " " &
															+ trim(kst_tab_clienti.loc_1) + " " &
															+ trim(kst_tab_clienti.prov_1) + " " &
															+ string(kst_tab_clienti.id_nazione_1)  &
																	) 
					else
						tab_1.tabpage_1.dw_1.setitem( 1, "meca_clie_2", 0)
						tab_1.tabpage_1.dw_1.setitem( 1, "meca_rag_soc_10", "")
					end if
				end if

		end choose

	end if
	
//-- DROP nel TAB 4	
	if ki_tab_1_index_new = 4 then

		choose case kdw_source.dataobject 
	
//--- se torno da elenco Lotti da Spedire
			case kiuf_sped.kki_dw_meca_da_sped &
			, kids_elenco_da_sped_dosezero.dataobject

				if kdw_source.rowcount() > 0 then
	
					k_ind_selected = kdw_source.getselectedrow( 0 )
	
					do while k_ind_selected > 0 
						
						kst_tab_armo.id_meca = kdw_source.getitemnumber(k_ind_selected, "id_meca")
						kst_tab_armo.num_int = kdw_source.getitemnumber(k_ind_selected, "num_int")
						kst_tab_armo.data_int = kdw_source.getitemdate(k_ind_selected, "data_int")
						
						if kst_tab_armo.id_meca > 0 then
							riga_nuova_in_lista_meca(kst_tab_armo)  // Aggiunge le righe al ddt
						end if
						
						k_ind_selected = kdw_source.getselectedrow( (k_ind_selected) )
						
					loop
					
//					attiva_tasti()
					
//--- posiziona su ultima riga
					if tab_1.tabpage_4.dw_4.rowcount() > 0 then
						tab_1.tabpage_4.dw_4.selectrow( 0, false)
						tab_1.tabpage_4.dw_4.selectrow( tab_1.tabpage_4.dw_4.rowcount() , true)
						tab_1.tabpage_4.dw_4.scrolltorow( tab_1.tabpage_4.dw_4.rowcount() )
					end if						
				end if
			
	
//	//--- se torno da elenco Righe Fatturate (quando ad es. sono in N.C.)
//			case  kiuf_sped.kki_dw_righe_sped 
//		
//				if kdw_source.rowcount() > 0 then
//		
//					kst_tab_sped.id_armo = kdw_source.getitemnumber(long(k_riga), "id_armo")
//					kst_tab_sped.colli = 0 //kdw_source.getitemnumber(long(k_riga), "colli")
//					kst_tab_sped.colli_out = 0
//					kst_tab_sped.id_sped_se_nc = kdw_source.getitemnumber(long(k_riga), "id_sped")
//					kst_tab_meca.id = kdw_source.getitemnumber(long(k_riga), "id_meca")	
//					kst_tab_sped.art = kdw_source.getitemstring(long(k_riga), "art")	
//					kst_tab_sped.des = kdw_source.getitemstring(long(k_riga), "prodotti_des")	
//					kst_tab_sped.tipo_riga = kdw_source.getitemstring(long(k_riga), "tipo_riga")	
//					kst_tab_sped.tipo_l = kuf_listino.kki_tipo_prezzo_a_corpo
//					
////--- piglia i prezzi da riproporre nella N.C.
//					kst_tab_sped.id_sped = kdw_source.getitemnumber(long(k_riga), "id_sped")	
//					kiuf_sped.get_prezzi_spedura(kst_tab_sped)
//					kst_tab_sped.id_sped = 0
//					try	
//						riga_nuova_in_lista(kst_tab_sped, kst_tab_meca)			
//		
//						tab_1.tabpage_4.dw_4.setfocus()
//		
//					catch (uo_exception kuo_exception3)
//						kuo_exception3.messaggio_utente( )
//					end try
//
////--- posiziona su ultima riga
//					if tab_1.tabpage_4.dw_4.rowcount() > 0 then
//						tab_1.tabpage_4.dw_4.selectrow( 0, false)
//						tab_1.tabpage_4.dw_4.selectrow( tab_1.tabpage_4.dw_4.rowcount() , true)
//						tab_1.tabpage_4.dw_4.scrolltorow( tab_1.tabpage_4.dw_4.rowcount() )
//					end if						
//									 
//				end if
//
	
			
			
		end choose
		
		tab_1.tabpage_4.dw_4.setfocus()
	end if


	attiva_tasti()

end if





end subroutine

private subroutine call_elenco_note ();//
//--- Fa l'elenco delle NOTE documenti precedenti
//
pointer kp_oldpointer  // Declares a pointer variable


kp_oldpointer = SetPointer(HourGlass!)


	kist_tab_sped.clie_2 = tab_1.tabpage_1.dw_1.getitemnumber( 1, "clie_2")
	if kist_tab_sped.clie_2 > 0 then
		kiuf_sped.elenco_note( kist_tab_sped )
	end if
						
SetPointer(kp_oldpointer)

	


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


	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
		
		tab_1.tabpage_1.dw_1.getchild("clie_2", kdwc_1)
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

private subroutine put_video_vett (st_tab_sped_vettori ast_tab_sped_vettori);//
//--- Visualizza dati Pagamento
//

tab_1.tabpage_1.dw_1.modify( "id_vettore.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
tab_1.tabpage_1.dw_1.setitem( 1, "id_vettore", ast_tab_sped_vettori.id )

if ast_tab_sped_vettori.id > 0 then
	tab_1.tabpage_1.dw_1.setitem(1, "vett_1", ast_tab_sped_vettori.rag_soc_1 )
	if trim(ast_tab_sped_vettori.rag_soc_2) > " " then
		tab_1.tabpage_1.dw_1.setitem(1, "vett_2", ast_tab_sped_vettori.rag_soc_2 )
	end if
else
//	tab_1.tabpage_1.dw_1.setitem(1, "vett_1", " " )
//	tab_1.tabpage_1.dw_1.setitem(1, "vett_2", " " )
end if



end subroutine

private subroutine put_video_caus (st_tab_caus ast_tab_caus);//
//--- Visualizza dati Pagamento
//
long k_riga=0
datawindowchild kdwc_1


tab_1.tabpage_1.dw_1.modify( "caus_codice.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
tab_1.tabpage_1.dw_1.setitem( 1, "caus_codice", ast_tab_caus.codice )

tab_1.tabpage_1.dw_1.getchild("caus_codice", kdwc_1)
k_riga = kdwc_1.find( "codice = '" + trim(ast_tab_caus.codice) + "' " , 1, kdwc_1.rowcount())
if k_riga > 0 then
	tab_1.tabpage_1.dw_1.setitem(1, "causale", kdwc_1.getitemstring(k_riga, "des")  )
else
	tab_1.tabpage_1.dw_1.setitem(1, "causale", " " )
end if



end subroutine

private subroutine put_video_clie_3 (st_tab_clienti kst_tab_clienti);//
//--- Visualizza dati Cliente Fatturato
//
st_esito kst_esito


tab_1.tabpage_1.dw_1.modify( "clie_3.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
tab_1.tabpage_1.dw_1.setitem( 1, "clie_3", kst_tab_clienti.codice )
tab_1.tabpage_1.dw_1.modify( "clie_3_rag_soc.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
tab_1.tabpage_1.dw_1.setitem( 1, "clie_3_rag_soc", trim(kst_tab_clienti.rag_soc_10) )

tab_1.tabpage_1.dw_1.setitem( 1, "clie_3", kst_tab_clienti.codice)
tab_1.tabpage_1.dw_1.setitem( 1, "clie_3_rag_soc", kst_tab_clienti.rag_soc_10 )

attiva_tasti()


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
st_tab_sped kst_tab_sped
st_esito kst_esito,kst_esito1
datastore kds_inp_testa, kds_inp_righe


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//--- Controllo i tab
	if tab_1.tabpage_1.dw_1.rowcount() > 0 then
		kds_inp_testa = create datastore
		kds_inp_testa.dataobject = tab_1.tabpage_1.dw_1.dataobject
		tab_1.tabpage_1.dw_1.setrow(1)
		tab_1.tabpage_1.dw_1.rowscopy( 1,1,primary!, kds_inp_testa, 1, primary!)
		kds_inp_righe = create datastore
		kds_inp_righe.dataobject = tab_1.tabpage_4.dw_4.dataobject
		if tab_1.tabpage_4.dw_4.rowcount( ) = 0 and tab_1.tabpage_4.dw_4.deletedcount( ) = 0 then
			kst_tab_sped.id_sped = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_sped")  
			if kst_tab_sped.id_sped > 0 then
				tab_1.tabpage_4.dw_4.retrieve(kst_tab_sped.id_sped)  // carica le righe del DDT !!!!!!
				for k_ctr = 1 to tab_1.tabpage_4.dw_4.rowcount( ) 
					tab_1.tabpage_4.dw_4.setitem(k_ctr, "k_progressivo", k_ctr)
				end for
			end if
		end if
		tab_1.tabpage_4.dw_4.rowscopy( 1,tab_1.tabpage_4.dw_4.rowcount( ) ,primary!, kds_inp_righe, 1, primary!)
		tab_1.tabpage_4.dw_4.rowscopy( 1,tab_1.tabpage_4.dw_4.rowcount( ) ,delete!, kds_inp_righe, 1, delete!)
		kst_esito = kiuf_sped_checkmappa.u_check_dati(kds_inp_testa, kds_inp_righe)
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

private function integer riga_nuova_in_lista (ref st_tab_armo kst_tab_armo) throws uo_exception;//---
//--- aggiunge una riga nel DDT
//--- Inp: id_armo
//--- out: numero di riga caricata
//---
long k_riga=0
st_tab_arsp kst_tab_arsp
st_tab_meca kst_tab_meca
st_tab_prodotti kst_tab_prodotti
st_esito kst_esito


try

//--- devo avere passato il ID riga del lotto da spedire
	if kst_tab_armo.id_armo  > 0 then

//--- legge riga Lotto	
		kst_tab_arsp.id_armo = kst_tab_armo.id_armo
		kst_esito = kiuf_armo.leggi_riga("*", kst_tab_armo)
		if kst_esito.esito = kkg_esito.db_ko then
			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito )
			throw kguo_exception
		end if
		kst_tab_arsp.note_1 = kst_tab_armo.note_1
		kst_tab_arsp.note_2 = kst_tab_armo.note_2
		kst_tab_arsp.note_3 = kst_tab_armo.note_3
	
		kst_tab_arsp.id_sped = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_sped")

//--- legge dati articolo	
		if len(trim(kst_tab_armo.art)) > 0 then 
			kst_tab_prodotti.des = " "
			kst_tab_prodotti.codice = kst_tab_armo.art
			kst_esito = kiuf_prodotti.select_riga(kst_tab_prodotti )
			if kst_esito.esito = kkg_esito.ok then
			else
				if kst_esito.esito = kkg_esito.db_ko then
					kguo_exception.inizializza( )
					kguo_exception.set_esito( kst_esito )
					throw kguo_exception
				end if
			end if
		end if	

//--- legge colli da spedire
		kst_tab_arsp.colli = get_colli_da_sped(kst_tab_armo)

//--- se non ci sono colli da spedire non aggiunge la riga 		
		if kst_tab_arsp.colli > 0 then
			kst_tab_arsp.colli_out = kst_tab_arsp.colli
//--- legge altri dati dalla riga di entrata
			kiuf_armo.get_altri_dati(kst_tab_armo) 
			if kst_tab_armo.peso_kg > 0 and kst_tab_armo.colli_2 > 0 then
				kst_tab_arsp.peso_kg_out = kst_tab_armo.peso_kg / kst_tab_armo.colli_2 * kst_tab_arsp.colli
			end if

			if kst_tab_armo.id_meca > 0 then
				kst_tab_meca.id = kst_tab_armo.id_meca

//--- legge altri dati Lotto
				kiuf_armo.get_clie(kst_tab_meca)
				kst_tab_meca.data_ent = kiuf_armo.get_data_ent(kst_tab_meca)
				kiuf_armo.get_e1_dati(kst_tab_meca)

			end if
	
//--- inserisce la riga in elenco	
			k_riga = riga_nuova_in_lista_1 (kst_tab_arsp, kst_tab_armo, kst_tab_prodotti, kst_tab_meca)  

//--- controllo se c'e' un Lotto con Allarme MEMO			
			u_allarme_lotto()

		end if
	else
		kguo_exception.inizializza( )
		kst_esito.sqlerrtext = "Manca ID riga Lotto di entrata, non posso proseguire!"
		kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_non_eseguito)
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception
	end if

catch(uo_exception kuo_exception)
	throw kuo_exception


end try	
		
	
return k_riga

	
end function

private function integer riga_gia_presente (st_tab_arsp kst_tab_arsp);//---
//--- Controllo se riga magazzino presente in questa fattura
//--- inp: kst_tab_armo.id_armo
//--- out: boolean:   true=presente, false=non trovata
//
int k_return = 0


	if tab_1.tabpage_4.dw_4.rowcount() > 0 and kst_tab_arsp.id_armo > 0 then

		if kst_tab_arsp.id_arsp > 0 then
//				k_return = tab_1.tabpage_4.dw_4.find( "id_arsp = " + string(kst_tab_arsp.id_arsp) , 1, tab_1.tabpage_4.dw_4.rowcount() ) 
			k_return = tab_1.tabpage_4.dw_4.find( "id_arsp <> " + string(kst_tab_arsp.id_arsp) + " and id_armo = " + string(kst_tab_arsp.id_armo) , 1, tab_1.tabpage_4.dw_4.rowcount() ) 
				
		else
			k_return = tab_1.tabpage_4.dw_4.find( "id_armo = " + string(kst_tab_arsp.id_armo) , 1, tab_1.tabpage_4.dw_4.rowcount() ) 
				
		end if		
		
	end if

		
return k_return 	


end function

private subroutine elenco_lotti_da_sped ();//
//--- Fa l'elenco delle Entrate da Spedire (screma quelle già presenti nel ddt)
//
long k_ind, k_riga, k_ind_1, k_nr_lotti=0
date k_data_competenza_dal
datastore kds_1
st_tab_armo kst_tab_armo, kst_tab_armo_1[]
st_open_w kst_open_w 
st_report_merce_da_sped kst_report_merce_da_sped
kuf_elenco kuf1_elenco


try
	
	kst_report_merce_da_sped.k_clie_2 = tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "meca_clie_2")
	if kst_report_merce_da_sped.k_clie_2 > 0 then
	else
		kst_report_merce_da_sped.k_clie_2 = tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "clie_2")
	end if
	if kst_report_merce_da_sped.k_clie_2 > 0 then

		SetPointer(kkg.pointer_attesa)

		kst_report_merce_da_sped.k_data_da = tab_1.tabpage_1.dw_1.getitemdate(tab_1.tabpage_1.dw_1.getrow(), "k_competenza_dal")
		if (kst_report_merce_da_sped.k_clie_2) > 0 then

			if not isvalid(kiuf_report_merce_da_sped.kids_report_merce_da_sped) then
				destroy kiuf_report_merce_da_sped
				kiuf_report_merce_da_sped = create kuf_report_merce_da_sped
			end if
			k_nr_lotti = kiuf_report_merce_da_sped.kids_report_merce_da_sped.rowcount( )
			if k_nr_lotti <= 0 then
				
//--- lancia estrazione dei dati
				k_nr_lotti = kiuf_report_merce_da_sped.get_report(kst_report_merce_da_sped)
				
			else	
//--- se sono cambiati i parametri rifaccio la lettura				
				if kiuf_report_merce_da_sped.kids_report_merce_da_sped.getitemnumber(1, "k_clie_2") <> kst_report_merce_da_sped.k_clie_2 &
	 				    or date(kiuf_report_merce_da_sped.kids_report_merce_da_sped.getitemstring(1, "k_data_int")) <> kst_report_merce_da_sped.k_data_da &
						or ki_riga_rimossaxelencolotti then

					ki_riga_rimossaxelencolotti = false   // x non rifare la retieve
//--- lancia estrazione dei dati
					k_nr_lotti = kiuf_report_merce_da_sped.get_report(kst_report_merce_da_sped)
					
				end if
			end if

//--- Screma lotti già nel documento 			
			if k_nr_lotti > 0 then
				k_nr_lotti = elenco_lotti_da_sped_1()
			end if
			
			if k_nr_lotti > 0 then

//--- copia del datastore da passare allo zoom		
				kds_1 = create datastore
				kds_1.dataobject = kiuf_report_merce_da_sped.kids_report_merce_da_sped.dataobject
				kiuf_report_merce_da_sped.kids_report_merce_da_sped.rowscopy( 1, kiuf_report_merce_da_sped.kids_report_merce_da_sped.rowcount( ) , primary!, kds_1, 1, primary! )
				
//--- chiamare la window di elenco
				kuf1_elenco = create kuf_elenco
				kst_open_w.id_programma = kkg_id_programma.elenco
				kst_open_w.flag_primo_giro = "S"
				kst_open_w.flag_modalita = kkg_flag_modalita.elenco
				kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
				kst_open_w.flag_leggi_dw = " "
				kst_open_w.flag_cerca_in_lista = " "
				kst_open_w.key1 = "Lotti da spedire (dose>zero)" 
				kst_open_w.key2 = trim(kds_1.dataobject)
				kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
				kst_open_w.key4 = trim(kiw_this_window.title)   //--- Titolo della Window di chiamata per riconoscerla
				kst_open_w.key6 = " "    //--- nome del campo cliccato
				kst_open_w.key7 = kuf1_elenco.ki_esci_dopo_scelta  // esce subito dopo la scelta
				kst_open_w.key12_any = kds_1
				kst_open_w.flag_where = " "
				kuf1_elenco.u_open(kst_open_w)
			
				tab_1.selectedtab = 4
			else
				
				messagebox("Elenco Dati", &
							"Nessun Lotto da spedire per il Ricevente " + string(kst_report_merce_da_sped.k_clie_2) + " dal " + string(kst_report_merce_da_sped.k_data_da)  )
				
				
			end if
		end if

		SetPointer(kkg.pointer_default)
	else

		tab_1.selectedtab = 1

//--- se manca il CLIENTE allora chiedo il Numero Bolla per reperirlo
		dw_anno_numero.title = "Ricerca Ricevente; indicare il nr. Lotto (Riferimento) "
		dw_anno_numero.setcolumn( "numero")
		dw_anno_numero.SelectText(1, Len(dw_anno_numero.GetText()))
		dw_anno_numero.visible = true
		dw_anno_numero.setfocus()

	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try


end subroutine

private function integer get_totale_colli ();//--
//---  Torna Totale Colli OUT delle righe di questo documento 
//---
int k_return = 0, k_ctr=0
st_tab_arsp kst_tab_arsp

	
//--- calcolo il totale colli 	
	kst_tab_arsp.colli_out=0
	for k_ctr= 1 to tab_1.tabpage_4.dw_4.rowcount( )
		kst_tab_arsp.colli_out = tab_1.tabpage_4.dw_4.getitemnumber(k_ctr, "colli_out")
		if kst_tab_arsp.colli_out > 0 then
			k_return += kst_tab_arsp.colli_out 
		end if
	next

return k_return


end function

private subroutine call_elenco_riceventi ();//
//--- Fa l'elenco dei Riceventi
//
st_tab_sped kst_tab_sped
st_open_w kst_open_w 
kuf_elenco kuf1_elenco


	try
	
		SetPointer(kkg.pointer_attesa)

		if not isvalid(kids_elenco_riceventi) then 
			kids_elenco_riceventi = create datastore
			kids_elenco_riceventi.dataobject = "d_m_r_f_l_2"
			kids_elenco_riceventi.settransobject(kguo_sqlca_db_magazzino)
		end if
		kids_elenco_riceventi.reset()
		kst_tab_sped.clie_2 = tab_1.tabpage_1.dw_1.getitemnumber( 1, "clie_2")
		if kst_tab_sped.clie_2 > 0 then
			kids_elenco_riceventi.retrieve(kst_tab_sped.clie_2)
		end if
		
		if kids_elenco_riceventi.rowcount() > 0 then

//--- chiamare la window di elenco
			kuf1_elenco = create kuf_elenco
			kst_open_w.id_programma = kkg_id_programma.elenco
			kst_open_w.flag_primo_giro = "S"
			kst_open_w.flag_modalita = kkg_flag_modalita.elenco
			kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
			kst_open_w.flag_leggi_dw = " "
			kst_open_w.flag_cerca_in_lista = " "
			kst_open_w.key1 = "Elenco Riceventi " 
			kst_open_w.key2 = trim(kids_elenco_riceventi.dataobject)
			kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
			kst_open_w.key4 = trim(kiw_this_window.title)   //--- Titolo della Window di chiamata per riconoscerla
			kst_open_w.key6 = " "    //--- nome del campo cliccato
			kst_open_w.key12_any = kids_elenco_riceventi
			kst_open_w.key7 = kuf1_elenco.ki_esci_dopo_scelta  // esce subito dopo la scelta
			kuf1_elenco.u_open(kst_open_w)
		else
				
			messagebox("Elenco Dati", "Nessun Ricevente trovato "  )
		end if

		SetPointer(kkg.pointer_default)

	
	catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
	end try


end subroutine

private subroutine call_elenco_fatt ();//
//--- Fa l'elenco Clienti
//
st_tab_sped kst_tab_sped
st_open_w kst_open_w 
kuf_elenco kuf1_elenco


	try
	
		SetPointer(kkg.pointer_attesa)

		if not isvalid(kids_elenco_fatt) then 
			kids_elenco_fatt = create datastore
			kids_elenco_fatt.dataobject = "d_clienti_l_fatturati_xclie_2"
			kids_elenco_fatt.settransobject(kguo_sqlca_db_magazzino)
		end if
		kids_elenco_fatt.reset()
		kst_tab_sped.clie_2 = tab_1.tabpage_1.dw_1.getitemnumber( 1, "meca_clie_2")
		if kst_tab_sped.clie_2 = 0 then
			kst_tab_sped.clie_2 = tab_1.tabpage_1.dw_1.getitemnumber( 1, "clie_2")
		end if
		if kst_tab_sped.clie_2 > 0 then
			kids_elenco_fatt.retrieve(kst_tab_sped.clie_2)
		end if
		
		if kids_elenco_fatt.rowcount() > 0 then

//--- chiamare la window di elenco
			kuf1_elenco = create kuf_elenco
			kst_open_w.id_programma = kkg_id_programma.elenco
			kst_open_w.flag_primo_giro = "S"
			kst_open_w.flag_modalita = kkg_flag_modalita.elenco
			kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
			kst_open_w.flag_leggi_dw = " "
			kst_open_w.flag_cerca_in_lista = " "
			kst_open_w.key1 = "Elenco Clienti " 
			kst_open_w.key2 = trim(kids_elenco_fatt.dataobject)
			kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
			kst_open_w.key4 = trim(kiw_this_window.title)   //--- Titolo della Window di chiamata per riconoscerla
			kst_open_w.key6 = " "    //--- nome del campo cliccato
			kst_open_w.key12_any = kids_elenco_fatt
			kst_open_w.key7 = kuf1_elenco.ki_esci_dopo_scelta  // esce subito dopo la scelta
			kuf1_elenco.u_open(kst_open_w)
		else
				
			messagebox("Elenco Dati", "Nessun Cliente trovato "  )
		end if

		SetPointer(kkg.pointer_default)

	
	catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
	end try


end subroutine

public function integer get_colli_da_sped (st_tab_armo ast_tab_armo) throws uo_exception;//---
//--- Calcola i colli da spedire 
//--- input: st_tab_armo.id_armo
//--- rit. numero max colli spedibili
//---
integer k_return=0
st_tab_arsp kst_tab_arsp


try

	kst_tab_arsp.id_armo = ast_tab_armo.id_armo
	kst_tab_arsp.id_sped = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_sped")
	k_return = kiuf_sped_checkmappa.get_colli_da_sped(kst_tab_arsp)

catch (uo_exception kuo_exception)
	throw kuo_exception
//	kuo_exception.messaggio_utente()
	
end try 


return k_return

end function

public function boolean stampa_ddt ();//
boolean k_return = false
string k_errore = "0"
st_tab_sped kst_tab_sped[1]

//
//--- Controllo se ho modificato dei dati nella DW DETTAGLIO
if left(dati_modif(""), 1) = "1" then //Richisto Aggiornamento

//=== Controllo congruenza dei dati caricati e Aggiornamento  
//=== Ritorna 1 char : 0=tutto OK; 1=errore grave;
//===                : 2=errore non grave dati aggiornati;
//===			         : 3=LIBERO
//===      il resto della stringa contiene la descrizione dell'errore   
	k_errore = aggiorna_dati()

end if

 
if left(k_errore, 1) = "0" then
//--- stampa DDT
	kst_tab_sped[1].id_sped = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_sped")
	if kst_tab_sped[1].id_sped > 0 then
		kst_tab_sped[1].num_bolla_out = tab_1.tabpage_1.dw_1.getitemnumber(1, "num_bolla_out")
		kst_tab_sped[1].data_bolla_out = tab_1.tabpage_1.dw_1.getitemdate(1, "data_bolla_out")
		
		k_return = kiuf_sped.u_open_stampa(kst_tab_sped[])
		
	end if
end if


return k_return

end function

private subroutine riga_display_in_lista (integer k_riga, st_tab_arsp kst_tab_arsp, st_tab_armo kst_tab_armo, st_tab_prodotti kst_tab_prodotti, st_tab_meca kst_tab_meca) throws uo_exception;//
//--- Visualizza la Riga in Elenco
//
int k_colli=0
st_tab_sped kst_tab_sped
st_esito kst_esito


	kiuf_sped.if_isnull_riga(kst_tab_arsp)

	tab_1.tabpage_4.dw_4.setitem(k_riga, "num_int"  ,kst_tab_armo.num_int )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "data_int"  ,kst_tab_armo.data_int )

	tab_1.tabpage_4.dw_4.setitem(k_riga, "alt_2"  ,kst_tab_armo.alt_2 )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "art"  ,kst_tab_armo.art )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "des"  ,kst_tab_prodotti.des )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "clie_3"  ,kst_tab_meca.clie_3 )
	
	tab_1.tabpage_4.dw_4.setitem(k_riga, "colli"  ,kst_tab_arsp.colli )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "colli_out"  ,kst_tab_arsp.colli_out )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "peso_kg_out"  ,kst_tab_arsp.peso_kg_out )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "id_sped"  ,kst_tab_arsp.id_sped )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "id_arsp"  ,kst_tab_arsp.id_arsp )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "id_meca"  ,kst_tab_armo.id_meca )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "id_armo"  ,kst_tab_arsp.id_armo )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "stampa"  ,kst_tab_arsp.stampa )

	tab_1.tabpage_4.dw_4.setitem(k_riga, "note_1"  ,kst_tab_arsp.note_1 )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "note_2"  ,kst_tab_arsp.note_2 )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "note_3"  ,kst_tab_arsp.note_3 )

	tab_1.tabpage_4.dw_4.setitem(k_riga, "data_ent" ,kst_tab_meca.data_ent )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "e1doco"  ,kst_tab_meca.e1doco )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "e1rorn"  ,kst_tab_meca.e1rorn )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "e1srst"  ,kst_tab_meca.e1srst )
	
	if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then
//--- imposta il numero colli dell'intero ddt
		set_totale_colli( )
	end if


	
end subroutine

private function integer riga_nuova_in_lista_1 (ref st_tab_arsp ast_tab_arsp, st_tab_armo ast_tab_armo, st_tab_prodotti kst_tab_prodotti, st_tab_meca kst_tab_meca) throws uo_exception;//---
//--- aggiunge una riga di spedizione
//--- Inp: st_tab_arsp.* + alcuni campi della st_tab_armo e st_tab_prodotti st_tab_meca.clie_3
//--- out: numero di riga caricato
//---
long k_return=0
long k_riga_nuova=0, k_riga_presente=0
st_tab_arfa kst_tab_arfa
kuf_fatt kuf1_fatt

try

//--- Check se riga già presente in elenco
	k_riga_presente = riga_gia_presente (ast_tab_arsp) 
	if k_riga_presente > 0 then
		kguo_exception.inizializza( )
		kguo_exception.setmessage( "Articolo già caricato alla riga nr. " + string(k_riga_presente)+" !!")
		kguo_exception.messaggio_utente( "Fare Attenzione", "")
	else			
			
//--- NUOVA RIGA			
		k_riga_nuova = tab_1.tabpage_4.dw_4.insertrow(0)
		k_return = k_riga_nuova  // imposta il valore di ritorno
	
		tab_1.tabpage_4.dw_4.setitem(k_riga_nuova, "k_progressivo", k_riga_nuova)

//--- inserisce la riga in elenco	
		riga_display_in_lista (k_riga_nuova, ast_tab_arsp, ast_tab_armo, kst_tab_prodotti, kst_tab_meca)  
		
		kuf1_fatt = create kuf_fatt
		if ast_tab_armo.id_armo > 0 then
			kst_tab_arfa.id_armo = ast_tab_armo.id_armo
			if kuf1_fatt.get_colli_x_id_armo(kst_tab_arfa) > 0 then
				kguo_exception.inizializza( )
				kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_wrn)
				if k_riga_presente > 0 then
					kguo_exception.setmessage( "Riga già in Fattura, per " + string(kst_tab_arfa.colli) + " colli. Alla riga nr. = " + string(k_riga_presente)+" ")
				else
					kguo_exception.setmessage( "Riga già in Fattura, per " + string(kst_tab_arfa.colli) + " colli. ")
				end if
				kguo_exception.messaggio_utente( "Fare Attenzione", "")
			end if
		end if
		
	end if


catch(uo_exception kuo_exception)
	throw kuo_exception


end try

		
		
	
return k_return

	
end function

private function integer riga_modifica_in_lista (long a_riga, st_tab_arsp ast_tab_arsp, st_tab_armo ast_tab_armo, st_tab_prodotti ast_tab_prodotti, st_tab_meca kst_tab_meca) throws uo_exception;//
//--- aggiunge una riga 
//
//long k_riga=0


//k_riga = tab_1.tabpage_4.dw_4.find( "k_progressivo = " +  string(tab_1.tabpage_4.dw_riga_0.getitemnumber(tab_1.tabpage_4.dw_riga_0.getrow(), "k_progressivo")), 1,  tab_1.tabpage_4.dw_4.rowcount()) 

if a_riga > 0 then

//--- espone i dati circa l'articolo, prezzo, iva ecc... 	
	riga_display_in_lista (a_riga, ast_tab_arsp, ast_tab_armo, ast_tab_prodotti, kst_tab_meca)  

end if
	
	
return a_riga

	
end function

private subroutine riga_modifica_display_note (st_tab_armo_nt ast_tab_armo_nt);//======================================================================
//=== 
//======================================================================
//
long k_riga=0
	
k_riga = tab_1.tabpage_4.dw_riga_0.rowcount()
if k_riga > 0 then

	tab_1.tabpage_4.dw_riga_0.setitem( 1, "armo_nt_note_1", ast_tab_armo_nt.note[1] )
	tab_1.tabpage_4.dw_riga_0.setitem( 1, "armo_nt_note_2", ast_tab_armo_nt.note[2] )
	tab_1.tabpage_4.dw_riga_0.setitem( 1, "armo_nt_note_3", ast_tab_armo_nt.note[3] )
	tab_1.tabpage_4.dw_riga_0.setitem( 1, "armo_nt_note_4", ast_tab_armo_nt.note[4] )
	tab_1.tabpage_4.dw_riga_0.setitem( 1, "armo_nt_note_5", ast_tab_armo_nt.note[5] )
	tab_1.tabpage_4.dw_riga_0.setitem( 1, "armo_nt_note_6", ast_tab_armo_nt.note[6] )
	tab_1.tabpage_4.dw_riga_0.setitem( 1, "armo_nt_note_7", ast_tab_armo_nt.note[7] )
	tab_1.tabpage_4.dw_riga_0.setitem( 1, "armo_nt_note_8", ast_tab_armo_nt.note[8] )
	tab_1.tabpage_4.dw_riga_0.setitem( 1, "armo_nt_note_9", ast_tab_armo_nt.note[9] )
	tab_1.tabpage_4.dw_riga_0.setitem( 1, "armo_nt_note_10", ast_tab_armo_nt.note[10] )

end if
	
end subroutine

public subroutine u_allarme_cliente (readonly st_tab_clienti ast_tab_clienti) throws uo_exception;////
//boolean k_return = false
//st_memo_allarme kst_memo_allarme
//
//
//try
//	
////--- Gestione di Allert per il cliente 	
//	if ast_tab_clienti.codice > 0 then
//		kst_memo_allarme.allarme = kguf_memo_allarme.kki_memo_allarme_ddt
//		kst_memo_allarme.st_memo.st_tab_clienti_memo.id_cliente = ast_tab_clienti.codice
//		kst_memo_allarme.descr = "Avviso rilevato sul Cliente " + string(ast_tab_clienti.codice) + ", ddt: " + string(tab_1.tabpage_1.dw_1.getitemnumber(1, "num_bolla_out"))
//		if kguf_memo_allarme.set_allarme_cliente(kst_memo_allarme) then
//			kguf_memo_allarme.u_attiva_memo_allarme_on()
//		end if
//	else
//		kguf_memo_allarme.inizializza()
//	end if
//	
//catch (uo_exception kuo_exception)
//	throw kuo_exception
//	
//
//finally
//	
//end try



end subroutine

public subroutine u_get_numero_lotto ();//

	dw_anno_numero.post event u_attiva()



end subroutine

private function long riga_nuova_in_lista_meca (st_tab_armo ast_tab_armo);//--------------------------------------------------------------------------------------------------------------
//--- Aggiunge le righe di un lotto sul DDT
//--- input: ast_tab_armo.id_meca
//--------------------------------------------------------------------------------------------------------------
//
long k_return = 0
int k_rc
long  k_riga, k_ind
st_tab_armo kst_tab_armo
st_tab_armo kst_tab_armo_1[]
//st_esito kst_esito


	if ast_tab_armo.id_meca > 0 then
		
		kst_tab_armo_1[1].id_meca = ast_tab_armo.id_meca
		kiuf_armo_inout.get_righe_da_sped(kst_tab_armo_1[])

		for k_ind = 1 to upperbound(kst_tab_armo_1[])

			if kst_tab_armo_1[k_ind].id_armo > 0 then
				try	
//--- Aggiungi riga nel Documento										
					kst_tab_armo.id_armo =  kst_tab_armo_1[k_ind].id_armo
					k_riga = riga_nuova_in_lista(kst_tab_armo)		

				catch (uo_exception kuo_exception)
					kuo_exception.messaggio_utente( )

				end try
				
			end if

		end for
	end if
						
	if k_riga > 0 then k_return = k_riga


return k_return


end function

private subroutine call_indirizzi_storici ();//
//--- Fa l'elenco Indirizzi ddt precedenti
//
pointer kp_oldpointer  // Declares a pointer variable


kp_oldpointer = SetPointer(HourGlass!)


	kist_tab_sped.clie_2 = tab_1.tabpage_1.dw_1.getitemnumber( 1, "clie_2")
	if kist_tab_sped.clie_2 > 0 then
		kiuf_sped.elenco_indirizzi_ddt( kist_tab_sped )
	end if
						
SetPointer(kp_oldpointer)

	



		
		
		


end subroutine

private subroutine elenco_lotti_da_sped_dosezero ();//
//--- Fa l'elenco delle Entrate da Spedire (screma quelle già presenti nel ddt)
//
long k_ind, k_riga, k_ind_1, k_nr_lotti=0
date k_data_competenza_dal
st_tab_armo kst_tab_armo, kst_tab_armo_1[]
st_open_w kst_open_w 
st_report_merce_da_sped kst_report_merce_da_sped
kuf_elenco kuf1_elenco
datastore kds_1


try
	
	SetPointer(kkg.pointer_attesa)
	
	k_nr_lotti = kids_elenco_da_sped_dosezero.retrieve()
	
//		kst_report_merce_da_sped.k_data_da = tab_1.tabpage_1.dw_1.getitemdate(tab_1.tabpage_1.dw_1.getrow(), "k_competenza_dal")
	if k_nr_lotti > 0 then
		
		kds_1 = create datastore
		kds_1.dataobject = kids_elenco_da_sped_dosezero.dataobject
		kids_elenco_da_sped_dosezero.rowscopy( 1, kids_elenco_da_sped_dosezero.rowcount( ) , primary!, kds_1, 1, primary! )
		
//--- chiamare la window di elenco
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
		kst_open_w.key1 = "Lotti materiale (dose=zero)" 
		kst_open_w.key2 = trim(kds_1.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = trim(kiw_this_window.title)   //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key6 = " "    //--- nome del campo cliccato
		kst_open_w.key7 = kuf1_elenco.ki_esci_dopo_scelta  // esce subito dopo la scelta
		kst_open_w.key12_any = kds_1
		kst_open_w.flag_where = " "
		kuf1_elenco = create kuf_elenco 
		kuf1_elenco.u_open(kst_open_w)
	
		tab_1.selectedtab = 4
	else
		
		messagebox("Elenco Dati", &
					"Nessun Lotto per materiale da non trattare da spedire trovato ")
		
		
	end if

	SetPointer(kkg.pointer_default)

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try


end subroutine

private subroutine set_video_vett (st_tab_sped ast_tab_sped);//
//--- Imposta i campi di Vettore
//
kuf_utility kuf1_utility


if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica or trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento then

	kuf1_utility = create kuf_utility
	if ast_tab_sped.cura_trasp <> "V" then // se diverso da VETTORE allora protegge i campi
		tab_1.tabpage_1.dw_1.setitem(1, "id_vettore", 0)
		tab_1.tabpage_1.dw_1.setitem(1, "vett_1", " ")
		tab_1.tabpage_1.dw_1.setitem(1, "vett_2", " ")
		kuf1_utility.u_proteggi_dw("1", "id_vettore", tab_1.tabpage_1.dw_1)
		kuf1_utility.u_proteggi_dw("1", "vett_1", tab_1.tabpage_1.dw_1)
		kuf1_utility.u_proteggi_dw("1", "vett_2", tab_1.tabpage_1.dw_1)
	else
		kuf1_utility.u_proteggi_dw("0", "id_vettore", tab_1.tabpage_1.dw_1)
		kuf1_utility.u_proteggi_dw("0", "vett_1", tab_1.tabpage_1.dw_1)
		kuf1_utility.u_proteggi_dw("0", "vett_2", tab_1.tabpage_1.dw_1)
	end if

end if


end subroutine

private function integer set_totale_colli ();//
//--- Imposta campo colli in testata
//
int k_colli=0, k_colli_out=0
st_tab_sped kst_tab_sped

	
//--- becco colli totali in automatico
	k_colli = get_totale_colli( )

//--- valorizzo il numero colli dell'intero ddt
	if  tab_1.tabpage_1.dw_1.rowcount( ) > 0 then
		k_colli_out = tab_1.tabpage_1.dw_1.getitemnumber(1, "k_tot_colli_out")
		kst_tab_sped.colli = tab_1.tabpage_1.dw_1.getitemnumber(1, "colli")
		if isnull(kst_tab_sped.colli) then kst_tab_sped.colli = 0 
	
	//--- se i colli in testata sono uguali a quelli di appoggio calcolati vuol dire che impostazione in automatico
		if kst_tab_sped.colli = k_colli_out or (k_colli_out = 0 and ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento) then
			kst_tab_sped.colli = k_colli
			tab_1.tabpage_1.dw_1.setitem(1, "colli", kst_tab_sped.colli)
		end if
	
	//--- Aggiorna colli di appoggio calcolati in automatico
		tab_1.tabpage_1.dw_1.setitem(1, "k_tot_colli_out", k_colli)
		
	else
		
		kst_tab_sped.colli = k_colli 
		
	end if

return kst_tab_sped.colli

end function

private subroutine get_cliente_da_armo (st_tab_meca kst_tab_meca) throws uo_exception;//
//--- Piglia il codice cliente da LOTTO 
//
//long k_riga
kuf_sped kuf1_sped 
st_tab_sped kst_tab_sped 
st_tab_clienti kst_tab_clienti
st_esito kst_esito



kst_tab_clienti.codice = 0

	
try 
	if kst_tab_meca.id > 0 then 
		kiuf_armo.get_clie( kst_tab_meca ) // ...poi pesca il cliente con ID_MECA
		if kst_tab_meca.clie_2 > 0 then
			kst_tab_clienti.codice = kst_tab_meca.clie_2 
		end if
	end if

catch (uo_exception kuo1_exception)
	throw kuo1_exception

end try

//--- Legge e imposta il cliente nel form
if kst_tab_clienti.codice > 0 then

	get_dati_cliente(kst_tab_clienti)
	put_video_clie_2(kst_tab_clienti)

end if



		
end subroutine

public subroutine add_lotto_da_id_meca (st_tab_meca kst_tab_meca) throws uo_exception;//
//--- Aggiunge righe lotto al DDT anche la testata se non esiste
//
long k_riga = 0
st_tab_armo kst_tab_armo
st_tab_meca kst_tab_meca_1


try

	if kst_tab_meca.id > 0 then
		
		if kst_tab_meca.num_int = 0 then
			kiuf_armo.get_num_int(kst_tab_meca)
		end if
		kst_tab_armo.id_meca = kst_tab_meca.id
		kst_tab_armo.num_int = kst_tab_meca.num_int
		kst_tab_armo.data_int = kst_tab_meca.data_int
		
		if tab_1.tabpage_1.dw_1.rowcount( ) = 0 then 
			inserisci()
			kst_tab_meca.clie_2 = 0
		else
			kst_tab_meca.clie_2 = tab_1.tabpage_1.dw_1.getitemnumber(1, "meca_clie_2") 
			if kst_tab_meca.clie_2 > 0 then
			else
				kst_tab_meca.clie_2 = tab_1.tabpage_1.dw_1.getitemnumber(1, "clie_2") 
			end if
		end if

//--- se cliente già indicato non lo prendo	
		if kst_tab_meca.clie_2 > 0 then
			kst_tab_meca_1 = kst_tab_meca
			kiuf_armo.get_clie(kst_tab_meca_1)  //--- get del ricevente
			if kst_tab_meca_1.clie_2 > 0 and kst_tab_meca_1.clie_2 <> kst_tab_meca.clie_2 then
				kguo_exception.inizializza( )
				kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_non_eseguito)
				kguo_exception.setmessage("Ricevente " + string(kst_tab_meca_1.clie_2) + " del Lotto " + string(kst_tab_armo.num_int) + " " + string(kst_tab_armo.data_int) &
													+ " diverso da quello del documento (" + string(kst_tab_meca.clie_2) + ") !")
				throw kguo_exception
			end if
		else
			get_cliente_da_armo(kst_tab_meca)    // imposta i dati cliente in mappa
		end if

		k_riga = riga_nuova_in_lista_meca(kst_tab_armo)  // Aggiunge le righe al ddt
		if k_riga > 0 then
			tab_1.selecttab(4)
		else
			kguo_exception.inizializza( )
			kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_non_eseguito)
			kguo_exception.setmessage("Lotto " + string(kst_tab_armo.num_int) + " " + string(kst_tab_armo.data_int) &
												+ " senza righe da aggiungere, probabilmente già evaso")
			throw kguo_exception
		end if
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try



end subroutine

private function long elenco_lotti_da_sped_1 ();//
//--- Fa l'elenco delle Entrate da Spedire (screma quelle già presenti nel ddt) chiamata da elenco_lotti_da_sped
//--- torna il nr righe trovate
//
long k_return=0
long k_ind, k_riga, k_ind_1
date k_data_competenza_dal
st_tab_armo kst_tab_armo, kst_tab_armo_1[]


try
	
	SetPointer(kkg.pointer_attesa)
				
	//-- screma elenco da righe già nel documento
	for k_ind = 1 to tab_1.tabpage_4.dw_4.rowcount( ) 
		kst_tab_armo.id_meca = tab_1.tabpage_4.dw_4.getitemnumber( k_ind, "id_meca")
		if kst_tab_armo.id_meca > 0 then 
			k_riga = kiuf_report_merce_da_sped.kids_report_merce_da_sped.find( "id_meca = " + string( kst_tab_armo.id_meca) + " " , 1, kiuf_report_merce_da_sped.kids_report_merce_da_sped.rowcount( ) )
			if k_riga > 0 then
				kst_tab_armo_1[1].id_meca = kst_tab_armo.id_meca
				if kiuf_armo.get_righe(kst_tab_armo_1[]) > 1 then
					for k_ind_1=1 to UpperBound(kst_tab_armo_1)
						k_riga = tab_1.tabpage_4.dw_4.find( "id_armo = " + string( kst_tab_armo_1[k_ind_1].id_armo) + " " , 1, tab_1.tabpage_4.dw_4.rowcount( ) )
						if k_riga = 0 then exit
					next
					if k_riga > 0 then
						kiuf_report_merce_da_sped.kids_report_merce_da_sped.deleterow( k_riga ) // ho trovato tutte le righe del lotto gia' qui per cui rimuovo da elenco
					end if
				else
					kiuf_report_merce_da_sped.kids_report_merce_da_sped.deleterow( k_riga ) // ho trovato una sola riga nel lotto per cui e' sicuramente questa
				end if
			end if
		end if
	next
	
	
	k_return = kiuf_report_merce_da_sped.kids_report_merce_da_sped.rowcount( )

	SetPointer(kkg.pointer_default)

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try

return k_return
end function

public function st_esito u_aggiorna_base (st_tab_sped ast_tab_sped);//---
//--- Aggiorna Numero e Data DDT su archivio BASE
//---
string k_dato_base
st_esito kst_esito
st_tab_base kst_tab_base
kuf_base kuf1_base

			
	kuf1_base = create kuf_base

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
			
	kst_tab_base.st_tab_g_0.esegui_commit = "S" 
	kst_tab_base.key = "numdata_ddt"
	k_dato_base = kuf1_base.prendi_dato_base(kst_tab_base.key)
	if left(k_dato_base, 1) = "0" then 
		kst_tab_base.num_bolla = long(mid(k_dato_base,2,12))
	//	kst_tab_base.key = "data_bolla_out"
		kst_tab_base.data_bolla = date(mid(k_dato_base,15)) //kuf1_base.prendi_dato_base( kst_tab_base.key ),2 ))
	//if kst_tab_base.num_bolla > 1 then
		if ast_tab_sped.num_bolla_out > kst_tab_base.num_bolla and year(ast_tab_sped.data_bolla_out) = year(kst_tab_base.data_bolla) then // se n ddt > di quello su BASE..
			if ast_tab_sped.num_bolla_out > (kst_tab_base.num_bolla + 10) then  // ma non deve essere troppo superiore...
				kst_esito.esito = kkg_esito.no_esecuzione
				kst_esito.SQLErrText = "N.DTT " + string(ast_tab_sped.num_bolla_out) + " troppo avanti rispetto a " + string(kst_tab_base.num_bolla) + " di Proprietà Azienda. Procedere manualmente."
			else
				kst_tab_base.key = "num_bolla_out"
				kst_tab_base.key1 = string(ast_tab_sped.num_bolla_out)	
				kst_esito = kuf1_base.metti_dato_base( kst_tab_base )
				if kst_esito.esito = kkg_esito.ok then 
					kst_tab_base.key = "data_bolla_out"
					kst_tab_base.key1 = string(ast_tab_sped.data_bolla_out )
					kst_esito = kuf1_base.metti_dato_base( kst_tab_base )
				else
					kst_esito.esito = kkg_esito.db_ko
					kst_esito.SQLErrText = "Errore in aggiornamento del n.DDT " + string(ast_tab_sped.num_bolla_out) + " in Proprietà Azienda. Procedere manualmente."
				end if
			end if
		end if
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Qualcosa è andato male, aggiornamento del n.DDT " + string(ast_tab_sped.num_bolla_out) + " in Proprietà Azienda non eseguito! Procedere manualmente."
	end if

return kst_esito
end function

public function st_esito u_aggiorna_base_cancella (st_tab_sped ast_tab_sped);//---
//--- Aggiorna Numero e Data DDT su archivio BASE in caso di rimozione del DDT 
//---
st_esito kst_esito
st_tab_base kst_tab_base
kuf_base kuf1_base

			
	kuf1_base = create kuf_base

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
			
	kst_tab_base.key = "num_bolla_out"
	kst_tab_base.num_bolla = integer(mid(kuf1_base.prendi_dato_base( kst_tab_base.key ),2 ))
	kst_tab_base.key = "data_bolla_out"
	kst_tab_base.data_bolla = date(mid(kuf1_base.prendi_dato_base( kst_tab_base.key ),2 ))
//--- se ho rimosso l'ultimo DDT allora riporta indietro il contatore	
	if ast_tab_sped.num_bolla_out = kst_tab_base.num_bolla and year(ast_tab_sped.data_bolla_out) = year(kst_tab_base.data_bolla) then
		kst_tab_base.key = "num_bolla_out"
		kst_tab_base.key1 = string(ast_tab_sped.num_bolla_out - 1)	  // toglie UNO al numero riportando indietro il contatore
		kst_esito = kuf1_base.metti_dato_base( kst_tab_base )
		if kst_esito.esito = kkg_esito.ok then 
			kst_tab_base.key = "data_bolla_out"
			kst_tab_base.key1 = string(ast_tab_sped.data_bolla_out )
			kst_esito = kuf1_base.metti_dato_base( kst_tab_base )
		end if
	end if

return kst_esito
end function

private function boolean if_anag_attiva (st_tab_clienti ast_tab_clienti);//
//--- Verifica se l'angrafica è attiva
//
boolean k_return = false


try
	setPointer(kkg.pointer_attesa)

	if ast_tab_clienti.codice > 0 then

		k_return = kiuf_clienti.if_attivo(ast_tab_clienti)
		if not k_return then
			messagebox("Anagrafica non attiva", &
			    "Il cliente "+ string(ast_tab_clienti.codice) + "  non è Attivo in Anagrafe, per utilizzarlo prima procedere con il cambio di stato", information!)
		end if
		
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally
	SetPointer(kkg.pointer_default)

end try
	
return k_return

end function

private subroutine put_video_data_rit (st_tab_sped ast_tab_sped);//
//--- Visualizza dati Data Ritiro
//


tab_1.tabpage_1.dw_1.setitem( 1, "data_rit", ast_tab_sped.data_rit )




end subroutine

protected function string aggiorna_dati ();//
string k_return = ""


if tab_1.tabpage_4.dw_riga_0.visible then
	
	if tab_1.tabpage_4.dw_riga_0.rowcount( ) > 0 then
		tab_1.tabpage_4.dw_riga_0.accepttext( )
		if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
		
//--- forza OK sul BOX del dettaglio 				
			tab_1.tabpage_4.dw_riga_0.event u_aggiorna(1)
		
			tab_1.tabpage_4.dw_riga_0.visible = false
			
		end if
	end if
end if

k_return = super::aggiorna_dati( )
//
//if left(k_return, 1) = "0" then
//	u_if_allarme_memo( )
//end if

return k_return 

end function

protected subroutine attiva_tasti_0 ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================


super::attiva_tasti_0()

tab_1.tabpage_2.enabled = false
tab_1.tabpage_3.enabled = false
tab_1.tabpage_4.enabled = false

//=== Nr righe ne DW lista
if tab_1.tabpage_1.dw_1.rowcount() > 0 then

	if tab_1.tabpage_1.dw_1.getitemnumber(1, "clie_2") > 0 then
		tab_1.tabpage_4.enabled = true
	end if
	
	choose case ki_tab_1_index_new  //tab_1.selectedtab
		case 1
			cb_aggiorna.enabled = true
		case 4 //righe
			if tab_1.tabpage_4.dw_4.rowcount( ) > 0 then
				cb_aggiorna.enabled = true
				cb_modifica.enabled = true
				cb_visualizza.enabled = true
				cb_cancella.enabled = true
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

//if tab_1.tabpage_4.enabled and tab_1.tabpage_4.dw_4.rowcount() > 0 then
//	tab_1.tabpage_4.text = "righe " + string(tab_1.tabpage_4.dw_4.rowcount())
//else
//	tab_1.tabpage_4.text = "righe "
//end if




end subroutine

public subroutine u_num_bolla_inp_changed ();//
	try

		//kist_tab_sped.id_sped = ast_tab_sped.id_sped
	
		if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then
			//kist_tab_sped.id_sped = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_sped")
			kist_tab_sped_orig.num_bolla_out = tab_1.tabpage_1.dw_1.getitemnumber(1, "num_bolla_out")
			kist_tab_sped_orig.data_bolla_out = tab_1.tabpage_1.dw_1.getitemdate(1, "data_bolla_out")
			if kiuf_sped.get_id_sped(kist_tab_sped_orig) > 0 then
				tab_1.tabpage_1.dw_1.reset( )
				tab_1.tabpage_4.dw_4.SetItemStatus( 1, 0, Primary!, NotModified!)
				ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica
				tab_1.selecttab(1)  // parte INIZIALIZZA()
			else
				if ki_st_open_w.flag_modalita <> kkg_flag_modalita.inserimento then
					ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento	
					tab_1.selecttab(1)  // parte INIZIALIZZA()
				end if
			end if
		end if
		
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
	end try

end subroutine

public subroutine u_message (uo_exception auo_exception);//
//--- messge box
//
					
		auo_exception.messaggio_utente( )	

end subroutine

public subroutine u_if_allarme_memo ();////
//st_tab_sped kst_tab_sped
//kuf_link_zoom kuf1_link_zoom
//
//try
//	kst_tab_sped.id_sped = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_sped")
//	if kst_tab_sped.id_sped > 0 then
//		if kiuf_sped.if_ddt_allarme_memo(kst_tab_sped) then
//			if messagebox("Allarme MEMO", "C'è un Avviso di Allarme MEMO, vuoi aprirlo subito?", question!, yesno!, 1) = 1 then
//	//--- lancia visualizzazione dell'allarme memo
//				kuf1_link_zoom = create kuf_link_zoom
//				kuf1_link_zoom.link_standard_call_p (tab_1.tabpage_1.dw_1, "p_memo_alarm_ddt") 
//			end if 
//		end if
//	end if
//
//catch (uo_exception kuo_exception)
//	kuo_exception.messaggio_utente()
//	
//finally
//	if isvalid(kuf1_link_zoom) then destroy kuf1_link_zoom
//	
//end try
end subroutine

protected subroutine inizializza_4 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 5 controllandone i valori se gia' presenti
//======================================================================
//

tab_1.tabpage_5.dw_5.setfocus()

attiva_tasti()
	

end subroutine

public function integer u_ddt_rows_retrieve ();//
integer k_return
integer k_row
st_tab_sped kst_tab_sped


try
	kst_tab_sped.id_sped = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_sped")	

	k_return = tab_1.tabpage_4.dw_4.retrieve(kst_tab_sped.id_sped)
	if k_return > 0 then  // carica le righe nel DDT !!!!!!
		if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
			tab_1.tabpage_4.dw_4.setrow(1)
			tab_1.tabpage_4.dw_4.selectrow(1,true)
		end if
		
		for k_row = 1 to k_return 
			tab_1.tabpage_4.dw_4.setitem(k_row, "k_progressivo", k_row)
		end for
		tab_1.tabpage_4.dw_4.resetupdate( )
	end if				

	tab_1.tabpage_4.text = string(k_return) + " " + ki_righe_titolo

	u_allarme_lotto()

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try

return k_return
end function

public function integer u_allarme_lotto () throws uo_exception;//
int k_return 
//st_memo_allarme kst_memo_allarme
//kuf_armo_inout kuf1_armo_inout
kuf_memo_allarme kuf1_memo_allarme
int k_riga, k_righe
long k_id_meca[10]

try
	
	k_righe = tab_1.tabpage_4.dw_4.rowcount( )
	if k_righe > 10 then k_righe = 10
	for k_riga = 1 to k_righe
		k_id_meca[k_riga] = tab_1.tabpage_4.dw_4.getitemnumber( k_riga, "id_meca")
	next
	if k_id_meca[1] > 0 then
		k_return = tab_1.tabpage_5.dw_5.retrieve(k_id_meca[1], k_id_meca[2], k_id_meca[3] &
														,k_id_meca[4], k_id_meca[5], k_id_meca[6] &
														,k_id_meca[7], k_id_meca[8], k_id_meca[9] &
														,k_id_meca[10])
	end if
	
	if tab_1.tabpage_5.dw_5.rowcount( ) > 0 then
		if not tab_1.tabpage_5.visible then
			tab_1.tabpage_5.visible = true
			kGuf_data_base.POST suona_motivo(kuf1_memo_allarme.kki_suona_motivo_allarme, 0)
		end if
		tab_1.tabpage_5.text = " " + ki_memo_titolo + " "+ string(k_return) + ""
	else
		tab_1.tabpage_5.visible = false
		tab_1.tabpage_5.text = ki_memo_titolo
	end if
//		kiuf_armo.get_num_int(ast_tab_meca)
//		kst_memo_allarme.allarme = kguf_memo_allarme.kki_memo_allarme_ddt
//		kst_memo_allarme.st_memo.st_tab_meca_memo.id_meca = ast_tab_meca.id
//		kst_memo_allarme.descr = "Avviso rilevato sul Lotto " + string(ast_tab_meca.num_int) + " " + string(ast_tab_meca.data_int, "dd/mm/yy") + " id "+ string(ast_tab_meca.id) + ", ddt: " + string(tab_1.tabpage_1.dw_1.getitemnumber(1, "num_bolla_out"))
//		if kguf_memo_allarme.set_allarme_lotto(kst_memo_allarme) then
//			kguf_memo_allarme.u_attiva_memo_allarme_on()
//		end if
//	else
//		kguf_memo_allarme.inizializza()
//	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	

finally
	
end try

return k_return 

end function

on w_ddt.create
int iCurrent
call super::create
this.dw_anno_numero=create dw_anno_numero
this.dw_x_copia=create dw_x_copia
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_anno_numero
this.Control[iCurrent+2]=this.dw_x_copia
end on

on w_ddt.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_anno_numero)
destroy(this.dw_x_copia)
end on

event u_ricevi_da_elenco;call super::u_ricevi_da_elenco;//
int k_return
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
					k_return = 1
				
					k_rc = kids_elenco_input.rowscopy(1, k_righe, Primary!, dw_x_copia, 1, Primary! )
					dw_x_copia.selectrow(0, true)  //--- seleziono tutte le righe tanto devo trattarle tutte
					dragdrop_dw_esterna( dw_x_copia, k_riga )
					
					attiva_tasti()
				end if
			end if
			
		end if
		
end if

return k_return



end event

type st_ritorna from w_g_tab_3`st_ritorna within w_ddt
integer y = 1808
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_ddt
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_ddt
integer y = 1804
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_ddt
integer y = 1640
end type

type st_stampa from w_g_tab_3`st_stampa within w_ddt
integer y = 1732
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_ddt
integer y = 1612
end type

event cb_visualizza::clicked;//


	choose case tab_1.selectedtab
		case 1
		case 4
			if tab_1.tabpage_4.dw_4.getselectedrow(0) > 0 then
				riga_modifica()		
				tab_1.tabpage_4.dw_riga_0.event u_visualizza()
			end if
			
	end choose



end event

type cb_modifica from w_g_tab_3`cb_modifica within w_ddt
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
				tab_1.tabpage_4.dw_riga_0.event u_modifica()
			end if
			
	end choose



end event

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_ddt
integer y = 1708
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_ddt
integer y = 1708
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_ddt
integer y = 1708
integer height = 92
end type

event cb_inserisci::clicked;//
//=== 
string k_errore="0"
string k_cod_art
long k_cod_cli, k_mis_x, k_mis_y, k_mis_z
double k_dose
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window
kuf_utility kuf1_utility


//=== Nuovo Rekord
	choose case ki_tab_1_index_new
		case  1   // clienti
			
			Super::EVENT Clicked()
			

		case 4
			u_get_numero_lotto()
			
			
	end choose
	

end event

type tab_1 from w_g_tab_3`tab_1 within w_ddt
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
string text = "Testata"
string picturename = "Custom081!"
long picturemaskcolor = 32435950
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
event u_enter ( )
event u_setcolumn ( string a_column )
boolean visible = true
integer x = 0
integer y = 28
integer width = 2953
integer height = 1308
string dataobject = "d_sped_testata"
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_d_std_1_attiva_cerca = false
boolean ki_abilita_ddw_proposta = true
end type

event dw_1::u_setcolumn(string a_column);//
this.setcolumn(a_column) 
this.setfocus( )



end event

event dw_1::itemchanged;call super::itemchanged;//
string k_nome
long k_riga, k_return=0
st_tab_clienti kst_tab_clienti, kst_tab_clienti3
st_tab_sped kst_tab_sped
st_tab_caus kst_tab_caus
st_tab_sped_vettori kst_tab_sped_vettori
st_esito kst_esito
datawindowchild kdwc_1


try
	choose case dwo.name 

		case "num_bolla_out", "data_bolla_out"
			this.modify("data_bolla_out.Background.Color = '" + string(KKG_COLORE.BIANCO) + "' ") 
			if dwo.name = "num_bolla_out" then
//				kst_tab_sped.num_bolla_out = long(data)
				kst_tab_sped.data_bolla_out = this.getitemdate( row, "data_bolla_out")
			else
				kst_tab_sped.data_bolla_out = date(data)
//				kst_tab_sped.num_bolla_out = this.getitemnumber( row, "num_bolla_out")
			end if
			if kst_tab_sped.data_bolla_out = kguo_g.get_dataoggi( ) then
			else
				this.modify("data_bolla_out.Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
			end if
			post u_num_bolla_inp_changed() //kst_tab_sped)
			
			
		case "rag_soc_10" 
			this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.BIANCO) + "' ") 
			if len(trim(data)) > 0 then 
				this.getchild(dwo.name, kdwc_1)
				k_riga = kdwc_1.find( "rag_soc_1 like '" + trim(data) + "%" +"'" , 1, kdwc_1.rowcount())
				if k_riga > 0 then
					kst_tab_clienti.codice = kdwc_1.getitemnumber( k_riga, "id_cliente")
					if if_anag_attiva(kst_tab_clienti) then
						get_dati_cliente(kst_tab_clienti)
						post put_video_clie_2(kst_tab_clienti)
						post event u_setcolumn(dwo.name)
					else
						this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
					end if
				else
					this.object.clie_2[1] = 0
					this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
				end if
			else
				set_iniz_dati_cliente(kst_tab_clienti)
				post put_video_clie_2(kst_tab_clienti)
				post event u_setcolumn(dwo.name)
			end if
	
		case "clie_2" 
			this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.BIANCO) + "' ") 
			if len(trim(data)) > 0 then 
				this.getchild(dwo.name, kdwc_1)
				k_riga = kdwc_1.find( "id_cliente = " + trim(data) + " " , 1, kdwc_1.rowcount())
				if k_riga > 0 then
					kst_tab_clienti.codice = long(trim(data))
					if if_anag_attiva(kst_tab_clienti) then
						get_dati_cliente(kst_tab_clienti)
						post put_video_clie_2(kst_tab_clienti)
						post event u_setcolumn("rag_soc_10")
					else
						this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
					end if
				else
					this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
				end if
			else
				set_iniz_dati_cliente(kst_tab_clienti)
				post put_video_clie_2(kst_tab_clienti)
				post event u_setcolumn("rag_soc_10")
			end if
	
		case "p_iva", "cf" 
			this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.BIANCO) + "' ") 
			if len(trim(data)) > 0 then 
				this.getchild("clie_2", kdwc_1)
				k_nome = dwo.name + " like '" + trim(data) + "%" +"' " 
				k_riga = kdwc_1.find( k_nome, 1, kdwc_1.rowcount())
				if k_riga > 0 then
					kst_tab_clienti.codice = kdwc_1.getitemnumber( k_riga, "id_cliente")
					if if_anag_attiva(kst_tab_clienti) then
						get_dati_cliente(kst_tab_clienti)
						post put_video_clie_2(kst_tab_clienti)
						post event u_setcolumn(dwo.name)
					else
						this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
					end if
				else
					this.object.clie_2[1] = 0
					this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
				end if
			else
				set_iniz_dati_cliente(kst_tab_clienti)
				post put_video_clie_2(kst_tab_clienti)
				post event u_setcolumn(dwo.name)
			end if
	
		case "meca_clie_2" 
			this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.BIANCO) + "' ") 
			if len(trim(data)) > 0 then 
				if isnumber(trim(data)) then
					kst_tab_clienti.codice = long(trim(data))
					if if_anag_attiva(kst_tab_clienti) then
						kst_esito = kiuf_clienti.leggi_rag_soc(kst_tab_clienti)
						if kst_esito.esito = kkg_esito.ok then
							this.setitem( 1, "meca_rag_soc_10", trim(kst_tab_clienti.rag_soc_10) + " " &
																		+ trim(kst_tab_clienti.rag_soc_11) + " " &
																+ trim(kst_tab_clienti.indi_1) + " " &
																+ trim(kst_tab_clienti.loc_1) + " " &
																+ trim(kst_tab_clienti.prov_1) + " " &
																+ string(kst_tab_clienti.id_nazione_1)  &
																		) 
						else
							this.modify(dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
						end if
					else
						this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
					end if
				end if
			else
				this.setitem( 1, "meca_rag_soc_10", " ")
			end if
	
		case "clie_3" 
			this.modify(dwo.name + ".Background.Color = '" + string(KKG_COLORE.BIANCO) + "' ") 
			if len(trim(data)) > 0 then 
				if isnumber(trim(data)) then
					kst_tab_clienti.codice = long(trim(data))
					if if_anag_attiva(kst_tab_clienti) then
						kst_esito = kiuf_clienti.leggi_rag_soc(kst_tab_clienti)
						if kst_esito.esito = kkg_esito.ok then
							this.setitem( 1, "clie3_rag_soc", trim(kst_tab_clienti.rag_soc_10) + " " &
																		+ trim(kst_tab_clienti.rag_soc_11) + " " &
																+ trim(kst_tab_clienti.indi_1) + " " &
																+ trim(kst_tab_clienti.loc_1) + " " &
																+ trim(kst_tab_clienti.prov_1) + " " &
																+ string(kst_tab_clienti.id_nazione_1)  &
																		) 
							//--- Gestione di Allert per il cliente 	
//							post u_allarme_cliente(kst_tab_clienti)

						else
							this.modify(dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
						end if
					else
						this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
					end if
				end if
			else
				this.setitem( 1, "clie3_rag_soc", " ")
			end if
	
	//	case "clie_3" 
	//		if len(trim(data)) > 0 then 
	//			this.getchild(dwo.name, kdwc_1)
	//			k_riga = kdwc_1.find( "clie_3 = " + trim(data) + " " , 1, kdwc_1.rowcount())
	//			if k_riga > 0 then
	//				kst_tab_clienti3.codice = long(trim(data))
	////				get_dati_cliente(kst_tab_clienti3)
	//				post put_video_clie_2(kst_tab_clienti)
	//			else
	//				this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
	//			end if
	//		else
	//			set_iniz_dati_cliente(kst_tab_clienti3)
	//			post put_video_clie_2(kst_tab_clienti3)
	//		end if
	
		case "caus_codice" 
			this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.BIANCO) + "' ") 
			if len(trim(data)) > 0 then 
				this.getchild(dwo.name, kdwc_1)
				k_riga = kdwc_1.find( "codice = '" + trim(data) + "' " , 1, kdwc_1.rowcount())
				if k_riga > 0 then
					kst_tab_caus.codice = trim(data)
					post put_video_caus(kst_tab_caus)
					post event u_setcolumn("cura_trasp")
				else
					this.setitem(1, "causale", " " )
					this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
				end if
			else
				this.setitem(1, "causale", " " )
			end if
	
		case "id_vettore" 
			this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.BIANCO) + "' ") 
			if len(trim(data)) > 0 then 
				this.getchild(dwo.name, kdwc_1)
				k_riga = kdwc_1.find( "id = " + trim(data) + " " , 1, kdwc_1.rowcount())
				if k_riga > 0 then
					kst_tab_sped_vettori.id = long(trim(data))
					kst_tab_sped_vettori.rag_soc_1 = kdwc_1.getitemstring( k_riga, "rag_soc_1")
					kst_tab_sped_vettori.rag_soc_2 = kdwc_1.getitemstring( k_riga, "rag_soc_2")
					post put_video_vett(kst_tab_sped_vettori)
					post event u_setcolumn("vett_1")
				else
					this.setitem(1, "vett_1", " " )
					this.setitem(1, "vett_2", " " )
					this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
				end if
			end if
		case "vett_1" 
			this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.BIANCO) + "' ") 
			if len(trim(data)) > 0 then 
				this.getchild(dwo.name, kdwc_1)
				k_riga = kdwc_1.find( "rag_soc_1 like ~"" + RightTrim(data) + "%" +"~"" , 1, kdwc_1.rowcount())
				if k_riga > 0 then
					kst_tab_sped_vettori.id = kdwc_1.getitemnumber( k_riga, "id")
					kst_tab_sped_vettori.rag_soc_1 = kdwc_1.getitemstring( k_riga, "rag_soc_1")
					kst_tab_sped_vettori.rag_soc_2 = kdwc_1.getitemstring( k_riga, "rag_soc_2")
					post put_video_vett(kst_tab_sped_vettori)
					post event u_setcolumn("vett_2")
				else
					this.setitem(1, "id_vettore", 0)
					this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
				end if
			end if
	
		case "id_nazione" 
			this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.BIANCO) + "' ") 
			if len(trim(data)) > 0 then 
				this.getchild(dwo.name, kdwc_1)
				k_riga = kdwc_1.find( "id_nazione = '" + trim(data) + "' " , 1, kdwc_1.rowcount())
				if k_riga > 0 then
					kst_tab_clienti.id_nazione_1 =  trim(data)
					post put_video_nazioni(kst_tab_clienti)
					post event u_setcolumn("caus_codice")
				else
					this.setitem(1, "nazioni_nome", " " )
					this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
				end if
			else
				this.setitem(1, "nazioni_nome", " " )
			end if

		case "cura_trasp"
			kst_tab_sped.cura_trasp = trim(data)
			post set_video_vett(kst_tab_sped)	
			post event u_setcolumn("id_vettore")
			
		case "k_competenza_dal"
			if len(trim(data)) > 0 then 
				ki_data_competenza = date(data)
			end if
			

		case "data_rit" 
			kst_tab_sped.data_rit = this.getitemdate(row, "data_rit")
			post put_video_data_rit(kst_tab_sped)		
			
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

//--- elenco indirizzi 
		case "p_img_indi", &
			"k_nr_ind_ddt"
			if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita =  kkg_flag_modalita.modifica then
				call_indirizzi_storici()
			else
				messagebox("Operazione bloccata", "Funzione non attiva per questa modalità", Information!)
			end if

//--- elenco Note
		case "p_img_note"
			if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita =  kkg_flag_modalita.modifica then
				call_elenco_note()
			else
				messagebox("Operazione bloccata", "Funzione non attiva per questa modalità", Information!)
			end if

//--- elenco riceventi
		case "p_img_meca_clie_2"
			if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita =  kkg_flag_modalita.modifica then
				call_elenco_riceventi()
			else
				messagebox("Operazione bloccata", "Funzione non attiva per questa modalità", Information!)
			end if

//--- elenco clienti
		case "p_img_fatturati_x_clie_2"
			if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita =  kkg_flag_modalita.modifica then
				call_elenco_fatt()
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
event u_resize ( )
boolean visible = true
integer width = 3159
integer height = 1428
long backcolor = 32435950
string text = "righe"
string picturename = "DataWindow5!"
dw_riga_0 dw_riga_0
st_orizzontal st_orizzontal
end type

event tabpage_4::u_resize();//---

this.dw_riga_0.event u_resize(true)



end event

on tabpage_4.create
this.dw_riga_0=create dw_riga_0
this.st_orizzontal=create st_orizzontal
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_riga_0
this.Control[iCurrent+2]=this.st_orizzontal
end on

on tabpage_4.destroy
call super::destroy
destroy(this.dw_riga_0)
destroy(this.st_orizzontal)
end on

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
boolean visible = true
integer x = 41
integer y = 12
integer width = 3054
integer height = 520
boolean enabled = true
string dataobject = "d_arsp_l_righe"
boolean ki_in_drag = true
end type

event dw_4::ue_drop_out;//
		dragdrop_dw_esterna( kdw_source, k_droprow )
		
return 1

end event

event dw_4::doubleclicked;//

if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then

	cb_modifica.event clicked( )
	
else
	
	cb_visualizza.event clicked( )	
	
end if
	
	
end event

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
integer width = 3159
integer height = 1428
long backcolor = 553648127
string text = "Allarmi Memo"
long tabtextcolor = 255
long tabbackcolor = 32896
string picturename = "alert24.png"
long picturemaskcolor = 553648127
string powertiptext = "avvisi di allarmi memo"
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
boolean visible = true
integer x = 0
integer width = 2318
integer height = 1296
boolean enabled = true
string dataobject = "d_memo_allarme_noddt"
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

type st_duplica from w_g_tab_3`st_duplica within w_ddt
end type

type dw_riga_0 from uo_d_sped_riga within tabpage_4
event type integer u_aggiorna ( long a_riga )
event u_aggiungi ( )
event u_modifica ( )
event u_posiziona ( )
event u_visualizza ( )
event u_resize ( boolean a_visible )
event u_resize_false ( )
integer x = 37
integer y = 720
integer taborder = 60
boolean bringtotop = true
boolean hsplitscroll = false
boolean ki_dw_visibile_in_open_window = false
end type

event type integer u_aggiorna(long a_riga);//======================================================================
//=== 
//======================================================================
//
long k_riga, k_progressivo, k_riga_elenco
st_tab_armo kst_tab_armo
st_tab_prodotti kst_tab_prodotti
st_tab_arsp kst_tab_arsp
st_tab_meca kst_tab_meca


	try

		tab_1.selectedtab = 4
		this.setfocus( )

		if this.getitemnumber(a_riga, "colli") <> this.getitemnumber(a_riga, "colli_out") then
			if messagebox ("Verifica dati anomala", "Attenzione numero colli da scaricare diverso dai colli in stampa, proseguire?", Question!, YesNo!, 1) = 2 then
				return 1
			end if
		end if
		
		kiuf_armo.if_isnull_meca( kst_tab_meca )
		kiuf_armo.if_isnull_armo( kst_tab_armo )
	
		k_riga = this.getrow( )
		if k_riga > 0 then
			kst_tab_armo.art = this.getitemstring(k_riga, "art")
			kst_tab_prodotti.des = this.getitemstring(k_riga, "des")
			kst_tab_arsp.stampa = this.getitemstring(k_riga, "stampa")
			kst_tab_armo.alt_2 = this.getitemnumber(k_riga, "alt_2")
			kst_tab_arsp.peso_kg_out = this.getitemnumber(k_riga, "peso_kg_out")
			kst_tab_arsp.colli = this.getitemnumber(k_riga, "colli")
			kst_tab_arsp.colli_out = this.getitemnumber( k_riga, "colli_out" )
//			kst_tab_meca.clie_3 = this.getitemnumber( k_riga, "clie_3" )
			kst_tab_arsp.id_arsp = this.getitemnumber( k_riga, "id_arsp")
			kst_tab_arsp.id_armo = this.getitemnumber( k_riga, "id_armo")
//			kst_tab_arsp.id_sped = this.getitemnumber( k_riga, "id_sped")
			kst_tab_armo.id_meca = this.getitemnumber( k_riga, "id_meca")
			kst_tab_armo.num_int = this.getitemnumber( k_riga, "num_int")
			kst_tab_armo.data_int = this.getitemdate( k_riga, "data_int")
			kst_tab_arsp.note_1 = this.getitemstring(k_riga, "note_1")
			kst_tab_arsp.note_2 = this.getitemstring(k_riga, "note_2")
			kst_tab_arsp.note_3 = this.getitemstring(k_riga, "note_3")
			
			kst_tab_meca.e1doco = this.getitemnumber( k_riga, "e1doco")
			kst_tab_meca.e1rorn = this.getitemnumber( k_riga, "e1rorn")
			kst_tab_meca.e1srst = this.getitemstring( k_riga, "e1srst")
			kst_tab_meca.data_ent = this.getitemdatetime( k_riga, "data_ent")
			
			k_progressivo = this.getitemnumber(k_riga, "k_progressivo")

			if k_progressivo > 0 then
				k_riga_elenco = tab_1.tabpage_4.dw_4.find( "k_progressivo = " + string(k_progressivo), 1, tab_1.tabpage_4.dw_4.rowcount())
				if k_riga_elenco > 0 then
					kst_tab_meca.clie_3 = tab_1.tabpage_4.dw_4.getitemnumber( k_riga_elenco, "clie_3")
					kst_tab_arsp.id_sped = tab_1.tabpage_4.dw_4.getitemnumber( k_riga_elenco, "id_sped")
					riga_modifica_in_lista(k_riga_elenco, kst_tab_arsp, kst_tab_armo, kst_tab_prodotti, kst_tab_meca)  
					//this.visible = false  // dopo la modifica Nascondo la DW
					this.event u_resize(false) // dopo la modifica Nascondo la DW
				end if					
			else
				
//--- legge cliente a cui fatturare
				kst_tab_meca.id = kst_tab_armo.id_meca
				kiuf_armo.get_clie(kst_tab_meca)
				kst_tab_arsp.id_sped = tab_1.tabpage_1.dw_1.getitemnumber( 1, "id_sped")
				
				riga_nuova_in_lista_1(kst_tab_arsp, kst_tab_armo, kst_tab_prodotti, kst_tab_meca)  
	//			this.visible = false  // dopo la aggiunta Nascondo la DW
				this.event u_resize(false) // dopo la modifica Nascondo la DW
					
			end if
		end if
			
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()

	finally
//		this.setitem(k_riga, "colli", 1)
		attiva_tasti()
	
	end try
	
return 0




end event

event u_aggiungi();//======================================================================
//=== 
//======================================================================
//
	this.reset( )
	this.insertrow(0)

	this.ki_flag_modalita = kkg_flag_modalita.inserimento

	this.object.b_ok.visible = true 
	this.object.b_esci.visible = true 
	this.object.b_armo_note.enabled = true

	this.visible = true		

end event

event u_modifica();//======================================================================
//=== 
//======================================================================
//
kuf_utility kuf1_utility

	setredraw(false)

	this.object.b_ok.visible = true 
	this.object.b_esci.visible = true 
	this.object.b_armo_note.enabled = true
	
	kuf1_utility = create kuf_utility
	kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_4.dw_riga_0)
	 
	this.insertrow( 0)

	this.event u_resize(true)
	setredraw(true)
	this.setfocus( )

end event

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

	setredraw(false)

	kuf1_utility = create kuf_utility
	this.object.b_ok.visible = false 
	this.object.b_esci.visible = false 
	this.object.b_armo_note.enabled = false
     kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_4.dw_riga_0)
//     kuf1_utility.u_proteggi_dw("1", "iva", dw_riga)
//     kuf1_utility.u_proteggi_dw("1", "art", dw_riga)
//	this.visible = true
	this.event u_resize(true)
	destroy kuf1_utility
	
	setredraw(true)
	
	



end event

event u_resize(boolean a_visible);//
long k_height=0


	if not a_visible then
		
		tab_1.tabpage_4.st_orizzontal.visible = false
		this.enabled = false
		this.visible = false
		u_resize( )
		
	else
	
		this.setredraw(false)

		tab_1.tabpage_4.st_orizzontal.x = 1
		tab_1.tabpage_4.st_orizzontal.height = 30
		tab_1.tabpage_4.st_orizzontal.width =	kiw_this_window.WorkSpaceWidth()
		if tab_1.tabpage_4.st_orizzontal.y = 0 then
			tab_1.tabpage_4.st_orizzontal.y = kiw_this_window.WorkSpaceHeight() * 0.9 * 0.25 
		end if
		
		k_height = kiw_this_window.WorkSpaceHeight()

//	//--- posizionamento min e max della barra orizzontale
//		if tab_1.tabpage_4.st_orizzontal.y < 180 then
//			tab_1.tabpage_4.st_orizzontal.y = 180
//		else
//			if tab_1.tabpage_4.st_orizzontal.y > k_height - 200 then
//				tab_1.tabpage_4.st_orizzontal.y = k_height - 200
//			end if
//		end if

		tab_1.tabpage_4.dw_4.x = 1 //tab_1.tabpage_4.st_orizzontal.x 
		tab_1.tabpage_4.dw_4.y = 5 
		this.y = tab_1.tabpage_4.st_orizzontal.y + tab_1.tabpage_4.st_orizzontal.height
		this.x = tab_1.tabpage_4.st_orizzontal.x
			
		tab_1.tabpage_4.dw_4.height = tab_1.tabpage_4.st_orizzontal.y  - tab_1.tabpage_4.dw_4.y 
		this.height = k_height - tab_1.tabpage_4.st_orizzontal.y - tab_1.tabpage_4.st_orizzontal.height 
		tab_1.tabpage_4.dw_4.width = tab_1.tabpage_4.st_orizzontal.width
		this.width = tab_1.tabpage_4.st_orizzontal.width
		
		this.enabled = true
		this.visible = true
		tab_1.tabpage_4.st_orizzontal.visible = true
	
		this.setredraw(true)
	end if
	
end event

event u_resize_false();//


	this.event u_resize(false)
	

	
end event

event getfocus;call super::getfocus;//
st_tab_armo_nt kst_tab_armo_nt

try
	if this.rowcount( ) > 0 then
		kst_tab_armo_nt.id_armo = this.getitemnumber(1, "id_armo")
		if kst_tab_armo_nt.id_armo > 0 then
			kiuf_armo_nt.get_note(kst_tab_armo_nt)
			riga_modifica_display_note(kst_tab_armo_nt)
		end if
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try
end event

event itemchanged;call super::itemchanged;//
int k_colli_spedibili=0


	choose case dwo.name 

		case "colli"
			this.modify( dwo.name + ".Background.Color = '" + string(kkg_colore.bianco ) + "' ") 
			this.modify( "colli_out.Background.Color = '" + string(kkg_colore.bianco ) + "' ") 
			if integer(data) = 0 then
				this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
				messagebox ("Verifica dati fallita", "Attenzione non è possibile spedire ZERO colli, prego verificare", StopSign!)
				return 1
			else
				if this.getitemnumber(row, "id_arsp") > 0 then
					k_colli_spedibili = this.getitemnumber(row, "colli_orig") + this.getitemnumber(row, "colli_da_sped_max")
				else
					k_colli_spedibili = this.getitemnumber(row, "colli_da_sped_max")
				end if
				if integer(data) > k_colli_spedibili then
					this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
					messagebox ("Verifica dati fallita", "Attenzione non è possibile spedire più di " + string(k_colli_spedibili) + " colli, prego verificare", StopSign!)
					return 1
				end if
			end if
			if integer(data) <> this.getitemnumber(row, "colli_out") then
				this.modify("colli_out.Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
			end if
		case "colli_out"
			this.modify( dwo.name + ".Background.Color = '" + string(kkg_colore.bianco ) + "' ") 
			if integer(data) = 0 then
				this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
				if messagebox ("Verifica dati anomala", "Attenzione sono stati indicati ZERO colli in stampa, proseguire?", Question!, YesNo!, 2 ) = 2 then
					return 1
				end if
			else
				if integer(data) <> this.getitemnumber(row, "colli") then
					this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
				end if
			end if
	end choose

end event

event u_constructor;call super::u_constructor;//
post event u_posiziona()

end event

event buttonclicked;call super::buttonclicked;//
long k_riga=0
st_tab_g_0 kst_tab_g_0[]
st_open_w kst_open_w
st_tab_armo_nt kst_tab_armo_nt


this.accepttext( )

if dwo.name = "b_ok" then

	return event u_aggiorna(row)
		
else
	if dwo.name = "b_armo_note" then
		
		kst_open_w.flag_modalita = kkg_flag_modalita.modifica
		kst_tab_armo_nt.id_armo = this.getitemnumber( 1, "id_armo")
		if kst_tab_armo_nt.id_armo > 0 then
			kst_tab_g_0[1].id = kst_tab_armo_nt.id_armo
			kiuf_armo_nt.u_open(kst_tab_g_0[], kst_open_w)  // apre la window per la modifica delle NOTE
		end if
		
	else
		
		if dwo.name = "b_rilegge_note" then
			this.event getfocus( )
		else
		
			if dwo.name = "b_esci" then
				
				event u_resize(false)
			
			end if
		end if
	end if
end if


end event

type st_orizzontal from statictext within tabpage_4
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
event u_resize ( )
boolean visible = false
integer y = 540
integer width = 2757
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "SizeNS!"
long backcolor = 0
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event mousemove;//Check for move in progess
If KeyDown(keyLeftButton!) Then
	if Parent.PointerY() > parent.height / 10 then
		if Parent.PointerY() > (parent.height - (this.height * 10)) then  // se tiro giù molto allora scompare la finestra di dettaglio
			dw_riga_0.event u_resize(false)
			this.y = 0
		else
			This.y = Parent.PointerY()
			parent.event u_resize()
		end if
	end if
End If


end event

event mouseup;//
parent.event u_resize()

end event

event constructor;//
	this.backcolor = parent.backcolor

end event

type dw_anno_numero from datawindow within w_ddt
event u_posiziona ( )
event u_enter pbm_dwnprocessenter
event u_attiva ( )
boolean visible = false
integer x = 818
integer y = 240
integer width = 1225
integer height = 368
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "none"
string dataobject = "d_anno_numero"
boolean controlmenu = true
string icon = "Form!"
end type

event u_posiziona();//
//--- posizione
//
this.x = parent.width / 4
this.y = parent.height / 4
//

end event

event u_enter;//
long k_riga = 0
st_tab_meca kst_tab_meca


try
	this.visible = false
	this.accepttext()	

//--- get del id lotto / SO
	kst_tab_meca.num_int = this.getitemnumber(1, "numero")
	kst_tab_meca.data_int = date (this.getitemnumber(1, "anno") , 01, 01)
	if kst_tab_meca.num_int > 0 then
		
		if kst_tab_meca.num_int > 100000 then // probabilmente è un E1-SO
			kst_tab_meca.e1rorn = kst_tab_meca.num_int
			kst_tab_meca.id = kiuf_armo.get_id_da_e1rorn(kst_tab_meca)
		else
			kiuf_armo.get_id_meca(kst_tab_meca)
		end if
		if kst_tab_meca.id > 0 then
			
			add_lotto_da_id_meca(kst_tab_meca)
			
		end if
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally
//	this.reset( )
	
end try

end event

event u_attiva();
//--- Richiesta del Numero Lotto o SO
	this.title = "Compila DDT: indicare N.Lotto/SO "
	this.visible = true
	this.setrow(1)
	this.setcolumn( "numero")
	this.SelectText(1, Len(this.GetText()))
	this.enabled = true
	this.setfocus()


end event

event constructor;//
post event u_posiziona()

end event

event clicked;//

if dwo.name = "b_ok" then
	
	this.event u_enter( )

end if
end event

type dw_x_copia from uo_d_std_1 within w_ddt
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

