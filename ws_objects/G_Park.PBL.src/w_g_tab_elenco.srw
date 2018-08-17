$PBExportHeader$w_g_tab_elenco.srw
forward
global type w_g_tab_elenco from w_g_tab
end type
type cb_visualizza from commandbutton within w_g_tab_elenco
end type
type cb_modifica from commandbutton within w_g_tab_elenco
end type
type cb_conferma from commandbutton within w_g_tab_elenco
end type
type cb_cancella from commandbutton within w_g_tab_elenco
end type
type cb_inserisci from commandbutton within w_g_tab_elenco
end type
type dw_lista_0 from uo_d_std_1 within w_g_tab_elenco
end type
type dw_lista_sel from datawindow within w_g_tab_elenco
end type
end forward

global type w_g_tab_elenco from w_g_tab
integer width = 2981
integer height = 1516
string title = "Elenco"
cb_visualizza cb_visualizza
cb_modifica cb_modifica
cb_conferma cb_conferma
cb_cancella cb_cancella
cb_inserisci cb_inserisci
dw_lista_0 dw_lista_0
dw_lista_sel dw_lista_sel
end type
global w_g_tab_elenco w_g_tab_elenco

type variables
//
private DataWindow  ki_dw_cerca
private datastore kdsi_elenco, kdsi_elenco_orig
private w_g_tab ki_window
private kuf_g_tab_elenco kiuf1_g_tab_elenco
private string ki_path_risorse = " "


//--- Attiva/disattiva il Drag & Drop....
public boolean ki_attiva_DRAGDROP = true // Abilitazione al DRAG&DROP
public long ki_riga_selected = 0
public long ki_riga_selected_sel = 0
public string ki_dragdrop_display = " "
private long ki_riga_dragwithin = 0
private long ki_clicked_row = 0
private long ki_clicked_row_sel = 0
private long ki_lbuttondown_row=0
private boolean ki_in_DRAG = false

//--- Serve per capire sto tenendo premuto il TASTO sx del MOUSE (senza CTRL) per alcuni istanti così da fare ad es. il DRAG&DROP
//private boolean ki_keyleftbutton=false
private time ki_keyleftbutton_ini 


end variables

forward prototypes
private function string cancella ()
private function integer posiz_window ()
protected subroutine inizializza_lista ()
protected subroutine attiva_tasti ()
public subroutine attiva_evento_in_win_origine ()
protected subroutine ordina_dw ()
private subroutine smista_funz (string k_par_in)
private function string inizializza ()
protected subroutine stampa ()
protected subroutine attiva_menu ()
protected subroutine leggi_liste ()
protected function graphicobject get_obj_trova ()
protected subroutine put_obj_trova ()
protected subroutine open_start_window ()
end prototypes

private function string cancella ();//
string k_return="0 "
//string k_desc
//string k_id_art
//string k_errore = "0 ", k_errore1 = "0 "
//long k_riga
//kuf_articoli  kuf1_articoli
//
//
////=== Controllo se sul dettaglio c'e' qualche cosa
//k_riga = dw_dett_0.rowcount()	
//if k_riga > 0 then
//	k_id_art = dw_dett_0.getitemstring(1, "id_art")
//	k_desc = dw_dett_0.getitemstring(1, "descrizione")
//end if
////=== Se sul dw non c'e' nessuna riga o nessun id_art allora pesco dalla lista
//if k_riga <= 0 or isnull(k_id_art) then
//	k_riga = dw_lista_0.getrow()	
//	if k_riga > 0 then
//		k_id_art = dw_lista_0.getitemstring(k_riga, "id_art")
//		k_desc = dw_lista_0.getitemstring(k_riga, "descrizione")
//	end if
//end if
//if k_riga > 0 and isnull(k_id_art) = false then	
//	if isnull(k_desc) = true or trim(k_desc) = "" then
//		k_desc = "Articolo senza Descrizione" 
//	end if
//	
////=== Richiesta di conferma della eliminazione del rek
//
//	if messagebox("Elimina Articolo", "Sei sicuro di voler Cancellare : ~n~r" + &
//				k_id_art + " " + trim(k_desc), &
//				question!, yesno!, 1) = 1 then
// 
////=== Creo l'oggetto che ha la funzione x cancellare la tabella
//		kuf1_articoli = create kuf_articoli
//		
////=== Cancella la riga dal data windows di lista
//		k_errore = kuf1_articoli.tb_delete(k_id_art) 
//		if left(k_errore, 1) = "0" then
//
//			k_errore = kuf1_data_base.db_commit()
//			if left(k_errore, 1) <> "0" then
//				messagebox("Problemi durante la Cancellazione !!", &
//						"Controllare i dati. " + mid(k_errore, 2))
//
//			else
//				
//				dw_dett_0.deleterow(k_riga)
//
//			end if
//
//			dw_dett_0.setfocus()
//
//		else
//			k_errore1 = k_errore
//			k_errore = kuf1_data_base.db_rollback()
//
//			messagebox("Problemi durante Cancellazione - Operazione fallita !!", &
//							mid(k_errore1, 2) ) 	
//			if left(k_errore, 1) <> "0" then
//				messagebox("Problemi durante il recupero dell'errore !!", &
//					"Controllare i dati. " + mid(k_errore, 2))
//			end if
//
//			attiva_tasti()
//	
//
//		end if
//
////=== Distruggo l'oggetto che ha avuto la funzione x cancellare la tabella
//		destroy kuf1_articoli
//
//	else
//		messagebox("Elimina Articolo", "Operazione Annullata !!")
//	end if
//
//	dw_dett_0.setcolumn(1)
//
//end if
//
return(k_return)
end function

private function integer posiz_window ();//
//=== Dimensiona la Window come la DW
//dw_dett_0.width = integer(dw_dett_0.Describe("id_merce.width")) + &
//               	integer(dw_dett_0.Describe("desc.width")) + 100	
//dw_dett_0.height = integer(dw_dett_0.Describe("id_merce.Height")) * 11 + 40 
//
//w_g_tab0.width = dw_dett_0.width + 42
//w_g_tab0.height = dw_dett_0.height + 100

//=== Posiziona Windows
if w_main.width > w_g_tab0.width then
	w_g_tab0.x = (w_main.width - w_g_tab0.width) / 2
