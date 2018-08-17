$PBExportHeader$w_listino_voci.srw
forward
global type w_listino_voci from w_g_tab_3
end type
end forward

global type w_listino_voci from w_g_tab_3
boolean ki_fai_nuovo_dopo_update = false
boolean ki_fai_nuovo_dopo_insert = false
boolean ki_fai_inizializza_dopo_update = true
end type
global w_listino_voci w_listino_voci

type variables
//
private kuf_listino_voci kiuf_listino_voci
private int ki_selectedtab=1
end variables

forward prototypes
protected function string inizializza () throws uo_exception
public subroutine leggi_dwc ()
protected function integer inserisci ()
protected subroutine riempi_id ()
protected subroutine open_start_window ()
protected function string aggiorna ()
protected subroutine inizializza_1 () throws uo_exception
protected function integer cancella ()
protected subroutine pulizia_righe ()
protected function string check_dati ()
private subroutine put_video_pregruppi (st_tab_listino_pregruppi_voci kst_tab_listino_pregruppi_voci)
end prototypes

protected function string inizializza () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_return="0 "
int k_rc 
st_tab_listino_voci kst_tab_listino_voci
st_esito kst_esito
kuf_utility kuf1_utility
//
pointer oldpointer  // Declares a pointer variable

ki_selectedtab=1

if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)
//
//
	if LenA(trim(ki_st_open_w.key1)) = 0 then
		kst_tab_listino_voci.id_listino_voce = 0
	else
		kst_tab_listino_voci.id_listino_voce = long(trim(ki_st_open_w.key1))  // id listino voce
	end if

	if LenA(trim(ki_st_open_w.key2)) = 0 or &
		isnull(trim(ki_st_open_w.key2)) then
		kst_tab_listino_voci.id_listino_voci_categ = " "
	else
		kst_tab_listino_voci.id_listino_voci_categ = trim(ki_st_open_w.key2) // id categoria listino voce
	end if


//--- Se inserimento.... 
   if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento then
		post inserisci()
	else

//--- Se NO inserimento.... 
		k_rc = tab_1.tabpage_1.dw_1.retrieve( kst_tab_listino_voci.id_listino_voce ) 
		
		choose case k_rc

			case is < 0				
				messagebox("Operazione fallita", &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(ID cercato :" + trim(string(kst_tab_listino_voci.id_listino_voce)) + ")~n~r" )
				cb_ritorna.postevent(clicked!)

			case 0
	
				tab_1.tabpage_1.dw_1.reset()
				attiva_tasti()

				messagebox("Ricerca fallita", &
						"Mi spiace, il codice Listino non e' in archivio ~n~r" + &
					"(ID cercato: " + trim(string(kst_tab_listino_voci.id_listino_voce)) + ")~n~r" )

				cb_ritorna.triggerevent("clicked!")

			case is > 0		
				attiva_tasti()
		
		end choose

	end if

//--- se inserimento inabilito gli altri TAB, sono inutili
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
	
		tab_1.tabpage_2.enabled = false
		tab_1.tabpage_1.dw_1.setcolumn(1)
		tab_1.tabpage_1.dw_1.setfocus()
	else
		if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
			tab_1.tabpage_1.dw_1.setcolumn("descr")
			tab_1.tabpage_1.dw_1.setfocus()
		end if
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
	
//--- legge datawindowchild			
	leggi_dwc( )
	
end if


return k_return 

end function

public subroutine leggi_dwc ();int k_rc
long k_cod_cli
datawindowchild  kdwc_listino_voci_categ, kdwc_listino_voci_categ_1



		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
	
	//--- Attivo dw archivio CATEG VOCI LISTINO
			k_rc = tab_1.tabpage_1.dw_1.getchild("id_listino_voci_categ", kdwc_listino_voci_categ)
			k_rc = tab_1.tabpage_1.dw_1.getchild("id_listino_voci_categ_1", kdwc_listino_voci_categ_1)
			if kdwc_listino_voci_categ.rowcount() < 2 then
				
				kdwc_listino_voci_categ.retrieve()
				kdwc_listino_voci_categ.RowsCopy(kdwc_listino_voci_categ.GetRow(), kdwc_listino_voci_categ.RowCount(), Primary!,kdwc_listino_voci_categ_1, 1, Primary!)
				k_rc = kdwc_listino_voci_categ.insertrow(1)
		
			end if
		end if 



end subroutine

protected function integer inserisci ();//
int k_return=1, k_ctr, k_rc
string k_errore="0 ", k_rcx
long k_riga 
st_tab_listino_voci kst_tab_listino_voci
kuf_utility kuf1_utility
datawindowchild Kdwc_listino_voci_categ, Kdwc_listino_voci_catege_des



//--- Aggiunge una riga al data windows
choose case ki_selectedtab 
	case  1 

//--- Controllo se ho modificato dei dati nella DW DETTAGLIO
		if left(dati_modif(""), 1) = "1" then //Richisto Aggiornamento

//--- Controllo congruenza dei dati caricati e Aggiornamento  
//--- Ritorna 1 char : 0=tutto OK; 1=errore grave;
//---                : 2=errore non grave dati aggiornati;
//---			         : 3=LIBERO
//---      il resto della stringa contiene la descrizione dell'errore   
			k_errore = aggiorna_dati()

		end if

		if LeftA(k_errore, 1) = "0" then


//--- prima di tutto disabilito e resetto gli altri tab			
			if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
				tab_1.tabpage_2.enabled = false
				tab_1.tabpage_2.dw_2.reset ()
			end if

			kst_tab_listino_voci.id_listino_voci_categ = trim(trim(ki_st_open_w.key2))
			
			if tab_1.tabpage_1.dw_1.rowcount() > 0 then tab_1.tabpage_1.dw_1.reset() 
			
			tab_1.tabpage_1.dw_1.insertrow(0)
			
			ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento

//--- S-protezione campi per abilitare l'inserimento
			kuf1_utility = create kuf_utility
	     	kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)
			destroy kuf1_utility
			
