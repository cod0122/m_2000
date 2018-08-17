$PBExportHeader$w_listino_l.srw
forward
global type w_listino_l from w_g_tab0
end type
type dw_data from uo_d_std_1 within w_listino_l
end type
type dw_box_duplica_listini from datawindow within w_listino_l
end type
end forward

global type w_listino_l from w_g_tab0
integer width = 3328
integer height = 1964
string title = "Listini"
long backcolor = 32172778
boolean ki_toolbar_window_presente = true
dw_data dw_data
dw_box_duplica_listini dw_box_duplica_listini
end type
global w_listino_l w_listino_l

type variables
private kuf_listino kiuf_listino
private string ki_mostra_nascondi_in_lista="*"
private string ki_win_titolo_orig_save = ""
private st_tab_listino ki_st_tab_listino
private st_tab_listino ki_st_tab_listino_arg
private long ki_ultimo_clie_3_cercato=999999
private date ki_data_scad, ki_data_al
private boolean ki_duplica_enabled = false


end variables

forward prototypes
protected function integer visualizza ()
private function string cancella ()
private function string inizializza ()
protected subroutine attiva_menu ()
protected subroutine smista_funz (string k_par_in)
private subroutine mostra_nascondi_in_lista ()
private subroutine carica_listino_no_dose ()
protected subroutine open_start_window ()
protected subroutine set_titolo_window_personalizza ()
public function integer u_retrieve_dw_lista ()
public subroutine call_contratti ()
private subroutine cambia_data_scadenze ()
public subroutine call_listini_cambia_stato ()
private function boolean u_duplica ()
private subroutine u_duplica_massiva ()
private subroutine u_duplica_box ()
public subroutine u_resize ()
public subroutine u_retrieve_post ()
protected subroutine attiva_tasti_0 ()
end prototypes

protected function integer visualizza ();//
string k_cod_art
long k_cod_cli, k_mis_x, k_mis_y, k_mis_z, k_riga
double k_dose
st_open_w k_st_open_w
//kuf_menu_window kuf1_menu_window


k_riga = dw_lista_0.getselectedrow(0)	
if k_riga > 0 then

	k_cod_cli = dw_lista_0.getitemnumber( k_riga, "cod_cli") 
	k_cod_art = dw_lista_0.getitemstring( k_riga, "cod_art") 
	k_dose = dw_lista_0.getitemnumber( k_riga, "listino_dose") 
	k_mis_x = dw_lista_0.getitemnumber( k_riga, "listino_mis_x") 
	k_mis_y = dw_lista_0.getitemnumber( k_riga, "listino_mis_y") 
	k_mis_z = dw_lista_0.getitemnumber( k_riga, "listino_mis_z") 


//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice cli; key2=cod sl-pt

	K_st_open_w.id_programma = "li"
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_modalita = "vi"
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN_NO
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = trim(string(k_cod_cli)) // cod cliente
	K_st_open_w.key2 = trim(k_cod_art) // cod articolo 
	K_st_open_w.key3 = trim(string(k_dose)) // dose
	K_st_open_w.key4 = trim(string(k_mis_x)) // misure imballo
	K_st_open_w.key5 = trim(string(k_mis_y)) // misure imballo
	K_st_open_w.key6 = trim(string(k_mis_z)) // misure imballo
	K_st_open_w.flag_where = " "
	
	//kuf1_menu_window = create kuf_menu_window 
	kGuf_menu_window.open_w_tabelle(k_st_open_w)
	//destroy kuf1_menu_window
								
else

	messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")

end if

return (0)
end function

private function string cancella ();//
string k_errore = "0 ", k_errore1 = "0 "
long k_riga
st_tab_listino kst_tab_listino
st_esito kst_esito

k_riga = dw_lista_0.getselectedrow(0)	
if k_riga > 0 then
	kst_tab_listino.id = dw_lista_0.getitemnumber(k_riga, "id_listino")
	kst_tab_listino.cod_art = dw_lista_0.getitemstring(k_riga, "cod_art")
	kst_tab_listino.cod_cli = dw_lista_0.getitemnumber(k_riga, "cod_cli")
	kst_tab_listino.dose = dw_lista_0.getitemnumber(k_riga, "listino_dose")
	kst_tab_listino.mis_x = dw_lista_0.getitemnumber(k_riga, "listino_mis_x")
	kst_tab_listino.mis_y = dw_lista_0.getitemnumber(k_riga, "listino_mis_y")
	kst_tab_listino.mis_z = dw_lista_0.getitemnumber(k_riga, "listino_mis_z")

	if isnull(kst_tab_listino.cod_art) = true or trim(kst_tab_listino.cod_art) = "" then
		kst_tab_listino.cod_art = "Listino senza cod_artizione" 
	end if
	
//=== Richiesta di conferma della eliminazione del rek
	if messagebox("Elimina Prezzo Listino  " +  string(kst_tab_listino.id, "####0"), "Sei sicuro di voler CANCELLARE definitivamente la riga: ~n~r" &
	         + "Cliente: " + string(kst_tab_listino.cod_cli, "#####") + "   Articolo: " + trim(kst_tab_listino.cod_art) &
	         + "   dose: " + string(kst_tab_listino.dose, "###0.00")  &
	         + "   ID: " + string(kst_tab_listino.id, "####0"), &
				question!, yesno!, 2) = 1 then
				
		try 		
			
