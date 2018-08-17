$PBExportHeader$w_wm_pklist_cfg.srw
forward
global type w_wm_pklist_cfg from w_g_tab_3
end type
type ln_1 from line within tabpage_4
end type
end forward

global type w_wm_pklist_cfg from w_g_tab_3
integer x = 169
integer y = 148
integer width = 3826
integer height = 1904
string title = "Propriea connessione Warehouse Management (WM)"
string icon = "AppIcon!"
boolean clientedge = true
boolean ki_utente_abilitato = true
boolean ki_toolbar_window_presente = true
boolean ki_sincronizza_window_consenti = false
boolean ki_fai_nuovo_dopo_update = false
boolean ki_fai_nuovo_dopo_insert = false
end type
global w_wm_pklist_cfg w_wm_pklist_cfg

type variables
//
kuf_wm_pklist_cfg kiuf_wm_pklist_cfg
private string ki_blocca_importa
end variables

forward prototypes
private function integer inserisci ()
private subroutine riempi_id ()
protected function string aggiorna ()
protected function string inizializza ()
private subroutine open_notepad_documento (string k_file) throws uo_exception
protected subroutine open_start_window ()
private subroutine get_file_esiti ()
private subroutine get_path_pkl_da_web ()
protected function string check_dati ()
public function boolean test_dll_m2000utility ()
protected subroutine inizializza_1 () throws uo_exception
protected subroutine inizializza_2 () throws uo_exception
private subroutine get_path_pkl_da_txt ()
protected subroutine inizializza_3 () throws uo_exception
protected subroutine attiva_tasti_0 ()
end prototypes

private function integer inserisci ();////
int k_return=1, k_ctr
st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg
//string k_errore="0 "
//date k_data
//long k_riga 
//string k_codice
////datawindowchild kdwc_cliente, kdwc_cliente_1, kdwc_cliente_2 
//kuf_base kuf1_base
//
//
////=== Controllo se ho modificato dei dati nella DW DETTAGLIO
////if left(dati_modif(""), 1) = "1" then //Richisto Aggiornamento
//
////=== Controllo congruenza dei dati caricati e Aggiornamento  
////=== Ritorna 1 char : 0=tutto OK; 1=errore grave;
////===                : 2=errore non grave dati aggiornati;
////===			         : 3=LIBERO
////===      il resto della stringa contiene la descrizione dell'errore   
////	k_errore = aggiorna_dati()
//
////end if
//
//
//if left(k_errore, 1) = "0" then
//
//
////=== Aggiunge una riga al data windows
//	choose case tab_1.selectedtab 
//		case  1 
//	
////			tab_1.tabpage_1.dw_1.getchild("clienti_a_rag_soc_1", kdwc_cliente)
//
////			kdwc_cliente.settransobject(sqlca)
//	
			tab_1.tabpage_1.dw_1.reset( )
			tab_1.tabpage_1.dw_1.insertrow(0)
//			
			kiuf_wm_pklist_cfg.if_isnull(kst_tab_wm_pklist_cfg)
			tab_1.tabpage_1.dw_1.setitem(1, "codice", kst_tab_wm_pklist_cfg.codice )
			tab_1.tabpage_1.dw_1.setitem(1, "blocca_importa", kst_tab_wm_pklist_cfg.blocca_importa )
			tab_1.tabpage_1.dw_1.setitem(1, "cartella_pkl_da_web", kst_tab_wm_pklist_cfg.cartella_pkl_da_web )
			tab_1.tabpage_1.dw_1.setitem(1, "ultimo_idimportazione", kst_tab_wm_pklist_cfg.ultimo_idimportazione )
			tab_1.tabpage_1.dw_1.setitem(1, "file_esiti", kst_tab_wm_pklist_cfg.file_esiti )
			tab_1.tabpage_1.dw_1.setitem(1, "cfg_dbms_scelta", 1) //kst_tab_wm_pklist_cfg.cfg_dbms_scelta )
			tab_1.tabpage_1.dw_1.setitem(1, "cfg_dbms", kst_tab_wm_pklist_cfg.cfg_dbms )
			tab_1.tabpage_1.dw_1.setitem(1, "cfg_autocommit", kst_tab_wm_pklist_cfg.cfg_autocommit )
			tab_1.tabpage_1.dw_1.setitem(1, "cfg_dbparm", kst_tab_wm_pklist_cfg.cfg_dbparm )
			tab_1.tabpage_1.dw_1.setitem(1, "cfg_servername", kst_tab_wm_pklist_cfg.cfg_servername )
			tab_1.tabpage_1.dw_1.setitem(1, "cfg_utente", kst_tab_wm_pklist_cfg.cfg_utente )
			tab_1.tabpage_1.dw_1.setitem(1, "cfg_pwd", kst_tab_wm_pklist_cfg.cfg_pwd )
			tab_1.tabpage_1.dw_1.setitem(1, "cfg_dbms_alt", kst_tab_wm_pklist_cfg.cfg_dbms_alt )
			tab_1.tabpage_1.dw_1.setitem(1, "cfg_autocommit_alt", kst_tab_wm_pklist_cfg.cfg_autocommit_alt )
			tab_1.tabpage_1.dw_1.setitem(1, "cfg_dbparm_alt", kst_tab_wm_pklist_cfg.cfg_dbparm_alt )
			tab_1.tabpage_1.dw_1.setitem(1, "cfg_servername_alt", kst_tab_wm_pklist_cfg.cfg_servername_alt )
			tab_1.tabpage_1.dw_1.setitem(1, "cfg_utente_alt", kst_tab_wm_pklist_cfg.cfg_utente_alt )
			tab_1.tabpage_1.dw_1.setitem(1, "cfg_pwd_alt", kst_tab_wm_pklist_cfg.cfg_pwd_alt )

			tab_1.tabpage_1.dw_1.setcolumn(1)
