$PBExportHeader$w_contratti_doc.srw
forward
global type w_contratti_doc from w_g_tab_3
end type
type ln_1 from line within tabpage_4
end type
end forward

global type w_contratti_doc from w_g_tab_3
integer x = 169
integer y = 148
integer width = 3447
integer height = 2000
string title = "Quotazione"
windowanimationstyle closeanimation = topslide!
boolean ki_toolbar_window_presente = true
boolean ki_fai_nuovo_dopo_update = false
boolean ki_consenti_duplica = true
end type
global w_contratti_doc w_contratti_doc

type variables
//
protected kuf_contratti_doc kiuf_contratti_doc
protected kuf_clienti kiuf_clienti
protected st_tab_contratti_doc kist_tab_contratti_doc //memorizzare i dati di entrata


end variables

forward prototypes
private subroutine pulizia_righe ()
protected function string aggiorna ()
protected function integer cancella ()
protected function string check_dati ()
private subroutine riempi_id ()
protected function string inizializza ()
protected function integer inserisci ()
private subroutine call_elenco_mandanti ()
protected subroutine open_start_window ()
private subroutine put_video_cliente (st_tab_clienti kst_tab_clienti)
public subroutine set_iniz_dati_cliente (ref st_tab_clienti kst_tab_clienti)
public function boolean get_dati_cliente (ref st_tab_clienti kst_tab_clienti)
protected subroutine leggi_liste ()
private subroutine proteggi_campi ()
private subroutine call_memo_old ()
public subroutine u_calcola_riga (string a_riga_imp)
public subroutine u_set_imp_contratto (st_tab_contratti_doc kst_tab_contratti_doc)
public subroutine u_set_imp_acconto (st_tab_contratti_doc kst_tab_contratti_doc)
public function st_tab_contratti_doc u_calcola_tot ()
public subroutine u_imposta_tot_imp ()
public subroutine u_imposta_imp_acconto ()
private subroutine if_anag_attiva_no (st_tab_clienti ast_tab_clienti)
private function boolean if_anag_attiva (st_tab_clienti ast_tab_clienti)
private subroutine if_anag_bloccata (st_tab_clienti ast_tab_clienti)
public function st_tab_contratti_doc u_set_st_tab_from_dw ()
public function boolean u_duplica () throws uo_exception
end prototypes

private subroutine pulizia_righe ();////
//long k_riga
//
//
//
////=== Oltre a confermare ACCEPTTEXT toglie righe da non UPDATE
tab_1.tabpage_1.dw_1.accepttext()
//tab_1.tabpage_2.dw_2.accepttext()
////
//
//
//
////=== Pulisco eventuali righe rimaste vuote e aggiusto campi a NULL
//k_riga = tab_1.tabpage_1.dw_1.rowcount ( )
//if k_riga > 0 then
//
//	kiuf_contratti_doc.if_isnull( kst_tab_listino)
//	
//end if
//
if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then
	if tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente") > 0 then
	else
		tab_1.tabpage_1.dw_1.reset( )
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
st_tab_contratti_doc kst_tab_contratti_doc


//=== 
choose case tab_1.selectedtab 

	case 1 

		//=== Aggiorna, se modificato, la TAB_1	
		if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0 then
		
			kst_tab_contratti_doc = u_set_st_tab_from_dw( )
			kst_tab_contratti_doc.x_datins = kGuf_data_base.prendi_x_datins()
			kst_tab_contratti_doc.x_utente = kGuf_data_base.prendi_x_utente()
			kst_tab_contratti_doc.id_contratto_doc = tab_1.tabpage_1.dw_1.getitemnumber(1, "contratti_doc_id_contratto_doc")
			try 
				kst_tab_contratti_doc.st_tab_g_0.esegui_commit = "S"
				//--- aggiorna
				if kst_tab_contratti_doc.id_contratto_doc > 0 then
					kiuf_contratti_doc.tb_update(kst_tab_contratti_doc)
				else
				//--- nuovo
					kiuf_contratti_doc.tb_insert(kst_tab_contratti_doc)
					//kiuf_contratti_doc.get_ultimo_id(kst_tab_contratti_doc)
					tab_1.tabpage_1.dw_1.setitem(1, "contratti_doc_id_contratto_doc", kst_tab_contratti_doc.id_contratto_doc)
				end if

				tab_1.tabpage_1.dw_1.resetupdate( )
				k_return ="0 "
				
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
string k_errore = "0 ", k_errore1 = "0 "
long k_riga
st_tab_clienti kst_tab_clienti
st_tab_contratti_doc kst_tab_contratti_doc
st_esito kst_esito



//=== 
choose case tab_1.selectedtab 
	case 1 

		//=== Controllo se sul dettaglio c'e' qualche cosa
		k_riga = tab_1.tabpage_1.dw_1.rowcount()	
		if k_riga > 0 then
			kst_tab_contratti_doc.id_contratto_doc = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "contratti_doc_id_contratto_doc")
			kst_tab_clienti.codice = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_cliente")
			kst_tab_clienti.rag_soc_10 = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "clienti_rag_soc_10")
		end if
		
		if k_riga > 0 and kst_tab_contratti_doc.id_contratto_doc > 0 then	
			if isnull(kst_tab_clienti.codice) or kst_tab_clienti.codice = 0 then
				kst_tab_clienti.rag_soc_10 = "*** Progettazione senza Cliente ***" 
			end if
			
		//=== Richiesta di conferma della eliminazione del rek
		
			if messagebox("Elimina Quotazione", "Sei sicuro di voler Cancellare : ~n~r" + &
						string(kst_tab_contratti_doc.id_contratto_doc, "####0") + " di " + string(kst_tab_clienti.codice) &
						+ "  ~n~rnome: " + trim(kst_tab_clienti.rag_soc_10), &
						question!, yesno!, 2) = 1 then
		 
			
		//=== Cancella la riga dal data windows di lista
				kst_esito = kiuf_contratti_doc.tb_delete( kst_tab_contratti_doc ) 
				if kst_esito.esito = kkg_esito.ok then
					k_errore = "0" + trim(kst_esito.sqlerrtext)
		
					k_errore = kGuf_data_base.db_commit()
					if LeftA(k_errore, 1) <> "0" then
						messagebox("Problemi durante la Cancellazione !!", &
								"Controllare i dati. " + MidA(k_errore, 2))
		
					else
						
						tab_1.tabpage_1.dw_1.deleterow(k_riga)
		
					end if
		
					tab_1.tabpage_1.dw_1.setfocus()
		
				else
					k_errore = "1" + trim(kst_esito.sqlerrtext)

					k_errore1 = k_errore
					k_errore = kGuf_data_base.db_rollback()
		
					messagebox("Problemi durante Cancellazione - Operazione fallita !!", &
									MidA(k_errore1, 2) ) 	
					if LeftA(k_errore, 1) <> "0" then
						messagebox("Problemi durante il recupero dell'errore !!", &
							"Controllare i dati. " + MidA(k_errore, 2))
					end if
			
		
				end if
		
		
			else
				messagebox("Elimina Quotazione", "Operazione Annullata !!")
			end if
		
			tab_1.tabpage_1.dw_1.setcolumn(1)
		
		end if


//--- Cancella la Condizione
	case 3 

end choose	


choose case tab_1.selectedtab 
	case 1 
		tab_1.tabpage_1.dw_1.setfocus()
		tab_1.tabpage_1.dw_1.setcolumn(1)
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

//--- Controllo il primo tab
	if tab_1.tabpage_1.dw_1.rowcount() > 0 then
		kds_inp.dataobject = tab_1.tabpage_1.dw_1.dataobject
		tab_1.tabpage_1.dw_1.rowscopy( 1,tab_1.tabpage_1.dw_1.rowcount( ) ,primary!, kds_inp, 1, primary!)
		kst_esito = kiuf_contratti_doc.u_check_dati(kds_inp)
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
st_tab_contratti_doc kst_tab_contratti_doc



	k_ctr = tab_1.tabpage_1.dw_1.getrow()
	
	if k_ctr > 0 then
	
		kst_tab_contratti_doc.id_contratto_doc = tab_1.tabpage_1.dw_1.getitemnumber(k_ctr, "contratti_doc_id_contratto_doc")
	
//=== Se non sono in caricamento allora prelevo l'ID dalla dw
		if tab_1.tabpage_1.dw_1.getitemstatus(k_ctr, 0, primary!) <> newmodified! then
			kst_tab_contratti_doc.id_contratto_doc = tab_1.tabpage_1.dw_1.getitemnumber(k_ctr, "contratti_doc_id_contratto_doc")
		end if
	
		if isnull(kst_tab_contratti_doc.id_contratto_doc) or kst_tab_contratti_doc.id_contratto_doc = 0 then				
			tab_1.tabpage_1.dw_1.setitem(k_ctr, "contratti_doc_id_contratto_doc", 0)
		end if
		
	end if


end subroutine

protected function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_return="0 "
int k_rc 
//st_tab_contratti_doc kst_tab_contratti_doc
st_esito kst_esito
kuf_utility kuf1_utility
uo_exception kuo_exception

// 
pointer oldpointer  // Declares a pointer variable

if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
//=== Puntatore Cursore da attesa..... 
	oldpointer = SetPointer(HourGlass!)
//


//--- Se inserimento.... 
   if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento then
		inserisci()
	else
//--- Se NO inserimento.... 
		k_rc = tab_1.tabpage_1.dw_1.retrieve( kist_tab_contratti_doc.id_contratto_doc  ) 
		
		choose case k_rc

			case is < 0				
				messagebox("Operazione fallita", &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(ID Contratto Studio e Svulippo cercato :" + trim(string(kist_tab_contratti_doc.id_contratto_doc)) + ")~n~r" )
				cb_ritorna.postevent(clicked!)

			case 0
	
				tab_1.tabpage_1.dw_1.reset()
				attiva_tasti()

				messagebox("Ricerca fallita", &
						"Mi spiace, il codice 'Contratto Studio e Svulippo' non e' in archivio ~n~r" + &
					"(ID cercato: "  &
					 + trim(string(kist_tab_contratti_doc.id_contratto_doc)) + ")~n~r" )

				cb_ritorna.triggerevent("clicked!")

			case is > 0		
				if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
//--- se Documento già ACCETTATO/STAMPATO allora ATTENZIONE alle Modifiche	!!!!!	
					if tab_1.tabpage_1.dw_1.getitemstring( 1, "stato") = kiuf_contratti_doc.kki_STATO_stampato then
						kuo_exception = create uo_exception
						kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_allerta )
						kuo_exception.setmessage(  &
							"Attenzione, il Documento e' ga' stato Stampato 'in versione Definitiva'. ~n~rLa Modifica potebbe comprometterne l'integrità. ~n~r" + &
							"(ID Documento cercato:" + string(kist_tab_contratti_doc.id_contratto_doc) + ") " )
						kuo_exception.messaggio_utente( )	
					else
//--- se lo STATO è ACCETTATO o NON/TRASFERITO oppure contratto ANNULLATO allora permetto solo visualizzazione						
						if tab_1.tabpage_1.dw_1.getitemstring( 1, "stato") = kiuf_contratti_doc.kki_STATO_accettato &
								or tab_1.tabpage_1.dw_1.getitemstring( 1, "stato") = kiuf_contratti_doc.kki_stato_respinto &
								or tab_1.tabpage_1.dw_1.getitemstring( 1, "stato") = kiuf_contratti_doc.kki_stato_trasferito then
							ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
						end if
//						if tab_1.tabpage_1.dw_1.getitemstring( 1, "stato") = kiuf_contratti_doc.kki_STATO_accettato then
//							ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
//						end if
					end if
					
//--- legge tiutte le DWC			
					leggi_liste()			
					
				end if	
				attiva_tasti()
		
		end choose

	end if

