$PBExportHeader$w_listino.srw
forward
global type w_listino from w_g_tab_3
end type
type dw_10 from uo_d_std_1 within tabpage_2
end type
type ln_1 from line within tabpage_4
end type
type dw_periodo from uo_d_std_1 within w_listino
end type
end forward

global type w_listino from w_g_tab_3
integer x = 169
integer y = 148
integer width = 3049
integer height = 1604
string title = "Listino"
boolean ki_toolbar_window_presente = true
boolean ki_fai_nuovo_dopo_update = false
boolean ki_fai_nuovo_dopo_insert = false
boolean ki_fai_inizializza_dopo_update = true
dw_periodo dw_periodo
end type
global w_listino w_listino

type variables
protected long ki_cod_cli
protected string ki_cod_art
protected string ki_sl_pt
protected kuf_listino kiuf_listino

private boolean ki_cambio_stato_listino_autorizzato=false
private boolean ki_cambio_prezzi_listino_autorizzato=false

private int ki_selectedtab=1

private date ki_data_ini 
private date ki_data_fin 

private st_tab_listino kist_tab_listino_open
end variables

forward prototypes
private subroutine pulizia_righe ()
protected function string aggiorna ()
protected subroutine inizializza_1 ()
protected function integer cancella ()
protected function string check_dati ()
private subroutine riempi_id ()
protected function string inizializza ()
protected function integer inserisci ()
protected subroutine inizializza_2 () throws uo_exception
protected subroutine attiva_menu ()
protected subroutine smista_funz (string k_par_in)
private subroutine call_elenco_mandanti ()
protected subroutine set_tab_listino (ref st_tab_listino kst_tab_listino)
public subroutine leggi_dwc ()
public subroutine riempi_video_contratto (st_tab_contratti k_st_tab_contratti)
private subroutine put_video_pregruppi (st_tab_listino_pregruppi_voci ast_tab_listino_pregruppi_voci)
protected subroutine open_start_window ()
protected subroutine inizializza_4 () throws uo_exception
public subroutine proteggi_campi ()
protected function boolean dati_modif_1 ()
private subroutine put_video_retrieve_voci_prezzi ()
private subroutine put_video_voci_prezzi (st_tab_listino_prezzi ast_tab_listino_prezzi)
public function string u_get_dw_name_focus ()
public subroutine leggi_dwc_dw10 ()
private subroutine cambia_periodo_elenco ()
protected function boolean inserisci_dw10 ()
protected subroutine attiva_tasti_0 ()
public subroutine u_resize_1 ()
end prototypes

private subroutine pulizia_righe ();//
long k_riga
long k_nr_righe
string k_cod_art, k_id
long k_cod_cli
long k_ctr
st_tab_listino kst_tab_listino



//=== Toglie righe da non UPDATE
dati_modif_accept( )


//=== Pulisco eventuali righe rimaste vuote e aggiusto campi a NULL
k_riga = tab_1.tabpage_1.dw_1.rowcount ( )
if k_riga > 0 then
	
	if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) = newmodified! & 
				or tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) = new! then 
		k_ctr = 1
		
		k_id = tab_1.tabpage_1.dw_1.Describe("cod_cli.TabSequence") 
		if isnumber(k_id) then
			if long(k_id) > 0 then
				k_cod_cli = tab_1.tabpage_1.dw_1.getitemnumber(k_ctr, "cod_cli") 
				if isnull(k_cod_cli) or k_cod_cli = 0 then
					tab_1.tabpage_1.dw_1.deleterow(k_ctr)
				end if
			end if
		end if

		k_riga = tab_1.tabpage_1.dw_1.rowcount ( )
		if k_riga > 0 then
			k_id = tab_1.tabpage_1.dw_1.Describe("cod_art.TabSequence") 
			if isnumber(k_id) then
				if long(k_id) > 0 then
					k_cod_art = tab_1.tabpage_1.dw_1.getitemstring(k_ctr, "cod_art") 
					if isnull(k_cod_art) or LenA(trim(k_cod_art)) = 0 then
						tab_1.tabpage_1.dw_1.deleterow(k_ctr)
					end if
				end if
			end if
		end if
	end if
end if

k_riga = tab_1.tabpage_1.dw_1.rowcount ( )
if k_riga > 0 then
	set_tab_listino(kst_tab_listino)
	kiuf_listino.if_isnull( kst_tab_listino)
end if




//=== Pulizia dei rek non validi sui vari TAB
	k_nr_righe = tab_1.tabpage_2.dw_2.rowcount()
	for k_riga = k_nr_righe to 1 step -1

		if tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, "id_listino_link_pregruppo") > 0 then
		else
			if tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, "id_listino_pregruppo") > 0 then
			else

				if tab_1.tabpage_2.dw_2.getrow() = 0  then // riposizione il fuoco
					if tab_1.tabpage_2.dw_2.rowcount() = 1 then
						tab_1.tabpage_2.dw_2.setrow(1) 
					else
						tab_1.tabpage_2.dw_2.setrow(tab_1.tabpage_2.dw_2.rowcount() - 1) 
					end if
				end if
				tab_1.tabpage_2.dw_2.deleterow(k_riga)

			end if
		end if
		
	next

	k_nr_righe = tab_1.tabpage_2.dw_10.rowcount()
	for k_riga = k_nr_righe to 1 step -1

		if tab_1.tabpage_2.dw_10.getitemnumber ( k_riga, "id_listino_link_pregruppo") > 0 then
		else
			if tab_1.tabpage_2.dw_10.getitemnumber ( k_riga, "id_listino_voce") > 0  then
			else
				if k_riga = tab_1.tabpage_2.dw_10.getrow() and k_riga > 1 then tab_1.tabpage_2.dw_10.setrow(k_riga - 1)  // riposizione il fuoco
				tab_1.tabpage_2.dw_10.deleterow(k_riga)

			end if
		end if
		
	next



k_ctr = tab_1.tabpage_3.dw_3.rowcount ( )
for k_riga = k_ctr to 1 step -1

//	if tab_1.tabpage_3.dw_3.getitemstatus(k_ctr, 0, primary!) = newmodified! then 
		if (len(trim(tab_1.tabpage_3.dw_3.getitemstring( k_riga, "ipotesi_1"))) = 0 or isnull(tab_1.tabpage_3.dw_3.getitemstring( k_riga, "valore_1")) ) &
			   and (len(trim(tab_1.tabpage_3.dw_3.getitemstring( k_riga, "ipotesi_2"))) = 0 or isnull(tab_1.tabpage_3.dw_3.getitemstring( k_riga, "valore_2")) ) &
			   and (len(trim(tab_1.tabpage_3.dw_3.getitemstring( k_riga, "ipotesi_3"))) = 0 or isnull(tab_1.tabpage_3.dw_3.getitemstring( k_riga, "valore_3")) ) &
			then
			tab_1.tabpage_3.dw_3.deleterow(k_riga)
			tab_1.tabpage_3.dw_3.SetItemStatus( k_riga, 0, Delete!, NotModified!)
		else
			if (len(trim(tab_1.tabpage_3.dw_3.getitemstring( k_riga, "ipotesi_1"))) = 0 or isnull(tab_1.tabpage_3.dw_3.getitemstring( k_riga, "valore_1")) ) &
					or trim(tab_1.tabpage_3.dw_3.getitemstring( k_riga, "valore_1")) = "0" or len(trim(tab_1.tabpage_3.dw_3.getitemstring( k_riga, "valore_1"))) = 0 then
				tab_1.tabpage_3.dw_3.setitem( k_riga, "ipotesi_1", "") 
				tab_1.tabpage_3.dw_3.setitem( k_riga, "valore_1", "") 
				tab_1.tabpage_3.dw_3.SetItemStatus( k_riga, "ipotesi_1", Primary!, NotModified!)
				tab_1.tabpage_3.dw_3.SetItemStatus( k_riga, "valore_1", Primary!, NotModified!)
			end if
			if (len(trim(tab_1.tabpage_3.dw_3.getitemstring( k_riga, "ipotesi_2"))) = 0 or isnull(tab_1.tabpage_3.dw_3.getitemstring( k_riga, "valore_2")) ) &
					or trim(tab_1.tabpage_3.dw_3.getitemstring( k_riga, "valore_2")) = "0" or len(trim(tab_1.tabpage_3.dw_3.getitemstring( k_riga, "valore_2"))) = 0 then
				tab_1.tabpage_3.dw_3.setitem( k_riga, "ipotesi_2", "") 
				tab_1.tabpage_3.dw_3.setitem( k_riga, "valore_2", "") 
				tab_1.tabpage_3.dw_3.SetItemStatus( k_riga, "ipotesi_2", Primary!, NotModified!)
				tab_1.tabpage_3.dw_3.SetItemStatus( k_riga, "valore_2", Primary!, NotModified!)
			end if
			if (len(trim(tab_1.tabpage_3.dw_3.getitemstring( k_riga, "ipotesi_3"))) = 0 or isnull(tab_1.tabpage_3.dw_3.getitemstring( k_riga, "valore_3")) ) & 
					or trim(tab_1.tabpage_3.dw_3.getitemstring( k_riga, "valore_3")) = "0" or len(trim(tab_1.tabpage_3.dw_3.getitemstring( k_riga, "valore_3"))) = 0 then
				tab_1.tabpage_3.dw_3.setitem( k_riga, "ipotesi_3", "") 
				tab_1.tabpage_3.dw_3.setitem( k_riga, "valore_3", "") 
				tab_1.tabpage_3.dw_3.SetItemStatus( k_riga, "ipotesi_3", Primary!, NotModified!)
				tab_1.tabpage_3.dw_3.SetItemStatus( k_riga, "valore_3", Primary!, NotModified!)
			end if
		end if
//	end if
next




end subroutine

protected function string aggiorna ();//
//======================================================================
//=== Aggiorna tabelle 
//=== Ritorna 1 chr : 0=tutto OK; 1=errore grave I-O;
//=== 				  : 2=
//===					  : 3=Commit fallita
//===		dal char 2 in poi spiegazione dell'errore
//======================================================================

string k_return="0 ", k_errore="0 ", k_errore1="0 "
st_tab_listino kst_tab_listino, kst_tab_listino_parent
boolean k_new_rec
st_esito kst_esito


choose case tab_1.selectedtab 

	case 1, 2 

		//=== Aggiorna, se modificato, la TAB_1	
		if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0 then
		
//--- imposto dati utente e data aggiornamento
			tab_1.tabpage_1.dw_1.setitem(1, "x_datins", kGuf_data_base.prendi_x_datins())
			tab_1.tabpage_1.dw_1.setitem(1, "x_utente", kGuf_data_base.prendi_x_utente())

			if tab_1.tabpage_1.dw_1.GetItemStatus(1, 0,  primary!) = NewModified!	then
				k_new_rec = true
			else
				k_new_rec = false
			end if

			if tab_1.tabpage_1.dw_1.update() = 1 then 
		
//--- Se tutto OK faccio la COMMIT		
				kst_esito = kguo_sqlca_db_magazzino.db_commit()
				if kst_esito.esito = kkg_esito.db_ko then
					k_return = "3" + "Archivio " + tab_1.tabpage_1.text + " " + kst_esito.sqlerrtext
				else // Tutti i Dati Caricati in Archivio
					k_return ="0 "

//--- Se nuova riga Imposto il campo Contatore ID (SERIAL)				
					if k_new_rec then
						kiuf_listino.get_ultimo_id(kst_tab_listino)
						tab_1.tabpage_1.dw_1.setitem(1, "id", kst_tab_listino.id)
						tab_1.tabpage_1.dw_1.resetupdate( )
					else
//--- Disattiva eventuale Listino da cui era stato duplicato						
						if tab_1.tabpage_1.dw_1.getitemstring(1, "attivo") = "S" then
							kst_tab_listino_parent.id = tab_1.tabpage_1.dw_1.getitemnumber(1, "listino_id_parent")
							if kst_tab_listino_parent.id > 0 then
								try
									kst_tab_listino_parent.attivo = kiuf_listino.get_attivo(kst_tab_listino_parent)
									if kst_tab_listino_parent.attivo = kiuf_listino.kki_attivo_si then
										kiuf_listino.set_stato_non_attivo(kst_tab_listino_parent)
										kguo_exception.inizializza( )
										kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_ok )
										kguo_exception.messaggio_utente( "Listino Disattivato", "Attenzione, il Listino di duplica (id " + string(kst_tab_listino_parent.id) + ") non può più essere utilizzato. " )
									end if
								catch (uo_exception kuo_exception) 
									kuo_exception.messaggio_utente()
								end try
							end if
						end if
					end if

				end if
				
			else
				kst_esito = kguo_sqlca_db_magazzino.db_rollback()
				k_return="1Fallito aggiornamento archivio '" + tab_1.tabpage_1.text + "' ~n~r" 
			end if
		end if

//--- Aggiorna, se modificato, la TAB_2 LINK GRUPPI-VOCI
		if left(k_return,1) = "0" and tab_1.tabpage_2.dw_2.getnextmodified(0, primary!) > 0 	then
		
			if tab_1.tabpage_2.dw_2.update() = 1 then

//--- Se tutto OK faccio la COMMIT		
				kst_esito = kguo_sqlca_db_magazzino.db_commit()
				if kst_esito.esito = kkg_esito.db_ko then
					k_return = "3" + "Archivio " + tab_1.tabpage_2.text + " " + kst_esito.sqlerrtext + " (GRUPPI) "
				else // Tutti i Dati Caricati in Archivio
					k_return ="0 "
				end if
			else
				kst_esito = kguo_sqlca_db_magazzino.db_rollback()
				k_return="1Fallito aggiornamento archivio '" + tab_1.tabpage_2.text + " (GRUPPI) " + "' ~n~r" 
			end if	
		end if

//--- Aggiorna, se modificato, la TAB_2 PREZZI
		if left(k_return,1) = "0" and tab_1.tabpage_2.dw_10.getnextmodified(0, primary!) > 0 	then
		
			if tab_1.tabpage_2.dw_10.update() = 1 then

//--- Se tutto OK faccio la COMMIT		
				kst_esito = kguo_sqlca_db_magazzino.db_commit()
				if kst_esito.esito = kkg_esito.db_ko then
					k_return = "3" + "Archivio " + tab_1.tabpage_2.text + " " + kst_esito.sqlerrtext + " (PREZZI) "
				else // Tutti i Dati Caricati in Archivio
					k_return ="0 "
				end if
			else
				kst_esito = kguo_sqlca_db_magazzino.db_rollback()
				k_return="1Fallito aggiornamento archivio '" + tab_1.tabpage_2.text + " (PREZZI) " + "' ~n~r" 
			end if	
		end if
		
	case 3  // CONDIZIONI 
		
		//=== Aggiorna, se modificato, la TAB_3	
		if tab_1.tabpage_3.dw_3.getnextmodified(0, primary!) > 0 OR &
			tab_1.tabpage_3.dw_3.getnextmodified(0, delete!) > 0 & 
			then
		
			if tab_1.tabpage_3.dw_3.update() = 1 then
		
