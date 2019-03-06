$PBExportHeader$w_wm_pklist.srw
forward
global type w_wm_pklist from w_g_tab_3
end type
type dw_x_copia from uo_d_std_1 within w_wm_pklist
end type
type dw_riga from uo_d_std_1 within w_wm_pklist
end type
type dw_barcode from uo_d_std_1 within w_wm_pklist
end type
end forward

global type w_wm_pklist from w_g_tab_3
integer width = 2651
integer height = 2176
string title = "Packing List"
string pointer = "Arrow!"
boolean ki_toolbar_window_presente = true
boolean ki_fai_nuovo_dopo_update = false
boolean ki_fai_nuovo_dopo_insert = false
boolean ki_msg_dopo_update = false
dw_x_copia dw_x_copia
dw_riga dw_riga
dw_barcode dw_barcode
end type
global w_wm_pklist w_wm_pklist

type variables
//
private kuf_wm_pklist_testa kiuf_wm_pklist_testa
private kuf_wm_pklist_righe kiuf_wm_pklist_righe  
private st_tab_wm_pklist kist_tab_wm_pklist_orig
private kuf_clienti kiuf_clienti
private kuf_contratti kiuf_contratti


end variables

forward prototypes
protected function string aggiorna ()
protected function integer cancella ()
protected function string check_dati ()
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
protected function string inizializza_post ()
public subroutine set_iniz_dati_cliente (ref st_tab_clienti kst_tab_clienti)
public subroutine set_dw_clienti_child ()
private function integer riga_aggiungi_in_lista (st_tab_wm_pklist_righe kst_tab_wm_pklist_righe) throws uo_exception
private function integer riga_nuova_in_lista (ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe) throws uo_exception
private subroutine riga_aggiorna_in_lista (long k_riga, readonly st_tab_wm_pklist_righe kst_tab_wm_pklist_righe) throws uo_exception
private subroutine riga_aggiorna_in_lista_art (long k_riga, readonly st_tab_wm_pklist_righe kst_tab_wm_pklist_righe)
private function long riga_modifica_in_lista (long k_riga, st_tab_wm_pklist_righe kst_tab_wm_pklist_righe) throws uo_exception
private subroutine riga_aggiungi ()
private subroutine riempi_st_tab_wm_pklist_righe_da_dw_riga (long k_riga, ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe)
private subroutine riempi_st_tab_wm_pklist_righe_da_dw4 (long k_riga, ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe)
private function boolean riga_gia_presente (st_tab_wm_pklist_righe kst_tab_wm_pklist_righe)
private subroutine riempi_dw_riga (long k_riga, readonly st_tab_wm_pklist_righe kst_tab_wm_pklist_righe)
private subroutine riempi_st_tab_wm_pklist_da_dw1 (long k_riga, ref st_tab_wm_pklist kst_tab_wm_pklist)
private subroutine put_video_gruppo_dw_riga (st_tab_gru kst_tab_gru)
private subroutine put_video_cliente (st_tab_clienti kst_tab_clienti, string k_tipo)
private subroutine importa_pklist ()
private subroutine importa_pklist_ext ()
private subroutine call_m_r_f ()
private subroutine call_elenco_contratti ()
public subroutine u_set_k_e1litm_ok ()
private subroutine u_duplica_pklist ()
protected subroutine inizializza_4 () throws uo_exception
public subroutine u_modifica_barcode ()
protected subroutine attiva_tasti_0 ()
protected function string check_dati_x_importa ()
end prototypes

protected function string aggiorna ();//
//======================================================================
//=== Aggiorna tabelle 
//=== Ritorna 1 chr : 0=tutto OK; 1=errore grave I-O;
//=== 				  : 2=
//===					  : 3=Commit fallita
//===		dal char 2 in poi spiegazione dell'errore
//======================================================================

string k_return="0 ", k_errore="0 "
long k_riga, k_rc
st_tab_wm_pklist kst_tab_wm_pklist
st_tab_wm_pklist_righe kst_tab_wm_pklist_righe
st_esito kst_esito


setpointer(kkg.pointer_attesa) 

//=== Aggiorna, se modificato, la TAB_1 o TAB_4	
if tab_1.tabpage_1.dw_1.rowcount( ) > 0 and (tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0	or tab_1.tabpage_4.dw_4.getnextmodified(0, primary!) > 0 or  tab_1.tabpage_4.dw_4.deletedcount() > 0) then


	try
		
		k_riga = 1

	//--- Se sono in Inserimento verifico se codice PKLIST già usato
		if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
			kst_tab_wm_pklist.idpkl = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "idpkl")
			
			if kiuf_wm_pklist_testa.if_esiste( kst_tab_wm_pklist ) then
				
				kguo_exception.setmessage( "Packing List gia' caricata " + trim(kst_tab_wm_pklist.idpkl )  )
				kguo_exception.messaggio_utente( )
	
			end if
		else
			
//--- se sono in Modifica e ho cambiato il codice dela Packing List....			
			if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
				kst_tab_wm_pklist.idpkl = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "idpkl")
				if kst_tab_wm_pklist.idpkl <> kst_tab_wm_pklist.idpkl then
//--- Cambio codice....			
					kst_tab_wm_pklist.st_tab_g_0.esegui_commit = "N"
					kst_esito = kiuf_wm_pklist_testa.tb_update_idpkl( kst_tab_wm_pklist )
				end if
			end if
		end if
		if kst_esito.esito <> kkg_esito.db_ko then
			
			riempi_st_tab_wm_pklist_da_dw1(k_riga, kst_tab_wm_pklist)
			
//=== Aggiorna, se modificato, la TAB_1	
			if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0	then
		
//--- Aggiorna la testa PK-LIST
				k_rc = tab_1.tabpage_1.dw_1.update()  
				if k_rc = 1 then
					kst_esito.esito = kkg_esito.ok
					kst_esito.sqlerrtext = ""
					kst_esito.sqlcode = 0

//--- se id documento manca nella struct lo legge da tabella
					if kst_tab_wm_pklist.id_wm_pklist = 0 or isnull(kst_tab_wm_pklist.id_wm_pklist) then
						kst_tab_wm_pklist.id_wm_pklist = kiuf_wm_pklist_testa.get_id_wm_pklist_max()
					end if
					tab_1.tabpage_1.dw_1.setitem(k_riga, "id_wm_pklist", kst_tab_wm_pklist.id_wm_pklist )
					
				else
					kst_esito.esito = kkg_esito.db_ko  // fermo la registrazione  ROLLBACK!
					kst_esito.sqlerrtext = "Errore in aggiornamento testata del PKL, ~n~r" + "impossibile proseguire con la registrazione!"
					kst_esito.sqlcode = 0
				end if	
	
			
			else
				kst_esito.esito = kkg_esito.ok
				kst_esito.sqlerrtext = ""
				kst_esito.sqlcode = 0
				
			end if
		end if
	
	catch	(uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito( )
		kst_esito.esito = kkg_esito.db_ko
		
	end try
	

//--- Se tutto OK carico le righe di dettaglio 	
	if kst_esito.esito <> kkg_esito.db_ko then


		k_riga = 0
		k_riga = tab_1.tabpage_4.dw_4.getnextmodified (k_riga, primary!)
		//do while kst_esito.esito <> kkg_esito.db_ko
		//do while k_riga <= tab_1.tabpage_4.dw_4.rowcount() and kst_esito.esito <> kkg_esito.db_ko
		if k_riga > 0 then
//			riempi_st_tab_wm_pklist_righe_da_dw4( k_riga, kst_tab_wm_pklist_righe )
//			kst_tab_wm_pklist_righe.id_wm_pklist = kst_tab_wm_pklist.id_wm_pklist

//--- Aggiorna righe PK-LIST
			//if tab_1.tabpage_4.dw_4.GetItemStatus (k_riga, primary!) > 0	then
				k_rc =  tab_1.tabpage_4.dw_4.update()  
				if k_rc = 1 then
					tab_1.tabpage_4.dw_4.resetupdate( )
					kst_esito.esito = kkg_esito.ok
					kst_esito.sqlerrtext = ""
					kst_esito.sqlcode = 0
				else
					kst_esito.esito = kkg_esito.db_ko  // fermo la registrazione  ROLLBACK!
					kst_esito.sqlerrtext = "Errore in aggiornamento righe del PKL, ~n~r" + "impossibile proseguire con la registrazione!"
					kst_esito.sqlcode = 0
				end if	
			//end if			
			//k_riga++
			k_riga = tab_1.tabpage_4.dw_4.getnextmodified (k_riga, primary!)

		end if
		
	end if

//--- 
	if kst_esito.esito = kkg_esito.ok then

//--- Se tutto OK faccio la COMMIT		
		kst_esito = kguo_sqlca_db_magazzino.db_commit()
		if kst_esito.esito <> kkg_esito.ok then
			k_return = "3" + "Archivio " + tab_1.tabpage_1.text + " ~n~r" + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) 
			
		else // Tutti i Dati Caricati in Archivio
			k_return ="0 "

//---- azzera il flag delle modifiche
			tab_1.tabpage_1.dw_1.ResetUpdate ( ) 
			tab_1.tabpage_4.dw_4.ResetUpdate ( ) 

		end if
	else
		k_errore = string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) 
		kguo_sqlca_db_magazzino.db_rollback( )
		if kst_esito.esito <> kkg_esito.ok then
			k_errore += "~n~rfallito anche il 'recupero' dell'errore: ~n~r" + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) 
		end if
		k_errore += "~n~rPrego, controllare i dati !! "
		k_return="1Fallito aggiornamento archivio Packing List Mandante ! " + k_errore 
	end if	
	
end if

setpointer(kkg.pointer_default)

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


return k_return

end function

protected function integer cancella ();//
//=== Cancellazione rekord dal DB
//=== Ritorna : 0=OK 1=KO 2=non eseguita
//
int k_return=0
string k_record, k_record_1
string k_errore = "0 ", k_errore1 = "0 ", k_nro_fatt
long k_riga, k_seq, k_ctr
st_tab_wm_pklist kst_tab_wm_pklist
st_tab_clienti kst_tab_clienti
st_esito kst_esito


//=== 
choose case tab_1.selectedtab 
	case 1 
		k_record = " Packing List Mandante "
		k_riga = tab_1.tabpage_1.dw_1.getrow()	
		if k_riga > 0 then
			if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> new! and &
					tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
				kst_tab_wm_pklist.id_wm_pklist  = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_wm_pklist")
				kst_tab_wm_pklist.idpkl = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "idpkl")
				kst_tab_clienti.rag_soc_10 = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "rag_soc_10")
				if isnull(kst_tab_wm_pklist.idpkl) then kst_tab_wm_pklist.idpkl = ""
				if isnull(kst_tab_wm_pklist.id_wm_pklist) then kst_tab_wm_pklist.id_wm_pklist = 0
				if isnull(kst_tab_clienti.rag_soc_10) then kst_tab_clienti.rag_soc_10 = ""
				k_record_1 = &
					"Sei sicuro di voler eliminare il Packing List Mandante~n~r" + &
					"codice " + string(kst_tab_wm_pklist.idpkl) +  &
					" (id = " + string(kst_tab_wm_pklist.id_wm_pklist) + ") ~n~r, di " +  &
					" " + string(kst_tab_clienti.rag_soc_10) + "? "
			else
				tab_1.tabpage_1.dw_1.deleterow(k_riga)
				k_riga = 0
			end if
		end if
	case 4
		k_record = " Riga di dettaglio "
		k_riga = tab_1.tabpage_4.dw_4.getselectedrow(0)	
//		if k_riga > 0 then
//			if tab_1.tabpage_4.dw_4.getitemstatus(k_riga, 0, primary!) <> new! and &
//				tab_1.tabpage_4.dw_4.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
//				k_key = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "m_r_f_clie_3")
//				k_clie_1 = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "clie_1")
//				k_clie_2 = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "clie_2")
//				k_record_1 = &
//					"Sei sicuro di voler eliminare il legame con il~n~r" &
//					+ "Mandante " + trim(string(k_clie_1)) + "  e  il Ricevente " &
//					+ trim(string(k_clie_2)) + " ?"
//			else
//				tab_1.tabpage_4.dw_4.deleterow(k_riga)
//			end if
//		end if
end choose	



//=== Se righe in lista
if k_riga > 0  then
	
//=== Cancella la riga dal data windows di lista
	choose case tab_1.selectedtab 
		case 1 
//=== Richiesta di conferma della eliminazione del rek
			if messagebox("Elimina" + k_record, k_record_1, question!, yesno!, 2) = 1 then
				kst_esito = kiuf_wm_pklist_testa.tb_delete( kst_tab_wm_pklist )   // CANCELLA PKLIST
				
			else
				messagebox("Elimina" + k_record,  "Operazione Annullata !!")
				k_return = 2
			end if
		case 4
//				k_errore = kiuf_fatt.tb_delete_riga( kst_tab_arfa )   
			kst_esito.esito = kkg_esito.ok
	end choose	
	
	if k_return <> 2 then
	
		if kst_esito.esito = kkg_esito.ok then
			kst_esito = kguo_sqlca_db_magazzino.db_commit()
			if kst_esito.esito <> kkg_esito.ok then
				k_return = 1
				messagebox("Problemi durante la Cancellazione", "Controllare i dati. Errore durante la conferma dati (COMMIT)"  + " ~n~r" + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) )
	
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
			k_errore1 = "Operazione fallita per errore: ~n~r" + mid(k_errore, 2)
			kguo_sqlca_db_magazzino.db_rollback( )
			if kst_esito.esito <> kkg_esito.ok then
				k_errore1 += "~n~rfallito anche il 'recupero' dell'errore: ~n~r" + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) 
			end if
			k_errore1 += "~n~rPrego, controllare i dati !! "
			messagebox("Problemi durante la Cancellazione", k_errore1 ) 	
			
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
				
			tab_1.tabpage_4.dw_4.setcolumn(1)
	//		tab_1.tabpage_4.dw_4.ResetUpdate ( ) 
	end choose	
	
end if


return k_return

end function

protected function string check_dati ();//
//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK ma errore non grave
//===                : 5=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================

string k_return = " "
string k_errore = "0"
long k_nr_righe
int k_riga, k_ctr
int k_nr_errori 
date k_data_scad_sf_cf, k_data_pkl
kuf_armo kuf1_armo
st_esito kst_esito
st_tab_wm_pklist kst_tab_wm_pklist, kst_tab_wm_pklist_altro
st_tab_wm_pklist_righe kst_tab_wm_pklist_righe
st_tab_contratti kst_tab_contratti
st_tab_meca kst_tab_meca