//			
//		case 2 // Listino
//			k_codice = tab_1.tabpage_1.dw_1.getitemstring(1, "codice")
//////=== Riempe indirizzo di Spedizione da DW_1
////			if k_codice > 0 then
////				k_riga = tab_1.tabpage_2.dw_2.insertrow(0)
////	
////				tab_1.tabpage_2.dw_2.setitem(k_riga, "codice", k_codice)
////				tab_1.tabpage_2.dw_2.setitem(k_riga, "clie_3", k_codice)
////	
////				tab_1.tabpage_2.dw_2.scrolltorow(k_riga)
////				tab_1.tabpage_2.dw_2.setrow(k_riga)
////				tab_1.tabpage_2.dw_2.setcolumn(1)
////			end if
////			
//		case 3 // Listino
//			
//		case 4 // Lista Entrate
//			
//		case 5 // Lista Fatture
//			
//	end choose	
//
	attiva_tasti()
//
//	k_return = 0
//
//end if
//
return (k_return)



end function

private subroutine riempi_id ();//
//=== Imposta gli Effettivi ID degli archivi
long k_righe, k_ctr
integer k_codice_1, k_codice
string k_ret_code
kuf_base kuf1_base
st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg 

//=== Salvo ID  originale x piu' avanti
//	k_codice_1 = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")



//=== Se non sono in caricamento 
//	if tab_1.tabpage_1.dw_1.getitemstatus(1, 0, primary!) <> newmodified! then
		k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")
//	end if

	if k_codice = 0 or isnull(k_codice) then
		tab_1.tabpage_1.dw_1.setitem(1, "codice", "1")		
	end if
	
	if len(trim(tab_1.tabpage_1.dw_1.getitemstring(1, "blocca_importa"))) > 0 then // or trim(tab_1.tabpage_1.dw_1.getitemstring(1, "blocca_importa")) <> kiuf_wm_pklist_cfg.ki_blocca_importa_si then 
	else
		tab_1.tabpage_1.dw_1.setitem(1, "blocca_importa",  kiuf_wm_pklist_cfg.ki_blocca_importa_no  )
	end if		
	tab_1.tabpage_1.dw_1.setitem(1, "x_datins", kGuf_data_base.prendi_x_datins() )
	tab_1.tabpage_1.dw_1.setitem(1, "x_utente", kGuf_data_base.prendi_x_utente() )

	
//		kuf1_base = create kuf_base
//	//=== Imposto il ID  su arch. Azienda
//		k_ret_code = kuf1_base.prendi_dato_base("codice")
//		if left(k_ret_code, 1) = "0" then
//			k_codice = long(mid(k_ret_code, 2)) + 1
//			k_ret_code = kuf1_base.metti_dato_base(0, "codice", string(k_codice,"#####"))
//		end if
//		if left(k_ret_code, 1) = "1" then
//	
//			k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")
//			
//			messagebox("Aggiornamento Automatico Fallito !!", &
//				"Attenzione: non sono riuscito ad aggiornare il contatore COMMESSE,~n~r" + &
//				"in archivio Azienda. ~n~r" + &
//				"Aggiornare immediatamente in modo manuale il 'ID Commessa' in Azienda. ~n~r" + &
//				"Per eseguire l'aggiornamento fare ALT+Z ed impostare  ~n~r" + &
//				"il numero " + string(k_codice,"#####") + " nel campo 'ID Commess'. ~n~r" + &
//				"Eseguire poi gli opportuni controlli su questi dati Commessa. ~n~r" + &
//				"Se il problema persiste, si prega di contattare il programmatore. Grazie", &
//				stopsign!, ok!)
//				
//		end if		
	
//		destroy kuf1_base
//		k_nro_commessa_1 = tab_1.tabpage_1.dw_1.getitemnumber(1, "nro_commessa")
//		if k_nro_commessa <> k_nro_commessa_1 then
//
////=== ho trovato il nr commessa diverso da quello in BASE controllo se commessa gia' caricata
//			select codice into :k_ctr
//				from commesse
//				where nro_commessa = :k_nro_commessa_1;
//
//			if sqlca.sqlcode = 0 then
//				k_nro_old = tab_1.tabpage_1.dw_1.getitemnumber(1, "nro_commessa") 
//				messagebox("Aggiornamento Commessa", &
//					"Mi spiace ma il numero abbinato a questa commessa e' stato cambiato ~n~r" + &
//					"da " + string(k_nro_old,"#####") + " a " + &
//						string(k_nro_commessa,"#####") + "~n~r" + &
//					"Motivo : potrebbero esserci altri utenti che stanno caricando Commesse, ~n~r" + &
//					"nessun pericolo di perdita dati. ", &
//					information!, ok!)
//			end if
//		end if		
//	
	
