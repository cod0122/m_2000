$PBExportHeader$uo_d_std_1.sru
forward
global type uo_d_std_1 from datawindow
end type
end forward

shared variables

end variables

global type uo_d_std_1 from datawindow
boolean visible = false
integer width = 1344
integer height = 836
boolean enabled = false
string title = "none"
string dataobject = "d_nulla"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
boolean livescroll = true
event ue_dwnkey pbm_dwnkey
event u_doppio_click ( )
event u_pigiato_enter pbm_dwnprocessenter
event rbuttonup pbm_rbuttonup
event ue_visibile ( boolean k_visibile )
event u_personalizza_dw ( )
event ue_timer pbm_timer
event type long ue_dropfromsame ( long k_droprow,  uo_d_std_1 kdw_source )
event type long ue_dropfromthis ( long k_droprow,  uo_d_std_1 kdw_source )
event ue_dragleave_post ( )
event type long ue_drop_out ( long k_droprow,  uo_d_std_1 kdw_source )
event ue_dwnmousemove pbm_dwnmousemove
event ue_lbuttondown pbm_lbuttondown
event ue_lbuttonup pbm_lbuttonup
event ue_dragdrop_end ( )
event type long ue_drag_out ( long k_droprow,  uo_d_std_1 kdw_target )
event ue_aggiungi_riga ( long a_riga )
event u_constructor ( )
event u_set_powerfilter ( )
event ue_leftbuttonup pbm_dwnlbuttonup
event u_modifica_set_color ( )
end type
global uo_d_std_1 uo_d_std_1

type variables
//
//--- Riferimento a questo oggetto
private uo_d_std_1 kidw_this

pointer kipointer_orig

//--- Icone per la dw selezionata nelle window
public string ki_icona_normale =   "Application5!"
public string ki_icona_selezionata = "UserObject5!"

//--- disattiva moment.la funz.'aggiorna' fino a che non mod.un dato
public boolean ki_disattiva_moment_cb_aggiorna = true

//--- Operazione a cui e' sottoposta la dw (x default è Visualizzazione) utile x i LINK
public string ki_flag_modalita = ""

//--- attiva/disattiva i LINK
public boolean ki_link_standard_sempre_possibile = false
public boolean ki_link_standard_attivi = true
public boolean ki_button_standard_attivi = true
private string ki_ultima_dataobject = " "

//--- attiva colore in background in Evidenza x riga aggiornata di recente
public boolean ki_colora_riga_aggiornata = true

public string ki_SQLsyntax = " "
public string ki_SQLErrText = " "
public long ki_SQLdbcode = 0

public integer ki_riga_rbuttondown=0
public dwobject kidwo_1

//--- serve x evitare che siano selezionate automaticamente le righe come nell'evento rowfocuschanged
public boolean ki_attiva_standard_select_row=true
public boolean ki_d_std_1_primo_giro=false

//--- Attiva/disattiva il SORT - ordina righe se premuto campo di testata colonna
public boolean ki_d_std_1_attiva_SORT = true

//--- Attiva/disattiva il Cerca....
public boolean ki_d_std_1_attiva_CERCA = true

//--- ultima riga selezionata
public long ki_UltRigaSel = 0

//--- Attiva/disattiva il Drag & Drop....
public boolean ki_attiva_DRAGDROP = false // Abilitazione al DRAG&DROP
private int ki_mouse_down_x = 0
private int ki_mouse_down_y = 0  
public string ki_dragdrop_display = " "
private long ki_riga_dragwithin = 0
private long ki_clicked_row = 0
private long ki_clicked_row_sel = 0
private long ki_lbuttondown_row=0
public boolean ki_in_DRAG = false
private boolean ki_drag_scroll=false
private boolean ki_u_drag_scroll_lanciata=false
private string ki_dragicon1 = " "
private string ki_dragicon2 = " "
private uo_d_std_1 kidw_dragdrop_this
private uo_d_std_1 kidw_source

//--- variabile gestione x errori DB
public:
st_errori_gestione kist_errori_gestione

//--- tipo datawindow (Processing)
public constant string kki_tipo_processing_form="0"
public constant string kki_tipo_processing_grid="1"
public constant string kki_tipo_processing_tree="8"
public constant string kki_tipo_processing_rtf="7"
public constant string kki_tipo_processing_altro="9"
//0 – (Default) Form, group, n-up, or tabular
//1 – Grid
//2 – Label
//3 – Graph
//4 – Crosstab
//5 – Composite
//6 – OLE
//7 – RichText
//8 – TreeView
//9 – TreeView with Grid


//
public boolean ki_abilita_ddw_proposta=false
private kuf_ddw_grid kiuf_ddw_grid

//--- nome dw old x evitare di rifare il link delle immagini x lo stesso dw
private string ki_personalizza_dw_name = ""

protected boolean ki_db_conn_standard = true   // indica se fare 'settransobject' su 'sqlca' in automatico su dw standard

public boolean ki_dw_visibile_in_open_window = true   // indica se la dw è visibile subito appena aperta la window

//--- gestione filitri tipo EXCEL
n_cst_PowerFilter kin_cst_PowerFilter

private kuf_menu_popup kiuf_menu_popup

//--- dataoggi set in constuct
private string ki_dataoggi_x

end variables

forward prototypes
public function boolean u_filtra_record (string k_filtro)
public function long u_get_riga_atpointer (string k_nome_campo)
private subroutine personalizza_dw ()
private subroutine link_standard_imposta ()
private subroutine u_drag_scroll (long row)
public function boolean u_sort (readonly string a_nome_campo)
public function long u_selectrow (long a_riga)
public subroutine set_flag_modalita (string a_flag_modalita)
private function long u_set_immagini (string a_nomeimgdacercare)
public function boolean u_dati_modificati ()
private subroutine u_set_immagini ()
public function string u_get_tipo ()
private subroutine u_sleep (integer a_sec)
public subroutine u_menu_popup (integer a_xpos, ref integer a_ypos)
public function long u_get_band_pointer ()
private function string modifica_set_color ()
public function string u_getitemstring (datawindow adw_link, string a_colonna, long a_riga)
protected function boolean link_standard_call (datawindow adw_link, string a_nome_link, long a_riga) throws uo_exception
public subroutine u_fine_primo_giro ()
end prototypes

event ue_dwnkey;//
long k_riga
string k_bands=""
boolean k_exit=false

//this.SetRedraw(FALSE)

//--- se tasto ESC provo l'undo
if key = KeyESCape! then

//--- chiude eventuali DRAG & GDROP
	event ue_dragdrop_end( )

//--- se tasto ESC provo l'undo
//--- Undelete
	IF this.CanUndo() THEN
		this.Undo()
	end if
	
else

//--- sono in TREEVIEW ?
	if (this.Object.DataWindow.Processing = kki_tipo_processing_grid or this.Object.DataWindow.Processing = kki_tipo_processing_tree or this.Object.DataWindow.Processing = kki_tipo_processing_altro) then

		IF keyflags = 1 THEN //con SHIFT

			k_riga = this.GetRow()
		
			IF k_riga > 0 THEN
		
//				this.SetRedraw(FALSE)
			
				IF key = KeyUpArrow! THEN
					if k_riga > 1 then
						if IsSelected ( k_riga - 1) then
							SelectRow(k_riga      , FALSE)
							ki_UltRigaSel = k_riga - 1
						else
							SelectRow(k_riga - 1, TRUE)
						end if
						k_exit = true
						
					end if
				END IF
				
				IF key = KeyDownArrow! THEN
					if k_riga < this.rowcount() then
						if IsSelected ( k_riga + 1 ) then
							SelectRow(k_riga      , FALSE)
							ki_UltRigaSel = k_riga + 1 
						else
							SelectRow(k_riga + 1 , TRUE)
						end if
						k_exit = true
					end if
				END IF
				
	//			this.SetRedraw(true)
		
				
			END IF
				
				
		ELSEIF keyflags = 2 THEN // con CTRL
				
			k_riga = this.GetRow()
			IF key = KeyDownArrow! THEN
				ScrollToRow(k_riga )
				k_exit = true
			END IF
			
			IF key = KeyUpArrow! THEN
				ScrollToRow(k_riga )
				k_exit = true
			END IF
				
		ELSEIF keyflags = 0 THEN  // solo il tasto premuto
				
			k_riga = this.GetRow()

