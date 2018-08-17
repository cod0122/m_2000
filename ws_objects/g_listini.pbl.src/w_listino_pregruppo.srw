$PBExportHeader$w_listino_pregruppo.srw
forward
global type w_listino_pregruppo from w_g_tab_3
end type
end forward

global type w_listino_pregruppo from w_g_tab_3
boolean ki_fai_nuovo_dopo_insert = false
end type
global w_listino_pregruppo w_listino_pregruppo

type variables
//
private kuf_listino_pregruppo kiuf_listino_pregruppo
private kuf_listino_pregruppi_voci kiuf_listino_pregruppi_voci
private kuf_listino_link_pregruppi kiuf_listino_link_pregruppi

private int ki_selectedtab = 1

end variables

forward prototypes
protected function string inizializza () throws uo_exception
public subroutine leggi_dwc ()
protected function integer inserisci ()
protected subroutine riempi_id ()
protected subroutine open_start_window ()
protected function string aggiorna ()
protected subroutine inizializza_2 () throws uo_exception
protected subroutine inizializza_3 () throws uo_exception
protected function string check_dati ()
protected subroutine pulizia_righe ()
private subroutine put_video_listino_voci (long a_id)
private subroutine put_video_listino (long a_id)
protected function integer cancella ()
protected subroutine attiva_menu ()
private function boolean u_duplica ()
protected subroutine smista_funz (string k_par_in)
protected function integer visualizza ()
protected subroutine attiva_tasti_0 ()
end prototypes

protected function string inizializza () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_return="0 "
int k_rc 
st_tab_listino_pregruppo kst_tab_listino_pregruppo
st_esito kst_esito
kuf_utility kuf1_utility
pointer oldpointer  // Declares a pointer variable


ki_selectedtab = 1

if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)
//
//
	if LenA(trim(ki_st_open_w.key1)) = 0 then
		kst_tab_listino_pregruppo.id_listino_pregruppo = 0
	else
		kst_tab_listino_pregruppo.id_listino_pregruppo = long(trim(ki_st_open_w.key1))  // id listino Gruppo
	end if

	if LenA(trim(ki_st_open_w.key2)) = 0 or &
		isnull(trim(ki_st_open_w.key2)) then
		kst_tab_listino_pregruppo.id_listino_pregruppo_link = " "
	else
		kst_tab_listino_pregruppo.id_listino_pregruppo_link = trim(ki_st_open_w.key2) // id listino Gruppo collegato
	end if

//--- legge datawindowchild			
	leggi_dwc( )

//--- Se inserimento.... 
   if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento then
		post inserisci()
	else

//--- Se NO inserimento.... 
		k_rc = tab_1.tabpage_1.dw_1.retrieve( kst_tab_listino_pregruppo.id_listino_pregruppo ) 
		
		choose case k_rc

			case is < 0				
				messagebox("Operazione fallita", &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(ID cercato :" + trim(string(kst_tab_listino_pregruppo.id_listino_pregruppo)) + ")~n~r" )
				cb_ritorna.postevent(clicked!)

			case 0
	
				tab_1.tabpage_1.dw_1.reset()
				attiva_tasti()

				messagebox("Ricerca fallita", &
						"Mi spiace, il codice Listino non e' in archivio ~n~r" + &
					"(ID cercato: " + trim(string(kst_tab_listino_pregruppo.id_listino_pregruppo)) + ")~n~r" )

				cb_ritorna.triggerevent("clicked!")

			case is > 0		
				attiva_tasti()
		
		end choose

	end if

//--- se Modifica
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
		tab_1.tabpage_1.dw_1.setcolumn("descr")
		tab_1.tabpage_1.dw_1.setfocus()
	end if

	
//--- se NO inserimento leggo DW-CHILD
	if ki_st_open_w.flag_modalita <> kkg_flag_modalita.inserimento and tab_1.tabpage_1.dw_1.getrow() > 0 then

		tab_1.tabpage_1.dw_1.setredraw(false)

//--- Inabilita campi alla modifica se Vsualizzazione
		kuf1_utility = create kuf_utility 
		if trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.inserimento and trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.modifica then
		
			kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_1.dw_1)

		else		
			
//--- S-protezione campi per riabilitare la modifica a parte la chiave
	      	kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)

//--- Inabilita campo cliente per la modifica se Funzione MODIFICA
			if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
	
			end if
	
		end if
		destroy kuf1_utility
		
	
		tab_1.tabpage_1.dw_1.setredraw(true)
	
	end if
	
	
end if


return k_return 

end function

public subroutine leggi_dwc ();int k_rc
st_tab_listino_pregruppo kst_tab_listino_pregruppo
datawindowchild  kdwc_listino_pregruppo_link, kdwc_listino_pregruppo_link_1, kdwc_1



choose case ki_selectedtab

	case 1
		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
	
	//--- Attivo dw archivio GRUPPI LISTINO
			k_rc = tab_1.tabpage_1.dw_1.getchild("id_listino_pregruppo_link", kdwc_listino_pregruppo_link)
