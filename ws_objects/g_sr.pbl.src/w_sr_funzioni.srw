$PBExportHeader$w_sr_funzioni.srw
forward
global type w_sr_funzioni from w_g_tab_3
end type
end forward

global type w_sr_funzioni from w_g_tab_3
integer width = 2313
integer height = 752
string title = "Funzione"
long backcolor = 67108864
boolean ki_toolbar_window_presente = true
end type
global w_sr_funzioni w_sr_funzioni

type variables
//
string ki_path_risorse
//datastore kdsi_elenco_output 
constant string ki_dw_lista_funzioni = "d_sr_prof_funz_l_diverso" 

end variables

forward prototypes
protected subroutine pulizia_righe ()
protected subroutine inizializza_2 ()
protected function integer cancella ()
protected subroutine inizializza_1 ()
protected subroutine attiva_menu ()
protected subroutine smista_funz (string k_par_in)
protected function string check_dati ()
protected function string inizializza ()
protected function integer inserisci ()
private subroutine mostra_operazioni_disp ()
protected subroutine riempi_id ()
private subroutine popola_sr_funzioni ()
protected subroutine inizializza_3 ()
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
			if isnull(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "id_programma")) &
				or LenA(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "id_programma"))) = 0  &
				then
		
				tab_1.tabpage_1.dw_1.deleterow(k_riga)
				
			end if
		end if
		
	next

end subroutine

protected subroutine inizializza_2 ();//
//======================================================================
//=== Inizializzazione del TAB 3 controllandone i valori se gia' presenti
//======================================================================
//
int k_rc=0
double k_dose 
string k_codice_attuale, k_codice_prec

	

//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if not isnull(tab_1.tabpage_3.st_3_retrieve.text) then
	k_codice_prec = tab_1.tabpage_3.st_3_retrieve.text
else
	k_codice_prec = " "
end if

k_codice_attuale = "*"

//=== Forza valore Codice composto per ricordarlo per le prossime richieste
tab_1.tabpage_3.st_3_retrieve.text = k_codice_attuale

if k_codice_attuale <> k_codice_prec then

	k_rc=tab_1.tabpage_3.dw_3.retrieve()  

end if				
				

attiva_tasti()
if tab_1.tabpage_3.dw_3.rowcount() = 0 then
	tab_1.tabpage_3.dw_3.insertrow(0) 
end if


tab_1.tabpage_3.dw_3.setfocus()
	
	

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
				kst_tab_sr_funzioni.id = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id")
				kst_tab_sr_funzioni.nome = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "nome")
				if isnull(kst_tab_sr_funzioni.nome) = true or trim(kst_tab_sr_funzioni.nome) = "" then
					k_testo = trim(tab_1.tabpage_1.dw_1.object.nome_t.text)
					kst_tab_sr_funzioni.nome = "senza " + k_testo
				end if
				k_record_1 = &
					"Sei sicuro di voler eliminare la " + trim(tab_1.tabpage_1.text) + "~n~r" + &
					trim(kst_tab_sr_funzioni.nome)  &
				   + " ?"
			else
				tab_1.tabpage_1.dw_1.deleterow(k_riga)
			end if
		end if
		k_key = trim(string(kst_tab_sr_funzioni.id))

	case 2 
		k_record = " " + trim(tab_1.tabpage_2.text) + " "
		k_riga = tab_1.tabpage_2.dw_2.getselectedrow(0)
		if k_riga > 0 then
			if tab_1.tabpage_2.dw_2.getitemstatus(k_riga, 0, primary!) <> new! and &
				tab_1.tabpage_2.dw_2.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
				
				kst_tab_sr_prof_funz.id = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "sr_prof_funz_id")
				kst_tab_sr_funzioni.id = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id")
				kst_tab_sr_funzioni.nome = tab_1.tabpage_2.dw_2.getitemstring(k_riga, "nome")

				if isnull(kst_tab_sr_funzioni.id) then
					kst_tab_sr_funzioni.id = 0
				end if
				if isnull(kst_tab_sr_funzioni.nome) or trim(kst_tab_sr_funzioni.nome) = "" then
					k_testo = trim(tab_1.tabpage_2.dw_2.object.nome_t.text)
					kst_tab_sr_funzioni.nome = "senza " + k_testo
				end if
				
				k_record_1 = &
					"Sei sicuro di voler eliminare l'associazione con il Profilo" + "~n~r" + &
					trim(kst_tab_sr_funzioni.nome) + " id=" + string(kst_tab_sr_funzioni.id) &
				   + " ?"
			else
				tab_1.tabpage_2.dw_2.deleterow(k_riga)
			end if
		end if
		k_key = trim(string(kst_tab_sr_prof_funz.id))
		
		