//=== Controllo il primo tab
	k_nr_righe = tab_1.tabpage_1.dw_1.rowcount()
	k_nr_errori = 0
	k_riga = 1
	this.riempi_st_tab_wm_pklist_da_dw1( k_riga, kst_tab_wm_pklist)

	if kst_tab_wm_pklist.clie_1 = 0 then
		k_return = tab_1.tabpage_1.text + ": Manca il codice Mandante " + "~n~r" 
		k_errore = "3"
		k_nr_errori++
	end if

////--- controllo se PK-LIST già caricato		
//	if k_errore = "0" or k_errore = "4" or k_errore = "5" then
//		
//		try
//			kst_tab_wm_pklist.idpkl = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "idpkl")
//			if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento &
//					or kist_tab_wm_pklist_orig.idpkl <> kst_tab_wm_pklist.idpkl then
//			
//				if kiuf_wm_pklist_testa.if_esiste( kst_tab_wm_pklist ) then
//					kst_tab_wm_pklist_altro.id_wm_pklist = kiuf_wm_pklist_testa.get_id_wm_pklist_altro(kst_tab_wm_pklist)
//
//					k_return = tab_1.tabpage_1.text + ": Packing List '" + trim(kst_tab_wm_pklist.idpkl) + "' già caricato con lo stesso Codice, vedi id " &
//					                        + string(kst_tab_wm_pklist_altro.id_wm_pklist) 
//					
//					kuf1_armo = create kuf_armo
//					kst_tab_meca.id_wm_pklist = kst_tab_wm_pklist_altro.id_wm_pklist
//					kuf1_armo.get_id_da_id_wm_pklist(kst_tab_meca)
//					if kst_tab_meca.id > 0 then
//						kuf1_armo.get_dati_rid(kst_tab_meca)
//						k_return += "~n~rLotto n. " + string(kst_tab_meca.num_int) + " del " + string(kst_tab_meca.data_int, "dd mmm yyyy") 
//						if date(kst_tab_meca.data_ent) > kkg.data_zero then
//							k_return += " entrato il " + string(kst_tab_meca.data_ent, "dd mmm yy")
//						else
//							k_return +=  " non ancora entrato. "
//						end if
//						if kuf1_armo.if_lotto_chiuso(kst_tab_meca) then
//							k_return += "~n~rLotto CHIUSO o ANNULLATO, per proseguire eliminare il Packing-List indicato." 
//						else
//							k_return += "~n~rPer proseguire ANNULLARE il Lotto ed eliminare il Packing-List indicato."
//						end if
//					else
//						k_return += "~n~rNessun Lotto associato è stato trovato, per proseguire eliminare prima il Packing-List indicato." 
//					end if
//					k_errore = "1"
//					k_nr_errori++
//				end if
//			end if
//			
//		catch (uo_exception kuo_exception1)
//				kst_esito = kuo_exception1.get_st_esito()
//				k_return += tab_1.tabpage_1.text + ": Errore DB-1: '" + string(kst_esito.sqlcode) +" - "+ trim(kst_esito.sqlerrtext) + "'~n~r" 
//				k_errore = "1"
//				k_nr_errori++
//			
//		finally
//			if isvalid(kuf1_armo) then destroy kuf1_armo
//			
//		end try
//		
//	end if
//
////--- controllo Contratti
//	if k_errore = "0" or k_errore = "4" or k_errore = "5" then
//		try
//
//			k_data_pkl = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "dtord")
//
////--- controllo CO 
//			if trim(kst_tab_wm_pklist.mc_co) > " " then
//				kst_tab_contratti.mc_co = trim(kst_tab_wm_pklist.mc_co)
//				if not kiuf_contratti.if_esiste_mc_co(kst_tab_contratti) then
//					k_return = tab_1.tabpage_1.text + " - " + trim(tab_1.tabpage_1.dw_1.object.mc_co_t.text)+ " " + trim(kst_tab_contratti.mc_co) + " non Trovato " +  "~n~r" 
//					k_errore = "1"
//					k_nr_errori++
//				end if
//			else
//				kst_tab_wm_pklist.mc_co = ""
//			end if
//			
////--- controllo CF
//			if trim(kst_tab_wm_pklist.sc_cf) > " " then
//				kst_tab_contratti.sc_cf = trim(kst_tab_wm_pklist.sc_cf)
//				if not kiuf_contratti.if_esiste_sc_cf(kst_tab_contratti) then
//					k_return = tab_1.tabpage_1.text + " - " + trim(tab_1.tabpage_1.dw_1.object.sc_cf_t.text) + " " + trim(kst_tab_contratti.sc_cf) + " Capitolato " + trim(kst_tab_contratti.sc_cf) + " non Trovato " + "~n~r" 
//					k_errore = "1"
//					k_nr_errori++
//				else
//					k_data_scad_sf_cf = kiuf_contratti.get_data_scad_sc_cf(kst_tab_contratti)
//					if k_data_scad_sf_cf < k_data_pkl then
//						k_return = tab_1.tabpage_1.text + " - " + trim(tab_1.tabpage_1.dw_1.object.sc_cf_t.text) + " " + trim(kst_tab_contratti.sc_cf) + " Capitolato " + trim(kst_tab_contratti.sc_cf) &
//											+ " Scaduto il " + string(k_data_scad_sf_cf) + ". Data di confronto " + string(k_data_pkl) + "~n~r" 
//						k_errore = "1"
//						k_nr_errori++
//					end if
//				end if
//			else
//				kst_tab_contratti.sc_cf = ""
//			end if
//
////--- Controllo Contratto periodo	
//			if k_errore = "0" or k_errore = "4" or k_errore = "5" then
//				if trim(kst_tab_wm_pklist.mc_co) > " " then
//					kst_tab_contratti.cod_cli = kst_tab_wm_pklist.clie_3 
//					kst_esito = kiuf_contratti.get_codice_da_cf_co(kst_tab_contratti)   // get del codice esatto del contratto
//					if kst_esito.esito <> kkg_esito.ok then
//						if kst_esito.esito = kkg_esito.err_logico then
//							k_return = tab_1.tabpage_1.text + " - " + trim(tab_1.tabpage_1.dw_1.object.sc_cf_t.text) + " " + trim(kst_tab_contratti.sc_cf) + " Più di un Contratto " + trim(kst_tab_contratti.mc_co) &
//											+ " + cf = '" + trim(kst_tab_contratti.sc_cf) + "' presente in archivio~n~r" 
//						else
//							k_return = tab_1.tabpage_1.text + " - " + trim(tab_1.tabpage_1.dw_1.object.sc_cf_t.text) + " " + trim(kst_tab_contratti.sc_cf) + " Contratto " + trim(kst_tab_contratti.mc_co) &
//											+ " + cf = '" + trim(kst_tab_contratti.sc_cf) + "', non Trovato in archivio~n~r" 
//						end if
//						k_errore = "1"
//						k_nr_errori++
//					else
//						kiuf_contratti.get_data_scad(kst_tab_contratti)
//						if k_data_pkl > kst_tab_contratti.data_scad or k_data_pkl < kst_tab_contratti.data then
//							k_return = tab_1.tabpage_1.text + " - " + trim(tab_1.tabpage_1.dw_1.object.sc_cf_t.text) + " " + trim(kst_tab_contratti.sc_cf) + " Contratto " + trim(kst_tab_contratti.sc_cf) &
//											+ " + cf = '" + trim(kst_tab_contratti.sc_cf) + "', non valido~n~r" &
//											+ "data del pk.list " + string(k_data_pkl) + " oltre il periodo " + string(kst_tab_contratti.data) + "-" + string(kst_tab_contratti.data_scad) + "~n~r" 
//							k_errore = "1"
//							k_nr_errori++
//						end if
//					end if
//				end if
//			end if	
//			
//		catch (uo_exception kuo_exception2)
//				kst_esito = kuo_exception2.get_st_esito()
//				k_return += tab_1.tabpage_1.text + ": Errore DB-1: '" + string(kst_esito.sqlcode) +" - "+ trim(kst_esito.sqlerrtext) + "'~n~r" 
//				k_errore = "1"
//				k_nr_errori++
//			
//		finally
//			
//		end try
//	end if
//	
	
//=== Controllo altro tab
	if k_errore = "0" or k_errore = "4" or k_errore = "5" then

//--- verifica se ci sono righe di dettaglio		
		k_nr_righe = tab_1.tabpage_4.dw_4.rowcount()
		if k_nr_righe = 0 then
			
			if kst_tab_wm_pklist.id_wm_pklist > 0 then
				 tab_1.tabpage_4.dw_4.retrieve(kst_tab_wm_pklist.id_wm_pklist)
			end if
			k_nr_righe = tab_1.tabpage_4.dw_4.rowcount()
			if k_nr_righe = 0 then
				k_return = tab_1.tabpage_1.text + ": Non ci sono righe caricate x questo documento " + "~n~r" 
				k_errore = "3"
				k_nr_errori++
			end if
		end if
	end if

//--- controllo se è presente almeno un Contratto-E1 
//					if k_errore = "0" or k_errore = "4" or k_errore = "5" then
//						try
//							u_set_k_e1litm_ok()   // verifica se c'è almeno un Contratto-E1 è attivo su Listino
//							
//							if tab_1.tabpage_1.dw_1.getitemstring(1, "k_e1litm_ok") = "1" then
//							else
//								k_return = tab_1.tabpage_1.text + ": Attenzione nessun Contratto-E1 attivo in archivio, il documento ASN su E1 non verrà generato!!~n~r" 
//								k_errore = "5"
//								k_nr_errori++
//								if messagebox("Importa Packing-List come Nuovo Lotto", & 
//									"Generare il nuovo Lotto da questa Packing-List '" + kst_tab_wm_pklist.idpkl + "'?~n~r" &
//									+ "Durante l'importazione eventuali modifiche saranno subito inserite sul Pk-List e sul nuovo Lotto" &
//									, question!, yesno!, 2) = 1 then
//							end if
//							
//						catch (uo_exception kuo_exception3)
//								kst_esito = kuo_exception3.get_st_esito()
//								k_return += tab_1.tabpage_1.text + ": Errore DB-1: '" + string(kst_esito.sqlcode) +" - "+ trim(kst_esito.sqlerrtext) + "'~n~r" 
//								k_errore = "1"
//								k_nr_errori++
//							
//						finally
//							
//						end try
//					end if

	if k_errore = "0" or k_errore = "4" or k_errore = "5" then
		
		try 
			
			k_riga = tab_1.tabpage_4.dw_4.getnextmodified(0, primary!)
		
			do while k_riga > 0  and k_nr_errori < 10
		
				if k_nr_errori < 9 then // per non uscire da check senza contr.eventuali eltri errori gravi 
				
					this.riempi_st_tab_wm_pklist_righe_da_dw4(k_riga, kst_tab_wm_pklist_righe)
					
//--- Controllo Numero COLLI			
					if kst_tab_wm_pklist_righe.colli = 0 or isnull(kst_tab_wm_pklist_righe.colli )  then 
						k_return = trim(k_return) + tab_1.tabpage_4.text + ": Manca il numero Colli alla riga "+ string(k_riga, "#####") +  + "~n~r" 
						k_errore = "3"
						k_nr_errori++
					end if
				end if
				
				k_riga++
		
				k_riga = tab_1.tabpage_4.dw_4.getnextmodified(k_riga, primary!)
		
			loop
			
		catch (uo_exception kuo1_exception)
				kst_esito = kuo1_exception.get_st_esito()
				k_return += tab_1.tabpage_1.text + ": Errore DB-6: '" + string(kst_esito.sqlcode) +" - "+ trim(kst_esito.sqlerrtext) + "'~n~r" 
				k_errore = "1"
				k_nr_errori++
			
		finally

		end try
		
	end if

//--- contollo numero colli messo in testata con quello nelle righe
	if k_errore = "0" or k_errore = "4" or k_errore = "5" then
		if tab_1.tabpage_4.dw_4.rowcount( ) > 0 then
			kst_tab_wm_pklist_righe.colli = 0
			for k_riga=1 to tab_1.tabpage_4.dw_4.rowcount( )
				kst_tab_wm_pklist_righe.colli += tab_1.tabpage_4.dw_4.getitemnumber( k_riga, "colli")
			next
			
			if kst_tab_wm_pklist.collipkl > 0 then
				if kst_tab_wm_pklist.colliddt <> kst_tab_wm_pklist_righe.colli then
					k_return += tab_1.tabpage_4.text + ": Totale Colli righe ( "+ string(kst_tab_wm_pklist_righe.colli) &
					                   + " ) diverso dal n.Colli bolla (" + string(kst_tab_wm_pklist.colliddt ) + ") indicato; " +  " ~n~r" 
					k_errore = "4"
 					k_nr_errori++
				end if
			else
				tab_1.tabpage_4.dw_4.setitem( k_riga, "colli", kst_tab_wm_pklist_righe.colli)
			end if
		end if
	end if
		


//
return k_errore + k_return


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
st_tab_wm_pklist kst_tab_wm_pklist
st_tab_clienti kst_tab_clienti
st_esito kst_esito
uo_exception kuo_exception
kuf_base kuf1_base
kuf_utility kuf1_utility



//=== Puntatore Cursore da attesa.....
SetPointer(kkg.pointer_attesa)

kuo_exception = create uo_exception 

//--- reset degli elenchi ddw
if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione and  ki_st_open_w.flag_modalita <> kkg_flag_modalita.cancellazione then

	tab_1.tabpage_1.dw_1.ki_link_standard_attivi = FALSE

else
	tab_1.tabpage_1.dw_1.ki_link_standard_attivi = true
	
end if

