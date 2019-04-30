$PBExportHeader$w_memo.srw
forward
global type w_memo from w_g_tab_3
end type
type ln_1 from line within tabpage_4
end type
end forward

global type w_memo from w_g_tab_3
integer x = 169
integer y = 148
integer width = 3680
integer height = 2088
string title = "Piano di Trattamento SL-PT"
boolean ki_sincronizza_window_ok = true
boolean ki_fai_nuovo_dopo_update = false
boolean ki_fai_nuovo_dopo_insert = false
boolean ki_msg_dopo_update = false
end type
global w_memo w_memo

type prototypes
//
subroutine DragAcceptFiles(long l_hWnd,boolean fAccept) library "shell32.dll"
subroutine DragFinish(long hDrop) library "shell32.dll"
function int DragQueryFileW(long hDrop,int iFile,ref string szFileName,int cb) library "shell32.dll"
end prototypes

type variables
//
//kuf_clienti kiuf_clienti
private kuf_memo kiuf_memo
private kuf_armo_inout kiuf_armo_inout
private kuf_clienti kiuf_clienti
private kuf_memo_allarme kiuf_memo_allarme
private kuf_memo_utenti kiuf_memo_utenti

//st_tab_clienti_memo kist_tab_clienti_memo
private:
st_tab_memo kist_tab_memo_orig
st_memo kist_memo 
//string ki_memo_rtf 

private datastore kids_elenco_input

//
private kuf_file_dragdrop kiuf_file_dragdrop

private string ki_memo_rtf_orig = ""
//private datastore ki_ds_rtf_orig

private string ki_flag_modalita_orig=""

end variables

forward prototypes
private function integer inserisci ()
protected function integer cancella ()
private subroutine leggi_altre_tab ()
protected function string aggiorna ()
protected function string inizializza ()
protected subroutine open_start_window ()
protected function string check_dati ()
protected subroutine inizializza_1 () throws uo_exception
protected subroutine stampa ()
private subroutine call_memo_link ()
protected subroutine inizializza_2 () throws uo_exception
protected function integer visualizza ()
protected function boolean dati_modif_0 ()
private subroutine put_video_cliente (st_tab_clienti kst_tab_clienti)
public function boolean get_dati_cliente (ref st_tab_clienti kst_tab_clienti)
public subroutine set_iniz_dati_cliente (ref st_tab_clienti kst_tab_clienti)
public subroutine get_dati_lotto (ref st_tab_armo kst_tab_armo)
private subroutine put_video_lotto (st_tab_meca kst_tab_meca)
private subroutine dragdrop_dw_esterna (datastore kdw_source, long k_riga)
protected function integer cancella_custom ()
private subroutine u_add_memo_link (string a_file[], integer a_file_nr)
public function long u_drop_file (integer a_k_tipo_drag, long a_handle)
public subroutine legge_dwc_sl_pt ()
private subroutine put_video_pt ()
public subroutine u_proteggi_pt ()
public subroutine u_clicked_fascicola_pt ()
protected subroutine attiva_tasti_0 ()
end prototypes

private function integer inserisci ();//
int k_return=1, k_ctr
st_tab_clienti kst_tab_clienti
st_tab_meca kst_tab_meca
st_tab_armo kst_tab_armo
st_tab_sr_settori kst_tab_sr_settori
kuf_sr_sicurezza kuf1_sr_sicurezza
kuf_ausiliari kuf1_ausiliari


try
	
//=== Aggiunge una riga al data windows
	choose case ki_tab_1_index_new 
	
	
		case  1 
	
			kist_memo.st_tab_memo.id_memo = 0
			kist_memo.st_tab_memo.x_datins = kGuf_data_base.prendi_x_datins( )			
			kist_memo.st_tab_memo.x_utente = kGuf_data_base.prendi_x_utente( )
			
			if tab_1.tabpage_1.dw_1.rowcount() > 0 then
				tab_1.tabpage_1.dw_1.reset() 
			end if
			k_ctr=tab_1.tabpage_1.dw_1.insertrow(0)
			tab_1.tabpage_1.dw_1.setredraw( false)

			if isnull(kist_memo.st_tab_memo.memo) then kist_memo.st_tab_memo.memo = blob("")
			tab_1.tabpage_1.dw_1.SelectTextAll() // seleziona tutto
			tab_1.tabpage_1.dw_1.pasteRtf(string(kist_memo.st_tab_memo.memo) ) // aggiunge testo alla fine dell'attuale, quindi RICOPRE
			ki_memo_rtf_orig = string(kist_memo.st_tab_memo.memo) // memorizza il testo originale così da informare che è cambiato

			tab_1.tabpage_1.dw_1.setredraw( true)

			tab_1.tabpage_1.dw_1.SetItemStatus( 1, 0, Primary!, NotModified!)

			ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
			tab_1.tabpage_1.dw_1.set_flag_modalita(ki_st_open_w.flag_modalita)
			tab_1.tabpage_2.dw_2.set_flag_modalita(ki_st_open_w.flag_modalita)
			
			
//		case 2 // dati proprietà
			//--- campo settore di default 
			if trim(kist_memo.st_tab_memo.tipo_sv) > " " then
			else
				kist_memo.st_tab_memo.tipo_sv = ki_st_open_w.sr_settore 
			end if

			tab_1.tabpage_2.dw_2.reset( )
			k_ctr=tab_1.tabpage_2.dw_2.insertrow(0)
			tab_1.tabpage_2.dw_2.setitem(1, "dataora_ins", kist_memo.st_tab_memo.dataora_ins )
			tab_1.tabpage_2.dw_2.setitem(1, "utente_ins", kist_memo.st_tab_memo.utente_ins )
			tab_1.tabpage_2.dw_2.setitem(1, "id_memo", kist_memo.st_tab_memo.id_memo )
			tab_1.tabpage_2.dw_2.setitem(1, "note", kist_memo.st_tab_memo.note )
			tab_1.tabpage_2.dw_2.setitem(1, "tipo_memo", kist_memo.st_tab_memo.tipo_memo )
			tab_1.tabpage_2.dw_2.setitem(1, "tipo_sv", kist_memo.st_tab_memo.tipo_sv )
			if not isvalid(kuf1_ausiliari) then kuf1_ausiliari = create kuf_ausiliari
			kst_tab_sr_settori.sr_settore = kist_memo.st_tab_memo.tipo_sv
			kst_tab_sr_settori.descr = kuf1_ausiliari.tb_get_descr(kst_tab_sr_settori)
			tab_1.tabpage_2.dw_2.setitem( 1, "sr_settori_descr", kst_tab_sr_settori.descr)
			kist_memo.st_tab_memo.permessi = kuf1_sr_sicurezza.ki_permessi_scrittura 
			tab_1.tabpage_2.dw_2.setitem(1, "permessi", kist_memo.st_tab_memo.permessi )
			tab_1.tabpage_2.dw_2.setitem(1, "titolo", kist_memo.st_tab_memo.titolo )
			tab_1.tabpage_2.dw_2.setitem(1, "meca_memo_allarme", kiuf_memo_allarme.kki_memo_allarme_no )
			tab_1.tabpage_2.dw_2.setitem(1, "clienti_memo_allarme", kiuf_memo_allarme.kki_memo_allarme_no )
			
			tab_1.tabpage_2.dw_2.setitem(1, "x_datins", kist_memo.st_tab_memo.x_datins )
			tab_1.tabpage_2.dw_2.setitem(1, "x_utente", kist_memo.st_tab_memo.x_utente )
			if kist_memo.st_tab_clienti_memo.id_cliente > 0 then
				kst_tab_clienti.codice = kist_memo.st_tab_clienti_memo.id_cliente
				get_dati_cliente(kst_tab_clienti)
				put_video_cliente(kst_tab_clienti)
			end if
			if kist_memo.st_tab_meca_memo.id_meca > 0 then
				kst_tab_meca.id = kist_memo.st_tab_meca_memo.id_meca 
				put_video_lotto(kst_tab_meca)
			end if
			//--- imposta dati PT x fascicolo
			u_proteggi_pt()
			//in inserimento meglio non visualizzare niente può confondere: put_video_pt()

			
			tab_1.tabpage_2.dw_2.SetItemStatus( 1, 0, Primary!, NotModified!)
			tab_1.tabpage_1.dw_1.set_flag_modalita(ki_st_open_w.flag_modalita)
			tab_1.tabpage_2.dw_2.set_flag_modalita(ki_st_open_w.flag_modalita)

			if tab_1.tabpage_3.dw_3.rowcount() > 0 then
				tab_1.tabpage_3.dw_3.reset() 
			end if
			
		case 3 //link documenti
			call_memo_link( )
		
	end choose	

	attiva_tasti()

	k_return = 0
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try

