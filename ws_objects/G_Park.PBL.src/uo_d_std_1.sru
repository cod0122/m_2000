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
boolean border = false
boolean hsplitscroll = true
boolean livescroll = true
event ue_dwnkey pbm_dwnkey
event u_doppio_click pbm_custom01
event u_pigiato_enter pbm_dwnprocessenter
event rbuttonup pbm_rbuttonup
event ue_visibile ( boolean k_visibile )
event u_personalizza_dw ( )
event ue_timer pbm_timer
event ue_selectrow ( long k_riga )
event type long ue_dropfromsame ( long k_droprow,  uo_d_std_1 kdw_source )
event type long ue_dropfromthis ( long k_droprow,  uo_d_std_1 kdw_source )
event ue_dragleave_post ( )
event type long ue_drop_out ( long k_droprow,  uo_d_std_1 kdw_source )
event ue_dwnmousemove pbm_dwnmousemove
event ue_lbuttondown pbm_lbuttondown
event ue_lbuttonup pbm_lbuttonup
event ue_lbuttonup_post ( )
event type long ue_drag_out ( long k_droprow,  uo_d_std_1 kdw_target )
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
public string ki_flag_modalita = kkg_flag_modalita_visualizzazione

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
//public long ki_riga_selected = 0
//public long ki_riga_selected_sel = 0
public string ki_dragdrop_display = " "
private long ki_riga_dragwithin = 0
private long ki_clicked_row = 0
private long ki_clicked_row_sel = 0
private long ki_lbuttondown_row=0
public boolean ki_in_DRAG = false
private boolean ki_drag_scroll=false
private boolean ki_u_drag_scroll_lanciata=false
//private time ki_keyleftbutton_ini  //--- Serve per capire sto tenendo premuto il TASTO sx del MOUSE (senza CTRL) per alcuni istanti così da fare ad es. il DRAG&DROP
private datawindow ki_dragdrop_oggetto

//--- variabile gestione x errori DB
public:
st_errori_gestione kist_errori_gestione


end variables

forward prototypes
public function boolean dati_modificati ()
public function boolean u_filtra_record (string k_filtro)
public function long u_get_riga_atpointer (string k_nome_campo)
private function boolean link_standard_call_p (string k_tipo) throws uo_exception
private subroutine link_standard_imposta_p ()
private subroutine personalizza_dw ()
private function string button_standard_call_p (string k_tipo) throws uo_exception
private subroutine link_standard_imposta ()
private subroutine u_drag_scroll (long row)
public function boolean u_sort (readonly string a_nome_campo)
protected function boolean link_standard_call (string k_tipo) throws uo_exception
end prototypes

event ue_dwnkey;//
long k_riga
string k_bands=""


//--- se tasto ESC provo l'undo
if key = KeyESCape! then

//--- chiude eventuali DRAG & GDROP
	THIS.Drag(cancel!)
	ki_in_DRAG = false		 
	setnull(ki_dragdrop_oggetto)
	ki_drag_scroll=false	
	this.modify("k_dragdrop_row.Expression='0' ")

//--- se tasto ESC provo l'undo
//--- Undelete
	IF this.CanUndo() THEN
		this.Undo()
	end if
	
else

//--- sono in TREEVIEW ?
	if (this.Object.DataWindow.Processing = "1" or this.Object.DataWindow.Processing = "8" or this.Object.DataWindow.Processing = "9") then

		IF keyflags = 1 THEN //con SHIFT

			k_riga = this.GetRow()
		
			IF k_riga > 0 THEN
		
				this.SetRedraw(FALSE)
			
				IF key = KeyUpArrow! THEN
					if k_riga > 1 then
						if IsSelected ( k_riga - 1) then
							SelectRow(k_riga      , FALSE)
							ki_UltRigaSel = k_riga - 1
						else
							SelectRow(k_riga - 1, TRUE)
						end if
						
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
					end if
				END IF
				
				this.SetRedraw(true)
		
				
			END IF
				
				
		ELSEIF keyflags = 2 THEN // con CTRL
				
			k_riga = this.GetRow()
			IF key = KeyDownArrow! THEN
				ScrollToRow(k_riga )
//				return 1
			END IF
			
			IF key = KeyUpArrow! THEN
				ScrollToRow(k_riga )
//				return 1
			END IF
				
		ELSEIF keyflags = 0 THEN  // solo il tasto premuto
				
			k_riga = this.GetRow()

//			k_bands=this.Describe("DataWindow.Bands") 
////--- verifica se sono sul Banda HEADER (probabile in treeeview) deseleziono tutto
//			if pos(k_bands, "header") > 1 then
//				SelectRow(0, false)	
//			end if

			IF k_riga > 0 THEN

				this.SetRedraw(false)
				
				IF key = KeyUpArrow! THEN
					this.selectrow( 0, false)
					IF k_riga  > 1 THEN
						ki_UltRigaSel = k_riga - 1
						SelectRow(k_riga - 1, TRUE)	
					else
						SelectRow(1, TRUE)	
					END IF
				END IF
				
				IF key = KeyDownArrow! THEN
					this.selectrow( 0, false)
					IF k_riga < this.RowCount() THEN
						ki_UltRigaSel = k_riga + 1
						SelectRow(k_riga + 1, TRUE)	
					else
						SelectRow(this.RowCount(), TRUE)	
					END IF
				END IF
				
				this.SetRedraw(TRUE)
			
			END IF
		END IF
		
	end if


	if ki_UltRigaSel = 0 then
		ki_UltRigaSel = this.getselectedrow ( 0 )
	end if

end if



return 0


end event

event u_doppio_click;//
//--- Operazione di default una volta fatto il doppio click su dw
	parent.triggerevent (doubleclicked!)

//--- esempio di cosa fare in questa funzione
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
	datawindow kdw
	kdw = this

//--- Calendario
	if ki_riga_rbuttondown > 0 then

