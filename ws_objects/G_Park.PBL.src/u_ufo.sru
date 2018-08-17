$PBExportHeader$u_ufo.sru
forward
global type u_ufo from datastore
end type
end forward

global type u_ufo from datastore
event dragleave pbm_dragleave
event dragwithin pbm_dwndragwithin
event losefocus pbm_dwnkillfocus
event ue_aggiungi_riga ( )
event rowfocuschanging pbm_dwnrowchanging
event ue_drag_out ( )
event ue_dragleave_post ( )
event ue_dwnmousemove pbm_dwnmousemove
event ue_lbuttondown pbm_lbuttondown
event ue_lbuttonup pbm_lbuttonup
event ue_lbuttonup_post ( )
event timer ( )
end type
global u_ufo u_ufo

forward prototypes
public function boolean dati_modificati ()
end prototypes

event dragleave;////
//	if ki_attiva_DRAGDROP then 
//
//		this.triggerevent ("ue_dragleave_post")
//
//	end if
//		
//
end event

event dragwithin;//boolean k_piu_righe = false
//string k_alla_riga = ""
//long k_last_row = 0, k_first_row=0
//
//
//
//if ki_attiva_DRAGDROP then
//
//	
//	//	this.dragicon = ki_path_risorse + "\drag1.ico"
//	//	source = this
//	
//	
//	if row = 0 then
//	
//	//	st_barcode.visible = false
////		this.drag(cancel!)
//	
//	else
////--- se sono ll'interno dello stesso oggetto da DRAGGARE		
//		if TypeOf(source) = datawindow! then
//			if not isnull(ki_dragdrop_oggetto) and ki_dragdrop_oggetto = source then
//	
//				if ki_riga_selected <= 0 then
//					if this.getselectedrow(0) = 0 then
//						this.selectrow(row, true)	
//					end if
//					ki_riga_selected = this.getselectedrow(0)
////					if not keydown(KeyShift!) then
////						this.selectrow(0, false)	
////					end if
//					ki_dragdrop_display = "Riga: " + string(row) //string(this.getitemnumber(ki_riga_selected, "ordine")) +"-"+ trim(this.getitemstring(ki_riga_selected, "barcode")) 
//				end if
//	//---- se sono piu' di 1 riga da drag allora multi-drag	
//				if ki_riga_selected > 0 then
//					if this.getselectedrow(ki_riga_selected) > 0 then
//						 k_piu_righe = true
//						this.dragicon = ki_path_risorse + "\drag2.ico" 
//					else
//						this.dragicon = ki_path_risorse + "\drag1.ico"
//					end if
//				end if
//	
//				if ki_riga_selected <> row then
//				
//					if ki_riga_dragwithin > 0 then
//			//			this.setitem(ki_riga_dragwithin, "k_su_drop", "0")
//					end if
//					ki_riga_dragwithin = row
//					if this.IsSelected( row ) then
//						k_alla_riga = " ??? "
//					else
//						k_alla_riga =   "   > "+ string(row)
//					end if
//				
//			//		st_barcode.x = parent.pointerx() +50
//			//		st_barcode.y = parent.pointery() + 50
//					if k_piu_righe then
//			//			st_barcode.text = " " + ki_dragdrop_display + "....." + k_alla_riga
//					else
//			//			st_barcode.text = " " +  ki_dragdrop_display + k_alla_riga  
//					end if
//			//		st_barcode.visible = true
//				
//				end if
//			end if
//
//		end if
//		
//		k_last_row = long(this.Object.DataWindow.LastRowOnPage) - 2
//		if this.rowcount() > (k_last_row + 2)  then
//			if row > k_last_row  then
//				this.scrolltorow(k_last_row + 3) 
//			else
//				k_first_row = long(this.Object.DataWindow.FirstRowOnPage) + 2
//				if row < k_first_row  and row > 2 then
//					this.scrolltorow(k_first_row - 3) 
//				end if
//			end if
//		end if
//	
//	end if
//end if
//	
//	
//
end event

event losefocus;////
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

event ue_aggiungi_riga();////
////--- aggiunge riga 
////
//dw_lista_elenco_sel.rowscopy ( ki_riga_selected_sel, ki_riga_selected_sel,Primary!, this, 1,Primary!)
//dw_lista_elenco_sel.deleterow( ki_riga_selected_sel )
//
//
//

