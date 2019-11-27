$PBExportHeader$w_ddt_free.srw
forward
global type w_ddt_free from w_g_tab_3
end type
end forward

global type w_ddt_free from w_g_tab_3
integer x = 169
integer y = 148
integer width = 3447
integer height = 2000
string title = "DDT"
windowanimationstyle closeanimation = topslide!
boolean ki_toolbar_window_presente = true
boolean ki_fai_nuovo_dopo_update = false
boolean ki_fai_nuovo_dopo_insert = false
boolean ki_attiva_tasti_vmi = true
boolean ki_consenti_duplica = true
end type
global w_ddt_free w_ddt_free

type variables
//
private kuf_sped_free kiuf_sped_free
private st_tab_sped_free kist_tab_sped_free, kist_tab_sped_free_orig

protected kuf_clienti kiuf_clienti

private string ki_win_titolo_orig_save
end variables

forward prototypes
private subroutine pulizia_righe ()
protected function string aggiorna ()
protected function integer cancella ()
protected function string check_dati ()
private subroutine riempi_id ()
protected function string inizializza ()
protected function integer inserisci ()
protected subroutine open_start_window ()
private subroutine put_video_cliente (st_tab_clienti kst_tab_clienti)
public subroutine set_iniz_dati_cliente (ref st_tab_clienti kst_tab_clienti)
public function boolean get_dati_cliente (ref st_tab_clienti kst_tab_clienti)
protected subroutine leggi_liste ()
private subroutine proteggi_campi ()
public function boolean u_duplica () throws uo_exception
public function st_tab_sped_free u_set_st_tab_from_dw () throws uo_exception
public subroutine u_calcola_colli ()
protected subroutine inizializza_1 () throws uo_exception
protected subroutine attiva_menu ()
public subroutine u_set_indirizzo_border ()
protected subroutine attiva_tasti_0 ()
protected function string dati_modif (string k_titolo)
public function boolean stampa_ddt ()
protected function integer visualizza ()
protected subroutine modifica ()
public subroutine smista_funz (string k_par_in)
end prototypes

private subroutine pulizia_righe ();//
tab_1.tabpage_2.dw_2.accepttext()

//if tab_1.tabpage_2.dw_2.rowcount( ) > 0 then
//	if tab_1.tabpage_2.dw_2.getitemnumber(1, "id_cliente") > 0 then
//	else
//		tab_1.tabpage_2.dw_2.reset( )
//	end if
//end if

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
st_tab_sped_free kst_tab_sped_free


choose case tab_1.selectedtab 

	case 2

		//=== Aggiorna, se modificato, la TAB_1/2	
		if tab_1.tabpage_2.dw_2.getnextmodified(0, primary!) > 0 then
		
			try 
				kst_tab_sped_free = u_set_st_tab_from_dw( )   // popola st contratti
				kst_tab_sped_free.id_sped_free = tab_1.tabpage_2.dw_2.getitemnumber(1, "id_sped_free")
				kst_tab_sped_free.st_tab_g_0.esegui_commit = "S"
				//--- aggiorna
				if kst_tab_sped_free.id_sped_free > 0 then
					kiuf_sped_free.tb_update(kst_tab_sped_free)
				else
				//--- nuovo
					kiuf_sped_free.tb_insert(kst_tab_sped_free)
					tab_1.tabpage_2.dw_2.setitem(1, "id_sped_free", kst_tab_sped_free.id_sped_free)
				end if

				tab_1.tabpage_2.dw_2.resetupdate( )
				k_return ="0 "
				
				proteggi_campi()
				
			catch (uo_exception kuo_exception)
				k_return="1Fallito aggiornamento in archivio '" &
							+ tab_1.tabpage_1.text + "' ~n~r" &
							+ kguo_exception.get_errtext( )
				messagebox("Aggiornamento non eseguito", mid(k_return,2), stopsign!)
			finally
				
			end try
		end if

end choose



return k_return

end function

protected function integer cancella ();//
//=== Cancellazione rekord dal DB
//=== Ritorna : 0=OK 1=KO 2=non eseguita
//
int k_return=0
long k_riga
st_tab_clienti kst_tab_clienti
st_tab_sped_free kst_tab_sped_free
st_esito kst_esito



//=== 
choose case tab_1.selectedtab 
	case 1 

		//=== Controllo se sul dettaglio c'e' qualche cosa
		k_riga = tab_1.tabpage_1.dw_1.getselectedrow(0)
		if k_riga > 0 then
			kst_tab_sped_free.id_sped_free = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_sped_free")
			kst_tab_sped_free.num_bolla_out = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "sped_free_num_bolla_out")
			kst_tab_sped_free.data_bolla_out = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "sped_free_data_bolla_out")
		end if
		
		if k_riga > 0 and kst_tab_sped_free.id_sped_free > 0 then	
			if kst_tab_sped_free.num_bolla_out > " " then
			else
				kst_tab_sped_free.num_bolla_out = "*** DDT senza numero ***" 
			end if
			
		//=== Richiesta di conferma della eliminazione del rek
		
			if messagebox("Elimina DDT", "Sei sicuro di voler Cancellare : ~n~r" + &
						string(kst_tab_sped_free.id_sped_free, "####0") + " n. " + trim(kst_tab_sped_free.num_bolla_out) &
						+ " del " + string(kst_tab_sped_free.data_bolla_out, "dd mmm yyyy"), &
						question!, yesno!, 2) = 1 then
		 
			
		//=== Cancella 
				try
					kst_tab_sped_free.st_tab_g_0.esegui_commit = "S"
					kiuf_sped_free.tb_delete( kst_tab_sped_free ) 
				
					tab_1.tabpage_1.dw_1.deleterow(k_riga)

				catch (uo_exception kuo_exception)
					kst_esito = kuo_exception.get_st_esito()

					messagebox("Errore in Cancellazione" &
								,"Controllare i dati.~n~r" + trim(kst_esito.sqlerrtext) &
								,stopsign!)
					k_return = 1		
					tab_1.tabpage_1.dw_1.setfocus()
				end try
		
			else
				k_return = 1
				messagebox("Elimina DDT", "Operazione Annullata !!")
			end if
		
			tab_1.tabpage_2.dw_2.setcolumn(1)
		else
			messagebox("Elimina DDT", "Selezionare una riga dall'elenco")
		end if


	case 3 

end choose	


choose case tab_1.selectedtab 
	case 1 
		tab_1.tabpage_2.dw_2.setfocus()
		tab_1.tabpage_2.dw_2.setcolumn(1)
//	case 3
//		tab_1.tabpage_3.dw_3.setfocus()
//		tab_1.tabpage_3.dw_3.setcolumn(1)
end choose	


		
attiva_tasti()


return k_return

end function

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
st_esito kst_esito
datastore kds_inp

try
	kds_inp = create datastore

//--- Controllo il secondo tab
	if tab_1.tabpage_2.dw_2.rowcount() > 0 then
		kds_inp.dataobject = tab_1.tabpage_2.dw_2.dataobject
		tab_1.tabpage_2.dw_2.rowscopy( 1,tab_1.tabpage_2.dw_2.rowcount( ) ,primary!, kds_inp, 1, primary!)
		kst_esito = kiuf_sped_free.u_check_dati(kds_inp)
		if kst_esito.sqlerrtext > " " then
			kst_esito.sqlerrtext = tab_1.tabpage_1.text + ": " + kst_esito.sqlerrtext
		end if
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

