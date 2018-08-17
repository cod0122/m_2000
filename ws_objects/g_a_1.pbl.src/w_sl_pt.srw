$PBExportHeader$w_sl_pt.srw
forward
global type w_sl_pt from w_g_tab_3
end type
type ln_1 from line within tabpage_4
end type
end forward

global type w_sl_pt from w_g_tab_3
integer x = 169
integer y = 148
integer width = 3127
integer height = 1728
string title = "Piano di Trattamento SL-PT"
boolean ki_toolbar_window_presente = true
boolean ki_fai_nuovo_dopo_insert = false
end type
global w_sl_pt w_sl_pt

type variables
//
private boolean ki_cambio_giri_autorizzato=false
private boolean ki_b_reset_proposta=false
private st_tab_sl_pt kist_tab_sl_pt_orig
private kuf_sl_pt kiuf_sl_pt

end variables

forward prototypes
private function integer inserisci ()
private subroutine riempi_id ()
protected function integer cancella ()
private subroutine leggi_altre_tab ()
private function integer check_rek (string k_codice)
protected subroutine inizializza_1 ()
protected function string aggiorna ()
protected function string inizializza ()
protected function string check_dati ()
protected subroutine open_start_window ()
public subroutine trattamento_proposta_reset ()
public subroutine trattamento_proposta_sposta ()
private subroutine u_open_esempio_st_dosim ()
public function boolean u_get_dati_cliente (ref st_tab_clienti kst_tab_clienti)
private subroutine u_put_video_cliente (st_tab_clienti kst_tab_clienti)
private function boolean if_anag_attiva (st_tab_clienti ast_tab_clienti)
public subroutine u_set_dw_clienti_child ()
protected subroutine attiva_tasti_0 ()
protected subroutine inizializza_2 () throws uo_exception
protected subroutine pulizia_righe ()
protected subroutine u_pulizia_righe_dosimpos ()
end prototypes

private function integer inserisci ();//
int k_return=1, k_ctr
string k_errore="0 "
date k_data
string k_codice
long k_riga
//datawindowchild kdwc_cliente, kdwc_cliente_1, kdwc_cliente_2 
//kuf_base kuf1_base


//=== Controllo se ho modificato dei dati nella DW DETTAGLIO
//if left(dati_modif(""), 1) = "1" then //Richisto Aggiornamento

//=== Controllo congruenza dei dati caricati e Aggiornamento  
//=== Ritorna 1 char : 0=tutto OK; 1=errore grave;
//===                : 2=errore non grave dati aggiornati;
//===			         : 3=LIBERO
//===      il resto della stringa contiene la descrizione dell'errore   
//	k_errore = aggiorna_dati()

//end if


if LeftA(k_errore, 1) = "0" then

//=== Pulizia dei campi
	attiva_tasti()

//=== Aggiunge una riga al data windows
	choose case tab_1.selectedtab 
		case  1 
	
//			tab_1.tabpage_1.dw_1.getchild("clienti_a_rag_soc_1", kdwc_cliente)

//			kdwc_cliente.settransobject(sqlca)
	
			tab_1.tabpage_1.dw_1.insertrow(0)
			
//			tab_1.tabpage_1.dw_1.setitem(1, "cod_sl_pt", "")
			
			tab_1.tabpage_1.dw_1.setcolumn(1)
			
		case 2 // posizioni dosimetri
			k_riga = tab_1.tabpage_2.dw_2.insertrow(0)
			tab_1.tabpage_2.dw_2.setitem(k_riga, "seq", k_riga*10)
			tab_1.tabpage_2.dw_2.setcolumn("dosimpos_codice")
			
		case 3 // dati listino
			k_codice = tab_1.tabpage_1.dw_1.getitemstring(1, "codice")
////=== Riempe indirizzo di Spedizione da DW_1
//			if k_codice > 0 then
//				k_riga = tab_1.tabpage_2.dw_2.insertrow(0)
//	
//				tab_1.tabpage_2.dw_2.setitem(k_riga, "codice", k_codice)
//				tab_1.tabpage_2.dw_2.setitem(k_riga, "clie_3", k_codice)
//	
//				tab_1.tabpage_2.dw_2.scrolltorow(k_riga)
//				tab_1.tabpage_2.dw_2.setrow(k_riga)
//				tab_1.tabpage_2.dw_2.setcolumn(1)
//			end if
//			
//		case 3 // Listino
//			k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")
//				 
//			if k_id_cliente > 0 and k_codice > 0 then
//				tab_1.tabpage_3.dw_3.Modify("codice.CheckBox.On='"+ &
//										string(k_codice, "#####")+"'")
//
////=== Parametri : commessa, cliente, flag di rek commessa + altri prot non abbinati
//				if tab_1.tabpage_3.dw_3.retrieve(k_codice, k_id_cliente, 1) > 0 then
//					tab_1.tabpage_3.dw_3.scrolltorow(1)
//					tab_1.tabpage_3.dw_3.setrow(1)
//					tab_1.tabpage_3.dw_3.setcolumn(1)
////=== Imposto il protocollo messo in testata
//					k_id_protocollo = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_protocollo")
//					if k_id_protocollo > 0 then 
//						k_ctr = tab_1.tabpage_3.dw_3.find("id_protocollo=" + &
//											string(k_id_protocollo, "#####"), 0, &
//											tab_1.tabpage_3.dw_3.rowcount())
//						if k_ctr > 0 then 
//							if tab_1.tabpage_3.dw_3.getitemnumber(k_ctr, "codice") = 0 or & 
//								isnull(tab_1.tabpage_3.dw_3.getitemnumber(k_ctr, "codice")) then 
//							
//								tab_1.tabpage_3.dw_3.setitem(k_ctr, "codice", k_codice)
//							end if
//						end if
//					end if
//
//				end if
//			end if
//
			
		case 4 
//			k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")
	
//			if k_codice > 0 then
//				k_riga = tab_1.tabpage_4.dw_4.insertrow(0)
//
//				tab_1.tabpage_4.dw_4.setitem(k_riga, "codice", k_codice)
//				tab_1.tabpage_4.dw_4.scrolltorow(k_riga)
//				tab_1.tabpage_4.dw_4.setrow(k_riga)
//				tab_1.tabpage_4.dw_4.setcolumn(1)
//
////				if tab_1.tabpage_4.dw_41.rowcount() = 0 then
////					k_riga = tab_1.tabpage_4.dw_41.insertrow(0)
////
////					tab_1.tabpage_4.dw_41.setitem(k_riga, "codice", k_codice)
////					tab_1.tabpage_4.dw_41.scrolltorow(k_riga)
////					tab_1.tabpage_4.dw_41.setrow(k_riga)
////					tab_1.tabpage_4.dw_41.setcolumn(1)
////				end if
//			end if
			