//--- seleziona la riga su cui si trova 		
		if ki_attiva_standard_select_row and not ki_d_std_1_primo_giro then
			event ue_selectrow (ki_riga_rbuttondown)
		end if
		
		if kidwo_1.type = "column" then
			if lower(MidA(kidwo_1.coltype,1,4)) = "date" &
				and integer(this.Describe(trim(kidwo_1.name)+".TabSequence")) > 0 &
				and this.Describe(trim(kidwo_1.name)+".Protect") = "0" & 
				and this.Describe(trim(kidwo_1.name)+".edit.DisplayOnly") <> "yes"   & 
				then
				gf_dw_pop_calendar(kdw,kidwo_1.name,kidwo_1.coltype,ki_riga_rbuttondown)
			else
				parent.triggerevent("rbuttonup")
			end if
		else
			parent.triggerevent("rbuttonup")
		end if
	else
		parent.triggerevent("rbuttonup")
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
//---- imposta i link standard se attivi e              // se è cambiata la dataobject 
//	if ki_link_standard_attivi then //and ki_ultima_dataobject <> this.dataobject then
//03.04.2008	if ki_link_standard_possibile then //and ki_ultima_dataobject <> this.dataobject then
	if ki_link_standard_attivi &
		and ((ki_flag_modalita <> kkg_flag_modalita_modifica and ki_flag_modalita <> kkg_flag_richiesta_inserimento) &
			or ki_link_standard_sempre_possibile) then
		
		ki_ultima_dataobject = this.dataobject 

		try
			personalizza_dw()
			link_standard_imposta() 
		catch (uo_exception kuo_exception)
			kuo_exception.messaggio_utente()
		end try
		
	end if


end event

event ue_timer;//
//
//// --- diamo spazio a eventuali eventi in coda 
//Yield()
//
end event

event ue_selectrow(long k_riga);//
long k_riga_ctr, k_riga_ini, k_riga_fin, k_riga_select
int k_ctr



//--- seleziona le righe del DW solo x i tipi GRID
if this.Object.DataWindow.Processing = "1" or this.Object.DataWindow.Processing = "8" or this.Object.DataWindow.Processing = "9" then
	
	if ki_UltRigaSel = 0 then	
		if k_riga > 0 then 
			ki_UltRigaSel = k_riga
		else
			if this.getselectedrow ( 0 ) > 0 then
				ki_UltRigaSel = this.getselectedrow ( 0 )
			else
				if this.getrow() > 0 then
					ki_UltRigaSel = this.getrow ( )
				else
					ki_UltRigaSel = 0
				end if
			end if
		end if
	end if
	
//--- ctrlt+click	per seleziare altra riga
	if keydown( keycontrol! ) then
		
		if k_riga > 0 then 
			
			if this.isselected( k_riga) then
				this.selectrow ( k_riga, false )
			else
				this.selectrow ( k_riga, true )
			end if
			ki_UltRigaSel = k_riga
			
		end if
		
	else
		 
	//--- shift+click	per selezione multipla	
		if keydown( keyshift! ) then 
			this.setredraw ( false )
			
			if this.getselectedrow ( 0 ) = 0 then
				k_riga_ini = k_riga
			else
				k_riga_ini = this.getrow()
			end if
			k_riga_fin = k_riga
			ki_UltRigaSel = k_riga
			
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
			if k_riga > 1 then
				this.selectrow ( k_riga, true )
			else
	//--- solo per il tipo GRID fa la selezione della riga n.1	
				if k_riga = 1 &
					and (this.Object.DataWindow.Processing = "1"  or this.Object.DataWindow.Processing = "8" or this.Object.DataWindow.Processing = "9") then
					this.selectrow ( k_riga, true )
				end if
			end if 
			ki_UltRigaSel = k_riga
			
		end if 
		
	end if
	
end if


this.setrow( k_riga )


end event

event type long ue_dropfromsame(long k_droprow, uo_d_std_1 kdw_source);//
// Dragged da un DW che ha lo stesso Dataobject del nostro

Long		k_row=0

// ---

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


RETURN 1
end event

event type long ue_dropfromthis(long k_droprow, uo_d_std_1 kdw_source);
// We Dragged From this... we Drop to this...

Long		l_row, l_selectedRows, l_rowSave[], l_index, l_rowCount
Long		l_subRows

// ---

//Go Through all selected Rows And Move Them to the destination Datawindow (this)



IF (kdw_source.GetRow() <> k_droprow OR k_droprow = this.RowCount() OR k_droprow = 1) AND ki_UltRigaSel <> k_droprow  THEN
	
	l_rowCount = this.RowCount()
	
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
	// Change Move To Row.. All Rows wich was selected bevore have to be substracted
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
	
	// CurrentRow Should Be Dragged Row now
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
	if row > 0 and not ki_in_DRAG then
	
		if keydown(keyleftbutton!)  and not  keydown(keycontrol!) then
				
			k_riga = this.getselectedrow(0) 
			if k_riga > 0 then
				

				if this.getselectedrow(k_riga) > 0 then
//					this.dragicon = kGuo_path.get_risorse() + "\drag2.ico"
					this.dragicon = "drag2.ico"
				else
//					this.dragicon = kGuo_path.get_risorse() + "\drag1.ico"
					this.dragicon = "drag1.ico"
				end if
						
				ki_in_DRAG = true		 
				this.drag(begin!)
				ki_dragdrop_oggetto = this
				
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
	
		end if
	end if
end if

end event

event ue_lbuttonup;//

	if this.ki_attiva_DRAGDROP then
		this.event ue_lbuttonup_post()
	end if
end event

event ue_lbuttonup_post();//
//	st_barcode.visible = false
	ki_lbuttondown_row = 0
	ki_in_DRAG = false		 
	this.drag(end!)
	setnull(ki_dragdrop_oggetto)
	ki_drag_scroll=false	
	this.modify("k_dragdrop_row.Expression='0' ")

end event

event type long ue_drag_out(long k_droprow, uo_d_std_1 kdw_target);//
//--- Questo Evento serve a 'Gestire' il DRAG dopo che è stato eseuito il DROP sul dw sorgente (esterno)
//---  quindi prima di ques è stato lanciatao il UE_DROP_OUT nel DW target
//