return (k_return)



end function

protected function integer cancella ();//
//=== Cancellazione rekord dal DB
//=== Ritorna : 0=OK 1=KO 2=non eseguita
//
int k_return=2
st_tab_memo_link kst_tab_memo_link
st_tab_memo kst_tab_memo
kuf_memo_link kuf1_memo_link

try
//--- controlla se Utente autorizzato	
	kst_tab_memo.id_memo =  tab_1.tabpage_2.dw_2.getitemnumber(1, "id_memo")
	if NOT kiuf_memo.u_if_sicurezza(kst_tab_memo, kkg_flag_modalita.cancellazione) then
//		kguo_exception.inizializza( )
//		kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_noaut )
//		kguo_exception.setmessage("Autorizzazione Rimozione allegato non concessa. Tipo '" + kst_tab_memo.tipo_sv + "' ")
//		kguo_exception.messaggio_utente( )
	else
		k_return = cancella_custom()
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try

return k_return

end function

private subroutine leggi_altre_tab ();
end subroutine

protected function string aggiorna ();//
//------------------------------------------------------------------------
//--- Aggiorna tabelle 
//--- Ritorna 1 chr : 0=tutto OK; 1=errore grave I-O;
//--- 				  : 2=
//---					  : 3=Commit fallita
//---		dal char 2 in poi spiegazione dell'errore
//------------------------------------------------------------------------

string k_return="0 ", k_errore="0 ", k_errore1="0 "
string k_memo_rtf=""
boolean k_new_rec
long k_memo_rtf_len, k_memo_rtf_orig_len
st_esito kst_esito
st_memo kst_memo
st_tab_memo kst_tab_memo
st_tab_clienti_memo kst_tab_clienti_memo 
st_tab_meca_memo kst_tab_meca_memo
st_tab_sl_pt_memo kst_tab_sl_pt_memo 
st_tab_memo_utenti kst_tab_memo_utenti


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then

//--- Aggiorna, se modificato, la TAB_1	 
	try
		
//--- carica il MEMO in tabella
		kst_tab_memo = kist_memo.st_tab_memo
		kst_tab_memo.id_memo = kist_memo.st_tab_memo.id_memo
		if tab_1.tabpage_2.dw_2.rowcount( ) > 0 then
			kst_tab_memo.note =  tab_1.tabpage_2.dw_2.getitemstring(1, "note") 
			kst_tab_memo.titolo = tab_1.tabpage_2.dw_2.getitemstring(1, "titolo")
		else
			kst_tab_memo.note = kist_memo.st_tab_memo.note 
			kst_tab_memo.titolo = kist_memo.st_tab_memo.titolo
		end if
		kst_tab_memo.tipo_sv = tab_1.tabpage_2.dw_2.getitemstring(1, "tipo_sv")
		kst_tab_memo.permessi = tab_1.tabpage_2.dw_2.getitemnumber(1, "permessi")
		k_memo_rtf = trim(tab_1.tabpage_1.dw_1.CopyRTF(false))
		kst_tab_memo.tipo_memo = kiuf_memo.kki_tipo_memo_rtf
		kst_tab_memo.memo = blob(k_memo_rtf)

//--- Se il SETTORE è stato cambiato, cancello dagli utenti del settore l'allegato 
		if trim(kist_tab_memo_orig.tipo_sv) > " " and kist_tab_memo_orig.tipo_sv <> kst_tab_memo.tipo_sv then
			kst_tab_memo_utenti.id_memo = kst_tab_memo.id_memo	
			kiuf_memo_utenti.tb_delete_x_id_memo(kst_tab_memo_utenti)
		end if

//---- dati memo fascicolo cliente
		kst_tab_clienti_memo.id_cliente = tab_1.tabpage_2.dw_2.getitemnumber(1, "id_cliente")
		kst_tab_clienti_memo.id_memo = tab_1.tabpage_2.dw_2.getitemnumber(1, "id_memo")
		kst_tab_clienti_memo.allarme = tab_1.tabpage_2.dw_2.getitemstring(1, "clienti_memo_allarme")
		kst_tab_clienti_memo.tipo_sv = tab_1.tabpage_2.dw_2.getitemstring(1, "tipo_sv")

//---- dati memo fascicolo Lotto
		kst_tab_meca_memo.id_meca = tab_1.tabpage_2.dw_2.getitemnumber(1, "id_meca")
		kst_tab_meca_memo.id_memo = tab_1.tabpage_2.dw_2.getitemnumber(1, "id_memo")
		kst_tab_meca_memo.allarme = tab_1.tabpage_2.dw_2.getitemstring(1, "meca_memo_allarme")
		kst_tab_meca_memo.tipo_sv = tab_1.tabpage_2.dw_2.getitemstring(1, "tipo_sv")

//---- dati memo fascicolo PT
		if tab_1.tabpage_2.dw_2.getitemnumber( 1, "k_fascicola_pt") = 1 then
			kst_tab_sl_pt_memo.cod_sl_pt = tab_1.tabpage_2.dw_2.getitemstring(1, "cod_sl_pt")
		else
			kst_tab_sl_pt_memo.cod_sl_pt = ""
		end if
		kst_tab_sl_pt_memo.id_memo = tab_1.tabpage_2.dw_2.getitemnumber(1, "id_memo")
		kst_tab_sl_pt_memo.tipo_sv = tab_1.tabpage_2.dw_2.getitemstring(1, "tipo_sv")
		
		kst_memo.st_tab_memo = kst_tab_memo
		kst_memo.st_tab_clienti_memo = kst_tab_clienti_memo
		kst_memo.st_tab_meca_memo = kst_tab_meca_memo
		kst_memo.st_tab_sl_pt_memo = kst_tab_sl_pt_memo
		kist_memo.st_tab_memo.id_memo = kiuf_memo.aggiorna(kst_memo)  //AGGIORNA TUTTI I  DATI MEMO
		
	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito()
		
	end try 

	if kst_esito.esito <> kkg_esito.ok then
		
		k_errore1 = "1" + string(kst_esito.sqlcode) + " " + kst_esito.sqlerrtext
		k_return = "1" + "Archivio " + tab_1.tabpage_1.text + MidA(k_errore1, 2)
			
	else // Tutti i Dati Caricati in Archivio
		ki_memo_rtf_orig = k_memo_rtf
//		if isvalid(ki_ds_rtf_orig) then destroy ki_ds_rtf_orig
//		ki_ds_rtf_orig = create datastore
//		ki_ds_rtf_orig.pasteRtf(k_memo_rtf)
		
		if kist_memo.st_tab_memo.id_memo > 0 then
			tab_1.tabpage_1.dw_1.setitem(1, "id_memo", kist_memo.st_tab_memo.id_memo)
			if tab_1.tabpage_2.dw_2.rowcount( ) > 0 then
				tab_1.tabpage_2.dw_2.setitem(1, "id_memo", kist_memo.st_tab_memo.id_memo)
			end if
	
//			try
////--- Aggiorna archivi correlati
//				aggiorna_altri_archivi()
//				
//			catch (uo_exception kuo1_exception)
//				kst_esito = kuo1_exception.get_st_esito()
//
//				k_errore1 = "1" + string(kst_esito.sqlcode) + " " + kst_esito.sqlerrtext
//				k_return = "1" + "Archivio " + tab_1.tabpage_1.text + MidA(k_errore1, 2)
//				
//			end try

			k_return ="0 "
	
			tab_1.tabpage_1.dw_1.resetupdate( )
			tab_1.tabpage_2.dw_2.resetupdate( )
			tab_1.tabpage_3.dw_3.resetupdate( )
			
		end if 
	end if
	
