$PBExportHeader$w_sv_skedulati.srw
forward
global type w_sv_skedulati from w_g_tab0
end type
end forward

global type w_sv_skedulati from w_g_tab0
integer height = 1488
string title = "Eventi da Schedulare"
boolean ki_toolbar_window_presente = true
end type
global w_sv_skedulati w_sv_skedulati

forward prototypes
protected subroutine attiva_menu ()
protected subroutine smista_funz (string k_par_in)
protected function string cancella ()
private subroutine genera_sked ()
protected function string check_dati ()
protected function string inizializza ()
protected subroutine open_start_window ()
protected subroutine riempi_id ()
protected subroutine attiva_tasti_0 ()
end prototypes

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
	ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2

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
string k_errore = "0 ", k_errore1 = "0 "
long k_riga
st_sv_eventi_sked kst_sv_eventi_sked
st_esito kst_esito
kuf_sv_skedula  kuf1_sv_skedula


//=== Controllo se sul dettaglio c'e' qualche cosa
k_riga = dw_dett_0.rowcount()	
if k_riga > 0 then
	kst_sv_eventi_sked.id = dw_dett_0.getitemnumber(k_riga, "sv_eventi_sked_id")
	kst_sv_eventi_sked.id_menu_window = trim(dw_dett_0.getitemstring(k_riga, "sv_eventi_sked_id_menu_window"))
	k_descr = trim(dw_dett_0.getitemstring(k_riga, "menu_window_titolo"))
	kst_sv_eventi_sked.run_giorno = (dw_dett_0.getitemdate(k_riga, "sv_eventi_sked_run_giorno"))
	kst_sv_eventi_sked.run_ora = trim(dw_dett_0.getitemstring(k_riga, "sv_eventi_sked_run_ora"))
	
end if
//=== Se sul dw non c'e' nessuna riga o nessun codice allora pesco dalla lista
if k_riga <= 0 or isnull(k_codice) then
	k_riga = dw_lista_0.getrow()	
	if k_riga > 0 then
		kst_sv_eventi_sked.id = dw_lista_0.getitemnumber(k_riga, "sv_eventi_sked_id")
		kst_sv_eventi_sked.id_menu_window = trim(dw_lista_0.getitemstring(1, "sv_eventi_sked_id_menu_window"))
		k_descr = trim(dw_lista_0.getitemstring(k_riga, "menu_window_titolo"))
		kst_sv_eventi_sked.run_giorno = (dw_lista_0.getitemdate(k_riga, "sv_eventi_sked_run_giorno"))
		kst_sv_eventi_sked.run_ora = trim(dw_lista_0.getitemstring(k_riga, "sv_eventi_sked_run_ora"))
	end if
end if

if isnull(kst_sv_eventi_sked.id) then
	kst_sv_eventi_sked.id = 0
end if
if isnull(k_descr) then
	k_descr = " " 
end if
if isnull(kst_sv_eventi_sked.id_menu_window) then
	kst_sv_eventi_sked.id_menu_window = " "
end if
if LenA(trim(k_descr)) = 0 and LenA(trim(kst_sv_eventi_sked.id_menu_window)) = 0 then
	k_descr = "Evento senza Funzione" 
end if

if k_riga > 0 and kst_sv_eventi_sked.id > 0 then	
	
//=== Richiesta di conferma della eliminazione del rek

	if messagebox("Elimina Evento Schedulato", "Sei sicuro di voler Cancellare : ~n~r" &
	             + "Id: " + string(kst_sv_eventi_sked.id) &
					 + ", del giorno: " + string(kst_sv_eventi_sked.run_giorno) + " ore " + trim(kst_sv_eventi_sked.run_ora) +  "~n~r"&
					 + ", Funzione: " + trim(kst_sv_eventi_sked.id_menu_window) + " - " + trim(k_descr), &
				question!, yesno!, 2) = 1 then
 
//=== Creo l'oggetto che ha la funzione x cancellare la tabella
		kuf1_sv_skedula = create kuf_sv_skedula
		
//=== Cancella la riga dal data windows di lista
		kuf1_sv_skedula.kist_sv_eventi_sked[1] = kst_sv_eventi_sked
		kuf1_sv_skedula.tb_delete_sv_eventi_sked() 
		if kuf1_sv_skedula.kist_esito.esito = "0" then

			kst_esito = kguo_sqlca_db_magazzino.db_commit()
			if kst_esito.esito <> kkg_esito.ok then
				messagebox("Problemi durante la Cancellazione !!", "Controllare i dati. " + " ~n~r" + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) )
			else

//--- cancello riga a video
				kst_sv_eventi_sked.id = 0
				k_riga = dw_dett_0.rowcount()	
				if k_riga > 0 then
					kst_sv_eventi_sked.id = dw_dett_0.getitemnumber(1, "sv_eventi_sked_id")
					dw_dett_0.deleterow(k_riga)
				end if
				if k_riga <= 0 or isnull(kst_sv_eventi_sked.id) then
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
		messagebox("Elimina Evento Schedulato", "Operazione Annullata !!")
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

//--- aggiorna elenco	
		leggi_liste()

//--- 		
		attiva_tasti()

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
st_sv_eventi_sked kst_sv_eventi_sked



	k_riga = dw_dett_0.getrow()
		

	if not isnull(dw_dett_0.getitemstring(k_riga, "sv_eventi_sked_run_ora")) &
	   and not istime(dw_dett_0.getitemstring(k_riga, "sv_eventi_sked_run_ora")) &
		then
		k_return = k_return + "Indicare valore 'ora' valido in " &
		          + trim(dw_dett_0.object.sv_eventi_sked_run_ora_t.text) + " " + "~n~r"
		k_errore = "2"
	else
	
		if isnull(dw_dett_0.getitemstring(k_riga, "sv_eventi_sked_run_ora")) then
