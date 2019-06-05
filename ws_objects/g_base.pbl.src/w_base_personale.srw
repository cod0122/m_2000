$PBExportHeader$w_base_personale.srw
forward
global type w_base_personale from w_g_tab_3
end type
type cb_1 from commandbutton within tabpage_3
end type
type cb_2 from commandbutton within tabpage_3
end type
type cb_3 from commandbutton within tabpage_3
end type
type st_non_auth_4 from statictext within tabpage_4
end type
type st_non_auth_5 from statictext within tabpage_5
end type
type st_1 from statictext within tabpage_6
end type
type cb_pilota_proprieta from commandbutton within tabpage_6
end type
type cb_db_wmf from commandbutton within tabpage_6
end type
type st_18 from statictext within tabpage_6
end type
type cb_db_web from commandbutton within tabpage_6
end type
type st_19 from statictext within tabpage_6
end type
type cb_db_crm from commandbutton within tabpage_6
end type
type st_21 from statictext within tabpage_6
end type
type cb_db_previsioni from commandbutton within tabpage_6
end type
type st_23 from statictext within tabpage_6
end type
type cb_db_e1 from commandbutton within tabpage_6
end type
type st_26 from statictext within tabpage_6
end type
type rr_1 from roundrectangle within tabpage_8
end type
type rr_4 from roundrectangle within tabpage_8
end type
type rr_2 from roundrectangle within tabpage_8
end type
type st_3 from statictext within tabpage_8
end type
type cb_ausiliari_1 from commandbutton within tabpage_8
end type
type cb_ausiliari_2 from commandbutton within tabpage_8
end type
type st_5 from statictext within tabpage_8
end type
type st_6 from statictext within tabpage_8
end type
type st_7 from statictext within tabpage_8
end type
type st_8 from statictext within tabpage_8
end type
type st_10 from statictext within tabpage_8
end type
type st_11 from statictext within tabpage_8
end type
type st_12 from statictext within tabpage_8
end type
type st_9 from statictext within tabpage_8
end type
type st_13 from statictext within tabpage_8
end type
type st_14 from statictext within tabpage_8
end type
type st_15 from statictext within tabpage_8
end type
type st_16 from statictext within tabpage_8
end type
type st_17 from statictext within tabpage_8
end type
type cb_docpath from commandbutton within tabpage_8
end type
type st_20 from statictext within tabpage_8
end type
type st_2 from statictext within tabpage_8
end type
type st_24 from statictext within tabpage_8
end type
type st_25 from statictext within tabpage_8
end type
type st_28 from statictext within tabpage_8
end type
type st_4 from statictext within tabpage_9
end type
type cb_4 from commandbutton within tabpage_9
end type
type st_22 from statictext within tabpage_9
end type
type cb_5 from commandbutton within tabpage_9
end type
type tabpage_10 from userobject within tab_1
end type
type st_27 from statictext within tabpage_10
end type
type cb_6 from commandbutton within tabpage_10
end type
type cb_meca_chiude from commandbutton within tabpage_10
end type
type st_meca_chiude from statictext within tabpage_10
end type
type dw_10 from uo_d_std_1 within tabpage_10
end type
type tabpage_10 from userobject within tab_1
st_27 st_27
cb_6 cb_6
cb_meca_chiude cb_meca_chiude
st_meca_chiude st_meca_chiude
dw_10 dw_10
end type
type tabpage_11 from userobject within tab_1
end type
type dw_11 from uo_d_std_1 within tabpage_11
end type
type tabpage_11 from userobject within tab_1
dw_11 dw_11
end type
type tabpage_12 from userobject within tab_1
end type
type dw_12 from uo_d_std_1 within tabpage_12
end type
type tabpage_12 from userobject within tab_1
dw_12 dw_12
end type
type tabpage_13 from userobject within tab_1
end type
type st_esiti_operazioni from statictext within tabpage_13
end type
type pb_st_esiti_operazioni from picturebutton within tabpage_13
end type
type cb_monitor from commandbutton within tabpage_13
end type
type st_13_retrieve from statictext within tabpage_13
end type
type st_non_auth_13 from statictext within tabpage_13
end type
type dw_13 from uo_d_std_1 within tabpage_13
end type
type tabpage_13 from userobject within tab_1
st_esiti_operazioni st_esiti_operazioni
pb_st_esiti_operazioni pb_st_esiti_operazioni
cb_monitor cb_monitor
st_13_retrieve st_13_retrieve
st_non_auth_13 st_non_auth_13
dw_13 dw_13
end type
end forward

global type w_base_personale from w_g_tab_3
integer width = 1669
integer height = 584
string title = "Proprietà Personali"
long backcolor = 67108864
string icon = "Form!"
boolean ki_toolbar_window_presente = true
boolean ki_sincronizza_window_consenti = false
boolean ki_fai_nuovo_dopo_update = false
boolean ki_fai_nuovo_dopo_insert = false
end type
global w_base_personale w_base_personale

type variables
//
string ki_record_orig
kuf_stampe kiuf_stampe
end variables

forward prototypes
protected subroutine pulizia_righe ()
protected subroutine riempi_id ()
protected subroutine smista_funz (string k_par_in)
protected function string check_dati ()
protected function integer cancella ()
protected subroutine inizializza_1 ()
protected function string aggiorna ()
protected function string inizializza ()
private function integer popola_dw_1 ()
private subroutine sr_cambia_pwd ()
protected subroutine inizializza_3 () throws uo_exception
private subroutine get_path_centrale ()
private subroutine get_path_pgm_upd ()
protected subroutine open_start_window ()
public function st_esito scrivi_base ()
protected subroutine inizializza_4 () throws uo_exception
private subroutine get_path_fatt ()
protected subroutine inizializza_12 () throws uo_exception
protected subroutine inizializza_11 () throws uo_exception
private subroutine get_dosimetro_ult_barcode ()
private subroutine get_path_doc_root ()
private subroutine popola_dw_2 ()
private subroutine get_path_esolver_anag ()
private subroutine get_path_esolver_fidi ()
public subroutine u_resize ()
public subroutine u_avvia_check_db ()
public subroutine u_elenco_esiti (boolean k_visibile)
private subroutine u_call_art_x_no_contratto ()
public subroutine u_set_sv_call_vettore_id_listino (st_tab_listino ast_tab_listino)
public function string u_attiva_tab (integer a_tab_da_attivare)
protected subroutine stampa_esegui (st_stampe ast_stampe)
protected subroutine attiva_tasti_0 ()
private subroutine get_path_reportpilota ()
private subroutine get_fgrp_out_path ()
private subroutine get_report_export_dir ()
end prototypes

protected subroutine pulizia_righe ();////
//long k_riga
//long k_nr_righe
//
//
//tab_1.tabpage_1.dw_1.accepttext()
//tab_1.tabpage_2.dw_2.accepttext()
//tab_1.tabpage_3.dw_3.accepttext()
//tab_1.tabpage_4.dw_4.accepttext()
//tab_1.tabpage_5.dw_5.accepttext()
//
////
////=== Pulizia dei rek non validi sui vari TAB
//	k_nr_righe = tab_1.tabpage_1.dw_1.rowcount()
//	for k_riga = k_nr_righe to 1 step -1
//
//		if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) = newmodified! then 
//			if isnull(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "id_programma")) &
//				or len(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "id_programma"))) = 0  &
//				then
//		
//				tab_1.tabpage_1.dw_1.deleterow(k_riga)
//				
//			end if
//		end if
//		
//	next
//
end subroutine

protected subroutine riempi_id ();////
//datawindowchild kdwc_1
//long k_riga, k_riga_dw3
//date k_dataoggi
//kuf_base kuf1_base
//
//	
//	k_riga = tab_1.tabpage_1.dw_1.getrow()
//
//
//	
//	if k_riga > 0 then
//
////--- legge la dw dei programmi
//		if tab_1.tabpage_3.dw_3.rowcount() = 0 then
//			tab_1.tabpage_3.dw_3.retrieve()  
//		end if
//
//		if isnull(tab_1.tabpage_1.dw_1.getitemdate(k_riga, "data_1")) &
//		   or tab_1.tabpage_1.dw_1.getitemdate(k_riga, "data_1") = date(0) &
//			then				
//		
//			kuf1_base = create kuf_base
//			k_dataoggi = date(mid(kuf1_base.prendi_dato_base("dataoggi"),2))
//			destroy kuf1_base
//
//			tab_1.tabpage_1.dw_1.setitem(k_riga, "data_1", k_dataoggi)
//		end if
//
//		if isnull(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "descrizione")) &
//		   or len(trim(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "descrizione"))) = 0 &
//			then				
//
//			k_riga_dw3 = tab_1.tabpage_3.dw_3.Find( "id = '" &
//						+ string(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "id_programma")) + "' ", &
//						1, tab_1.tabpage_3.dw_3.RowCount( ))
//
//			if k_riga_dw3 > 0 then
//				tab_1.tabpage_1.dw_1.setitem(k_riga, "descrizione", &
//					trim(tab_1.tabpage_3.dw_3.getitemstring(k_riga_dw3, "titolo")))
//			else
//				tab_1.tabpage_1.dw_1.setitem(k_riga, "descrizione", " ")
//			end if			
//		end if
//
////--- imposta le funzioni/operazioni 
//		if isnull(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "funzioni")) &
//			or len(trim(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "funzioni"))) = 0 &
//			or trim(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "funzioni")) = "X" &
//			then				
//
//			k_riga_dw3 = tab_1.tabpage_3.dw_3.Find( "id = '" &
//						+ string(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "id_programma")) + "' ", &
//						1, tab_1.tabpage_3.dw_3.RowCount( ))
//
//			if k_riga_dw3 > 0 then
//				tab_1.tabpage_1.dw_1.setitem(k_riga, "funzioni", &
//					upper(trim(tab_1.tabpage_3.dw_3.getitemstring(k_riga_dw3, "funzioni"))))
//			else
//				tab_1.tabpage_1.dw_1.setitem(k_riga, "funzioni", " ")
//			end if			
//			
//		end if
//		
////=== Se sono in inser azzero il ID  
//		if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) = newmodified! then
//			if isnull(tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id")) &
//				then				
//				tab_1.tabpage_1.dw_1.setitem(k_riga, "id", 0)
//			end if
//		end if
//	end if
//	
end subroutine

protected subroutine smista_funz (string k_par_in);//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//=== Ritorna ...: 0=tutto OK; 1=Errore
//===

	choose case k_par_in 
	
		case KKG_FLAG_RICHIESTA.refresh		//rilegge lista
			tab_1.tabpage_12.dw_12.reset( )
			
	end choose

	super::smista_funz(k_par_in)





end subroutine

protected function string check_dati ();//
//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================

string k_return = ""
string k_errore = "0", k_rx
long k_nr_righe
int k_riga
int k_nr_errori
st_tab_base kst_tab_base
st_tab_armo kst_tab_armo
//string k_key_str
//char k_stato, k_tipo
string k_testo
//st_esito kst_esito
//st_tab_sr_funzioni kst_tab_sr_funzioni
kuf_meca_dosim kuf1_meca_dosim
kuf_armo kuf1_armo
//
//
//
//=== Controllo il tab 4
	k_nr_righe = tab_1.tabpage_4.dw_4.rowcount()
	k_nr_errori = 0
	if k_nr_righe > 0 then
		k_riga = 1
		if tab_1.tabpage_4.dw_4.getitemstatus( k_riga, 0, primary!) = DataModified! then
		
//--- controllo codice barcode 		
			kst_tab_base.dosimetro_ult_barcode = tab_1.tabpage_4.dw_4.getitemstring( k_riga, "dosimetro_ult_barcode") 
			if trim(kst_tab_base.dosimetro_ult_barcode) > " " then
				if left(kst_tab_base.dosimetro_ult_barcode, 2) <= "AA" and left(kst_tab_base.dosimetro_ult_barcode, 2) >= "ZZ" then
					k_testo = trim(tab_1.tabpage_4.dw_4.object.dosimetro_ult_barcode_t.text)
					k_return += tab_1.tabpage_4.text + ": Primi 2 caratteri non ammessi nel campo '" + k_testo + "', accetta solo da 'AA' a 'ZZ'" + "~n~r"
					k_errore = "2"
					k_nr_errori++
				end if
				if not isnumber(trim(mid(kst_tab_base.dosimetro_ult_barcode,3,3))) then
					k_testo = trim(tab_1.tabpage_4.dw_4.object.dosimetro_ult_barcode_t.text)
					k_return += tab_1.tabpage_4.text + ": Ultimi 3 caratteri non ammessi nel campo '" + k_testo + "', accetta solo numeri 000 - 999" + "~n~r"
					k_errore = "2"
					k_nr_errori++
				end if
				if k_errore = "0" then
					k_rx = left(kst_tab_base.dosimetro_ult_barcode, 2) + string(integer(mid(kst_tab_base.dosimetro_ult_barcode,3,3)), "000")
					tab_1.tabpage_4.dw_4.setitem( k_riga, "dosimetro_ult_barcode", k_rx) 
				end if
			end if	
			kst_tab_base.dosimetro_barcode_mask = tab_1.tabpage_4.dw_4.getitemstring( k_riga, "dosimetro_barcode_mask")
			kst_tab_base.dosimetro_ult_barcode = tab_1.tabpage_4.dw_4.getitemstring( k_riga, "dosimetro_ult_barcode")
			if len(trim(kst_tab_base.dosimetro_barcode_mask)) = 0 or isnull(kst_tab_base.dosimetro_barcode_mask) then kst_tab_base.dosimetro_barcode_mask = "DSM"
			
//--- controllo codice E1 		
			kst_tab_base.e1mcu = tab_1.tabpage_4.dw_4.getitemstring( k_riga, "e1mcu") 
			if trim(kst_tab_base.e1mcu) > " " then
			else
				k_testo = trim(tab_1.tabpage_4.dw_4.object.dosimetro_ult_barcode_t.text)
				k_return += tab_1.tabpage_4.text + ": scegliere il codice E1" + "~n~r"
				k_errore = "2"
				k_nr_errori++
			end if	

//--- controlla periodo ORA LEGALE
//			kst_tab_base.oralegale_on = tab_1.tabpage_4.dw_4.object.oralegale_on[k_riga] 
//			kst_tab_base.oralegale_start = tab_1.tabpage_4.dw_4.object.oralegale_start[k_riga] 
//			kst_tab_base.oralegale_end = tab_1.tabpage_4.dw_4.object.oralegale_end[k_riga] 
//			kst_tab_base.anno = tab_1.tabpage_4.dw_4.object.anno[k_riga] 
//			
//			if kst_tab_base.oralegale_on = "S" then
//				if year(kst_tab_base.oralegale_start) < kst_tab_base.anno then
//					k_return += tab_1.tabpage_1.text + ": Impostare la data di Inizio dell'Ora Legale per l'anno " + string(kst_tab_base.anno) + "~n~r"
//					k_errore = "1"
//					k_nr_errori++
//				end if
//				if year(kst_tab_base.oralegale_end) < kst_tab_base.anno then
//					k_return += tab_1.tabpage_1.text + ": Impostare la data di Fine dell'Ora Legale per l'anno " + string(kst_tab_base.anno) + "~n~r"
//					k_errore = "1"
//					k_nr_errori++
//				end if
//				//--- l'anno deve essere uguale e le date congruenti
//				if year(kst_tab_base.oralegale_start) = year(kst_tab_base.oralegale_end) and kst_tab_base.oralegale_start < kst_tab_base.oralegale_end then
//				else
//					k_return += tab_1.tabpage_1.text + ": Periodo dell'Ora Legale non congruente, controllare le date di inizio e fine~n~r"
//					k_errore = "1"
//					k_nr_errori++
//				end if
//
//			end if
			
		end if
	end if
	