//	case 4
//		k_record = " Fattura di anticipo "
//		k_riga = tab_1.tabpage_4.dw_4.getselectedrow(0)
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
				kst_esito = kuf1_sr_sicurezza.tb_delete_sr_funzioni(kst_tab_sr_funzioni) 
			case 2
				kst_esito = kuf1_sr_sicurezza.tb_delete_sr_prof_funz(kst_tab_sr_prof_funz) 
		end choose	
		if kst_esito.esito = kkg_esito.ko then

//--- Se tutto OK faccio la COMMIT		
			kst_esito = kguo_sqlca_db_magazzino.db_commit()
			if kst_esito.esito <> kkg_esito.ok then
				k_return = 1
				messagebox("Problemi durante la Cancellazione !!", "Controllare i dati. " +  " ~n~rErrore: " + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext))

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
			k_errore = "Operazione fallita !! ~n~rErrore: " + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) 
			kguo_sqlca_db_magazzino.db_rollback( )
			if kst_esito.esito <> kkg_esito.ok then
				k_errore += "~n~rfallito anche il 'recupero' dell'errore: ~n~r" + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) 
			end if
			k_errore += "~n~rPrego, controllare i dati !! "
			messagebox("Problemi durante Cancellazione", trim(k_errore))
			
			attiva_tasti()

		end if

//=== Distruggo l'oggetto che ha avuto la funzione x cancellare la tabella
		destroy kuf1_sr_sicurezza

	else
		messagebox("Elimina " + k_record,  "Operazione Annullata !!")
		k_return = 2
	end if
else
	messagebox("Elimina " + k_record,  "Selezionare almeno una riga. ")

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

protected subroutine attiva_menu ();//

	choose case tab_1.selectedtab 

		case 1
			ki_menu.m_finestra.m_gestione.m_fin_inserimento.text = "Inserisci"
			ki_menu.m_finestra.m_gestione.m_fin_elimina.text = "Elimina"
		case 2 
			ki_menu.m_finestra.m_gestione.m_fin_inserimento.text = "Aggiunge Profilo"
			ki_menu.m_finestra.m_gestione.m_fin_elimina.text = "Toglie Profilo"
			
	end choose

	ki_menu.m_finestra.m_gestione.m_fin_inserimento.microhelp = ki_menu.m_finestra.m_gestione.m_fin_inserimento.text
	ki_menu.m_finestra.m_gestione.m_fin_inserimento.toolbaritemtext = ki_menu.m_finestra.m_gestione.m_fin_inserimento.text
	ki_menu.m_finestra.m_gestione.m_fin_elimina.microhelp = ki_menu.m_finestra.m_gestione.m_fin_elimina.text
	ki_menu.m_finestra.m_gestione.m_fin_elimina.toolbaritemtext = ki_menu.m_finestra.m_gestione.m_fin_elimina.text


//
//--- Attiva/Dis. Voci di menu personalizzate
//
	if ki_menu.m_strumenti.m_fin_gest_libero1.visible then
		ki_menu.m_strumenti.m_fin_gest_libero1.text = "Importa Programmi"
		ki_menu.m_strumenti.m_fin_gest_libero1.microhelp = &
		"Carica le Funzioni mancanti da elenco Programmi"
		ki_menu.m_strumenti.m_fin_gest_libero1.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero1.enabled = cb_inserisci.enabled
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemtext = "Importa,"+&
												 ki_menu.m_strumenti.m_fin_gest_libero1.text
	//	ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex = 2
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemvisible = true
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemname = "CheckIn!" //ki_path_risorse + "\barcode.bmp"
	end if
	
	super::attiva_menu()
	
	


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
			popola_sr_funzioni() 
		end if

	case else      // standard
		super::smista_funz(k_par_in)
		
end choose



end subroutine

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
int k_riga
int k_nr_errori
string k_key_str
string k_stato, k_tipo
string k_key, k_testo
st_esito kst_esito
st_tab_sr_funzioni kst_tab_sr_funzioni
kuf_sr_sicurezza kuf1_sr_sicurezza



