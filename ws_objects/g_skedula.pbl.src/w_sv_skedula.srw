$PBExportHeader$w_sv_skedula.srw
forward
global type w_sv_skedula from w_g_tab0
end type
end forward

global type w_sv_skedula from w_g_tab0
integer width = 2935
integer height = 1104
string title = "Eventi da Schedulare"
boolean ki_toolbar_window_presente = true
end type
global w_sv_skedula w_sv_skedula

forward prototypes
protected function string inizializza ()
protected subroutine attiva_menu ()
protected subroutine smista_funz (string k_par_in)
protected function string cancella ()
private subroutine genera_sked ()
protected function string check_dati ()
protected subroutine open_start_window ()
end prototypes

protected function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Parametro IN : k_id_vettore
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
string k_key
long k_codice
string k_attiva
int k_importa = 0
pointer oldpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


//=== Legge le righe del dw salvate l'ultima volta (importfile)
	if ki_st_open_w.flag_primo_giro = "S" then 

		k_key = trim(ki_st_open_w.key1)+trim(ki_st_open_w.key2)+trim(ki_st_open_w.key3)&
      		  +trim(ki_st_open_w.key4)+trim(ki_st_open_w.key5)+trim(ki_st_open_w.key6)&
		  		  +trim(ki_st_open_w.key7)+trim(ki_st_open_w.key8)+trim(ki_st_open_w.key9)
		
		k_importa = kGuf_data_base.dw_importfile(trim(k_key), dw_lista_0)

	end if
		
	
	if k_importa <= 0 then // Nessuna importazione eseguita

		if dw_lista_0.retrieve() < 1 then
			k_return = "1Nessun dato trovato "

			SetPointer(oldpointer)
			messagebox("Elenco Vuoto", &
					"Nesun Codice Trovato per la richiesta fatta")

		end if		
	end if


return k_return



end function

protected subroutine attiva_menu ();//
boolean k_rc
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza


//
//--- Attiva/Dis. Voci di menu personalizzate
//
	ki_menu.m_strumenti.m_fin_gest_libero1.text = "Rigenera Eventi"
	ki_menu.m_strumenti.m_fin_gest_libero1.microhelp = &
   "Rigenera, nella tabella Schedulazioni, l'elenco degli Eventi da Eseguire"
	ki_menu.m_strumenti.m_fin_gest_libero1.visible = true
	ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2

	kst_open_w = ki_st_open_w
	kst_open_w.flag_modalita = kkg_flag_modalita.modifica
	kst_open_w.id_programma = kkg_id_programma.sv_sked_oper_g
//--- controlla se utente autorizzato alla funzione in atto
	kuf1_sicurezza = create kuf_sicurezza
	k_rc = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	destroy kuf1_sicurezza
	if k_rc then
		ki_menu.m_strumenti.m_fin_gest_libero1.enabled = true
	else
		ki_menu.m_strumenti.m_fin_gest_libero1.enabled = false
	end if	
	ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
	ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText = "Rigenera,"+ki_menu.m_strumenti.m_fin_gest_libero1.text
	ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName = "Regenerate!"


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
	case "l1"		//
		genera_sked()		
		

	case else // standard
		super::smista_funz(k_par_in)
		
end choose



end subroutine

protected function string cancella ();//
string k_return="0 "
string k_descr
string k_codice
string k_errore = "0 "
long k_riga
st_sv_skedula kst_sv_skedula
st_esito kst_esito
kuf_sv_skedula  kuf1_sv_skedula


//=== Controllo se sul dettaglio c'e' qualche cosa
k_riga = dw_dett_0.rowcount()	
if k_riga > 0 then
	kst_sv_skedula.id = dw_dett_0.getitemnumber(1, "sv_skedula_id")
	kst_sv_skedula.id_menu_window = trim(dw_dett_0.getitemstring(1, "sv_skedula_id_menu_window"))
	k_descr = trim(dw_dett_0.getitemstring(1, "menu_window_titolo"))
end if
//=== Se sul dw non c'e' nessuna riga o nessun codice allora pesco dalla lista
if k_riga <= 0 or isnull(k_codice) then
	k_riga = dw_lista_0.getrow()	
	if k_riga > 0 then
		kst_sv_skedula.id = dw_lista_0.getitemnumber(k_riga, "sv_skedula_id")
		kst_sv_skedula.id_menu_window = trim(dw_lista_0.getitemstring(1, "sv_skedula_id_menu_window"))
		k_descr = trim(dw_lista_0.getitemstring(k_riga, "menu_window_titolo"))
	end if
end if

if isnull(kst_sv_skedula.id) then
	kst_sv_skedula.id = 0
end if
if isnull(k_descr) then
	k_descr = " " 
end if
if isnull(kst_sv_skedula.id_menu_window) then
	kst_sv_skedula.id_menu_window = " "
end if
if LenA(trim(k_descr)) = 0 and LenA(trim(kst_sv_skedula.id_menu_window)) = 0 then
	k_descr = "Evento senza Funzione" 