//		case 5 // 
//			k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")
//	
////			if k_codice > 0 then
//				k_riga = tab_1.tabpage_4.dw_4.insertrow(0)
//
//				tab_1.tabpage_4.dw_4.setitem(k_riga, "codice", k_codice)
//				tab_1.tabpage_4.dw_4.scrolltorow(k_riga)
//				tab_1.tabpage_4.dw_4.setrow(k_riga)
//				tab_1.tabpage_4.dw_4.setcolumn(1)
//
////				if tab_1.tabpage_4.dw_41.rowcount() = 0 then
////					k_riga = tab_1.tabpage_4.dw_41.insertrow(0)
////
////					tab_1.tabpage_4.dw_41.setitem(k_riga, "codice", k_codice)
////					tab_1.tabpage_4.dw_41.scrolltorow(k_riga)
////					tab_1.tabpage_4.dw_41.setrow(k_riga)
////					tab_1.tabpage_4.dw_41.setcolumn(1)
////				end if
//			end if
			
	end choose	

	k_return = 0

end if

return (k_return)



end function

private subroutine riempi_id ();//
//=== Imposta gli Effettivi ID degli archivi
string k_codice_1, k_codice
long k_riga, k_riga_max
st_tab_sl_pt kst_tab_sl_pt

//=== Salvo ID del rec originale x piu' avanti
	k_codice_1 = tab_1.tabpage_1.dw_1.getitemstring(1, "cod_sl_pt")

//=== Se non sono in caricamento allora prelevo l'ID dalla dw
	if tab_1.tabpage_1.dw_1.getitemstatus(1, 0, primary!) <> newmodified! then
		k_codice = tab_1.tabpage_1.dw_1.getitemstring(1, "cod_sl_pt")
	else
		

	end if
	
	kst_tab_sl_pt.proposta_tipo_cicli = tab_1.tabpage_1.dw_1.getitemstring(1, "proposta_tipo_cicli")
	if trim(kst_tab_sl_pt.proposta_tipo_cicli) > " " then
		if kist_tab_sl_pt_orig.proposta_tipo_cicli <> tab_1.tabpage_1.dw_1.getitemstring(1, "proposta_tipo_cicli") &
					or kist_tab_sl_pt_orig.proposta_fila_1 <> tab_1.tabpage_1.dw_1.getitemnumber(1, "proposta_fila_1") &
					or kist_tab_sl_pt_orig.proposta_fila_1p <> tab_1.tabpage_1.dw_1.getitemnumber(1, "proposta_fila_1p") &
					or kist_tab_sl_pt_orig.proposta_fila_2 <> tab_1.tabpage_1.dw_1.getitemnumber(1, "proposta_fila_2") &
					or kist_tab_sl_pt_orig.proposta_fila_2p <> tab_1.tabpage_1.dw_1.getitemnumber(1, "proposta_fila_2p") then
			
			tab_1.tabpage_1.dw_1.setitem( 1, "proposta_utente", kGuf_data_base.prendi_x_utente( ) )
			tab_1.tabpage_1.dw_1.setitem( 1, "proposta_data", kGuf_data_base.prendi_x_datins( ) )
			
		end if
//--- se tipo ciclo non è a scelta pulizia della preferenza
		if kist_tab_sl_pt_orig.proposta_tipo_cicli <> kiuf_sl_pt.ki_tipo_cicli_a_scelta then
			tab_1.tabpage_1.dw_1.setitem( 1, "proposta_fila_pref"," ")
		end if
	else
		tab_1.tabpage_1.dw_1.setitem( 1, "proposta_utente", "" )
		tab_1.tabpage_1.dw_1.setitem( 1, "proposta_data", datetime(date(0)) )
	end if

//--- dati Posizioni Dosimetri	
	k_codice = tab_1.tabpage_1.dw_1.getitemstring(1, "cod_sl_pt")
	if trim(k_codice) > " " then
		k_riga = tab_1.tabpage_2.dw_2.getnextmodified(0, primary!)
		do while k_riga > 0  
			if tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id_sl_pt_dosimpos") > 0 then
			else
				tab_1.tabpage_2.dw_2.setitem(k_riga, "id_sl_pt_dosimpos", 0)
			end if
			if tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "posxcm") > 0 then
			else
				tab_1.tabpage_2.dw_2.setitem(k_riga, "posxcm", 0)
			end if
			if tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "posycm") > 0 then
			else
				tab_1.tabpage_2.dw_2.setitem(k_riga, "posycm", 0)
			end if
			if tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "poszcm") > 0 then
			else
				tab_1.tabpage_2.dw_2.setitem(k_riga, "poszcm", 0)
			end if
			if tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id_dosimpos") > 0 then
			else
				tab_1.tabpage_2.dw_2.setitem(k_riga, "id_dosimpos", 0)
			end if
			if trim(tab_1.tabpage_2.dw_2.getitemstring(k_riga, "dosim_tipo")) > " " then
			else
				tab_1.tabpage_2.dw_2.setitem(k_riga, "dosim_tipo", "")
			end if
			if trim(tab_1.tabpage_2.dw_2.getitemstring(k_riga, "dosim_flg_tipo_dose")) > " " then
			else
				tab_1.tabpage_2.dw_2.setitem(k_riga, "dosim_flg_tipo_dose", "")
			end if
			if trim(tab_1.tabpage_2.dw_2.getitemstring(k_riga, "descr1")) > " " then
			else
				tab_1.tabpage_2.dw_2.setitem(k_riga, "descr1", "")
			end if
			tab_1.tabpage_2.dw_2.setitem(k_riga, "cod_sl_pt", k_codice)
			tab_1.tabpage_2.dw_2.setitem(k_riga, "x_datins", kGuf_data_base.prendi_x_datins())
			tab_1.tabpage_2.dw_2.setitem(k_riga, "x_utente", kGuf_data_base.prendi_x_utente())
			k_riga = tab_1.tabpage_2.dw_2.getnextmodified(k_riga, primary!)
		loop
		//--- risistema il progressivo sequenza
		tab_1.tabpage_2.dw_2.setsort("seq asc")
		tab_1.tabpage_2.dw_2.sort()
		k_riga_max = tab_1.tabpage_2.dw_2.rowcount( )
		for k_riga = 1 to k_riga_max
			if (k_riga * 10) <> tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "seq") then
				tab_1.tabpage_2.dw_2.setitem(k_riga, "seq", k_riga * 10)
			end if
		next
	end if
	
	
end subroutine

protected function integer cancella ();////
////=== Cancellazione rekord dal DB
////=== Ritorna : 0=OK 1=KO 2=non eseguita
////
int k_return=0
string k_desc, k_record, k_record_1, k_key = " "
long  k_nro=0, k_id_fase
string k_errore = "0 ", k_errore1 = "0 ", k_nro_fatt
long k_riga, k_seq
date k_data
//kuf_sl_pt  kuf1_sl_pt



//=== 
choose case tab_1.selectedtab 
	case 1 
		k_record = " Piano di Trattamento SL-PT "
		k_riga = tab_1.tabpage_1.dw_1.getrow()	
		if k_riga > 0 then
			if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> new! and &
				tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
				k_key = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "cod_sl_pt")
				k_desc = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "descr")
				if isnull(k_desc) = true or trim(k_desc) = "" then
					k_desc = "senza descrizione" 
				end if
				k_record_1 = &
					"Sei sicuro di voler eliminare il SL-PT~n~r" + &
					trim(k_key) +  &
					"~n~r" + trim(k_desc) + " ?"
			else
				tab_1.tabpage_1.dw_1.deleterow(k_riga)
			end if
		end if