private subroutine riempi_id ();//
//
long k_ctr = 0
st_tab_sped_free kst_tab_sped_free



	k_ctr = tab_1.tabpage_2.dw_2.getrow()
	
	if k_ctr > 0 then
	
		kst_tab_sped_free.id_sped_free = tab_1.tabpage_2.dw_2.getitemnumber(k_ctr, "id_sped_free")
	
////=== Se non sono in caricamento allora prelevo l'ID dalla dw
//		if tab_1.tabpage_2.dw_2.getitemstatus(k_ctr, 0, primary!) <> newmodified! then
//			kst_tab_sped_free.id_sped_free = tab_1.tabpage_2.dw_2.getitemnumber(k_ctr, "id_sped")
//		end if
	
		if isnull(kst_tab_sped_free.id_sped_free) or kst_tab_sped_free.id_sped_free = 0 then				
			tab_1.tabpage_2.dw_2.setitem(k_ctr, "id_sped_free", 0)
		end if
		
	end if


end subroutine

protected function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Parametro IN : k_id_vettore
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
string k_ricevente
int k_importa = 0, k_righe
st_tab_sped_free kst_tab_sped_free
kuf_listino kuf1_listino
pointer oldpointer  // Declares a pointer variable


	oldpointer = SetPointer(HourGlass!)

	
	if len(trim(ki_st_open_w.key1)) > 0 then 
		k_ricevente = "Ricevente codice " + trim(ki_st_open_w.key1)
		kst_tab_sped_free.clie_2 = long(trim(ki_st_open_w.key1))
	else
		k_ricevente = ""
		kst_tab_sped_free.clie_2 = 0
	end if
	//k_righe = tab_1.tabpage_1.dw_1.retrieve(dw_periodo.ki_data_ini, dw_periodo.ki_data_fin, kst_tab_sped_free.clie_2)
	k_righe = tab_1.tabpage_1.dw_1.retrieve(date('01.01.2000'), kguo_g.get_dataoggi( ), kst_tab_sped_free.clie_2)
	if k_righe < 1 then
		k_return = "1Nessuna Spedizione per il periodo: " + string(date('01.01.2000'), "dd mmm yy") + " - " + string(kguo_g.get_dataoggi( ), "dd mmm yy") + " " + k_ricevente

		SetPointer(oldpointer)
		messagebox("Elenco ddt", &
				"Nessuna Spedizione per il periodo: " + string(date('01.01.2000'), "dd mmm yy") + " - " + string(kguo_g.get_dataoggi( ), "dd mmm yy") + " " + k_ricevente)
	else
		if k_righe = 1 then
			tab_1.tabpage_1.dw_1.setrow(1)
			tab_1.tabpage_1.dw_1.selectrow(1, true)
		end if
	end if		

//	ki_win_titolo_orig = ki_win_titolo_orig_save
//	ki_win_titolo_orig += " dal " + string(date('01.01.2000'), "dd mmm yy") + " al " + string(kguo_g.get_dataoggi( ), "dd mmm yy") 
//	kiw_this_window.title = ki_win_titolo_orig

	attiva_tasti()

return k_return


end function

protected function integer inserisci ();//
int k_return=1
long k_riga
kuf_utility kuf1_utility


//=== Aggiunge una riga al data windows
	choose case tab_1.selectedtab 
		case  1, 2 

//--- legge tiutte le DWC			
			leggi_liste()			
			
			k_riga = 1
			if tab_1.tabpage_2.dw_2.rowcount() > 0 then
				
				kist_tab_sped_free.data_bolla_out = tab_1.tabpage_2.dw_2.getitemdate(k_riga, "sped_free_data_bolla_out")
				kist_tab_sped_free.aspetto = tab_1.tabpage_2.dw_2.getitemstring(k_riga, "aspetto")
				kist_tab_sped_free.porto = tab_1.tabpage_2.dw_2.getitemstring(k_riga, "porto")
				
				tab_1.tabpage_2.dw_2.reset() 
			else
				kist_tab_sped_free.data_bolla_out = kguo_g.get_dataoggi( )
			end if
			
			tab_1.tabpage_2.dw_2.insertrow(0)
			tab_1.tabpage_2.enabled = true
			
			//tab_1.tabpage_2.dw_2.setcolumn("oggetto")
			
			ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
			tab_1.tabpage_2.dw_2.ki_flag_modalita = kkg_flag_modalita.inserimento

			tab_1.tabpage_2.dw_2.setitem(1, "sped_free_data_bolla_out", kist_tab_sped_free.data_bolla_out)
			tab_1.tabpage_2.dw_2.setitem(1, "aspetto", kist_tab_sped_free.aspetto)
			tab_1.tabpage_2.dw_2.setitem(1, "porto", kist_tab_sped_free.porto)

//--- S-protezione campi per abilitare l'inserimento
			kuf1_utility = create kuf_utility
	     	kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_2.dw_2)
			destroy kuf1_utility
		
			tab_1.tabpage_2.dw_2.SetItemStatus( 1, 0, Primary!, NotModified!)

	end choose	

//	attiva_tasti()

	k_return = 0


return (k_return)



end function

protected subroutine open_start_window ();//
int k_rc


	kiuf_sped_free = create kuf_sped_free
//	kiuf_clienti = create kuf_clienti

//--- Acquisisce i dati da passati in Argomento
	if LenA(trim(ki_st_open_w.key1)) = 0 then
		kist_tab_sped_free.id_sped_free = 0
	else
		kist_tab_sped_free.id_sped_free = long(trim(ki_st_open_w.key1))
	end if

	ki_win_titolo_orig_save = trim(tab_1.tabpage_1.dw_1.title)

