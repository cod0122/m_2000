$PBExportHeader$w_sr_profili.srw
forward
global type w_sr_profili from w_g_tab_3
end type
end forward

global type w_sr_profili from w_g_tab_3
integer width = 1422
integer height = 556
string title = "Profilo"
long backcolor = 67108864
boolean ki_toolbar_window_presente = true
end type
global w_sr_profili w_sr_profili

type variables
//
private datastore kdspi_elenco_output 
constant string ki_dw_lista_funzioni = "d_sr_prof_funz_l_diverso" 

end variables

forward prototypes
protected subroutine pulizia_righe ()
protected subroutine riempi_id ()
protected subroutine inizializza_1 ()
protected function integer cancella ()
protected function string inizializza ()
public subroutine chiama_elenco_funzioni ()
protected subroutine smista_funz (string k_par_in)
protected subroutine attiva_menu ()
protected subroutine inizializza_2 ()
public function string check_dati ()
public subroutine popola_sr_prof_funz ()
protected subroutine open_start_window ()
protected subroutine attiva_tasti_0 ()
end prototypes

protected subroutine pulizia_righe ();//
long k_riga
long k_nr_righe


tab_1.tabpage_1.dw_1.accepttext()
tab_1.tabpage_2.dw_2.accepttext()
tab_1.tabpage_3.dw_3.accepttext()
tab_1.tabpage_4.dw_4.accepttext()
tab_1.tabpage_5.dw_5.accepttext()

//
//=== Pulizia dei rek non validi sui vari TAB
	k_nr_righe = tab_1.tabpage_1.dw_1.rowcount()
	for k_riga = k_nr_righe to 1 step -1

		if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) = newmodified! then 
			if isnull(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "nome")) &
				or LenA(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "nome"))) = 0  &
				then
		
				tab_1.tabpage_1.dw_1.deleterow(k_riga)
				
			end if
		end if
		
	next

end subroutine

protected subroutine riempi_id ();//
long k_riga

	
	k_riga = tab_1.tabpage_1.dw_1.getrow()
	
	if k_riga > 0 then

		if isnull(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "stato")) &
		   or LenA(trim(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "stato"))) = 0 &
			then				
			tab_1.tabpage_1.dw_1.setitem(k_riga, "stato", '0')
		end if
	