//	case 2
//		k_record = " Indirizzo Commerciale "
//		k_riga = tab_1.tabpage_2.dw_2.getrow()	
//		if k_riga > 0 then
//			if tab_1.tabpage_2.dw_2.getitemstatus(k_riga, 0, primary!) <> new! and &
//				tab_1.tabpage_2.dw_2.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
//				k_key = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "clie_c")
//				k_desc = tab_1.tabpage_2.dw_2.getitemstring(k_riga, "rag_soc_1_c")
//				if isnull(k_desc) = true or trim(k_desc) = "" then
//					k_desc = "senza ragione sociale" 
//				end if
//				k_record_1 = &
//					"Sei sicuro di voler eliminare l'Indirizzo Commerciale di~n~r" + &
//					string(k_key, "#####") + " " + trim(k_desc) + " ?"
//			else
//				tab_1.tabpage_2.dw_2.deleterow(k_riga)
//			end if
//		end if
//	case 4
//		k_record = " Fattura di anticipo "
//		k_riga = tab_1.tabpage_4.dw_4.getrow()	
//		if k_riga > 0 then
//			if tab_1.tabpage_4.dw_4.getitemstatus(k_riga, 0, primary!) <> new! and &
//				tab_1.tabpage_4.dw_4.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
//				k_key = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_commessa")
//				k_nro_fatt = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "id_fattura")
//				k_data = tab_1.tabpage_4.dw_4.getitemdate(k_riga, "data_fattura")
//				k_record_1 = &
//					"Sei sicuro di voler eliminare la Fattura~n~r" + &
//					trim(k_nro_fatt) + " del " + string(k_data, "dd-mm-yy") + " ?"
//			else
//				tab_1.tabpage_4.dw_4.deleterow(k_riga)
//			end if
//		end if
end choose	



//=== Se righe in lista
if k_riga > 0 and LenA(trim(k_key)) > 0 then
	
//=== Richiesta di conferma della eliminazione del rek
	if messagebox("Elimina" + k_record, k_record_1, &
		question!, yesno!, 1) = 1 then
 
//=== Cancella la riga dal data windows di lista
		choose case tab_1.selectedtab 
			case 1 
				k_errore = kiuf_sl_pt.tb_delete(k_key) 
//			case 2
//				k_errore = kuf1_sl_pt.tb_delete_ind_comm(k_key) 
		end choose	
		if LeftA(k_errore, 1) = "0" then

			k_errore = kGuf_data_base.db_commit()
			if LeftA(k_errore, 1) <> "0" then
				k_return = 1
				messagebox("Problemi durante la Cancellazione !!", &
						"Controllare i dati. " + MidA(k_errore, 2))

			else
				
				choose case tab_1.selectedtab 
					case 1 
						tab_1.tabpage_1.dw_1.deleterow(k_riga)
//					case 2
//						tab_1.tabpage_2.dw_2.deleterow(k_riga)
				end choose	

			end if

		else
			k_return = 1
			k_errore1 = k_errore
			k_errore = kGuf_data_base.db_rollback()

			messagebox("Problemi durante Cancellazione - Operazione fallita !!", &
							MidA(k_errore1, 2) ) 	
			if LeftA(k_errore, 1) <> "0" then
				messagebox("Problemi durante il recupero dell'errore !!", &
					"Controllare i dati. " + MidA(k_errore, 2))
			end if

			attiva_tasti()

		end if


	else
		messagebox("Elimina" + k_record,  "Operazione Annullata !!")
		k_return = 2
	end if


end if


choose case tab_1.selectedtab 
	case 1 
		tab_1.tabpage_1.dw_1.setfocus()
		tab_1.tabpage_1.dw_1.setcolumn(1)
//	case 2
//		tab_1.tabpage_2.dw_2.setfocus()
//		tab_1.tabpage_2.dw_2.setcolumn(1)
end choose	


return k_return

end function

private subroutine leggi_altre_tab ();
end subroutine

private function integer check_rek (string k_codice);//
int k_return = 0
int k_anno
string k_descr
long k_codice_1



	SELECT 
         sl_pt.descr  
   	 INTO 
      	   :k_descr  
    	FROM sl_pt 
   	WHERE cod_sl_pt = :k_codice;

	if sqlca.sqlcode = 0 then

		if messagebox("Piano gia' in Archivio", & 
					"Vuoi modificare il Piano di Trattamento: ~n~r"+ &
					trim(k_codice)+ " " +trim(k_descr), question!, yesno!, 2) = 1 then
		
//			tab_1.tabpage_1.dw_1.reset()

			ki_st_open_w.flag_modalita = "mo"
			ki_st_open_w.key1 = trim(k_codice) 

			tab_1.tabpage_1.dw_1.reset()
			inizializza()
			
		else
			
			k_return = 1
		end if
	end if  

	attiva_tasti()



return k_return


end function

protected subroutine inizializza_1 ();//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
string k_codice, k_rc
int k_dosim_x_bcode, k_ctr, k_righe


	u_pulizia_righe_dosimpos()	

	if tab_1.tabpage_1.dw_1.rowcount() > 0 then
		k_codice = tab_1.tabpage_1.dw_1.getitemstring(1, "cod_sl_pt")  
		k_dosim_x_bcode =  tab_1.tabpage_1.dw_1.getitemnumber(1,"dosim_x_bcode")
		
		if trim(k_codice) > " " then 
		
	//=== Se le righe presenti non c'entrano con il codice della prima mappa allora resetto		
			if tab_1.tabpage_2.dw_2.rowcount() > 0 then
				if tab_1.tabpage_2.dw_2.getitemstring(1, "cod_sl_pt") <> k_codice then 
					tab_1.tabpage_2.dw_2.reset()
				end if
			end if
	
			k_righe = tab_1.tabpage_2.dw_2.rowcount()
			if k_righe = 0 then
				k_righe = tab_1.tabpage_2.dw_2.retrieve(k_codice) 
			end if
			
			for k_ctr = (k_righe + 1) to k_dosim_x_bcode
				inserisci()
			next

			if tab_1.tabpage_2.dw_2.rowcount() > 0 then
				k_rc = tab_1.tabpage_2.dw_2.modify( "k_dosim_x_bcode=" + string(k_dosim_x_bcode))
			end if
	
			attiva_tasti()
			tab_1.tabpage_2.dw_2.setfocus()
				
		end if
	
		
	end if
	



end subroutine

protected function string aggiorna ();//
//======================================================================
//=== Aggiorna tabelle 
//=== Ritorna 1 chr : 0=tutto OK; 1=errore grave I-O;
//=== 				  : 2=
//===					  : 3=Commit fallita
//===		dal char 2 in poi spiegazione dell'errore
//======================================================================
//
string k_return="0 ", k_errore="0 ", k_errore1="0 "
int k_rc
st_tab_sl_pt kst_tab_sl_pt

//=== Aggiorna, se modificato, la TAB_1	
if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0 OR &
	tab_1.tabpage_1.dw_1.getnextmodified(0, delete!) > 0 & 
	then