////--- Attivo dw elenco Oggetti già usati
//	k_rc = tab_1.tabpage_2.dw_2.getchild("oggetto", kdwc_oggetto)
//	k_rc = kdwc_oggetto.settransobject(sqlca)
//	k_rc = kdwc_oggetto.insertrow(1)
//
//	k_rc = tab_1.tabpage_2.dw_2.getchild("fattura_da", kdwc_fattura_da)
//	k_rc = kdwc_fattura_da.settransobject(sqlca)
//	k_rc = kdwc_fattura_da.insertrow(1)
////--- Attivo dw archivio Clienti-contatti
//	k_rc = tab_1.tabpage_2.dw_2.getchild("nome_contatto", kdwc_clie_tipo)
//	k_rc = kdwc_clie_tipo.settransobject(sqlca)
//	k_rc = kdwc_clie_tipo.insertrow(1)
////--- Attivo dw archivio Settori
//	k_rc = tab_1.tabpage_2.dw_2.getchild("id_clie_settore", kdwc_clie_settori)
//	k_rc = kdwc_clie_settori.settransobject(sqlca)
//	k_rc = kdwc_clie_settori.insertrow(1)
////--- Attivo dw archivio Gruppi
//	k_rc = tab_1.tabpage_2.dw_2.getchild("gruppo", kdwc_gru)
//	k_rc = kdwc_gru.settransobject(sqlca)
//	k_rc = kdwc_gru.insertrow(1)
////--- Attivo dw archivio Articoli
//	k_rc = tab_1.tabpage_2.dw_2.getchild("art", kdwc_x)
//	k_rc = kdwc_x.settransobject(sqlca)
//	k_rc = kdwc_x.insertrow(1)
////--- Attivo dw archivio IVA
//	k_rc = tab_1.tabpage_2.dw_2.getchild("iva", kdwc_iva)
//	k_rc = kdwc_iva.settransobject(sqlca)
//	k_rc = kdwc_iva.insertrow(1)
////--- Attivo dw archivio Pagamenti
//	k_rc = tab_1.tabpage_2.dw_2.getchild("cod_pag", kdwc_pag)
//	k_rc = kdwc_pag.settransobject(sqlca)
//	k_rc = kdwc_pag.insertrow(1)
//	tab_1.tabpage_2.dw_2.getchild("acconto_cod_pag", kdwc_x)
//	kdwc_pag.ShareData( kdwc_x)			
////--- Attivo dw Gruppi-Listino
//	k_rc = tab_1.tabpage_2.dw_2.getchild("id_listino_pregruppo", kdwc_x)
//	k_rc = kdwc_x.settransobject(sqlca)
//	k_rc = kdwc_x.insertrow(1)
////--- Attivo dw Voci-Prezzi
//	k_rc = tab_1.tabpage_2.dw_2.getchild("id_listino_voce_1", kdwc_x)
//	k_rc = kdwc_x.settransobject(sqlca)
//	k_rc = kdwc_x.insertrow(1)
////--- Attivo dw Voci-Prezzi
//	k_rc = tab_1.tabpage_2.dw_2.getchild("id_listino_voce_1", kdwc_x)
//	k_rc = kdwc_x.settransobject(sqlca)
//	k_rc = kdwc_x.insertrow(1)
////--- Attivo dw Venditore
//	k_rc = tab_1.tabpage_2.dw_2.getchild("venditore_nome", kdwc_x)
//	k_rc = kdwc_x.settransobject(sqlca)
//	k_rc = kdwc_x.insertrow(1)
//	k_rc = tab_1.tabpage_2.dw_2.getchild("venditore_ruolo", kdwc_x)
//	k_rc = kdwc_x.settransobject(sqlca)
//	k_rc = kdwc_x.insertrow(1)


end subroutine

private subroutine put_video_cliente (st_tab_clienti kst_tab_clienti);//
//--- Visualizza dati Cliente 
//
long k_riga=0
st_esito kst_esito
datawindowchild kdwc_1


//tab_1.tabpage_2.dw_2.modify( "id_cliente.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
//tab_1.tabpage_2.dw_2.modify( "clienti_rag_soc_10.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
////tab_1.tabpage_2.dw_2.modify( "p_iva.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
////tab_1.tabpage_2.dw_2.modify( "cf.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
//tab_1.tabpage_2.dw_2.modify( "id_nazione.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
//tab_1.tabpage_2.dw_2.setitem( 1, "clienti_id_nazione_1", kst_tab_clienti.id_nazione_1 )
//
//tab_1.tabpage_2.dw_2.setitem( 1, "id_cliente", kst_tab_clienti.codice)
//tab_1.tabpage_2.dw_2.setitem( 1, "clienti_rag_soc_10", kst_tab_clienti.rag_soc_10 )
////tab_1.tabpage_2.dw_2.setitem( 1, "p_iva", trim(kst_tab_clienti.p_iva) )
////tab_1.tabpage_2.dw_2.setitem( 1, "cf", trim(kst_tab_clienti.cf) )
//tab_1.tabpage_2.dw_2.setitem( 1, "clienti_loc_1", kst_tab_clienti.loc_1 )
//tab_1.tabpage_2.dw_2.setitem( 1, "clienti_prov_1", trim(kst_tab_clienti.prov_1) )
//tab_1.tabpage_2.dw_2.setitem( 1, "clienti_id_nazione_1", kst_tab_clienti.id_nazione_1 )
//
//tab_1.tabpage_2.dw_2.setitem( 1, "iva", kst_tab_clienti.iva )
//tab_1.tabpage_2.dw_2.getchild( "iva", kdwc_1)
//k_riga = kdwc_1.find("codice="+trim(string(kst_tab_clienti.iva)),0,kdwc_1.rowcount())
//if k_riga > 0 then
//	tab_1.tabpage_2.dw_2.setitem(1, "iva_aliq", kdwc_1.getitemnumber(k_riga,"aliq") )
//	tab_1.tabpage_2.dw_2.setitem(1, "iva_des", kdwc_1.getitemstring(k_riga,"des") )
//end if
//
//tab_1.tabpage_2.dw_2.setitem( 1, "cod_pag", kst_tab_clienti.cod_pag )
//tab_1.tabpage_2.dw_2.getchild( "cod_pag", kdwc_1)
//k_riga = kdwc_1.find("codice="+trim(string(kst_tab_clienti.cod_pag)),0,kdwc_1.rowcount())
//if k_riga > 0 then
//	tab_1.tabpage_2.dw_2.setitem(1, "pagam_des", kdwc_1.getitemstring(k_riga,"des") )
//end if
//tab_1.tabpage_2.dw_2.setitem( 1, "banca", kst_tab_clienti.banca )
//tab_1.tabpage_2.dw_2.setitem( 1, "abi", kst_tab_clienti.abi )
//tab_1.tabpage_2.dw_2.setitem( 1, "cab", kst_tab_clienti.cab )

end subroutine

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

public function boolean get_dati_cliente (ref st_tab_clienti kst_tab_clienti);//
boolean k_return = false
st_esito kst_esito
kuf_clienti kuf1_clienti


try
	
//	kuf1_clienti = create kuf_clienti

	k_return = kiuf_clienti.leggi (kst_tab_clienti)

	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	

finally
//	destroy kuf1_clienti
	
end try

return k_return


end function