//	if isnull(kst_tab_sr_funzioni.id) then
//		kst_tab_sr_funzioni.id = 0
//	end if
//	kst_tab_sr_funzioni.id_programma = tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "id_programma") 
//	kst_tab_sr_funzioni.nome = tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "nome") 
//	if isnull(kst_tab_sr_funzioni.nome) or len(trim(kst_tab_sr_funzioni.nome)) = 0 then
//		kst_tab_sr_funzioni.nome = upper(kst_tab_sr_funzioni.id_programma)
//		tab_1.tabpage_1.dw_1.setitem ( k_riga, "nome", kst_tab_sr_funzioni.nome) 
//	end if
//	
//	if len(trim(kst_tab_sr_funzioni.id_programma)) > 0 then
//		kuf1_sicurezza = create kuf_sicurezza
//		kst_esito = kuf1_sicurezza.tb_sr_funzioni_conta_id_programma(kst_tab_sr_funzioni)
//		destroy kuf1_sicurezza
//		if kst_esito.esito = "0" and kst_tab_sr_funzioni.contatore > 0 then
//			k_errore = "4"
//			kst_tab_sr_funzioni.nome = trim(kst_tab_sr_funzioni.nome) + trim(string(kst_tab_sr_funzioni.contatore))
//			tab_1.tabpage_1.dw_1.setitem ( k_riga, "nome", kst_tab_sr_funzioni.nome) 
//			k_return = tab_1.tabpage_1.text + ": Funzione gia' caricata, nuovo nome proposto: " &
//			                   + kst_tab_sr_funzioni.nome + " " + &
//									 + "~n~r" 
//		end if
//	end if
//
////	if isnull(k_key) or len(trim(k_key)) = 0 then
////		k_testo = trim(tab_1.tabpage_1.dw_1.object.nome_t.text)
////		k_return = tab_1.tabpage_1.text + ": Manca valore nel campo '" + k_testo + "'. " + "~n~r"
////		k_errore = "3"
////		k_nr_errori++
////	end if
////	if isnull(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "id_programma")) = true then
////		k_testo = trim(tab_1.tabpage_1.dw_1.object.id_programma_t.text)
////		k_return = k_return + tab_1.tabpage_1.text + ": Manca valore nel campo '" + k_testo + "'. " + "~n~r" 
////		k_errore = "3"
////		k_nr_errori++
////	end if
//
//	if k_errore = "0" then
//	
//		tab_1.tabpage_1.dw_1.setitem(k_riga, "x_datins", today())
//		tab_1.tabpage_1.dw_1.setitem(k_riga, "x_utente", kguo_utente.get_codice())
//		
//	end if
//
////
//////=== Controllo altro tab
////	k_nr_righe = tab_1.tabpage_2.dw_2.rowcount()
////	k_riga = tab_1.tabpage_2.dw_2.getnextmodified(0, primary!)
////
////	do while k_riga > 0  and k_nr_errori < 10
////
////		k_key = tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, "sequenza") 
////
////		if isnull(k_key) then
////			tab_1.tabpage_2.dw_2.setitem ( k_riga, "sequenza", 0) 
////			k_key = 0
////		end if
////
////		if k_nr_errori < 9 then // per non uscire da check senza contr.eventuali eltri errori gravi 
////			if isnull(tab_1.tabpage_2.dw_2.getitemdate ( k_riga, "data_prev")) = true then
////				k_return = "Data " + tab_1.tabpage_2.text + " alla riga " + &
////				string(k_riga, "#####") + " non impostata~n~r" 
////				k_errore = "4"
////				k_nr_errori++
////			end if
////
////			if k_errore = "0" and k_riga < k_nr_righe and k_key > 0 then
////				k_tipo = tab_1.tabpage_2.dw_2.getitemstring ( k_riga, "tipo") 
////				if tab_1.tabpage_2.dw_2.find("sequenza = " +  &
////							string(k_key, "#####") + " and tipo='" + k_tipo + "'", &
////							(k_riga+1), k_nr_righe) > 0 then
////					k_return = "La stessa sequenza " + tab_1.tabpage_2.text + " ripetuta piu' volte~n~r" 
////					k_return = k_return + "(Codice " + string(k_key) + ") ~n~r"
////					k_errore = "4"
////					k_nr_errori++
////				end if
////			end if
////		end if
////		k_riga++
////
////		k_riga = tab_1.tabpage_2.dw_2.getnextmodified(k_riga, primary!)
////
////	loop
////
//////=== Controllo altro tab
////	k_nr_righe = tab_1.tabpage_4.dw_4.rowcount()
////	k_riga = tab_1.tabpage_4.dw_4.getnextmodified(0, primary!)
////
////	do while k_riga > 0  and k_nr_errori < 10
////
////		k_key_str = tab_1.tabpage_4.dw_4.getitemstring ( k_riga, "id_fattura") 
////
////
////		if k_nr_errori < 9 then // per non uscire da check senza contr.eventuali eltri errori gravi 
////
////			if isnull(tab_1.tabpage_4.dw_4.getitemdate ( k_riga, "data_fattura")) = true then
////				k_return = "Manca la Data " + tab_1.tabpage_4.text + " alla riga " + &
////				string(k_riga, "#####") + " ~n~r" 
////				k_errore = "3"
////				k_nr_errori++
////			end if
////
////			if k_nr_errori < 9 then // per non uscire da check senza contr.eventuali eltri errori gravi 
////				if isnull(tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "importo")) = true or & 
////					tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "importo") = 0 then
////					k_return = "Manca l'Importo " + tab_1.tabpage_4.text + " alla riga " + &
////					string(k_riga, "#####") + " ~n~r" 
////					k_errore = "4"
////					k_nr_errori++
////				end if
////			end if
////
////		end if
////		k_riga++
////
////		k_riga = tab_1.tabpage_4.dw_4.getnextmodified(k_riga, primary!)
////
////	loop
////
////
////
return k_errore + k_return


end function

protected function integer cancella ();//
//=== Cancellazione record dal DB
//=== Ritorna : 0=OK 1=KO 2=non eseguita
//
int k_return=0

return k_return

end function

protected subroutine inizializza_1 ();//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
long k_riga
double k_dose 
string k_codice_attuale, k_codice_prec
st_tab_sr_prof_funz kst_tab_sr_prof_funz
	

k_riga = tab_1.tabpage_1.dw_1.getrow() 
	
//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if not isnull(tab_1.tabpage_2.st_2_retrieve.text) then
	k_codice_prec = tab_1.tabpage_2.st_2_retrieve.text
else
	k_codice_prec = string(kst_tab_sr_prof_funz.id_funzioni)
end if

k_codice_attuale = "*"

//=== Forza valore Codice composto per ricordarlo per le prossime richieste
tab_1.tabpage_2.st_2_retrieve.text = k_codice_attuale

if k_codice_attuale <> k_codice_prec then

	popola_dw_2()
	tab_1.tabpage_2.dw_2.resetupdate( )

end if				
				

attiva_tasti()
tab_1.tabpage_1.dw_1.setredraw(true)
if tab_1.tabpage_2.dw_2.rowcount() = 0 then
	tab_1.tabpage_2.dw_2.insertrow(0) 
end if


tab_1.tabpage_2.dw_2.setfocus()
	
	

end subroutine

protected function string aggiorna ();//
//=== Aggiorna il BASE
//
string k_return = "0 "
string k_text
int k_len
long k_riga=0, k_riga_1
pointer kp_oldpointer
datawindowchild kdwc_menu
st_tab_base kst_tab_base
st_esito kst_esito
kuf_base  kuf1_base
 

//=== Puntatore Cursore da attesa.....
kp_oldpointer = SetPointer(HourGlass!)

kst_esito.esito = kkg_esito.ok

if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then
	
	if tab_1.tabpage_1.dw_1.getitemstatus(1, 0, primary!) = datamodified! or &
		tab_1.tabpage_1.dw_1.getitemstatus(1, 0, primary!) = newmodified!  &
		then
	
		k_riga = tab_1.tabpage_1.dw_1.getrow()
	
		kuf1_base = create kuf_base
	
		k_text = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "titolo_main")
		if isnull(k_text) then
			k_text=" " 
		end if
		kst_tab_base.st_tab_base_personale.titolo_main = trim(k_text)
	
		k_text = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "nome")
		if isnull(k_text) then
			k_text=trim(kguo_utente.get_codice())
		end if
		kst_tab_base.st_tab_base_personale.nome = trim(k_text)
	
		k_text = ""
		tab_1.tabpage_1.dw_1.getchild("finestra_inizio", kdwc_menu)
		k_text = trim(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "finestra_inizio"))
		k_riga_1 = kdwc_menu.find("titolo = '" + k_text + "' ", 0, kdwc_menu.rowcount()) 
		if k_riga_1 > 0 then
			k_text = kdwc_menu.getitemstring(k_riga_1, "id")
		else
			k_text = " "
		end if
		if LenA(k_text) = 0 then
			k_text = " "
		end if
		kst_tab_base.st_tab_base_personale.finestra_inizio = trim(k_text)

		k_text = ""
		k_text = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "flag_salva_liste")
		if isnull(k_text) then
			k_text="S"
		end if
		kst_tab_base.st_tab_base_personale.flag_salva_liste = trim(k_text)
	
		k_text = ""
		k_text = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "e_mail")
		if isnull(k_text) then
			k_text="e-mail"
		end if
		kst_tab_base.st_tab_base_personale.e_mail = trim(k_text)
	
		k_text = ""
		k_text = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "tel")
		if isnull(k_text) then
			k_text="interno"
		end if
		kst_tab_base.st_tab_base_personale.tel = trim(k_text)
		
		k_text = ""
		k_text = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "flag_suoni")
		if isnull(k_text) then
			k_text="S"
		end if
		kst_tab_base.st_tab_base_personale.flag_suoni = trim(k_text)
	
		kst_esito = kuf1_base.scrivi_base(kst_tab_base)    // scrive i parametri di cui sopra in tab BASE_UTENTI

		k_text = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "stcert1")
		if isnull(k_text) then
			k_text=""
		end if
		kst_tab_base.key = kuf1_base.kki_base_utenti_codice_stcert1
		kst_tab_base.key1 = k_text
		kuf1_base.metti_dato_base(kst_tab_base) // scrive i parametri di cui sopra in tab BASE_UTENTI
		k_text = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "stcert2")
		if isnull(k_text) then
			k_text=""
		end if
		kst_tab_base.key = kuf1_base.kki_base_utenti_codice_stcert2
		kst_tab_base.key1 = k_text
		kuf1_base.metti_dato_base(kst_tab_base) // scrive i parametri di cui sopra in tab BASE_UTENTI
	
		k_text = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "flag_zoom_ctrl")
		if isnull(k_text) then
			k_text=""
		end if
		kst_tab_base.key = kuf1_base.kki_base_utenti_flagZOOMctrl
		kst_tab_base.key1 = k_text
		kuf1_base.metti_dato_base(kst_tab_base) // scrive i parametri di cui sopra in tab BASE_UTENTI
		if  k_text = "S" then
			kguo_g.set_flagZOOMctrl(true)
		else
			kguo_g.set_flagZOOMctrl(false)
		end if		
	
		destroy kuf1_base
	
	end if
end if

//--- Se sono su 'Proprietà Procedura Generale'
if tab_1.tabpage_4.dw_4.rowcount( ) > 0 then
	if tab_1.tabpage_4.dw_4.getitemstatus(1, 0, primary!) = datamodified! or &
			tab_1.tabpage_4.dw_4.getitemstatus(1, 0, primary!) = newmodified! then
//=== Aggiorno BASE
		kst_esito = scrivi_base()
	end if
end if

//--- Se sono su 'Contatori Procedura Generale'
if tab_1.tabpage_5.dw_5.rowcount( ) > 0 then
	if tab_1.SelectedTab = 5 then
		if tab_1.tabpage_5.dw_5.getitemstatus(1, 0, primary!) = datamodified! or &
				tab_1.tabpage_5.dw_5.getitemstatus(1, 0, primary!) = newmodified! then
				
			if tab_1.tabpage_5.dw_5.update() < 0 then
				kst_esito.esito = kkg_esito.db_ko 
			end if
			
		end if
	end if
end if


//--- Proprietà Procedura NT
if tab_1.tabpage_9.dw_9.rowcount( ) > 0 then
	if tab_1.tabpage_9.dw_9.getitemstatus(1, 0, primary!) = datamodified! or &
				tab_1.tabpage_9.dw_9.getitemstatus(1, 0, primary!) = newmodified!  then

		if tab_1.tabpage_9.dw_9.update() < 0 then
			kst_esito.esito = kkg_esito.db_ko 
		end if
		
	end if
end if


//=== Puntatore Cursore da attesa.....
SetPointer(kp_oldpointer)


//=== errore : 0=tutto OK o NON RICHIESTA; 1=errore grave I-O;
//=== 		 : 2=LIBERO
//===			 : 3=Commit fallita
	
if kst_esito.esito <> kkg_esito.ok then 

	kguo_sqlca_db_magazzino.db_rollback( )
	k_return="1Fallito aggiornamento archivio '" + trim(kst_esito.sqlerrtext) + "' ~n~r" 

else
	
	kguo_sqlca_db_magazzino.db_commit( )
	tab_1.tabpage_1.dw_1.resetupdate()
	
end if	


if LeftA(k_return, 1) = "1" then
	messagebox("Operazione di Aggiornamento Non Eseguita !!", MidA(k_return, 2))
end if




return k_return


end function

protected function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_scelta
string k_stato = "0"
int k_err_ins, k_rc
kuf_base kuf1_base
string k_record="0 ", k_stampanti
string k_nome_db, k_parametro_db, k_path_db, k_path_dw
string k_nome_dbf, k_parametro_dbf, k_path_dbf
int k_ctr, k_ctr_1, k_punt, k_len, k_errore
kuf_utility kuf1_utility
datawindowchild kdwc_menu, kdwc_menu_1




if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
	k_scelta = trim(ki_st_open_w.flag_modalita)
	
//	k_key = trim(ki_st_open_w.key1)

//--- Attivo dw archivio MENU WINDOW
	tab_1.tabpage_1.dw_1.getchild("finestra_inizio", kdwc_menu)
	tab_1.tabpage_1.dw_1.getchild("finestra_inizio_1", kdwc_menu_1)

	kdwc_menu.settransobject(sqlca)
	kdwc_menu_1.settransobject(sqlca)

	tab_1.tabpage_1.dw_1.insertrow(0)

	if kdwc_menu.rowcount() = 0 then
		kdwc_menu.retrieve()
		kdwc_menu.insertrow(1)
		kdwc_menu.setitem(1, "descr", "<Nulla>")
		kdwc_menu.setitem(1, "titolo", "<Nulla>")
		kdwc_menu.setitem(1, "id", "  ")
		kdwc_menu_1.retrieve()
	end if


	k_rc = popola_dw_1()
	
	choose case k_rc

		case is < 0				
			k_errore = 1
			messagebox("Dati non trovati", "Configurazione proprietà personali non Trovata")
			

		case 0
			tab_1.tabpage_1.dw_1.reset()
			attiva_tasti()

			if k_scelta <> kkg_flag_modalita.inserimento then
				k_errore = 1
				messagebox("Ricerca fallita", &
					"Nessuna impostazione Azienda trovata" )
//					"(Codice Cercato:" + trim(k_key) + ")~n~r" )

				post close(this)
				
			else
				k_err_ins = inserisci()
				tab_1.tabpage_1.dw_1.setfocus()
			end if
			
		case is > 0		
			if k_scelta = kkg_flag_modalita.inserimento then
				cb_inserisci.postevent(clicked!)
			end if

			tab_1.tabpage_1.dw_1.setfocus()
			tab_1.tabpage_1.dw_1.setcolumn(1)
			
			attiva_tasti()
	
	end choose

	tab_1.tabpage_1.dw_1.resetupdate( )
else
	attiva_tasti()
end if


//--- inabilito le modifiche sulla dw
if k_errore = 0 then
	
//--- Inabilita campi alla modifica se Visualizzazione
	kuf1_utility = create kuf_utility 
	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.visualizzazione &
	   or trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.cancellazione then
		
		kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_1.dw_1)

	else		
		
//--- S-protezione campi per riabilitare la modifica 
      	kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)

//--- legge le stampanti definitive
		k_stampanti = kiuf_stampe.get_stampanti_dwddlb_values()
     	tab_1.tabpage_1.dw_1.object.stcert1.Values = k_stampanti
     	tab_1.tabpage_1.dw_1.object.stcert2.Values = k_stampanti

	end if
	destroy kuf1_utility
	
//--- se cancellazione
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.cancellazione then

		cb_cancella.postevent (clicked!)
		post close(this)
		
	end if
end if



return "0"

end function

private function integer popola_dw_1 ();//
//=== Legge l'archivio sequenzale di BASE
//
int k_return=0
string k_record="0 "
string k_nome_dbf, k_parametro_dbf, k_path_dbf, k_text
int k_ctr, k_ctr_1, k_punt, k_len
long k_riga_1
datetime k_current
st_tab_base kst_tab_base
st_esito kst_esito 
kuf_base kuf1_base
datawindowchild kdwc_menu
//kds_current_datetime kds1_current_datetime