//		tab_1.tabpage_1.dw_1.setitem(1, "nro_commessa", k_nro_commessa)
	
//		tab_1.tabpage_1.dw_1.setitem(1, "codice", k_codice)

//	end if
	
//	k_righe = tab_1.tabpage_2.dw_2.rowcount()
//	if k_righe > 0 then
//
//	
//		tab_1.tabpage_2.dw_2.setitem(k_ctr, "codice", k_codice)
//
//		tab_1.tabpage_1.dw_1.setitem(1, "indi_2", &
//				tab_1.tabpage_2.dw_2.getitemstring(1, "indi_2"))
//		tab_1.tabpage_1.dw_1.setitem(1, "cap_2", &
//				tab_1.tabpage_2.dw_2.getitemstring(1, "cap_2"))
//		tab_1.tabpage_1.dw_1.setitem(1, "loc_2", &
//				tab_1.tabpage_2.dw_2.getitemstring(1, "loc_2"))
//		tab_1.tabpage_1.dw_1.setitem(1, "prov_2", &
//				tab_1.tabpage_2.dw_2.getitemstring(1, "prov_2"))
//				
//	end if
//


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
string k_return="0 ", k_errore="0 "
st_esito kst_esito


//=== Aggiorna, se modificato, la TAB_1	
if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0 OR &
	tab_1.tabpage_1.dw_1.getnextmodified(0, delete!) > 0 & 
	then

	if tab_1.tabpage_1.dw_1.update() = 1 then

//=== Se tutto OK faccio la COMMIT		
		kst_esito = kguo_sqlca_db_magazzino.db_commit()
		if kst_esito.esito <> kkg_esito.ok then
			k_return = "3" + "Archivio " + tab_1.tabpage_1.text + " ~n~r" + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) 
		else // Tutti i Dati Caricati in Archivio
			k_return ="0 "
		end if
	else
		k_errore = string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) 
		kguo_sqlca_db_magazzino.db_rollback( )
		if kst_esito.esito <> kkg_esito.ok then
			k_errore += "~n~rfallito anche il 'recupero' dell'errore: ~n~r" + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) 
		end if
		k_errore += "~n~rPrego, controllare i dati !! "
		k_return="1Fallito aggiornamento archivio di Configurazione Pk-List '" + tab_1.tabpage_1.text + "' : " + k_errore 
	end if
end if



//=== errore : 0=tutto OK o NON RICHIESTA; 1=errore grave I-O;
//=== 		 : 2=LIBERO
//===			 : 3=Commit fallita

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
string  k_key, k_codice
int k_err_ins, k_rc
kuf_utility kuf1_utility


//=== 


if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
	k_scelta = trim(ki_st_open_w.flag_modalita)
	
	k_key = trim(ki_st_open_w.key1)



	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
		
		k_err_ins = inserisci()
//		tab_1.tabpage_1.dw_1.setfocus()
	else

		k_rc = tab_1.tabpage_1.dw_1.retrieve(k_key) 
		
		choose case k_rc

			case is < 0				
				messagebox("Operazione fallita", &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(Codice cercato: " + trim(k_key) + ")~n~r" )
				cb_ritorna.postevent(clicked!)

			case 0
	
				tab_1.tabpage_1.dw_1.reset()
				attiva_tasti()

				if k_scelta = kkg_flag_modalita.modifica then
					messagebox("Ricerca fallita", &
						"Mi spiace ma il Record non e' in archivio ~n~r" + &
						"(Codice cercato: " + trim(k_key) + ")~n~r" )

					cb_ritorna.triggerevent("clicked!")
					
				else
					k_err_ins = inserisci()
//					tab_1.tabpage_1.dw_1.setfocus()
				end if
			case is > 0		
				if k_scelta = "in" then
					messagebox("Gia' in tabella", &
						"Il record e' gia' in archivio ~n~r" + &
						"(Codice cercato: " + trim(k_key) + ")~n~r" )
			
						ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica

				end if

				tab_1.tabpage_1.dw_1.setcolumn(1)
//				tab_1.tabpage_1.dw_1.setfocus()
				
				attiva_tasti()
		
		end choose

	end if

else
	attiva_tasti()
end if


	
//--- Inabilita campi alla modifica se Vsualizzazione
   kuf1_utility = create kuf_utility 
   if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.visualizzazione then
	
      kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_1.dw_1)

	else		
		
//--- S-protezione campi per riabilitare la modifica a parte la chiave
      kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)

//--- Inabilita campo cliente per la modifica se Funzione MODIFICA
	   if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
   	   kuf1_utility.u_proteggi_dw("1", 1, tab_1.tabpage_1.dw_1)
		end if

	end if
	destroy kuf1_utility

	