protected subroutine leggi_liste ();////
//int k_rc
//datawindowchild  kdwc_clienti_des, kdwc_clienti, kdwc_clie_settori, kdwc_gru, kdwc_clie_tipo, kdwc_iva, kdwc_pag, kdwc_oggetto, kdwc_fattura_da, kdwc_1, kdwc_2
//
////--- Attivo dw archivio Clienti
//	k_rc = tab_1.tabpage_2.dw_2.getchild("id_cliente", kdwc_clienti)
//	k_rc = kdwc_clienti.settransobject(sqlca)
//	k_rc = kdwc_clienti.retrieve("%")
//	k_rc = kdwc_clienti.insertrow(1)
//	kdwc_clienti_des.setsort( "id_cliente asc")
//	kdwc_clienti_des.sort( )
//
//	k_rc = tab_1.tabpage_2.dw_2.getchild("clienti_rag_soc_10", kdwc_clienti_des)
//	k_rc = kdwc_clienti_des.settransobject(sqlca)
//
//	kdwc_clienti.RowsCopy(kdwc_clienti.GetRow(), kdwc_clienti.RowCount(), Primary!, kdwc_clienti_des, 1, Primary!)
//	kdwc_clienti_des.setsort( "rag_soc_1 asc")
//	kdwc_clienti_des.sort( )
//
////--- Attivo dw elenco Descrizioni  già usati
//	k_rc = tab_1.tabpage_2.dw_2.getchild("oggetto", kdwc_oggetto)
//	k_rc = kdwc_oggetto.settransobject(sqlca)
//	k_rc = kdwc_oggetto.retrieve()
//	k_rc = kdwc_oggetto.insertrow(1)
////--- 
//	k_rc = tab_1.tabpage_2.dw_2.getchild("fattura_da", kdwc_fattura_da)
//	k_rc = kdwc_fattura_da.settransobject(sqlca)
//	k_rc = kdwc_fattura_da.retrieve()
//	k_rc = kdwc_fattura_da.insertrow(1)
////--- Attivo dw archivio Clienti-contatti
////	k_rc = tab_1.tabpage_2.dw_2.getchild("nome_contatto", kdwc_clie_tipo)
////	k_rc = kdwc_clie_tipo.settransobject(sqlca)
////	k_rc = kdwc_clie_tipo.retrieve()
////	k_rc = kdwc_clie_tipo.insertrow(1)
////--- Attivo dw archivio Settori
//	k_rc = tab_1.tabpage_2.dw_2.getchild("id_clie_settore", kdwc_clie_settori)
//	k_rc = kdwc_clie_settori.settransobject(sqlca)
//	k_rc = kdwc_clie_settori.retrieve()
//	k_rc = kdwc_clie_settori.insertrow(1)
////--- Attivo dw archivio Gruppi
//	k_rc = tab_1.tabpage_2.dw_2.getchild("gruppo", kdwc_gru)
//	k_rc = kdwc_gru.settransobject(sqlca)
////--- piglio il codice del settore xchè la query va fatta con il codice
//	if tab_1.tabpage_2.dw_2.rowcount( ) > 0 then
//		kist_tab_contratti_doc.id_clie_settore = tab_1.tabpage_2.dw_2.getitemstring(1, "id_clie_settore")
//		if len(trim(kist_tab_contratti_doc.id_clie_settore)) > 0 then
//			k_rc = kdwc_gru.retrieve(kist_tab_contratti_doc.id_clie_settore)
//		else
//			kdwc_gru.reset()
//		end if
//	end if
//	k_rc = kdwc_gru.insertrow(1)
////--- Attivo dw archivio IVA
//	k_rc = tab_1.tabpage_2.dw_2.getchild("iva", kdwc_iva)
//	k_rc = kdwc_iva.settransobject(sqlca)
//	k_rc = kdwc_iva.retrieve()
//	k_rc = kdwc_iva.insertrow(1)
////--- Attivo dw archivio Pagamenti
//	k_rc = tab_1.tabpage_2.dw_2.getchild("cod_pag", kdwc_pag)
//	k_rc = kdwc_pag.settransobject(sqlca)
//	k_rc = kdwc_pag.retrieve()
//	k_rc = kdwc_pag.insertrow(1)
// 	k_rc = tab_1.tabpage_2.dw_2.getchild("acconto_cod_pag", kdwc_2)
//	k_rc = kdwc_pag.ShareData( kdwc_2)			
//
////--- Attivo dw archivio Gruppo-Prezzi
//	k_rc = tab_1.tabpage_2.dw_2.getchild("id_listino_pregruppo", kdwc_1)
//	k_rc = kdwc_1.settransobject(sqlca)
//	k_rc = kdwc_1.retrieve(0)
//	k_rc = kdwc_1.insertrow(1)
//
//
end subroutine

private subroutine proteggi_campi ();//
//--- Protegge o meno a seconda dei casi
//
kuf_utility kuf1_utility


	kuf1_utility = create kuf_utility 
	tab_1.tabpage_2.dw_2.setredraw(false)

//--- se NO inserimento leggo DW-CHILD
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
		kuf1_utility.u_proteggi_dw("1", "id_sped_free", tab_1.tabpage_2.dw_2)
//--- S-protezione campi 
		kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_2.dw_2)
	else
//--- Protezione tutti i campi 
		kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_2.dw_2)
		kuf1_utility.u_proteggi_dw("1", "id_sped_free", tab_1.tabpage_2.dw_2)
	end if			

	destroy kuf1_utility
		
	
	tab_1.tabpage_2.dw_2.setredraw(true)
	
end subroutine

public function boolean u_duplica () throws uo_exception;//
//--- Duplica documento 
//
long k_id_sped_free
int k_row


try
	
	if tab_1.selectedtab = 1 then
		k_row = kguf_data_base.u_getlistselectedrow(tab_1.tabpage_1.dw_1)
		k_id_sped_free = tab_1.tabpage_1.dw_1.getitemnumber(k_row, "id_sped_free")
	else
		if tab_1.tabpage_2.dw_2.rowcount( ) > 0 then
			k_row = 1
			k_id_sped_free = tab_1.tabpage_2.dw_2.getitemnumber(k_row, "id_sped_free")
		end if
	end if
	
	if k_row > 0 then
		//=== Richiesta di conferma operazione
		if messagebox("Duplica DDT", "Genera il nuovo DDT copiando i dati da questo " &
					+ "id " + string(k_id_sped_free),  &
					question!, yesno!, 2) = 1 then
					
			ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
			tab_1.tabpage_2.dw_2.ki_flag_modalita = kkg_flag_modalita.inserimento
			
			if tab_1.selectedtab = 1 then
				k_row = tab_1.tabpage_2.dw_2.retrieve(k_id_sped_free)
			end if
			
			tab_1.tabpage_2.dw_2.setitem(k_row, "sped_free_num_bolla_out", '')
			tab_1.tabpage_2.dw_2.setitem(k_row, "id_sped_free", 0)
			tab_1.tabpage_2.dw_2.resetupdate()
			
			tab_1.selecttab(2)
			
		end if	
	end if	
	
catch (uo_exception kuo_exception)
	
finally
	
end try

return true
end function

public function st_tab_sped_free u_set_st_tab_from_dw () throws uo_exception;//
int k_idx, k_rc, k_idx_max
st_tab_sped_free kst_tab_sped_free


kst_tab_sped_free.id_sped_free = tab_1.tabpage_2.dw_2.getitemnumber( 1, "id_sped_free")						

kst_tab_sped_free.data_bolla_out   	= tab_1.tabpage_2.dw_2.getitemdate( 1, "sped_free_data_bolla_out")
kst_tab_sped_free.num_bolla_out  	= tab_1.tabpage_2.dw_2.getitemstring( 1, "sped_free_num_bolla_out")
kst_tab_sped_free.causale   			= tab_1.tabpage_2.dw_2.getitemstring( 1, "causale")
kst_tab_sped_free.clie_2   			= tab_1.tabpage_2.dw_2.getitemnumber( 1, "clie_2")
kst_tab_sped_free.clie_3		   	= tab_1.tabpage_2.dw_2.getitemnumber( 1, "clie_3")


kst_tab_sped_free.stampa           = tab_1.tabpage_2.dw_2.getitemstring( 1, "stampa")
kst_tab_sped_free.form_di_stampa   = tab_1.tabpage_2.dw_2.getitemstring( 1, "form_di_stampa")
kst_tab_sped_free.aspetto          = tab_1.tabpage_2.dw_2.getitemstring( 1, "aspetto")   
kst_tab_sped_free.causale          = tab_1.tabpage_2.dw_2.getitemstring( 1, "causale") 
kst_tab_sped_free.colli            = tab_1.tabpage_2.dw_2.getitemstring( 1, "colli") 
kst_tab_sped_free.consegna         = tab_1.tabpage_2.dw_2.getitemstring( 1, "consegna") 
kst_tab_sped_free.data_ora_rit     = tab_1.tabpage_2.dw_2.getitemstring( 1, "data_ora_rit") 