//			k_bands=this.Describe("DataWindow.Bands") 
////--- verifica se sono sul Banda HEADER (probabile in treeeview) deseleziono tutto
//			if pos(k_bands, "header") > 1 then
//				SelectRow(0, false)	
//			end if

			IF k_riga > 0 THEN

//				this.SetRedraw(false)
				
				IF key = KeyUpArrow! THEN
					this.selectrow( 0, false)
					IF k_riga  > 1 THEN
						ki_UltRigaSel = k_riga - 1
						SelectRow(k_riga - 1, TRUE)	
					else
						SelectRow(1, TRUE)	
					END IF
					k_exit = true
				END IF
				
				IF key = KeyDownArrow! THEN
					this.selectrow( 0, false)
					IF k_riga < this.RowCount() THEN
						ki_UltRigaSel = k_riga + 1
						SelectRow(k_riga + 1, TRUE)	
					else
						SelectRow(this.RowCount(), TRUE)	
					END IF
					k_exit = true
				END IF
				
				//this.SetRedraw(TRUE)
			
			END IF
		END IF
		
	end if


	if ki_UltRigaSel = 0 then
		ki_UltRigaSel = this.getselectedrow ( 0 )
		if ki_UltRigaSel = 0 then
			ki_UltRigaSel = this.GetRow()
//			this.selectrow(ki_UltRigaSel,true)
		end if
	end if

end if

if k_exit then
//	this.SetRedraw(TRUE)
else
//	if isvalid(ki_menu) then
//		ki_menu.u_run_shortcutkey(key, keyflags )
//	end if
end if
//this.SetRedraw(TRUE)

return 0


end event

event u_doppio_click();//
w_g_tab_3 kw_g_tab_3

//--- Operazione di default una volta fatto il doppio click su dw
//	parent.triggerevent (doubleclicked!)

//--- esempio di cosa fare in questa funzione
long ll_count
FOR ll_count = 1 to UpperBound(kguo_g.kgw_attiva.Control[])
	if TypeOf(kguo_g.kgw_attiva.Control[ll_count]) = CommandButton! then
		if classname(kguo_g.kgw_attiva.Control[ll_count]) = "cb_visualizza" then
			kguo_g.kgw_attiva.Control[ll_count].postevent(clicked!)
		end if
	end if
NEXT
//if isvalid(kguo_g.kgw_attiva) then
//	if type(kguo_g.kgw_attiva) = typeof( )
//.cb_visualizza) then
//	if kguo_g.kgw_attiva.cb_visualizza.enabled then
//		kguo_g.kgw_attiva.cb_visualizza.postevent(clicked!)
//	end if
//end if

//
//	if cb_visualizza.enabled = true then 
//		cb_visualizza.postevent(clicked!)
//	end if
//

end event

event u_pigiato_enter;//
//--- trasforma l'ENTER in un TAB
//
send (Handle(this),256,9,long(0,0)) 

return 1 


end event

event rbuttonup;//
long k_riga
int k_xpos, k_ypos
string k_nome_col
//datawindow kdw
//kdw = this

	if ki_riga_rbuttondown > 0 then

		k_nome_col = getcolumnname( )

//--- seleziona la riga su cui si trova 		
		if ki_attiva_standard_select_row and not ki_d_std_1_primo_giro then
			//event ue_selectrow (ki_riga_rbuttondown)
			k_riga = u_selectrow (ki_riga_rbuttondown)
			if k_riga > 0 then
				this.setrow(k_riga)
			end if
			
		end if
		
////--- Se Calendario
//		if this.Describe(trim(k_nome)+".Type") = "column" &
//			and lower(Mid(this.Describe(trim(k_nome)+".coltype"),1,4)) = "date" &
//				and integer(this.Describe(trim(k_nome)+".TabSequence")) > 0 &
//				and this.Describe(trim(k_nome)+".Protect") = "0" & 
//				and this.Describe(trim(k_nome)+".edit.DisplayOnly") <> "yes"   & 
//				then
//			gf_dw_pop_calendar(kidw_this ,k_nome,"date",ki_riga_rbuttondown)
//		else
				
//--- Se sono su una colonna editabile non scatta il menu popup
//		if integer(this.Describe(trim(k_nome)+".TabSequence")) = 0 &
//				or this.Describe(trim(k_nome)+".Protect") = "1" & 
//				or this.Describe(trim(k_nome)+".edit.DisplayOnly") = "yes" then
				
			k_xpos = xpos + this.x  
			k_ypos = ypos + this.y 
			u_menu_popup(k_xpos, k_ypos)
				
//				parent.dynamic event rbuttonup(flags, xpos, ypos)
//				parent.triggerevent("rbuttonup")
//			end if
//		else
//			parent.dynamic event rbuttonup(flags, xpos, ypos)
//			parent.triggerevent("rbuttonup")
//		end if
	else
		k_xpos = xpos + this.x  
		k_ypos = ypos + this.y 
		u_menu_popup(xpos, ypos)
//		parent.dynamic event rbuttonup(flags, xpos, ypos)
//		parent.triggerevent("rbuttonup")
	end if
	
	return 1


end event

event ue_visibile(boolean k_visibile);//
//--- usato come evento "di entrata" ovvero ad esempio x rendere visible la dw e posizionarla o fare delle operazioni iniziali prima di visualizzarla
//--- vedi ad esmpio nella W_MECA_1 
//
//
//		this.visible = k_visible
	
end event

event u_personalizza_dw();//
//---- imposta i link standard se attivi e memorizza l'ultimo dataobject cliccato          
	if ki_link_standard_attivi &
			and ((ki_flag_modalita <> kkg_flag_modalita.modifica and ki_flag_modalita <> KKG_FLAG_RICHIESTA.inserimento) &
				or ki_link_standard_sempre_possibile) then
		
		ki_ultima_dataobject = this.dataobject 

		try
			personalizza_dw()
			link_standard_imposta() 
		catch (uo_exception kuo_exception)
			kuo_exception.messaggio_utente()
		end try
		
	end if

//--- imposta le immagini degli oggetti del dw tipo png econe ecc..
	u_set_immagini( )
	

end event

event ue_timer;//
//
//// --- diamo spazio a eventuali eventi in coda 
//Yield()
//
end event

event type long ue_dropfromsame(long k_droprow, uo_d_std_1 kdw_source);//
// Dragged da un DW che ha lo stesso Dataobject del nostro

Long		k_row=0

// ---

if isvalid(kdw_source) then
	
	// Go Through all selected Rows And Copy Them to the destination Datawindow
	k_row = kdw_source.GetSelectedRow(k_row)
	DO
		kdw_source.RowsMove(k_row, k_row, primary!, this, k_droprow, primary!)
	//---  Fire Drop Row Event
	//		this.EVENT ue_AfterDropRow(k_droprow)
		k_row --
		k_droprow ++
		
		k_row = kdw_source.GetSelectedRow(k_row)
		
	LOOP WHILE k_row > 0
	
end if

RETURN 1
end event

event type long ue_dropfromthis(long k_droprow, uo_d_std_1 kdw_source);
// We Dragged From this... we Drop to this...

Long		l_row=0, l_selectedRows=0, l_rowSave[], l_index, l_rowCount, l_getRow
Long		l_subRows=0

// ---

//Go Through all selected Rows And Move Them to the destination Datawindow (this)


l_rowCount = this.RowCount()
l_getRow = kdw_source.GetRow()
if isvalid(kdw_source) and k_droprow > 0 and l_rowCount > 1 then
//IF (l_getRow <> k_droprow OR k_droprow = l_rowCount OR k_droprow = 1) AND ki_UltRigaSel <> k_droprow  THEN
	
	// Move all Selected Rows To the Back
	l_row = kdw_source.GetSelectedRow(l_row)
	DO
		l_selectedRows ++
		l_rowSave[l_selectedRows] = l_row			
		l_row = kdw_source.GetSelectedRow(l_row)
	LOOP WHILE l_row > 0
	
	FOR l_index = UpperBound(l_rowSave[]) TO 1 STEP - 1
		kdw_source.RowsMove(l_rowSave[l_index], l_rowSave[l_index], primary!, this, l_rowCount + 1, primary!)
	NEXT
	
	FOR l_index = 1 TO UpperBound(l_rowSave[])
	// Change Move To Row.. All Rows wich was selected before have to be substracted
		IF k_droprow > l_rowSave[l_index] THEN
			l_subRows ++
		END IF
	NEXT
	
	k_dropRow -= l_subRows
	
	
	FOR l_index = 0 TO l_selectedRows - 1
		kdw_source.RowsMove(l_rowCount, l_rowCount, primary!, this, k_dropRow + l_index, primary!)
		// Fire Drop Row Event