//--- DA PERSONALIZZARE

//
RETURN 1
end event

public function boolean dati_modificati ();//
//--- Compiute modifice nel dw?
//--- true=si; false=no
//
	
	if this.enabled then

		this.accepttext()
		
		if (this.Object.DataWindow.Table.UpdateTable <> " " and &
			 (this.getnextmodified(0, primary!) > 0  &
					or this.getnextmodified(0, delete!) > 0) &
					or this.ModifiedCount ( ) > 0) then
			return true
		else
			return false
		end if

	else
		return false

	end if
end function

public function boolean u_filtra_record (string k_filtro);//
//--- filtra le righe cosi':
//---             k_filtro = la codizione di filtro
//
boolean k_return
int k_ctr, k_rc



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

public function long u_get_riga_atpointer (string k_nome_campo);long k_riga=0
string k_rigax
int k_ctr


//--- potrebbe essere un tree per cui prendo il NUMERO RIGA se ho premuto su un NODO
		k_rigax = this.GetObjectAtPointer()
		k_ctr = len(k_rigax)
		k_rigax = Replace ( k_rigax, pos( k_rigax,trim(k_nome_campo), 1) , len(trim(k_nome_campo)) , space(len(trim(k_nome_campo))) )

		if isnumber(trim(k_rigax)) then 
			k_riga = long(trim(k_rigax))
		else
			k_riga = 0
		end if
		
return k_riga


end function

private function boolean link_standard_call_p (string k_tipo) throws uo_exception;//
//--- Chiama le window con funzione standard di consultazione
//--- Input:   k_tipo    = tipo di funzione standard da chiamare
//---             this   = data_window dalla quale prelevare i dati 
//--- Output: boolean TRUE = ok e' entrato in funzione; FALSE=non ha fatto niente
//
boolean k_return=true
st_esito kst_esito
st_tab_meca kst_tab_meca
st_tab_barcode kst_tab_barcode
st_tab_certif kst_tab_certif
st_tab_arfa kst_tab_arfa
st_tab_sl_pt kst_tab_sl_pt
st_tab_armo kst_tab_armo
st_tab_clienti kst_tab_clienti
st_tab_contratti kst_tab_contratti 
st_tab_prodotti kst_tab_prodotti
st_tab_listino kst_tab_listino
st_tab_sr_utenti kst_tab_sr_utenti
st_tab_ricevute kst_tab_ricevute
st_tab_prof kst_tab_prof
kuf_armo_tree kuf1_armo_tree
kuf_barcode_tree kuf1_barcode_tree
kuf_sped kuf1_sped
kuf_fatt kuf1_fatt
kuf_certif kuf1_certif
kuf_clienti kuf1_clienti
kuf_sl_pt kuf1_sl_pt
kuf_contratti kuf1_contratti 
kuf_contratti_rd kuf1_contratti_rd 
kuf_prodotti kuf1_prodotti 
kuf_listino kuf1_listino
kuf_sicurezza kuf1_sicurezza
kuf_ricevute kuf1_ricevute
kuf_prof kuf1_prof
kuf_ausiliari kuf1_ausiliari
kuf_wm_pklist kuf1_wm_pklist
kuf_contratti_co kuf1_contratti_co
kuf_esito_operazioni kuf1_esito_operazioni
kuf_docprod kuf1_docprod
pointer kp_oldpointer



kp_oldpointer = SetPointer(hourglass!)

st_open_w kst_open_w 
datastore kdsi_elenco_output   //ds da passare alla windows di elenco
kuf_menu_window kuf1_menu_window


if NOT isvalid(kdsi_elenco_output) then kdsi_elenco_output = create datastore //destroy kdsi_elenco_output


choose case k_tipo
		
	case "barcode", "barcode_t", "barcode_lav" &
		,"barcode_figli", "barcode_figli_t" &
		,"b_barcode_lotto" &
		,"grp"
		kuf1_barcode_tree = create kuf_barcode_tree
		k_return = kuf1_barcode_tree.link_call( kidw_this, k_tipo )
		destroy kuf1_barcode_tree
		
	case "num_int", "num_int_t", "id_meca", "b_armo", "id_armo", "id_meca_righe"
		kuf1_armo_tree = create kuf_armo_tree
		k_return = kuf1_armo_tree.link_call( kidw_this, k_tipo )
		destroy kuf1_armo_tree

	case "b_arsp_lotto", "b_arsp_sped", "num_bolla_out", "num_bolla_out_1", "arsp_insped"
		kuf1_sped = create kuf_sped
		k_return = kuf1_sped.link_call( kidw_this, k_tipo )
		destroy kuf1_sped
		
	case "b_arfa_lotto", "num_fatt", "b_fatt_righe"
		kuf1_fatt = create kuf_fatt
		k_return = kuf1_fatt.link_call( kidw_this, k_tipo )
		destroy kuf1_fatt
		
	case "clie_1", "clie_2", "clie_3", "clie", "cod_cli", "id_cliente", "id_cliente_link", "b_cliente_mkt", "b_cliente_web", "b_m_r_f", "id_contatto_1", "id_contatto_2", "id_contatto_3", "id_contatto_4", "id_contatto_5", "b_elenco_clienti_del_contatto" &    
			,"email", "email1", "email2",  "sito_web", "sito_web1" 
		kuf1_clienti = create kuf_clienti
		k_return = kuf1_clienti.link_call( kidw_this, k_tipo )
		destroy kuf1_clienti
		
	case "id_contratto_rd" 
		kuf1_contratti_rd = create kuf_contratti_rd
		k_return = kuf1_contratti_rd.link_call( kidw_this, k_tipo )
		destroy kuf1_contratti_rd
		
	case "id_contratto_co" 
		kuf1_contratti_co = create kuf_contratti_co
		k_return = kuf1_contratti_co.link_call( kidw_this, k_tipo )
		destroy kuf1_contratti_co
	
	case "b_cap_l", "b_clie_settori", "b_clie_classi", "b_nazioni_l", "gruppo", "id_clie_settore" 
		kuf1_ausiliari	= create kuf_ausiliari
		k_return = kuf1_ausiliari.link_call( kidw_this, k_tipo )
		destroy kuf1_ausiliari
		
	case "num_certif"  &
			,"b_certif_lotto" 
		kuf1_certif = create kuf_certif
		k_return = kuf1_certif.link_call( kidw_this, k_tipo )
		destroy kuf1_certif
		
	case "cod_sl_pt", "sl_pt"
		kuf1_sl_pt = create kuf_sl_pt
		k_return = kuf1_sl_pt.link_call( kidw_this, k_tipo )
		destroy kuf1_sl_pt

	case "id_listino"
		kuf1_listino = create kuf_listino 
		k_return = kuf1_listino.link_call ( kidw_this, k_tipo )
		destroy kuf1_listino