//--- Tratto il CAMPO et_descr in modo particolare (diviso in 2 parti)
	if isnull(tab_1.tabpage_1.dw_1.getitemstring(1, "dosim_et_descr")) then tab_1.tabpage_1.dw_1.setitem(1, "dosim_et_descr", " ")
	kst_tab_sl_pt.dosim_et_descr = tab_1.tabpage_1.dw_1.getitemstring(1, "dosim_et_descr") + space(40)
	if isnull(tab_1.tabpage_1.dw_1.getitemstring(1, "dosim_et_descr_1")) then tab_1.tabpage_1.dw_1.setitem(1, "dosim_et_descr_1", " ")
	kst_tab_sl_pt.dosim_et_descr = left(kst_tab_sl_pt.dosim_et_descr,40) + tab_1.tabpage_1.dw_1.getitemstring(1, "dosim_et_descr_1")
	if trim(kst_tab_sl_pt.dosim_et_descr) = "" then kst_tab_sl_pt.dosim_et_descr = "" 

	if tab_1.tabpage_1.dw_1.update() = 1 then

//--- aggiorna manualmente anche la descrizione che è spezzata in due
		try
			kst_tab_sl_pt.cod_sl_pt = tab_1.tabpage_1.dw_1.getitemstring(1, "cod_sl_pt") 
			kiuf_sl_pt.set_dosim_et_descr(kst_tab_sl_pt)
			
			k_return ="0 "
			
//=== Se tutto OK faccio la COMMIT		
			kguo_sqlca_db_magazzino.db_commit()
			
		catch (uo_exception kuo_exception)
			kuo_exception.messaggio_utente()
			k_return="1Fallito aggiornamento archivio (durante aggiornaemnto descrizioni) '" + tab_1.tabpage_1.text + "' ~n~r" 
		end try

	else
		
		kguo_sqlca_db_magazzino.db_rollback()
		k_return="1Fallito aggiornamento archivio '" + tab_1.tabpage_1.text + "' ~n~r" 
		
	end if
end if

//=== Aggiorna, se modificato, la TAB_1	
if tab_1.tabpage_2.dw_2.getnextmodified(0, primary!) > 0 OR &
	tab_1.tabpage_2.dw_2.getnextmodified(0, delete!) > 0 OR &
	tab_1.tabpage_2.dw_2.deletedcount( ) > 0 &
	then

	if tab_1.tabpage_1.dw_1.getitemstring(1, "cod_sl_pt") > " " then
		
//--- update dati dosimetri			
		k_rc = tab_1.tabpage_2.dw_2.update()
		kguo_sqlca_db_magazzino.db_commit()
		
		k_rc = tab_1.tabpage_2.dw_2.resetupdate()
		
		if k_rc < 0 then
			k_return="1Fallito aggiornamento archivio '" + tab_1.tabpage_2.text + "' ~n~r" 
		end if
		
	end if
end if

//=== errore : 0=tutto OK o NON RICHIESTA; 1=errore grave I-O;
//=== 		 	: 2=LIBERO
//===			: 3=Commit fallita

if LeftA(k_return, 1) = "1" then
	messagebox("Operazione di Aggiornamento Non Eseguita !!", &
		MidA(k_return, 2))
else
	if LeftA(k_return, 1) = "3" then
		messagebox("Registrazione dati : problemi nella 'Commit' !!", &
			"Consiglio : chiudere e ripetere le operazioni eseguite")
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
string k_scelta
string k_stato = "0"
string  k_key
string k_fine_ciclo=""
int k_ctr=0
int k_err_ins, k_rc
kuf_utility kuf1_utility
kuf_sl_pt_cambio_giri kuf1_sl_pt_cambio_giri

//=== 
//tab_1.tabpage_4.dw_41.settransobject(sqlca)


if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
	k_scelta = trim(ki_st_open_w.flag_modalita)
	
	k_key = trim(ki_st_open_w.key1)

	if LenA(k_key) = 0 then
		
		k_err_ins = inserisci()
		tab_1.tabpage_1.dw_1.setfocus()
	else

		k_rc = tab_1.tabpage_1.dw_1.retrieve(k_key) 
		
		choose case k_rc

			case is < 0				
				messagebox("Operazione fallita", &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(Codice ricercato:" + trim(k_key) + ")~n~r" )
				cb_ritorna.postevent(clicked!)


			case 0
	
				tab_1.tabpage_1.dw_1.reset()
				attiva_tasti()

				if k_scelta = kkg_flag_modalita.modifica then
					messagebox("Ricerca fallita", &
						"Mi spiace ma il SL-PT non e' in Archivio ~n~r" + &
						"(Codice ricercato:" + trim(k_key) + ")~n~r" )

					cb_ritorna.triggerevent("clicked!")
					
				else
					k_err_ins = inserisci()
					tab_1.tabpage_1.dw_1.setfocus()
				end if
				
				
			case is > 0		

				if k_scelta = "in" then
					
					messagebox("Trovata Anagrafica", &
							"Il PT e' gia' in archivio  ( Codice ricercato : " + trim(k_key) + " )~n~r" )
			
	           		ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica
					
					kist_tab_sl_pt_orig.proposta_tipo_cicli = tab_1.tabpage_1.dw_1.getitemstring(1, "proposta_tipo_cicli")
					kist_tab_sl_pt_orig.proposta_fila_1 = tab_1.tabpage_1.dw_1.getitemnumber(1, "proposta_fila_1")
					kist_tab_sl_pt_orig.proposta_fila_1p = tab_1.tabpage_1.dw_1.getitemnumber(1, "proposta_fila_1p")
					kist_tab_sl_pt_orig.proposta_fila_2 = tab_1.tabpage_1.dw_1.getitemnumber(1, "proposta_fila_2")
					kist_tab_sl_pt_orig.proposta_fila_2p = tab_1.tabpage_1.dw_1.getitemnumber(1, "proposta_fila_2p")
					
				end if

				tab_1.tabpage_1.dw_1.setcolumn(1)
				tab_1.tabpage_1.dw_1.setfocus()
				
				attiva_tasti()
		
		end choose

	end if

else
	attiva_tasti()
end if


ki_cambio_giri_autorizzato = false
ki_b_reset_proposta = false

//--- Inabilita campi alla modifica se Vsualizzazione
   kuf1_utility = create kuf_utility 
   if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.visualizzazione or trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.cancellazione then
	
      kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_1.dw_1)

	else		
//--- popola dw child dw clienti 
		u_set_dw_clienti_child()
		
		ki_b_reset_proposta = true

//--- S-protezione campi per riabilitare la modifica a parte la chiave
      	kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)

//--- Inabilita campo cliente per la modifica se Funzione MODIFICA
		if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
   	   kuf1_utility.u_proteggi_dw("1", 1, tab_1.tabpage_1.dw_1)
		end if

		try
		
		   if trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.cancellazione then
//--- Utente autorizzato al cambio GIRI ?
				kuf1_sl_pt_cambio_giri = create kuf_sl_pt_cambio_giri
				ki_cambio_giri_autorizzato = kuf1_sl_pt_cambio_giri.if_sicurezza(kkg_flag_modalita.modifica )
			end if
				
		catch (uo_exception kuo_exception)
//			kuo_exception.messaggio_utente()
		
		end try

	end if
	destroy kuf1_utility
	

return "0"

end function

protected function string check_dati ();//
//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================

string k_return = ""
string k_errore = "0"
long k_nr_righe
int k_riga, k_num_file=0, k_num_file_p=0, k_num_diff_giri_fila1, k_num_diff_giri_fila2
int k_nr_errori
string k_key_str
string k_stato, k_tipo
string k_key