//=== Controllo il primo tab
	k_nr_righe = tab_1.tabpage_1.dw_1.rowcount()
	k_nr_errori = 0
	k_riga = 1

	kst_tab_sr_funzioni.id = tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "id") 
	if isnull(kst_tab_sr_funzioni.id) then
		kst_tab_sr_funzioni.id = 0
	end if
	kst_tab_sr_funzioni.id_programma = tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "id_programma") 
	kst_tab_sr_funzioni.nome = tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "nome") 
	if isnull(kst_tab_sr_funzioni.nome) or LenA(trim(kst_tab_sr_funzioni.nome)) = 0 then
		kst_tab_sr_funzioni.nome = upper(kst_tab_sr_funzioni.id_programma)
		tab_1.tabpage_1.dw_1.setitem ( k_riga, "nome", kst_tab_sr_funzioni.nome) 
	end if
	
	if LenA(trim(kst_tab_sr_funzioni.id_programma)) > 0 then
		kuf1_sr_sicurezza = create kuf_sr_sicurezza
		kst_esito = kuf1_sr_sicurezza.tb_sr_funzioni_conta_id_programma(kst_tab_sr_funzioni)
		destroy kuf1_sr_sicurezza
		if kst_esito.esito = "0" and kst_tab_sr_funzioni.contatore > 0 then
			k_errore = "4"
			kst_tab_sr_funzioni.nome = trim(kst_tab_sr_funzioni.nome) + trim(string(kst_tab_sr_funzioni.contatore))
			tab_1.tabpage_1.dw_1.setitem ( k_riga, "nome", kst_tab_sr_funzioni.nome) 
			k_return = tab_1.tabpage_1.text + ": Funzione gia' caricata, nuovo nome proposto: " &
			                   + kst_tab_sr_funzioni.nome + " " + &
									 + "~n~r" 
		end if
	end if

//	if isnull(k_key) or len(trim(k_key)) = 0 then
//		k_testo = trim(tab_1.tabpage_1.dw_1.object.nome_t.text)
//		k_return = tab_1.tabpage_1.text + ": Manca valore nel campo '" + k_testo + "'. " + "~n~r"
//		k_errore = "3"
//		k_nr_errori++
//	end if
//	if isnull(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "id_programma")) = true then
//		k_testo = trim(tab_1.tabpage_1.dw_1.object.id_programma_t.text)
//		k_return = k_return + tab_1.tabpage_1.text + ": Manca valore nel campo '" + k_testo + "'. " + "~n~r" 
//		k_errore = "3"
//		k_nr_errori++
//	end if

	if k_errore = "0" then
	
		tab_1.tabpage_1.dw_1.setitem(k_riga, "x_datins", today())
		tab_1.tabpage_1.dw_1.setitem(k_riga, "x_utente", kguo_utente.get_codice())
		
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
datawindowchild kdwc_dw1
kuf_utility kuf1_utility


//=== 
//tab_1.tabpage_4.dw_41.settransobject(sqlca)


if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
	k_scelta = trim(ki_st_open_w.flag_modalita)
	
	k_key = trim(ki_st_open_w.key1)

	tab_1.tabpage_1.dw_1.getchild("id_programma", kdwc_dw1)
	kdwc_dw1.settransobject(sqlca)
	kdwc_dw1.insertrow(0)


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

				if k_scelta <> kkg_flag_modalita.inserimento then
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
				if k_scelta = kkg_flag_modalita.inserimento then
					cb_inserisci.postevent(clicked!)
				end if

				tab_1.tabpage_1.dw_1.setfocus()
				tab_1.tabpage_1.dw_1.setcolumn(1)
				
				attiva_tasti()
		
		end choose

	end if

	kdwc_dw1.retrieve()

	mostra_operazioni_disp() // mostra le operazioni disponibili della funzione letta

else
	attiva_tasti()
end if


//===
//--- inabilito le modifiche sulla dw
if k_errore = 0 then
	
//--- Inabilita campi alla modifica se Vsualizzazione
	kuf1_utility = create kuf_utility 
	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.visualizzazione &
	   or trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.cancellazione then
		
		kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_1.dw_1)

	else		
		
//--- S-protezione campi per riabilitare la modifica 
      kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)

		if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then 
//--- proteggi il primo campo
			kuf1_utility.u_proteggi_dw("1", 1, tab_1.tabpage_1.dw_1)
		end if

	end if
	destroy kuf1_utility
	
//--- se cancellazione
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.cancellazione then

		cb_cancella.postevent (clicked!)
		
	end if
end if


return "0"

end function

protected function integer inserisci ();//
int k_return 
kuf_utility kuf1_utility


	k_return = super::inserisci()


	if tab_1.tabpage_1.dw_1.rowcount() > 0 then
		kuf1_utility = create kuf_utility