//=== Cancella la riga dal data windows di lista
			k_errore = kiuf_listino.tb_delete( kst_tab_listino ) 
			if LeftA(k_errore, 1) = "0" then
	
				k_errore = kGuf_data_base.db_commit()
				if LeftA(k_errore, 1) <> "0" then
					messagebox("Problemi durante la Cancellazione !!", &
											"Controllare i dati. " + MidA(k_errore, 2))

				else

					dw_lista_0.setitemstatus(k_riga, 0, primary!, new!)
					dw_lista_0.deleterow(k_riga)

				end if

				dw_lista_0.setfocus()

			else
				k_errore1 = k_errore
				k_errore = kGuf_data_base.db_rollback()

				messagebox("Problemi durante Cancellazione - Operazione fallita !!", &
																MidA(k_errore1, 2) ) 	
				if LeftA(k_errore, 1) <> "0" then
					messagebox("Problemi durante il recupero dell'errore !!", &
							"Controllare i dati. " + MidA(k_errore, 2))
				end if

				attiva_tasti()

			end if
			
		catch (uo_exception kuo1_exception)
			kst_esito = kuo1_exception.get_st_esito()
			k_errore = "1" + kst_esito.sqlerrtext
			kuo1_exception.messaggio_utente()
			
			
		end try


	else
		messagebox("Elimina Prezzo Listino", "Operazione Annullata !!")

	end if
else
	messagebox("Elimina Prezzo Listino", "Selezionare una riga dall'elenco. ")
end if

return " "
end function

private function string inizializza ();//
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
long  k_riga=0
int k_importa = 0
pointer oldpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

//--- Se non ho richiesto un cliente particolare mi fermo x chiedere
	if ki_st_open_w.flag_primo_giro = "S" then
		if ki_st_tab_listino.cod_cli = 0 and ki_st_tab_listino.cod_art = "*" then

			dw_guida.setfocus( )
			dw_guida.setitem(1,"rag_soc_1", "")

		else
			dw_guida.setitem(1,"rag_soc_1", string(ki_st_tab_listino.cod_cli ))
		end if
		
		dw_guida.setcolumn("rag_soc_1")

	end if
//=== Legge le righe del dw salvate l'ultima volta (importfile)
//	if ki_st_open_w.flag_primo_giro = "S" then  
//		k_importa = kGuf_data_base.dw_importfile(trim(ki_syntaxquery), dw_lista_0)
//	end if
		
	//	if k_importa <= 0 then // Nessuna importazione eseguita
	if ki_st_tab_listino.cod_cli > 0 or ki_st_tab_listino.cod_art <> "*" or ki_st_tab_listino.contratto > 0 or ki_st_open_w.flag_primo_giro <> "S" then

		if u_retrieve_dw_lista() < 1 then
			k_return = "1Non trovati Prezzi Listino "
	
			SetPointer(oldpointer)
			messagebox("Elenco Prezzi Listino Vuota", &
					"Nesun Codice Trovato per la richiesta fatta")
		else
			u_retrieve_post()
		end if		

	
//		end if
		
		if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima volta il tasto e' false 
			ki_mostra_nascondi_in_lista = "S"
			mostra_nascondi_in_lista()
		end if

		
	end if
	
	attiva_tasti()

return k_return


end function

protected subroutine attiva_menu ();//--- Attiva/Dis. Voci di menu


//
//--- Attiva/Dis. Voci di menu personalizzate
//
	if not ki_menu.m_strumenti.m_fin_gest_libero1.visible then
	
		ki_menu.m_strumenti.m_fin_gest_libero1.text = "Carica Listino di servizio"
		ki_menu.m_strumenti.m_fin_gest_libero1.microhelp = "Carica Listino di servizio (no dose)"
		ki_menu.m_strumenti.m_fin_gest_libero1.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero1.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText = "No-Dose,"+ki_menu.m_strumenti.m_fin_gest_libero1.text
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName = "New!"
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2

		if ki_menu.m_strumenti.m_fin_gest_libero2.enabled <> ki_duplica_enabled then
			ki_menu.m_strumenti.m_fin_gest_libero2.text = "Genera nuovo Listino come quello selezionato"
			ki_menu.m_strumenti.m_fin_gest_libero2.microhelp =  "Duplica Listino"
			ki_menu.m_strumenti.m_fin_gest_libero2.visible = true
			ki_menu.m_strumenti.m_fin_gest_libero2.enabled = ki_duplica_enabled
			ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true
			ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemText = "Duplica,"+ki_menu.m_strumenti.m_fin_gest_libero2.text
			ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName =  "Copy!"
			ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
		end if

		ki_menu.m_strumenti.m_fin_gest_libero3.text = "Contratto CO"
		ki_menu.m_strumenti.m_fin_gest_libero3.microhelp = "Elenco Contratto associato al Listino selezionato"
		ki_menu.m_strumenti.m_fin_gest_libero3.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemText = "Contr.," + ki_menu.m_strumenti.m_fin_gest_libero3.microhelp
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemName = "Custom004!"
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero3.visible = true
	
		ki_menu.m_strumenti.m_fin_gest_libero4.text = "Cambia data estrazione scadenze contratto CO"
		ki_menu.m_strumenti.m_fin_gest_libero4.microhelp = "Cambia data estrazione scadenze contratto CO"
		ki_menu.m_strumenti.m_fin_gest_libero4.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemText = "Scad.,"+ki_menu.m_strumenti.m_fin_gest_libero4.text
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemName = "Custom015!"
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero4.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemVisible = true
		
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.text = "Mostra righe Listini in Vigore "
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.microhelp = "Mostra Listini in Vigore"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.toolbaritemText = "Validi,"+ki_menu.m_strumenti.m_fin_gest_libero7.libero1.text
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.toolbaritemName = "DataWindow1!"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.toolbaritembarindex=2
	
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.text = "Mostra righe Listini Annullati"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.microhelp = "Mostra Listini Annullati"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.toolbaritemText = "Scaduti,"+ki_menu.m_strumenti.m_fin_gest_libero7.libero2.text
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.toolbaritemName = "DataWindow2!"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.toolbaritembarindex=2
	
		ki_menu.m_strumenti.m_fin_gest_libero7.libero3.text = "Mostra righe Listini Da-Attivare"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero3.microhelp = "Mostra Listini Da-Attivare"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero3.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero7.libero3.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero7.libero3.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero7.libero3.toolbaritemText = "Da-Att.,"+ki_menu.m_strumenti.m_fin_gest_libero7.libero3.text
		ki_menu.m_strumenti.m_fin_gest_libero7.libero3.toolbaritemName = "DataWindow5!"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero3.toolbaritembarindex=2
	
		ki_menu.m_strumenti.m_fin_gest_libero7.libero4.text = "Mostra Tutti i Listini"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero4.microhelp = "Mostra Tutti i Listini"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero4.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero7.libero4.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero7.libero4.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero7.libero4.toolbaritemText = "Tutti,"+ki_menu.m_strumenti.m_fin_gest_libero7.libero4.text
		ki_menu.m_strumenti.m_fin_gest_libero7.libero4.toolbaritemName = "EditDataTabular!"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero4.toolbaritembarindex=2
	
		ki_menu.m_strumenti.m_fin_gest_libero7.libero5.text = "Mostra Listini di Servizio (No-Dose)"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero5.microhelp = "Mostra Listini di Servizio (No-Dose)"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero5.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero7.libero5.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero7.libero5.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero7.libero5.toolbaritemText = "No-Dose,"+ki_menu.m_strumenti.m_fin_gest_libero7.libero5.text
		ki_menu.m_strumenti.m_fin_gest_libero7.libero5.toolbaritemName = "DataWindow!"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero5.toolbaritembarindex=2
	
		ki_menu.m_strumenti.m_fin_gest_libero7.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero7.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero7.visible = true

	
		ki_menu.m_strumenti.m_fin_gest_libero8.text = "Annulla/Attiva Listini"
		ki_menu.m_strumenti.m_fin_gest_libero8.microhelp = "Annullamento/Attivazione massiva dei Listini per data scadenze contratto CO"
		ki_menu.m_strumenti.m_fin_gest_libero8.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritemText = "Annulla,"+ki_menu.m_strumenti.m_fin_gest_libero8.text
		ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritemName = "Close!"
		ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero8.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritemVisible = true
		
	end if

	super::attiva_menu()