//--- errore : 0=tutto OK o NON RICHIESTA; 1=errore grave I-O;
//--- 		 : 2=LIBERO
//---			 : 3=Commit fallita

	if LeftA(k_return, 1) = "1" then
		messagebox("Operazione di Aggiornamento Non Eseguita !!", &
			MidA(k_return, 2))
	else
		if LeftA(k_return, 1) = "3" then
			messagebox("Registrazione dati : problemi nella 'Commit' !!", &
				"Consiglio : chiudere e ripetere le operazioni eseguite")
		end if
	end if
	
end if

return k_return

end function

protected function string inizializza ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_return="0", k_memo_rtf=""
long k_err_ins, k_rc
kuf_utility kuf1_utility


	if ki_st_open_w.flag_primo_giro = "S" then
		try
			if ki_st_open_w.flag_modalita <> kkg_flag_modalita.cancellazione then
				if kist_memo.st_tab_memo.id_memo = 0 then
					k_err_ins = inserisci()
					tab_1.tabpage_1.dw_1.setfocus()
				else
					if kiuf_memo.if_esiste(kist_memo.st_tab_memo) then
				
						k_memo_rtf = kiuf_memo.get_memo(kist_memo.st_tab_memo)  
						if len(k_memo_rtf) > 0 then
							tab_1.tabpage_1.dw_1.setitem( 1, "id_memo", kist_memo.st_tab_memo.id_memo)
							tab_1.tabpage_1.dw_1.setredraw( false)
							tab_1.tabpage_1.dw_1.pasteRtf( k_memo_rtf ) // mette il testo RTF a video
							ki_memo_rtf_orig = k_memo_rtf  // salva il RTF originale
//							ki_ds_rtf_orig.pasteRtf( k_memo_rtf ) // salva il RTF originale
//							tab_1.tabpage_1.dw_rtf_orig.pasteRtf( k_memo_rtf ) // salva il RTF originale
							tab_1.tabpage_1.dw_1.setredraw( true)
							tab_1.tabpage_1.dw_1.SetItemStatus( 1, 0, Primary!, NotModified!)
//							ki_memo_rtf = trim(tab_1.tabpage_1.dw_1.CopyRTF(false)) 
						end if

//--- leggo anche il tab 2 
						k_rc = tab_1.tabpage_2.dw_2.retrieve(kist_memo.st_tab_memo.id_memo)

					else
						if ki_st_open_w.flag_modalita <> kkg_flag_modalita.inserimento then
							k_return ="E"   //Uscita Immediata
							messagebox("MEMO non Trovato ", &
								"Il Memo non è stato trovato in Archivio ~n~r" + &
								"(Codice cercato :" + string(kist_memo.st_tab_memo.id_memo) + ")~n~r" )
							//ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
						end if
					end if
				end if
				
				
				
			end if
		catch (uo_exception kuo1_exception)
			kuo1_exception.messaggio_utente()
		end try


		if trim(k_return) <> "E" then
			if len(trim(kist_memo.st_tab_memo.note)) > 0 then
				ki_st_open_w.window_title += " " + trim(kist_memo.st_tab_memo.note)
			else
				ki_st_open_w.window_title += " *senza titolo* " 
			end if
			set_titolo_window()
		end if
	end if
	
	if trim(k_return) <> "E" then
		tab_1.tabpage_1.dw_1.title = trim(kist_memo.st_tab_memo.titolo)
	
		kuf1_utility = create kuf_utility
		if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
		//--- S-protezione campi 
			tab_1.tabpage_1.dw_1.enabled = true
		//	tab_1.tabpage_1.dw_1.Modify("DataWindow.ReadOnly='No'")
			kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_2.dw_2)
			u_proteggi_pt( ) // solo campo del PT
		else
			tab_1.tabpage_1.dw_1.resetupdate( )
			tab_1.tabpage_2.dw_2.resetupdate( )
		//--- Protezione campi 
			tab_1.tabpage_1.dw_1.enabled = false
		//	tab_1.tabpage_1.dw_1.Modify("DataWindow.ReadOnly=Yes")
			kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_2.dw_2)
		end if
	
		if ki_st_open_w.flag_primo_giro = "S" then
			if tab_1.tabpage_2.dw_2.getitemnumber( 1, "id_cliente") > 0 or tab_1.tabpage_2.dw_2.getitemnumber( 1, "id_meca") > 0 then
				tab_1.tabpage_1.dw_1.setcolumn(1)
				tab_1.tabpage_1.dw_1.setfocus()
	//			tab_1.selectedtab = 1
			else
				tab_1.tabpage_2.dw_2.setcolumn("titolo")
				tab_1.tabpage_2.dw_2.setfocus()
				tab_1.selectedtab = 2
			end if
		else
			tab_1.tabpage_1.dw_1.setcolumn(1)
			tab_1.tabpage_1.dw_1.setfocus()
		end if

		ki_flag_modalita_orig = ki_st_open_w.flag_modalita
	end if
	

return k_return 

end function

protected subroutine open_start_window ();//
//	kiuf_clienti = create kuf_clienti

	kiuf_armo_inout = create kuf_armo_inout
	kiuf_clienti = create kuf_clienti 
	kiuf_memo = create kuf_memo 
	kiuf_memo_utenti = create kuf_memo_utenti
//	ki_ds_rtf_orig = create datastore
	
	
//	kiuf_memo = ki_st_open_w.key12_any
	kist_memo = ki_st_open_w.key12_any //kiuf_memo.get_st_memo()

//		tab_1.tabpage_1.dw_rtf_orig.resetupdate( )
//		tab_1.tabpage_1.dw_rtf_orig.pasteRtf("",detail!)
//		tab_1.tabpage_1.dw_rtf_orig.pasteRtf(, detail!)


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
st_esito kst_esito //,kst_esito1
datastore kds_inp

try
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kds_inp = create datastore

////--- Controllo il primo tab
//	if tab_1.tabpage_1.dw_1.rowcount() > 0 then
//		kds_inp.dataobject = tab_1.tabpage_1.dw_1.dataobject
//		tab_1.tabpage_1.dw_1.rowscopy( 1,tab_1.tabpage_1.dw_1.rowcount( ) ,primary!, kds_inp, 1, primary!)
//		kst_esito = kiuf1_parent.u_check_dati(kds_inp)
//	end if
	
//--- Controllo altro tab
	if tab_1.tabpage_2.dw_2.rowcount() > 0 then
		if  tab_1.tabpage_2.dw_2.enabled then
			kds_inp.dataobject = tab_1.tabpage_2.dw_2.dataobject
			tab_1.tabpage_2.dw_2.rowscopy( 1,tab_1.tabpage_2.dw_2.rowcount( ) ,primary!, kds_inp, 1, primary!)
			kst_esito = kiuf_memo.u_check_dati(kds_inp)
			if kst_esito.esito <> kkg_esito.ok then
				kst_esito.sqlerrtext = tab_1.tabpage_2.text + ": " + kst_esito.sqlerrtext 
			end if
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

if isnull(k_return) then k_return = " "
return k_errore + k_return


end function

protected subroutine inizializza_1 () throws uo_exception;//======================================================================
//=== TAB 2: proprietà 
//======================================================================
//
string k_codice_prec
long k_rc
st_tab_clienti kst_tab_clienti
st_tab_meca kst_tab_meca
kuf_utility kuf1_utility
datawindowchild kdwc_1
st_tab_memo_utenti kst_tab_memo_utenti

//--- salvo i parametri cosi come sono stati immessi
	k_codice_prec = tab_1.tabpage_2.st_2_retrieve.text
	tab_1.tabpage_2.st_2_retrieve.Text = string(kist_memo.st_tab_memo.id_memo)

	if tab_1.tabpage_2.st_2_retrieve.text <> k_codice_prec then
	