//--- S-protezione campi per riabilitare la modifica 
		kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)
		destroy kuf1_utility
	end if		


return k_return
end function

private subroutine mostra_operazioni_disp ();//
//--- legge dalla DDW delle funzioni e mostra le operazioni disponibili
//
string k_codice, k_operazioni
int k_errore=0, k_riga=0
datawindowchild kdwc_dw1
		

if tab_1.tabpage_1.dw_1.getrow() > 0 then
	
	k_codice = lower(trim(tab_1.tabpage_1.dw_1.object.id_programma.primary[tab_1.tabpage_1.dw_1.getrow()]))
	if isnull(k_codice) = false and LenA(trim(k_codice)) > 0 then
	
		tab_1.tabpage_1.dw_1.getchild("id_programma", kdwc_dw1)
		if kdwc_dw1.rowcount() > 0 then
			k_riga = kdwc_dw1.find("id='" + k_codice + "' ", 1, kdwc_dw1.rowcount())
			if k_riga > 0 then
				k_operazioni = trim(tab_1.tabpage_1.dw_1.object.id_programma.object.funzioni.primary[k_riga])
			else
				k_operazioni = "nessuna"
			end if
		end if
	else
		k_operazioni = "nessuna"
	end if
	
	tab_1.tabpage_1.dw_1.object.t_disponibili.text = "disponibili: " + upper(string(k_operazioni, "@ @ @ @ @ @ @ @ @ @ @ @ @"))
		
end if
	

end subroutine

protected subroutine riempi_id ();//
datawindowchild kdwc_1
long k_riga, k_riga_dw3
date k_dataoggi
kuf_base kuf1_base

	
	k_riga = tab_1.tabpage_1.dw_1.getrow()


	
	if k_riga > 0 then

//--- legge la dw dei programmi
		if tab_1.tabpage_3.dw_3.rowcount() = 0 then
			tab_1.tabpage_3.dw_3.retrieve()  
		end if

		if isnull(tab_1.tabpage_1.dw_1.getitemdate(k_riga, "data_1")) &
		   or tab_1.tabpage_1.dw_1.getitemdate(k_riga, "data_1") = date(0) &
			then				
		
			kuf1_base = create kuf_base
			k_dataoggi = date(MidA(kuf1_base.prendi_dato_base("dataoggi"),2))
			destroy kuf1_base

			tab_1.tabpage_1.dw_1.setitem(k_riga, "data_1", k_dataoggi)
		end if

		if isnull(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "descrizione")) &
		   or LenA(trim(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "descrizione"))) = 0 &
			then				

			k_riga_dw3 = tab_1.tabpage_3.dw_3.Find( "id = '" &
						+ string(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "id_programma")) + "' ", &
						1, tab_1.tabpage_3.dw_3.RowCount( ))

			if k_riga_dw3 > 0 then
				tab_1.tabpage_1.dw_1.setitem(k_riga, "descrizione", &
					trim(tab_1.tabpage_3.dw_3.getitemstring(k_riga_dw3, "titolo")))
			else
				tab_1.tabpage_1.dw_1.setitem(k_riga, "descrizione", " ")
			end if			
		end if

//--- imposta le funzioni/operazioni 
		if isnull(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "funzioni")) &
			or LenA(trim(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "funzioni"))) = 0 &
			or trim(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "funzioni")) = "X" &
			then				

			k_riga_dw3 = tab_1.tabpage_3.dw_3.Find( "id = '" &
						+ string(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "id_programma")) + "' ", &
						1, tab_1.tabpage_3.dw_3.RowCount( ))

			if k_riga_dw3 > 0 then
				tab_1.tabpage_1.dw_1.setitem(k_riga, "funzioni", &
					upper(trim(tab_1.tabpage_3.dw_3.getitemstring(k_riga_dw3, "funzioni"))))
			else
				tab_1.tabpage_1.dw_1.setitem(k_riga, "funzioni", " ")
			end if			
			
		end if
		