else
	w_g_tab0.x = 1
end if
if w_main.height > w_g_tab0.height then
	w_g_tab0.y = (w_main.height - w_g_tab0.height) / 4
else
	w_g_tab0.y = 1
end if

return (0)

end function

protected subroutine inizializza_lista ();//
//=== Routine STANDARD
//=== Ritorna 0=ok 1=errore
//
int k_return=0
string k_inizializza, k_key
long k_riga_getrow
int k_importa=0

//=== se ho fatto una selezione su un determinato cliente (o rag soc che si assomigl.)
	k_key = trim(ki_st_open_w.key1)
	if isnull(k_key) or len(trim(k_key)) = 0 then
		k_key = ""
	end if

	ki_st_open_w.key1 = trim(k_key)

//=== Legge le righe del dw salvate l'ultima volta (importfile)
	if cb_ritorna.enabled = false then  //solo la prima volta il tasto e' false 

		k_key = trim(ki_st_open_w.key1) + trim(ki_st_open_w.key2) + trim(ki_st_open_w.key3) &
				  + trim(ki_st_open_w.key4) + trim(ki_st_open_w.key5)
		k_importa = kuf1_data_base.dw_importfile(k_key, dw_lista_0)

	end if
	
	if k_importa <= 0 then // Nessuna importazione eseguita

		k_inizializza = inizializza() //Reimposta i tasti e fa la retrieve di lista

	end if

	
//=== Se le INIZIALIZZA tornano con errore = 2 allora chiudo la windows	
	if left(k_inizializza,1) <> "2" then
		if left(k_inizializza,1) <> "1" then
			attiva_tasti()
		end if
//=== posizionamento sulla riga su cui ero
		if dw_lista_0.getrow() = 0 then
			if k_riga_getrow > dw_lista_0.rowcount() then
				k_riga_getrow = dw_lista_0.rowcount()
			end if
		else
			k_riga_getrow = dw_lista_0.getrow()
		end if

		dw_lista_0.setrow(k_riga_getrow)
		dw_lista_0.selectrow(0, false)
		if k_riga_getrow > 1 then
			dw_lista_0.selectrow(k_riga_getrow, true)
		end if
		dw_lista_0.scrolltorow(k_riga_getrow)
	
		
		if dw_lista_0.visible = true then
			dw_lista_0.setfocus()
		end if

	else
		cb_ritorna.postevent(clicked!)
	end if
	
	attiva_tasti()
	

//=== Disattivo flag di 'prima volta'
	if ki_st_open_w.flag_primo_giro = 'S' then
		ki_st_open_w.flag_primo_giro = ''
	end if



end subroutine

protected subroutine attiva_tasti ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================

long k_nr_righe

cb_ritorna.visible = false
//cb_inserisci.visible = false
cb_conferma.visible = false
//cb_modifica.visible = false
//cb_cancella.visible = false
//cb_visualizza.visible = false

cb_ritorna.enabled = true
//cb_inserisci.enabled = true
cb_conferma.enabled = true
//cb_modifica.enabled = false
//cb_cancella.enabled = false
//cb_visualizza.enabled = false

////=== Nr righe ne DW lista
//if dw_lista_0.getrow ( ) > 0 then
////	cb_modifica.enabled = true
////	cb_cancella.enabled = true
////	cb_visualizza.enabled = true
////	cb_visualizza.default = true
//end if

            
attiva_menu()

end subroutine

public subroutine attiva_evento_in_win_origine ();//
//--- richiama nella Windows chiamata (se ancora aperta) l'evento "u_ricevi_da_elenco"
int k_errore, k_rc
string k_key


//=== Valorizza l'oggetto DATASTORE per ritorno dei valori 
	destroy kdsi_elenco 
	kdsi_elenco = create datastore
	kdsi_elenco.dataobject = dw_lista_0.dataobject
	k_rc = dw_lista_0.rowscopy(1,dw_lista_0.rowcount(), &
											primary!,kdsi_elenco,1,primary!)
	ki_st_open_w.key12_any = kdsi_elenco
	
	if not isnull(ki_window) then
		
		if isvalid(ki_window) then
			ki_window.trigger event u_ricevi_da_elenco (ki_st_open_w)
		end if
		
	end if

end subroutine

protected subroutine ordina_dw ();//
//=== Possibilita' di filtrare su una colonna i valori richiesti
string k_x
datawindow kdw_1


	kdw_1 = dw_lista_0

	if kdw_1.rowcount() > 1 then
	
		setnull(k_x)
		kdw_1.setsort(k_x)
		kdw_1.SetRedraw (false)
		kdw_1.sort()
		kdw_1.SetRedraw (true)
		kdw_1.setfocus()
		
		attiva_tasti()
	end if


end subroutine

private subroutine smista_funz (string k_par_in);//===
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//=== Ritorna ...: 0=tutto OK; 1=Errore
//===


choose case left(k_par_in, 2) 

	case kkg_flag_richiesta_refresh		//Aggiorna Liste
		leggi_liste()

//	case "ag"		//Aggiorna Liste
//		inizializza()

	case kkg_flag_richiesta_inserimento		//richiesta inserimento
		if cb_inserisci.enabled = true then
			cb_inserisci.postevent(clicked!)
		end if

	case kkg_flag_richiesta_cancellazione		//richiesta cancellazione
		if cb_cancella.enabled = true then
			cb_cancella.postevent(clicked!)
		end if

	case kkg_flag_richiesta_conferma		//richiesta conferma
		if cb_conferma.enabled = true then
			cb_conferma.postevent(clicked!)
		end if

	case kkg_flag_richiesta_visualizzazione		//richiesta visualizz
		if cb_visualizza.enabled = true then
			cb_visualizza.postevent(clicked!)
		end if

	case kkg_flag_richiesta_modifica		//richiesta modifica
		if cb_modifica.enabled = true then
			cb_modifica.postevent(clicked!)
		end if

	case kkg_flag_richiesta_stampa		//richiesta stampa
		stampa()

	case kkg_flag_richiesta_esci		//richiesta uscita
		if cb_ritorna.enabled = true then
			cb_ritorna.postevent(clicked!)
		end if

	case else
		messagebox("Operazione non Eseguita", &
					"Funzione richiesta non Abilitata")


end choose


//return k_return

end subroutine