return "0"


end function

private subroutine open_notepad_documento (string k_file) throws uo_exception;//
kuf_ole kuf1_ole
st_esito kst_esito
uo_exception kuo_exception


	if LenA(trim(k_file)) > 0 then 
	
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

protected subroutine open_start_window ();//
kiuf_wm_pklist_cfg = create kuf_wm_pklist_cfg

kiw_this_window.icon = kGuo_path.get_risorse() + "\pklist.ico"
tab_1.tabpage_1.dw_1.SetPosition("cfg_dbms_scelta", "", false)
tab_1.tabpage_1.dw_1.SetPosition("b_odbc", "", true)

//tab_1.tabpage_1.dw_1.object.cfg_dbms_scelta.sendtoback
end subroutine

private subroutine get_file_esiti ();//
string k_path="..", k_file
int k_ret


k_path = tab_1.tabpage_1.dw_1.getitemstring (1, "file_esiti")
if len(trim(k_path)) > 0 then
else
	k_path="Esiti_PKLIST.txt"
end if


k_ret = GetFileSaveName ( "Scegli File di Registrazione Esiti Importazioni",  k_path, k_file  )

if k_ret = 1 then
	tab_1.tabpage_1.dw_1.setitem(1, "file_esiti", trim(k_path))
else
	if k_ret < 0 then
//--- ERRORE	
	end if
end if


end subroutine

private subroutine get_path_pkl_da_web ();//
string k_path="..", k_file
int k_ret


k_path = tab_1.tabpage_1.dw_1.getitemstring (1, "cartella_pkl_da_web")
if len(trim(k_path)) > 0 then
else
	k_path= kg_path_procedura
end if


k_ret = GetFolder ( "Scegli Cartella dei Packing-list in formato XML (Web)",  k_path  )

if k_ret = 1 then
	tab_1.tabpage_1.dw_1.setitem(1, "cartella_pkl_da_web", trim(k_path))
else
	if k_ret < 0 then
//--- ERRORE	
	end if
end if


end subroutine

protected function string check_dati ();//
//--- x evitare di fare il PADRE
return "0"
end function

public function boolean test_dll_m2000utility ();//
boolean k_return = false
//pointer k_pointer
//kuf_wm_dll_m2000utility kuf1_wm_dll_m2000utility
//		
//
//	
//	try 
//		k_pointer = setpointer(HourGlass!)
//		kuf1_wm_dll_m2000utility = create kuf_wm_dll_m2000utility
//		kuf1_wm_dll_m2000utility.crea_object()
//		kuf1_wm_dll_m2000utility.login( )
//		k_return = true
//		kuf1_wm_dll_m2000utility.logout( )
//		
//	catch (uo_exception kuo1_exception)
//		k_return = false		
//		
//	finally
//		destroy kuf1_wm_dll_m2000utility
//		setpointer(k_pointer)
//		
//	end try
//
return k_return
end function

protected subroutine inizializza_1 () throws uo_exception;//
//======================================================================
//=== Inizializzazione del TAB 3 controllandone i valori se gia' presenti
//======================================================================
//
string k_scelta, k_codice_prec, k_codice_attuale
long  k_righe=0
st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg
kuf_utility kuf1_utility


kuf1_utility = create kuf_utility

kst_tab_wm_pklist_cfg.blocca_importa = tab_1.tabpage_1.dw_1.getitemstring(1, "blocca_importa") 

if ki_blocca_importa > " " and ki_blocca_importa = kst_tab_wm_pklist_cfg.blocca_importa then
else

	if kst_tab_wm_pklist_cfg.blocca_importa = kiuf_wm_pklist_cfg.ki_blocca_importa_DAM2000 then
		tab_1.tabpage_2.dw_2.settrans(kguo_sqlca_db_magazzino)
	else
		kguo_sqlca_db_wm.db_connetti( )
		tab_1.tabpage_2.dw_2.settrans(kguo_sqlca_db_wm)
	end if
	
	k_righe=tab_1.tabpage_2.dw_2.retrieve("*")
	if k_righe > 0 then
		ki_blocca_importa = kst_tab_wm_pklist_cfg.blocca_importa
	else
		ki_blocca_importa = ""
	end if				

	if kst_tab_wm_pklist_cfg.blocca_importa = kiuf_wm_pklist_cfg.ki_blocca_importa_DAM2000 then
	else
		kguo_sqlca_db_wm.db_disconnetti( )
	end if

end if

//--- Inabilita campi alla modifica se Visualizzazione
kuf1_utility = create kuf_utility 
if tab_1.tabpage_2.dw_2.ki_flag_modalita = kkg_flag_modalita.visualizzazione then 
	kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_2.dw_2)
else
	kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_2.dw_2)
end if
destroy kuf1_utility

attiva_tasti()

if k_righe > 0 then
	tab_1.tabpage_2.dw_2.selectrow(0, false)
	tab_1.tabpage_2.dw_2.scrolltorow(tab_1.tabpage_2.dw_2.rowcount())
	tab_1.tabpage_2.dw_2.selectrow(tab_1.tabpage_2.dw_2.rowcount(), true)
