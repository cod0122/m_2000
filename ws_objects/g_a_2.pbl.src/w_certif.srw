$PBExportHeader$w_certif.srw
forward
global type w_certif from w_g_tab_3
end type
end forward

global type w_certif from w_g_tab_3
string title = "Attestati"
end type
global w_certif w_certif

type variables
//
//	datastore kdsi_elenco 
	private boolean ki_stampa_attestato = false
	private uo_d_certif_stampa kiuo1_d_certif_stampa
	

end variables

forward prototypes
protected function string aggiorna ()
protected function integer cancella ()
protected subroutine attiva_menu ()
protected subroutine smista_funz (string k_par_in)
private subroutine stampa_attestato ()
protected subroutine riempi_id ()
protected function string check_dati ()
protected function string inizializza ()
protected function string dati_modif (string k_titolo)
protected subroutine open_start_window ()
private subroutine rigenera_alcuni_dati_lotto ()
protected subroutine attiva_tasti_0 ()
end prototypes

protected function string aggiorna ();//
//======================================================================
//=== Aggiorna tabelle 
//=== Ritorna 1 chr : 0=tutto OK; 1=errore grave I-O;
//=== 				  : 2=
//===					  : 3=Commit fallita
//===		dal char 2 in poi spiegazione dell'errore
//======================================================================
 
string k_return="0 ", k_errore="0 ", k_errore1="0 "
pointer kp_oldpointer


//=== Puntatore Cursore da attesa..... 
kp_oldpointer = SetPointer(HourGlass!)

//=== Aggiorna, se modificato, la TAB_1	
if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0 &
			or tab_1.tabpage_1.dw_1.getnextmodified(0, delete!) > 0 then

	if tab_1.tabpage_1.dw_1.update() = 1 then

//=== Se tutto OK faccio la COMMIT		
		k_errore1 = kGuf_data_base.db_commit()
		if LeftA(k_errore1, 1) <> "0" then
			k_return = "3" + "Archivio " + tab_1.tabpage_1.text + MidA(k_errore1, 2)
		else // Tutti i Dati Caricati in Archivio
			k_return ="0 "
		end if
	else
		k_errore1 = kGuf_data_base.db_rollback()
		k_return="1Fallito aggiornamento archivio '" + &
					tab_1.tabpage_1.text + "' ~n~r" 
				end if
end if



//=== Puntatore Cursore da attesa.....
SetPointer(kp_oldpointer)


//=== errore : 0=tutto OK o NON RICHIESTA; 1=errore grave I-O;
//=== 		 : 2=LIBERO
//===			 : 3=Commit fallita

if LeftA(k_return, 1) = "1" then
	messagebox("Operazione di Aggiornamento Non Eseguita !!", &
		MidA(k_return, 2))
else
	if LeftA(k_return, 1) = "3" then
		messagebox("Registrazione dati : problemi nella 'Commit' !!", &
			"Provare a chiudere e ripetere le operazioni eseguite")
	end if
end if


return k_return

end function

protected function integer cancella ();//
//=== Cancellazione record dal DB
//=== Ritorna : 0=OK 1=KO 2=non eseguita
//
int k_return=0
string k_record, k_record_1, k_key, k_testo
string k_errore = "0 "
long k_riga
kuf_certif  kuf1_certif
st_esito kst_esito
st_tab_certif kst_tab_certif



//=== 
choose case tab_1.selectedtab 
	case 1 
		k_record = " " + trim(tab_1.tabpage_1.text) + " "
		k_riga = tab_1.tabpage_1.dw_1.getrow()	
		if k_riga > 0 then
			if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> new! and &
				tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
				
				kst_tab_certif.id = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "certif_id")
				kst_tab_certif.num_certif = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "certif_num_certif")
				
				if isnull(kst_tab_certif.num_certif) or kst_tab_certif.num_certif = 0 then
					k_testo = trim(tab_1.tabpage_2.dw_2.object.codice_t.text)
					k_record_1 = &
					"Sei sicuro di voler eliminare la stampa dell'Attestato SENZA Numero~n~r" 
				else
					k_record_1 = &
					"Sei sicuro di voler eliminare la stampa dell'Attestato~n~r" + &
					"Numero: " + string(kst_tab_certif.num_certif)  &
				   + " ?"
				end if
			else
				tab_1.tabpage_1.dw_1.deleterow(k_riga)
			end if
		end if
		k_key = trim(string(kst_tab_certif.id))
		