//=== Controllo il primo tab
	k_nr_righe = tab_1.tabpage_1.dw_1.rowcount()
	k_nr_errori = 0
	k_riga = 1

	k_key = tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "cod_sl_pt") 
	if isnull(k_key) or LenA(trim(k_key)) = 0 then
		k_return = tab_1.tabpage_1.text + ": Manca il codice SL-PT! " + "~n~r"
		k_errore = "3"
		k_nr_errori++
	end if
	if isnull(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "descr")) = true then
		k_return = k_return + tab_1.tabpage_1.text + ": Manca la descrizione; " + "~n~r" 
		k_errore = "3"
		k_nr_errori++
	end if

	if k_errore = "0" then
		if tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "dose_min") > 0  &
		   and (tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "dose_min") >   &
		    tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "dose_max")  &
			 or isnull(tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "dose_max"))) then
			k_return = k_return + tab_1.tabpage_1.text + ": Dose Massima minore della Minima; " &
			           + "~n~r" 
			k_errore = "1"
			k_nr_errori++
		end if
	end if
	if k_errore = "0" then
		if tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "dosetgminmin") > 0  &
		   and tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "dosetgminmin") >   &
		    tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "dosetgminmax")  &
			 then
			k_return = k_return + tab_1.tabpage_1.text + ": valore Massimo di 'Dose Target Minima' minore del Minimo; " &
			           + "~n~r" 
			k_errore = "1"
			k_nr_errori++
		end if
	end if
	if k_errore = "0" then
		if tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "dosetgmaxmin") > 0  &
		   and tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "dosetgmaxmin") >   &
		    tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "dosetgmaxmax")  &
			 then
			k_return = k_return + tab_1.tabpage_1.text + ": valore Massimo di 'Dose Target Massima' minore del Minimo; " &
			           + "~n~r" 
			k_errore = "1"
			k_nr_errori++
		end if
	end if
	if k_errore = "0" then
		if tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "dosetgmaxmin") > 0  &
		   and tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "dosetgmaxmin") >   &
		    tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "dosetgmaxmax")  &
			 then
			k_return = k_return + tab_1.tabpage_1.text + ": valore Massimo di 'Dose Target Massima' minore del Minimo; " &
			           + "~n~r" 
			k_errore = "1"
			k_nr_errori++
		end if
	end if

//--- Tipo cicli di trattamento congruente?
	if k_errore = "0" then
		k_num_file = 0           // numero file valorizzate
		k_num_file_p = 0         // numero file permutate valorizzate 
		if isnull(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "tipo_cicli")) = true then
			tab_1.tabpage_1.dw_1.setitem( k_riga, "tipo_cicli", "0") 
		end if
//--- quante 'file' sono valorizzate?		
		if tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "fila_1") > 0 then
			k_num_file++
		   if isnull(tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "fila_1p")) then
				tab_1.tabpage_1.dw_1.setitem( k_riga, "fila_1p", tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "fila_1"))
			end if
		else
			if tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "fila_1p") > 0 &
		      and (isnull(tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "fila_1")) &
		       or tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "fila_1") = 0) then
				tab_1.tabpage_1.dw_1.setitem( k_riga, "fila_1", 0)
			else
				tab_1.tabpage_1.dw_1.setitem( k_riga, "fila_1", 0)
				tab_1.tabpage_1.dw_1.setitem( k_riga, "fila_1p", 0)
			end if
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "fila_2") > 0 then
			k_num_file++
		   if isnull(tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "fila_2p")) then
				tab_1.tabpage_1.dw_1.setitem( k_riga, "fila_2p", tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "fila_2"))
			end if
		else
			if tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "fila_2p") > 0 &
		      and (isnull(tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "fila_2")) &
		       or tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "fila_2") = 0) then
				tab_1.tabpage_1.dw_1.setitem( k_riga, "fila_2", 0)
			else
				tab_1.tabpage_1.dw_1.setitem( k_riga, "fila_2", 0)
				tab_1.tabpage_1.dw_1.setitem( k_riga, "fila_2p", 0)
			end if
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "fila_1p") > 0 then
			k_num_file_p++
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "fila_2p") > 0 then
			k_num_file_p++
		end if

//		k_num_diff_giri_fila1 = abs(tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "fila_1") - tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "fila_1p"))
//		k_num_diff_giri_fila2 = abs(tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "fila_2") - tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "fila_2p"))

		choose case tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "tipo_cicli")
//--- ciclo normale ( valorizza fila 1 o fila 2) //???? con permutazione identica )
			case "0"
				if (k_num_file > 1 or k_num_file_p > 1) then
					k_return = k_return + tab_1.tabpage_1.text + ": Per Trattamento modalita' '" &
					       + trim(MidA (tab_1.tabpage_1.dw_1.getvalue("tipo_cicli",1), 1, PosA(tab_1.tabpage_1.dw_1.getvalue("tipo_cicli",1), "~t", 1) - 1)) &
					       + "' impostare solo Giri in Fila 1 o 2; " &
							 + "~n~r" 
					k_errore = "1"
					k_nr_errori++
				end if 
//--- ciclo normale a scelta ( valorizza fila 1 e fila 2 ) //???con permutazione identica )
			case "1", "2"
				if (k_num_file = 1 and k_num_file_p = 1) then
					k_return = k_return + tab_1.tabpage_1.text + ": E' più opportuno impostare la modalita' di Trattamento a '" &
						 + trim(MidA(tab_1.tabpage_1.dw_1.getvalue("tipo_cicli",1), 1, PosA(tab_1.tabpage_1.dw_1.getvalue("tipo_cicli",1), "~t", 1) - 1)) &
						 + "'; " &
						 + "~n~r" 
					k_errore = "4"
					k_nr_errori++
				end if
		end choose
	end if

	if k_errore = "0" then
	
		tab_1.tabpage_1.dw_1.setitem(k_riga, "x_datins", kGuf_data_base.prendi_x_datins())
		tab_1.tabpage_1.dw_1.setitem(k_riga, "x_utente", kGuf_data_base.prendi_x_utente())

		
	end if


return k_errore + k_return


end function

protected subroutine open_start_window ();//
kiuf_sl_pt = create kuf_sl_pt

tab_1.tabpage_2.dw_2.modify( "k_delete.visible=1")
tab_1.tabpage_2.dw_2.modify( "b_delete.visible=1")


end subroutine

public subroutine trattamento_proposta_reset ();//
//--- Cancella il trattamento PROPOSTA
//
st_tab_sl_pt kst_tab_sl_pt

	if ki_b_reset_proposta then

//--- azzera proposta
		kst_tab_sl_pt.proposta_tipo_cicli = ""
		kst_tab_sl_pt.proposta_fila_1 = 0
		kst_tab_sl_pt.proposta_fila_1p = 0
		kst_tab_sl_pt.proposta_fila_2 = 0
		kst_tab_sl_pt.proposta_fila_2p = 0
		tab_1.tabpage_1.dw_1.setitem( 1, "proposta_tipo_cicli", kst_tab_sl_pt.proposta_tipo_cicli )
		tab_1.tabpage_1.dw_1.setitem( 1, "proposta_fila_1", kst_tab_sl_pt.proposta_fila_1)
		tab_1.tabpage_1.dw_1.setitem( 1, "proposta_fila_1p", kst_tab_sl_pt.proposta_fila_1p)
		tab_1.tabpage_1.dw_1.setitem( 1, "proposta_fila_2", kst_tab_sl_pt.proposta_fila_2)
		tab_1.tabpage_1.dw_1.setitem( 1, "proposta_fila_2p", kst_tab_sl_pt.proposta_fila_2p)

	end if

	attiva_tasti( )
	
