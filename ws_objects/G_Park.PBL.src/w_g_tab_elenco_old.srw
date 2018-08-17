$PBExportHeader$w_g_tab_elenco_old.srw
forward
global type w_g_tab_elenco_old from w_g_tab
end type
type cb_visualizza from commandbutton within w_g_tab_elenco_old
end type
type cb_modifica from commandbutton within w_g_tab_elenco_old
end type
type cb_conferma from commandbutton within w_g_tab_elenco_old
end type
type cb_cancella from commandbutton within w_g_tab_elenco_old
end type
type cb_inserisci from commandbutton within w_g_tab_elenco_old
end type
type tab_1 from tab within w_g_tab_elenco_old
end type
type tabpage_1 from userobject within tab_1
end type
type dw_1 from uo_d_std_1 within tabpage_1
end type
type st_1_retrieve from statictext within tabpage_1
end type
type dw_1_sel from uo_d_std_1 within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_1 dw_1
st_1_retrieve st_1_retrieve
dw_1_sel dw_1_sel
end type
type tabpage_2 from userobject within tab_1
end type
type dw_2_sel from uo_d_std_1 within tabpage_2
end type
type st_2_retrieve from statictext within tabpage_2
end type
type dw_2 from uo_d_std_1 within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_2_sel dw_2_sel
st_2_retrieve st_2_retrieve
dw_2 dw_2
end type
type tabpage_3 from userobject within tab_1
end type
type dw_3_sel from uo_d_std_1 within tabpage_3
end type
type st_3_retrieve from statictext within tabpage_3
end type
type dw_3 from uo_d_std_1 within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_3_sel dw_3_sel
st_3_retrieve st_3_retrieve
dw_3 dw_3
end type
type tabpage_4 from userobject within tab_1
end type
type dw_4_sel from uo_d_std_1 within tabpage_4
end type
type st_4_retrieve from statictext within tabpage_4
end type
type dw_4 from uo_d_std_1 within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_4_sel dw_4_sel
st_4_retrieve st_4_retrieve
dw_4 dw_4
end type
type tabpage_5 from userobject within tab_1
end type
type dw_5_sel from uo_d_std_1 within tabpage_5
end type
type st_5_retrieve from statictext within tabpage_5
end type
type dw_5 from uo_d_std_1 within tabpage_5
end type
type tabpage_5 from userobject within tab_1
dw_5_sel dw_5_sel
st_5_retrieve st_5_retrieve
dw_5 dw_5
end type
type tabpage_6 from userobject within tab_1
end type
type dw_6_sel from uo_d_std_1 within tabpage_6
end type
type dw_6 from uo_d_std_1 within tabpage_6
end type
type st_6_retrieve from statictext within tabpage_6
end type
type tabpage_6 from userobject within tab_1
dw_6_sel dw_6_sel
dw_6 dw_6
st_6_retrieve st_6_retrieve
end type
type tabpage_7 from userobject within tab_1
end type
type dw_7_sel from uo_d_std_1 within tabpage_7
end type
type dw_7 from uo_d_std_1 within tabpage_7
end type
type st_7_retrieve from statictext within tabpage_7
end type
type tabpage_7 from userobject within tab_1
dw_7_sel dw_7_sel
dw_7 dw_7
st_7_retrieve st_7_retrieve
end type
type tabpage_8 from userobject within tab_1
end type
type dw_8_sel from uo_d_std_1 within tabpage_8
end type
type dw_8 from uo_d_std_1 within tabpage_8
end type
type st_8_retrieve from statictext within tabpage_8
end type
type tabpage_8 from userobject within tab_1
dw_8_sel dw_8_sel
dw_8 dw_8
st_8_retrieve st_8_retrieve
end type
type tabpage_9 from userobject within tab_1
end type
type dw_9_sel from uo_d_std_1 within tabpage_9
end type
type dw_9 from uo_d_std_1 within tabpage_9
end type
type st_9_retrieve from statictext within tabpage_9
end type
type tabpage_9 from userobject within tab_1
dw_9_sel dw_9_sel
dw_9 dw_9
st_9_retrieve st_9_retrieve
end type
type tab_1 from tab within w_g_tab_elenco_old
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
tabpage_8 tabpage_8
tabpage_9 tabpage_9
end type
end forward

global type w_g_tab_elenco_old from w_g_tab
integer width = 4009
integer height = 1352
boolean ki_toolbar_window_presente = true
boolean ki_esponi_msg_dati_modificati = false
cb_visualizza cb_visualizza
cb_modifica cb_modifica
cb_conferma cb_conferma
cb_cancella cb_cancella
cb_inserisci cb_inserisci
tab_1 tab_1
end type
global w_g_tab_elenco_old w_g_tab_elenco_old

type variables
//
private kuf_elenco kiuf_elenco
//private boolean ki_resize=false   // x fare il rsize 
private DataWindow  ki_dw_cerca
private datastore kdsi_elenco, kdsi_elenco_orig
private w_g_tab ki_window
private kuf_g_tab_elenco kiuf1_g_tab_elenco
//private string ki_path_risorse = " "
private boolean ki_attendi_u_ricevi_da_elenco=false  // x evitare di fare richiamare troppo velocemente la funz. 'u_ricevi_da_elenco()'

//private long ki_riga_selected
//private time ki_keyleftbutton_ini  //--- Serve per capire sto tenendo premuto il TASTO sx del MOUSE (senza CTRL) per alcuni istanti così da fare ad es. il DRAG&DROP

private uo_d_std_1 kidw_lista_elenco 
private uo_d_std_1 kidw_lista_elenco_sel
//protected long ki_riga_x_riposizionamento = 0
protected int ki_selecttab = 0
protected string ki_syntaxquery=" " 


//=== DS di Appoggio x ogni TAB
private datastore kdsi1_elenco, kdsi1_elenco_orig
private datastore kdsi2_elenco, kdsi2_elenco_orig
private datastore kdsi3_elenco, kdsi3_elenco_orig
private datastore kdsi4_elenco, kdsi4_elenco_orig
private datastore kdsi5_elenco, kdsi5_elenco_orig
private datastore kdsi6_elenco, kdsi6_elenco_orig
private datastore kdsi7_elenco, kdsi7_elenco_orig
private datastore kdsi8_elenco, kdsi8_elenco_orig
private datastore kdsi9_elenco, kdsi9_elenco_orig

//=== Parametri passati con il WITHPARM x ogni Tab
private st_open_w kist1_open_w 
private st_open_w kist2_open_w 
private st_open_w kist3_open_w 
private st_open_w kist4_open_w 
private st_open_w kist5_open_w 
private st_open_w kist6_open_w 
private st_open_w kist7_open_w 
private st_open_w kist8_open_w 
private st_open_w kist9_open_w 

//--- Contatore per Gestire troppi tab aperti, ovvero chiude il successivo per ri-occuparlo
private int ki_tab_rioccupato=0


//--- Appoggio x gestione abilitazione tasti funzionali
private boolean ki_tasti_funzionali_enabled[10]
private string ki_dataobject[10]

private kuf_utility kiuf_utility 

//--- flag x disabilitare l'uscita dopo la conferma se ad es. si è aperta una nuova window
private boolean ki_disattiva_exit = false 
//--- evita il RESIZE!
private boolean ki_resize = true


end variables

forward prototypes
private function integer posiz_window ()
protected subroutine inizializza_lista ()
public subroutine attiva_evento_in_win_origine ()
protected subroutine ordina_dw ()
private subroutine smista_funz (string k_par_in)
protected subroutine attiva_menu ()
protected subroutine leggi_liste ()
private subroutine togli_righe_selezionate ()
public subroutine mostra_elenco_selezionati ()
private function string inizializza_1 ()
private function string inizializza_2 ()
private function string inizializza_3 ()
private function string inizializza_4 ()
private function string inizializza_5 ()
private function string inizializza_6 ()
private function string inizializza_7 ()
private function string inizializza_8 ()
public function boolean u_riopen (st_open_w kst_open_w) throws uo_exception
public subroutine u_close_tab ()
public function boolean u_apri_tab (st_open_w kst_open_w) throws uo_exception
protected function uo_d_std_1 u_get_dw ()
private function boolean setta_oggetti ()
protected subroutine stampa_esegui (st_stampe ast_stampe)
protected subroutine open_start_window ()
protected function string inizializza () throws uo_exception
protected subroutine riposiziona_cursore_salva_riga_old ()
protected subroutine riposiziona_cursore (ref uo_d_std_1 auo_d_std_1)
protected subroutine riposiziona_cursore_sulla_riga (ref uo_d_std_1 kdw_1, long k_riga)
public subroutine attiva_drag_drop (uo_d_std_1 adw_1)
public function string conferma_dati ()
private subroutine conferma_selezione_old ()
public subroutine u_dw_ddw_retrieve_auto (ref datawindow a_dw_source, transaction a_sqlca)
protected function uo_d_std_1 u_key (keycode key, unsignedlong keyflags)
public subroutine u_zoom_piu (uo_d_std_1 adw_1)
public subroutine u_zoom_meno (uo_d_std_1 adw_1)
public subroutine u_zoom_off (uo_d_std_1 adw_1)
protected subroutine attiva_tasti_0 ()
public subroutine u_obj_visible_0 ()
public subroutine u_resize_1 ()
public subroutine u_attiva_tasti ()
end prototypes

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
//=== Routine override dello standard
//
string k_key


//
	k_key = trim(ki_st_open_w.key1)
	if trim(k_key) > " " then
	else
		k_key = ""
	end if

	ki_st_open_w.key1 = trim(k_key)

	tab_1.selecttab(1)


	if ki_st_open_w.flag_primo_giro = 'S' then
		kidw_lista_elenco.drag( Cancel! )
		kidw_lista_elenco_sel.drag( Cancel! )
		
//=== Disattivo flag di 'prima volta'
		fine_primo_giro()
		
	end if


end subroutine

public subroutine attiva_evento_in_win_origine ();//
//--- richiama nella Windows chiamata (se ancora aperta) l'evento "u_ricevi_da_elenco"
long k_riga=0, k_riga_ins=0
int k_errore, k_rc
string k_key


//--- imposta gli oggetti standard
	setta_oggetti()


//=== Valorizza l'oggetto DATASTORE per ritorno dei valori 
	if isvalid(kdsi_elenco) then destroy kdsi_elenco 
	kdsi_elenco = create datastore
	kdsi_elenco.dataobject = kidw_lista_elenco.dataobject
	kdsi_elenco.reset( )
	
//--- copia solo i record selezionati	
	for k_riga = 1 to kidw_lista_elenco.rowcount()
		
		if kidw_lista_elenco.isselected( k_riga) then
			
			k_riga_ins++
			if kidw_lista_elenco.rowscopy(k_riga, k_riga, primary!, kdsi_elenco, k_riga_ins, primary!) > 0 then // copia la riga SELECTED
				kdsi_elenco.selectrow( k_riga_ins,true) // anche qui la rende SELECTED (solo x mantenere la vecchia compatibilità)
			end if
			
		end if
		
	end for
	
	if kdsi_elenco.rowcount( ) > 0 then
		ki_st_open_w.key12_any = kdsi_elenco
		ki_st_open_w.key3 = "1"
		
		if not isnull(ki_window) then
			
			if isvalid(ki_window) and not ki_attendi_u_ricevi_da_elenco then
				ki_attendi_u_ricevi_da_elenco = true
				ki_window.event u_ricevi_da_elenco (ki_st_open_w)
				ki_attendi_u_ricevi_da_elenco = false
			end if
			
		end if
	end if

	
	
end subroutine

protected subroutine ordina_dw ();//
//=== Possibilita' di filtrare su una colonna i valori richiesti
string k_x
datawindow kdw_1

//--- imposta gli oggetti standard
	setta_oggetti()

	kdw_1 = kidw_lista_elenco

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


choose case trim(k_par_in) 

	case KKG_FLAG_RICHIESTA.refresh		//Aggiorna Liste
		leggi_liste()

//	case "ag"		//Aggiorna Liste
//		inizializza()

	case KKG_FLAG_RICHIESTA.inserimento		//richiesta inserimento
		if cb_inserisci.enabled = true then
			cb_inserisci.postevent(clicked!)
		end if

	case KKG_FLAG_RICHIESTA.cancellazione		//richiesta cancellazione
		if cb_cancella.enabled = true then
			cb_cancella.postevent(clicked!)
		end if

	case KKG_FLAG_RICHIESTA.conferma		//richiesta conferma
		if cb_conferma.enabled = true then
			cb_conferma.postevent(clicked!)
		end if

	case KKG_FLAG_RICHIESTA.visualizzazione		//richiesta visualizz
		if cb_visualizza.enabled = true then
			cb_visualizza.postevent(clicked!)
		end if

	case KKG_FLAG_RICHIESTA.modifica		//richiesta modifica
		if cb_modifica.enabled  then
			cb_modifica.postevent(clicked!)
		end if

	case KKG_FLAG_RICHIESTA.stampa		//richiesta stampa
		stampa()

	case KKG_FLAG_RICHIESTA.esci		//richiesta uscita
		if cb_ritorna.enabled = true then
			post close(this)
		end if
		
	case KKG_FLAG_RICHIESTA.libero1	//chiude il tab
		u_close_tab()
		
	case KKG_FLAG_RICHIESTA.libero2	//conferma selezionato come doppio-click
		cb_conferma.event clicked( )
//		if cb_conferma.enabled then
//			conferma_selezione()
//		end if

	case KKG_FLAG_RICHIESTA.libero3	//mostra nascondi elenco selezionati
		mostra_elenco_selezionati()

	case KKG_FLAG_RICHIESTA.libero71	//zoom +
		u_zoom_piu(kidw_lista_elenco)
	case KKG_FLAG_RICHIESTA.libero72	//zoom -
		u_zoom_meno(kidw_lista_elenco)

	case else
		super::smista_funz(k_par_in)
//		messagebox("Operazione non Eseguita", &
//					"Funzione richiesta non Abilitata")


end choose


//return k_return

end subroutine

protected subroutine attiva_menu ();//--- Attiva/Dis. Voci di menu
string k_lista, k_nome_controllo


if ki_st_open_w.flag_primo_giro <> "S" then

//--- imposta gli oggetti standard
	setta_oggetti()

//if ki_st_open_w.flag_primo_giro = "S" then
		
	if ki_menu.m_finestra.m_fin_stampa.enabled <> st_stampa.enabled then
		ki_menu.m_finestra.m_fin_stampa.enabled = st_stampa.enabled
	end if
	
	if ki_menu.m_trova.enabled <> st_ordina_lista.enabled then
		ki_menu.m_trova.enabled = st_ordina_lista.enabled 
	end if
	
	if ki_menu.m_trova.m_fin_ordina.enabled <> st_ordina_lista.enabled then
		ki_menu.m_trova.m_fin_ordina.enabled = st_ordina_lista.enabled 
	end if

	if ki_menu.m_trova.m_fin_cerca.enabled <> st_ordina_lista.enabled then
		ki_menu.m_trova.m_fin_cerca.enabled = st_ordina_lista.enabled 
	end if

	if ki_menu.m_trova.m_fin_cercaancora.enabled <> st_ordina_lista.enabled then
		ki_menu.m_trova.m_fin_cercaancora.enabled = st_ordina_lista.enabled 
	end if
	
	if ki_menu.m_trova.m_fin_filtra.enabled <> st_ordina_lista.enabled then
		ki_menu.m_trova.m_fin_filtra.enabled = st_ordina_lista.enabled 
	end if
	if ki_menu.m_filtro.enabled <> st_ordina_lista.enabled then
		ki_menu.m_filtro.enabled = st_ordina_lista.enabled 
	end if

	if ki_menu.m_finestra.m_aggiornalista.enabled <> st_aggiorna_lista.enabled then
		ki_menu.m_finestra.m_aggiornalista.enabled = st_aggiorna_lista.enabled 
	end if

	if ki_menu.m_finestra.m_riordinalista.enabled <> st_ordina_lista.enabled then
		ki_menu.m_finestra.m_riordinalista.enabled = st_ordina_lista.enabled 
	end if

	if ki_menu.m_finestra.m_chiudifinestra.enabled <> cb_ritorna.enabled then 
		ki_menu.m_finestra.m_chiudifinestra.enabled = cb_ritorna.enabled
	end if

	if ki_menu.m_finestra.m_layout_predefinito.enabled <> ki_personalizza_pos_controlli then
		ki_menu.m_finestra.m_layout_predefinito.enabled = ki_personalizza_pos_controlli
	end if

	if ki_menu.m_trova.enabled <> st_aggiorna_lista.enabled  then
		ki_menu.m_trova.enabled = st_aggiorna_lista.enabled 
	end if
	if ki_menu.m_trova.m_fin_ordina.enabled <> st_aggiorna_lista.enabled  then
		ki_menu.m_trova.m_fin_ordina.enabled = st_aggiorna_lista.enabled  
	end if
	if ki_menu.m_trova.m_fin_cerca.enabled <> st_aggiorna_lista.enabled then 
		ki_menu.m_trova.m_fin_cercaancora.enabled = st_aggiorna_lista.enabled  
	end if
//	if ki_menu.m_trova.m_fin_cercaancora.enabled <> st_aggiorna_lista.enabled then 
//		ki_menu.m_trova.m_fin_filtra.enabled = st_aggiorna_lista.enabled  
//	end if
	if ki_menu.m_finestra.m_aggiornalista.enabled <> st_aggiorna_lista.enabled  then
		ki_menu.m_finestra.m_aggiornalista.enabled = st_aggiorna_lista.enabled  
	end if
	if ki_menu.m_finestra.m_riordinalista.enabled <> st_aggiorna_lista.enabled then 
		ki_menu.m_finestra.m_riordinalista.enabled = st_aggiorna_lista.enabled 
	end if

	if ki_menu.m_finestra.m_gestione.m_fin_visualizza.enabled <> cb_visualizza.enabled then
		ki_menu.m_finestra.m_gestione.m_fin_visualizza.enabled = cb_visualizza.enabled
	end if
	if ki_menu.m_finestra.m_gestione.m_fin_modifica.enabled <> cb_modifica.enabled then
		ki_menu.m_finestra.m_gestione.m_fin_modifica.enabled = cb_modifica.enabled
	end if
	if ki_menu.m_finestra.m_gestione.m_fin_inserimento.enabled <> cb_inserisci.enabled then
		ki_menu.m_finestra.m_gestione.m_fin_inserimento.enabled = cb_inserisci.enabled
	end if