//=== Se sono in insert azzero il ID  
		if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) = newmodified! then
			if isnull(tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id")) &
				then				
				tab_1.tabpage_1.dw_1.setitem(k_riga, "id", 0)
			end if
		end if
	end if
	
end subroutine

private subroutine popola_sr_funzioni ();//
datawindowchild kdwc_1
long k_riga_elab, k_riga_max
long k_len, k_pos
string k_funzioni, k_funzioni1
pointer kp_oldpointer
st_tab_sr_funzioni kst_tab_sr_funzioni, kst1_tab_sr_funzioni
st_esito kst_esito
kuf_sr_sicurezza kuf1_sr_sicurezza
kuf_base kuf1_base



	
	tab_1.tabpage_3.dw_3.retrieve()  
	k_riga_max = tab_1.tabpage_3.dw_3.rowcount()

	if k_riga_max > 0 then
//=== Richiesta di conferma della eliminazione del rek
		if messagebox("Inserisci Funzioni", & 
		              "Confermare l'operazione di inserimento automatico delle Funzioni mancanti?", &
			           question!, yesno!, 2) = 1 then
				
			kp_oldpointer = SetPointer(HourGlass!)
		else
 			k_riga_max = 0
		end if
	end if
	
	
	kuf1_sr_sicurezza = create kuf_sr_sicurezza
	
	k_riga_elab = 1
	do while k_riga_elab <= k_riga_max

		kst_tab_sr_funzioni.id_programma = tab_1.tabpage_3.dw_3.getitemstring(k_riga_elab, "id")
		tab_1.tabpage_1.dw_1.setitem(1, "id_programma", kst_tab_sr_funzioni.id_programma)
		
		k_funzioni1 = ""
		k_funzioni = ""
		kst_tab_sr_funzioni.funzioni = upper(trim(tab_1.tabpage_3.dw_3.getitemstring(k_riga_elab, "funzioni")))
		
		k_funzioni = trim(upper(kuf1_sr_sicurezza.get_funzione_f(kkg_flag_modalita.inserimento)))
		k_pos = PosA(kst_tab_sr_funzioni.funzioni, k_funzioni, 1) 
		if k_pos > 0 then
			kst_tab_sr_funzioni.funzioni=ReplaceA(kst_tab_sr_funzioni.funzioni, k_pos, 1, " ")
			kst1_tab_sr_funzioni.id_programma = kst_tab_sr_funzioni.id_programma 
			kst1_tab_sr_funzioni.funzioni = k_funzioni
			kst1_tab_sr_funzioni.nome = upper(trim(kst_tab_sr_funzioni.id_programma))
			kst1_tab_sr_funzioni.id = 0
			kuf1_sr_sicurezza.tb_sr_funzioni_conta_id_programma(kst1_tab_sr_funzioni) 
			if kst1_tab_sr_funzioni.contatore = 0 then
//--- predispone campo x inserire la funzione in archivio
				k_funzioni1 = k_funzioni1 + k_funzioni
			end if
		end if

		k_funzioni = trim(upper(kuf1_sr_sicurezza.get_funzione_f(kkg_flag_modalita.modifica)))
		k_pos = PosA(kst_tab_sr_funzioni.funzioni, k_funzioni, 1) 
		if k_pos > 0 then
			kst_tab_sr_funzioni.funzioni=ReplaceA(kst_tab_sr_funzioni.funzioni, k_pos, 1, " ")
			kst1_tab_sr_funzioni.id_programma = kst_tab_sr_funzioni.id_programma 
			kst1_tab_sr_funzioni.funzioni = k_funzioni
			kst1_tab_sr_funzioni.nome = upper(trim(kst_tab_sr_funzioni.id_programma))
			kst1_tab_sr_funzioni.id = 0
			kuf1_sr_sicurezza.tb_sr_funzioni_conta_id_programma(kst1_tab_sr_funzioni) 
			if kst1_tab_sr_funzioni.contatore = 0 then
//--- predispone campo x inserire la funzione in archivio
				k_funzioni1 = k_funzioni1 + k_funzioni
			end if
		end if

		k_funzioni = trim(upper(kuf1_sr_sicurezza.get_funzione_f(kkg_flag_modalita.cancellazione)))
		k_pos = PosA(kst_tab_sr_funzioni.funzioni, k_funzioni, 1) 
		if k_pos > 0 then
			kst_tab_sr_funzioni.funzioni=ReplaceA(kst_tab_sr_funzioni.funzioni, k_pos, 1, " ")
			kst1_tab_sr_funzioni.id_programma = kst_tab_sr_funzioni.id_programma 
			kst1_tab_sr_funzioni.funzioni = k_funzioni
			kst1_tab_sr_funzioni.nome = upper(trim(kst_tab_sr_funzioni.id_programma))
			kst1_tab_sr_funzioni.id = 0
			kuf1_sr_sicurezza.tb_sr_funzioni_conta_id_programma(kst1_tab_sr_funzioni) 
			if kst1_tab_sr_funzioni.contatore = 0 then
//--- predispone campo x inserire la funzione in archivio
				k_funzioni1 = k_funzioni1 + k_funzioni
			end if
		end if

      if LenA(trim(k_funzioni1)) > 0 then
			tab_1.tabpage_1.dw_1.setitem(1, "funzioni", trim(k_funzioni1))
//--- Inserisce la funzione in archivio
			kst1_tab_sr_funzioni.id_programma = kst_tab_sr_funzioni.id_programma 
			kst1_tab_sr_funzioni.funzioni = trim(k_funzioni1)
			kst1_tab_sr_funzioni.nome = upper(trim(kst_tab_sr_funzioni.id_programma)) + trim(k_funzioni1)
			kst1_tab_sr_funzioni.id = 0
			kuf1_sr_sicurezza.tb_sr_funzioni_conta_id_programma(kst1_tab_sr_funzioni) 
			if kst1_tab_sr_funzioni.contatore = 0 then
				kst_esito = kuf1_sr_sicurezza.tb_sr_funzioni_assegna_nome(kst1_tab_sr_funzioni) 
				if kst_esito.esito = "0" then 
					tab_1.tabpage_1.dw_1.setitem(1, "nome", kst1_tab_sr_funzioni.nome)
					if LeftA(aggiorna_dati(), 1) <> "0" then
						k_riga_elab = k_riga_max + 1
					else
						inserisci()
					end if
				end if
			end if
		end if

//--- scova le altre funzioni oltre a quelle standard INS+MOD+CANC raggruppate sopra
		k_funzioni = ""
		if k_riga_elab <= k_riga_max then
			k_len = LenA(kst_tab_sr_funzioni.funzioni)
			for k_pos = 1 to k_len
				
				k_funzioni = upper(MidA(kst_tab_sr_funzioni.funzioni, k_pos, 1)) 
				kst_tab_sr_funzioni.funzioni=ReplaceA(kst_tab_sr_funzioni.funzioni, k_pos, 1, " ")
				
				if LenA(trim(k_funzioni)) > 0 then
					kst_tab_sr_funzioni.id_programma = tab_1.tabpage_3.dw_3.getitemstring(k_riga_elab, "id")
					tab_1.tabpage_1.dw_1.setitem(1, "id_programma", kst_tab_sr_funzioni.id_programma)
					tab_1.tabpage_1.dw_1.setitem(1, "funzioni", k_funzioni)
					
					kst1_tab_sr_funzioni.id_programma = kst_tab_sr_funzioni.id_programma 
					kst1_tab_sr_funzioni.funzioni = trim(k_funzioni)
					kst1_tab_sr_funzioni.nome = upper(trim(kst_tab_sr_funzioni.id_programma)) + k_funzioni
					kst1_tab_sr_funzioni.id = 0
					kuf1_sr_sicurezza.tb_sr_funzioni_conta_id_programma(kst1_tab_sr_funzioni) 
					if kst1_tab_sr_funzioni.contatore = 0 then
//--- Inserisce la funzione in archivio
						kst_esito = kuf1_sr_sicurezza.tb_sr_funzioni_assegna_nome(kst1_tab_sr_funzioni) 
						if kst_esito.esito = "0" then 
							tab_1.tabpage_1.dw_1.setitem(1, "nome", kst1_tab_sr_funzioni.nome)
							if LeftA(aggiorna_dati(), 1) <> "0" then
								k_riga_elab = k_riga_max + 1
							else
								inserisci()
							end if
						end if
					end if
				end if
			end for
		end if
		
		k_riga_elab++

	loop 

	tab_1.tabpage_3.dw_3.resetupdate()
	inserisci()

	destroy kuf1_sr_sicurezza

	SetPointer(kp_oldpointer)

//--- close della windows
	if cb_ritorna.enabled then
		cb_ritorna.postevent(clicked!)
	end if

	
end subroutine

protected subroutine inizializza_3 ();//
//======================================================================
//=== Inizializzazione del TAB 3 controllandone i valori se gia' presenti
//======================================================================
//
int k_rc=0
double k_dose 
string k_codice_attuale, k_codice_prec
long k_key
	

//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if not isnull(tab_1.tabpage_4.st_4_retrieve.text) then
	k_codice_prec = tab_1.tabpage_4.st_4_retrieve.text
else
	k_codice_prec = " "
end if

k_key = tab_1.tabpage_1.dw_1.object.id[tab_1.tabpage_1.dw_1.getrow()]
k_codice_attuale = string(k_key)

//=== Forza valore Codice composto per ricordarlo per le prossime richieste
tab_1.tabpage_4.st_4_retrieve.text = k_codice_attuale

if k_codice_attuale <> k_codice_prec then

	k_rc=tab_1.tabpage_4.dw_4.retrieve(k_key, 0)  

end if				
				

attiva_tasti()
if tab_1.tabpage_4.dw_4.rowcount() = 0 then
	tab_1.tabpage_4.dw_4.insertrow(0) 
end if


tab_1.tabpage_4.dw_4.setfocus()
	
	

end subroutine

protected subroutine open_start_window ();//
	ki_toolbar_window_presente=true

end subroutine

protected subroutine attiva_tasti_0 ();//
	super::attiva_tasti_0()

	cb_modifica.enabled = false

	tab_1.tabpage_2.enabled = false
	if tab_1.tabpage_1.dw_1.getrow() > 0 then
		if tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "id") > 0 then
			tab_1.tabpage_2.enabled = true 
			tab_1.tabpage_4.enabled = true 
		end if
	end if


	if tab_1.selectedtab <> 1 then
		cb_aggiorna.enabled = false
		cb_visualizza.enabled = false
	end if

	if tab_1.selectedtab = 4 then
		cb_inserisci.enabled = false
		cb_cancella.enabled = false
	end if


	