//	case "b_certif_lotto" 
//		kst_tab_certif.id_meca = this.getitemnumber(this.getrow(), "id_meca")
//		if kst_tab_certif.id_meca > 0 then
//
//			kuf1_certif = create kuf_certif
//			kuf1_certif.get_num_certif (kst_tab_certif)
//			kst_esito = kuf1_certif.anteprima ( kdsi_elenco_output, kst_tab_certif )
//			destroy kuf1_certif
//			if kst_esito.esito <> kkg_esito.ok then
//				kuo_exception = create uo_exception
//				kuo_exception.set_esito( kst_esito)
//				throw kuo_exception
//			end if
//			kst_open_w.key1 = "Elenco Righe Attestato di Trattamento  (id lotto=" + trim(string(kst_tab_armo.id_meca)) + ") " 
//		else
//			k_return = false
//		end if

	case "contratto", "mc_co", "contratti_codice",  "sc_cf", "cf"
		kuf1_contratti = create kuf_contratti 
		k_return = kuf1_contratti.link_call ( kidw_this, k_tipo )
		destroy kuf1_contratti


	case "art", "cod_art"
		kuf1_prodotti = create kuf_prodotti 
		k_return = kuf1_prodotti.link_call ( kidw_this, k_tipo )
		destroy kuf1_prodotti

	case "x_utente" &
		, "x_utente_cert_alim" &
		, "x_utente_cert_farm" &
		, "x_utente_cert_f_st"
		kuf1_sicurezza = create kuf_sicurezza 
		k_return = kuf1_sicurezza.link_call ( kidw_this, k_tipo )
		destroy kuf1_sicurezza

	case "id_ric", "b_ric_lotto" 
		kuf1_ricevute = create kuf_ricevute 
		k_return = kuf1_ricevute.link_call ( kidw_this, k_tipo )
		destroy kuf1_ricevute
		
	case "b_contab" 
		kuf1_prof = create kuf_prof 
		k_return = kuf1_ricevute.link_call ( kidw_this, k_tipo )
		destroy kuf1_prof

	case "id_wm_pklist", "idpkl", "b_wm_pklist_righe", "id_wm_pklist_riga" 
		kuf1_wm_pklist = create kuf_wm_pklist
		k_return = kuf1_wm_pklist.link_call( kidw_this, k_tipo )
		destroy kuf1_wm_pklist

	case "esito_operazioni_ts_operazione" 
		kuf1_esito_operazioni = create kuf_esito_operazioni
		k_return = kuf1_esito_operazioni.link_call( kidw_this, k_tipo )
		destroy kuf1_esito_operazioni

	case "id_docprod", "b_docprod", "id_docprod_file" 
		kuf1_docprod = create kuf_docprod
		k_return = kuf1_docprod.link_call( kidw_this, k_tipo )
		destroy kuf1_docprod


	case else
		k_return = false
		
end choose

SetPointer(kp_oldpointer)

	
return k_return


end function

private subroutine link_standard_imposta_p ();//
//--- link_standard_imposta
//--- Imposta nel DW i "Link Standard" ovvero il campo blu sottolinato con "manina" come cursore
//
//---
integer k_num_colonne_nr, k_ctr=1
string k_num_colonne, k_nome


	k_num_colonne = this.Object.DataWindow.Column.Count
	if isnumber(k_num_colonne) then
		k_num_colonne_nr = integer(k_num_colonne)
	else
		k_num_colonne_nr = 99
	end if
	do 

			k_nome=lower(this.Describe("#" + trim(string(k_ctr,"###"))+".name"))
			choose case k_nome

//--- se LINK standard (sottolinea il campo)
				case "clie_1", "clie_2", "clie_3", "clie", "cod_cli", "id_cliente", "id_cliente_link" &
					, "id_contatto_1", "id_contatto_2", "id_contatto_3", "id_contatto_4", "id_contatto_5" &   
					 ,"barcode","barcode_lav", "cod_sl_pt", "sl_pt", "contratto", "sc_cf" &
					 ,"barcode_figli" &
					 ,"art", "cod_art" &
					 ,"id_listino" &
					 ,"id_meca" &
					 ,"id_armo" &
					, "id_meca_righe" &
					 ,"x_utente"  &
					, "x_utente_cert_alim" &
					, "x_utente_cert_farm" &
					, "x_utente_cert_f_st" &
					, "id_ric" &
					, "num_bolla_out" &
					, "num_bolla_out_1" &
					, "email", "email1", "email2", "sito_web", "sito_web1" &
					, "id_contratto_rd" &
					, "id_contratto_co" &
					, "id_wm_pklist" &
					, "idpkl" &
					, "esito_operazioni_ts_operazione"  &
					, "gruppo" &
					, "id_clie_settore" &
					, "gru" &
					, "num_certif"  &
					, "id_docprod"  
					
//--- se e' del tipo grid o tabular link sul valore alrimenti sul testo		
					if this.Object.DataWindow.Type <> "Form" then
						