//end if
//	if kdsi_elenco_orig.rowcount() <> kidw_lista_elenco.rowcount() then
//		 ki_menu.m_finestra.m_aggiornalista.text = "Rirpistina elenco "
//		 ki_menu.m_finestra.m_aggiornalista.text = "Rirpistina elenco "
//	end if

//--- Chiude scheda
	if not ki_menu.m_strumenti.m_fin_gest_libero1.enabled  or not ki_menu.m_strumenti.m_fin_gest_libero1.visible then
		ki_menu.m_strumenti.m_fin_gest_libero1.text = "Chiudi scheda "
		ki_menu.m_strumenti.m_fin_gest_libero1.microhelp = "Chiudi scheda "
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText = 	"Chiudi, Chiudi scheda Selezionata  "
//		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
//		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName = kGuo_path.get_risorse() + "\Cancel16.ico"
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName = "Cancel16.png"
		ki_menu.m_strumenti.m_fin_gest_libero1.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero1.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
	end if		

	
//--- Visualizza elenco selezionati	
//	if cb_conferma.enabled  then 	
//		k_attiva = true
//	else
//		k_attiva= false
//	end if
	if ki_menu.m_strumenti.m_fin_gest_libero2.enabled  <> cb_conferma.enabled or not ki_menu.m_strumenti.m_fin_gest_libero2.visible then
		ki_menu.m_strumenti.m_fin_gest_libero2.text = "Importa riga/righe Selezionata "
		ki_menu.m_strumenti.m_fin_gest_libero2.microhelp = "Importa riga/righe Selezionata "
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemText = 	"Importa, Importa riga/righe Selezionata  "
//		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
//		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName = kGuo_path.get_risorse() + "\spunta.gif"
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName = "spunta.gif"
		ki_menu.m_strumenti.m_fin_gest_libero2.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero2.enabled = cb_conferma.enabled
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true
	end if		
//--- Come doppio-click
	if not ki_menu.m_strumenti.m_fin_gest_libero3.visible  then 
		ki_menu.m_strumenti.m_fin_gest_libero3.text = "Mosta/Nascondi elenco Righe già Selezonate "
		ki_menu.m_strumenti.m_fin_gest_libero3.microhelp = "Mostra Elenco Selezionati "
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemText = "Mostra, Mosta/Nascondi elenco Righe già Selezonate  "
//		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemName = "PlaceColumn5!"
		ki_menu.m_strumenti.m_fin_gest_libero3.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero3.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemVisible = true
	end if
//--- ZOOM
	if not ki_menu.m_strumenti.m_fin_gest_libero7.visible  then 
		ki_menu.m_strumenti.m_fin_gest_libero7.text = "Zoom sulla scheda aperta (usa anche i tasti più e meno)"
		ki_menu.m_strumenti.m_fin_gest_libero7.microhelp = "per lo Zoom usare anche + o -"
		ki_menu.m_strumenti.m_fin_gest_libero7.toolbaritemText = 	"ZOOM, Zoom sulla scheda aperta (usa anche + o -) "
//		ki_menu.m_strumenti.m_fin_gest_libero7.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero7.toolbaritemName = "zoom.png"
		ki_menu.m_strumenti.m_fin_gest_libero7.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero7.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero7.toolbaritemVisible = true

		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.text = "Ingrandicse la scheda aperta (usa anche il tasto più)"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.microhelp = "Ingrandisce usare anche il + "
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.toolbaritemText = 	"ZOOM+, Ingrandisce la scheda aperta (usa anche il +) "
//		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.toolbaritemName = "zoompiu.png"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.toolbaritemVisible = true

		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.text = "Diminuisce la scheda aperta (usa anche il tasto meno)"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.microhelp = "Diminuisce usare anche il + "
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.toolbaritemText = 	"ZOOM-, Diminuisce la scheda aperta (usa anche il -) "
//		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.toolbaritemName = "zoommeno.png"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.toolbaritemVisible = true
	end if

//---
	super::attiva_menu()

end if

end subroutine

protected subroutine leggi_liste ();//
int k_rc

//--- imposta gli oggetti standard
	setta_oggetti()

	kidw_lista_elenco.reset()

	k_rc = kdsi_elenco_orig.rowscopy(1,kdsi_elenco_orig.rowcount(), primary!,kidw_lista_elenco,1,primary!)

//	k_rc = kdsi1_elenco.sharedata(kidw_lista_elenco)
	
	kidw_lista_elenco_sel.visible = false
	kidw_lista_elenco_sel.reset()


end subroutine

private subroutine togli_righe_selezionate ();//

long k_ind_selected=0


//--- imposta gli oggetti standard
if setta_oggetti() then

	k_ind_selected = kidw_lista_elenco.getselectedrow( 0 )
	do while k_ind_selected > 0 
					
//		kidw_lista_elenco_sel.dynamic event ue_aggiungi_riga(k_ind_selected)
		kidw_lista_elenco_sel.event ue_aggiungi_riga(k_ind_selected)
	
		k_ind_selected --
		k_ind_selected = kidw_lista_elenco.getselectedrow( k_ind_selected )
		
	loop
	
end if


end subroutine

public subroutine mostra_elenco_selezionati ();//
//--- imposta gli oggetti standard
	setta_oggetti()

if kidw_lista_elenco_sel.visible then
	kidw_lista_elenco_sel.visible = false
else
	kidw_lista_elenco_sel.visible = true
end if

end subroutine

private function string inizializza_1 ();//
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
datastore ds_elenco


//--- imposta gli oggetti standard
	setta_oggetti()
	

	tab_1.tabpage_2.text = trim(ki_st_open_w.key1)

		
//--- Popolo l'elenco dal datastore passato
	if kdsi2_elenco_orig.rowcount( ) = 0 then 

		kdsi2_elenco.dataobject = trim(ki_st_open_w.key2)
		kdsi2_elenco_orig.dataobject = trim(ki_st_open_w.key2)
		k_rc = kdsi2_elenco.settransobject ( sqlca )
		
		tab_1.tabpage_2.dw_2.dataobject = trim(ki_st_open_w.key2)
		tab_1.tabpage_2.dw_2.settransobject ( sqlca )
	
		tab_1.tabpage_2.dw_2_sel.dataobject = trim(ki_st_open_w.key2)
		tab_1.tabpage_2.dw_2_sel.settransobject ( sqlca )
		
		kdsi2_elenco = ki_st_open_w.key12_any
		k_rc = kdsi2_elenco.rowscopy(1, kdsi2_elenco.rowcount(), primary!,kdsi2_elenco_orig,1,primary!)

		attiva_drag_drop(tab_1.tabpage_2.dw_2)  // attiva il dar&drop solo se dw GRID
		
	
		leggi_liste()		
	
	
//		tab_1.tabpage_2.dw_2.visible = true
										
		k_nr_rek = tab_1.tabpage_2.dw_2.rowcount() 
		
		if k_nr_rek < 1 then
			k_return = "1Nessuna Informazione trovata "
	
			messagebox("Elenco Dati Vuoto", &
				"Mi spiace, nessun dato trovato per la richiesta fatta ~n~r"  &
				 )
	
		else
			
	//--- Inabilita campi alla modifica 
			kiuf_utility.u_dw_toglie_ddw(1, tab_1.tabpage_2.dw_2)
			kiuf_utility.u_proteggi_dw("1", 0, tab_1.tabpage_2.dw_2)
	
	//--- attiva i LINK standard
			tab_1.tabpage_2.dw_2.event u_personalizza_dw ()
			tab_1.tabpage_2.dw_2_sel.event u_personalizza_dw ()
	
		end if
			
	end if

	kdsi_elenco = kdsi2_elenco
	kdsi_elenco_orig = kdsi2_elenco_orig

//	kidw_lista_elenco.visible = true
	kidw_lista_elenco.setfocus()

return k_return



end function

private function string inizializza_2 ();//
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
datastore ds_elenco


//--- imposta gli oggetti standard
	setta_oggetti()
	

	tab_1.tabpage_3.text = trim(ki_st_open_w.key1)

		
//--- Popolo l'elenco dal datastore passato
	if kdsi3_elenco_orig.rowcount( ) = 0 then 

		kdsi3_elenco.dataobject = trim(ki_st_open_w.key2)
		kdsi3_elenco_orig.dataobject = trim(ki_st_open_w.key2)
		k_rc = kdsi3_elenco.settransobject ( sqlca )
		
		tab_1.tabpage_3.dw_3.dataobject = trim(ki_st_open_w.key2)
		tab_1.tabpage_3.dw_3.settransobject ( sqlca )
	
		tab_1.tabpage_3.dw_3_sel.dataobject = trim(ki_st_open_w.key2)
		tab_1.tabpage_3.dw_3_sel.settransobject ( sqlca )
		
		kdsi3_elenco = ki_st_open_w.key12_any
		k_rc = kdsi3_elenco.rowscopy(1, kdsi3_elenco.rowcount(), primary!,kdsi3_elenco_orig,1,primary!)

		attiva_drag_drop(tab_1.tabpage_3.dw_3)  // attiva il dar&drop solo se dw GRID
	
		leggi_liste()		
	
	
//		tab_1.tabpage_3.dw_3.visible = true
										
		k_nr_rek = tab_1.tabpage_3.dw_3.rowcount() 
		
		if k_nr_rek < 1 then
			k_return = "1Nessuna Informazione trovata "
	
			messagebox("Elenco Dati Vuoto", &
				"Mi spiace, nessun dato trovato per la richiesta fatta ~n~r"  &
				 )
	
		else
			
	//--- Inabilita campi alla modifica 
			kiuf_utility.u_dw_toglie_ddw(1, tab_1.tabpage_3.dw_3)
			kiuf_utility.u_proteggi_dw("1", 0, tab_1.tabpage_3.dw_3)
	
	//--- attiva i LINK standard
			tab_1.tabpage_3.dw_3.event u_personalizza_dw ()
			tab_1.tabpage_3.dw_3_sel.event u_personalizza_dw ()
	
		end if
			
	end if

	kdsi_elenco = kdsi3_elenco
	kdsi_elenco_orig = kdsi3_elenco_orig

//	kidw_lista_elenco.visible = true
	kidw_lista_elenco.setfocus()

return k_return



end function

private function string inizializza_3 ();//
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
datastore ds_elenco


//--- imposta gli oggetti standard
	setta_oggetti()
	

	tab_1.tabpage_4.text = trim(ki_st_open_w.key1)

		
//--- Popolo l'elenco dal datastore passato
	if kdsi4_elenco_orig.rowcount( ) = 0 then 

		kdsi4_elenco.dataobject = trim(ki_st_open_w.key2)
		kdsi4_elenco_orig.dataobject = trim(ki_st_open_w.key2)
		k_rc = kdsi4_elenco.settransobject ( sqlca )
		
		tab_1.tabpage_4.dw_4.dataobject = trim(ki_st_open_w.key2)
		tab_1.tabpage_4.dw_4.settransobject ( sqlca )
	
		tab_1.tabpage_4.dw_4_sel.dataobject = trim(ki_st_open_w.key2)
		tab_1.tabpage_4.dw_4_sel.settransobject ( sqlca )
		
		kdsi4_elenco = ki_st_open_w.key12_any
		k_rc = kdsi4_elenco.rowscopy(1, kdsi4_elenco.rowcount(), primary!,kdsi4_elenco_orig,1,primary!)

		attiva_drag_drop(tab_1.tabpage_4.dw_4)  // attiva il dar&drop solo se dw GRID
	
		leggi_liste()		
	
	
//		tab_1.tabpage_4.dw_4.visible = true
										
		k_nr_rek = tab_1.tabpage_4.dw_4.rowcount() 
		
		if k_nr_rek < 1 then
			k_return = "1Nessuna Informazione trovata "
	
			messagebox("Elenco Dati Vuoto", &
				"Mi spiace, nessun dato trovato per la richiesta fatta ~n~r"  &
				 )
	
		else
			
	//--- Inabilita campi alla modifica 
			kiuf_utility.u_dw_toglie_ddw(1, tab_1.tabpage_4.dw_4)
			kiuf_utility.u_proteggi_dw("1", 0, tab_1.tabpage_4.dw_4)
	
	//--- attiva i LINK standard
			tab_1.tabpage_4.dw_4.event u_personalizza_dw ()
			tab_1.tabpage_4.dw_4_sel.event u_personalizza_dw ()
	
		end if
			
	end if

	kdsi_elenco = kdsi4_elenco
	kdsi_elenco_orig = kdsi4_elenco_orig

//	kidw_lista_elenco.visible = true
	kidw_lista_elenco.setfocus()

return k_return



end function

private function string inizializza_4 ();//
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
datastore ds_elenco


//--- imposta gli oggetti standard
	setta_oggetti()
	

	tab_1.tabpage_5.text = trim(ki_st_open_w.key1)

		
//--- Popolo l'elenco dal datastore passato
	if kdsi5_elenco_orig.rowcount( ) = 0 then 

		kdsi5_elenco.dataobject = trim(ki_st_open_w.key2)
		kdsi5_elenco_orig.dataobject = trim(ki_st_open_w.key2)
		k_rc = kdsi5_elenco.settransobject ( sqlca )
		
		tab_1.tabpage_5.dw_5.dataobject = trim(ki_st_open_w.key2)
		tab_1.tabpage_5.dw_5.settransobject ( sqlca )
	
		tab_1.tabpage_5.dw_5_sel.dataobject = trim(ki_st_open_w.key2)
		tab_1.tabpage_5.dw_5_sel.settransobject ( sqlca )
		
		kdsi5_elenco = ki_st_open_w.key12_any
		k_rc = kdsi5_elenco.rowscopy(1, kdsi5_elenco.rowcount(), primary!,kdsi5_elenco_orig,1,primary!)

		attiva_drag_drop(tab_1.tabpage_5.dw_5)  // attiva il dar&drop solo se dw GRID
	
		leggi_liste()		
	
	
//		tab_1.tabpage_5.dw_5.visible = true
										
		k_nr_rek = tab_1.tabpage_5.dw_5.rowcount() 
		
		if k_nr_rek < 1 then
			k_return = "1Nessuna Informazione trovata "
	
			messagebox("Elenco Dati Vuoto", &
				"Mi spiace, nessun dato trovato per la richiesta fatta ~n~r"  &
				 )
	
		else
			
	//--- Inabilita campi alla modifica 
			kiuf_utility.u_dw_toglie_ddw(1, tab_1.tabpage_5.dw_5)
			kiuf_utility.u_proteggi_dw("1", 0, tab_1.tabpage_5.dw_5)
	
	//--- attiva i LINK standard
			tab_1.tabpage_5.dw_5.event u_personalizza_dw ()
			tab_1.tabpage_5.dw_5_sel.event u_personalizza_dw ()
	
		end if
			
	end if

	kdsi_elenco = kdsi5_elenco
	kdsi_elenco_orig = kdsi5_elenco_orig

//	kidw_lista_elenco.visible = true
	kidw_lista_elenco.setfocus()

return k_return



end function

private function string inizializza_5 ();//
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
datastore ds_elenco


//--- imposta gli oggetti standard
	setta_oggetti()
	

	tab_1.tabpage_6.text = trim(ki_st_open_w.key1)

		
//--- Popolo l'elenco dal datastore passato
	if kdsi6_elenco_orig.rowcount( ) = 0 then 

		kdsi6_elenco.dataobject = trim(ki_st_open_w.key2)
		kdsi6_elenco_orig.dataobject = trim(ki_st_open_w.key2)
		k_rc = kdsi6_elenco.settransobject ( sqlca )
		
		tab_1.tabpage_6.dw_6.dataobject = trim(ki_st_open_w.key2)
		tab_1.tabpage_6.dw_6.settransobject ( sqlca )
	
		tab_1.tabpage_6.dw_6_sel.dataobject = trim(ki_st_open_w.key2)
		tab_1.tabpage_6.dw_6_sel.settransobject ( sqlca )
		
		kdsi6_elenco = ki_st_open_w.key12_any
		k_rc = kdsi6_elenco.rowscopy(1, kdsi6_elenco.rowcount(), primary!,kdsi6_elenco_orig,1,primary!)

		attiva_drag_drop(tab_1.tabpage_6.dw_6)  // attiva il dar&drop solo se dw GRID
	
		leggi_liste()		
	
	
//		tab_1.tabpage_6.dw_6.visible = true
										
		k_nr_rek = tab_1.tabpage_6.dw_6.rowcount() 
		
		if k_nr_rek < 1 then
			k_return = "1Nessuna Informazione trovata "
	
			messagebox("Elenco Dati Vuoto", &
				"Mi spiace, nessun dato trovato per la richiesta fatta ~n~r"  &
				 )
	
		else
			
	//--- Inabilita campi alla modifica 
			kiuf_utility.u_dw_toglie_ddw(1, tab_1.tabpage_6.dw_6)
			kiuf_utility.u_proteggi_dw("1", 0, tab_1.tabpage_6.dw_6)
	
	//--- attiva i LINK standard
			tab_1.tabpage_6.dw_6.event u_personalizza_dw ()
			tab_1.tabpage_6.dw_6_sel.event u_personalizza_dw ()
	
		end if
			
	end if

	kdsi_elenco = kdsi6_elenco
	kdsi_elenco_orig = kdsi6_elenco_orig

//	kidw_lista_elenco.visible = true
	kidw_lista_elenco.setfocus()

return k_return



end function

private function string inizializza_6 ();//
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
datastore ds_elenco


//--- imposta gli oggetti standard
	setta_oggetti()
	

	tab_1.tabpage_7.text = trim(ki_st_open_w.key1)

		
//--- Popolo l'elenco dal datastore passato
	if kdsi7_elenco_orig.rowcount( ) = 0 then 

		kdsi7_elenco.dataobject = trim(ki_st_open_w.key2)
		kdsi7_elenco_orig.dataobject = trim(ki_st_open_w.key2)
		k_rc = kdsi7_elenco.settransobject ( sqlca )
		
		tab_1.tabpage_7.dw_7.dataobject = trim(ki_st_open_w.key2)
		tab_1.tabpage_7.dw_7.settransobject ( sqlca )
	
		tab_1.tabpage_7.dw_7_sel.dataobject = trim(ki_st_open_w.key2)
		tab_1.tabpage_7.dw_7_sel.settransobject ( sqlca )
		
		kdsi7_elenco = ki_st_open_w.key12_any
		k_rc = kdsi7_elenco.rowscopy(1, kdsi7_elenco.rowcount(), primary!,kdsi7_elenco_orig,1,primary!)

		attiva_drag_drop(tab_1.tabpage_7.dw_7)  // attiva il dar&drop solo se dw GRID
	
		leggi_liste()		
	
	