private function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Ritorna 1 chr : 0=Retrieve OK; 1 e 2=Retrieve fallita (2=uscita Window)
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
integer k_rc
long k_nr_rek, k_riga
kuf_utility kuf1_utility 
datastore ds_elenco

	
									
	k_nr_rek = dw_lista_0.rowcount() 
	
	if k_nr_rek < 1 then
		k_return = "1Nessuna Informazione trovata "

		messagebox("Elenco Dati Vuoto", &
			"Mi spiace, nessun dato trovato per la richiesta fatta ~n~r"  &
			 )

	else
		
//--- Inabilita campi alla modifica 
		kuf1_utility = create kuf_utility 
		kuf1_utility.u_dw_toglie_ddw(1, dw_lista_0)
		kuf1_utility.u_proteggi_dw("1", 0, dw_lista_0)
		destroy kuf1_utility 

//--- attiva i LINK standard
		dw_lista_0.triggerevent ("u_personalizza_dw")


		
	end if
		

return k_return



end function

protected subroutine stampa ();//
st_stampe kst_stampe

		
	kst_stampe.dw_print = dw_lista_0
	kst_stampe.titolo = trim(dw_lista_0.tag)

	kuf1_data_base.stampa_dw(kst_stampe)

end subroutine

protected subroutine attiva_menu ();//--- Attiva/Dis. Voci di menu
string k_lista, k_nome_controllo



//---
	super::attiva_menu()


//--- certi tasti sono attivi solo se dw e' di tipo elenco...
//	k_nome_controllo = kuf1_data_base.u_getfocus_nome()
//	choose case k_nome_controllo
//		case "dw_lista_0"
      	k_lista = dw_lista_0.Object.DataWindow.Processing
//		case "dw_dett_0"
//      	k_lista = dw_dett_0.Object.DataWindow.Processing
// end choose
//--- queste dovrebbero essere di tipo GRID...
	if k_lista = "1" then
		st_aggiorna_lista.enabled = true
	else
		st_aggiorna_lista.enabled  = false
	end if
	kG_menu.m_finestra.m_trova.enabled = st_aggiorna_lista.enabled 
	kG_menu.m_finestra.m_trova.m_fin_ordina.enabled = st_aggiorna_lista.enabled 
	kG_menu.m_finestra.m_trova.m_fin_cerca.enabled = st_aggiorna_lista.enabled 
	kG_menu.m_finestra.m_trova.m_fin_cercaancora.enabled = st_aggiorna_lista.enabled 
	kG_menu.m_finestra.m_trova.m_fin_filtra.enabled = st_aggiorna_lista.enabled 
	kG_menu.m_finestra.m_aggiornalista.enabled = st_aggiorna_lista.enabled 
	kG_menu.m_finestra.m_riordinalista.enabled = st_aggiorna_lista.enabled 

	
end subroutine

protected subroutine leggi_liste ();//
int k_rc


	dw_lista_0.reset()
	k_rc = kdsi_elenco_orig.rowscopy(1,kdsi_elenco_orig.rowcount(), &
													primary!,dw_lista_0,1,primary!)

		
	dw_lista_sel.visible = false
	dw_lista_sel.reset()


end subroutine

protected function graphicobject get_obj_trova ();//
//datawindow kdw_1
GraphicObject k_which_control
GraphicObject kany_1


//--- cerca il dw con il fuoco
	k_which_control = GetFocus()
	
	CHOOSE CASE TypeOf(k_which_control)
		CASE DataWindow!
			kany_1 = k_which_control
	
//--- se nessun dw ha il fuoco allora x default impostao il dw_lista
		CASE ELSE
			dw_lista_0.setfocus()
			kany_1 = dw_lista_0
	
	END CHOOSE


return kany_1

end function

protected subroutine put_obj_trova ();//

kiany_trova = dw_lista_0


end subroutine

protected subroutine open_start_window ();//
timer(0.5)

end subroutine

event rbuttondown;//
string k_stringa=""
long k_riga=0
string k_tag_old=""
string k_tag=""
m_popup m_menu



//=== Se sono sulla lista con il mouse allora posiziono il punt sul rek puntato

//=== Salvo il Tag attuale per reimpostarlo a fine routine
		k_tag_old = this.tag

//=== Creo menu Popup 
		m_menu = create m_popup

//		m_menu.m_lib_1.text = "Cerca"
//		m_menu.m_lib_1.visible = true
		m_menu.m_lib_1.text = kG_menu.m_strumenti.m_fin_gest_libero1.text 
		m_menu.m_lib_1.visible = kG_menu.m_strumenti.m_fin_gest_libero1.visible
		m_menu.m_lib_1.enabled = kG_menu.m_strumenti.m_fin_gest_libero1.enabled
		m_menu.m_t_lib_1.visible = m_menu.m_lib_1.visible
		m_menu.m_lib_2.text = kG_menu.m_strumenti.m_fin_gest_libero2.text 
		m_menu.m_lib_2.visible = kG_menu.m_strumenti.m_fin_gest_libero2.visible
		m_menu.m_lib_2.enabled = kG_menu.m_strumenti.m_fin_gest_libero2.enabled
		m_menu.m_t_lib_2.visible = m_menu.m_lib_2.visible
		m_menu.m_lib_3.text = kG_menu.m_strumenti.m_fin_gest_libero3.text 
		m_menu.m_lib_3.visible = kG_menu.m_strumenti.m_fin_gest_libero3.visible
		m_menu.m_lib_3.enabled = kG_menu.m_strumenti.m_fin_gest_libero3.enabled
		m_menu.m_t_lib_3.visible = m_menu.m_lib_3.visible
		m_menu.m_lib_4.text = kG_menu.m_strumenti.m_fin_gest_libero4.text 
		m_menu.m_lib_4.visible = kG_menu.m_strumenti.m_fin_gest_libero4.visible
		m_menu.m_lib_4.enabled = kG_menu.m_strumenti.m_fin_gest_libero4.enabled
		m_menu.m_t_lib_4.visible = m_menu.m_lib_4.visible

		m_menu.m_cerca.text = kG_menu.m_finestra.m_trova.m_fin_cerca.text 
		m_menu.m_cerca.visible = kG_menu.m_finestra.m_trova.m_fin_cerca.visible
		m_menu.m_cerca.enabled = kG_menu.m_finestra.m_trova.m_fin_cerca.enabled
		m_menu.m_t_cerca.visible = m_menu.m_cerca.visible

		m_menu.m_inserisci.visible = cb_inserisci.enabled
		m_menu.m_modifica.visible = cb_modifica.enabled
		m_menu.m_t_modifica.visible = cb_modifica.enabled
		m_menu.m_cancella.visible = cb_cancella.enabled
		m_menu.m_t_cancella.visible = cb_cancella.enabled
		m_menu.m_visualizza.visible = cb_visualizza.enabled

		m_menu.m_agglista.visible = true
		m_menu.m_t_agglista.visible = true
		if dw_lista_0.rowcount() > 0 then //or dw_filtra.rowcount() > 0 then
			m_menu.m_filtro.visible = true
			m_menu.m_t_filtro.visible = false
		end if
		m_menu.m_stampa.visible = false
		m_menu.m_t_stampa.visible = false
		m_menu.m_conferma.visible = cb_conferma.enabled
		m_menu.m_ritorna.visible = true