//						this.Modify("#" + trim(string(k_ctr,"###"))+&
//									  ".Font.Underline = 1")
						this.Modify("#" + trim(string(k_ctr,"###"))+&
									  ".Color = '" + string(kk_colore_blu)+"' ")
						this.Modify("#" + trim(string(k_ctr,"###"))+&
									  ".pointer = 'HyperLink!' " )
					else
//--- ..... alrimenti sul testo		
//						this.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
//									  ".Font.Underline = 1")
						this.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
									  ".Color = '" + string(kk_colore_blu)+"' ")
						this.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
									  ".pointer = 'HyperLink!' " )
					  end if

				
//				case "barcode", "cod_sl_pt", "sl_pt", "contratto", "sc_cf"
//					
////--- se e' del tipo grid o tabular link sul valore alrimenti sul testo		
//					if this.Object.DataWindow.Type <> "Form" then
//						
//						this.Modify("#" + trim(string(k_ctr,"###"))+&
//									  ".Font.Underline = 1")
//						this.Modify("#" + trim(string(k_ctr,"###"))+&
//									  ".Color = '" + string(kk_colore_blu)+"' ")
//						this.Modify("#" + trim(string(k_ctr,"###"))+&
//									  ".pointer = 'HyperLink!' " )
//					else
////--- ..... alrimenti sul testo		
//						this.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
//									  ".Font.Underline = 1")
//						this.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
//									  ".Color = '" + string(kk_colore_blu)+"' ")
//						this.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
//									  ".pointer = 'HyperLink!' " )
//					  end if
//	      	k_lista = tab_1.tabpage_9.dw_9.Object.DataWindow.Processing se "1"=GRID

				
				case  "mc_co",  "contratti_codice"
					
					if this.Object.DataWindow.Type <> "Form" then
						if trim(this.Describe("contratti_codice.x")) <> "!" then 
//							this.Modify("#" + trim(string(k_ctr,"###"))+&
//										  ".Font.Underline = 1")
							this.Modify("#" + trim(string(k_ctr,"###"))+&
										  ".Color = '" + string(kk_colore_blu)+"' ")
							this.Modify("#" + trim(string(k_ctr,"###"))+&
										  ".pointer = 'HyperLink!' " )
						end if
					else
						if trim(this.Describe("contratti_codice_t.x")) <> "!" then 
//							this.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
//										  ".Font.Underline = 1")
							this.Modify(k_nome+ "_t" + trim(string(k_ctr,"###"))+&
										  ".Color = '" + string(kk_colore_blu)+"' ")
							this.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
										  ".pointer = 'HyperLink!' " )
						end if
					end if

				
//				case "barcode_figli"
//					
////--- se e' del tipo grid o tabular link sul valore alrimenti sul testo		
//					if this.Object.DataWindow.Type <> "Form" then
//						
//						this.Modify("#" + trim(string(k_ctr,"###"))+&
//									  ".Font.Underline = 1")
//						this.Modify("#" + trim(string(k_ctr,"###"))+&
//									  ".Color = '" + string(kk_colore_blu)+"' ")
//						this.Modify("#" + trim(string(k_ctr,"###"))+&
//									  ".pointer = 'HyperLink!' " )
//					else
////--- ..... alrimenti sul testo		
//						this.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
//									  ".Font.Underline = 1")
//						this.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
//									  ".Color = '" + string(kk_colore_blu)+"' ")
//						this.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
//									  ".pointer = 'HyperLink!' " )
//					  end if
//								  
								  
				case "num_int"
//--- per farlo diventare un link ho bisogno anche del campo "id_meca"

					if this.Object.DataWindow.Type <> "Form" then
						if trim(this.Describe("id_meca.x")) <> "!" then 
//							this.Modify("#" + trim(string(k_ctr,"###"))+&
//										  ".Font.Underline = 1")
							this.Modify("#" + trim(string(k_ctr,"###"))+&
										  ".Color = '" + string(kk_colore_blu)+"' ")
							this.Modify("#" + trim(string(k_ctr,"###"))+&
										  ".pointer = 'HyperLink!' " )
						end if
					else
						if trim(this.Describe("num_int_t.x")) <> "!" then 
//							this.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
//										  ".Font.Underline = 1")
							this.Modify(k_nome+ "_t" + trim(string(k_ctr,"###"))+&
										  ".Color = '" + string(kk_colore_blu)+"' ")
							this.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
										  ".pointer = 'HyperLink!' " )
						end if
					end if
					
				case "num_fatt"  //, "data_fatt" 
					if this.Object.DataWindow.Type <> "Form" then
						if trim(this.Describe("num_fatt.x"))  <> "!" then 
//							this.Modify("#" + trim(string(k_ctr,"###"))+&
//										  ".Font.Underline = 1")
							this.Modify("#" + trim(string(k_ctr,"###"))+&
										  ".Color = '" + string(kk_colore_blu)+"' ")
							this.Modify("#" + trim(string(k_ctr,"###"))+&
										  ".pointer = 'HyperLink!' " )
						end if
					else
						if trim(this.Describe("num_fatt.x"))  <> "!" then 
//							this.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
//										  ".Font.Underline = 1")
							this.Modify(k_nome+ "_t" + trim(string(k_ctr,"###"))+&
										  ".Color = '" + string(kk_colore_blu)+"' ")
							this.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
										  ".pointer = 'HyperLink!' " )
						end if
					end if
					

				
			end choose

		k_ctr = k_ctr + 1 

	loop while k_ctr <= k_num_colonne_nr 
end subroutine

private subroutine personalizza_dw ();//
//--- Personalizza DW (es. colora le righe agg. di recente)
//--- 
//
//---
integer k_num_colonne_nr, k_ctr=1, k_pos
string k_num_colonne, k_colore, K_RET, k_str, k_colore_orig


	if ki_colora_riga_aggiornata and this.rowcount( ) > 1 then

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
				//--- controllo se nella dw c'e' gia' una EXPRESSION
				k_pos = pos(k_colore, "~t", 1) 
				if k_pos > 0 then 