//--- Se nr.cliente non impostato forzo una INSERISCI cliente, impostando in nr.cliente
		if kist_memo.st_tab_memo.id_memo > 0 then
			
			k_rc = tab_1.tabpage_2.dw_2.retrieve(kist_memo.st_tab_memo.id_memo)
			if k_rc > 0 then
				kst_tab_clienti.codice =  tab_1.tabpage_2.dw_2.getitemnumber(1, "id_cliente")
				this.get_dati_cliente(kst_tab_clienti)
				this.put_video_cliente(kst_tab_clienti)
				kst_tab_meca.id =  tab_1.tabpage_2.dw_2.getitemnumber(1, "id_meca")
				this.put_video_lotto(kst_tab_meca)

				kist_tab_memo_orig.tipo_sv = tab_1.tabpage_2.dw_2.getitemstring( 1, "tipo_sv")
				
			end if
		else
			
			inserisci()
			
		end if

		if kdwc_1.rowcount( ) < 2 then
			tab_1.tabpage_2.dw_2.getchild( "tipo_sv", kdwc_1)
			kdwc_1.settransobject(kguo_sqlca_db_magazzino )
			k_rc = kdwc_1.retrieve(kguo_utente.get_id_utente( ))
			kdwc_1.insertrow(0)
		end if	
	end if
	
	kuf1_utility = create kuf_utility
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
	//--- S-protezione campi 
		tab_1.tabpage_1.dw_1.enabled = true

		kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_2.dw_2)
		u_proteggi_pt( ) // solo campo del PT

		if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then

			if kist_memo.st_tab_memo.id_memo > 0 then
				kst_tab_memo_utenti.id_memo = kist_memo.st_tab_memo.id_memo
//--- solo l'utente che ha caricato può cambiare i PERMESSI				
				if trim(tab_1.tabpage_2.dw_2.getitemstring(1,"utente_ins")) <> trim(string(kguo_utente.get_id_utente( ))) then
					kuf1_utility.u_proteggi_dw("1", "permessi", tab_1.tabpage_2.dw_2)
				end if
//				if NOT kiuf_memo_utenti.if_letto(kst_tab_memo_utenti) then
//					kuf1_utility.u_proteggi_dw("1", "tipo_sv", tab_1.tabpage_2.dw_2)
//				end if
			end if
		else
			kuf1_utility.u_proteggi_dw("0", "tipo_sv", tab_1.tabpage_2.dw_2)
		end if
	else
	//--- Protezione campi 
		tab_1.tabpage_1.dw_1.enabled = false
		kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_2.dw_2)
		kuf1_utility.u_proteggi_dw("1", "tipo_sv", tab_1.tabpage_2.dw_2)
	end if

//--- attiva eventuale Drag&Drop di files da Windows	Explorer
	if not isvalid(kiuf_file_dragdrop) then kiuf_file_dragdrop = create kuf_file_dragdrop 
	kiuf_file_dragdrop.u_attiva(handle(tab_1.tabpage_2.dw_2))

	tab_1.tabpage_2.dw_2.resetupdate( )
	
	attiva_tasti( )
	
	tab_1.tabpage_2.dw_2.setfocus()
	
	tab_1.tabpage_2.dw_2.ki_flag_modalita = ki_st_open_w.flag_modalita
	

end subroutine

protected subroutine stampa ();//
 st_stampe kst_stampe
  
  
 kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_dw_rtf 
 stampa_esegui(kst_stampe)

end subroutine

private subroutine call_memo_link ();//
string k_return
long k_riga
st_tab_memo_link kst_tab_memo_link 
kuf_memo_link kuf1_memo_link


try   
	
//--- se nuovo tento subito l'inserimento	
	if kist_memo.st_tab_memo.id_memo = 0 or isnull(kist_memo.st_tab_memo.id_memo) then
		
		//--- Aggiornamento dei dati inseriti/modificati
		dati_modif_accept( )
		
		//--- Toglie le righe eventualmente da non registrare
		pulizia_righe()
		
		k_return = super::aggiorna_dati()
		
		if left(k_return, 1) = "0" then
			kist_memo.st_tab_memo.id_memo = tab_1.tabpage_2.dw_2.getitemnumber(1, "id_memo")
		end if
		
	end if
	if kist_memo.st_tab_memo.id_memo  > 0 then
		 kst_tab_memo_link.id_memo_link = 0
		 
		 kst_tab_memo_link.id_memo = kist_memo.st_tab_memo.id_memo
		 
		if NOT isvalid(kuf1_memo_link) then kuf1_memo_link = create kuf_memo_link 
		kuf1_memo_link.u_attiva_funzione(kst_tab_memo_link, kkg_flag_modalita.modifica )
		
	end if
		
catch (uo_exception	kuo_exception)
	kuo_exception.messaggio_utente()
		
end try
	


end subroutine

protected subroutine inizializza_2 () throws uo_exception;//======================================================================
//=== TAB 3: proprietà 
//======================================================================
//
string k_codice_prec
int k_rc
kuf_utility kuf1_utility

	

//--- salvo i parametri cosi come sono stati immessi
	k_codice_prec = tab_1.tabpage_3.st_3_retrieve.text
	kuf1_utility = create kuf_utility
	tab_1.tabpage_3.st_3_retrieve.Text = string(kist_memo.st_tab_memo.id_memo)  //kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)

	if tab_1.tabpage_3.st_3_retrieve.text <> k_codice_prec then
	
//--- Se nr.cliente non impostato forzo una INSERISCI cliente, impostando in nr.cliente
		if kist_memo.st_tab_memo.id_memo > 0 then
			
			tab_1.tabpage_3.dw_3.dataobject = "d_memo_link_l"
			tab_1.tabpage_3.dw_3.settransobject(kguo_sqlca_db_magazzino)
			tab_1.tabpage_3.dw_3.retrieve(kist_memo.st_tab_memo.id_memo)
			
		end if
	end if

//--- Info x DRAG&DROP
	if  tab_1.tabpage_3.dw_3.rowcount( ) <= 0 and (ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica or ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento) then
		tab_1.tabpage_3.dw_3.dataobject = "d_memo_dragdrop_info"
		tab_1.tabpage_3.st_3_retrieve.Text = "" // azzero per essere sicuro che al prx tentativo torna a fare la retrieve
	end if

	tab_1.tabpage_3.dw_3.resetupdate( )

	attiva_tasti( )
	
	tab_1.tabpage_3.dw_3.setfocus()
	
//--- attiva eventuale Drag&Drop di files da Windows	Explorer
	if not isvalid(kiuf_file_dragdrop) then kiuf_file_dragdrop = create kuf_file_dragdrop 
	kiuf_file_dragdrop.u_attiva(handle(tab_1.tabpage_3.dw_3))

end subroutine

protected function integer visualizza ();//
long k_riga = 0
st_tab_memo_link kst_tab_memo_link
kuf_memo_link kuf1_memo_link

try

	choose case ki_tab_1_index_new 

		case 1, 2
			ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
			tab_1.tabpage_1.dw_1.set_flag_modalita(ki_st_open_w.flag_modalita)
			tab_1.tabpage_2.dw_2.set_flag_modalita(ki_st_open_w.flag_modalita)
			inizializza_lista()
			
		case 3
			kuf1_memo_link = create kuf_memo_link
			k_riga = tab_1.tabpage_3.dw_3.getrow()
			if k_riga > 0 then
			else
				if tab_1.tabpage_3.dw_3.rowcount() = 1 then
					k_riga = 1
				end if
			end if
			if k_riga > 0 then
				kst_tab_memo_link.id_memo_link = tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "id_memo_link")
				if kst_tab_memo_link.id_memo_link > 0 then
					kuf1_memo_link.u_attiva_funzione(kst_tab_memo_link, kkg_flag_modalita.visualizzazione )
				end if
			end if
			
	end choose
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

return 0
end function

protected function boolean dati_modif_0 ();//
boolean k_return = false
string k_memo_rtf, k_memo_rtf_orig
long k_memo_rtf_len, k_memo_rtf_orig_len