//--- 
//			if len(trim(kst_tab_listino_voci.id_listino_voci_categ)) > 0 then
//				k_rc = tab_1.tabpage_1.dw_1.getchild("id_listino_voci_categ", Kdwc_listino_voci_categ)
//--- legge dwc dei clienti
//				if Kdwc_listino_voci_categ.rowcount() < 2 then
//					Kdwc_listino_voci_categ.retrieve()
//					k_rc = Kdwc_listino_voci_categ.insertrow(1)
//					k_rc = tab_1.tabpage_1.dw_1.getchild("id_listino_voci_categ", Kdwc_listino_voci_catege_des)
//					Kdwc_listino_voci_categ.RowsCopy(Kdwc_listino_voci_categ.GetRow(), Kdwc_listino_voci_categ.RowCount(), Primary!, Kdwc_listino_voci_catege_des, 1, Primary!)
//				end if	
//				
//				k_riga = Kdwc_listino_voci_categ.find("id_listino_voci_categ='"+trim(kst_tab_listino_voci.id_listino_voci_categ) + "' ",0,Kdwc_listino_voci_categ.rowcount())
//				if k_riga > 0 then
//					k_rc = tab_1.tabpage_1.dw_1.setitem(1, "id_listino_voci_categ", Kdwc_listino_voci_categ.getitemstring(k_riga, "id_listino_voci_categ"))
//				end if
//			end if
				
			tab_1.tabpage_1.dw_1.setitem(1, "id_listino_voce", 0)
			
			tab_1.tabpage_1.dw_1.setitem(1, "attivo", "S")
			tab_1.tabpage_1.dw_1.setitem(1, "um", kiuf_listino_voci.kki_um_assente )
			tab_1.tabpage_1.dw_1.setitem(1, "tipo_listino", kiuf_listino_voci.kki_tipo_listino_a_collo )
			tab_1.tabpage_1.dw_1.setitem(1, "tipo_calcolo",  kiuf_listino_voci.kki_tipo_calcolo_in_entrata )
			tab_1.tabpage_1.dw_1.setitem(1, "differito",  kiuf_listino_voci.kki_differito_no )
			tab_1.tabpage_1.dw_1.setitem(1, "aperto", kiuf_listino_voci.kki_aperto_no)

			tab_1.tabpage_1.dw_1.SetItemStatus( 1, 0, Primary!, NotModified!)

			tab_1.tabpage_1.dw_1.setfocus()
			tab_1.tabpage_1.dw_1.setrow(1)
			tab_1.tabpage_1.dw_1.setcolumn("descr")
			
		end if
		
		
	case 2 
		kst_tab_listino_voci.id_listino_voce = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_listino_voce")
	