//	case 2  
//		k_record = " " + trim(tab_1.tabpage_2.text) + " " 
//		k_riga = tab_1.tabpage_2.dw_2.getrow()	
//		if k_riga > 0 then
//				
//			kst_tab_sr_prof_utenti.id = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "sr_prof_utenti_id")
//				
//			if tab_1.tabpage_2.dw_2.getitemstatus(k_riga, 0, primary!) <> new! and &
//				tab_1.tabpage_2.dw_2.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
//				
//				kst_tab_certif.nome = tab_1.tabpage_2.dw_2.getitemstring(k_riga, "nome")
//				kst_tab_certif.descrizione = tab_1.tabpage_2.dw_2.getitemstring(k_riga, "descrizione")
//				
//				if isnull(kst_tab_certif.nome) or trim(kst_tab_certif.nome) = "" then
//					k_testo = trim(tab_1.tabpage_2.dw_2.object.nome_t.text)
//					kst_tab_certif.nome = "senza " + k_testo
//				end if
//				if isnull(kst_tab_certif.descrizione) or trim(kst_tab_certif.descrizione) = "" then
//					kst_tab_certif.descrizione = " "
//				end if
//				k_record_1 = &
//					"Sei sicuro di voler eliminare l'associazione con il Profilo " + "~n~r" + &
//					trim(kst_tab_certif.nome) + " " + trim(kst_tab_certif.descrizione) &
//				   + " ?"
//			else
//				tab_1.tabpage_2.dw_2.deleterow(k_riga)
//			end if
//		end if
//		k_key = trim(string(kst_tab_sr_prof_utenti.id))
end choose	



//=== Se righe in lista
if k_riga > 0 and LenA(trim(k_key)) > 0 then
	
//=== Richiesta di conferma della eliminazione del rek
	if messagebox("Elimina" + k_record, k_record_1, &
		question!, yesno!, 2) = 1 then
 
//=== Creo l'oggetto che ha la funzione x cancellare la tabella
		kuf1_certif = create kuf_certif
		
//=== Cancella la riga dal data windows di lista
		choose case tab_1.selectedtab 
			case 1 
				try
					kst_esito = kuf1_certif.tb_delete(kst_tab_certif) 
				catch (uo_exception kuo_exception)
					kst_esito = kuo_exception.get_st_esito()
				end try 
//			case 2
//				kst_esito = kuf1_certif.tb_delete_sr_prof_utenti(kst_tab_sr_prof_utenti) 
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
//					case 2
//						tab_1.tabpage_2.dw_2.deleterow(k_riga)
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
		destroy kuf1_certif

	else
		messagebox("Elimina" + k_record,  "Operazione Annullata !!")
		k_return = 2
	end if


end if


choose case tab_1.selectedtab 
	case 1 
		tab_1.tabpage_1.dw_1.setfocus()
		tab_1.tabpage_1.dw_1.setcolumn(1)
//	case 2
//		tab_1.tabpage_2.dw_2.setfocus()
//		tab_1.tabpage_2.dw_2.setcolumn(1)
end choose	


return k_return

end function

protected subroutine attiva_menu ();//

//
//--- Attiva/Dis. Voci di menu personalizzate
//
	if ki_menu.m_strumenti.m_fin_gest_libero1.enabled <> ki_stampa_attestato then
		ki_menu.m_strumenti.m_fin_gest_libero1.text = "Stampa Attestato"
		ki_menu.m_strumenti.m_fin_gest_libero1.microhelp = "Stampa Attestato di Trattamento"
		ki_menu.m_strumenti.m_fin_gest_libero1.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero1.enabled = ki_stampa_attestato
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText = "Stampa,"+ki_menu.m_strumenti.m_fin_gest_libero1.text
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
	end if


//--- Rigenera alcuni dati del Lotto 		
	if ki_menu.m_strumenti.m_fin_gest_libero9.enabled <>  cb_aggiorna.enabled then
		ki_menu.m_strumenti.m_fin_gest_libero9.text = "Sistema la data di Fine Trattamento "
		ki_menu.m_strumenti.m_fin_gest_libero9.microhelp = "Sistema la data di Fine Trattamento "
		ki_menu.m_strumenti.m_fin_gest_libero9.enabled =  cb_aggiorna.enabled
		ki_menu.m_strumenti.m_fin_gest_libero9.toolbaritemtext =  "Rigenera,"+ ki_menu.m_strumenti.m_fin_gest_libero9.text
		ki_menu.m_strumenti.m_fin_gest_libero9.toolbaritemvisible = true
		ki_menu.m_strumenti.m_fin_gest_libero9.toolbaritembarindex=2
	end if


	
	if ki_st_open_w.flag_primo_giro = 'S' then
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName = "Custom074!"
		ki_menu.m_strumenti.m_fin_gest_libero9.toolbaritemname =  "Regenerate5!"
	end if

	super::attiva_menu()