k_idx_max = upperbound(kst_tab_sped_free.Indirizzo_riga[])
for k_idx = 1 to k_idx_max
	kst_tab_sped_free.Indirizzo_riga[k_idx] = tab_1.tabpage_2.dw_2.getitemstring( 1, "Indirizzo_riga_" + string(k_idx, "#"))
next
k_idx_max = upperbound(kst_tab_sped_free.descr[])
for k_idx = 1 to k_idx_max
	kst_tab_sped_free.descr[k_idx]  = tab_1.tabpage_2.dw_2.getitemstring( 1, "descr_" + string(k_idx, "#")) 
	kst_tab_sped_free.kgy[k_idx]    = tab_1.tabpage_2.dw_2.getitemstring( 1, "kgy_" + string(k_idx, "#")) 
	kst_tab_sped_free.qta[k_idx]    = tab_1.tabpage_2.dw_2.getitemstring( 1, "qta_" + string(k_idx, "#")) 
next
k_idx_max = upperbound(kst_tab_sped_free.note[])
for k_idx = 1 to k_idx_max
	kst_tab_sped_free.note[k_idx]           = tab_1.tabpage_2.dw_2.getitemstring( 1, "note_" + string(k_idx, "#")) 
next

kst_tab_sped_free.dicit_ind_intest = tab_1.tabpage_2.dw_2.getitemstring( 1, "dicit_ind_intest")   
kst_tab_sped_free.dicit_ind_sped   = tab_1.tabpage_2.dw_2.getitemstring( 1, "dicit_ind_sped") 
kst_tab_sped_free.intestazione     = tab_1.tabpage_2.dw_2.getitemstring( 1, "intestazione") 
k_idx_max = upperbound(kst_tab_sped_free.intestazione_ind[])
for k_idx = 1 to k_idx_max
	kst_tab_sped_free.intestazione_ind[k_idx] = tab_1.tabpage_2.dw_2.getitemstring( 1, "intestazione_ind" + string(k_idx, "#")) 
next
kst_tab_sped_free.peso_kg          = tab_1.tabpage_2.dw_2.getitemstring( 1, "peso_kg") 
kst_tab_sped_free.porto            = tab_1.tabpage_2.dw_2.getitemstring( 1, "porto") 
kst_tab_sped_free.sped_note        = tab_1.tabpage_2.dw_2.getitemstring( 1, "sped_note") 
kst_tab_sped_free.tipo_copia       = tab_1.tabpage_2.dw_2.getitemstring( 1, "tipo_copia") 
kst_tab_sped_free.trasporto        = tab_1.tabpage_2.dw_2.getitemstring( 1, "trasporto") 
kst_tab_sped_free.vett_1           = tab_1.tabpage_2.dw_2.getitemstring( 1, "vett_1")  
//kst_tab_sped_free.vett_2           = tab_1.tabpage_2.dw_2.getitemstring( 1, "vett_2") 
kst_tab_sped_free.resa             = tab_1.tabpage_2.dw_2.getitemstring( 1, "resa") 
kst_tab_sped_free.annotazioni      = tab_1.tabpage_2.dw_2.getitemstring( 1, "annotazioni") 

return kst_tab_sped_free
end function

public subroutine u_calcola_colli ();//
//--- calcola Importo riga 
//		
int k_idx, k_idx_max
int k_qta_sum
st_tab_sped_free kst_tab_sped_free


	if tab_1.tabpage_2.dw_2.rowcount( ) > 0 then
		
		k_idx_max = upperbound(kst_tab_sped_free.qta[])
		for k_idx = 1 to k_idx_max	
			kst_tab_sped_free.qta[k_idx] = trim(tab_1.tabpage_2.dw_2.getitemstring(1, "qta_" + string(k_idx, "#")))
			if IsNumber(kst_tab_sped_free.qta[k_idx]) then 
				k_qta_sum += integer(kst_tab_sped_free.qta[k_idx])
			end if
		next		
		
		if k_qta_sum > 0 then
			tab_1.tabpage_2.dw_2.setitem(1, "colli", string(k_qta_sum, "#"))
		end if
		
	end if
end subroutine

protected subroutine inizializza_1 () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_return="0 "
int k_rc 
st_tab_sped_free kst_tab_sped_free
st_esito kst_esito
kuf_utility kuf1_utility
uo_exception kuo_exception

 
	SetPointer(kkg.pointer_attesa)
	tab_1.tabpage_2.enabled = true
	tab_1.tabpage_2.dw_2.enabled = true

	if tab_1.tabpage_2.dw_2.ki_flag_modalita <> kkg_flag_modalita.inserimento then
		k_rc = tab_1.tabpage_2.dw_2.retrieve(kist_tab_sped_free.id_sped_free) 
		
		choose case k_rc
			case is < 0		
				SetPointer(kkg.pointer_default)
				kguo_exception.inizializza()
				kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_err_int )
				kguo_exception.setmessage(  &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(ID Documento cercato: " + string(kist_tab_sped_free.id_sped_free) + ") " )
				kguo_exception.post messaggio_utente( )	

			case 0
				SetPointer(kkg.pointer_default)
				kguo_exception.inizializza()
				kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_not_fnd )
				kguo_exception.setmessage(  &
						"Mi spiace ma il Documento cercato non e' in archivio ~n~r" + &
						"(ID Documento cercato: " + string(kist_tab_sped_free.id_sped_free) + ") " )
				kguo_exception.post messaggio_utente( )	

			case is > 0	
				kist_tab_sped_free_orig.id_sped_free = kist_tab_sped_free.id_sped_free
				kist_tab_sped_free_orig.num_bolla_out = tab_1.tabpage_2.dw_2.getitemstring(1, "sped_free_num_bolla_out")
				kist_tab_sped_free_orig.data_bolla_out = tab_1.tabpage_2.dw_2.getitemdate(1, "sped_free_data_bolla_out")
				kist_tab_sped_free.num_bolla_out = kist_tab_sped_free_orig.num_bolla_out
				kist_tab_sped_free.data_bolla_out = kist_tab_sped_free_orig.data_bolla_out
				
				tab_1.tabpage_2.dw_2.setfocus()
//				tab_1.tabpage_2.dw_2.setcolumn("fat1_note_1")
				tab_1.tabpage_2.dw_2.visible = true
		end choose
	end if
	
	if tab_1.tabpage_2.dw_2.rowcount() = 0 then
		
		SetPointer(kkg.pointer_attesa)
	
		ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
		tab_1.tabpage_2.dw_2.ki_flag_modalita = kkg_flag_modalita.inserimento
		
		inserisci()
		
	end if

//--- se inserimento inabilito gli altri TAB, sono inutili
//	if tab_1.tabpage_2.dw_2.ki_flag_modalita = kkg_flag_modalita.inserimento then
//		tab_1.tabpage_2.dw_2.setcolumn("")
//	else
//		if tab_1.tabpage_2.dw_2.ki_flag_modalita = kkg_flag_modalita.modifica then
	//		tab_1.tabpage_2.dw_2.setcolumn("oggetto")