//=== Attivo il menu Popup
		m_menu.visible = true
		m_menu.popmenu(this.x + pointerx(), this.y + pointery())
		m_menu.visible = false

		destroy m_menu

		k_tag = this.tag 

		this.tag = k_tag_old 

		if trim(k_tag) <> "" then
			smista_funz(k_tag)
		end if
		


end event

event closequery;//
//=== Controllo prima della chiusura della Windows
int k_errore, k_rc
string k_key
w_g_tab k_window


	cb_ritorna.enabled = false


//=== Salva le righe del dw (saveas)
	k_key = trim(ki_st_open_w.key1)+trim(ki_st_open_w.key2)+trim(ki_st_open_w.key3)&
			  +trim(ki_st_open_w.key4)+trim(ki_st_open_w.key5)+trim(ki_st_open_w.key6)&
			  +trim(ki_st_open_w.key7)+trim(ki_st_open_w.key8)+trim(ki_st_open_w.key9)+trim(ki_st_open_w.key10)
	kuf1_data_base.dw_saveas(trim(k_key), dw_lista_0)


//=== Valorizza l'oggetto DATASTORE per ritorno dei valori 
	destroy kdsi_elenco 
	kdsi_elenco = create datastore
	k_rc = dw_lista_0.rowscopy(1,dw_lista_0.rowcount(), &
											primary!,kdsi_elenco,1,primary!)
											
	ki_st_open_w.key12_any = kdsi_elenco

	

//	Message.PowerObjectParm	= ki_st_open_w



end event

event open;call super::open;//
//----------------------------------------------------------------
//--- Window utilizzata per Elenco Valori d scelta 
//--- in alternativa alla DROP-DATAWINDOWS
//----
//--- Parametri richiesti:
//--- KEY1 = Titolo di questa Window di "elenco/anteprima"
//--- KEY2 = nome data-window x l'elenco
//--- KEY3 = non usare in input: ritorna il numero di RIGA cliccato
//--- KEY4 = Titolo della Windows chiamante
//--- KEY5 = non usare in input: riservato
//--- KEY6 = nome campo che ha scatenato la chiamata a questo elenco
//--- KEY7 = flag di chiusura della Window dopo il DOPPIO CLICK di scelta (S=chiudi)
//--- KEY12_DW = reference data window dell'elenco valorizzato probabilmente con la RETRIEVE
//---
//--- Torna:
//--- KEY3 = numero della riga scelta dall'elenco
//---        0 = nessuna riga scelta
//--- KEY5 = nome campo che ha scatenato la chiamata a questo elenco
//----------------------------------------------------------------
//
int k_rc
kuf_utility kuf1_utility


//=== Parametri passati con il WITHPARM
	ki_st_open_w = message.powerobjectparm


	ki_st_open_w.key3 = " "
	
	ki_nome_save =  trim(ki_st_open_w.key2)
	set_window_size()

//--- setta la directory di base
	kuf1_data_base.setta_path_default ()

//--- setta il titolo della window
	if len(trim(ki_st_open_w.key1)) > 0 then
		ki_st_open_w.window_title = trim(ki_st_open_w.key1)
	end if
	set_titolo_window()


//=== Imposta il titolo della wind. nella dw x la desc. in una eventuale stampa
	dw_lista_0.tag = this.title
	
	
//--- path per reperire le ico del drag e drop
	ki_path_risorse = trim(kuf1_data_base.profilestring_leggi_scrivi(1, "arch_graf", " "))
	
	if ki_utente_abilitato then

		kiuf1_g_tab_elenco = create kuf_g_tab_elenco

//--- Individua la Window di provenienza
		ki_window = kuf1_data_base.prendi_win_x_uguale_titolo(ki_st_open_w.key4)
		
//--- Popolo l'elenco dal datastore passato
		kdsi_elenco = create datastore
		kdsi_elenco.dataobject = trim(ki_st_open_w.key2)
		kdsi_elenco_orig = create datastore
		kdsi_elenco_orig.dataobject = trim(ki_st_open_w.key2)
		k_rc = kdsi_elenco.settransobject ( sqlca )
		
		dw_lista_0.dataobject = trim(ki_st_open_w.key2)
		dw_lista_0.settransobject ( sqlca )

		dw_lista_sel.dataobject = trim(ki_st_open_w.key2)
		dw_lista_sel.settransobject ( sqlca )
		
		kdsi_elenco = ki_st_open_w.key12_any
		k_rc = kdsi_elenco.rowscopy(1, kdsi_elenco.rowcount(), primary!,kdsi_elenco_orig,1,primary!)

		leggi_liste()		
		
		post inizializza_lista()
	
	end if

//dw_dett_0.setrowfocusindicator ( Hand! )


end event

on w_g_tab_elenco.create
int iCurrent
call super::create
this.cb_visualizza=create cb_visualizza
this.cb_modifica=create cb_modifica
this.cb_conferma=create cb_conferma
this.cb_cancella=create cb_cancella
this.cb_inserisci=create cb_inserisci
this.dw_lista_0=create dw_lista_0
this.dw_lista_sel=create dw_lista_sel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_visualizza
this.Control[iCurrent+2]=this.cb_modifica
this.Control[iCurrent+3]=this.cb_conferma
this.Control[iCurrent+4]=this.cb_cancella
this.Control[iCurrent+5]=this.cb_inserisci
this.Control[iCurrent+6]=this.dw_lista_0
this.Control[iCurrent+7]=this.dw_lista_sel
end on