if ki_flag_modalita_orig = kkg_flag_modalita.modifica then

//	tab_1.tabpage_1.dw_rtf_orig.SelectTextAll()
	if isnull(ki_memo_rtf_orig) then
		k_memo_rtf_orig = ""
		k_memo_rtf_orig_len = 0
	else
		k_memo_rtf_orig = trim(ki_memo_rtf_orig) // ki_ds_rtf_orig.CopyRTF(false)
		k_memo_rtf_orig_len = len((k_memo_rtf_orig))
	end if
	k_memo_rtf = tab_1.tabpage_1.dw_1.CopyRTF(false)
	if isnull(k_memo_rtf) then
		k_memo_rtf = ""
		k_memo_rtf_len = 0
	else
		k_memo_rtf = trim(k_memo_rtf) // ki_ds_rtf_orig.CopyRTF(false)
		k_memo_rtf_len = len((k_memo_rtf))
	end if
	
	if k_memo_rtf_len > 3 and k_memo_rtf_orig_len > 3 then
		if trim(mid(k_memo_rtf_orig, 1, k_memo_rtf_orig_len - 3)) <> trim(mid(k_memo_rtf, 1, k_memo_rtf_len - 3)) then 
			k_return = true
			ki_dw_titolo_modif_1 = trim(tab_1.tabpage_1.dw_1.title)
		end if
	else	
		if k_memo_rtf_len <> k_memo_rtf_orig_len then
			k_return = true
		end if
	end if
else
	if ki_flag_modalita_orig = kkg_flag_modalita.inserimento then
		k_return = true
	end if
end if

return k_return
 
end function

private subroutine put_video_cliente (st_tab_clienti kst_tab_clienti);//
//--- Visualizza dati Cliente 
//
st_esito kst_esito



tab_1.tabpage_2.dw_2.modify( "id_cliente.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
tab_1.tabpage_2.dw_2.setitem( 1, "id_cliente", kst_tab_clienti.codice )
tab_1.tabpage_2.dw_2.modify( "rag_soc_10.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
tab_1.tabpage_2.dw_2.setitem( 1, "rag_soc_10", trim(kst_tab_clienti.rag_soc_10) )

tab_1.tabpage_2.dw_2.setitem( 1, "id_cliente", kst_tab_clienti.codice)
tab_1.tabpage_2.dw_2.setitem( 1, "rag_soc_10", kst_tab_clienti.rag_soc_10+ " "+kst_tab_clienti.rag_soc_11 )

attiva_tasti()


end subroutine

public function boolean get_dati_cliente (ref st_tab_clienti kst_tab_clienti);//
boolean k_return = false
st_esito kst_esito

try
	
	k_return = kiuf_clienti.leggi (kst_tab_clienti)

	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	

finally
	
end try

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


end subroutine

public subroutine get_dati_lotto (ref st_tab_armo kst_tab_armo);//
boolean k_return = false
st_esito kst_esito
kuf_armo kuf1_armo

	
	kuf1_armo = create kuf_armo

	kst_esito = kuf1_armo.get_id_meca(kst_tab_armo) 
//--- cerca nei mesi precedenti
	if kst_esito.esito = kkg_esito.not_fnd then
		kst_tab_armo.data_int = relativedate(kst_tab_armo.data_int, -180)
		kst_esito = kuf1_armo.get_id_meca(kst_tab_armo) 
	end if
	



end subroutine

private subroutine put_video_lotto (st_tab_meca kst_tab_meca);//
int k_return=1
st_tab_clienti kst_tab_clienti
st_esito kst_esito
kuf_armo kuf1_armo


	try

//--- recupero eventuale Allegato
		if kst_tab_meca.id > 0 then
			kuf1_armo = create kuf_armo
			kuf1_armo.get_dati_rid(kst_tab_meca)
		end if
			
		//--- Se anno a zero lo imposto con anno di data oggi
		if tab_1.tabpage_2.dw_2.getitemdate(1, "data_int") > date(0) then
		else
			kst_tab_meca.data_int = kguo_g.get_dataoggi()
		end if
		tab_1.tabpage_2.dw_2.setitem(1, "num_int", kst_tab_meca.num_int )
		tab_1.tabpage_2.dw_2.setitem(1, "data_int", kst_tab_meca.data_int )
		tab_1.tabpage_2.dw_2.setitem(1, "id_meca", kst_tab_meca.id )

		if kst_tab_meca.id > 0 then
			kst_tab_clienti.codice = kst_tab_meca.clie_3
			kiuf_clienti.leggi (kst_tab_clienti)
		end if
		tab_1.tabpage_2.dw_2.setitem(1, "clie_3", kst_tab_meca.clie_3 )
		if kst_tab_clienti.rag_soc_11 > " " then kst_tab_clienti.rag_soc_10 += " " + kst_tab_clienti.rag_soc_11  
		tab_1.tabpage_2.dw_2.setitem(1, "meca_rag_soc_10", kst_tab_clienti.rag_soc_10 )
		
		
//--- in caso di errore...
	catch (uo_exception kuo_exception1)
		kuo_exception1.messaggio_utente()
		
	end try





end subroutine

private subroutine dragdrop_dw_esterna (datastore kdw_source, long k_riga);//
//
int k_rc


if k_riga > 0 then 

//--- Se dalla w di elenco 'prevista'  ho fatto doppio-click	 x scegliere la riga	
	if tab_1.selectedtab = 2 then
		
		choose case kdw_source.dataobject 

//--- scelta da elenco Anagrafiche
			case  "d_clienti_l_rag_soc" 
			
				if kdw_source.rowcount() > 0 then
		
					tab_1.tabpage_2.dw_2.setitem(1, "rag_soc_10",  kdw_source.getitemstring(k_riga, "rag_soc_1"))
					tab_1.tabpage_2.dw_2.setitem(1, "id_cliente", 	 kdw_source.getitemnumber(k_riga, "id_cliente"))
				end if
		
		
		end choose

	end if
	
			
end if





end subroutine

protected function integer cancella_custom ();//
//=== Cancellazione rekord dal DB
//=== Ritorna : 0=OK 1=KO 2=non eseguita
//
int k_return=0, k_nr_link=0
string k_desc, k_record, k_record_1
long k_key = 0, k_clie_1=0, k_clie_2
string k_errore = "0 ", k_errore1 = "0 ", k_nro_fatt
long k_riga, k_seq
st_tab_memo_link kst_tab_memo_link
kuf_memo_link kuf1_memo_link


try
	
	kuf1_memo_link = create kuf_memo_link

	choose case tab_1.selectedtab 
		case 1, 2 
			k_record = " MEMO "
			k_riga = 1
			if k_riga > 0 then
				if kist_memo.st_tab_memo.id_memo > 0 then
					k_key = kist_memo.st_tab_memo.id_memo
					k_desc = kist_memo.st_tab_memo.note
					if isnull(k_desc) = true or trim(k_desc) = "" then
						k_desc = "senza descrizione" 
					end if
					
					kst_tab_memo_link.id_memo = kist_memo.st_tab_memo.id_memo
					k_nr_link = kuf1_memo_link.get_count_x_id_memo(kst_tab_memo_link)
					if k_nr_link > 0 then
						k_record_1 = "La rimozione del MEMO " + string(k_key, "#####") + " toglie anche gli Allegati (" + string(k_nr_link) + ") "  & 
						                 + "~n~r" + trim(k_desc) + " ?"
					else
						k_record_1 = "Sei sicuro di voler eliminare il MEMO (id=" +	string(k_key, "#####") + ")~n~r" + trim(k_desc) + " ?"
					end if
					
				else
					tab_1.tabpage_1.dw_1.deleterow(k_riga)
				end if
			end if

		case 3 //allegati
			k_record = " Allegato "
			k_riga = tab_1.tabpage_3.dw_3.getrow()	
			if k_riga > 0 then
				kst_tab_memo_link.id_memo_link = tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "id_memo_link")
				if kst_tab_memo_link.id_memo_link > 0 then
					kst_tab_memo_link.titolo = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "titolo")
					k_key = kst_tab_memo_link.id_memo_link
					k_desc = kst_tab_memo_link.titolo
					if isnull(k_desc) = true or trim(k_desc) = "" then
						k_desc = "senza titolo" 
					end if
					k_record_1 = &
						"Sei sicuro di voler togliere l'allegato, id=" + &
						string(k_key, "#####") +  &
						"~n~rtitolo: " + trim(k_desc) + " ?"
				else
					tab_1.tabpage_3.dw_3.deleterow(k_riga)
				end if
			end if
			
			
	end choose	
	
	
	//=== Se righe in lista
	if k_riga > 0 and k_key > 0 then
		
	//=== Richiesta di conferma della eliminazione del rek
		if messagebox("Elimina" + k_record, k_record_1, &
			question!, yesno!, 2) = 1 then
	 
	//=== Cancella la riga dal data windows di lista
			choose case tab_1.selectedtab 
				case 1, 2 
					kist_memo.st_tab_memo.st_tab_g_0.esegui_commit = "S"
					kiuf_memo.tb_delete(kist_memo.st_tab_memo) 

				case 3 
					kist_memo.st_tab_memo.st_tab_g_0.esegui_commit = "S"
					kuf1_memo_link.tb_delete(kst_tab_memo_link) 
	
			end choose	
			
			choose case tab_1.selectedtab 
				case 1, 2 
					tab_1.tabpage_1.dw_1.reset( )
					tab_1.tabpage_2.dw_2.reset( )
					tab_1.tabpage_2.dw_2.reset( )
					cb_ritorna.post event clicked( )
				case 3 
					tab_1.tabpage_3.dw_3.deleterow(k_riga)
			end choose	
	
		else
			messagebox("Elimina" + k_record,  "Operazione Annullata !!")
			k_return = 2
		end if
	
	
	end if
	
	
	choose case tab_1.selectedtab 
		case 1 
			tab_1.tabpage_1.dw_1.setfocus()
			tab_1.tabpage_1.dw_1.setcolumn(1)
			tab_1.tabpage_1.dw_1.ResetUpdate ( ) 
		case 3 
			tab_1.tabpage_3.dw_3.setfocus()
			tab_1.tabpage_3.dw_3.setcolumn(1)
			tab_1.tabpage_3.dw_3.ResetUpdate ( ) 
			ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica
			smista_funz(KKG_FLAG_RICHIESTA.refresh)
	end choose	