end subroutine

protected subroutine smista_funz (string k_par_in);//
//===

choose case k_par_in 


	case KKG_FLAG_RICHIESTA.libero1		//carica listino NO DOSE
		carica_listino_no_dose()
		
	case KKG_FLAG_RICHIESTA.libero2		//duplica riga
		u_duplica_box( )

	case KKG_FLAG_RICHIESTA.libero4		//cambia data estrazione scadenze
		cambia_data_scadenze()
		
	case KKG_FLAG_RICHIESTA.libero71		//Mostra solo Validi
		ki_mostra_nascondi_in_lista = "S"
		mostra_nascondi_in_lista()
	case KKG_FLAG_RICHIESTA.libero72		//Mostra solo scaduti
		ki_mostra_nascondi_in_lista = "N"
		mostra_nascondi_in_lista()
	case KKG_FLAG_RICHIESTA.libero73		//Mostra solo listini Da-Attivare
		ki_mostra_nascondi_in_lista = "D"
		mostra_nascondi_in_lista()
	case KKG_FLAG_RICHIESTA.libero74		//Mostra tutti
		ki_mostra_nascondi_in_lista = "*"
		mostra_nascondi_in_lista()
	case KKG_FLAG_RICHIESTA.libero75		//Mostra solo Listini NO DOSE 'di servizio'
		ki_mostra_nascondi_in_lista = "X"
		mostra_nascondi_in_lista()
		
	case KKG_FLAG_RICHIESTA.libero3		//chiama CONTRATTO-CO
		call_contratti( )
	case KKG_FLAG_RICHIESTA.libero8		//chiama CAMBIO LISTINO
		call_listini_cambia_stato( )
		
	case else
		super::smista_funz(k_par_in)

end choose



end subroutine

private subroutine mostra_nascondi_in_lista ();//
boolean k_rc


	pointer kpointer_orig
	kpointer_orig = setpointer(hourglass!)


	dw_lista_0.setredraw(false)


//--- se NON sono al primo giro
	if ki_st_open_w.flag_primo_giro <> "S" then

		if ki_mostra_nascondi_in_lista = "X" then
			
			if dw_lista_0.dataobject <> "d_listino_no_dose_l" then
				dw_lista_0.dataobject = "d_listino_no_dose_l"
				dw_lista_0.settransobject(kguo_sqlca_db_magazzino )
				dw_lista_0.reset( )
			end if

			dw_lista_0.u_filtra_record("") 
			if dw_lista_0.rowcount( ) = 0 then
				leggi_liste()
			end if
			
		else
			
			if dw_lista_0.dataobject <> "d_clienti_listino_l" then
				dw_lista_0.dataobject = "d_clienti_listino_l"
				dw_lista_0.settransobject(kguo_sqlca_db_magazzino )
				dw_lista_0.reset( )
			end if

			dw_lista_0.u_filtra_record("") 
			if dw_lista_0.rowcount( ) = 0 then
				leggi_liste()
			end if
	
			ki_win_titolo_orig = ki_win_titolo_orig_save
			choose case ki_mostra_nascondi_in_lista
				case "S" 	
					dw_lista_0.u_filtra_record("listino_attivo = 'S' and (data_scad >= date('" + string(kG_dataoggi) + "') or isnull(data_scad) ) ")   
				case "N" 
					k_rc=dw_lista_0.u_filtra_record("listino_attivo = 'N' or data_scad < date('" + string(kG_dataoggi) + "') ")  
				case "D" 
					k_rc=dw_lista_0.u_filtra_record("listino_attivo = 'D' ")  
				case "*"
					dw_lista_0.u_filtra_record("") 
//				case "X"
//					dw_lista_0.u_filtra_record("listino_dose = 0.00 or isnull(listino_dose) ") 
			end choose
		end if	
	end if


	dw_lista_0.setredraw(true)

	attiva_tasti()
	
	setpointer(kpointer_orig)




end subroutine

private subroutine carica_listino_no_dose ();//
st_tab_listino kst_tab_listino
st_open_w k_st_open_w
//kuf_menu_window kuf1_menu_window

//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	K_st_open_w.id_programma = kkg_id_programma_listini2
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = "0" // id
	K_st_open_w.key2 = "0" // cod cliente 
	K_st_open_w.key3 = " " // cod articolo 
	K_st_open_w.flag_where = " "
	
	//kuf1_menu_window = create kuf_menu_window 
	kGuf_menu_window.open_w_tabelle(k_st_open_w)
	//destroy kuf1_menu_window

								