end subroutine

protected subroutine smista_funz (string k_par_in);//
//===

choose case LeftA(k_par_in, 2) 


	case KKG_FLAG_RICHIESTA.libero1		//Stampa attestato
		stampa_attestato()

//--- Rigenera alcuni dati del Riferimento
	case "l9"
		rigenera_alcuni_dati_lotto()		
		
	case else
		super::smista_funz(k_par_in)

end choose



end subroutine

private subroutine stampa_attestato ();//
//--- lancia la stampa dell'attestato
//
//
//=== 
string k_errore, k_titolo
long k_rc
window kwindow_1
st_tab_certif kst_tab_certif[]
st_open_w kst_open_w
st_esito kst_esito
kuf_certif kuf1_certif



kst_open_w = ki_st_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.stampa

//--- controlla se utente autorizzato alla funzione in atto
if sicurezza(kst_open_w) then

	if tab_1.tabpage_1.dw_1.getrow() = 0 then
				
	else
		kwindow_1 = kGuf_data_base.prendi_win_attiva()
		if not isnull(kwindow_1) then
			k_titolo = trim(kwindow_1.title)
		else
			k_titolo = "...senza titolo..."
		end if
		k_errore = LeftA(dati_modif(k_titolo), 1)
		
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
		
		if LeftA(k_errore, 1) = "0" then

			try		
					
//--- 		
//--- stampa attestato	
//				if not isvalid(kiuo1_d_certif_stampa) then
////--- apre oggetto stampa-attestato
//					kiuo1_d_certif_stampa = create uo_d_certif_stampa 
//				end if
//				tab_1.tabpage_9.dw_9.dataobject = kiuo1_d_certif_stampa.dataobject			
//				tab_1.tabpage_9.dw_9.settransobject(sqlca)
//				kst_tab_certif.id = 0
//				if tab_1.tabpage_9.dw_9.getrow() > 0 then
//					if tab_1.tabpage_9.dw_9.object.certif_id[tab_1.tabpage_9.dw_9.getrow()] <> tab_1.tabpage_1.dw_1.object.certif_id[tab_1.tabpage_1.dw_1.getrow()] then
//						kst_tab_certif.id = 1
//					end if
//				else
//					kst_tab_certif.id = 1
//				end if				
//			
//				if kst_tab_certif.id = 1 then
	
					kst_tab_certif[1].id = tab_1.tabpage_1.dw_1.object.certif_id[tab_1.tabpage_1.dw_1.getrow()]
					kst_tab_certif[1].num_certif = tab_1.tabpage_1.dw_1.object.certif_num_certif[tab_1.tabpage_1.dw_1.getrow()]
				
//					tab_1.tabpage_9.dw_9.setredraw(false)
//					tab_1.tabpage_9.dw_9.reset()	
	
					kuf1_certif = create kuf_certif

//--- retrieve e stampa attestato 
						
					kuf1_certif.kist_tab_certif = kst_tab_certif[1]
					kuf1_certif.ki_flag_stampa_di_test = true
					if not kuf1_certif.stampa(kst_tab_certif[]) then
						messagebox("Stampa Attestato", 	"Operazione di preparazione alla stampa Fallita." ) //&
					end if
					
	
//--- rilegge il certificato				
					smista_funz(kkg_flag_richiesta_refresh)
				

					tab_1.tabpage_9.dw_9.setredraw(true)

//				end if				

				
			catch (uo_exception kuo_exception)
				kuo_exception.messaggio_utente()
				
			finally
				destroy kuf1_certif

				
			end try	
		end if
	end if
end if


end subroutine