catch (uo_exception kuo_exception)
//		kst_esito = kuo_exception.get_st_esito()
		k_errore = "1" + trim(kuo_exception.getmessage())
		messagebox("Problemi durante Cancellazione - Operazione fallita !!", &
								mid(k_errore1, 2) ) 	

finally
	if tab_1.selectedtab = 3 then
		attiva_tasti()
	end if

	
end try


return k_return

end function

private subroutine u_add_memo_link (string a_file[], integer a_file_nr);//
long k_riga=0
int k_risposta_load_memo_link = 1
st_tab_memo_link kst_tab_memo_link[] 
kuf_memo_link kuf1_memo_link
kuf_utility kuf1_utility


try   
	if kist_memo.st_tab_memo.id_memo  > 0 then

		if a_file_nr = 1 then
			k_risposta_load_memo_link = messagebox("Associa un Allegato al MEMO", "Oltre al collegamento vuoi importare anche l'intero documento nel DB", Question!, yesnocancel!, k_risposta_load_memo_link)
		else
			k_risposta_load_memo_link = messagebox("Associa  " + string(a_file_nr) + " Allegati al MEMO", "Oltre ai collegamenti vuoi importare anche tutti i documenti nel DB", Question!, yesnocancel!, k_risposta_load_memo_link)
		end if

		if k_risposta_load_memo_link = 3 then
			messagebox("Operazione annullata", "Nessun Allegato è stato collegato al MEMO", information!)
		else
			if NOT isvalid(kuf1_utility) then kuf1_utility = create kuf_utility 
			if NOT isvalid(kuf1_memo_link) then kuf1_memo_link = create kuf_memo_link 
	
			for k_riga = 1 to a_file_nr
				
				kst_tab_memo_link[k_riga].id_memo_link = 0
				kst_tab_memo_link[k_riga].id_memo = kist_memo.st_tab_memo.id_memo
				kst_tab_memo_link[k_riga].link =a_file[k_riga]
				kst_tab_memo_link[k_riga].tipo_memo_link = kuf1_utility.u_get_ext_file(kst_tab_memo_link[k_riga].link)
				kst_tab_memo_link[k_riga].nome = kuf1_utility.u_get_nome_file(kst_tab_memo_link[k_riga].link)
				kst_tab_memo_link[k_riga].titolo = "Allegato " + kst_tab_memo_link[k_riga].nome
				if k_risposta_load_memo_link = 1 then
					kst_tab_memo_link[k_riga].memo_link_load = kuf1_memo_link.kki_memo_link_load_si
				else
					kst_tab_memo_link[k_riga].memo_link_load = kuf1_memo_link.kki_memo_link_load_NO
				end if
				
			next
			if a_file_nr > 0 then
				kuf1_memo_link.crea_memo_link(kst_tab_memo_link[])
			end if
			
			tab_1.tabpage_3.dw_3.resetupdate( )
			smista_funz(KKG_FLAG_RICHIESTA.refresh)
		
		end if
	end if
		
catch (uo_exception	kuo_exception)
	tab_1.tabpage_3.dw_3.resetupdate( )
	smista_funz(KKG_FLAG_RICHIESTA.refresh)
	kuo_exception.messaggio_utente()
		
end try
	


end subroutine

public function long u_drop_file (integer a_k_tipo_drag, long a_handle);//
int k_sn
long k_file_nr
string k_file_drop[], k_modalita_descr


if not isvalid(kiuf_file_dragdrop) then kiuf_file_dragdrop = create kuf_file_dragdrop 

k_file_nr = kiuf_file_dragdrop.u_get_file(a_k_tipo_drag, a_handle, k_file_drop[])
if k_file_nr > 0 then	

	kGuf_data_base.set_focus(handle(this)) // dovrebbe prendere il fuoco

	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
//	messagebox("Operazione fermata", "Prima di caricare gli allegati, devo salvare questo MEMO in Archivio. Posso Procedere", question!, yesno!, 1) 
		aggiorna_dati( )
		u_add_memo_link(k_file_drop[], k_file_nr)  // carica i file in archivio
	else
		if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
			u_add_memo_link(k_file_drop[], k_file_nr)  // carica i file in archivio
		else
			k_modalita_descr = kguo_g.get_descrizione( ki_st_open_w.flag_modalita)
			messagebox("Operazione non Permessa", "Modalità '" + k_modalita_descr + "' non permessa per il carico dei MEMO", stopsign!) 
		end if
	end if
end if

return k_file_nr
end function

public subroutine legge_dwc_sl_pt ();//--- legge i DWC presenti
int k_rc=0
datawindowchild  kdwc_sl_pt_d



//=== Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa)


//--- Attivo dw archivio SL-PT
	k_rc = tab_1.tabpage_2.dw_2.getchild("cod_sl_pt", kdwc_sl_pt_d)
	k_rc = kdwc_sl_pt_d.settransobject(sqlca)
//	kdwc_sl_pt_d.reset()
//--- Attivo dw archivio PT
	k_rc = tab_1.tabpage_2.dw_2.getchild("cod_sl_pt", kdwc_sl_pt_d)
	if kdwc_sl_pt_d.rowcount() < 2 then
		kdwc_sl_pt_d.retrieve()
		kdwc_sl_pt_d.insertrow(1)
	end if


	SetPointer(kkg.pointer_default)
	
	

end subroutine

private subroutine put_video_pt ();//
st_tab_armo kst_tab_armo
st_tab_sl_pt kst_tab_sl_pt
st_esito kst_esito
kuf_armo kuf1_armo
kuf_sl_pt kuf1_sl_pt


	try
		
		kst_tab_armo.cod_sl_pt = tab_1.tabpage_2.dw_2.getitemstring(1, "cod_sl_pt")
		if trim(kst_tab_armo.cod_sl_pt) > " " then
		else
		