on w_g_tab_elenco.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_visualizza)
destroy(this.cb_modifica)
destroy(this.cb_conferma)
destroy(this.cb_cancella)
destroy(this.cb_inserisci)
destroy(this.dw_lista_0)
destroy(this.dw_lista_sel)
end on

event key;//
//=== Controllo quale tasto da tastiera ha premuto

//--- chiudo finestra se sono in visualizzazione
//	if key = keyescape! and ki_st_open_w.flag_modalita = "vi" then
//		smista_funz("ri")
//	end if
//

end event

event resize;//---
	
	if ki_st_open_w.flag_adatta_win = KK_ADATTA_WIN then

		this.setredraw(false)

		if dw_lista_0.visible = true then
			
//=== Dimensione dw nella window 
         dw_lista_0.height = this.height - 180
			dw_lista_0.width = this.width - 80


			if cb_ritorna.visible = true then
				
				dw_lista_0.height = this.height - cb_ritorna.height * 1.5 - 150
				cb_ritorna.y = this.height - cb_ritorna.height * 1.5 - 75
				cb_conferma.y = this.height - cb_conferma.height * 1.5 - 75
				cb_cancella.y = this.height - cb_cancella.height * 1.5 - 75
				cb_inserisci.y = this.height - cb_inserisci.height * 1.5 - 75
				cb_ritorna.x = this.width - cb_ritorna.width - 50
				cb_cancella.x = cb_ritorna.x - cb_cancella.width - 50
				cb_conferma.x = cb_cancella.x - cb_conferma.width - 50
				cb_inserisci.x = cb_conferma.x - cb_inserisci.width - 50
			end if
	
		end if

	
//=== Posiziona dw nella window 
		dw_lista_0.x = (this.width - dw_lista_0.width) / 4
		dw_lista_0.y = (this.height - dw_lista_0.height) / 7
		
//=== Dimensione e Posizione dw di selezione nella window 
		dw_lista_sel.height = dw_lista_0.height * 0.70
		dw_lista_sel.width = dw_lista_0.width * 0.30
		dw_lista_sel.x = (this.width - dw_lista_sel.width) - 45
		dw_lista_sel.y = dw_lista_0.y + 30
		
		this.setredraw(true)
		
	end if
//end if




end event

event close;call super::close;//
if isvalid(kiuf1_g_tab_elenco) then destroy kiuf1_g_tab_elenco

end event

event timer;call super::timer;//
	if keydown(keyleftbutton!)  and not  keydown(keycontrol!) then
		if SecondsAfter (  ki_keyleftbutton_ini,  now() ) >= 1 then   //se premuto x almeno 1 secondo allora attivo il DRAG&DROP
			ki_in_DRAG = true
		end if
	end if


end event

type st_aggiorna_lista from w_g_tab`st_aggiorna_lista within w_g_tab_elenco
integer x = 1961
integer y = 1140
end type

type cb_ritorna from w_g_tab`cb_ritorna within w_g_tab_elenco
integer x = 2523
integer y = 1088
integer width = 329
integer height = 88
end type

type st_stampa from w_g_tab`st_stampa within w_g_tab_elenco
integer x = 1961
integer y = 1012
end type

type st_ritorna from w_g_tab`st_ritorna within w_g_tab_elenco
integer x = 1929
integer y = 836
end type

type dw_trova from w_g_tab`dw_trova within w_g_tab_elenco
integer y = 108
end type

type dw_filtra from w_g_tab`dw_filtra within w_g_tab_elenco
integer x = 1221
integer y = 320
end type

type cb_visualizza from commandbutton within w_g_tab_elenco
boolean visible = false
integer x = 2528
integer y = 644
integer width = 329
integer height = 88
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Visualizza"
boolean default = true
end type

event clicked;////
////
////=== Legge il rek dalla DW lista per la modifica
//long k_riga
//string k_key
//string k_errore="0 "
//
//
////=== Abilito la DW Dettaglio se disabilitata (x il giro di prima volta)
//if dw_dett_0.enabled = false then
//	dw_dett_0.enabled = true
//else
////=== Controllo se ho modificato dei dati nella DW DETTAGLIO
//	if left(dati_modif(), 1) = "1" then //Fare gli aggiornamenti
//
////=== Controllo congruenza dei dati caricati e Aggiornamento  
////=== Ritorna 1 char : 0=tutto OK; 1=errore grave;
////===                : 2=errore non grave dati aggiornati;
////===			         : 3=
////===      il resto della stringa contiene la descrizione dell'errore   
//		k_errore = aggiorna_dati()
//
//	end if
//end if
//
//
//	if left(k_errore, 1) = "0" then
//
//		dw_dett_0.reset()
//
//		if dw_lista_0.getrow() > 0 then
//			
//			if visualizza() > 0 then
//
//				attiva_tasti()
//	
//				dw_dett_0.setfocus()		
//
//			else
//
//				messagebox("Operazione Fallita", "Mi spiace, ma dati non trovati in archivio~n~r" +&
//							"Provare a riaggiornare la lista scegliendo da menu :~n~r" + &
//							"'Finestra -> Aggiorna lista'")
//
//			end if
//
//			
//		end if
//
//	end if
//
//
end event

type cb_modifica from commandbutton within w_g_tab_elenco
boolean visible = false
integer x = 2528
integer y = 868
integer width = 329
integer height = 88
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Modifica"
end type