protected subroutine riempi_id ();//
long k_riga


	
	k_riga = tab_1.tabpage_1.dw_1.getrow()
	
	if k_riga > 0 then

		if tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "certif_dose_min") > 0 and tab_1.tabpage_1.dw_1.getitemstring(k_riga, "k_forza_dose_min") = "S" then
		else
			tab_1.tabpage_1.dw_1.setitem(k_riga, "certif_dose_min", 0.00)
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "certif_dose_max") > 0 and tab_1.tabpage_1.dw_1.getitemstring(k_riga, "k_forza_dose_max") = "S" then
		else
			tab_1.tabpage_1.dw_1.setitem(k_riga, "certif_dose_max", 0.00)
		end if
		
		if isnull(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "certif_st_dose_min")) &
		   or LenA(trim(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "certif_st_dose_min"))) = 0 &
			then				
			tab_1.tabpage_1.dw_1.setitem(k_riga, "certif_st_dose_min", 'N')
		end if
		if isnull(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "certif_st_dose_max")) &
		   or LenA(trim(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "certif_st_dose_max"))) = 0 &
			then				
			tab_1.tabpage_1.dw_1.setitem(k_riga, "certif_st_dose_max", 'N')
		end if
		if isnull(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "certif_st_data_ini")) &
		   or LenA(trim(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "certif_st_data_ini"))) = 0 &
			then				
			tab_1.tabpage_1.dw_1.setitem(k_riga, "certif_st_data_ini", 'N')
		end if
		if isnull(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "certif_st_data_fin")) &
		   or LenA(trim(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "certif_st_data_fin"))) = 0 &
			then				
			tab_1.tabpage_1.dw_1.setitem(k_riga, "certif_st_data_fin", 'N')
		end if
	
//=== Se sono in inser azzero il ID  
		if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) = newmodified! then
			if isnull(tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "certif_id")) &
				then				
				tab_1.tabpage_1.dw_1.setitem(k_riga, "certif_id", 0)
			end if
		end if
	end if


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
string k_key, k_testo
date k_dataoggi
st_tab_certif kst_tab_certif
	
	
	k_dataoggi = kguo_g.get_dataoggi( )

//=== Controllo il primo tab
	k_nr_righe = tab_1.tabpage_1.dw_1.rowcount()
	k_nr_errori = 0
	k_riga = 1

	if k_nr_righe > 0 then
		kst_tab_certif.dose_min = tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "certif_dose_min") 
		kst_tab_certif.dose_max = tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "certif_dose_max") 
		kst_tab_certif.st_dose_min = tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "certif_st_dose_min") 
		kst_tab_certif.st_dose_max = tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "certif_st_dose_max") 
		kst_tab_certif.st_data_ini = tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "certif_st_data_ini") 
		kst_tab_certif.st_data_fin = tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "certif_st_data_fin") 
		
		if isnull(kst_tab_certif.dose_min) then
			kst_tab_certif.dose_min = 0
		end if
		if isnull(kst_tab_certif.dose_max) then
			kst_tab_certif.dose_max = 0
		end if
	
		if kst_tab_certif.st_dose_min = "S" and kst_tab_certif.st_dose_max = "S" then
			if kst_tab_certif.dose_min > 0 and kst_tab_certif.dose_max > 0 & 
				and kst_tab_certif.dose_min > kst_tab_certif.dose_max then 
				k_return = tab_1.tabpage_1.text + ": " + trim(tab_1.tabpage_1.dw_1.object.certif_dose_min_t.text) &
								  + " maggiore di " + trim(tab_1.tabpage_1.dw_1.object.certif_dose_min_t.text) + ", valore non accettato." + "~n~r"
				k_errore = "1"
				k_nr_errori++
			end if
		end if
	
		if k_errore = "0" or k_errore = "4" then
			kst_tab_certif.data = tab_1.tabpage_1.dw_1.getitemdate ( k_riga, "certif_data") 
			if kst_tab_certif.data <> k_dataoggi and kst_tab_certif.data > kkg.data_no then
				k_testo = string(k_dataoggi, "dd.mm.yy" )
				k_return = tab_1.tabpage_1.text + ": Data Attestato differente da oggi '" + k_testo + "'. " + "~n~r"
				k_errore = "4"
				k_nr_errori++
			end if
		end if
	
		if k_errore = "0" or k_errore = "4" then
			if kst_tab_certif.st_dose_min = "S" then
				if kst_tab_certif.dose_min = 0 then 
					k_testo = string(tab_1.tabpage_1.dw_1.getitemnumber( 1, "k_dose_min"), "#0.00")
					k_return += tab_1.tabpage_1.text + ": Dose Minima richiesta in stampa, verrà esposto il dato calcolato (" + k_testo + "). " + "~n~r"
					k_errore = "4"
					k_nr_errori++
				end if
			end if
			if kst_tab_certif.st_dose_max = "S" then
				if kst_tab_certif.dose_max = 0 then 
					k_testo = string(tab_1.tabpage_1.dw_1.getitemnumber( 1, "k_dose_max"), "#0.00")
					k_return += tab_1.tabpage_1.text + ": Dose Massima richiesta in stampa, verrà esposto il dato calcolato (" + k_testo + "). " + "~n~r"
					k_errore = "4"
					k_nr_errori++
				end if
			end if
		end if
		
