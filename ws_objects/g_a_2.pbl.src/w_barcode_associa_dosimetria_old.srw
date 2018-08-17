$PBExportHeader$w_barcode_associa_dosimetria_old.srw
forward
global type w_barcode_associa_dosimetria_old from w_g_tab0
end type
end forward

global type w_barcode_associa_dosimetria_old from w_g_tab0
boolean visible = true
boolean ki_toolbar_window_presente = true
boolean ki_esponi_msg_dati_modificati = false
boolean ki_sincronizza_window_consenti = false
boolean ki_resize_dw_dett = true
boolean ki_riparte_dopo_save_ok = true
end type
global w_barcode_associa_dosimetria_old w_barcode_associa_dosimetria_old

type variables

private kuf_meca_dosim_barcode kiuf_meca_dosim_barcode
private kuf_armo kiuf_armo
private st_tab_meca_dosim kist_tab_meca_dosim

end variables

forward prototypes
protected function string inizializza () throws uo_exception
protected subroutine open_start_window ()
protected function string check_dati ()
protected function string aggiorna_tabelle ()
end prototypes

protected function string inizializza () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_return= "0"
long k_riga=0
kuf_utility kuf1_utility



//	dw_dett_0.object.t_info.visible = false

	if (kist_tab_meca_dosim.id_meca) > 0 then
		k_riga = dw_dett_0.retrieve(kist_tab_meca_dosim.id_meca ) 
	end if

		
	choose case k_riga

		case is < 0				
			messagebox("Operazione fallita", &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(Lotto cercato id: " + string(kist_tab_meca_dosim.id_meca) + ")~n~r" )
					
			k_return = "2"   // USCITA!

		case 0
			dw_dett_0.reset()
			if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
				
				inserisci()
				
			else
				messagebox("Accoppiamento Dosimetri", &
						"Nessun barcode per la dosimetria trovato. Lotto senza dosimetri o barcode non ancora generati e/o stampati.~n~r" + &
						"Lotto cercato id: " + string(kist_tab_meca_dosim.id_meca) + "~n~r" )
				k_return = "2"   // USCITA!
			end if
			

		case is > 0		
				if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
					messagebox("Accoppiamento Dosimetri", &
						"Attenzione il lotto ha già dei dosimetri accoppiati in archivio~n~r" + &
						"(Lotto cercato id:  " + string(kist_tab_meca_dosim.id_meca) + ")~n~r" )
		
					inserisci()
					
				else
					
					if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
				
						dw_dett_0.setrow(1)
						dw_dett_0.scrolltorow(1)
						
					end if
					
					dw_dett_0.setfocus()
				end if
					
		
	end choose

//	attiva_tasti()

//--- Inabilita campi alla modifica se Vsualizzazione
   kuf1_utility = create kuf_utility 
   if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.visualizzazione then
	
      kuf1_utility.u_proteggi_dw("1", 0, dw_lista_0)

	else		
		
//--- se Funzione MODIFICA
	   	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
			kuf1_utility.u_proteggi_dw("0", 0, dw_lista_0)
		end if

	end if
	destroy kuf1_utility
	


return k_return

end function

protected subroutine open_start_window ();//

//--- crea oggetto da usare nell'intera window
	kiuf_meca_dosim_barcode = create kuf_meca_dosim_barcode
	kiuf_armo = create kuf_armo

//--- Salva Argomenti programma chiamante
	if isnumber(trim(ki_st_open_w.key1)) then // ID MECA
		kist_tab_meca_dosim.id_meca = long(trim(ki_st_open_w.key1))
		ki_exit_dopo_save_ok = TRUE // dopo save ESCO
	else
		kist_tab_meca_dosim.id_meca = 0
	end if

end subroutine

protected function string check_dati ();//
//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK con errori non gravi
//===                : 5=OK con avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================
//
string k_return ="0" 
long k_riga, k_righe
st_tab_meca_dosim kst_tab_meca_dosim, kst_tab_meca_dosim_Barcode, kst_tab_meca_dosim_Dosimetro
st_tab_meca kst_tab_meca
st_esito kst_esito 


kst_esito.esito = kkg_esito.ok  
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try

//	dw_dett_0.object.t_info.visible = false
//	dw_dett_0.object.t_info.text = ""

	k_righe = dw_dett_0.rowcount()
	for k_riga = 1 to k_righe
		
		kst_tab_meca_dosim_Barcode.id_meca = 0
		kst_tab_meca_dosim_Barcode.barcode = ""
		kst_tab_meca_dosim_Dosimetro.barcode_dosimetro = ""
		dw_dett_0.setitem(k_riga,"t_info", "")

//--- probabile Barcode interno su prima colonna e Dosimetro sulla seconda
		kst_tab_meca_dosim_Barcode.barcode = dw_dett_0.object.meca_dosim_barcode[k_riga]    // PRIMA COLONNA
		if isnull(kst_tab_meca_dosim_Barcode.barcode) then kst_tab_meca_dosim_Barcode.barcode = ""
		kst_tab_meca_dosim_Dosimetro.barcode_dosimetro = dw_dett_0.object.barcode_dosimetro[k_riga]   // SECONDA COLONNA
		if isnull(kst_tab_meca_dosim_Dosimetro.barcode_dosimetro) then kst_tab_meca_dosim_Dosimetro.barcode_dosimetro = ""
	
//--- esiste il barcode?
//--- cerco dalla prima colonna
		kst_tab_meca_dosim.id_meca = 0
		if len(trim(kst_tab_meca_dosim_Barcode.barcode)) > 0 then
			kst_tab_meca_dosim.barcode = kst_tab_meca_dosim_Barcode.barcode
			if kiuf_meca_dosim_barcode.get_id_meca_da_barcode(kst_tab_meca_dosim) then
				
				kst_tab_meca_dosim_Barcode.id_meca = kst_tab_meca_dosim.id_meca
				kst_tab_meca_dosim_Barcode.barcode = kst_tab_meca_dosim.barcode
				
			else
	
//--- se non trovato cerco dalla seconda colonna
	
				kst_tab_meca_dosim.id_meca = 0
				kst_tab_meca_dosim.barcode = dw_dett_0.object.barcode_dosimetro[k_riga]
				if len(trim(kst_tab_meca_dosim.barcode)) > 0 then
					
					if kiuf_meca_dosim_barcode.get_id_meca_da_barcode(kst_tab_meca_dosim) then
						
						kst_tab_meca_dosim_Barcode.id_meca = kst_tab_meca_dosim.id_meca
						kst_tab_meca_dosim_Barcode.barcode = kst_tab_meca_dosim.barcode
					
//--- Il barcode interno e' sulla seconda colonna quindi forse il Dosimetro dovrebbe essere sulla prima colonna
						kst_tab_meca_dosim_Dosimetro.barcode_dosimetro = kst_tab_meca_dosim.barcode
						if isnull(kst_tab_meca_dosim_Dosimetro.barcode_dosimetro) then kst_tab_meca_dosim_Dosimetro.barcode_dosimetro = ""
	
					else
						kst_tab_meca_dosim_Barcode.barcode = ""   // NON TROVATO!!
					end if
				end if
			end if
		end if
	
	
		if len(trim(kst_tab_meca_dosim_Barcode.barcode)) = 0 then
//--- se non anora trovato: ERRORE
			kst_esito.esito = kkg_esito.not_fnd
			kst_esito.sqlerrtext = "Barcode interno non Trovato, probabile digitazione errata! "
			kst_esito.sqlcode = 0
			dw_dett_0.setitem (k_riga, "t_info", "BARCODE NON TROVATO!!")
		
		else
		
//--- Se trovato proseguo con i controlli

			kst_tab_meca.id = kst_tab_meca_dosim_Barcode.id_meca
			kiuf_armo.get_num_int(kst_tab_meca)
		
//--- Imposta dati Lotto in mappa
			dw_dett_0.setitem (k_riga, "id_meca", kst_tab_meca.id)
			dw_dett_0.setitem (k_riga, "num_int", kst_tab_meca.num_int)
			dw_dett_0.setitem (k_riga, "data_int", kst_tab_meca.data_int)

//--- esiste il Dosimetro?
			kst_tab_meca_dosim.id_meca = 0
			kst_tab_meca_dosim.barcode_dosimetro = kst_tab_meca_dosim_Dosimetro.barcode_dosimetro
			if len(trim(kst_tab_meca_dosim.barcode_dosimetro)) = 0 then
				
				kst_esito.esito = kkg_esito.no_esecuzione
				kst_esito.sqlerrtext = "Dosimetro non impostato, inutile salvare l'accoppiamento " 
				dw_dett_0.setitem (k_riga, "t_info", "DIGITARE IL DOSIMETRO")
				//dw_dett_0.object.t_info.text = "DIGITARE IL DOSIMETRO"
			
			else
				
//--- trova il codice Dosimetro in TAB spero che i dati siano quelli su cui sto lavorando ora....
				if kiuf_meca_dosim_barcode.if_esiste_barcode_dosimetro(kst_tab_meca_dosim) then
					
					kst_tab_meca_dosim_Dosimetro.id_meca = kst_tab_meca_dosim.id_meca
				else
					kst_tab_meca_dosim_Dosimetro.barcode_dosimetro = kst_tab_meca_dosim.barcode_dosimetro
				end if
	
//--- se DOSIMETRO trovato spero appartenga allo stesso del barcode altrimenti ERRORE		
				if kst_tab_meca_dosim_Dosimetro.id_meca > 0 and  kst_tab_meca_dosim_Barcode.id_meca <> kst_tab_meca_dosim_Dosimetro.id_meca then
					kst_tab_meca.id = kst_tab_meca_dosim_Dosimetro.id_meca
					kiuf_armo.get_num_int(kst_tab_meca)
					kst_esito.esito = kkg_esito.not_fnd
					kst_esito.sqlerrtext = "Dosimetro già utilizzato in altro Lotto, cambiare il codice o rimuoverlo dal " + string(kst_tab_meca.num_int) + " del " + string(kst_tab_meca.data_int)
					kst_esito.sqlcode = 0
					dw_dett_0.setitem (k_riga, "t_info", "DOSIMETRO GIA' UTILIZZATO!!")
				end if
			
//--- Se i barcode sono uguali qls non va...
				if trim(kst_tab_meca_dosim_Barcode.barcode) = trim(kst_tab_meca_dosim_Dosimetro.barcode_dosimetro) then
					kst_esito.esito = kkg_esito.no_esecuzione
					kst_esito.sqlerrtext = "Codici barcode uguali, controlla meglio! "
					dw_dett_0.setitem (k_riga, "t_info", "ERRORE CODICI UGUALI!!")
				end if
	
			end if

//--- barcode gia' usato?
			kst_tab_meca_dosim.id_meca = 0
			kst_tab_meca_dosim.barcode = kst_tab_meca_dosim_Barcode.barcode
			if kiuf_meca_dosim_barcode.if_gia_usato_barcode(kst_tab_meca_dosim) > 1 then
				kst_esito.esito = kkg_esito.ko
				kst_esito.sqlerrtext = "Barcode interno già utilizzato in altro Lotto, probabile digitazione errata! "
				kst_esito.sqlcode = 0
				dw_dett_0.setitem (k_riga, "t_info", "BARCODE GIA' UTILIZZATO!!")
			end if		
			
		end if
		
	
//--- Se Tutto OK	
		if kst_esito.esito = kkg_esito.ok then
//			dw_dett_0.object.t_info.text = "OK!"
			dw_dett_0.setitem (k_riga, "t_info", "OK!")
			dw_dett_0.setitem (k_riga, "meca_dosim_barcode", kst_tab_meca_dosim_Barcode.barcode )
			dw_dett_0.setitem (k_riga, "barcode_dosimetro", kst_tab_meca_dosim_Dosimetro.barcode_dosimetro )
		end if
		
//		if len(trim(dw_dett_0.object.t_info.text)) > 0 then
//			dw_dett_0.object.t_info.visible = true
//		end if

	next

catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	k_return = "1" + trim(kst_esito.sqlerrtext)  // ERRORE


finally
	
	if kst_esito.esito <> kkg_esito.ok then

		if kst_esito.esito = kkg_esito.no_esecuzione then

			k_return = "3" + trim(kst_esito.sqlerrtext)  // ERRORE
		else 
			
			k_return = "1" + trim(kst_esito.sqlerrtext)  // ERRORE
		end if
		
	end if
	
end try
	
	
return k_return	
	
	
end function

protected function string aggiorna_tabelle ();//
//=== Update delle Tabelle
string k_return = "0 "
st_tab_meca_dosim kst_tab_meca_dosim
st_esito kst_esito

	
	try 
		
		kst_tab_meca_dosim.id_meca = dw_dett_0.object.id_meca[1]
		kst_tab_meca_dosim.barcode_dosimetro = dw_dett_0.object.barcode_dosimetro[1]
		kst_tab_meca_dosim.barcode = dw_dett_0.object.meca_dosim_barcode[1]
		kiuf_meca_dosim_barcode.set_barcode_dosimetro(kst_tab_meca_dosim)
//		kiuf_meca_dosim_barcode.tb_add_barcode(kst_tab_meca_dosim)
		
		dw_dett_0.resetupdate( ) 
		
	catch(uo_exception kuo_exception)
	
		kst_esito = kuo_exception.get_st_esito()
		k_return = "1" + kst_esito.sqlerrtext
	
	end try

	
return k_return


end function

on w_barcode_associa_dosimetria_old.create
call super::create
end on

on w_barcode_associa_dosimetria_old.destroy
call super::destroy
end on

event close;call super::close;//

if isvalid(kiuf_meca_dosim_barcode) then destroy kiuf_meca_dosim_barcode

end event

type st_ritorna from w_g_tab0`st_ritorna within w_barcode_associa_dosimetria_old
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_barcode_associa_dosimetria_old
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_barcode_associa_dosimetria_old
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_barcode_associa_dosimetria_old
end type

type st_stampa from w_g_tab0`st_stampa within w_barcode_associa_dosimetria_old
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_barcode_associa_dosimetria_old
end type

type cb_modifica from w_g_tab0`cb_modifica within w_barcode_associa_dosimetria_old
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_barcode_associa_dosimetria_old
end type

type cb_cancella from w_g_tab0`cb_cancella within w_barcode_associa_dosimetria_old
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_barcode_associa_dosimetria_old
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_barcode_associa_dosimetria_old
integer x = 18
integer y = 168
integer height = 1164
boolean enabled = true
string dataobject = "d_barcode_accoppia_dosimetro"
boolean hsplitscroll = false
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_colora_riga_aggiornata = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_dw_visibile_in_open_window = true
end type

type st_orizzontal from w_g_tab0`st_orizzontal within w_barcode_associa_dosimetria_old
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_barcode_associa_dosimetria_old
boolean enabled = false
boolean hscrollbar = false
boolean vscrollbar = false
boolean hsplitscroll = false
boolean livescroll = false
boolean ki_link_standard_attivi = false
boolean ki_button_standard_attivi = false
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_d_std_1_attiva_cerca = false
boolean ki_db_conn_standard = false
boolean ki_dw_visibile_in_open_window = false
end type

type dw_guida from w_g_tab0`dw_guida within w_barcode_associa_dosimetria_old
end type