end subroutine

on w_sr_funzioni.create
call super::create
end on

on w_sr_funzioni.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event u_ricevi_da_elenco;call super::u_ricevi_da_elenco;//
//
int k_rc
long k_num_int, k_riga
date k_data_int
window k_window
st_esito kst_esito
st_tab_sr_prof_funz kst_tab_sr_prof_funz 
kuf_menu_window kuf1_menu_window 
kuf_sr_sicurezza kuf1_sr_sicurezza



//st_open_w kst_open_w

//kst_open_w = Message.PowerObjectParm	

if isvalid(kst_open_w) then

//--- Dalla finestra di Elenco Valori
	if kst_open_w.id_programma = kkg_id_programma_elenco then
	
		if not isvalid(kdsi_elenco_input) then kdsi_elenco_input = create datastore
	
		choose case kst_open_w.key2

			case ki_dw_lista_funzioni 
			
//--- Se dalla w di elenco doppio-click		
 				if long(kst_open_w.key3) > 0 then
		
					kdsi_elenco_input = kst_open_w.key12_any 
				
					if kdsi_elenco_input.rowcount() > 0 then
						
						kst_tab_sr_prof_funz.id_profili = &
							tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "id")
						kst_tab_sr_prof_funz.id_funzioni = &
							kdsi_elenco_input.getitemnumber(long(kst_open_w.key3), "id")
		
						if kst_tab_sr_prof_funz.id_funzioni > 0 then
							
							kuf1_sr_sicurezza = create kuf_sr_sicurezza
							kst_esito = kuf1_sr_sicurezza.tb_insert_sr_prof_funz (kst_tab_sr_prof_funz)
							destroy kuf1_sr_sicurezza
						
	//--- torna a rileggere la lista					
							inizializza_lista()
							
							if kst_esito.esito <> "0" then
								messagebox("Operazione non riuscita", &
											  + trim(kst_esito.sqlerrtext), &
											  StopSign!&
											 )   
							end if
							
						end if
									
					end if
				end if