//--- Se tutto OK faccio la COMMIT		
				kst_esito = kguo_sqlca_db_magazzino.db_commit()
				if kst_esito.esito = kkg_esito.db_ko then
					k_return = "3" + "Archivio " + tab_1.tabpage_3.text + " " + kst_esito.sqlerrtext
				else // Tutti i Dati Caricati in Archivio
					k_return ="0 "
				end if
			else
				kst_esito = kguo_sqlca_db_magazzino.db_rollback()
				k_return="1Fallito aggiornamento archivio '" + tab_1.tabpage_3.text + "' ~n~r" 
			end if	
		end if
		
end choose

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

protected subroutine inizializza_1 ();//---------------------------------------------------------------------=
//--- Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//---------------------------------------------------------------------=
//
long k_id_listino, k_rc
string k_codice_attuale, k_codice_prec, k_string
int k_ctr=0
kuf_utility kuf1_utility


ki_selectedtab = 2

k_id_listino = tab_1.tabpage_1.dw_1.getitemnumber(1, "id")  

if k_id_listino > 0 then

//--- attiva DWC
	leggi_dwc( )
	

//--- Acchiappo il id_listino x evitare la rilettura
	if IsNumber(trim(tab_1.tabpage_2.st_2_retrieve.Text)) then
		k_codice_prec = trim(tab_1.tabpage_2.st_2_retrieve.Text)
	else
		k_codice_prec = " "
	end if

	k_codice_attuale = string(k_id_listino) 
	
//--- Forza valore Codice composto per ricordarlo per le prossime richieste
	tab_1.tabpage_2.st_2_retrieve.text = k_codice_attuale

	if k_codice_attuale <> k_codice_prec then
		tab_1.tabpage_2.dw_2.retrieve(k_id_listino)
	end if

//--- metto ID in testata
	if tab_1.tabpage_2.dw_2.rowcount( )  > 0 then
		k_string = "id_listino_testa.Expression='~"" + string(tab_1.tabpage_1.dw_1.getitemnumber(1,"id") ) + " ~" ' "
		tab_1.tabpage_2.dw_2.modify(k_string)
	end if  

	attiva_tasti()

end if

//--- Inabilita campi alla modifica se Visualizzazione
kuf1_utility = create kuf_utility 
if tab_1.tabpage_2.dw_2.ki_flag_modalita = kkg_flag_modalita.visualizzazione then 
	kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_2.dw_2)
	kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_2.dw_10)
else
	kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_2.dw_2)
	kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_2.dw_10)
end if
destroy kuf1_utility

attiva_tasti()


tab_1.tabpage_2.dw_10.setfocus()



	


end subroutine

protected function integer cancella ();//
//=== Cancellazione rekord dal DB
//=== Ritorna : 0=OK 1=KO 2=non eseguita
//
int k_return=0
string k_errore = "0 ", k_errore1 = "0 "
long k_riga
string k_desc, k_record, k_record_1
long k_key = 0, k_id_listino_pregruppo=0, k_id_listino_link_pregruppo=0,k_id_listino_voce=0
string k_listino_pregruppo_descr, k_dataobject
kuf_listino  kuf1_listino
kuf_listino_link_pregruppi kuf1_listino_link_pregruppi
kuf_listino_prezzi kuf1_listino_prezzi
st_tab_listino kst_tab_listino
st_tab_cond_fatt kst_tab_cond_fatt
st_tab_listino_link_pregruppi kst_tab_listino_link_pregruppi
st_tab_listino_prezzi kst_tab_listino_prezzi
st_esito kst_esito


//=== 
choose case tab_1.selectedtab 
	case 1 

		//=== Controllo se sul dettaglio c'e' qualche cosa
		k_riga = tab_1.tabpage_1.dw_1.rowcount()	
		if k_riga > 0 then
			kst_tab_listino.id = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id")
			kst_tab_listino.cod_cli = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "cod_cli")
			kst_tab_listino.cod_art = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "cod_art")
			kst_tab_listino.dose = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "dose")
			kst_tab_listino.mis_x = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "mis_x")
			kst_tab_listino.mis_y = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "mis_y")
			kst_tab_listino.mis_z = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "mis_z")
		
		end if
		
		if k_riga > 0 and kst_tab_listino.id > 0 then	
			if isnull(kst_tab_listino.cod_art) = true or trim(kst_tab_listino.cod_art) = "" then
				kst_tab_listino.cod_art = "Prezzo Listino senza Articolo" 
			end if
			
		//=== Richiesta di conferma della eliminazione del rek
		
			if messagebox("Elimina il Prezzo Listino  "+string(kst_tab_listino.id, "####0"), "Sei sicuro di voler Cancellare: ~n~r" + &
						string(kst_tab_listino.cod_cli, "####0") + "  Articolo: " + trim(kst_tab_listino.cod_art) &
						+ "  Id:" + string(kst_tab_listino.id, "####0"), &
						question!, yesno!, 2) = 1 then
		 
		//=== Creo l'oggetto che ha la funzione x cancellare la tabella
				kuf1_listino = create kuf_listino
				
				try
					
		//=== Cancella la riga dal data windows di lista
					k_errore = kuf1_listino.tb_delete( kst_tab_listino ) 
					if LeftA(k_errore, 1) = "0" then
			
						k_errore = kGuf_data_base.db_commit()
						if LeftA(k_errore, 1) <> "0" then
							messagebox("Problemi durante la Cancellazione !!", &
									"Controllare i dati. " + MidA(k_errore, 2))
			
						else
							
							tab_1.tabpage_1.dw_1.deleterow(k_riga)
			
						end if
			
						tab_1.tabpage_1.dw_1.setfocus()
			
					else
						k_errore1 = k_errore
						k_errore = kGuf_data_base.db_rollback()
			
						messagebox("Problemi durante Cancellazione - Operazione fallita !!", &
										MidA(k_errore1, 2) ) 	
						if LeftA(k_errore, 1) <> "0" then
							messagebox("Problemi durante il recupero dell'errore !!", &
								"Controllare i dati. " + MidA(k_errore, 2))
						end if
				
			
					end if
		
			
				catch (uo_exception kuo3_exception)
					kst_esito = kuo3_exception.get_st_esito()
					k_errore = "1" + kst_esito.sqlerrtext
					kuo3_exception.messaggio_utente()
					
					
				end try
				
		//=== Distruggo l'oggetto che ha avuto la funzione x cancellare la tabella
				destroy kuf1_listino
		
			else
				messagebox("Elimina Prezzo Listino", "Operazione Annullata !!")
			end if
		
			tab_1.tabpage_1.dw_1.setcolumn(1)
		
		end if

//--- Prezzi
	case 2
		k_record = "  "
		
		k_dataobject = u_get_dw_name_focus()  // recupera il nome del dw su cui ho il fuoco
		
		choose case k_dataobject

			case "d_listino_voci_prezzi_l_2" 
				k_riga = tab_1.tabpage_2.dw_10.getrow()	
				if k_riga > 0 then
					if tab_1.tabpage_2.dw_10.getitemnumber(k_riga, "id_listino_prezzo") > 0 then
						if tab_1.tabpage_2.dw_10.getitemstatus(k_riga, 0, primary!) <> new! and &
									tab_1.tabpage_2.dw_10.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
							k_key = tab_1.tabpage_2.dw_10.getitemnumber(k_riga, "id_listino_prezzo")
							k_id_listino_link_pregruppo = tab_1.tabpage_2.dw_10.getitemnumber(k_riga, "id_listino_link_pregruppo")
							k_id_listino_voce = tab_1.tabpage_2.dw_10.getitemnumber(k_riga, "id_listino_voce")
							k_listino_pregruppo_descr = tab_1.tabpage_2.dw_10.getitemstring(k_riga, "listino_voci_descr")
							k_record_1 = "Sei sicuro di voler rimuovere da questo Listino la VOCE ~n~r" &
								+ " " + string(k_id_listino_voce) + "  " + trim(k_listino_pregruppo_descr) + ".  )" &
								+ "  ID: " + string(k_key) 
	//--- Richiesta di conferma della eliminazione del rek
							if messagebox("Elimina" + k_record, k_record_1, question!, yesno!, 2) = 1 then
								try
			//--- Rimozione in tab
									kuf1_listino_prezzi = create kuf_listino_prezzi
									kst_tab_listino_prezzi.id_listino_prezzo = k_key
									kuf1_listino_prezzi.tb_delete(kst_tab_listino_prezzi) 
					
								catch (uo_exception kuo2_exception)
									kst_esito = kuo2_exception.get_st_esito()
									if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.db_wrn then
										if kst_esito.sqlcode > 0 then
											k_errore = "1" + trim(kst_esito.sqlerrtext) + "~n~rCodice errore: " + string(kst_esito.sqlcode)
										else
											k_errore = "1" + trim(kst_esito.sqlerrtext) 
										end if
									end if
						
								end try
					
								if left(k_errore, 1) = "0" then
									kst_esito = kguo_sqlca_db_magazzino.db_commit()
									if kst_esito.esito <> kkg_esito.ok then
										k_return = 1
										messagebox("Problemi durante la Cancellazione !!", "Controllare i dati. " + trim(kst_esito.sqlerrtext))
									else
										tab_1.tabpage_2.dw_10.deleterow(k_riga)
									end if
								else
									k_return = 1
									kst_esito = kguo_sqlca_db_magazzino.db_rollback()
									messagebox("Problemi durante Cancellazione - Operazione fallita !!", mid(k_errore, 2) ) 	
									if kst_esito.esito <> kkg_esito.ok then
										messagebox("Problemi durante il recupero dell'errore !!", "Controllare i dati. " + trim(kst_esito.sqlerrtext))
									end if
									attiva_tasti()
								end if
							else
								messagebox("Elimina" + k_record,  "Operazione Annullata !!")
								k_return = 2
							end if
						else
							tab_1.tabpage_2.dw_10.deleterow(k_riga)
						end if
					else
						tab_1.tabpage_2.dw_10.deleterow(k_riga)
					end if
				end if
				
			case else
				k_riga = tab_1.tabpage_2.dw_2.getrow()	
				if k_riga > 0 then
					if tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id_listino_link_pregruppo") > 0 then 
						if tab_1.tabpage_2.dw_2.getitemstatus(k_riga, 0, primary!) <> new! and &
										tab_1.tabpage_2.dw_2.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
							k_id_listino_link_pregruppo = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id_listino_link_pregruppo")
							k_id_listino_pregruppo = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id_listino_pregruppo")
							k_listino_pregruppo_descr = tab_1.tabpage_2.dw_2.getitemstring(k_riga, "listino_pregruppo_descr")
							k_record_1 = "Sei sicuro di voler rimuovere tutte le voci del Gruppo ~n~r" &
								+ " ID " + trim(string(k_id_listino_link_pregruppo)) &
								 + ". Gruppo: "+ trim(string(k_id_listino_pregruppo)) + " " &
								+ trim(k_listino_pregruppo_descr) + ", da questo Listino ?"
	//--- Richiesta di conferma della eliminazione del rek
							if messagebox("Elimina" + k_record, k_record_1, question!, yesno!, 2) = 1 then
								try
			//--- Rimozione in tab
									kuf1_listino_link_pregruppi = create kuf_listino_link_pregruppi
									kst_tab_listino_link_pregruppi.id_listino_link_pregruppo = k_id_listino_link_pregruppo
									kuf1_listino_link_pregruppi.tb_delete(kst_tab_listino_link_pregruppi) 
					
								catch (uo_exception kuo_exception)
									kst_esito = kuo_exception.get_st_esito()
									if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.db_wrn then
										if kst_esito.sqlcode > 0 then
											k_errore = "1" + trim(kst_esito.sqlerrtext) + "~n~rCodice errore: " + string(kst_esito.sqlcode)
										else
											k_errore = "1" + trim(kst_esito.sqlerrtext) 
										end if
									end if
						
								end try
					
								if left(k_errore, 1) = "0" then
									kst_esito = kguo_sqlca_db_magazzino.db_commit()
									if kst_esito.esito <> kkg_esito.ok then
										k_return = 1
										messagebox("Problemi durante la Cancellazione !!", "Controllare i dati. " + trim(kst_esito.sqlerrtext))
									else
										tab_1.tabpage_2.dw_2.deleterow(k_riga)
									end if
								else
									k_return = 1
									kst_esito = kguo_sqlca_db_magazzino.db_rollback()
									messagebox("Problemi durante Cancellazione - Operazione fallita !!", mid(k_errore, 2) ) 	
									if kst_esito.esito <> kkg_esito.ok then
										messagebox("Problemi durante il recupero dell'errore !!", "Controllare i dati. " + trim(kst_esito.sqlerrtext))
									end if
									attiva_tasti()
								end if
							else
								messagebox("Elimina" + k_record,  "Operazione Annullata !!")
								k_return = 2
							end if
						else
							tab_1.tabpage_2.dw_2.deleterow(k_riga)
						end if
					else
						tab_1.tabpage_2.dw_2.deleterow(k_riga)
					end if
				end if
		end choose


//--- Cancella la Condizione
	case 3 
		//=== Controllo se sul dettaglio c'e' qualche cosa
		k_riga = tab_1.tabpage_3.dw_3.rowcount()	
		if k_riga > 0 then
			kst_tab_cond_fatt.id = tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "id")
				
			if kst_tab_cond_fatt.id > 0 then
				
				kuf1_listino = create kuf_listino

				kst_esito = kuf1_listino.tb_delete( kst_tab_cond_fatt ) 
				if kst_esito.esito = kkg_esito.ok then
					tab_1.tabpage_3.dw_3.deleterow(k_riga)
				else
					k_errore1 = k_errore
		
					messagebox("Problemi durante Cancellazione - Operazione fallita !!", &
									trim(kst_esito.sqlerrtext ) ) 	
				end if
		
		//=== Distruggo l'oggetto che ha avuto la funzione x cancellare la tabella
				
				destroy kuf1_listino
				
			else
				tab_1.tabpage_3.dw_3.deleterow(k_riga)

			end if
		end if
		tab_1.tabpage_3.dw_3.setfocus()

end choose	