//	if isnull(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "id_programma")) = true then
//		k_testo = trim(tab_1.tabpage_1.dw_1.object.id_programma_t.text)
//		k_return = k_return + tab_1.tabpage_1.text + ": Manca valore nel campo '" + k_testo + "'. " + "~n~r" 
//		k_errore = "3"
//		k_nr_errori++
//	end if

		if k_errore = "0" then
			
			kst_tab_certif.x_datins = kGuf_data_base.prendi_x_datins()
			kst_tab_certif.x_utente = kGuf_data_base.prendi_x_utente()
		
			tab_1.tabpage_1.dw_1.setitem(k_riga, "certif_x_datins", kst_tab_certif.x_datins)
			tab_1.tabpage_1.dw_1.setitem(k_riga, "certif_x_utente", kst_tab_certif.x_utente)
			
		end if
		
	end if
	
return k_errore + k_return


end function

protected function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_scelta, k_return = "0"
string k_stato = "0"
string  k_key
string k_fine_ciclo=""
int k_ctr=0, k_errore = 0
int k_err_ins, k_rc
pointer kpointer_orig
st_esito kst_esito, kst_esito_certif
st_tab_certif kst_tab_certif
kuf_utility kuf1_utility
kuf_certif kuf1_certif

//=== 
//tab_1.tabpage_4.dw_41.settransobject(sqlca)

kpointer_orig = setpointer(hourglass!)

ki_fai_nuovo_dopo_update = false

if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
	k_scelta = trim(ki_st_open_w.flag_modalita)
	
	k_key = trim(ki_st_open_w.key1)  // numero certificato

	if LenA(k_key) = 0 or not isnumber(k_key) then
		
//		cb_inserisci.postevent(clicked!)
		tab_1.tabpage_1.dw_1.setfocus()

	else

		try
			kuf1_certif = create kuf_certif
			kst_tab_certif.num_certif = long(k_key)
			kst_esito = kuf1_certif.leggi(1, kst_tab_certif)
		
			if kst_esito.esito = kkg_esito.not_fnd then
//--- se attestato non trovato allora lo genero		
				kst_esito = kuf1_certif.crea_certif(kst_tab_certif)
			else
				if kst_esito.esito = kkg_esito.ok then
//--- get dati attestato calcolati dal programma
					 kuf1_certif.crea_certif_0(kst_tab_certif)
				end if
			end if
		
		catch (uo_exception kuo_exception)
			kuo_exception.messaggio_utente()
			
		finally
			destroy kuf1_certif
			
		end try
		
		if kst_esito.esito <> "0" then
			k_rc = 0
		else
			k_rc = tab_1.tabpage_1.dw_1.retrieve(0, kst_tab_certif.num_certif) 
		end if
		
		choose case k_rc

			case is < 0				
				k_errore = 1
				messagebox("Operazione fallita", &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(Numero Attestato cercato:" + trim(k_key) + ")~n~r" )
				k_return = "E"
//				cb_ritorna.postevent(clicked!)
				

			case 0
	
				tab_1.tabpage_1.dw_1.reset()
				attiva_tasti()

				if k_scelta <> kkg_flag_modalita.inserimento then
					k_errore = 1
					messagebox("Ricerca fallita", &
						"Attestato non trovato in Archivio ~n~r" + &
						"(Codice cercato:" + trim(k_key) + ")~n~r" )
					k_return = "E"
					//cb_ritorna.postevent(clicked!)
					
				else
					k_err_ins = inserisci()
					tab_1.tabpage_1.dw_1.setfocus()
				end if
				
			case is > 0		
				if k_scelta =  kkg_flag_modalita.inserimento then
					cb_inserisci.postevent(clicked!)
				end if
				
				tab_1.tabpage_1.dw_1.setrow(1)
				tab_1.tabpage_1.dw_1.setfocus()
				tab_1.tabpage_1.dw_1.setcolumn("certif_num_certif")
				
				tab_1.tabpage_1.dw_1.setitem( 1, "k_dose_min", kst_tab_certif.dose_min )
				if tab_1.tabpage_1.dw_1.getitemnumber( 1, "certif_dose_min") > 0 and kst_tab_certif.dose_min <> tab_1.tabpage_1.dw_1.getitemnumber( 1, "certif_dose_min") then
					tab_1.tabpage_1.dw_1.setitem( 1, "k_forza_dose_min", "S")
				end if
				tab_1.tabpage_1.dw_1.setitem( 1, "k_dose_max", kst_tab_certif.dose_max )
				if tab_1.tabpage_1.dw_1.getitemnumber( 1, "certif_dose_max") > 0 and kst_tab_certif.dose_max <> tab_1.tabpage_1.dw_1.getitemnumber( 1, "certif_dose_max") then
					tab_1.tabpage_1.dw_1.setitem( 1, "k_forza_dose_max", "S")
				end if
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

	tab_1.tabpage_1.dw_1.resetupdate ()

//--- modifica dell'attestato consentita?
	if trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.visualizzazione &
	   and trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.cancellazione then
		kst_tab_certif.num_certif = tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "certif_num_certif")
		kuf1_certif = create kuf_certif
		kst_esito_certif=kuf1_certif.consenti_modifica(kst_tab_certif)
		if kst_esito_certif.esito <> "0" then
			ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
			messagebox("Operazione non consentita", &
			      "L'Attestato non può essere modificato perchè~n~r" + &
					"non ha completato il Trattamento oppure è già stato 'Stampato'. " )
			
		end if
		destroy kuf1_certif
	end if
	