//=== Se sono in inser azzero il ID  
		if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) = newmodified! then
			if isnull(tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id")) &
				then				
				tab_1.tabpage_1.dw_1.setitem(k_riga, "id", 0)
			end if
		end if
	end if

	

end subroutine

protected subroutine inizializza_1 ();//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
int k_rc=0
long k_riga
double k_dose 
string k_codice_attuale, k_codice_prec
st_tab_sr_prof_funz kst_tab_sr_prof_funz
	

k_riga = tab_1.tabpage_1.dw_1.getrow() 
	
kst_tab_sr_prof_funz.id_funzioni = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id")

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

	k_rc=tab_1.tabpage_2.dw_2.retrieve(kst_tab_sr_prof_funz.id_funzioni)  

end if				
				

attiva_tasti()
if tab_1.tabpage_2.dw_2.rowcount() = 0 then
	tab_1.tabpage_2.dw_2.insertrow(0) 
end if


tab_1.tabpage_2.dw_2.setfocus()
	
	

end subroutine

protected function integer cancella ();//
//=== Cancellazione record dal DB
//=== Ritorna : 0=OK 1=KO 2=non eseguita
//
int k_return=0
string k_record, k_record_1, k_key, k_testo
string k_errore = "0 " 
long k_riga
kuf_sr_sicurezza  kuf1_sr_sicurezza
st_esito kst_esito
st_tab_sr_profili kst_tab_sr_profili
st_tab_sr_funzioni kst_tab_sr_funzioni
st_tab_sr_prof_funz kst_tab_sr_prof_funz



//=== 
choose case tab_1.selectedtab 
	case 1 
		k_record = " " + trim(tab_1.tabpage_1.text) + " "
		k_riga = tab_1.tabpage_1.dw_1.getrow()	
		if k_riga > 0 then
			if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> new! and &
				tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
				kst_tab_sr_profili.id = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id")
				kst_tab_sr_profili.nome = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "nome")
				if isnull(kst_tab_sr_profili.nome) = true or trim(kst_tab_sr_profili.nome) = "" then
					
					k_testo = trim(tab_1.tabpage_1.dw_1.object.nome_t.text)
					kst_tab_sr_profili.nome = "senza " + k_testo
					
				end if
				k_record_1 = &
					"Sei sicuro di voler eliminare " + trim(tab_1.tabpage_1.text) + "~n~r" + &
					trim(kst_tab_sr_profili.nome)  &
				   + " ?"
			else
				tab_1.tabpage_1.dw_1.deleterow(k_riga)
			end if
		end if
		k_key = trim(string(kst_tab_sr_profili.id))
 
	case 2 
		k_record = " " + trim(tab_1.tabpage_2.text) + " "
		k_riga = tab_1.tabpage_2.dw_2.getselectedrow(0)	
		if k_riga > 0 then
			if tab_1.tabpage_2.dw_2.getitemstatus(k_riga, 0, primary!) <> new! and &
				tab_1.tabpage_2.dw_2.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
				
				kst_tab_sr_prof_funz.id = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "sr_prof_funz_id")
				kst_tab_sr_funzioni.id = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id")
				kst_tab_sr_funzioni.nome = tab_1.tabpage_2.dw_2.getitemstring(k_riga, "nome")
				if isnull(kst_tab_sr_funzioni.nome) or trim(kst_tab_sr_funzioni.nome) = "" then
					
					k_testo = trim(tab_1.tabpage_2.dw_2.object.nome_t.text)
					kst_tab_sr_funzioni.nome = "senza " + k_testo
					
				end if
				k_record_1 = &
					"Sei sicuro di voler eliminare l'associazione con la Funzione" + "~n~r" + &
					trim(kst_tab_sr_funzioni.nome) + " id=" + string(kst_tab_sr_funzioni.id) &
				   + " ?"
			else
				tab_1.tabpage_2.dw_2.deleterow(k_riga)
			end if
		else
			messagebox("Elimina" + k_record,  "Selezionare almeno una riga. ")
		end if
		k_key = trim(string(kst_tab_sr_prof_funz.id))
		
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
		question!, yesno!, 2) = 1 then
 
//=== Creo l'oggetto che ha la funzione x cancellare la tabella
		kuf1_sr_sicurezza = create kuf_sr_sicurezza
		
//=== Cancella la riga dal data windows di lista
		choose case tab_1.selectedtab 
			case 1 
				kst_esito = kuf1_sr_sicurezza.tb_delete_sr_profili(kst_tab_sr_profili) 
			case 2
				kst_esito = kuf1_sr_sicurezza.tb_delete_sr_prof_funz(kst_tab_sr_prof_funz) 
		end choose	
		if kst_esito.esito = "0" then

			k_errore = kGuf_data_base.db_commit()
			if LeftA(k_errore, 1) <> "0" then
				k_return = 1
				messagebox("Problemi durante la Cancellazione !!", &
						"Controllare i dati. " + MidA(k_errore, 2))

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
			k_errore = kGuf_data_base.db_rollback()

			messagebox("Problemi durante Cancellazione - Operazione fallita !!", &
						  trim(kst_esito.SQLErrText) ) 	
			if LeftA(k_errore, 1) <> "0" then
				messagebox("Problemi durante il recupero dell'errore !!", &
					"Controllare i dati. " + MidA(k_errore, 2))
			end if

			attiva_tasti()

		end if

//=== Distruggo l'oggetto che ha avuto la funzione x cancellare la tabella
		destroy kuf1_sr_sicurezza

	else
		messagebox("Elimina" + k_record,  "Operazione Annullata !!")
		k_return = 2
	end if


end if


choose case tab_1.selectedtab 
	case 1 
		tab_1.tabpage_1.dw_1.setfocus()
		tab_1.tabpage_1.dw_1.setcolumn(1)
	case 2
		tab_1.tabpage_2.dw_2.setfocus()
		tab_1.tabpage_2.dw_2.setcolumn(1)