//			k_rc = tab_1.tabpage_1.dw_1.getchild("id_listino_pregruppo_link_1", kdwc_listino_pregruppo_link_1)
			if kdwc_listino_pregruppo_link.rowcount() < 2 then
				
				kst_tab_listino_pregruppo.id_listino_pregruppo = long(trim(ki_st_open_w.key1))  // id listino Gruppo
				if kst_tab_listino_pregruppo.id_listino_pregruppo > 0 then
				else
					kst_tab_listino_pregruppo.id_listino_pregruppo = 0
				end if
				kdwc_listino_pregruppo_link.retrieve(kst_tab_listino_pregruppo.id_listino_pregruppo)
				kdwc_listino_pregruppo_link.RowsCopy(kdwc_listino_pregruppo_link.GetRow(), kdwc_listino_pregruppo_link.RowCount(), Primary!,kdwc_listino_pregruppo_link_1, 1, Primary!)
				k_rc = kdwc_listino_pregruppo_link.insertrow(1)
		
			end if
		end if 


	case 3
		k_rc = tab_1.tabpage_3.dw_3.getchild("id_listino_voce", kdwc_1)
		k_rc = kdwc_1.settransobject(sqlca)
		if tab_1.tabpage_3.dw_3.ki_flag_modalita = kkg_flag_modalita.visualizzazione then
		else
			if kdwc_1.rowcount() < 2 then
				kdwc_1.retrieve(0 )
				kdwc_1.insertrow(1)
			end if
		end if
		
		
	case 4
		k_rc = tab_1.tabpage_4.dw_4.getchild("id_listino", kdwc_1)
		k_rc = kdwc_1.settransobject(sqlca)
		if tab_1.tabpage_4.dw_4.ki_flag_modalita = kkg_flag_modalita.visualizzazione then
		else
			k_rc = kdwc_1.rowcount()
			if kdwc_1.rowcount() < 2 then
				kdwc_1.retrieve(kguo_g.get_dataoggi())
				kdwc_1.insertrow(1)
			end if
		end if
		
		
end choose
		
end subroutine

protected function integer inserisci ();//
int k_return=1, k_ctr, k_rc
string k_errore="0 ", k_rcx
long k_riga 
st_tab_listino_pregruppo kst_tab_listino_pregruppo
kuf_utility kuf1_utility
//datawindowchild Kdwc_listino_pregruppo_link, Kdwc_listino_pregruppo_linke_des




//--- Aggiunge una riga al data windows
choose case tab_1.selectedtab 
	case  1 

		tab_1.tabpage_3.enabled = false
		tab_1.tabpage_4.enabled = false
		
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
			ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
			tab_1.tabpage_1.dw_1.ki_flag_modalita = kkg_flag_modalita.inserimento

//--- S-protezione campi per abilitare l'inserimento
			kuf1_utility = create kuf_utility
			kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)
			destroy kuf1_utility

			kst_tab_listino_pregruppo.id_listino_pregruppo_link = trim(trim(ki_st_open_w.key2))
		
			if tab_1.tabpage_1.dw_1.rowcount() > 0 then tab_1.tabpage_1.dw_1.reset() 
		
			tab_1.tabpage_1.dw_1.insertrow(0)
		
			tab_1.tabpage_1.dw_1.setcolumn(1)
		
			tab_1.tabpage_1.dw_1.setitem(1, "id_listino_pregruppo", 0)
			tab_1.tabpage_1.dw_1.setitem(1, "id_listino_pregruppo_link", 0)
			tab_1.tabpage_1.dw_1.SetItemStatus( 1, 0, Primary!, NotModified!)

			tab_1.tabpage_1.dw_1.setfocus()
			tab_1.tabpage_1.dw_1.setcolumn("descr")

		end if
			
			
	case 3  // listino Voci
		tab_1.tabpage_3.dw_3.ki_flag_modalita = kkg_flag_modalita.inserimento
	
//--- S-protezione campi per abilitare l'inserimento
		kuf1_utility = create kuf_utility
		kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_3.dw_3)
		kuf1_utility.u_proteggi_dw("0","id_listino_voce", tab_1.tabpage_3.dw_3)
		kuf1_utility.u_proteggi_dw("0","prezzo", tab_1.tabpage_3.dw_3)
		kuf1_utility.u_proteggi_dw("0","attivo", tab_1.tabpage_3.dw_3)
		destroy kuf1_utility

		k_riga = tab_1.tabpage_3.dw_3.insertrow(0)
		tab_1.tabpage_3.dw_3.setitem(k_riga, "id_listino_pregruppo_voce", 0)
		tab_1.tabpage_3.dw_3.setitem(k_riga, "id_listino_voce", 0)
		tab_1.tabpage_3.dw_3.setitem(k_riga, "id_listino_pregruppo", tab_1.tabpage_1.dw_1.getitemnumber(1, "id_listino_pregruppo"))
		tab_1.tabpage_3.dw_3.setitem(k_riga, "attivo", kiuf_listino_pregruppi_voci.kki_attivo_si )
		tab_1.tabpage_3.dw_3.SetItemStatus(k_riga, 0, Primary!, NotModified!)

		tab_1.tabpage_3.dw_3.setfocus()
		tab_1.tabpage_3.dw_3.setrow(k_riga)
		tab_1.tabpage_3.dw_3.setcolumn("id_listino_voce")

		
	case 4  // listino 
		tab_1.tabpage_4.dw_4.ki_flag_modalita = kkg_flag_modalita.inserimento

//--- S-protezione campi per abilitare l'inserimento
		kuf1_utility = create kuf_utility
		kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_4.dw_4)
		kuf1_utility.u_proteggi_dw("0","id_listino", tab_1.tabpage_4.dw_4)
		destroy kuf1_utility

		k_riga = tab_1.tabpage_4.dw_4.insertrow(0)
		tab_1.tabpage_4.dw_4.setitem(k_riga, "id_listino_link_pregruppo", 0)
		tab_1.tabpage_4.dw_4.setitem(k_riga, "id_listino", 0)
		tab_1.tabpage_4.dw_4.setitem(k_riga, "id_listino_pregruppo", tab_1.tabpage_1.dw_1.getitemnumber(1, "id_listino_pregruppo"))
		tab_1.tabpage_4.dw_4.SetItemStatus(k_riga, 0, Primary!, NotModified!)

		tab_1.tabpage_4.dw_4.setfocus()
		tab_1.tabpage_4.dw_4.setrow(k_riga)
		tab_1.tabpage_4.dw_4.setcolumn("id_listino")


		