//--- Riempe indirizzo di Spedizione da DW_1
		if kst_tab_listino_voci.id_listino_voce > 0 then

//--- S-protezione campi per abilitare l'inserimento
			kuf1_utility = create kuf_utility
	     	kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_2.dw_2)
			destroy kuf1_utility

			k_riga = tab_1.tabpage_2.dw_2.insertrow(0)

			tab_1.tabpage_2.dw_2.setitem(k_riga, "id_listino_voce", kst_tab_listino_voci.id_listino_voce)
			tab_1.tabpage_2.dw_2.setitem(k_riga, "attivo", "S")
			tab_1.tabpage_2.dw_2.SetItemStatus( k_riga, 0, Primary!, NotModified!)

			tab_1.tabpage_2.dw_2.setcolumn("id_listino_pregruppo")
			tab_1.tabpage_2.dw_2.scrolltorow(k_riga)
			tab_1.tabpage_2.dw_2.setrow(k_riga)
			
		end if

	case 3 

	case 4 
		
	case 5 
		
end choose	

attiva_tasti()

k_return = 0



return (k_return)



end function

protected subroutine riempi_id ();//
//
long k_ctr = 0
st_tab_listino_voci kst_tab_listino_voci



	k_ctr = tab_1.tabpage_1.dw_1.getrow()
	
	if k_ctr > 0 then
	
		kst_tab_listino_voci.id_listino_voce = tab_1.tabpage_1.dw_1.getitemnumber(k_ctr, "id_listino_voce")
	
//=== Se non sono in caricamento allora prelevo l'id_listino_voce dalla dw
		if tab_1.tabpage_1.dw_1.getitemstatus(k_ctr, 0, primary!) <> newmodified! then
			kst_tab_listino_voci.id_listino_voce = tab_1.tabpage_1.dw_1.getitemnumber(k_ctr, "id_listino_voce")
		end if
		if tab_1.tabpage_1.dw_1.GetItemStatus(1,0, primary!) = NewModified! &
				or tab_1.tabpage_1.dw_1.GetItemStatus(1,0, primary!) = DataModified! then
			tab_1.tabpage_1.dw_1.setitem(1, "x_datins", kGuf_data_base.prendi_x_datins())
			tab_1.tabpage_1.dw_1.setitem(1, "x_utente", kGuf_data_base.prendi_x_utente())
		end if
	
		if isnull(kst_tab_listino_voci.id_listino_voce) or kst_tab_listino_voci.id_listino_voce = 0 then				
			tab_1.tabpage_1.dw_1.setitem(k_ctr, "id_listino_voce", 0)
		else

	
//--- il secondo TAB
			for k_ctr = 1 to tab_1.tabpage_2.dw_2.rowcount()
		
				if tab_1.tabpage_2.dw_2.getitemnumber(k_ctr, "id_listino_pregruppo_voce") > 0 then
				else
					tab_1.tabpage_2.dw_2.setitem(k_ctr, "id_listino_pregruppo_voce", 0)
				end if
	
				tab_1.tabpage_2.dw_2.setitem(k_ctr, "id_listino_voce", kst_tab_listino_voci.id_listino_voce)
				
				if tab_1.tabpage_2.dw_2.GetItemStatus(k_ctr,0, primary!) = NewModified! &
						or tab_1.tabpage_2.dw_2.GetItemStatus(k_ctr,0, primary!) = DataModified! then
					tab_1.tabpage_2.dw_2.setitem(k_ctr, "x_datins", kGuf_data_base.prendi_x_datins())
					tab_1.tabpage_2.dw_2.setitem(k_ctr, "x_utente", kGuf_data_base.prendi_x_utente())
				end if
						
			end for
		end if
	end if


end subroutine

protected subroutine open_start_window ();//
int k_rc
datawindowchild  kdwc_listino_voci_categ_des, kdwc_listino_voci_categ



	kiuf_listino_voci = create kuf_listino_voci

	ki_toolbar_window_presente=true



//--- Attivo dw archivio Prodotto
	k_rc = tab_1.tabpage_1.dw_1.getchild("id_listino_voci_categ", kdwc_listino_voci_categ)

	k_rc = kdwc_listino_voci_categ.settransobject(sqlca)

	kdwc_listino_voci_categ.insertrow(1)

	k_rc = tab_1.tabpage_1.dw_1.getchild("id_listino_voci_categ_1", kdwc_listino_voci_categ_des)

	k_rc = kdwc_listino_voci_categ_des.settransobject(sqlca)