//		end if
//	end if

//--- ripropone eventaulemnete i link
	tab_1.tabpage_2.dw_2.event u_personalizza_dw()

	tab_1.tabpage_2.dw_2.modify("clie_2_l.visible='1' clie_3_l.visible='1'") 

//--- protegge/sprotegge campi
	proteggi_campi()

	u_resize_1( )
	
//--- espone i bordi per alcuni campi
	post u_set_indirizzo_border()
	
	tab_1.tabpage_2.dw_2.visible = true
	tab_1.tabpage_2.dw_2.setfocus()
	
end subroutine

protected subroutine attiva_menu ();//--- Attiva/Dis. Voci di menu


//
//--- Attiva/Dis. Voci di menu personalizzate
//
	if not ki_menu.m_strumenti.m_fin_gest_libero5.visible then
		ki_menu.m_strumenti.m_fin_gest_libero5.text = "Stampa ddt selezionate"
		ki_menu.m_strumenti.m_fin_gest_libero5.microhelp =  "Stampa ddt selezionate"
		ki_menu.m_strumenti.m_fin_gest_libero5.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero5.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemText = "Stampa,"+ki_menu.m_strumenti.m_fin_gest_libero5.text
		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemName = "printer16x16.gif"
		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemVisible = true
	end if	
	
//---
	super::attiva_menu()



end subroutine

public subroutine u_set_indirizzo_border ();//
//<DW Control Name>.Modify("<Columnname>.Border='<0 - None, 1- Shadow, 2 - Box, 3 - Resize, 4 - Underline, 5 - 3D Lowered, 6 - 3D Raised>'")
string k_border 
string k_rc
int k_idx
string k_color

tab_1.tabpage_2.dw_2.setredraw(false)

if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica &
				or ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
	k_border = "6"
	k_color = string(rgb(205,238,255))
else
	k_border = "0"
end if
//k_rc = tab_1.tabpage_2.dw_2.modify("dicit_ind_intest.border='" + k_border &
//									+ "' intestazione.border=' " + k_border &
//									+ "' intestazione_ind.border='" + k_border &
//									+ "' dicit_ind_sped.border='" + k_border &
//									+ "' indirizzo_riga_1.border='" + k_border &
//									+ "' indirizzo_riga_2.border='" + k_border &
//									+ "' indirizzo_riga_3.border='" + k_border &
//									+ "' indirizzo_riga_4.border='" + k_border &
//									+ "' indirizzo_riga_5.border='" + k_border &
//									+ "' ")
k_rc = tab_1.tabpage_2.dw_2.modify("dicit_ind_intest.Background.Color='" + k_color &
									+ "' intestazione.Background.Color=' " + k_color &
									+ "' intestazione_ind1.Background.Color='" + k_color &
									+ "' intestazione_ind2.Background.Color='" + k_color &
									+ "' intestazione_ind3.Background.Color='" + k_color &
									+ "' intestazione_ind4.Background.Color='" + k_color &
									+ "' dicit_ind_sped.Background.Color='" + k_color &
									+ "' indirizzo_riga_1.Background.Color='" + k_color &
									+ "' indirizzo_riga_2.Background.Color='" + k_color &
									+ "' indirizzo_riga_3.Background.Color='" + k_color &
									+ "' indirizzo_riga_4.Background.Color='" + k_color &
									+ "' indirizzo_riga_5.Background.Color='" + k_color &
									+ "' sped_free_data_bolla_out.Background.Color='" + k_color &
									+ "' sped_free_num_bolla_out.Background.Color='" + k_color &
									+ "' ")
k_rc = tab_1.tabpage_2.dw_2.modify( "causale.Background.Color='" + k_color &
									+ "' sped_note.Background.Color='" + k_color &
									+ "' aspetto.Background.Color='" + k_color &
									+ "' resa.Background.Color='" + k_color &
									+ "' colli.Background.Color='" + k_color &
									+ "' peso_kg.Background.Color='" + k_color &
									+ "' porto.Background.Color='" + k_color &
									+ "' trasporto.Background.Color='" + k_color &
									+ "' data_ora_rit.Background.Color='" + k_color &
									+ "' vett_1.Background.Color='" + k_color &
									+ "' annotazioni.Background.Color='" + k_color &
									+ "' ")

for k_idx = 1 to 19
	k_rc = tab_1.tabpage_2.dw_2.modify("qta_" + string(k_idx, "#") + ".Background.Color='" + k_color &
											+ "' descr_" + string(k_idx, "#") + ".Background.Color=' " + k_color &
											+ "' kgy_" + string(k_idx, "#") + ".Background.Color=' " + k_color &
									+ "' ")
next
									
									
//									+ "' clie_2.border='" + k_border &
//									+ "' clie_3.border='" + k_border &
									
tab_1.tabpage_2.dw_2.setredraw(true)

k_rc = ""
end subroutine

protected subroutine attiva_tasti_0 ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================


super::attiva_tasti_0()


//=== Nr righe ne DW lista
if tab_1.tabpage_1.dw_1.rowcount() > 0 then

	if tab_1.tabpage_1.dw_1.getitemnumber(1, "clie_2") > 0 then
		tab_1.tabpage_4.enabled = true
	end if
	
	choose case ki_tab_1_index_new  //tab_1.selectedtab
		case 1
			st_aggiorna_lista.enabled = true
			st_ordina_lista.enabled = true
			cb_modifica.enabled = true
			cb_visualizza.enabled = true
			cb_cancella.enabled = true
			cb_inserisci.enabled = true
		case 2 //DETTAGLIO
			cb_cancella.enabled = false
	end choose

else
	
	cb_inserisci.enabled = true
	cb_inserisci.default = true
	
end if

//if ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione or ki_st_open_w.flag_modalita = kkg_flag_modalita.cancellazione then
//	cb_inserisci.enabled = false
//	cb_aggiorna.enabled = false
//	cb_cancella.enabled = false
//	cb_modifica.enabled = false
//end if





end subroutine

protected function string dati_modif (string k_titolo);//
//=== Controllo se ci sono state modifiche di dati sui DW
string k_return="0 "
//boolean k_return
int k_msg=0
int k_row


//=== Toglie le righe eventualmente da non registrare
//	pulizia_righe()
	
	if (tab_1.tabpage_2.dw_2.getnextmodified(0, primary!) > 0  & 
				or tab_1.tabpage_2.dw_2.deletedcount() > 0) then 

		if tab_1.tabpage_2.dw_2.rowcount( ) > 0  then
	
			k_msg = messagebox("Aggiorna DDT", "Dati Modificati, vuoi Salvare gli Aggiornamenti ?", &
								question!, yesnocancel!, 1) 
		
			if k_msg = 1 then
//				k_return = true
				k_return = "1Dati Modificati"	
			else
				k_return = string(k_msg)			
			end if
		end if
	end if


return k_return
end function

public function boolean stampa_ddt ();//
boolean k_return = false
string k_errore = "0"
int k_row, k_row_print
st_tab_sped_free kst_tab_sped_free[] 