kuf1_base = create kuf_base
kst_esito = kuf1_base.leggi_base(kst_tab_base)

	k_current = kGuf_data_base.prendi_dataora( )
	k_return=1

	tab_1.tabpage_1.dw_1.setitem(1, "nome", trim(kst_tab_base.st_tab_base_personale.nome))
	tab_1.tabpage_1.dw_1.setitem(1, "titolo_main", trim(kst_tab_base.st_tab_base_personale.titolo_main))
	tab_1.tabpage_1.dw_1.setitem(1, "flag_salva_liste", trim(kst_tab_base.st_tab_base_personale.flag_salva_liste))
	tab_1.tabpage_1.dw_1.setitem(1, "e_mail", trim(kst_tab_base.st_tab_base_personale.e_mail))
	tab_1.tabpage_1.dw_1.setitem(1, "tel", trim(kst_tab_base.st_tab_base_personale.tel))
	tab_1.tabpage_1.dw_1.setitem(1, "flag_suoni", trim(kst_tab_base.st_tab_base_personale.flag_suoni))
	tab_1.tabpage_1.dw_1.setitem(1, "stcert1", trim(kst_tab_base.st_tab_base_personale.stcert1))
	tab_1.tabpage_1.dw_1.setitem(1, "stcert2", trim(kst_tab_base.st_tab_base_personale.stcert2))
	tab_1.tabpage_1.dw_1.setitem(1, "current", k_current)
	tab_1.tabpage_1.dw_1.setitem(1, "path", trim(kGuo_path.get_procedura()))
	tab_1.tabpage_1.dw_1.setitem(1, "flag_zoom_ctrl", trim(kst_tab_base.st_tab_base_personale.flag_zoom_ctrl))

	tab_1.tabpage_1.dw_1.getchild("finestra_inizio", kdwc_menu)
 	k_text = trim(kst_tab_base.st_tab_base_personale.finestra_inizio)
	k_riga_1 = kdwc_menu.find("id = '" + k_text + "' ", 0, kdwc_menu.rowcount()) 
	if k_riga_1 > 0 then
      kdwc_menu.setrow(k_riga_1)
      kdwc_menu.scrolltorow(k_riga_1)
		k_text = kdwc_menu.getitemstring(k_riga_1, "titolo")
	end if
	tab_1.tabpage_1.dw_1.setitem(1, "finestra_inizio", trim(k_text))

	tab_1.tabpage_1.dw_1.resetupdate()

	if trim(kst_tab_base.st_tab_base_personale.titolo_main) > " " then
	else
		tab_1.tabpage_1.dw_1.setitem(1, "titolo_main", "M2000")
	end if
	if trim(kst_tab_base.st_tab_base_personale.nome) > " " then
	else
		tab_1.tabpage_1.dw_1.setitem(1, "nome", trim(kguo_utente.get_codice()))
	end if
	if trim(kst_tab_base.st_tab_base_personale.e_mail) > " " then
	else
		tab_1.tabpage_1.dw_1.setitem(1, "e_mail", "@sterigenics.com")
	end if
	if trim(kst_tab_base.st_tab_base_personale.flag_salva_liste) > " " then
	else
		tab_1.tabpage_1.dw_1.setitem(1, "flag_salva_liste", "S")
	end if
	if trim(kst_tab_base.st_tab_base_personale.flag_suoni) > " " then
	else
		tab_1.tabpage_1.dw_1.setitem(1, "flag_suoni", "S")
	end if
	if trim(kst_tab_base.st_tab_base_personale.stcert1) > " " then
	else
		tab_1.tabpage_1.dw_1.setitem(1, "stcert1", " ")
	end if
	if trim(kst_tab_base.st_tab_base_personale.stcert2) > " " then
	else
		tab_1.tabpage_1.dw_1.setitem(1, "stcert2", " ")
	end if

	
return k_return
end function

private subroutine sr_cambia_pwd ();//=== Lancia il Logo iniziale
//open (w_about)
//
st_open_w kst_open_w
//kuf_menu_window kuf1_menu_window



//===
//=== Menu Treeview
//===
	kst_open_w.id_programma = kkg_id_programma.sr_change_pwd
	kst_open_w.flag_primo_giro = "S"
	kst_open_w.flag_modalita = kkg_flag_modalita.modifica
	kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
	kst_open_w.flag_leggi_dw = " "
	kst_open_w.flag_cerca_in_lista = " "
	kst_open_w.key1 = string(kGuo_utente.get_pwd())
	kst_open_w.key2 = " "
	kst_open_w.key3 = " "
	kst_open_w.key4 = " " 

	
	//kuf1_menu_window = create kuf_menu_window 
	kGuf_menu_window.open_w_tabelle(kst_open_w)
	//destroy kuf1_menu_window


							
							



end subroutine

protected subroutine inizializza_3 () throws uo_exception;//
//======================================================================
//=== Inizializzazione del TAB 4 controllandone i valori se gia' presenti
//======================================================================
//
int k_rc=0
double k_dose 
string k_codice_attuale, k_codice_prec
boolean k_autorizza
st_tab_sr_prof_funz kst_tab_sr_prof_funz
datawindowchild kdw_1, kdw_2, kdw_11, kdw_22


st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.modifica
kst_open_w.id_programma = "az"

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	tab_1.tabpage_4.dw_4.visible = false
	tab_1.tabpage_4.st_non_auth_4.visible = true
//	k_return = "1" + "La funzione richiesta non e' stata abilitata"

else
	tab_1.tabpage_4.dw_4.visible = true
	tab_1.tabpage_4.st_non_auth_4.visible = false

	if tab_1.tabpage_4.dw_4.rowcount( ) = 0 then
	
		k_rc=tab_1.tabpage_4.dw_4.retrieve()  
		tab_1.tabpage_4.dw_4.getchild( "email_codice",kdw_1)
		tab_1.tabpage_4.dw_4.getchild( "email_codice_1",kdw_2)
		tab_1.tabpage_4.dw_4.getchild( "id_email_lettera_fattura",kdw_11)
		tab_1.tabpage_4.dw_4.getchild( "id_email_lettera_avviso",kdw_22)
		kdw_1.settransobject( sqlca)
		kdw_2.settransobject( sqlca)
		kdw_2.reset( )
		kdw_1.reset( )
		kdw_2.reset( )
		kdw_1.retrieve("%")
		kdw_2.retrieve("%")
		kdw_1.insertrow(1)
		kdw_2.insertrow(1)
		kdw_11 = kdw_1
		kdw_22 = kdw_2

		if len(trim(tab_1.tabpage_4.dw_4.getitemstring(1, "smtp_port"))) = 0 then
			tab_1.tabpage_4.dw_4.setitem(1, "smtp_port", "25")
		end if
	
		tab_1.tabpage_4.dw_4.resetupdate( )
	end if				
					
	
	attiva_tasti()
	tab_1.tabpage_4.dw_4.VScrollBar = TRUE
	tab_1.tabpage_4.dw_4.setredraw(true)
	if tab_1.tabpage_4.dw_4.rowcount() = 0 then
		tab_1.tabpage_4.dw_4.insertrow(0) 
		tab_1.tabpage_4.dw_4.resetupdate( )
	end if
end if
	

tab_1.tabpage_4.dw_4.setfocus()
	
	

end subroutine

private subroutine get_path_centrale ();//
string k_path=".."
int k_ret


k_path = tab_1.tabpage_4.dw_4.getitemstring (1, "path_centrale")
if len(trim(k_path)) > 0 then
else
	k_path=".."
end if

k_ret = GetFolder ( "Scegliere la cartella del Server Centrale utile per raggiungere le risorse utili a tutti gli utenti", k_path )

if k_ret = 1 then
	tab_1.tabpage_4.dw_4.setitem(1, "path_centrale", trim(k_path))
else
	if k_ret < 0 then
//--- ERRORE	
	end if
end if


end subroutine

private subroutine get_path_pgm_upd ();//
string k_path=".."
int k_ret


k_path = tab_1.tabpage_4.dw_4.getitemstring (1, "path_pgm_upd")
if len(trim(k_path)) > 0 then
else
	k_path=".."
end if

k_ret = GetFolder ( "Scegliere la cartella dove trovare gli aggiornamenti della Procedura ", k_path )

if k_ret = 1 then
	tab_1.tabpage_4.dw_4.setitem(1, "path_pgm_upd", trim(k_path))
else
	if k_ret < 0 then
//--- ERRORE	
	end if
end if


end subroutine

protected subroutine open_start_window ();//
kiuf_stampe = create kuf_stampe

//tab_1.tabpage_7.picturename = kguo_path.get_risorse() + "\pklist.ico"
tab_1.tabpage_4.dw_4.object.p_esempio_piede_fattura.filename = kguo_path.get_risorse() + "\fatt_piede.png"

end subroutine

public function st_esito scrivi_base ();//
//=== Aggiorna il BASE
//
kuf_base  kuf1_base
string k_record
string k_errore="0 "
string k_text, k_dati_id
int k_len, k_len_1, k_punt, k_ctr, k_ctr_1, k_errore_1=0, k_errore_agg=0
st_tab_base kst_tab_base
st_esito kst_esito

try
//tab_1.tabpage_personale.dw_dett_0.accepttext()

		kst_esito.esito = kkg_esito.ok

		k_errore_1 = tab_1.tabpage_4.dw_4.update()
	
		if k_errore_1 > 0 then
			
			kguo_g.E1MCU = tab_1.tabpage_4.dw_4.object.e1mcu[1]   //imposta il codice (azienda) facility di E1
			
			kuf1_base = create kuf_base
			
//--- reimposta il flag con E1 (magari è cambiato)			
			if kuf1_base.if_e1_enabled( ) then
				kguo_g.set_e1_enabled(true)
			else
				kguo_g.set_e1_enabled(false)
			end if
			
//--- dati Fatture
			kst_tab_base.id_base = tab_1.tabpage_4.dw_4.object.id[1]
			kst_tab_base.fatt_bolli_lim_stampa = tab_1.tabpage_4.dw_4.object.base_fatt_bolli_lim_stampa[1] 
			kst_tab_base.fatt_bolli_note = tab_1.tabpage_4.dw_4.object.base_fatt_bolli_note[1] 
			kst_tab_base.fatt_banca = tab_1.tabpage_4.dw_4.object.base_fatt_banca[1] 
			kst_tab_base.id_email_lettera_fattura = tab_1.tabpage_4.dw_4.object.id_email_lettera_fattura[1] 
			kst_tab_base.id_email_lettera_avviso = tab_1.tabpage_4.dw_4.object.id_email_lettera_avviso[1] 
			kst_tab_base.fatt_comunicazione_attiva = tab_1.tabpage_4.dw_4.object.base_fatt_comunicazione_attiva[1] 
			kst_tab_base.fatt_comunicazione = tab_1.tabpage_4.dw_4.object.base_fatt_comunicazione[1] 
			kst_tab_base.esolver_fidi_id_meca_causale = 0 //OBSOLETO tab_1.tabpage_4.dw_4.object.esolver_fidi_id_meca_causale[1] 
			kst_tab_base.ddt_qtna_note = tab_1.tabpage_4.dw_4.object.ddt_qtna_note[1]
			kst_tab_base.ddt_blk_lotti_senza_attestato = tab_1.tabpage_4.dw_4.object.ddt_blk_lotti_senza_attestato[1]
			if isnull (tab_1.tabpage_4.dw_4.object.base_fatt_impon_minimo[1] ) then
				kst_tab_base.fatt_impon_minimo = 0
			else
				kst_tab_base.fatt_impon_minimo = tab_1.tabpage_4.dw_4.object.base_fatt_impon_minimo[1] 
			end if
			kst_tab_base.sv_call_vettore_id_listino = tab_1.tabpage_4.dw_4.object.base_fatt_sv_call_vettore_id_listino[1]
			kst_tab_base.e1_id_listino_dsm_tof554701_f = tab_1.tabpage_4.dw_4.object.e1_id_listino_dsm_tof554701_f[1]
			kst_tab_base.e1_id_listino_dsm_tof554701 = tab_1.tabpage_4.dw_4.object.e1_id_listino_dsm_tof554701[1]

			kst_tab_base.st_tab_g_0.esegui_commit = "N" 
			kst_esito = kuf1_base.tb_update_base_fatt(kst_tab_base) 

			if kst_esito.esito <> kkg_esito.db_ko then 
			
//--- dati smtp			
				kst_tab_base.id_base = tab_1.tabpage_4.dw_4.object.id[1]
				kst_tab_base.smtp_autorizz_rich = tab_1.tabpage_4.dw_4.object.smtp_autorizz_rich[1] 
				kst_tab_base.smtp_logfile = tab_1.tabpage_4.dw_4.object.smtp_logfile[1] 
				kst_tab_base.smtp_port = tab_1.tabpage_4.dw_4.object.smtp_port[1] 
				kst_tab_base.smtp_pwd = tab_1.tabpage_4.dw_4.object.smtp_pwd[1] 
				kst_tab_base.smtp_user = tab_1.tabpage_4.dw_4.object.smtp_user[1] 
				kst_tab_base.smtp_server = tab_1.tabpage_4.dw_4.object.smtp_server[1] 
				kst_tab_base.st_tab_g_0.esegui_commit = "N" 
				kst_esito = kuf1_base.tb_update_base_smtp(kst_tab_base) 

//--- dati Cartelle
				kst_tab_base.id_base = trim(tab_1.tabpage_4.dw_4.object.id[1])
				kst_tab_base.dir_fatt = trim(tab_1.tabpage_4.dw_4.object.dir_fatt[1]) 
				kst_tab_base.doc_root = tab_1.tabpage_4.dw_4.object.doc_root[1] 
				kst_tab_base.esolver_expanag_dir = "" //OBSOLETO trim(tab_1.tabpage_4.dw_4.object.esolver_expanag_dir[1]) 
				kst_tab_base.esolver_expanag_nome = "" //OBSOLETO trim(tab_1.tabpage_4.dw_4.object.esolver_expanag_nome[1]) 
				kst_tab_base.esolver_fidi_dir = "" //OBSOLETO trim(tab_1.tabpage_4.dw_4.object.esolver_fidi_dir[1]) 
				kst_tab_base.esolver_expfidi_nome = "" //OBSOLETO trim(tab_1.tabpage_4.dw_4.object.esolver_expfidi_nome[1]) 
				kst_tab_base.esolver_inpfidi_nome = "" //OBSOLETO trim(tab_1.tabpage_4.dw_4.object.esolver_inpfidi_nome[1]) 
				kst_tab_base.dir_ddt = ""
				kst_tab_base.e1dtlav_allineagg = tab_1.tabpage_4.dw_4.getitemnumber(1, "e1dtlav_allineagg")
				kst_tab_base.dir_report_pilota = tab_1.tabpage_4.dw_4.getitemstring(1, "dir_report_pilota")
				kst_tab_base.report_export_dir = tab_1.tabpage_4.dw_4.getitemstring(1, "report_export_dir")
				kst_tab_base.st_tab_g_0.esegui_commit = "N" 
				kst_esito = kuf1_base.tb_update_base_dir(kst_tab_base) 
			
			
//--- dati GMT			
				kst_tab_base.id_base = tab_1.tabpage_4.dw_4.object.id[1]
				kst_tab_base.utc_fuso = tab_1.tabpage_4.dw_4.object.utc_fuso[1] 
				kst_tab_base.oralegale_on = tab_1.tabpage_4.dw_4.object.oralegale_on[1] 
				kst_tab_base.oralegale_start = tab_1.tabpage_4.dw_4.object.oralegale_start[1] 
				kst_tab_base.oralegale_end = tab_1.tabpage_4.dw_4.object.oralegale_end[1] 
				kst_tab_base.st_tab_g_0.esegui_commit = "N" 
				kst_esito = kuf1_base.tb_update_base_gmt(kst_tab_base) 

				kguo_sqlca_db_magazzino.db_commit( )
				
//--- Reimposta le Variabli Globali dei Dati di Ora legale e UTC 	
				kuf1_base.set_oralegale_utc()
				
				tab_1.tabpage_4.dw_4.setitemstatus(1, 0, primary!, NotModified!)	
			else
				
				kguo_sqlca_db_magazzino.db_rollback( )
				k_errore_agg = 1
				messagebox("Archivio 'Proprietà Procedura' Non Aggiornato (errore base_fatt):", trim(kst_esito.SQLErrText), &
								stopsign!, ok!) 
			end if
			
			
		ELSE
			kguo_sqlca_db_magazzino.db_rollback( )
	
			k_errore_agg = 1
			messagebox("Archivio 'Proprietà Procedura' Non Aggiornato:", trim(sqlca.SQLErrText), &
							stopsign!, ok!) 
		end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()