end subroutine

protected function string aggiorna ();//
//======================================================================
//=== Aggiorna tabelle 
//=== Ritorna 1 chr : 0=tutto OK; 1=errore grave I-O;
//=== 				  : 2=
//===					  : 3=Commit fallita
//===		dal char 2 in poi spiegazione dell'errore
//======================================================================

string k_return="0 ", k_errore="0 "
st_tab_listino_voci kst_tab_listino_voci
boolean k_new_rec
st_esito kst_esito

//=== 
//choose case tab_1.selectedtab 

//	case 1 

//=== Aggiorna, se modificato, la TAB_1	
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
						kst_tab_listino_voci.id_listino_voce = kiuf_listino_voci.get_ultimo_id()	
						tab_1.tabpage_1.dw_1.setitem(1, "id_listino_voce", kst_tab_listino_voci.id_listino_voce)
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


		
//=== Aggiorna, se modificato, la TAB_2 Voci-prezzi
	if left(k_return,1) = "0" and tab_1.tabpage_2.dw_2.getnextmodified(0, primary!) > 0 	then
	
		if tab_1.tabpage_2.dw_2.update() = 1 then

//=== Se tutto OK faccio la COMMIT		
			kst_esito = kguo_sqlca_db_magazzino.db_commit()
			if kst_esito.esito = kkg_esito.db_ko then
				k_return = "3" + "Archivio " + tab_1.tabpage_2.text + " " + kst_esito.sqlerrtext
			else // Tutti i Dati Caricati in Archivio
				k_return ="0 "
			end if
		else
			kst_esito = kguo_sqlca_db_magazzino.db_rollback()
			k_return="1Fallito aggiornamento archivio '" + tab_1.tabpage_2.text + "' ~n~r" 
		end if	
	end if

		
//end choose

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

protected subroutine inizializza_1 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
long k_id_listino_voce, k_id_listino_voce_2, k_rc
string k_scelta, k_id_listino_voce_prec, k_string
int k_ctr=0
datawindowchild kdwc_listino_pregruppo_1, kdwc_listino_pregruppo_2
kuf_utility kuf1_utility


ki_selectedtab = 2

k_id_listino_voce = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_listino_voce")  
k_scelta = trim(ki_st_open_w.flag_modalita)

//--- Acchiappo il id_listino_voce VOCE x evitare la rilettura
if IsNumber(tab_1.tabpage_2.st_2_retrieve.Text) then
	k_id_listino_voce_2 = long(tab_1.tabpage_2.st_2_retrieve.Text)
else
	k_id_listino_voce_2 = 0
end if
//--- Forza valore id_listino_voce  per ricordarlo per le prossime richieste
tab_1.tabpage_2.st_2_retrieve.Text=string(k_id_listino_voce, "####0")


//--- Se VOCE non impostato forzo una INSERISCI prezzo, impostando il id_listino_voce
if k_id_listino_voce = 0 then
	tab_1.tabpage_2.dw_2.reset()
else


	if tab_1.tabpage_2.dw_2.rowcount() = 0  and k_id_listino_voce_2 <> k_id_listino_voce then

//--- Attivo dw archivio GRUPPI LISTINO
		k_rc = tab_1.tabpage_2.dw_2.getchild("id_listino_pregruppo", kdwc_listino_pregruppo_1)
		k_rc = kdwc_listino_pregruppo_1.settransobject(sqlca)
		k_rc = tab_1.tabpage_2.dw_2.getchild("listino_pregruppo_descr", kdwc_listino_pregruppo_2)
		k_rc = kdwc_listino_pregruppo_1.settransobject(sqlca)
		if kdwc_listino_pregruppo_1.rowcount() < 2 then
			kdwc_listino_pregruppo_1.retrieve(0 )
			kdwc_listino_pregruppo_1.insertrow(1)
		end if
		kdwc_listino_pregruppo_1.rowscopy( 1,kdwc_listino_pregruppo_1.rowcount( ) ,primary!, kdwc_listino_pregruppo_2, 1,primary!)
	
	end if