end if
	

end subroutine

protected subroutine inizializza_2 () throws uo_exception;//
//--- Elenco file pkl-XML
//
int k_nr_file_xml, k_ctr_file_xml, k_nr_wm_pkl_web, k_riga, k_ctr_file_xml_web
st_esito kst_esito
st_wm_pkl_web kst_wm_pkl_web[], kst_wm_pkl_web_file[], kst_wm_pkl_web_da_imp[], kst_wm_pkl_web_vuoto[]
kuf_wm_pklist_web kuf1_wm_pklist_web



	try
	
		kuf1_wm_pklist_web = create kuf_wm_pklist_web
	
		tab_1.tabpage_3.dw_3.reset( )
	
//--- Leggo elenco file pkl-web della cartella FTP 
		k_nr_file_xml = kuf1_wm_pklist_web.get_file_wm_pklist_web(kst_wm_pkl_web_file[]) 
		
		tab_1.tabpage_3.dw_3.setredraw(false)
		
		if k_nr_file_xml > 0 then
			
			for k_ctr_file_xml = 1 to k_nr_file_xml
		
				if len(trim(kst_wm_pkl_web_file[k_ctr_file_xml].nome_file)) > 0 then   // se c'e' un file....

					kst_wm_pkl_web_da_imp[] = kst_wm_pkl_web_vuoto[]
					k_riga = 0
					k_nr_wm_pkl_web = kuf1_wm_pklist_web.get_wm_pklist_web_xml( kst_wm_pkl_web_file[k_ctr_file_xml], kst_wm_pkl_web_da_imp[]) 
				
					if k_nr_wm_pkl_web > 0 then
							k_riga = tab_1.tabpage_3.dw_3.insertrow(0)
							k_ctr_file_xml_web = 1
							tab_1.tabpage_3.dw_3.setitem(k_riga, "folder", kst_wm_pkl_web_da_imp[k_ctr_file_xml_web].path_file)
							tab_1.tabpage_3.dw_3.setitem(k_riga, "nomefile", kst_wm_pkl_web_da_imp[k_ctr_file_xml_web].nome_file)
							tab_1.tabpage_3.dw_3.setitem(k_riga, "mandante", kst_wm_pkl_web_da_imp[k_ctr_file_xml_web].mandante)
							tab_1.tabpage_3.dw_3.setitem(k_riga, "datainvio", kst_wm_pkl_web_da_imp[k_ctr_file_xml_web].data_invio)
							tab_1.tabpage_3.dw_3.setitem(k_riga, "orainvio", kst_wm_pkl_web_da_imp[k_ctr_file_xml_web].ora_invio )
							tab_1.tabpage_3.dw_3.setitem(k_riga, "colli", 1 )
							tab_1.tabpage_3.dw_3.setitem(k_riga, "nrddt", kst_wm_pkl_web_da_imp[k_ctr_file_xml_web].nrddt )
							tab_1.tabpage_3.dw_3.setitem(k_riga, "dtddt", kst_wm_pkl_web_da_imp[k_ctr_file_xml_web].dtddt )
							tab_1.tabpage_3.dw_3.setitem(k_riga, "externalpallet", kst_wm_pkl_web_da_imp[k_ctr_file_xml_web].barcode )
							tab_1.tabpage_3.dw_3.setitem(k_riga, "id", kst_wm_pkl_web_da_imp[k_ctr_file_xml_web].codice_lotto )
					end if
					for k_ctr_file_xml_web = 2 to k_nr_wm_pkl_web
						if tab_1.tabpage_3.dw_3.getitemstring(k_riga, "nomefile") <> kst_wm_pkl_web_da_imp[k_ctr_file_xml_web].nome_file &
								or tab_1.tabpage_3.dw_3.getitemstring(k_riga, "mandante") <> kst_wm_pkl_web_da_imp[k_ctr_file_xml_web].mandante &
								or tab_1.tabpage_3.dw_3.getitemstring(k_riga, "datainvio") <> kst_wm_pkl_web_da_imp[k_ctr_file_xml_web].data_invio &
								or tab_1.tabpage_3.dw_3.getitemstring(k_riga, "orainvio") <> kst_wm_pkl_web_da_imp[k_ctr_file_xml_web].ora_invio &
								or tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "colli") <> kst_wm_pkl_web_da_imp[k_ctr_file_xml_web].colliddt  &
								or tab_1.tabpage_3.dw_3.getitemstring(k_riga, "nrddt") <> kst_wm_pkl_web_da_imp[k_ctr_file_xml_web].nrddt &
								or tab_1.tabpage_3.dw_3.getitemstring(k_riga, "dtddt") <> kst_wm_pkl_web_da_imp[k_ctr_file_xml_web].dtddt &
								or tab_1.tabpage_3.dw_3.getitemstring(k_riga, "externalpallet") <> kst_wm_pkl_web_da_imp[k_ctr_file_xml_web].barcode &
								or tab_1.tabpage_3.dw_3.getitemstring(k_riga, "id") <> kst_wm_pkl_web_da_imp[k_ctr_file_xml_web].codice_lotto then
	
							k_riga = tab_1.tabpage_3.dw_3.insertrow(0)
							tab_1.tabpage_3.dw_3.setitem(k_riga, "folder", kst_wm_pkl_web_da_imp[k_ctr_file_xml_web].path_file)
							tab_1.tabpage_3.dw_3.setitem(k_riga, "nomefile", kst_wm_pkl_web_da_imp[k_ctr_file_xml_web].nome_file)
							tab_1.tabpage_3.dw_3.setitem(k_riga, "mandante", kst_wm_pkl_web_da_imp[k_ctr_file_xml_web].mandante)
							tab_1.tabpage_3.dw_3.setitem(k_riga, "datainvio", kst_wm_pkl_web_da_imp[k_ctr_file_xml_web].data_invio)
							tab_1.tabpage_3.dw_3.setitem(k_riga, "orainvio", kst_wm_pkl_web_da_imp[k_ctr_file_xml_web].ora_invio )
							tab_1.tabpage_3.dw_3.setitem(k_riga, "colli", 1 )
							tab_1.tabpage_3.dw_3.setitem(k_riga, "nrddt", kst_wm_pkl_web_da_imp[k_ctr_file_xml_web].nrddt )
							tab_1.tabpage_3.dw_3.setitem(k_riga, "dtddt", kst_wm_pkl_web_da_imp[k_ctr_file_xml_web].dtddt )
							tab_1.tabpage_3.dw_3.setitem(k_riga, "externalpallet", kst_wm_pkl_web_da_imp[k_ctr_file_xml_web].barcode)
							tab_1.tabpage_3.dw_3.setitem(k_riga, "id", kst_wm_pkl_web_da_imp[k_ctr_file_xml_web].codice_lotto)
						end if
					end for
				end if
			end for	
			
		end if

	catch(uo_exception kuo_exception)
		kguo_exception.set_esito(kuo_exception.get_st_esito())
		
	finally
		tab_1.tabpage_3.dw_3.setredraw(true)
		if isvalid(kuf1_wm_pklist_web) then destroy kuf1_wm_pklist_web
		tab_1.tabpage_3.dw_3.groupcalc( )
		tab_1.tabpage_3.dw_3.resetupdate( )
		
	end try
	
 