//		this.EVENT ue_AfterDropRow(k_droprow + l_index)
	NEXT
	
//--- CurrentRow Should Be Dragged Row now
	ki_UltRigaSel 	= k_dropRow
//	kil_lastSelectedRow 	= k_dropRow
	
END IF


RETURN 1

end event

event ue_dragleave_post();////
//
//if this.ki_attiva_DRAGDROP then
//	
//	ki_riga_selected= 0
//	this.selectrow( 0, false )
//
//	THIS.Drag(cancel!)
//	ki_in_DRAG = false		 
//	setnull(ki_dragdrop_oggetto)
//
//	//st_barcode.visible = false
//
//end if
//
end event

event type long ue_drop_out(long k_droprow, uo_d_std_1 kdw_source);//
//--- Questo Evento serve a 'Gestire' i DROP provenienti da DW esterne
//---  dopo questa è lanciata anche la UE_DRAG_OUT nel DW sorgente
//

//--- DA PERSONALIZZARE

//
RETURN 1
end event

event ue_dwnmousemove;//
//---- Muove il mouse con il tasto left premuto
//
long k_riga


if this.ki_attiva_DRAGDROP and ki_lbuttondown_row > 0 then

//-- se riga > 0 e Non sono ancora in DRAG
//	if row > 0 and not ki_in_DRAG then
	if not ki_in_DRAG then
	
		if keydown(keyleftbutton!)  and not  keydown(keycontrol!) then
//--- se ho trascinato il mouse x un po'....
//			if (Abs(PointerX() - ki_mouse_down_x) > 50) OR (Abs(PointerY() - ki_mouse_down_y) > 50) OR (PointerX() = 0) OR (PointerY() = 0) THEN  
			if (Abs(xpos - ki_mouse_down_x) > 20) OR (Abs(ypos - ki_mouse_down_y) > 20) OR (xpos = 0) OR (ypos = 0) THEN  
				k_riga = this.getselectedrow(0) 
				if k_riga > 0 then
					if this.getselectedrow(k_riga) > 0 then
//						this.dragicon = kGuo_path.get_risorse() + "\drag2.ico"
						this.dragicon = ki_dragicon2   
					else
	//					this.dragicon = kGuo_path.get_risorse() + "\drag1.ico"
						this.dragicon = ki_dragicon1
					end if
							
					ki_in_DRAG = true		 
					this.drag(begin!)
					kidw_dragdrop_this = this
					
				end if
			end if
		end if
		
	end if
end if

end event

event ue_lbuttondown;//
long k_ctr
long k_Height

if this.ki_attiva_DRAGDROP then
	if isnumber(this.Describe("#1.Height")) then
		k_Height = long(this.Describe("#1.Height"))
	
		if ypos > k_Height then
		
			ki_UltRigaSel=0	
			ki_lbuttondown_row = this.getrow()
			if ki_lbuttondown_row > 0 then
				this.selectrow( ki_lbuttondown_row, true )
				this.setrow(ki_lbuttondown_row)
			end if
		end if
	end if
end if

end event

event ue_lbuttonup;//

//	if this.ki_attiva_DRAGDROP then
		this.event ue_dragdrop_end()
//	end if
end event

event ue_dragdrop_end();//
//	st_barcode.visible = false
	this.ki_lbuttondown_row = 0
	this.ki_in_DRAG = false		 
	this.drag(end!)
	this.ki_drag_scroll=false	
	this.dragicon = ""
	this.modify("k_dragdrop_row.Expression='0' ")
	if isvalid(kidw_dragdrop_this) then
		kidw_dragdrop_this.drag(end!)
		kidw_dragdrop_this.ki_in_drag = false
		kidw_dragdrop_this.ki_drag_scroll = false
		kidw_dragdrop_this.dragicon = ""
		kidw_dragdrop_this.modify("k_dragdrop_row.Expression='0' ")
	end if
	if isvalid(kidw_source) then
		kidw_source.drag(end!)
		kidw_source.ki_in_drag = false
		kidw_source.ki_drag_scroll = false
		kidw_source.dragicon = ""
		kidw_source.modify("k_dragdrop_row.Expression='0' ")
	end if
		


end event

event type long ue_drag_out(long k_droprow, uo_d_std_1 kdw_target);//
//--- Questo Evento serve a 'Gestire' il DRAG dopo che è stato eseuito il DROP sul dw sorgente (esterno)
//---  quindi prima di ques è stato lanciatao il UE_DROP_OUT nel DW target
//

//--- DA PERSONALIZZARE

//
RETURN 1
end event

event ue_aggiungi_riga(long a_riga);//
//--- utilizzata x spostare righe da un dw ad un altro specie nello ZOOM (w_g_tab_elenco)
//
end event

event u_constructor();//
//if this.dataobject <> "d_nulla" then
//	this.POST SetTrans(sqlca)
if ki_db_conn_standard then
	SetTransObject(kguo_sqlca_db_magazzino)
end if
if this.dataobject <> "d_nulla" then
	ki_personalizza_dw_name = ""
	event u_personalizza_dw()
end if

end event

event u_set_powerfilter();//

kin_cst_PowerFilter.checked = NOT kin_cst_PowerFilter.checked
kin_cst_PowerFilter.of_setdw(this)
if NOT kin_cst_PowerFilter.checked then
	kin_cst_PowerFilter.u_resetoriginalfilter()  // reset per poi ripristinare l'elenco
end if
kin_cst_PowerFilter.event ue_clicked()

end event

event ue_leftbuttonup;//
if kin_cst_PowerFilter.checked then
	kin_cst_PowerFilter.event post ue_buttonclicked(dwo.type,dwo.name)
end if

end event

event u_modifica_set_color();//
//---- imposta colori background colonne x modifica / inserimento      

		try
			modifica_set_color( )
		catch (uo_exception kuo_exception)
			kuo_exception.messaggio_utente()
		end try
		
	

end event

public function boolean u_filtra_record (string k_filtro);//
//--- filtra le righe cosi':
//---             k_filtro = la codizione di filtro
//
boolean k_return
long k_ctr, k_rc



	this.setredraw(false)
	

	k_rc=this.setfilter("") // rimuovo vecchi filtri

	if this.setfilter(k_filtro) < 1 then
		k_return = false
	else
		k_rc=this.filter()
		k_rc=this.GroupCalc()
		this.setfocus()
		if k_rc > 0 then
			k_return = true
		else
			k_return = false
		end if
	end if

	this.setredraw(true)
		
		
return k_return

end function

public function long u_get_riga_atpointer (string k_nome_campo);//
//--- tenta di trovare il numero di riga con o senza nome-campo 
//
long k_riga=0
string k_rigax
//long k_ctr


//	k_stringa = this.GetObjectAtPointer()
//	if k_stringa <> "" then

//--- potrebbe essere un tree per cui prendo il NUMERO RIGA se ho premuto su un NODO
	k_rigax = this.GetObjectAtPointer()
	if k_rigax <> "" then
		
		//k_ctr = len(k_rigax)
		if trim(k_nome_campo) > " " then
			k_rigax = Replace ( k_rigax, pos( k_rigax,trim(k_nome_campo), 1) , len(trim(k_nome_campo)) , space(len(trim(k_nome_campo))) )
		else
			k_rigax = right(k_rigax, len(k_rigax) - pos(k_rigax, "~t"))
		end if
		if isnumber(trim(k_rigax)) then 
			k_riga = long(trim(k_rigax))
		else
			k_riga = 0
		end if
	
	end if

return k_riga


end function

private subroutine personalizza_dw ();//
//--- Personalizza DW (es. colora le righe agg. di recente)
//--- 
//
//---
long k_num_colonne_nr, k_ctr=1, k_pos
string k_num_colonne, k_colore, K_RET, k_str, k_colore_orig, k_str_modify=""
//string k_nomeImgDaCercare=""
//string k_dw_syntax = "", k_filename="", k_nome_oggetto="", k_path
//long k_len_max=0, k_oggettiTrovati=0,  k_ctr1, k_ctr2, k_ctr3, k_ctr4


	if ki_colora_riga_aggiornata then
		    //and this.rowcount( ) > 1 then