end choose	


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
int k_ctr=0, k_errore = 0
int k_err_ins, k_rc
//datawindowchild kdwc_dw1
kuf_utility kuf1_utility


//=== 
//tab_1.tabpage_4.dw_41.settransobject(sqlca)


if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
	k_scelta = trim(ki_st_open_w.flag_modalita)
	
	k_key = trim(ki_st_open_w.key1)

//	tab_1.tabpage_1.dw_1.getchild("id_programma", kdwc_dw1)
//	kdwc_dw1.settransobject(sqlca)
//	kdwc_dw1.insertrow(0)


	if LenA(k_key) = 0 or not isnumber(k_key) then
		
		cb_inserisci.postevent(clicked!)
		tab_1.tabpage_1.dw_1.setfocus()
	else

		k_rc = tab_1.tabpage_1.dw_1.retrieve(long(k_key)) 
		
		choose case k_rc

			case is < 0				
				k_errore = 1
				messagebox("Operazione fallita", &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(Codice ricercato:" + trim(k_key) + ")~n~r" )
				cb_ritorna.postevent(clicked!)
				

			case 0
	
				tab_1.tabpage_1.dw_1.reset()
				attiva_tasti()

				if k_scelta <> "in" then
					k_errore = 1
					messagebox("Ricerca fallita", &
						"Mi spiace ma il dato non e' in Archivio ~n~r" + &
						"(Codice Cercato:" + trim(k_key) + ")~n~r" )

					cb_ritorna.postevent(clicked!)
					
				else
					k_err_ins = inserisci()
					tab_1.tabpage_1.dw_1.setfocus()
				end if
				
			case is > 0		
				if k_scelta = "in" then
					cb_inserisci.postevent(clicked!)
				end if

				tab_1.tabpage_1.dw_1.setfocus()
				tab_1.tabpage_1.dw_1.setcolumn(1)
				
				attiva_tasti()
		
		end choose

	end if

//	kdwc_dw1.retrieve()

else
	attiva_tasti()
end if


//===
//--- inabilito le modifiche sulla dw
if k_errore = 0 then
	
//--- Inabilita campi alla modifica se Vsualizzazione
	kuf1_utility = create kuf_utility 
	if trim(ki_st_open_w.flag_modalita) = "vi" &
	   or trim(ki_st_open_w.flag_modalita) = "ca" then
		
		kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_1.dw_1)

	else		
		
//--- S-protezione campi per riabilitare la modifica 
      kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)

	end if
	destroy kuf1_utility
	
//--- se cancellazione
	if ki_st_open_w.flag_modalita = "ca" then

		cb_cancella.postevent (clicked!)
		
	end if
end if


return "0"

end function

public subroutine chiama_elenco_funzioni ();//
int k_rc
string k_id_programma="", k_key
long k_riga=0
window k_window
st_open_w kst_open_w
kuf_base kuf1_base
kuf_menu_window kuf1_menu_window
st_tab_sr_prof_funz kst_tab_sr_prof_funz
st_tab_sr_utenti kst_tab_sr_funzioni

		
//--- ricavo l'id
	k_riga = tab_1.tabpage_1.dw_1.getrow()
	kst_tab_sr_prof_funz.id_funzioni = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id")
	kst_tab_sr_funzioni.descrizione = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "descrizione")
	kst_tab_sr_funzioni.nome = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "nome")

//--- popolo il datasore (dw non visuale) per appoggio elenco

//--- 
	kdspi_elenco_output = create datastore 
		
	kdspi_elenco_output.dataobject = ki_dw_lista_funzioni 
	k_rc = kdspi_elenco_output.settransobject ( sqlca )
	k_rc = kdspi_elenco_output.retrieve(kst_tab_sr_prof_funz.id_funzioni)

	if isnull(kst_tab_sr_funzioni.nome) then
		kst_tab_sr_funzioni.nome = " "
	end if
	if isnull(kst_tab_sr_funzioni.descrizione) then
		kst_tab_sr_funzioni.descrizione = " "
	end if
	
	kst_open_w.key1 = "Elenco Funzioni disponibili per il Profilo: '" &
						  + trim(kst_tab_sr_funzioni.nome) + "'  " &
						  + trim(kst_tab_sr_funzioni.descrizione) 


	if kdspi_elenco_output.rowcount() > 0 then

		k_window = kGuf_data_base.prendi_win_attiva()
		