end choose	

leggi_dwc( )

attiva_tasti()

k_return = 0


return (k_return)



end function

protected subroutine riempi_id ();//
//
long k_riga = 0
st_tab_listino_pregruppo kst_tab_listino_pregruppo



	k_riga = tab_1.tabpage_1.dw_1.getrow()
	
	if k_riga > 0 then
	
		kst_tab_listino_pregruppo.id_listino_pregruppo = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_listino_pregruppo")
	
//=== Se non sono in caricamento allora prelevo l'id_listino_pregruppo dalla dw
		if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> newmodified! then
			kst_tab_listino_pregruppo.id_listino_pregruppo = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_listino_pregruppo")
		end if
	
		if isnull(kst_tab_listino_pregruppo.id_listino_pregruppo) or kst_tab_listino_pregruppo.id_listino_pregruppo = 0 then				
			tab_1.tabpage_1.dw_1.setitem(k_riga, "id_listino_pregruppo", 0)
		end if

		tab_1.tabpage_1.dw_1.setitem(k_riga, "x_datins", kGuf_data_base.prendi_x_datins())
		tab_1.tabpage_1.dw_1.setitem(k_riga, "x_utente", kGuf_data_base.prendi_x_utente())

		
//--- altro TAB (Prezzi)
		if kst_tab_listino_pregruppo.id_listino_pregruppo > 0 then

			k_riga = tab_1.tabpage_3.dw_3.getnextmodified( 0, primary!)
			do while k_riga > 0

				if tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "id_listino_pregruppo_voce") > 0 then
				else
					tab_1.tabpage_3.dw_3.setitem(k_riga, "id_listino_pregruppo_voce", 0)
				end if
				
				if tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "id_listino_pregruppo") > 0 then
				else
					tab_1.tabpage_3.dw_3.setitem(k_riga, "id_listino_pregruppo" ,kst_tab_listino_pregruppo.id_listino_pregruppo)
				end if			
				
				tab_1.tabpage_3.dw_3.setitem(k_riga, "x_datins", kGuf_data_base.prendi_x_datins())
				tab_1.tabpage_3.dw_3.setitem(k_riga, "x_utente", kGuf_data_base.prendi_x_utente())
				
				k_riga = tab_1.tabpage_3.dw_3.getnextmodified( k_riga, primary!)
			loop
		end if
		
//--- altro TAB (LISTINO)
		if kst_tab_listino_pregruppo.id_listino_pregruppo > 0 then

			k_riga = tab_1.tabpage_4.dw_4.getnextmodified( 0, primary!)
			do while k_riga > 0

				if tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_listino_link_pregruppo") > 0 then
				else
					tab_1.tabpage_4.dw_4.setitem(k_riga, "id_listino_link_pregruppo", 0)
				end if
				
				if tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_listino_pregruppo") > 0 then
				else
					tab_1.tabpage_4.dw_4.setitem(k_riga, "id_listino_pregruppo" ,kst_tab_listino_pregruppo.id_listino_pregruppo)
				end if			
				
				tab_1.tabpage_4.dw_4.setitem(k_riga, "x_datins", kGuf_data_base.prendi_x_datins())
				tab_1.tabpage_4.dw_4.setitem(k_riga, "x_utente", kGuf_data_base.prendi_x_utente())
				
				k_riga = tab_1.tabpage_4.dw_4.getnextmodified( k_riga, primary!)
			loop
		end if


	end if

		
end subroutine

protected subroutine open_start_window ();//
int k_rc
datawindowchild  kdwc_listino_pregruppo_link_des, kdwc_listino_pregruppo_link



	kiuf_listino_pregruppo = create kuf_listino_pregruppo
	kiuf_listino_pregruppi_voci = create kuf_listino_pregruppi_voci
	kiuf_listino_link_pregruppi = create kuf_listino_link_pregruppi

	ki_toolbar_window_presente=true

	tab_1.tabpage_3.dw_3.ki_flag_modalita = kkg_flag_modalita.visualizzazione 
	tab_1.tabpage_4.dw_4.ki_flag_modalita = kkg_flag_modalita.visualizzazione 


//--- Attivo dw archivio Prodotto
	k_rc = tab_1.tabpage_1.dw_1.getchild("id_listino_pregruppo_link", kdwc_listino_pregruppo_link)

	k_rc = kdwc_listino_pregruppo_link.settransobject(sqlca)

	kdwc_listino_pregruppo_link.insertrow(1)

//	k_rc = tab_1.tabpage_1.dw_1.getchild("id_listino_pregruppo_link_1", kdwc_listino_pregruppo_link_des)
//
//	k_rc = kdwc_listino_pregruppo_link_des.settransobject(sqlca)



end subroutine

protected function string aggiorna ();//
//---------------------------------------------------------------------=
//--- Aggiorna tabelle 
//--- Ritorna 1 chr : 0=tutto OK; 1=errore grave I-O;
//--- 				  : 2=
//---					  : 3=Commit fallita
//---		dal char 2 in poi spiegazione dell'errore
//---------------------------------------------------------------------=

string k_return="0 ", k_errore="0 "
st_tab_listino_pregruppo kst_tab_listino_pregruppo
boolean k_new_rec
st_esito kst_esito

//--- 
choose case tab_1.selectedtab 

	case 1,3,4 

//--- Aggiorna, se modificato, la TAB_1	
		if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0 then
			if tab_1.tabpage_1.dw_1.GetItemStatus(1, 0,  primary!) = NewModified!	then
				k_new_rec = true
			else
				k_new_rec = false
			end if

			if tab_1.tabpage_1.dw_1.update() = 1 then 