choose case tab_1.selectedtab 
	case 1 
		tab_1.tabpage_1.dw_1.setfocus()
		tab_1.tabpage_1.dw_1.setcolumn(1)
	case 2
		choose case k_dataobject
			case "d_listino_link_pregruppi_l" 
				tab_1.tabpage_2.dw_2.setfocus()
				tab_1.tabpage_2.dw_2.setcolumn(1)
				tab_1.tabpage_2.dw_2.ResetUpdate ( ) 
			case "d_listino_voci_prezzi_l_2" 
				tab_1.tabpage_2.dw_10.setfocus()
				tab_1.tabpage_2.dw_10.setcolumn(1)
				tab_1.tabpage_2.dw_10.ResetUpdate ( ) 
		end choose
	case 3
		tab_1.tabpage_3.dw_3.setfocus()
		tab_1.tabpage_3.dw_3.setcolumn(1)
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
	kds_inp.dataobject = tab_1.tabpage_1.dw_1.dataobject
	tab_1.tabpage_1.dw_1.rowscopy( 1,tab_1.tabpage_1.dw_1.rowcount( ) ,primary!, kds_inp, 1, primary!)
	kiuf_listino.u_check_dati(kds_inp)

//--- Controllo altro tab
	if  tab_1.tabpage_3.dw_3.enabled then
		kds_inp.dataobject = tab_1.tabpage_2.dw_2.dataobject
		tab_1.tabpage_3.dw_3.rowscopy( 1,tab_1.tabpage_3.dw_3.rowcount( ) ,primary!, kds_inp, 1, primary!)
		kst_esito = kiuf_listino.u_check_dati_cond_fatt(kds_inp)
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
long k_ctr = 0, k_riga, k_cond_priorita_max
st_tab_listino kst_tab_listino



	k_ctr = tab_1.tabpage_1.dw_1.getrow()
	
	if k_ctr > 0 then
	
		kst_tab_listino.id = tab_1.tabpage_1.dw_1.getitemnumber(k_ctr, "id")
	
//=== Se non sono in caricamento allora prelevo l'ID dalla dw
		if tab_1.tabpage_1.dw_1.getitemstatus(k_ctr, 0, primary!) <> newmodified! then
			kst_tab_listino.id = tab_1.tabpage_1.dw_1.getitemnumber(k_ctr, "id")
		end if
	
		if isnull(kst_tab_listino.id) or kst_tab_listino.id = 0 then				
			tab_1.tabpage_1.dw_1.setitem(k_ctr, "id", 0)
		end if

//--- il secondo TAB (Prezzi)
		if isnull(kst_tab_listino.id) or kst_tab_listino.id = 0 then				
			tab_1.tabpage_1.dw_1.setitem(k_ctr, "id", 0)
		else
			k_cond_priorita_max = 0
			for k_ctr = 1 to tab_1.tabpage_2.dw_2.rowcount()
		
				if tab_1.tabpage_2.dw_2.getitemnumber(k_ctr, "id_listino_link_pregruppo") > 0 then
				else
					tab_1.tabpage_2.dw_2.setitem(k_ctr, "id_listino_link_pregruppo", 0)
				end if
				if tab_1.tabpage_2.dw_2.getitemnumber(k_ctr, "cond_priorita") > k_cond_priorita_max then
					k_cond_priorita_max = tab_1.tabpage_2.dw_2.getitemnumber(k_ctr, "cond_priorita")
				end if
	
				tab_1.tabpage_2.dw_2.setitem(k_ctr, "id_listino", kst_tab_listino.id)
				
				if tab_1.tabpage_2.dw_2.GetItemStatus(k_ctr,0, primary!) = NewModified! &
						or tab_1.tabpage_2.dw_2.GetItemStatus(k_ctr,0, primary!) = DataModified! then
					tab_1.tabpage_2.dw_2.setitem(k_ctr, "x_datins", kGuf_data_base.prendi_x_datins())
					tab_1.tabpage_2.dw_2.setitem(k_ctr, "x_utente", kGuf_data_base.prendi_x_utente())
				end if
						
			end for
//--- se ho trovato almeno una Priorita', tutte quelle a ZERO le pongo dopo questa			
			if k_cond_priorita_max > 0 then 
				k_cond_priorita_max ++
				for k_ctr = 1 to tab_1.tabpage_2.dw_2.rowcount()
					if tab_1.tabpage_2.dw_2.getitemnumber(k_ctr, "cond_priorita") > 0 then
					else
						tab_1.tabpage_2.dw_2.setitem(k_ctr, "cond_priorita", k_cond_priorita_max)
					end if
				end for
			end if
			
//--- dw con le VOCI- PREZZI			
			for k_ctr = 1 to tab_1.tabpage_2.dw_10.rowcount()
		
				if tab_1.tabpage_2.dw_10.getitemnumber(k_ctr, "id_listino_prezzo") > 0 then
				else
					tab_1.tabpage_2.dw_10.setitem(k_ctr, "id_listino_prezzo", 0)
				end if
	
				if tab_1.tabpage_2.dw_10.GetItemStatus(k_ctr,0, primary!) = NewModified! &
						or tab_1.tabpage_2.dw_10.GetItemStatus(k_ctr,0, primary!) = DataModified! then
					tab_1.tabpage_2.dw_10.setitem(k_ctr, "x_datins", kGuf_data_base.prendi_x_datins())
					tab_1.tabpage_2.dw_10.setitem(k_ctr, "x_utente", kGuf_data_base.prendi_x_utente())
				end if
						
			end for
			
		end if
		
//--- terzo TAB (condizioni)		
		for k_riga = 1 to tab_1.tabpage_3.dw_3.rowcount()
			if len(tab_1.tabpage_3.dw_3.getitemstring( k_riga, "ipotesi_1")) > 0 and len(trim(tab_1.tabpage_3.dw_3.getitemstring( k_riga, "valore_1"))) > 0 then
				if len(trim( tab_1.tabpage_3.dw_3.getitemstring( k_riga, "segno_1"))) = 0 or isnull( tab_1.tabpage_3.dw_3.getitemstring( k_riga, "segno_1")) then
					tab_1.tabpage_3.dw_3.setitem( k_riga, "segno_1","=")
				end if
			else
				tab_1.tabpage_3.dw_3.setitem( k_riga, "ipotesi_1"," ")
				tab_1.tabpage_3.dw_3.setitem( k_riga, "valore_1"," ")
				tab_1.tabpage_3.dw_3.setitem( k_riga, "segno_1"," ")
			end if
			if len(tab_1.tabpage_3.dw_3.getitemstring( k_riga, "ipotesi_2")) > 0 and len(trim(tab_1.tabpage_3.dw_3.getitemstring( k_riga, "valore_1"))) > 0 then
				if len(trim( tab_1.tabpage_3.dw_3.getitemstring( k_riga, "segno_2"))) = 0 or isnull( tab_1.tabpage_3.dw_3.getitemstring( k_riga, "segno_1")) then
					tab_1.tabpage_3.dw_3.setitem( k_riga, "segno_2","=")
				end if
			else
				tab_1.tabpage_3.dw_3.setitem( k_riga, "ipotesi_2"," ")
				tab_1.tabpage_3.dw_3.setitem( k_riga, "valore_2"," ")
				tab_1.tabpage_3.dw_3.setitem( k_riga, "segno_2"," ")
			end if
			if len(tab_1.tabpage_3.dw_3.getitemstring( k_riga, "ipotesi_3")) > 0 and len(trim(tab_1.tabpage_3.dw_3.getitemstring( k_riga, "valore_1"))) > 0 then
				if len(trim( tab_1.tabpage_3.dw_3.getitemstring( k_riga, "segno_3"))) = 0 or isnull( tab_1.tabpage_3.dw_3.getitemstring( k_riga, "segno_1")) then
					tab_1.tabpage_3.dw_3.setitem( k_riga, "segno_3","=")
				end if
			else
				tab_1.tabpage_3.dw_3.setitem( k_riga, "ipotesi_3"," ")
				tab_1.tabpage_3.dw_3.setitem( k_riga, "valore_3"," ")
				tab_1.tabpage_3.dw_3.setitem( k_riga, "segno_3"," ")
			end if
		end for

		
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
st_tab_contratti kst_tab_contratti
st_tab_prodotti kst_tab_prodotti
st_esito kst_esito
kuf_prodotti kuf1_prodotti
datawindowchild  kdwc_contratto
datawindowchild  kdwc_articoli , kdwc_articoli_des
pointer oldpointer  // Declares a pointer variable


ki_selectedtab = 1

if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


//--- resetto i campi che servono alla retrieve delle childdw
	ki_cod_cli = 0
	ki_cod_art = " "
	ki_sl_pt = " "



//--- Se inserimento.... 
   if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento then
		inserisci()
	else
//--- Se NO inserimento.... 
		k_rc = tab_1.tabpage_1.dw_1.retrieve( kist_tab_listino_open.id ) 
		
		choose case k_rc

			case is < 0				
				messagebox("Operazione fallita", &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(ID Listino cercato :" + trim(string(kist_tab_listino_open.id)) + ")~n~r" )
				cb_ritorna.postevent(clicked!)

			case 0
	
				tab_1.tabpage_1.dw_1.reset()
				attiva_tasti()

				messagebox("Ricerca fallita", &
						"Mi spiace, il codice Listino non e' in archivio ~n~r" + &
					"(Listino cercato :" + &
					"cliente " + trim(string(kist_tab_listino_open.cod_cli)) + ", articolo " + trim(kist_tab_listino_open.cod_art) + ", ID " + trim(string(kist_tab_listino_open.id)) + &
					")~n~r" )

				cb_ritorna.triggerevent("clicked!")

			case is > 0		
				attiva_tasti()
		
		end choose

	end if

//--- se inserimento inabilito gli altri TAB, sono inutili
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
	
//	tab_1.tabpage_2.enabled = false
		tab_1.tabpage_3.enabled = false
		tab_1.tabpage_4.enabled = false
		tab_1.tabpage_5.enabled = false
		tab_1.tabpage_1.dw_1.setcolumn(1)
		tab_1.tabpage_1.dw_1.setfocus()
	else
		
		if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
			if ki_cambio_stato_listino_autorizzato then
				tab_1.tabpage_1.dw_1.setcolumn("attivo")
			else
				tab_1.tabpage_1.dw_1.setcolumn("contratto")
			end if
			tab_1.tabpage_1.dw_1.setfocus()
		end if
	end if

//--- se Ins o Modifica faccio puntatore manina sul '%'	
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
		tab_1.tabpage_1.dw_1.modify("occup_ped_perc_t.pointer = 'HyperLink!'")
	else
		tab_1.tabpage_1.dw_1.modify("occup_ped_perc_t.pointer = '' ")
	end if
	
	kiuf_listino.autorizza_campi(tab_1.tabpage_1.dw_1)

//--- protegge i campi mappa
	proteggi_campi()

//--- leggo i vari DWC x i dati del listino
	if tab_1.tabpage_1.dw_1.getrow() > 0 then
		leggi_dwc( )
	end if	
	
end if


return k_return 

end function

protected function integer inserisci ();//
int k_return=1, k_ctr, k_rc
string k_errore="0 ", k_rcx
long k_riga, k_riga_new 
string k_record_base, k_dataobject
st_tab_listino kst_tab_listino
st_tab_clienti kst_tab_clienti
st_tab_listino_prezzi kst_tab_listino_prezzi
window kw_window
kuf_base kuf1_base
kuf_utility kuf1_utility
datawindowchild kdwc_cli, kdwc_clie_cod


//=== Aggiunge una riga al data windows
choose case ki_selectedtab
	case  1 


//--- Controllo se ho modificato i dati 
		if left(dati_modif(""), 1) = "1" then //Richisto Aggiornamento

//--- Controllo congruenza dei dati caricati e Aggiornamento  
//--- Ritorna 1 char : 0=tutto OK; 1=errore grave;
//---                : 2=errore non grave dati aggiornati;
//---			         : 3=LIBERO
//---      il resto della stringa contiene la descrizione dell'errore   
			k_errore = aggiorna_dati()

		end if

		if LeftA(k_errore, 1) = "0" then

////--- S-protezione campi per abilitare l'inserimento
//			kuf1_utility = create kuf_utility
//	     	kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)
//			destroy kuf1_utility

//			kw_window = kGuf_data_base.prendi_win_attiva()
//			kw_window.title = "Listino: Inserimento"
	
			kst_tab_listino.cod_cli = long(trim(ki_st_open_w.key2))
			kst_tab_listino.cod_art = trim(ki_st_open_w.key3)
			
			if tab_1.tabpage_1.dw_1.rowcount() > 0 then
				tab_1.tabpage_1.dw_1.reset() 
			end if
			
			tab_1.tabpage_1.dw_1.insertrow(0)
			
			tab_1.tabpage_1.dw_1.setcolumn(1)
			
			ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
			
//--- posiziono su riga cliente richiesto
			if kst_tab_listino.cod_cli > 0 then
				k_rc = tab_1.tabpage_1.dw_1.getchild("rag_soc_10", Kdwc_cli)
//--- legge dwc dei clienti
				if Kdwc_cli.rowcount() < 2 then
					Kdwc_cli.retrieve("%")
					k_rc = Kdwc_cli.insertrow(1)
					k_rc = tab_1.tabpage_1.dw_1.getchild("cod_clie", kdwc_clie_cod)
					Kdwc_cli.RowsCopy(Kdwc_cli.GetRow(), Kdwc_cli.RowCount(), Primary!, kdwc_clie_cod, 1, Primary!)
				end if	
				
				k_riga = kdwc_cli.find("id_cliente="+trim(string(kst_tab_listino.cod_cli, "####0")),0,kdwc_cli.rowcount())
				if k_riga > 0 then
					k_rc = tab_1.tabpage_1.dw_1.setitem(1, "rag_soc_10", kdwc_cli.getitemstring(k_riga, "rag_soc_1"))
				end if
			end if
				
			tab_1.tabpage_1.dw_1.setitem(1, "cod_cli", kst_tab_listino.cod_cli)
			tab_1.tabpage_1.dw_1.setitem(1, "cod_art", kst_tab_listino.cod_art)
			
			tab_1.tabpage_1.dw_1.setitem(1, "attivo", "D")
//			tab_1.tabpage_1.dw_1.setitem(1, "magazzino", 2)
			tab_1.tabpage_1.dw_1.setitem(1, "prezzo", 0)
			tab_1.tabpage_1.dw_1.setitem(1, "prezzo_2", 0)
			tab_1.tabpage_1.dw_1.setitem(1, "prezzo_3", 0)
			tab_1.tabpage_1.dw_1.setitem(1, "tipo", kiuf_listino.kki_tipo_prezzo_a_collo)
			tab_1.tabpage_1.dw_1.setitem(1, "attiva_listino_pregruppi", "N")

//--- Listino con Misure?
			k_rcx = tab_1.tabpage_1.dw_1.Describe("mis_x.TabSequence") 
			if isnumber(k_rcx) then
				if long(k_rcx) > 0 then
				
					kuf1_base = create kuf_base
					k_record_base = kuf1_base.prendi_dato_base ("mis_ped")
					destroy kuf_base
					if LeftA(k_record_base,1) = "0" then			
						tab_1.tabpage_1.dw_1.setitem(1, "mis_x", integer(trim(MidA(k_record_base, 2, 5)))) 		
						tab_1.tabpage_1.dw_1.setitem(1, "mis_y", integer(trim(MidA(k_record_base, 7, 5)))) 		
						tab_1.tabpage_1.dw_1.setitem(1, "mis_z", integer(trim(MidA(k_record_base, 12, 5)))) 		
						tab_1.tabpage_1.dw_1.setitem(1, "occup_ped", 100)
						
					end if
				else
					tab_1.tabpage_1.dw_1.setitem(1, "mis_x", 0) 		
					tab_1.tabpage_1.dw_1.setitem(1, "mis_y", 0) 		
					tab_1.tabpage_1.dw_1.setitem(1, "mis_z", 0) 		
					tab_1.tabpage_1.dw_1.setitem(1, "occup_ped", 0) 		
				end if
			end if
				
			tab_1.tabpage_1.dw_1.setfocus()
			tab_1.tabpage_1.dw_1.setcolumn(3)
		
//			tab_1.tabpage_1.dw_1.resetupdate( )
			tab_1.tabpage_1.dw_1.SetItemStatus( 1, 0, Primary!, NotModified!)
			
		end if
			
	case 2 // prezzi
		kst_tab_listino.id = tab_1.tabpage_1.dw_1.getitemnumber(1, "id")
		
		if kst_tab_listino.id > 0 then
			tab_1.tabpage_2.dw_2.ki_flag_modalita = kkg_flag_modalita.inserimento

			k_dataobject = u_get_dw_name_focus()  // recupera il nome del dw su cui ho il fuoco
			
			choose case k_dataobject
					
				case  tab_1.tabpage_2.dw_10.dataobject  // "d_listino_voci_prezzi_l_2" 

					inserisci_dw10( )
					
				case else 

//--- S-protezione campi per abilitare l'inserimento
					kuf1_utility = create kuf_utility
					kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_2.dw_2)
					destroy kuf1_utility
		
					k_riga = tab_1.tabpage_2.dw_2.insertrow(0)
					tab_1.tabpage_2.dw_10.reset( )	
					tab_1.tabpage_2.dw_2.setitem(k_riga, "id_listino", kst_tab_listino.id)
					tab_1.tabpage_2.dw_2.setitem(k_riga, "cond_priorita", 0)
					tab_1.tabpage_2.dw_2.setitem(k_riga, "id_cond_fatt", 0)
		
		
					tab_1.tabpage_2.dw_2.setcolumn("id_listino_pregruppo")
					tab_1.tabpage_2.dw_2.scrolltorow(k_riga)
					tab_1.tabpage_2.dw_2.setrow(k_riga)
					
					tab_1.tabpage_2.dw_2.SetItemStatus( k_riga, 0, Primary!, NotModified!)
			end choose
			leggi_dwc( )
		end if


	case 3 // Condizioni
		kst_tab_listino.cod_cli = tab_1.tabpage_1.dw_1.getitemnumber(1, "cod_cli")
		tab_1.tabpage_3.dw_3.ki_flag_modalita = kkg_flag_modalita.inserimento