end if

if k_riga > 0 and kst_sv_skedula.id > 0 then	
	
//=== Richiesta di conferma della eliminazione del rek

	if messagebox("Elimina Evento di Schedulazione", "Sei sicuro di voler Cancellare : ~n~r" &
	             + string(kst_sv_skedula.id) &
					 + " funzione " + trim(kst_sv_skedula.id_menu_window) + " " + trim(k_descr), &
				question!, yesno!, 2) = 1 then
 
//=== Creo l'oggetto che ha la funzione x cancellare la tabella
		kuf1_sv_skedula = create kuf_sv_skedula
		
//=== Cancella la riga dal data windows di lista
		kuf1_sv_skedula.kist_sv_skedula = kst_sv_skedula
		kuf1_sv_skedula.tb_delete() 
		if kuf1_sv_skedula.kist_esito.esito = "0" then

			kst_esito = kguo_sqlca_db_magazzino.db_commit()
			if kst_esito.esito <> kkg_esito.ok then
				messagebox("Problemi durante la Cancellazione !!", "Controllare i dati. " + " ~n~r" + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) )

			else

//--- cancello riga a video
				kst_sv_skedula.id = 0
				k_riga = dw_dett_0.rowcount()	
				if k_riga > 0 then
					kst_sv_skedula.id = dw_dett_0.getitemnumber(1, "sv_skedula_id")
					dw_dett_0.deleterow(k_riga)
				end if
				if k_riga <= 0 or isnull(kst_sv_skedula.id) then
					k_riga = dw_lista_0.getrow()	
					if k_riga > 0 then
						dw_lista_0.deleterow(k_riga)
					end if
				end if

			end if

			dw_dett_0.setfocus()

		else
			k_errore = string(kuf1_sv_skedula.kist_esito.sqlcode ) + " " + trim(kuf1_sv_skedula.kist_esito.sqlerrtext) 
			kguo_sqlca_db_magazzino.db_rollback( )
			if kst_esito.esito <> kkg_esito.ok then
				k_errore += "~n~rfallito anche il 'recupero' dell'errore: ~n~r" + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) 
			end if
			k_errore += "~n~rPrego, controllare i dati !! "
			messagebox("Problemi durante Cancellazione", "Operazione fallita !! ~n~r" + trim(k_errore) ) 	

			attiva_tasti()
	

		end if

//=== Distruggo l'oggetto che ha avuto la funzione x cancellare la tabella
		destroy kuf1_sv_skedula

	else
		messagebox("Elimina Evento da schedulare", "Operazione Annullata !!")
	end if

	dw_dett_0.setcolumn(1)

end if

return(k_return)
//

end function

private subroutine genera_sked ();//
int k_rc
kuf_sv_skedula kuf1_sv_skedula
st_esito kst_esito
pointer kpointer  // Declares a pointer variable


	k_rc = MessageBox("Generazione Eventi in schedulazione",&
				"Questa operazione e' distruttiva!" + "~r~n" &
				+ "Tutte gli Eventi in Schedulazione varranno Cancellati e Rigenerati. " + "~r~n" &
				+ "Proseguire con l'operazione ? "  &
				,Information!,yesno!,2)		

	if k_rc = 1 then 

//=== Puntatore Cursore da attesa.....
		kpointer = SetPointer(HourGlass!)
		
		kuf1_sv_skedula = create kuf_sv_skedula
		kst_esito = kuf1_sv_skedula.genera_eventi()
		destroy kuf1_sv_skedula
	
		SetPointer(kpointer)
	
		if kst_esito.esito = kkg_esito.ok then
			MessageBox("Generazione Eventi in schedulazione",&
					kst_esito.sqlerrtext + "~r~n" &
					,Information!,OK!,1)		
		else
			MessageBox("Generazione Eventi in schedulazione",&
					kst_esito.sqlerrtext + "~r~n" &
					+ "codice errore: " + string(kst_esito.sqlcode) &
					,Exclamation!,OK!,1)		
		end if
	end if	
	







end subroutine