//--- Se tutto OK faccio la COMMIT		
				kst_esito = kguo_sqlca_db_magazzino.db_commit()
				if kst_esito.esito <> kkg_esito.ok then
					k_return = "3" + "Archivio " + tab_1.tabpage_1.text + " ~n~rErrore: " + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) 
		
				else // Tutti i Dati Caricati in Archivio
					k_return ="0 "

//--- Se nuova riga Imposto il campo Contatore ID (SERIAL)				
					if k_new_rec then
						
						try 
							kst_tab_listino_pregruppo.id_listino_pregruppo = kiuf_listino_pregruppo.get_ultimo_id()	
							tab_1.tabpage_1.dw_1.setitem(1, "id_listino_pregruppo", kst_tab_listino_pregruppo.id_listino_pregruppo)
							tab_1.tabpage_1.dw_1.resetupdate( )
							
						catch (uo_exception kuo_exception)
							kuo_exception.messaggio_utente()
							
						end try
						
					end if
				end if
			else
				kguo_sqlca_db_magazzino.db_rollback( )
				k_return="1Fallito aggiornamento archivio '" + tab_1.tabpage_1.text 
			end if
		end if

		
//--- Aggiorna, se modificato, altro tab  VOCI-PREZZI
		if left(k_return,1) = "0" and tab_1.tabpage_3.dw_3.getnextmodified(0, primary!) > 0 	then
		
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
		
//--- Aggiorna, se modificato, altro tab  ASSOCIAZIONI-LISTINO
		if left(k_return,1) = "0" and tab_1.tabpage_4.dw_4.getnextmodified(0, primary!) > 0 	then
		
			if tab_1.tabpage_4.dw_4.update() = 1 then

//--- Se tutto OK faccio la COMMIT		
				kst_esito = kguo_sqlca_db_magazzino.db_commit()
				if kst_esito.esito = kkg_esito.db_ko then
					k_return = "3" + "Archivio " + tab_1.tabpage_4.text + " " + kst_esito.sqlerrtext
				else // Tutti i Dati Caricati in Archivio
					k_return ="0 "
				end if
			else
				kst_esito = kguo_sqlca_db_magazzino.db_rollback()
				k_return="1Fallito aggiornamento archivio '" + tab_1.tabpage_4.text + "' ~n~r" 
			end if	
		end if

//--- Se tutto ok
		if left(k_return,1) = "0" then
			tab_1.tabpage_3.enabled = true
			tab_1.tabpage_4.enabled = true
		end if
		
end choose

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


return k_return

end function

protected subroutine inizializza_2 () throws uo_exception;//
//======================================================================
//=== Inizializzazione del TAB 3 controllandone i valori se gia' presenti
//======================================================================
//
long  k_rc
string k_codice_attuale, k_codice_prec
st_tab_listino_pregruppo kst_tab_listino_pregruppo
kuf_utility kuf1_utility


ki_selectedtab = 3


kst_tab_listino_pregruppo.id_listino_pregruppo = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_listino_pregruppo") //misura

if kst_tab_listino_pregruppo.id_listino_pregruppo > 0 then

	//--- attiva DWC
	leggi_dwc( )
	
	//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
	if not isnull(tab_1.tabpage_3.st_3_retrieve.text) then
		k_codice_prec = tab_1.tabpage_3.st_3_retrieve.text
	else
		k_codice_prec = " "
	end if
	
	k_codice_attuale = string(kst_tab_listino_pregruppo.id_listino_pregruppo) 
	
	//=== Forza valore Codice composto per ricordarlo per le prossime richieste
	tab_1.tabpage_3.st_3_retrieve.text = k_codice_attuale
	
	if k_codice_attuale <> k_codice_prec then
	
		k_rc = tab_1.tabpage_3.dw_3.retrieve( kst_tab_listino_pregruppo.id_listino_pregruppo)

	
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

protected subroutine inizializza_3 () throws uo_exception;//
//---------------------------------------------------------------------=
//--- Inizializzazione del TAB 3 controllandone i valori se gia' presenti
//---------------------------------------------------------------------=
//
long  k_key, k_rc
string k_codice_attuale, k_codice_prec
st_tab_listino_pregruppo kst_tab_listino_pregruppo
kuf_utility kuf1_utility


ki_selectedtab = 4


kst_tab_listino_pregruppo.id_listino_pregruppo = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_listino_pregruppo") //misura

if kst_tab_listino_pregruppo.id_listino_pregruppo > 0 then

//--- attiva DWC
	leggi_dwc( )
	

	//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
	if not isnull(tab_1.tabpage_4.st_4_retrieve.text) then
		k_codice_prec = tab_1.tabpage_4.st_4_retrieve.text
	else
		k_codice_prec = " "
	end if
	
	k_codice_attuale = string(kst_tab_listino_pregruppo.id_listino_pregruppo) 
	
	//--- Forza valore Codice composto per ricordarlo per le prossime richieste
	tab_1.tabpage_4.st_4_retrieve.text = k_codice_attuale
	
	if k_codice_attuale <> k_codice_prec then
	
		k_rc = tab_1.tabpage_4.dw_4.retrieve( kst_tab_listino_pregruppo.id_listino_pregruppo)

	
	end if				

end if

					
//--- Inabilita campi alla modifica se Visualizzazione
kuf1_utility = create kuf_utility 
if tab_1.tabpage_4.dw_4.ki_flag_modalita = kkg_flag_modalita.visualizzazione then 
	kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_4.dw_4)
else
		kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_4.dw_4)
end if
destroy kuf1_utility


attiva_tasti()


tab_1.tabpage_4.dw_4.setfocus()


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
st_esito kst_esito
datastore kds_inp

try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kds_inp = create datastore

//--- Controllo il primo tab
	if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0 then
		kds_inp.dataobject = tab_1.tabpage_1.dw_1.dataobject
		tab_1.tabpage_1.dw_1.rowscopy( 1,tab_1.tabpage_1.dw_1.rowcount( ) ,primary!, kds_inp, 1, primary!)
		kst_esito = kiuf_listino_pregruppo.u_check_dati(kds_inp)
	end if
	
