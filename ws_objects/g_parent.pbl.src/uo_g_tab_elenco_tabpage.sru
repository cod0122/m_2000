$PBExportHeader$uo_g_tab_elenco_tabpage.sru
forward
global type uo_g_tab_elenco_tabpage from userobject
end type
type dw_sel from uo_d_std_1 within uo_g_tab_elenco_tabpage
end type
type dw_1 from uo_d_std_1 within uo_g_tab_elenco_tabpage
end type
end forward

global type uo_g_tab_elenco_tabpage from userobject
boolean visible = false
integer width = 1883
integer height = 940
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_sel dw_sel
dw_1 dw_1
end type
global uo_g_tab_elenco_tabpage uo_g_tab_elenco_tabpage

type variables
//
string ki_syntaxquery
//private w_g_tab_elenco kiw_g_tab_elenco
//uo_d_std_1 kidw_lista_elenco
//uo_d_std_1 kidw_lista_elenco_sel
uo_d_std_1 kidw_selezionata
datastore kids_elenco, kids_elenco_orig
st_open_w kist_open_w	
boolean ki_conferma=false, ki_disattiva_exit=false, ki_attendi_u_ricevi_da_elenco=false
kuf_utility kiuf_utility
end variables

forward prototypes
public subroutine u_zoom_meno ()
public subroutine u_zoom_off ()
public subroutine u_zoom_piu ()
public function integer togli_righe_selezionate ()
public subroutine set_dw_1_visible (boolean a_visible)
public subroutine set_dw_1_enabled (boolean a_enabled)
public function uo_d_std_1 get_dw_1 ()
public function string conferma_dati ()
public function uo_d_std_1 get_dw_sel ()
public function datastore get_ds_elenco_orig ()
public function datastore get_ds_elenco ()
public subroutine attiva_drag_drop (uo_d_std_1 adw_1)
public function string inizializza () throws uo_exception
public subroutine leggi_liste ()
public subroutine u_resize ()
public function long riposiziona_cursore ()
public subroutine mostra_elenco_selezionati ()
public subroutine attiva_evento_in_win_origine ()
public subroutine u_esegui_funzione (string a_flag_modalita)
end prototypes

public subroutine u_zoom_meno ();//
//--- diminuisce 
//
int k_zoom


	k_zoom = integer(dw_1.Object.DataWindow.Print.Preview.Zoom)
	if k_zoom < 11 then
		k_zoom = 100
	else
		k_zoom -= 10
	end if
	if k_zoom = 100 then
		dw_1.Object.DataWindow.Print.Preview = "No"
	else
		dw_1.Object.DataWindow.Print.Preview = "Yes"
	end if
	dw_1.Object.DataWindow.Print.Preview.Zoom = k_zoom
	dw_1.SetRedraw(TRUE)

end subroutine

public subroutine u_zoom_off ();//
//--- diminuisce 
//
	dw_1.Object.DataWindow.Print.Preview = "No"
	dw_1.Object.DataWindow.Print.Preview.Zoom = 100
	dw_1.SetRedraw(TRUE)

end subroutine

public subroutine u_zoom_piu ();//
//--- ingrandisce 
//
int k_zoom

	k_zoom = integer(dw_1.Object.DataWindow.Print.Preview.Zoom)
	if k_zoom > 1000 then
		k_zoom = 100
	else
		k_zoom += 10
	end if
	if k_zoom = 100 then
		dw_1.Object.DataWindow.Print.Preview = "No"
	else
		dw_1.Object.DataWindow.Print.Preview = "Yes"
	//	adw_1.Object.DataWindow.Print.Margin.Bottom = '0'
	//	adw_1.Object.DataWindow.Print.Margin.Left = '0'
	//	adw_1.Object.DataWindow.Print.Margin.Right = '0'
	//	adw_1.Object.DataWindow.Print.Margin.Top = '0'
	//	adw_1.Object.DataWindow.Print.paper.source = '0'
	end if
	dw_1.Object.DataWindow.Print.Preview.Zoom = k_zoom
	dw_1.SetRedraw(TRUE)

end subroutine

public function integer togli_righe_selezionate ();//--- x postare nella dw dei "cliccati" tutte le righe  selezionate
long k_ind_selected=0, k_return


	k_ind_selected = dw_1.getselectedrow( 0 )
	do while k_ind_selected > 0 
		
		k_return ++
		dw_sel.event ue_aggiungi_riga(k_ind_selected)
	
		k_ind_selected --
		k_ind_selected = dw_1.getselectedrow( k_ind_selected )
		
	loop
	
	