//--- chiamare la window di elenco
//
//=== Parametri : 
//=== struttura st_open_w
		kst_open_w.id_programma = "elenco"
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
		kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
		kst_open_w.flag_leggi_dw = " "
		kst_open_w.flag_cerca_in_lista = " "
		kst_open_w.key2 = trim(kdspi_elenco_output.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = k_window.title    //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key12_any = kdspi_elenco_output
		kst_open_w.flag_where = " "
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(kst_open_w)
		destroy kuf1_menu_window

	else
		
		messagebox("Elenco Dati", &
					"Nessun valore disponibile. ")
		
		
	end if
			

end subroutine

protected subroutine smista_funz (string k_par_in);//---
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//===


choose case LeftA(k_par_in, 2) 

//--- Personalizzo da qui
	case "l1"		// inserisce funzioni da programmi
		if cb_inserisci.enabled = true then
			popola_sr_prof_funz() 
		end if

	case else      // standard
		super::smista_funz(k_par_in)
		
end choose



end subroutine

protected subroutine attiva_menu ();//
kuf_utility kuf1_utility



	choose case tab_1.selectedtab 

		case 1
			ki_menu.m_finestra.m_gestione.m_fin_inserimento.text = "Inserisci"
			ki_menu.m_finestra.m_gestione.m_fin_elimina.text = "Elimina"
		case 2 
			ki_menu.m_finestra.m_gestione.m_fin_inserimento.text = "Aggiunge Funzione"
			ki_menu.m_finestra.m_gestione.m_fin_elimina.text = "Toglie Funzione"
			
	end choose

	ki_menu.m_finestra.m_gestione.m_fin_inserimento.microhelp = ki_menu.m_finestra.m_gestione.m_fin_inserimento.text
	ki_menu.m_finestra.m_gestione.m_fin_inserimento.toolbaritemtext = ki_menu.m_finestra.m_gestione.m_fin_inserimento.text
	ki_menu.m_finestra.m_gestione.m_fin_elimina.microhelp = ki_menu.m_finestra.m_gestione.m_fin_elimina.text
	ki_menu.m_finestra.m_gestione.m_fin_elimina.toolbaritemtext = ki_menu.m_finestra.m_gestione.m_fin_elimina.text

//
//--- Attiva/Dis. Voci di menu personalizzate
//
	if tab_1.selectedtab = 1 then
		ki_menu.m_strumenti.m_fin_gest_libero1.enabled = false
	else
		ki_menu.m_strumenti.m_fin_gest_libero1.enabled = cb_inserisci.enabled
	end if
	if not ki_menu.m_strumenti.m_fin_gest_libero1.visible then
		ki_menu.m_strumenti.m_fin_gest_libero1.text = "Importa tutte le Funzioni"
		ki_menu.m_strumenti.m_fin_gest_libero1.microhelp = &
		"Associa tutte le Funzioni esistenti al profilo"
		ki_menu.m_strumenti.m_fin_gest_libero1.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemtext = "Importa,"+&
												 ki_menu.m_strumenti.m_fin_gest_libero1.text
	//	ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex = 2
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemvisible = true
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemname = "CheckIn!" //ki_path_risorse + "\barcode.bmp"
	end if		
	
	super::attiva_menu()

end subroutine

protected subroutine inizializza_2 ();//
//======================================================================
//=== Inizializzazione del TAB 3 controllandone i valori se gia' presenti
//======================================================================
//
int k_rc=0
double k_dose 
string k_codice_attuale, k_codice_prec
long k_key
	

//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if not isnull(tab_1.tabpage_3.st_3_retrieve.text) then
	k_codice_prec = tab_1.tabpage_3.st_3_retrieve.text
else
	k_codice_prec = " "
end if

k_key = tab_1.tabpage_1.dw_1.object.id[tab_1.tabpage_1.dw_1.getrow()]
k_codice_attuale = string(k_key)

//=== Forza valore Codice composto per ricordarlo per le prossime richieste
tab_1.tabpage_3.st_3_retrieve.text = k_codice_attuale

if k_codice_attuale <> k_codice_prec then

	k_rc=tab_1.tabpage_3.dw_3.retrieve(k_key)  

end if				
				

attiva_tasti()
if tab_1.tabpage_3.dw_3.rowcount() = 0 then
	tab_1.tabpage_3.dw_3.insertrow(0) 
end if


tab_1.tabpage_3.dw_3.setfocus()
	
	

end subroutine

public function string check_dati ();//
//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================

string k_return = ""
string k_errore = "0"
long k_nr_righe
int k_riga
int k_nr_errori
string k_key_str
string k_stato, k_tipo
string k_key, k_testo



//=== Controllo il primo tab
	k_nr_righe = tab_1.tabpage_1.dw_1.rowcount()
	k_nr_errori = 0
	k_riga = 1

	k_key = tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "nome") 
	if isnull(k_key) or LenA(trim(k_key)) = 0 then
		k_testo = trim(tab_1.tabpage_1.dw_1.object.nome_t.text)
		k_return = tab_1.tabpage_1.text + ": Manca valore nel campo '" + k_testo + "'. " + "~n~r"
		k_errore = "3"
		k_nr_errori++
	end if