//		tab_1.tabpage_7.dw_7.visible = true
										
		k_nr_rek = tab_1.tabpage_7.dw_7.rowcount() 
		
		if k_nr_rek < 1 then
			k_return = "1Nessuna Informazione trovata "
	
			messagebox("Elenco Dati Vuoto", &
				"Mi spiace, nessun dato trovato per la richiesta fatta ~n~r"  &
				 )
	
		else
			
	//--- Inabilita campi alla modifica 
			kiuf_utility.u_dw_toglie_ddw(1, tab_1.tabpage_7.dw_7)
			kiuf_utility.u_proteggi_dw("1", 0, tab_1.tabpage_7.dw_7)
	
	//--- attiva i LINK standard
			tab_1.tabpage_7.dw_7.event u_personalizza_dw ()
			tab_1.tabpage_7.dw_7_sel.event u_personalizza_dw ()
	
		end if
			
	end if

	kdsi_elenco = kdsi7_elenco
	kdsi_elenco_orig = kdsi7_elenco_orig

//	kidw_lista_elenco.visible = true
	kidw_lista_elenco.setfocus()

return k_return



end function

private function string inizializza_7 ();//
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
datastore ds_elenco


//--- imposta gli oggetti standard
	setta_oggetti()
	

	tab_1.tabpage_8.text = trim(ki_st_open_w.key1)

		
//--- Popolo l'elenco dal datastore passato
	if kdsi8_elenco_orig.rowcount( ) = 0 then 

		kdsi8_elenco.dataobject = trim(ki_st_open_w.key2)
		kdsi8_elenco_orig.dataobject = trim(ki_st_open_w.key2)
		k_rc = kdsi8_elenco.settransobject ( sqlca )
		
		tab_1.tabpage_8.dw_8.dataobject = trim(ki_st_open_w.key2)
		tab_1.tabpage_8.dw_8.settransobject ( sqlca )
	
		tab_1.tabpage_8.dw_8_sel.dataobject = trim(ki_st_open_w.key2)
		tab_1.tabpage_8.dw_8_sel.settransobject ( sqlca )
		
		kdsi8_elenco = ki_st_open_w.key12_any
		k_rc = kdsi8_elenco.rowscopy(1, kdsi8_elenco.rowcount(), primary!,kdsi8_elenco_orig,1,primary!)

		attiva_drag_drop(tab_1.tabpage_8.dw_8)  // attiva il dar&drop solo se dw GRID
	
		leggi_liste()		
	
	
//		tab_1.tabpage_8.dw_8.visible = true
										
		k_nr_rek = tab_1.tabpage_8.dw_8.rowcount() 
		
		if k_nr_rek < 1 then
			k_return = "1Nessuna Informazione trovata "
	
			messagebox("Elenco Dati Vuoto", &
				"Mi spiace, nessun dato trovato per la richiesta fatta ~n~r"  &
				 )
	
		else
			
	//--- Inabilita campi alla modifica 
			kiuf_utility.u_dw_toglie_ddw(1, tab_1.tabpage_8.dw_8)
			kiuf_utility.u_proteggi_dw("1", 0, tab_1.tabpage_8.dw_8)
	
	//--- attiva i LINK standard
			tab_1.tabpage_8.dw_8.event u_personalizza_dw ()
			tab_1.tabpage_8.dw_8_sel.event u_personalizza_dw ()
	
		end if
			
	end if

	kdsi_elenco = kdsi8_elenco
	kdsi_elenco_orig = kdsi8_elenco_orig

//	kidw_lista_elenco.visible = true
	kidw_lista_elenco.setfocus()

return k_return



end function

private function string inizializza_8 ();//
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
datastore ds_elenco


//--- imposta gli oggetti standard
	setta_oggetti()
	

	tab_1.tabpage_9.text = trim(ki_st_open_w.key1)

		
//--- Popolo l'elenco dal datastore passato
	if kdsi9_elenco_orig.rowcount( ) = 0 then 

		kdsi9_elenco.dataobject = trim(ki_st_open_w.key2)
		kdsi9_elenco_orig.dataobject = trim(ki_st_open_w.key2)
		k_rc = kdsi9_elenco.settransobject ( sqlca )
		
		tab_1.tabpage_9.dw_9.dataobject = trim(ki_st_open_w.key2)
		tab_1.tabpage_9.dw_9.settransobject ( sqlca )
	
		tab_1.tabpage_9.dw_9_sel.dataobject = trim(ki_st_open_w.key2)
		tab_1.tabpage_9.dw_9_sel.settransobject ( sqlca )
		
		kdsi9_elenco = ki_st_open_w.key12_any
		k_rc = kdsi9_elenco.rowscopy(1, kdsi9_elenco.rowcount(), primary!,kdsi9_elenco_orig,1,primary!)

		attiva_drag_drop(tab_1.tabpage_9.dw_9)  // attiva il dar&drop solo se dw GRID

		leggi_liste()		
	
	
//		tab_1.tabpage_9.dw_9.visible = true
										
		k_nr_rek = tab_1.tabpage_9.dw_9.rowcount() 
		
		if k_nr_rek < 1 then
			k_return = "1Nessuna Informazione trovata "
	
			messagebox("Elenco Dati Vuoto", &
				"Mi spiace, nessun dato trovato per la richiesta fatta ~n~r"  &
				 )
	
		else
			
	//--- Inabilita campi alla modifica 
			kiuf_utility.u_dw_toglie_ddw(1, tab_1.tabpage_9.dw_9)
			kiuf_utility.u_proteggi_dw("1", 0, tab_1.tabpage_9.dw_9)
	
	//--- attiva i LINK standard
			tab_1.tabpage_9.dw_9.event u_personalizza_dw ()
			tab_1.tabpage_9.dw_9_sel.event u_personalizza_dw ()
	
		end if
			
	end if

	kdsi_elenco = kdsi9_elenco
	kdsi_elenco_orig = kdsi9_elenco_orig

//	kidw_lista_elenco.visible = true
	kidw_lista_elenco.setfocus()

return k_return



end function

public function boolean u_riopen (st_open_w kst_open_w) throws uo_exception;//---
//--- Controlla il primo TAB disponibile e lo ATTIVA
//---
boolean k_return = true

ki_disattiva_exit = true

super::u_riopen(kst_open_w)

post u_apri_tab(kst_open_w)

ki_st_open_w.flag_primo_giro = "N"

return k_return

end function

public subroutine u_close_tab ();//
//--- close il tab cliccato
//
int	k_inizio 
int	k_fine  
int k_ctr

	setredraw (false)

		choose case tab_1.selectedtab
			case 1
				tab_1.tabpage_1.dw_1.reset( )
				tab_1.tabpage_1.dw_1_sel.reset( )
				if isvalid(kdsi1_elenco_orig) then kdsi1_elenco_orig.reset( )
				if isvalid(kdsi1_elenco) then kdsi1_elenco.reset( )
				tab_1.tabpage_1.dw_1.enabled = false
				tab_1.tabpage_1.visible = false
			case 2
				tab_1.tabpage_2.dw_2.reset( )
				tab_1.tabpage_2.dw_2_sel.reset( )
				if isvalid(kdsi2_elenco_orig) then kdsi2_elenco_orig.reset( )
				if isvalid(kdsi2_elenco) then kdsi1_elenco.reset( )
				tab_1.tabpage_2.dw_2.enabled = false
				tab_1.tabpage_2.visible = false
			case 3
				tab_1.tabpage_3.dw_3.reset( )
				tab_1.tabpage_3.dw_3_sel.reset( )
				if isvalid(kdsi3_elenco_orig) then kdsi3_elenco_orig.reset( )
				if isvalid(kdsi3_elenco) then kdsi1_elenco.reset( )
				tab_1.tabpage_3.dw_3.enabled = false
				tab_1.tabpage_3.visible = false
			case 4
				tab_1.tabpage_4.dw_4.reset( )
				tab_1.tabpage_4.dw_4_sel.reset( )
				if isvalid(kdsi4_elenco_orig) then kdsi4_elenco_orig.reset( )
				if isvalid(kdsi4_elenco) then kdsi1_elenco.reset( )
				tab_1.tabpage_4.dw_4.enabled = false
				tab_1.tabpage_4.visible = false
			case 5
				tab_1.tabpage_5.dw_5.reset( )
				tab_1.tabpage_5.dw_5_sel.reset( )
				if isvalid(kdsi5_elenco_orig) then kdsi5_elenco_orig.reset( )
				if isvalid(kdsi5_elenco) then kdsi1_elenco.reset( )
				tab_1.tabpage_5.dw_5.enabled = false
				tab_1.tabpage_5.visible = false
			case 6
				tab_1.tabpage_6.dw_6.reset( )
				tab_1.tabpage_6.dw_6_sel.reset( )
				if isvalid(kdsi6_elenco_orig) then kdsi6_elenco_orig.reset( )
				if isvalid(kdsi6_elenco) then kdsi1_elenco.reset( )
				tab_1.tabpage_6.dw_6.enabled = false
				tab_1.tabpage_6.visible = false
			case 7
				tab_1.tabpage_7.dw_7.reset( )
				tab_1.tabpage_7.dw_7_sel.reset( )
				if isvalid(kdsi7_elenco_orig) then kdsi7_elenco_orig.reset( )
				if isvalid(kdsi7_elenco) then kdsi1_elenco.reset( )
				tab_1.tabpage_7.dw_7.enabled = false
				tab_1.tabpage_7.visible = false
			case 8
				tab_1.tabpage_8.dw_8.reset( )
				tab_1.tabpage_8.dw_8_sel.reset( )
				if isvalid(kdsi8_elenco_orig) then kdsi8_elenco_orig.reset( )
				if isvalid(kdsi8_elenco) then kdsi1_elenco.reset( )
				tab_1.tabpage_8.dw_8.enabled = false
				tab_1.tabpage_8.visible = false
			case 9
				tab_1.tabpage_9.dw_9.reset( )
				tab_1.tabpage_9.dw_9_sel.reset( )
				if isvalid(kdsi9_elenco_orig) then kdsi9_elenco_orig.reset( )
				if isvalid(kdsi9_elenco) then kdsi1_elenco.reset( )
				tab_1.tabpage_9.dw_9.enabled = false
				tab_1.tabpage_9.visible = false
		end choose
		
//--- dopo la close si posiziona sulla successiva (precedente/successiva)
		k_inizio = tab_1.selectedtab - 1
		k_fine = 1 
		for k_ctr = k_inizio to k_fine STEP -1 
			
			choose case k_ctr
				case 1
					if tab_1.tabpage_1.visible then
						k_fine=0 // x evitare l'altro choose
						tab_1.selecttab(1)
						exit
					end if
				case 2
					if tab_1.tabpage_2.visible then
						k_fine=0 // x evitare l'altro choose
						tab_1.selecttab(2)
						exit
					end if
				case 3
					if tab_1.tabpage_3.visible then
						k_fine=0 // x evitare l'altro choose
						tab_1.selecttab(3)
						exit
					end if
				case 4
					if tab_1.tabpage_4.visible then
						k_fine=0 // x evitare l'altro choose
						tab_1.selecttab(4)
						exit
					end if
				case 5
					if tab_1.tabpage_5.visible then
						k_fine=0 // x evitare l'altro choose
						tab_1.selecttab(5)
						exit
					end if
				case 6
					if tab_1.tabpage_6.visible then
						k_fine=0 // x evitare l'altro choose
						tab_1.selecttab(6)
						exit
					end if
				case 7
					if tab_1.tabpage_7.visible then
						k_fine=0 // x evitare l'altro choose
						tab_1.selecttab(7)
						exit
					end if
				case 8
					if tab_1.tabpage_8.visible then
						k_fine=0 // x evitare l'altro choose
						tab_1.selecttab(8)
						exit
					end if
				case 9
					if tab_1.tabpage_9.visible then
						k_fine=0 // x evitare l'altro choose
						tab_1.selecttab(9)
						exit
					end if
			end choose
			
		next
		
		if k_fine > 0 then
			k_fine = 9
			for k_ctr = k_inizio to k_fine  
				
				choose case k_ctr
					case 1
						if tab_1.tabpage_1.visible then
							k_fine=0 // x dire ho trovato
							tab_1.selecttab(1)
							exit
						end if
					case 2
						if tab_1.tabpage_2.visible then
							k_fine=0 // x dire ho trovato
							tab_1.selecttab(2)
							exit
						end if
					case 3
						if tab_1.tabpage_3.visible then
							k_fine=0 // x dire ho trovato
							tab_1.selecttab(3)
							exit
						end if
					case 4
						if tab_1.tabpage_4.visible then
							k_fine=0 // x dire ho trovato
							tab_1.selecttab(4)
							exit
						end if
					case 5
						if tab_1.tabpage_5.visible then
							k_fine=0 // x dire ho trovato
							tab_1.selecttab(5)
							exit
						end if
					case 6
						if tab_1.tabpage_6.visible then
							k_fine=0 // x dire ho trovato
							tab_1.selecttab(6)
							exit
						end if
					case 7
						if tab_1.tabpage_7.visible then
							k_fine=0 // x dire ho trovato
							tab_1.selecttab(7)
							exit
						end if
					case 8
						if tab_1.tabpage_8.visible then
							k_fine=0 // x dire ho trovato
							tab_1.selecttab(8)
							exit
						end if
					case 9
						if tab_1.tabpage_9.visible then
							k_fine=0 // x dire ho trovato
							tab_1.selecttab(9)
							exit
						end if
				end choose
			
			next
		end if

//--- se non ho trovato alcuna scheda chiudo!
		if k_fine > 0 then
			post close(this)
		end if

	setredraw (true)


end subroutine

public function boolean u_apri_tab (st_open_w kst_open_w) throws uo_exception;//---
//--- Controlla il primo TAB disponibile e lo ATTIVA
//---
boolean k_return = false
kst_open_w.key3 = " "


ki_resize = false   // disbilita il RESIZE

do while not k_return
		
	k_return = true 
	 
	if not tab_1.tabpage_1.dw_1.visible or kist1_open_w.key2 = kst_open_w.key2 then
		kidw_selezionata = tab_1.tabpage_1.dw_1
		kist1_open_w = kst_open_w 
		tab_1.tabpage_1.dw_1.reset( )
		tab_1.tabpage_1.dw_1_sel.reset( )
		if isvalid(kdsi1_elenco_orig) then kdsi1_elenco_orig.reset( )
		if isvalid(kdsi1_elenco) then kdsi1_elenco.reset( )
		tab_1.tabpage_1.dw_1.enabled = true
		tab_1.selecttab(1)
	else		
	if not  tab_1.tabpage_2.dw_2.visible or kist2_open_w.key2 = kst_open_w.key2 then
		kidw_selezionata = tab_1.tabpage_1.dw_1
		kist2_open_w = kst_open_w 
		tab_1.tabpage_2.dw_2.reset( )
		tab_1.tabpage_2.dw_2_sel.reset( )
		if isvalid(kdsi2_elenco_orig) then kdsi2_elenco_orig.reset( )
		if isvalid(kdsi2_elenco) then kdsi2_elenco.reset( )
		tab_1.tabpage_2.enabled = true
		tab_1.selecttab(2)
	else		
	if not  tab_1.tabpage_3.dw_3.visible or kist3_open_w.key2 = kst_open_w.key2 then
		kidw_selezionata = tab_1.tabpage_1.dw_1
		kist3_open_w = kst_open_w 
		tab_1.tabpage_3.dw_3.reset( )
		tab_1.tabpage_3.dw_3_sel.reset( )
		if isvalid(kdsi3_elenco_orig) then kdsi3_elenco_orig.reset( )
		if isvalid(kdsi3_elenco) then kdsi3_elenco.reset( )
		tab_1.tabpage_3.enabled = true
		tab_1.selecttab(3)
	else		
	if not  tab_1.tabpage_4.dw_4.visible or kist4_open_w.key2 = kst_open_w.key2 then
		kidw_selezionata = tab_1.tabpage_1.dw_1
		kist4_open_w = kst_open_w 
		tab_1.tabpage_4.dw_4.reset( )
		tab_1.tabpage_4.dw_4_sel.reset( )
		if isvalid(kdsi4_elenco_orig) then kdsi4_elenco_orig.reset( )
		if isvalid(kdsi4_elenco) then kdsi4_elenco.reset( )
		tab_1.tabpage_4.enabled = true
		tab_1.selecttab(4)
	else		
	if not  tab_1.tabpage_5.dw_5.visible or kist5_open_w.key2 = kst_open_w.key2 then
		kidw_selezionata = tab_1.tabpage_1.dw_1
		kist5_open_w = kst_open_w 
		tab_1.tabpage_5.dw_5.reset( )
		tab_1.tabpage_5.dw_5_sel.reset( )
		if isvalid(kdsi5_elenco_orig) then kdsi5_elenco_orig.reset( )
		if isvalid(kdsi5_elenco) then kdsi5_elenco.reset( )
		tab_1.tabpage_5.enabled = true
		tab_1.selecttab(5)
	else		
	if not  tab_1.tabpage_6.dw_6.visible or kist6_open_w.key2 = kst_open_w.key2 then
		kidw_selezionata = tab_1.tabpage_1.dw_1
		kist6_open_w = kst_open_w 
		tab_1.tabpage_6.dw_6.reset( )
		tab_1.tabpage_6.dw_6_sel.reset( )
		if isvalid(kdsi6_elenco_orig) then kdsi6_elenco_orig.reset( )
		if isvalid(kdsi6_elenco) then kdsi6_elenco.reset( )
		tab_1.selecttab(6)
		tab_1.tabpage_6.enabled = true
	else		
	if not  tab_1.tabpage_7.dw_7.visible or kist7_open_w.key2 = kst_open_w.key2 then
		kidw_selezionata = tab_1.tabpage_1.dw_1
		kist7_open_w = kst_open_w 
		tab_1.tabpage_7.dw_7.reset( )
		tab_1.tabpage_7.dw_7_sel.reset( )
		if isvalid(kdsi7_elenco_orig) then kdsi7_elenco_orig.reset( )
		if isvalid(kdsi7_elenco) then kdsi7_elenco.reset( )
		tab_1.selecttab(7)
		tab_1.tabpage_7.enabled = true
	else		
	if not  tab_1.tabpage_8.dw_8.visible or kist8_open_w.key2 = kst_open_w.key2 then
		kidw_selezionata = tab_1.tabpage_1.dw_1
		kist8_open_w = kst_open_w 
		tab_1.tabpage_8.dw_8.reset( )
		tab_1.tabpage_8.dw_8_sel.reset( )
		if isvalid(kdsi8_elenco_orig) then kdsi8_elenco_orig.reset( )
		if isvalid(kdsi8_elenco) then kdsi8_elenco.reset( )
		tab_1.selecttab(8)
		tab_1.tabpage_8.enabled = true
	else		
	if not  tab_1.tabpage_9.dw_9.visible or kist9_open_w.key2 = kst_open_w.key2 then
		kidw_selezionata = tab_1.tabpage_1.dw_1
		kist9_open_w = kst_open_w 
		tab_1.tabpage_9.dw_9.reset( )
		tab_1.tabpage_9.dw_9_sel.reset( )
		if isvalid(kdsi9_elenco_orig) then kdsi9_elenco_orig.reset( )
		if isvalid(kdsi9_elenco) then kdsi9_elenco.reset( )
		tab_1.selecttab(9)
		tab_1.tabpage_9.enabled = true
	else