//---- Mette Colore BACKCOLOR x le righe aggiornate di recente
		if isnumber(this.Describe("x_datins.x")) then
		
			k_num_colonne = this.Object.DataWindow.Column.Count
			if isnumber(k_num_colonne) then
				k_num_colonne_nr = integer(k_num_colonne)
			else
				k_num_colonne_nr = 99
			end if
			do 
				k_colore = trim(this.Describe("#" + trim(string(k_ctr,"###"))+".background.color"))
				
//--- controllo di NON avere già registrato l'espressione... 
				k_pos = pos(k_colore, "if( date(x_datins) = date(", 1) 
				if k_pos <= 0 then 
				
//--- controllo se nella dw c'e' gia' una EXPRESSION
					k_pos = pos(k_colore, "~t", 1) 
					if k_pos > 0 then 
//--- piglia l'espressione senza le Virgolette
						k_colore_orig = mid(k_colore, k_pos, len(k_colore) - k_pos  )
						k_str = "#" + trim(string(k_ctr,"###"))+".background.color=~" 0"   &
								+"~tif( date(x_datins) =  date('" + ki_dataoggi_x + "'),"+ KKG_COLORE.REC_UPDX + "," +k_colore_orig + ") ~""  //kGuo_g.get_dataoggi()) +"'),"+ KKG_COLORE.REC_UPDX + "," +k_colore_orig + ") ~"" //~""
					else
						k_str = "#" + trim(string(k_ctr,"###"))+".background.color=~" 0"  &
								+"~tif( date(x_datins) = date('" + ki_dataoggi_x +"'),"+ KKG_COLORE.REC_UPDX + "," +k_colore + ") ~""//string(kGuo_g.get_dataoggi()) +"'),"+ KKG_COLORE.REC_UPDX + "," +k_colore + ") ~"" //~""
					end if
					
					k_str_modify += k_str + " "
//					k_ret = this.Modify(k_str)
					
				end if
				k_ctr ++

			loop while k_ctr <= k_num_colonne_nr 
		end if
	end if	

		
//--- se ho trovato qls applica le modifiche tutte insieme	
	if k_str_modify > " " then 
		k_ret = this.Modify(k_str_modify)
	end if
	
		
		
		
end subroutine

private subroutine link_standard_imposta ();//-----------------------------------------------------------------------------------------------------------------------------------------------
//---
//--- link_standard_imposta
//--- Imposta nel DW i "Link Standard" ovvero mette il campo in blu con "manina" come cursore
//---
//-----------------------------------------------------------------------------------------------------------------------------------------------
kuf_link_zoom kuf1_link_zoom


//--- Se NON sono in modalita' Inserimento/Modifica oppure ho indicato LINK SEMPRE POSSIBILE 
	if (ki_flag_modalita <> kkg_flag_modalita.modifica and ki_flag_modalita <> KKG_FLAG_RICHIESTA.inserimento) or ki_link_standard_sempre_possibile  then
			
		kuf1_link_zoom = create kuf_link_zoom
		kuf1_link_zoom.link_standard_imposta_p (kidw_this) // attiva i tasti con il LINK

	end if
	
	//link_standard_imposta_p ()  // evidenzia (mette in sottolineato) i campi di link
	


end subroutine

private subroutine u_drag_scroll (long row);//---
//--- scroll delle righe visibili mentre si fa il DRAG&DROP 
//---

long k_righe_tot, k_riga_scroll, k_last_row, k_first_row
string k_rc

	
	ki_u_drag_scroll_lanciata=true
	ki_drag_scroll=true	
	
	k_righe_tot = this.rowcount() 
	k_riga_scroll = 2
	do while ki_drag_scroll and k_riga_scroll <  k_righe_tot and k_riga_scroll > 1
		
		k_rc = this.modify("k_dragdrop_row.Expression='"+ string(row)+"' ")
		
		k_last_row = long(this.describe("DataWindow.LastRowOnPage")) - 1
		if row > k_last_row  then
			k_riga_scroll = k_last_row + 2
			this.scrolltorow(k_riga_scroll) 
		else
			k_first_row = long(this.describe("DataWindow.FirstRowOnPage")) + 1
			if k_first_row > 2 and row < k_first_row then
				k_riga_scroll = k_first_row - 2
				this.scrolltorow(k_riga_scroll) 
			else
				k_riga_scroll = 0
			end if
		end if	
		
		this.setredraw( true)
		
//		yield()


	loop 


	ki_u_drag_scroll_lanciata=false

end subroutine

public function boolean u_sort (readonly string a_nome_campo);//---
//--- Ordina le righe x la colonna pigiata (click su campo di testata)
//---
boolean k_return = true
string k_tipo_sort="", k_nome_campo=""
string k_colore_orig=""


	setpointer(kkg.pointer_attesa)

	this.enabled = false
	
	k_nome_campo = trim(a_nome_campo)	
//	k_x = integer(this.describe(trim(k_nome_campo)+".x"))  + integer(this.describe(trim(a_nome_campo)+".width"))
//	k_x_1 = PixelsToUnits(xpos, XPixelsToUnits!)
	k_colore_orig = this.Describe(k_nome_campo + ".color")
	this.Modify(k_nome_campo + ".color = '" + string(kkg_colore.rosso) + "' " ) 

//--- se campo char sort ascendente altrimenti discendente
	if LeftA(this.Describe(trim(a_nome_campo) + ".colType"),4) = lower("char") then
//--- se campo gia' sortato discendente lo faccio ascendente
		if trim(this.Describe(trim(a_nome_campo) + ".tag")) = "D" then 
			k_tipo_sort = " A"
		else
			k_tipo_sort = " D"
		end if
	else
//--- se campo gia' sortato ascendente lo faccio discendente
		if trim(this.Describe(trim(a_nome_campo) + ".tag")) = "A" then 
			k_tipo_sort = " D"
		else
			k_tipo_sort = " A"
		end if
	end if
	this.modify(trim(a_nome_campo) + ".tag='" + trim(k_tipo_sort) + "'") 

//--- tolgo la '_t' dal nome campo
	k_nome_campo = LeftA(a_nome_campo, LenA(a_nome_campo) - 2) 

	this.SetRedraw(false)
	This.SetSort(k_nome_campo + k_tipo_sort)
	This.Sort()
	this.GroupCalc()
	this.SetRedraw(true)

	this.Modify(trim(a_nome_campo) + ".color = '" + k_colore_orig + "' " ) 


	this.enabled = true
	
	setpointer(kkg.pointer_default)
	
return k_return

end function

public function long u_selectrow (long a_riga);//
long k_return=0
long k_riga_ctr, k_riga_ini, k_riga_fin, k_riga_select
//int k_ctr



//--- seleziona le righe del DW solo x i tipi GRID
if (this.Object.DataWindow.Processing = kki_tipo_processing_grid or this.Object.DataWindow.Processing = kki_tipo_processing_tree or this.Object.DataWindow.Processing = kki_tipo_processing_altro) then
	
	if ki_UltRigaSel = 0 then	
		if a_riga  > 0 then 
			ki_UltRigaSel = a_riga
		else
			if this.getselectedrow ( 0 ) > 0 then
				ki_UltRigaSel = this.getselectedrow ( 0 )
			else
				if this.getrow() > 0 then
					a_riga = this.getrow ( )
					ki_UltRigaSel = a_riga
				else
					ki_UltRigaSel = 0
				end if
			end if
		end if
	end if
	
//--- ctrlt+click	per seleziare altra riga
	if keydown( keycontrol! ) then
		
		if a_riga > 0 then 
			
			if this.isselected( a_riga) then
				this.selectrow ( a_riga, false )
			else
				this.selectrow ( a_riga, true )
			end if
			ki_UltRigaSel = a_riga
			
		end if
		
	else
		 
	//--- shift+click	per selezione multipla	
		if keydown( keyshift! ) then 
			this.setredraw ( false )
			
			if this.getselectedrow ( 0 ) = 0 then
				k_riga_ini = a_riga
			else
				k_riga_ini = this.getrow()
			end if
			k_riga_fin = a_riga
			ki_UltRigaSel = a_riga
			
			if k_riga_ini > k_riga_fin then
			
				for k_riga_ctr = k_riga_ini to k_riga_fin step -1 
				
					this.selectrow ( k_riga_ctr, true )
				
				next
			
			else
			
				for k_riga_ctr = k_riga_ini to k_riga_fin 
				
					this.selectrow ( k_riga_ctr, true )
				
				next
			
			end if
			this.setredraw ( true )
		else
	
	//--- solo click		
			this.selectrow ( 0, false )
			if a_riga > 1 then
				this.selectrow ( a_riga, true )
			else
	//--- solo per il tipo GRID fa la selezione della riga n.1	
				if a_riga = 1 &
	                  and (this.Object.DataWindow.Processing = kki_tipo_processing_grid or this.Object.DataWindow.Processing = kki_tipo_processing_tree or this.Object.DataWindow.Processing = kki_tipo_processing_altro) then
					this.selectrow ( a_riga, true )
				end if
			end if 
			ki_UltRigaSel = a_riga
			
		end if 
		
	end if
	