if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
	kst_tab_wm_pklist.id_wm_pklist = 0
	kst_tab_wm_pklist.clie_1 = 0
	if isnumber(ki_st_open_w.key1) then
		kst_tab_wm_pklist.id_wm_pklist  = long(trim(ki_st_open_w.key1))
	end if
	if isnumber(ki_st_open_w.key2) then
		kst_tab_wm_pklist.clie_1  = long(trim(ki_st_open_w.key2))
	end if

	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
		
		k_err_ins = inserisci()

		if kst_tab_wm_pklist.clie_1 > 0 then
			kst_tab_clienti.codice = kst_tab_wm_pklist.clie_1 
			get_dati_cliente(kst_tab_clienti)
			put_video_cliente(kst_tab_clienti, "clie_1")
		end if
		
	else

		k_rc = tab_1.tabpage_1.dw_1.retrieve(kst_tab_wm_pklist.id_wm_pklist) 
		
		choose case k_rc

			case is < 0		
				SetPointer(kkg.pointer_default)
				kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_err_int )
				kuo_exception.setmessage(  &
					"Mi spiace ma si è verificato un errore interno al programma~n~r" + &
					"(ID Documento cercato:" + string(kst_tab_wm_pklist.id_wm_pklist) + ") " )
				kuo_exception.messaggio_utente( )	
				cb_ritorna.postevent(clicked!)

			case 0
				tab_1.tabpage_1.dw_1.reset()

				if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
					ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento

					SetPointer(kkg.pointer_default)
					kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_not_fnd )
					kuo_exception.setmessage(  &
						"Mi spiace ma il Documento non è in archivio ~n~r" + &
						"(ID Documento cercato:" + string(kst_tab_wm_pklist.id_wm_pklist) + ") " )
					kuo_exception.messaggio_utente( )	
					
					cb_ritorna.postevent(clicked!)
					
				else
					k_err_ins = inserisci()
				end if

			case is > 0		
				kist_tab_wm_pklist_orig.id_wm_pklist = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_wm_pklist")
				
				if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
					SetPointer(kkg.pointer_default)
					kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_allerta )
					kuo_exception.setmessage(  &
						"Attenzione, il Documento è già in archivio ~n~r" + &
						"(ID Documento cercato:" + string(kist_tab_wm_pklist_orig.id_wm_pklist) + ") " )
					kuo_exception.messaggio_utente( )	
			
					ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica

				end if
				u_set_k_e1litm_ok()   // verifica se c'è almeno un Contratto-E1 è attivo su Listino

				kiw_this_window.setfocus( )
				tab_1.tabpage_1.dw_1.setfocus()
				tab_1.tabpage_1.dw_1.setcolumn("clie_1")
		end choose

	end if	

end if


//===
//--- se inserimento inabilito gli altri TAB, sono inutili
if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then

	tab_1.tabpage_2.enabled = false
	tab_1.tabpage_3.enabled = false
	tab_1.tabpage_4.enabled = false
	
end if

//--- Inabilita campi alla modifica se Visualizzazione
kuf1_utility = create kuf_utility 
if trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.modifica &
		 and trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.inserimento then

//		tab_1.tabpage_1.dw_1.object.b_indi.visible = false 
//		tab_1.tabpage_1.dw_1.object.b_note.visible = false 

	kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_1.dw_1)

else		

//--- popola dw child dw clienti 
	set_dw_clienti_child()
	
//--- S-protezione campi per riabilitare la modifica a parte la chiave
	kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)

//--- Inabilita campi documento alla modifica se Funzione MODIFICA
	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
//			kuf1_utility.u_proteggi_dw("1", "stato", tab_1.tabpage_1.dw_1)
		kuf1_utility.u_proteggi_dw("1", "id_wm_pklist", tab_1.tabpage_1.dw_1)
		kuf1_utility.u_proteggi_dw("1", "dtimportazione", tab_1.tabpage_1.dw_1)
	end if
	kuf1_utility.u_proteggi_dw("0", "note_lotto", tab_1.tabpage_1.dw_1)  // sprotegge note lotto
	
end if

//---- azzera il flag delle modifiche
tab_1.tabpage_1.dw_1.SetItemStatus( 1, 0, Primary!, NotModified!)

if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
	if len(trim(tab_1.tabpage_1.dw_1.getitemstring( 1, "stato"))) > 0 then
		if tab_1.tabpage_1.dw_1.getitemstring( 1, "stato") <> kiuf_wm_pklist_testa.kki_stato_nuovo then
//						ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione

			kuf1_utility.u_proteggi_dw("1", "customerlot", tab_1.tabpage_1.dw_1)

			kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_allerta )
			kuo_exception.setmessage(  &
				"Attenzione, Packing List già Importato come Lotto di Trattamento (Riferimento). ~n~rLa Modifica potebbe comprometterne l'integrità. ~n~r" + &
				"(ID Documento cercato:" + string(kst_tab_wm_pklist.id_wm_pklist) + ") " )
			kuo_exception.messaggio_utente( )	
		end if
	end if
end if	


if isvalid(kuf1_utility) then destroy kuf1_utility
if isvalid(kuo_exception) then destroy kuo_exception

attiva_tasti()

SetPointer(kkg.pointer_default)

return "0"


end function

protected function integer inserisci ();//
int k_return=0
kuf_base kuf1_base
st_tab_wm_pklist kst_tab_wm_pklist



if tab_1.selectedtab <> 1 then 
	tab_1.selectedtab = 1
end if

//=== Aggiunge una riga al data windows
	choose case tab_1.selectedtab 
		case  1 
			this.setredraw(false)
	
			tab_1.tabpage_4.dw_4.reset() 
			tab_1.tabpage_1.dw_1.reset() 
			
			tab_1.tabpage_1.dw_1.insertrow(0)
			
			tab_1.tabpage_1.dw_1.setitem(1, "tpimportazione", kiuf_wm_pklist_testa.kki_tpimportazione_manuale )
			tab_1.tabpage_1.dw_1.setitem(1, "dtimportazione", kGuf_data_base.prendi_dataora( ) )
			tab_1.tabpage_1.dw_1.setitem(1, "stato", kiuf_wm_pklist_testa.kki_stato_nuovo )

			ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
			
			this.setredraw(true)

			tab_1.tabpage_1.dw_1.setfocus()
			tab_1.tabpage_1.dw_1.setcolumn("idpkl")

//---- azzera il flag delle modifiche
			tab_1.tabpage_1.dw_1.ResetUpdate ( ) 
			tab_1.tabpage_4.dw_4.ResetUpdate ( ) 


		
		case 4 // 
			if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then	
				riga_aggiungi()
			end if
			

	end choose	

	k_return = 0

//=== 
	attiva_tasti()

//end if

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
			if (isnull(tab_1.tabpage_4.dw_4.getitemstring ( k_riga, "des"))  &
				 	or len(trim(tab_1.tabpage_4.dw_4.getitemstring ( k_riga, "des"))) = 0) &
				then
		
				tab_1.tabpage_4.dw_4.deleterow(k_riga)
//---- azzera il flag delle modifiche
				tab_1.tabpage_4.dw_4.SetItemStatus( k_riga, 0, Primary!, NotModified!)

			end if
		end if
		
	next


end subroutine

protected subroutine riempi_id ();//
//=== Imposta gli Effettivi ID degli archivi
long k_righe, k_ctr
st_tab_wm_pklist kst_tab_wm_pklist



if tab_1.tabpage_1.dw_1.rowcount() > 0 then
	k_ctr = 1
end if

if k_ctr > 0 then
	
//=== Salvo ID originale x piu' avanti
	kst_tab_wm_pklist.id_wm_pklist = tab_1.tabpage_1.dw_1.getitemnumber(k_ctr, "id_wm_pklist")

	if isnull(kst_tab_wm_pklist.id_wm_pklist) then				
		tab_1.tabpage_1.dw_1.setitem(k_ctr, "id_wm_pklist", 0)
		kst_tab_wm_pklist.id_wm_pklist = 0
	end if

//--- imposto se vuoto il campo collipkl uguale a colliddt
	kst_tab_wm_pklist.collipkl = tab_1.tabpage_1.dw_1.getitemnumber(k_ctr, "collipkl")
	if isnull(kst_tab_wm_pklist.collipkl) or kst_tab_wm_pklist.collipkl = 0 then
		tab_1.tabpage_1.dw_1.setitem(k_ctr, "collipkl", tab_1.tabpage_1.dw_1.getitemnumber(k_ctr, "colliddt"))
	end if


	k_righe = tab_1.tabpage_4.dw_4.rowcount()
	for k_ctr = 1 to k_righe 
		
		if tab_1.tabpage_4.dw_4.getitemnumber(k_ctr, "id_wm_pklist") > 0 then
		else
			tab_1.tabpage_4.dw_4.setitem(k_ctr, "id_wm_pklist", kst_tab_wm_pklist.id_wm_pklist)
	
	//=== Se non sono in caricamento allora imposto a zero l'ID serial
			if tab_1.tabpage_4.dw_4.getitemstatus(k_ctr, 0, primary!) = newmodified! then
				tab_1.tabpage_4.dw_4.setitem(k_ctr, "id_wm_pklist_riga", 0)
				
			end if
		end if
	
	end for

end if

end subroutine

protected subroutine open_start_window ();//
//
kiuf_wm_pklist_testa = create kuf_wm_pklist_testa	 
kiuf_wm_pklist_righe = create kuf_wm_pklist_righe  	 
kiuf_clienti = create kuf_clienti  	 
kiuf_contratti = create kuf_contratti

ki_toolbar_window_presente=true

//	tab_1.tabpage_1.dw_1.object.b_ric_lotto.filename = kGuo_path.get_risorse() + "\scadenzario.gif" 
//	tab_1.tabpage_1.dw_1.object.b_contab.filename = kGuo_path.get_risorse() + "\contabilita.gif" 
//	tab_1.tabpage_1.dw_1.object.b_cliente.filename = kGuo_path.get_risorse() + kkg_risorsa_elenco 
//	tab_1.tabpage_1.dw_1.object.b_indi.filename = kGuo_path.get_risorse() + kkg_risorsa_elenco 
//	tab_1.tabpage_1.dw_1.object.b_note.filename = kGuo_path.get_risorse() + kkg_risorsa_elenco 


end subroutine

protected subroutine attiva_menu ();//
//---
//
boolean k_attiva


//--- solo se sono im caricamento posso importare nuove PKL grezze
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento and ki_tab_1_index_new = 1 then
		k_attiva = true
	else
		k_attiva = false
	end if
	if ki_menu.m_strumenti.m_fin_gest_libero1.enabled <> k_attiva then
		ki_menu.m_strumenti.m_fin_gest_libero1.text = "Crea nuovo Packing-list da file cliente importato"
		ki_menu.m_strumenti.m_fin_gest_libero1.microhelp = "Genera Packing-list già importato"
	
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText = 	"Crea, Nuovo Packing-list da file importato"
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
	
		ki_menu.m_strumenti.m_fin_gest_libero1.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemname = "CreateTable5!"
		ki_menu.m_strumenti.m_fin_gest_libero1.visible = true
	end if
	
//=== 
	if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then	

		if tab_1.tabpage_1.dw_1.getitemnumber(1, "id_wm_pklist") > 0 &
					and tab_1.tabpage_1.dw_1.object.stato[1] = kiuf_wm_pklist_testa.kki_stato_nuovo &
					and ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica &
					and ki_tab_1_index_new = 1 then
			k_attiva = true
		else
			k_attiva = false
		end if
		if ki_menu.m_strumenti.m_fin_gest_libero2.enabled <> k_attiva then
			ki_menu.m_strumenti.m_fin_gest_libero2.text = "Genera nuovo Lotto di entrata "
			ki_menu.m_strumenti.m_fin_gest_libero2.microhelp = "Carica da questo Packing-list il nuovo Lotto "
			ki_menu.m_strumenti.m_fin_gest_libero2.visible = true

			ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemText = 	"Genera, Carica Nuovo Lotto  "
			ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
		
			ki_menu.m_strumenti.m_fin_gest_libero2.enabled = k_attiva
			ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemname = "lotto16x16.gif" 
			ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true
		end if
		

		if tab_1.tabpage_1.dw_1.getitemnumber(1, "id_wm_pklist") > 0 &
					and ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica &
					and ki_tab_1_index_new = 1 then
			k_attiva = true
		else
			k_attiva = false
		end if
		if ki_menu.m_strumenti.m_fin_gest_libero3.enabled <> k_attiva then
			ki_menu.m_strumenti.m_fin_gest_libero3.text = "Duplica Packing-list"
			ki_menu.m_strumenti.m_fin_gest_libero3.microhelp = "Crea una duplica da questo Packing-list"
			ki_menu.m_strumenti.m_fin_gest_libero3.visible = true

			ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemText = "Duplica,Crea un nuovo Packing-list da questo "
			ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritembarindex=2
		
			ki_menu.m_strumenti.m_fin_gest_libero3.enabled = k_attiva
			ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemname = "ViewPainter!" 
			ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemVisible = true
		end if

		if tab_1.tabpage_1.dw_1.getitemnumber(1, "id_wm_pklist") > 0 &
					and ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
			k_attiva = true
		else
			k_attiva = false
		end if
		if ki_menu.m_strumenti.m_fin_gest_libero4.enabled <> k_attiva then
			ki_menu.m_strumenti.m_fin_gest_libero4.text = "Modifica codici barcode"
			ki_menu.m_strumenti.m_fin_gest_libero4.microhelp = "Modifica codici barcode del mittente"
			ki_menu.m_strumenti.m_fin_gest_libero4.visible = true

			ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemText = "Barcode,Modifica codici barcode"
			ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritembarindex=2
		
			ki_menu.m_strumenti.m_fin_gest_libero4.enabled = k_attiva
			ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemname = "barcode.bmp" 
			ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemVisible = true
		end if
		
	end if

//		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione &
//				and ki_st_open_w.flag_modalita <> kkg_flag_modalita.cancellazione &
//				and tab_1.tabpage_4.enabled then
//			ki_menu.m_strumenti.m_fin_gest_libero5.text = "Aggiungi Riga Merce senza trattamento "
//			ki_menu.m_strumenti.m_fin_gest_libero5.microhelp = "Aggiungi Riga Merce da non trattare (no-dose)"
//			ki_menu.m_strumenti.m_fin_gest_libero5.visible = true
//	
//			ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemVisible = true
//			ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemText = 	"Merce, Nuova Riga senza Trattamento "
//			ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritembarindex=2
//	
//			ki_menu.m_strumenti.m_fin_gest_libero5.enabled = true
//		else
//			ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemVisible = false
//			ki_menu.m_strumenti.m_fin_gest_libero5.enabled = false
//		end if

//		this.settoolbar( 2, true)
//	else
//		this.settoolbar( 2, false)
//		ki_menu.m_strumenti.m_fin_gest_libero1.visible = false
//		ki_menu.m_strumenti.m_fin_gest_libero2.visible = false
//		ki_menu.m_strumenti.m_fin_gest_libero3.visible = false
//		ki_menu.m_strumenti.m_fin_gest_libero4.visible = false
//		ki_menu.m_strumenti.m_fin_gest_libero5.visible = false
//		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = false
//		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = false
//		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemVisible = false
//		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemVisible = false
//		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemVisible = false
//	end if
//
//	if ki_st_open_w.flag_primo_giro = 'S' then
//		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName = "ScriptYes!"
//		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemName = "Custom048!"
//		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemName = "DataManip!"
//		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemName = kGuo_path.get_risorse() + "\lotto16x16.gif"
//	end if

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

	case "l1"		//Crea nuovo Packing-List 
		importa_pklist_ext()

	case "l2"		//Genera Lotto Riferimento dal Packing-List 
		importa_pklist()

	case "l3"		//Duplica
		u_duplica_pklist( )

	case "l4"		//modifica barcode
		u_modifica_barcode( )
		