//--- salvo i parametri cosi come sono stati immessi
	k_id_listino_voce_prec = tab_1.tabpage_2.st_2_retrieve.text
	kuf1_utility = create kuf_utility
	tab_1.tabpage_2.st_2_retrieve.Text = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
	destroy kuf1_utility
	
	if tab_1.tabpage_2.st_2_retrieve.text <> k_id_listino_voce_prec then
	
		if tab_1.tabpage_2.dw_2.retrieve(0, k_id_listino_voce)  < 1 then
			inserisci()
		end if
	end if

//--- metto la descrizione in testata
	if tab_1.tabpage_2.dw_2.rowcount( )  > 0 then
		k_string = "listino_voci_descr_testa.Expression='~"" + trim(tab_1.tabpage_1.dw_1.getitemstring(1,"descr") ) + " ~" ' "
		tab_1.tabpage_2.dw_2.modify(k_string)
	end if  

	attiva_tasti()

//--- Inabilita campi alla modifica se Visualizzazione
   kuf1_utility = create kuf_utility 
   if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.visualizzazione then 
		kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_2.dw_2)
	else
      	kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_2.dw_2)
	end if
	destroy kuf1_utility

		
end if



	


end subroutine

protected function integer cancella ();//
//=== Cancellazione rekord dal DB
//=== Ritorna : 0=OK 1=KO 2=non eseguita
//
int k_return=0
string k_desc, k_record, k_record_1
long k_key = 0, k_id_listino_pregruppo=0
string k_listino_pregruppo_descr
string k_errore = "0 ",  k_nro_fatt
long k_riga, k_seq
date k_data
st_esito kst_esito
st_tab_listino_pregruppi_voci kst_tab_listino_pregruppi_voci
st_tab_listino_voci kst_tab_listino_voci
kuf_listino_pregruppi_voci kuf1_listino_pregruppi_voci



//=== 
choose case tab_1.selectedtab 
	case 1 
		k_record = " Voce "
		k_riga = tab_1.tabpage_1.dw_1.getrow()	
		if k_riga > 0 then
			if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> new! and &
				tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
				k_key = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_listino_voce")
				k_desc = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "descr")
				if isnull(k_desc) = true or trim(k_desc) = "" then
					k_desc = "senza descrizione" 
				end if
				k_record_1 = &
					"Sei sicuro di voler eliminare la Voce~n~r" + &
					string(k_key, "#####") +  &
					"~n~r" + trim(k_desc) + " ?"
			else
				tab_1.tabpage_1.dw_1.deleterow(k_riga)
			end if
		end if
	case 2
		k_record = "  "
		k_riga = tab_1.tabpage_2.dw_2.getrow()	
		if k_riga > 0 then
			if  tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id_listino_pregruppo_voce") > 0 then
				if tab_1.tabpage_2.dw_2.getitemstatus(k_riga, 0, primary!) <> new! and &
								tab_1.tabpage_2.dw_2.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
					k_key = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id_listino_pregruppo_voce")
					k_id_listino_pregruppo = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id_listino_pregruppo")
					k_listino_pregruppo_descr = tab_1.tabpage_2.dw_2.getitemstring(k_riga, "listino_pregruppo_descr")
					k_record_1 = &
						"Sei sicuro di voler eliminare PREZZO~n~r" &
						+ " id " + string(k_key) + ", gruppo " + trim(string(k_id_listino_pregruppo)) + " " &
						+ trim(k_listino_pregruppo_descr) + " ?"
				else
					tab_1.tabpage_2.dw_2.deleterow(k_riga)
				end if
			else
				tab_1.tabpage_2.dw_2.deleterow(k_riga)
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
					kst_tab_listino_voci.id_listino_voce = k_key
					kiuf_listino_voci.tb_delete(kst_tab_listino_voci) 
				case 2
					kuf1_listino_pregruppi_voci = create kuf_listino_pregruppi_voci
					kst_tab_listino_pregruppi_voci.id_listino_pregruppo_voce = k_key
					kuf1_listino_pregruppi_voci.tb_delete(kst_tab_listino_pregruppi_voci) 
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
					case 2 
						tab_1.tabpage_2.dw_2.deleterow(k_riga)
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
	case 2
		tab_1.tabpage_2.dw_2.setfocus()
		tab_1.tabpage_2.dw_2.setcolumn(1)
		tab_1.tabpage_2.dw_2.ResetUpdate ( ) 
end choose	


return k_return

end function