//--- Programma ID
			case "d_menu_window_l" 
				if long(kst_open_w.key3) > 0 then
					kdsi_elenco_input = kst_open_w.key12_any 
					if kdsi_elenco_input.rowcount() > 0 then
		
						tab_1.tabpage_1.dw_1.setitem(1, "id_programma", trim(kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "id")))
//						tab_1.tabpage_1.dw_1.setitem(1, "id_programma_1", (trim(kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "descr"))))

					end if
				end if
				
				
		end choose

	end if

end if
//


end event

event open;call super::open;//
//--- path per reperire le ico del drag e drop
ki_path_risorse = trim(kGuf_data_base.profilestring_leggi_scrivi(1, "arch_graf", " "))

end event

type st_ritorna from w_g_tab_3`st_ritorna within w_sr_funzioni
integer x = 101
integer y = 1148
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_sr_funzioni
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_sr_funzioni
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_sr_funzioni
end type

type st_stampa from w_g_tab_3`st_stampa within w_sr_funzioni
integer x = 507
integer y = 1152
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_sr_funzioni
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_sr_funzioni
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_sr_funzioni
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_sr_funzioni
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_sr_funzioni
end type

event cb_inserisci::clicked;//
int k_rc
string k_id_programma="", k_key
long k_riga=0
window k_window
st_open_w k_st_open_w
st_open_w kst_open_w
kuf_base kuf1_base
kuf_menu_window kuf1_menu_window
st_tab_sr_prof_funz kst_tab_sr_prof_funz
st_tab_sr_utenti kst_tab_sr_funzioni