end subroutine

protected subroutine open_start_window ();//
long k_rc=0
datawindowchild kdwc_cliente

	
	ki_win_titolo_orig_save = ki_win_titolo_orig
	ki_toolbar_window_presente=true

	kiuf_listino = create kuf_listino

	kiuf_listino.autorizza_campi(dw_lista_0)

//---
	ki_st_tab_listino.cod_cli = long(trim(ki_st_open_w.key1))  // codice cliente
	if isnull(ki_st_tab_listino.cod_cli ) then
			ki_st_tab_listino.cod_cli = 0
	end if
	ki_st_tab_listino.cod_art = trim(ki_st_open_w.key2)  // codice articolo
	if isnull(ki_st_tab_listino.cod_art) or LenA(trim(ki_st_tab_listino.cod_art)) = 0 then
		ki_st_tab_listino.cod_art = "*"
	end if
	if trim(ki_st_open_w.key3) = "" then									// da quale data scadenza contratti?
		if isdate(trim(ki_st_open_w.key3)) then
			ki_data_scad = date(trim(ki_st_open_w.key3))
		else
			ki_data_scad = relativedate(kg_dataoggi, -365)
		end if
	else
		ki_data_scad = relativedate(kg_dataoggi, -365)
	end if
	ki_data_al = date(kg_dataoggi)
	
	ki_st_tab_listino.contratto = 0
	if IsNumber(ki_st_open_w.key4) then // codice contratto
		ki_st_tab_listino.contratto = long(ki_st_open_w.key4)  
		if isnull(ki_st_tab_listino.contratto) then
			ki_st_tab_listino.contratto = 0
		end if
	end if
	
	dw_guida.insertrow(0)
	dw_guida.getchild("rag_soc_1", kdwc_cliente)
	kdwc_cliente.settransobject( sqlca)
	kdwc_cliente.retrieve("%")
	kdwc_cliente.insertrow(1)
	
	try
		if kiuf_listino.if_sicurezza(kkg_flag_modalita.inserimento ) then
			ki_duplica_enabled = true
		end if
	catch (uo_exception kuo_exception)
		ki_duplica_enabled = false
	end try
	
	dw_box_duplica_listini.insertrow(0)
	
	ki_st_tab_listino_arg = ki_st_tab_listino
	
	
end subroutine

protected subroutine set_titolo_window_personalizza ();
super::set_titolo_window_personalizza()

choose case ki_mostra_nascondi_in_lista
   case 'S'  // solo in vigore
      this.title += " - righe Listini in Vigore "
   case 'N'  // solo Scaduti
      this.title += " - Solo righe Listini Annullati "
   case 'D'  // solo Scaduti
      this.title += " - Solo righe Listini Da-Attivare "
   case '*'  // Tutte
      this.title += " - Mostra tutti i Listini "
   case 'X' //solo i No dose
      this.title += " - Solo righe Listini di Servizio (Senza Dose) "
end choose

end subroutine

public function integer u_retrieve_dw_lista ();//---
//---  Fa la Retrieve
//---
long k_return=0	
	
	
//	dw_lista_0.reset()
	if ki_mostra_nascondi_in_lista = "X" then  // listino NO DOSE di servizio
		k_return = dw_lista_0.retrieve() 
	else
		k_return = dw_lista_0.retrieve(ki_st_tab_listino.cod_cli, ki_data_scad, ki_st_tab_listino.contratto) 
	end if
	
return k_return
	

end function

public subroutine call_contratti ();//---
st_tab_contratti kst_tab_contratti
kuf_contratti kuf1_contratti
st_open_w kst_open_w


try

	if dw_lista_0.getselectedrow(0) > 0 then
		kst_tab_contratti.codice = dw_lista_0.getitemnumber(dw_lista_0.getselectedrow(0), "contratto")
	
//--- protezione campi per visual
		kuf1_contratti= create kuf_contratti
		kst_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
		kuf1_contratti.link_call_imvc(kst_tab_contratti, kst_open_w)

	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally
	if isvalid(kuf1_contratti) then destroy kuf1_contratti	
	
	
end try 

end subroutine

private subroutine cambia_data_scadenze ();//---
//--- Visualizza il box x il cambio DATA
//---


dw_data.triggerevent("ue_visibile")

end subroutine

public subroutine call_listini_cambia_stato ();//---
kuf_listino_cambio_stato kuf1_listino_cambio_stato
st_open_w kst_open_w
st_tab_listino kst_tab_listino

try

//---
	kuf1_listino_cambio_stato= create kuf_listino_cambio_stato
	kst_open_w.flag_modalita = kkg_flag_modalita.modifica
	kuf1_listino_cambio_stato.link_call_imvc(kst_tab_listino, kst_open_w)
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally
	if isvalid(kuf1_listino_cambio_stato) then destroy kuf1_listino_cambio_stato	
	
	
end try 

end subroutine

private function boolean u_duplica ();//
boolean k_return = false
//string k_errore = "0 ", k_errore1 = "0 "
long k_riga=0, k_id
string k_rag_soc_10
st_tab_listino kst_tab_listino
st_esito kst_esito


if dw_lista_0.rowcount() > 0 then
	k_riga = 	dw_lista_0.getselectedrow(0)
	if k_riga > 0 then