//--- se inserimento inabilito gli altri TAB, sono inutili
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
	
//	tab_1.tabpage_2.enabled = false
		tab_1.tabpage_1.dw_1.setcolumn("quotazione_tipo")
		tab_1.tabpage_1.dw_1.setfocus()
	else
		if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
			tab_1.tabpage_1.dw_1.setcolumn("oggetto")
			tab_1.tabpage_1.dw_1.setfocus()
		end if
	end if
	

//--- protegge/sprotegge campi
	proteggi_campi()
	
	
end if

//--- ripropone eventaulemnete i link
tab_1.tabpage_1.dw_1.ki_flag_modalita = ki_st_open_w.flag_modalita
tab_1.tabpage_1.dw_1.event u_personalizza_dw()



return k_return 

end function

protected function integer inserisci ();//
int k_return=1, k_ctr, k_rc
string k_errore="0 ", k_rcx
//date k_data
long k_riga 
string k_record_base
//int k_taborder
//string k_rc1, k_style
st_tab_contratti_doc kst_tab_contratti_doc
st_tab_clienti kst_tab_clienti
st_tab_clie_settori kst_tab_clie_settori

kuf_ausiliari kuf1_ausiliari
//window kw_window
kuf_base kuf1_base
kuf_utility kuf1_utility
datawindowchild Kdwc_clie_des, kdwc_clie_cod, Kdwc_clie_contatti, kdwc_oggetto, kdwc_settori, kdwc_gru


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


//=== Aggiunge una riga al data windows
	choose case tab_1.selectedtab 
		case  1 

//			kw_window = kGuf_data_base.prendi_win_attiva()
//			kw_window.title = "Listino: Inserimento"
	
//			kst_tab_listino.cod_cli = long(trim(ki_st_open_w.key1))
//			kst_tab_listino.cod_art = trim(ki_st_open_w.key2)
			
//--- legge tiutte le DWC			
			leggi_liste()			
			
			if tab_1.tabpage_1.dw_1.rowcount() > 0 then
				
				k_riga = 1
				kst_tab_contratti_doc.magazzino = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "magazzino")
				kst_tab_contratti_doc.anno = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "anno")
				kst_tab_contratti_doc.offerta_data = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "offerta_data")
				kst_tab_contratti_doc.offerta_validita = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "offerta_validita")
				kst_tab_contratti_doc.stampa_tradotta = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "stampa_tradotta")
				kst_tab_contratti_doc.oggetto = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "oggetto")
				kst_tab_contratti_doc.id_clie_settore = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "id_clie_settore")
				kst_tab_clie_settori.descr = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "clie_settori_descr")
				kst_tab_contratti_doc.gruppo = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "gruppo")
				kst_tab_contratti_doc.art = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "art")
				kst_tab_contratti_doc.data_inizio = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "data_inizio")
				kst_tab_contratti_doc.data_fine = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "data_fine")
				kst_tab_contratti_doc.id_listino_pregruppo = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_listino_pregruppo")
				for k_ctr = 1 to 10
					kst_tab_contratti_doc.id_listino_voce[k_ctr] = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_listino_voce_" + string(k_ctr,"#"))
				next			
				tab_1.tabpage_1.dw_1.reset() 
			else
//--- piglia i dati di default dall'ultimo caricamento dell'anno in corso.... 				
				kst_tab_contratti_doc.anno = year(kg_dataoggi)
				kiuf_contratti_doc.get_dati_default( kst_tab_contratti_doc )
				if kst_tab_contratti_doc.id_contratto_doc > 0 then // se non trovo nulla allora riprovo con anno meno 1
				else
					kst_tab_contratti_doc.anno = year(kg_dataoggi) - 1
					kiuf_contratti_doc.get_dati_default( kst_tab_contratti_doc )
					if kst_tab_contratti_doc.anno = 0 then // se non trovo nulla allora riprovo con anno meno 1
						kst_tab_contratti_doc.anno = year(kg_dataoggi) 
					end if				
				end if			
			end if
			
			tab_1.tabpage_1.dw_1.insertrow(0)
			
			tab_1.tabpage_1.dw_1.setcolumn("oggetto")
			
			ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento

//--- data redazione 			
			if kst_tab_contratti_doc.anno > 0 then
				tab_1.tabpage_1.dw_1.setitem(1, "anno", kst_tab_contratti_doc.anno)
			else
				tab_1.tabpage_1.dw_1.setitem(1, "anno", year(kg_dataoggi))
			end if
			if kst_tab_contratti_doc.offerta_data > date(0) then
				tab_1.tabpage_1.dw_1.setitem(1, "offerta_data", kst_tab_contratti_doc.offerta_data)
			else
				tab_1.tabpage_1.dw_1.setitem(1, "offerta_data", kg_dataoggi)
			end if
			if len(trim(kst_tab_contratti_doc.offerta_validita)) > 0 then
				tab_1.tabpage_1.dw_1.setitem(1, "offerta_validita", kst_tab_contratti_doc.offerta_validita)
			else
				tab_1.tabpage_1.dw_1.setitem(1, "offerta_validita", "")
			end if
			if kst_tab_contratti_doc.magazzino > 0 then
				tab_1.tabpage_1.dw_1.setitem(1, "magazzino", kst_tab_contratti_doc.magazzino)
			else
				tab_1.tabpage_1.dw_1.setitem(1, "magazzino", kkg_magazzino.rd )
			end if
			tab_1.tabpage_1.dw_1.setitem(1, "stato", kst_tab_contratti_doc.stato)
			tab_1.tabpage_1.dw_1.setitem(1, "data_stampa", kst_tab_contratti_doc.data_stampa)
			tab_1.tabpage_1.dw_1.setitem(1, "stampa_tradotta", kst_tab_contratti_doc.stampa_tradotta)

//--- Imposta il periodo di default			
			if kst_tab_contratti_doc.data_inizio > date(0) then
				tab_1.tabpage_1.dw_1.setitem(1, "data_inizio", kst_tab_contratti_doc.data_inizio)
			else
				tab_1.tabpage_1.dw_1.setitem(1, "data_inizio", kg_dataoggi)
			end if
			if kst_tab_contratti_doc.data_fine > date(0) then
				tab_1.tabpage_1.dw_1.setitem(1, "data_fine", kst_tab_contratti_doc.data_inizio)
			else
				tab_1.tabpage_1.dw_1.setitem(1, "data_fine", date(year(kg_dataoggi), 12, 31))
			end if
			
//--- popolo campi cliente se passato come argomento
			if kist_tab_contratti_doc.id_cliente > 0 then
				k_rc = tab_1.tabpage_1.dw_1.getchild("clienti_rag_soc_10", Kdwc_clie_des)
//--- legge dwc dei clienti
//				if Kdwc_clie_des.rowcount() < 2 then
//					Kdwc_clie_des.retrieve("%")
//					k_rc = Kdwc_clie_des.insertrow(1)
//					k_rc = tab_1.tabpage_1.dw_1.getchild("id_cliente", kdwc_clie_cod)
//					Kdwc_clie_des.RowsCopy(Kdwc_clie_des.GetRow(), Kdwc_clie_des.RowCount(), Primary!, kdwc_clie_cod, 1, Primary!)
//					Kdwc_clie_cod.SetSort("id_cliente A")
//					Kdwc_clie_cod.sort( ) 
//				end if	

				kst_tab_clienti.codice = kist_tab_contratti_doc.id_cliente
				get_dati_cliente(kst_tab_clienti)
				put_video_cliente(kst_tab_clienti)
				
//				k_riga = Kdwc_clie_des.find("id_cliente="+trim(string(kist_tab_contratti_doc.id_cliente)),0,Kdwc_clie_des.rowcount())
//				if k_riga > 0 then
//					k_rc = tab_1.tabpage_1.dw_1.setitem(1, "id_cliente",  kist_tab_contratti_doc.id_cliente)
//					k_rc = tab_1.tabpage_1.dw_1.setitem(1, "clienti_rag_soc_10", Kdwc_clie_des.getitemstring(k_riga, "rag_soc_1"))
//					k_rc = tab_1.tabpage_1.dw_1.setitem(1, "clienti_loc_1", Kdwc_clie_des.getitemstring(k_riga, "localita"))
//					k_rc = tab_1.tabpage_1.dw_1.setitem(1, "clienti_prov_1", Kdwc_clie_des.getitemstring(k_riga, "prov"))
//					k_rc = tab_1.tabpage_1.dw_1.setitem(1, "clienti_id_nazione_1", Kdwc_clie_des.getitemstring(k_riga, "id_nazione_1"))
//				end if

//--- legge dwc dei contatti del cliente
				k_rc = tab_1.tabpage_1.dw_1.getchild("nome_contatto", Kdwc_clie_contatti)
				Kdwc_clie_contatti.retrieve(kist_tab_contratti_doc.id_cliente)
				if Kdwc_clie_contatti.rowcount( ) > 0 then
					k_riga = Kdwc_clie_contatti.find("id_cliente="+trim(string(kist_tab_contratti_doc.id_cliente)),0,Kdwc_clie_contatti.rowcount())
					if k_riga = 0 then
						k_rc = tab_1.tabpage_1.dw_1.setitem(1, "nome_contatto", " " )
					else
						if not isnull(Kdwc_clie_contatti.getitemstring(k_riga, "rag_soc_10")) and  not isnull(Kdwc_clie_contatti.getitemstring(k_riga, "rag_soc_20")) then
							k_rc = tab_1.tabpage_1.dw_1.setitem(1, "nome_contatto", trim(Kdwc_clie_contatti.getitemstring(k_riga, "rag_soc_10")) &
										+ " " + trim(Kdwc_clie_contatti.getitemstring(k_riga, "rag_soc_10")))
						else
							if not isnull(Kdwc_clie_contatti.getitemstring(k_riga, "rag_soc_10")) then
								k_rc = tab_1.tabpage_1.dw_1.setitem(1, "nome_contatto", trim(Kdwc_clie_contatti.getitemstring(k_riga, "rag_soc_10")))
							else
								if not isnull(Kdwc_clie_contatti.getitemstring(k_riga, "rag_soc_20")) then
									k_rc = tab_1.tabpage_1.dw_1.setitem(1, "nome_contatto", trim(Kdwc_clie_contatti.getitemstring(k_riga, "rag_soc_20")))
								else
									k_rc = tab_1.tabpage_1.dw_1.setitem(1, "nome_contatto", "" )
								end if						
							end if						
						end if						
					end if						
				end if						
				k_rc = Kdwc_clie_contatti.insertrow(1)

			end if

//--- legge dwc Oggetti già utilizzati
			if len(trim(kst_tab_contratti_doc.oggetto )) > 0 then
				k_rc = tab_1.tabpage_1.dw_1.setitem(1, "oggetto", kst_tab_contratti_doc.oggetto  )
			else
				k_rc = tab_1.tabpage_1.dw_1.setitem(1, "oggetto", "" )
				k_rc = tab_1.tabpage_1.dw_1.getchild("oggetto", Kdwc_oggetto)
				Kdwc_oggetto.retrieve()
				if Kdwc_oggetto.rowcount( ) > 0 then
					k_rc = tab_1.tabpage_1.dw_1.setitem(1, "oggetto", trim(Kdwc_oggetto.getitemstring(1, "oggetto")) )
				end if
			end if
			