//--- piglia l'espressione senza le Virgolette
					k_colore_orig = mid(k_colore, k_pos, len(k_colore) - k_pos  )
					k_str = "#" + trim(string(k_ctr,"###"))+".background.color=~" 0"   &
							+"~tif( date(x_datins) =  date('" + string(kGuo_g.get_dataoggi()) +"'),"+ KK_COLORE_REC_UPDX + "," +k_colore_orig + ") ~"" //~""
				else
					k_str = "#" + trim(string(k_ctr,"###"))+".background.color=~" 0"  &
							+"~tif( date(x_datins) = date('" + string(kGuo_g.get_dataoggi()) +"'),"+ KK_COLORE_REC_UPDX + "," +k_colore + ") ~"" //~""
				end if
				k_ret = this.Modify(k_str)
				k_ctr = k_ctr + 1 //+ k_colore &
			
			loop while k_ctr <= k_num_colonne_nr 
		end if
	end if	
	
end subroutine

private function string button_standard_call_p (string k_tipo) throws uo_exception;//-----------------------------------------------------------------------------------------------------------------------------------------------
//---
//--- Inserire l'associazione tra un BUTTON e la funzione che deve attivare
//--- Input:   k_tipo    = button pigiato
//---             
//--- Output: TIPO = il tipo di funzione da chiamare (vedi nella "link_standard_call_p")
//---             spazio = nesuna funzione da chiamare
//---
//-----------------------------------------------------------------------------------------------------------------------------------------------
//
string k_return=""



choose case k_tipo
		
	case "b_meca"
		k_return = "id_meca"
		
	case "b_barcode_dett"		
		k_return = "barcode"

	case "b_barcode_figli"		
		k_return = "barcode_figli"
		
	case "b_barcode" 
		k_return = "b_barcode_lotto"

	case "b_armo"
		k_return = "id_armo"

	case "b_arsp" 
		k_return = "b_arsp_lotto"
		
	case "b_arfa" 
		k_return = "b_arfa_lotto"
		
	case "b_fatt"
		k_return = "num_fatt"
		
	case "b_fatt_righe"
		k_return = "b_fatt_righe"
		
	case "b_certif" 
		k_return = "b_certif_lotto"
		
	case "b_cliente" 
		k_return = "id_cliente" 
	
	case "b_sl_pt" 
		k_return = "sl_pt"
		
	case "b_contratto" 
		k_return = "contratti_codice"

	case "b_sc_cf" 
		k_return = "sc_cf"

	case "b_art" 
		k_return = "art"

	case "b_listino" 
		k_return = "id_listino"

	case "b_utente" 
		k_return = "x_utente"
		
	case "b_ric" 
		k_return = "id_ric"

	case "b_sped" 
		k_return = "num_bolla_out"
		
	case "b_contratto_rd" 
		k_return = "id_contratto_rd"

	case "b_ric_lotto", "b_cap_l",  "b_nazioni_l",  "b_clie_settori",  "b_clie_classi", "b_contab", "b_cliente_mkt", "b_ciente_web" & 
		, "b_arsp_sped", "b_m_r_f", "b_elenco_clienti_del_contatto", "b_wm_pklist_righe", "b_docprod"
		k_return = k_tipo
		
	case "b_gruppo"
		k_return = "gruppo"
		
		
	case else
		k_return = ""
		
end choose

	
return k_return


end function

private subroutine link_standard_imposta ();//-----------------------------------------------------------------------------------------------------------------------------------------------
//---
//--- link_standard_imposta
//--- Imposta nel DW i "Link Standard" ovvero mette il campo in blu con "manina" come cursore
//---
//-----------------------------------------------------------------------------------------------------------------------------------------------

	link_standard_imposta_p ()  // evidenzia (mette in sottolineato) i campi di link
	


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
				
//				k_rc = this.modify("#1.y = '" + string(this.pointerX()) + "' " )
				
//				if row > 1 then
					
//					this.selectrow( row - 1, false)
//				end if
//				if row < k_righe_tot then
//					if (row + 1) <> 
//					this.selectrow( row + 1, false)
//				end if
//				this.selectrow( row, false)
				
				
				k_last_row = long(this.describe("DataWindow.LastRowOnPage")) - 1
//			if k_righe_tot > (k_last_row + 1)  then
				if row > k_last_row  then
					k_riga_scroll = k_last_row + 2
					this.scrolltorow(k_riga_scroll) 
				else
					k_first_row = long(this.describe("DataWindow.FirstRowOnPage")) + 1
					if k_first_row > 2 and row < k_first_row then
						k_riga_scroll = k_first_row - 2
						this.scrolltorow(k_riga_scroll) 
					end if
				end if	
				
				this.setredraw( true)
				
				yield()

			loop 


	ki_u_drag_scroll_lanciata=false

end subroutine

public function boolean u_sort (readonly string a_nome_campo);//---
//--- Ordina le righe x la colonna pigiata (click su campo di testata)
//---
boolean k_return = true
string k_tipo_sort="", k_nome_campo=""
string k_colore_orig=""


	this.enabled = false
	
	k_nome_campo = trim(a_nome_campo)	
//	k_x = integer(this.describe(trim(k_nome_campo)+".x"))  + integer(this.describe(trim(a_nome_campo)+".width"))
//	k_x_1 = PixelsToUnits(xpos, XPixelsToUnits!)
	k_colore_orig = this.Describe(k_nome_campo + ".color")
	this.Modify(k_nome_campo + ".color = '" + string(kk_colore_rosso) + "' " ) 

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
	
	
return k_return

end function

protected function boolean link_standard_call (string k_tipo) throws uo_exception;//
//--- Chiama le window con funzione standard di consultazione
//--- Input:   k_tipo    = tipo di funzione standard da chiamare
//---             this   = data_window dalla quale prelevare i dati 
//--- Output: boolean TRUE = ok e' entrato in funzione; FALSE=non ha fatto niente
//
boolean k_return=true, k_button=false
string k_tipo_button
kuf_link_zoom kuf1_link_zoom


try 