//--- Controllo altro tab
	if  tab_1.tabpage_3.dw_3.enabled then
		if tab_1.tabpage_3.dw_3.getnextmodified(0, primary!) > 0 then
			kds_inp.dataobject = tab_1.tabpage_3.dw_3.dataobject
			tab_1.tabpage_3.dw_3.rowscopy( 1,tab_1.tabpage_3.dw_3.rowcount( ) ,primary!, kds_inp, 1, primary!)
			kst_esito = kiuf_listino_pregruppi_voci.u_check_dati_1(kds_inp)
		end if	
	end if	

//--- Controllo altro tab
	if  tab_1.tabpage_4.dw_4.enabled then
		if tab_1.tabpage_4.dw_4.getnextmodified(0, primary!) > 0 then
			kds_inp.dataobject = tab_1.tabpage_4.dw_4.dataobject
			tab_1.tabpage_4.dw_4.rowscopy( 1,tab_1.tabpage_4.dw_4.rowcount( ) ,primary!, kds_inp, 1, primary!)
			kst_esito = kiuf_listino_link_pregruppi.u_check_dati(kds_inp)
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

protected subroutine pulizia_righe ();//
long k_riga

//--- Pulizia dei rek non validi sui vari TAB
	if tab_1.tabpage_3.dw_3.getrow() > 0 then
		k_riga = tab_1.tabpage_3.dw_3.getnextmodified( 0, primary!)
		do while k_riga > 0

			if tab_1.tabpage_3.dw_3.getitemnumber ( k_riga, "id_listino_voce") > 0 then
			else
		
				tab_1.tabpage_3.dw_3.deleterow(k_riga)
				k_riga --
			end if

			k_riga = tab_1.tabpage_3.dw_3.getnextmodified( k_riga, primary!)
		loop
	end if
	
	
//--- Pulizia dei rek non validi sui vari TAB
	if tab_1.tabpage_4.dw_4.getrow() > 0 then
		k_riga = tab_1.tabpage_4.dw_4.getnextmodified( 0, primary!)
		do while k_riga > 0

			if tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "id_listino") > 0 then
			else
		
				tab_1.tabpage_4.dw_4.deleterow(k_riga)
				k_riga --
			end if

			k_riga = tab_1.tabpage_4.dw_4.getnextmodified( k_riga, primary!)
		loop
	end if
	
end subroutine

private subroutine put_video_listino_voci (long a_id);//
//--- Visualizza dati Voci Prezzi
//
long k_riga=0, k_riga_dwc
datawindowchild kdwc_1


k_riga = tab_1.tabpage_3.dw_3.getrow()

//tab_1.tabpage_3.dw_3.modify("id_listino_voce.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
tab_1.tabpage_3.dw_3.setitem(k_riga, "id_listino_voce", a_id )

tab_1.tabpage_3.dw_3.getchild("id_listino_voce", kdwc_1)
k_riga_dwc = kdwc_1.find( "id_listino_voce = " + string(a_id) + " " , 1, kdwc_1.rowcount())
if k_riga_dwc > 0 then
	tab_1.tabpage_3.dw_3.setitem(k_riga, "listino_voci_descr", kdwc_1.getitemstring(k_riga_dwc, "descr")  )
	tab_1.tabpage_3.dw_3.setitem(k_riga, "listino_voci_attivo", kdwc_1.getitemstring(k_riga_dwc, "attivo")  )
	tab_1.tabpage_3.dw_3.setitem(k_riga, "listino_voci_tipo_listino", kdwc_1.getitemstring(k_riga_dwc, "tipo_listino")  )
	tab_1.tabpage_3.dw_3.setitem(k_riga, "listino_voci_tipo_calcolo", kdwc_1.getitemstring(k_riga_dwc, "tipo_calcolo")  )
	tab_1.tabpage_3.dw_3.setitem(k_riga, "listino_voci_um", kdwc_1.getitemstring(k_riga_dwc, "um")  )
	tab_1.tabpage_3.dw_3.setitem(k_riga, "listino_voci_id_listino_voci_categ", kdwc_1.getitemstring(k_riga_dwc, "id_listino_voci_categ")  )
else
	tab_1.tabpage_3.dw_3.setitem(k_riga, "listino_voci_descr", "???????? " )
	tab_1.tabpage_3.dw_3.setitem(k_riga, "listino_voci_attivo", "" )
	tab_1.tabpage_3.dw_3.setitem(k_riga, "listino_voci_tipo_listino", "")
	tab_1.tabpage_3.dw_3.setitem(k_riga, "listino_voci_tipo_calcolo",  "" )
	tab_1.tabpage_3.dw_3.setitem(k_riga, "listino_voci_um",  "")
	tab_1.tabpage_3.dw_3.setitem(k_riga, "listino_voci_id_listino_voci_categ",  "")
end if



end subroutine

private subroutine put_video_listino (long a_id);//
//--- Visualizza dati Voci Prezzi
//
long k_riga=0, k_riga_dwc
datawindowchild kdwc_1


k_riga = tab_1.tabpage_4.dw_4.getrow()

//tab_1.tabpage_4.dw_4.modify("id_listino.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
tab_1.tabpage_4.dw_4.setitem(k_riga, "id_listino", a_id )