end subroutine

public subroutine trattamento_proposta_sposta ();//
//--- sposta il trattamento da PROPOSTA a EFFETTIVO
//
st_tab_sl_pt kst_tab_sl_pt

if ki_cambio_giri_autorizzato then

	tab_1.tabpage_1.dw_1.accepttext( )

//--- copia proposta in effettivo	
	kst_tab_sl_pt.proposta_tipo_cicli = tab_1.tabpage_1.dw_1.getitemstring(1, "proposta_tipo_cicli")
	kst_tab_sl_pt.proposta_fila_pref = tab_1.tabpage_1.dw_1.getitemstring(1, "proposta_fila_pref")
	kst_tab_sl_pt.proposta_fila_1 = tab_1.tabpage_1.dw_1.getitemnumber(1, "proposta_fila_1")
	kst_tab_sl_pt.proposta_fila_1p = tab_1.tabpage_1.dw_1.getitemnumber(1, "proposta_fila_1p")
	kst_tab_sl_pt.proposta_fila_2 = tab_1.tabpage_1.dw_1.getitemnumber(1, "proposta_fila_2")
	kst_tab_sl_pt.proposta_fila_2p = tab_1.tabpage_1.dw_1.getitemnumber(1, "proposta_fila_2p")
	if len(trim(kst_tab_sl_pt.proposta_tipo_cicli)) > 0 then
		tab_1.tabpage_1.dw_1.setitem( 1, "tipo_cicli", kst_tab_sl_pt.proposta_tipo_cicli )
		tab_1.tabpage_1.dw_1.setitem( 1, "fila_pref", kst_tab_sl_pt.proposta_fila_pref)
		tab_1.tabpage_1.dw_1.setitem( 1, "fila_1", kst_tab_sl_pt.proposta_fila_1)
		tab_1.tabpage_1.dw_1.setitem( 1, "fila_1p", kst_tab_sl_pt.proposta_fila_1p)
		tab_1.tabpage_1.dw_1.setitem( 1, "fila_2", kst_tab_sl_pt.proposta_fila_2)
		tab_1.tabpage_1.dw_1.setitem( 1, "fila_2p", kst_tab_sl_pt.proposta_fila_2p)
	end if
	
//--- azzera proposta
	trattamento_proposta_reset( )

end if

end subroutine

private subroutine u_open_esempio_st_dosim ();//
string k_path 
kuf_file_explorer kuf1_file_explorer


	k_path = kguo_path.get_risorse( ) + kkg.path_sep + "dosimetroesempio.png"
	SetPointer(kkg.pointer_attesa)
	kuf1_file_explorer = create kuf_file_explorer
	kuf1_file_explorer.of_execute( k_path )
	destroy kuf1_file_explorer

end subroutine

public function boolean u_get_dati_cliente (ref st_tab_clienti kst_tab_clienti);//
boolean k_return = false
st_esito kst_esito
kuf_clienti kuf1_clienti

////---- scrive Trace su LOG---------
//PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
//u_write_trace()  
////-------------------------------------


try
	
	kuf1_clienti = create kuf_clienti

	k_return = kuf1_clienti.leggi (kst_tab_clienti)
	
//--- Gestione di Allert per il cliente 	
//	u_allarme_cliente(kst_tab_clienti)
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	

finally
	if isvalid(kuf1_clienti) then destroy kuf1_clienti
////---- scrive Trace su LOG---------
//PopulateError(2, "fattura") //x popolare systemerror con i vari dati automatici 
//u_write_trace()  
////-------------------------------------

	
end try

return k_return


end function

private subroutine u_put_video_cliente (st_tab_clienti kst_tab_clienti);//
//--- Visualizza dati Cliente 
//

