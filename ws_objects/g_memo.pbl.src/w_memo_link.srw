$PBExportHeader$w_memo_link.srw
forward
global type w_memo_link from w_g_tab_3
end type
type ln_1 from line within tabpage_4
end type
end forward

global type w_memo_link from w_g_tab_3
integer x = 169
integer y = 148
integer width = 3680
integer height = 2088
string title = "MEMO"
boolean ki_sincronizza_window_consenti = false
boolean ki_fai_nuovo_dopo_update = false
boolean ki_fai_nuovo_dopo_insert = false
boolean ki_msg_dopo_update = false
end type
global w_memo_link w_memo_link

type variables
//
private kuf_memo_link kiuf_memo_link
private st_tab_memo_link kist_tab_memo_link
private st_tab_memo_link kist_tab_memo_link_orig
private boolean ki_allegato_ancoraDaImportare_si = false

end variables

forward prototypes
private function integer inserisci ()
protected function integer cancella ()
private subroutine leggi_altre_tab ()
protected function string inizializza ()
protected subroutine open_start_window ()
public subroutine load_file_to_memo_link ()
private subroutine get_path ()
protected subroutine riempi_id ()
protected function string aggiorna ()
protected function string check_dati ()
end prototypes

private function integer inserisci ();//
int k_return=1, k_ctr
kuf_memo kuf1_memo
st_tab_memo kst_tab_memo


try
//=== Aggiunge una riga al data windows
	choose case tab_1.selectedtab 
	
		case  1 
	
			tab_1.tabpage_1.dw_1.reset( )
			k_ctr=tab_1.tabpage_1.dw_1.insertrow(0)
			tab_1.tabpage_1.dw_1.setitem(1, "id_memo_link", 0 )
			tab_1.tabpage_1.dw_1.setitem(1, "dataora_ins", kist_tab_memo_link.dataora_ins )
			tab_1.tabpage_1.dw_1.setitem(1, "utente_ins", kist_tab_memo_link.utente_ins )
			tab_1.tabpage_1.dw_1.setitem(1, "id_memo", kist_tab_memo_link.id_memo )
			tab_1.tabpage_1.dw_1.setitem(1, "link", kist_tab_memo_link.link )
			tab_1.tabpage_1.dw_1.setitem(1, "nome", kist_tab_memo_link.nome )
			tab_1.tabpage_1.dw_1.setitem(1, "tipo_memo_link", kist_tab_memo_link.tipo_memo_link )
			tab_1.tabpage_1.dw_1.setitem(1, "memo_link_load", kiuf_memo_link.kki_memo_link_load_NO)
			tab_1.tabpage_1.dw_1.setitem(1, "titolo", kist_tab_memo_link.titolo )
			tab_1.tabpage_1.dw_1.setitem(1, "x_datins", kist_tab_memo_link.x_datins )
			tab_1.tabpage_1.dw_1.setitem(1, "x_utente", kist_tab_memo_link.x_utente )
			
			kuf1_memo = create kuf_memo
			kst_tab_memo.id_memo = kist_tab_memo_link.id_memo 
			kst_tab_memo.titolo = kuf1_memo.get_titolo(kst_tab_memo)
			tab_1.tabpage_1.dw_1.setitem(1, "memo_titolo", kst_tab_memo.titolo)
			
			tab_1.tabpage_1.dw_1.SetItemStatus( 1, 0, Primary!, NotModified!)

			ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento

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
int k_return=0
string k_desc, k_record, k_record_1
long k_key = 0, k_clie_1=0, k_clie_2
string k_errore = "0 ", k_errore1 = "0 ", k_nro_fatt
long k_riga
st_tab_memo_link kst_tab_memo_link

try

	choose case tab_1.selectedtab 
		case 1 
			k_record = " Link"
			k_riga = tab_1.tabpage_1.dw_1.getrow()	
			if k_riga > 0 then
				kst_tab_memo_link.titolo = tab_1.tabpage_1.dw_1.getitemstring( k_riga, "titolo")
				kst_tab_memo_link.id_memo_link = tab_1.tabpage_1.dw_1.getitemnumber( k_riga, "id_memo_link")
				if kst_tab_memo_link.id_memo_link > 0 then
					k_key = kst_tab_memo_link.id_memo_link
					k_desc = kst_tab_memo_link.titolo
					if isnull(k_desc) = true or trim(k_desc) = "" then
						k_desc = "senza descrizione" 
					end if
					k_record_1 = "Sei sicuro di voler eliminare il LINK, id=" + string(k_key, "#####") +  "~n~r" + trim(k_desc) + " ?"
				else
					tab_1.tabpage_1.dw_1.deleterow(k_riga)
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
				case 1 
					kst_tab_memo_link.st_tab_g_0.esegui_commit = "S"
					kiuf_memo_link.tb_delete(kst_tab_memo_link) 
	
			end choose	
			
			choose case tab_1.selectedtab 
				case 1 
					tab_1.tabpage_1.dw_1.deleterow(k_riga)
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
	end choose	