event clicked;////
////
////=== Legge il rek dalla DW lista per la modifica
//long k_riga
//string k_key
//string k_errore="0 "
//
//
////=== Abilito la DW Dettaglio se disabilitata (x il giro di prima volta)
//if dw_dett_0.enabled = false then
//	dw_dett_0.enabled = true
//else
////=== Controllo se ho modificato dei dati nella DW DETTAGLIO
//	if left(dati_modif(), 1) = "1" then //Fare gli aggiornamenti
//
////=== Controllo congruenza dei dati caricati e Aggiornamento  
////=== Ritorna 1 char : 0=tutto OK; 1=errore grave;
////===                : 2=errore non grave dati aggiornati;
////===			         : 3=
////===      il resto della stringa contiene la descrizione dell'errore   
//		k_errore = aggiorna_dati()
//
//	end if
//end if
//
//
//	if left(k_errore, 1) = "0" then
//
//		dw_dett_0.reset()
//
//		if dw_lista_0.getrow() > 0 then
//			
//			if modifica() > 0 then
//
//				attiva_tasti()
//	
//				dw_dett_0.setfocus()		
//
//			else
//
//				messagebox("Operazione Fallita", "Mi spiace, ma dati non trovati in archivio~n~r" +&
//							"Provare a riaggiornare la lista scegliendo da menu :~n~r" + &
//							"'Finestra -> Aggiorna lista'")
//
//			end if
//
//			
//		end if
//
//	end if
//
//
end event

type cb_conferma from commandbutton within w_g_tab_elenco
boolean visible = false
integer x = 110
integer y = 1228
integer width = 329
integer height = 88
integer taborder = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Seleziona"
end type

event clicked;//
//=== Conferma la riga da importare
long k_riga


k_riga = dw_lista_0.getrow() 

if dw_lista_0.getrow() > 0 then

	dw_lista_0.setfocus()
	
	ki_st_open_w.key3 = string(k_riga)

//--- invia la riga selezionata alla windows che ha chiamato l'elenco	
	attiva_evento_in_win_origine()


	if ki_st_open_w.key7 = "S" then

		cb_ritorna.triggerevent( clicked! )
		
	else
//--- mette la riga nella finestrella dei selzionati solo se sono + di 1
		if dw_lista_0.rowcount() > 1 then
			
			ki_riga_selected=k_riga
			dw_lista_sel.triggerevent("ue_aggiungi_riga")

//			dw_lista_0.rowscopy(k_riga, k_riga, primary!,dw_lista_sel,1,primary!)
//			dw_lista_sel.visible = true
//			dw_lista_0.deleterow(k_riga)
	
		end if

		attiva_tasti()

	end if

else
	
	messagebox("Elenco Dati", &
					"Selezionare una riga dall'elenco. ")

end if

end event

type cb_cancella from commandbutton within w_g_tab_elenco
boolean visible = false
integer x = 2528
integer y = 756
integer width = 329
integer height = 88
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Elimina"
end type

event clicked;//
cancella()
end event

type cb_inserisci from commandbutton within w_g_tab_elenco
boolean visible = false
integer x = 2528
integer y = 532
integer width = 329
integer height = 88
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Nuovo"
end type

event clicked;////
////=== 
//string k_errore
//
//
//dw_dett_0.accepttext()
//
//
//k_errore = left(dati_modif(), 1)
//
////=== Controllo se ho modificato dei dati nella DW DETTAGLIO
//if k_errore = "1" then //Fare gli aggiornamenti
//
////=== Ritorna 1 char: 0=Tutto OK; 1=Errore grave; 
////===	              : 2=Errore Non grave dati aggiornati
////===               : 3=
//	k_errore = aggiorna_dati()		
//
//else
//
//	if k_errore = "2" then //Aggiornamento non richiesto
//		k_errore = "0"
//	end if
//
//end if
//
//if left(k_errore, 1) = "0" then 
//	inserisci()
//end if
//
end event

type dw_lista_0 from uo_d_std_1 within w_g_tab_elenco
event ue_lbuttondown pbm_lbuttondown
event ue_lbuttonup pbm_lbuttonup
event ue_lbuttonup_post ( )
event ue_dragleave_post ( )
event ue_aggiungi_riga ( )
event ue_drag_out ( )
event ue_dwnmousemove pbm_dwnmousemove
integer x = 110
integer y = 28
integer height = 1156
integer taborder = 110
boolean vscrollbar = true
end type

event ue_lbuttondown;//
long k_ctr
long k_Height

if ki_attiva_DRAGDROP then
	if isnumber(this.Describe("#1.Height")) then
		k_Height = long(this.Describe("#1.Height"))
	
		if ypos > k_Height then
		
			ki_riga_selected=0	
			ki_lbuttondown_row = this.getrow()
	
		end if
	end if
end if

end event

event ue_lbuttonup;//

	if ki_attiva_DRAGDROP then
		this.triggerevent ("ue_lbuttonup_post")
	end if
end event

event ue_lbuttonup_post();//
//	st_barcode.visible = false
	ki_lbuttondown_row = 0
	ki_in_DRAG = false		 
	this.drag(end!)

end event

event ue_dragleave_post();//

if ki_attiva_DRAGDROP then
	
	ki_riga_selected= 0
	this.selectrow( 0, false )

	THIS.Drag(cancel!)
	ki_in_DRAG = false		 

	//st_barcode.visible = false

end if

end event

event ue_aggiungi_riga();//
//--- aggiunge riga 
//
dw_lista_sel.rowscopy ( ki_riga_selected_sel, ki_riga_selected_sel,Primary!, this, 1,Primary!)
dw_lista_sel.deleterow( ki_riga_selected_sel )






end event

event ue_drag_out();//
if ki_in_DRAG and cb_conferma.enabled = true then 
	ki_st_open_w.key5 = " " //--- nessun pulsante pigiato
	cb_conferma.triggerevent(clicked!)
end if


end event

event ue_dwnmousemove;//
//---- Muove il mouse con il tasto left premuto
//

if ki_in_DRAG and ki_attiva_DRAGDROP then

	if keydown(keyleftbutton!)  and not  keydown(keycontrol!) then
	
	//--- se tasto ESC provo l'undo
		if keydown(KeyESCape!) then
	
	//--- chiude eventuali DRAG & DROP
	//		st_barcode.visible = false
			this.Drag(cancel!)
			ki_in_DRAG = false		 
			if ki_clicked_row > 0 then
				this.scrolltorow(ki_clicked_row)
			end if
			ki_clicked_row= 0
			this.selectrow( 0, false )
			
		else
			
			if this.getselectedrow(0) > 0 then
		
				this.dragicon = ki_path_risorse + "\drag1.ico"
					
				ki_in_DRAG = true		 
				this.drag(begin!)
			end if
		end if
	end if
	
end if


end event

event doubleclicked;//
if row < 1 then
	return 1