return k_return
end function

public subroutine set_dw_1_visible (boolean a_visible);//
dw_1.visible = a_visible

end subroutine

public subroutine set_dw_1_enabled (boolean a_enabled);//
dw_1.enabled = a_enabled

end subroutine

public function uo_d_std_1 get_dw_1 ();// 
return dw_1 
end function

public function string conferma_dati ();//
//--- Operazione di Conferma della riga/rughe selezionate
string k_rc
string k_processing 
string k_return = ""
long k_riga



k_processing = dw_1.Object.DataWindow.Processing

ki_conferma = false
ki_disattiva_exit = false

if dw_1.ki_ultrigasel > 0 then
	
	dw_1.setfocus()
		
//--- invia la riga selezionata alla windows che ha chiamato l'elenco	
	attiva_evento_in_win_origine()
	
	if NOT ki_disattiva_exit and kist_open_w.key7 = "S" then //kiuf_elenco.ki_esci_dopo_scelta then
		parent.triggerevent("ue_exit") 
		//k_return = "EXIT"
	else
	
//--- Se è stata aperta come windows di "CONFERMA" oppure come da "inquary" ma è di tipo "GRID" o "TREEVIEW" allora 
//--- quando fccio doppio click metto il record nella DW di appoggio 'dei selzionati'
		if dw_1.rowcount() > 0 & 
				and ( &
					 (k_processing = "1" &
						or k_processing = "8" &
						or k_processing = "9") ) then

			//kiuo_g_tab_elenco_tabpage = tab_1.control[tab_1.SelectedTab] 
			//kiuo_g_tab_elenco_tabpage.togli_righe_selezionate()
			togli_righe_selezionate()

//--- ripiglia il fuoco sul tab giusto
			riposiziona_cursore()

		end if

//			attiva_tasti()

		ki_conferma = true
	end if
else
	ki_conferma = true
end if

return k_return 

end function

public function uo_d_std_1 get_dw_sel ();// 
return dw_sel
end function

public function datastore get_ds_elenco_orig ();// 
return kids_elenco_orig
end function

public function datastore get_ds_elenco ();// 
return kids_elenco
end function

public subroutine attiva_drag_drop (uo_d_std_1 adw_1);//
if dw_1.u_get_tipo() = dw_1.kki_tipo_processing_grid then
	dw_1.ki_attiva_dragdrop = true
else
	dw_1.ki_attiva_dragdrop = false
end if
end subroutine

public function string inizializza () throws uo_exception;//
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
//	setta_oggetti()

	//tab_1.tabpage_1.text = trim(ki_st_open_w.key1)

		
//--- Popolo l'elenco dal datastore passato
	if kids_elenco_orig.rowcount( ) = 0 then 

		kids_elenco.dataobject = trim(kist_open_w.key2)
		kids_elenco_orig.dataobject = trim(kist_open_w.key2)
//		k_rc = kdsi1_elenco.settransobject ( sqlca )
		
		dw_1.dataobject = trim(kist_open_w.key2)
		if trim(kist_open_w.settrans) > " " then
			if trim(kist_open_w.settrans) = "db_magazzino" then 
				dw_1.settrans (kguo_sqlca_db_magazzino)
			elseif trim(kist_open_w.settrans) = "db_pilota" then
				dw_1.settrans (kguo_sqlca_db_pilota)
			elseif trim(kist_open_w.settrans) = "db_e1" then
				dw_1.settrans (kguo_sqlca_db_e1)
			end if
		else
			dw_1.settrans ( sqlca )
		end if
	
		dw_sel.dataobject = trim(kist_open_w.key2)
		
		kids_elenco = kist_open_w.key12_any
		k_rc = kids_elenco.rowscopy(1, kids_elenco.rowcount(), primary!,kids_elenco_orig,1,primary!)

		attiva_drag_drop(dw_1)  // attiva il dar&drop solo se dw GRID
	
		leggi_liste()		
	
		k_nr_rek = dw_1.rowcount() 
		
		if k_nr_rek < 1 then
			k_return = "1Nessuna Informazione trovata "
	
			messagebox("Elenco Dati Vuoto", &
				"Mi spiace, nessun dato trovato per la richiesta fatta ~n~r"  &
				 )
	
		else
			
	//--- Inabilita campi alla modifica 
			kiuf_utility.u_dw_toglie_ddw(1, dw_1)
			kiuf_utility.u_proteggi_dw("1", 0, dw_1)
	
	//--- attiva i LINK standard
			dw_1.event u_personalizza_dw ()
			dw_sel.event u_personalizza_dw ()
			
		end if
			
	end if