catch (uo_exception kuo_exception)
//		kst_esito = kuo_exception.get_st_esito()
		k_errore = "1" + trim(kuo_exception.getmessage())
		messagebox("Problemi durante Cancellazione - Operazione fallita !!", &
								mid(k_errore1, 2) ) 	

finally
	attiva_tasti()

	
end try


return k_return

end function

private subroutine leggi_altre_tab ();
end subroutine

protected function string inizializza ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_return="0"
long k_memo_link_len = 0
int k_err_ins, k_rc
kuf_utility kuf1_utility


if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
	if kist_tab_memo_link.id_memo_link = 0 then
		k_err_ins = inserisci()
		tab_1.tabpage_1.dw_1.setfocus()
	else
		k_rc = tab_1.tabpage_1.dw_1.retrieve(kist_tab_memo_link.id_memo_link) 
		
		choose case k_rc

			case is < 0				
				messagebox("Operazione fallita", &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(Codice cercato:" + string(kist_tab_memo_link.id_memo_link) + ")~n~r" )
				cb_ritorna.postevent(clicked!)

			case 0
				tab_1.tabpage_1.dw_1.reset()
				k_err_ins = inserisci()
				tab_1.tabpage_1.dw_1.setfocus()
				
			case is > 0		
				if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
					messagebox("Link Trovato ", &
						"Link gia' in archivio ~n~r" + &
						"(Codice cercato :" + string(kist_tab_memo_link.id_memo_link) + ")~n~r" )
					ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica
				end if

				try
//					k_memo_link_len = kiuf_memo_link.get_memo_link(kist_tab_memo_link)  
//					if k_memo_link_len > 5 then  //il minimo x capire di avere un blob
//						tab_1.tabpage_1.dw_1.setitem(1, "memo_link_load", kiuf_memo_link.kki_memo_link_load_SI)
//					else
//						tab_1.tabpage_1.dw_1.setitem(1, "memo_link_load", kiuf_memo_link.kki_memo_link_load_NO)
//					end if
//					tab_1.tabpage_1.dw_1.SetItemStatus( 1, 0, Primary!, NotModified!)

				catch (uo_exception kuo_exception)
					kuo_exception.messaggio_utente()
				end try

				tab_1.tabpage_1.dw_1.setcolumn(1)
				tab_1.tabpage_1.dw_1.setfocus()
	
		end choose

	end if
end if

kuf1_utility = create kuf_utility
if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
//--- S-protezione campi 
	kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)
else
//--- Protezione campi 
	kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_1.dw_1)
	tab_1.tabpage_1.dw_1.modify("cb_importa.visibile='0'")
end if


return k_return 

end function

protected subroutine open_start_window ();//
//	kiuf_clienti = create kuf_clienti


	kiuf_memo_link = ki_st_open_w.key12_any

	kist_tab_memo_link = kiuf_memo_link.get_st_tab_memo_link()
	

end subroutine

public subroutine load_file_to_memo_link ();//
int k_rc = 0
int ki=0
long k_len
string k_aggiorna_dati = "", k_msg
kuf_utility kuf1_utility


try

	kist_tab_memo_link.id_memo_link = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_memo_link")
	kist_tab_memo_link.link = tab_1.tabpage_1.dw_1.getitemstring(1, "link")