//--- legge dwc Settori
			if len(trim(kst_tab_contratti_doc.id_clie_settore )) > 0 then
				k_rc = tab_1.tabpage_1.dw_1.setitem(1, "id_clie_settore", kst_tab_contratti_doc.id_clie_settore  )
				k_rc = tab_1.tabpage_1.dw_1.setitem(1, "clie_settori_descr", trim(kst_tab_clie_settori.descr ) )
			else
				k_rc = tab_1.tabpage_1.dw_1.setitem(1, "id_clie_settore", "" )
				k_rc = tab_1.tabpage_1.dw_1.setitem(1, "clie_settori_descr", "")

				k_rc = tab_1.tabpage_1.dw_1.getchild("id_clie_settore", kdwc_settori)
				if kdwc_settori.rowcount( ) > 0 then
					kdwc_settori.retrieve()
					if kdwc_settori.rowcount( ) > 0 then
						kuf1_ausiliari = create kuf_ausiliari

						kst_tab_clienti.codice = kist_tab_contratti_doc.id_cliente
						kiuf_clienti.get_settore(kst_tab_clienti) 
						kst_tab_clie_settori.id_clie_settore = kst_tab_clienti.id_clie_settore
						kuf1_ausiliari.tb_select( kst_tab_clie_settori )
						k_rc = tab_1.tabpage_1.dw_1.setitem(1, "id_clie_settore", trim(kst_tab_clienti.id_clie_settore) )
						k_rc = tab_1.tabpage_1.dw_1.setitem(1, "clie_settori_descr", trim(kst_tab_clie_settori.descr ) )

						destroy kuf1_ausiliari
					end if
				end if
			end if
//--- Associo gruppi-Settori
//--- Attivo dw archivio Gruppi
			kist_tab_contratti_doc.id_clie_settore = tab_1.tabpage_1.dw_1.getitemstring(1, "id_clie_settore")
			if len(trim(kist_tab_contratti_doc.id_clie_settore)) > 0 then
				k_rc = tab_1.tabpage_1.dw_1.getchild("gruppo", kdwc_gru)
				k_rc = kdwc_gru.settransobject(sqlca)
				k_rc = kdwc_gru.retrieve(kist_tab_contratti_doc.id_clie_settore)
				kdwc_gru.insertrow(0)
			end if
			
//--- Imposta Prezzi	
			tab_1.tabpage_1.dw_1.setitem(k_riga, "id_listino_pregruppo",kst_tab_contratti_doc.id_listino_pregruppo)
			for k_ctr = 1 to 10
				tab_1.tabpage_1.dw_1.setitem(k_riga, "id_listino_voce_" + string(k_ctr,"#"),kst_tab_contratti_doc.id_listino_voce[k_ctr])
			next			


//--- S-protezione campi per abilitare l'inserimento
			kuf1_utility = create kuf_utility
	     	kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)
			destroy kuf1_utility
		
//			tab_1.tabpage_1.dw_1.resetupdate( )
			tab_1.tabpage_1.dw_1.SetItemStatus( 1, 0, Primary!, NotModified!)
			
		case 2 

			
	end choose	

	attiva_tasti()

	k_return = 0

end if

return (k_return)



end function

private subroutine call_elenco_mandanti ();////
//st_tab_listino kst_tab_listino
//st_tab_cond_fatt kst_tab_cond_fatt
//st_open_w kst_open_w 
//kuf_clienti kuf1_clienti
//pointer kp_oldpointer  // Declares a pointer variable
//
//
//	kp_oldpointer = SetPointer(HourGlass!)
//
//		kuf_menu_window kuf1_menu_window
//		
//		if not isvalid(kdsi_elenco_output) then kdsi_elenco_output = create datastore   //ds da passare alla windows di elenco
//		
//		kst_tab_cond_fatt.cod_cli = tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "cod_cli")
//		if (kst_tab_cond_fatt.cod_cli) > 0 then
//	
//			kdsi_elenco_output.dataobject = kuf1_clienti.kk_dw_elenco_mand
//			kdsi_elenco_output.settransobject ( sqlca )
//			kdsi_elenco_output.retrieve(kst_tab_cond_fatt.cod_cli) 
//			kst_open_w.key1 = "Elenco Mandanti del Cliente: " + string(kst_tab_cond_fatt.cod_cli)
//
//
//			if kdsi_elenco_output.rowcount() > 0 then
//				
//			//--- chiamare la window di elenco
//			//
//			//=== Parametri : 
//			//=== struttura st_open_w
//				kst_open_w.id_programma =kkg_id_programma_elenco
//				kst_open_w.flag_primo_giro = "S"
//				kst_open_w.flag_modalita = kkg_flag_modalita.elenco
//				kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
//				kst_open_w.flag_leggi_dw = " "
//				kst_open_w.flag_cerca_in_lista = " "
//				kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
//				kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
//				kst_open_w.key4 = trim(kiw_this_window.title)   //--- Titolo della Window di chiamata per riconoscerla
//				kst_open_w.key6 = " "    //--- nome del campo cliccato
//				kst_open_w.key7 = "S"    //--- dopo la scelta chiudere la Window di elenco
//				kst_open_w.key12_any = kdsi_elenco_output
//				kst_open_w.flag_where = " "
//				kuf1_menu_window = create kuf_menu_window 
//				kuf1_menu_window.open_w_tabelle(kst_open_w)
//				destroy kuf1_menu_window
//			
//			else
//				
//				messagebox("Elenco Dati", &
//							"Nessun valore disponibile. ")
//				
//				
//			end if
//		end if
//
//
//
//
//SetPointer(kp_oldpointer)
//
//
end subroutine

protected subroutine open_start_window ();//
int k_rc
datawindowchild  kdwc_clienti_des, kdwc_clienti, kdwc_clie_settori, kdwc_gru, kdwc_clie_tipo, kdwc_iva, kdwc_pag, kdwc_oggetto, kdwc_fattura_da, kdwc_x


//	tab_1.tabpage_1.dw_1.object.b_cliente.filename = kGuo_path.get_risorse() + kkg_risorsa_elenco 
//	tab_1.tabpage_1.dw_1.object.b_cliente.filename = "folder.gif" 

	kiuf_contratti_doc = create kuf_contratti_doc
	kiuf_clienti = create kuf_clienti

//--- Acquisisce i dati da passati in Argomento
	if LenA(trim(ki_st_open_w.key1)) = 0 then
		kist_tab_contratti_doc.id_contratto_doc = 0
	else
		kist_tab_contratti_doc.id_contratto_doc = long(trim(ki_st_open_w.key1))
	end if
	if LenA(trim(ki_st_open_w.key2)) = 0 then
		kist_tab_contratti_doc.id_cliente = 0
	else
		kist_tab_contratti_doc.id_cliente = long(trim(ki_st_open_w.key2))
	end if


//--- Attivo dw archivio Clienti
	k_rc = tab_1.tabpage_1.dw_1.getchild("id_cliente", kdwc_clienti)
	k_rc = kdwc_clienti.settransobject(sqlca)
	k_rc = kdwc_clienti.insertrow(1)

	k_rc = tab_1.tabpage_1.dw_1.getchild("clienti_rag_soc_10", kdwc_clienti_des)
	k_rc = kdwc_clienti_des.settransobject(sqlca)
	k_rc = kdwc_clienti_des.insertrow(1)

	if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
		if kdwc_clienti.rowcount() < 2 then
			kdwc_clienti.retrieve("%")
			kdwc_clienti.RowsCopy(kdwc_clienti.GetRow(), kdwc_clienti.RowCount(), Primary!, kdwc_clienti_des, 1, Primary!)
			kdwc_clienti.setsort( "id_cliente A")
			kdwc_clienti.sort( )
			k_rc = kdwc_clienti.insertrow(1)
			k_rc = kdwc_clienti_des.insertrow(1)
		end if
	end if
//	kdwc_clienti.RowsCopy(kdwc_clienti.GetRow(), kdwc_clienti.RowCount(), Primary!, kdwc_clienti_des, 1, Primary!)

//--- Attivo dw elenco Oggetti già usati
	k_rc = tab_1.tabpage_1.dw_1.getchild("oggetto", kdwc_oggetto)
	k_rc = kdwc_oggetto.settransobject(sqlca)
	k_rc = kdwc_oggetto.insertrow(1)

	k_rc = tab_1.tabpage_1.dw_1.getchild("fattura_da", kdwc_fattura_da)
	k_rc = kdwc_fattura_da.settransobject(sqlca)
	k_rc = kdwc_fattura_da.insertrow(1)
//--- Attivo dw archivio Clienti-contatti
	k_rc = tab_1.tabpage_1.dw_1.getchild("nome_contatto", kdwc_clie_tipo)
	k_rc = kdwc_clie_tipo.settransobject(sqlca)
	k_rc = kdwc_clie_tipo.insertrow(1)
//--- Attivo dw archivio Settori
	k_rc = tab_1.tabpage_1.dw_1.getchild("id_clie_settore", kdwc_clie_settori)
	k_rc = kdwc_clie_settori.settransobject(sqlca)
	k_rc = kdwc_clie_settori.insertrow(1)
//--- Attivo dw archivio Gruppi
	k_rc = tab_1.tabpage_1.dw_1.getchild("gruppo", kdwc_gru)
	k_rc = kdwc_gru.settransobject(sqlca)
	k_rc = kdwc_gru.insertrow(1)
//--- Attivo dw archivio Articoli
	k_rc = tab_1.tabpage_1.dw_1.getchild("art", kdwc_x)
	k_rc = kdwc_x.settransobject(sqlca)
	k_rc = kdwc_x.insertrow(1)
//--- Attivo dw archivio IVA
	k_rc = tab_1.tabpage_1.dw_1.getchild("iva", kdwc_iva)
	k_rc = kdwc_iva.settransobject(sqlca)
	k_rc = kdwc_iva.insertrow(1)
//--- Attivo dw archivio Pagamenti
	k_rc = tab_1.tabpage_1.dw_1.getchild("cod_pag", kdwc_pag)
	k_rc = kdwc_pag.settransobject(sqlca)
	k_rc = kdwc_pag.insertrow(1)
	tab_1.tabpage_1.dw_1.getchild("acconto_cod_pag", kdwc_x)
	kdwc_pag.ShareData( kdwc_x)			
//--- Attivo dw Gruppi-Listino
	k_rc = tab_1.tabpage_1.dw_1.getchild("id_listino_pregruppo", kdwc_x)
	k_rc = kdwc_x.settransobject(sqlca)
	k_rc = kdwc_x.insertrow(1)
//--- Attivo dw Voci-Prezzi
	k_rc = tab_1.tabpage_1.dw_1.getchild("id_listino_voce_1", kdwc_x)
	k_rc = kdwc_x.settransobject(sqlca)
	k_rc = kdwc_x.insertrow(1)




end subroutine

private subroutine put_video_cliente (st_tab_clienti kst_tab_clienti);//
//--- Visualizza dati Cliente 
//
long k_riga=0
st_esito kst_esito
datawindowchild kdwc_1