//--- finalmente visualizza il tab

	dw_1.visible = true
	dw_1.setfocus()

	//riposiziona_cursore(dw_1)   // riga seleziona
	if isvalid(dw_1) then dw_1.setredraw(true)
	dw_sel.visible = false
	
	this.visible = true
	this.enabled = true
	
	SetPointer(kkg.pointer_default)
	
return k_return



end function

public subroutine leggi_liste ();//
int k_rc


	dw_1.reset()

	k_rc = kids_elenco_orig.rowscopy(1, kids_elenco_orig.rowcount(), primary!, dw_1,1,primary!)

	dw_sel.visible = false
	dw_sel.reset()


end subroutine

public subroutine u_resize ();//
	constant int kk_barra_width = 0 //1
	constant int kk_barra_height = 0 //100

//--- Dimensiona dw nel tab
	dw_1.width = this.width - kk_barra_width
	dw_1.height = this.height - kk_barra_height
	dw_1.x = 0
	dw_1.y = 0
	
//--- Dimensione e Posizione dw di selezione nella window 
	dw_sel.height = dw_1.height * 0.70
	dw_sel.width = dw_1.width * 0.30
	dw_sel.x = (this.width - dw_sel.width) - 45
	dw_sel.y = dw_1.y + 30

end subroutine

public function long riposiziona_cursore ();//
long k_riga


		k_riga = dw_1.getrow()
		if k_riga = 0 then
			k_riga = dw_1.GetSelectedRow(0)
		end if
		if k_riga = 0 then
			k_riga = 1
		end if
		if k_riga > 0 and dw_1.rowcount() > 0 then
			if k_riga > dw_1.rowcount() then
				k_riga = dw_1.rowcount()
			end if
	
			if dw_1.Rowcount() > 1 then // and ki_st_open_w.flag_primo_giro <> 'S' then
			 
				dw_1.selectrow( 0, false)
				dw_1.selectrow( k_riga, true)
				dw_1.setrow( k_riga )
				dw_1.scrolltorow( k_riga )
	
			end if
		end if

return k_riga
end function

public subroutine mostra_elenco_selezionati ();//

if dw_sel.visible then
	dw_sel.visible = false
else
	dw_sel.visible = true
end if

end subroutine

public subroutine attiva_evento_in_win_origine ();//
//--- richiama nella Windows chiamata (se ancora aperta) l'evento "u_ricevi_da_elenco"
long k_riga=0, k_riga_ins=0, k_righe
int k_errore, k_rc
string k_key


//--- imposta gli oggetti standard
//	setta_oggetti()


//=== Valorizza l'oggetto DATASTORE per ritorno dei valori 
	if isvalid(kids_elenco) then destroy kids_elenco 
	kids_elenco = create datastore
	kids_elenco.dataobject = dw_1.dataobject
	kids_elenco.reset( )
	
//--- copia solo i record selezionati	
	k_riga = dw_1.getselectedrow(0)
	//k_righe = dw_1.rowcount()
	//for k_riga = 1 to k_righe
	do while k_riga > 0
		
//		if dw_1.isselected( k_riga) then
			
			k_riga_ins++
			if dw_1.rowscopy(k_riga, k_riga, primary!, kids_elenco, k_riga_ins, primary!) > 0 then // copia la riga SELECTED
				kids_elenco.selectrow( k_riga_ins,true) // anche qui la rende SELECTED (solo x mantenere la vecchia compatibilità)
			end if
			
	
//			if kids_elenco.rowcount( ) > 0 then
				kist_open_w.key12_any = kids_elenco
				kist_open_w.key3 = string(k_riga_ins) //"1"
				
				if not isnull(kist_open_w.key10_window_chiamante) then
					
					if isvalid(kist_open_w.key10_window_chiamante) and not ki_attendi_u_ricevi_da_elenco then
						ki_attendi_u_ricevi_da_elenco = true
						kist_open_w.key10_window_chiamante.event u_ricevi_da_elenco (kist_open_w)
						ki_attendi_u_ricevi_da_elenco = false
					end if
					
				end if
			//end if
		
		//end if
		
		k_riga = dw_1.getselectedrow(k_riga) // cerca la successiva selezionata
		
	loop
	
	