//		kguo_exception.inizializza( )
//		kguo_exception.messaggio_utente( "Duplica Listino", "Selezionare almeno una riga")
//	else
//		
//		
		kst_tab_listino.id = dw_lista_0.getitemnumber(k_riga, "id_listino")
		k_rag_soc_10  = dw_lista_0.getitemstring(k_riga, "rag_soc_10")
	
		if k_rag_soc_10 > " " then
		else
			k_rag_soc_10 = "Listino senza Cliente " 
		end if
		
	//=== Richiesta di conferma operazione
		if messagebox("Duplica", "Sei sicuro di voler DUPLICARE questo Listino: ~n~r" &
					+ string(kst_tab_listino.id, "#####") + " - " + trim(k_rag_soc_10),  &
					question!, yesno!, 2) = 1 then
			
			
			try
			
	//=== Duplica la riga dal data windows di lista
				kst_tab_listino.st_tab_g_0.esegui_commit = "S"
				k_id = kiuf_listino.tb_duplica( kst_tab_listino ) 
				if k_id > 0 then
				
					k_return = true
			
	//				ki_st_open_w.key1 = string(k_id)
	//				ki_st_open_w.key2 = ""
	//				dw_lista_0.reset( )
	//				inizializza( )
					kguo_exception.inizializza( )
					kguo_exception.messaggio_utente( "Duplica Terminata", "Listino duplicato id " + string(k_id))
	
					dw_lista_0.setfocus()
				else
					kguo_exception.inizializza( )
					kguo_exception.messaggio_utente( "Duplica Listino", "Operazione non eseguita")
				end if
	
				
			catch (uo_exception kuo_exception)
				kuo_exception.messaggio_utente( "Duplica Fallita","")
	
				attiva_tasti()
	
			end try
	
	
		else
			kguo_exception.inizializza( )
			kguo_exception.messaggio_utente( "Duplica Listino", "Operazione Annullata")
	
		end if
	end if
end if



return k_return

end function

private subroutine u_duplica_massiva ();//
long k_riga, k_id, k_idx, k_righe
boolean k_da_selezione=false
st_tab_listino kst_tab_listino
st_listino_duplica kst_listino_duplica[]
st_open_w kst_open_w
kuf_listino_duplica_massiva kuf1_listino_duplica_massiva



kuf1_listino_duplica_massiva = create kuf_listino_duplica_massiva

k_righe = dw_lista_0.rowcount()
if k_righe > 0 then

	k_riga = 	dw_lista_0.getselectedrow(0)
	if k_riga > 0 then
		k_riga = 	dw_lista_0.getselectedrow(k_riga)
		if k_riga > 0 then
			k_da_selezione = true
		end if
	end if

//--- popolo array da passare al programma di DUPLICA MASSIVA
	if k_da_selezione then
		k_riga = 	dw_lista_0.getselectedrow(0)
		do while k_riga > 0 
			kst_listino_duplica[k_idx].id_listino = dw_lista_0.getitemnumber(k_riga, "id_listino")
			k_riga = 	dw_lista_0.getselectedrow(k_riga+1)
		loop
	else
		for k_idx = 1 to k_righe
			kst_listino_duplica[k_idx].id_listino = dw_lista_0.getitemnumber(k_idx, "id_listino")
		next
	end if

end if
	

//--- Chiama la funzione di DUPLICA MASSIVA
kst_open_w.key12_any = kst_listino_duplica[]
kuf1_listino_duplica_massiva.u_open(kst_open_w)

end subroutine

private subroutine u_duplica_box ();//
long k_riga = 0, k_riga1
boolean k_return = false
//string k_errore = "0 ", k_errore1 = "0 "
string k_rag_soc_10
st_tab_listino kst_tab_listino
st_esito kst_esito


if dw_lista_0.rowcount( ) > 0 then
	k_riga = 	dw_lista_0.getselectedrow(0)
	if k_riga > 0 then
		k_riga1 = 	dw_lista_0.getselectedrow(k_riga+1)
		if k_riga1 > 0 then
			u_duplica_massiva( )  // Ho piu' righe selezionate parte la Massiva
		else
			kst_tab_listino.id = dw_lista_0.getitemnumber(k_riga, "id_listino")
			k_rag_soc_10  = dw_lista_0.getitemstring(k_riga, "rag_soc_10")
			if k_rag_soc_10 > " " then
			else
				k_rag_soc_10 = "Listino senza Cliente " 
			end if
			dw_box_duplica_listini.object.b_dup_singolo.text = "Duplica Listino " + string(kst_tab_listino.id, "#") + " di " + trim(k_rag_soc_10)
			dw_box_duplica_listini.visible = true
		end if
	else
		u_duplica_massiva( )   // non ho nessuna riga selezionata parte la Massiva
	end if
else
	u_duplica_massiva( )  // non ho niente in elenco parte la Massiva
end if

end subroutine

public subroutine u_resize ();//
super::u_resize()

dw_box_duplica_listini.x = (width - dw_box_duplica_listini.width) / 2 
dw_box_duplica_listini.y = (height - dw_box_duplica_listini.height) / 3 

end subroutine

public subroutine u_retrieve_post ();//---
//---  Dopo la Retrieve posizione cursore
//---

if dw_lista_0.rowcount() > 0 then
	dw_lista_0.setfocus( )

	//--- seleziona almeno una riga
	if dw_lista_0.rowcount() > 0 then
		if dw_lista_0.getselectedrow(0) = 0 then
			if dw_lista_0.getrow() = 0 then
				dw_lista_0.setrow(1)
				dw_lista_0.selectrow( 1, true)
			else
				dw_lista_0.selectrow(dw_lista_0.getrow(), true)
			end if
		end if
	end if

end if	

attiva_tasti( )
	

end subroutine

protected subroutine attiva_tasti_0 ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================

long k_nr_righe


super::attiva_tasti_0()

cb_inserisci.visible = false
cb_aggiorna.visible = false
cb_modifica.visible = false
cb_cancella.visible = false
cb_visualizza.visible = false

cb_inserisci.enabled = true
cb_aggiorna.enabled = false
cb_modifica.enabled = false
cb_cancella.enabled = false
cb_visualizza.enabled = false

//=== Nr righe ne DW lista
if dw_lista_0.rowcount ( ) > 0 then
	cb_modifica.enabled = true
	cb_cancella.enabled = true
	cb_visualizza.enabled = true
	cb_visualizza.default = true
end if
            

end subroutine

on w_listino_l.create
int iCurrent
call super::create
this.dw_data=create dw_data
this.dw_box_duplica_listini=create dw_box_duplica_listini
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_data
this.Control[iCurrent+2]=this.dw_box_duplica_listini
end on