tab_1.tabpage_1.dw_1.modify( "id_cliente.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
tab_1.tabpage_1.dw_1.modify( "clienti_rag_soc_10.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
//tab_1.tabpage_1.dw_1.modify( "p_iva.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
//tab_1.tabpage_1.dw_1.modify( "cf.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
tab_1.tabpage_1.dw_1.modify( "id_nazione.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
tab_1.tabpage_1.dw_1.setitem( 1, "clienti_id_nazione_1", kst_tab_clienti.id_nazione_1 )

tab_1.tabpage_1.dw_1.setitem( 1, "id_cliente", kst_tab_clienti.codice)
tab_1.tabpage_1.dw_1.setitem( 1, "clienti_rag_soc_10", kst_tab_clienti.rag_soc_10 )
//tab_1.tabpage_1.dw_1.setitem( 1, "p_iva", trim(kst_tab_clienti.p_iva) )
//tab_1.tabpage_1.dw_1.setitem( 1, "cf", trim(kst_tab_clienti.cf) )
tab_1.tabpage_1.dw_1.setitem( 1, "clienti_loc_1", kst_tab_clienti.loc_1 )
tab_1.tabpage_1.dw_1.setitem( 1, "clienti_prov_1", trim(kst_tab_clienti.prov_1) )
tab_1.tabpage_1.dw_1.setitem( 1, "clienti_id_nazione_1", kst_tab_clienti.id_nazione_1 )

tab_1.tabpage_1.dw_1.setitem( 1, "iva", kst_tab_clienti.iva )
tab_1.tabpage_1.dw_1.getchild( "iva", kdwc_1)
k_riga = kdwc_1.find("codice="+trim(string(kst_tab_clienti.iva)),0,kdwc_1.rowcount())
if k_riga > 0 then
	tab_1.tabpage_1.dw_1.setitem(1, "iva_aliq", kdwc_1.getitemnumber(k_riga,"aliq") )
	tab_1.tabpage_1.dw_1.setitem(1, "iva_des", kdwc_1.getitemstring(k_riga,"des") )
end if

tab_1.tabpage_1.dw_1.setitem( 1, "cod_pag", kst_tab_clienti.cod_pag )
tab_1.tabpage_1.dw_1.getchild( "cod_pag", kdwc_1)
k_riga = kdwc_1.find("codice="+trim(string(kst_tab_clienti.cod_pag)),0,kdwc_1.rowcount())
if k_riga > 0 then
	tab_1.tabpage_1.dw_1.setitem(1, "pagam_des", kdwc_1.getitemstring(k_riga,"des") )
end if
tab_1.tabpage_1.dw_1.setitem( 1, "banca", kst_tab_clienti.banca )
tab_1.tabpage_1.dw_1.setitem( 1, "abi", kst_tab_clienti.abi )
tab_1.tabpage_1.dw_1.setitem( 1, "cab", kst_tab_clienti.cab )


//attiva_tasti()


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

protected subroutine leggi_liste ();//
int k_rc
datawindowchild  kdwc_clienti_des, kdwc_clienti, kdwc_clie_settori, kdwc_gru, kdwc_clie_tipo, kdwc_iva, kdwc_pag, kdwc_oggetto, kdwc_fattura_da, kdwc_1, kdwc_2

//--- Attivo dw archivio Clienti
	k_rc = tab_1.tabpage_1.dw_1.getchild("id_cliente", kdwc_clienti)
	k_rc = kdwc_clienti.settransobject(sqlca)
	k_rc = kdwc_clienti.retrieve("%")
	k_rc = kdwc_clienti.insertrow(1)
	kdwc_clienti_des.setsort( "id_cliente asc")
	kdwc_clienti_des.sort( )

	k_rc = tab_1.tabpage_1.dw_1.getchild("clienti_rag_soc_10", kdwc_clienti_des)
	k_rc = kdwc_clienti_des.settransobject(sqlca)

	kdwc_clienti.RowsCopy(kdwc_clienti.GetRow(), kdwc_clienti.RowCount(), Primary!, kdwc_clienti_des, 1, Primary!)
	kdwc_clienti_des.setsort( "rag_soc_1 asc")
	kdwc_clienti_des.sort( )

//--- Attivo dw elenco Descrizioni  già usati
	k_rc = tab_1.tabpage_1.dw_1.getchild("oggetto", kdwc_oggetto)
	k_rc = kdwc_oggetto.settransobject(sqlca)
	k_rc = kdwc_oggetto.retrieve()
	k_rc = kdwc_oggetto.insertrow(1)
//--- 
	k_rc = tab_1.tabpage_1.dw_1.getchild("fattura_da", kdwc_fattura_da)
	k_rc = kdwc_fattura_da.settransobject(sqlca)
	k_rc = kdwc_fattura_da.retrieve()
	k_rc = kdwc_fattura_da.insertrow(1)
//--- Attivo dw archivio Clienti-contatti
//	k_rc = tab_1.tabpage_1.dw_1.getchild("nome_contatto", kdwc_clie_tipo)
//	k_rc = kdwc_clie_tipo.settransobject(sqlca)
//	k_rc = kdwc_clie_tipo.retrieve()
//	k_rc = kdwc_clie_tipo.insertrow(1)
//--- Attivo dw archivio Settori
	k_rc = tab_1.tabpage_1.dw_1.getchild("id_clie_settore", kdwc_clie_settori)
	k_rc = kdwc_clie_settori.settransobject(sqlca)
	k_rc = kdwc_clie_settori.retrieve()
	k_rc = kdwc_clie_settori.insertrow(1)
//--- Attivo dw archivio Gruppi
	k_rc = tab_1.tabpage_1.dw_1.getchild("gruppo", kdwc_gru)
	k_rc = kdwc_gru.settransobject(sqlca)
//--- piglio il codice del settore xchè la query va fatta con il codice
	if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then
		kist_tab_contratti_doc.id_clie_settore = tab_1.tabpage_1.dw_1.getitemstring(1, "id_clie_settore")
		if len(trim(kist_tab_contratti_doc.id_clie_settore)) > 0 then
			k_rc = kdwc_gru.retrieve(kist_tab_contratti_doc.id_clie_settore)
		else
			kdwc_gru.reset()
		end if
	end if
	k_rc = kdwc_gru.insertrow(1)
//--- Attivo dw archivio IVA
	k_rc = tab_1.tabpage_1.dw_1.getchild("iva", kdwc_iva)
	k_rc = kdwc_iva.settransobject(sqlca)
	k_rc = kdwc_iva.retrieve()
	k_rc = kdwc_iva.insertrow(1)
//--- Attivo dw archivio Pagamenti
	k_rc = tab_1.tabpage_1.dw_1.getchild("cod_pag", kdwc_pag)
	k_rc = kdwc_pag.settransobject(sqlca)
	k_rc = kdwc_pag.retrieve()
	k_rc = kdwc_pag.insertrow(1)
 	k_rc = tab_1.tabpage_1.dw_1.getchild("acconto_cod_pag", kdwc_2)
	k_rc = kdwc_pag.ShareData( kdwc_2)			

//--- Attivo dw archivio Gruppo-Prezzi
	k_rc = tab_1.tabpage_1.dw_1.getchild("id_listino_pregruppo", kdwc_1)
	k_rc = kdwc_1.settransobject(sqlca)
	k_rc = kdwc_1.retrieve(0)
	k_rc = kdwc_1.insertrow(1)
//	k_rc = tab_1.tabpage_1.dw_1.getchild("id_listino_pregruppo_1", kdwc_2)
//	kdwc_1.sharedata( kdwc_2)
//	k_rc = tab_1.tabpage_1.dw_1.getchild("id_listino_pregruppo_2", kdwc_2)
//	kdwc_1.sharedata( kdwc_2)
//	k_rc = tab_1.tabpage_1.dw_1.getchild("id_listino_pregruppo_3", kdwc_2)
//	kdwc_1.sharedata( kdwc_2)
//	k_rc = tab_1.tabpage_1.dw_1.getchild("id_listino_pregruppo_4", kdwc_2)
//	kdwc_1.sharedata( kdwc_2)
//	k_rc = tab_1.tabpage_1.dw_1.getchild("id_listino_pregruppo_5", kdwc_2)
//	kdwc_1.sharedata( kdwc_2)
//	k_rc = tab_1.tabpage_1.dw_1.getchild("id_listino_pregruppo_6", kdwc_2)
//	kdwc_1.sharedata( kdwc_2)
//	k_rc = tab_1.tabpage_1.dw_1.getchild("id_listino_pregruppo_7", kdwc_2)
//	kdwc_1.sharedata( kdwc_2)
//	k_rc = tab_1.tabpage_1.dw_1.getchild("id_listino_pregruppo_8", kdwc_2)
//	kdwc_1.sharedata( kdwc_2)
//	k_rc = tab_1.tabpage_1.dw_1.getchild("id_listino_pregruppo_9", kdwc_2)
//	kdwc_1.sharedata( kdwc_2)
//	k_rc = tab_1.tabpage_1.dw_1.getchild("id_listino_pregruppo_10", kdwc_2)
//	kdwc_1.sharedata( kdwc_2)


end subroutine

private subroutine proteggi_campi ();//
//--- Protegge o meno a seconda dei casi
//
kuf_utility kuf1_utility


//--- se NO inserimento leggo DW-CHILD
	if ki_st_open_w.flag_modalita <> kkg_flag_modalita.inserimento and tab_1.tabpage_1.dw_1.getrow() > 0 then

		tab_1.tabpage_1.dw_1.setredraw(false)

//--- Inabilita campi alla modifica se Visualizzazione
		kuf1_utility = create kuf_utility 
		if trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.inserimento and trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.modifica &
			 			or (tab_1.tabpage_1.dw_1.getitemstring( 1, "stato") <> kiuf_contratti_doc.kki_STATO_riaperto and tab_1.tabpage_1.dw_1.getitemstring( 1, "stato") <> kiuf_contratti_doc.kki_STATO_nuovo) then
		
//--- Protezione tutti i campi 
			kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_1.dw_1)
			kuf1_utility.u_proteggi_dw("1", "contratti_doc_id_contratto_doc", tab_1.tabpage_1.dw_1)
			kuf1_utility.u_proteggi_dw("1", "id_listino_pregruppo", tab_1.tabpage_1.dw_1)
				
//--- se sono in MODIFICA e Contratto già stampa definitiva allora inabilito tutti i campi all'infuori che lo Stato			
			if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica &
			 			and (tab_1.tabpage_1.dw_1.getitemstring( 1, "stato") = kiuf_contratti_doc.kki_STATO_stampato &
						         or tab_1.tabpage_1.dw_1.getitemstring( 1, "stato") = kiuf_contratti_doc.kki_STATO_accettato &
						         or tab_1.tabpage_1.dw_1.getitemstring( 1, "stato") = kiuf_contratti_doc.kki_STATO_respinto) then
//--- Abilito solo campo STATO
				kuf1_utility.u_proteggi_dw("0", "stato", tab_1.tabpage_1.dw_1)
			end if			

		else

//--- S-protezione campi per riabilitare la modifica a parte la chiave
			kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)

//--- Inabilita campo cliente per la modifica se Funzione MODIFICA
			if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
	
//--- protegge i campi chiave
				kuf1_utility.u_proteggi_dw("1", "contratti_doc_id_contratto_doc", tab_1.tabpage_1.dw_1)


			end if
	
		end if
		destroy kuf1_utility
		
	
		tab_1.tabpage_1.dw_1.setredraw(true)
	
	end if

end subroutine

private subroutine call_memo_old ();//
//=== Legge il rek dalla DW lista per la modifica

long k_riga
st_tab_clienti_memo kst_tab_clienti_memo 
st_memo kst_memo
kuf_memo kuf1_memo
kuf_memo_inout kuf1_memo_inout


try   
	k_riga = tab_1.tabpage_1.dw_1.getrow()
	if k_riga > 0 then
	
		kst_tab_clienti_memo.id_cliente_memo = tab_1.tabpage_1.dw_1.getitemnumber( k_riga, "id_cliente_memo" ) 
//		if kst_tab_clienti_memo.id_cliente_memo > 0 then
//			kiuf_clienti.get_id_memo(kst_tab_clienti_memo)
//		else
			kst_tab_clienti_memo.id_memo = 0
//		end if
		kst_tab_clienti_memo.id_cliente = tab_1.tabpage_1.dw_1.getitemnumber( k_riga, "id_cliente" ) 
			
		if kst_tab_clienti_memo.id_cliente  > 0 then
			kuf1_memo = create kuf_memo
			kuf1_memo_inout = create kuf_memo_inout
			kst_tab_clienti_memo.tipo_sv = ki_st_open_w.sr_settore //kuf1_memo.kki_tipo_sv_CRD
			kst_memo.st_tab_clienti_memo = kst_tab_clienti_memo
			kuf1_memo_inout.memo_xcliente(kst_memo.st_tab_clienti_memo, kst_memo.st_tab_memo)
			kuf1_memo.u_attiva_funzione(kst_memo,kkg_flag_modalita.inserimento )   // APRE FUNZIONE
			
		end if
	end if 
		
catch (uo_exception	kuo_exception)
	kuo_exception.messaggio_utente()
		
end try
	


end subroutine

public subroutine u_calcola_riga (string a_riga_imp);//
//--- calcola Importo riga 
//		
st_tab_contratti_doc kst_tab_contratti_doc

	a_riga_imp = trim(a_riga_imp)
		
	kst_tab_contratti_doc.voce_qta[1] = tab_1.tabpage_1.dw_1.getitemnumber(1, "voce_qta_" + a_riga_imp)
	if kst_tab_contratti_doc.voce_qta[1] > 0 then
		kst_tab_contratti_doc.voce_prezzo[1] = tab_1.tabpage_1.dw_1.getitemnumber(1, "voce_prezzo_" + a_riga_imp)
		if kst_tab_contratti_doc.voce_prezzo[1] <> 0 then
			kst_tab_contratti_doc.voce_prezzo_tot[1] = kst_tab_contratti_doc.voce_qta[1] * kst_tab_contratti_doc.voce_prezzo[1]
		end if
	else
		kst_tab_contratti_doc.voce_prezzo_tot[1] = 0
	end if
	tab_1.tabpage_1.dw_1.setitem(1, "voce_prezzo_tot_" + a_riga_imp, kst_tab_contratti_doc.voce_prezzo_tot[1])

end subroutine

public subroutine u_set_imp_contratto (st_tab_contratti_doc kst_tab_contratti_doc);//
tab_1.tabpage_1.dw_1.setitem(1, "totale_contratto", kst_tab_contratti_doc.totale_contratto)


end subroutine

public subroutine u_set_imp_acconto (st_tab_contratti_doc kst_tab_contratti_doc);//
	tab_1.tabpage_1.dw_1.setitem(1, "acconto_imp", kst_tab_contratti_doc.acconto_imp)


end subroutine

public function st_tab_contratti_doc u_calcola_tot ();//
int k_id = 0
string k_idx =""
st_tab_contratti_doc kst_tab_contratti_doc
decimal {2} k_subtot=0.00


kst_tab_contratti_doc.totale_contratto = 0
kst_tab_contratti_doc.acconto_imp = 0

//--- calcola tot documento
for k_id = 1 to 10 
	
	k_idx = trim(string(k_id))
	
	kst_tab_contratti_doc.voce_prezzo_tot[1] = 0
		
	kst_tab_contratti_doc.flg_st_voce[1] = tab_1.tabpage_1.dw_1.getitemstring(1, "flg_st_voce_" + k_idx)
	if kst_tab_contratti_doc.flg_st_voce[1] = "N" then
	else
		kst_tab_contratti_doc.voce_prezzo[1] = tab_1.tabpage_1.dw_1.getitemnumber(1, "voce_prezzo_" + k_idx)
		if kst_tab_contratti_doc.voce_prezzo[1] <> 0 then
			kst_tab_contratti_doc.voce_qta[1] = tab_1.tabpage_1.dw_1.getitemnumber(1, "voce_qta_" + k_idx)
			if kst_tab_contratti_doc.voce_qta[1] > 0 then
				kst_tab_contratti_doc.voce_prezzo_tot[1] = kst_tab_contratti_doc.voce_qta[1] * kst_tab_contratti_doc.voce_prezzo[1] 
				if kst_tab_contratti_doc.voce_prezzo[1] <> 0 then
					if k_id = 10 then  // lo SCONTO non è parte del Subtotale
					else
						k_subtot += kst_tab_contratti_doc.voce_qta[1] * kst_tab_contratti_doc.voce_prezzo[1] 
					end if
				end if
			end if
		end if
	end if
	
	if k_id = 10 then  // lo SCONTO è sulla decima riga
		kst_tab_contratti_doc.totale_contratto -= abs(kst_tab_contratti_doc.voce_prezzo_tot[1])
	else
		kst_tab_contratti_doc.totale_contratto += kst_tab_contratti_doc.voce_prezzo_tot[1]
	end if
	

end for

//--- calcola eventuale Acconto
kst_tab_contratti_doc.acconto_perc = tab_1.tabpage_1.dw_1.getitemnumber(1, "acconto_perc")
if kst_tab_contratti_doc.acconto_perc > 0 then
	kst_tab_contratti_doc.acconto_imp = k_subtot * (kst_tab_contratti_doc.acconto_perc / 100)
end if



return kst_tab_contratti_doc

end function

public subroutine u_imposta_tot_imp ();//
//--- calcola e imposta i totali a video
//
st_tab_contratti_doc kst_tab_contratti_doc


	kst_tab_contratti_doc = u_calcola_tot( )
	u_set_imp_contratto(kst_tab_contratti_doc)
	u_set_imp_acconto(kst_tab_contratti_doc)
	
end subroutine

public subroutine u_imposta_imp_acconto ();//
//--- calcola e imposta i totali a video
//
st_tab_contratti_doc kst_tab_contratti_doc


	kst_tab_contratti_doc = u_calcola_tot( )
	u_set_imp_acconto(kst_tab_contratti_doc)
	
end subroutine

private subroutine if_anag_attiva_no (st_tab_clienti ast_tab_clienti);//
//--- Msg di angrafica attiva
//
	messagebox("Anagrafica non attiva", &
			    "Il cliente "+ string(ast_tab_clienti.codice) + "  non è Attivo in Anagrafe, per utilizzarlo prima procedere con il cambio di stato", information!)

end subroutine

private function boolean if_anag_attiva (st_tab_clienti ast_tab_clienti);//
//--- Verifica se l'angrafica è attiva
//
boolean k_attivo, k_bloccato, k_return = false


try
	setPointer(kkg.pointer_attesa)

	if ast_tab_clienti.codice > 0 then

		k_attivo = kiuf_clienti.if_attivo(ast_tab_clienti)  // cliente ATTIVO completamente?
		if not k_attivo then
			post if_anag_attiva_no(ast_tab_clienti)
		else
			k_bloccato = kiuf_clienti.if_bloccato(ast_tab_clienti) //cliente con causale di BLOCCO?
			if k_bloccato then
				post if_anag_bloccata(ast_tab_clienti)
			else
				k_return = true  // CLIENTE OK!!!
			end if
		end if
		
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally
	SetPointer(kkg.pointer_default)

end try
	
return k_return

end function

private subroutine if_anag_bloccata (st_tab_clienti ast_tab_clienti);//
//--- Msg di angrafica BLOCCATA
//
st_tab_meca_causali kst_tab_meca_causali
kuf_ausiliari kuf1_ausiliari


	kuf1_ausiliari = create kuf_ausiliari
	
	kst_tab_meca_causali.id_meca_causale = ast_tab_clienti.id_meca_causale
	kuf1_ausiliari.tb_select(kst_tab_meca_causali)
	
	messagebox("Anagrafica Bloccata", &
			    "Il cliente "+ string(ast_tab_clienti.codice) + " è bloccato per '" &
				 + string(ast_tab_clienti.id_meca_causale) + " " + trim(kst_tab_meca_causali.descrizione) &
				 + "' in Anagrafe, per utilizzarlo prima procedere con la rimozione del blocco", information!)

	destroy kuf1_ausiliari
end subroutine

public function st_tab_contratti_doc u_set_st_tab_from_dw ();//
int k_idx
st_tab_contratti_doc kst_tab_contratti_doc


kst_tab_contratti_doc.id_contratto_doc = tab_1.tabpage_1.dw_1.getitemnumber( 1, "contratti_doc_id_contratto_doc")						
//kst_tab_contratti_doc.id_contratto = tab_1.tabpage_1.dw_1.getitemnumber( 1, "id_contratto")	
kst_tab_contratti_doc.quotazione_cod = tab_1.tabpage_1.dw_1.getitemstring( 1, "quotazione_cod")		
kst_tab_contratti_doc.quotazione_tipo = tab_1.tabpage_1.dw_1.getitemstring( 1, "quotazione_tipo")		
kst_tab_contratti_doc.anno = tab_1.tabpage_1.dw_1.getitemnumber( 1, "anno")
kst_tab_contratti_doc.magazzino = tab_1.tabpage_1.dw_1.getitemnumber( 1, "magazzino")			
kst_tab_contratti_doc.offerta_data = tab_1.tabpage_1.dw_1.getitemdate( 1, "offerta_data")
kst_tab_contratti_doc.offerta_validita = tab_1.tabpage_1.dw_1.getitemstring( 1, "offerta_validita")
kst_tab_contratti_doc.stato = tab_1.tabpage_1.dw_1.getitemstring( 1, "stato")				
kst_tab_contratti_doc.stampa_tradotta = tab_1.tabpage_1.dw_1.getitemstring( 1, "stampa_tradotta")
kst_tab_contratti_doc.data_stampa = tab_1.tabpage_1.dw_1.getitemdate( 1, "data_stampa")
kst_tab_contratti_doc.data_inizio = tab_1.tabpage_1.dw_1.getitemdate( 1, "data_inizio")
kst_tab_contratti_doc.data_fine = tab_1.tabpage_1.dw_1.getitemdate( 1, "data_fine")
kst_tab_contratti_doc.oggetto = tab_1.tabpage_1.dw_1.getitemstring( 1, "oggetto")
kst_tab_contratti_doc.id_clie_settore = tab_1.tabpage_1.dw_1.getitemstring( 1, "id_clie_settore")
kst_tab_contratti_doc.gruppo = tab_1.tabpage_1.dw_1.getitemnumber( 1, "gruppo")
kst_tab_contratti_doc.art = tab_1.tabpage_1.dw_1.getitemstring( 1, "art")
kst_tab_contratti_doc.cliente_desprod = tab_1.tabpage_1.dw_1.getitemstring( 1, "cliente_desprod")
kst_tab_contratti_doc.cliente_desprod_rid = tab_1.tabpage_1.dw_1.getitemstring( 1, "cliente_desprod_rid")
kst_tab_contratti_doc.id_cliente = tab_1.tabpage_1.dw_1.getitemnumber( 1, "id_cliente")
//kst_tab_contratti_doc.id_docprod = tab_1.tabpage_1.dw_1.getitemnumber( 1, "id_docprod")
kst_tab_contratti_doc.nome_contatto = tab_1.tabpage_1.dw_1.getitemstring( 1, "nome_contatto")
kst_tab_contratti_doc.note_fasi_operative = tab_1.tabpage_1.dw_1.getitemstring( 1, "note_fasi_operative")
kst_tab_contratti_doc.note = tab_1.tabpage_1.dw_1.getitemstring( 1, "note")
//kst_tab_contratti_doc.note_audit = tab_1.tabpage_1.dw_1.getitemstring( 1, "note_audit")
kst_tab_contratti_doc.id_listino_pregruppo = tab_1.tabpage_1.dw_1.getitemnumber( 1, "id_listino_pregruppo")
for k_idx = 1 to 10 
	kst_tab_contratti_doc.id_listino_voce[k_idx] = tab_1.tabpage_1.dw_1.getitemnumber( 1, "id_listino_voce_" + string(k_idx, "#"))
	kst_tab_contratti_doc.descr[k_idx] = tab_1.tabpage_1.dw_1.getitemstring( 1, "descr_" + string(k_idx, "#"))
	kst_tab_contratti_doc.voce_prezzo[k_idx] = tab_1.tabpage_1.dw_1.getitemnumber( 1, "voce_prezzo_" + string(k_idx, "#"))
	kst_tab_contratti_doc.voce_prezzo_tot[k_idx] = tab_1.tabpage_1.dw_1.getitemnumber( 1, "voce_prezzo_tot_" + string(k_idx, "#"))		
	kst_tab_contratti_doc.voce_qta[k_idx] = tab_1.tabpage_1.dw_1.getitemnumber( 1, "voce_qta_" + string(k_idx, "#"))
	kst_tab_contratti_doc.flg_st_voce[k_idx] = tab_1.tabpage_1.dw_1.getitemstring( 1, "flg_st_voce_" + string(k_idx, "#"))		
next
kst_tab_contratti_doc.totale_contratto = tab_1.tabpage_1.dw_1.getitemnumber( 1, "totale_contratto")	
kst_tab_contratti_doc.iva = tab_1.tabpage_1.dw_1.getitemnumber( 1, "iva")
kst_tab_contratti_doc.cod_pag = tab_1.tabpage_1.dw_1.getitemnumber( 1, "cod_pag")
kst_tab_contratti_doc.banca = tab_1.tabpage_1.dw_1.getitemstring( 1, "banca")
kst_tab_contratti_doc.abi = tab_1.tabpage_1.dw_1.getitemnumber( 1, "abi")
kst_tab_contratti_doc.cab = tab_1.tabpage_1.dw_1.getitemnumber( 1, "cab")
kst_tab_contratti_doc.acconto_perc = tab_1.tabpage_1.dw_1.getitemnumber( 1, "acconto_perc")		
kst_tab_contratti_doc.acconto_imp = tab_1.tabpage_1.dw_1.getitemnumber( 1, "acconto_imp")	
kst_tab_contratti_doc.acconto_cod_pag = tab_1.tabpage_1.dw_1.getitemnumber( 1, "acconto_cod_pag")		
kst_tab_contratti_doc.fattura_da = tab_1.tabpage_1.dw_1.getitemstring( 1, "fattura_da")
kst_tab_contratti_doc.altre_condizioni = tab_1.tabpage_1.dw_1.getitemstring( 1, "altre_condizioni")
kst_tab_contratti_doc.esito_operazioni_ts_operazione = tab_1.tabpage_1.dw_1.getitemdatetime( 1, "esito_operazioni_ts_operazione")
//kst_tab_contratti_doc.form_di_stampa = tab_1.tabpage_1.dw_1.getitemstring( 1, "form_di_stampa")
kst_tab_contratti_doc.flg_fatt_dopo_valid = tab_1.tabpage_1.dw_1.getitemstring( 1, "flg_fatt_dopo_valid")	
kst_tab_contratti_doc.id_meca_causale = tab_1.tabpage_1.dw_1.getitemnumber( 1, "id_meca_causale")
kst_tab_contratti_doc.x_datins = tab_1.tabpage_1.dw_1.getitemdatetime( 1, "x_datins")
kst_tab_contratti_doc.x_utente = tab_1.tabpage_1.dw_1.getitemstring( 1, "x_utente")


return kst_tab_contratti_doc
end function

public function boolean u_duplica () throws uo_exception;//
//--- Duplica documento 
//

try
	ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
	
	tab_1.tabpage_1.dw_1.setitem(1, "contratti_doc_id_contratto_doc", 0)
	tab_1.tabpage_1.dw_1.setitem(1, "anno", kguo_g.get_anno( ) )
	tab_1.tabpage_1.dw_1.setitem(1, "quotazione_cod", "")
	tab_1.tabpage_1.dw_1.setitem(1, "stato", "1")
	tab_1.tabpage_1.dw_1.setitem(1, "data_stampa", kkg.data_zero )
	tab_1.tabpage_1.dw_1.setitem(1, "offerta_data", kguo_g.get_dataoggi( ) )
	tab_1.tabpage_1.dw_1.setitem(1, "data_inizio", kkg.data_zero )
	tab_1.tabpage_1.dw_1.setitem(1, "data_fine", kkg.data_zero )
	tab_1.tabpage_1.dw_1.setitem(1, "esito_operazioni_ts_operazione", kguo_g.get_datetime_zero( ) )
	tab_1.tabpage_1.dw_1.setitem(1, "x_utente", "")
	tab_1.tabpage_1.dw_1.setitem(1, "x_datins", kguo_g.get_datetime_zero( ) )
	
	tab_1.tabpage_1.dw_1.resetupdate( )
	
catch (uo_exception kuo_exception)
	
finally
	
end try

return true
end function

on w_contratti_doc.create
int iCurrent
call super::create
end on

on w_contratti_doc.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;//
if isvalid(kiuf_contratti_doc) then destroy 	kiuf_contratti_doc
if isvalid(kiuf_clienti) then destroy 	kiuf_clienti



end event

event u_ricevi_da_elenco;call super::u_ricevi_da_elenco;//
//
int k_rc
//string k_capitolati=""
window k_window
st_esito kst_esito
st_tab_contratti  kst_tab_contratti 
st_tab_clienti kst_tab_clienti
//kuf_contratti kuf1_contratti
kuf_menu_window kuf1_menu_window 
kuf_sicurezza kuf1_sicurezza



//st_open_w kst_open_w

//kst_open_w = Message.PowerObjectParm	

if isvalid(kst_open_w) then

//--- Dalla finestra di Elenco Valori
	if kst_open_w.id_programma = kkg_id_programma_elenco &
					and long(kst_open_w.key3) > 0 then
	
		if not isvalid(kdsi_elenco_input) then kdsi_elenco_input = create datastore
		kdsi_elenco_input = kst_open_w.key12_any 
		
		if kdsi_elenco_input.rowcount() > 0 then
		
			choose case kst_open_w.key2
	
				case "d_listino_pregruppo_l" 
					if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento or  trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
				
							tab_1.tabpage_1.dw_1.setitem(1, "id_listino_pregruppo", &
											 kdsi_elenco_input.getitemnumber(long(kst_open_w.key3), "id_listino_pregruppo"))
							tab_1.tabpage_1.dw_1.setitem(1, "listino_pregruppo_descr", &
												(trim(kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "descr"))))
									

					end if		

				case  "d_clienti_l_rag_soc"  
					if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento or  trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
						kst_tab_clienti.codice = kdsi_elenco_input.getitemnumber(long(kst_open_w.key3), "id_cliente")
						if kst_tab_clienti.codice > 0 then
							kst_tab_clienti.rag_soc_10 = kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "rag_soc_1")
							kst_tab_clienti.loc_1 = kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "localita")
							kst_tab_clienti.prov_1 = kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "prov")
							kst_tab_clienti.id_nazione_1 = kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "id_nazione_1")
							
							tab_1.tabpage_1.dw_1.setitem(1, "id_cliente", kst_tab_clienti.codice)
							tab_1.tabpage_1.dw_1.setitem(1, "clienti_rag_soc_10", kst_tab_clienti.rag_soc_10)
							tab_1.tabpage_1.dw_1.setitem(1, "clienti_loc_1", kst_tab_clienti.loc_1)
							tab_1.tabpage_1.dw_1.setitem(1, "clienti_prov_1", kst_tab_clienti.prov_1)
							tab_1.tabpage_1.dw_1.setitem(1, "clienti_id_nazione_1", kst_tab_clienti.id_nazione_1)
						end if
					end if
				
			end choose 
		end if
							
	end if