end subroutine

private subroutine get_path_pkl_da_txt ();//
string k_path="..", k_file
int k_ret


k_path = tab_1.tabpage_1.dw_1.getitemstring (1, "cartella_pkl_da_txt")
if len(trim(k_path)) > 0 then
else
	k_path= kg_path_procedura
end if


k_ret = GetFolder ( "Scegli Cartella dei Packing-list in formato lineare",  k_path  )

if k_ret = 1 then
	tab_1.tabpage_1.dw_1.setitem(1, "cartella_pkl_da_txt", trim(k_path))
else
	if k_ret < 0 then
//--- ERRORE	
	end if
end if


end subroutine

protected subroutine inizializza_3 () throws uo_exception;//
//--- Elenco file pkl-TXT
//
int k_nr_file_txt, k_ctr_da_imp_txt, k_nr_wm_pkl_file, k_riga, k_ctr_file_txt
st_esito kst_esito
st_wm_pkl_file kst_wm_pkl_file[], kst_wm_pkl_file_file[], kst_wm_pkl_file_da_imp[], kst_wm_pkl_file_vuoto[]
kuf_wm_receiptgammarad kuf1_wm_receiptgammarad



	try
	
		kuf1_wm_receiptgammarad = create kuf_wm_receiptgammarad
	
		tab_1.tabpage_4.dw_4.reset( )
	