//--- chiudo un tab x ri-occuparlo		
		k_return = false
		ki_tab_rioccupato ++
		choose case ki_tab_rioccupato
			case 1
				tab_1.tabpage_1.dw_1.visible = false
			case 2
				tab_1.tabpage_2.dw_2.visible = false
			case 3
				tab_1.tabpage_3.dw_3.visible = false
			case 4
				tab_1.tabpage_4.dw_4.visible = false
			case 5
				tab_1.tabpage_5.dw_5.visible = false
			case 6
				tab_1.tabpage_6.dw_6.visible = false
			case 7
				tab_1.tabpage_7.dw_7.visible = false
			case 8
				tab_1.tabpage_8.dw_8.visible = false
			case 9
				tab_1.tabpage_9.dw_9.visible = false
				ki_tab_rioccupato = 0
		end choose

//		kGuo_exception.set_tipo( kGuo_exception.kk_st_uo_exception_tipo_allerta )
//		kGuo_exception.setmessage( "Troppe funzioni di 'ZOOM' aperte, ~n~rchiudere " + trim(this.title) + " e riprovare")
//		throw kGuo_exception

	end if
	end if
	end if
	end if
	end if
	end if
	end if
	end if
	end if

loop

if k_return then
	//--- forza un RESIZE del dw
	ki_resize = true   // abilita il RESIZE
	u_resize( )

	kidw_selezionata.visible = true
end if

return k_return

end function

protected function uo_d_std_1 u_get_dw ();//---
//--- get il DW attivo
//---
uo_d_std_1 kdw_x


	choose case tab_1.selectedtab 
		case  1 
			kdw_x = tab_1.tabpage_1.dw_1
		case 2
			kdw_x = tab_1.tabpage_2.dw_2
		case 3
			kdw_x = tab_1.tabpage_3.dw_3
		case 4
			kdw_x = tab_1.tabpage_4.dw_4
		case 5
			kdw_x = tab_1.tabpage_5.dw_5
		case 6
			kdw_x = tab_1.tabpage_6.dw_6
		case 7
			kdw_x = tab_1.tabpage_7.dw_7
		case 8
			kdw_x = tab_1.tabpage_8.dw_8
		case 9
			kdw_x = tab_1.tabpage_9.dw_9
	end choose	

return kdw_x	



end function

private function boolean setta_oggetti ();//
//--- Imposta gli Oggetti Generici dal Tab Selezionato
//
boolean k_return = false
string k_flag_primo_giro = ""


//--- salva il flag per ripristinarlo dopo
	k_flag_primo_giro = ki_st_open_w.flag_primo_giro 


	if not isvalid(kdsi_elenco) then kdsi_elenco = create datastore
	if not isvalid(kdsi_elenco_orig) then kdsi_elenco_orig = create datastore

	if not isvalid(kdsi1_elenco) then kdsi1_elenco = create datastore
	if not isvalid(kdsi1_elenco_orig) then kdsi1_elenco_orig = create datastore
	if not isvalid(kdsi2_elenco) then kdsi2_elenco = create datastore
	if not isvalid(kdsi2_elenco_orig) then kdsi2_elenco_orig = create datastore
	if not isvalid(kdsi3_elenco) then kdsi3_elenco = create datastore
	if not isvalid(kdsi3_elenco_orig) then kdsi3_elenco_orig = create datastore
	if not isvalid(kdsi4_elenco) then kdsi4_elenco = create datastore
	if not isvalid(kdsi4_elenco_orig) then kdsi4_elenco_orig = create datastore
	if not isvalid(kdsi5_elenco) then kdsi5_elenco = create datastore
	if not isvalid(kdsi5_elenco_orig) then kdsi5_elenco_orig = create datastore
	if not isvalid(kdsi6_elenco) then kdsi6_elenco = create datastore
	if not isvalid(kdsi6_elenco_orig) then kdsi6_elenco_orig = create datastore
	if not isvalid(kdsi7_elenco) then kdsi7_elenco = create datastore
	if not isvalid(kdsi7_elenco_orig) then kdsi7_elenco_orig = create datastore
	if not isvalid(kdsi8_elenco) then kdsi8_elenco = create datastore
	if not isvalid(kdsi8_elenco_orig) then kdsi8_elenco_orig = create datastore
	if not isvalid(kdsi9_elenco) then kdsi9_elenco = create datastore
	if not isvalid(kdsi9_elenco_orig) then kdsi9_elenco_orig = create datastore
	
	choose case ki_selecttab // tab_1.selectedtab 
		case  1 
			tab_1.tabpage_1.visible = true
			tab_1.tabpage_1.dw_1.enabled = true
			ki_st_open_w = kist1_open_w	
			kidw_lista_elenco = tab_1.tabpage_1.dw_1
			kidw_lista_elenco_sel =  tab_1.tabpage_1.dw_1_sel
			kidw_lista_elenco.ki_ultrigasel = tab_1.tabpage_1.dw_1.ki_ultrigasel
			kdsi_elenco = kdsi1_elenco
			kdsi_elenco_orig = kdsi1_elenco_orig
		case 2
			tab_1.tabpage_2.visible = true
			tab_1.tabpage_2.dw_2.enabled = true
			ki_st_open_w = kist2_open_w	
			kidw_lista_elenco = tab_1.tabpage_2.dw_2
			kidw_lista_elenco_sel =  tab_1.tabpage_2.dw_2_sel
			kidw_lista_elenco.ki_ultrigasel = tab_1.tabpage_2.dw_2.ki_ultrigasel
			kdsi_elenco = kdsi2_elenco
			kdsi_elenco_orig = kdsi2_elenco_orig
		case 3
			tab_1.tabpage_3.visible = true
			tab_1.tabpage_3.dw_3.enabled = true
			ki_st_open_w = kist3_open_w	
			kidw_lista_elenco = tab_1.tabpage_3.dw_3
			kidw_lista_elenco_sel =  tab_1.tabpage_3.dw_3_sel
			kidw_lista_elenco.ki_ultrigasel = tab_1.tabpage_3.dw_3.ki_ultrigasel
			kdsi_elenco = kdsi3_elenco
			kdsi_elenco_orig = kdsi3_elenco_orig
		case 4
			tab_1.tabpage_4.visible = true
			tab_1.tabpage_4.dw_4.enabled = true
			ki_st_open_w = kist4_open_w	
			kidw_lista_elenco = tab_1.tabpage_4.dw_4
			kidw_lista_elenco_sel =  tab_1.tabpage_4.dw_4_sel
			kidw_lista_elenco.ki_ultrigasel = tab_1.tabpage_4.dw_4.ki_ultrigasel
			kdsi_elenco = kdsi4_elenco
			kdsi_elenco_orig = kdsi4_elenco_orig
		case 5
			tab_1.tabpage_5.visible = true
			tab_1.tabpage_5.dw_5.enabled = true
			ki_st_open_w = kist5_open_w	
			kidw_lista_elenco = tab_1.tabpage_5.dw_5
			kidw_lista_elenco_sel =  tab_1.tabpage_5.dw_5_sel
			kidw_lista_elenco.ki_ultrigasel = tab_1.tabpage_5.dw_5.ki_ultrigasel
			kdsi_elenco = kdsi5_elenco
			kdsi_elenco_orig = kdsi5_elenco_orig
		case 6
			tab_1.tabpage_6.visible = true
			tab_1.tabpage_6.dw_6.enabled = true
			ki_st_open_w = kist6_open_w	
			kidw_lista_elenco = tab_1.tabpage_6.dw_6
			kidw_lista_elenco_sel =  tab_1.tabpage_6.dw_6_sel
			kidw_lista_elenco.ki_ultrigasel = tab_1.tabpage_6.dw_6.ki_ultrigasel
			kdsi_elenco = kdsi6_elenco
			kdsi_elenco_orig = kdsi6_elenco_orig
		case 7
			tab_1.tabpage_7.visible = true
			tab_1.tabpage_7.dw_7.enabled = true
			ki_st_open_w = kist7_open_w	
			kidw_lista_elenco = tab_1.tabpage_7.dw_7
			kidw_lista_elenco_sel =  tab_1.tabpage_7.dw_7_sel
			kidw_lista_elenco.ki_ultrigasel = tab_1.tabpage_7.dw_7.ki_ultrigasel
			kdsi_elenco = kdsi7_elenco
			kdsi_elenco_orig = kdsi7_elenco_orig
		case 8
			tab_1.tabpage_8.visible = true
			tab_1.tabpage_8.dw_8.enabled = true
			ki_st_open_w = kist8_open_w	
			kidw_lista_elenco = tab_1.tabpage_8.dw_8
			kidw_lista_elenco_sel =  tab_1.tabpage_8.dw_8_sel
			kidw_lista_elenco.ki_ultrigasel = tab_1.tabpage_8.dw_8.ki_ultrigasel
			kdsi_elenco = kdsi8_elenco
			kdsi_elenco_orig = kdsi8_elenco_orig
		case 9
			tab_1.tabpage_9.visible = true
			tab_1.tabpage_9.dw_9.enabled = true
			ki_st_open_w = kist9_open_w	
			kidw_lista_elenco = tab_1.tabpage_9.dw_9
			kidw_lista_elenco_sel =  tab_1.tabpage_9.dw_9_sel
			kidw_lista_elenco.ki_ultrigasel = tab_1.tabpage_9.dw_9.ki_ultrigasel
			kdsi_elenco = kdsi9_elenco
			kdsi_elenco_orig = kdsi9_elenco_orig
	end choose	

//--- Individua la Window di provenienza
	if trim(ki_st_open_w.key4) > " " then
		ki_window = kGuf_data_base.prendi_win_x_uguale_titolo(ki_st_open_w.key4)
		if kidw_lista_elenco.ki_ultrigasel > 0 then
			ki_st_open_w.key3 = string(kidw_lista_elenco.ki_ultrigasel )
			k_return = true // OOKKK!
		end if
	end if

//--- salva il flag per ripristinarlo dopo
	ki_st_open_w.flag_primo_giro = k_flag_primo_giro


return k_return

end function

protected subroutine stampa_esegui (st_stampe ast_stampe);//

//--- imposta gli oggetti standard
		setta_oggetti()
		
//	ast_stampe.dw_print = kidw_lista_elenco
//	ast_stampe.titolo = trim(kidw_lista_elenco.tag)
//
//	kGuf_data_base.stampa_dw(ast_stampe)

	if isvalid(kidw_selezionata) then
		ast_stampe.dw_print = kidw_selezionata
	else
		if kidw_lista_elenco.visible then
			ast_stampe.dw_print = kidw_lista_elenco
		end if
	end if
	
	if isvalid(ast_stampe.dw_print) then
		if isvalid(kidw_lista_elenco) then
			ast_stampe.titolo = trim(kidw_lista_elenco.tag)
		else
			ast_stampe.titolo = trim(kiw_this_window.title)
		end if
		kGuf_data_base.stampa_dw(ast_stampe)
	else
		messagebox("Richiesta Stampa", "Stampa non eseguita, funzione non attiva")
	end if

end subroutine

protected subroutine open_start_window ();//
//
//-------------------------------------------------------------------------------------------------------------
//--- Window utilizzata per ZOOM da  Valori  delle varie Window
//---
//--- spesso in alternativa alla DROP-DATAWINDOWS (doppio click)
//----
//--- Parametri richiesti:
//--- KEY1 = Titolo di questa Window di Zoom ("elenco/anteprima")
//--- KEY2 = nome data-window x l'elenco
//--- KEY3 = non usare xchè ritorna il numero di RIGA cliccato
//--- KEY4 = Titolo della Windows chiamante
//--- KEY5 = RISERVATO da non usare
//--- KEY6 = nome campo che ha scatenato la chiamata a questo elenco
//--- KEY7 = flag di chiusura della Window dopo il DOPPIO CLICK di scelta (kuf_elenco.ki_esci_dopo_scelta) 
//--- KEY12_any = reference al datastore con i dati
//---
//--- Torna:
//--- KEY3 = numero della riga scelta dall'elenco
//---        0 = nessuna riga scelta
//--- KEY5 = nome campo che ha scatenato la chiamata a questo elenco
//-------------------------------------------------------------------------------------------------------------
//
int k_rc


	kiuf_utility = create kuf_utility
	
	kidw_lista_elenco = tab_1.tabpage_1.dw_1
	kidw_lista_elenco_sel =  tab_1.tabpage_1.dw_1_sel

//	set_window_size()

////--- setta la directory di base
//	kGuf_data_base.setta_path_default ()
//
//	set_titolo_window()
//
//
////=== Imposta il titolo della wind. nella dw x la desc. in una eventuale stampa
//	kidw_lista_elenco.tag = this.title
//	
//	
////--- path per reperire le ico del drag e drop
////	ki_path_risorse = trim(kGuf_data_base.profilestring_leggi_scrivi(1, "arch_graf", " "))
//	
////	if ki_utente_abilitato then
//
//		kiuf1_g_tab_elenco = create kuf_g_tab_elenco
//
//		post inizializza_lista()
//	
////	end if



end subroutine

protected function string inizializza () throws uo_exception;//
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
datastore ds_elenco


	SetPointer(kkg.pointer_attesa)

//--- imposta gli oggetti standard
	setta_oggetti()

	tab_1.tabpage_1.text = trim(ki_st_open_w.key1)

		
//--- Popolo l'elenco dal datastore passato
	if kdsi1_elenco_orig.rowcount( ) = 0 then 

		kdsi1_elenco.dataobject = trim(ki_st_open_w.key2)
		kdsi1_elenco_orig.dataobject = trim(ki_st_open_w.key2)
//		k_rc = kdsi1_elenco.settransobject ( sqlca )
		
		tab_1.tabpage_1.dw_1.dataobject = trim(ki_st_open_w.key2)
		if trim(ki_st_open_w.settrans) > " " then
			if trim(ki_st_open_w.settrans) = "db_magazzino" then 
				tab_1.tabpage_1.dw_1.settrans (kguo_sqlca_db_magazzino)
			elseif trim(ki_st_open_w.settrans) = "db_pilota" then
				tab_1.tabpage_1.dw_1.settrans (kguo_sqlca_db_pilota)
			elseif trim(ki_st_open_w.settrans) = "db_e1" then
				tab_1.tabpage_1.dw_1.settrans (kguo_sqlca_db_e1)
			end if
		else
			tab_1.tabpage_1.dw_1.settrans ( sqlca )
		end if
//		u_dw_ddw_retrieve_auto(tab_1.tabpage_1.dw_1, ki_st_open_w.settrans)
	
		tab_1.tabpage_1.dw_1_sel.dataobject = trim(ki_st_open_w.key2)
//		tab_1.tabpage_1.dw_1_sel.settransobject ( sqlca )
		
		kdsi1_elenco = ki_st_open_w.key12_any
		k_rc = kdsi1_elenco.rowscopy(1, kdsi1_elenco.rowcount(), primary!,kdsi1_elenco_orig,1,primary!)

//		k_rc = kdsi1_elenco.object.rep_hello[this.RowCount()].object.data.Primary = ds_hello.object.data.Primary

		attiva_drag_drop(tab_1.tabpage_1.dw_1)  // attiva il dar&drop solo se dw GRID
	
		leggi_liste()		
	
		k_nr_rek = tab_1.tabpage_1.dw_1.rowcount() 
		
		if k_nr_rek < 1 then
			k_return = "1Nessuna Informazione trovata "
	
			messagebox("Elenco Dati Vuoto", &
				"Mi spiace, nessun dato trovato per la richiesta fatta ~n~r"  &
				 )
	
		else
			
	//--- Inabilita campi alla modifica 
			kiuf_utility.u_dw_toglie_ddw(1, tab_1.tabpage_1.dw_1)
			kiuf_utility.u_proteggi_dw("1", 0, tab_1.tabpage_1.dw_1)
	
	//--- attiva i LINK standard
			tab_1.tabpage_1.dw_1.event u_personalizza_dw ()
			tab_1.tabpage_1.dw_1_sel.event u_personalizza_dw ()
			
		end if
			
	end if

	kdsi_elenco = kdsi1_elenco
	kdsi_elenco_orig = kdsi1_elenco_orig

//--- finalmente visualizza il tab
//	tab_1.tabpage_1.dw_1.visible = true

	kidw_lista_elenco.visible = true
	kidw_lista_elenco.setfocus()
	
	SetPointer(kkg.pointer_default)
	
return k_return



end function