//--- recupero dati PT da Lotto
			kst_tab_armo.id_meca = tab_1.tabpage_2.dw_2.getitemnumber(1, "id_meca")
			if kst_tab_armo.id_meca > 0 then
				kuf1_armo = create kuf_armo
				kuf1_armo.get_cod_sl_pt_x_id_meca(kst_tab_armo)
			end if
				
			tab_1.tabpage_2.dw_2.setitem(1, "cod_sl_pt", kst_tab_armo.cod_sl_pt )
	
		end if
		if trim(kst_tab_armo.cod_sl_pt) > " " then
			kuf1_sl_pt = create kuf_sl_pt
			kst_tab_sl_pt.cod_sl_pt = kst_tab_armo.cod_sl_pt
			kuf1_sl_pt.get_descr(kst_tab_sl_pt)
		end if
		
		tab_1.tabpage_2.dw_2.setitem(1, "sl_pt_descr", kst_tab_sl_pt.descr )
		
		
//--- in caso di errore...
	catch (uo_exception kuo_exception1)
		kuo_exception1.messaggio_utente()
		
	end try





end subroutine

public subroutine u_proteggi_pt ();//---
//--- proteggi/sproteggi campo PT
//---
kuf_utility kuf1_utility

			
	kuf1_utility = create kuf_utility 

	if tab_1.tabpage_2.dw_2.getitemnumber( 1, "k_fascicola_pt") = 1 then
		kuf1_utility.u_proteggi_dw("0", "cod_sl_pt", tab_1.tabpage_2.dw_2 )
	else
		kuf1_utility.u_proteggi_dw("1", "cod_sl_pt", tab_1.tabpage_2.dw_2 )
	end if

	if isvalid(kuf1_utility) then destroy kuf1_utility
	
end subroutine

public subroutine u_clicked_fascicola_pt ();//		
//	if tab_1.tabpage_2.dw_2.getitemnumber( 1, "k_fascicola_pt") = 1 then
//		tab_1.tabpage_2.dw_2.setitem( 1, "k_fascicola_pt", 0)
//	else
//		tab_1.tabpage_2.dw_2.setitem( 1, "k_fascicola_pt", 1)
//	end if
	u_proteggi_pt()
	put_video_pt()

end subroutine

protected subroutine attiva_tasti_0 ();//
super::attiva_tasti_0()		 

//if ki_memo_rtf = trim(tab_1.tabpage_1.dw_1.CopyRTF(false)) then
//	cb_aggiorna.enabled = true
//end if
if ki_tab_1_index_new = 1 or ki_tab_1_index_new = 2 then
	cb_inserisci.enabled = true
	cb_visualizza.enabled = true
	cb_modifica.enabled = true
	cb_cancella.enabled = true
end if

if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
	cb_aggiorna.enabled = true
	cb_cancella.enabled = true
end if

if ki_tab_1_index_new = 3 then
	cb_inserisci.enabled = true
	if tab_1.tabpage_3.dw_3.rowcount( ) > 0 then
		cb_modifica.enabled = true
		cb_visualizza.enabled = true
		cb_cancella.enabled = true
	end if
end if


end subroutine

on w_memo.create
int iCurrent
call super::create
end on

on w_memo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event u_ricevi_da_elenco;call super::u_ricevi_da_elenco;//
//
int k_rc
long  k_riga, k_righe
datastore kds_elenco_input_appo


if isvalid(kst_open_w) then

	if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica or ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then

		if isnumber(kst_open_w.key3) then
			if long(kst_open_w.key3) > 0 then 
		
				if not isvalid(kds_elenco_input_appo) then kds_elenco_input_appo = create datastore
				if not isvalid(kids_elenco_input) then kids_elenco_input = create datastore
				kds_elenco_input_appo = kst_open_w.key12_any 
				kids_elenco_input.dataobject = kds_elenco_input_appo.dataobject
				kids_elenco_input.reset()
				if not isvalid(kids_elenco_input) then kids_elenco_input = create datastore
				kds_elenco_input_appo.rowscopy( 1, kds_elenco_input_appo.rowcount( ) , primary!,kids_elenco_input, 1,primary!)

//				kids_elenco_input = kst_open_w.key12_any 
				k_riga = long(kst_open_w.key3)

				if kids_elenco_input.rowcount() > 0 and k_riga > 0 then
				
					dragdrop_dw_esterna( kids_elenco_input, k_riga )
					
				end if
			end if
		end if
	end if
		
end if



attiva_tasti()



end event

event close;call super::close;// 
kuf_memo_utenti kuf1_memo_utenti
st_tab_memo_utenti kst_tab_memo_utenti


try
	
//--- imposta lo stato di LETTO sul MEMO
	if kist_memo.st_tab_memo.id_memo > 0 then
		kuf1_memo_utenti = create kuf_memo_utenti
		kst_tab_memo_utenti.id_memo = kist_memo.st_tab_memo.id_memo 
		kst_tab_memo_utenti.id_sr_utente = kguo_utente.get_id_utente( )
		kuf1_memo_utenti.set_stato_letto(kst_tab_memo_utenti)
		kuf1_memo_utenti.set_contatore(kst_tab_memo_utenti)
	end if
	
catch (uo_exception kuo_exception)
	
	
end try

end event

type st_ritorna from w_g_tab_3`st_ritorna within w_memo
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_memo
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_memo
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_memo
integer x = 2711
integer y = 1424
end type

type st_stampa from w_g_tab_3`st_stampa within w_memo
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_memo
integer x = 1152
integer y = 1440
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_memo
integer x = 768
integer y = 1440
end type

event cb_modifica::clicked;//
long k_riga = 0
st_tab_memo_link kst_tab_memo_link
st_tab_memo kst_tab_memo
kuf_memo_link kuf1_memo_link

try

	ki_flag_modalita_orig = ki_st_open_w.flag_modalita
	
//--- controlla se Utente autorizzato	
	kst_tab_memo.id_memo =  kist_memo.st_tab_memo.id_memo  // tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id_memo")
	if NOT kiuf_memo.u_if_sicurezza(kst_tab_memo, kkg_flag_modalita.modifica) then
		kguo_exception.inizializza( )
		kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_noaut )
		kguo_exception.setmessage("Autorizzazione apertura allegato non concessa. Tipo '" + kst_tab_memo.tipo_sv + "' ")
		kguo_exception.messaggio_utente( )
//		throw kguo_exception
	else
		choose case ki_tab_1_index_new 
	
			case 1, 2
				ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica
				tab_1.tabpage_1.dw_1.set_flag_modalita(ki_st_open_w.flag_modalita)
				tab_1.tabpage_2.dw_2.set_flag_modalita(ki_st_open_w.flag_modalita)
				inizializza_lista()
				
			case 3
				kuf1_memo_link = create kuf_memo_link
				k_riga = tab_1.tabpage_3.dw_3.getrow()
				if k_riga > 0 then
				else
					if tab_1.tabpage_3.dw_3.rowcount() = 1 then
						k_riga = 1
					end if
				end if
				if k_riga > 0 then
					kst_tab_memo_link.id_memo_link = tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "id_memo_link")
					if kst_tab_memo_link.id_memo_link > 0 then
						kuf1_memo_link.u_attiva_funzione(kst_tab_memo_link, kkg_flag_modalita.modifica )
					end if
				end if
				
		end choose
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
//	throw kuo_exception
	
end try

return 0
end event

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_memo
integer x = 1970
integer y = 1424
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_memo
integer x = 2341
integer y = 1424
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_memo
integer x = 1600
integer y = 1424
boolean enabled = false
end type

event cb_inserisci::clicked;//
//=== 
string k_errore="0"

//=== Nuovo Rekord
	choose case ki_tab_1_index_new //  tab_1.selectedtab 
		case  1, 2, 3 
	
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
		kist_memo.st_tab_memo.note = ""
		kist_memo.st_tab_memo.titolo = ""
		kist_memo.st_tab_memo.memo = blob("")
		inserisci()
	end if