tab_1.tabpage_4.dw_4.getchild("id_listino", kdwc_1)
k_riga_dwc = kdwc_1.find( "id_listino = " + string(a_id) + " " , 1, kdwc_1.rowcount())
if k_riga_dwc > 0 then
	tab_1.tabpage_4.dw_4.setitem(k_riga, "rag_soc_10", kdwc_1.getitemstring(k_riga_dwc, "rag_soc_10")  )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "cod_cli", kdwc_1.getitemnumber(k_riga_dwc, "cod_cli")  )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "cod_art", kdwc_1.getitemstring(k_riga_dwc, "cod_art")  )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "prodotti_des", kdwc_1.getitemstring(k_riga_dwc, "prodotti_des")  )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "contratto", kdwc_1.getitemnumber(k_riga_dwc, "contratto")  )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "mc_co", kdwc_1.getitemstring(k_riga_dwc, "mc_co")  )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "sc_cf", kdwc_1.getitemstring(k_riga_dwc, "sc_cf")  )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "sl_pt", kdwc_1.getitemstring(k_riga_dwc, "sl_pt")  )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "prodotti_gruppo", kdwc_1.getitemnumber(k_riga_dwc, "gruppo")  )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "dose", kdwc_1.getitemnumber(k_riga_dwc, "dose")  )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "magazzino", kdwc_1.getitemnumber(k_riga_dwc, "magazzino")  )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "occup_ped", kdwc_1.getitemnumber(k_riga_dwc, "occup_ped")  )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "campione", kdwc_1.getitemstring(k_riga_dwc, "campione")  )
else
	tab_1.tabpage_4.dw_4.setitem(k_riga, "rag_soc_10", "????????")
	tab_1.tabpage_4.dw_4.setitem(k_riga, "cod_cli", 0)
	tab_1.tabpage_4.dw_4.setitem(k_riga, "cod_art", "")
	tab_1.tabpage_4.dw_4.setitem(k_riga, "prodotti_des", "")
	tab_1.tabpage_4.dw_4.setitem(k_riga, "contratto", 0)
	tab_1.tabpage_4.dw_4.setitem(k_riga, "mc_co", "")
	tab_1.tabpage_4.dw_4.setitem(k_riga, "sc_cf", "")
	tab_1.tabpage_4.dw_4.setitem(k_riga, "sl_pt", "")
	tab_1.tabpage_4.dw_4.setitem(k_riga, "prodotti_gruppo", 0)
	tab_1.tabpage_4.dw_4.setitem(k_riga, "dose", 0)
	tab_1.tabpage_4.dw_4.setitem(k_riga, "magazzino", 0)
	tab_1.tabpage_4.dw_4.setitem(k_riga, "occup_ped", 0)
	tab_1.tabpage_4.dw_4.setitem(k_riga, "campione", "")
end if



end subroutine

protected function integer cancella ();//
//=== Cancellazione rekord dal DB
//=== Ritorna : 0=OK 1=KO 2=non eseguita
//
int k_return=0
string k_desc,k_desc_1,  k_record, k_record_1
long k_key = 0, k_id_listino_pregruppo=0
string k_listino_pregruppo_descr
string k_errore = "0 ",  k_nro_fatt
long k_riga, k_seq
date k_data
st_esito kst_esito
st_tab_listino_pregruppo kst_tab_listino_pregruppo
st_tab_listino_pregruppi_voci kst_tab_listino_pregruppi_voci
st_tab_listino_link_pregruppi kst_tab_listino_link_pregruppi



//=== 
choose case tab_1.selectedtab 

	case 1 
		k_record = " Gruppo "
		k_riga = tab_1.tabpage_1.dw_1.getrow()	
		if k_riga > 0 then
			if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> new! and &
				tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
				k_key = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_listino_pregruppo")
				k_desc = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "descr")
				if isnull(k_desc) = true or trim(k_desc) = "" then
					k_desc = "senza descrizione" 
				end if
				k_record_1 = &
					"Sei sicuro di voler eliminare la Gruppo~n~r" + &
					string(k_key, "#####") +  &
					"~n~r" + trim(k_desc) + " ?"
			else
				tab_1.tabpage_1.dw_1.deleterow(k_riga)
			end if
		end if
		
	case 3 
		k_record = " Voce "
		k_riga = tab_1.tabpage_3.dw_3.getrow()	
		if k_riga > 0 then
			if tab_1.tabpage_3.dw_3.getitemstatus(k_riga, 0, primary!) <> new! and &
				tab_1.tabpage_3.dw_3.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
				k_key = tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "id_listino_pregruppo_voce")
				k_desc_1 = string(tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "id_listino_voce"))
				k_desc = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "listino_voci_descr")
				if isnull(k_desc) = true or trim(k_desc) = "" then
					k_desc = "senza descrizione" 
				end if
				k_record_1 = &
					"Sei sicuro di voler rimuovere da questo Gruppo la Voce~n~r" + &
					trim(k_desc_1) + " (id=" + &
					string(k_key, "#####") + ") " + &
					"~n~r" + trim(k_desc) + " ?"
			else
				tab_1.tabpage_3.dw_3.deleterow(k_riga)
			end if
		end if
		
	case 4
		k_record = "  "
		k_riga = tab_1.tabpage_4.dw_4.getrow()	
		if k_riga > 0 then
			if tab_1.tabpage_4.dw_4.getitemstatus(k_riga, 0, primary!) <> new! and &
				tab_1.tabpage_4.dw_4.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
				k_key = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_listino_link_pregruppo")
				k_desc_1 = string(tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_listino"))
				k_desc = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "rag_soc_10")
				k_record_1 = &
					"Sei sicuro di voler rimuovere da questo Gruppo il Listino~n~r" + &
					trim(k_desc_1) + " (id=" + &
					string(k_key, "#####") + ") di " + &
					+ trim(k_desc) + " ?"
			else
				tab_1.tabpage_4.dw_4.deleterow(k_riga)
			end if
		end if
end choose	



//=== Se righe in lista
if k_riga > 0 and k_key > 0 then
	
//--- Richiesta di conferma della eliminazione del rek
	if messagebox("Elimina" + k_record, k_record_1, &
		question!, yesno!, 2) = 1 then
 
 
 		try
			