on w_listino_l.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_data)
destroy(this.dw_box_duplica_listini)
end on

type st_ritorna from w_g_tab0`st_ritorna within w_listino_l
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_listino_l
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_listino_l
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_listino_l
integer x = 2427
integer y = 1160
integer height = 92
integer taborder = 80
boolean cancel = true
end type

type st_stampa from w_g_tab0`st_stampa within w_listino_l
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_listino_l
integer x = 1801
integer y = 1252
end type

event cb_visualizza::clicked;//
long k_riga=0
st_tab_listino kst_tab_listino
st_open_w k_st_open_w
//kuf_menu_window kuf1_menu_window

try

	k_riga = dw_lista_0.getselectedrow(0)	
	if k_riga > 0 then
	
		kst_tab_listino.id = dw_lista_0.getitemnumber(k_riga, "id_listino") 
//		kst_tab_listino.cod_cli = kiuf_listino.get_cod_cli(kst_tab_listino)
//		kst_tab_listino.contratto = kiuf_listino.get_contratto(kst_tab_listino)
	
	//	kst_tab_listino.cod_cli = dw_lista_0.getitemnumber(k_riga, "cod_cli") 
	//	kst_tab_listino.cod_art = dw_lista_0.getitemstring(k_riga, "cod_art") 
	
	
	//
	//=== Parametri : 
	//=== struttura st_open_w
	//=== dati particolare programma
	//
		if dw_lista_0.dataobject = "d_clienti_listino_l" then
			K_st_open_w.id_programma = kiuf_listino.get_id_programma(kkg_flag_modalita.visualizzazione) //kkg_id_programma_listini
		else
			K_st_open_w.id_programma = kkg_id_programma_listini2  //listini di servizio
		end if
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
		K_st_open_w.flag_leggi_dw = " "
		K_st_open_w.flag_cerca_in_lista = " "
		K_st_open_w.key1 = trim(string(kst_tab_listino.id)) // ID
		K_st_open_w.key2 = "" //trim(string(kst_tab_listino.cod_cli)) // cod cliente
		K_st_open_w.key3 = "" //trim(kst_tab_listino.cod_art) // cod articolo 
		K_st_open_w.flag_where = " "
		
		//kuf1_menu_window = create kuf_menu_window 
		kGuf_menu_window.open_w_tabelle(k_st_open_w)
		//destroy kuf1_menu_window
									
	else
	
		messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")
	
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try
end event

type cb_modifica from w_g_tab0`cb_modifica within w_listino_l
integer x = 1783
integer y = 1152
integer height = 96
integer taborder = 60
end type

event cb_modifica::clicked;//
long k_riga=0
st_tab_listino kst_tab_listino
st_open_w k_st_open_w
//kuf_menu_window kuf1_menu_window

try

	k_riga = dw_lista_0.getselectedrow(0)	
	if k_riga > 0 then
	
		kst_tab_listino.id = dw_lista_0.getitemnumber(k_riga, "id_listino") 
//		kst_tab_listino.cod_cli = kiuf_listino.get_cod_cli(kst_tab_listino)
//		kst_tab_listino.contratto = kiuf_listino.get_contratto(kst_tab_listino)
	
	//	kst_tab_listino.cod_cli = dw_lista_0.getitemnumber(k_riga, "cod_cli") 
	//	kst_tab_listino.cod_art = dw_lista_0.getitemstring(k_riga, "cod_art") 
	
	
	//
	//=== Parametri : 
	//=== struttura st_open_w
	//=== dati particolare programma
	//
		if dw_lista_0.dataobject = "d_clienti_listino_l" then
			K_st_open_w.id_programma = kiuf_listino.get_id_programma(kkg_flag_modalita.modifica) //kkg_id_programma_listini
		else
			K_st_open_w.id_programma = kkg_id_programma_listini2  //listini di servizio
		end if
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = kkg_flag_modalita.modifica
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
		K_st_open_w.flag_leggi_dw = " "
		K_st_open_w.flag_cerca_in_lista = " "
		K_st_open_w.key1 = trim(string(kst_tab_listino.id)) // ID
		K_st_open_w.key2 = "" //trim(string(kst_tab_listino.cod_cli)) // cod cliente
		K_st_open_w.key3 = "" //trim(kst_tab_listino.cod_art) // cod articolo 
		K_st_open_w.flag_where = " "
		
		//kuf1_menu_window = create kuf_menu_window 
		kGuf_menu_window.open_w_tabelle(k_st_open_w)
		//destroy kuf1_menu_window
									
	else
	
		messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")
	
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try
end event

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_listino_l
integer x = 1134
integer y = 1160
integer height = 96
integer taborder = 100
end type

type cb_cancella from w_g_tab0`cb_cancella within w_listino_l
integer x = 2121
integer y = 1164
integer height = 96
integer taborder = 70
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_listino_l
integer x = 1467
integer y = 1156
integer height = 96
integer taborder = 50
boolean enabled = false
end type

event cb_inserisci::clicked;//
long k_riga=0
st_tab_listino kst_tab_listino
st_open_w k_st_open_w
//kuf_menu_window kuf1_menu_window

try

	if dw_lista_0.dataobject = "d_clienti_listino_l" then
		if dw_lista_0.rowcount() > 0 then
		
			if dw_lista_0.getselectedrow(0) > 0 then
		
				kst_tab_listino.cod_cli = dw_lista_0.getitemnumber( dw_lista_0.getselectedrow(0), "cod_cli") 
			end if
			
		else
			kst_tab_listino.cod_cli = long(trim(ki_st_open_w.key1))
		end if
		
		if kst_tab_listino.cod_cli = 0 and dw_guida.rowcount() > 0 then	
			kst_tab_listino.cod_cli = dw_guida.getitemnumber(1, "id_cliente")
		end if
		K_st_open_w.id_programma = kiuf_listino.get_id_programma(kkg_flag_modalita.inserimento) //kkg_id_programma_listini
	else
		kst_tab_listino.cod_cli = 0
		K_st_open_w.id_programma = kkg_id_programma_listini2  //listini di servizio
	end if	
	//
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = "0" //trim(string(kst_tab_listino.id)) // ID
	K_st_open_w.key2 = trim(string(kst_tab_listino.cod_cli)) // cod cliente
	K_st_open_w.key3 = "" //trim(kst_tab_listino.cod_art) // cod articolo 
	K_st_open_w.flag_where = " "
	
	//kuf1_menu_window = create kuf_menu_window 
	kGuf_menu_window.open_w_tabelle(k_st_open_w)
	//destroy kuf1_menu_window
									
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try