//--- se button attivi... 
	if ki_button_standard_attivi then
		
		k_tipo_button = button_standard_call_p (k_tipo)
		
		if len(trim(k_tipo_button)) > 0 then  
			
			k_button = link_standard_call_p (k_tipo_button)
			
		end if
	end if

//--- se nessun button attivato e Link attivi... 
	if not k_button and ki_link_standard_attivi then
//	if ki_link_standard_possibile then
//--- Se DW diverso da Inserimento/Modifica oppure ho indicato SEMPRE POSSIBILE
		if (ki_flag_modalita <> kkg_flag_modalita_modifica and ki_flag_modalita <> kkg_flag_richiesta_inserimento) &
			or ki_link_standard_sempre_possibile then
			
			kuf1_link_zoom = create kuf_link_zoom
			k_return = kuf1_link_zoom.link_standard_call_p (kidw_this, k_tipo) // attiva i tasti con il LINK
			
		end if
	else
		k_return = false
	end if

catch (uo_exception kup_exception)
	throw kup_exception
	
end try
	
return k_return


end function

on uo_d_std_1.create
end on

on uo_d_std_1.destroy
end on

event clicked;//
string k_name, k_tipo_sort, k_bands
long k_colore 
//datawindow kdw_this
int k_x,k_x_1
pointer kpointer



this.accepttext()

k_bands=this.Describe("DataWindow.Bands") 
//--- verifica se sono sul Banda di dettaglio e se sono in TREEVIEW
if pos(k_bands, "detail") > 1 then
	if (this.Object.DataWindow.Processing = "8" or this.Object.DataWindow.Processing = "9") and row = 0 then
		row=u_get_riga_atpointer(dwo.Name)
	end if
end if

if row > 0 then

	kpointer = setpointer(HourGlass!)

	if ki_attiva_standard_select_row and not ki_d_std_1_primo_giro then
		
		event ue_selectrow (row)

	end if

	if ki_link_standard_attivi or ki_button_standard_attivi then
//03.04.2008	if ki_link_standard_possibile then
		try
			link_standard_call(dwo.name) 
		catch (uo_exception kuo_exception)
			setpointer (kpointer)	
			kuo_exception.messaggio_utente()
		end try
	end if

	setpointer (kpointer)	
	
else
	if (this.Object.DataWindow.Processing = "8" or this.Object.DataWindow.Processing = "9") then
		event ue_selectrow (0)
	end if
	
	if kpointer <> HourGlass! then
		kpointer = setpointer(HourGlass!)
	end if

	if kpointer <> SizeNS! and kpointer <> SizeNESW! and kpointer <> SizeWE! and kpointer <> SizeNWSE! then 
		
		
//--- Ordina righe se il campo di testata colonna finisce x '_t' ed è formato testo
		if ki_d_std_1_attiva_sort then
			k_name = trim(dwo.Name)
			IF dwo.Type = "text" and MidA(k_name, LenA(trim(k_name)), 1) = "t" THEN
				
				u_sort(k_name)   // Esegue il SORT
	
			end if
		end if
	end if

	setpointer (kpointer)	
end if

end event

event doubleclicked;//
string k_name, k_tipo_sort
long k_colore 
int k_x,k_x_1



this.accepttext()


if row = 0 and this.Object.DataWindow.Processing = "8" or this.Object.DataWindow.Processing = "9"  then
	row=u_get_riga_atpointer(dwo.Name)
end if

if row > 0 then

	this.setrow(row)
//	if this.getrow() > 0 then
		triggerevent ("u_doppio_click")
//	end if


else
	return 1
end if


end event

event getfocus;//
this.icon = ki_icona_selezionata


if ki_attiva_standard_select_row  and not ki_d_std_1_primo_giro then
	if This.getSelectedRow(0) <= 0 then
		event ue_selectrow (0)
	end if
end if

end event

event rbuttondown;//
	datawindow kdw
	kdw = this


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

kuf1_data_base.errori_gestione(kist_errori_gestione)

//=== tentativo di set transobject per il datawindows 
//this.settransobject ( sqlca )


RETURN 1 // Do not display system error message

end event

event itemerror;//
//=== Evita la messaggistica di sistema
return 1

end event

event itemchanged;//
int k_return=0
string k_codice
string k_style, k_ddw_campo, k_type, k_valore
int k_find_riga=0, K_RC 
datawindowchild  kdwc_1




//--- Controllo se valori immessi nella ddw
//--- Sono su un campo DDW?
	k_style=this.Describe("#" + trim(dwo.id)+".Edit.Style")
	if upper(k_style) = "DDDW" and not isnull(data) and LenA(trim(data)) > 0 then
		
		k_return = 1
		
//--- Attivo dw 
		this.getchild(dwo.name, kdwc_1)
	
		kdwc_1.settransobject(sqlca)
	
		if kdwc_1.rowcount() > 0 then

			k_type = dwo.coltype
			
//--- acchiappo campo di display della ddw		
			k_ddw_campo = this.Describe(dwo.name +".DDDW.DisplayColumn")
			if LenA(trim(k_ddw_campo)) > 0 then
//--- cerco se c'e' un valore simile a quello digitato
				if LeftA(upper(k_type),2) <> "CH" then
					if isnull(data) then 
						k_valore = "0"
					else
						k_valore = trim(data)
					end if
					k_find_riga=kdwc_1.Find ( k_ddw_campo + "="+k_valore, 1, kdwc_1.rowcount() )
//--- se non ho trovato un valore allora cerco per approssimazione
					if k_find_riga <= 0 then
						k_find_riga=kdwc_1.Find ( k_ddw_campo + ">="+k_valore, 1, kdwc_1.rowcount() )
					end if
				else
					if isnull(data) then 
						k_valore = " "
					else
						k_valore = trim(data)
					end if
					k_find_riga=kdwc_1.Find ( k_ddw_campo + "=~""+k_valore+"~"", 1, kdwc_1.rowcount() )
//--- se non ho trovato un valore allora cerco per approssimazione
					if k_find_riga <= 0 then
						k_find_riga=kdwc_1.Find ( k_ddw_campo + ">=~""+k_valore+"~"", 1, kdwc_1.rowcount() )
					end if
				end if