//
//	case "l5"		//Elenco Lotti senza Trattamento
//		elenco_lotti_no_dose()

	case else
		super::smista_funz(k_par_in)

end choose

end subroutine

public function boolean get_dati_cliente (ref st_tab_clienti kst_tab_clienti);//
boolean k_return = false
st_esito kst_esito
kuf_clienti kuf1_clienti


try
	
	kuf1_clienti = create kuf_clienti

	k_return = kuf1_clienti.leggi (kst_tab_clienti)

	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	

finally
	destroy kuf1_clienti
	
end try

return k_return


end function

private subroutine riga_modifica ();//======================================================================
//=== 
//======================================================================
//
long k_riga=0, k_riga1=0, k_rc
st_tab_wm_pklist_righe kst_tab_wm_pklist_righe



	k_riga = tab_1.tabpage_4.dw_4.getselectedrow(0)
	if k_riga > 0 then

		riempi_st_tab_wm_pklist_righe_da_dw4(k_riga, 	kst_tab_wm_pklist_righe)	
		

		dw_riga.object.b_aggiungi.visible = false 
		dw_riga.object.b_aggiorna.visible = true 
	
	
		dw_riga.triggerevent( "u_modifica" )
		k_riga1=dw_riga.insertrow(0)
		riempi_dw_riga(k_riga1, kst_tab_wm_pklist_righe)
		dw_riga.object.k_riga[k_riga1] = k_riga  //devo ricordare la riga che sto x modificare 
	
		dw_riga.visible = true		
			
	end if



end subroutine

protected subroutine inizializza_3 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 4 controllandone i valori se gia' presenti
//======================================================================
//
st_tab_wm_pklist_righe kst_tab_wm_pklist_righe


kst_tab_wm_pklist_righe.id_wm_pklist  = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_wm_pklist")  

if kst_tab_wm_pklist_righe.id_wm_pklist  > 0 then

	if tab_1.tabpage_4.dw_4.rowcount() < 1 then

		tab_1.tabpage_4.dw_4.retrieve(kst_tab_wm_pklist_righe.id_wm_pklist ) 
		
	end if

//---- azzera il flag delle modifiche
//	tab_1.tabpage_4.dw_4.SetItemStatus( 1, 0, Primary!, NotModified!)

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
st_tab_clienti kst_tab_clienti
st_tab_contratti kst_tab_contratti
st_esito kst_esito
datawindowchild kdwc_1
uo_exception kuo_exception1




if long(k_riga) > 0 then 

//--- Se dalla w di elenco 'prevista'  ho fatto doppio-click	 x scegliere la riga	
	if tab_1.selectedtab = 1 then
		choose case kdw_source.dataobject 

//-- DROP nel TAB 1

//--- scelta da elenco Mand-Ricev-Fatt
			case  kiuf_clienti.kki_dw_elenco_m_r_f_3 
			
				if kdw_source.rowcount() > 0 then
		
					tab_1.tabpage_1.dw_1.setitem(1, "clie_1",  kdw_source.getitemnumber(long(k_riga), "clie_1"))
					tab_1.tabpage_1.dw_1.setitem(1, "rag_soc_10",  kdw_source.getitemstring(long(k_riga), "clienti_rag_soc_1"))
					tab_1.tabpage_1.dw_1.setitem(1, "clie_2",  kdw_source.getitemnumber(long(k_riga), "clie_2"))
					tab_1.tabpage_1.dw_1.setitem(1, "rag_soc_10_1", kdw_source.getitemstring(long(k_riga), "clienti_rag_soc_2"))
					tab_1.tabpage_1.dw_1.setitem(1, "clie_3",  kdw_source.getitemnumber(long(k_riga), "clie_3"))
					tab_1.tabpage_1.dw_1.setitem(1, "rag_soc_10_2", kdw_source.getitemstring(long(k_riga), "clienti_rag_soc_3"))
									 
				end if
		
//--- scelta da elenco Contratti
			case  kiuf_contratti. kki_dw_elenco_contratti 
			
				if kdw_source.rowcount() > 0 then
					tab_1.tabpage_1.dw_1.setitem(1,"id_contratto", kdw_source.getitemnumber(long(k_riga), "codice"))
					tab_1.tabpage_1.dw_1.setitem(1, "mc_co",  kdw_source.getitemstring(long(k_riga), "mc_co"))
					tab_1.tabpage_1.dw_1.setitem(1, "sc_cf",  kdw_source.getitemstring(long(k_riga), "sc_cf"))
					u_set_k_e1litm_ok()  // verifica se contratto-E1 attivato
				end if
		
		end choose

	end if
	
end if





end subroutine

protected function string inizializza_post ();string k_return = "0"



	k_return = super::inizializza_post()


//--- se sono entrato x cancellazione...				
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.cancellazione then
		ki_esci_dopo_cancella = true
		cb_cancella.event clicked( )
	end if 

return k_return
end function

public subroutine set_iniz_dati_cliente (ref st_tab_clienti kst_tab_clienti);//			
kst_tab_clienti.codice = 0
kst_tab_clienti.rag_soc_10 = " "
kst_tab_clienti.p_iva = " "
kst_tab_clienti.cf = " "
kst_tab_clienti.id_nazione_1 = " "
kst_tab_clienti.cadenza_fattura = " "
kst_tab_clienti.loc_1 = " "
kst_tab_clienti.prov_1 = " "
kst_tab_clienti.kst_tab_ind_comm.rag_soc_1_c  = " "
kst_tab_clienti.kst_tab_ind_comm.rag_soc_2_c  = " "
kst_tab_clienti.kst_tab_ind_comm.indi_c  = " "
kst_tab_clienti.kst_tab_ind_comm.cap_c  = " "
kst_tab_clienti.kst_tab_ind_comm.loc_c  = " "
kst_tab_clienti.kst_tab_ind_comm.prov_c  = " "
kst_tab_clienti.kst_tab_clienti_fatt.fattura_da  = " "
kst_tab_clienti.iva  = 0
kst_tab_clienti.kst_tab_clienti_fatt.note_1 = " "
kst_tab_clienti.kst_tab_clienti_fatt.note_2 = " "

end subroutine

public subroutine set_dw_clienti_child ();//
int k_rc
string k_cadenza_fattura="", k_x=""
datawindowchild  kdwc_1, kdwc_2, kdwc_1_2, kdwc_1_3, kdwc_2_2, kdwc_2_3


//	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
		
//--- se e' a zero la dwc allora faccio il popolamento delle DW
//		if tab_1.tabpage_1.dw_1.rowcount( ) = 0 then

			tab_1.tabpage_1.dw_1.getchild("clie_1", kdwc_1)
			kdwc_1.settransobject(sqlca)
			kdwc_1.reset() 
			tab_1.tabpage_1.dw_1.getchild("rag_soc_10", kdwc_2)
			kdwc_2.settransobject(sqlca)
			kdwc_2.reset() 
			tab_1.tabpage_1.dw_1.getchild("clie_2", kdwc_1_2)
			kdwc_1_2.settransobject(sqlca)
			kdwc_1_2.reset() 
			tab_1.tabpage_1.dw_1.getchild("rag_soc_10_1", kdwc_2_2)
			kdwc_2_2.settransobject(sqlca)
			kdwc_2_2.reset() 
			tab_1.tabpage_1.dw_1.getchild("clie_3", kdwc_1_3)
			kdwc_1_3.settransobject(sqlca)
			kdwc_1_3.reset() 
			tab_1.tabpage_1.dw_1.getchild("rag_soc_10_2", kdwc_2_3)
			kdwc_2_3.settransobject(sqlca)
			kdwc_2_3.reset() 

			kdwc_1.retrieve("%")
			kdwc_1.SetSort("id_cliente A")
			kdwc_1.sort( )
			kdwc_1.insertrow(1)
			
			k_rc = kdwc_1.RowsCopy(1, kdwc_1.RowCount(), Primary!, kdwc_1_2, 1, Primary!)
			k_rc = kdwc_1.RowsCopy(1, kdwc_1.RowCount(), Primary!, kdwc_1_3, 1, Primary!)
			
			k_rc = kdwc_1.RowsCopy(1, kdwc_1.RowCount(), Primary!, kdwc_2, 1, Primary!)
			k_rc = kdwc_2.SetSort("rag_soc_1 A")
			k_rc = kdwc_2.sort( )
			
			k_rc = kdwc_2.RowsCopy(1, kdwc_2.RowCount(), Primary!, kdwc_2_2, 1, Primary!)
			k_rc = kdwc_2.RowsCopy(1, kdwc_2.RowCount(), Primary!, kdwc_2_3, 1, Primary!)
			
//		end if		
//	end if

end subroutine

private function integer riga_aggiungi_in_lista (st_tab_wm_pklist_righe kst_tab_wm_pklist_righe) throws uo_exception;//
//--- aggiunge una riga 
//
long k_riga=0


k_riga = tab_1.tabpage_4.dw_4.insertrow(0)

if k_riga > 0 then

	riga_aggiorna_in_lista (k_riga, kst_tab_wm_pklist_righe)  

end if
	
	
return k_riga

	
end function

private function integer riga_nuova_in_lista (ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe) throws uo_exception;//---
//--- aggiunge una riga in elenco
//--- Inp: id_armo, colli  + eventuale num_bolla_out+data_bolla_out+id_arsp, id_arfa_se_nc
//--- out: numero della riga
//---
long k_riga=0
st_tab_wm_pklist kst_tab_wm_pklist
//st_esito kst_esito
//uo_exception kuo_exception


//kuo_exception = create uo_exception

//if riga_gia_presente (kst_tab_arfa) then
//	kuo_exception.setmessage( "Riga già caricata nel Documento! (id="+string(kst_tab_arfa.id_armo)+")")
//	throw kuo_exception
//else
	
	k_riga = tab_1.tabpage_4.dw_4.insertrow(0)
	
	if k_riga > 0 then


		kst_tab_wm_pklist_righe.id_wm_pklist = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_wm_pklist")
		kst_tab_wm_pklist.idpkl = tab_1.tabpage_1.dw_1.getitemstring(1, "idpkl")


////--- legge dati articolo	
//		if len(trim(kst_tab_arfa.art)) > 0 then 
//			kst_tab_arfa.des = " "
//			kst_tab_arfa.iva = 0
//			kst_tab_prodotti.codice = kst_tab_arfa.art
//			kst_esito = kuf1_prodotti.select_riga(kst_tab_prodotti )
//			if kst_esito.esito = kkg_esito.ok then
//				kst_tab_arfa.des = trim(kst_tab_prodotti.des)
//				kst_tab_arfa.iva = kst_tab_prodotti.iva
//			else
//				if kst_esito.esito = kkg_esito.db_ko then
//					kuo_exception.set_esito( kst_esito )
//					throw kuo_exception
//				end if
//			end if
//		end if	

		kiuf_wm_pklist_righe  .if_isnull( kst_tab_wm_pklist_righe ) 


//--- inserisce la riga in elenco	
		riga_aggiorna_in_lista (k_riga, kst_tab_wm_pklist_righe)  
	
	
	
	end if
//end if

//destroy kuo_exception	
		
		
	
return k_riga

	
end function

private subroutine riga_aggiorna_in_lista (long k_riga, readonly st_tab_wm_pklist_righe kst_tab_wm_pklist_righe) throws uo_exception;//
//--- Operazioni x aggiorna riga in elenco
//
//double k_imp_iva=0, k_importo_riga=0
st_esito kst_esito
//uo_exception kuo_exception





//--- espone i dati in elenco 	
	riga_aggiorna_in_lista_art(k_riga, kst_tab_wm_pklist_righe)
	


	
end subroutine

private subroutine riga_aggiorna_in_lista_art (long k_riga, readonly st_tab_wm_pklist_righe kst_tab_wm_pklist_righe);//
//--- Carico in elenco la riga Modificata / Nuova
//


	tab_1.tabpage_4.dw_4.setitem(k_riga, "id_wm_pklist_riga"  ,kst_tab_wm_pklist_righe.id_wm_pklist_riga )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "wm_pklist_idpkl"  ,tab_1.tabpage_1.dw_1.getitemstring(1, "idpkl"))
	tab_1.tabpage_4.dw_4.setitem(k_riga, "id_wm_pklist"  ,kst_tab_wm_pklist_righe.id_wm_pklist )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "stato"  ,kst_tab_wm_pklist_righe.stato )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "idart_clie"  ,kst_tab_wm_pklist_righe.idart_clie )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "idlotto_clie"  ,kst_tab_wm_pklist_righe.idlotto_clie )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "areamag"  ,kst_tab_wm_pklist_righe.areamag )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "id_meca" , kst_tab_wm_pklist_righe.id_meca )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "id_armo"  ,kst_tab_wm_pklist_righe.id_armo )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "gruppo"  ,kst_tab_wm_pklist_righe.gruppo )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "colli"  ,kst_tab_wm_pklist_righe.colli )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "wm_barcode"  ,kst_tab_wm_pklist_righe.wm_barcode )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "barcode"  ,kst_tab_wm_pklist_righe.barcode )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "eliminato"  ,kst_tab_wm_pklist_righe.eliminato )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "idpezzo_clie"  ,kst_tab_wm_pklist_righe.idpezzo_clie )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "qtapezzi_pallet"  ,kst_tab_wm_pklist_righe.qtapezzi_pallet )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "x_datins"  ,kst_tab_wm_pklist_righe.x_datins )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "x_utente"  ,kst_tab_wm_pklist_righe.x_utente )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "x_datins_elim"  ,kst_tab_wm_pklist_righe.x_datins_elim )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "x_utente_elim"  ,kst_tab_wm_pklist_righe.x_utente_elim )
	
end subroutine

private function long riga_modifica_in_lista (long k_riga, st_tab_wm_pklist_righe kst_tab_wm_pklist_righe) throws uo_exception;//
//--- aggiunge una riga 
//


	
	if k_riga > 0 then
	
		kiuf_wm_pklist_righe.if_isnull(kst_tab_wm_pklist_righe)
	
//--- espone i dati circa l'articolo, prezzo, iva ecc... 	
		riga_aggiorna_in_lista_art(k_riga, kst_tab_wm_pklist_righe)
	
	end if
	
	
return k_riga

	
end function