//--- popolo il datasore (dw non visuale) per appoggio elenco
if not isvalid(kdsi_elenco_output) then kdsi_elenco_output = create datastore

choose case tab_1.selectedtab 

	case 2 
//--- ricavo l'id
		k_riga = tab_1.tabpage_1.dw_1.getrow()
		kst_tab_sr_prof_funz.id_funzioni = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id")
		kst_tab_sr_funzioni.descrizione = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "descrizione")
		kst_tab_sr_funzioni.nome = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "nome")
	

		kdsi_elenco_output.dataobject = ki_dw_lista_funzioni 
		k_rc = kdsi_elenco_output.settransobject ( sqlca )
		k_rc = kdsi_elenco_output.retrieve(kst_tab_sr_prof_funz.id_funzioni)

		if isnull(kst_tab_sr_funzioni.nome) then
			kst_tab_sr_funzioni.nome = " "
		end if
		if isnull(kst_tab_sr_funzioni.descrizione) then
			kst_tab_sr_funzioni.descrizione = " "
		end if
		
		kst_open_w.key1 = "Elenco Funzioni disponibili per il Profilo " &
							  + trim(kst_tab_sr_funzioni.nome) + " " &
		                 + trim(kst_tab_sr_funzioni.descrizione) 

	
		if kdsi_elenco_output.rowcount() > 0 then
	
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
			kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
			kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
			kst_open_w.key4 = k_window.title    //--- Titolo della Window di chiamata per riconoscerla
			kst_open_w.key12_any = kdsi_elenco_output
			kst_open_w.flag_where = " "
			kuf1_menu_window = create kuf_menu_window 
			kuf1_menu_window.open_w_tabelle(kst_open_w)
			destroy kuf1_menu_window
	
		else
			
			messagebox("Elenco Dati", &
						"Nessun valore disponibile. ")
			
			
		end if
				
	case else
		Super::EVENT Clicked()
		
		
end choose	


end event

type tab_1 from w_g_tab_3`tab_1 within w_sr_funzioni
integer x = 0
integer y = 0
integer width = 2066
integer height = 1120
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
integer width = 2030
integer height = 992
long backcolor = 67108864
string text = "Funzione"
long tabbackcolor = 67108864
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
boolean visible = true
integer width = 1202
string dataobject = "d_sr_funzioni"
boolean ki_colora_riga_aggiornata = false
end type

event dw_1::itemchanged;call super::itemchanged;//


choose case dwo.name 
		
	case "id_programma" 

		mostra_operazioni_disp()
		
end choose 


end event

event dw_1::clicked;call super::clicked;//
kuf_sr_sicurezza kuf1_sr_sicurezza


if dwo.name = "b_id_programma" then

	try 
		kuf1_sr_sicurezza = create kuf_sr_sicurezza
		kuf1_sr_sicurezza.link_call( kidw_selezionata  , "b_menu_window") //"b_sr_sicurezza" )

	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
	end try
	
end if
end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
integer width = 2030
integer height = 992
long backcolor = 67108864
string text = "Profili"
long tabbackcolor = 67108864
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
boolean visible = true
integer x = 9
integer y = 28
boolean enabled = true
string dataobject = "d_sr_prof_funz_l_2"
end type

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
boolean visible = true
integer width = 2030
integer height = 992
long backcolor = 67108864
string text = "Programmi"
long tabbackcolor = 67108864
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
boolean visible = true
integer x = 46
boolean enabled = true
string dataobject = "d_menu_window_l_1"
end type

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
boolean visible = true
integer width = 2030
integer height = 992
long backcolor = 134217750
string text = "Utenti Associati"
long tabbackcolor = 134217750
end type

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
boolean visible = true
boolean enabled = true
string dataobject = "d_sr_funz_utenti_l"
end type

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
integer width = 2030
integer height = 992
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
end type

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
integer width = 2030
integer height = 992
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
end type

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
integer width = 2030
integer height = 992
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
end type

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
integer width = 2030
integer height = 992
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
integer width = 2030
integer height = 992
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
end type