protected subroutine pulizia_righe ();//
long k_riga
long k_nr_righe


if tab_1.tabpage_2.dw_2.rowcount() > 0 then
	tab_1.tabpage_2.dw_2.accepttext()
end if

//=== Pulizia dei rek non validi sui vari TAB
	k_nr_righe = tab_1.tabpage_2.dw_2.rowcount()
	for k_riga = k_nr_righe to 1 step -1

		if tab_1.tabpage_2.dw_2.getitemstatus(k_riga, 0, primary!) = newmodified! then 
			if (isnull(tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, "id_listino_pregruppo"))  &
				 	or tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, "id_listino_pregruppo") = 0)  &
				then
		
				tab_1.tabpage_2.dw_2.deleterow(k_riga)

			end if
		end if
		
	next


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
kuf_listino_pregruppi_voci kuf1_listino_pregruppi_voci

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
		kst_esito = kiuf_listino_voci.u_check_dati(kds_inp)
	end if
//--- Controllo altro tab
	if  tab_1.tabpage_2.dw_2.enabled then
		if tab_1.tabpage_2.dw_2.getnextmodified(0, primary!) > 0 then
			kds_inp.dataobject = tab_1.tabpage_2.dw_2.dataobject
			tab_1.tabpage_2.dw_2.rowscopy( 1,tab_1.tabpage_2.dw_2.rowcount( ) ,primary!, kds_inp, 1, primary!)
			kuf1_listino_pregruppi_voci = create kuf_listino_pregruppi_voci
			kst_esito = kuf1_listino_pregruppi_voci.u_check_dati(kds_inp)
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

private subroutine put_video_pregruppi (st_tab_listino_pregruppi_voci kst_tab_listino_pregruppi_voci);//
//--- Visualizza dati Pagamento
//
long k_riga=0
datawindowchild kdwc_1



//tab_1.tabpage_2.dw_2.modify( "id_listino_pregruppo.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
tab_1.tabpage_2.dw_2.setitem( tab_1.tabpage_2.dw_2.getrow(), "id_listino_pregruppo", kst_tab_listino_pregruppi_voci.id_listino_pregruppo )

tab_1.tabpage_2.dw_2.getchild("id_listino_pregruppo", kdwc_1)
k_riga = kdwc_1.find( "id_listino_pregruppo = " + string(kst_tab_listino_pregruppi_voci.id_listino_pregruppo) + " " , 1, kdwc_1.rowcount())
if k_riga > 0 then
	tab_1.tabpage_2.dw_2.setitem(tab_1.tabpage_2.dw_2.getrow(), "listino_pregruppo_descr", kdwc_1.getitemstring(k_riga, "descr")  )
else
	tab_1.tabpage_2.dw_2.setitem(tab_1.tabpage_2.dw_2.getrow(), "listino_pregruppo_descr", " " )
end if



end subroutine

on w_listino_voci.create
call super::create
end on

on w_listino_voci.destroy
call super::destroy
end on

type st_ritorna from w_g_tab_3`st_ritorna within w_listino_voci
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_listino_voci
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_listino_voci
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_listino_voci
end type

type st_stampa from w_g_tab_3`st_stampa within w_listino_voci
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_listino_voci
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_listino_voci
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_listino_voci
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_listino_voci
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_listino_voci
end type

type tab_1 from w_g_tab_3`tab_1 within w_listino_voci
end type

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
string text = "Voce"
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
integer width = 1207
string dataobject = "d_listino_voci"
end type

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
string text = "Prezzi"
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
boolean visible = true
boolean enabled = true
string dataobject = "d_listino_pregruppi_voci_xvoce_l"
end type

event dw_2::itemchanged;//
long k_riga
st_tab_listino_pregruppi_voci kst_tab_listino_pregruppi_voci
datawindowchild kdwc_1

choose case dwo.name 

	case "id_listino_pregruppo" 
		if len(trim(data)) > 0 then 
			kst_tab_listino_pregruppi_voci.id_listino_pregruppo =  long(trim(data))
			post put_video_pregruppi(kst_tab_listino_pregruppi_voci)
		else
			tab_1.tabpage_2.dw_2.setitem(row, "listino_pregruppo_descr", " " )
		end if

		
end choose 

post	attiva_tasti()
	
end event

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
boolean enabled = false
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
end type

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
boolean enabled = false
end type

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
end type

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