try

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
		
		k_row = tab_1.tabpage_1.dw_1.getselectedrow(0)
		do while k_row > 0
			k_row_print ++
			kst_tab_sped_free[k_row_print].id_sped_free = tab_1.tabpage_1.dw_1.getitemnumber(k_row, "id_sped_free")
			kst_tab_sped_free[k_row_print].num_bolla_out = tab_1.tabpage_1.dw_1.getitemstring(k_row, "sped_free_num_bolla_out")
			k_row = tab_1.tabpage_1.dw_1.getselectedrow(k_row)
		loop
		
	//--- stampa DDT
		if k_row_print > 0 then
			
			k_return = kiuf_sped_free.u_open_stampa(kst_tab_sped_free[])
			
		end if
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try

return k_return

end function

protected function integer visualizza ();//---
//--- personalizza routine di visualizzazione
//
int k_row


try

	if tab_1.selectedtab = 1 then
		k_row = kguf_data_base.u_getlistselectedrow(tab_1.tabpage_1.dw_1)
		if k_row = 0 then
			messagebox("Visualizza DDT", "Prego, selezionare una riga dall'elenco")
		else
			kist_tab_sped_free.id_sped_free = tab_1.tabpage_1.dw_1.getitemnumber(k_row, "id_sped_free")
		end if
	end if
	
	if tab_1.selectedtab = 2 or k_row > 0 then
		ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
		tab_1.tabpage_2.dw_2.ki_flag_modalita = kkg_flag_modalita.visualizzazione 
		
//	inizializza_1( )
		tab_1.selecttab(2)
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try

return(0)
end function

protected subroutine modifica ();//---
//--- personalizza routine di visualizzazione
//
int k_row


try

	if tab_1.selectedtab = 1 then
		k_row = kguf_data_base.u_getlistselectedrow(tab_1.tabpage_1.dw_1)
		if k_row = 0 then
			messagebox("Modifica DDT", "Prego, selezionare una riga dall'elenco")
		else
			ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica
			kist_tab_sped_free.id_sped_free = tab_1.tabpage_1.dw_1.getitemnumber(k_row, "id_sped_free")
		end if
	end if
	
	if tab_1.selectedtab = 2 or k_row > 0 then
		ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica
		tab_1.tabpage_2.dw_2.ki_flag_modalita = kkg_flag_modalita.modifica 
		
		tab_1.selecttab(2)
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try

end subroutine

public subroutine smista_funz (string k_par_in);//
//===

choose case LeftA(k_par_in, 2) 

	case KKG_FLAG_RICHIESTA.libero5		//stampa ddt
		stampa_ddt()

	case else
		super::smista_funz(k_par_in)

end choose

end subroutine

on w_ddt_free.create
call super::create
end on

on w_ddt_free.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;//
if isvalid(kiuf_sped_free) then destroy kiuf_sped_free
if isvalid(kiuf_clienti) then destroy 	kiuf_clienti



end event

event u_ricevi_da_elenco;call super::u_ricevi_da_elenco;//
int k_return
int k_rc
st_tab_clienti kst_tab_clienti



if isvalid(kst_open_w) then

//--- Dalla finestra di Elenco Valori
	if kst_open_w.id_programma = kkg_id_programma_elenco &
					and long(kst_open_w.key3) > 0 then
	
		if not isvalid(kdsi_elenco_input) then kdsi_elenco_input = create datastore
		kdsi_elenco_input = kst_open_w.key12_any 
		
		if kdsi_elenco_input.rowcount() > 0 then
		
			choose case kst_open_w.key6 // nome campo di link
	
				case "clie_2_l" 
					if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento or trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
						k_return = 1
				
						tab_1.tabpage_2.dw_2.setitem(1, "clie_2", &
											 kdsi_elenco_input.getitemnumber(long(kst_open_w.key3), "id_cliente"))
						tab_1.tabpage_2.dw_2.setitem(1, "intestazione", &
											 kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "rag_soc_1"))
						tab_1.tabpage_2.dw_2.setitem(1, "intestazione_ind1", &
												trim(kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "indirizzo")))
						tab_1.tabpage_2.dw_2.setitem(1, "intestazione_ind2", &
												trim(kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "localita")) &
												+ " (" + trim(kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "prov")) + ")")
						tab_1.tabpage_2.dw_2.setitem(1, "intestazione_ind3", &
												trim(kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "nazione_nome"))) 
						tab_1.tabpage_2.dw_2.setitem(1, "intestazione_ind4", " ")
					end if		
								
				case "clie_3_l" 
					if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento or trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
						k_return = 1
				
						tab_1.tabpage_2.dw_2.setitem(1, "clie_3", &
											 kdsi_elenco_input.getitemnumber(long(kst_open_w.key3), "id_cliente"))
								

					end if		

			end choose 
		end if
							
	end if

end if

return k_return


end event

type st_ritorna from w_g_tab_3`st_ritorna within w_ddt_free
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_ddt_free
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_ddt_free
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_ddt_free
integer x = 2711
integer y = 1468
end type

type st_stampa from w_g_tab_3`st_stampa within w_ddt_free
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_ddt_free
integer x = 1179
integer y = 1472
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_ddt_free
integer x = 645
integer y = 1468
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_ddt_free
integer x = 1970
integer y = 1468
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_ddt_free
integer x = 2341
integer y = 1468
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_ddt_free
integer x = 1600
integer y = 1468
boolean enabled = false
end type

event cb_inserisci::clicked;//
//=== 
string k_errore="0"

//=== Nuovo 
	choose case tab_1.selectedtab 
		case  1, 2 
			
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
	
		tab_1.selecttab(2)  // si posiziona sul tab dettaglio
	end if

end event