//	if isnull(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "id_programma")) = true then
//		k_testo = trim(tab_1.tabpage_1.dw_1.object.id_programma_t.text)
//		k_return = k_return + tab_1.tabpage_1.text + ": Manca valore nel campo '" + k_testo + "'. " + "~n~r" 
//		k_errore = "3"
//		k_nr_errori++
//	end if

	if k_errore <> "1" or k_errore <> "2" or k_errore <> "3" then
	
		tab_1.tabpage_1.dw_1.setitem(k_riga, "x_datins", kGuf_data_base.prendi_x_datins())
		tab_1.tabpage_1.dw_1.setitem(k_riga, "x_utente", kGuf_data_base.prendi_x_utente())
		
	end if

//
////=== Controllo altro tab
//	k_nr_righe = tab_1.tabpage_2.dw_2.rowcount()
//	k_riga = tab_1.tabpage_2.dw_2.getnextmodified(0, primary!)
//
//	do while k_riga > 0  and k_nr_errori < 10
//
//		k_key = tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, "sequenza") 
//
//		if isnull(k_key) then
//			tab_1.tabpage_2.dw_2.setitem ( k_riga, "sequenza", 0) 
//			k_key = 0
//		end if
//
//		if k_nr_errori < 9 then // per non uscire da check senza contr.eventuali eltri errori gravi 
//			if isnull(tab_1.tabpage_2.dw_2.getitemdate ( k_riga, "data_prev")) = true then
//				k_return = "Data " + tab_1.tabpage_2.text + " alla riga " + &
//				string(k_riga, "#####") + " non impostata~n~r" 
//				k_errore = "4"
//				k_nr_errori++
//			end if
//
//			if k_errore = "0" and k_riga < k_nr_righe and k_key > 0 then
//				k_tipo = tab_1.tabpage_2.dw_2.getitemstring ( k_riga, "tipo") 
//				if tab_1.tabpage_2.dw_2.find("sequenza = " +  &
//							string(k_key, "#####") + " and tipo='" + k_tipo + "'", &
//							(k_riga+1), k_nr_righe) > 0 then
//					k_return = "La stessa sequenza " + tab_1.tabpage_2.text + " ripetuta piu' volte~n~r" 
//					k_return = k_return + "(Codice " + string(k_key) + ") ~n~r"
//					k_errore = "4"
//					k_nr_errori++
//				end if
//			end if
//		end if
//		k_riga++
//
//		k_riga = tab_1.tabpage_2.dw_2.getnextmodified(k_riga, primary!)
//
//	loop
//
////=== Controllo altro tab
//	k_nr_righe = tab_1.tabpage_4.dw_4.rowcount()
//	k_riga = tab_1.tabpage_4.dw_4.getnextmodified(0, primary!)
//
//	do while k_riga > 0  and k_nr_errori < 10
//
//		k_key_str = tab_1.tabpage_4.dw_4.getitemstring ( k_riga, "id_fattura") 
//
//
//		if k_nr_errori < 9 then // per non uscire da check senza contr.eventuali eltri errori gravi 
//
//			if isnull(tab_1.tabpage_4.dw_4.getitemdate ( k_riga, "data_fattura")) = true then
//				k_return = "Manca la Data " + tab_1.tabpage_4.text + " alla riga " + &
//				string(k_riga, "#####") + " ~n~r" 
//				k_errore = "3"
//				k_nr_errori++
//			end if
//
//			if k_nr_errori < 9 then // per non uscire da check senza contr.eventuali eltri errori gravi 
//				if isnull(tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "importo")) = true or & 
//					tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "importo") = 0 then
//					k_return = "Manca l'Importo " + tab_1.tabpage_4.text + " alla riga " + &
//					string(k_riga, "#####") + " ~n~r" 
//					k_errore = "4"
//					k_nr_errori++
//				end if
//			end if
//
//		end if
//		k_riga++
//
//		k_riga = tab_1.tabpage_4.dw_4.getnextmodified(k_riga, primary!)
//
//	loop
//
//
//
return k_errore + k_return