//--- Inabilita campi alla modifica se Visualizzazione
	kuf1_utility = create kuf_utility 
	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.visualizzazione &
	   or trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.cancellazione then
		
		kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_1.dw_1)

	else		
		
//--- S-protezione campi per riabilitare la modifica 
      kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)

	end if
	destroy kuf1_utility
	
//--- se cancellazione
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.cancellazione then

		cb_cancella.postevent (clicked!)
		k_return = "E"
//		cb_ritorna.postevent(clicked!)
		
	end if
end if



return k_return 



end function

protected function string dati_modif (string k_titolo);//
//=== Controllo se ci sono state modifiche di dati sui DW
string k_return="0 "
int k_msg=0


//=== Toglie le righe eventualmente da non registrare
	pulizia_righe()
	
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica &
	   or ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then 
		
      if dati_modif_1() then
	
			if isnull(k_titolo) or LenA(trim(k_titolo)) = 0 then
				k_titolo = "Aggiorna Archivio"
			end if
	
			k_msg = messagebox(k_titolo, "Dati Modificati, vuoi Salvare gli Aggiornamenti ?", &
								question!, yesnocancel!, 1) 
		
			if k_msg = 1 then
				k_return = "1Dati Modificati"	
			else
				k_return = string(k_msg)			
			end if
			
		end if
		
	end if
return k_return
end function

protected subroutine open_start_window ();//
	ki_toolbar_window_presente=true

end subroutine

private subroutine rigenera_alcuni_dati_lotto ();//
int k_ok=0
st_tab_meca kst_tab_meca
kuf_armo kuf1_armo

	
	kst_tab_meca.id = tab_1.tabpage_1.dw_1.object.id_meca[1]

	try

		kuf1_armo = create kuf_armo

//--- Modifica 
		k_ok = messagebox("Operazione di: "+trim(ki_menu.m_strumenti.m_fin_gest_libero9.text), "L'operazione non è distruttiva ma aggiorna dati Lotto, proseguire?", &
							question!, yesno!, 2) 
		if k_ok = 1 then
//--- aggiorna lo stato del Riferimento
			kuf1_armo.set_data_fine_lav(kst_tab_meca)
			inizializza_lista()
		end if
			
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
	finally
		destroy kuf1_armo
		
	end try




end subroutine

protected subroutine attiva_tasti_0 ();//
	super::attiva_tasti_0()

	if tab_1.selectedtab = 1 &
		and tab_1.tabpage_1.dw_1.rowcount() > 0 then
		ki_stampa_attestato = true
	else
		ki_stampa_attestato = false
	end if

		

end subroutine

on w_certif.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

on w_certif.create
call super::create
end on

event close;call super::close;//
if isvalid(kiuo1_d_certif_stampa) then	destroy kiuo1_d_certif_stampa 
//if isvalid(kdsi_elenco) then destroy kdsi_elenco   