end if
if cb_conferma.enabled = true then 
	ki_st_open_w.key5 = " " //--- nessun pulsante pigiato
	cb_conferma.triggerevent(clicked!)
end if


end event

event dragwithin;call super::dragwithin;boolean k_piu_righe = false
string k_alla_riga = ""
long k_last_row = 0, k_first_row=0



if ki_attiva_DRAGDROP then

	
	//	this.dragicon = ki_path_risorse + "\drag1.ico"
	//	source = this
	
	
	if row = 0 then
	
	//	st_barcode.visible = false
//		this.drag(cancel!)
	
	else
		ki_riga_selected = this.getselectedrow(0)
		if ki_riga_selected <= 0 then
			this.selectrow(row, true)	
			ki_riga_selected = row
			ki_dragdrop_display = "Riga: " + string(row) //string(this.getitemnumber(ki_riga_selected, "ordine")) +"-"+ trim(this.getitemstring(ki_riga_selected, "barcode")) 
		else
			if this.getselectedrow(ki_riga_selected) > 0 then
				 k_piu_righe = true
			end if
		end if
		
		k_last_row = long(this.Object.DataWindow.LastRowOnPage) - 2
		if row > k_last_row  then
			this.scrolltorow(k_last_row + 3) 
		else
			k_first_row = long(this.Object.DataWindow.FirstRowOnPage) + 2
			if row < k_first_row  and row > 2 then
				this.scrolltorow(k_first_row - 3) 
			end if
		end if
	
		//---- se sono piu' di 1 riga da drag allora multi-drag	
		if k_piu_righe  then
			this.dragicon = ki_path_risorse + "\drag2.ico" 
		else		
			this.dragicon = ki_path_risorse + "\drag1.ico"
		end if
		
		if row > 0 and ki_riga_selected <> row then
		
			if ki_riga_dragwithin > 0 then
	//			this.setitem(ki_riga_dragwithin, "k_su_drop", "0")
			end if
			ki_riga_dragwithin = row
			if this.IsSelected( row ) then
				k_alla_riga = " ??? "
			else
				k_alla_riga =   "   > "+ string(row)
			end if
		
	//		st_barcode.x = parent.pointerx() +50
	//		st_barcode.y = parent.pointery() + 50
			if k_piu_righe then
	//			st_barcode.text = " " + ki_dragdrop_display + "....." + k_alla_riga
			else
	//			st_barcode.text = " " +  ki_dragdrop_display + k_alla_riga  
			end if
	//		st_barcode.visible = true
		
		end if
	end if
end if
	
	

end event

event losefocus;call super::losefocus;////
//
//if ki_attiva_DRAGDROP then 
//
////	st_barcode.visible = false
////	ki_dragdrop = false
//	this.drag(cancel!)
//	ki_in_DRAG = false		 
//	ki_riga_selected = 0	
//
//end if
//
end event

event rowfocuschanging;call super::rowfocuschanging;//

if ki_in_DRAG and ki_attiva_DRAGDROP then 
	
	if (keydown(KeyDownArrow!) or keydown(KeyUpArrow!)) then
		if  keydown(keyshift!) then 
			if this.IsSelected( newrow ) then
				if currentrow <> ki_clicked_row then
					if currentrow <> newrow then
						this.selectrow( currentrow, false )
					end if
				end if
			else
				this.selectrow( newrow, True )
			end if
		else
			this.selectrow( 0, false )
			this.selectrow( newrow, True )
			ki_clicked_row = newrow
			
		end if
	end if
end if

end event

event dragleave;call super::dragleave;////
//	if ki_attiva_DRAGDROP then 
//
//		this.triggerevent ("ue_dragleave_post")
//
//	end if
//		
//		
end event

event dragdrop;call super::dragdrop;//
datawindow kdw_1
string k_nome


//st_barcode.visible = false

if ki_attiva_DRAGDROP then

	if not this.IsSelected( row ) then 
		
		CHOOSE CASE TypeOf(source)
		
			CASE datawindow!
		
				kdw_1 = source
				kdw_1.Drag(cancel!)
				ki_in_DRAG = false		 
				
				choose case kdw_1.classname()
						
					case "dw_lista_sel" 
						this.postevent( "ue_aggiungi_riga")
		
				end choose
				
				
		END CHOOSE
	
	end if

end if




end event

event ue_dwnkey;call super::ue_dwnkey;//
	if keydown(keyleftbutton!)  and not  keydown(keycontrol!) then
		ki_keyleftbutton_ini = now()
	end if
end event

type dw_lista_sel from datawindow within w_g_tab_elenco
event ue_lbuttondown pbm_lbuttondown
event ue_lbuttonup pbm_lvnbegindrag
event ue_lbuttonup_post ( )
event ue_dragleave_post ( )
event ue_dwnmousemove pbm_dwnmousemove
event ue_aggiungi_riga ( )
boolean visible = false
integer x = 1833
integer width = 800
integer height = 996
integer taborder = 110
boolean bringtotop = true
boolean titlebar = true
string title = "righe selezionate"
string dataobject = "d_nulla"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean vscrollbar = true
boolean resizable = true
boolean border = false
boolean livescroll = true
end type

event ue_lbuttondown;//
long k_ctr
long k_Height

if ki_attiva_DRAGDROP then
	if isnumber(this.Describe("#1.Height")) then
		k_Height = long(this.Describe("#1.Height"))
	
		if ypos > k_Height then
		
			ki_riga_selected=0	
			ki_lbuttondown_row = this.getrow()
	
		end if
	end if
end if

end event

event ue_lbuttonup;//

	if ki_attiva_DRAGDROP then
		this.triggerevent ("ue_lbuttonup_post")
	end if
end event

event ue_lbuttonup_post();//
//	st_barcode.visible = false
	ki_lbuttondown_row = 0
	ki_in_DRAG = false		 
	this.drag(end!)

end event

event ue_dragleave_post();////
//
//if ki_attiva_DRAGDROP then
//	
//	ki_riga_selected_sel= 0
//	this.selectrow( 0, false )
//	ki_dragdrop = false
//	THIS.Drag(cancel!)
//	//st_barcode.visible = false
//
//end if
//
end event

event ue_dwnmousemove;//
//---- Muove il mouse con il tasto left premuto
//