//--- S-protezione campi per abilitare l'inserimento
		kuf1_utility = create kuf_utility
		kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_3.dw_3)
		destroy kuf1_utility

		if kst_tab_listino.cod_cli > 0 then
			kst_tab_clienti.rag_soc_10 = tab_1.tabpage_1.dw_1.getitemstring(1, "rag_soc_10")
		else
			kst_tab_listino.cod_cli = 0
			kst_tab_clienti.rag_soc_10 = " "
		end if
		k_riga = tab_1.tabpage_3.dw_3.insertrow(0)

		tab_1.tabpage_3.dw_3.setitem( k_riga, "id", 0 )
		tab_1.tabpage_3.dw_3.setitem( k_riga, "cod_cli", kst_tab_listino.cod_cli )
		tab_1.tabpage_3.dw_3.setitem( k_riga, "rag_soc_10", kst_tab_clienti.rag_soc_10 )

		tab_1.tabpage_3.dw_3.scrolltorow(k_riga)
		tab_1.tabpage_3.dw_3.setrow(k_riga)
		tab_1.tabpage_3.dw_3.setcolumn("ipotesi_1")
		
		tab_1.tabpage_3.dw_3.SetItemStatus( k_riga, 0, Primary!, NotModified!)

		leggi_dwc( )
			
			
	case 4 // Lista Entrate
			
	case 5 // Lista Fatture
			
end choose	


attiva_tasti()

k_return = 0


return (k_return)



end function

protected subroutine inizializza_2 () throws uo_exception;//
//======================================================================
//=== Inizializzazione del TAB 3 controllandone i valori se gia' presenti
//======================================================================
//
string k_scelta, k_codice_prec, k_codice_attuale
long  k_rc
st_tab_listino kst_tab_listino
kuf_utility kuf1_utility


ki_selectedtab = 3

kuf1_utility = create kuf_utility

kst_tab_listino.cod_cli = tab_1.tabpage_1.dw_1.getitemnumber(1, "cod_cli") //fatt

if kst_tab_listino.cod_cli > 0 then
	
//--- attiva DWC
	leggi_dwc( )
	

	//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
	if trim(tab_1.tabpage_3.st_3_retrieve.text) > " " then
		k_codice_prec = tab_1.tabpage_3.st_3_retrieve.text
	else
		k_codice_prec = " "
	end if

	k_codice_attuale = string(kst_tab_listino.cod_cli) 
	//=== Forza valore Codice composto per ricordarlo per le prossime richieste
	tab_1.tabpage_3.st_3_retrieve.text = k_codice_attuale

	if k_codice_attuale <> k_codice_prec then

		k_rc=tab_1.tabpage_3.dw_3.retrieve(  kst_tab_listino.cod_cli )

	end if				

end if

//--- Inabilita campi alla modifica se Visualizzazione
kuf1_utility = create kuf_utility 
if tab_1.tabpage_3.dw_3.ki_flag_modalita = kkg_flag_modalita.visualizzazione then 
	kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_3.dw_3)
else
		kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_3.dw_3)
end if
destroy kuf1_utility

attiva_tasti()

tab_1.tabpage_3.dw_3.setfocus()
	


end subroutine

protected subroutine attiva_menu ();//
//

//=== 

	ki_menu.m_strumenti.m_fin_gest_libero3.text = "Mandanti"
	ki_menu.m_strumenti.m_fin_gest_libero3.microhelp = "Elenco Mandanti per questo Cliente    "
	ki_menu.m_strumenti.m_fin_gest_libero3.visible = true
	choose case tab_1.selectedtab 
		case 3 
//		   if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento then
			ki_menu.m_strumenti.m_fin_gest_libero3.enabled = true
		case else
			ki_menu.m_strumenti.m_fin_gest_libero3.enabled = false
	end choose
	ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemVisible = true
	ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemText = 	"Elenco Mandanti per questo Cliente    "
	ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemName = "Insert!"
	ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritembarindex=2
	
	ki_menu.m_strumenti.m_fin_gest_libero1.text = "Cambia il periodo di estrazione scheda elenco Movimenti (data Lotto)"
	ki_menu.m_strumenti.m_fin_gest_libero1.microhelp =  "Cambia periodo di estrazione Movimenti"
	ki_menu.m_strumenti.m_fin_gest_libero1.visible = true
	ki_menu.m_strumenti.m_fin_gest_libero1.enabled = true
	ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
	ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText = "Periodo,"+ki_menu.m_strumenti.m_fin_gest_libero1.text
	ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName = "Custom015!"
	ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2

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


	case kkg_flag_richiesta.libero1	//cambia data di estrazione
		cambia_periodo_elenco()

	case kkg_flag_richiesta.libero3		//Elenco Mandanti
		call_elenco_mandanti()

	case else
		super::smista_funz(k_par_in)

end choose

end subroutine

private subroutine call_elenco_mandanti ();//
st_tab_listino kst_tab_listino
st_tab_cond_fatt kst_tab_cond_fatt
st_open_w kst_open_w 
kuf_clienti kuf1_clienti
pointer kp_oldpointer  // Declares a pointer variable


	kp_oldpointer = SetPointer(HourGlass!)

		//kuf_menu_window kuf1_menu_window
		
		if not isvalid(kdsi_elenco_output) then kdsi_elenco_output = create datastore   //ds da passare alla windows di elenco
		
		kst_tab_cond_fatt.cod_cli = tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "cod_cli")
		if (kst_tab_cond_fatt.cod_cli) > 0 then
	
			kdsi_elenco_output.dataobject = kuf1_clienti.kk_dw_elenco_mand
			kdsi_elenco_output.settransobject ( sqlca )
			kdsi_elenco_output.retrieve(kst_tab_cond_fatt.cod_cli) 
			kst_open_w.key1 = "Elenco Mandanti del Cliente: " + string(kst_tab_cond_fatt.cod_cli)


			if kdsi_elenco_output.rowcount() > 0 then
				
			//--- chiamare la window di elenco
			//
			//=== Parametri : 
			//=== struttura st_open_w
				kst_open_w.id_programma =kkg_id_programma_elenco
				kst_open_w.flag_primo_giro = "S"
				kst_open_w.flag_modalita = kkg_flag_modalita.elenco
				kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
				kst_open_w.flag_leggi_dw = " "
				kst_open_w.flag_cerca_in_lista = " "
				kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
				kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
				kst_open_w.key4 = trim(kiw_this_window.title)   //--- Titolo della Window di chiamata per riconoscerla
				kst_open_w.key6 = " "    //--- nome del campo cliccato
				kst_open_w.key7 = "S"    //--- dopo la scelta chiudere la Window di elenco
				kst_open_w.key12_any = kdsi_elenco_output
				kst_open_w.flag_where = " "
				//kuf1_menu_window = create kuf_menu_window 
				kGuf_menu_window.open_w_tabelle(kst_open_w)
				//destroy kuf1_menu_window
			
			else
				
				messagebox("Elenco Dati", &
							"Nessun valore disponibile. ")
				
				
			end if
		end if




SetPointer(kp_oldpointer)


end subroutine

protected subroutine set_tab_listino (ref st_tab_listino kst_tab_listino);//
//--- Setta la st_tab_listino
//
int k_ctr, k_num_col




k_ctr = tab_1.tabpage_1.dw_1.getrow()

if k_ctr > 0 then

	k_num_col = long(tab_1.tabpage_1.dw_1.Object.DataWindow.Column.Count)
	
	for k_ctr = 1 to k_num_col 
		choose case  tab_1.tabpage_1.dw_1.Describe("#"+string(k_ctr)+".Name")
			case "attivo"
				kst_tab_listino.attivo = tab_1.tabpage_1.dw_1.getitemstring( 1, "attivo")
		 	case "campione"
				kst_tab_listino.campione = tab_1.tabpage_1.dw_1.getitemstring( 1, "campione")
		 	case "cod_art"
				kst_tab_listino.cod_art = tab_1.tabpage_1.dw_1.getitemstring( 1, "cod_art")
		 	case "cod_cli"
				kst_tab_listino.cod_cli = tab_1.tabpage_1.dw_1.getitemnumber( 1, "cod_cli")
		 	case "contratto"
				kst_tab_listino.contratto = tab_1.tabpage_1.dw_1.getitemnumber( 1, "contratto")
		 	case "dose"
				kst_tab_listino.dose = tab_1.tabpage_1.dw_1.getitemnumber( 1, "dose")
		 	case "id"
				kst_tab_listino.id = tab_1.tabpage_1.dw_1.getitemnumber( 1, "id")
		 	case "id_cond_fatt_1"
				kst_tab_listino.id_cond_fatt_1 = tab_1.tabpage_1.dw_1.getitemnumber( 1, "id_cond_fatt_1")
		 	case "id_cond_fatt_2"
				kst_tab_listino.id_cond_fatt_1 = tab_1.tabpage_1.dw_1.getitemnumber( 1, "id_cond_fatt_2")
		 	case "id_cond_fatt_3"
				kst_tab_listino.id_cond_fatt_3 = tab_1.tabpage_1.dw_1.getitemnumber( 1, "id_cond_fatt_3")
		 	case "m_cubi_f"
				kst_tab_listino.m_cubi_f = tab_1.tabpage_1.dw_1.getitemnumber( 1, "m_cubi_f")
		 	case "magazzino"
				kst_tab_listino.magazzino = tab_1.tabpage_1.dw_1.getitemnumber( 1, "magazzino")
		 	case "mis_x"
				kst_tab_listino.mis_x = tab_1.tabpage_1.dw_1.getitemnumber( 1, "mis_x")
		 	case "mis_y"
				kst_tab_listino.mis_y = tab_1.tabpage_1.dw_1.getitemnumber( 1, "mis_y")
		 	case "mis_z"
				kst_tab_listino.mis_z = tab_1.tabpage_1.dw_1.getitemnumber( 1, "mis_z")
		 	case "occup_ped"
				kst_tab_listino.occup_ped = tab_1.tabpage_1.dw_1.getitemnumber( 1, "occup_ped")
		 	case "peso_kg"
				kst_tab_listino.peso_kg = tab_1.tabpage_1.dw_1.getitemnumber( 1, "peso_kg")
		 	case "prezzo"
				kst_tab_listino.prezzo = tab_1.tabpage_1.dw_1.getitemnumber( 1, "prezzo")
		 	case "prezzo_2"
				kst_tab_listino.prezzo_2 = tab_1.tabpage_1.dw_1.getitemnumber( 1, "prezzo_2")
		 	case "prezzo_3"
				kst_tab_listino.prezzo_3 = tab_1.tabpage_1.dw_1.getitemnumber( 1, "prezzo_3")
		 	case "tipo"
				kst_tab_listino.tipo = tab_1.tabpage_1.dw_1.getitemstring( 1, "tipo")
		 	case "travaso"
				kst_tab_listino.travaso = tab_1.tabpage_1.dw_1.getitemstring( 1, "travaso")

		end choose
		
	end for
end if

end subroutine

public subroutine leggi_dwc ();int k_rc
long k_id
datawindowchild  kdwc_contratto, kdwc_clienti, kdwc_clie_des, kdwc_articoli, kdwc_articoli_des
datawindowchild kdwc_2



choose case ki_selectedtab

	case 1
		k_id = tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "cod_cli")
		
		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
	
	//--- Attivo dw archivio CONTRATTI
			k_rc = tab_1.tabpage_1.dw_1.getchild("contratto", kdwc_contratto)
			if (ki_cod_cli <> k_id or kdwc_contratto.rowcount() < 2) then
				if k_id > 0 then
				else
					k_id = 0
				end if
				ki_cod_cli = k_id
				kdwc_contratto.retrieve(k_id, "*")
				k_rc = kdwc_contratto.insertrow(1)
		
			end if
		end if 


	//--- Attivo dw archivio CLIENTI
		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
			k_rc = tab_1.tabpage_1.dw_1.getchild("cod_cli", kdwc_clienti)
			if kdwc_clienti.rowcount() < 2 then
				kdwc_clienti.retrieve("%")
				k_rc = kdwc_clienti.insertrow(1)
				
				k_rc = tab_1.tabpage_1.dw_1.getchild("rag_soc_10", kdwc_clie_des)
				kdwc_clienti.RowsCopy(kdwc_clienti.GetRow(), kdwc_clienti.RowCount(), Primary!, kdwc_clie_des, 1, Primary!)
			end if	
		end if
		