protected subroutine riposiziona_cursore_salva_riga_old ();////
//
//ki_riga_x_riposizioamento = 0
//	
//
//	try 
//		choose case tab_1.selectedtab 
//			case 1 
//				if tab_1.tabpage_1.dw_1.rowcount() > 0 then
//					ki_riga_x_riposizioamento = tab_1.tabpage_1.dw_1.getselectedrow(0)
//				end if
//			case 2
//				if tab_1.tabpage_2.dw_2.rowcount() > 0 then
//					ki_riga_x_riposizioamento = tab_1.tabpage_2.dw_2.getselectedrow(0)
//				end if
//			case 3
//				if tab_1.tabpage_3.dw_3.rowcount() > 0 then
//					ki_riga_x_riposizioamento = tab_1.tabpage_3.dw_3.getselectedrow(0)
//				end if
//			case 4
//				if tab_1.tabpage_4.dw_4.rowcount() > 0 then
//					ki_riga_x_riposizioamento = tab_1.tabpage_4.dw_4.getselectedrow(0)
//				end if
//			case 5
//				if tab_1.tabpage_5.dw_5.rowcount() > 0 then
//					ki_riga_x_riposizioamento = tab_1.tabpage_5.dw_5.getselectedrow(0)
//				end if
//			case 6
//				if tab_1.tabpage_6.dw_6.rowcount() > 0 then
//					ki_riga_x_riposizioamento = tab_1.tabpage_6.dw_6.getselectedrow(0)
//				end if
//			case 7
//				if tab_1.tabpage_7.dw_7.rowcount() > 0 then
//					ki_riga_x_riposizioamento = tab_1.tabpage_7.dw_7.getselectedrow(0)
//				end if
//			case 8
//				if tab_1.tabpage_8.dw_8.rowcount() > 0 then
//					ki_riga_x_riposizioamento = tab_1.tabpage_8.dw_8.getselectedrow(0)
//				end if
//			case 9
//				if tab_1.tabpage_9.dw_9.rowcount() > 0 then
//					ki_riga_x_riposizioamento = tab_1.tabpage_9.dw_9.getselectedrow(0)
//				end if
//		end choose	
//	
//	catch (uo_exception kuo_exception1)
//		kuo_exception1.messaggio_utente()
//	finally
//	end try
//

	
end subroutine

protected subroutine riposiziona_cursore (ref uo_d_std_1 auo_d_std_1);//
long k_riga = 0


try 
//	if ki_riga_x_riposizionamento > 0 then
//	else	
		k_riga = auo_d_std_1.getrow()
		if k_riga = 0 then
			k_riga = auo_d_std_1.GetSelectedRow(0)
		end if
		if k_riga = 0 then
			k_riga = 1
		end if
//	end if
	riposiziona_cursore_sulla_riga(auo_d_std_1, k_riga)
	

catch (uo_exception kuo_exception1)
	kuo_exception1.messaggio_utente()
finally
end try


	
end subroutine

protected subroutine riposiziona_cursore_sulla_riga (ref uo_d_std_1 kdw_1, long k_riga);//
string k_processing


k_processing = kdw_1.Object.DataWindow.Processing
//---- Se di tipo GRID / TABULAR / TREEVIEW faccio selezione
if k_processing = "1" or k_processing = "8" or k_processing = "9" then

	if k_riga > 0 and kdw_1.rowcount() > 0 then
		if k_riga > kdw_1.rowcount() then
			k_riga = kdw_1.rowcount()
		end if

		if kdw_1.Rowcount() > 1 then // and ki_st_open_w.flag_primo_giro <> 'S' then
		 
			kdw_1.selectrow( 0, false)
			kdw_1.selectrow( k_riga, true)
			kdw_1.setrow( k_riga )
			kdw_1.scrolltorow( k_riga )

		end if
	end if
end if
end subroutine

public subroutine attiva_drag_drop (uo_d_std_1 adw_1);//
if adw_1.u_get_tipo() = adw_1.kki_tipo_processing_grid then
	adw_1.ki_attiva_dragdrop = true
else
	adw_1.ki_attiva_dragdrop = false
end if
end subroutine

public function string conferma_dati ();//
//--- Operazione di Conferma della riga/rughe selezionate
string k_rc
string k_processing 
string k_return = ""



k_processing = kidw_lista_elenco.Object.DataWindow.Processing

cb_conferma.enabled = false
ki_disattiva_exit = false

//--- imposta gli oggetti standard
if setta_oggetti() then

	if kidw_lista_elenco.ki_ultrigasel > 0 then
	
		kidw_lista_elenco.setfocus()
		
//--- invia la riga selezionata alla windows che ha chiamato l'elenco	
		attiva_evento_in_win_origine()
	
		if NOT ki_disattiva_exit and ki_st_open_w.key7 = kiuf_elenco.ki_esci_dopo_scelta then
			//cb_ritorna.postevent( clicked! )
			k_return = "EXIT"
		else
		
//--- Se è stata aperta come windows di "CONFERMA" oppure come da "inquary" ma è di tipo "GRID" o "TREEVIEW" allora 
//--- quando fccio doppio click metto il record nella DW di appoggio 'dei selzionati'
			if kidw_lista_elenco.rowcount() > 0 & 
					and ( &
						 (k_processing = "1" &
							or k_processing = "8" &
							or k_processing = "9") ) then
	
				togli_righe_selezionate()
//
//--- ripiglia il fuoco sul tab giusto
				riposiziona_cursore(kidw_lista_elenco)
//				if ki_selecttab > 0 then
//					tab_1.event selectionchanged(ki_selecttab, ki_selecttab)
//				end if
	
			end if
	
//			attiva_tasti()

			cb_conferma.enabled = true
		end if
	else
		cb_conferma.enabled = true
	end if
else
	cb_conferma.enabled = true
	if (k_processing = "1" &
					or k_processing = "8" &
					or k_processing = "9") then

		messagebox("Importa Dati da Elenco", "Prego, selezionare una riga dall'elenco. ")
		
	end if
end if

return k_return 

end function

private subroutine conferma_selezione_old ();//
//--- hiamato ad sempio quando faccio doppio click
//

//	cb_conferma.enabled = false
//	kist1_open_w.key5 = " " //--- nessun pulsante pigiato
//	k_return = conferma_dati( )
//	if k_return <> "EXIT" then
//		cb_conferma.enabled = true
//	end if

//	cb_conferma.event clicked( ) 

	//conferma_dati( )

end subroutine

public subroutine u_dw_ddw_retrieve_auto (ref datawindow a_dw_source, transaction a_sqlca);//---
//--- Lancia la retrieve delle colonne DDW dove c'è il flag autoretrieve 
//---
//--- parametri di input:
//---    a_dw_source:  la dw sorgente 
//---    Transaction: x fare il set con SETTRANS 
//---
//---
int k_colcount, k_ctr, k_rcn
string k_rc, k_nome
datawindowchild kdwc_1 



			k_rcn = tab_1.tabpage_1.dw_1.getchild("armo_prezzi_stato", kdwc_1)
			if isvalid(a_sqlca) then
				kdwc_1.settrans ( a_sqlca )
			else
				kdwc_1.settrans ( sqlca )
			end if
//			if kdwc_1.rowcount() = 0 then
				k_rcn = kdwc_1.retrieve()
//			end if


end subroutine

protected function uo_d_std_1 u_key (keycode key, unsignedlong keyflags);//---
//--- get il DW attivo
//---
uo_d_std_1 kdw_x


	if key = keyInsert! and cb_conferma.enabled then
		choose case tab_1.selectedtab 
			case  1 
					kist1_open_w.key5 = " " //--- nessun pulsante pigiato
			case 2
					kist2_open_w.key5 = " " //--- nessun pulsante pigiato
			case 3
					kist3_open_w.key5 = " " //--- nessun pulsante pigiato
			case 4
					kist4_open_w.key5 = " " //--- nessun pulsante pigiato
			case 5
					kist5_open_w.key5 = " " //--- nessun pulsante pigiato
			case 6
					kist6_open_w.key5 = " " //--- nessun pulsante pigiato
			case 7
					kist7_open_w.key5 = " " //--- nessun pulsante pigiato
			case 8
					kist8_open_w.key5 = " " //--- nessun pulsante pigiato
			case 9
					kist9_open_w.key5 = " " //--- nessun pulsante pigiato
		end choose	
		cb_conferma.event clicked( ) 
	else
		if key = KeyAdd! or key = KeySubtract! or key = KeyEqual! or key = KeyDash! or key = KeyEscape! or key = KeyDelete! then
			choose case tab_1.selectedtab 
				case  1 
					kdw_x = tab_1.tabpage_1.dw_1
				case 2
					kdw_x = tab_1.tabpage_2.dw_2
				case 3
					kdw_x = tab_1.tabpage_3.dw_3
				case 4
					kdw_x = tab_1.tabpage_4.dw_4
				case 5
					kdw_x = tab_1.tabpage_5.dw_5
				case 6
					kdw_x = tab_1.tabpage_6.dw_6
				case 7
					kdw_x = tab_1.tabpage_7.dw_7
				case 8
					kdw_x = tab_1.tabpage_8.dw_8
				case 9
					kdw_x = tab_1.tabpage_9.dw_9
			end choose	
			if key = KeyEscape! or key = KeyDelete! then
				u_zoom_off(kdw_x)
			else
				if key = KeyAdd! or key = KeyEqual! then
					u_zoom_piu(kdw_x)   //Zoomma +
				else
					u_zoom_meno(kdw_x)   //Zoomma -
				end if
			end if
		else
		end if
	end if



return kdw_x	



end function

public subroutine u_zoom_piu (uo_d_std_1 adw_1);//
//--- ingrandisce 
//
int k_zoom

	k_zoom = integer(adw_1.Object.DataWindow.Print.Preview.Zoom)
	if k_zoom > 1000 then
		k_zoom = 100
	else
		k_zoom += 5
	end if
	if k_zoom = 100 then
		adw_1.Object.DataWindow.Print.Preview = "No"
	else
		adw_1.Object.DataWindow.Print.Preview = "Yes"
	//	adw_1.Object.DataWindow.Print.Margin.Bottom = '0'
	//	adw_1.Object.DataWindow.Print.Margin.Left = '0'
	//	adw_1.Object.DataWindow.Print.Margin.Right = '0'
	//	adw_1.Object.DataWindow.Print.Margin.Top = '0'
	//	adw_1.Object.DataWindow.Print.paper.source = '0'
	end if
	adw_1.Object.DataWindow.Print.Preview.Zoom = k_zoom
	adw_1.SetRedraw(TRUE)

end subroutine

public subroutine u_zoom_meno (uo_d_std_1 adw_1);//
//--- diminuisce 
//
int k_zoom


	k_zoom = integer(adw_1.Object.DataWindow.Print.Preview.Zoom)
	if k_zoom < 10 then
		k_zoom = 100
	else
		k_zoom -= 5
	end if
	if k_zoom = 100 then
		adw_1.Object.DataWindow.Print.Preview = "No"
	else
		adw_1.Object.DataWindow.Print.Preview = "Yes"
	end if
	adw_1.Object.DataWindow.Print.Preview.Zoom = k_zoom
	adw_1.SetRedraw(TRUE)

end subroutine

public subroutine u_zoom_off (uo_d_std_1 adw_1);//
//--- diminuisce 
//
	adw_1.Object.DataWindow.Print.Preview = "No"
	adw_1.Object.DataWindow.Print.Preview.Zoom = 100
	adw_1.SetRedraw(TRUE)

end subroutine

protected subroutine attiva_tasti_0 ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================

long k_nr_righe
string k_lista, k_nome_controllo
uo_d_std_1 kdw_focus
st_tab_menu_window_anteprima kst_tab_menu_window_anteprima
//kuf_menu kuf1_menu


super::attiva_tasti_0()		 

st_aggiorna_lista.enabled = true
//--- queste dovrebbero essere di tipo GRID...
kdw_focus = u_get_dw( )  //kGuf_data_base. u_getfocus_dw()
if isnull(kdw_focus) then 
	st_ordina_lista.enabled = false
else
	k_lista = kdw_focus.Object.DataWindow.Processing
	if k_lista = "1"  then
		st_ordina_lista.enabled = true
	else
		st_ordina_lista.enabled = false
	end if
end if

kst_tab_menu_window_anteprima.anteprima = kdw_focus.dataobject
if kdw_focus.dataobject <> ki_dataobject[tab_1.selectedtab] then  // se è cambiato qls ricontrolla
	
	ki_dataobject[tab_1.selectedtab] = kdw_focus.dataobject 
	
//	kuf1_menu = create kuf_menu
	if kguf_menu_window.get_st_tab_menu_window_anteprima(kst_tab_menu_window_anteprima) then // se Anteprima è apribile...
		ki_tasti_funzionali_enabled[tab_1.selectedtab] = true
	else
		ki_tasti_funzionali_enabled[tab_1.selectedtab] = false
	end if	
//	destroy kuf1_menu
end if
cb_visualizza.enabled = ki_tasti_funzionali_enabled[tab_1.selectedtab]
cb_modifica.enabled = ki_tasti_funzionali_enabled[tab_1.selectedtab]
cb_inserisci.enabled = ki_tasti_funzionali_enabled[tab_1.selectedtab]

cb_ritorna.visible = false
cb_conferma.visible = false

cb_ritorna.enabled = true
cb_conferma.enabled = true

            

end subroutine

public subroutine u_obj_visible_0 ();//
	this.tab_1.visible = true

end subroutine

public subroutine u_resize_1 ();//
super::u_resize_1()

//--- Se tab_1 e visible oppure sono in prima volta
//if ki_resize then
	
	this.setredraw(false)

//--- Dimensione dw nella window 
//	if a_width = 0 then
		tab_1.width = width //a_width - 2  //this.width - 2
		tab_1.height = height //a_height - 2  //this.height - 2
//	end if
	
//--- Posiziona dw nella window 
	tab_1.x = 1 //(this.width - tab_1.width) / 4
	tab_1.y = 1 //(this.height - tab_1.height) / 7

	constant int kk_barra_width = 1 //55
	constant int kk_barra_height = 100 //140
	
//--- Dimensiona dw nel tab
	tab_1.tabpage_1.dw_1.width = tab_1.tabpage_1.width - kk_barra_width
	tab_1.tabpage_1.dw_1.height = tab_1.tabpage_1.height - kk_barra_height
	tab_1.tabpage_1.dw_1.x = 1
	tab_1.tabpage_1.dw_1.y = 1
	
//--- Dimensione e Posizione dw di selezione nella window 
	tab_1.tabpage_1.dw_1_sel.height = tab_1.tabpage_1.dw_1.height * 0.70
	tab_1.tabpage_1.dw_1_sel.width = tab_1.tabpage_1.dw_1.width * 0.30
	tab_1.tabpage_1.dw_1_sel.x = (this.width - tab_1.tabpage_1.dw_1_sel.width) - 45
	tab_1.tabpage_1.dw_1_sel.y = tab_1.tabpage_1.dw_1.y + 30

	tab_1.tabpage_2.dw_2.width = tab_1.tabpage_2.width - kk_barra_width
	tab_1.tabpage_2.dw_2.height = tab_1.tabpage_2.height - kk_barra_height
	tab_1.tabpage_2.dw_2.x =  1 // (tab_1.tabpage_2.width - tab_1.tabpage_2.dw_2.width) / 2
	tab_1.tabpage_2.dw_2.y =  1 // (tab_1.tabpage_2.height - tab_1.tabpage_2.dw_2.height) / 2
	
//--- Dimensione e Posizione dw di selezione nella window 
	tab_1.tabpage_2.dw_2_sel.height = tab_1.tabpage_1.dw_1.height * 0.70
	tab_1.tabpage_2.dw_2_sel.width = tab_1.tabpage_1.dw_1.width * 0.30
	tab_1.tabpage_2.dw_2_sel.x = (this.width - tab_1.tabpage_1.dw_1_sel.width) - 45
	tab_1.tabpage_2.dw_2_sel.y = tab_1.tabpage_1.dw_1.y + 30

	tab_1.tabpage_3.dw_3.width = tab_1.tabpage_3.width - kk_barra_width
	tab_1.tabpage_3.dw_3.height = tab_1.tabpage_3.height - kk_barra_height
	tab_1.tabpage_3.dw_3.x =  1
	tab_1.tabpage_3.dw_3.y =  1// (tab_1.tabpage_3.height - tab_1.tabpage_3.dw_3.height) / 2
	