//--- Rimozione in tab
			choose case tab_1.selectedtab 
				case 1 
					kst_tab_listino_pregruppo.id_listino_pregruppo = k_key
					kiuf_listino_pregruppo.tb_delete(kst_tab_listino_pregruppo) 
				case 3
					kst_tab_listino_pregruppi_voci.id_listino_pregruppo_voce = k_key
					kiuf_listino_pregruppi_voci.tb_delete(kst_tab_listino_pregruppi_voci) 
				case 4
					kst_tab_listino_link_pregruppi.id_listino_link_pregruppo = k_key
					kiuf_listino_link_pregruppi.tb_delete(kst_tab_listino_link_pregruppi) 
			end choose	
		
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
				messagebox("Problemi durante la Cancellazione !!", &
					"Controllare i dati. " + trim(kst_esito.sqlerrtext))

			else
				
				choose case tab_1.selectedtab 
					case 1 
						tab_1.tabpage_1.dw_1.deleterow(k_riga)
					case 3 
						tab_1.tabpage_3.dw_3.deleterow(k_riga)
					case 4 
						tab_1.tabpage_4.dw_4.deleterow(k_riga)
				end choose	

			end if

		else
			k_return = 1
			kst_esito = kguo_sqlca_db_magazzino.db_rollback()

			messagebox("Problemi durante Cancellazione - Operazione fallita !!", mid(k_errore, 2) ) 	
			if kst_esito.esito <> kkg_esito.ok then
				messagebox("Problemi durante il recupero dell'errore !!", &
					"Controllare i dati. " + trim(kst_esito.sqlerrtext))
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
		tab_1.tabpage_1.dw_1.ResetUpdate ( ) 
	case 3
		tab_1.tabpage_3.dw_3.setfocus()
		tab_1.tabpage_3.dw_3.setcolumn(1)
		tab_1.tabpage_3.dw_3.ResetUpdate ( ) 
	case 4
		tab_1.tabpage_4.dw_4.setfocus()
		tab_1.tabpage_4.dw_4.setcolumn(1)
		tab_1.tabpage_4.dw_4.ResetUpdate ( ) 
end choose	


return k_return

end function

protected subroutine attiva_menu ();//--- Attiva/Dis. Voci di menu



//--- Attiva/Dis. Voci di menu personalizzate

	if not ki_menu.m_strumenti.m_fin_gest_libero2.visible then
	
		ki_menu.m_strumenti.m_fin_gest_libero2.text = "Genera un nuovo Gruppo Listino come quello selezionato"
		ki_menu.m_strumenti.m_fin_gest_libero2.microhelp =  "Duplica Gruppo listino"
		ki_menu.m_strumenti.m_fin_gest_libero2.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero2.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemText = "Duplica,"+ki_menu.m_strumenti.m_fin_gest_libero2.text
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName =  "Copy!"
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
		
	end if
//---
	super::attiva_menu()

end subroutine

private function boolean u_duplica ();//
boolean k_return = false
//string k_errore = "0 ", k_errore1 = "0 "
long k_riga
st_tab_listino_pregruppo kst_tab_listino_pregruppo
st_tab_clienti kst_tab_clienti
st_esito kst_esito


if tab_1.tabpage_1.dw_1.rowcount() > 0 then
	k_riga = 	1
	
	kst_tab_listino_pregruppo.id_listino_pregruppo = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_listino_pregruppo")
	kst_tab_listino_pregruppo.descr  = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "descr")

	if isnull(kst_tab_listino_pregruppo.descr) = true or trim(kst_tab_listino_pregruppo.descr) = "" then
		kst_tab_listino_pregruppo.descr = "Gruppo listino senza descrizione " 
	end if
	
//=== Richiesta di conferma operazione
	if messagebox("Duplica", "Sei sicuro di voler DUPLICARE questo gruppo: ~n~r" &
	         + string(kst_tab_listino_pregruppo.id_listino_pregruppo, "#####") + " - " + trim(kst_tab_listino_pregruppo.descr),  &
				question!, yesno!, 2) = 1 then
		
		
		try
		
//=== Duplica la riga dal data windows di lista
		kst_tab_listino_pregruppo.st_tab_g_0.esegui_commit = "S"
		if kiuf_listino_pregruppo.tb_duplica( kst_tab_listino_pregruppo ) then

				k_return = true
		
				ki_st_open_w.key1 = string(kiuf_listino_pregruppo.get_ultimo_id( ))
				ki_st_open_w.key2 = ""
				tab_1.tabpage_1.dw_1.reset( )
				inizializza( )
//				kguo_exception.inizializza( )
//				kguo_exception.messaggio_utente( "Duplica", "Gruppo Listino duplicato")

				tab_1.tabpage_1.dw_1.setfocus()
			else
				kguo_exception.inizializza( )
				kguo_exception.messaggio_utente( "Duplica", "Operazione non eseguita")
			end if

			
		catch (uo_exception kuo_exception)
			kuo_exception.messaggio_utente( "Duplica Fallita","")

			attiva_tasti()

		end try


	else
		kguo_exception.inizializza( )
		kguo_exception.messaggio_utente( "Duplica", "Operazione Annullata")

	end if
end if



return k_return

end function

protected subroutine smista_funz (string k_par_in);//
//===

choose case trim(k_par_in) 
		
	case KKG_FLAG_RICHIESTA.libero2		//duplica riga
		u_duplica( )

	case else
		super::smista_funz(k_par_in)

end choose



end subroutine

protected function integer visualizza ();//
datastore kds_1
kuf_menu_window kuf1_menu_window