end function

public subroutine popola_sr_prof_funz ();//
long k_riga 
string k_funzioni
pointer kp_oldpointer
st_tab_sr_prof_funz kst_tab_sr_prof_funz
kuf_sr_sicurezza kuf1_sr_sicurezza
st_esito kst_esito


	
//=== 
if tab_1.tabpage_2.dw_2.rowcount() > 1 then
	messagebox("Inserisci tutte le Funzioni", & 
	 "Sono già presenti delle Funzioni in questo Profilo. Operazione non permessa.", &
				  information!) 
else
	if messagebox("Importa tutte le Funzioni esistenti", & 
	  "Operazione di associazione automatica di tutte le Funzioni al Profilo. Proseguire ?", &
					  question!, yesno!, 2) = 1 then
			
		kp_oldpointer = SetPointer(HourGlass!)
		
		chiama_elenco_funzioni()
		
		if kdspi_elenco_output.rowcount() > 0 then
		
			for k_riga = 1 to kdspi_elenco_output.rowcount() 
				
				kst_tab_sr_prof_funz.id_profili = &
					tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "id")
				kst_tab_sr_prof_funz.id_funzioni = &
					kdspi_elenco_output.getitemnumber(k_riga, "id")
	
				if kst_tab_sr_prof_funz.id_funzioni > 0 then
					kuf1_sr_sicurezza = create kuf_sr_sicurezza
					kst_esito = kuf1_sr_sicurezza.tb_insert_sr_prof_funz (kst_tab_sr_prof_funz)
					destroy kuf1_sr_sicurezza
				end if					
	
			next

			smista_funz(kkg_flag_richiesta_refresh)
			SetPointer(kp_oldpointer)
			messagebox("Inserisci Funzioni", "Operazione terminata correttamente") 
			
		else
			smista_funz(kkg_flag_richiesta_refresh)
			SetPointer(kp_oldpointer)
			messagebox("Inserisci Funzioni", "Nessuna funzione da associare") 
			
		end if
		
		SetPointer(kp_oldpointer)
	end if
end if
	

	
end subroutine

protected subroutine open_start_window ();//
kdspi_elenco_output = create datastore

ki_toolbar_window_presente=true

end subroutine

protected subroutine attiva_tasti_0 ();//
	super::attiva_tasti_0()

	cb_modifica.enabled = false

	tab_1.tabpage_2.enabled = false
	if tab_1.tabpage_1.dw_1.getrow() > 0 then
		if tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "id") > 0 then
			tab_1.tabpage_2.enabled = true 
		end if
	end if

	if tab_1.selectedtab <> 1 then
		cb_aggiorna.enabled = false
		cb_visualizza.enabled = false
	end if

	if tab_1.selectedtab = 3 then
		cb_inserisci.enabled = false
		cb_cancella.enabled = false
	end if