//--- Leggo elenco file pkl-txt della cartella FTP 
		k_nr_file_txt = kuf1_wm_receiptgammarad.get_file_wm_pklist_txt(kst_wm_pkl_file_file[]) 
		
		tab_1.tabpage_4.dw_4.setredraw(false)
		if k_nr_file_txt > 0 then
			
			for k_ctr_file_txt = 1 to k_nr_file_txt
		
				if len(trim(kst_wm_pkl_file_file[k_ctr_file_txt].nome_file)) > 0 then   // se c'e' un file....

					kst_wm_pkl_file_da_imp[1] = kst_wm_pkl_file_file[k_ctr_file_txt]
					k_riga = 0
					k_nr_wm_pkl_file = kuf1_wm_receiptgammarad.get_wm_pklist_file_txt(kst_wm_pkl_file_da_imp[]) 
				
					if k_nr_wm_pkl_file > 0 then
							k_riga = tab_1.tabpage_4.dw_4.insertrow(0)
							k_ctr_da_imp_txt = 1
							tab_1.tabpage_4.dw_4.setitem(k_riga, "folder", kst_wm_pkl_file_da_imp[k_ctr_da_imp_txt].path_file)
							tab_1.tabpage_4.dw_4.setitem(k_riga, "nomefile", kst_wm_pkl_file_da_imp[k_ctr_da_imp_txt].nome_file)
							tab_1.tabpage_4.dw_4.setitem(k_riga, "mandante", kst_wm_pkl_file_da_imp[k_ctr_da_imp_txt].mandante)
							tab_1.tabpage_4.dw_4.setitem(k_riga, "datainvio", kst_wm_pkl_file_da_imp[k_ctr_da_imp_txt].data_invio)
							tab_1.tabpage_4.dw_4.setitem(k_riga, "orainvio", kst_wm_pkl_file_da_imp[k_ctr_da_imp_txt].ora_invio )
							tab_1.tabpage_4.dw_4.setitem(k_riga, "colli", kst_wm_pkl_file_da_imp[k_ctr_da_imp_txt].colliddt )
							tab_1.tabpage_4.dw_4.setitem(k_riga, "nrddt", kst_wm_pkl_file_da_imp[k_ctr_da_imp_txt].nrddt )
							tab_1.tabpage_4.dw_4.setitem(k_riga, "dtddt", kst_wm_pkl_file_da_imp[k_ctr_da_imp_txt].dtddt )
							tab_1.tabpage_4.dw_4.setitem(k_riga, "externalpallet", kst_wm_pkl_file_da_imp[k_ctr_da_imp_txt].externalpalletcode )
							tab_1.tabpage_4.dw_4.setitem(k_riga, "id", kst_wm_pkl_file_da_imp[k_ctr_da_imp_txt].idlotto)
					end if
					for k_ctr_da_imp_txt = 2 to k_nr_wm_pkl_file
						if tab_1.tabpage_4.dw_4.getitemstring(k_riga, "nomefile") <> kst_wm_pkl_file_da_imp[k_ctr_da_imp_txt].nome_file &
								or tab_1.tabpage_4.dw_4.getitemstring(k_riga, "mandante") <> kst_wm_pkl_file_da_imp[k_ctr_da_imp_txt].mandante &
								or tab_1.tabpage_4.dw_4.getitemstring(k_riga, "datainvio") <> kst_wm_pkl_file_da_imp[k_ctr_da_imp_txt].data_invio &
								or tab_1.tabpage_4.dw_4.getitemstring(k_riga, "orainvio") <> kst_wm_pkl_file_da_imp[k_ctr_da_imp_txt].ora_invio &
								or tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "colli") <> kst_wm_pkl_file_da_imp[k_ctr_da_imp_txt].colliddt  &
								or tab_1.tabpage_4.dw_4.getitemstring(k_riga, "nrddt") <> kst_wm_pkl_file_da_imp[k_ctr_da_imp_txt].nrddt &
								or tab_1.tabpage_4.dw_4.getitemstring(k_riga, "dtddt") <> kst_wm_pkl_file_da_imp[k_ctr_da_imp_txt].dtddt &
								or tab_1.tabpage_4.dw_4.getitemstring(k_riga, "externalpallet") <> kst_wm_pkl_file_da_imp[k_ctr_da_imp_txt].externalpalletcode &
								or tab_1.tabpage_4.dw_4.getitemstring(k_riga, "id") <> kst_wm_pkl_file_da_imp[k_ctr_da_imp_txt].idlotto then
	
							k_riga = tab_1.tabpage_4.dw_4.insertrow(0)
							tab_1.tabpage_4.dw_4.setitem(k_riga, "folder", kst_wm_pkl_file_da_imp[k_ctr_da_imp_txt].path_file)
							tab_1.tabpage_4.dw_4.setitem(k_riga, "nomefile", kst_wm_pkl_file_da_imp[k_ctr_da_imp_txt].nome_file)
							tab_1.tabpage_4.dw_4.setitem(k_riga, "mandante", kst_wm_pkl_file_da_imp[k_ctr_da_imp_txt].mandante)
							tab_1.tabpage_4.dw_4.setitem(k_riga, "datainvio", kst_wm_pkl_file_da_imp[k_ctr_da_imp_txt].data_invio)
							tab_1.tabpage_4.dw_4.setitem(k_riga, "orainvio", kst_wm_pkl_file_da_imp[k_ctr_da_imp_txt].ora_invio )
							tab_1.tabpage_4.dw_4.setitem(k_riga, "colli", kst_wm_pkl_file_da_imp[k_ctr_da_imp_txt].colliddt )
							tab_1.tabpage_4.dw_4.setitem(k_riga, "nrddt", kst_wm_pkl_file_da_imp[k_ctr_da_imp_txt].nrddt )
							tab_1.tabpage_4.dw_4.setitem(k_riga, "dtddt", kst_wm_pkl_file_da_imp[k_ctr_da_imp_txt].dtddt )
							tab_1.tabpage_4.dw_4.setitem(k_riga, "externalpallet", kst_wm_pkl_file_da_imp[k_ctr_da_imp_txt].externalpalletcode )
							tab_1.tabpage_4.dw_4.setitem(k_riga, "id", kst_wm_pkl_file_da_imp[k_ctr_da_imp_txt].idlotto)
						end if
					end for
				end if
			end for	
			
		end if
		
	catch(uo_exception kuo_exception)
		kguo_exception.set_esito(kuo_exception.get_st_esito())
		
	finally
		tab_1.tabpage_4.dw_4.groupcalc( )
		tab_1.tabpage_4.dw_4.setredraw(true)
		if isvalid(kuf1_wm_receiptgammarad) then destroy kuf1_wm_receiptgammarad
		tab_1.tabpage_4.dw_4.resetupdate( )
		
	end try
	
 