if ki_in_DRAG and ki_attiva_DRAGDROP then

	if keydown(keyleftbutton!)  and not  keydown(keycontrol!) then
	
	//--- se tasto ESC provo l'undo
		if keydown(KeyESCape!) then
	
	//--- chiude eventuali DRAG & DROP
	//		st_barcode.visible = false
			this.Drag(cancel!)
			ki_in_DRAG = false		 
			
			if ki_clicked_row_sel > 0 then
				this.scrolltorow(ki_clicked_row_sel)
			end if
			ki_clicked_row_sel= 0
			this.selectrow( 0, false )
			
		else
			
			if this.getselectedrow(0) > 0 then
		
				this.dragicon = ki_path_risorse + "\drag1.ico"
					
				this.drag(begin!)
				ki_in_DRAG = true 
			end if
		end if
	end if
end if

end event

event ue_aggiungi_riga();//
//--- aggiunge riga 
//
//long k_riga



//k_riga = this.insertrow(1)
dw_lista_0.rowscopy ( ki_riga_selected, ki_riga_selected,Primary!, this, 1,Primary!)
dw_lista_0.deleterow( ki_riga_selected )
this.visible = true


end event

event dragwithin;//
boolean k_piu_righe = false
string k_alla_riga = ""
long k_last_row = 0, k_first_row=0



if ki_attiva_DRAGDROP then

	
	//	this.dragicon = ki_path_risorse + "\drag1.ico"
	//	source = this
	
	
	if row = 0 then
	
	//	st_barcode.visible = false
//		this.drag(cancel!)
	
	else
		
		
//		CHOOSE CASE TypeOf(source)
//		
//			CASE datawindow!
//		
//				kdw_1 = source
//				kdw_1.Drag(cancel!)
// 				ki_in_DRAG = false		 
//				choose case kdw_1.classname()
//						
//					case "dw_lista_0" 
//						this.triggerevent( "e_aggiungi_riga")
//		
//				end choose
//				
//				
//		END CHOOSE
	
		
		ki_riga_selected_sel = this.getselectedrow(0)
		if ki_riga_selected_sel <= 0 then
			this.selectrow(row, true)	
			ki_riga_selected_sel = row
			ki_dragdrop_display = "Riga: " + string(row) //string(this.getitemnumber(ki_riga_selected, "ordine")) +"-"+ trim(this.getitemstring(ki_riga_selected, "barcode")) 
		else
			if this.getselectedrow(ki_riga_selected_sel) > 0 then
				 k_piu_righe = true
			end if
		end if
		
		k_last_row = long(this.Object.DataWindow.LastRowOnPage) - 2
		if row > k_last_row  then
			this.scrolltorow(k_last_row + 3) 
		else
			k_first_row = long(this.Object.DataWindow.FirstRowOnPage) + 2
			if row < k_first_row  and row > 2 then
				this.scrolltorow(k_first_row - 3) 
			end if
		end if
	
		//---- se sono piu' di 1 riga da drag allora multi-drag	
		if k_piu_righe  then
			this.dragicon = ki_path_risorse + "\drag2.ico" 
		else		
			this.dragicon = ki_path_risorse + "\drag1.ico"
		end if
		
		if row > 0 and ki_riga_selected_sel <> row then
		
			if ki_riga_dragwithin > 0 then
	//			this.setitem(ki_riga_dragwithin, "k_su_drop", "0")
			end if
			ki_riga_dragwithin = row
			if this.IsSelected( row ) then
				k_alla_riga = " ??? "
			else
				k_alla_riga =   "   > "+ string(row)
			end if
		
	//		st_barcode.x = parent.pointerx() +50
	//		st_barcode.y = parent.pointery() + 50
			if k_piu_righe then
	//			st_barcode.text = " " + ki_dragdrop_display + "....." + k_alla_riga
			else
	//			st_barcode.text = " " +  ki_dragdrop_display + k_alla_riga  
			end if
	//		st_barcode.visible = true
		
		end if
	end if
end if
	
	

end event

event losefocus;////
//
//if ki_attiva_DRAGDROP then 
//
////	st_barcode.visible = false
////					ki_in_DRAG = false		 
//	this.drag(cancel!)
//	ki_riga_selected_sel = 0	
//
//end if
//
end event

event rowfocuschanging;//

if	ki_in_DRAG and ki_attiva_DRAGDROP then 
	if (keydown(KeyDownArrow!) or keydown(KeyUpArrow!)) then
		if  keydown(keyshift!) then 
			if this.IsSelected( newrow ) then
				if currentrow <> ki_clicked_row_sel then
					if currentrow <> newrow then
						this.selectrow( currentrow, false )
					end if
				end if
			else
				this.selectrow( newrow, True )
			end if
		else
			this.selectrow( 0, false )
			this.selectrow( newrow, True )
			ki_clicked_row_sel = newrow
			
		end if
	end if
end if

end event

event dragleave;//
	if ki_attiva_DRAGDROP then 

		this.triggerevent ("ue_dragleave_post")

	end if
		
		
end event

event dragdrop;//
datawindow kdw_1
string k_nome


//st_barcode.visible = false

if ki_attiva_DRAGDROP then

//	if not this.IsSelected( row ) then 
		
		CHOOSE CASE TypeOf(source)
		
			CASE datawindow!
		
				kdw_1 = source
				kdw_1.Drag(cancel!)
				ki_in_DRAG = false		 
		 
				choose case kdw_1.classname()
						
					case "dw_lista_0" 
						this.postevent( "ue_aggiungi_riga")
		
				end choose
				
				
		END CHOOSE
	
//	end if

end if

end event

event clicked;//
long i=0


if ki_clicked_row_sel > 0 then
	
	if keydown(keyshift!) then
		if ki_clicked_row_sel > row then
			for i = row to ki_clicked_row_sel
				this.selectrow( i, True )
			end for			
		else
			for i = ki_clicked_row_sel to row  
				this.selectrow( i, True )
			end for			
		end if
	else
		if not keydown(KeyControl!) then
			this.selectrow( 0, false )
			this.selectrow( row, True )
		else
			if this.isselected( row ) then
				this.selectrow( row, false )
			else
				this.selectrow( row, true )
			end if
		end if
	end if
else
	this.selectrow( row, true )
end if

ki_clicked_row_sel = row

this.setrow( row )


end event