//--- get Flag se devo togliere o mettere il blob in tabella
	kist_tab_memo_link.memo_link_load = tab_1.tabpage_1.dw_1.getitemstring(1, "memo_link_load")
	if isnull(kist_tab_memo_link.memo_link_load) then kist_tab_memo_link.memo_link_load = kiuf_memo_link.kki_memo_link_load_NO
	
	if trim(kist_tab_memo_link.link) > " " or kist_tab_memo_link.memo_link_load = kiuf_memo_link.kki_memo_link_load_SI then
	
		if kist_tab_memo_link.memo_link_load = kiuf_memo_link.kki_memo_link_load_no then
			k_rc = messagebox("Importa file", "Caricare l'intero documento in archivio", question!, yesno!, 2)
		else
			k_rc = messagebox("Toglie file", "Rimuovere il documento dagli archivi", question!, yesno!, 2)
		end if
		
		if k_rc = 1 then

			ki_msg_dopo_update = false
			k_aggiorna_dati = aggiorna_dati() // aggiorna tutti i dati
			ki_msg_dopo_update = true
			if left(k_aggiorna_dati,1) = "1" then // se aggiornamento fallito non fa nulla
			else
			
				ki_allegato_ancoraDaImportare_si = false   // flag se allegato da importare più tardi dopo il tasto aggiorna
	
		//--- carica il documento nel campo memo_link
					
				if kist_tab_memo_link.memo_link_load = kiuf_memo_link.kki_memo_link_load_no then
					kiuf_memo_link.load_memo_link(kist_tab_memo_link) 
				else
					setnull(kist_tab_memo_link.memo_link) // =  blob("")
				end if

				if kist_tab_memo_link.id_memo_link > 0 then
	//--- aggiorna il blob
					kiuf_memo_link.tb_update_memo_link(kist_tab_memo_link)
					if kist_tab_memo_link.memo_link_load = kiuf_memo_link.kki_memo_link_load_no then
						kuf1_utility = create kuf_utility
						kist_tab_memo_link.nome = kuf1_utility.u_get_nome_file(kist_tab_memo_link.link)
						tab_1.tabpage_1.dw_1.setitem(1, "nome", trim(kist_tab_memo_link.nome))
						tab_1.tabpage_1.dw_1.setitem(1, "memo_link_load", kiuf_memo_link.kki_memo_link_load_SI)
						k_len = filelength(kist_tab_memo_link.link) //--- lunghezza dell'allegato originale
						tab_1.tabpage_1.dw_1.setitem (1, "memo_link_lenunzip", k_len) 
						k_msg =  "File importato nel DB"
					else
						tab_1.tabpage_1.dw_1.setitem(1, "memo_link_load", kiuf_memo_link.kki_memo_link_load_NO)
						tab_1.tabpage_1.dw_1.setitem(1, "nome", "")
						tab_1.tabpage_1.dw_1.setitem (1, "memo_link_lenunzip", 0) 
						k_msg =  "File cancellato dal DB"
					end if
					ki_msg_dopo_update = false
					k_aggiorna_dati = aggiorna_dati() // aggiorna tutti i dati
					ki_msg_dopo_update = true
					tab_1.tabpage_1.dw_1.SetItemStatus( 1, 0, Primary!, NotModified!)
					messagebox("Operazione completata", k_msg, information!)
				else
					ki_allegato_ancoraDaImportare_si = true
					tab_1.tabpage_1.dw_1.setitem(1, "memo_link_load", " ")
					if kist_tab_memo_link.memo_link_load = kiuf_memo_link.kki_memo_link_load_no then
						tab_1.tabpage_1.dw_1.setitem(1, "nome", trim(kist_tab_memo_link.nome))
						k_rc = messagebox("Operazione incompleta", "File parcheggiato in area temporanea fino alla conferma di Aggiornamento", information!)
					else
						tab_1.tabpage_1.dw_1.setitem(1, "nome", "")
						k_rc = messagebox("Operazione incompleta", "Il file sarà cancellato solo al termine della conferma di Aggiornamento", information!)
					end if
				end if
			end if
		end if	
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try
end subroutine

private subroutine get_path ();//
string k_path="..", k_docpath, k_docname
int k_ret
kuf_utility ku1_utility



k_path = tab_1.tabpage_1.dw_1.getitemstring (1, "link")
if len(trim(k_path)) > 0 then
	ku1_utility = create kuf_utility
	k_path = ku1_utility.u_get_path_file(k_path)
else
	k_path = trim(kGuf_data_base.profilestring_leggi_scrivi(kGuf_data_base.ki_profilestring_operazione_leggi, "path_allegati", ".."))
	if isnull(k_path) then k_path = ".." 
end if

k_ret = GetFileOpenName("Selezionare il documento da allegare", &
				k_docpath, k_docname, "*", &
				+ "Tutti i File (*.*),*.*," &
				+ "Doc  (*.doc),*.doc*" &
				+ "Open  (*.odt),*.odt*" &
				+ "EXCEL  (*.xls), *.XLS*", &
				k_path, 18)