end subroutine

on w_sr_profili.create
call super::create
end on

on w_sr_profili.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event u_ricevi_da_elenco;call super::u_ricevi_da_elenco;//
int k_return
int k_rc
st_esito kst_esito
st_tab_sr_prof_funz kst_tab_sr_prof_funz 
kuf_sr_sicurezza kuf1_sr_sicurezza


if isvalid(kst_open_w) then

//--- Dalla finestra di Elenco Valori
	if kst_open_w.id_programma = "elenco" then
	
		if not isvalid(kdsi_elenco_input) then kdsi_elenco_input = create datastore
	
//--- Se dalla w di elenco doppio-click		
 		if kst_open_w.key2 = ki_dw_lista_funzioni and long(kst_open_w.key3) > 0 then
		
			kdsi_elenco_input = kst_open_w.key12_any 
		
			if kdsi_elenco_input.rowcount() > 0 then
				
				kst_tab_sr_prof_funz.id_profili = &
			      tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "id")
				kst_tab_sr_prof_funz.id_funzioni = &
  		      	kdsi_elenco_input.getitemnumber(long(kst_open_w.key3), "id")

				if kst_tab_sr_prof_funz.id_funzioni > 0 then
					k_return = 1
					
					kuf1_sr_sicurezza = create kuf_sr_sicurezza
					kst_esito = kuf1_sr_sicurezza.tb_insert_sr_prof_funz (kst_tab_sr_prof_funz)
					destroy kuf1_sr_sicurezza
					
//--- torna a rileggere la lista					
					inizializza_lista()
					
					tab_1.tabpage_2.dw_2.SetSort("sr_prof_funz_id D")
					tab_1.tabpage_2.dw_2.Sort()					
					
					if kst_esito.esito <> "0" then
						messagebox("Operazione non riuscita", "Errore: " + trim(kst_esito.sqlerrtext), StopSign!)   
					end if
					
				end if
							
			end if
		end if

	end if

end if

return k_return


end event

event close;call super::close;//
	if isvalid(kdspi_elenco_output) then destroy kdspi_elenco_output 

end event

type st_ritorna from w_g_tab_3`st_ritorna within w_sr_profili
integer x = 101
integer y = 1148
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_sr_profili
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_sr_profili
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_sr_profili
end type

type st_stampa from w_g_tab_3`st_stampa within w_sr_profili
integer x = 507
integer y = 1152
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_sr_profili
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_sr_profili
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_sr_profili
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_sr_profili
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_sr_profili
end type

event cb_inserisci::clicked;//

choose case tab_1.selectedtab 

	case 2 
		chiama_elenco_funzioni()
				
	case else
		Super::EVENT Clicked()

end choose	


end event

type tab_1 from w_g_tab_3`tab_1 within w_sr_profili
boolean visible = true
integer width = 1303
long backcolor = 67108864
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
integer width = 1266
long backcolor = 67108864
string text = "Profilo"
long tabbackcolor = 67108864
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
boolean visible = true
integer width = 1202
string dataobject = "d_sr_profili"
boolean ki_colora_riga_aggiornata = false
end type

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
integer width = 1266
long backcolor = 67108864
string text = "Funzioni"
long tabbackcolor = 67108864
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
boolean visible = true
integer x = 9
integer y = 28
boolean enabled = true
string dataobject = "d_sr_prof_funz_l_1"
end type

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
boolean visible = true
integer width = 1266
long backcolor = 67108864
string text = "Elenco Utenti"
long tabbackcolor = 67108864
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
boolean visible = true
boolean enabled = true
string dataobject = "d_sr_utenti_prof_l"
end type

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
integer width = 1266
end type

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
end type

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
integer width = 1266
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
end type

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
integer width = 1266
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
end type

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
integer width = 1266
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
end type

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
integer width = 1266
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
integer width = 1266
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
end type

type st_duplica from w_g_tab_3`st_duplica within w_sr_profili
end type