tab_1.tabpage_1.dw_1.modify( "id_cliente.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
tab_1.tabpage_1.dw_1.setitem( 1, "id_cliente", kst_tab_clienti.codice )
tab_1.tabpage_1.dw_1.modify( "rag_soc_10.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
tab_1.tabpage_1.dw_1.setitem( 1, "rag_soc_10", trim(kst_tab_clienti.rag_soc_10) )

tab_1.tabpage_1.dw_1.setitem( 1, "id_cliente", kst_tab_clienti.codice)
tab_1.tabpage_1.dw_1.setitem( 1, "rag_soc_10", kst_tab_clienti.rag_soc_10 )

attiva_tasti()


end subroutine

private function boolean if_anag_attiva (st_tab_clienti ast_tab_clienti);//
//--- Verifica se l'angrafica è attiva
//
boolean k_return = false
kuf_clienti kiuf_clienti


try
	setPointer(kkg.pointer_attesa)

	kiuf_clienti = create kuf_clienti
	if ast_tab_clienti.codice > 0 then

		k_return = kiuf_clienti.if_attivo(ast_tab_clienti)
		if not k_return then
			messagebox("Anagrafica non attiva", &
			    "Il cliente "+ string(ast_tab_clienti.codice) + " non è Attivo in Anagrafe, per utilizzarlo prima procedere con il cambio di stato", information!)
		end if
		
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally
	if isvalid(kiuf_clienti) then destroy kiuf_clienti
	SetPointer(kkg.pointer_default)

end try
	
return k_return

end function

public subroutine u_set_dw_clienti_child ();//
int k_rc
string k_cadenza_fattura="", k_x=""
datawindowchild  kdwc_1, kdwc_2


//	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
		
		tab_1.tabpage_1.dw_1.getchild("id_cliente", kdwc_1)
		kdwc_1.settransobject(sqlca)
		
//--- se non avevo letto nulla allora faccio il ripopolamento delle DW
		if kdwc_1.rowcount() = 0 then
			kdwc_1.reset() 
			kdwc_1.retrieve("%")
			kdwc_1.SetSort("id_cliente A")
			kdwc_1.sort( )
			kdwc_1.insertrow(1)
			
			tab_1.tabpage_1.dw_1.getchild("rag_soc_10", kdwc_2)
			kdwc_2.settransobject(sqlca)
			kdwc_2.reset() 
//			kdwc_2.retrieve("%")
			k_rc = kdwc_1.RowsCopy(1, kdwc_1.RowCount(), Primary!, kdwc_2, 1, Primary!)
			k_rc = kdwc_2.SetSort("rag_soc_1 A")
			k_rc = kdwc_2.sort( )
		end if		
		
//	end if


end subroutine

protected subroutine attiva_tasti_0 ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================

long k_riga = 0
string k_codice = ""


super::attiva_tasti_0()

cb_ritorna.enabled = true
cb_ritorna.default = false
cb_inserisci.default = false
cb_aggiorna.default = false
cb_cancella.default = false

//--- pulsante che fa vedere un esempio di stampa, sempre ebilitato
tab_1.tabpage_1.dw_1.modify("p_img_dosimesempio.enabled = '1'")

//--- inabilito le mofidifice sulla dw
if ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione or ki_st_open_w.flag_modalita = kkg_flag_modalita.cancellazione then
	
	cb_inserisci.enabled = false
	cb_aggiorna.enabled = false
	cb_cancella.enabled = false
	tab_1.tabpage_1.dw_1.modify( "b_reset_proposta.enabled=0")
	tab_1.tabpage_1.dw_1.modify( "b_trattamento_effettivo.enabled=0")

else
	
	cb_inserisci.enabled = true
	cb_aggiorna.enabled = true
	cb_cancella.enabled = true

//=== Nr righe ne DW lista
	choose case tab_1.selectedtab
		case 1
			k_riga = tab_1.tabpage_1.dw_1.getrow()
			if k_riga > 0 then
				k_codice = trim(tab_1.tabpage_1.dw_1.getitemstring(k_riga,"cod_sl_pt"))
			end if
			if k_riga <= 0 or LenA(k_codice) = 0 or isnull(k_codice) then
				cb_inserisci.enabled = false
				cb_inserisci.default = false
				cb_cancella.enabled = false
				cb_aggiorna.enabled = false
			end if

//---  pulsante x Trasferimento in effettivo dei GIRI modificati proposti
			if ki_cambio_giri_autorizzato then
				tab_1.tabpage_1.dw_1.modify( "b_trattamento_effettivo.enabled=1")
			else
				tab_1.tabpage_1.dw_1.modify( "b_trattamento_effettivo.enabled=0")
			end if
//---  pulsante x reset dei GIRI modificati proposti
			if ki_b_reset_proposta then
				tab_1.tabpage_1.dw_1.modify( "b_reset_proposta.enabled=1")
			else
				tab_1.tabpage_1.dw_1.modify( "b_reset_proposta.enabled=0")
			end if


		case 2
			k_riga = tab_1.tabpage_2.dw_2.getrow()
			if k_riga <= 0 then
				cb_inserisci.enabled = false
				cb_inserisci.default = false
				cb_cancella.enabled = false
				cb_aggiorna.enabled = false
			end if
			if cb_aggiorna.enabled then
				tab_1.tabpage_2.dw_2.modify("b_delete.enabled=1") 
			else
				tab_1.tabpage_2.dw_2.modify("b_delete.enabled=0") 
			end if

		case 3
				cb_inserisci.enabled = false
				cb_inserisci.default = false
				cb_aggiorna.enabled = false
				cb_cancella.enabled = false
	end choose

end if

end subroutine

protected subroutine inizializza_2 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
string k_codice
string k_scelta



	if tab_1.tabpage_1.dw_1.rowcount() > 0 then
		k_codice = tab_1.tabpage_1.dw_1.getitemstring(1, "cod_sl_pt")  
		k_scelta = trim(ki_st_open_w.flag_modalita)

////=== Se cliente non impostato forzo una INSERISCI cliente, impostando in nr.cliente
//	if k_codice = 0 then
//		inserisci()
//		k_codice = tab_1.tabpage_3.dw_3.getitemnumber(1, "codice")  
//	end if

//=== Se tab_1 non ha righe INSERISCI_tab_1 altrimenti controllo che righe sono
//=== Se le righe presenti non c'entrano con il cliente allora resetto		
		if tab_1.tabpage_3.dw_3.rowcount() > 0 then
			if tab_1.tabpage_3.dw_3.getitemstring(1, "sl_pt") <> k_codice then 
				tab_1.tabpage_3.dw_3.reset()
			end if
		end if
	
		if tab_1.tabpage_3.dw_3.rowcount() < 1 then
	
//if tab_1.tabpage_3.dw_3.rowcount() = 0 then
	

//	k_key = long(mid(st_parametri.text, 3, 10))



//=== Retrive 
			if tab_1.tabpage_3.dw_3.retrieve(0, date(0), k_codice, 0) <= 0 then

//			inserisci()
			else
				attiva_tasti()
			end if				
		else
			attiva_tasti()
		end if
	
		tab_1.tabpage_3.dw_3.setfocus()
		
	end if
	



end subroutine

protected subroutine pulizia_righe ();//=== Oltre a confermare ACCEPTTEXT toglie righe da non UPDATE
//

u_pulizia_righe_dosimpos()
end subroutine

protected subroutine u_pulizia_righe_dosimpos ();//=== Oltre a confermare ACCEPTTEXT toglie righe da non UPDATE
//
string k_key
long k_riga, k_ctr



k_riga = tab_1.tabpage_2.dw_2.rowcount ( )
for k_ctr = k_riga to 1 step -1

	if tab_1.tabpage_2.dw_2.getitemstatus(k_ctr, 0, primary!) = newmodified! then 
		if trim(tab_1.tabpage_2.dw_2.getitemstring(k_ctr, "dosimpos_codice")) > " " then
		else
			tab_1.tabpage_2.dw_2.deleterow(k_ctr)
		end if
	end if
next


end subroutine

on w_sl_pt.create
int iCurrent
call super::create
end on

on w_sl_pt.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type st_ritorna from w_g_tab_3`st_ritorna within w_sl_pt
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_sl_pt
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_sl_pt
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_sl_pt
integer x = 2711
integer y = 1424
end type

type st_stampa from w_g_tab_3`st_stampa within w_sl_pt
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_sl_pt
integer x = 1152
integer y = 1440
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_sl_pt
integer x = 768
integer y = 1440
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_sl_pt
integer x = 1970
integer y = 1424
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_sl_pt
integer x = 2341
integer y = 1424
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_sl_pt
integer x = 1600
integer y = 1424
boolean enabled = false
end type

event cb_inserisci::clicked;//
//=== 
string k_errore="0"

//=== Nuovo Rekord
	choose case tab_1.selectedtab 
		case  1, 3 
	
			k_errore = LeftA(dati_modif(parent.title), 1)

//=== Controllo se ho modificato dei dati nella DW DETTAGLIO
			if k_errore = "1" then //Fare gli aggiornamenti

//=== Ritorna 1 char: 0=Tutto OK; 1=Errore grave; 
//===	              : 2=Errore Non grave dati aggiornati
//===               : 3=
				k_errore = aggiorna_dati()		

			else

				if k_errore = "2" then //Aggiornamento non richiesto
					k_errore = "0"
				end if

			end if
			
	end choose
	
	if LeftA(k_errore, 1) = "0" then 
		inserisci()
	end if

end event

type tab_1 from w_g_tab_3`tab_1 within w_sl_pt
integer x = 32
integer y = 52
integer width = 3040
integer height = 1396
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
integer width = 3003
integer height = 1268
long backcolor = 32238571
string text = " PT "
long tabbackcolor = 32435950
long picturemaskcolor = 31646434
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
integer x = 5
integer width = 2967
integer height = 1244
string dataobject = "d_sl_pt"
boolean hsplitscroll = false
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_d_std_1_attiva_cerca = false
end type

event dw_1::itemchanged;call super::itemchanged;//
string k_codice, k_descr
int k_errore=0
long k_riga
st_tab_clienti kst_tab_clienti
datawindowchild kdwc_1


choose case dwo.name 
		
	case "cod_sl_pt" 
	     k_codice = upper(trim(data))
		if isnull(k_codice) = false and LenA(trim(k_codice)) > 0 then
			if check_rek( k_codice ) > 0 then
				k_errore = 1
			end if
			
		end if

	case "rag_soc_10" 
		this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.BIANCO) + "' ") 
		if len(trim(data)) > 0 then 
			this.getchild(dwo.name, kdwc_1)
			k_riga = kdwc_1.find( "rag_soc_1 like '" + trim(data) + "%" +"'" , 1, kdwc_1.rowcount())
			if k_riga > 0 then
				kst_tab_clienti.codice = kdwc_1.getitemnumber( k_riga, "id_cliente")
				if if_anag_attiva(kst_tab_clienti) then
					u_get_dati_cliente(kst_tab_clienti)
					post u_put_video_cliente(kst_tab_clienti)
				else
					this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
				end if
			else
				this.object.id_cliente[1] = 0
				this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
			end if
		else
			kst_tab_clienti.codice = 0
			kst_tab_clienti.rag_soc_10 = ""
			post u_put_video_cliente(kst_tab_clienti)
		end if

	case "id_cliente" 
		this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.BIANCO) + "' ") 
		if trim(data) > "0" then 
			this.getchild(dwo.name, kdwc_1)
			k_riga = kdwc_1.find( "id_cliente = " + trim(data) + " " , 1, kdwc_1.rowcount())
			if k_riga > 0 then
				kst_tab_clienti.codice = long(trim(data))
				if if_anag_attiva(kst_tab_clienti) then
					u_get_dati_cliente(kst_tab_clienti)
					post u_put_video_cliente(kst_tab_clienti)
				else
					this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
				end if
			else
				this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
			end if
		else
			kst_tab_clienti.codice = 0
			kst_tab_clienti.rag_soc_10 = ""
			post u_put_video_cliente(kst_tab_clienti)
		end if


end choose 

if k_errore = 1 then
	return 2
end if
	
end event

event dw_1::clicked;//

choose case dwo.name 
	case "b_trattamento_effettivo" 
		trattamento_proposta_sposta()
		
	case "b_reset_proposta"
		trattamento_proposta_reset( )
		
	case "p_img_dosimesempio"
		u_open_esempio_st_dosim( )
		
end choose
	

end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
integer width = 3003
integer height = 1268
long backcolor = 16777215
string text = "Posizioni Dosimetri"
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
boolean visible = true
integer x = 0
integer width = 2981
integer height = 1228
boolean enabled = true
string dataobject = "d_sl_pt_dosimpos_1"
end type

event dw_2::itemchanged;call super::itemchanged;//
string k_x
long k_riga, k_n
datawindowchild kdwc_1


choose case dwo.name

	case "dosimpos_codice" 
		if trim(data) > " " then 
			
			if len(trim(data)) = 1 and isnumber(trim(data)) then
				data = "0" + trim(data)  //normalizza, ad es.  '1' diventa '01'
			end if
			
			this.getchild(dwo.name, kdwc_1)
			
			k_riga = kdwc_1.find("dosimpos_codice = '" + trim(data) + "'", 0, kdwc_1.rowcount())
			
			if trim(data) = kdwc_1.getitemstring(kdwc_1.getrow(), "codice") then
				k_riga = kdwc_1.getrow()  //priorità alla riga scelta nel DDW
			end if
			
			if k_riga > 0 then
				k_n = kdwc_1.getitemnumber(k_riga, "id_dosimpos")
				if k_n > 0 then
					this.setitem( row, "id_dosimpos", k_n)
				end if

//				if trim(this.getitemstring( row, "descr")) > " " then
//				if trim(this.object.descr.original[row]) > " " then
//				else
					k_x = kdwc_1.getitemstring(kdwc_1.getrow(), "descr")
					if trim(k_x) > " " then
						this.setitem( row, "descr", k_x)
					else
						this.setitem( row, "descr", "")
					end if
//				end if
//				if trim(this.getitemstring( row, "descr1")) > " " then
//				if trim(this.object.descr1.original[row]) > " " then
//				else
					k_x = kdwc_1.getitemstring(kdwc_1.getrow(), "descr1")
					if trim(k_x) > " " then
						this.setitem( row, "descr1", k_x)
					else
						this.setitem( row, "descr1", "")
					end if
//				end if
			end if
		end if
		
		if k_riga > 0 then
		else
			this.setitem( row, "id_dosimpos", 0)
		end if

end choose
end event

event dw_2::buttonclicked;call super::buttonclicked;//
if dwo.name = "b_delete" then
	this.deleterow(row)
	attiva_tasti()
end if
	

end event

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
boolean visible = true
integer width = 3003
integer height = 1268
string text = "Listini"
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
integer width = 2967
integer height = 1232
boolean enabled = true
string dataobject = "d_clienti_listino_sl_pt"
boolean ki_link_standard_sempre_possibile = true
end type

event dw_3::itemchanged;call super::itemchanged;//



end event

event dw_3::getfocus;call super::getfocus;//getfocus
if This.getSelectedRow(0) <= 0 then
	This.SelectRow(1, TRUE)
end if
//

end event

event dw_3::clicked;call super::clicked;This.SetRow(row)
This.SelectRow(0, FALSE)
if row > 0 then
	This.SelectRow(row, TRUE)
end if

end event

event rowfocuschanged;//
This.SelectRow(0, FALSE)
this.SelectRow(currentrow, TRUE)

end event

event dw_3::ue_dwnkey;//

end event

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
integer width = 3003
integer height = 1268
boolean enabled = false
string text = ""
ln_1 ln_1
end type

on tabpage_4.create
this.ln_1=create ln_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ln_1
end on

on tabpage_4.destroy
call super::destroy
destroy(this.ln_1)
end on

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
integer y = 24
integer width = 2939
integer height = 1116
integer taborder = 10
end type

event dw_4::getfocus;call super::getfocus;//getfocus
if This.getSelectedRow(0) <= 0 then
	This.SelectRow(1, TRUE)
end if
//

end event

event dw_4::clicked;call super::clicked;//
This.SetRow(row)
This.SelectRow(0, FALSE)
if row > 0 then
	This.SelectRow(row, TRUE)
end if

end event

event rowfocuschanged;//
This.SelectRow(0, FALSE)
this.SelectRow(currentrow, TRUE)

end event

event dw_4::ue_dwnkey;//

end event

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
integer width = 3003
integer height = 1268
boolean enabled = false
string text = ""
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
integer width = 2935
integer height = 1172
end type

event dw_5::clicked;call super::clicked;//
This.SetRow(row)
This.SelectRow(0, FALSE)
if row > 0 then
	This.SelectRow(row, TRUE)
end if

end event

event dw_5::getfocus;call super::getfocus;//getfocus
if This.getSelectedRow(0) <= 0 then
	This.SelectRow(1, TRUE)
end if
//

end event

event rowfocuschanged;//
This.SelectRow(0, FALSE)
this.SelectRow(currentrow, TRUE)

end event

event dw_5::ue_dwnkey;//
end event

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
integer width = 3003
integer height = 1268
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
end type

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
integer width = 3003
integer height = 1268
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
end type

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
integer width = 3003
integer height = 1268
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
integer width = 3003
integer height = 1268
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
end type

type ln_1 from line within tabpage_4
integer linethickness = 4
integer beginx = 361
integer beginy = 2376
integer endx = 2674
integer endy = 2376
end type