if k_ret = 1 then
	
	tab_1.tabpage_1.dw_1.setitem(1, "link", trim(k_docpath))

	attiva_tasti()
else
	if k_ret < 0 then
//--- ERRORE	
	end if
end if


end subroutine

protected subroutine riempi_id ();//
//st_tab_memo_link kst_tab_memo_link
kuf_utility kuf1_utility



if tab_1.tabpage_1.dw_1.getitemnumber (1, "id_memo_link") > 0 then
else
	tab_1.tabpage_1.dw_1.setitem (1, "id_memo_link", 0) 
	tab_1.tabpage_1.dw_1.setitem (1, "dataora_ins", kGuf_data_base.prendi_x_datins()) 
	tab_1.tabpage_1.dw_1.setitem (1, "utente_ins",  kGuf_data_base.prendi_x_utente()) 
end if
//--- piglia l'estensione x decidere il tipo memo
kist_tab_memo_link.link = trim(tab_1.tabpage_1.dw_1.getitemstring (1, "link")) 
if kist_tab_memo_link.link > " " then
	kuf1_utility = create kuf_utility
	kist_tab_memo_link.tipo_memo_link = kuf1_utility.u_get_ext_file(kist_tab_memo_link.link)
	if kist_tab_memo_link.tipo_memo_link > " " then
		tab_1.tabpage_1.dw_1.setitem(1, "tipo_memo_link", kist_tab_memo_link.tipo_memo_link)
	end if
end if

tab_1.tabpage_1.dw_1.setitem (1, "x_datins", kGuf_data_base.prendi_x_datins()) 
tab_1.tabpage_1.dw_1.setitem (1, "x_utente",  kGuf_data_base.prendi_x_utente()) 

end subroutine

protected function string aggiorna ();//
//======================================================================
//=== Aggiorna tabelle 
//=== Ritorna 1 chr : 0=tutto OK; 1=errore grave I-O;
//=== 				  : 2=
//===					  : 3=Commit fallita
//===		dal char 2 in poi spiegazione dell'errore
//======================================================================
 
string k_return=" ", k_errore="0", k_errore1="0 ", k_path=""
st_esito kst_esito
kuf_utility kuf1_utility

//=== Puntatore Cursore da attesa..... 
SetPointer(kkg.pointer_attesa)

//--- Salva il PATH per poi riproporlo all'utente nei nuovi allgati					
kist_tab_memo_link.link = tab_1.tabpage_1.dw_1.getitemstring(1, "link")
if trim(kist_tab_memo_link.link) > " " then
	kuf1_utility = create kuf_utility
	k_path = kuf1_utility.u_get_path_file(kist_tab_memo_link.link)
	if trim(k_path) = "" then k_path = ".." 
	kGuf_data_base.profilestring_leggi_scrivi(kGuf_data_base.ki_profilestring_operazione_scrivi , "path_allegati", trim(k_path))
end if	

//=== Aggiorna, se modificato, la TAB_1	
kst_esito = aggiorna_dw (tab_1.tabpage_1.dw_1,  tab_1.tabpage_1.text)
if kst_esito.esito <> "0" then
	if k_errore = "0" then
		k_errore = trim(kst_esito.esito)
	else
		k_errore = "2"
	end if
	k_return = trim(k_return) + trim(kst_esito.sqlerrtext)
else 

//--- se tutto ok salva/toglie il blob
	try
		if kist_tab_memo_link.id_memo_link = 0 then // se ero in caricamento allora lo piglio
			kist_tab_memo_link.id_memo_link = kiuf_memo_link.get_ult_id_memo_link( )
		end if
		
		if kist_tab_memo_link.id_memo_link > 0 then
//--- il BLOB è ancora da aggiornare?
			if ki_allegato_ancoraDaImportare_si then
				ki_allegato_ancoraDaImportare_si = false
				kiuf_memo_link.tb_update_memo_link(kist_tab_memo_link)
			end if
			tab_1.tabpage_1.dw_1.setitem(1, "id_memo_link", kist_tab_memo_link.id_memo_link)
			tab_1.tabpage_1.dw_1.SetItemStatus( 1, 0, Primary!, NotModified!)
			ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica
		end if

	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito()
		k_errore = "1" 
		k_return =  trim(kst_esito.esito) + " " + trim(kst_esito.sqlerrtext)

	end try