finally
	if isvalid(kuf1_base) then	destroy kuf1_base


end try

//
//if	k_errore_agg = 0 then
//
//	cb_ritorna.triggerevent (clicked!)
//
//end if

return kst_esito

end function

protected subroutine inizializza_4 () throws uo_exception;//
//======================================================================
//=== Inizializzazione del TAB 4 controllandone i valori se gia' presenti
//======================================================================
//
int k_rc=0
double k_dose 
string k_codice_attuale, k_codice_prec
boolean k_autorizza
st_tab_sr_prof_funz kst_tab_sr_prof_funz

st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza


kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.modifica
kst_open_w.id_programma = "az"

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	tab_1.tabpage_5.dw_5.visible = false
	tab_1.tabpage_5.st_non_auth_5.visible = true
//	k_return = "1" + "La funzione richiesta non e' stata abilitata"

else
	tab_1.tabpage_5.dw_5.visible = true
	tab_1.tabpage_5.st_non_auth_5.visible = false

	k_rc=tab_1.tabpage_5.dw_5.retrieve()  
	
	attiva_tasti()
	if tab_1.tabpage_5.dw_5.rowcount() = 0 then
		tab_1.tabpage_5.dw_5.insertrow(0) 
	end if
	tab_1.tabpage_5.dw_5.resetupdate( )
end if
	

tab_1.tabpage_5.dw_5.setfocus()
	
	


end subroutine

private subroutine get_path_fatt ();//
string k_path=".."
int k_ret


k_path = tab_1.tabpage_4.dw_4.getitemstring (1, "dir_fatt")
if len(trim(k_path)) > 0 then
else
	k_path=".."
end if

k_ret = GetFolder ( "Scegli Cartella per le Fatture", k_path )

if k_ret = 1 then
	tab_1.tabpage_4.dw_4.setitem(1, "dir_fatt", trim(k_path))
else
	if k_ret < 0 then
//--- ERRORE	
	end if
end if


end subroutine

protected subroutine inizializza_12 () throws uo_exception;//
//======================================================================
//=== Inizializzazione del TAB 13 controllandone i valori se gia' presenti
//======================================================================
//
int k_rc=0, k_anno
string k_codice_attuale, k_codice_prec
//st_tab_sr_prof_funz kst_tab_sr_prof_funz
//boolean k_autorizza
//st_open_w kst_open_w
//kuf_sicurezza kuf1_sicurezza
//
//
//kst_open_w = kst_open_w
//kst_open_w.flag_modalita = kkg_flag_modalita.modifica
//kst_open_w.id_programma = "az"
//
////--- controlla se utente autorizzato alla funzione in atto
//kuf1_sicurezza = create kuf_sicurezza
//k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
//destroy kuf1_sicurezza
//
//if not k_autorizza then
//
//	tab_1.tabpage_13.dw_13.visible = false
//	tab_1.tabpage_13.st_non_auth_13.visible = true
//
//else
	tab_1.tabpage_13.dw_13.visible = true
	tab_1.tabpage_13.st_non_auth_13.visible = false

	if tab_1.tabpage_13.dw_13.rowcount() = 0 then
		tab_1.tabpage_13.dw_13.insertrow(0) 
		tab_1.tabpage_13.dw_13.setitem(1, "anno", year(kguo_g.get_dataoggi()) )
		tab_1.tabpage_13.dw_13.resetupdate( )
	end if
	
	attiva_tasti()

	tab_1.tabpage_13.cb_monitor.enabled = true
	tab_1.tabpage_13.pb_st_esiti_operazioni.enabled = true
	
//end if
tab_1.tabpage_13.dw_13.setfocus()
	
	


end subroutine

protected subroutine inizializza_11 () throws uo_exception;//
//======================================================================
//=== Inizializzazione del TAB 13 controllandone i valori se gia' presenti
//======================================================================
//
int k_rc=0, k_anno, k_file
long k_byte, k_riga
string k_codice_attuale, k_codice_prec, k_record, k_filerec, k_filetemp
boolean k_eof = false
datastore kds_1
st_log_msg_xml kst_log_msg_xml
pbdom_builder kpbdom_builder
PBDOM_ATTRIBUTE kPBDOM_ATTRIBUTE 
PBDOM_Document kpbdom_doc
PBDOM_Element kpbdom_el_root, kpbdom_el_node1, kpbdom_el_node11[], kpbdom_el_node1111, kpbdom_el_node11111
PBDOM_PROCESSINGINSTRUCTION kpbdom_proc


//--- Clessidra di attesa
setpointer(kkg.pointer_attesa)

try
	
	kpbdom_builder = create pbdom_builder		
	
//	kpbdom_proc = create PBDOM_PROCESSINGINSTRUCTION
	kpbdom_el_node1 = create PBDOM_Element
	kPBDOM_ATTRIBUTE = create PBDOM_ATTRIBUTE 
//	kpbdom_el_node11[] = create PBDOM_Element []
	kpbdom_el_root = create PBDOM_Element
//	kpbdom_el_node1111 = create PBDOM_Element
//	kpbdom_el_node11111 = create PBDOM_Element

	tab_1.tabpage_12.dw_12.visible = true

	if tab_1.tabpage_12.dw_12.rowcount() = 0 then
		
		tab_1.tabpage_12.dw_12.object.file.Expression = "trim('" + kguo_path.get_nome_path_file_errori_xml() + "')"
		tab_1.tabpage_12.dw_12.object.k_u_id.Expression = "trim('" + string(kguo_utente.get_id_utente( )) + "')"
		
		k_filetemp = kguo_path.get_temp( ) + kguo_path.get_nome_file_errori_xml()
		k_rc = filecopy(kguo_path.get_nome_path_file_errori_xml( ), k_filetemp, true)
		
		if k_rc < 0 then

			kguo_exception.inizializza( )
			kguo_exception.setmessage( "Visualizzazione LOG", "Errore durante Copia del file di LOG da" &
			                          + kguo_path.get_nome_path_file_errori_xml( ) &
			                          + " a " + kguo_path.get_temp( ))
			throw kguo_exception
		
		else
			
			kds_1 = create datastore
			kds_1.dataobject = tab_1.tabpage_12.dw_12.dataobject
			kds_1.reset( )
			
			k_file = fileopen(k_filetemp , linemode!, read!, Shared!)

//--- legge il primo tag <Istanza> completo
			k_byte = FileReadEx(k_file, k_filerec)
			do while k_byte > 0 and left(k_filerec, 8) <> "<Istanza" 
				k_byte = FileReadEx(k_file, k_filerec)
			loop
			if k_byte < 0 then 
				k_eof = true
			else
				k_record = k_filerec
				do while k_byte > -1 and left(k_filerec, 8) <> "<Istanza" 
					k_byte = FileReadEx(k_file, k_filerec)
				loop
			end if
			
			do while not k_eof 
				
				kpbdom_doc = CREATE PBDOM_Document
				
		//--- parse della riga LOG 
				kpbdom_doc = kpbdom_builder.BuildFromString (k_record)
				kpbdom_el_node1 = kpbdom_doc.GetRootElement() 
				kpbdom_doc.getelementsbytagname("Istanza", kpbdom_el_node11[])
				if upperbound(kpbdom_el_node11[]) > 0 then
					kPBDOM_ATTRIBUTE = kpbdom_el_node11[1].getattribute("id")
					kst_log_msg_xml.i_id = kPBDOM_ATTRIBUTE.gettexttrim( )
					kPBDOM_ATTRIBUTE = kpbdom_el_node11[1].getattribute("data")
					kst_log_msg_xml.i_data = kPBDOM_ATTRIBUTE.gettexttrim( )
					kPBDOM_ATTRIBUTE = kpbdom_el_node11[1].getattribute("M2000")
					kst_log_msg_xml.i_m2000 = kPBDOM_ATTRIBUTE.gettexttrim( )
					
					kpbdom_doc.getelementsbytagname("Messaggio", kpbdom_el_node11[])
					kPBDOM_ATTRIBUTE = kpbdom_el_node11[1].getattribute("tipo")
					if isvalid(kPBDOM_ATTRIBUTE) then
						kst_log_msg_xml.m_tipo = kPBDOM_ATTRIBUTE.gettexttrim( )
					end if
					
					kpbdom_doc.getelementsbytagname("NomePC", kpbdom_el_node11[])
					kst_log_msg_xml.nomepc = kpbdom_el_node11[1].gettext( )
					
					kpbdom_doc.getelementsbytagname("Utente", kpbdom_el_node11[])
					kPBDOM_ATTRIBUTE = kpbdom_el_node11[1].getattribute("id")			
					kst_log_msg_xml.u_id = kPBDOM_ATTRIBUTE.gettexttrim( )
					if IsNumber (kst_log_msg_xml.u_id) then
						kst_log_msg_xml.u_id = string(long(kst_log_msg_xml.u_id), "#")
					end if
					kst_log_msg_xml.utente = kpbdom_el_node11[1].gettext( )
					
					kpbdom_doc.getelementsbytagname("Esito", kpbdom_el_node11[])
					kPBDOM_ATTRIBUTE = kpbdom_el_node11[1].getattribute("cod")			
					kst_log_msg_xml.e_cod = kPBDOM_ATTRIBUTE.gettexttrim( )
					kst_log_msg_xml.esito = kpbdom_el_node11[1].gettext( )
					
					kpbdom_doc.getelementsbytagname("Segnalazione", kpbdom_el_node11[])
					kPBDOM_ATTRIBUTE = kpbdom_el_node11[1].getattribute("sqlcode")			
					kst_log_msg_xml.s_sqlcode = kPBDOM_ATTRIBUTE.gettexttrim( )
					if IsNumber (kst_log_msg_xml.s_sqlcode) then
						kst_log_msg_xml.s_sqlcode = string(long(kst_log_msg_xml.s_sqlcode), "#")
					end if
					kst_log_msg_xml.segnalazione = kpbdom_el_node11[1].gettext( )
					
					kpbdom_doc.getelementsbytagname("Oggetto", kpbdom_el_node11[])
					kst_log_msg_xml.oggetto = kpbdom_el_node11[1].gettext( )		
			
					k_riga = kds_1.insertrow(0)
					kds_1.setitem( k_riga, "progr", k_riga )
					kds_1.setitem( k_riga, "i_id", kst_log_msg_xml.i_id )
					kds_1.setitem( k_riga, "i_data", kst_log_msg_xml.i_data )
					kds_1.setitem( k_riga, "i_m2000", kst_log_msg_xml.i_m2000 )
					kds_1.setitem( k_riga, "nomepc", kst_log_msg_xml.nomepc )
					kds_1.setitem( k_riga, "u_id", kst_log_msg_xml.u_id )
					kds_1.setitem( k_riga, "utente", kst_log_msg_xml.utente )
					kds_1.setitem( k_riga, "oggetto", kst_log_msg_xml.oggetto )
					kds_1.setitem( k_riga, "segnalazione", trim(kst_log_msg_xml.segnalazione) )
					kds_1.setitem( k_riga, "s_sqlcode", kst_log_msg_xml.s_sqlcode )
					kds_1.setitem( k_riga, "esito", trim(kst_log_msg_xml.esito) )
					kds_1.setitem( k_riga, "e_cod", kst_log_msg_xml.e_cod )
					kds_1.setitem( k_riga, "m_tipo", kst_log_msg_xml.m_tipo )
				end if
	
	//--- leggo XML <Istanza> successivo (lo compongo se su più righe)
				if k_record <> k_filerec then k_record = k_filerec
				k_byte = FileReadEx(k_file, k_filerec)
				do while k_byte > -1 and left(k_filerec, 8) <> "<Istanza" 
					k_record += k_filerec
					k_byte = FileReadEx(k_file, k_filerec)
				loop
				if k_byte < 0 then k_eof = true
				
				if isvalid(kpbdom_doc) then destroy kpbdom_doc
			loop
	
			kds_1.rowscopy( 1, kds_1.rowcount(), primary!, tab_1.tabpage_12.dw_12, 1, primary!)
			
			//tab_1.tabpage_12.dw_12.ImportFile(XML!,"D:\gammarad\pb_gmmrd126\m2000_errori_t.xml")  
			tab_1.tabpage_12.dw_12.resetupdate( )
		end if
	end if
	

CATCH ( PBDOM_Exception pbde )
//	kguo_exception.inizializza( )
//	kguo_exception.setmessage( "Errore durante Generazione XML", pbde.getmessage() )
//	throw kguo_exception
	
catch (uo_exception kuo_exception) 
//	throw kuo_exception
	
finally
	if k_file > 0 then
		fileclose(k_file)
	end if
	if isvalid(kpbdom_doc) then destroy kpbdom_doc
	if isvalid(kpbdom_el_node1) then destroy kpbdom_el_node1
//	if isvalid(kpbdom_el_node11) then destroy kpbdom_el_node11
	if isvalid(kpbdom_el_root) then destroy kpbdom_el_root
	if isvalid(kpbdom_el_node1111) then destroy kpbdom_el_node1111
	if isvalid(kpbdom_el_node11111) then destroy kpbdom_el_node11111

	attiva_tasti()

	tab_1.tabpage_12.dw_12.VScrollBar = TRUE
	tab_1.tabpage_12.dw_12.setredraw(true)
	tab_1.tabpage_12.dw_12.setfocus()
	setpointer(kkg.pointer_default)

end try


	
//end if
	
	


end subroutine

private subroutine get_dosimetro_ult_barcode ();//
kuf_meca_dosim kuf1_meca_dosim
st_tab_base kst_tab_base 

try
	kuf1_meca_dosim = create kuf_meca_dosim
	
	kst_tab_base.dosimetro_barcode_mask = trim(tab_1.tabpage_4.dw_4.getitemstring(1, "dosimetro_barcode_mask"))
	if len(kst_tab_base.dosimetro_barcode_mask) = 0 or isnull(kst_tab_base.dosimetro_barcode_mask) then kst_tab_base.dosimetro_barcode_mask = "DSM"

	kst_tab_base.dosimetro_ult_barcode = kuf1_meca_dosim.get_ultimo_numero_barcode_da_tab(kst_tab_base.dosimetro_barcode_mask )  // Ultimo Barcode caricato

	if len(trim(kst_tab_base.dosimetro_ult_barcode)) = 0 or isnull(kst_tab_base.dosimetro_ult_barcode) then
		kst_tab_base.dosimetro_ult_barcode = "AA000000"
	end if

	tab_1.tabpage_4.dw_4.setitem(1, "dosimetro_ult_barcode", trim(kst_tab_base.dosimetro_ult_barcode))

catch (uo_exception kuo_exception)	
	kuo_exception.messaggio_utente()

finally
	destroy kuf1_meca_dosim
	
end try

end subroutine

private subroutine get_path_doc_root ();//
string k_path=".."
int k_ret


k_path = tab_1.tabpage_4.dw_4.getitemstring (1, "doc_root")
if len(trim(k_path)) > 0 then
else
	k_path=".."
end if
k_ret = GetFolder ( "Scegliere la cartella radice per l'archiviazione dei documenti elettronici", k_path )

if k_ret = 1 then
	tab_1.tabpage_4.dw_4.setitem(1, "doc_root", trim(k_path))
else
	if k_ret < 0 then
//--- ERRORE	
	end if
end if




end subroutine

private subroutine popola_dw_2 ();//
//=== Legge parametri dal arch. di config
//
int k_riga_user
string k_nome_db, k_parametro_db, k_path_db, k_path_dw, k_server="?", k_dbversione="?"
string k_esito=""
datastore kds_1
kuf_base kuf1_base
kuf_utility kuf1_utility


	try
		kuf1_base = create kuf_base
		kuf1_utility = create kuf_utility
		kds_1 = create datastore
		
		kds_1.dataobject = "ds_current_user"
		kds_1.settransobject( kguo_sqlca_db_magazzino )
		k_riga_user = kds_1.retrieve( )
	
		k_parametro_db = trim ( kguo_sqlca_db_magazzino.DBParm )
		k_path_dw = trim(kGuf_data_base.profilestring_leggi_scrivi(kGuf_data_base.ki_profilestring_operazione_leggi, "arch_saveas", ""))
//		k_path_dw = profilestring ( KG_PATH_PROCEDURA + "\confdb.ini", "ambiente", "arch_saveas", "<NULLA>")
		k_path_db = trim(kGuf_data_base.profilestring_leggi_scrivi(kGuf_data_base.ki_profilestring_operazione_leggi, "arch_base", ""))