private subroutine riga_aggiungi ();//======================================================================
//=== 
//======================================================================
//
long k_riga= 0
st_tab_wm_pklist_righe kst_tab_wm_pklist_righe

	dw_riga.triggerevent( "u_aggiungi") 
	
		
	k_riga = dw_riga.insertrow(0)
	
	
	kiuf_wm_pklist_righe  .if_isnull( kst_tab_wm_pklist_righe) 
	kst_tab_wm_pklist_righe.stato = kiuf_wm_pklist_righe  .kki_stato_nuovo
	kst_tab_wm_pklist_righe.id_wm_pklist = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_wm_pklist")
	kst_tab_wm_pklist_righe.id_wm_pklist_riga = 0
	kst_tab_wm_pklist_righe.colli = 1
	
	riempi_dw_riga(k_riga, kst_tab_wm_pklist_righe)
	
	dw_riga.visible = true		
	dw_riga.setfocus()
	
end subroutine

private subroutine riempi_st_tab_wm_pklist_righe_da_dw_riga (long k_riga, ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe);//
		
		kst_tab_wm_pklist_righe.id_wm_pklist_riga = dw_riga.getitemnumber(k_riga, "id_wm_pklist_riga")
		kst_tab_wm_pklist_righe.id_wm_pklist = dw_riga.getitemnumber(k_riga, "id_wm_pklist")
		kst_tab_wm_pklist_righe.id_meca = dw_riga.getitemnumber(k_riga, "id_meca")
		kst_tab_wm_pklist_righe.id_armo = dw_riga.getitemnumber(k_riga, "id_armo")
		kst_tab_wm_pklist_righe.colli = dw_riga.getitemnumber(k_riga, "colli")
		kst_tab_wm_pklist_righe.qtapezzi_pallet = dw_riga.getitemnumber(k_riga, "qtapezzi_pallet")
		kst_tab_wm_pklist_righe.id_wm_pklist_riga = dw_riga.getitemnumber(k_riga, "id_wm_pklist_riga")
		kst_tab_wm_pklist_righe.gruppo = dw_riga.getitemnumber(k_riga, "gruppo")

		kst_tab_wm_pklist_righe.stato = dw_riga.getitemstring(k_riga, "stato")
		kst_tab_wm_pklist_righe.idart_clie = dw_riga.getitemstring(k_riga, "idart_clie")
		kst_tab_wm_pklist_righe.idlotto_clie = dw_riga.getitemstring(k_riga, "idlotto_clie")
		kst_tab_wm_pklist_righe.idpezzo_clie = dw_riga.getitemstring(k_riga, "idpezzo_clie")
		kst_tab_wm_pklist_righe.areamag = dw_riga.getitemstring(k_riga, "areamag")
		kst_tab_wm_pklist_righe.wm_barcode = dw_riga.getitemstring(k_riga, "wm_barcode")
		kst_tab_wm_pklist_righe.barcode = dw_riga.getitemstring(k_riga, "barcode")
		kst_tab_wm_pklist_righe.eliminato = dw_riga.getitemstring(k_riga, "eliminato")

		kst_tab_wm_pklist_righe.x_datins = dw_riga.getitemdatetime(k_riga, "x_datins")
		kst_tab_wm_pklist_righe.x_utente = dw_riga.getitemstring(k_riga, "x_utente")
		kst_tab_wm_pklist_righe.x_datins_elim = dw_riga.getitemdatetime(k_riga, "x_datins_elim")
		kst_tab_wm_pklist_righe.x_utente_elim = dw_riga.getitemstring(k_riga, "x_utente_elim")

		kiuf_wm_pklist_righe  .if_isnull( kst_tab_wm_pklist_righe )
	

end subroutine

private subroutine riempi_st_tab_wm_pklist_righe_da_dw4 (long k_riga, ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe);//
		
		kst_tab_wm_pklist_righe.id_wm_pklist_riga = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_wm_pklist_riga")
		kst_tab_wm_pklist_righe.id_wm_pklist = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_wm_pklist")
		kst_tab_wm_pklist_righe.id_meca = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_meca")
		kst_tab_wm_pklist_righe.id_armo = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_armo")
		kst_tab_wm_pklist_righe.colli = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "colli")
		kst_tab_wm_pklist_righe.qtapezzi_pallet = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "qtapezzi_pallet")
		kst_tab_wm_pklist_righe.id_wm_pklist_riga = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_wm_pklist_riga")
		kst_tab_wm_pklist_righe.gruppo = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "gruppo")

		kst_tab_wm_pklist_righe.stato = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "stato")
		kst_tab_wm_pklist_righe.idart_clie = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "idart_clie")
		kst_tab_wm_pklist_righe.idlotto_clie = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "idlotto_clie")
		kst_tab_wm_pklist_righe.idpezzo_clie = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "idpezzo_clie")
		kst_tab_wm_pklist_righe.areamag = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "areamag")
		kst_tab_wm_pklist_righe.wm_barcode = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "wm_barcode")
		kst_tab_wm_pklist_righe.barcode = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "barcode")
		kst_tab_wm_pklist_righe.eliminato = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "eliminato")

		kst_tab_wm_pklist_righe.x_datins = tab_1.tabpage_4.dw_4.getitemdatetime(k_riga, "x_datins")
		kst_tab_wm_pklist_righe.x_utente = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "x_utente")
		kst_tab_wm_pklist_righe.x_datins_elim = tab_1.tabpage_4.dw_4.getitemdatetime(k_riga, "x_datins_elim")
		kst_tab_wm_pklist_righe.x_utente_elim = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "x_utente_elim")

		kiuf_wm_pklist_righe.if_isnull( kst_tab_wm_pklist_righe )
	

end subroutine

private function boolean riga_gia_presente (st_tab_wm_pklist_righe kst_tab_wm_pklist_righe);//---
//--- Controllo se riga gia' presente in questo documento
//--- out: boolean:   true=presente, false=non trovata
//
boolean k_return = false


//	if kst_tab_arfa.id_armo > 0 then
//		
//		if kst_tab_arfa.id_arsp > 0 then
//			if tab_1.tabpage_4.dw_4.find( "id_arsp = " + string(kst_tab_arfa.id_arsp) , 1, tab_1.tabpage_4.dw_4.rowcount() ) > 0 then
//				k_return = true
//			end if
//		else		
//			if tab_1.tabpage_4.dw_4.find( "id_armo = " + string(kst_tab_arfa.id_armo) , 1, tab_1.tabpage_4.dw_4.rowcount() ) > 0 then
//				k_return = true
//			end if
//		end if		
//	end if

		
return k_return 	


end function

private subroutine riempi_dw_riga (long k_riga, readonly st_tab_wm_pklist_righe kst_tab_wm_pklist_righe);//
//--- Valorizza nella dw_riga i campi dalla st_tab_
//


	dw_riga.setitem(k_riga, "id_wm_pklist_riga"  ,kst_tab_wm_pklist_righe.id_wm_pklist_riga )
	dw_riga.setitem(k_riga, "wm_pklist_idpkl"  ,trim(tab_1.tabpage_1.dw_1.getitemstring(1, "idpkl")))
	dw_riga.setitem(k_riga, "id_wm_pklist"  ,kst_tab_wm_pklist_righe.id_wm_pklist )
	dw_riga.setitem(k_riga, "stato"  ,kst_tab_wm_pklist_righe.stato )
	dw_riga.setitem(k_riga, "idart_clie"  ,trim(kst_tab_wm_pklist_righe.idart_clie ))
	dw_riga.setitem(k_riga, "idlotto_clie"  ,trim(kst_tab_wm_pklist_righe.idlotto_clie) )
	dw_riga.setitem(k_riga, "areamag"  ,trim(kst_tab_wm_pklist_righe.areamag ))
	dw_riga.setitem(k_riga, "id_meca" , kst_tab_wm_pklist_righe.id_meca )
	dw_riga.setitem(k_riga, "id_armo"  ,kst_tab_wm_pklist_righe.id_armo )
	dw_riga.setitem(k_riga, "gruppo"  ,kst_tab_wm_pklist_righe.gruppo )
	dw_riga.setitem(k_riga, "colli"  ,kst_tab_wm_pklist_righe.colli )
	dw_riga.setitem(k_riga, "wm_barcode"  ,trim(kst_tab_wm_pklist_righe.wm_barcode ))
	dw_riga.setitem(k_riga, "barcode"  ,trim(kst_tab_wm_pklist_righe.barcode ))
	dw_riga.setitem(k_riga, "eliminato"  ,kst_tab_wm_pklist_righe.eliminato )
	dw_riga.setitem(k_riga, "idpezzo_clie"  ,kst_tab_wm_pklist_righe.idpezzo_clie )
	dw_riga.setitem(k_riga, "qtapezzi_pallet"  ,kst_tab_wm_pklist_righe.qtapezzi_pallet )
	dw_riga.setitem(k_riga, "x_datins"  ,kst_tab_wm_pklist_righe.x_datins )
	dw_riga.setitem(k_riga, "x_utente"  ,kst_tab_wm_pklist_righe.x_utente )
	dw_riga.setitem(k_riga, "x_datins_elim"  ,kst_tab_wm_pklist_righe.x_datins_elim )
	dw_riga.setitem(k_riga, "x_utente_elim"  ,kst_tab_wm_pklist_righe.x_utente_elim )
	
end subroutine

private subroutine riempi_st_tab_wm_pklist_da_dw1 (long k_riga, ref st_tab_wm_pklist kst_tab_wm_pklist);//
		
		kst_tab_wm_pklist.id_wm_pklist = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_wm_pklist")
		kst_tab_wm_pklist.colliddt = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "colliddt")
		kst_tab_wm_pklist.collipkl = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "collipkl")
		kst_tab_wm_pklist.clie_1 = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "clie_1")
		kst_tab_wm_pklist.clie_2 = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "clie_2")
		kst_tab_wm_pklist.clie_3 = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "clie_3")

		kst_tab_wm_pklist.dtimportazione = tab_1.tabpage_1.dw_1.getitemdatetime(k_riga, "dtimportazione")
		kst_tab_wm_pklist.dtord = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "dtord")
		kst_tab_wm_pklist.dtddt = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "dtddt")
		
		kst_tab_wm_pklist.idpkl = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "idpkl")
		kst_tab_wm_pklist.stato = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "stato")
		kst_tab_wm_pklist.nrord = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "nrord")
		kst_tab_wm_pklist.nrddt = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "nrddt")
		kst_tab_wm_pklist.mc_co = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "mc_co")
		kst_tab_wm_pklist.sc_cf = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "sc_cf")
		kst_tab_wm_pklist.eliminato = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "eliminato")
		
		kst_tab_wm_pklist.packinglistcode = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "packinglistcode")
		kst_tab_wm_pklist.id_wm_pklist_padre = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_wm_pklist_padre")
		
		kst_tab_wm_pklist.x_datins = tab_1.tabpage_1.dw_1.getitemdatetime(k_riga, "x_datins")
		kst_tab_wm_pklist.x_utente = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "x_utente")
		kst_tab_wm_pklist.x_datins_elim = tab_1.tabpage_1.dw_1.getitemdatetime(k_riga, "x_datins_elim")
		kst_tab_wm_pklist.x_utente_elim = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "x_utente_elim")

		kiuf_wm_pklist_testa.if_isnull( kst_tab_wm_pklist )
	
		

end subroutine

private subroutine put_video_gruppo_dw_riga (st_tab_gru kst_tab_gru);//
//--- Visualizza dati Gruppo 
//
st_esito kst_esito