end event

type tab_1 from w_g_tab_3`tab_1 within w_memo
boolean visible = true
integer x = 32
integer y = 52
integer width = 3040
integer height = 1396
long backcolor = 32435950
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

event tab_1::key;call super::key;
if kidw_selezionata.dataobject = "d_memo" or kidw_selezionata.dataobject = "d_memo_link_l" then
//--- CTRL+V fa Incolla dei file
	if key = KeyV! and keyflags = 2 then
		u_drop_file(kiuf_file_dragdrop.kki_tipo_drag_incolla, handle(this))
	end if
end if

end event

event tab_1::selectionchanged;call super::selectionchanged;//
if ki_st_open_w.flag_primo_giro <> 'S' then
	attiva_tasti( )
end if


end event

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
integer width = 3003
integer height = 1268
long backcolor = 32435950
string text = "Testo"
long tabbackcolor = 32435950
long picturemaskcolor = 32435950
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
boolean visible = true
integer x = 59
integer y = 60
integer width = 1111
integer height = 812
string dataobject = "d_memo_rtf"
boolean ki_link_standard_attivi = false
boolean ki_button_standard_attivi = false
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_d_std_1_attiva_cerca = false
boolean ki_db_conn_standard = false
end type

event dw_1::clicked;//
//--- evita di fare evento PARENT 

end event

event dw_1::doubleclicked;//
//--- evita di fare evento PARENT 

end event

event dw_1::editchanged;//
//--- evita di fare evento PARENT 

end event

event dw_1::getfocus;//
//--- evita di fare evento PARENT 

end event

event dw_1::itemchanged;//
//--- evita di fare evento PARENT 

end event

event dw_1::itemfocuschanged;//
//--- evita di fare evento PARENT 

end event

event dw_1::losefocus;//
//--- evita di fare evento PARENT 

end event

event dw_1::rbuttondown;//
//--- evita di fare evento PARENT 

end event

event dw_1::rbuttonup;//
//--- evita di fare evento PARENT 

end event

event dw_1::rowfocuschanged;//
//--- evita di fare evento PARENT 

end event

event dw_1::ue_dwnkey;//
//--- evita di fare evento PARENT 

end event

event dw_1::ue_dwnmousemove;//
//--- evita di fare evento PARENT 

end event

event dw_1::ue_lbuttondown;//
//--- evita di fare evento PARENT 

end event

event dw_1::ue_lbuttonup;//
//--- evita di fare evento PARENT 

end event

event dw_1::ue_leftbuttonup;//
//--- evita di fare evento PARENT 

end event

event dw_1::ue_timer;//
//--- evita di fare evento PARENT 

end event

event dw_1::u_pigiato_enter;//
//--- evita di fare evento PARENT 

end event

event dw_1::sqlpreview;//
//--- evita di fare evento PARENT 

end event

event dw_1::dragwithin;//
//--- evita di fare evento PARENT 

end event

event dw_1::dragleave;//
//--- evita di fare evento PARENT 

end event

event dw_1::dragdrop;//
//--- evita di fare evento PARENT 

end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
integer width = 3003
integer height = 1268
long backcolor = 32435950
string text = "Proprietà"
long tabbackcolor = 32435950
string picturename = "Properties!"
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
event u_dropfiles pbm_dropfiles
boolean visible = true
integer x = 0
integer width = 2981
integer height = 1228
boolean enabled = true
string dataobject = "d_memo"
boolean hsplitscroll = false
boolean ki_colora_riga_aggiornata = false
boolean ki_abilita_ddw_proposta = true
end type

event dw_2::u_dropfiles;//
int k_file_nr=0


k_file_nr = u_drop_file(kiuf_file_dragdrop.kki_tipo_drag_dragdrop, handle)

return k_file_nr




end event

event dw_2::itemchanged;call super::itemchanged;//
string k_nome
long k_riga, k_return=0
st_tab_clienti kst_tab_clienti
st_tab_meca kst_tab_meca
kuf_armo kuf1_meca
st_esito kst_esito

try
	
	choose case dwo.name 
	
		case "rag_soc_10" 
			kst_tab_clienti.rag_soc_10 = ""
			kst_tab_clienti.codice = 0
			if len(trim(data)) > 0 then 
				kst_tab_clienti.codice = kiuf_clienti.get_codice_da_rag_soc(data)
				if kst_tab_clienti.codice > 0 then
					get_dati_cliente(kst_tab_clienti)
				else
					tab_1.tabpage_1.dw_1.object.id_cliente[1] = 0
					tab_1.tabpage_1.dw_1.modify( dwo.name + ".Background.Color = '" + string(kkg_colore.ERR_DATO) + "' ") 
				end if
			else
				set_iniz_dati_cliente(kst_tab_clienti)
			end if
			post put_video_cliente(kst_tab_clienti)
	
		case "id_cliente" 
			kst_tab_clienti.rag_soc_10 = ""
			kst_tab_clienti.codice = 0
			if len(trim(data)) > 0 then 
				kst_tab_clienti.codice = long(trim(data))
				if kst_tab_clienti.codice > 0 then
					get_dati_cliente(kst_tab_clienti)
				else
					tab_1.tabpage_1.dw_1.modify( dwo.name + ".Background.Color = '" + string(kkg_colore.ERR_DATO) + "' ") 
				end if
			else
				set_iniz_dati_cliente(kst_tab_clienti)
			end if
			post put_video_cliente(kst_tab_clienti)
	
			
		case "num_int" &
			, "data_int" 
			if dwo.name = "data_int" then
				if not isdate(trim(data)) then
					kst_tab_meca.data_int = kguo_g.get_dataoggi()
				else
					kst_tab_meca.data_int = date(data)
				end if
				kst_tab_meca.num_int = this.getitemnumber(row,"num_int")
			else
				if dwo.name = "num_int" then
					if isnumber(trim(data)) then
						kst_tab_meca.num_int = long(data)
					end if
					kst_tab_meca.data_int = this.getitemdate(row,"data_int")
				end if
			end if
			if kst_tab_meca.num_int > 0 then
				kuf1_meca = create kuf_armo
				if kst_tab_meca.data_int > date(0) then 
				else
					kst_tab_meca.data_int = kguo_g.get_dataoggi()
				end if
				kst_esito = kuf1_meca.get_id_meca(kst_tab_meca) 
	//--- cerca nei mesi precedenti
				if kst_esito.esito = kkg_esito.not_fnd then
					kst_tab_meca.data_int = relativedate(kst_tab_meca.data_int, -180)
					kst_esito = kuf1_meca.get_id_meca(kst_tab_meca) 
				end if
				post put_video_lotto(kst_tab_meca)
			end if
	
			
	end choose 


catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally
	this.accepttext()
	
end try
	
end event

event dw_2::clicked;call super::clicked;//
//=== Premuto pulsante nella DW
//
string k_nome


	this.accepttext( )

	k_nome = lower(trim(dwo.name))
	choose case k_nome

//--- fascicola su PT
		case "k_fascicola_pt"
			post u_clicked_fascicola_pt()

//--- PT popola il dw PT
		case "cod_sl_pt"
			if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
				legge_dwc_sl_pt()
			end if

		
	end choose


//	post attiva_tasti()

end event

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
boolean visible = true
integer width = 3003
integer height = 1268
string text = "Allegati"
string picturename = "DosEdit5!"
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
event u_dropfiles pbm_dropfiles
boolean visible = true
integer width = 2967
integer height = 1232
boolean enabled = true
string dataobject = "d_memo_link_l"
boolean hsplitscroll = false
end type

event dw_3::u_dropfiles;//
int k_file_nr=0


k_file_nr = u_drop_file(kiuf_file_dragdrop.kki_tipo_drag_dragdrop, handle)

return k_file_nr




end event

event dw_3::itemchanged;call super::itemchanged;//



end event

event dw_3::getfocus;call super::getfocus;//getfocus
if This.getSelectedRow(0) <= 0 then
	This.SelectRow(1, TRUE)
end if
//


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