try

	choose case ki_selectedtab 

		case 4 

			if tab_1.tabpage_4.dw_4.getrow( ) > 0 then
				
		//--- call della window che esegue la funzione
				kds_1 = create datastore
				kds_1.dataobject = tab_1.tabpage_4.dw_4.dataobject
				tab_1.tabpage_4.dw_4.rowscopy( tab_1.tabpage_4.dw_4.getrow( ) , tab_1.tabpage_4.dw_4.getrow( ), primary!, kds_1, 1, primary!)
		
				kuf1_menu_window = create kuf_menu_window
				kuf1_menu_window.open_w_tabelle_da_ds(kds_1, kkg_flag_modalita.visualizzazione)
			else
				kguo_exception.inizializza( )
				kguo_exception.messaggio_utente( "Operazione di Visualizzazione", "Selezionare prima una riga dall'elenco")
			end if

	end choose
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

return 0
end function

protected subroutine attiva_tasti_0 ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================


super::attiva_tasti_0()


	cb_ritorna.default = false

	choose case tab_1.selectedtab
		case 1
			if trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.visualizzazione then
				cb_modifica.enabled = false
				if tab_1.tabpage_1.dw_1.rowcount() = 0 then
					cb_inserisci.enabled = true
					cb_inserisci.default = true
					cb_cancella.enabled = false
					cb_aggiorna.enabled = false
				end if
			end if            
			
		case 3
			if trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.visualizzazione then
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
			end if            
			
		case 4
			if tab_1.tabpage_1.dw_1.rowcount() = 0 then
				cb_inserisci.enabled = false
				cb_inserisci.default = false
				cb_cancella.enabled = false
				cb_aggiorna.enabled = false
				cb_modifica.enabled = false
			else
				if tab_1.tabpage_4.dw_4.rowcount() > 0 then
					cb_modifica.enabled = true
					cb_visualizza.enabled = true
					cb_inserisci.enabled = false
					cb_cancella.enabled = false
					cb_aggiorna.enabled = false
				end if
			end if
	
		case else
			cb_inserisci.enabled = false
			cb_inserisci.default = false
			cb_aggiorna.enabled = false
			cb_aggiorna.enabled = false
	end choose



end subroutine

on w_listino_pregruppo.create
call super::create
end on

on w_listino_pregruppo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type st_ritorna from w_g_tab_3`st_ritorna within w_listino_pregruppo
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_listino_pregruppo
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_listino_pregruppo
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_listino_pregruppo
end type

type st_stampa from w_g_tab_3`st_stampa within w_listino_pregruppo
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_listino_pregruppo
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_listino_pregruppo
end type

event cb_modifica::clicked;//
//if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
//	
//	choose case ki_selectedtab
//			
//		case 3
//			tab_1.tabpage_3.dw_3.ki_flag_modalita = kkg_flag_modalita.modifica
//			inizializza_lista( )
//			
//		case 4
//			tab_1.tabpage_4.dw_4.ki_flag_modalita = kkg_flag_modalita.modifica
//			inizializza_lista( )
//		
//	end choose
//	
//end if
datastore kds_1
kuf_menu_window kuf1_menu_window
kuf_utility kuf1_utility

try
			
	choose case ki_selectedtab

		case 4 

			if tab_1.tabpage_4.dw_4.getrow( ) > 0 then
				
		//--- call della window che esegue la funzione
				kds_1 = create datastore
				kds_1.dataobject = tab_1.tabpage_4.dw_4.dataobject
				tab_1.tabpage_4.dw_4.rowscopy( tab_1.tabpage_4.dw_4.getrow( ) , tab_1.tabpage_4.dw_4.getrow( ), primary!, kds_1, 1, primary!)
		
				kuf1_menu_window = create kuf_menu_window
				kuf1_menu_window.open_w_tabelle_da_ds(kds_1, kkg_flag_modalita.modifica)
			else
				kguo_exception.inizializza( )
				kguo_exception.messaggio_utente( "Operazione di Modifica", "Selezionare prima una riga dall'elenco")
			end if
			
			
			
	end choose
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try


end event

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_listino_pregruppo
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_listino_pregruppo
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_listino_pregruppo
end type

type tab_1 from w_g_tab_3`tab_1 within w_listino_pregruppo
integer weight = 700
fontcharset fontcharset = ansi!
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
string text = "Gruppo"
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
string dataobject = "d_listino_pregruppo"
end type

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
boolean visible = false
boolean enabled = false
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
end type

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
boolean visible = true
string text = "Voci"
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
boolean visible = true
boolean enabled = true
string dataobject = "d_listino_pregruppi_voci_l_1"
end type

event dw_3::itemchanged;//
long k_riga
st_tab_listino_voci kst_tab_listino_voci
datawindowchild kdwc_1

choose case dwo.name 

	case "id_listino_voce" 
		if len(trim(data)) > 0 then 
			kst_tab_listino_voci.id_listino_voce =  long(trim(data))
			post put_video_listino_voci(kst_tab_listino_voci.id_listino_voce)
		else
			this.setitem(row, "listino_voci_descr", " " )
		end if

		
end choose 

post	attiva_tasti()
	
end event

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
boolean visible = true
string text = "Listini"
end type

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
boolean visible = true
boolean enabled = true
string dataobject = "d_listino_pregruppo_listini"
end type

event dw_4::itemchanged;//
long k_riga
st_tab_listino_link_pregruppi kst_tab_listino_link_pregruppi
datawindowchild kdwc_1

choose case dwo.name 

	case "id_listino" 
		if len(trim(data)) > 0 then 
			kst_tab_listino_link_pregruppi.id_listino =  long(trim(data))
			post put_video_listino(kst_tab_listino_link_pregruppi.id_listino)
		else
			this.setitem(row, "rag_soc_10", " " )
		end if

		
end choose 

post	attiva_tasti()

end event

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
boolean enabled = false
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
end type

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
end type

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
end type

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
end type