dw_riga.modify( "gruppo.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
dw_riga.setitem( 1, "gruppo", kst_tab_gru.codice )
dw_riga.modify( "gruppo_1.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
dw_riga.setitem( 1, "gruppo_1", trim(kst_tab_gru.des) )


attiva_tasti()


end subroutine

private subroutine put_video_cliente (st_tab_clienti kst_tab_clienti, string k_tipo);//
//--- Visualizza dati Cliente 
//
st_esito kst_esito


if k_tipo = "clie_1" or  k_tipo = "rag_soc_10" then
	tab_1.tabpage_1.dw_1.modify( "clie_1.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
	tab_1.tabpage_1.dw_1.setitem( 1, "clie_1", kst_tab_clienti.codice )
	tab_1.tabpage_1.dw_1.modify( "rag_soc_10.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
	tab_1.tabpage_1.dw_1.setitem( 1, "rag_soc_10", trim(kst_tab_clienti.rag_soc_10) )
else
	if k_tipo = "clie_2" or  k_tipo = "rag_soc_10_1" then
		tab_1.tabpage_1.dw_1.modify( "clie_2.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
		tab_1.tabpage_1.dw_1.setitem( 1, "clie_2", kst_tab_clienti.codice )
		tab_1.tabpage_1.dw_1.modify( "rag_soc_10_1.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
		tab_1.tabpage_1.dw_1.setitem( 1, "rag_soc_10_1", trim(kst_tab_clienti.rag_soc_10) )
	else
		if k_tipo = "clie_3" or  k_tipo = "rag_soc_10_2" then
			tab_1.tabpage_1.dw_1.modify( "clie_3.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
			tab_1.tabpage_1.dw_1.setitem( 1, "clie_3", kst_tab_clienti.codice )
			tab_1.tabpage_1.dw_1.modify( "rag_soc_10_2.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
			tab_1.tabpage_1.dw_1.setitem( 1, "rag_soc_10_2", trim(kst_tab_clienti.rag_soc_10) )
		end if
	end if
end if

attiva_tasti()


end subroutine

private subroutine importa_pklist ();//---
//---  Carica il Packing-List sul Lotto di Magazzino (Riferimento)
//---
string k_aggiornato
kuf_armo_inout kuf1_armo_inout
st_tab_wm_pklist kst_tab_wm_pklist
st_tab_meca kst_tab_meca
st_esito kst_esito
st_tab_g_0 kst_tab_g_0
kuf_armo kuf1_armo


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
 
	if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then	
		
		kst_tab_wm_pklist.id_wm_pklist = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_wm_pklist")
		if kst_tab_wm_pklist.id_wm_pklist > 0 then
			
			kst_tab_wm_pklist.idpkl = trim(tab_1.tabpage_1.dw_1.getitemstring(1, "idpkl"))
			if len(trim(kst_tab_wm_pklist.idpkl)) = 0 then kst_tab_wm_pklist.idpkl= string(kst_tab_wm_pklist.id_wm_pklist)
			
			if messagebox("Importa Packing-List come Nuovo Lotto", & 
				"Generare il nuovo Lotto da questa Packing-List '" + kst_tab_wm_pklist.idpkl + "'?~n~r" &
				+ "Durante l'importazione saranno aggiornati anche i dati del Packing-List" &
				, question!, yesno!, 2) = 1 then
						
				try
					
					k_aggiornato = aggiorna_dati()  //  prima di tutto AGGIORNA i dati della PKL
					if left(k_aggiornato, 1) <> "0" then
						kst_esito.esito = kkg_esito.no_esecuzione
						kst_esito.sqlcode = integer(left(k_aggiornato, 1))
						kst_esito.sqlerrtext = mid(k_aggiornato, 2)
						kguo_exception.inizializza( )
						kguo_exception.set_esito(kst_esito)
						throw kguo_exception
					end if
					
					k_aggiornato = check_dati_x_importa()  //  Controlla dati della PKL x Importazione
					if left(k_aggiornato, 1) <> "0" and left(k_aggiornato, 1) <> "4" and left(k_aggiornato, 1) <> "5" then
						kst_esito.esito = kkg_esito.no_esecuzione
						kst_esito.sqlcode = integer(left(k_aggiornato, 1))
						kst_esito.sqlerrtext = mid(k_aggiornato, 2)
						kguo_exception.inizializza( )
						kguo_exception.set_esito(kst_esito)
						throw kguo_exception
					else
						if left(k_aggiornato, 1) <> "0" then
							if messagebox("Importa Packing-List come Nuovo Lotto", & 
												"Attenzione ai seguenti errore NON bloccanti~n~r" &
												+ trim(mid(k_aggiornato, 2)) &
												+ "Proseguire comunque?" &
												, question!, yesno!, 2) = 2 then
								kst_esito.esito = kkg_esito.no_esecuzione
								kst_esito.sqlerrtext = "Operazione interrotta dall'utente"
								kguo_exception.inizializza( )
								kguo_exception.set_esito(kst_esito)
								throw kguo_exception
							end if
						end if
					end if
					
//--- controllo se è presente almeno un Contratto-E1 
					u_set_k_e1litm_ok()   // verifica se c'è almeno un Contratto-E1 è attivo su Listino
					if tab_1.tabpage_1.dw_1.getitemstring(1, "k_e1litm_ok") = "1" then
					else
						if messagebox("Importa Packing-List come Nuovo Lotto", & 
											"Attenzione nessun CONTRATTO-E1 attivo in archivio, il documento ASN su E1 non verrà generato!!~n~r" &
											+ "Proseguire comunque?" &
											, question!, yesno!, 2) = 2 then
							kst_esito.esito = kkg_esito.no_esecuzione
							kst_esito.sqlerrtext = "Operazione interrotta dall'utente"
							kguo_exception.inizializza( )
							kguo_exception.set_esito(kst_esito)
							throw kguo_exception
						end if
					end if

//--- GENERA IL NUOVO RIFERIMENTO									
					kuf1_armo_inout = create kuf_armo_inout 
					kst_tab_meca.id = kuf1_armo_inout.importa_wm_pklist(kst_tab_wm_pklist)

//---- azzera il flag delle modifiche
					tab_1.tabpage_1.dw_1.ResetUpdate ( ) 
					tab_1.tabpage_4.dw_4.ResetUpdate ( ) 

//--- lancia l'applicazione per Aggiornare il Riferimento
					if kst_tab_meca.id > 0 then
//05082014 disattivo la richiesta x volontà della Frignani		
//						if messagebox("Nuovo Lotto", & 
//								"Vuoi aprire il nuovo Lotto prodotta da questa Packing-List (id lotto = " + string(kst_tab_meca.id) + ") ?", question!, yesno!, 2) = 1 then
						kuf1_armo = create kuf_armo
						kst_tab_g_0.id = kst_tab_meca.id
						kuf1_armo.u_open_applicazione(kst_tab_g_0, kkg_flag_modalita.modifica )
					end if

//--- funzione utile alla sincronizzazione con la window di ritorno (come il navigatore)
					kiuf1_sync_window.u_window_set_funzione_aggiornata(ki_st_open_w)

//--- se tutto OK chiude ila Window					
					cb_ritorna.triggerevent( clicked!)
			
				catch (uo_exception kuo_exception)
					kst_esito = kuo_exception.get_st_esito()
//---- Imposta le Note descrittive dell'anomalia		
					kst_tab_wm_pklist.note = "Anomalie durante Importazione nel Lotto: " + trim(kst_esito.sqlerrtext) 
					kiuf_wm_pklist_testa.set_add_note(kst_tab_wm_pklist)

					kuo_exception.messaggio_utente( ) 
					
				finally
					if isvalid(kuf1_armo_inout) then destroy kuf1_armo_inout
				end try
			end if
		end if
	end if


end subroutine

private subroutine importa_pklist_ext ();//---
//---  Crea da file xml il nuovo Packing-List 
//---
int k_ret=0, k_ctr=0
string k_PathFile, k_Path, k_File
kuf_wm_pklist_inout kuf1_wm_pklist_inout
kuf_wm_pklist_cfg kuf1_wm_pklist_cfg
st_tab_wm_pklist kst_tab_wm_pklist
st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg
st_esito kst_esito


try
	
	kuf1_wm_pklist_cfg = create kuf_wm_pklist_cfg
	kuf1_wm_pklist_inout = create kuf_wm_pklist_inout
	
	kuf1_wm_pklist_cfg.get_wm_pklist_cfg( kst_tab_wm_pklist_cfg)
 
	if kst_tab_wm_pklist_cfg.blocca_importa = kuf1_wm_pklist_cfg.ki_blocca_importa_si then	
		kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_dati_non_eseguito )
		kguo_exception.setmessage( "BLOCCATA importazione da WMF (vedi Archivio Impostazioni WMF) - L'operazione non può proseguire. ")
		kGuo_exception.messaggio_utente( ) 
	else	
	

		if messagebox("Richiesta Produzione Nuovi Packing-List", & 
			"Vuoi importare i nuovi Packing-List entrati a Magazzino? ~n~r" , &
			question!, yesno!, 2) = 1 then

//--- prima salva poi parte l'importa						
			cb_aggiorna.event clicked( )
					
			k_ctr = kuf1_wm_pklist_inout.importa_wm_pklist_ext_tutti() 

			if k_ctr > 0 then
				
//--- funzione utile alla sincronizzazione con la window di ritorno (come il navigatore)
				kiuf1_sync_window.u_window_set_funzione_aggiornata(ki_st_open_w)

//--- Visualizzo il Packing appena creato					
				tab_1.tabpage_1.dw_1.reset( )
				ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica
				kiuf_wm_pklist_testa.get_ultimo_doc_ins(kst_tab_wm_pklist)
				ki_st_open_w.key1= string(kst_tab_wm_pklist.id_wm_pklist)
				inizializza()
				
			end if
		end if
		
	end if
					
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	kuo_exception.messaggio_utente( ) 
	
finally
	destroy kuf1_wm_pklist_cfg
	destroy kuf_wm_pklist_inout
	
end try

end subroutine

private subroutine call_m_r_f ();//
//--- Fa l'elenco Anagrafiche per il Mandante indicato
//
st_tab_wm_pklist kist_tab_wm_pklist
st_tab_clienti kst_tab_clienti


SetPointer(kkg.pointer_attesa)


	kist_tab_wm_pklist.clie_1 = tab_1.tabpage_1.dw_1.getitemnumber( 1, "clie_1")
	if kist_tab_wm_pklist.clie_1 > 0 then
		kst_tab_clienti.codice = kist_tab_wm_pklist.clie_1
		kiuf_clienti.elenco_m_r_f_3( kst_tab_clienti )
	end if
						
SetPointer(kkg.pointer_default)

	



		
		
		


end subroutine

private subroutine call_elenco_contratti ();//
//--- Fa l'elenco Contratti Attivi x Cliente
//
st_tab_contratti kst_tab_contratti


SetPointer(kkg.pointer_attesa )


	kst_tab_contratti.cod_cli = tab_1.tabpage_1.dw_1.getitemnumber( 1, "clie_3")
	if kst_tab_contratti.cod_cli > 0 then
		if kiuf_contratti.elenco_contratti_attivi_cliente( kst_tab_contratti ) > 0 then
		else
			messagebox("Elenco Contratti", "Nessun contratto disponibile per il cliente "+ string(kst_tab_contratti.cod_cli) )
		end if
	else
		messagebox("Elenco Contratti", "Manca il Cliente, scegliere prima l'anagrafica di fatturazione "+ string(kst_tab_contratti.cod_cli) )
	end if
						
SetPointer(kkg.pointer_default)

	



		
		
		


end subroutine

public subroutine u_set_k_e1litm_ok ();//
int k_nr_e1litm 
st_esito kst_esito
kuf_contratti kuf1_contratti
kuf_listino kuf1_listino
st_tab_listino kst_tab_listino
st_tab_contratti kst_tab_contratti


try
	

	kst_tab_listino.contratto = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_contratto")
	if kst_tab_listino.contratto > 0 then
	else
		kuf1_contratti = create kuf_contratti
		kst_tab_contratti.mc_co = trim(tab_1.tabpage_1.dw_1.getitemstring(1, "mc_co"))
		kst_tab_contratti.sc_cf = trim(tab_1.tabpage_1.dw_1.getitemstring(1, "sc_cf"))
		kst_tab_listino.contratto = kuf1_contratti.get_contratto_da_cf_co(kst_tab_contratti)
	end if
	if kst_tab_listino.contratto > 0 then
		tab_1.tabpage_1.dw_1.setitem(1, "id_contratto", kst_tab_listino.contratto) 
		kuf1_listino = create kuf_listino
		k_nr_e1litm = kuf1_listino.if_e1litm_x_contratto (kst_tab_listino)
	end if
	if k_nr_e1litm > 0 then
		tab_1.tabpage_1.dw_1.setitem(1, "k_e1litm_ok", "1") 
	else
		tab_1.tabpage_1.dw_1.setitem(1, "k_e1litm_ok", "0") 
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	

finally
	if isvalid(kuf1_listino) then destroy kuf1_listino
	if isvalid(kuf1_contratti) then destroy kuf1_contratti
	
end try



end subroutine

private subroutine u_duplica_pklist ();//---
//---  Duplica questo Packing-List 
//---
long k_ctr=0
kuf_wm_pklist_inout kuf1_wm_pklist_inout
st_tab_wm_pklist kst_tab_wm_pklist
st_esito kst_esito


try
	
	kuf1_wm_pklist_inout = create kuf_wm_pklist_inout

	ki_aggiorna_richiesta_conferma = false  // evita la richiesta della conferma, salva automaticamente

	if messagebox("Duplicazione del Packing-List", & 
			"Vuoi generare un nuovo Packing-List identico e collegato a questo?", question!, yesno!, 2) = 1 then  //~n~r

//--- prima salva e se OK allora poi parte la duplica						
		if left(aggiorna_dati(),1) = "0" then
					
			kst_tab_wm_pklist.id_wm_pklist = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_wm_pklist")
			
			k_ctr = kuf1_wm_pklist_inout.u_duplica_pklist(kst_tab_wm_pklist, "") 
	
			if k_ctr > 0 then
				kst_tab_wm_pklist.id_wm_pklist = k_ctr
					
	//--- funzione utile alla sincronizzazione con la window di ritorno (come il navigatore)
				kiuf1_sync_window.u_window_set_funzione_aggiornata(ki_st_open_w)
	
	//--- Resetta vecchi pannelli e visualizza il Packing appena creato	
				tab_1.tabpage_1.dw_1.reset()
				tab_1.tabpage_4.dw_4.reset( )
				tab_1.tabpage_5.dw_5.reset()
				ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica
				ki_st_open_w.key1= string(kst_tab_wm_pklist.id_wm_pklist)
				inizializza()
				messagebox("Packing-List Duplicato", & 
					"Generato il nuovo Paking-List '"+ trim(tab_1.tabpage_1.dw_1.getitemstring(1, "idpkl")) &
					+"' (id "+ ki_st_open_w.key1 +")", information!)
			end if
		end if
		
	end if
					
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	kuo_exception.messaggio_utente( ) 
	
finally
	ki_aggiorna_richiesta_conferma = true
	if isvalid(kuf_wm_pklist_inout) then destroy kuf_wm_pklist_inout
	
end try

end subroutine

protected subroutine inizializza_4 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 5 controllandone i valori se gia' presenti
//======================================================================
//
st_tab_wm_pklist_righe kst_tab_wm_pklist_righe


kst_tab_wm_pklist_righe.id_wm_pklist  = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_wm_pklist")  

if kst_tab_wm_pklist_righe.id_wm_pklist  > 0 then

	if tab_1.tabpage_5.dw_5.rowcount() < 1 then

		tab_1.tabpage_5.dw_5.retrieve(kst_tab_wm_pklist_righe.id_wm_pklist ) 
		
	end if

//---- azzera il flag delle modifiche
	tab_1.tabpage_5.dw_5.SetItemStatus( 1, 0, Primary!, NotModified!)

else

//	inserisci()
	
end if

tab_1.tabpage_5.dw_5.setfocus()

attiva_tasti()
	

end subroutine

public subroutine u_modifica_barcode ();//

dw_barcode.event u_modifica( )



end subroutine

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

	if tab_1.tabpage_1.dw_1.getitemnumber(1, "id_wm_pklist") > 0 then
		tab_1.tabpage_4.enabled = true
	end if
	
	choose case tab_1.selectedtab
		case 1
			cb_aggiorna.enabled = true
			cb_inserisci.enabled = false
		case 4 //righe
			if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then
				cb_inserisci.enabled = true
			end if
			if tab_1.tabpage_4.dw_4.rowcount( ) > 0 then
				cb_modifica.enabled = true
				cb_visualizza.enabled = true
				cb_cancella.enabled = true
			end if
//		case 4
//			if ki_st_open_w.flag_modalita <> kkg_flag_modalita.inserimento then
//				cb_modifica.enabled = true
//				cb_inserisci.enabled = true
//				cb_aggiorna.enabled = true
//				cb_cancella.enabled = true
//			end if
	end choose

else
	
	cb_inserisci.enabled = true
	cb_inserisci.default = true
	
end if

if ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione &
   or ki_st_open_w.flag_modalita = kkg_flag_modalita.cancellazione then
	cb_inserisci.enabled = false
	cb_aggiorna.enabled = false
	cb_cancella.enabled = false
	cb_modifica.enabled = false
end if



end subroutine

protected function string check_dati_x_importa ();//
//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK ma errore non grave
//===                : 5=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================

string k_return = " "
string k_errore = "0"
long k_nr_righe
int k_riga, k_ctr
int k_nr_errori 
date k_data_scad_sf_cf, k_data_pkl
kuf_armo kuf1_armo
kuf_listino kuf1_listino
st_esito kst_esito
st_tab_wm_pklist kst_tab_wm_pklist, kst_tab_wm_pklist_altro
st_tab_wm_pklist_righe kst_tab_wm_pklist_righe
st_tab_contratti kst_tab_contratti
st_tab_meca kst_tab_meca
st_tab_listino kst_tab_listino[]



//=== Controllo il primo tab
	k_nr_righe = tab_1.tabpage_1.dw_1.rowcount()
	k_nr_errori = 0
	k_riga = 1
	this.riempi_st_tab_wm_pklist_da_dw1( k_riga, kst_tab_wm_pklist)

	if kst_tab_wm_pklist.clie_1 = 0 then
		k_return = tab_1.tabpage_1.text + ": Manca il codice Mandante " + "~n~r" 
		k_errore = "3"
		k_nr_errori++
	end if

//--- controllo se PK-LIST già caricato		
	if k_errore = "0" or k_errore = "4" or k_errore = "5" then
		
		try
			kst_tab_wm_pklist.idpkl = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "idpkl")
			if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento &
					or kist_tab_wm_pklist_orig.idpkl <> kst_tab_wm_pklist.idpkl then
			
			
				kst_tab_wm_pklist_altro.id_wm_pklist = kiuf_wm_pklist_testa.get_id_wm_pklist_altro(kst_tab_wm_pklist)

				if kst_tab_wm_pklist_altro.id_wm_pklist > 0 then
					kuf1_armo = create kuf_armo
					kst_tab_meca.id_wm_pklist = kst_tab_wm_pklist_altro.id_wm_pklist
					kuf1_armo.get_id_da_id_wm_pklist(kst_tab_meca)
					if kst_tab_meca.id > 0 then
						kuf1_armo.get_dati_rid(kst_tab_meca)
					end if
				end if
				
				if kiuf_wm_pklist_testa.if_esiste( kst_tab_wm_pklist ) then
					k_errore = "1"
					k_nr_errori++

					k_return = tab_1.tabpage_1.text + ": Packing List '" + trim(kst_tab_wm_pklist.idpkl) + "' già caricato con lo stesso Codice, vedi id " &
					                        + string(kst_tab_wm_pklist_altro.id_wm_pklist) 
					
					if kst_tab_meca.id > 0 then
						k_return += "~n~rLotto n. " + string(kst_tab_meca.num_int) + " del " + string(kst_tab_meca.data_int, "dd mmm yyyy") 
						if date(kst_tab_meca.data_ent) > kkg.data_zero then
							k_return += " entrato il " + string(kst_tab_meca.data_ent, "dd mmm yy")
						else
							k_return +=  " non ancora entrato. "
						end if
						if kuf1_armo.if_lotto_chiuso(kst_tab_meca) then
							k_return += "~n~rLotto CHIUSO o ANNULLATO, per proseguire Eliminare il Packing-List indicato." 
						else
							k_return += "~n~rPer proseguire ANNULLARE il Lotto ed Eliminare il Packing-List indicato."
						end if
					else
						k_return += "~n~rNessun Lotto associato è stato trovato, per proseguire Eliminare prima il Packing-List indicato." 
					end if
				else
					if kst_tab_wm_pklist_altro.id_wm_pklist > 0 and kst_tab_meca.id > 0 then
						k_return += "ATTENZIONE Lotto n. " + string(kst_tab_meca.num_int) + " del " + string(kst_tab_meca.data_int, "dd mmm yyyy") 
						if date(kst_tab_meca.data_ent) > kkg.data_zero then
							k_return += " entrato il " + string(kst_tab_meca.data_ent, "dd mmm yy")
						else
							k_return +=  " non ancora entrato. "
						end if
						if kuf1_armo.if_lotto_chiuso(kst_tab_meca) then
							k_return += "~n~rLotto CHIUSO o ANNULLATO." 
							k_errore = "4"
						else
							k_return += "~n~rPer proseguire ANNULLARE il Lotto."
							k_errore = "1"
							k_nr_errori++
						end if
					end if
				end if
			end if

		catch (uo_exception kuo_exception1)
				kst_esito = kuo_exception1.get_st_esito()
				k_return += tab_1.tabpage_1.text + ": Errore DB-1: '" + string(kst_esito.sqlcode) +" - "+ trim(kst_esito.sqlerrtext) + "'~n~r" 
				k_errore = "1"
				k_nr_errori++
			
		finally
			if isvalid(kuf1_armo) then destroy kuf1_armo
			
		end try
		
	end if

//--- controllo Contratti
	if k_errore = "0" or k_errore = "4" or k_errore = "5" then
		try

			k_data_pkl = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "dtord")

//--- controllo CO 
			if trim(kst_tab_wm_pklist.mc_co) > " " then
				kst_tab_contratti.mc_co = trim(kst_tab_wm_pklist.mc_co)
				if not kiuf_contratti.if_esiste_mc_co(kst_tab_contratti) then
					k_return = tab_1.tabpage_1.text + " - " + trim(tab_1.tabpage_1.dw_1.object.mc_co_t.text)+ " " + trim(kst_tab_contratti.mc_co) + " non Trovato " +  "~n~r" 
					k_errore = "1"
					k_nr_errori++
				end if
			else
				kst_tab_wm_pklist.mc_co = ""
			end if
			
//--- controllo CF
			if trim(kst_tab_wm_pklist.sc_cf) > " " then
				kst_tab_contratti.sc_cf = trim(kst_tab_wm_pklist.sc_cf)
				if not kiuf_contratti.if_esiste_sc_cf(kst_tab_contratti) then
					k_return = tab_1.tabpage_1.text + " - " + trim(tab_1.tabpage_1.dw_1.object.sc_cf_t.text) + " " + trim(kst_tab_contratti.sc_cf) + " Capitolato " + trim(kst_tab_contratti.sc_cf) + " non Trovato " + "~n~r" 
					k_errore = "1"
					k_nr_errori++
				else
					k_data_scad_sf_cf = kiuf_contratti.get_data_scad_sc_cf(kst_tab_contratti)
					if k_data_scad_sf_cf < k_data_pkl then
						k_return = tab_1.tabpage_1.text + " - " + trim(tab_1.tabpage_1.dw_1.object.sc_cf_t.text) + " " + trim(kst_tab_contratti.sc_cf) + " Capitolato " + trim(kst_tab_contratti.sc_cf) &
											+ " Scaduto il " + string(k_data_scad_sf_cf) + ". Data di confronto " + string(k_data_pkl) + "~n~r" 
						k_errore = "1"
						k_nr_errori++
					end if
				end if
			else
				kst_tab_contratti.sc_cf = ""
			end if

//--- Controllo Contratto periodo	
			if k_errore = "0" or k_errore = "4" or k_errore = "5" then
				if trim(kst_tab_wm_pklist.mc_co) > " " then
					kst_tab_contratti.cod_cli = kst_tab_wm_pklist.clie_3 
					kst_esito = kiuf_contratti.get_codice_da_cf_co(kst_tab_contratti)   // get del codice esatto del contratto
					if kst_esito.esito <> kkg_esito.ok then
						if kst_esito.esito = kkg_esito.err_logico then
							k_return = tab_1.tabpage_1.text + " - " + trim(tab_1.tabpage_1.dw_1.object.sc_cf_t.text) + " " + trim(kst_tab_contratti.sc_cf) + " Più di un Contratto " + trim(kst_tab_contratti.mc_co) &
											+ " + cf = '" + trim(kst_tab_contratti.sc_cf) + "' presente in archivio~n~r" + kst_esito.sqlerrtext
						else
							k_return = tab_1.tabpage_1.text + " - " + trim(tab_1.tabpage_1.dw_1.object.sc_cf_t.text) + " " + trim(kst_tab_contratti.sc_cf) + " Contratto " + trim(kst_tab_contratti.mc_co) &
											+ " + cf = '" + trim(kst_tab_contratti.sc_cf) + "', non Trovato in archivio~n~r" 
						end if
						k_errore = "1"
						k_nr_errori++
					else
						kiuf_contratti.get_data_scad(kst_tab_contratti)
						if k_data_pkl > kst_tab_contratti.data_scad or k_data_pkl < kst_tab_contratti.data then
							k_return = tab_1.tabpage_1.text + " - " + trim(tab_1.tabpage_1.dw_1.object.sc_cf_t.text) + " " + trim(kst_tab_contratti.sc_cf) + " Contratto " + trim(kst_tab_contratti.sc_cf) &
											+ " + cf = '" + trim(kst_tab_contratti.sc_cf) + "', non valido~n~r" &
											+ "data del pk.list " + string(k_data_pkl) + " oltre il periodo " + string(kst_tab_contratti.data) + "-" + string(kst_tab_contratti.data_scad) + "~n~r" 
							k_errore = "1"
							k_nr_errori++
						end if
					end if
				end if
			end if	
			
//--- controllo se è presente il Contratto-E1 su Listino 
			if k_errore = "0" or k_errore = "4" or k_errore = "5" then
				if kst_tab_wm_pklist.clie_3  > 0 and kst_tab_contratti.codice > 0 then
					kuf1_listino = create kuf_listino			
					kst_tab_listino[1].cod_cli = kst_tab_wm_pklist.clie_3 
					kst_tab_listino[1].contratto = kst_tab_contratti.codice 
					kuf1_listino.get_id_listini(kst_tab_listino[])  // get id listino
					kst_tab_listino[1].e1litm = kuf1_listino.get_e1litm(kst_tab_listino[1])   // get del contratto E1
					
					if trim(kst_tab_listino[1].e1litm) > " " then // verifica se c'è il Contratto-E1 su Listino
					else
						k_return = tab_1.tabpage_1.text + ": Attenzione listino senza Contratto-E1, il documento ASN su E1 non può essere generato!!~n~r" 
						k_errore = "5"
						k_nr_errori++
					end if
			
				end if
			end if
			
		catch (uo_exception kuo_exception2)
				kst_esito = kuo_exception2.get_st_esito()
				k_return += tab_1.tabpage_1.text + ": Errore DB-1: '" + string(kst_esito.sqlcode) +" - "+ trim(kst_esito.sqlerrtext) + "'~n~r" 
				k_errore = "1"
				k_nr_errori++
			
			
		finally
			if isvalid(kuf1_listino) then destroy kuf1_listino			
			
		end try
	end if
	
	
//=== Controllo altro tab
	if k_errore = "0" or k_errore = "4" or k_errore = "5" then

//--- verifica se ci sono righe di dettaglio		
		k_nr_righe = tab_1.tabpage_4.dw_4.rowcount()
		if k_nr_righe = 0 then
			
			if kst_tab_wm_pklist.id_wm_pklist > 0 then
				 tab_1.tabpage_4.dw_4.retrieve(kst_tab_wm_pklist.id_wm_pklist)
			end if
			k_nr_righe = tab_1.tabpage_4.dw_4.rowcount()
			if k_nr_righe = 0 then
				k_return = tab_1.tabpage_1.text + ": Non ci sono righe caricate x questo documento " + "~n~r" 
				k_errore = "3"
				k_nr_errori++
			end if
		end if
	end if


	if k_errore = "0" or k_errore = "4" or k_errore = "5" then
		
		try 
			
			k_riga = tab_1.tabpage_4.dw_4.getnextmodified(0, primary!)
		
			do while k_riga > 0  and k_nr_errori < 10
		
				if k_nr_errori < 9 then // per non uscire da check senza contr.eventuali eltri errori gravi 
				
					this.riempi_st_tab_wm_pklist_righe_da_dw4(k_riga, kst_tab_wm_pklist_righe)
					
//--- Controllo Numero COLLI			
					if kst_tab_wm_pklist_righe.colli = 0 or isnull(kst_tab_wm_pklist_righe.colli )  then 
						k_return = trim(k_return) + tab_1.tabpage_4.text + ": Manca il numero Colli alla riga "+ string(k_riga, "#####") +  + "~n~r" 
						k_errore = "3"
						k_nr_errori++
					end if
				end if
				
				k_riga++
		
				k_riga = tab_1.tabpage_4.dw_4.getnextmodified(k_riga, primary!)
		
			loop
			
		catch (uo_exception kuo1_exception)
				kst_esito = kuo1_exception.get_st_esito()
				k_return += tab_1.tabpage_1.text + ": Errore DB-6: '" + string(kst_esito.sqlcode) +" - "+ trim(kst_esito.sqlerrtext) + "'~n~r" 
				k_errore = "1"
				k_nr_errori++
			
		finally

		end try
		
	end if

//--- contollo numero colli messo in testata con quello nelle righe
	if k_errore = "0" or k_errore = "4" or k_errore = "5" then
		if tab_1.tabpage_4.dw_4.rowcount( ) > 0 then
			kst_tab_wm_pklist_righe.colli = 0
			for k_riga=1 to tab_1.tabpage_4.dw_4.rowcount( )
				kst_tab_wm_pklist_righe.colli += tab_1.tabpage_4.dw_4.getitemnumber( k_riga, "colli")
			next
			
			if kst_tab_wm_pklist.collipkl > 0 then
				if kst_tab_wm_pklist.colliddt <> kst_tab_wm_pklist_righe.colli then
					k_return += tab_1.tabpage_4.text + ": Totale Colli righe ( "+ string(kst_tab_wm_pklist_righe.colli) &
					                   + " ) diverso dal n.Colli bolla (" + string(kst_tab_wm_pklist.colliddt ) + ") indicato; " +  " ~n~r" 
					k_errore = "4"
 					k_nr_errori++
				end if
			else
				tab_1.tabpage_4.dw_4.setitem( k_riga, "colli", kst_tab_wm_pklist_righe.colli)
			end if
		end if
	end if
		


//
return k_errore + k_return


end function

on w_wm_pklist.create
int iCurrent
call super::create
this.dw_x_copia=create dw_x_copia
this.dw_riga=create dw_riga
this.dw_barcode=create dw_barcode
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_x_copia
this.Control[iCurrent+2]=this.dw_riga
this.Control[iCurrent+3]=this.dw_barcode
end on

on w_wm_pklist.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_x_copia)
destroy(this.dw_riga)
destroy(this.dw_barcode)
end on

event close;call super::close;//
//if isvalid(kiuf_clienti) then destroy kiuf_clienti
if isvalid(kiuf_wm_pklist_testa) then destroy kiuf_wm_pklist_testa
if isvalid(kiuf_wm_pklist_righe  ) then destroy kiuf_wm_pklist_righe  
if isvalid(kiuf_clienti  ) then destroy kiuf_clienti
if isvalid(kiuf_contratti  ) then destroy kiuf_contratti



end event

event u_ricevi_da_elenco;call super::u_ricevi_da_elenco;//
//
int k_rc
long  k_riga, k_ind_selected, k_righe



if isvalid(kst_open_w) then

	if not isvalid(kdsi_elenco_input) then kdsi_elenco_input = create datastore
	
	if long(kst_open_w.key3) > 0 then 

		kdsi_elenco_input = kst_open_w.key12_any 
		k_riga = long(kst_open_w.key3)

//=== Valorizza l'oggetto DW per passarli all'evento di DROP
		dw_x_copia.dataobject = kdsi_elenco_input.dataobject
		k_righe = kdsi_elenco_input.rowcount()
		k_rc = kdsi_elenco_input.rowscopy(1,k_righe, Primary!, dw_x_copia,1, Primary! )
//---- valorizza i selezionati
		k_ind_selected = kdsi_elenco_input.getselectedrow( 0 )
		do while k_ind_selected > 0 
						
			dw_x_copia.selectrow( k_ind_selected, true)			
		
			k_ind_selected = kdsi_elenco_input.getselectedrow( (k_ind_selected) )
			
		loop
		
		this.dragdrop_dw_esterna( dw_x_copia, k_riga )
		
		kdsi_elenco_input.selectrow( 0, false)
		
	end if
end if


attiva_tasti()



end event

type st_ritorna from w_g_tab_3`st_ritorna within w_wm_pklist
integer y = 1808
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_wm_pklist
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_wm_pklist
integer y = 1804
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_wm_pklist
integer y = 1640
end type

type st_stampa from w_g_tab_3`st_stampa within w_wm_pklist
integer y = 1732
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_wm_pklist
integer y = 1612
end type

event cb_visualizza::clicked;//


	choose case tab_1.selectedtab
		case 1
		case 2 
		case 4
			if tab_1.tabpage_4.dw_4.getselectedrow(0) > 0 then
				riga_modifica()		
				dw_riga.triggerevent( "u_visualizza")
			end if
			
	end choose



end event

type cb_modifica from w_g_tab_3`cb_modifica within w_wm_pklist
integer y = 1708
end type

event cb_modifica::clicked;//


	choose case tab_1.selectedtab
		case 1
		case 2 
		case 4
			if tab_1.tabpage_4.dw_4.getselectedrow(0) > 0 then
				riga_modifica()		
			end if
			
	end choose



end event

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_wm_pklist
integer y = 1708
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_wm_pklist
integer y = 1708
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_wm_pklist
integer y = 1708
integer height = 92
end type

event cb_inserisci::clicked;//


//=== Nuovo Rekord
	choose case tab_1.selectedtab 
		case  1   // clienti
			
			Super::EVENT Clicked()
			

		case 4
			inserisci() 
			
			
	end choose
	

end event

type tab_1 from w_g_tab_3`tab_1 within w_wm_pklist
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
string text = "Testata"
string picturename = "Custom081!"
long picturemaskcolor = 32435950
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
event u_enter ( )
integer x = 0
integer y = 28
integer width = 2953
integer height = 1308
string dataobject = "d_wm_pklist"
boolean controlmenu = true
string icon = "Asterisk!"
boolean ki_attiva_standard_select_row = false
end type

event dw_1::itemchanged;call super::itemchanged;//
string k_nome
long k_riga, k_return=0
st_tab_clienti kst_tab_clienti
datawindowchild kdwc_1

choose case dwo.name 

	case "rag_soc_10", "rag_soc_10_1", "rag_soc_10_2"
		if len(trim(data)) > 0 then 
			tab_1.tabpage_1.dw_1.getchild(dwo.name, kdwc_1)
			k_riga = kdwc_1.find( "rag_soc_1 like '" + trim(data) + "%" +"'" , 1, kdwc_1.rowcount())
			if k_riga > 0 then
				kst_tab_clienti.codice = kdwc_1.getitemnumber( k_riga, "id_cliente")
				get_dati_cliente(kst_tab_clienti)
				post put_video_cliente(kst_tab_clienti, dwo.name)
			else
				tab_1.tabpage_1.dw_1.object.clie_1[1] = 0
				tab_1.tabpage_1.dw_1.modify( dwo.name + ".Background.Color = '" + string(kkg_colore.ERR_DATO) + "' ") 
			end if
		else
			set_iniz_dati_cliente(kst_tab_clienti)
			post put_video_cliente(kst_tab_clienti, dwo.name)
		end if

	case "clie_1", "clie_2", "clie_3" 
		if len(trim(data)) > 0 then 
			tab_1.tabpage_1.dw_1.getchild(dwo.name, kdwc_1)
			k_riga = kdwc_1.find( "id_cliente = " + trim(data) + " " , 1, kdwc_1.rowcount())
			if k_riga > 0 then
				kst_tab_clienti.codice = long(trim(data))
				get_dati_cliente(kst_tab_clienti)
				post put_video_cliente(kst_tab_clienti, dwo.name)
			else
				tab_1.tabpage_1.dw_1.modify( dwo.name + ".Background.Color = '" + string(kkg_colore.ERR_DATO) + "' ") 
			end if
		else
			set_iniz_dati_cliente(kst_tab_clienti)
			post put_video_cliente(kst_tab_clienti, dwo.name)
		end if

		
end choose 

	
end event

event dw_1::clicked;call super::clicked;//
//=== Premuto pulsante nella DW
//
	this.accepttext( )


	choose case dwo.name

	//--- elenco riceventi-fatt
		case "b1_m_r_f"
			post call_m_r_f ()

	//--- elenco contratti
		case "b1_contratti"
			post call_elenco_contratti()
						
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
string text = "usi futuri"
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
string text = "Righe"
string picturename = "DataWindow5!"
end type

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
boolean visible = true
integer x = 41
integer y = 12
integer width = 3054
boolean enabled = true
string dataobject = "d_wm_pklist_righe_l"
end type

event dw_4::ue_drop_out;call super::ue_drop_out;//
		dragdrop_dw_esterna( kdw_source, k_droprow )
		
return 1

end event

event dw_4::doubleclicked;call super::doubleclicked;
//
	if ki_st_open_w.flag_modalita <> kkg_flag_modalita.inserimento &
			or ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
	
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
string dataobject = "d_wm_pklist_barcode"
boolean hsplitscroll = false
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

type dw_x_copia from uo_d_std_1 within w_wm_pklist
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

type dw_riga from uo_d_std_1 within w_wm_pklist
event u_aggiungi ( )
event u_visualizza ( )
event u_intemchanged_riga_magazzino ( string k_campo )
event u_modifica ( )
integer x = 471
integer y = 156
integer width = 3063
integer height = 1684
integer taborder = 60
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string title = "Dettaglio Riga"
string dataobject = "d_wm_pklist_righe"
boolean controlmenu = true
boolean hsplitscroll = false
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_cerca = false
end type

event u_aggiungi();//======================================================================
//=== 
//======================================================================
//

	this.reset()
	this.ki_link_standard_attivi = tab_1.tabpage_1.dw_1.ki_link_standard_attivi 
	this.event u_personalizza_dw( )

	this.object.b_aggiungi.visible = true 
	this.object.b_aggiorna.visible = false 


end event

event u_visualizza();//======================================================================
//=== 
//======================================================================
//
kuf_utility kuf1_utility


	this.object.b_aggiorna.visible = false 
	this.object.b_aggiungi.visible = false 
	
//--- Protezione campi per riabilitare la modifica a parte la chiave
	kuf1_utility = create kuf_utility
	kuf1_utility.u_proteggi_dw("1", 0, dw_riga)
	destroy kuf1_utility
	
	this.ki_link_standard_attivi = true
	this.event u_personalizza_dw( )

end event

event u_intemchanged_riga_magazzino(string k_campo);//
long k_riga 
st_tab_gru kst_tab_gru
datawindowchild kdwc_1


k_riga = 1
if k_riga > 0 then

	choose case k_campo 
	
		case "gruppo"
			kst_tab_gru.codice = this.getitemnumber( k_riga, "gruppo") 
			if kst_tab_gru.codice > 0 then 
				this.getchild(k_campo, kdwc_1)
				k_riga = kdwc_1.find( "codice = " + string(kst_tab_gru.codice) + " " , 1, kdwc_1.rowcount())
				if k_riga > 0 then
					kst_tab_gru.des = kdwc_1.getitemstring( k_riga, "des")
					post put_video_gruppo_dw_riga(kst_tab_gru)
				else
					this.setitem(k_riga, k_campo, 0)
					this.modify( k_campo + ".Background.Color = '" + string(kkg_colore.ERR_DATO) + "' ") 
				end if
			else
				kst_tab_gru.codice = 0
				kst_tab_gru.des = ""
				post put_video_gruppo_dw_riga(kst_tab_gru)
			end if

	end choose 

end if



	

end event

event u_modifica();//======================================================================
//=== 
//======================================================================
//

	this.reset()
	this.ki_link_standard_attivi = tab_1.tabpage_1.dw_1.ki_link_standard_attivi 
	this.event u_personalizza_dw( )

	this.object.b_aggiungi.visible = false 
	this.object.b_aggiorna.visible = true 

	
//--- S-protezione campi per riabilitare la modifica a parte la chiave
	kuf_utility kuf1_utility
	kuf1_utility = create kuf_utility
	kuf1_utility.u_proteggi_dw("0", 0, dw_riga)
	destroy kuf1_utility
	

end event

event buttonclicked;call super::buttonclicked;//
long k_riga=0, k_riga_modificata
st_tab_wm_pklist_righe kst_tab_wm_pklist_righe

st_tab_meca kst_tab_meca
st_tab_armo kst_tab_armo


this.accepttext( )

if dwo.name = "b_aggiungi" or dwo.name = "b_aggiorna" then


	if this.rowcount( ) > 0 then
		k_riga = 1
		
		riempi_st_tab_wm_pklist_righe_da_dw_riga(k_riga, kst_tab_wm_pklist_righe)
	
		try
			if dwo.name = "b_aggiungi" then
				
				riga_aggiungi_in_lista(kst_tab_wm_pklist_righe)
				
			else
				
				k_riga_modificata = this.object.k_riga[1]
				riga_modifica_in_lista(k_riga_modificata, kst_tab_wm_pklist_righe )
				this.visible = false  // dopo la modifica Nascondo la DW
				
			end if
			
			attiva_tasti()
			
		catch (uo_exception kuo_exception)
			kuo_exception.messaggio_utente()
		
		end try
			
	end if
	
	
end if

if dwo.name = "b_esci" then
	this.visible = false
end if


end event

event constructor;call super::constructor;////
//int k_rc
//datawindowchild  kdwc_1, kdwc_2
//
//
//	if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
//		
//
//		tab_1.tabpage_1.dw_1.getchild("gruppo", kdwc_1)
//		kdwc_1.settransobject(sqlca)
//		kdwc_1.reset() 
//		tab_1.tabpage_1.dw_1.getchild("gruppo_1", kdwc_2)
//		kdwc_2.settransobject(sqlca)
//
//		kdwc_1.retrieve()
//		kdwc_1.SetSort("codice A")
//		kdwc_1.sort( )
//		kdwc_1.insertrow(1)
//		
//		k_rc = kdwc_2.RowsCopy(1, kdwc_1.RowCount(), Primary!, kdwc_2, 1, Primary!)
//	
//	end if
//	
//
//	this.postevent( "u_posiziona")
this.x = parent.width / 4
this.y = parent.height / 4

end event

event itemchanged;call super::itemchanged;//
long k_riga


k_riga = this.getrow()

if k_riga > 0 then

	this.post event u_intemchanged_riga_magazzino ( dwo.name )
		
end if


end event

type dw_barcode from uo_d_std_1 within w_wm_pklist
event u_modifica ( )
integer x = 247
integer y = 632
integer width = 2007
integer height = 1208
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "cambia codici barcode"
string dataobject = "d_wm_pklist_barcode_change"
boolean controlmenu = true
boolean resizable = true
boolean hsplitscroll = false
end type

event u_modifica();//======================================================================
//=== 
//======================================================================
//
st_tab_wm_pklist kst_tab_wm_pklist


	this.ki_link_standard_attivi = tab_1.tabpage_1.dw_1.ki_link_standard_attivi 
	this.event u_personalizza_dw( )

//	this.object.b_aggiorna.visible = true 
	
	this.x = parent.width / 4
	this.y = parent.height / 4
	
	this.settransobject( kguo_sqlca_db_magazzino )
	kst_tab_wm_pklist.id_wm_pklist = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_wm_pklist")
	this.retrieve(kst_tab_wm_pklist.id_wm_pklist)
	
	this.visible = true
	this.enabled = true

end event

event buttonclicked;call super::buttonclicked;//
long k_riga=0, k_riga_modificata
st_tab_wm_pklist_righe kst_tab_wm_pklist_righe

st_tab_meca kst_tab_meca
st_tab_armo kst_tab_armo


this.accepttext( )

if dwo.name = "b_aggiorna" then

	if this.rowcount( ) > 0 then

		try
			if messagebox("Richiesta aggiornamento", "Confermare la modifica dei barcode del mittente", question!, yesno!, 2) = 2 then
				kguo_exception.inizializza( )
				kguo_exception.setmessage("Richiesta aggiornamento", "Operazione interrotta dall'utente")
				throw kguo_exception 
			end if
			
			if dw_barcode.update( ) > 0 then
			else
				kguo_exception.inizializza( )
				kguo_exception.setmessage("Fallito aggiornamento", "Errore durante aggiornamento barcode mittente")
				throw kguo_exception 
			end if
			
			this.visible = false
			inizializza_3()
			inizializza_4()
			
		catch (uo_exception kuo_exception)
			kuo_exception.messaggio_utente()
		
		end try
			
	end if
	
	
end if



end event

event editchanged;//
string k_barcode_old, k_barcode_new
int k_riga, k_righe, k_len

if dwo.name = "k_pref" then

	//--- modifica il record su cui è
	k_riga = row
	k_barcode_old = this.getitemstring(k_riga, "wm_barcode_1") 
	k_len = len(k_barcode_old)
	if k_len >= 10 then
		k_barcode_old = right(k_barcode_old,10)
	end if
	k_barcode_new = trim(data) + k_barcode_old
	this.setitem(k_riga, "wm_barcode", k_barcode_new) 
	
	//--- modifica anche i records successivi se il PREF è vuoto
	k_righe = this.rowcount( )
	k_riga ++
	for k_riga = k_riga to k_righe
		if trim(this.getitemstring(k_riga, "k_pref")) > " " then
		else
			k_barcode_old = this.getitemstring(k_riga, "wm_barcode_1") 
			k_len = len(k_barcode_old)
			if k_len >= 10 then
				k_barcode_old = right(k_barcode_old,10)
			end if
			k_barcode_new = trim(data) + k_barcode_old
			this.setitem(k_riga, "wm_barcode", k_barcode_new) 
		end if
	end for
	
end if

end event

event itemchanged;//
end event