end if
//


end event

type st_ritorna from w_g_tab_3`st_ritorna within w_contratti_doc
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_contratti_doc
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_contratti_doc
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_contratti_doc
integer x = 2711
integer y = 1468
end type

type st_stampa from w_g_tab_3`st_stampa within w_contratti_doc
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_contratti_doc
integer x = 1179
integer y = 1472
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_contratti_doc
integer x = 645
integer y = 1468
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_contratti_doc
integer x = 1970
integer y = 1468
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_contratti_doc
integer x = 2341
integer y = 1468
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_contratti_doc
integer x = 1600
integer y = 1468
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

type tab_1 from w_g_tab_3`tab_1 within w_contratti_doc
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
string text = "R.& D."
string picturename = "Window!"
long picturemaskcolor = 553648127
string powertiptext = "Quotazione"
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
integer y = 36
integer width = 3173
integer height = 1220
string dataobject = "d_contratti_doc"
boolean minbox = true
boolean maxbox = true
boolean hsplitscroll = false
string ki_flag_modalita = "vi"
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_d_std_1_attiva_cerca = false
end type

event dw_1::itemchanged;//
date k_data
string k_codice, k_nome
string k_des
int k_errore=0
long k_riga, k_rc
st_esito kst_esito
st_tab_contratti kst_tab_contratti
st_tab_contratti_doc kst_tab_contratti_doc
st_tab_clienti kst_tab_clienti
kuf_contratti kuf1_contratti
datawindowchild kdwc_1, kdwc_x, kdwc_x_des


try
	
	k_nome = lower(dwo.name)
	
	if k_nome = "clienti_rag_soc_10" then
			if len(trim(data)) > 0 then 
				tab_1.tabpage_1.dw_1.getchild(dwo.name, kdwc_1)
				k_riga = kdwc_1.find( "rag_soc_1 like '" + trim(data) + "%" +"'" , 1, kdwc_1.rowcount())
				if k_riga > 0 then
					kst_tab_clienti.codice = kdwc_1.getitemnumber( k_riga, "id_cliente")
					if if_anag_attiva(kst_tab_clienti) then
						get_dati_cliente(kst_tab_clienti)
						post put_video_cliente(kst_tab_clienti)
					else
						this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
						set_iniz_dati_cliente(kst_tab_clienti)
						post put_video_cliente(kst_tab_clienti)
						post if_anag_attiva_no(kst_tab_clienti)
					end if
//					get_dati_cliente(kst_tab_clienti)
//					post put_video_cliente(kst_tab_clienti)
				else
					tab_1.tabpage_1.dw_1.object.id_cliente[1] = 0
					tab_1.tabpage_1.dw_1.modify( dwo.name + ".Background.Color = '" + string(kkg_colore.ERR_DATO) + "' ") 
				end if
			else
				set_iniz_dati_cliente(kst_tab_clienti)
				post put_video_cliente(kst_tab_clienti)
			end if
	
	elseif k_nome = "id_cliente" then
			if len(trim(data)) > 0 and isnumber(trim(data)) then 
				tab_1.tabpage_1.dw_1.getchild(dwo.name, kdwc_1)
				k_riga = kdwc_1.find( "id_cliente = " + trim(data) + " " , 1, kdwc_1.rowcount())
				if k_riga > 0 then
					kst_tab_clienti.codice = long(trim(data))
					if if_anag_attiva(kst_tab_clienti) then
						get_dati_cliente(kst_tab_clienti)
						post put_video_cliente(kst_tab_clienti)
					else
						this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
						set_iniz_dati_cliente(kst_tab_clienti)
						post put_video_cliente(kst_tab_clienti)
					end if
//					get_dati_cliente(kst_tab_clienti)
//					post put_video_cliente(kst_tab_clienti)
				else
					tab_1.tabpage_1.dw_1.modify( dwo.name + ".Background.Color = '" + string(kkg_colore.ERR_DATO) + "' ") 
				end if
			else
				set_iniz_dati_cliente(kst_tab_clienti)
				post put_video_cliente(kst_tab_clienti)
			end if
	
	
	elseif k_nome = "id_clie_settore" then
			if Len(trim(data)) > 0 then
				k_codice = RightTrim(data)
				k_rc = this.getchild("id_clie_settore", kdwc_x)
				k_riga = kdwc_x.find("id_clie_settore = ~""+ trim(k_codice)+"~" ",0,kdwc_x.rowcount())
				if k_riga <= 0 or isnull(k_riga) then
					k_errore = 2
					this.setitem(row, "clie_settori_descr", " - NON TROVATO -")
				else
					this.setitem(row, "clie_settori_descr", kdwc_x.getitemstring(k_riga, "descr"))
				end if
			else
				this.setitem(row, "clie_settori_descr", "")
				this.setitem(row, "id_clie_settore", "")
			end if
	
	
	elseif k_nome = "gruppo" then
			if Len(trim(data)) > 0 then
				k_codice = RightTrim(data)
				k_rc = this.getchild("gruppo", kdwc_x)
				k_riga = kdwc_x.find("codice = "+ trim(k_codice)+" ",0,kdwc_x.rowcount())
				if k_riga <= 0 or isnull(k_riga) then
					k_errore = 2
					this.setitem(row, "gru_des", " - NON TROVATO -")
				else
					this.setitem(row, "gru_des", kdwc_x.getitemstring(k_riga, "des"))
				end if
			else
				this.setitem(row, "gru_des", "")
				this.setitem(row, "gruppo", 0)
			end if
	
	
	elseif k_nome = "art" then
			if Len(trim(data)) > 0 then
				k_codice = RightTrim(data)
				k_rc = this.getchild("art", kdwc_x)
				k_riga = kdwc_x.find("codice = '"+ trim(k_codice)+"' ",0,kdwc_x.rowcount())
				if k_riga <= 0 or isnull(k_riga) then
					k_errore = 2
					this.setitem(row, "prodotti_des_mkt", " - NON TROVATO -")
				else
					this.setitem(row, "prodotti_des_mkt", kdwc_x.getitemstring(k_riga, "des"))
				end if
			else
				this.setitem(row, "prodotti_des_mkt", "")
				this.setitem(row, "art", "")
			end if
	
	
	elseif k_nome = "iva" then
			if Len(trim(data)) > 0 then
				k_codice = RightTrim(data)
				k_rc = this.getchild("iva", kdwc_x)
				k_riga = kdwc_x.find("codice = "+ trim(k_codice)+" ",0,kdwc_x.rowcount())
				if k_riga <= 0 or isnull(k_riga) then
					k_errore = 2
					this.setitem(row, "iva_aliq", 0)
					this.setitem(row, "iva_des", " - NON TROVATO -")
				else
					this.setitem(row, "iva_aliq", kdwc_x.getitemnumber(k_riga, "aliq"))
					this.setitem(row, "iva_des", kdwc_x.getitemstring(k_riga, "des"))
				end if
			else
				this.setitem(row, "iva_aliq", 0)
				this.setitem(row, "iva_des", "")
				this.setitem(row, "iva", 0)
			end if
	
	
	elseif k_nome = "cod_pag" then
			if Len(trim(data)) > 0 then
				k_codice = RightTrim(data)
				k_rc = this.getchild("cod_pag", kdwc_x)
				k_riga = kdwc_x.find("codice = "+ trim(k_codice)+" ",0,kdwc_x.rowcount())
				if k_riga <= 0 or isnull(k_riga) then
					k_errore = 2
					this.setitem(row, "pagam_des", " - NON TROVATO -")
				else
					this.setitem(row, "pagam_des", kdwc_x.getitemstring(k_riga, "des"))
				end if
			else
				this.setitem(row, "pagam_des", "")
				this.setitem(row, "cod_pag", "")
			end if
	
	elseif k_nome = "acconto_cod_pag" then
			if Len(trim(data)) > 0 then
				k_codice = RightTrim(data)
				k_rc = this.getchild("acconto_cod_pag", kdwc_x)
				k_riga = kdwc_x.find("codice = "+ trim(k_codice)+" ",0,kdwc_x.rowcount())
				if k_riga <= 0 or isnull(k_riga) then
					k_errore = 2
					this.setitem(row, "acconto_pagam_des", " - NON TROVATO -")
				else
					this.setitem(row, "acconto_pagam_des", kdwc_x.getitemstring(k_riga, "des"))
				end if
			else
				this.setitem(row, "acconto_pagam_des", "")
				this.setitem(row, "acconto_cod_pag", "")
			end if
			
	elseif left(k_nome, 5) = "stato" then
			kst_tab_contratti_doc.stato = this.getitemstring( 1, "stato")
			choose case trim(data) 
				case kiuf_contratti_doc.kki_stato_riaperto 
					if kst_tab_contratti_doc.stato <> kiuf_contratti_doc.kki_stato_stampato then
						kguo_exception.inizializza( )
						kguo_exception.setmessage("Non è possibile modificare lo STATO su RIAPERTO; non sembra avere senso")
						kguo_exception.post messaggio_utente()
						k_errore = 2
					end if
				case kiuf_contratti_doc.kki_stato_trasferito 
					kguo_exception.inizializza( )
					kguo_exception.setmessage("Non è possibile modificare lo STATO su TRASFERITO; usa l'apposita funzione")
					kguo_exception.post messaggio_utente()
					k_errore = 2
				case kiuf_contratti_doc.kki_stato_nuovo 
					kguo_exception.inizializza( )
					kguo_exception.setmessage("Non è possibile modificare lo STATO su NUOVO; usa 'RIAPERTO'")
					kguo_exception.post messaggio_utente()
					k_errore = 2
				case kiuf_contratti_doc.kki_stato_stampato 
					kst_tab_contratti_doc.id_contratto_doc = this.getitemnumber( row, "id_contratto_doc")
					if kst_tab_contratti_doc.id_contratto_doc > 0 then
						kiuf_contratti_doc.get_stato(kst_tab_contratti_doc)
					end if
					if kst_tab_contratti_doc.stato > " " then
					else
						kst_tab_contratti_doc.stato =  kiuf_contratti_doc.kki_stato_nuovo
					end if
					if kst_tab_contratti_doc.stato <> kiuf_contratti_doc.kki_stato_stampato then
						kguo_exception.inizializza( )
						kguo_exception.setmessage("Non è possibile modificare lo STATO su STAMPATO; usa 'Stampa definitiva'")
						kguo_exception.post messaggio_utente()
						k_errore = 2
					end if
				case kiuf_contratti_doc.kki_stato_accettato &
					    ,kiuf_contratti_doc.kki_stato_respinto 
					kst_tab_contratti_doc.id_contratto_doc = this.getitemnumber( row, "id_contratto_doc")
					if kst_tab_contratti_doc.id_contratto_doc > 0 then
						kiuf_contratti_doc.get_stato(kst_tab_contratti_doc)
					end if
					if kst_tab_contratti_doc.stato > " " then
					else
						kst_tab_contratti_doc.stato =  kiuf_contratti_doc.kki_stato_nuovo
					end if
					if kst_tab_contratti_doc.stato <> kiuf_contratti_doc.kki_stato_stampato then
						kguo_exception.inizializza( )
						kguo_exception.setmessage("Non è possibile modificare lo STATO su ACCETTATO o  SCADUTO;  fare prima la stampa DEFINITIVA")
						kguo_exception.post messaggio_utente()
						k_errore = 2
					end if

				case else	
//--- protegge/sprotegge campi
					post proteggi_campi()
			end choose
			if k_errore = 0 then
				post attiva_tasti()
			end if
			
	
	elseif k_nome = "id_listino_pregruppo" then
			this.getchild("id_listino_voce_1", kdwc_1)
			kdwc_1.reset( )
			if Len(trim(data)) > 0 then
				k_codice = RightTrim(data)
				k_rc = this.getchild("id_listino_pregruppo", kdwc_x)
				k_riga = kdwc_x.find("id_listino_pregruppo = "+ trim(k_codice)+" ",0,kdwc_x.rowcount())
				if k_riga <= 0 or isnull(k_riga) then
					k_errore = 2
					this.setitem(row, "listino_pregruppo_descr", " - NON TROVATO -")
				else
					this.setitem(row, "listino_pregruppo_descr", kdwc_x.getitemstring(k_riga, "descr"))
				end if
			else
				this.setitem(row, "pagam_des", "")
				this.setitem(row, "cod_pag", "")
			end if
			
	
	elseif left(k_nome,16) = "id_listino_voce_" then
			k_des = trim(mid(k_nome, 17))

			if Len(trim(data)) > 0 then
				k_codice = RightTrim(data)
				k_rc = this.getchild(k_nome, kdwc_x)
				k_riga = kdwc_x.find("id_listino_voce = "+ trim(k_codice)+" ",0,kdwc_x.rowcount())
				if k_riga <= 0 or isnull(k_riga) then
					k_errore = 2
	//				this.setitem(row, "listino_voci_descr_" + k_des , " - NON TROVATO -")
					this.setitem(row, "voce_prezzo_" + k_des , 0)
					this.setitem(row, "listino_voci_tipo_listino_" + k_des , "")
					this.setitem(row, "listino_voci_tipo_calcolo_" + k_des , "")
					this.setitem(row, "descr_" + k_des , "")
				else
	//				this.setitem(row, "listino_voci_descr_" + k_des , kdwc_x.getitemstring(k_riga, "listino_voci_descr"))
					if this.getitemnumber(row, "voce_prezzo_" + k_des ) <> 0 &
							and kdwc_x.getitemnumber(k_riga, "listino_pregruppi_voci_prezzo") <> this.getitemnumber(row, "voce_prezzo_" + k_des ) then
						kguo_exception.inizializza( )					
						kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_dati_wrn )
						kguo_exception.setmessage( "Attenzione è cambiato il prezzo da " + string(this.getitemnumber(row, "voce_prezzo_" + k_des ), "€0.00" ) &
															+ " a " +  string(kdwc_x.getitemnumber(k_riga, "listino_pregruppi_voci_prezzo"), "€0.00" ) )	 
						kguo_exception. post messaggio_utente( )
					end if
					this.setitem(row, "voce_prezzo_" + k_des , kdwc_x.getitemnumber(k_riga, "listino_pregruppi_voci_prezzo"))
					this.setitem(row, "listino_voci_tipo_listino_" + k_des, kdwc_x.getitemstring(k_riga, "listino_voci_tipo_listino"))
					this.setitem(row, "listino_voci_tipo_calcolo_" + k_des, kdwc_x.getitemstring(k_riga, "listino_voci_tipo_calcolo")) 
					if this.getitemstring( row, "stampa_tradotta") = "EN" then
						this.setitem(row, "descr_" + k_des, kdwc_x.getitemstring(k_riga, "listino_voci_descr_xctr_eng")) 
					else
						this.setitem(row, "descr_" + k_des, kdwc_x.getitemstring(k_riga, "listino_voci_descr_xctr")) 
					end if
				end if
			else
				this.setitem(row, dwo.name, "")
				this.setitem(row, "voce_prezzo_" + k_des , 0)
				this.setitem(row, "listino_voci_tipo_listino_" + k_des , "")
				this.setitem(row, "listino_voci_tipo_calcolo_" + k_des, "")
				this.setitem(row, "descr_" + k_des , "")
			end if

	
	elseif left(k_nome, 12) = "voce_prezzo_" and left(k_nome, 16) <> "voce_prezzo_tot_" then
			k_des = trim(mid(k_nome, 13))
			post u_calcola_riga(k_des)
			post u_imposta_tot_imp()

	
	elseif left(k_nome, 9) = "voce_qta_" then
			k_des = trim(mid(k_nome, 10))
			post u_calcola_riga(k_des)
			post u_imposta_tot_imp()

	
	elseif left(k_nome, 12) = "flg_st_voce_" then
			k_des = trim(mid(k_nome, 13))
			post u_calcola_riga(k_des)
			post u_imposta_tot_imp()


	elseif k_nome = "acconto_perc" then
			post u_imposta_imp_acconto()


	end if 

	if k_errore = 0 then
		attiva_tasti()
	end if

catch (uo_exception kuo_exception)
	kuo_exception.post messaggio_utente()
	k_errore = 2
	
end try

return k_errore
	
end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;int k_rc
long k_cod_cli, k_cod_cli_old
st_tab_contratti_doc kst_tab_contratti_doc
datawindowchild  kdwc_x,  kdwc_x_des, kdwc_2


choose case dwo.name


	//--- Attivo dw archivio CLIENTI
	case "clienti_rag_soc_10", "id_cliente"
		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
			k_rc = this.getchild("id_cliente", kdwc_x)
			if kdwc_x.rowcount() < 2 then
				kdwc_x.retrieve("%")
				k_rc = this.getchild("clienti_rag_soc_10", kdwc_x_des)
				kdwc_x.RowsCopy(kdwc_x.GetRow(), kdwc_x.RowCount(), Primary!, kdwc_x_des, 1, Primary!)
				kdwc_x.setsort( "id_cliente A")
				kdwc_x.sort( )
				k_rc = kdwc_x.insertrow(1)
				k_rc = kdwc_x_des.insertrow(1)
			end if	
		end if
		

	case "nome_contatto"
		k_cod_cli = this.getitemnumber(this.getrow(), "id_cliente")
		
		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
	//--- Attivo dw archivio CONTATTI
			k_rc = this.getchild(dwo.name, kdwc_x)
			if kdwc_x.rowcount() > 1 then
				k_cod_cli_old = kdwc_x.getitemnumber( 2, "codice")
				if k_cod_cli_old <> k_cod_cli or kdwc_x.rowcount() < 2 then
					kdwc_x.retrieve(k_cod_cli)
					k_rc = kdwc_x.insertrow(1)
				end if
			end if
		end if 


	case "gruppo"
		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
	
	//--- piglio il codice del settore xchè la query va fatta con il codice
			kist_tab_contratti_doc.id_clie_settore = this.getitemstring(1, "id_clie_settore")
			k_rc = this.getchild(dwo.name, kdwc_x)
			if len(trim(kist_tab_contratti_doc.id_clie_settore)) > 0 then
	//--- Attivo dw diversi archivi 
				if kdwc_x.rowcount() > 1 then
					 if trim(kdwc_x.getitemstring(2, "id_clie_settore")) <> trim(kist_tab_contratti_doc.id_clie_settore) then
						kdwc_x.reset()
					end if
				end if
				if kdwc_x.rowcount() < 2 then
					kdwc_x.retrieve(kist_tab_contratti_doc.id_clie_settore )
					k_rc = kdwc_x.insertrow(1)
				end if
			else
				k_rc = kdwc_x.reset()
				k_rc = kdwc_x.insertrow(1)
			end if
		end if 

	case "art"
		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
	
	//--- piglio il codice del Gruppo xchè la query va fatta con il codice
			kst_tab_contratti_doc.gruppo = this.getitemnumber(1, "gruppo")
			if kst_tab_contratti_doc.gruppo > 0 then
	//--- Attivo dw diversi archivi 
				k_rc = this.getchild(dwo.name, kdwc_x)
				if kdwc_x.rowcount() > 1 then
					 if  isnull(kdwc_x.getitemnumber(2, "gruppo")) or kdwc_x.getitemnumber(2, "gruppo") <> kst_tab_contratti_doc.gruppo then
						kdwc_x.reset()
					end if
				end if
				if kdwc_x.rowcount() < 2 then
					kdwc_x.retrieve(kst_tab_contratti_doc.gruppo )
					k_rc = kdwc_x.insertrow(1)
				end if
			else
				k_rc = kdwc_x.reset()
				kdwc_x.retrieve(0)
				k_rc = kdwc_x.insertrow(1)
			end if
		end if 


	case "oggetto", "id_clie_settore",  "iva"
		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
	
	//--- Attivo dw diversi archivi 
			k_rc = this.getchild(dwo.name, kdwc_x)
			if kdwc_x.rowcount() < 2 then
				kdwc_x.retrieve()
				k_rc = kdwc_x.insertrow(1)
			end if
		end if 

	case "cod_pag", "acconto_cod_pag"
		this.getchild("cod_pag", kdwc_x)
		kdwc_x.settransobject(sqlca)
		if kdwc_x.rowcount() < 2 then
			kdwc_x.retrieve()
			kdwc_x.insertrow(1)
		end if
		this.getchild("acconto_cod_pag", kdwc_2)
		kdwc_x.ShareData( kdwc_2)			


//--- campo Gruppo Listino
	case "id_listino_voce_1" &
			, "id_listino_voce_2" &
			, "id_listino_voce_3" &
			, "id_listino_voce_4" &
			, "id_listino_voce_5" &
			, "id_listino_voce_6" &
			, "id_listino_voce_7" &
			, "id_listino_voce_8" &
			, "id_listino_voce_9" &
			, "id_listino_voce_10"
		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
			kst_tab_contratti_doc.id_listino_pregruppo = this.getitemnumber(1, "id_listino_pregruppo")
			if kst_tab_contratti_doc.id_listino_pregruppo > 0 then
				k_rc = this.getchild(dwo.name, kdwc_x)
				if kdwc_x.rowcount() > 1 then
					 if  isnull(kdwc_x.getitemnumber(2, "id_listino_pregruppo")) or kdwc_x.getitemnumber(2, "id_listino_pregruppo") <> kst_tab_contratti_doc.id_listino_pregruppo then
						kdwc_x.reset()
					end if
				else
					this.getchild("id_listino_voce_1", kdwc_x)
					kdwc_x.settransobject(sqlca)
					kdwc_x.retrieve(kst_tab_contratti_doc.id_listino_pregruppo )
					k_rc = kdwc_x.insertrow(1)
				end if
			else
				k_rc = kdwc_x.reset()
				kdwc_x.retrieve(0)
				k_rc = kdwc_x.insertrow(1)
			end if
			k_rc = tab_1.tabpage_1.dw_1.getchild("id_listino_voce_2", kdwc_2)
			kdwc_x.sharedata( kdwc_2)
			k_rc = tab_1.tabpage_1.dw_1.getchild("id_listino_voce_3", kdwc_2)
			kdwc_x.sharedata( kdwc_2)
			k_rc = tab_1.tabpage_1.dw_1.getchild("id_listino_voce_4", kdwc_2)
			kdwc_x.sharedata( kdwc_2)
			k_rc = tab_1.tabpage_1.dw_1.getchild("id_listino_voce_5", kdwc_2)
			kdwc_x.sharedata( kdwc_2)
			k_rc = tab_1.tabpage_1.dw_1.getchild("id_listino_voce_6", kdwc_2)
			kdwc_x.sharedata( kdwc_2)
			k_rc = tab_1.tabpage_1.dw_1.getchild("id_listino_voce_7", kdwc_2)
			kdwc_x.sharedata( kdwc_2)
			k_rc = tab_1.tabpage_1.dw_1.getchild("id_listino_voce_8", kdwc_2)
			kdwc_x.sharedata( kdwc_2)
			k_rc = tab_1.tabpage_1.dw_1.getchild("id_listino_voce_9", kdwc_2)
			kdwc_x.sharedata( kdwc_2)
			k_rc = tab_1.tabpage_1.dw_1.getchild("id_listino_voce_10", kdwc_2)
			kdwc_x.sharedata( kdwc_2)
		end if 
		
end choose


end event

event dw_1::clicked;call super::clicked;//
long k_riga, k_id, k_rc
datawindowchild kdwc_1, kdwc_2
pointer kp_oldpointer  // Declares a pointer variable



kp_oldpointer = SetPointer(HourGlass!)


choose case dwo.name

	case "id_listino_pregruppo"
		this.getchild("id_listino_pregruppo", kdwc_1)
		kdwc_1.reset( )
		k_rc = tab_1.tabpage_1.dw_1.getchild("id_listino_pregruppo", kdwc_1)
		k_rc = kdwc_1.settransobject(sqlca)
		k_rc = kdwc_1.retrieve(0)
		k_rc = kdwc_1.insertrow(1)


	case "id_listino_voce_1" &
			, "id_listino_voce_2" &
			, "id_listino_voce_3" &
			, "id_listino_voce_4" &
			, "id_listino_voce_5" &
			, "id_listino_voce_6" &
			, "id_listino_voce_7" &
			, "id_listino_voce_8" &
			, "id_listino_voce_9" &
			, "id_listino_voce_10"

		k_id = this.getitemnumber(row, "id_listino_pregruppo")

		this.getchild("id_listino_voce_1", kdwc_1)
		kdwc_1.settransobject(sqlca)
		if kdwc_1.rowcount() < 2 then
			kdwc_1.retrieve(k_id)
			kdwc_1.insertrow(1)
			this.getchild("id_listino_voce_2", kdwc_2)
			kdwc_1.ShareData( kdwc_2)			
			this.getchild("id_listino_voce_3", kdwc_2)
			kdwc_1.ShareData( kdwc_2)			
			this.getchild("id_listino_voce_4", kdwc_2)
			kdwc_1.ShareData( kdwc_2)			
			this.getchild("id_listino_voce_5", kdwc_2)
			kdwc_1.ShareData( kdwc_2)			
			this.getchild("id_listino_voce_6", kdwc_2)
			kdwc_1.ShareData( kdwc_2)			
			this.getchild("id_listino_voce_7", kdwc_2)
			kdwc_1.ShareData( kdwc_2)			
			this.getchild("id_listino_voce_8", kdwc_2)
			kdwc_1.ShareData( kdwc_2)			
			this.getchild("id_listino_voce_9", kdwc_2)
			kdwc_1.ShareData( kdwc_2)			
			this.getchild("id_listino_voce_10", kdwc_2)
			kdwc_1.ShareData( kdwc_2)			
		end if


//	case "p_id_memo_no" &
//		 ,"p_id_memo"
//		call_memo()


end choose

SetPointer(kp_oldpointer)


end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
boolean visible = false
integer width = 3218
integer height = 1256
boolean enabled = false
string text = "tab"
string powertiptext = "Entrate-Uscite di magazzino"
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
boolean visible = true
integer x = 0
integer width = 2981
integer height = 1228
boolean enabled = true
string ki_flag_modalita = "vi"
end type

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
integer x = 594
integer y = 136
integer height = 144
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
integer width = 3218
integer height = 1256
boolean enabled = false
string text = "tab"
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
integer width = 2967
integer height = 1232
string ki_flag_modalita = "vi"
end type

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
integer width = 3218
integer height = 1256
boolean enabled = false
string text = "tab"
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
string ki_flag_modalita = "vi"
end type

event buttonclicked;//
//=== Attivo/Disattivo visione grafico
if this.object.kgr_1.visible = "1" then
	tab_1.tabpage_4.dw_4.object.kcb_gr.text = "Grafico"
	tab_1.tabpage_4.dw_4.object.kgr_1.visible = "0" 
else
	tab_1.tabpage_4.dw_4.object.kcb_gr.text = "Dati"
	tab_1.tabpage_4.dw_4.object.kgr_1.visible = "1"
end if
//

end event

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
integer width = 3218
integer height = 1256
boolean enabled = false
string text = "tab"
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
integer width = 2935
integer height = 1172
string ki_flag_modalita = "vi"
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
string ki_flag_modalita = "vi"
end type

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
integer width = 3218
integer height = 1256
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
string ki_flag_modalita = "vi"
end type

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
integer width = 3218
integer height = 1256
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
string ki_flag_modalita = "vi"
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
integer width = 3218
integer height = 1256
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
string ki_flag_modalita = "vi"
end type

type st_duplica from w_g_tab_3`st_duplica within w_contratti_doc
end type

type ln_1 from line within tabpage_4
integer linethickness = 4
integer beginx = 361
integer beginy = 2376
integer endx = 2674
integer endy = 2376
end type