end if


//=== Puntatore Cursore da attesa.....
SetPointer(kkg.pointer_default)


//=== errore : 0=tutto OK o NON RICHIESTA; 1=errore grave I-O;
//=== 		 : 2=LIBERO
//===			 : 3=Commit fallita

if k_errore = "1" then
	messagebox("Operazione Aggiornamento Archivio Fallita", &
		trim(k_return), & 
			stopsign!)
else
	if k_errore = "3" then
		messagebox("Registrazione dati: problemi nella 'Commit' !!", &
			"Provare a chiudere e controllare/ripetere le operazioni eseguite", &
			stopsign!)
	else
		if k_errore = "2" then
			messagebox("Operazioni Aggiornamenti Archivi Fallite", &
				"Si sono verificati diversi errori in fase di resgitrazione dati:"  &
			   + trim(k_return), stopsign! )
		end if
	end if
end if


return k_errore + trim(k_return)

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
st_esito kst_esito,kst_esito1
datastore kds_inp

try
	kds_inp = create datastore

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//--- Controllo il primo tab
	if tab_1.tabpage_1.dw_1.rowcount() > 0 then
		kds_inp.dataobject = tab_1.tabpage_1.dw_1.dataobject
		tab_1.tabpage_1.dw_1.rowscopy( 1,tab_1.tabpage_1.dw_1.rowcount( ) ,primary!, kds_inp, 1, primary!)
		kst_esito = kiuf_memo_link.u_check_dati(kds_inp)
	end if
	
////--- Controllo altro tab
//	if tab_1.tabpage_2.dw_2.rowcount() > 0 then
//		if  tab_1.tabpage_2.dw_2.enabled then
//			kds_inp.dataobject = tab_1.tabpage_2.dw_2.dataobject
//			tab_1.tabpage_2.dw_2.rowscopy( 1,tab_1.tabpage_2.dw_2.rowcount( ) ,primary!, kds_inp, 1, primary!)
//			kst_esito1 = kiuf1_parent.u_check_dati(kds_inp)
//			if kst_esito1.esito <> kkg_esito.ok then
//				if kst_esito.esito <> kkg_esito.ok then
//					kst_esito.esito = kst_esito1.esito
//					kst_esito.sqlerrtext = tab_1.tabpage_1.text + ": " + kst_esito.sqlerrtext + " " + tab_1.tabpage_2.text + ": " + kst_esito1.sqlerrtext
//				else
//					kst_esito = kst_esito1
//					kst_esito.sqlerrtext = tab_1.tabpage_2.text + ": " + kst_esito.sqlerrtext 
//				end if
//			end if
//		end if	
//	end if	
	
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

on w_memo_link.create
int iCurrent
call super::create
end on

on w_memo_link.destroy
call super::destroy
end on

type st_ritorna from w_g_tab_3`st_ritorna within w_memo_link
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_memo_link
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_memo_link
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_memo_link
integer x = 2711
integer y = 1424
end type

type st_stampa from w_g_tab_3`st_stampa within w_memo_link
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_memo_link
integer x = 1152
integer y = 1440
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_memo_link
integer x = 768
integer y = 1440
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_memo_link
integer x = 1970
integer y = 1424
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_memo_link
integer x = 2341
integer y = 1424
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_memo_link
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

type tab_1 from w_g_tab_3`tab_1 within w_memo_link
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

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
integer width = 3003
integer height = 1268
long backcolor = 32435950
string text = "Allegato"
long tabbackcolor = 32435950
long picturemaskcolor = 32435950
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
boolean visible = true
integer x = 32
integer y = 28
integer width = 2862
integer height = 1192
string dataobject = "d_memo_link"
boolean hsplitscroll = false
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_d_std_1_attiva_cerca = false
end type

event dw_1::clicked;call super::clicked;//
if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then

	if dwo.name = "b_importa" then
		load_file_to_memo_link()
	else
		if dwo.name = "b_path" then
			get_path( )
		end if
	end if
end if

end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
boolean visible = false
integer width = 3003
integer height = 1268
boolean enabled = false
long backcolor = 32435950
string text = ""
long tabbackcolor = 32435950
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
integer x = 0
integer width = 2981
integer height = 1228
boolean hsplitscroll = false
end type

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
integer width = 3003
integer height = 1268
boolean enabled = false
string text = ""
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
integer width = 2967
integer height = 1232
boolean hsplitscroll = false
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