return (0)
end event

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_listino_l
integer x = 37
integer y = 876
integer width = 827
integer height = 524
end type

on dw_dett_0::rbuttondown;call w_g_tab0`dw_dett_0::rbuttondown;//
//=== Scateno l'evento sulla window
parent.triggerevent("rbuttondown")

end on

on dw_dett_0::getfocus;////
//long k_id_vettore
//
////=== Verifico se ho gia' fatto almeno una retrieve o una insert
//if dw_dett_0.getrow() = 0 then
//	if cb_modifica.enabled = true then
//		cb_modifica.triggerevent("clicked")
//	else
//		cb_inserisci.triggerevent("clicked")
//	end if
//end if
//
////=== Controlla quali tasti attivare
//attiva_tasti()
//
//k_id_vettore = this.getitemnumber(1, "id_vettore")
////k_desc = this.getitemstring(1, "desc")
//
////=== Imposto valori di default se non ce ne sono
////if isnull(k_id_c_pag) = true or isnull(k_desc) = true or &
////	(trim(k_id_c_pag) = "" and &
////	 trim(k_desc) = "") then
////	setitem(1, "tipo", 1)
////	setitem(1, "scad_p", 1)
////end if
//
end on

type st_orizzontal from w_g_tab0`st_orizzontal within w_listino_l
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_listino_l
integer width = 2807
integer height = 708
string dataobject = "d_clienti_listino_l"
borderstyle borderstyle = stylelowered!
end type

event dw_lista_0::buttonclicked;call super::buttonclicked;//
string a
a=dwo.name
a=a
end event