//--- Dimensione e Posizione dw di selezione nella window 
	tab_1.tabpage_3.dw_3_sel.height = tab_1.tabpage_1.dw_1.height * 0.70
	tab_1.tabpage_3.dw_3_sel.width = tab_1.tabpage_1.dw_1.width * 0.30
	tab_1.tabpage_3.dw_3_sel.x = (this.width - tab_1.tabpage_1.dw_1_sel.width) - 45
	tab_1.tabpage_3.dw_3_sel.y = tab_1.tabpage_1.dw_1.y + 30

	tab_1.tabpage_4.dw_4.width = tab_1.tabpage_4.width - kk_barra_width
	tab_1.tabpage_4.dw_4.height = tab_1.tabpage_4.height - kk_barra_height
	tab_1.tabpage_4.dw_4.x =  1// (tab_1.tabpage_4.width - tab_1.tabpage_4.dw_4.width) / 2
	tab_1.tabpage_4.dw_4.y =  1// (tab_1.tabpage_4.height - tab_1.tabpage_4.dw_4.height) / 2

	tab_1.tabpage_4.dw_4_sel.height = tab_1.tabpage_1.dw_1.height * 0.70
	tab_1.tabpage_4.dw_4_sel.width = tab_1.tabpage_1.dw_1.width * 0.30
	tab_1.tabpage_4.dw_4_sel.x = (this.width - tab_1.tabpage_1.dw_1_sel.width) - 45
	tab_1.tabpage_4.dw_4_sel.y = tab_1.tabpage_1.dw_1.y + 30

	tab_1.tabpage_5.dw_5.width = tab_1.tabpage_5.width - kk_barra_width
	tab_1.tabpage_5.dw_5.height = tab_1.tabpage_5.height - kk_barra_height
	tab_1.tabpage_5.dw_5.x =  1// (tab_1.tabpage_5.width - tab_1.tabpage_5.dw_5.width) / 2
	tab_1.tabpage_5.dw_5.y =  1// (tab_1.tabpage_5.height - tab_1.tabpage_5.dw_5.height) / 2

	tab_1.tabpage_5.dw_5_sel.height = tab_1.tabpage_1.dw_1.height * 0.70
	tab_1.tabpage_5.dw_5_sel.width = tab_1.tabpage_1.dw_1.width * 0.30
	tab_1.tabpage_5.dw_5_sel.x = (this.width - tab_1.tabpage_1.dw_1_sel.width) - 45
	tab_1.tabpage_5.dw_5_sel.y = tab_1.tabpage_1.dw_1.y + 30

	tab_1.tabpage_6.dw_6.width = tab_1.tabpage_6.width - kk_barra_width
	tab_1.tabpage_6.dw_6.height = tab_1.tabpage_6.height - kk_barra_height
	tab_1.tabpage_6.dw_6.x =  1// (tab_1.tabpage_5.width - tab_1.tabpage_5.dw_5.width) / 2
	tab_1.tabpage_6.dw_6.y =  1// (tab_1.tabpage_5.height - tab_1.tabpage_5.dw_5.height) / 2

	tab_1.tabpage_6.dw_6_sel.height = tab_1.tabpage_1.dw_1.height * 0.70
	tab_1.tabpage_6.dw_6_sel.width = tab_1.tabpage_1.dw_1.width * 0.30
	tab_1.tabpage_6.dw_6_sel.x = (this.width - tab_1.tabpage_1.dw_1_sel.width) - 45
	tab_1.tabpage_6.dw_6_sel.y = tab_1.tabpage_1.dw_1.y + 30

	tab_1.tabpage_7.dw_7.width = tab_1.tabpage_7.width - kk_barra_width
	tab_1.tabpage_7.dw_7.height = tab_1.tabpage_7.height - kk_barra_height
	tab_1.tabpage_7.dw_7.x =  1// (tab_1.tabpage_5.width - tab_1.tabpage_5.dw_5.width) / 2
	tab_1.tabpage_7.dw_7.y =  1// (tab_1.tabpage_5.height - tab_1.tabpage_5.dw_5.height) / 2

	tab_1.tabpage_7.dw_7_sel.height = tab_1.tabpage_1.dw_1.height * 0.70
	tab_1.tabpage_7.dw_7_sel.width = tab_1.tabpage_1.dw_1.width * 0.30
	tab_1.tabpage_7.dw_7_sel.x = (this.width - tab_1.tabpage_1.dw_1_sel.width) - 45
	tab_1.tabpage_7.dw_7_sel.y = tab_1.tabpage_1.dw_1.y + 30

	tab_1.tabpage_8.dw_8.width = tab_1.tabpage_8.width - kk_barra_width
	tab_1.tabpage_8.dw_8.height = tab_1.tabpage_8.height - kk_barra_height
	tab_1.tabpage_8.dw_8.x =  1// (tab_1.tabpage_5.width - tab_1.tabpage_5.dw_5.width) / 2
	tab_1.tabpage_8.dw_8.y =  1// (tab_1.tabpage_5.height - tab_1.tabpage_5.dw_5.height) / 2

	tab_1.tabpage_8.dw_8_sel.height = tab_1.tabpage_1.dw_1.height * 0.70
	tab_1.tabpage_8.dw_8_sel.width = tab_1.tabpage_1.dw_1.width * 0.30
	tab_1.tabpage_8.dw_8_sel.x = (this.width - tab_1.tabpage_1.dw_1_sel.width) - 45
	tab_1.tabpage_8.dw_8_sel.y = tab_1.tabpage_1.dw_1.y + 30

	tab_1.tabpage_9.dw_9.width = tab_1.tabpage_9.width - kk_barra_width
	tab_1.tabpage_9.dw_9.height = tab_1.tabpage_9.height - kk_barra_height
	tab_1.tabpage_9.dw_9.x =  1// (tab_1.tabpage_5.width - tab_1.tabpage_5.dw_5.width) / 2
	tab_1.tabpage_9.dw_9.y =  1// (tab_1.tabpage_5.height - tab_1.tabpage_5.dw_5.height) / 2

	tab_1.tabpage_9.dw_9_sel.height = tab_1.tabpage_1.dw_1.height * 0.70
	tab_1.tabpage_9.dw_9_sel.width = tab_1.tabpage_1.dw_1.width * 0.30
	tab_1.tabpage_9.dw_9_sel.x = (this.width - tab_1.tabpage_1.dw_1_sel.width) - 45
	tab_1.tabpage_9.dw_9_sel.y = tab_1.tabpage_1.dw_1.y + 30

	
//	this.setredraw(true)

//end if	

this.setredraw(true)



end subroutine

public subroutine u_attiva_tasti ();//
attiva_tasti( )
end subroutine

on w_g_tab_elenco_old.create
int iCurrent
call super::create
this.cb_visualizza=create cb_visualizza
this.cb_modifica=create cb_modifica
this.cb_conferma=create cb_conferma
this.cb_cancella=create cb_cancella
this.cb_inserisci=create cb_inserisci
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_visualizza
this.Control[iCurrent+2]=this.cb_modifica
this.Control[iCurrent+3]=this.cb_conferma
this.Control[iCurrent+4]=this.cb_cancella
this.Control[iCurrent+5]=this.cb_inserisci
this.Control[iCurrent+6]=this.tab_1
end on

on w_g_tab_elenco_old.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_visualizza)
destroy(this.cb_modifica)
destroy(this.cb_conferma)
destroy(this.cb_cancella)
destroy(this.cb_inserisci)
destroy(this.tab_1)
end on

event u_open_preliminari;call super::u_open_preliminari;//
	ki_nome_save = trim(this.ClassName())

//--- Parametri passati con il WITHPARM
	kist1_open_w = message.powerobjectparm
	kist1_open_w.key3 = " "
	ki_nome_save =  trim(kist1_open_w.key2)

	ki_st_open_w = kist1_open_w

	
end event

event open;//
//=== Parametri di Input : 1  lung 2   scelta; 
//===								3  lung 20  Key principale
//===								23 lung 1   's'=adatta windows alla definiz.
//===								24 lung 26  Libero x future implem
//===								50 lung ??  Personalizzabile
//===								
//
long k_ctr


//--- INIZIO OPERAZIONI PRELIMINARI --------------------------------------------------------------------------

//sembra nascondere il puntatore	this.setredraw(false)
	
//--- Importante: personalizzazione x i figli	
	event u_open_preliminari()   

//--- assegna il puntatore alla Window x renderlo visibile negli script
	kiw_this_window = this
	
//--- setta la directory di base
	kGuf_data_base.setta_path_default ()

//--- setta il titolo della window
	set_titolo_window()

//--- oggetto utile alla sincronizzazione con una window chiamata, es canc di una riga dall'elenco
	kiuf1_sync_window = create kuf_sync_window

//---- oggetto generico 
	kiuf_parent = create kuf_parent

//--- FINE !!!! OPERAZIONI PRELIMINARI --------------------------------------------------------------------------

	setpointer(kkg.pointer_attesa)

//	//--- Menu Window
//	if this.windowtype = response! or this.windowtype = popup! then
//	else
//		post set_window_size()	
//
//		ki_menu = ki_menu_0
// 		this.ChangeMenu (ki_menu)
//		ki_menu.autorizza_menu( )
//		ki_menu.u_inizializza( )
//		ki_menu.u_espone_testo_delete(ki_menu_espone_tasto_delete)
//			
//	end if
	
//--- altre operazioni
	post event u_open( )

//	setpointer(kkg.pointer_default)		


end event

event u_open;call super::u_open;//
//
//--- setta la directory di base
	kGuf_data_base.setta_path_default ()

	set_titolo_window()


//=== Imposta il titolo della wind. nella dw x la desc. in una eventuale stampa
	kidw_lista_elenco.tag = this.title
	
	kiuf1_g_tab_elenco = create kuf_g_tab_elenco

	inizializza_lista()
	
	fine_primo_giro()

	kGuo_g.kgw_attiva = this

	post attiva_tasti()

end event

type st_ritorna from w_g_tab`st_ritorna within w_g_tab_elenco_old
end type

type st_ordina_lista from w_g_tab`st_ordina_lista within w_g_tab_elenco_old
end type

type st_aggiorna_lista from w_g_tab`st_aggiorna_lista within w_g_tab_elenco_old
integer x = 1961
integer y = 1140
end type

type cb_ritorna from w_g_tab`cb_ritorna within w_g_tab_elenco_old
integer x = 2523
integer y = 1088
integer width = 329
integer height = 88
end type