type tab_1 from w_g_tab_3`tab_1 within w_ddt_free
integer y = 28
integer width = 3255
integer height = 1384
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
integer width = 3218
integer height = 1256
long backcolor = 32172778
string text = "Elenco DDT"
string picturename = "Window!"
long picturemaskcolor = 553648127
string powertiptext = "Elenco DDT a contenuto libero (non scarica il magazzino)"
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
integer x = 0
integer y = 0
integer width = 3173
integer height = 1220
string title = "elenco DDT a cotenuto libero"
string dataobject = "d_sped_free_l"
boolean hsplitscroll = false
boolean livescroll = false
borderstyle borderstyle = stylelowered!
string ki_flag_modalita = "el"
boolean ki_link_standard_sempre_possibile = true
end type

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
integer width = 3218
integer height = 1256
boolean enabled = false
string text = "DDT"
string powertiptext = "Dettaglio dati"
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
integer x = 5
integer y = 20
integer width = 2981
integer height = 1228
string dataobject = "d_ddt_st_ed7_10_2019f"
string ki_flag_modalita = "vi"
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_d_std_1_attiva_cerca = false
boolean ki_dw_visibile_in_open_window = false
end type

event dw_2::itemchanged;//
string k_codice, k_nome
int k_errore

try
	
	k_nome = lower(dwo.name)
	
	if left(k_nome,4) = "qta_" then
		post u_calcola_colli()
	end if
	
// fino a che non e' a posto il bug che la funzione non viene lanciata da u_d_std_1
	post attiva_tasti()
	
catch (uo_exception kuo_exception)
	kuo_exception.post messaggio_utente()
	k_errore = 2
	
end try

return k_errore

end event

event dw_2::itemfocuschanged;call super::itemfocuschanged;//int k_rc
//long k_cod_cli, k_cod_cli_old
//st_tab_contratti_doc kst_tab_contratti_doc
//datawindowchild  kdwc_x,  kdwc_x_des, kdwc_2
//
//
//choose case dwo.name
//
//
//	//--- Attivo dw archivio CLIENTI
//	case "clienti_rag_soc_10", "id_cliente"
//		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
//			k_rc = this.getchild("id_cliente", kdwc_x)
//			if kdwc_x.rowcount() < 2 then
//				kdwc_x.retrieve("%")
//				k_rc = this.getchild("clienti_rag_soc_10", kdwc_x_des)
//				kdwc_x.RowsCopy(kdwc_x.GetRow(), kdwc_x.RowCount(), Primary!, kdwc_x_des, 1, Primary!)
//				kdwc_x.setsort( "id_cliente A")
//				kdwc_x.sort( )
//				k_rc = kdwc_x.insertrow(1)
//				k_rc = kdwc_x_des.insertrow(1)
//			end if	
//		end if
//		
//
//	case "nome_contatto"
//		k_cod_cli = this.getitemnumber(this.getrow(), "id_cliente")
//		
//		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
//	//--- Attivo dw archivio CONTATTI
//			k_rc = this.getchild(dwo.name, kdwc_x)
//			if kdwc_x.rowcount() > 1 then
//				k_cod_cli_old = kdwc_x.getitemnumber( 2, "codice")
//				if k_cod_cli_old <> k_cod_cli or kdwc_x.rowcount() < 2 then
//					kdwc_x.retrieve(k_cod_cli)
//					k_rc = kdwc_x.insertrow(1)
//				end if
//			end if
//		end if 
//
//
//	case "gruppo"
//		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
//	
//	//--- piglio il codice del settore xchè la query va fatta con il codice
//			kist_tab_contratti_doc.id_clie_settore = this.getitemstring(1, "id_clie_settore")
//			k_rc = this.getchild(dwo.name, kdwc_x)
//			if len(trim(kist_tab_contratti_doc.id_clie_settore)) > 0 then
//	//--- Attivo dw diversi archivi 
//				if kdwc_x.rowcount() > 1 then
//					 if trim(kdwc_x.getitemstring(2, "id_clie_settore")) <> trim(kist_tab_contratti_doc.id_clie_settore) then
//						kdwc_x.reset()
//					end if
//				end if
//				if kdwc_x.rowcount() < 2 then
//					kdwc_x.retrieve(kist_tab_contratti_doc.id_clie_settore )
//					k_rc = kdwc_x.insertrow(1)
//				end if
//			else
//				k_rc = kdwc_x.reset()
//				k_rc = kdwc_x.insertrow(1)
//			end if
//		end if 
//
//	case "art"
//		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
//	
//	//--- piglio il codice del Gruppo xchè la query va fatta con il codice
//			kst_tab_contratti_doc.gruppo = this.getitemnumber(1, "gruppo")
//			if kst_tab_contratti_doc.gruppo > 0 then
//	//--- Attivo dw diversi archivi 
//				k_rc = this.getchild(dwo.name, kdwc_x)
//				if kdwc_x.rowcount() > 1 then
//					 if  isnull(kdwc_x.getitemnumber(2, "gruppo")) or kdwc_x.getitemnumber(2, "gruppo") <> kst_tab_contratti_doc.gruppo then
//						kdwc_x.reset()
//					end if
//				end if
//				if kdwc_x.rowcount() < 2 then
//					kdwc_x.retrieve(kst_tab_contratti_doc.gruppo )
//					k_rc = kdwc_x.insertrow(1)
//				end if
//			else
//				k_rc = kdwc_x.reset()
//				kdwc_x.retrieve(0)
//				k_rc = kdwc_x.insertrow(1)
//			end if
//		end if 
//
//
//	case "oggetto", "id_clie_settore",  "iva"
//		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
//	
//	//--- Attivo dw diversi archivi 
//			k_rc = this.getchild(dwo.name, kdwc_x)
//			if kdwc_x.rowcount() < 2 then
//				kdwc_x.retrieve()
//				k_rc = kdwc_x.insertrow(1)
//			end if
//		end if 
//
//	case "cod_pag", "acconto_cod_pag"
//		this.getchild("cod_pag", kdwc_x)
//		kdwc_x.settransobject(sqlca)
//		if kdwc_x.rowcount() < 2 then
//			kdwc_x.retrieve()
//			kdwc_x.insertrow(1)
//		end if
//		this.getchild("acconto_cod_pag", kdwc_2)
//		kdwc_x.ShareData( kdwc_2)			
//
//end choose
//
//
end event

event dw_2::clicked;call super::clicked;////
//long k_riga, k_id, k_rc
//datawindowchild kdwc_1, kdwc_2
//
//
//
//SetPointer(kkg.pointer_attesa)
//
//if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or  ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
//
//	if dwo.name = "quotazione_cod" &
//					or dwo.name = "offerta_validita" &
//					or dwo.name = "oggetto" &
//					or dwo.name = "note" &
//					or dwo.name = "fattura_da" &
//					or dwo.name = "acconto_cod_pag" &
//					or dwo.name = "altre_condizioni" &
//					or dwo.name = "note_interne" &
//					or dwo.name = "gest_doc_des" &
//					or dwo.name = "dir_tecnico_des" &
//					or dwo.name = "analisi_lab_des" &
//					or dwo.name = "stoccaggio_des" &
//					or dwo.name = "logistica_des" &
//					or dwo.name = "altro_des" &
//					or dwo.name = "venditore_nome" &
//					or dwo.name = "venditore_ruolo" then
//			this.getchild(dwo.name, kdwc_1)
//			k_rc = kdwc_1.settransobject(sqlca)
//			if kdwc_1.rowcount() < 2 then
//				k_rc = kdwc_1.retrieve()
//				k_rc = kdwc_1.insertrow(1)
//			end if
//	elseif dwo.name = "nome_contatto" &
//					or dwo.name = "cliente_desprod" &
//					or dwo.name = "cliente_desprod_rid" &
//					 then
//			k_id = this.getitemnumber(row, "id_cliente")
//			this.getchild(dwo.name, kdwc_1)
//			if kdwc_1.rowcount() > 1 then
//				if k_id <> kdwc_1.getitemnumber(2, "id_cliente") then
//					kdwc_1.reset( )
//				end if
//			end if
//			if kdwc_1.rowcount() < 2 then
//				k_rc = kdwc_1.settransobject(sqlca)
//				k_rc = kdwc_1.retrieve(k_id)
//				k_rc = kdwc_1.insertrow(1)
//			end if
//	end if
//
//end if
//
//SetPointer(kkg.pointer_default)
//
//
end event

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
integer x = 594
integer y = 136
integer height = 144
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
integer width = 3218
integer height = 1256
boolean enabled = false
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
end type

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
integer width = 3218
integer height = 1256
boolean enabled = false
end type

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
end type

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
integer width = 3218
integer height = 1256
boolean enabled = false
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
end type

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
integer width = 3218
integer height = 1256
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
end type

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
integer width = 3218
integer height = 1256
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
end type

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
integer width = 3218
integer height = 1256
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
integer width = 3218
integer height = 1256
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
end type

type st_duplica from w_g_tab_3`st_duplica within w_ddt_free
end type