end if


//this.setrow( a_riga )
if a_riga > 0 then
	k_return = a_riga
end if

return k_return 
end function

public subroutine set_flag_modalita (string a_flag_modalita);//

ki_flag_modalita = a_flag_modalita

end subroutine

private function long u_set_immagini (string a_nomeimgdacercare);//
string k_dw_syntax = "", k_filename="", k_nome_oggetto="", k_path, k_str_modify=""
long k_len_max=0, k_oggettiTrovati=0, k_ctr, k_ctr1, k_ctr2, k_ctr3, k_ctr4


//--- controlla se ci sono delle immagini da fare vedere----------------------------------------
//--- estrazione dell'intero contenuto del dw
	k_dw_syntax = this.describe("DataWindow.Syntax")
	k_len_max = len(k_dw_syntax)
//--- estrazione dei nomi dei txt
	k_path =  kguo_path.get_risorse( ) //+ kkg.path_sep
	k_ctr = 1
	k_ctr = pos(k_dw_syntax, "(name=", k_ctr)    //cerca stringa 'name' ovvero tutti gli oggetti nel dw 
	
	DO WHILE k_ctr > 0 and k_oggettiTrovati < 100
		k_ctr1 = k_ctr + 6
		if k_ctr1 < k_len_max then
		//	k_ctr1 = k_ctr1 + 6
			k_ctr2 = pos(k_dw_syntax, a_nomeImgDaCercare, k_ctr1)
			if k_ctr2 > 0 then
				k_ctr = k_ctr2
				k_ctr2 = pos(k_dw_syntax, "_", k_ctr2)  + 1  // piglia la pos di "_" che segue txt
				k_ctr4 = pos(k_dw_syntax, "~"", k_ctr2) - k_ctr2   // piglia len del "p_img_" es. "p_img_lente" se carattere doppi apici
				k_ctr3 = pos(k_dw_syntax, " ", k_ctr2) - k_ctr2   // piglia len del "p_img_" es. "p_img_lente"
				if k_ctr3 > k_ctr4 then k_ctr3 = k_ctr4  // se c'e' prima doppi apici allora sistema la posizione
				k_nome_oggetto = mid(k_dw_syntax, k_ctr2, k_ctr3 ) // carica il nime del file jpg o bmp o ecc....
//--- recupera il nome dell'immagine
				k_filename = trim(this.Describe('txt_' + k_nome_oggetto + ".Text"))
				if k_filename > " " and k_filename <> "!" and k_filename <> "?"  then
//--- visualizza l'immagine
					if left(k_filename,1) = kkg.path_sep then // se c'e' una BARRA a inzio del nome allora add il PATH altrimenti se nome della risorsa 'secca' nel file PBR
						k_str_modify += (k_nome_oggetto + ".Filename='" + k_path + k_filename + "'") + " "
					else
						k_str_modify += (k_nome_oggetto + ".Filename='" + k_filename + "'") + " "
					end if
				end if
				k_oggettiTrovati++
			else
				exit
			end if
			
		end if
		k_ctr++
		k_ctr = pos(k_dw_syntax, "(name=", k_ctr)
	LOOP	
	
//--- se ho trovato qls applica le modifiche tutte insieme	
	if k_oggettiTrovati > 0 then 
		this.Modify(k_str_modify)
	end if
	
return k_oggettiTrovati

end function

public function boolean u_dati_modificati ();//
//--- Compiute modifice nel dw?
//--- true=si; false=no
//
boolean k_return = false	

	
	if this.enabled then

		this.accepttext()
		
		if this.visible then
			if this.Object.DataWindow.Table.UpdateTable <> " " then
				 if this.getnextmodified(0, primary!) > 0 or this.getnextmodified(0, delete!) > 0 or this.ModifiedCount ( ) > 0 or this.deletedcount() > 0 then
					k_return = true
				end if
			end if
		end if
	end if
	
return k_return
	
end function

private subroutine u_set_immagini ();//
string k_nomeImgDaCercare = ""


//--- imposta le icone e grafiche png ecc... negli oggetti del dw
	if ki_personalizza_dw_name <> this.dataobject then
		ki_personalizza_dw_name = this.dataobject  // x evitare di impostare più volte lo stesso oggetto

		k_nomeImgDaCercare = "txt_p_img"   // uso oboleto
		u_set_immagini(k_nomeImgDaCercare)
		
		k_nomeImgDaCercare = "txt_p_"   // uso oboleto
		u_set_immagini(k_nomeImgDaCercare)

		k_nomeImgDaCercare = "txt_img_"  //--- nuovo standard: usare txt_img_..... che può essere p o b o quello che si vuole
		u_set_immagini(k_nomeImgDaCercare)
		
	end if	

end subroutine

public function string u_get_tipo ();//---
//--- torna il tipo di datawindow catturato da Processing 
//---

choose case this.Object.DataWindow.Processing
		
	case "0"
		return kki_tipo_processing_form		
		
	case "1"
		return kki_tipo_processing_grid		
		
	case "8" 
	case "9" 
		return kki_tipo_processing_tree
		
	case "7"	// Rich Text
		return kki_tipo_processing_rtf	

	case else
		return kki_tipo_processing_altro
		
end choose

end function

private subroutine u_sleep (integer a_sec);//
sleep (a_sec)

end subroutine

public subroutine u_menu_popup (integer a_xpos, ref integer a_ypos);//

 	
	if not isvalid(kiuf_menu_popup) then kiuf_menu_popup = create kuf_menu_popup
	
	kiuf_menu_popup.u_popup(a_xpos, a_ypos)
	

end subroutine

public function long u_get_band_pointer ();//
//--- tenta di trovare il numero di riga (utile ad esempio in un datawindow TREEVIEW)
//
long ll_row
long ll_pos
string ls_band
string ls_bandatpointer
 
 
ls_bandatpointer = this.GetBandAtPointer()
ll_pos = Pos ( ls_bandatpointer , "~t" )
if ll_pos > 0 then
    ls_band = Left(ls_bandatpointer , ll_pos - 1)
    ll_row =  long (Mid ( ls_bandatpointer, ll_pos + 1 ) )
end if


return ll_row


end function

private function string modifica_set_color ();//
//--- Mette le colonne da modificare in bianco e le altre in grigio
//--- usato in operazioni di INSERIMENTO/MODIFICA
//
//---
long k_num_colonne_nr, k_ctr=1, k_pos
string k_TabSequence, k_ret
string k_num_colonne, k_colore, k_str, k_str_modify=""



	k_num_colonne = this.Object.DataWindow.Column.Count
	if isnumber(k_num_colonne) then
		k_num_colonne_nr = integer(k_num_colonne)
	else
		k_num_colonne_nr = 99
	end if
	
	do 
		k_TabSequence = trim(this.Describe("#" + trim(string(k_ctr,"###"))+".TabSequence"))
		//k_colore = trim(this.Describe("#" + trim(string(k_ctr,"###"))+".background.color"))
		if k_TabSequence = "0" or k_TabSequence = "" then
			k_colore = string(KKG_COLORE.campo_disattivo)
		else
			k_colore = string(KKG_COLORE.bianco)
		end if
//--- controllo di NON avere già registrato l'espressione... 
//--- controllo se nella dw c'e' gia' una EXPRESSION
		k_str = "#" + trim(string(k_ctr,"###"))+".background.color= '" + k_colore + "'" //~""
					
		k_str_modify += k_str + " "
					
		k_ctr ++

	loop while k_ctr <= k_num_colonne_nr 
		
//--- se ho trovato qls applica le modifiche tutte insieme	
	if k_str_modify > " " then 
		k_ret = this.Modify(k_str_modify)
	end if
	
return k_ret
		
end function

public function string u_getitemstring (datawindow adw_link, string a_colonna, long a_riga);//
//=== Torna Valore String da una colonna di DW
string k_return=""
string k_tipo=""

	
	if a_riga > 0 and trim(a_colonna) > " " then
		k_tipo = adw_link.Describe(a_colonna + ".ColType")
		choose case lower(left(k_tipo, 3))
			case "cha"
				k_return = trim(adw_link.getitemstring(a_riga, a_colonna))
			case "lon", "dec", "num", "int", "ulo"
				k_return = string(adw_link.getitemnumber(a_riga, a_colonna))
			case "dat"
		    	if k_tipo = "datetime" then
					k_return = string(adw_link.getitemdatetime(a_riga, a_colonna))
				else
					k_return = string(adw_link.getitemdate(a_riga, a_colonna))
				end if
			case "tim"
				k_return = string(adw_link.getitemtime(a_riga, a_colonna))
		end choose
 		if isnull(k_return) then k_return = ""
	end if	

return k_return


end function

protected function boolean link_standard_call (datawindow adw_link, string a_nome_link, long a_riga) throws uo_exception;//
//--- Verifica se è stato premuto un link (button o campo)
//--- Input: a_nome_link  = nome del campo o button cliccato
//---        a_riga = numero riga
//---        adw_link = datawindow che può essere anche un dwc 
//---            
//--- Output: boolean TRUE = ok e' entrato in funzione; FALSE=non ha fatto niente
//
boolean k_return=false
string k_nome_link_button = " "
string k_protect = "", k_taborder="", k_valore=""
int k_taborder_n = 0
boolean k_zoom_ok = false 
kuf_link_zoom kuf1_link_zoom


try 

	
//--- Ho un VALORE e Ho attivato i flag x fare lo ZOOM?
	if (ki_button_standard_attivi or ki_link_standard_attivi) then

		setpointer (kkg.pointer_attesa)	
		
		kuf1_link_zoom = create kuf_link_zoom
		
//--- se ho cliccato su un BUTTON o SIMILARE converto nel link tradizionale 
		k_nome_link_button = kuf1_link_zoom.get_link_da_button (a_nome_link)
		
		if k_nome_link_button > " " then  // se è un Bottone lo riverso anche nel campo nome LINK
			a_nome_link = trim(k_nome_link_button)
		end if

//--- valutazione se 'lanciare lo ZOOM'
		k_zoom_ok = true
		if k_nome_link_button > " " then  // se è un button allora allora ZOOM ok
		else
//--- Verifica valore da cercare se OK
			if NOT ki_link_standard_attivi then // se NO link standard attivo allora ok
				k_zoom_ok = FALSE 
			else
				if a_riga > 0 and trim(a_nome_link) > " " then
					k_valore = trim(u_getitemstring(adw_link, a_nome_link, a_riga))
					if k_valore > " " then
						k_protect = adw_link.Describe(a_nome_link + ".Protect") // campo protetto
						if k_protect = "0" then // se campo protetto ovvero diverso da ZERO allora ZOOM ok
							k_taborder = adw_link.Describe(a_nome_link + ".TabSequence")
							if isnumber(k_taborder) then 
								if integer(k_taborder) > 0 then
									k_zoom_ok = FALSE // campo di INPUT ATTIVO non faccio ZOOM altrimenti e' un casino x l'utente 
								end if
							end if
						end if
					else
						k_zoom_ok = FALSE // non passo perchè campo senza VALORE 25.5.2015
					end if
				else
					k_zoom_ok = FALSE // non passo perchè campo senza NOME
				end if
			end if

		end if

//--- Se posso 'lanciare lo ZOOM'
		if k_zoom_ok then 
			k_return = kuf1_link_zoom.link_standard_call_p (adw_link, a_nome_link) // attiva i tasti con il LINK
		end if			

	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally	
	setpointer (kkg.pointer_default)	

end try
	
return k_return


end function

public subroutine u_fine_primo_giro ();//
ki_d_std_1_primo_giro = false

end subroutine

on uo_d_std_1.create
end on

on uo_d_std_1.destroy
end on

event clicked;//
string k_name, k_tipo_sort, k_bands
long k_colore, k_riga 
long k_x,k_x_1, k_rc
datawindow kdw_link
datawindowchild kdwc_link


k_name = trim(dwo.Name)
k_bands=this.Describe("DataWindow.Bands") 
//--- verifica se sono sul Banda di dettaglio e se sono in TREEVIEW
//if left(k_bands, 4) = "deta" then
if pos(k_bands, "detail") > 1 then
	if (this.Object.DataWindow.Processing = kki_tipo_processing_tree or this.Object.DataWindow.Processing = kki_tipo_processing_altro)  and row = 0 then
		row=u_get_riga_atpointer(k_name)
	end if
	//--- risolve il problema di avere cliccato su una colonna posta in una zona non detail
	if row = 0 then
		k_name = dwo.name
		if pos(k_name, "_t") > 0 or pos(k_name, "t_") > 0 then  // salta le intestazioni (non solo colonne del DB!)
		else
			if this.rowcount() > 0 then
				row = 1   
			end if
		end if
	end if
end if

if row > 0 then

	ki_mouse_down_x = xpos // original coordinates of pointer x fare il drag&drop 
	ki_mouse_down_y = ypos // original coordinates of pointer x fare il drag&drop  			

	if ki_attiva_standard_select_row and not ki_d_std_1_primo_giro then
		
		k_riga=u_selectrow (row)
		if k_riga > 0 then
			this.setrow(k_riga)
		end if

	end if

//--- funzione di ZOOM
	if (ki_link_standard_attivi or ki_button_standard_attivi)  then
		if (ki_link_standard_attivi or ki_button_standard_attivi)  then
			try
				
				//--- se ho cliccato dentro a un DW child allora cerca il campo
				if left(k_name, 2) = "dw" then
//					k_rc = this.getchild( k_name, kdwc_link)
//					if k_rc > 0 then
//						k_name = kdwc_link.getbandatpointer( )
//						if left(k_name, 1) = "d" then
//							k_riga = mid(k_name, 7, len(k_name)) // get del nome del campo
//							k_rc = kdwc_link.getcolumn( )
//							k_name = kdwc_link.getcolumnname( )
//							kdwc_link.rowscopy(row, row, primary!, kdw_link, 1, primary!)
//							link_standard_call(kdw_link, k_name, 1)   // lancia link standard
//						end if
//					end if
				else
					kdw_link = this
					link_standard_call(kdw_link, k_name, row)   // lancia link standard
				end if
			catch (uo_exception kuo_exception)
				kuo_exception.messaggio_utente()
			end try
		end if
	end if
	
else
	
	if (this.Object.DataWindow.Processing = kki_tipo_processing_tree or this.Object.DataWindow.Processing = kki_tipo_processing_altro) then
		k_riga=u_selectrow (0)
		if k_riga > 0 then
			this.setrow(k_riga)
		end if
		
	end if
	
		
//--- Ordina righe se il campo di testata colonna finisce x '_t' ed è formato testo
//	if left(k_bands, 4) = "head" then
	if ki_d_std_1_attiva_sort then
//		k_name = trim(dwo.Name)
		IF dwo.Type = "text" and MidA(k_name, LenA(trim(k_name)), 1) = "t" THEN
			
			u_sort(k_name)   // Esegue il SORT

		end if
	end if
//	end if

end if

end event

event doubleclicked;//
string k_name, k_tipo_sort
long k_colore 
long k_x,k_x_1



this.accepttext()


if row = 0 and this.Object.DataWindow.Processing = kki_tipo_processing_tree or this.Object.DataWindow.Processing = kki_tipo_processing_altro  then
	row=u_get_riga_atpointer(dwo.Name)
end if

if row > 0 and this.Object.DataWindow.Processing = kki_tipo_processing_grid then // dw tipo GRID

//	this.setrow(row)
//	triggerevent ("u_doppio_click")
	event u_doppio_click( )
	

else
	return 1
end if


end event

event getfocus;//
long k_riga=0


if trim(ki_icona_selezionata) > " " then
	this.icon = ki_icona_selezionata
end if

// se abilitato imposta la gestione di mostrare mentre si digita il primo valore completo che trova nel ddw
if ki_abilita_ddw_proposta then
	kiuf_ddw_grid.u_set_current_dw(kidw_this)
end if

if ki_attiva_standard_select_row  and not ki_d_std_1_primo_giro then
	k_riga = This.getSelectedRow(0) 
	if  k_riga > 0 then
 //--- riga con il fuoco e' selezionata?
		if isSelected(This.getRow()) then
		else
 //--- cerco di far coincidere la riga selezionata con quella con il fuoco
			if setrow(This.getSelectedRow(This.getRow())) > 0 then
			else
				setrow(k_riga)
			end if
		end if
	else
		k_riga=u_selectrow (0)
		if k_riga > 0 then
			this.setrow(k_riga)
		end if
//		event ue_selectrow (0)
	end if
end if

end event

event rbuttondown;//
//	datawindow kdw
//	kdw = this


	ki_riga_rbuttondown = row
	kidwo_1 = dwo

//--- Calendario
//	if row > 0 then
//		if dwo.type = "column" then
//			if lower(mid(dwo.coltype,1,4)) = "date" &
//				and integer(this.Describe(trim(dwo.name)+".TabSequence")) > 0 &
//				and this.Describe(trim(dwo.name)+".Protect") = "0" & 
//				and this.Describe(trim(dwo.name)+".edit.DisplayOnly") <> "yes"   & 
//				then
//				gf_dw_pop_calendar(kdw,dwo.name,dwo.coltype,row)
//			else
//				parent.triggerevent(rbuttondown!)
//			end if
//		else
//			parent.triggerevent(rbuttondown!)
//		end if
//	else
//		parent.triggerevent(rbuttondown!)
//	end if
	


end event

event dberror;//
st_esito kst_esito
st_errori_gestione kst_errori_gestione

ki_SQLsyntax = trim(SQLsyntax)
ki_SQLErrText = trim(SQLErrText)
ki_SQLdbcode = SQLdbcode

if isvalid(parent) then 
	kist_errori_gestione.nome_oggetto = parent.classname()
else
	kist_errori_gestione.nome_oggetto = classname()
end if
kist_errori_gestione.sqlsyntax = trim(sqlsyntax)
kist_errori_gestione.sqlerrtext = trim(sqlerrtext)
kist_errori_gestione.sqldbcode = sqldbcode
kist_errori_gestione.sqlca = sqlca

if isvalid(kGuf_data_base) then kGuf_data_base.errori_gestione(kist_errori_gestione)

//=== tentativo di set transobject per il datawindows 
//if ki_db_conn_standard then
//this.settransobject ( sqlca )
//end if

RETURN 1 // Do not display system error message

end event

event itemerror;//

//
string k_data_x



	if dwo.coltype = "date" then 
		k_data_x = trim(data)
		if k_data_x = "" or left(k_data_x,2) = "00" then
			return 2  // OK
		elseif len(k_data_x) < 3 and isnumber(k_data_x) then
			k_data_x = trim(k_data_x) + "/" + string(today(), "mmm/yyyy")
		elseif len(k_data_x) = 4 and isnumber(k_data_x) then
			k_data_x = left(k_data_x,2) + "/" + mid(k_data_x,3,2) + "/" + string(today(), "yyyy") 
		elseif len(k_data_x) = 5 and not isnumber(mid(k_data_x,3,1)) then 
			k_data_x = left(k_data_x,2) + "/" + mid(k_data_x,4,2) + "/" + string(today(), "yyyy") 
		end if
		if isdate(k_data_x) then 
			return 2 // OK
		else
			return 0 // KO con errore
		end if			

	else
		return 1 // KO senza errore

	end if
	

end event

event itemchanged;//
int k_return=0
string k_codice, k_data_x
date k_data, k_dataoggi
string k_style, k_ddw_campo, k_type, k_valore
long k_find_riga=0, K_RC 
datawindowchild  kdwc_1


//--- sui campi data tento correzioni --------------------------------------------
	if dwo.coltype = "date" then 
		k_dataoggi = kguo_g.get_dataoggi( )
		k_data_x = trim(data)
//--- se è una data ok prosegue		
		if isdate(k_data_x) then
			
//--- se a spazio metto data 01.01.1899		
		elseif k_data_x = "" then
			k_data_x = string(date(0))
//--- se è una dattipo yyyy-mm-dd è bella e fatta
		elseif isnumber(left(k_data_x,4)) and isnumber(mid(k_data_x,6,2)) and isnumber(mid(k_data_x,9,2)) then
			k_data_x = mid(k_data_x,9,2) + "/" + mid(k_data_x,6,2) + "/" +  left(k_data_x,4)
//--- se a ZERO metto data 01.01.1899		
		elseif left(k_data_x,2) = '00' then
			k_data_x = string(date(0))
//--- se a indicato un numero tipo 5 o 23 metto lo considero il giorno
		elseif len(k_data_x) < 3 and isnumber(k_data_x) then
			k_data_x = string(date(string(k_dataoggi, "yyyy/mm/") + k_data_x))
		elseif len(k_data_x) = 4 and isnumber(k_data_x) then
			k_data_x = string(date(string(k_dataoggi, "yyyy/") + mid(k_data_x,3,2) + "/" + left(k_data_x,2)))
		elseif len(k_data_x) = 5 and not isnumber(mid(k_data_x,3,1)) then 
			k_data_x = string(date(string(k_dataoggi, "yyyy/") + mid(k_data_x,4,2) + "/" + left(k_data_x,2)))
		else
			k_data_x = string(date(0))
		end if			
		if isdate(k_data_x) then
			k_data = date(k_data_x)
		else
			k_data = date(0)
		end if
		k_rc=this.setitem(row, integer(dwo.id), k_data)
	end if			
//-----------------------------------------------------------------------------------------------------------

//--- sui campi Numerici se vuoto forza ZERO --------------------------------------------
	if dwo.coltype = "Int" or dwo.coltype = "Long" or dwo.coltype = "Number" or left(dwo.coltype,3) = "Dec" or dwo.coltype = "Ulong" then
		if trim(data) = "" then
			this.setitem(row, integer(dwo.id), 0)
		end if
	end if
//-----------------------------------------------------------------------------------------------------------


//--- Controllo se valori immessi nella ddw
//--- Sono su un campo DDW?
//	k_style=this.Describe("#" + trim(dwo.id)+".Edit.Style")
//	if k_style = "dddw" and trim(data) > " " then
//		
////--- Attivo dw 
//		this.getchild(dwo.name, kdwc_1)
//		if isvalid(kdwc_1) then 
//	
//			if ki_db_conn_standard then
//				kdwc_1.settransobject(sqlca)
//			end if
//		
//			if kdwc_1.rowcount() > 0 then
//	
//				k_type = dwo.coltype
//				
//	//--- se i campi "data" e "display" della dddw sono uguali procede 		
//				if this.Describe(dwo.name +".DDDW.DataColumn") = this.Describe(dwo.name +".DDDW.DisplayColumn") then
//					k_return = 1
//					
//					k_ddw_campo = this.Describe(dwo.name +".DDDW.DataColumn")
//					if trim(k_ddw_campo) > " " then
//		//--- cerco se c'e' un valore simile a quello digitato
//						if Left(k_type,2) <> "ch" then
//							if isnull(data) then 
//								k_valore = "0"
//							else
//								k_valore = trim(data)
//							end if
//							k_find_riga=kdwc_1.Find ( k_ddw_campo + "="+k_valore, 1, kdwc_1.rowcount() )
//		//--- se non ho trovato un valore allora cerco per approssimazione
//							if k_find_riga <= 0 then
//								k_find_riga=kdwc_1.Find ( k_ddw_campo + ">="+k_valore, 1, kdwc_1.rowcount() )
//							end if
//						else
//							if isnull(data) then 
//								k_valore = " "
//							else
//								k_valore = trim(data)
//							end if
//							k_find_riga=kdwc_1.Find( k_ddw_campo + "=~""+k_valore+"~"", 1, kdwc_1.rowcount() )
//		//--- se non ho trovato un valore allora cerco per approssimazione
//							if k_find_riga <= 0 then
//								k_find_riga=kdwc_1.Find( k_ddw_campo + ">=~""+k_valore+"~"", 1, kdwc_1.rowcount() )
//							end if
//						end if
//		//--- se ho trovato un valore allora ok
//						if k_find_riga > 0 then
//							k_return = 2
//							if LeftA(k_type,2) <> "ch" then
//								k_rc=this.settext(trim(string(kdwc_1.getitemnumber(k_find_riga, k_ddw_campo))))
//								k_rc=this.setitem(row, integer(dwo.id), kdwc_1.getitemnumber(k_find_riga, k_ddw_campo))
//							else
//								k_valore = trim(kdwc_1.getitemstring(k_find_riga, k_ddw_campo))
//								k_rc=this.setitem(row, integer(dwo.id), k_valore)
//								k_rc=this.settext(k_valore)
//							end if
//						end if
//					end if
//				end if
//			end if
//			
//		end if
//
//	end if



	return k_return



end event

event losefocus;//
this.icon = ki_icona_normale
////
//
//if this.ki_attiva_DRAGDROP then 
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

event constructor;//
if trim(ki_icona_normale) > " " then
	this.icon = ki_icona_normale
end if
kidw_this = this

ki_dataoggi_x = string(today())
ki_dragicon1 = "drag1.ico" //kGuo_path.get_risorse() + kkg.path_sep + "drag1.ico"
ki_dragicon2 = "drag2.ico" //kGuo_path.get_risorse() + kkg.path_sep + "drag2.ico"
this.dragicon = ""

set_flag_modalita(kkg_flag_modalita.visualizzazione)

kist_errori_gestione.nome_oggetto = parent.classname()
kist_errori_gestione.sqlsyntax = ""
kist_errori_gestione.sqlerrtext = ""
kist_errori_gestione.sqldbcode = 0
setnull(kist_errori_gestione.sqlca) 

kiuf_ddw_grid = create kuf_ddw_grid

//--- costruisce oggetto x effetto EXCEL
kin_cst_PowerFilter = create n_cst_PowerFilter  
kin_cst_PowerFilter.of_SetLanguage(3)  //0-english, 1-French, 2-German, 3-Italian, 4-Brazilian Portuguese, 5-Russian 

//post event u_constructor()
event u_constructor()

end event

event dragdrop;//
string k_nome
long k_row, k_ret
DragObject		do_control



//st_barcode.visible = false
this.SetRedraw(FALSE)

//ki_drag_scroll=false	
//this.modify("k_dragdrop_row.Expression='0' ")

//Get the dragged object
do_control = DraggedObject()

IF IsValid(do_control) then //AND this.ki_attiva_DRAGDROP THEN

//	k_ret = this.EVENT ue_BeforeDrop(l_row, dw_source)
	
	IF k_ret <> -1 THEN

//	if not this.IsSelected( row ) then 
		
		CHOOSE CASE TypeOf(source)
		
			CASE datawindow!
		
				kidw_source = source
			
//				kidw_source.Drag(cancel!)
//				this.dragicon = ""
				if isvalid(kidw_source) then
					if kidw_source.ki_UltRigaSel > 0 then
						k_row = kidw_source.ki_UltRigaSel
					 else
						k_row = 1
					end if
					this.scrolltorow( k_row)
						
					IF kidw_source <> this THEN
						
	//--- Drop qlc il quale non e' dal ns Datawindow
						IF Lower(kidw_source.dataobject) = Lower(this.dataobject) THEN
							
	//--- DataObjects  sono uguali (drop x DW UGUALI)
							k_ret = this.EVENT ue_DropFromSame(ki_riga_dragwithin, kidw_source)
							
						ELSE
							
	//--- Noi Copiamo da un altro DW.. l'utente deve fare Copy stuff (drop ESTERNO)
							k_ret = this.event ue_drop_out(k_row, kidw_source)
							if k_ret = 1 then
								kidw_source.event ue_drag_out(k_row, this)	
							end if
							
						END IF
					ELSE
						
	//--- Noi Drop dal  Datawindow (i drop INTERNO )
						if ki_riga_dragwithin > 0 then 
							k_ret = this.EVENT ue_DropFromThis(ki_riga_dragwithin, kidw_source)	
						end if
						
					END IF
	
					if ki_riga_dragwithin > 0 then 
						this.setrow(ki_riga_dragwithin)
					end if
				end if
//				choose case kdw_1.classname()
//						
//					case "dw_lista_sel" 
//						this.postevent( "ue_aggiungi_riga")
//		
//				end choose
//				
				
		END CHOOSE

//	ELSE
//--- Mark Row come Errore x AfterDrop
//		k_row = 0
	END IF
		
//--- AfterDrop e' sempre Fired
//	this.EVENT ue_AfterDrop(k_row)
	
	
end if

//--- pulisco area del drag&drop
event ue_dragdrop_end( )

this.SetRedraw(true)



end event

event dragleave;//
//	if this.ki_attiva_DRAGDROP then 

		this.event ue_dragleave_post()

//	end if
		

end event

event dragwithin;boolean k_piu_righe = false
//string k_alla_riga = ""
long k_last_row = 0, k_first_row=0, k_riga=0


if this.ki_attiva_DRAGDROP then

	ki_drag_scroll=false	
	
	
	if row = 0 then
	
	
	else
//--- se sono ll'interno dello stesso oggetto da DRAGGARE		
		if TypeOf(source) = datawindow! then
			
			kidw_source = source
			if isvalid(kidw_dragdrop_this) and isvalid(kidw_source) then 
				if kidw_dragdrop_this = kidw_source then
	
//---- Imposta ki_UltRigaSel se non lo è ancora 
					if ki_UltRigaSel <= 0 then  
						if this.getselectedrow(0) = 0 then
							this.selectrow(row, true)	
						end if
						ki_UltRigaSel = this.getselectedrow(0)
						ki_dragdrop_display = "Riga: " + string(row) //string(this.getitemnumber(ki_UltRigaSel, "ordine")) +"-"+ trim(this.getitemstring(ki_UltRigaSel, "barcode")) 
					end if
//------------------------------------------------------------------------------------------		

//---- se sono piu' di 1 riga da drag allora multi-drag	
					if this.dragicon > " " then  // faccio solo la prima volta
					else
						k_riga = this.getselectedrow(0) 
						if k_riga > 0 then
							if this.getselectedrow(k_riga) > 0 then
								k_piu_righe = true
								this.dragicon = ki_dragicon2 
							else
		//						this.dragicon = kGuo_path.get_risorse() + "\drag1.ico"
								this.dragicon = ki_dragicon1
							end if
						end if
					end if
//------------------------------------------------------------------------------------------		
					if ki_UltRigaSel <> row then
					
//						if ki_riga_dragwithin > 0 then
//						end if
						ki_riga_dragwithin = row
//						if this.IsSelected( row ) then
//							k_alla_riga = " ??? "
//						else
//							k_alla_riga =   "   > "+ string(row)
//						end if
	
					
//						if k_piu_righe then
				//			st_barcode.text = " " + ki_dragdrop_display + "....." + k_alla_riga
//						else
				//			st_barcode.text = " " + ki_dragdrop_display + k_alla_riga  
//						end if
				//		st_barcode.visible = true
					end if					
				end if
			end if

//--- scrolla le righe x mostrare il dragging
			if not ki_u_drag_scroll_lanciata then
				u_drag_scroll(row)
			end if

		end if
	end if
end if
	
	

end event

event retrievestart;//
event u_personalizza_dw()

kipointer_orig = setpointer(HourGlass!)


end event

event retrieveend;//
setpointer(kipointer_orig)


end event

event destructor;
//--- Se sono nel ciclo ciclo Drag&Drop cerca prima di uscire da quello poi Distrugge 
if ki_drag_scroll  then
	ki_drag_scroll=false
	post u_sleep(1)
end if
if isvalid(kin_cst_PowerFilter) then destroy kin_cst_PowerFilter
if isvalid(kiuf_menu_popup) then destroy kiuf_menu_popup

end event

event rowfocuschanged;//
// NON METTERE NIENTE QUIIIII!!!!
// MA SE SI DEVE LANCIARE LA SELEZIONE DELLA RIGA PENSARE COME AVVIENE E FARLO IN QUEl POSTO (NON PENSARE MALE!)

//u_selectrow (currentrow) questa istruzione fa casino!!

end event

event editchanged;//
// se abilitato mostra mentre si digita il primo valore completo che trova nel ddw
if ki_abilita_ddw_proposta then
	if len(trim(data)) > 2 then
		if isvalid(kiuf_ddw_grid) then kiuf_ddw_grid.u_editchanged(row, dwo, data)
	end if
end if

end event

event itemfocuschanged;// se abilitato mostra mentre si digita il primo valore completo che trova nel ddw
if ki_abilita_ddw_proposta then
	if isvalid(kiuf_ddw_grid) then kiuf_ddw_grid.u_itemfocuschanged(row, dwo)
end if

end event

event resize;//
if isvalid(kin_cst_PowerFilter) then
	if kin_cst_PowerFilter.checked then
		kin_cst_PowerFilter.event ue_positionbuttons()	
	end if
end if

post u_fine_primo_giro( )
//int k
//k=0
end event