protected function string check_dati ();//
//=== Controllo dati inseriti
string k_return = ""
string k_errore = "0"
int k_rc=0
long k_riga, k_find_riga
string k_key
string k_descr, k_sc_cf=""
datawindowchild kdwc_1
st_sv_skedula kst_sv_skedula


	
	k_riga = dw_dett_0.getrow()
	
			
	kst_sv_skedula.flag_cmd_dos=dw_dett_0.getitemstring(k_riga, "sv_skedula_flag_cmd_dos")
	
	//--- se richiesto cmd dos....
	if kst_sv_skedula.flag_cmd_dos = "1" then
	
		kst_sv_skedula.cmd_dos_run=dw_dett_0.getitemstring(k_riga, "sv_skedula_cmd_dos_run")
		if isnull(kst_sv_skedula.cmd_dos_run) or LenA(trim(kst_sv_skedula.cmd_dos_run)) = 0 then
			k_return = k_return + "Manca " &
						 + trim(dw_dett_0.object.sv_skedula_cmd_dos_run_t.text) + " " + "~n~r"
			k_errore = "3"
		else
			dw_dett_0.setitem ( k_riga, "sv_skedula_id_menu_window", " ") 
		end if
		
	else
		
		dw_dett_0.setitem(k_riga, "sv_skedula_flag_cmd_dos", "0")
		
	//--- se richiesto applicazione m2000
		k_key = dw_dett_0.getitemstring ( k_riga, "sv_skedula_id_menu_window") 
		if isnull(k_key) or LenA(trim(k_key)) = 0 then
			k_return = k_return + "Manca " &
						 + trim(dw_dett_0.object.sv_skedula_id_menu_window_t.text) + " " + "~n~r"
			k_errore = "3"
			
		else
	
			dw_dett_0.setitem ( k_riga, "sv_skedula_cmd_dos_run", " ") 
	
	//--- Attivo dw e imposto il codice su dw per aggiornamento
			k_rc = dw_dett_0.getchild("sv_skedula_id_menu_window", kdwc_1)
			k_rc = kdwc_1.settransobject(sqlca)
			kst_sv_skedula.id_menu_window=dw_dett_0.getitemstring(k_riga, "sv_skedula_id_menu_window")
			if not isnull(kst_sv_skedula.id_menu_window) then
				
				if kdwc_1.rowcount() < 2 then
					kdwc_1.retrieve()
					kdwc_1.insertrow(1)
				end if
		
				k_find_riga=kdwc_1.find("sv_skedula_id_menu_window=~""+trim(kst_sv_skedula.id_menu_window)+"~"",&
														  0, kdwc_1.rowcount())
				if k_find_riga > 0 then
					dw_dett_0.setitem(k_riga, "menu_window_titolo", &
											kdwc_1.getitemnumber(k_find_riga, "titolo"))
				else
					dw_dett_0.setitem(k_riga, "menu_window_titolo", 0)
				end if
			else
				dw_dett_0.setitem(k_riga, "menu_window_titolo", 0)
			end if
		end if
	end if
	
//--- errori diversi
   if trim(k_errore) = "0" then
		
			
//		if isnull(dw_dett_0.getitemtime(k_riga, "sv_skedula_orario")) then
		if isnull(dw_dett_0.getitemstring(k_riga, "sv_skedula_orario")) then
//--- setta mezzanotte
			dw_dett_0.setitem(k_riga, "sv_skedula_orario", "00:00")
		end if
		if isnull(dw_dett_0.getitemstring(k_riga, "sv_skedula_flag_run_giorni")) then
//--- setta "gira tutti i giorni"
			dw_dett_0.setitem(k_riga, "sv_skedula_flag_run_giorni", "0")
		end if
		if isnull(dw_dett_0.getitemnumber(k_riga, "sv_skedula_rilancia_dopo_mm")) then
//--- setta "non rilanciare"
			dw_dett_0.setitem(k_riga, "sv_skedula_rilancia_dopo_mm", 0)
		end if
		if isnull(dw_dett_0.getitemstring(k_riga, "sv_skedula_stato")) then
//--- setta "da eseguire"
			dw_dett_0.setitem(k_riga, "sv_skedula_stato", "1")
		end if

	end if

	

//--- se nessun errore grave
	if trim(k_errore) > "3" or trim(k_errore) = "0"then

		k_riga = dw_dett_0.getrow()


//--- imposto i dati di default
		k_rc=dw_dett_0.setitem(k_riga, "x_datins", kGuf_data_base.prendi_x_datins())
		k_rc=dw_dett_0.setitem(k_riga, "x_utente", kGuf_data_base.prendi_x_utente())

	end if
	

return trim(k_errore) + trim(k_return)


end function

protected subroutine open_start_window ();//
	ki_toolbar_window_presente=true

end subroutine

on w_sv_skedula.create
call super::create
end on

on w_sv_skedula.destroy
call super::destroy
end on

type st_ritorna from w_g_tab0`st_ritorna within w_sv_skedula
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_sv_skedula
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_sv_skedula
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_sv_skedula
end type

type st_stampa from w_g_tab0`st_stampa within w_sv_skedula
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_sv_skedula
end type

type cb_modifica from w_g_tab0`cb_modifica within w_sv_skedula
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_sv_skedula
end type

type cb_cancella from w_g_tab0`cb_cancella within w_sv_skedula
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_sv_skedula
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_sv_skedula
boolean enabled = true
string dataobject = "d_sv_skedula"
end type

type st_orizzontal from w_g_tab0`st_orizzontal within w_sv_skedula
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_sv_skedula
integer x = 41
integer y = 56
string dataobject = "d_sv_skedula_l"
boolean ki_d_std_1_attiva_sort = false
end type

type dw_guida from w_g_tab0`dw_guida within w_sv_skedula
end type