//--- Attivo dw archivio Prodotto
		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
			k_rc = tab_1.tabpage_1.dw_1.getchild("cod_art", kdwc_articoli)
			if kdwc_articoli.rowcount() < 2 then
				kdwc_articoli.retrieve("%")
				kdwc_articoli.insertrow(1)

				k_rc = tab_1.tabpage_1.dw_1.getchild("cod_art_des", kdwc_articoli_des)
				kdwc_articoli.RowsCopy(kdwc_articoli.GetRow(), kdwc_articoli.RowCount(), Primary!,kdwc_articoli_des, 1, Primary!)
			end if	
		end if
		

	case 2
//--- Attivo dw archivio GRUPPI LISTINO
		k_rc = tab_1.tabpage_2.dw_2.getchild("id_listino_pregruppo", kdwc_2)
		k_rc = kdwc_2.settransobject(sqlca)
		if tab_1.tabpage_2.dw_2.ki_flag_modalita <> kkg_flag_modalita.visualizzazione then
			if kdwc_2.rowcount() < 2 then
				kdwc_2.retrieve(0 )
				kdwc_2.insertrow(1)
			end if
		end if

end choose

end subroutine

public subroutine riempi_video_contratto (st_tab_contratti k_st_tab_contratti);//
kuf_contratti kuf1_contratti
st_esito kst_esito		
		
			
	kuf1_contratti = create kuf_contratti
//	k_st_tab_contratti.codice = long(data)
	kst_esito = kuf1_contratti.select_riga(k_st_tab_contratti)
	destroy kuf1_contratti

	if kst_esito.sqlcode = 0 then
	else
		k_st_tab_contratti.mc_co = ""
		k_st_tab_contratti.sc_cf = ""
		k_st_tab_contratti.descr = ""
		k_st_tab_contratti.sl_pt = ""
	end if

	tab_1.tabpage_1.dw_1.setitem(1, "mc_co", k_st_tab_contratti.mc_co)
	tab_1.tabpage_1.dw_1.setitem(1, "sc_cf", k_st_tab_contratti.sc_cf)
	tab_1.tabpage_1.dw_1.setitem(1, "contratti_descr", k_st_tab_contratti.descr)
	tab_1.tabpage_1.dw_1.setitem(1, "cod_sl_pt", k_st_tab_contratti.sl_pt)


end subroutine

private subroutine put_video_pregruppi (st_tab_listino_pregruppi_voci ast_tab_listino_pregruppi_voci);//
//--- Visualizza dati Gruppi
//
long k_riga=0
datawindowchild kdwc_1



tab_1.tabpage_2.dw_2.modify( "id_listino_pregruppo.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
tab_1.tabpage_2.dw_2.setitem( tab_1.tabpage_2.dw_2.getrow(), "id_listino_pregruppo", ast_tab_listino_pregruppi_voci.id_listino_pregruppo )

tab_1.tabpage_2.dw_2.getchild("id_listino_pregruppo", kdwc_1)
k_riga = kdwc_1.find( "id_listino_pregruppo = " + string(ast_tab_listino_pregruppi_voci.id_listino_pregruppo) + " " , 1, kdwc_1.rowcount())
if k_riga > 0 then
	tab_1.tabpage_2.dw_2.setitem(tab_1.tabpage_2.dw_2.getrow(), "listino_pregruppo_descr", kdwc_1.getitemstring(k_riga, "descr")  )
else
	tab_1.tabpage_2.dw_2.setitem(tab_1.tabpage_2.dw_2.getrow(), "listino_pregruppo_descr", " " )
end if



end subroutine

protected subroutine open_start_window ();int k_rc
datawindowchild  kdwc_articoli_des, kdwc_articoli
kuf_listino_cambio_stato kuf1_listino_cambio_stato
kuf_listino_cambio_prezzo kuf1_listino_cambio_prezzo


try

	kiuf_listino = create kuf_listino

	ki_toolbar_window_presente=true

	tab_1.tabpage_2.dw_2.ki_flag_modalita = kkg_flag_modalita.visualizzazione 
	tab_1.tabpage_3.dw_3.ki_flag_modalita = kkg_flag_modalita.visualizzazione 

//	tab_1.tabpage_1.dw_1.object.cb_key.filename = kGuo_path.get_risorse() + "\Chiave.gif"
	tab_1.tabpage_1.dw_1.object.cb_key.filename = "Chiave.gif"

//--- imposta periodo x estrazione movimenti
	ki_data_ini = relativedate(kg_dataoggi, -91)
	ki_data_fin = kg_dataoggi

//--- get degli argomenti passati da esterno
	if not isnumber(trim(ki_st_open_w.key1)) then
		kist_tab_listino_open.id = 0
	else
		kist_tab_listino_open.id  = long(trim(ki_st_open_w.key1))
	end if
	if not isnumber(trim(ki_st_open_w.key2)) then
		kist_tab_listino_open.cod_cli = 0
	else
		kist_tab_listino_open.cod_cli = long(trim(ki_st_open_w.key2))
	end if
	if Len(trim(ki_st_open_w.key3)) = 0 or isnull(trim(ki_st_open_w.key3)) then
		kist_tab_listino_open.cod_art = ""
	else
		kist_tab_listino_open.cod_art = trim(ki_st_open_w.key3)
	end if

//--- Attivo dw archivio Prodotto
	k_rc = tab_1.tabpage_1.dw_1.getchild("cod_art", kdwc_articoli)

	k_rc = kdwc_articoli.settransobject(sqlca)

	kdwc_articoli.insertrow(1)

	k_rc = tab_1.tabpage_1.dw_1.getchild("cod_art_des", kdwc_articoli_des)

	k_rc = kdwc_articoli_des.settransobject(sqlca)

//	kdwc_articoli.RowsCopy(kdwc_articoli.GetRow(), kdwc_articoli.RowCount(), Primary!, kdwc_articoli_des, 1, Primary!)

	tab_1.tabpage_2.dw_10.settransobject(kguo_sqlca_db_magazzino )

//--- Utente autorizzato al cambio di STATO (colonna ATTIVO)?
	try
		kuf1_listino_cambio_stato = create kuf_listino_cambio_stato
		ki_cambio_stato_listino_autorizzato = kuf1_listino_cambio_stato.if_sicurezza(kkg_flag_modalita.modifica )
	catch (uo_exception kuo1_exception)
		ki_cambio_stato_listino_autorizzato = false
	end try
		
//--- Utente autorizzato al cambio PREZZI: apposita funzione + solo se listino NON attivo
	kist_tab_listino_open.attivo = kiuf_listino.get_attivo(kist_tab_listino_open)
	if kist_tab_listino_open.attivo = kiuf_listino.kki_attivo_si then
		ki_cambio_prezzi_listino_autorizzato = false
	else
		kuf1_listino_cambio_prezzo = create kuf_listino_cambio_prezzo
		ki_cambio_prezzi_listino_autorizzato = kuf1_listino_cambio_prezzo.if_sicurezza(kkg_flag_modalita.modifica )
	end if	 
		
		
catch (uo_exception kuo_exception)
//	kuo_exception.messaggio_utente()

end try
end subroutine

protected subroutine inizializza_4 () throws uo_exception;//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
string k_scelta
long  k_key, k_clie_3, k_contratto, k_riga, k_larg, k_lung, k_alt
int k_err_ins, k_rc=0, k_anno
double k_dose 
string k_art
string k_codice_prec
st_tab_listino kst_tab_listino
datawindowchild kdwc_barcode


ki_selectedtab = 5

k_scelta = trim(ki_st_open_w.flag_modalita)

k_key = long(trim(ki_st_open_w.key2)) //

kst_tab_listino.contratto = tab_1.tabpage_1.dw_1.getitemnumber(1, "contratto") //contratto
kst_tab_listino.id = tab_1.tabpage_1.dw_1.getitemnumber(1, "id") //misura

if kst_tab_listino.id > 0 then
	
	if isnull(kst_tab_listino.contratto) then kst_tab_listino.contratto = 0
	
//--- salvo i parametri cosi come sono stati immessi x evitare la rilettura
	k_codice_prec = tab_1.tabpage_5.st_5_retrieve.text
	tab_1.tabpage_5.st_5_retrieve.text = string(kst_tab_listino.id) + string(kst_tab_listino.contratto) + string(ki_data_ini) + string(ki_data_fin)
	
	if tab_1.tabpage_5.st_5_retrieve.text = k_codice_prec then
	else
	
		if kiuf_listino.if_listino_gia_in_rif(kst_tab_listino) then
			tab_1.tabpage_5.dw_5.getchild("barcode_elenco", kdwc_barcode)
			kdwc_barcode.settransobject(sqlca)
			kdwc_barcode.insertrow(0)

			k_rc=tab_1.tabpage_5.dw_5.retrieve( kst_tab_listino.id, kst_tab_listino.contratto, ki_data_ini, ki_data_fin  )

			if tab_1.tabpage_5.dw_5.rowcount() = 0 then
				tab_1.tabpage_5.dw_5.insertrow(0) 
			end if
		end if
	
	end if				
					
	
	attiva_tasti()
	
	
	tab_1.tabpage_5.dw_5.setfocus()
end if


end subroutine

public subroutine proteggi_campi ();//
kuf_utility kuf1_utility


	kuf1_utility = create kuf_utility 


//--- se NO inserimento leggo DW-CHILD
//	if ki_st_open_w.flag_modalita <> kkg_flag_modalita.inserimento and tab_1.tabpage_1.dw_1.getrow() > 0 then
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then

//--- S-protezione campi per abilitare l'inserimento
		kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)
		
	else
		
		tab_1.tabpage_1.dw_1.setredraw(false)

	
//--- Inabilita campi alla modifica se Vsualizzazione
		if trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.inserimento and trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.modifica then
		
			kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_1.dw_1)

			kuf1_utility.u_proteggi_dw("1", "b_cond_fatt_1", tab_1.tabpage_1.dw_1)
			kuf1_utility.u_proteggi_dw("1", "b_cond_fatt_2", tab_1.tabpage_1.dw_1)
			kuf1_utility.u_proteggi_dw("1", "b_cond_fatt_3", tab_1.tabpage_1.dw_1)
	
		else		
			
//--- S-protezione campi per riabilitare la modifica a parte la chiave
	      	kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)

//--- Inabilita campo cliente per la modifica se Funzione MODIFICA
			if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
	
//--- protegge i campi chiave
				kuf1_utility.u_proteggi_dw("1",  "cod_cli", tab_1.tabpage_1.dw_1)
				kuf1_utility.u_proteggi_dw("1", "cod_art", tab_1.tabpage_1.dw_1)
				kuf1_utility.u_proteggi_dw("1", "dose", tab_1.tabpage_1.dw_1)
				kuf1_utility.u_proteggi_dw("1", "mis_x", tab_1.tabpage_1.dw_1)
				kuf1_utility.u_proteggi_dw("1", "mis_y", tab_1.tabpage_1.dw_1)
				kuf1_utility.u_proteggi_dw("1", "mis_z", tab_1.tabpage_1.dw_1)
			end if
			
//--- Protegge il Campo ATTIVO se non autorizzato			
			if NOT ki_cambio_stato_listino_autorizzato then
				kuf1_utility.u_proteggi_dw("1", "attivo", tab_1.tabpage_1.dw_1)
			end if

//--- Protegge il Campo PREZZI se non autorizzato			
			if NOT ki_cambio_prezzi_listino_autorizzato then
				kuf1_utility.u_proteggi_dw("1", "attiva_listino_pregruppi", tab_1.tabpage_1.dw_1)
				kuf1_utility.u_proteggi_dw("1", "prezzo", tab_1.tabpage_1.dw_1)
				kuf1_utility.u_proteggi_dw("1", "prezzo_2", tab_1.tabpage_1.dw_1)
				kuf1_utility.u_proteggi_dw("1", "prezzo_3", tab_1.tabpage_1.dw_1)
				kuf1_utility.u_proteggi_dw("1", "b_cond_fatt_1", tab_1.tabpage_1.dw_1)
				kuf1_utility.u_proteggi_dw("1", "b_cond_fatt_2", tab_1.tabpage_1.dw_1)
				kuf1_utility.u_proteggi_dw("1", "b_cond_fatt_3", tab_1.tabpage_1.dw_1)
			end if
			
		end if
		
	
		tab_1.tabpage_1.dw_1.setredraw(true)
	
	end if
	destroy kuf1_utility

end subroutine

protected function boolean dati_modif_1 ();//
//--- dati modificati?
//--- true=si; false=no   poi   valorizza ki_dw_titolo_modif_1 con il Titolo del TAB modificato
//
boolean k_boolean = false

//
//--- Attiva/Dis. Voci di menu
	k_boolean = super::dati_modif_1()

	tab_1.tabpage_2.dw_10.accepttext( )

	if not k_boolean then 
		 if tab_1.tabpage_2.dw_10.u_dati_modificati() then
			k_boolean = true
			if len(ki_dw_titolo_modif_1) > 0 then
				ki_dw_titolo_modif_1 = ""
			else
				ki_dw_titolo_modif_1 = trim(tab_1.tabpage_2.dw_10.title)
			end if
		end if
	end if
			
return k_boolean
			
	

end function

private subroutine put_video_retrieve_voci_prezzi ();//
//--- Visualizza dati Voci Prezzi
//
st_tab_listino_link_pregruppi kst_listino_link_pregruppi

if tab_1.tabpage_2.dw_10.rowcount( ) > 0 then
	kst_listino_link_pregruppi.id_listino_link_pregruppo = tab_1.tabpage_2.dw_10.getitemnumber(1, "id_listino_link_pregruppo" ) 
else
	kst_listino_link_pregruppi.id_listino_link_pregruppo = 0
end if

if tab_1.tabpage_2.dw_2.rowcount( ) > 0 then
	if tab_1.tabpage_2.dw_2.getselectedrow(0) = 0 then
		if tab_1.tabpage_2.dw_2.getrow( ) = 0 then
			tab_1.tabpage_2.dw_2.setrow(1)
		end if
		tab_1.tabpage_2.dw_2.selectrow( tab_1.tabpage_2.dw_2.getrow( ) ,true)
	else
		tab_1.tabpage_2.dw_2.setrow(tab_1.tabpage_2.dw_2.getselectedrow(0))
	end if
	