//
////
////--- aggiunge riga 
////
////long k_riga
//
//
//
////k_riga = this.insertrow(1)
//dw_lista_elenco.rowscopy ( ki_riga_selected, ki_riga_selected,Primary!, this, 1,Primary!)
//dw_lista_elenco.deleterow( ki_riga_selected )
//this.visible = true
//

end event

event rowfocuschanging;////
//
//if ki_in_DRAG and ki_attiva_DRAGDROP then 
//	
//	if (keydown(KeyDownArrow!) or keydown(KeyUpArrow!)) then
//		if  keydown(keyshift!) then 
//			if this.IsSelected( newrow ) then
//				if currentrow <> ki_clicked_row then
//					if currentrow <> newrow then
//						this.selectrow( currentrow, false )
//					end if
//				end if
//			else
//				this.selectrow( newrow, True )
//			end if
//		else
//			this.selectrow( 0, false )
//			this.selectrow( newrow, True )
//			ki_clicked_row = newrow
//			
//		end if
//	end if
//end if
//
end event

event ue_drag_out();////
//
//if ki_in_DRAG and cb_conferma.enabled = true then 
//	
//	ki_st_open_w.key5 = " " //--- nessun pulsante pigiato
//	cb_conferma.triggerevent(clicked!)
//	
////--- x postare nella dw dei "cliccai" tutte le righe  selezionate
//	post togli_righe_selezionate()
//	
//end if
//

end event

event ue_dragleave_post();////
//
//if ki_attiva_DRAGDROP then
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

event ue_dwnmousemove;////
////---- Muove il mouse con il tasto left premuto
////
//
//if ki_in_DRAG and ki_attiva_DRAGDROP then
//
//	if keydown(keyleftbutton!)  and not  keydown(keycontrol!) then
//	
//	//--- se tasto ESC provo l'undo
//		if keydown(KeyESCape!) then
//	
//	//--- chiude eventuali DRAG & DROP
//	//		st_barcode.visible = false
//			this.Drag(cancel!)
//			ki_in_DRAG = false		 
//			if ki_clicked_row > 0 then
//				this.scrolltorow(ki_clicked_row)
//			end if
//			ki_clicked_row= 0
//			this.selectrow( 0, false )
//			setnull(ki_dragdrop_oggetto)
//			
//		else
//			
//			if this.getselectedrow(0) > 0 then
//		
//				this.dragicon = ki_path_risorse + "\drag1.ico"
//					
//				ki_in_DRAG = true		 
//				this.drag(begin!)
//				ki_dragdrop_oggetto = this
//				
//			end if
//		end if
//	end if
//	
//end if
//
//
end event

event ue_lbuttondown;////
//long k_ctr
//long k_Height
//
//if ki_attiva_DRAGDROP then
//	if isnumber(this.Describe("#1.Height")) then
//		k_Height = long(this.Describe("#1.Height"))
//	
//		if ypos > k_Height then
//		
//			ki_riga_selected=0	
//			ki_lbuttondown_row = this.getrow()
//	
//		end if
//	end if
//end if
//
end event

event ue_lbuttonup;////
//
//	if ki_attiva_DRAGDROP then
//		this.triggerevent ("ue_lbuttonup_post")
//	end if
end event

event ue_lbuttonup_post();////
////	st_barcode.visible = false
//	ki_lbuttondown_row = 0
//	ki_in_DRAG = false		 
//	this.drag(end!)
//	setnull(ki_dragdrop_oggetto)
//
end event

event timer();//
//	if keydown(keyleftbutton!)  and not  keydown(keycontrol!) then
//		if SecondsAfter (  ki_keyleftbutton_ini,  now() ) >= 1 then   //se premuto x almeno 1 secondo allora attivo il DRAG&DROP
//			ki_in_DRAG = true
//		end if
//	end if
//

end event

public function boolean dati_modificati ();//
//--- Compiute modifice nel dw?
//--- true=si; false=no
//
	
	this.accepttext()
	
	if (this.Object.DataWindow.Table.UpdateTable <> " " and &
		 (this.getnextmodified(0, primary!) > 0  &
				or this.getnextmodified(0, delete!) > 0) &
				or this.ModifiedCount ( ) > 0) then
		return true
	else
		return false
	end if


end function

on u_ufo.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_ufo.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