type dw_guida from w_g_tab0`dw_guida within w_listino_l
event ue_itemchanged ( string k_nome,  string k_dato )
integer x = 32
integer y = 28
integer width = 2738
boolean enabled = true
string dataobject = "d_clienti_listino_guida"
end type

event dw_guida::ue_itemchanged(string k_nome, string k_dato);//
int k_errore=0
long k_riga
string k_rag_soc
st_stat_fatt kst_stat_fatt
st_tab_clienti kst_tab_clienti
kuf_clienti kuf1_clienti
datawindowchild kdwc_cliente, kdwc_prodotti

try
		
	choose case k_nome 
	
		case "rag_soc_1" 
			k_rag_soc = k_dato
			if LenA(k_rag_soc) > 0 then
				dw_guida.getchild("rag_soc_1", kdwc_cliente)
				if kdwc_cliente.rowcount() < 2 then
					kdwc_cliente.retrieve("%")
					kdwc_cliente.insertrow(1)
				end if
				k_riga=kdwc_cliente.find("upper(rag_soc_1) like '%"+upper(trim(k_rag_soc))+"%'",&
										0, kdwc_cliente.rowcount())
				if k_riga > 0 then
					dw_guida.setitem(1, "id_cliente",	kdwc_cliente.getitemnumber(k_riga, "id_cliente"))
					dw_guida.setitem(1, "rag_soc_1", 	trim(kdwc_cliente.getitemstring(k_riga, "rag_soc_1")))
				else
					dw_guida.setitem(1, "rag_soc_1","Non trovato")
					dw_guida.setitem(1, "id_cliente",0)
				end if
				k_errore = 1
			else
				dw_guida.setitem(1, "id_cliente",0)
			end if
	
		case "id_cliente" 
			if isnumber(k_dato) then
				kst_stat_fatt.k_id_cliente = long(k_dato)
				if kst_stat_fatt.k_id_cliente > 0 then
					dw_guida.getchild("rag_soc_1", kdwc_cliente)
					if kdwc_cliente.rowcount() < 2 then
						kdwc_cliente.retrieve("%")
						kdwc_cliente.insertrow(1)
					end if
					k_riga=kdwc_cliente.find("id_cliente = "+string(kst_stat_fatt.k_id_cliente)+" ", 0, kdwc_cliente.rowcount())
					if k_riga > 0 then
						dw_guida.setitem(1, "id_cliente",	kdwc_cliente.getitemnumber(k_riga, "id_cliente"))
						dw_guida.setitem(1, "rag_soc_1", trim(kdwc_cliente.getitemstring(k_riga, "rag_soc_1")))
					else
						dw_guida.setitem(1, "rag_soc_1","Nessun Listino caricato per questo cliente")
						dw_guida.setitem(1, "id_cliente",kst_stat_fatt.k_id_cliente)
					end if
					k_errore = 1
				else
					dw_guida.setitem(1, "id_cliente",0)
				end if
			end if
	
		case "e1an" 
			if isnumber(k_dato) then
				kuf1_clienti = create kuf_clienti
				kst_tab_clienti.e1an = long(k_dato)
				kst_stat_fatt.k_id_cliente = kuf1_clienti.get_codice_da_e1an(kst_tab_clienti)
				if kst_stat_fatt.k_id_cliente > 0 then
					dw_guida.getchild("rag_soc_1", kdwc_cliente)
					if kdwc_cliente.rowcount() < 2 then
						kdwc_cliente.retrieve("%")
						kdwc_cliente.insertrow(1)
					end if
					k_riga=kdwc_cliente.find("id_cliente = "+string(kst_stat_fatt.k_id_cliente)+" ", 0, kdwc_cliente.rowcount())
					if k_riga > 0 then
						dw_guida.setitem(1, "id_cliente",	kdwc_cliente.getitemnumber(k_riga, "id_cliente"))
						dw_guida.setitem(1, "rag_soc_1", trim(kdwc_cliente.getitemstring(k_riga, "rag_soc_1")))
					else
						dw_guida.setitem(1, "rag_soc_1","Nessun Listino caricato per questo cliente")
						dw_guida.setitem(1, "id_cliente",kst_stat_fatt.k_id_cliente)
					end if
					k_errore = 1
				else
					dw_guida.setitem(1, "id_cliente",0)
				end if
			end if
	
	//	case "e1ancodrs" 
	//		if isnumber(k_dato) then
	//			kst_stat_fatt.k_id_cliente = long(k_dato)
	//			if kst_stat_fatt.k_id_cliente > 0 then
	//				dw_guida.getchild("rag_soc_1", kdwc_cliente)
	//				if kdwc_cliente.rowcount() < 2 then
	//					kdwc_cliente.retrieve("%")
	//					kdwc_cliente.insertrow(1)
	//				end if
	//				k_riga=kdwc_cliente.find("id_cliente = "+string(kst_stat_fatt.k_id_cliente)+" ", 0, kdwc_cliente.rowcount())
	//				if k_riga > 0 then
	//					dw_guida.setitem(1, "id_cliente",	kdwc_cliente.getitemnumber(k_riga, "id_cliente"))
	//					dw_guida.setitem(1, "rag_soc_1", kdwc_cliente.getitemstring(k_riga, "rag_soc_1"))
	//				else
	//					dw_guida.setitem(1, "rag_soc_1","Nessun Listino caricato per questo cliente")
	//					dw_guida.setitem(1, "id_cliente",kst_stat_fatt.k_id_cliente)
	//				end if
	//				k_errore = 1
	//			else
	//				dw_guida.setitem(1, "id_cliente",0)
	//			end if
	//		end if
	
	
	
	end choose 
	
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally
	if isvalid(kuf1_clienti) then destroy kuf1_clienti
	
end try

	



end event

event dw_guida::ue_buttonclicked;call super::ue_buttonclicked;//---
boolean k_elabora=true
string k_dacercare


   k_dacercare = trim(dw_guida.getitemstring(1, "rag_soc_1"))
	ki_st_tab_listino.cod_cli = ki_st_tab_listino_arg.cod_cli
	ki_st_tab_listino_arg.cod_cli = 0

//   ki_st_tab_listino.cod_cli = dw_guida.getitemnumber(1, "id_cliente")
//   if isnull(  ki_st_tab_listino.cod_cli ) then
//      ki_st_tab_listino.cod_cli = 0
//   end if

//--- se cliente non trovato (quindi digitato ma il codice e' rimast a zero), non faccio la retrieve
	if ki_st_tab_listino.cod_cli = 0 and k_dacercare > " " then
			
		if isnumber(k_dacercare) then
			this.event ue_itemchanged( "id_cliente", k_dacercare)
		else
			if left(k_dacercare,2) = "E1" then
				this.event ue_itemchanged( "e1an", mid(k_dacercare,3))
			else
				this.event ue_itemchanged( "rag_soc_1", k_dacercare)
			end if		
		end if
		ki_st_tab_listino.cod_cli = dw_guida.getitemnumber(1, "id_cliente")
			
	end if

   if ki_st_tab_listino.cod_cli = 0 and k_dacercare > " " then
		dw_lista_0.reset( )
	else
//--- parte la query solo se ricerco un cliente diverso oppure listino NO-DOSE
      if ki_ultimo_clie_3_cercato <> ki_st_tab_listino.cod_cli or ki_mostra_nascondi_in_lista = "X" then
         
         ki_mostra_nascondi_in_lista = "*"

         ki_ultimo_clie_3_cercato = ki_st_tab_listino.cod_cli
         u_retrieve_dw_lista()
         u_retrieve_post()   
      end if
   end if

end event

event dw_guida::itemchanged;call super::itemchanged;//
//event ue_buttonclicked( )
//if isnumber(trim(data)) then
//	post event ue_itemchanged( "id_cliente", trim(data) )  //this.gettext()) )
//else
//	post event ue_itemchanged( "rag_soc_1", trim(data) )  //this.gettext()) )
//end if



end event

type dw_data from uo_d_std_1 within w_listino_l
integer x = 1829
integer y = 400
integer width = 827
integer height = 492
integer taborder = 80
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string title = "Scadenze dal"
string dataobject = "d_data"
boolean controlmenu = true
string icon = "Information!"
boolean hsplitscroll = false
boolean livescroll = false
end type

event buttonclicked;call super::buttonclicked;//
st_stampe kst_stampe
pointer oldpointer  // Declares a pointer variable

	
//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)
	

if dwo.name = "b_ok" then
	
	
	this.visible = false
	
	ki_data_scad  = this.getitemdate( 1, "kdata")
	inizializza()

else
	if dwo.name = "b_annulla" then

		this.visible = false
	
	
	end if
end if

SetPointer(oldpointer)


end event

event ue_visibile;call super::ue_visibile;//
int k_rc

	this.width = long(this.object.kdata.x) + long(this.object.kdata.width) + 100
	this.height = long(this.object.b_ok.y) + long(this.object.b_ok.height) + 160

	this.x = (kiw_this_window.width  - this.width) / 4
	this.y = (kiw_this_window.height - this.height) / 4

	this.reset()
	k_rc = this.insertrow(0)
	k_rc = this.setitem(1, "kdata", ki_data_scad)
	this.visible = true
	this.setfocus()
end event

type dw_box_duplica_listini from datawindow within w_listino_l
boolean visible = false
integer x = 2322
integer y = 848
integer width = 891
integer height = 692
integer taborder = 50
boolean bringtotop = true
boolean titlebar = true
string title = "DUPLICA LISTINI"
string dataobject = "d_box_duplica_listini"
boolean controlmenu = true
boolean border = false
string icon = "Information!"
end type

event buttonclicked;//
if dwo.name = "b_dup_singolo" then
	u_duplica( )
else
	if dwo.name = "b_dup_massiva" then
		u_duplica_massiva( )
	end if
end if
this.visible = false
end event