//--- legge il dettaglio solo se codice diverso dalla Testata	
	if kst_listino_link_pregruppi.id_listino_link_pregruppo =  tab_1.tabpage_2.dw_2.getitemnumber(tab_1.tabpage_2.dw_2.getrow( ), "id_listino_link_pregruppo" )  then
	else
		kst_listino_link_pregruppi.id_listino_link_pregruppo = tab_1.tabpage_2.dw_2.getitemnumber(tab_1.tabpage_2.dw_2.getrow( ), "id_listino_link_pregruppo" ) 
		tab_1.tabpage_2.dw_10.retrieve(kst_listino_link_pregruppi.id_listino_link_pregruppo)
	end if
	
else
	tab_1.tabpage_2.dw_10.reset( )
end if



end subroutine

private subroutine put_video_voci_prezzi (st_tab_listino_prezzi ast_tab_listino_prezzi);//
//--- Visualizza dati Gruppi
//
long k_riga=0, k_riga_set=0
datawindowchild kdwc_1


k_riga_set = tab_1.tabpage_2.dw_10.getrow()

tab_1.tabpage_2.dw_10.modify( "id_listino_voce.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
tab_1.tabpage_2.dw_10.setitem( k_riga_set, "id_listino_voce", ast_tab_listino_prezzi.id_listino_voce )

tab_1.tabpage_2.dw_10.getchild("id_listino_voce", kdwc_1)
k_riga = kdwc_1.find( "id_listino_voce = " + string(ast_tab_listino_prezzi.id_listino_voce) + " " , 1, kdwc_1.rowcount())
if k_riga > 0 then
	tab_1.tabpage_2.dw_10.setitem(k_riga_set, "listino_voci_descr", kdwc_1.getitemstring(k_riga, "listino_voci_descr")  )
	tab_1.tabpage_2.dw_10.setitem(k_riga_set, "listino_voci_attivo", kdwc_1.getitemstring(k_riga, "listino_voci_attivo")  )
	tab_1.tabpage_2.dw_10.setitem(k_riga_set, "attivo", kdwc_1.getitemstring(k_riga, "listino_voci_attivo")  )
	tab_1.tabpage_2.dw_10.setitem(k_riga_set, "listino_voci_id_listino_voci_categ", kdwc_1.getitemstring(k_riga, "listino_voci_id_listino_voci_categ")  )
	tab_1.tabpage_2.dw_10.setitem(k_riga_set, "listino_voci_tipo_listino", kdwc_1.getitemstring(k_riga, "listino_voci_tipo_listino")  )
	tab_1.tabpage_2.dw_10.setitem(k_riga_set, "listino_voci_tipo_calcolo", kdwc_1.getitemstring(k_riga, "listino_voci_tipo_calcolo")  )
	tab_1.tabpage_2.dw_10.setitem(k_riga_set, "listino_voci_um", kdwc_1.getitemstring(k_riga, "listino_voci_um")  )
	if tab_1.tabpage_2.dw_10.getitemnumber(k_riga_set, "prezzo") > 0 then
	else
		tab_1.tabpage_2.dw_10.setitem(k_riga_set, "prezzo", kdwc_1.getitemnumber(k_riga, "prezzo") )
	end if
else
	tab_1.tabpage_2.dw_10.setitem(k_riga_set, "listino_voci_descr", " " )
	tab_1.tabpage_2.dw_10.setitem(k_riga_set, "listino_voci_attivo", "")
	tab_1.tabpage_2.dw_10.setitem(k_riga_set, "attivo", "")
	tab_1.tabpage_2.dw_10.setitem(k_riga_set, "listino_voci_id_listino_voci_categ","")
	tab_1.tabpage_2.dw_10.setitem(k_riga_set, "listino_voci_tipo_listino","")
	tab_1.tabpage_2.dw_10.setitem(k_riga_set, "listino_voci_tipo_calcolo", "")
	tab_1.tabpage_2.dw_10.setitem(k_riga_set, "listino_voci_um", "")
	tab_1.tabpage_2.dw_10.setitem(k_riga_set, "prezzo", 0)
end if



end subroutine

public function string u_get_dw_name_focus ();//
//--- Torna il nome del dw con il fuoco
//
string k_return = ""
GraphicObject k_which_control
uo_d_std_1 k_uo_d_std_1


	k_which_control = GetFocus()
	if TypeOf(k_which_control) = DataWindow! then
		
		k_uo_d_std_1 = k_which_control
		k_return = k_uo_d_std_1.dataobject

	end if

return k_return
end function

public subroutine leggi_dwc_dw10 ();int k_rc
long k_id
datawindowchild kdwc_2


	if tab_1.tabpage_2.dw_2.rowcount( ) > 0 then

		k_id = tab_1.tabpage_2.dw_2.getitemnumber(tab_1.tabpage_2.dw_2.getrow(), "id_listino_pregruppo")
			
//--- Attivo dw archivio GRUPPI LISTINO
		k_rc = tab_1.tabpage_2.dw_10.getchild("id_listino_voce", kdwc_2)
		k_rc = kdwc_2.settransobject(sqlca)
		if tab_1.tabpage_2.dw_2.ki_flag_modalita <> kkg_flag_modalita.visualizzazione then
			if kdwc_2.rowcount() > 1 then
				if k_id <>  tab_1.tabpage_2.dw_10.getitemnumber(2, "id_listino_pregruppo") then
					kdwc_2.reset( )
				end if
			end if
			if kdwc_2.rowcount() < 2 then
				kdwc_2.retrieve(k_id,0)
				kdwc_2.insertrow(1)
			end if
		end if
	end if
	

end subroutine

private subroutine cambia_periodo_elenco ();//---
//--- Visualizza il box x il cambio del Periodo di elenco fatture 
//---


dw_periodo.triggerevent("ue_visibile")

end subroutine

protected function boolean inserisci_dw10 ();//
boolean k_return = false
long k_riga, k_riga_new 
st_tab_listino_prezzi kst_tab_listino_prezzi
kuf_utility kuf1_utility


//--- ricavo la riga del GRUPPO
	if  tab_1.tabpage_2.dw_2.rowcount( ) > 0 then
		k_riga = tab_1.tabpage_2.dw_2.getrow( )
//--- controllo se NON ho scelto una riga e ce n'e' solo una allora setto quella
		if tab_1.tabpage_2.dw_2.getselectedrow(0) = 0  then
			if k_riga > 0 then
			else
				if tab_1.tabpage_2.dw_2.rowcount( ) = 1 then
					k_riga = 1
				end if
			end if
		else
			if tab_1.tabpage_2.dw_2.getselectedrow(0) <> k_riga  then
				k_riga = tab_1.tabpage_2.dw_2.getselectedrow(0)
			end if
		end if

		if k_riga > 0 then
			tab_1.tabpage_2.dw_2.selectrow(0, false )
			tab_1.tabpage_2.dw_2.selectrow(k_riga, true )
			tab_1.tabpage_2.dw_2.setrow(k_riga)
		end if
	end if
	if k_riga > 0 then
	
		kst_tab_listino_prezzi.id_listino_link_pregruppo =  tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id_listino_link_pregruppo")
		if kst_tab_listino_prezzi.id_listino_link_pregruppo > 0 then

//--- S-protezione campi per abilitare l'inserimento
			kuf1_utility = create kuf_utility
			kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_2.dw_10)
			destroy kuf1_utility

			k_riga_new = tab_1.tabpage_2.dw_10.insertrow(0)

			tab_1.tabpage_2.dw_10.setitem(k_riga_new, "id_listino_link_pregruppo", kst_tab_listino_prezzi.id_listino_link_pregruppo)

			tab_1.tabpage_2.dw_10.SetItemStatus( k_riga_new, 0, Primary!, NotModified!)
			tab_1.tabpage_2.dw_10.scrolltorow(k_riga_new)
			tab_1.tabpage_2.dw_10.setrow(k_riga_new)
			tab_1.tabpage_2.dw_10.selectrow(0, false)
			
			leggi_dwc_dw10( )   // leggo i dwc
		else
			messagebox ("Carico Voce", "Attenzione, prima SALVA in archivio il GRUPPO a cui aggiungere i Prezzi", information!)
			
		end if
	else
		messagebox ("Carico Voce", "Attenzione, prima seleziona il Gruppo dall'elenco", information!)
	end if

return k_return



end function

protected subroutine attiva_tasti_0 ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================


super::attiva_tasti_0()

if trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.visualizzazione then
	cb_ritorna.default = false
	
	//=== Nr righe ne DW lista
	choose case tab_1.selectedtab
		case 1
			cb_modifica.enabled = false
			if tab_1.tabpage_1.dw_1.rowcount() = 0 then
				cb_inserisci.enabled = true
				cb_inserisci.default = true
				cb_cancella.enabled = false
				cb_aggiorna.enabled = false
			end if
			tab_1.tabpage_1.dw_1.object.cb_key.visible=cb_aggiorna.enabled
			tab_1.tabpage_1.dw_1.object.t_key.visible=cb_aggiorna.enabled
		case 2
			if tab_1.tabpage_1.dw_1.rowcount() = 0 then
				cb_inserisci.enabled = false
				cb_inserisci.default = false
				cb_cancella.enabled = false
				cb_aggiorna.enabled = false
			else
				cb_modifica.enabled = true
				if tab_1.tabpage_2.dw_2.rowcount() = 0 then
					if ki_cambio_prezzi_listino_autorizzato then
						cb_inserisci.enabled = true
					else
						cb_inserisci.enabled = false
					end if
					cb_cancella.enabled = false
					cb_aggiorna.enabled = false
					cb_modifica.enabled = false
				end if
			end if
		case 3
			if tab_1.tabpage_1.dw_1.rowcount() = 0 then
				cb_inserisci.enabled = false
				cb_inserisci.default = false
				cb_cancella.enabled = false
				cb_aggiorna.enabled = false
			else
				cb_modifica.enabled = true
				if tab_1.tabpage_3.dw_3.rowcount() = 0 then
					cb_inserisci.enabled = true
					cb_cancella.enabled = false
					cb_aggiorna.enabled = false
					cb_modifica.enabled = false
				end if
			end if
		case 4
				cb_inserisci.enabled = false
				cb_inserisci.default = false
				cb_cancella.enabled = false
				cb_aggiorna.enabled = false
		case 5
				cb_inserisci.enabled = false
				cb_inserisci.default = false
				cb_aggiorna.enabled = false
				cb_aggiorna.enabled = false
	end choose


end if            

end subroutine

public subroutine u_resize_1 ();//
//--- Se tab_1 e visible oppure sono in prima volta
//if tab_1.visible or ki_st_open_w.flag_primo_giro = 'S' then
	this.setredraw(false)

//=== Dimensione dw nella window 
	tab_1.width = this.width - 2
	tab_1.height = this.height - 2

//--- Posiziona dw nella window 
	tab_1.x = 1 
	tab_1.y = 1 

	constant int kk_width = 1// 50
	constant int kk_height = 1 //150

//=== Dimensiona dw nel tab
	tab_1.tabpage_1.dw_1.width = tab_1.tabpage_1.width - kk_width
	tab_1.tabpage_1.dw_1.height = tab_1.tabpage_1.height - kk_height
	tab_1.tabpage_1.dw_1.x = 1
	tab_1.tabpage_1.dw_1.y =  1

	if tab_1.tabpage_2.dw_2.enabled then
		tab_1.tabpage_2.dw_2.width = tab_1.tabpage_2.width - kk_width
		tab_1.tabpage_2.dw_2.height = tab_1.tabpage_2.height / 3 - kk_height 
		tab_1.tabpage_2.dw_2.x =  1
		tab_1.tabpage_2.dw_2.y =  1
			
		tab_1.tabpage_2.dw_10.x =  1
		tab_1.tabpage_2.dw_10.y =  tab_1.tabpage_2.dw_2.height + 10
		tab_1.tabpage_2.dw_10.width = tab_1.tabpage_2.dw_2.width - 20
		tab_1.tabpage_2.dw_10.height = tab_1.tabpage_2.height - tab_1.tabpage_2.dw_2.height - 150
	end if
	if tab_1.tabpage_3.dw_3.enabled then
			tab_1.tabpage_3.dw_3.width = tab_1.tabpage_3.width - kk_width 
			tab_1.tabpage_3.dw_3.height = tab_1.tabpage_3.height - kk_height
			tab_1.tabpage_3.dw_3.x =  1
			tab_1.tabpage_3.dw_3.y =  1
	end if
	if tab_1.tabpage_4.dw_4.enabled then
			tab_1.tabpage_4.dw_4.width = tab_1.tabpage_4.width - kk_width
			tab_1.tabpage_4.dw_4.height = tab_1.tabpage_4.height - kk_height
			tab_1.tabpage_4.dw_4.x =  1
			tab_1.tabpage_4.dw_4.y =  1
	end if
	if tab_1.tabpage_5.dw_5.enabled then
			tab_1.tabpage_5.dw_5.width = tab_1.tabpage_5.width - kk_width
			tab_1.tabpage_5.dw_5.height = tab_1.tabpage_5.height - kk_height
			tab_1.tabpage_5.dw_5.x =  1
			tab_1.tabpage_5.dw_5.y =  1
	end if
	if tab_1.tabpage_6.dw_6.enabled then
			tab_1.tabpage_6.dw_6.width = tab_1.tabpage_6.width - kk_width
			tab_1.tabpage_6.dw_6.height = tab_1.tabpage_6.height - kk_height
			tab_1.tabpage_6.dw_6.x =  1
			tab_1.tabpage_6.dw_6.y =  1
	end if
	if tab_1.tabpage_7.dw_7.enabled then
			tab_1.tabpage_7.dw_7.width = tab_1.tabpage_7.width - kk_width
			tab_1.tabpage_7.dw_7.height = tab_1.tabpage_7.height - kk_height
			tab_1.tabpage_7.dw_7.x =  1
			tab_1.tabpage_7.dw_7.y =  1
	end if
	if tab_1.tabpage_8.dw_8.enabled then
			tab_1.tabpage_8.dw_8.width = tab_1.tabpage_8.width - kk_width
			tab_1.tabpage_8.dw_8.height = tab_1.tabpage_8.height - kk_height
			tab_1.tabpage_8.dw_8.x =  1
			tab_1.tabpage_8.dw_8.y =  1
	end if
	if tab_1.tabpage_9.dw_9.enabled then
			tab_1.tabpage_9.dw_9.width = tab_1.tabpage_9.width - kk_width
			tab_1.tabpage_9.dw_9.height = tab_1.tabpage_9.height - kk_height
			tab_1.tabpage_9.dw_9.x =  1
			tab_1.tabpage_9.dw_9.y =  1
	end if
	
	this.setredraw(true)
//end if



end subroutine

on w_listino.create
int iCurrent
call super::create
this.dw_periodo=create dw_periodo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_periodo
end on

on w_listino.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_periodo)
end on

event close;call super::close;//
if isvalid(kiuf_listino) then destroy 	kiuf_listino



end event