//--- setta mezzanotte
			dw_dett_0.setitem(k_riga, "sv_eventi_sked_run_ora", "00:00")
		end if
	end if
	
	if isnull(dw_dett_0.getitemdate(k_riga, "sv_eventi_sked_run_giorno")) then
//--- setta "gira tutti i giorni"
		dw_dett_0.setitem(k_riga, "sv_eventi_sked_run_giorno", today())
	end if
	if isnull(dw_dett_0.getitemstring(k_riga, "sv_eventi_sked_stato")) then
//--- setta "da eseguire"
		dw_dett_0.setitem(k_riga, "sv_eventi_sked_stato", "0")
	end if


//--- se nessun errore grave
	if trim(k_errore) > "3" or trim(k_errore) = "0"then

		k_riga = dw_dett_0.getrow()


//--- imposto i dati di default
//		k_rc=dw_dett_0.setitem(k_riga, "x_datins", kGuf_data_base.prendi_x_datins())
//		k_rc=dw_dett_0.setitem(k_riga, "x_utente", kGuf_data_base.prendi_x_utente())

	end if
	

return trim(k_errore) + trim(k_return)


end function

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
kuf_sv_skedula kuf1_sv_skedula
pointer oldpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


//--- se programma NON lanciato in modalita' batch...	
	if ki_st_open_w.flag_modalita <> kkg_flag_modalita.batch then 

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

		attiva_tasti( )
		
	else
//--- se programma lanciato in modalita' batch...	
		try 

			kiw_this_window.windowstate = minimized!
			
			kuf1_sv_skedula = create kuf_sv_skedula 
			kuf1_sv_skedula.kist_sv_eventi_sked[1] = ki_st_open_w.key12_any
	//		kuf1_sv_skedula.kist_sv_eventi_sked[1] = kst_sv_eventi_sked
			kuf1_sv_skedula.kist_sv_eventi_sked[1].esito = " in esecuzione..."
			kuf1_sv_skedula.tb_aggiorna_stato_sv_eventi_sked()
			
			kuf1_sv_skedula.genera_eventi()  // esegue l'elaborazione
			
			kuf1_sv_skedula.kist_sv_eventi_sked[1].esito = ""
			if dw_lista_0.rowcount() > 0 then
				kuf1_sv_skedula.kist_sv_eventi_sked[1].esito = "Generati nuovi " &
				+ string(dw_lista_0.rowcount()) + " eventi da eseguire  "
			else
				kuf1_sv_skedula.kist_sv_eventi_sked[1].esito = "nessun evento da eseguire " 
			end if
			
			kuf1_sv_skedula.kist_sv_eventi_sked[1] = ki_st_open_w.key12_any
			kuf1_sv_skedula.kist_sv_eventi_sked[1].stato = kuf1_sv_skedula.kki_sv_eventi_sked_stato_eseg
			kuf1_sv_skedula.tb_aggiorna_stato_sv_eventi_sked()
		
			destroy kuf1_sv_skedula
		
		catch(uo_exception kuo_exception1)
		
		end try
		cb_ritorna.postevent(clicked!)
		
	end if 


return k_return



end function

protected subroutine open_start_window ();//
	ki_toolbar_window_presente=true

end subroutine

protected subroutine riempi_id ();//
if dw_dett_0.rowcount( ) > 0 then
	dw_dett_0.event u_set_run_datetime(1)
end if


end subroutine

protected subroutine attiva_tasti_0 ();
super::attiva_tasti_0()

cb_inserisci.enabled = false

end subroutine

on w_sv_skedulati.create
call super::create
end on

on w_sv_skedulati.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type st_ritorna from w_g_tab0`st_ritorna within w_sv_skedulati
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_sv_skedulati
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_sv_skedulati
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_sv_skedulati
end type

type st_stampa from w_g_tab0`st_stampa within w_sv_skedulati
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_sv_skedulati
end type

type cb_modifica from w_g_tab0`cb_modifica within w_sv_skedulati
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_sv_skedulati
end type

type cb_cancella from w_g_tab0`cb_cancella within w_sv_skedulati
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_sv_skedulati
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_sv_skedulati
event u_set_run_datetime ( integer a_riga )
integer y = 384
boolean enabled = true
string dataobject = "d_sv_eventi_sked"
end type

event dw_dett_0::u_set_run_datetime(integer a_riga);//
datetime k_datetime
string k_timex
date k_data


	
	k_timex = trim(this.getitemstring(a_riga, "sv_eventi_sked_run_ora")) + ":00"
	
	if istime(k_timex) then 
		
		k_data = this.getitemdate(a_riga, "sv_eventi_sked_run_giorno")
	
		k_datetime = datetime(k_data, time(k_timex))
	
		this.setitem( a_riga, "sv_eventi_sked_run_datetime", k_datetime)
		
	end if
	

end event

event dw_dett_0::itemchanged;//
datetime k_datetime
string k_timex


if dwo.name = "sv_eventi_sked_run_giorno" or dwo.name = "sv_eventi_sked_run_ora" then

	post event u_set_run_datetime(row)
	
end if

end event

type st_orizzontal from w_g_tab0`st_orizzontal within w_sv_skedulati
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_sv_skedulati
string dataobject = "d_sv_eventi_sked_l"
boolean ki_d_std_1_attiva_sort = false
end type

type dw_guida from w_g_tab0`dw_guida within w_sv_skedulati
end type