end subroutine

public subroutine u_esegui_funzione (string a_flag_modalita);//
st_open_w kst_open_w
datastore kds_1


try

	kds_1 = create datastore
	kds_1.dataobject = dw_1.dataobject

	if dw_1.rowcount( ) > 0 then
		if dw_1.getrow( ) = 0 then dw_1.setrow(1) 
		dw_1.rowscopy( dw_1.getrow( ) , dw_1.getrow( ), primary!, kds_1, 1, primary!)
	end if
	
	kGuf_menu_window.open_w_tabelle_da_ds(kds_1, a_flag_modalita)
		

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try
end subroutine

event constructor;//
	if trim(message.stringparm) > " " then 
		this.text = message.stringparm
	else
		this.text = "?????"
	end if
	
	if not isvalid(kids_elenco) then kids_elenco = create datastore
	if not isvalid(kids_elenco_orig) then kids_elenco_orig = create datastore
	if not isvalid(kiuf_utility) then kiuf_utility = create kuf_utility


end event

on uo_g_tab_elenco_tabpage.create
this.dw_sel=create dw_sel
this.dw_1=create dw_1
this.Control[]={this.dw_sel,&
this.dw_1}
end on

on uo_g_tab_elenco_tabpage.destroy
destroy(this.dw_sel)
destroy(this.dw_1)
end on

type dw_sel from uo_d_std_1 within uo_g_tab_elenco_tabpage
integer x = 663
integer y = 72
integer taborder = 20
boolean enabled = true
boolean titlebar = true
string title = "righe selezionate"
boolean maxbox = true
boolean resizable = true
boolean hsplitscroll = false
end type

event sqlpreview;call super::sqlpreview;//
	ki_syntaxquery = sqlsyntax

end event

event ue_aggiungi_riga;call super::ue_aggiungi_riga;//
dw_1.rowsmove(a_riga, a_riga , Primary!, this, 1,Primary!)

end event

event getfocus;call super::getfocus;//
kidw_selezionata = this


end event

event ue_dwnkey;call super::ue_dwnkey;//

	if key = KeyAdd! or key = KeySubtract! or key = KeyEqual! or key = KeyDash! or key = KeyEscape! or key = KeyDelete! then
		if key = KeyEscape! or key = KeyDelete! then
			u_zoom_off()
		else
			if key = KeyAdd! or key = KeyEqual! then
				u_zoom_piu()   //Zoomma +
			else
				u_zoom_meno()   //Zoomma -
			end if
		end if
	else
	end if

end event

event clicked;call super::clicked;//
parent.triggerevent(clicked!)
end event

type dw_1 from uo_d_std_1 within uo_g_tab_elenco_tabpage
integer taborder = 10
boolean enabled = true
end type

event doubleclicked;call super::doubleclicked;//
if row < 1 then
	return 1
end if
if ki_conferma then 
	kist_open_w.key5 = " " //--- nessun pulsante pigiato
	//kiw_g_tab_elenco.cb_conferma.event clicked( ) 
	conferma_dati( )
end if


end event

event clicked;call super::clicked;//
//kiw_g_tab_elenco.u_attiva_tasti()
//parent.triggerevent(clicked!)

end event

event getfocus;call super::getfocus;//
kidw_selezionata = this
u_resize( )



end event

event sqlpreview;call super::sqlpreview;//
//--- salvo la query di select x "salvataggio e avvio veloce delle liste dw"
	ki_syntaxquery = sqlsyntax

end event

event ue_drag_out;call super::ue_drag_out;//


if ki_conferma then 

//--- x postare nella dw dei "cliccati" tutte le righe  selezionate
	togli_righe_selezionate()

end if

return 1

end event

event ue_dwnkey;call super::ue_dwnkey;//

	if key = KeyAdd! or key = KeySubtract! or key = KeyEqual! or key = KeyDash! or key = KeyEscape! or key = KeyDelete! then
		if key = KeyEscape! or key = KeyDelete! then
			u_zoom_off()
		else
			if key = KeyAdd! or key = KeyEqual! then
				u_zoom_piu()   //Zoomma +
			else
				u_zoom_meno()   //Zoomma -
			end if
		end if
	else
	end if

end event