event u_ricevi_da_elenco;call super::u_ricevi_da_elenco;//
int k_return
int k_rc
long k_num_int, k_riga, k_riga_zoom
date k_data_int
window k_window
st_esito kst_esito
st_tab_cond_fatt  kst_tab_cond_fatt 
st_tab_clienti kst_tab_clienti
//kuf_menu_window kuf1_menu_window 
kuf_sicurezza kuf1_sicurezza



//st_open_w kst_open_w

//kst_open_w = Message.PowerObjectParm	

if isvalid(kst_open_w) then

//--- Dalla finestra di Elenco Valori
	if kst_open_w.id_programma = kkg_id_programma_elenco then
	
		if not isvalid(kdsi_elenco_input) then kdsi_elenco_input = create datastore
	
		kdsi_elenco_input = kst_open_w.key12_any 
	
		k_riga_zoom = 0
		if isnumber(kst_open_w.key3) then k_riga_zoom = long(kst_open_w.key3)

		if kdsi_elenco_input.rowcount() > 0 and k_riga_zoom > 0  then

			choose case tab_1.selectedtab 

//--- 
				case 1 
				
			 		if kst_open_w.key2 = kiuf_listino.kki_anteprima_cond_fatt_dw  then   //se da zoom delle condizioni...
		
						kst_tab_cond_fatt.id = kdsi_elenco_input.getitemnumber(k_riga_zoom, "id")
			
						if kst_tab_cond_fatt.id = 0 or isnull(kst_tab_cond_fatt.id) then
							kst_tab_cond_fatt.descr = "Nessuna condizione"	
						else			
							kst_tab_cond_fatt.descr = kdsi_elenco_input.getitemstring( k_riga_zoom, "descr")
						end if
						
						k_return = 1
						choose case  kst_open_w.key6    //--- nome del campo che avevo cliccato
								
							case "b_cond_fatt_1"
								 tab_1.tabpage_1.dw_1.setitem( 1, "id_cond_fatt_1",kst_tab_cond_fatt.id)
								 tab_1.tabpage_1.dw_1.setitem( 1, "cf1_descr",kst_tab_cond_fatt.descr)
							case "b_cond_fatt_2"
								 tab_1.tabpage_1.dw_1.setitem( 1, "id_cond_fatt_2",kst_tab_cond_fatt.id)
								 tab_1.tabpage_1.dw_1.setitem( 1, "cf2_descr",kst_tab_cond_fatt.descr)
							case "b_cond_fatt_3"
								 tab_1.tabpage_1.dw_1.setitem( 1, "id_cond_fatt_3",kst_tab_cond_fatt.id)
								 tab_1.tabpage_1.dw_1.setitem( 1, "cf3_descr",kst_tab_cond_fatt.descr)
								 
						end choose
						attiva_tasti()
					end if
					
//--- Prezzi					
				case 2
			 		if kst_open_w.key2 = kiuf_listino.kki_anteprima_cond_fatt_dw  then //se da zoom delle condizioni...
		
						kst_tab_cond_fatt.id = kdsi_elenco_input.getitemnumber(k_riga_zoom, "id")
			
						if kst_tab_cond_fatt.id = 0 or isnull(kst_tab_cond_fatt.id) then
							kst_tab_cond_fatt.descr = "Nessuna condizione"	
							kst_tab_cond_fatt.id = 0
						else			
							kst_tab_cond_fatt.descr = kdsi_elenco_input.getitemstring(k_riga_zoom, "descr")
						end if
						
						k_riga = tab_1.tabpage_2.dw_2.getrow()
						if k_riga > 0 then
							choose case  kst_open_w.key6    //--- nome del campo che avevo cliccato
									
								case "b_cond_fatt_1"
									k_return = 1
									 tab_1.tabpage_2.dw_2.setitem( k_riga, "id_cond_fatt",kst_tab_cond_fatt.id)
									 tab_1.tabpage_2.dw_2.setitem( k_riga, "cond_fatt_descr",kst_tab_cond_fatt.descr)

									attiva_tasti()
									 
							end choose
						end if
					end if					

//--- Mandante
				case 3 
					
					k_riga =  tab_1.tabpage_3.dw_3.getrow( )
					
					kst_tab_clienti.codice = kdsi_elenco_input.getitemnumber(k_riga_zoom, "id_cliente")
		
					k_return = 1
					choose case  tab_1.tabpage_3.dw_3.getcolumnname( )    //--- nome del campo che avevo cliccato
							
						case "valore_1"
							 tab_1.tabpage_3.dw_3.setitem( k_riga, "ipotesi_1",kiuf_listino.kki_cond_fatt_mand )
							 tab_1.tabpage_3.dw_3.setitem( k_riga, "segno_1","=")
							 tab_1.tabpage_3.dw_3.setitem( k_riga, "valore_1",string(kst_tab_clienti.codice))
						case "valore_2"
							 tab_1.tabpage_3.dw_3.setitem( k_riga, "ipotesi_2",kiuf_listino.kki_cond_fatt_mand )
							 tab_1.tabpage_3.dw_3.setitem( k_riga, "segno_2","=")
							 tab_1.tabpage_3.dw_3.setitem( k_riga, "valore_2",string(kst_tab_clienti.codice))
						case "valore_3"
							 tab_1.tabpage_3.dw_3.setitem( k_riga, "ipotesi_3",kiuf_listino.kki_cond_fatt_mand )
							 tab_1.tabpage_3.dw_3.setitem( k_riga, "segno_3","=")
							 tab_1.tabpage_3.dw_3.setitem( k_riga, "valore_3",string(kst_tab_clienti.codice))
							 
					end choose

					attiva_tasti()
	
			end choose
							
		end if

	end if

end if

return k_return


end event

type st_ritorna from w_g_tab_3`st_ritorna within w_listino
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_listino
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_listino
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_listino
integer x = 2711
integer y = 1468
end type

type st_stampa from w_g_tab_3`st_stampa within w_listino
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_listino
integer x = 1179
integer y = 1472
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_listino
integer x = 645
integer y = 1468
end type

event cb_modifica::clicked;//
if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
	
	choose case ki_selectedtab
			
		case 2
			tab_1.tabpage_2.dw_2.ki_flag_modalita = kkg_flag_modalita.modifica
			inizializza_lista( )
			
		case 3
			tab_1.tabpage_3.dw_3.ki_flag_modalita = kkg_flag_modalita.modifica
			inizializza_lista( )
		
	end choose
	
end if
end event

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_listino
integer x = 1970
integer y = 1468
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_listino
integer x = 2341
integer y = 1468
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_listino
integer x = 1600
integer y = 1468
boolean enabled = false
end type

event cb_inserisci::clicked;//
//=== 
string k_errore="0", k_dataobject

//=== Nuovo Rekord
	choose case tab_1.selectedtab 
		case  1
	
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
		
		case  2
			k_dataobject = u_get_dw_name_focus()  // recupera il nome del dw su cui ho il fuoco
			if k_dataobject = tab_1.tabpage_2.dw_2.dataobject then // se sono sul dw_2
				if tab_1.tabpage_2.dw_10.rowcount( ) > 0 then
					k_errore = Left(dati_modif(""), 1)
		
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
				end if
			end if
					
			
	end choose
	
	if Left(k_errore, 1) = "0" then 
		inserisci()
	end if

end event