//		k_path_db = profilestring ( KG_PATH_PROCEDURA + "\confdb.ini", "ambiente", "arch_base", "<NULLA>")
		k_esito = kuf1_base.prendi_dato_base( "nome_server")
		if left(k_esito,1) = "0" then k_server	= trim(mid(k_esito,2))
		k_esito = kuf1_base.prendi_dato_base( "versione_db")
		if left(k_esito,1) = "0" then k_dbversione	= trim(mid(k_esito,2))
		
	
		tab_1.tabpage_2.dw_2.insertrow(0)
		tab_1.tabpage_2.dw_2.setitem(1, "dbms", trim(kguo_sqlca_db_magazzino.dbms)) 
		tab_1.tabpage_2.dw_2.setitem(1, "nome_db", trim(kguo_sqlca_db_magazzino.database) + " / " + trim(sqlca.servername )) // trim(k_nome_db))
		tab_1.tabpage_2.dw_2.setitem(1, "param_db", trim(kguo_sqlca_db_magazzino.dbparm)) // trim(k_parametro_db))
		tab_1.tabpage_2.dw_2.setitem(1, "path_db", trim(k_path_db))
		tab_1.tabpage_2.dw_2.setitem(1, "path_prog", trim(KG_PATH_PROCEDURA))
		tab_1.tabpage_2.dw_2.setitem(1, "path_files_dat", trim(k_path_dw))
		tab_1.tabpage_2.dw_2.setitem(1, "server", trim(k_server))
		tab_1.tabpage_2.dw_2.setitem(1, "dbversione", trim(k_dbversione))
		tab_1.tabpage_2.dw_2.setitem(1, "pc_name", trim(kuf1_utility.u_nome_computer()))
		if k_riga_user > 0 then
			tab_1.tabpage_2.dw_2.setitem(1, "user", trim(kds_1.getitemstring(1, "current_user")))
		else
			tab_1.tabpage_2.dw_2.setitem(1, "user", "NON RICONOSCIUTO")
		end if

		

		tab_1.tabpage_2.dw_2.resetupdate()
		
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
	finally		
		if isvalid(kuf1_base) then destroy kuf1_base
		if isvalid(kuf1_base) then destroy kuf1_utility
		if isvalid(kds_1) then destroy kds_1
		
	end try

end subroutine

private subroutine get_path_esolver_anag ();//
string k_path=".."
int k_ret


k_path = tab_1.tabpage_4.dw_4.getitemstring (1, "esolver_expanag_dir")
if len(trim(k_path)) > 0 then
else
	k_path=".."
end if

k_ret = GetFolder ( "Scegli Cartella per le Anagrafiche da esportare a ESOLVER", k_path )

if k_ret = 1 then
	tab_1.tabpage_4.dw_4.setitem(1, "esolver_expanag_dir", trim(k_path))
else
	if k_ret < 0 then
//--- ERRORE	
	end if
end if


end subroutine

private subroutine get_path_esolver_fidi ();//
string k_path=".."
int k_ret


k_path = tab_1.tabpage_4.dw_4.getitemstring (1, "esolver_fidi_dir")
if len(trim(k_path)) > 0 then
else
	k_path=".."
end if

k_ret = GetFolder ( "Scegli Cartella di scambio dati FIDO con ESOLVER", k_path )

if k_ret = 1 then
	tab_1.tabpage_4.dw_4.setitem(1, "esolver_fidi_dir", trim(k_path))
else
	if k_ret < 0 then
//--- ERRORE	
	end if
end if


end subroutine

public subroutine u_resize ();//
long kk_width=0, kk_height= 0

	super::u_resize()
 

 //--- per un bug di PB sono costretto a fare questo per far vedere le barre
	 	if tab_1.tabposition <> tabsonleft! and tab_1.height - tab_1.tabpage_10.height - 120 < 0 then 
			kk_height = 120	
		end if
		if tab_1.tabposition = tabsonleft! and tab_1.width - tab_1.tabpage_10.width - 950 < 0 then 
			kk_width = 950
		end if
	
	if tab_1.tabpage_10.dw_10.enabled then
		tab_1.tabpage_10.dw_10.width = tab_1.tabpage_10.width - kk_width
		tab_1.tabpage_10.dw_10.height = tab_1.tabpage_10.height - kk_height
		tab_1.tabpage_10.dw_10.x =  1// (tab_1.tabpage_5.width - tab_1.tabpage_5.dw_5.width) / 2
		tab_1.tabpage_10.dw_10.y =  1// (tab_1.tabpage_5.height - tab_1.tabpage_5.dw_5.height) / 2
	end if
//
	if tab_1.tabpage_11.dw_11.enabled then
		tab_1.tabpage_11.dw_11.width = tab_1.tabpage_11.width - kk_width
		tab_1.tabpage_11.dw_11.height = tab_1.tabpage_11.height - kk_height
		tab_1.tabpage_11.dw_11.x =  1// (tab_1.tabpage_5.width - tab_1.tabpage_5.dw_5.width) / 2
		tab_1.tabpage_11.dw_11.y =  1// (tab_1.tabpage_5.height - tab_1.tabpage_5.dw_5.height) / 2
	end if
//
	if tab_1.tabpage_12.dw_12.enabled then
		tab_1.tabpage_12.dw_12.width = tab_1.tabpage_12.width - kk_width
		tab_1.tabpage_12.dw_12.height = tab_1.tabpage_12.height - kk_height
		tab_1.tabpage_12.dw_12.x =  1// (tab_1.tabpage_5.width - tab_1.tabpage_5.dw_5.width) / 2
		tab_1.tabpage_12.dw_12.y =  1// (tab_1.tabpage_5.height - tab_1.tabpage_5.dw_5.height) / 2
	end if
//
	if tab_1.tabpage_13.dw_13.enabled then
//		tab_1.tabpage_13.dw_13.width = tab_1.tabpage_13.width - kk_width
//		tab_1.tabpage_13.dw_13.height = tab_1.tabpage_13.height - kk_height
		tab_1.tabpage_13.dw_13.x =  1// (tab_1.tabpage_5.width - tab_1.tabpage_5.dw_5.width) / 2
		tab_1.tabpage_13.dw_13.y =  1// (tab_1.tabpage_5.height - tab_1.tabpage_5.dw_5.height) / 2
	end if

end subroutine

public subroutine u_avvia_check_db ();//--- lancia operazioni di controllo dei dati sul db
boolean k_ok=true
string k_rc = ""
int k_anno
st_monitor_dati_db kst_monitor_dati_db
kuf_chk_db kuf1_chk_db


try
	tab_1.tabpage_13.cb_monitor.enabled = false
	setpointer(kkg.pointer_attesa)
	tab_1.tabpage_13.dw_13.accepttext( )
	k_anno = tab_1.tabpage_13.dw_13.getitemnumber(1, "anno")
	kst_monitor_dati_db.data_inizio = date(k_anno, 01, 01)
	kst_monitor_dati_db.data_fine = date(k_anno, 12, 31)
	
	kuf1_chk_db = create kuf_chk_db

	kst_monitor_dati_db.check_entrate = true
	kst_monitor_dati_db.check_ddt = true
	kst_monitor_dati_db.check_fatture = true
	
	k_ok = kuf1_chk_db.u_monitor_dati_db(kst_monitor_dati_db)
		
	if kst_monitor_dati_db.esito_check_entrate then
		k_rc = tab_1.tabpage_13.dw_13.modify("p_img_faccinaok_r.visible = '1'")
		k_rc = tab_1.tabpage_13.dw_13.modify("p_img_faccinako_r.visible = '0'")
	else
		k_rc = tab_1.tabpage_13.dw_13.modify("p_img_faccinaok_r.visible = '0'")
		k_rc = tab_1.tabpage_13.dw_13.modify("p_img_faccinako_r.visible = '1'")
	end if
	if kst_monitor_dati_db.esito_check_ddt then
		k_rc = tab_1.tabpage_13.dw_13.modify("p_img_faccinaok_b.visible = '1'")
		k_rc = tab_1.tabpage_13.dw_13.modify("p_img_faccinako_b.visible = '0'")
	else
		k_rc = tab_1.tabpage_13.dw_13.modify("p_img_faccinaok_b.visible = '0'")
		k_rc = tab_1.tabpage_13.dw_13.modify("p_img_faccinako_b.visible = '1'")
	end if
	if kst_monitor_dati_db.esito_check_fatture then
		k_rc = tab_1.tabpage_13.dw_13.modify("p_img_faccinaok_f.visible = '1'")
		k_rc = tab_1.tabpage_13.dw_13.modify("p_img_faccinako_f.visible = '0'")
	else
		k_rc = tab_1.tabpage_13.dw_13.modify("p_img_faccinaok_f.visible = '0'")
		k_rc = tab_1.tabpage_13.dw_13.modify("p_img_faccinako_f.visible = '1'")
	end if
	
	if not k_ok then
		if messagebox("Operazione Terminata", "Sono state riscontrate Anomalie, vuoi Verificare subito gli esiti? Ricorda che i Log degli esiti possono essere esaminati anche successivamente.", question!, yesno!) = 1 then
			u_elenco_esiti(true)
		end if
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()

finally
	setpointer(kkg.pointer_default)
	tab_1.tabpage_13.cb_monitor.enabled = true

end try
	
end subroutine

public subroutine u_elenco_esiti (boolean k_visibile);//
st_open_w kst_open_w
kuf_esito_operazioni kuf1_esito_operazioni
datetime k_ts


if k_visibile then

//	k_ts = datetime(relativedate( kguo_g.get_dataoggi(), - 365))
//	dw_esiti.retrieve(kuf1_esito_operazioni.kki_tipo_operazione_check_tabelle , "S", k_ts  )

	kuf1_esito_operazioni = create kuf_esito_operazioni
	kst_open_w.key1 = kuf1_esito_operazioni.kki_tipo_operazione_check_tabelle
	kst_open_w.key2 = string(datetime(relativedate( kguo_g.get_dataoggi(), - 365)))
	kst_open_w.flag_modalita = kkg_flag_modalita.elenco
	kuf1_esito_operazioni.u_open(kst_open_w)

end if


end subroutine