end event

type st_ritorna from w_g_tab_3`st_ritorna within w_certif
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_certif
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_certif
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_certif
end type

type st_stampa from w_g_tab_3`st_stampa within w_certif
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_certif
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_certif
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_certif
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_certif
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_certif
boolean enabled = false
end type

type tab_1 from w_g_tab_3`tab_1 within w_certif
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
string text = "Attestato"
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
string dataobject = "d_certif"
boolean hsplitscroll = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_d_std_1_attiva_cerca = false
end type

event dw_1::clicked;call super::clicked;////
////=== Premuto pulsante nella DW
////
//int k_rc
//st_open_w kst_open_w
//st_tab_meca kst_tab_meca
//st_tab_contratti kst_tab_contratti
//st_tab_clienti kst_tab_clienti
//st_esito kst_esito
//kuf_menu_window kuf1_menu_window
//kuf_utility kuf1_utility
//kuf_armo kuf1_armo
//kuf_contratti kuf1_contratti
//kuf_clienti kuf1_clienti
//datawindow kdw_1
//uo_exception kuo_exception
//
//
//
//if LeftA(dwo.name, 2) = "b_" then
//
////--- popolo il datasore (dw non visuale) per appoggio elenco
//	if not isvalid(kdsi_elenco_output) then kdsi_elenco_output = create datastore
//
//	kdw_1 = this
//
//	choose case dwo.name
//		case "b_meca"
//			if this.object.num_int[this.getrow()] > 0 then
////				kdsi_elenco_output.dataobject = "d_meca_1" 
////				k_rc = kdsi_elenco_output.settransobject ( sqlca )
////				kst_tab_meca.id = this.object.id_meca[this.getrow()]
////				if kst_tab_meca.id > 0 then
////					k_rc = kdsi_elenco_output.retrieve( kst_tab_meca.id )
////				end if
////				kst_open_w.key1 = "Riferimento "  + string(this.object.num_int[this.getrow()]) 
//				kuf1_armo = create kuf_armo
//				kst_tab_meca.id = this.getitemnumber(this.getrow(), "id_meca")
//				kst_esito = kuf1_armo.anteprima_testa ( kdw_1, kst_tab_meca )
//				destroy kuf1_armo
//				if kst_esito.esito <> kkg_esito.ok then
//					kuo_exception = create uo_exception
//					kuo_exception.set_esito( kst_esito)
//					kuo_exception.messaggio_utente()
//				end if
//			end if
//		case "b_contratti"
//			if this.object.contratto[this.getrow()] > 0 then
////				kdsi_elenco_output.dataobject = "d_contratti" 
////				k_rc = kdsi_elenco_output.settransobject ( sqlca )
////				kuf1_utility = create kuf_utility
////				kuf1_utility.u_ds_toglie_ddw(1, kdsi_elenco_output)
////				destroy kuf1_utility
////				k_rc = kdsi_elenco_output.retrieve(this.object.contratto[this.getrow()])
////				kst_open_w.key1 = "Contratto " + string(this.object.contratto[this.getrow()]) 
//				kuf1_contratti = create kuf_contratti
//				kst_tab_contratti.codice = this.getitemnumber(kdw_1.getrow(), "contratto")
//				kst_esito = kuf1_contratti.anteprima ( kdw_1, kst_tab_contratti )
//				destroy kuf1_contratti
//				if kst_esito.esito <> kkg_esito.ok then
//					kuo_exception = create uo_exception
//					kuo_exception.set_esito( kst_esito)
//					kuo_exception.messaggio_utente()
//				end if
//			end if
//		case "b_sc_cf"
//			if LenA(trim(this.object.contratti_sc_cf[this.getrow()])) > 0 then
////				kdsi_elenco_output.dataobject = "d_sc_cf" 
////				k_rc = kdsi_elenco_output.settransobject ( sqlca )
////				kuf1_utility = create kuf_utility
////				kuf1_utility.u_ds_toglie_ddw(1, kdsi_elenco_output)
////				destroy kuf1_utility
////				k_rc = kdsi_elenco_output.retrieve(this.object.contratti_sc_cf[this.getrow()])
////				kst_open_w.key1 = "Capitolato SC-CF " + string(this.object.contratti_sc_cf[this.getrow()]) 
//				kuf1_contratti = create kuf_contratti
//				kst_tab_contratti.sc_cf = this.getitemstring(kdw_1.getrow(), "contratti_sc_cf")
//				kst_esito = kuf1_contratti.anteprima_sc_cf ( kdw_1, kst_tab_contratti )
//				destroy kuf1_contratti
//				if kst_esito.esito <> kkg_esito.ok then
//					kuo_exception = create uo_exception
//					kuo_exception.set_esito( kst_esito)
//					kuo_exception.messaggio_utente()
//				end if
//
//			end if
//		case "b_clie_1"
//			if this.object.clie_1[this.getrow()] > 0 then
////				kdsi_elenco_output.dataobject = "d_clienti_1" 
////				k_rc = kdsi_elenco_output.settransobject ( sqlca )
////				k_rc = kdsi_elenco_output.retrieve(this.object.clie_1[this.getrow()])
////				kst_open_w.key1 = "Mandante " + string(this.object.clienti_rag_soc_10[this.getrow()]) 
//				kuf1_clienti = create kuf_clienti
//				kst_tab_clienti.codice = this.getitemnumber(kdw_1.getrow(), "clie_1")
//				kst_esito = kuf1_clienti.anteprima ( kdw_1, kst_tab_clienti )
//				destroy kuf1_clienti
//				if kst_esito.esito <> kkg_esito.ok then
//					kuo_exception = create uo_exception
//					kuo_exception.set_esito( kst_esito)
//					kuo_exception.messaggio_utente()
//				end if
//			end if
//		case "b_clie_2"
//			if this.object.clie_2[this.getrow()] > 0 then
////				kdsi_elenco_output.dataobject = "d_clienti_1" 
////				k_rc = kdsi_elenco_output.settransobject ( sqlca )
////				k_rc = kdsi_elenco_output.retrieve(this.object.clie_2[this.getrow()])
////				kst_open_w.key1 = "Ricevente " + string(this.object.clienti_rag_soc_10_1[this.getrow()]) 
//				kuf1_clienti = create kuf_clienti
//				kst_tab_clienti.codice = this.getitemnumber(kdw_1.getrow(), "clie_2")
//				kst_esito = kuf1_clienti.anteprima ( kdw_1, kst_tab_clienti )
//				destroy kuf1_clienti
//				if kst_esito.esito <> kkg_esito.ok then
//					kuo_exception = create uo_exception
//					kuo_exception.set_esito( kst_esito)
//					kuo_exception.messaggio_utente()
//				end if
//				
//			end if
//		case "b_clie_3"
//			if this.object.clie_3[this.getrow()] > 0 then
////				kdsi_elenco_output.dataobject = "d_clienti_1" 
////				k_rc = kdsi_elenco_output.settransobject ( sqlca )
////				k_rc = kdsi_elenco_output.retrieve(this.object.clie_3[this.getrow()])
////				kst_open_w.key1 = "Cliente " + string(this.object.clienti_rag_soc_10_2[this.getrow()]) 
//				kuf1_clienti = create kuf_clienti
//				kst_tab_clienti.codice = this.getitemnumber(kdw_1.getrow(), "clie_3")
//				kst_esito = kuf1_clienti.anteprima ( kdw_1, kst_tab_clienti )
//				destroy kuf1_clienti
//				if kst_esito.esito <> kkg_esito.ok then
//					kuo_exception = create uo_exception
//					kuo_exception.set_esito( kst_esito)
//					kuo_exception.messaggio_utente()
//				end if
//			end if
//	end choose
//
//
////	if kdsi_elenco_output.rowcount() > 0 then
////
////		
//////--- chiamare la window di elenco
//////
//////=== Parametri : 
//////=== struttura st_open_w
////		kst_open_w.id_programma = "elenco"
////		kst_open_w.flag_primo_giro = "S"
////		kst_open_w.flag_modalita = "el"
////		kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
////		kst_open_w.flag_leggi_dw = " "
////		kst_open_w.flag_cerca_in_lista = " "
////		kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
////		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
////		kst_open_w.key4 = kiw_this_window.title    //--- Titolo della Window di chiamata per riconoscerla
////		kst_open_w.key12_any = kdsi_elenco_output
////		kst_open_w.flag_where = " "
////		kuf1_menu_window = create kuf_menu_window 
////		kuf1_menu_window.open_w_tabelle(kst_open_w)
////		destroy kuf1_menu_window
////
////	else
////		
////		messagebox("Elenco Dati", &
////					"Nessun valore disponibile. ")
////		
////		
////	end if
//end if
//
////
end event

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