//--- se ho trovato un valore allora ok
				if k_find_riga > 0 then
					k_return = 2
					if LeftA(upper(k_type),2) <> "CH" then
						k_rc=this.settext(trim(string(kdwc_1.getitemnumber(k_find_riga, k_ddw_campo))))
						k_rc=this.setitem(row, integer(dwo.id), kdwc_1.getitemnumber(k_find_riga, k_ddw_campo))
					else
						k_valore = trim(kdwc_1.getitemstring(k_find_riga, k_ddw_campo))
						k_rc=this.setitem(row, integer(dwo.id), k_valore)
						k_rc=this.settext(k_valore)
					end if
				end if
			end if
		
		end if

	end if



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
this.icon = ki_icona_normale
if this.dataobject <> "d_nulla" then
//	this.POST SetTrans(sqlca)
	this.POST SetTransObject(sqlca)
end if
kidw_this = this

//
kist_errori_gestione.nome_oggetto = parent.classname()
kist_errori_gestione.sqlsyntax = ""
kist_errori_gestione.sqlerrtext = ""
kist_errori_gestione.sqldbcode = 0
setnull(kist_errori_gestione.sqlca) 

end event

event dragdrop;//
uo_d_std_1 kdw_source
string k_nome
long k_row, k_ret
DragObject		do_control



//st_barcode.visible = false
this.SetRedraw(FALSE)

ki_drag_scroll=false	
this.modify("k_dragdrop_row.Expression='0' ")

//Get the dragged object
do_control = DraggedObject()

IF IsValid(do_control) then //AND this.ki_attiva_DRAGDROP THEN

//	k_ret = this.EVENT ue_BeforeDrop(l_row, dw_source)
	
	IF k_ret <> -1 THEN

//	if not this.IsSelected( row ) then 
		
		CHOOSE CASE TypeOf(source)
		
			CASE datawindow!
		
				kdw_source = source
				kdw_source.Drag(cancel!)

//--- Se la ROW è a zero allora forzo alla fine se cmq ero dentro alla banda DETAIL altrimenti metto come prima riga
				if row > 0 then
					k_row = row
				else
					if Mid(this.GetBandAtPointer(),1,Pos(this.GetBandAtPointer(),'~t') - 1) = "detail" then
						k_row = this.rowcount( )  + 1
					else
						k_row = 1
					end if
					this.scrolltorow( k_row)
				end if
		 
				IF kdw_source <> this THEN
					
//--- Drop qlc il quale non e' dal ns Datawindow
					IF Lower(kdw_source.dataobject) = Lower(this.dataobject) THEN
						
//--- DataObjects  sono uguali (drop x DW UGUALI)
						k_ret = this.EVENT ue_DropFromSame(k_row, kdw_source)
						
					ELSE
						
//--- Noi Copiamo da un altro DW.. l'utente deve fare Copy stuff (drop ESTERNO)
						k_ret = this.event ue_drop_out(k_row, kdw_source)
						if k_ret = 1 then
							kdw_source.event ue_drag_out(k_row, this)	
						end if
						
					END IF
				ELSE
					
//--- Noi Drop dal  Datawindow (i drop INTERNO )
					k_ret = this.EVENT ue_DropFromThis(k_row, kdw_source)	
					
				END IF
				

//				choose case kdw_1.classname()
//						
//					case "dw_lista_sel" 
//						this.postevent( "ue_aggiungi_riga")
//		
//				end choose
//				
				
		END CHOOSE

	ELSE
//--- Mark Row come Errore x AfterDrop
		k_row = 0
	END IF
		
//--- AfterDrop e' sempre Fired
//	this.EVENT ue_AfterDrop(k_row)
	
	
end if


this.SetRedraw(true)



end event

event dragleave;//
	if this.ki_attiva_DRAGDROP then 

		this.event ue_dragleave_post()

	end if
		

end event

event dragwithin;boolean k_piu_righe = false
string k_alla_riga = ""
long k_last_row = 0, k_first_row=0


if this.ki_attiva_DRAGDROP then

	ki_drag_scroll=false	
	
	
	if row = 0 then
	
	
	else
//--- se sono ll'interno dello stesso oggetto da DRAGGARE		
		if TypeOf(source) = datawindow! then
			
			if not isnull(ki_dragdrop_oggetto) and ki_dragdrop_oggetto = source then
	
				if ki_UltRigaSel <= 0 then
					if this.getselectedrow(0) = 0 then
						this.selectrow(row, true)	
					end if
					ki_UltRigaSel = this.getselectedrow(0)
					ki_dragdrop_display = "Riga: " + string(row) //string(this.getitemnumber(ki_UltRigaSel, "ordine")) +"-"+ trim(this.getitemstring(ki_UltRigaSel, "barcode")) 
				end if

	//---- se sono piu' di 1 riga da drag allora multi-drag	
				if ki_UltRigaSel > 0 then
					if this.getselectedrow(ki_UltRigaSel) > 0 then
						 k_piu_righe = true
						this.dragicon = "drag2.ico" 
					else
//						this.dragicon = kGuo_path.get_risorse() + "\drag1.ico"
						this.dragicon = "drag1.ico"
					end if
				end if
	
			if ki_UltRigaSel <> row then
				
					if ki_riga_dragwithin > 0 then
					end if
					ki_riga_dragwithin = row
					if this.IsSelected( row ) then
						k_alla_riga = " ??? "
					else
						k_alla_riga =   "   > "+ string(row)
					end if

				
					if k_piu_righe then
			//			st_barcode.text = " " + ki_dragdrop_display + "....." + k_alla_riga
					else
			//			st_barcode.text = " " +  ki_dragdrop_display + k_alla_riga  
					end if
			//		st_barcode.visible = true
				
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
//--- Distrugge solo quando sono sicuro di essere uscito dal ciclo Drag&Drop
//do while ki_drag_scroll 
//loop


end event