type tab_1 from w_g_tab_3`tab_1 within w_listino
integer y = 28
integer width = 3072
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
integer width = 3035
integer height = 1256
string text = "Listino"
string picturename = "FormatDollar!"
long picturemaskcolor = 553648127
string powertiptext = "Anagrafica listino"
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
boolean visible = true
integer y = 36
integer width = 3013
integer height = 1236
string dataobject = "d_listino"
boolean minbox = true
boolean maxbox = true
boolean hsplitscroll = false
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_cerca = false
end type

event dw_1::itemchanged;//
date k_data
string k_codice
string k_des
int k_errore=0
long k_riga, k_rc
st_esito kst_esito
st_tab_contratti k_st_tab_contratti
kuf_contratti kuf1_contratti
datawindowchild kdwc_x, kdwc_x_des, kdwc_contratto

choose case upper(dwo.name)
		
	case "ATTIVO"
		if kist_tab_listino_open.attivo <> kiuf_listino.kki_attivo_si and this.getitemnumber(1, "listino_id_parent") > 0 then
			if data = "S" then
				post messagebox("Allerta", "L'attivazione di questo Listino comporta la DISATTIVAZIONE del Listino da cui e' stato duplicato ( " &
									+ string(this.getitemnumber(1, "listino_id_parent")) + " )", information!) 
			end if
		end if

	case "CONTRATTO" 
		if LenA(trim(data)) > 0 then
			k_st_tab_contratti.codice = long(data)
			post riempi_video_contratto(k_st_tab_contratti)
		end if

	case "RAG_SOC_10" 
		if isnull(data) = false and Len(trim(data)) > 0 then
			k_rc = this.getchild("rag_soc_10", kdwc_x)
			k_des = Trim(data)
			if isnumber(k_des) then
				k_riga = kdwc_x.find("id_cliente = " + k_des + " ",0,kdwc_x.rowcount())
				if k_riga > 0  then
					k_des = kdwc_x.getitemstring(k_riga, "rag_soc_1")
				end if
				k_riga = kdwc_x.find("rag_soc_1 =~""+ trim(k_des)+"~"",0,kdwc_x.rowcount())
			else
				k_riga = kdwc_x.find("rag_soc_1 like ~""+trim(k_des)+"~"",0,kdwc_x.rowcount())   // prima ricerca puntuale
				if k_riga <= 0 or isnull(k_riga) then
					k_riga = kdwc_x.find("rag_soc_1 like ~"%"+trim(k_des)+"%~"",0,kdwc_x.rowcount()) // seconda ricerca approssimativa
				end if
			end if
		
			if k_riga <= 0 or isnull(k_riga) then
				this.setitem(row, "rag_soc_10", (k_des)+" - NON TROVATO -")
				this.setitem(row, "cod_cli", 0)
			else

				this.setitem(row, "rag_soc_10", kdwc_x.getitemstring(k_riga, "rag_soc_1"))
				this.setitem(row, "cod_cli", kdwc_x.getitemnumber(k_riga, "id_cliente"))
			end if
			k_errore = 1 
		else
			this.setitem(row, "rag_soc_10", "")
			this.setitem(row, "cod_cli", 0)
		end if


	case "COD_ART" 

	   k_codice = Trim(data)
		if isnull(k_codice) = false and Len(trim(k_codice)) > 0 then
		
			k_rc = this.getchild("cod_art", kdwc_x)
			k_rc = this.getchild("cod_art_des", kdwc_x_des)
			k_riga = kdwc_x.find("codice=~""+trim(k_codice)+"~"",0,kdwc_x.rowcount())
			if k_riga <= 0 or isnull(k_riga) then
				k_rc=this.setitem(row, "cod_art", k_codice)
				k_rc=this.setitem(row, "cod_art_des", "NON TROVATO")
			else
//				k_errore = 2
				k_rc=this.setitem(row, "cod_art", kdwc_x.getitemstring(k_riga, "codice"))
				k_rc = this.setitem(row, "cod_art_des", kdwc_x.getitemstring(k_riga, "des"))
			end if
			k_errore = 1 
		else
			k_rc=this.setitem(row, "cod_art", "")
			k_rc=this.setitem(row, "cod_art_des", "")
		end if

//


end choose 

if k_errore = 1 then
	return 2
end if

post	attiva_tasti()


return k_errore
	
end event

event dw_1::buttonclicked;call super::buttonclicked;//
string k_errore
int k_rc
kuf_listino kuf1_listino
kuf_utility kuf1_utility
st_tab_listino kst_tab_listino
st_tab_cond_fatt kst_tab_cond_fatt
st_tab_meca kst_tab_meca
st_esito kst_esito
st_open_w kst_open_w 
kuf_armo kuf1_armo
datawindowchild kdwc_articoli, kdwc_articoli_des

pointer kp_oldpointer  // Declares a pointer variable


	kp_oldpointer = SetPointer(HourGlass!)


choose case dwo.name

	case "cb_key"

		try
			kst_tab_listino.id = this.getitemnumber(1, "id")
		
			this.object.cb_key.enabled = false
			
			kuf1_listino = create kuf_listino
			kuf1_armo = create kuf_armo
			
//			k_errore = kuf1_listino.tb_gia_fatturato( kst_tab_listino )
			kst_tab_meca.id = kuf1_listino.tb_gia_spedito( kst_tab_listino )
			if kst_tab_meca.id = 0 then
				k_errore = "0"
			else
				kuf1_armo.get_dati_rid(kst_tab_meca)
				k_errore = "1" + "Listino ancora aperto (non SPEDITO), come nel Lotto: ~n~r" &
						+ "numero " + string(kst_tab_meca.num_int, "#####") + " del " &
						+ string(kst_tab_meca.data_int, "dd.mmm.yy") 
				if date(kst_tab_meca.data_ent) > kkg.data_zero then
					k_errore +=  " entrato il " + string(kst_tab_meca.data_ent, "dd.mmm.yy") 
				else
					k_errore +=  " non ancora entrato"  
				end if
				k_errore += " (id " + string(kst_tab_meca.id) + ")" 	
			end if
			if LeftA(k_errore, 1) = "0" then 
				kuf1_utility = create kuf_utility
				kuf1_utility.u_proteggi_dw("0",  "cod_cli", tab_1.tabpage_1.dw_1)
				kuf1_utility.u_proteggi_dw("0", "cod_art", tab_1.tabpage_1.dw_1)
				kuf1_utility.u_proteggi_dw("0", "dose", tab_1.tabpage_1.dw_1)
				kuf1_utility.u_proteggi_dw("0", "mis_x", tab_1.tabpage_1.dw_1)
				kuf1_utility.u_proteggi_dw("0", "mis_y", tab_1.tabpage_1.dw_1)
				kuf1_utility.u_proteggi_dw("0", "mis_z", tab_1.tabpage_1.dw_1)
				destroy kuf1_utility 
				
	//--- Attivo dw archivio Prodotto
				k_rc = this.getchild("cod_art", kdwc_articoli)
				if kdwc_articoli.rowcount() < 2 then
				
					kdwc_articoli.reset()
					kdwc_articoli.retrieve("%")
					kdwc_articoli.insertrow(1)
			
					k_rc = this.getchild("cod_art_des", kdwc_articoli_des)
				
					kdwc_articoli.RowsCopy(kdwc_articoli.GetRow(), kdwc_articoli.RowCount(), Primary!, kdwc_articoli_des, 1, Primary!)
				end if
				
			else
	
				messagebox("Operazione non consentita", MidA(k_errore, 2) ) 	
				
			end if
			
		catch (uo_exception kuo1_exception)
			kst_esito = kuo1_exception.get_st_esito()
			k_errore = "1" + kst_esito.sqlerrtext
			kuo1_exception.messaggio_utente()
			
		finally
			if isvalid(kuf1_listino) then destroy kuf1_listino
			if isvalid(kuf1_armo) then destroy kuf1_armo
			this.object.cb_key.enabled = true
			
		end try
		

	case "b_cond_fatt_1", "b_cond_fatt_2", "b_cond_fatt_3"
				
		//kuf_menu_window kuf1_menu_window
		
		if not isvalid(kdsi_elenco_output) then kdsi_elenco_output = create datastore
		kst_tab_cond_fatt.cod_cli = this.getitemnumber(this.getrow(), "cod_cli")

		kdsi_elenco_output.dataobject = kiuf_listino.kki_anteprima_cond_fatt_dw 
		kdsi_elenco_output.settransobject ( sqlca )
		kdsi_elenco_output.retrieve(kst_tab_cond_fatt.cod_cli) 

		if (kst_tab_cond_fatt.cod_cli) > 0 then
			kst_open_w.key1 = "Condizioni Listino Cliente: " + string(kst_tab_cond_fatt.cod_cli)
		else
			kst_open_w.key1 = "Condizioni Listini di Servizio " 
		end if

		if kdsi_elenco_output.rowcount() > 0 then
			
			kdsi_elenco_output.insertrow(1) 
				
			//--- chiamare la window di elenco
			//
			//=== Parametri : 
			//=== struttura st_open_w
				kst_open_w.id_programma =kkg_id_programma_elenco
				kst_open_w.flag_primo_giro = "S"
				kst_open_w.flag_modalita = kkg_flag_modalita.elenco
				kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
				kst_open_w.flag_leggi_dw = " "
				kst_open_w.flag_cerca_in_lista = " "
				kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
				kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
				kst_open_w.key4 = trim(kiw_this_window.title)   //--- Titolo della Window di chiamata per riconoscerla
				kst_open_w.key6 = dwo.name    //--- nome del campo cliccato
				kst_open_w.key7 = "S"    //--- chiude Window dopo scelta
				kst_open_w.key12_any = kdsi_elenco_output
				kst_open_w.flag_where = " "
				//kuf1_menu_window = create kuf_menu_window 
				kGuf_menu_window.open_w_tabelle(kst_open_w)
				//destroy kuf1_menu_window
			
		else
			
			messagebox("Elenco Dati", &
						"Nessun valore disponibile. ")
			
			
		end if



end choose


SetPointer(kp_oldpointer)

end event

event dw_1::clicked;call super::clicked;//
long k_cod_cli=0
st_tab_listino kst_tab_listino
st_tab_base kst_tab_base
kuf_base kuf1_base
datawindowchild  kdwc_contratto
//, kdwc_clienti, kdwc_clie_des, kdwc_articoli, kdwc_articoli_des

choose case lower(dwo.name)

	case "contratto"
		k_cod_cli = this.getitemnumber(this.getrow(), "cod_cli")
		
		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
	
	//--- Attivo dw archivio CONTRATTI
			this.getchild("contratto", kdwc_contratto)
		
			if ki_cod_cli <> k_cod_cli or kdwc_contratto.rowcount() < 2 then
	//			k_rc = kdwc_contratto.settransobject(sqlca)
				if k_cod_cli > 0 then
				else
					k_cod_cli = 0
				end if
				ki_cod_cli = k_cod_cli
				kdwc_contratto.retrieve(k_cod_cli, "*")
				kdwc_contratto.insertrow(1)
		
			end if
		end if 

//--- Calcolo Occupazione Pedana
	case "occup_ped_perc_t" 
		
		if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
			
			kst_tab_base.mis_x = getitemnumber( row, "mis_x")
			if kst_tab_base.mis_x > 0 then
				
				try 
					kuf1_base = create kuf_base
					
					kst_tab_base.mis_y = getitemnumber( row, "mis_y")
					kst_tab_base.mis_z = getitemnumber( row, "mis_z")
					kst_tab_listino.occup_ped = kuf1_base.get_occupazione_pedana(kst_tab_base)
					
					if kst_tab_listino.occup_ped > 0 then
						setitem( row, "occup_ped", kst_tab_listino.occup_ped)
					end if
				
				catch (uo_exception kuo_exception)
					kuo_exception.messaggio_utente()
					
				finally
					destroy kuf1_base
					
				end try
			
			end if
		end if

end choose




//
//
//	//--- Attivo dw archivio CLIENTI
//	case "rag_soc_10"
//		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
//			k_rc = this.getchild("cod_cli", kdwc_clienti)
//			if kdwc_clienti.rowcount() < 2 then
//				kdwc_clienti.retrieve("%")
//				k_rc = kdwc_clienti.insertrow(1)
//				
//				k_rc = this.getchild("rag_soc_10", kdwc_clie_des)
//				kdwc_clienti.RowsCopy(kdwc_clienti.GetRow(), kdwc_clienti.RowCount(), Primary!, kdwc_clie_des, 1, Primary!)
//			end if	
//		end if
//		
//
////--- Attivo dw archivio Prodotto
//	case "cod_art"
//		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
//			k_rc = this.getchild("cod_art", kdwc_articoli)
//			if kdwc_articoli.rowcount() < 2 then
//				kdwc_articoli.retrieve("%")
//				kdwc_articoli.insertrow(1)
//
//				k_rc = this.getchild("cod_art_des", kdwc_articoli_des)
//				kdwc_articoli.RowsCopy(kdwc_articoli.GetRow(), kdwc_articoli.RowCount(), Primary!,kdwc_articoli_des, 1, Primary!)
//			end if	
//		end if
//		
//end choose
//
//













end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
integer width = 3035
integer height = 1256
string text = "Prezzi "
long tabbackcolor = 32435950
string picturename = "FormatDollar!"
string powertiptext = "Entrate-Uscite di magazzino"
dw_10 dw_10
end type

on tabpage_2.create
this.dw_10=create dw_10
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_10
end on

on tabpage_2.destroy
call super::destroy
destroy(this.dw_10)
end on

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
boolean visible = true
integer x = 0
integer y = 28
integer width = 2981
integer height = 608
boolean enabled = true
string dataobject = "d_listino_link_pregruppi_l"
boolean hsplitscroll = false
boolean livescroll = false
end type

event dw_2::itemchanged;//
long k_riga
st_tab_listino_pregruppi_voci kst_tab_listino_pregruppi_voci
datawindowchild kdwc_1

choose case dwo.name 

	case "id_listino_pregruppo" 
		if len(trim(data)) > 0 then 
			this.getchild(dwo.name, kdwc_1)
			k_riga = kdwc_1.find( "id_listino_pregruppo = " + trim(data) + " " , 1, kdwc_1.rowcount())
			if k_riga > 0 then
				kst_tab_listino_pregruppi_voci.id_listino_pregruppo =  long(trim(data))
				post put_video_pregruppi(kst_tab_listino_pregruppi_voci)
				post put_video_retrieve_voci_prezzi()
			else
				this.setitem(row, "listino_pregruppo_descr", " " )
				this.modify( dwo.name + ".Background.Color = '" + string(kkg_colore.ERR_DATO) + "' ") 
			end if
		else
			this.setitem(row, "listino_pregruppo_descr", " " )
		end if

		post	attiva_tasti()
		
end choose 

	
end event

event dw_2::clicked;call super::clicked;//
string k_errore
int k_rc
kuf_listino kuf1_listino
kuf_utility kuf1_utility
st_tab_listino kst_tab_listino
st_tab_cond_fatt kst_tab_cond_fatt
st_esito kst_esito
st_open_w kst_open_w 
datawindowchild kdwc_articoli, kdwc_articoli_des

pointer kp_oldpointer  // Declares a pointer variable




choose case dwo.name


	case "b_cond_fatt_1"
				
		//kuf_menu_window kuf1_menu_window
		
		if not isvalid(kdsi_elenco_output) then kdsi_elenco_output = create datastore
		kst_tab_cond_fatt.cod_cli = tab_1.tabpage_1.dw_1.getitemnumber(this.getrow(), "cod_cli")

		kdsi_elenco_output.dataobject = kiuf_listino.kki_anteprima_cond_fatt_dw 
		kdsi_elenco_output.settransobject ( sqlca )
		kdsi_elenco_output.retrieve(kst_tab_cond_fatt.cod_cli) 

		if (kst_tab_cond_fatt.cod_cli) > 0 then
			kst_open_w.key1 = "Condizioni Listino Cliente: " + string(kst_tab_cond_fatt.cod_cli)
		else
			kst_open_w.key1 = "Condizioni Listini di Servizio " 
		end if

		if kdsi_elenco_output.rowcount() > 0 then
			
			kp_oldpointer = SetPointer(HourGlass!)
			
			kdsi_elenco_output.insertrow(1) 
				
			//--- chiamare la window di elenco
			//
			//=== Parametri : 
			//=== struttura st_open_w
				kst_open_w.id_programma =kkg_id_programma_elenco
				kst_open_w.flag_primo_giro = "S"
				kst_open_w.flag_modalita = kkg_flag_modalita.elenco
				kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
				kst_open_w.flag_leggi_dw = " "
				kst_open_w.flag_cerca_in_lista = " "
				kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
				kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
				kst_open_w.key4 = trim(kiw_this_window.title)   //--- Titolo della Window di chiamata per riconoscerla
				kst_open_w.key6 = dwo.name    //--- nome del campo cliccato
				kst_open_w.key7 = "S"    //--- chiude Window dopo scelta
				kst_open_w.key12_any = kdsi_elenco_output
				kst_open_w.flag_where = " "
				//kuf1_menu_window = create kuf_menu_window 
				kGuf_menu_window.open_w_tabelle(kst_open_w)
				//destroy kuf1_menu_window
			
				SetPointer(kp_oldpointer)
				
		else
			
			messagebox("Elenco Dati", &
						"Nessun valore disponibile. ")
			
		end if

end choose



end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;//
	if currentrow > 0 then
		if this.getitemnumber ( currentrow, "id_listino_link_pregruppo") > 0 then
	//				if this.getitemnumber ( newrow, "id_listino_link_pregruppo") > 0  then
			post put_video_retrieve_voci_prezzi()
	//				end if
	end if
end if



end event

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
integer x = 594
integer y = 136
integer height = 144
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
boolean visible = true
integer width = 3035
integer height = 1256
string text = "Condizioni"
string picturename = "help!"
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
boolean visible = true
integer width = 2967
integer height = 1232
boolean enabled = true
string dataobject = "d_cond_fatt_l"
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_attiva_standard_select_row = false
end type

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
integer width = 3035
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
boolean visible = true
integer width = 3035
integer height = 1256
string text = "Movimenti"
string picturename = "Deploy!"
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
boolean visible = true
integer x = 0
integer y = 24
integer width = 2935
integer height = 1172
boolean enabled = true
string dataobject = "d_armo_listino_l"
boolean controlmenu = true
end type

event dw_5::clicked;call super::clicked;//
datawindowchild kdwc_barcode

if row > 0 and dwo.Name = "barcode_elenco" then
	
	this.getchild("barcode_elenco", kdwc_barcode)

	kdwc_barcode.settransobject(sqlca)

	if this.rowcount() > 0 then

		if kdwc_barcode.retrieve(this.getitemnumber(row,"id_meca")) > 0 then

			kdwc_barcode.insertrow(0)
			
		end if
	else
		kdwc_barcode.insertrow(0)

	end if

end if

end event

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
integer width = 3035
integer height = 1256
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
end type

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
integer width = 3035
integer height = 1256
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
end type

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
integer width = 3035
integer height = 1256
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
integer width = 3035
integer height = 1256
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
end type

type st_duplica from w_g_tab_3`st_duplica within w_listino
end type

type dw_10 from uo_d_std_1 within tabpage_2
boolean visible = true
integer x = 18
integer y = 648
integer width = 2830
integer height = 584
integer taborder = 30
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string title = "Dettaglio Prezzi "
string dataobject = "d_listino_voci_prezzi_l_2"
boolean hsplitscroll = false
end type

event editchanged;call super::editchanged;//
attiva_menu( )

end event

event itemchanged;call super::itemchanged;//
long k_riga
st_tab_listino_prezzi kst_tab_listino_prezzi
datawindowchild kdwc_1

choose case dwo.name 

	case "id_listino_voce" 
		if len(trim(data)) > 0 then 
			this.getchild(dwo.name, kdwc_1)
			k_riga = kdwc_1.find( "id_listino_voce = " + trim(data) + " " , 1, kdwc_1.rowcount())
			if k_riga > 0 then
				kst_tab_listino_prezzi.id_listino_voce =  long(trim(data))
				post put_video_voci_prezzi(kst_tab_listino_prezzi)
			else
				this.setitem(row, "listino_voci_descr", " " )
				this.modify( dwo.name + ".Background.Color = '" + string(kkg_colore.ERR_DATO) + "' ") 
			end if
		else
			this.setitem(row, "listino_voci_descr", " " )
		end if

		
end choose 

post	attiva_tasti()
	
end event

event getfocus;call super::getfocus;//
this.Object.testata.color = kkg_colore.rosso

end event

event losefocus;call super::losefocus;//
this.Object.testata.color = kkg_colore.blu_scuro

end event

type ln_1 from line within tabpage_4
integer linethickness = 4
integer beginx = 361
integer beginy = 2376
integer endx = 2674
integer endy = 2376
end type

type dw_periodo from uo_d_std_1 within w_listino
integer x = 777
integer y = 620
integer width = 955
integer height = 504
integer taborder = 80
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string title = "Periodo di estrazione"
string dataobject = "d_periodo"
boolean controlmenu = true
boolean hsplitscroll = false
boolean livescroll = false
end type

event buttonclicked;call super::buttonclicked;//
st_stampe kst_stampe

	

try
	SetPointer(kkg.pointer_attesa)

	if dwo.name = "b_ok" then
		
		
		this.visible = false
		
		ki_data_ini  = this.getitemdate( 1, "data_dal")
		ki_data_fin  = this.getitemdate( 1, "data_al")
		inizializza_4()
	
	else
		if dwo.name = "b_annulla" then
	
			this.visible = false
		
		
		end if
	end if


catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()


finally
	SetPointer(kkg.pointer_default)

	
end try

end event

event ue_visibile;call super::ue_visibile;//
int k_rc

	this.width = long(this.object.data_al.x) + long(this.object.data_al.width) + 100
	this.height = long(this.object.b_ok.y) + long(this.object.b_ok.height) + 160

	this.x = (kiw_this_window.width  - this.width) / 4
	this.y = (kiw_this_window.height - this.height) / 4

	this.reset()
	k_rc = this.insertrow(0)
	k_rc = this.setitem(1, "data_dal", ki_data_ini)
	k_rc = this.setitem(1, "data_al", ki_data_fin)
//	this.modify("data_al.protect='1'")
//	this.modify("data_al.background.color='"+string(kkg_colore.grigio)+"'")
	this.visible = true
	this.setfocus()
end event