private subroutine u_call_art_x_no_contratto ();//
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

	kst_tab_meca.clie_3 = 0
	kds_1.dataobject = "d_listino_l_x_no_contratto" 
	kds_1.settransobject(sqlca) 
	kds_1.retrieve(kst_tab_meca.clie_3)
	if kds_1.rowcount() > 0 then
		kuf1_elenco = create kuf_elenco
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
		kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
		kst_open_w.key1 = "Listino Articoli senza Contratto e Cliente " 
		kst_open_w.key2 = trim(kds_1.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = trim(this.title)    //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key12_any = kds_1
		kst_open_w.key7 = kuf1_elenco.ki_esci_dopo_scelta  // esce subito dopo la scelta
		kuf1_elenco.u_open(kst_open_w)
	else
		messagebox("Elenco Dati", "Nessun Listino disponibile. ")
	end if
						
				
SetPointer(kkg.pointer_default )

	



		
		
		


end subroutine

public subroutine u_set_sv_call_vettore_id_listino (st_tab_listino ast_tab_listino);//
//
long k_riga
kuf_listino kuf1_listino


	if ast_tab_listino.id > 0 then
		try
			kuf1_listino = create kuf_listino
			ast_tab_listino.cod_art = kuf1_listino.get_cod_art(ast_tab_listino) 
			kuf1_listino.get_prezzi123(ast_tab_listino) 
			tab_1.tabpage_4.dw_4.setitem(1, "listino_cod_art", ast_tab_listino.cod_art)
			tab_1.tabpage_4.dw_4.setitem(1, "listino_prezzo", ast_tab_listino.prezzo)
			if trim(ast_tab_listino.cod_art) > " " then
				tab_1.tabpage_4.dw_4.setitem(1, "base_fatt_sv_call_vettore_id_listino", ast_tab_listino.id)
			else
				tab_1.tabpage_4.dw_4.setitem(1, "base_fatt_sv_call_vettore_id_listino", 0)
			end if
			
		catch (uo_exception kuo_exception)
			kuo_exception.messaggio_utente()

		finally
			destroy kuf1_listino
		end try
		
							
	end if
		
end subroutine

public function string u_attiva_tab (integer a_tab_da_attivare);//
//--- Out: ""=OK;  "E" = Uscita Immediata
//
string k_return = ""
string k_rc_inizializza = ""

try 
	

	dati_modif_accept( )

	if a_tab_da_attivare > 0 then

//=== Puntatore Cursore da attesa..... 
		SetPointer(kkg.pointer_attesa)

		choose case a_tab_da_attivare 
			case 1 
				k_rc_inizializza = inizializza()
//				kidw_tabselezionato = tab_1.tabpage_1.dw_1
			case 2
				inizializza_1()
//				kidw_tabselezionato = tab_1.tabpage_2.dw_2
			case 3
				inizializza_2()
//				kidw_tabselezionato = tab_1.tabpage_3.dw_3
			case 4
				inizializza_3()
//				kidw_tabselezionato = tab_1.tabpage_4.dw_4
			case 5
				inizializza_4()
//				kidw_tabselezionato = tab_1.tabpage_5.dw_5
			case 6
				inizializza_5()
//				kidw_tabselezionato = tab_1.tabpage_6.dw_6
			case 7
				inizializza_6()
//				kidw_tabselezionato = tab_1.tabpage_7.dw_7
			case 8
				inizializza_7()
//				kidw_tabselezionato = tab_1.tabpage_8.dw_8
			case 9
				inizializza_8()
//				kidw_tabselezionato = tab_1.tabpage_9.dw_9
//			case 10
//				inizializza_9()
//			case 11
//				inizializza_10()
			case 12
				inizializza_11()
			case 13
				inizializza_12()
		end choose	
		
		if trim(k_rc_inizializza) <> "E" then //E=Uscita Immediata
		
			attiva_tasti()
			
			riposiziona_cursore()   // rimette la riga selezionata che c'era in precedenza
		
			tab_1.visible = true
			
			SetPointer(kkg.pointer_default)
		end if
		
	end if
	
catch (uo_exception kuo_exception1)
	kuo_exception1.messaggio_utente()

finally
		k_return = k_rc_inizializza

	
end try

return k_return

	
end function

protected subroutine stampa_esegui (st_stampe ast_stampe);//
//=== stampa dw
string k_errore, k_titolo=" "


if not isvalid(kidw_selezionata) then
	messagebox("Richiesta Stampa", "Stampa non eseguita, funzione non attiva")
else
	if kidw_selezionata.rowcount() > 0 then
		choose case ki_tab_1_index_new 
			case 1 
				k_titolo = tab_1.tabpage_1.text
			case 2
				k_titolo = tab_1.tabpage_2.text
			case 3
				k_titolo = tab_1.tabpage_3.text
			case 4
				k_titolo = tab_1.tabpage_4.text
			case 5
				k_titolo = tab_1.tabpage_5.text
			case 6
				k_titolo = tab_1.tabpage_6.text
			case 7
				k_titolo = tab_1.tabpage_7.text
			case 8
				k_titolo = tab_1.tabpage_8.text
			case 9
				k_titolo = tab_1.tabpage_9.text
			case 10
				k_titolo = tab_1.tabpage_10.text
			case 11
				k_titolo = tab_1.tabpage_11.text
			case 12
				k_titolo = tab_1.tabpage_12.text
			case else
				k_titolo = "Stampa dati"
		end choose	
	
//		kwindow_1 = kGuf_data_base.prendi_win_attiva()
		
		ast_stampe.dw_print = kidw_selezionata
		ast_stampe.titolo = trim(k_titolo) + " di '" + trim(kiw_this_window.title) + "'"
	
		k_errore = string(kGuf_data_base.stampa_dw(ast_stampe))
	else
		messagebox("Richiesta Stampa", "Stampa non eseguita, nessun dato rilevato da stampare")
	
	end if
end if		
		

end subroutine

protected subroutine attiva_tasti_0 ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================

super::attiva_tasti_0()		 

cb_inserisci.enabled = false
cb_modifica.enabled = false
cb_cancella.enabled = false
cb_visualizza.enabled = false

if ki_tab_1_index_new = 12 then   //tab_1.selectedtab

	st_ordina_lista.enabled = true
	
end if


end subroutine

private subroutine get_path_reportpilota ();//
string k_path=".."
int k_ret


k_path = tab_1.tabpage_4.dw_4.getitemstring (1, "dir_report_pilota")
if len(trim(k_path)) > 0 then
else
	k_path=".."
end if

k_ret = GetFolder ( "Scegliere la cartella dove il 'PILOTA' genera i Report", k_path )

if k_ret = 1 then
	tab_1.tabpage_4.dw_4.setitem(1, "dir_report_pilota", trim(k_path))
else
	if k_ret < 0 then
//--- ERRORE	
	end if
end if


end subroutine

private subroutine get_fgrp_out_path ();//
string k_path=".."
int k_ret


k_path = tab_1.tabpage_4.dw_4.getitemstring (1, "fgrp_out_path")
if len(trim(k_path)) > 0 then
else
	k_path=".."
end if

k_ret = GetFolder ( "Sceglere la cartella dove trovare i 'groupage' generati dal lettore dei barcode", k_path )

if k_ret = 1 then
	tab_1.tabpage_4.dw_4.setitem(1, "fgrp_out_path", trim(k_path))
else
	if k_ret < 0 then
//--- ERRORE	
	end if
end if


end subroutine

private subroutine get_report_export_dir ();//
string k_path=".."
int k_ret


k_path = tab_1.tabpage_4.dw_4.getitemstring (1, "report_export_dir")
if len(trim(k_path)) > 0 then
else
	k_path=".."
end if

k_ret = GetFolder ( "Scegli Cartella dove esportare i Report", k_path )

if k_ret = 1 then
	tab_1.tabpage_4.dw_4.setitem(1, "report_export_dir", trim(k_path))
else
	if k_ret < 0 then
//--- ERRORE	
	end if
end if


end subroutine

on w_base_personale.create
int iCurrent
call super::create
end on

on w_base_personale.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event u_ricevi_da_elenco;call super::u_ricevi_da_elenco;//
int k_return
long k_riga
st_tab_listino kst_tab_listino 
datastore kds_elenco


if isvalid(kst_open_w) then

	if isnumber(kst_open_w.key3) then
		if long(kst_open_w.key3) > 0 then 
			k_riga = long(kst_open_w.key3) 
			kds_elenco = kst_open_w.key12_any 
		
			if kds_elenco.rowcount() > 0 then
				
				choose case kds_elenco.dataobject 
		
					case "d_listino_l_x_no_contratto"  
						tab_1.tabpage_4.dw_4.setitem(1, "listino_cod_art", "")
						tab_1.tabpage_4.dw_4.setitem(1, "listino_prezzo", 0)
						kst_tab_listino.id = kds_elenco.getitemnumber(k_riga, "id_listino")
						if kst_tab_listino.id > 0 then
							k_return = 1
							u_set_sv_call_vettore_id_listino(kst_tab_listino)
							attiva_tasti()
						end if
									
				end choose

			end if
		end if
	end if

end if

return k_return

end event

event close;call super::close;//
if isvalid(kiuf_stampe) then destroy kiuf_stampe

end event

event u_open;call super::u_open;//
string k_scheda = ""

//--- Scheda da visualizzare (se nulla visualizza tutto)
	k_scheda = trim(ki_st_open_w.key2)
	if k_scheda = "utente" then
		tab_1.showpicture = true
		tab_1.showtext = false
		tab_1.tabpage_1.visible = true
		tab_1.tabpage_2.visible = true
		tab_1.tabpage_3.visible = true
	else
		tab_1.showpicture = true
		tab_1.showtext = true
		tab_1.tabpage_1.visible = true
		tab_1.tabpage_2.visible = true
		tab_1.tabpage_3.visible = true
		tab_1.tabpage_4.visible = true
		tab_1.tabpage_5.visible = true
		tab_1.tabpage_6.visible = true
		tab_1.tabpage_7.visible = false
		tab_1.tabpage_8.visible = true
		tab_1.tabpage_9.visible = true
		tab_1.tabpage_10.visible = true
		tab_1.tabpage_11.visible = false
		tab_1.tabpage_12.visible = true
		tab_1.tabpage_13.visible = true
	end if
	

end event

type st_ritorna from w_g_tab_3`st_ritorna within w_base_personale
integer x = 2939
integer y = 1572
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_base_personale
integer x = 914
integer y = 1576
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_base_personale
integer x = 1733
integer y = 1552
integer height = 68
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_base_personale
integer x = 1536
integer y = 1504
end type

type st_stampa from w_g_tab_3`st_stampa within w_base_personale
integer x = 2194
integer y = 1504
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_base_personale
integer x = 2487
integer y = 1536
integer taborder = 60
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_base_personale
integer x = 439
integer y = 1504
integer taborder = 50
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_base_personale
integer x = 805
integer y = 1504
integer taborder = 80
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_base_personale
integer x = 1170
integer y = 1504
integer taborder = 90
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_base_personale
integer x = 73
integer y = 1504
integer taborder = 70
end type

type tab_1 from w_g_tab_3`tab_1 within w_base_personale
integer x = 23
integer width = 2386
integer height = 972
integer taborder = 40
boolean fixedwidth = true
boolean showtext = false
boolean perpendiculartext = true
tabposition tabposition = tabsonleft!
tabpage_10 tabpage_10
tabpage_11 tabpage_11
tabpage_12 tabpage_12
tabpage_13 tabpage_13
end type

event tab_1::selectionchanging;call super::selectionchanging;////
int k_errore_1=0


if oldindex = 5 then
	
	tab_1.tabpage_5.dw_5.accepttext()
	
	//=== Aggiorno BASE
	if tab_1.tabpage_5.dw_5.getitemstatus(1, 0, primary!) = datamodified! or &
			tab_1.tabpage_5.dw_5.getitemstatus(1, 0, primary!) = newmodified! then
		
		k_errore_1 = messagebox("Aggiorna Dati " + trim(tab_1.tabpage_5.text), "Dati Modificati, vuoi Salvare i CONTATORI della Procedura?", question!, YesNo!, 2) 
		if k_errore_1 = 2 then
										
			k_errore_1 = tab_1.tabpage_5.dw_5.reset( )
		else
			
			tab_1.tabpage_5.dw_5.update()
	
		end if
	end if
end if

end event

on tab_1.create
this.tabpage_10=create tabpage_10
this.tabpage_11=create tabpage_11
this.tabpage_12=create tabpage_12
this.tabpage_13=create tabpage_13
call super::create
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6,&
this.tabpage_7,&
this.tabpage_8,&
this.tabpage_9,&
this.tabpage_10,&
this.tabpage_11,&
this.tabpage_12,&
this.tabpage_13}
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_10)
destroy(this.tabpage_11)
destroy(this.tabpage_12)
destroy(this.tabpage_13)
end on

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
integer x = 146
integer y = 16
integer width = 2222
integer height = 940
long backcolor = 67108864
string text = "Personalizza"
long tabbackcolor = 67108864
string picturename = "UserObject5!"
string powertiptext = "impostazioni utente"
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
integer x = 0
integer y = 0
integer width = 2217
integer height = 932
string dataobject = "d_base"
boolean controlmenu = true
boolean hsplitscroll = false
boolean livescroll = false
end type

event dw_1::buttonclicked;call super::buttonclicked;//
if dwo.name = "cb_password" then
	sr_cambia_pwd()
end if

end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
integer x = 146
integer y = 16
integer width = 2222
integer height = 940
long backcolor = 67108864
string text = " la mia Connessione"
long tabbackcolor = 67108864
string picturename = "Database!"
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
integer x = 0
integer y = 0
integer width = 2295
integer height = 832
boolean enabled = true
string dataobject = "d_base_2"
boolean hsplitscroll = false
end type

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
boolean visible = true
integer x = 146
integer y = 16
integer width = 2222
integer height = 940
long backcolor = 67108864
string text = " Messaggi~r~n della Procedura"
long tabbackcolor = 67108864
string picturename = "Error!"
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
end type

on tabpage_3.create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_3
end on

on tabpage_3.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
end on

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
integer x = -18
integer y = 272
integer width = 3035
integer height = 1120
string dataobject = "d_base_err0"
end type

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
integer x = 146
integer y = 16
integer width = 2222
integer height = 940
long backcolor = 67108864
string text = " Proprietà Procedura"
long tabbackcolor = 67108864
string picturename = "Application!"
long picturemaskcolor = 553648127
st_non_auth_4 st_non_auth_4
end type

on tabpage_4.create
this.st_non_auth_4=create st_non_auth_4
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_non_auth_4
end on

on tabpage_4.destroy
call super::destroy
destroy(this.st_non_auth_4)
end on

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
integer x = 41
integer y = 28
integer width = 2939
integer height = 1440
boolean enabled = true
string dataobject = "d_base_gen"
boolean hsplitscroll = false
end type

event dw_4::buttonclicked;call super::buttonclicked;//
//kuf_menu_window kuf1_menu_window
kuf_elenco kiuf_elenco
st_open_w kst_open_w
datastore kds_1


if dwo.name = "b_tab_navigatore" then
	
	//kuf1_menu_window = create kuf_menu_window 
	kst_open_w.id_programma = kkg_id_programma.treeview_tabella
	kst_open_w.flag_primo_giro = "S" //kuf1_menu_window.kki_primo_giro_si
	kst_open_w.flag_modalita = kkg_flag_modalita.modifica
	kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
	kst_open_w.flag_leggi_dw = " "
	kst_open_w.flag_cerca_in_lista = " "
	kst_open_w.key2 = ""
	kst_open_w.key3 = "" 
	kst_open_w.key4 = ""
	kst_open_w.key12_any = ""
	kst_open_w.flag_where = " "
	kGuf_menu_window.open_w_tabelle(kst_open_w)
	//destroy kuf1_menu_window
	
elseif dwo.name = "b_base_stat_l" then
	
	kds_1 = create datastore
	kds_1.dataobject = "d_base_stat_l"
	kds_1.settransobject(kguo_sqlca_db_magazzino)
	if kds_1.retrieve( ) > 0 then
		kst_open_w.key10_window_chiamante = kiw_this_window
		kst_open_w.key1 = "Elenco operazioni di estrazione statistici"    
		kst_open_w.key2 = trim(kds_1.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = ""
		kst_open_w.key12_any = kds_1
		kiuf_elenco = create kuf_elenco 
		kiuf_elenco.u_open(kst_open_w)
		destroy kiuf_elenco
	end if
	
elseif dwo.name = "b_fgrp_out_path" then
	get_fgrp_out_path()
elseif dwo.name = "b_path_doc_root" then
	get_path_doc_root()
elseif dwo.name = "b_path_centrale" then
	get_path_centrale()
elseif dwo.name = "b_path_upd" then
	get_path_pgm_upd()
elseif dwo.name = "b_path_fatt" then
	get_path_fatt()
elseif dwo.name = "b_dir_report_pilota" then
	get_path_reportpilota()
elseif dwo.name = "b_dosimetro_ult_barcode" then
	get_dosimetro_ult_barcode()
elseif dwo.name = "b_path_esolver_anag" then
	get_path_esolver_anag()
elseif dwo.name = "b_path_esolver_fidi" then
	get_path_esolver_fidi()
elseif dwo.name = "b_listini_no_contratto" then
	u_call_art_x_no_contratto( )
elseif dwo.name = "b_report_export_dir" then
	get_report_export_dir()
end if


attiva_tasti( )

end event

event dw_4::clicked;call super::clicked;//
string k_upd_last_vers = " "
double k_versione = 0.0000


if dwo.name = "update_last_vers_1" then
	k_upd_last_vers = this.GetItemString (1, "update_last_vers") 
	if k_upd_last_vers = "N" or isnull(k_upd_last_vers) then
		
		k_versione = double(this.GetItemString (1, "last_version"))
		if isnull(k_versione) then
			k_versione = 0.0
		end if
		if double(kkG.versione) > k_versione then 
			this.setitem(1, "last_version", kkG.versione)
		end if
		
	end if
else 
	if dwo.name = "p_data_ora_procedura" or dwo.name = "st_orario_procedura" then
		if this.describe("st_orario_procedura.visible") = '1' then
			this.modify("st_orario_procedura.visible = '0'")
		else
			this.modify("st_orario_procedura.text = '" + string(kGuf_data_base.prendi_dataora( ), "dd.mmm.yyyy  hh:mm:ss") + "'") 
			this.modify("st_orario_procedura.visible = '1'")
		end if
	end if
end if

end event

event dw_4::itemchanged;call super::itemchanged;//
int k_rc, k_errore=1
long k_riga
st_tab_email kst_tab_email
st_tab_listino kst_tab_listino
st_tab_prodotti kst_tab_prodotti
datawindowchild kdwc_1


choose case lower(dwo.name)

	case "email_codice" &
			,"email_codice_1" 
	   	kst_tab_email.codice = RightTrim(data)
		if not isnull(kst_tab_email.codice) and LenA(kst_tab_email.codice) > 0 then
		
			k_rc = this.getchild(dwo.name, kdwc_1)
			k_riga = kdwc_1.find("codice = ~""+(kst_tab_email.codice)+"~"",0,kdwc_1.rowcount())
			if k_riga <= 0 or isnull(k_riga) then
				k_errore = 2
				kst_tab_email.id_email = 0
			else
				kst_tab_email.id_email = kdwc_1.getitemnumber(k_riga, "id_email")
			end if
		else
			kst_tab_email.codice = ""
			kst_tab_email.id_email = 0
		
		end if
		if lower(dwo.name) = "email_codice" then
			this.setitem(row, "id_email_lettera_fattura", kst_tab_email.id_email )
		else
			this.setitem(row, "id_email_lettera_avviso", kst_tab_email.id_email )
		end if
//
	case "base_fatt_sv_call_vettore_id_listino" 
		this.setitem(1, "listino_cod_art", "")
		this.setitem(1, "listino_prezzo", 0)
		if isnumber(data) then
			kst_tab_listino.id = long(data)
			if kst_tab_listino.id > 0 then
				post u_set_sv_call_vettore_id_listino(kst_tab_listino)
			end if
		end if

	case "e1_id_listino_dsm_tof554701"
		if isnumber(data) then
			kst_tab_listino.id = long(data)
			k_rc = this.getchild(dwo.name, kdwc_1)
			k_riga = kdwc_1.find("id_listino = "+ string(kst_tab_listino.id)+" ",0,kdwc_1.rowcount())
			if k_riga <= 0 or isnull(k_riga) then
				k_errore = 2
				kst_tab_listino.id = 0
				kst_tab_prodotti.des = ""
				kst_tab_prodotti.codice = ""
			else
				kst_tab_listino.id = kdwc_1.getitemnumber(k_riga, "id_listino")
				kst_tab_prodotti.des = kdwc_1.getitemstring(k_riga, "prodotti_des")
				kst_tab_prodotti.codice = kdwc_1.getitemstring(k_riga, "cod_art")
			end if
		else
			kst_tab_prodotti.des = ""
			kst_tab_prodotti.codice = ""
			kst_tab_listino.id = 0
		end if
		this.setitem(row, "prodotti_des", trim(kst_tab_prodotti.codice) + " - " + trim(kst_tab_prodotti.des) )

end choose


end event

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
integer x = 146
integer y = 16
integer width = 2222
integer height = 940
string text = " Contatori Procedura"
long tabbackcolor = 67108864
string picturename = "Application!"
st_non_auth_5 st_non_auth_5
end type

on tabpage_5.create
this.st_non_auth_5=create st_non_auth_5
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_non_auth_5
end on

on tabpage_5.destroy
call super::destroy
destroy(this.st_non_auth_5)
end on

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
integer width = 2359
integer height = 844
boolean enabled = true
string dataobject = "d_base_gen_ctr"
boolean hsplitscroll = false
end type

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
integer x = 146
integer y = 16
integer width = 2222
integer height = 940
boolean enabled = true
long backcolor = 67108864
string text = " DB Esterni~r~n (Pilota, E-ONE, Pk-List...) "
long tabbackcolor = 67108864
string picturename = "DBConnect!"
long picturemaskcolor = 553648127
st_1 st_1
cb_pilota_proprieta cb_pilota_proprieta
cb_db_wmf cb_db_wmf
st_18 st_18
cb_db_web cb_db_web
st_19 st_19
cb_db_crm cb_db_crm
st_21 st_21
cb_db_previsioni cb_db_previsioni
st_23 st_23
cb_db_e1 cb_db_e1
st_26 st_26
end type

on tabpage_6.create
this.st_1=create st_1
this.cb_pilota_proprieta=create cb_pilota_proprieta
this.cb_db_wmf=create cb_db_wmf
this.st_18=create st_18
this.cb_db_web=create cb_db_web
this.st_19=create st_19
this.cb_db_crm=create cb_db_crm
this.st_21=create st_21
this.cb_db_previsioni=create cb_db_previsioni
this.st_23=create st_23
this.cb_db_e1=create cb_db_e1
this.st_26=create st_26
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_pilota_proprieta
this.Control[iCurrent+3]=this.cb_db_wmf
this.Control[iCurrent+4]=this.st_18
this.Control[iCurrent+5]=this.cb_db_web
this.Control[iCurrent+6]=this.st_19
this.Control[iCurrent+7]=this.cb_db_crm
this.Control[iCurrent+8]=this.st_21
this.Control[iCurrent+9]=this.cb_db_previsioni
this.Control[iCurrent+10]=this.st_23
this.Control[iCurrent+11]=this.cb_db_e1
this.Control[iCurrent+12]=this.st_26
end on

on tabpage_6.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_pilota_proprieta)
destroy(this.cb_db_wmf)
destroy(this.st_18)
destroy(this.cb_db_web)
destroy(this.st_19)
destroy(this.cb_db_crm)
destroy(this.st_21)
destroy(this.cb_db_previsioni)
destroy(this.st_23)
destroy(this.cb_db_e1)
destroy(this.st_26)
end on

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
integer x = 1312
integer y = 16
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
integer x = 503
integer y = 12
integer width = 489
integer height = 132
integer taborder = 10
boolean hscrollbar = false
boolean vscrollbar = false
end type

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
integer x = 146
integer y = 16
integer width = 2222
integer height = 940
long backcolor = 67108864
long tabbackcolor = 67108864
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
integer x = 1179
integer y = 28
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
integer x = 343
integer y = 8
integer width = 494
integer height = 152
end type

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
integer x = 146
integer y = 16
integer width = 2222
integer height = 940
boolean enabled = true
long backcolor = 16777215
string text = " Ausiliari"
long tabbackcolor = 67108864
string picturename = "ArrangeTables!"
rr_1 rr_1
rr_4 rr_4
rr_2 rr_2
st_3 st_3
cb_ausiliari_1 cb_ausiliari_1
cb_ausiliari_2 cb_ausiliari_2
st_5 st_5
st_6 st_6
st_7 st_7
st_8 st_8
st_10 st_10
st_11 st_11
st_12 st_12
st_9 st_9
st_13 st_13
st_14 st_14
st_15 st_15
st_16 st_16
st_17 st_17
cb_docpath cb_docpath
st_20 st_20
st_2 st_2
st_24 st_24
st_25 st_25
st_28 st_28
end type

on tabpage_8.create
this.rr_1=create rr_1
this.rr_4=create rr_4
this.rr_2=create rr_2
this.st_3=create st_3
this.cb_ausiliari_1=create cb_ausiliari_1
this.cb_ausiliari_2=create cb_ausiliari_2
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
this.st_8=create st_8
this.st_10=create st_10
this.st_11=create st_11
this.st_12=create st_12
this.st_9=create st_9
this.st_13=create st_13
this.st_14=create st_14
this.st_15=create st_15
this.st_16=create st_16
this.st_17=create st_17
this.cb_docpath=create cb_docpath
this.st_20=create st_20
this.st_2=create st_2
this.st_24=create st_24
this.st_25=create st_25
this.st_28=create st_28
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rr_1
this.Control[iCurrent+2]=this.rr_4
this.Control[iCurrent+3]=this.rr_2
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.cb_ausiliari_1
this.Control[iCurrent+6]=this.cb_ausiliari_2
this.Control[iCurrent+7]=this.st_5
this.Control[iCurrent+8]=this.st_6
this.Control[iCurrent+9]=this.st_7
this.Control[iCurrent+10]=this.st_8
this.Control[iCurrent+11]=this.st_10
this.Control[iCurrent+12]=this.st_11
this.Control[iCurrent+13]=this.st_12
this.Control[iCurrent+14]=this.st_9
this.Control[iCurrent+15]=this.st_13
this.Control[iCurrent+16]=this.st_14
this.Control[iCurrent+17]=this.st_15
this.Control[iCurrent+18]=this.st_16
this.Control[iCurrent+19]=this.st_17
this.Control[iCurrent+20]=this.cb_docpath
this.Control[iCurrent+21]=this.st_20
this.Control[iCurrent+22]=this.st_2
this.Control[iCurrent+23]=this.st_24
this.Control[iCurrent+24]=this.st_25
this.Control[iCurrent+25]=this.st_28
end on

on tabpage_8.destroy
call super::destroy
destroy(this.rr_1)
destroy(this.rr_4)
destroy(this.rr_2)
destroy(this.st_3)
destroy(this.cb_ausiliari_1)
destroy(this.cb_ausiliari_2)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.st_10)
destroy(this.st_11)
destroy(this.st_12)
destroy(this.st_9)
destroy(this.st_13)
destroy(this.st_14)
destroy(this.st_15)
destroy(this.st_16)
destroy(this.st_17)
destroy(this.cb_docpath)
destroy(this.st_20)
destroy(this.st_2)
destroy(this.st_24)
destroy(this.st_25)
destroy(this.st_28)
end on

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
integer x = 2482
integer y = 196
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
integer x = 2642
integer y = 1016
integer width = 343
integer height = 132
boolean hscrollbar = false
boolean vscrollbar = false
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
integer x = 146
integer y = 16
integer width = 2222
integer height = 940
boolean enabled = true
long backcolor = 16777215
string text = " E-Mail"
long tabbackcolor = 67108864
string picturename = "Custom025!"
long picturemaskcolor = 553648127
st_4 st_4
cb_4 cb_4
st_22 st_22
cb_5 cb_5
end type

on tabpage_9.create
this.st_4=create st_4
this.cb_4=create cb_4
this.st_22=create st_22
this.cb_5=create cb_5
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_4
this.Control[iCurrent+2]=this.cb_4
this.Control[iCurrent+3]=this.st_22
this.Control[iCurrent+4]=this.cb_5
end on

on tabpage_9.destroy
call super::destroy
destroy(this.st_4)
destroy(this.cb_4)
destroy(this.st_22)
destroy(this.cb_5)
end on

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
integer x = 1545
integer y = 96
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
integer x = 658
integer y = 808
integer width = 1563
integer height = 512
end type

type st_duplica from w_g_tab_3`st_duplica within w_base_personale
end type

type cb_1 from commandbutton within tabpage_3
integer x = 101
integer y = 84
integer width = 965
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Vedi Segnalazioni (LOG anomalie)"
end type

event clicked;//
st_esito kst_esito
kuf_utility kuf1_utility


	kuf1_utility = create kuf_utility
	kst_esito = kuf1_utility.errori_visualizza_log( 1 )
	destroy kuf1_utility
	if kst_esito.esito <> "0" then
			messagebox("Documento non Aperto", trim(kst_esito.sqlerrtext)) 	
	end if
	
	
end event

type cb_2 from commandbutton within tabpage_3
boolean visible = false
integer x = 114
integer y = 276
integer width = 709
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Vedi ~'Log~' Errori Informix"
end type

event clicked;//
st_esito kst_esito
kuf_utility kuf1_utility


	kuf1_utility = create kuf_utility
	kst_esito = kuf1_utility.errori_visualizza_log_informix( 1 )
	destroy kuf1_utility
	if kst_esito.esito <> "0" then
		messagebox("Documento non Aperto", trim(kst_esito.sqlerrtext)) 	
	end if
	

end event

type cb_3 from commandbutton within tabpage_3
integer x = 1157
integer y = 84
integer width = 1006
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Apri il mio file di Configurazione"
end type

event clicked;//
st_esito kst_esito
kuf_utility kuf1_utility


//	kuf1_utility = create kuf_utility
	kst_esito = kGuf_data_base.u_open_confdb_ini( 1 )
	destroy kuf1_utility
	if kst_esito.esito <> "0" then
		messagebox("Documento non Aperto", trim(kst_esito.sqlerrtext)) 	
	end if
	

end event

type st_non_auth_4 from statictext within tabpage_4
boolean visible = false
integer x = 274
integer y = 268
integer width = 1481
integer height = 84
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "Utente non autorizzato a visualizzare i dati"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_non_auth_5 from statictext within tabpage_5
boolean visible = false
integer x = 274
integer y = 268
integer width = 1481
integer height = 84
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "Utente non autorizzato a visualizzare i dati"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within tabpage_6
integer x = 1157
integer y = 84
integer width = 1792
integer height = 184
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Proprietà di scambio e accesso ai dati tra i Programmi di Gestione  Impianto  (PILOTA) e la Procedura M2000"
boolean focusrectangle = false
end type

type cb_pilota_proprieta from commandbutton within tabpage_6
integer x = 192
integer y = 80
integer width = 850
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Proprietà DB  Pilota Impianto "
end type

event clicked;//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice sl_pt;
//kuf_menu_window kuf1_menu_window
st_open_w k_st_open_w




K_st_open_w.id_programma = kkg_id_programma.pilota_proprieta
K_st_open_w.flag_primo_giro = "S"
K_st_open_w.flag_modalita = kkg_flag_modalita.modifica
K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
K_st_open_w.flag_leggi_dw = " "
K_st_open_w.key1 = " "
K_st_open_w.key2 = " "
K_st_open_w.key3 = " "
K_st_open_w.key4 = " "
K_st_open_w.flag_where = " "

//kuf1_menu_window = create kuf_menu_window 

kGuf_menu_window.open_w_tabelle(k_st_open_w)

//destroy kuf1_menu_window


end event

type cb_db_wmf from commandbutton within tabpage_6
integer x = 192
integer y = 584
integer width = 850
integer height = 112
integer taborder = 62
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Proprietà Packing-List (WM)"
end type

event clicked;//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice sl_pt;
//kuf_menu_window kuf1_menu_window 
kuf_wm_pklist_cfg kuf1_wm_pklist_cfg
st_open_w k_st_open_w


kuf1_wm_pklist_cfg = create kuf_wm_pklist_cfg
//kuf1_menu_window = create kuf_menu_window


K_st_open_w.id_programma = kuf1_wm_pklist_cfg.get_id_programma(kkg_flag_modalita.modifica)
K_st_open_w.flag_primo_giro = "S"
K_st_open_w.flag_modalita = kkg_flag_modalita.modifica
K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
K_st_open_w.flag_leggi_dw = " "
K_st_open_w.key1 = "1"
K_st_open_w.key2 = " "
K_st_open_w.key3 = " "
K_st_open_w.key4 = " "
K_st_open_w.flag_where = " "

kGuf_menu_window.open_w_tabelle(k_st_open_w)

destroy kuf1_wm_pklist_cfg
//destroy kuf1_menu_window





end event

type st_18 from statictext within tabpage_6
integer x = 1157
integer y = 568
integer width = 1792
integer height = 184
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Proprietà di importazione dati Packing-List di entrata dai canali FTP Web (XML) e diretto (TXT)"
boolean focusrectangle = false
end type

type cb_db_web from commandbutton within tabpage_6
integer x = 192
integer y = 1228
integer width = 850
integer height = 112
integer taborder = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Proprietà DB x il WEB"
end type

event clicked;//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice sl_pt;
//kuf_menu_window kuf1_menu_window 
kuf_db_cfg kuf1_db_cfg
st_open_w k_st_open_w


//kuf1_menu_window = create kuf_menu_window
kuf1_db_cfg = create kuf_db_cfg

K_st_open_w.id_programma = kuf1_db_cfg.get_id_programma(kkg_flag_modalita.modifica)
K_st_open_w.flag_primo_giro = "S"
K_st_open_w.flag_modalita = kkg_flag_modalita.modifica
K_st_open_w.flag_adatta_win = KKg.ADATTA_WIN
K_st_open_w.flag_leggi_dw = " "
K_st_open_w.key1 = kuf1_db_cfg.kki_codice_xweb
K_st_open_w.key2 = " "
K_st_open_w.key3 = " "
K_st_open_w.key4 = " "
K_st_open_w.flag_where = " "

kGuf_menu_window.open_w_tabelle(k_st_open_w)

destroy kuf1_db_cfg
//destroy kuf1_menu_window





end event

type st_19 from statictext within tabpage_6
integer x = 1157
integer y = 1244
integer width = 1792
integer height = 112
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Proprietà di accesso ai dati da trasferire al Web (SMART)"
boolean focusrectangle = false
end type

type cb_db_crm from commandbutton within tabpage_6
integer x = 192
integer y = 856
integer width = 850
integer height = 112
integer taborder = 82
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Proprietà DB x il CRM"
end type

event clicked;//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice sl_pt;
//kuf_menu_window kuf1_menu_window 
kuf_db_cfg kuf1_db_cfg
st_open_w k_st_open_w


//kuf1_menu_window = create kuf_menu_window
kuf1_db_cfg = create kuf_db_cfg

K_st_open_w.id_programma = kuf1_db_cfg.get_id_programma(kkg_flag_modalita.modifica)
K_st_open_w.flag_primo_giro = "S"
K_st_open_w.flag_modalita = kkg_flag_modalita.modifica
K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
K_st_open_w.flag_leggi_dw = " "
K_st_open_w.key1 = kuf1_db_cfg.kki_codice_xcrm
K_st_open_w.key2 = " "
K_st_open_w.key3 = " "
K_st_open_w.key4 = " "
K_st_open_w.flag_where = " "

kGuf_menu_window.open_w_tabelle(k_st_open_w)

destroy kuf1_db_cfg
//destroy kuf1_menu_window





end event

type st_21 from statictext within tabpage_6
integer x = 1157
integer y = 876
integer width = 1792
integer height = 144
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Proprietà di accesso ai dati di scambio con il CRM "
boolean focusrectangle = false
end type

type cb_db_previsioni from commandbutton within tabpage_6
integer x = 192
integer y = 1008
integer width = 850
integer height = 112
integer taborder = 102
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Proprietà DB ~'Previsionali~'"
end type

event clicked;//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice sl_pt;
//kuf_menu_window kuf1_menu_window 
kuf_db_cfg kuf1_db_cfg
st_open_w k_st_open_w


//kuf1_menu_window = create kuf_menu_window
kuf1_db_cfg = create kuf_db_cfg

K_st_open_w.id_programma = kuf1_db_cfg.get_id_programma(kkg_flag_modalita.modifica)
K_st_open_w.flag_primo_giro = "S"
K_st_open_w.flag_modalita = kkg_flag_modalita.modifica
K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
K_st_open_w.flag_leggi_dw = " "
K_st_open_w.key1 = kuf1_db_cfg.kki_codice_xprevisioni
K_st_open_w.key2 = " "
K_st_open_w.key3 = " "
K_st_open_w.key4 = " "
K_st_open_w.flag_where = " "

kGuf_menu_window.open_w_tabelle(k_st_open_w)

destroy kuf1_db_cfg
//destroy kuf1_menu_window



 

end event

type st_23 from statictext within tabpage_6
integer x = 1157
integer y = 1032
integer width = 1390
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Proprietà di accesso ai dati di Previsione (ACCESS)"
boolean focusrectangle = false
end type

type cb_db_e1 from commandbutton within tabpage_6
integer x = 192
integer y = 304
integer width = 850
integer height = 112
integer taborder = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Connessione E-ONE"
end type

event clicked;//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice sl_pt;
//kuf_menu_window kuf1_menu_window 
kuf_e1_conn_cfg kuf1_e1_conn_cfg
st_open_w k_st_open_w


kuf1_e1_conn_cfg = create kuf_e1_conn_cfg
//kuf1_menu_window = create kuf_menu_window

K_st_open_w.id_programma = kuf1_e1_conn_cfg.get_id_programma(kkg_flag_modalita.modifica)
K_st_open_w.flag_primo_giro = "S"
K_st_open_w.flag_modalita = kkg_flag_modalita.modifica
K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
K_st_open_w.flag_leggi_dw = " "
K_st_open_w.key1 = "1"
K_st_open_w.key2 = " "
K_st_open_w.key3 = " "
K_st_open_w.key4 = " "
K_st_open_w.flag_where = " "

kGuf_menu_window.open_w_tabelle(k_st_open_w)

destroy kuf1_e1_conn_cfg
//destroy kuf1_menu_window





end event

type st_26 from statictext within tabpage_6
integer x = 1157
integer y = 288
integer width = 1792
integer height = 184
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Proprietà di scambio e accesso ai dati tra E-ONE e la Procedura M2000"
boolean focusrectangle = false
end type

type rr_1 from roundrectangle within tabpage_8
long linecolor = 8388608
linestyle linestyle = dot!
integer linethickness = 4
long fillcolor = 134217732
integer x = 155
integer y = 396
integer width = 759
integer height = 840
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_4 from roundrectangle within tabpage_8
long linecolor = 8388608
linestyle linestyle = dot!
integer linethickness = 4
long fillcolor = 134217732
integer x = 1829
integer y = 396
integer width = 759
integer height = 840
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_2 from roundrectangle within tabpage_8
long linecolor = 8388608
linestyle linestyle = dot!
integer linethickness = 4
long fillcolor = 134217732
integer x = 987
integer y = 396
integer width = 759
integer height = 840
integer cornerheight = 40
integer cornerwidth = 46
end type

type st_3 from statictext within tabpage_8
integer x = 224
integer y = 184
integer width = 1765
integer height = 112
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
string text = "Interroga e Aggiorna i diversi Archivi Ausiliari della Procedura:"
boolean focusrectangle = false
end type

type cb_ausiliari_1 from commandbutton within tabpage_8
integer x = 197
integer y = 456
integer width = 672
integer height = 112
integer taborder = 62
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Archivi Ausiliari 1"
end type

event clicked;//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice sl_pt;
//kuf_menu_window kuf1_menu_window 
kuf_wm_pklist_cfg kuf1_wm_pklist_cfg
st_open_w k_st_open_w


kuf1_wm_pklist_cfg = create kuf_wm_pklist_cfg
//kuf1_menu_window = create kuf_menu_window


K_st_open_w.id_programma = kkg_id_programma.ausiliari //kuf1_wm_pklist_cfg.get_id_programma(kkg_flag_modalita.modifica)
K_st_open_w.flag_primo_giro = "S"
K_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
K_st_open_w.flag_leggi_dw = " "
K_st_open_w.key1 = " "
K_st_open_w.key2 = " "
K_st_open_w.key3 = " "
K_st_open_w.key4 = " "
K_st_open_w.flag_where = " "

kGuf_menu_window.open_w_tabelle(k_st_open_w)

destroy kuf1_wm_pklist_cfg
//destroy kuf1_menu_window




end event

type cb_ausiliari_2 from commandbutton within tabpage_8
integer x = 1033
integer y = 456
integer width = 672
integer height = 112
integer taborder = 62
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Archivi Ausiliari 2"
end type

event clicked;//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice sl_pt;
//kuf_menu_window kuf1_menu_window 
kuf_wm_pklist_cfg kuf1_wm_pklist_cfg
st_open_w k_st_open_w


kuf1_wm_pklist_cfg = create kuf_wm_pklist_cfg
//kuf1_menu_window = create kuf_menu_window


K_st_open_w.id_programma = kkg_id_programma.ausiliari1 //kuf1_wm_pklist_cfg.get_id_programma(kkg_flag_modalita.modifica)
K_st_open_w.flag_primo_giro = "S"
K_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
K_st_open_w.flag_leggi_dw = " "
K_st_open_w.key1 = " "
K_st_open_w.key2 = " "
K_st_open_w.key3 = " "
K_st_open_w.key4 = " "
K_st_open_w.flag_where = " "

kGuf_menu_window.open_w_tabelle(k_st_open_w)

destroy kuf1_wm_pklist_cfg
//destroy kuf1_menu_window





end event

type st_5 from statictext within tabpage_8
integer x = 274
integer y = 656
integer width = 489
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Tipi Pagamento"
boolean focusrectangle = false
end type

event clicked;//
cb_ausiliari_1.triggerevent(clicked!)
end event

type st_6 from statictext within tabpage_8
integer x = 274
integer y = 720
integer width = 457
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Misure"
boolean focusrectangle = false
end type

event clicked;//
cb_ausiliari_1.triggerevent(clicked!)
end event

type st_7 from statictext within tabpage_8
integer x = 274
integer y = 784
integer width = 457
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Gruppi"
boolean focusrectangle = false
end type

event clicked;//
cb_ausiliari_1.triggerevent(clicked!)
end event

type st_8 from statictext within tabpage_8
integer x = 274
integer y = 848
integer width = 585
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Causali Spedizione"
boolean focusrectangle = false
end type

event clicked;//
cb_ausiliari_1.triggerevent(clicked!)
end event

type st_10 from statictext within tabpage_8
integer x = 274
integer y = 984
integer width = 457
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Nazioni"
boolean focusrectangle = false
end type

event clicked;//
cb_ausiliari_1.triggerevent(clicked!)
end event

type st_11 from statictext within tabpage_8
integer x = 274
integer y = 1052
integer width = 457
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "CAP postali"
boolean focusrectangle = false
end type

event clicked;//
cb_ausiliari_1.triggerevent(clicked!)
end event

type st_12 from statictext within tabpage_8
integer x = 274
integer y = 1120
integer width = 457
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Province Italianei"
boolean focusrectangle = false
end type

event clicked;//
cb_ausiliari_1.triggerevent(clicked!)
end event

type st_9 from statictext within tabpage_8
integer x = 274
integer y = 916
integer width = 608
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Causali Entrata Merce"
boolean focusrectangle = false
end type

event clicked;//
cb_ausiliari_1.triggerevent(clicked!)
end event

type st_13 from statictext within tabpage_8
integer x = 1106
integer y = 592
integer width = 457
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Banche"
boolean focusrectangle = false
end type

event clicked;//
cb_ausiliari_2.triggerevent(clicked!)
end event

type st_14 from statictext within tabpage_8
integer x = 1106
integer y = 656
integer width = 457
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lotti Dosimetrici"
boolean focusrectangle = false
end type

event clicked;//
cb_ausiliari_2.triggerevent(clicked!)
end event

type st_15 from statictext within tabpage_8
integer x = 1106
integer y = 720
integer width = 539
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Settori Merceologici"
boolean focusrectangle = false
end type

event clicked;//
cb_ausiliari_2.triggerevent(clicked!)
end event

type st_16 from statictext within tabpage_8
integer x = 1106
integer y = 784
integer width = 539
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Classi Clienti"
boolean focusrectangle = false
end type

event clicked;//
cb_ausiliari_2.triggerevent(clicked!)
end event

type st_17 from statictext within tabpage_8
integer x = 274
integer y = 592
integer width = 457
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "codici IVA"
boolean focusrectangle = false
end type

event clicked;//
cb_ausiliari_1.triggerevent(clicked!)
end event

type cb_docpath from commandbutton within tabpage_8
integer x = 1874
integer y = 456
integer width = 672
integer height = 112
integer taborder = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cartelle Documenti"
end type

event clicked;//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice sl_pt;
//kuf_menu_window kuf1_menu_window 
kuf_docpath kuf1_docpath
st_open_w k_st_open_w


kuf1_docpath = create kuf_docpath
//kuf1_menu_window = create kuf_menu_window


K_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
K_st_open_w.id_programma = kuf1_docpath.get_id_programma(K_st_open_w.flag_modalita)
K_st_open_w.flag_primo_giro = "S"
K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
K_st_open_w.flag_leggi_dw = " "
K_st_open_w.key1 = " "
K_st_open_w.key2 = " "
K_st_open_w.key3 = " "
K_st_open_w.key4 = " "
K_st_open_w.flag_where = " "

kGuf_menu_window.open_w_tabelle(k_st_open_w)

destroy kuf1_docpath
//destroy kuf1_menu_window





end event

type st_20 from statictext within tabpage_8
integer x = 1947
integer y = 592
integer width = 603
integer height = 180
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Indica le Cartelle in cui esportare i documenti  "
boolean focusrectangle = false
end type

event clicked;//
cb_docpath.triggerevent(clicked!)

end event

type st_2 from statictext within tabpage_8
integer x = 1106
integer y = 848
integer width = 594
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Categoria Voce listino"
boolean focusrectangle = false
end type

event clicked;//
cb_ausiliari_2.triggerevent(clicked!)

end event

type st_24 from statictext within tabpage_8
integer x = 1106
integer y = 916
integer width = 567
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Settori Dipartimentali"
boolean focusrectangle = false
end type

event clicked;//
cb_ausiliari_2.triggerevent(clicked!)

end event

type st_25 from statictext within tabpage_8
integer x = 1106
integer y = 984
integer width = 567
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Tempi Impianto"
boolean focusrectangle = false
end type

event clicked;//
cb_ausiliari_2.triggerevent(clicked!)

end event

type st_28 from statictext within tabpage_8
integer x = 1106
integer y = 1052
integer width = 567
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Posizioni Dosimetro"
boolean focusrectangle = false
end type

event clicked;//
cb_ausiliari_2.triggerevent(clicked!)

end event

type st_4 from statictext within tabpage_9
integer x = 69
integer y = 184
integer width = 1326
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
string text = "Gestione Prototipi e-mail da inviare in automatico:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_4 from commandbutton within tabpage_9
integer x = 1458
integer y = 172
integer width = 672
integer height = 112
integer taborder = 62
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Prototipi E-mail"
end type

event clicked;//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice sl_pt;
kuf_email kuf1_email


kuf1_email = create kuf_email
kuf1_email.u_open( )


end event

type st_22 from statictext within tabpage_9
integer x = 430
integer y = 540
integer width = 965
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
string text = "Assegna funzioni e-mail ai Prototipi:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_5 from commandbutton within tabpage_9
integer x = 1458
integer y = 516
integer width = 672
integer height = 112
integer taborder = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Associa Prototipi"
end type

event clicked;//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice sl_pt;
kuf_email_funzioni kuf1_email_funzioni

kuf1_email_funzioni = create kuf_email_funzioni
kuf1_email_funzioni.u_open( )


end event

type tabpage_10 from userobject within tab_1
boolean visible = false
integer x = 146
integer y = 16
integer width = 2222
integer height = 940
long backcolor = 16777215
string text = " Kit"
long tabtextcolor = 33554432
string picturename = "Strikethrough!"
long picturemaskcolor = 536870912
string powertiptext = "Funzioni varie"
st_27 st_27
cb_6 cb_6
cb_meca_chiude cb_meca_chiude
st_meca_chiude st_meca_chiude
dw_10 dw_10
end type

on tabpage_10.create
this.st_27=create st_27
this.cb_6=create cb_6
this.cb_meca_chiude=create cb_meca_chiude
this.st_meca_chiude=create st_meca_chiude
this.dw_10=create dw_10
this.Control[]={this.st_27,&
this.cb_6,&
this.cb_meca_chiude,&
this.st_meca_chiude,&
this.dw_10}
end on

on tabpage_10.destroy
destroy(this.st_27)
destroy(this.cb_6)
destroy(this.cb_meca_chiude)
destroy(this.st_meca_chiude)
destroy(this.dw_10)
end on

type st_27 from statictext within tabpage_10
integer x = 1285
integer y = 436
integer width = 2066
integer height = 112
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
string text = "Esporta dati Contratti/Legami per le funzioni di Packing List Web (SMART)"
boolean focusrectangle = false
end type

type cb_6 from commandbutton within tabpage_10
integer x = 357
integer y = 416
integer width = 891
integer height = 112
integer taborder = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Esporta dati x il WEB (SMART)"
end type

event clicked;//--- 
st_open_w kst_open_w 
kuf_contratti_esporta kuf1_contratti_esporta


kuf1_contratti_esporta = create kuf_contratti_esporta
kst_open_w.flag_modalita = kkg_flag_modalita.elenco
kuf1_contratti_esporta.u_open(kst_open_w)

destroy kuf1_contratti_esporta





end event

type cb_meca_chiude from commandbutton within tabpage_10
integer x = 357
integer y = 184
integer width = 891
integer height = 112
integer taborder = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Chusura Lotti Massiva"
end type

event clicked;//
kuf_meca_chiudi kuf1_meca_chiudi


kuf1_meca_chiudi = create kuf_meca_chiudi
kuf1_meca_chiudi.u_open( )


end event

type st_meca_chiude from statictext within tabpage_10
integer x = 1285
integer y = 208
integer width = 997
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
string text = "Gestione chiusura Lotti massiva"
boolean focusrectangle = false
end type

type dw_10 from uo_d_std_1 within tabpage_10
integer x = 2597
integer y = 96
integer width = 818
integer height = 256
integer taborder = 40
end type

type tabpage_11 from userobject within tab_1
boolean visible = false
integer x = 146
integer y = 16
integer width = 2222
integer height = 940
boolean enabled = false
long backcolor = 16777215
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_11 dw_11
end type

on tabpage_11.create
this.dw_11=create dw_11
this.Control[]={this.dw_11}
end on

on tabpage_11.destroy
destroy(this.dw_11)
end on

type dw_11 from uo_d_std_1 within tabpage_11
integer x = 78
integer y = 104
integer taborder = 62
end type

type tabpage_12 from userobject within tab_1
boolean visible = false
integer x = 146
integer y = 16
integer width = 2222
integer height = 940
long backcolor = 16777215
string text = "Log Segnalazioni"
long tabtextcolor = 33554432
string picturename = "ToDoList!"
long picturemaskcolor = 536870912
dw_12 dw_12
end type

on tabpage_12.create
this.dw_12=create dw_12
this.Control[]={this.dw_12}
end on

on tabpage_12.destroy
destroy(this.dw_12)
end on

type dw_12 from uo_d_std_1 within tabpage_12
boolean visible = true
integer x = 50
integer y = 36
integer width = 2034
integer height = 388
integer taborder = 50
boolean enabled = true
string dataobject = "d_log_m2000"
boolean livescroll = false
boolean ki_link_standard_attivi = false
boolean ki_button_standard_attivi = false
boolean ki_colora_riga_aggiornata = false
boolean ki_db_conn_standard = false
end type

event getfocus;call super::getfocus;
//
kidw_selezionata = this

//--- imposta oggetto selezionato x fare il TROVA
kigrf_x_trova = this

end event

event doubleclicked;//
// non fare nulla
end event

type tabpage_13 from userobject within tab_1
boolean visible = false
integer x = 146
integer y = 16
integer width = 2222
integer height = 940
long backcolor = 67108864
string text = "Monitor"
long tabtextcolor = 33554432
string picturename = "Custom077!"
long picturemaskcolor = 536870912
st_esiti_operazioni st_esiti_operazioni
pb_st_esiti_operazioni pb_st_esiti_operazioni
cb_monitor cb_monitor
st_13_retrieve st_13_retrieve
st_non_auth_13 st_non_auth_13
dw_13 dw_13
end type

on tabpage_13.create
this.st_esiti_operazioni=create st_esiti_operazioni
this.pb_st_esiti_operazioni=create pb_st_esiti_operazioni
this.cb_monitor=create cb_monitor
this.st_13_retrieve=create st_13_retrieve
this.st_non_auth_13=create st_non_auth_13
this.dw_13=create dw_13
this.Control[]={this.st_esiti_operazioni,&
this.pb_st_esiti_operazioni,&
this.cb_monitor,&
this.st_13_retrieve,&
this.st_non_auth_13,&
this.dw_13}
end on

on tabpage_13.destroy
destroy(this.st_esiti_operazioni)
destroy(this.pb_st_esiti_operazioni)
destroy(this.cb_monitor)
destroy(this.st_13_retrieve)
destroy(this.st_non_auth_13)
destroy(this.dw_13)
end on

type st_esiti_operazioni from statictext within tabpage_13
integer x = 251
integer y = 1224
integer width = 855
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Mostra Log ultimo anno"
boolean focusrectangle = false
end type

type pb_st_esiti_operazioni from picturebutton within tabpage_13
integer x = 110
integer y = 1180
integer width = 128
integer height = 116
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "BrowseClasses!"
vtextalign vtextalign = top!
boolean map3dcolors = true
string powertiptext = "Visualizza Log degli estiti "
end type

event clicked;//
this.enabled = false

//if dw_esiti.visible then
//	elenco_esiti(false )
//	st_esiti_operazioni.text = "Mostra Log Esiti Operazioni   "
//else
u_elenco_esiti(true )
//	st_esiti_operazioni.text = "Nascondi Log                       "
//end if

this.enabled = true


end event

type cb_monitor from commandbutton within tabpage_13
integer x = 1838
integer y = 1188
integer width = 443
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Avvia controlli"
end type

event clicked;//
u_avvia_check_db( )

end event

type st_13_retrieve from statictext within tabpage_13
boolean visible = false
integer x = 2350
integer y = 1228
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type st_non_auth_13 from statictext within tabpage_13
boolean visible = false
integer x = 261
integer y = 276
integer width = 1481
integer height = 84
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "Utente non autorizzato a visualizzare i dati"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_13 from uo_d_std_1 within tabpage_13
boolean visible = true
integer x = 59
integer width = 2834
integer height = 1104
integer taborder = 30
boolean enabled = true
string dataobject = "d_chk_db"
boolean hsplitscroll = false
boolean livescroll = false
boolean ki_link_standard_attivi = false
boolean ki_button_standard_attivi = false
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_d_std_1_attiva_cerca = false
boolean ki_db_conn_standard = false
end type