end subroutine

protected subroutine attiva_tasti_0 ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================


super::attiva_tasti_0()		 

cb_ritorna.enabled = true
cb_inserisci.enabled = false
cb_aggiorna.enabled = true
cb_cancella.enabled = false

cb_ritorna.default = false
cb_inserisci.default = false
cb_aggiorna.default = false
cb_cancella.default = false


if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	cb_inserisci.enabled = true
end if

//attiva_menu()

end subroutine

on w_wm_pklist_cfg.create
int iCurrent
call super::create
end on

on w_wm_pklist_cfg.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;//
if isvalid(kiuf_wm_pklist_cfg) then destroy kiuf_wm_pklist_cfg

end event

type st_ritorna from w_g_tab_3`st_ritorna within w_wm_pklist_cfg
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_wm_pklist_cfg
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_wm_pklist_cfg
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_wm_pklist_cfg
integer x = 2711
integer y = 1444
end type

type st_stampa from w_g_tab_3`st_stampa within w_wm_pklist_cfg
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_wm_pklist_cfg
integer x = 1175
integer y = 1440
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_wm_pklist_cfg
integer x = 503
integer y = 1436
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_wm_pklist_cfg
integer x = 1970
integer y = 1444
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_wm_pklist_cfg
integer x = 2341
integer y = 1444
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_wm_pklist_cfg
integer x = 1600
integer y = 1444
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

type tab_1 from w_g_tab_3`tab_1 within w_wm_pklist_cfg
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
string text = "Proprieta~'"
string picturename = "DosEdit5!"
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
integer y = 16
integer width = 3465
integer height = 1244
string dataobject = "d_wm_pklist_cfg"
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_d_std_1_attiva_cerca = false
end type

event dw_1::buttonclicked;call super::buttonclicked;//
kuf_utility kuf1_utility


if dwo.name = "b_odbc" then 

	kuf1_utility = create kuf_utility
	kuf1_utility.u_apri_programma_esterno("odbcad32.exe")
	destroy kuf1_utility

else
	if dwo.name = "b_importazione_ts_ini_reset" then
		this.setitem( row, "importazione_ts_ini", datetime(date(0)) )
		attiva_tasti( )
	elseif dwo.name = "b_file_esiti" then
		get_file_esiti()
	elseif dwo.name = "b_check_dll" then
		if test_dll_m2000utility() then
			kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_OK)
			kguo_exception.messaggio_utente("Test Connessione", "Connessione all'Utility di WM riuscita!")
		else
			kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_err_int )
			kguo_exception.messaggio_utente("Test Connessione", "Connessione all'Utility di WM  NON  riuscita!")
		end if
	elseif dwo.name = "b_cartella_pkl_da_web" then
		get_path_pkl_da_web()
	elseif dwo.name = "b_cartella_pkl_da_txt" then
		get_path_pkl_da_txt()
	elseif dwo.name = "b_dbparm" then
		kguo_exception.inizializza( )
		kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_OK)
		kguo_exception.messaggio_utente("Test Connessione", "Hai Salvato i Dati della Connessione qui indicati?  ~n~rAttenzione: il test di Connessione è fatto con i parametri già SALVATI su DB!")
		try
			kguo_sqlca_db_wm.db_disconnetti( ) 
		catch (uo_exception kuo_exceptionOK)
		end try
		try
			if kguo_sqlca_db_wm.db_connetti( ) then
				kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_OK)
				kguo_exception.messaggio_utente("Test Connessione",  "OK, connessione eseguita.")
			end if
		catch (uo_exception kuo_exception)
			kuo_exception.messaggio_utente()
		end try
	end if
end if



end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
integer x = 507
integer y = 832
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
integer width = 3003
integer height = 1268
string text = "PackingList caricate"
string powertiptext = "Tutte i pkl arrivati (anche gli errati o mai gestiti) "
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
boolean visible = true
integer x = 0
integer width = 2981
integer height = 1228
boolean enabled = true
string dataobject = "d_wm_receiptgammarad_l"
end type

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
boolean visible = true
integer width = 3003
integer height = 1268
string text = "PackingList XML"
string powertiptext = "elenco pkl in formato XML"
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
boolean visible = true
integer width = 2967
integer height = 1232
boolean enabled = true
string dataobject = "d_wm_pklist_file_infolder"
end type

event dw_3::itemchanged;call super::itemchanged;//



end event

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
boolean visible = true
integer width = 3003
integer height = 1268
string text = "PackingList TXT"
string powertiptext = "elenco pkl in formato testo lineare"
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
boolean visible = true
integer y = 24
integer width = 2939
integer height = 1116
integer taborder = 10
boolean enabled = true
string dataobject = "d_wm_pklist_file_infolder"
end type

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