type st_stampa from w_g_tab`st_stampa within w_g_tab_elenco_old
integer x = 1961
integer y = 1012
end type

type cb_visualizza from commandbutton within w_g_tab_elenco_old
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

event clicked;//
uo_d_std_1 kdw_focus
datastore kds_1
//st_tab_menu_window_anteprima kst_tab_menu_window_anteprima
//st_open_w kst_open_w
//kuf_menu_window kuf1_menu_window


try

	kdw_focus = u_get_dw( )
	if kdw_focus.rowcount( ) > 0 then

		kds_1 = create datastore
		kds_1.dataobject = kdw_focus.dataobject
		if kdw_focus.getrow( ) = 0 then kdw_focus.setrow(1) 
		kdw_focus.rowscopy( kdw_focus.getrow( ) , kdw_focus.getrow( ), primary!, kds_1, 1, primary!)

//		kuf1_menu_window = create kuf_menu_window
		kguf_menu_window.open_w_tabelle_da_ds(kds_1, kkg_flag_modalita.visualizzazione)
		
		
//		kuf1_menu_window = create kuf_menu_window
//		kst_tab_menu_window_anteprima.anteprima = kdw_focus.dataobject
//		kuf1_menu_window.get_st_tab_menu_window_anteprima(kst_tab_menu_window_anteprima)
//		
//		kst_open_w.id_programma = kst_tab_menu_window_anteprima.id_menu_window
//		kst_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
//		kst_open_w.key9 = kst_tab_menu_window_anteprima.nome_id_tabella
//		kst_open_w.key11_ds = create datastore
//		kst_open_w.key11_ds.dataobject = kdw_focus.dataobject
//		kdw_focus.rowscopy( kdw_focus.getrow( ) , kdw_focus.getrow( ), primary!, kst_open_w.key11_ds, 1, primary!)
//		kst_open_w.key11_ds.setrow(1)
//		
//		kuf1_menu_window.u_open_funzione(kst_open_w)
		
	//	if kdw_focus.dataobject = "d_meca_1_anteprima" then
	//		
	//		if kdw_focus.getrow() = 0 then kdw_focus.setrow(1)
	//		
	//		kst_tab_g_0.id = kdw_focus.getitemnumber(kdw_focus.getrow(),"id_meca")
	//		
	//		kuf1_armo = create kuf_armo
	//		kuf1_armo.u_open_applicazione(kst_tab_g_0, kkg_flag_modalita.visualizzazione )
	//		
	//	end if
		
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try
end event

type cb_modifica from commandbutton within w_g_tab_elenco_old
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

event clicked;//
uo_d_std_1 kdw_focus
//st_tab_menu_window_anteprima kst_tab_menu_window_anteprima
//st_open_w kst_open_w
datastore kds_1
//kuf_menu_window kuf1_menu_window


try

	kdw_focus = u_get_dw( )
	if kdw_focus.rowcount( ) > 0 then
		
		kds_1 = create datastore
		kds_1.dataobject = kdw_focus.dataobject
		if kdw_focus.getrow( ) = 0 then kdw_focus.setrow(1) 
		kdw_focus.rowscopy( kdw_focus.getrow( ) , kdw_focus.getrow( ), primary!, kds_1, 1, primary!)

		//kuf1_menu_window = create kuf_menu_window
		kGuf_menu_window.open_w_tabelle_da_ds(kds_1, kkg_flag_modalita.modifica)

//		kuf1_menu_window = create kuf_menu_window
//		kst_tab_menu_window_anteprima.anteprima = kdw_focus.dataobject
//		kuf1_menu_window.get_st_tab_menu_window_anteprima(kst_tab_menu_window_anteprima)
//		
//		kst_open_w.id_programma = kst_tab_menu_window_anteprima.id_menu_window
//		kst_open_w.flag_modalita = kkg_flag_modalita.modifica
//		kst_open_w.key9 = kst_tab_menu_window_anteprima.nome_id_tabella
//		kst_open_w.key11_ds = create datastore
//		kst_open_w.key11_ds.dataobject = kdw_focus.dataobject
//		kdw_focus.rowscopy( kdw_focus.getrow( ) , kdw_focus.getrow( ), primary!, kst_open_w.key11_ds, 1, primary!)
//		kst_open_w.key11_ds.setrow(1)
//		
//		kuf1_menu_window.u_open_funzione(kst_open_w)
		
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try
end event

type cb_conferma from commandbutton within w_g_tab_elenco_old
boolean visible = false
integer x = 69
integer y = 832
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

if this.enabled then
	this.enabled = false
	if conferma_dati( ) = "EXIT" then
	
		cb_ritorna.post event clicked( )
		
	else
		
		this.enabled = true

	end if
end if
end event

type cb_cancella from commandbutton within w_g_tab_elenco_old
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
//cancella()
end event

type cb_inserisci from commandbutton within w_g_tab_elenco_old
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

event clicked;//
uo_d_std_1 kdw_focus
//st_tab_menu_window_anteprima kst_tab_menu_window_anteprima
st_open_w kst_open_w
datastore kds_1
//kuf_menu_window kuf1_menu_window


try

	kdw_focus = u_get_dw( )
	kds_1 = create datastore
	kds_1.dataobject = kdw_focus.dataobject

	if kdw_focus.rowcount( ) > 0 then
		if kdw_focus.getrow( ) = 0 then kdw_focus.setrow(1) 
		kdw_focus.rowscopy( kdw_focus.getrow( ) , kdw_focus.getrow( ), primary!, kds_1, 1, primary!)
	end if
	
	//kuf1_menu_window = create kuf_menu_window
	kGuf_menu_window.open_w_tabelle_da_ds(kds_1, kkg_flag_modalita.inserimento)
		
//		kuf1_menu_window = create kuf_menu_window
//		kst_tab_menu_window_anteprima.anteprima = kdw_focus.dataobject
//		kuf1_menu_window.get_st_tab_menu_window_anteprima(kst_tab_menu_window_anteprima)
//		
//		kst_open_w.id_programma = kst_tab_menu_window_anteprima.id_menu_window
//		kst_open_w.flag_modalita = kkg_flag_modalita.inserimento
//		kst_open_w.key9 = kst_tab_menu_window_anteprima.nome_id_tabella
//		kst_open_w.key11_ds = create datastore
//		kst_open_w.key11_ds.dataobject = kdw_focus.dataobject
//		kdw_focus.rowscopy( kdw_focus.getrow( ) , kdw_focus.getrow( ), primary!, kst_open_w.key11_ds, 1, primary!)
//		kst_open_w.key11_ds.setrow(1)
//		
//		kuf1_menu_window.u_open_funzione(kst_open_w)
		
//	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try
end event

type tab_1 from tab within w_g_tab_elenco_old
boolean visible = false
integer x = 14
integer y = 16
integer width = 3886
integer height = 872
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 31449055
boolean multiline = true
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
tabpage_8 tabpage_8
tabpage_9 tabpage_9
end type

event constructor;//
this.backcolor = parent.backcolor

end event

event selectionchanged;//
long k_riga=0
pointer kp_oldpointer


try 
	
	ki_selecttab = newindex
//	parent.triggerevent(resize!)
//
	if tab_1.tabpage_1.dw_1.rowcount() > 0 then
		tab_1.tabpage_1.dw_1.accepttext()
	end if
	if tab_1.tabpage_2.dw_2.rowcount() > 0 then
		tab_1.tabpage_2.dw_2.accepttext()
	end if
	if tab_1.tabpage_3.dw_3.rowcount() > 0 then
		tab_1.tabpage_3.dw_3.accepttext()
	end if
	if tab_1.tabpage_4.dw_4.rowcount() > 0 then
		tab_1.tabpage_4.dw_4.accepttext()
	end if
	if tab_1.tabpage_5.dw_5.rowcount() > 0 then
		tab_1.tabpage_5.dw_5.accepttext()
	end if
	if tab_1.tabpage_6.dw_6.rowcount() > 0 then
		tab_1.tabpage_6.dw_6.accepttext()
	end if
	if tab_1.tabpage_7.dw_7.rowcount() > 0 then
		tab_1.tabpage_7.dw_7.accepttext()
	end if
	if tab_1.tabpage_8.dw_8.rowcount() > 0 then
		tab_1.tabpage_8.dw_8.accepttext()
	end if
	if tab_1.tabpage_9.dw_9.rowcount() > 0 then
		tab_1.tabpage_9.dw_9.accepttext()
	end if

	if oldindex > 0 then

//=== Puntatore Cursore da attesa..... 
		SetPointer(kkg.pointer_attesa)

//		oldindex = 1
		tab_1.tag = string(oldindex)

		choose case newindex 
			case 1 
//				if tab_1.tabpage_1.dw_1.rowcount() = 0 then
					kidw_lista_elenco = tab_1.tabpage_1.dw_1
					kidw_lista_elenco_sel = tab_1.tabpage_1.dw_1_sel
					
					inizializza()
//				end if
			case 2
				kidw_lista_elenco = tab_1.tabpage_2.dw_2
				kidw_lista_elenco_sel = tab_1.tabpage_2.dw_2_sel
					
				inizializza_1()
			case 3
				kidw_lista_elenco = tab_1.tabpage_3.dw_3
				kidw_lista_elenco_sel = tab_1.tabpage_3.dw_3_sel
					
				inizializza_2()
			case 4
				kidw_lista_elenco = tab_1.tabpage_4.dw_4
				kidw_lista_elenco_sel = tab_1.tabpage_4.dw_4_sel
					
				inizializza_3()
			case 5
				kidw_lista_elenco = tab_1.tabpage_5.dw_5
				kidw_lista_elenco_sel = tab_1.tabpage_5.dw_5_sel
					
				inizializza_4()
			case 6
				kidw_lista_elenco = tab_1.tabpage_6.dw_6
				kidw_lista_elenco_sel = tab_1.tabpage_6.dw_6_sel
					
				inizializza_5()
			case 7
				kidw_lista_elenco = tab_1.tabpage_7.dw_7
				kidw_lista_elenco_sel = tab_1.tabpage_7.dw_7_sel
					
				inizializza_6()
			case 8
				kidw_lista_elenco = tab_1.tabpage_8.dw_8
				kidw_lista_elenco_sel = tab_1.tabpage_8.dw_8_sel
					
				inizializza_7()
			case 9
				kidw_lista_elenco = tab_1.tabpage_9.dw_9
				kidw_lista_elenco_sel = tab_1.tabpage_9.dw_9_sel
					
				inizializza_8()
		end choose	

		riposiziona_cursore(kidw_lista_elenco)   // riga seleziona
		if isvalid(kidw_lista_elenco) then kidw_lista_elenco.setredraw(true)
		kidw_lista_elenco_sel.visible = false
	
		SetPointer(kkg.pointer_default)

	end if
	
catch (uo_exception kuo_exception1)
	kuo_exception1.messaggio_utente()
finally
	POST attiva_tasti()
end try

k_riga = 0
	
end event

event key;//
//=== Controllo quale tasto da tastiera ha premuto
int k_null

setnull(k_null)


choose case key
	case keypagedown!
		if tab_1.selectedtab = 1 and tab_1.tabpage_2.visible = true and &
			tab_1.tabpage_2.enabled = true then
			tab_1.selectedtab = 2
		else
			if tab_1.selectedtab = 2 and tab_1.tabpage_3.visible = true and &
				tab_1.tabpage_3.enabled = true then
				tab_1.selectedtab = 3
			else
				if tab_1.selectedtab = 3 and tab_1.tabpage_4.visible = true and &
					tab_1.tabpage_4.enabled = true then
					tab_1.selectedtab = 4
				else
					if tab_1.selectedtab = 4 and tab_1.tabpage_5.visible = true and &
						tab_1.tabpage_5.enabled = true then
						tab_1.selectedtab = 5
					else
						if tab_1.selectedtab = 5 and tab_1.tabpage_6.visible = true and &
							tab_1.tabpage_6.enabled = true then
							tab_1.selectedtab = 6
						else
							if tab_1.selectedtab = 6 and tab_1.tabpage_7.visible = true and &
								tab_1.tabpage_6.enabled = true then
								tab_1.selectedtab = 7
							else
								if tab_1.selectedtab = 7 and tab_1.tabpage_8.visible = true and &
									tab_1.tabpage_6.enabled = true then
									tab_1.selectedtab = 8
								else
									if tab_1.selectedtab = 8 and tab_1.tabpage_9.visible = true and &
										tab_1.tabpage_6.enabled = true then
										tab_1.selectedtab = 9
									else
										tab_1.selectedtab = 1
									end if
								end if
							end if
						end if
					end if
				end if
			end if
		end if
	case keypageup!
		
		choose case tab_1.selectedtab 
		
			case 1
				if tab_1.tabpage_9.visible = true and &
					tab_1.tabpage_9.enabled = true then
					tab_1.selectedtab = 9
				else
				if tab_1.tabpage_8.visible = true and &
					tab_1.tabpage_8.enabled = true then
					tab_1.selectedtab = 8
				else
				if tab_1.tabpage_7.visible = true and &
					tab_1.tabpage_7.enabled = true then
					tab_1.selectedtab = 7
				else
				if tab_1.tabpage_6.visible = true and &
					tab_1.tabpage_6.enabled = true then
					tab_1.selectedtab = 6
				else
				if tab_1.tabpage_5.visible = true and &
					tab_1.tabpage_5.enabled = true then
					tab_1.selectedtab = 5
				else
				if tab_1.tabpage_4.visible = true and &
					tab_1.tabpage_4.enabled = true then
					tab_1.selectedtab = 4
				else
				if tab_1.tabpage_3.visible = true and &
					tab_1.tabpage_3.enabled = true then
					tab_1.selectedtab = 3
				else
				if tab_1.tabpage_2.visible = true and &
					tab_1.tabpage_2.enabled = true then
					tab_1.selectedtab = 2
					
				end if
				end if
				end if
				end if
				end if
				end if
				end if
				end if
				
			case 2
				if tab_1.tabpage_1.visible = true and &
					tab_1.tabpage_1.enabled = true then
					tab_1.selectedtab = 1
				end if
					
			case 3
				if tab_1.tabpage_2.visible = true and &
					tab_1.tabpage_2.enabled = true then
					tab_1.selectedtab = 2
				end if
					
			case 4
				if tab_1.tabpage_3.visible = true and &
					tab_1.tabpage_3.enabled = true then
					tab_1.selectedtab = 3
				end if
					
			case 5
				if tab_1.tabpage_4.visible = true and &
					tab_1.tabpage_4.enabled = true then
					tab_1.selectedtab = 4
				end if
					
			case 6
				if tab_1.tabpage_5.visible = true and &
					tab_1.tabpage_5.enabled = true then
					tab_1.selectedtab = 5
				end if
					
			case 7
				if tab_1.tabpage_6.visible = true and &
					tab_1.tabpage_6.enabled = true then
					tab_1.selectedtab = 6
				end if
					
			case 8
				if tab_1.tabpage_7.visible = true and &
					tab_1.tabpage_7.enabled = true then
					tab_1.selectedtab = 7
				end if
					
			case 9
				if tab_1.tabpage_8.visible = true and &
					tab_1.tabpage_8.enabled = true then
					tab_1.selectedtab = 8
				end if
		end choose
		
	case else
		parent.trigger event key (key, 0)
		
end choose

			

end event

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.tabpage_7=create tabpage_7
this.tabpage_8=create tabpage_8
this.tabpage_9=create tabpage_9
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
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
destroy(this.tabpage_7)
destroy(this.tabpage_8)
destroy(this.tabpage_9)
end on

type tabpage_1 from userobject within tab_1
event rbuttonup pbm_rbuttonup
integer x = 18
integer y = 48
integer width = 3849
integer height = 808
long backcolor = 32435950
long tabtextcolor = 134217735
long tabbackcolor = 32435950
long picturemaskcolor = 32435950
dw_1 dw_1
st_1_retrieve st_1_retrieve
dw_1_sel dw_1_sel
end type

on tabpage_1.create
this.dw_1=create dw_1
this.st_1_retrieve=create st_1_retrieve
this.dw_1_sel=create dw_1_sel
this.Control[]={this.dw_1,&
this.st_1_retrieve,&
this.dw_1_sel}
end on

on tabpage_1.destroy
destroy(this.dw_1)
destroy(this.st_1_retrieve)
destroy(this.dw_1_sel)
end on

type dw_1 from uo_d_std_1 within tabpage_1
integer x = 14
integer y = 32
integer width = 1029
integer height = 568
integer taborder = 50
boolean enabled = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean ki_link_standard_sempre_possibile = true
boolean ki_db_conn_standard = false
end type

event getfocus;call super::getfocus;
//
kidw_selezionata = this


end event

event sqlpreview;call super::sqlpreview;//
//--- salvo la query di select x "salvataggio e avvio veloce delle liste dw"
	ki_syntaxquery = sqlsyntax

end event

event doubleclicked;//
if row < 1 then
	return 1
end if
//if cb_conferma.enabled then 
//	
//	conferma_selezione()
//	
//end if
//
if cb_conferma.enabled = true then 
	kist1_open_w.key5 = " " //--- nessun pulsante pigiato
	cb_conferma.event clicked( ) 
end if


end event

event ue_drag_out;call super::ue_drag_out;//

//if this.ki_in_DRAG and 
if cb_conferma.enabled then 

	
//	ki_st_open_w.key5 = " " //--- nessun pulsante pigiato
//	cb_conferma.triggerevent(clicked!)
	
//--- x postare nella dw dei "cliccati" tutte le righe  selezionate
	
	togli_righe_selezionate()
	
end if

return 1

end event

event ue_drop_out;call super::ue_drop_out;//

cb_conferma.event clicked( ) 

return 1

end event

event ue_dwnkey;call super::ue_dwnkey;//
	u_key(key, keyflags)


end event

event clicked;call super::clicked;//
//kiw_this_window.event activate( )
attiva_tasti()

end event

type st_1_retrieve from statictext within tabpage_1
boolean visible = false
integer x = 1152
integer y = 132
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type dw_1_sel from uo_d_std_1 within tabpage_1
integer x = 1504
integer y = 80
integer width = 631
integer height = 616
integer taborder = 30
boolean enabled = true
boolean titlebar = true
string title = "righe selezionate"
boolean controlmenu = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean ki_attiva_dragdrop = true
end type

event ue_aggiungi_riga;call super::ue_aggiungi_riga;//--- aggiunge riga 
kidw_lista_elenco.rowsmove(a_riga, a_riga , Primary!, this, 1,Primary!)


end event

event getfocus;call super::getfocus;
//
kidw_selezionata = this


end event

event sqlpreview;call super::sqlpreview;//
//--- salvo la query di select x "salvataggio e avvio veloce delle liste dw"
	ki_syntaxquery = sqlsyntax

end event

type tabpage_2 from userobject within tab_1
event rbuttonup ( )
boolean visible = false
integer x = 18
integer y = 48
integer width = 3849
integer height = 808
boolean enabled = false
long backcolor = 31449055
long tabtextcolor = 33554432
long tabbackcolor = 31449055
long picturemaskcolor = 536870912
dw_2_sel dw_2_sel
st_2_retrieve st_2_retrieve
dw_2 dw_2
end type

on tabpage_2.create
this.dw_2_sel=create dw_2_sel
this.st_2_retrieve=create st_2_retrieve
this.dw_2=create dw_2
this.Control[]={this.dw_2_sel,&
this.st_2_retrieve,&
this.dw_2}
end on

on tabpage_2.destroy
destroy(this.dw_2_sel)
destroy(this.st_2_retrieve)
destroy(this.dw_2)
end on

type dw_2_sel from uo_d_std_1 within tabpage_2
integer x = 1079
integer y = 44
integer width = 631
integer height = 616
integer taborder = 40
boolean enabled = true
boolean titlebar = true
string title = "righe selezionate"
boolean controlmenu = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean ki_attiva_dragdrop = true
end type

event ue_aggiungi_riga;call super::ue_aggiungi_riga;//--- aggiunge riga 
kidw_lista_elenco.rowsmove(a_riga, a_riga , Primary!, this, 1,Primary!)


end event

event getfocus;call super::getfocus;
//
kidw_selezionata = this


end event

event sqlpreview;call super::sqlpreview;//
//--- salvo la query di select x "salvataggio e avvio veloce delle liste dw"
	ki_syntaxquery = sqlsyntax

end event

type st_2_retrieve from statictext within tabpage_2
boolean visible = false
integer x = 1189
integer y = 100
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type dw_2 from uo_d_std_1 within tabpage_2
integer x = 23
integer y = 52
integer width = 1038
integer height = 916
integer taborder = 30
boolean hscrollbar = true
boolean vscrollbar = true
boolean ki_link_standard_sempre_possibile = true
end type

event getfocus;call super::getfocus;//
kidw_selezionata = this


end event

event itemchanged;call super::itemchanged;//// fino a che non e' a posto il bug che la funzione non viene lanciata da u_d_std_1
//post	attiva_tasti()
//
end event

event doubleclicked;//
if row < 1 then
	return 1
end if
if cb_conferma.enabled = true then 
//	ki_riga_selected = row
	kist2_open_w.key5 = " " //--- nessun pulsante pigiato
	cb_conferma.event clicked( ) 
	//conferma_dati( )
	
end if


end event

event ue_drag_out;call super::ue_drag_out;//

//if this.ki_in_DRAG and 
if cb_conferma.enabled then 

	
//	ki_st_open_w.key5 = " " //--- nessun pulsante pigiato
//	cb_conferma.triggerevent(clicked!)
	
//--- x postare nella dw dei "cliccati" tutte le righe  selezionate
	
	togli_righe_selezionate()
	
end if

return 1

end event

event ue_drop_out;call super::ue_drop_out;//

//if this.ki_in_DRAG and 
if cb_conferma.enabled then 

	
//	ki_st_open_w.key5 = " " //--- nessun pulsante pigiato
	cb_conferma.triggerevent(clicked!)
	
//--- x postare nella dw dei "cliccati" tutte le righe  selezionate
	
//	togli_righe_selezionate()
	
end if

return 1


end event

event sqlpreview;call super::sqlpreview;//
//--- salvo la query di select x "salvataggio e avvio veloce delle liste dw"
	ki_syntaxquery = sqlsyntax

end event

event ue_dwnkey;call super::ue_dwnkey;//
	u_key(key, keyflags)


end event

event clicked;call super::clicked;//
//kiw_this_window.event activate( )
attiva_tasti()

end event

type tabpage_3 from userobject within tab_1
event rbuttonup pbm_rbuttonup
boolean visible = false
integer x = 18
integer y = 48
integer width = 3849
integer height = 808
boolean enabled = false
long backcolor = 31449055
long tabtextcolor = 33554432
long tabbackcolor = 31449055
long picturemaskcolor = 536870912
dw_3_sel dw_3_sel
st_3_retrieve st_3_retrieve
dw_3 dw_3
end type

on tabpage_3.create
this.dw_3_sel=create dw_3_sel
this.st_3_retrieve=create st_3_retrieve
this.dw_3=create dw_3
this.Control[]={this.dw_3_sel,&
this.st_3_retrieve,&
this.dw_3}
end on

on tabpage_3.destroy
destroy(this.dw_3_sel)
destroy(this.st_3_retrieve)
destroy(this.dw_3)
end on

type dw_3_sel from uo_d_std_1 within tabpage_3
integer x = 1079
integer y = 44
integer width = 631
integer height = 616
integer taborder = 40
boolean enabled = true
boolean titlebar = true
string title = "righe selezionate"
boolean controlmenu = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean ki_attiva_dragdrop = true
end type

event ue_aggiungi_riga;call super::ue_aggiungi_riga;//--- aggiunge riga 
kidw_lista_elenco.rowsmove(a_riga, a_riga , Primary!, this, 1,Primary!)


end event

event getfocus;call super::getfocus;
//
kidw_selezionata = this


end event

event sqlpreview;call super::sqlpreview;//
//--- salvo la query di select x "salvataggio e avvio veloce delle liste dw"
	ki_syntaxquery = sqlsyntax

end event

type st_3_retrieve from statictext within tabpage_3
boolean visible = false
integer x = 1225
integer y = 116
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type dw_3 from uo_d_std_1 within tabpage_3
integer x = 14
integer y = 40
integer width = 1074
integer height = 884
integer taborder = 40
boolean hscrollbar = true
boolean vscrollbar = true
boolean ki_link_standard_sempre_possibile = true
end type

event getfocus;call super::getfocus;
//
kidw_selezionata = this


end event

event itemchanged;call super::itemchanged;//// fino a che non e' a posto il bug che la funzione non viene lanciata da u_d_std_1
//post	attiva_tasti()
//
end event

event doubleclicked;//
if row < 1 then
	return 1
end if
if cb_conferma.enabled = true then 
//	ki_riga_selected = row
	kist3_open_w.key5 = " " //--- nessun pulsante pigiato
	cb_conferma.event clicked( ) 
	//conferma_dati( )
end if

end event

event ue_drag_out;call super::ue_drag_out;//

//if this.ki_in_DRAG and 
if cb_conferma.enabled then 

	
//	ki_st_open_w.key5 = " " //--- nessun pulsante pigiato
//	cb_conferma.triggerevent(clicked!)
	
//--- x postare nella dw dei "cliccati" tutte le righe  selezionate
	
	togli_righe_selezionate()
	
end if

return 1

end event

event ue_drop_out;call super::ue_drop_out;//

//if this.ki_in_DRAG and 
if cb_conferma.enabled then 

	
//	ki_st_open_w.key5 = " " //--- nessun pulsante pigiato
	cb_conferma.triggerevent(clicked!)
	
//--- x postare nella dw dei "cliccati" tutte le righe  selezionate
	
//	togli_righe_selezionate()
	
end if

return 1


end event

event sqlpreview;call super::sqlpreview;//
//--- salvo la query di select x "salvataggio e avvio veloce delle liste dw"
	ki_syntaxquery = sqlsyntax

end event

event ue_dwnkey;call super::ue_dwnkey;//
	u_key(key, keyflags)

end event

event clicked;call super::clicked;//
//kiw_this_window.event activate( )
attiva_tasti()

end event

type tabpage_4 from userobject within tab_1
event rbuttonup pbm_rbuttonup
boolean visible = false
integer x = 18
integer y = 48
integer width = 3849
integer height = 808
boolean enabled = false
long backcolor = 31449055
long tabtextcolor = 33554432
long tabbackcolor = 31449055
long picturemaskcolor = 536870912
dw_4_sel dw_4_sel
st_4_retrieve st_4_retrieve
dw_4 dw_4
end type

on tabpage_4.create
this.dw_4_sel=create dw_4_sel
this.st_4_retrieve=create st_4_retrieve
this.dw_4=create dw_4
this.Control[]={this.dw_4_sel,&
this.st_4_retrieve,&
this.dw_4}
end on

on tabpage_4.destroy
destroy(this.dw_4_sel)
destroy(this.st_4_retrieve)
destroy(this.dw_4)
end on

type dw_4_sel from uo_d_std_1 within tabpage_4
integer x = 1079
integer y = 44
integer width = 631
integer height = 616
integer taborder = 40
boolean enabled = true
boolean titlebar = true
string title = "righe selezionate"
boolean controlmenu = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean ki_attiva_dragdrop = true
end type

event ue_aggiungi_riga;call super::ue_aggiungi_riga;//--- aggiunge riga 
kidw_lista_elenco.rowsmove(a_riga, a_riga , Primary!, this, 1,Primary!)


end event

event getfocus;call super::getfocus;
//
kidw_selezionata = this


end event

event sqlpreview;call super::sqlpreview;//
//--- salvo la query di select x "salvataggio e avvio veloce delle liste dw"
	ki_syntaxquery = sqlsyntax

end event

type st_4_retrieve from statictext within tabpage_4
boolean visible = false
integer x = 1179
integer y = 148
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type dw_4 from uo_d_std_1 within tabpage_4
integer x = 32
integer y = 32
integer width = 992
integer height = 868
integer taborder = 20
boolean hscrollbar = true
boolean vscrollbar = true
boolean ki_link_standard_sempre_possibile = true
end type

event getfocus;call super::getfocus;
//
kidw_selezionata = this


end event

event itemchanged;call super::itemchanged;////
//post attiva_tasti()
end event

event sqlpreview;call super::sqlpreview;//
//--- salvo la query di select x "salvataggio e avvio veloce delle liste dw"
	ki_syntaxquery = sqlsyntax

end event

event ue_drop_out;call super::ue_drop_out;//

//if this.ki_in_DRAG and 
if cb_conferma.enabled then 

	
//	ki_st_open_w.key5 = " " //--- nessun pulsante pigiato
	cb_conferma.triggerevent(clicked!)
	
//--- x postare nella dw dei "cliccati" tutte le righe  selezionate
	
//	togli_righe_selezionate()
	
end if

return 1


end event

event ue_drag_out;call super::ue_drag_out;//

//if this.ki_in_DRAG and 
if cb_conferma.enabled then 

	
//	ki_st_open_w.key5 = " " //--- nessun pulsante pigiato
//	cb_conferma.triggerevent(clicked!)
	
//--- x postare nella dw dei "cliccati" tutte le righe  selezionate
	
	togli_righe_selezionate()
	
end if

return 1

end event

event doubleclicked;//
if row < 1 then
	return 1
end if
if cb_conferma.enabled = true then 
//	ki_riga_selected = row
	kist4_open_w.key5 = " " //--- nessun pulsante pigiato
	cb_conferma.event clicked( ) 
	//conferma_dati( )
end if

end event

event ue_dwnkey;call super::ue_dwnkey;//
	u_key(key, keyflags)


end event

event clicked;call super::clicked;//
//kiw_this_window.event activate( )
attiva_tasti()

end event

type tabpage_5 from userobject within tab_1
event rbuttonup pbm_rbuttonup
boolean visible = false
integer x = 18
integer y = 48
integer width = 3849
integer height = 808
boolean enabled = false
long backcolor = 31449055
long tabtextcolor = 33554432
long tabbackcolor = 31449055
long picturemaskcolor = 536870912
dw_5_sel dw_5_sel
st_5_retrieve st_5_retrieve
dw_5 dw_5
end type

on tabpage_5.create
this.dw_5_sel=create dw_5_sel
this.st_5_retrieve=create st_5_retrieve
this.dw_5=create dw_5
this.Control[]={this.dw_5_sel,&
this.st_5_retrieve,&
this.dw_5}
end on

on tabpage_5.destroy
destroy(this.dw_5_sel)
destroy(this.st_5_retrieve)
destroy(this.dw_5)
end on

type dw_5_sel from uo_d_std_1 within tabpage_5
integer x = 1079
integer y = 44
integer width = 631
integer height = 616
integer taborder = 40
boolean enabled = true
boolean titlebar = true
string title = "righe selezionate"
boolean controlmenu = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean ki_attiva_dragdrop = true
end type

event getfocus;call super::getfocus;
//
kidw_selezionata = this


end event

event sqlpreview;call super::sqlpreview;//
//--- salvo la query di select x "salvataggio e avvio veloce delle liste dw"
	ki_syntaxquery = sqlsyntax

end event

event ue_aggiungi_riga;call super::ue_aggiungi_riga;//--- aggiunge riga 
kidw_lista_elenco.rowsmove(a_riga, a_riga , Primary!, this, 1,Primary!)


end event

type st_5_retrieve from statictext within tabpage_5
boolean visible = false
integer x = 1097
integer y = 140
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type dw_5 from uo_d_std_1 within tabpage_5
integer x = 91
integer y = 52
integer width = 814
integer height = 508
integer taborder = 40
boolean hscrollbar = true
boolean vscrollbar = true
boolean ki_link_standard_sempre_possibile = true
end type

event getfocus;call super::getfocus;
//
kidw_selezionata = this


end event

event itemchanged;call super::itemchanged;////
//post attiva_tasti()
end event

event doubleclicked;//
if row < 1 then
	return 1
end if
if cb_conferma.enabled = true then 
//	ki_riga_selected = row
	kist5_open_w.key5 = " " //--- nessun pulsante pigiato
	cb_conferma.event clicked( ) 
	//conferma_dati( )
end if

end event

event ue_drag_out;call super::ue_drag_out;//

//if this.ki_in_DRAG and 
if cb_conferma.enabled then 

	
//	ki_st_open_w.key5 = " " //--- nessun pulsante pigiato
//	cb_conferma.triggerevent(clicked!)
	
//--- x postare nella dw dei "cliccati" tutte le righe  selezionate
	
	togli_righe_selezionate()
	
end if

return 1

end event

event ue_drop_out;call super::ue_drop_out;//

//if this.ki_in_DRAG and 
if cb_conferma.enabled then 

	
//	ki_st_open_w.key5 = " " //--- nessun pulsante pigiato
	cb_conferma.triggerevent(clicked!)
	
//--- x postare nella dw dei "cliccati" tutte le righe  selezionate
	
//	togli_righe_selezionate()
	
end if

return 1


end event

event sqlpreview;call super::sqlpreview;//
//--- salvo la query di select x "salvataggio e avvio veloce delle liste dw"
	ki_syntaxquery = sqlsyntax

end event

event ue_dwnkey;call super::ue_dwnkey;//
	u_key(key, keyflags)


end event

event clicked;call super::clicked;//
//kiw_this_window.event activate( )
attiva_tasti()

end event

type tabpage_6 from userobject within tab_1
event rbuttonup pbm_rbuttonup
boolean visible = false
integer x = 18
integer y = 48
integer width = 3849
integer height = 808
boolean enabled = false
long backcolor = 31449055
long tabtextcolor = 33554432
long tabbackcolor = 31449055
long picturemaskcolor = 536870912
dw_6_sel dw_6_sel
dw_6 dw_6
st_6_retrieve st_6_retrieve
end type

on tabpage_6.create
this.dw_6_sel=create dw_6_sel
this.dw_6=create dw_6
this.st_6_retrieve=create st_6_retrieve
this.Control[]={this.dw_6_sel,&
this.dw_6,&
this.st_6_retrieve}
end on

on tabpage_6.destroy
destroy(this.dw_6_sel)
destroy(this.dw_6)
destroy(this.st_6_retrieve)
end on

type dw_6_sel from uo_d_std_1 within tabpage_6
integer x = 1079
integer y = 44
integer width = 631
integer height = 616
integer taborder = 40
boolean enabled = true
boolean titlebar = true
string title = "righe selezionate"
boolean controlmenu = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean ki_attiva_dragdrop = true
end type

event ue_aggiungi_riga;call super::ue_aggiungi_riga;//--- aggiunge riga 
kidw_lista_elenco.rowsmove(a_riga, a_riga , Primary!, this, 1,Primary!)


end event

event getfocus;call super::getfocus;
//
kidw_selezionata = this


end event

event sqlpreview;call super::sqlpreview;//
//--- salvo la query di select x "salvataggio e avvio veloce delle liste dw"
	ki_syntaxquery = sqlsyntax

end event

type dw_6 from uo_d_std_1 within tabpage_6
integer x = 78
integer y = 36
integer width = 731
integer height = 528
integer taborder = 30
boolean hscrollbar = true
boolean vscrollbar = true
boolean ki_link_standard_sempre_possibile = true
end type

event getfocus;call super::getfocus;
//
kidw_selezionata = this


end event

event ue_drag_out;call super::ue_drag_out;//

//if this.ki_in_DRAG and 
if cb_conferma.enabled then 

	
//	ki_st_open_w.key5 = " " //--- nessun pulsante pigiato
//	cb_conferma.triggerevent(clicked!)
	
//--- x postare nella dw dei "cliccati" tutte le righe  selezionate
	
	togli_righe_selezionate()
	
end if

return 1

end event

event ue_drop_out;call super::ue_drop_out;//

//if this.ki_in_DRAG and 
if cb_conferma.enabled then 

	
//	ki_st_open_w.key5 = " " //--- nessun pulsante pigiato
	cb_conferma.triggerevent(clicked!)
	
//--- x postare nella dw dei "cliccati" tutte le righe  selezionate
	
//	togli_righe_selezionate()
	
end if

return 1

end event

event sqlpreview;call super::sqlpreview;//
//--- salvo la query di select x "salvataggio e avvio veloce delle liste dw"
	ki_syntaxquery = sqlsyntax

end event

event doubleclicked;//
if row < 1 then
	return 1
end if
if cb_conferma.enabled = true then 
//	ki_riga_selected = row
	kist6_open_w.key5 = " " //--- nessun pulsante pigiato
	cb_conferma.event clicked( ) 
	//conferma_dati( )
end if

end event

event ue_dwnkey;call super::ue_dwnkey;//
	u_key(key, keyflags)


end event

event clicked;call super::clicked;//
//kiw_this_window.event activate( )
attiva_tasti()

end event

type st_6_retrieve from statictext within tabpage_6
boolean visible = false
integer x = 1211
integer y = 132
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type tabpage_7 from userobject within tab_1
event rbuttonup pbm_rbuttonup
boolean visible = false
integer x = 18
integer y = 48
integer width = 3849
integer height = 808
boolean enabled = false
long backcolor = 31449055
long tabtextcolor = 33554432
long tabbackcolor = 31449055
long picturemaskcolor = 536870912
dw_7_sel dw_7_sel
dw_7 dw_7
st_7_retrieve st_7_retrieve
end type

on tabpage_7.create
this.dw_7_sel=create dw_7_sel
this.dw_7=create dw_7
this.st_7_retrieve=create st_7_retrieve
this.Control[]={this.dw_7_sel,&
this.dw_7,&
this.st_7_retrieve}
end on

on tabpage_7.destroy
destroy(this.dw_7_sel)
destroy(this.dw_7)
destroy(this.st_7_retrieve)
end on

type dw_7_sel from uo_d_std_1 within tabpage_7
integer x = 1079
integer y = 44
integer width = 631
integer height = 616
integer taborder = 40
boolean enabled = true
boolean titlebar = true
string title = "righe selezionate"
boolean controlmenu = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean ki_attiva_dragdrop = true
end type

event ue_aggiungi_riga;call super::ue_aggiungi_riga;//--- aggiunge riga 
kidw_lista_elenco.rowsmove(a_riga, a_riga , Primary!, this, 1,Primary!)


end event

event getfocus;call super::getfocus;
//
kidw_selezionata = this


end event

event sqlpreview;call super::sqlpreview;//
//--- salvo la query di select x "salvataggio e avvio veloce delle liste dw"
	ki_syntaxquery = sqlsyntax

end event

type dw_7 from uo_d_std_1 within tabpage_7
integer y = 28
integer width = 1042
integer taborder = 20
boolean hscrollbar = true
boolean vscrollbar = true
boolean ki_link_standard_sempre_possibile = true
end type

event getfocus;call super::getfocus;
//
kidw_selezionata = this


end event

event itemchanged;call super::itemchanged;////
//post attiva_tasti()
end event

event doubleclicked;//
if row < 1 then
	return 1
end if
if cb_conferma.enabled = true then 
//	ki_riga_selected = row
	kist7_open_w.key5 = " " //--- nessun pulsante pigiato
	cb_conferma.event clicked( ) 
	//conferma_dati( )
end if

end event

event sqlpreview;call super::sqlpreview;//
//--- salvo la query di select x "salvataggio e avvio veloce delle liste dw"
	ki_syntaxquery = sqlsyntax

end event

event ue_drag_out;call super::ue_drag_out;//

//if this.ki_in_DRAG and 
if cb_conferma.enabled then 

	
//	ki_st_open_w.key5 = " " //--- nessun pulsante pigiato
//	cb_conferma.triggerevent(clicked!)
	
//--- x postare nella dw dei "cliccati" tutte le righe  selezionate
	
	togli_righe_selezionate()
	
end if

return 1


end event

event ue_drop_out;call super::ue_drop_out;//

//if this.ki_in_DRAG and 
if cb_conferma.enabled then 

	
//	ki_st_open_w.key5 = " " //--- nessun pulsante pigiato
	cb_conferma.triggerevent(clicked!)
	
//--- x postare nella dw dei "cliccati" tutte le righe  selezionate
	
//	togli_righe_selezionate()
	
end if

return 1


end event

event ue_dwnkey;call super::ue_dwnkey;//
	u_key(key, keyflags)


end event

event clicked;call super::clicked;//
//kiw_this_window.event activate( )
attiva_tasti()

end event

type st_7_retrieve from statictext within tabpage_7
boolean visible = false
integer x = 1211
integer y = 132
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type tabpage_8 from userobject within tab_1
event rbuttonup pbm_rbuttonup
boolean visible = false
integer x = 18
integer y = 48
integer width = 3849
integer height = 808
boolean enabled = false
long backcolor = 31449055
long tabtextcolor = 33554432
long tabbackcolor = 31449055
long picturemaskcolor = 536870912
dw_8_sel dw_8_sel
dw_8 dw_8
st_8_retrieve st_8_retrieve
end type

on tabpage_8.create
this.dw_8_sel=create dw_8_sel
this.dw_8=create dw_8
this.st_8_retrieve=create st_8_retrieve
this.Control[]={this.dw_8_sel,&
this.dw_8,&
this.st_8_retrieve}
end on

on tabpage_8.destroy
destroy(this.dw_8_sel)
destroy(this.dw_8)
destroy(this.st_8_retrieve)
end on

type dw_8_sel from uo_d_std_1 within tabpage_8
integer x = 1079
integer y = 44
integer width = 631
integer height = 616
integer taborder = 40
boolean enabled = true
boolean titlebar = true
string title = "righe selezionate"
boolean controlmenu = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean ki_attiva_dragdrop = true
end type

event ue_aggiungi_riga;call super::ue_aggiungi_riga;//--- aggiunge riga 
kidw_lista_elenco.rowsmove(a_riga, a_riga , Primary!, this, 1,Primary!)


end event

event getfocus;call super::getfocus;
//
kidw_selezionata = this


end event

event sqlpreview;call super::sqlpreview;//
//--- salvo la query di select x "salvataggio e avvio veloce delle liste dw"
	ki_syntaxquery = sqlsyntax

end event

type dw_8 from uo_d_std_1 within tabpage_8
integer y = 28
integer width = 1042
integer taborder = 20
boolean hscrollbar = true
boolean vscrollbar = true
boolean ki_link_standard_sempre_possibile = true
end type

event getfocus;call super::getfocus;
//
kidw_selezionata = this


end event

event itemchanged;call super::itemchanged;////
//post attiva_tasti()
end event

event sqlpreview;call super::sqlpreview;//
//--- salvo la query di select x "salvataggio e avvio veloce delle liste dw"
	ki_syntaxquery = sqlsyntax


end event

event doubleclicked;//
if row < 1 then
	return 1
end if
if cb_conferma.enabled = true then 
//	ki_riga_selected = row
	kist8_open_w.key5 = " " //--- nessun pulsante pigiato
	cb_conferma.event clicked( ) 
	//conferma_dati( )
end if


end event

event ue_drag_out;call super::ue_drag_out;//

//if this.ki_in_DRAG and 
if cb_conferma.enabled then 

	
//	ki_st_open_w.key5 = " " //--- nessun pulsante pigiato
//	cb_conferma.triggerevent(clicked!)
	
//--- x postare nella dw dei "cliccati" tutte le righe  selezionate
	
	togli_righe_selezionate()
	
end if

return 1

end event

event ue_drop_out;call super::ue_drop_out;//

//if this.ki_in_DRAG and 
if cb_conferma.enabled then 

	
//	ki_st_open_w.key5 = " " //--- nessun pulsante pigiato
	cb_conferma.triggerevent(clicked!)
	
//--- x postare nella dw dei "cliccati" tutte le righe  selezionate
	
//	togli_righe_selezionate()
	
end if

return 1


end event

event ue_dwnkey;call super::ue_dwnkey;//
	u_key(key, keyflags)


end event

event clicked;call super::clicked;//
//kiw_this_window.event activate( )
attiva_tasti()

end event

type st_8_retrieve from statictext within tabpage_8
boolean visible = false
integer x = 1211
integer y = 132
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type tabpage_9 from userobject within tab_1
event rbuttonup pbm_rbuttonup
boolean visible = false
integer x = 18
integer y = 48
integer width = 3849
integer height = 808
boolean enabled = false
long backcolor = 31449055
long tabtextcolor = 33554432
long tabbackcolor = 31449055
long picturemaskcolor = 536870912
dw_9_sel dw_9_sel
dw_9 dw_9
st_9_retrieve st_9_retrieve
end type

on tabpage_9.create
this.dw_9_sel=create dw_9_sel
this.dw_9=create dw_9
this.st_9_retrieve=create st_9_retrieve
this.Control[]={this.dw_9_sel,&
this.dw_9,&
this.st_9_retrieve}
end on

on tabpage_9.destroy
destroy(this.dw_9_sel)
destroy(this.dw_9)
destroy(this.st_9_retrieve)
end on

type dw_9_sel from uo_d_std_1 within tabpage_9
integer x = 1079
integer y = 44
integer width = 631
integer height = 616
integer taborder = 40
boolean enabled = true
boolean titlebar = true
string title = "righe selezionate"
boolean controlmenu = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean ki_attiva_dragdrop = true
end type

event ue_aggiungi_riga;call super::ue_aggiungi_riga;//--- aggiunge riga 
kidw_lista_elenco.rowsmove(a_riga, a_riga , Primary!, this, 1,Primary!)


end event

event getfocus;call super::getfocus;
//
kidw_selezionata = this


end event

event sqlpreview;call super::sqlpreview;//
//--- salvo la query di select x "salvataggio e avvio veloce delle liste dw"
	ki_syntaxquery = sqlsyntax

end event

type dw_9 from uo_d_std_1 within tabpage_9
integer x = 64
integer y = 16
integer width = 1042
integer taborder = 10
boolean hscrollbar = true
boolean vscrollbar = true
boolean ki_link_standard_sempre_possibile = true
end type

event getfocus;call super::getfocus;
//
kidw_selezionata = this


end event

event itemchanged;call super::itemchanged;////
//post attiva_tasti()
end event

event ue_drop_out;call super::ue_drop_out;//

//if this.ki_in_DRAG and 
if cb_conferma.enabled then 

	
//	ki_st_open_w.key5 = " " //--- nessun pulsante pigiato
	cb_conferma.triggerevent(clicked!)
	
//--- x postare nella dw dei "cliccati" tutte le righe  selezionate
	
//	togli_righe_selezionate()
	
end if

return 1


end event

event ue_drag_out;call super::ue_drag_out;//

//if this.ki_in_DRAG and 
if cb_conferma.enabled then 

	
//	ki_st_open_w.key5 = " " //--- nessun pulsante pigiato
//	cb_conferma.triggerevent(clicked!)
	
//--- x postare nella dw dei "cliccati" tutte le righe  selezionate
	
	togli_righe_selezionate()
	
end if

return 1

end event

event doubleclicked;//
if row < 1 then
	return 1
end if
if cb_conferma.enabled = true then 
//	ki_riga_selected = row
	kist9_open_w.key5 = " " //--- nessun pulsante pigiato
	cb_conferma.event clicked( ) 
	//conferma_dati( )
end if

end event

event sqlpreview;call super::sqlpreview;//
//--- salvo la query di select x "salvataggio e avvio veloce delle liste dw"
	ki_syntaxquery = sqlsyntax

end event

event ue_dwnkey;call super::ue_dwnkey;//
	u_key(key, keyflags)


end event

event clicked;call super::clicked;//
//kiw_this_window.event activate( )
attiva_tasti()

end event

type st_9_retrieve from statictext within tabpage_9
boolean visible = false
integer x = 1211
integer y = 132
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

