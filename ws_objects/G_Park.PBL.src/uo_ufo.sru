$PBExportHeader$uo_ufo.sru
forward
global type uo_ufo from datawindow
end type
end forward

global type uo_ufo from datawindow
integer width = 686
integer height = 400
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
event ue_selectrow ( long k_riga )
event ue_dwnkey pbm_dwnkey
end type
global uo_ufo uo_ufo

type variables
//
//--- Riferimento a questo oggetto
private uo_d_std_1 kidw_this

//--- Icone per la dw selezionata nelle window
public string ki_icona_normale =   "Application5!"
public string ki_icona_selezionata = "UserObject5!"

//--- disattiva moment.la funz.'aggiorna' fino a che non mod.un dato
public boolean ki_disattiva_moment_cb_aggiorna = true

//--- attiva/disattiva i LINK
public boolean ki_link_standard_possibile = true
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
//private time ki_keyleftbutton_ini  //--- Serve per capire sto tenendo premuto il TASTO sx del MOUSE (senza CTRL) per alcuni istanti così da fare ad es. il DRAG&DROP
private datawindow ki_dragdrop_oggetto

end variables

forward prototypes
public function boolean dati_modificati ()
public function boolean link_standard_call (string k_tipo) throws uo_exception
public subroutine link_standard_imposta ()
private subroutine personalizza_dw ()
public function boolean u_filtra_record (string k_filtro)
public function long u_get_riga_atpointer (string k_nome_campo)
private function string button_standard_call_p (string k_tipo) throws uo_exception
private function boolean link_standard_call_p (string k_tipo) throws uo_exception
private subroutine link_standard_imposta_p ()
end prototypes

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
				
	//				if this.getselectedrow ( k_riga_ctr - 1 ) = k_riga_ctr then
	//					this.selectrow ( k_riga_ctr, false )
	//				else
						this.selectrow ( k_riga_ctr, true )
	//				end if
				
				next
			
			else
			
				for k_riga_ctr = k_riga_ini to k_riga_fin 
				
	//				if this.getselectedrow ( k_riga_ctr - 1 ) = k_riga_ctr then
	//					this.selectrow ( k_riga_ctr, false )
	//				else
						this.selectrow ( k_riga_ctr, true )
	//				end if
				
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
	
//	ki_UltRigaSel = this.getselectedrow ( 0 )
end if


this.setrow( k_riga )


end event

event ue_dwnkey;//
long k_riga


//--- se tasto ESC provo l'undo
	if key = KeyESCape! then

//--- chiude eventuali DRAG & GDROP
		THIS.Drag(cancel!)
		ki_in_DRAG = false		 
		setnull(ki_dragdrop_oggetto)

//--- se tasto ESC provo l'undo
//--- Undelete
		IF this.CanUndo() THEN
			this.Undo()
		end if
	
	else

		IF keyflags = 1 THEN //con SHIFT

			k_riga = this.GetRow()
		
			IF k_riga > 0 THEN
		
				this.SetRedraw(FALSE)
			
				IF key = KeyUpArrow! THEN
//					IF ki_UltRigaSel < k_riga THEN
//						SelectRow(k_riga, FALSE)
//					ELSE
//						
//					END IF
					if k_riga > 1 then
						if IsSelected ( k_riga - 1) then
							SelectRow(k_riga      , FALSE)
//							SelectRow(k_riga - 1, FALSE)

						else
							SelectRow(k_riga - 1, TRUE)
							ki_UltRigaSel = k_riga - 1
						end if
						this.setrow( k_riga - 1)
						
					end if
				END IF
				
				IF key = KeyDownArrow! THEN
//					IF ki_UltRigaSel > k_riga THEN
//						SelectRow(k_riga, FALSE)
//					ELSE
//						
//					END IF
					if k_riga < this.rowcount() then
						if IsSelected ( k_riga + 1 ) then
							SelectRow(k_riga      , FALSE)
//							SelectRow(k_riga + 1 , FALSE)
						else
							SelectRow(k_riga + 1 , TRUE)
							ki_UltRigaSel = k_riga + 1 
						end if
						this.setrow( k_riga + 1)
					end if
				END IF
				
				this.SetRedraw(true)
		
				
			END IF
				
				//return 1
				
		ELSEIF keyflags = 2 THEN // con CTRL
				
			k_riga = this.GetRow()
			IF key = KeyDownArrow! THEN
				this.setrow( k_riga + 1)
//				return 1
			END IF
			
			IF key = KeyUpArrow! THEN
				this.setrow( k_riga - 1)
//				return 1
			END IF
				
		ELSEIF keyflags = 0 THEN  // solo il tasto premuto
				
			k_riga = this.GetRow()
		
			IF k_riga > 0 THEN

				this.SetRedraw(false)
				
				IF key = KeyUpArrow! THEN
					this.selectrow( 0, false)
					SelectRow(k_riga, FALSE)
					IF k_riga - 1 >= 1 THEN
						ki_UltRigaSel = k_riga - 1
						SelectRow(k_riga - 1, TRUE)	
						//this.SetRow(l_row - 1)
						ScrollToRow(k_riga - 1)
					END IF
					this.setrow( k_riga - 1)
				END IF
				
				IF key = KeyDownArrow! THEN
					this.selectrow( 0, false)
					this.SelectRow(k_riga, FALSE)
					IF k_riga + 1 <= this.RowCount() THEN
						ki_UltRigaSel = k_riga + 1
						SelectRow(k_riga + 1, TRUE)	
						//this.SetRow(l_row + 1)
						this.ScrollToRow(k_riga + 1)
					END IF
					this.setrow( k_riga + 1)
				END IF
				
				this.SetRedraw(TRUE)
			
			END IF
		END IF
		
	end if

	if ki_UltRigaSel = 0 then
		ki_UltRigaSel = this.getselectedrow ( 0 )
	end if

return 0


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

public function boolean link_standard_call (string k_tipo) throws uo_exception;//
//--- Chiama le window con funzione standard di consultazione
//--- Input:   k_tipo    = tipo di funzione standard da chiamare
//---             this   = data_window dalla quale prelevare i dati 
//--- Output: boolean TRUE = ok e' entrato in funzione; FALSE=non ha fatto niente
//
boolean k_return=true, k_button=false
string k_tipo_button


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
		
		k_return = link_standard_call_p (k_tipo)

	else
		k_return = false
	end if

catch (uo_exception kup_exception)
	throw kup_exception
	
end try
	
return k_return


end function

public subroutine link_standard_imposta ();//
//--- link_standard_imposta
//--- Imposta nel DW i "Link Standard" ovvero il campo blu sottolinato con "manina" come cursore
//
//---

if ki_link_standard_possibile then
	link_standard_imposta_p ()
end if

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
							+"~tif( date(x_datins) =  date('" + string(KG_DATAOGGI) +"'),"+ KK_COLORE_REC_UPDX + "," +k_colore_orig + ") ~"" //~""
				else
					k_str = "#" + trim(string(k_ctr,"###"))+".background.color=~" 0"  &
							+"~tif( date(x_datins) = date('" + string(KG_DATAOGGI) +"'),"+ KK_COLORE_REC_UPDX + "," +k_colore + ") ~"" //~""
				end if
				k_ret = this.Modify(k_str)
				k_ctr = k_ctr + 1 //+ k_colore &
			
			loop while k_ctr <= k_num_colonne_nr 
		end if
	end if	
	
end subroutine

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

private function string button_standard_call_p (string k_tipo) throws uo_exception;//
//--- Verifica quale BUTTON ho premuto e valorizza la rispettiva funzione standard di consultazione
//--- Input:   k_tipo    = button pigiato
//---             
//--- Output: TIPO = il tipo di funzione da chiamare (vedi nella "link_standard_call_p")
//---             spazio = nesuna funzione da chiamare
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
		k_return = "b_arcode_lotto"

	case "b_armo"
		k_return = "id_armo"

	case "b_arsp" 
		k_return = "b_arsp_lotto"
		
	case "b_arfa" 
		k_tipo = "b_arfa_lotto"
		
	case "b_fatt"
		k_return = "num_fatt"
		
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
		
	case "b_ric_lotto" 
		k_return = "b_ric_lotto"

		
	case else
		k_return = ""
		
end choose

	
return k_return


end function

private function boolean link_standard_call_p (string k_tipo) throws uo_exception;//
//--- Chiama le window con funzione standard di consultazione
//--- Input:   k_tipo    = tipo di funzione standard da chiamare
//---             this   = data_window dalla quale prelevare i dati 
//--- Output: boolean TRUE = ok e' entrato in funzione; FALSE=non ha fatto niente
//
boolean k_return=true
int k_rc
string k_coltype
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
uo_exception kuo_exception
kuf_armo kuf1_armo
kuf_barcode kuf1_barcode
kuf_sped kuf1_arsp
kuf_fatt kuf1_fatt
kuf_certif kuf1_certif
kuf_clienti kuf1_clienti
kuf_sl_pt kuf1_sl_pt
kuf_contratti kuf1_contratti 
kuf_prodotti kuf1_prodotti 
kuf_listino kuf1_listino
kuf_sicurezza kuf1_sicurezza
kuf_ricevute kuf1_ricevute
kuf_prof kuf1_prof
pointer kp_oldpointer



kp_oldpointer = SetPointer(hourglass!)

st_open_w kst_open_w 
datastore kdsi_elenco_output   //ds da passare alla windows di elenco
kuf_menu_window kuf1_menu_window


kdsi_elenco_output = create datastore

choose case k_tipo
		
	case "num_int", "num_int_t", "id_meca", "b_meca"
		if  trim(this.describe("id_meca.x")) <> "!" then
			kuf1_armo = create kuf_armo
			kst_tab_meca.id = this.getitemnumber(this.getrow(), "id_meca")
			if kst_tab_meca.id > 0 then
				kdsi_elenco_output.dataobject = this.dataobject
				kdsi_elenco_output.insertrow(0)
				kdsi_elenco_output.object.id_meca[1] = this.object.id_meca[1]
				kst_esito = kuf1_armo.anteprima_a_righe ( kdsi_elenco_output, kst_tab_meca )
				destroy kuf1_armo
				if kst_esito.esito <> kkg_esito_ok then
					kuo_exception = create uo_exception
					kuo_exception.set_esito( kst_esito)
					throw kuo_exception
				end if
				kst_open_w.key1 = "Dettaglio del Lotto (id=" + trim(string(kst_tab_meca.id))  + ") "
			else
				k_return = false
			end if
		else
			k_return = false
		end if
		
	case "barcode", "barcode_t"
		kst_tab_barcode.barcode = this.getitemstring(this.getrow(), "barcode")
		if len(kst_tab_barcode.barcode) > 0 then
	
			kuf1_barcode = create kuf_barcode
			kst_esito = kuf1_barcode.anteprima ( kdsi_elenco_output, kst_tab_barcode )
			destroy kuf1_barcode
			if kst_esito.esito <> kkg_esito_ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito)
				throw kuo_exception
			end if
			kst_open_w.key1 = "Dettaglio Barcode : " + trim(string(kst_tab_barcode.barcode,"@@@ @@@@@@@@@")) 
		else
			k_return = false
		end if
		
	case "barcode_figli", "barcode_figli_t"
		kst_tab_barcode.barcode = this.getitemstring(this.getrow(), "barcode")
		if len(kst_tab_barcode.barcode) > 0 then
	
			kuf1_barcode = create kuf_barcode
			kst_esito = kuf1_barcode.anteprima_elenco_figli ( kdsi_elenco_output, kst_tab_barcode )
			destroy kuf1_barcode
			if kst_esito.esito <> kkg_esito_ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito)
				throw kuo_exception
			end if
			kst_open_w.key1 = "Elenco 'Figli' del Barcode : " + trim(string(kst_tab_barcode.barcode,"@@@ @@@@@@@@@")) 
		else
			k_return = false
		end if
		
	case "b_barcode_lotto" 
		kst_tab_barcode.id_meca = this.getitemnumber(this.getrow(), "id_meca")
		if kst_tab_barcode.id_meca > 0 then
	
			kuf1_barcode = create kuf_barcode
			kst_esito = kuf1_barcode.anteprima_elenco ( kdsi_elenco_output, kst_tab_barcode )
			destroy kuf1_barcode
			if kst_esito.esito <> kkg_esito_ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito)
				throw kuo_exception
			end if
			kst_open_w.key1 = "Elenco Barcode Lotto  (id=" + trim(string(kst_tab_barcode.id_meca)) + ") " 
		else
			k_return = false
		end if

	case "b_armo", "id_armo" 
		kst_tab_armo.id_armo = this.getitemnumber(this.getrow(), "id_armo")
		if kst_tab_armo.id_armo > 0 then

			kuf1_armo = create kuf_armo
			kst_esito = kuf1_armo.anteprima_riga ( kdsi_elenco_output, kst_tab_armo )
			destroy kuf1_armo
			if kst_esito.esito <> kkg_esito_ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito)
				throw kuo_exception
			end if
			kst_open_w.key1 = "Dettaglio Riga Lotto  (id=" + trim(string(kst_tab_armo.id_armo)) + ") " 
		else
			k_return = false
		end if

//	case "b_armo" 
//		kst_tab_armo.id_meca = this.getitemnumber(this.getrow(), "id_meca")
//		if kst_tab_armo.id_meca > 0 then
//
//			kuf1_armo = create kuf_armo
//			kst_esito = kuf1_armo.anteprima_elenco ( kdsi_elenco_output, kst_tab_armo )
//			destroy kuf1_armo
//			if kst_esito.esito <> kkg_esito_ok then
//				kuo_exception = create uo_exception
//				kuo_exception.set_esito( kst_esito)
//				throw kuo_exception
//			end if
//			kst_open_w.key1 = "Elenco Righe Lotto  (id=" + trim(string(kst_tab_armo.id_meca)) + ") " 
//		else
//			k_return = false
//		end if

	case "b_arsp_lotto" 
		kst_tab_armo.id_meca = this.getitemnumber(this.getrow(), "id_meca")
		if kst_tab_armo.id_meca > 0 then
	
			kuf1_arsp = create kuf_sped
			kst_esito = kuf1_arsp.anteprima_elenco ( kdsi_elenco_output, kst_tab_armo )
			destroy kuf1_arsp
			if kst_esito.esito <> kkg_esito_ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito)
				throw kuo_exception
			end if
			kst_open_w.key1 = "Elenco Righe Bolla di Spedizione  (id lotto=" + trim(string(kst_tab_armo.id_meca)) + ") " 
		else
			k_return = false
		end if
		
	case "b_arfa_lotto" 
		kst_tab_armo.id_meca = this.getitemnumber(this.getrow(), "id_meca")
		if kst_tab_armo.id_meca > 0 then
	
			kuf1_fatt = create kuf_fatt
			kst_esito = kuf1_fatt.anteprima_elenco ( kdsi_elenco_output, kst_tab_armo )
			destroy kuf1_fatt
			if kst_esito.esito <> kkg_esito_ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito)
				throw kuo_exception
			end if
			kst_open_w.key1 = "Elenco Righe Bolla di Spedizione  (id lotto=" + trim(string(kst_tab_armo.id_meca)) + ") " 
		else
			k_return = false
		end if
		
	case "num_fatt", "data_fatt" 
		kst_tab_arfa.num_fatt = this.getitemnumber(this.getrow(), "num_fatt")
		if kst_tab_arfa.num_fatt > 0 then
			kst_tab_arfa.data_fatt = this.getitemdate(this.getrow(), "data_fatt")

			kuf1_fatt = create kuf_fatt
			kst_esito = kuf1_fatt.anteprima ( kdsi_elenco_output, kst_tab_arfa )
			destroy kuf1_fatt
			if kst_esito.esito <> kkg_esito_ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito)
				throw kuo_exception
			end if
			kst_open_w.key1 = "Documento di Vendita n. " + trim(string(kst_tab_arfa.num_fatt)) + " del " + trim(string(kst_tab_arfa.data_fatt))
		else
			k_return = false
		end if
		
	case "b_certif_lotto" 
		kst_tab_certif.id_meca = this.getitemnumber(this.getrow(), "id_meca")
		if kst_tab_certif.id_meca > 0 then

			kuf1_certif = create kuf_certif
	//		kst_esito = kuf1_certif.anteprima_elenco ( kdsi_elenco_output, kst_tab_armo )
			kuf1_certif.get_num_certif (kst_tab_certif)
			kst_esito = kuf1_certif.anteprima ( kdsi_elenco_output, kst_tab_certif )
			destroy kuf1_certif
			if kst_esito.esito <> kkg_esito_ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito)
				throw kuo_exception
			end if
			kst_open_w.key1 = "Elenco Righe Attestato di Trattamento  (id lotto=" + trim(string(kst_tab_armo.id_meca)) + ") " 
		else
			k_return = false
		end if
		
	case "clie_1", "clie_2", "clie_3", "clie", "cod_cli", "id_cliente" 
		kst_tab_clienti.codice = this.getitemnumber(this.getrow(), k_tipo)
		if kst_tab_clienti.codice > 0 then
			kuf1_clienti = create kuf_clienti
			kst_esito = kuf1_clienti.anteprima_elenco( kdsi_elenco_output, kst_tab_clienti )
			destroy kuf1_clienti
			if kst_esito.esito <> kkg_esito_ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito)
				throw kuo_exception
			end if
			kst_open_w.key1 = "Anagrafica  (codice=" + trim(string(kst_tab_clienti.codice)) + ") " 
		else
			k_return = false
		end if
	
	case "cod_sl_pt", "sl_pt"
		kst_tab_sl_pt.cod_sl_pt = this.getitemstring(this.getrow(), k_tipo)
		if len(kst_tab_sl_pt.cod_sl_pt) > 0 then

			kuf1_sl_pt = create kuf_sl_pt
			kst_esito = kuf1_sl_pt.anteprima ( kdsi_elenco_output, kst_tab_sl_pt )
			destroy kuf1_sl_pt
			if kst_esito.esito <> kkg_esito_ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito)
				throw kuo_exception
			end if
			kst_open_w.key1 = "Piano di Trattamento previsto : " + trim(kst_tab_sl_pt.cod_sl_pt) 
		else
			k_return = false
		end if

	case "contratto", "mc_co", "contratti_codice"
		kst_tab_contratti.codice = 0
		if k_tipo = "contratto" then
			kst_tab_contratti.codice = this.getitemnumber(this.getrow(), k_tipo)
		else
			if trim(this.Describe("contratti_codice.x")) <> "!" then 
				kst_tab_contratti.codice = this.getitemnumber(this.getrow(), "contratti_codice")
			end if
		end if			

		if kst_tab_contratti.codice > 0 then 
			kuf1_contratti = create kuf_contratti 
			kst_esito = kuf1_contratti.anteprima ( kdsi_elenco_output, kst_tab_contratti )
			destroy kuf1_contratti 
			if kst_esito.esito <> kkg_esito_ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito)
				throw kuo_exception
			end if
			kst_open_w.key1 = "Contratto: " + trim(string(kst_tab_contratti.codice) )
		else
			k_return = false
		end if

	case "sc_cf", "cf"
		kst_tab_contratti.sc_cf = this.getitemstring(this.getrow(), k_tipo)
		if len(kst_tab_contratti.sc_cf) > 0 then
	
			kuf1_contratti = create kuf_contratti 
			kst_esito = kuf1_contratti.anteprima_sc_cf ( kdsi_elenco_output, kst_tab_contratti )
			destroy kuf1_contratti 
			if kst_esito.esito <> kkg_esito_ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito)
				throw kuo_exception
			end if
			kst_open_w.key1 = "codice Capitolato: " + trim(kst_tab_contratti.sc_cf)
		else
			k_return = false
		end if

	case "art", "cod_art"
		kst_tab_prodotti.codice = this.getitemstring(this.getrow(), k_tipo)
		if len(kst_tab_prodotti.codice) > 0 then
	
			kuf1_prodotti = create kuf_prodotti 
			kst_esito = kuf1_prodotti.anteprima ( kdsi_elenco_output, kst_tab_prodotti )
			destroy kuf1_prodotti 
			if kst_esito.esito <> kkg_esito_ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito)
				throw kuo_exception
			end if
			kst_open_w.key1 = "codice Articolo: " + trim(kst_tab_prodotti.codice)
		else
			k_return = false
		end if

	case "id_listino"
		kst_tab_listino.id = this.getitemnumber(this.getrow(), k_tipo)
		if kst_tab_listino.id > 0 then
	
			kuf1_listino = create kuf_listino 
			kst_esito = kuf1_listino.anteprima ( kdsi_elenco_output, kst_tab_listino )
			destroy kuf1_listino
			if kst_esito.esito <> kkg_esito_ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito)
				throw kuo_exception
			end if
			kst_open_w.key1 = "id Listino: " + string(kst_tab_listino.id)
		else
			k_return = false
		end if

	case "x_utente" &
		, "x_utente_cert_alim" &
		, "x_utente_cert_farm" &
		, "x_utente_cert_f_st"

		k_coltype = this.Describe(k_tipo+".Coltype")
		choose case upper(left(k_coltype,2))
			case 'CH'
				if isnumber(trim(this.getitemstring(this.getrow(), k_tipo))) then
					kst_tab_sr_utenti.id = integer(this.getitemstring(this.getrow(), k_tipo))
				else
					kst_tab_sr_utenti.id = 0
				end if
			case else
				kst_tab_sr_utenti.id = this.getitemnumber(this.getrow(), k_tipo)
		end choose
			
		if kst_tab_sr_utenti.id > 0 then
	
			kuf1_sicurezza = create kuf_sicurezza 
			kst_esito = kuf1_sicurezza.anteprima ( kdsi_elenco_output, kst_tab_sr_utenti )
			destroy kuf1_sicurezza
			if kst_esito.esito <> kkg_esito_ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito)
				throw kuo_exception
			end if
			kst_open_w.key1 = "codice Utente: " + string(kst_tab_sr_utenti.id)
		else
			k_return = true //evita il messaggio di errore
		end if
		

	case "id_ric"
		kst_tab_ricevute.id = this.getitemnumber(this.getrow(), k_tipo)
		if kst_tab_ricevute.id > 0 then
	
			kuf1_ricevute = create kuf_ricevute 
			kst_esito = kuf1_ricevute.anteprima ( kdsi_elenco_output, kst_tab_ricevute )
			destroy kuf1_ricevute
			if kst_esito.esito <> kkg_esito_ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito)
				throw kuo_exception
			end if
			kst_open_w.key1 = "id Ricevuta: " + string(kst_tab_listino.id)
		else
			k_return = false
		end if

	case "b_ric_lotto" 
		kst_tab_ricevute.num_fatt = this.getitemnumber(this.getrow(), "num_fatt")
		if kst_tab_ricevute.num_fatt > 0 then
			kst_tab_ricevute.data_fatt = this.getitemdate(this.getrow(), "data_fatt")

			kuf1_ricevute = create kuf_ricevute
			kst_esito = kuf1_ricevute.anteprima_elenco( kdsi_elenco_output, kst_tab_ricevute )
			destroy kuf1_ricevute
			if kst_esito.esito <> kkg_esito_ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito)
				throw kuo_exception
			end if
			kst_open_w.key1 = "Scadenze Fattura n. " + trim(string(kst_tab_ricevute.num_fatt)) + " / " + string(kst_tab_ricevute.data_fatt, "yyyy")
		else
			k_return = false
		end if
		
	case "b_contab" 
		kst_tab_prof.num_fatt = this.getitemnumber(this.getrow(), "num_fatt")
		if kst_tab_prof.num_fatt > 0 then
			kst_tab_prof.data_fatt = this.getitemdate(this.getrow(), "data_fatt")

			kuf1_prof = create kuf_prof
			kst_esito = kuf1_prof.anteprima_elenco( kdsi_elenco_output, kst_tab_prof )
			destroy kuf1_prof
			if kst_esito.esito <> kkg_esito_ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito)
				throw kuo_exception
			end if
			kst_open_w.key1 = "Movimenti x la contabilità Documento n. " + trim(string(kst_tab_prof.num_fatt)) + " / " + string(kst_tab_prof.data_fatt, "yyyy")
		else
			k_return = false
		end if
		

		
	case else
		k_return = false
		
end choose

SetPointer(kp_oldpointer)

if k_return then
	
	if kdsi_elenco_output.rowcount() > 0 then
	
		
	//--- chiamare la window di elenco
	//
	//=== Parametri : 
	//=== struttura st_open_w
		kst_open_w.id_programma =kkg_id_programma_elenco
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_modalita = kkg_flag_modalita_elenco
		kst_open_w.flag_adatta_win = KK_ADATTA_WIN
		kst_open_w.flag_leggi_dw = " "
		kst_open_w.flag_cerca_in_lista = " "
		kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = kuf1_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key12_any = kdsi_elenco_output
		kst_open_w.flag_where = " "
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(kst_open_w)
		destroy kuf1_menu_window


	else
		
		messagebox("Elenco Dati", 	"Nessun valore disponibile. ")
		
		
	end if
end if
	
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
				case "clie_1", "clie_2", "clie_3", "clie", "cod_cli", "id_cliente" &
					 ,"barcode", "cod_sl_pt", "sl_pt", "contratto", "sc_cf" &
					 ,"barcode_figli" &
					 ,"art", "cod_art" &
					 ,"id_listino" &
					 ,"id_armo" &
					 ,"x_utente"  &
					, "x_utente_cert_alim" &
					, "x_utente_cert_farm" &
					, "x_utente_cert_f_st" &
					, "id_ric"
					 
//--- se e' del tipo grid o tabular link sul valore alrimenti sul testo		
					if this.Object.DataWindow.Type <> "Form" then
						
						this.Modify("#" + trim(string(k_ctr,"###"))+&
									  ".Font.Underline = 1")
						this.Modify("#" + trim(string(k_ctr,"###"))+&
									  ".Color = '" + string(kk_colore_blu)+"' ")
						this.Modify("#" + trim(string(k_ctr,"###"))+&
									  ".pointer = 'HyperLink!' " )
					else
//--- ..... alrimenti sul testo		
						this.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
									  ".Font.Underline = 1")
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

				
				case  "mc_co",  "contratti_codice"
					
					if this.Object.DataWindow.Type <> "Form" then
						if trim(this.Describe("contratti_codice.x")) <> "!" then 
							this.Modify("#" + trim(string(k_ctr,"###"))+&
										  ".Font.Underline = 1")
							this.Modify("#" + trim(string(k_ctr,"###"))+&
										  ".Color = '" + string(kk_colore_blu)+"' ")
							this.Modify("#" + trim(string(k_ctr,"###"))+&
										  ".pointer = 'HyperLink!' " )
						end if
					else
						if trim(this.Describe("contratti_codice_t.x")) <> "!" then 
							this.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
										  ".Font.Underline = 1")
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
							this.Modify("#" + trim(string(k_ctr,"###"))+&
										  ".Font.Underline = 1")
							this.Modify("#" + trim(string(k_ctr,"###"))+&
										  ".Color = '" + string(kk_colore_blu)+"' ")
							this.Modify("#" + trim(string(k_ctr,"###"))+&
										  ".pointer = 'HyperLink!' " )
						end if
					else
						if trim(this.Describe("num_int_t.x")) <> "!" then 
							this.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
										  ".Font.Underline = 1")
							this.Modify(k_nome+ "_t" + trim(string(k_ctr,"###"))+&
										  ".Color = '" + string(kk_colore_blu)+"' ")
							this.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
										  ".pointer = 'HyperLink!' " )
						end if
					end if
					
				case "num_fatt"  //, "data_fatt" 
					if this.Object.DataWindow.Type <> "Form" then
						if trim(this.Describe("num_fatt.x"))  <> "!" then 
							this.Modify("#" + trim(string(k_ctr,"###"))+&
										  ".Font.Underline = 1")
							this.Modify("#" + trim(string(k_ctr,"###"))+&
										  ".Color = '" + string(kk_colore_blu)+"' ")
							this.Modify("#" + trim(string(k_ctr,"###"))+&
										  ".pointer = 'HyperLink!' " )
						end if
					else
						if trim(this.Describe("num_fatt.x"))  <> "!" then 
							this.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
										  ".Font.Underline = 1")
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

on uo_ufo.create
end on

on uo_ufo.destroy
end on

event clicked;//
string k_name, k_tipo_sort
long k_colore 
//datawindow kdw_this
int k_x,k_x_1
pointer kpointer


//--- verifica se sono sul Banda di dettaglio e se sono in TREEVIEW
if this.Object.DataWindow.Bands = "Detail" and (this.Object.DataWindow.Processing = "8" or this.Object.DataWindow.Processing = "9") and row = 0 then

	row=u_get_riga_atpointer(dwo.Name)
	
end if

if row > 0 then

//=== Se sono sulla testata della DW (il nome finisce x 't' ed e' un text)
//=== allora ordino le righe per quella colonna
	kpointer = setpointer(HourGlass!)

	if ki_attiva_standard_select_row and not ki_d_std_1_primo_giro then
//		kdw_this = this
//		kuf1_data_base.dw_selectrow( kdw_this, row )
//qui		event ue_selectrow (row)

	end if

//	if ki_link_standard_attivi then
	if ki_link_standard_possibile then
		try
			link_standard_call(dwo.name) 
		catch (uo_exception kuo_exception)
			setpointer (kpointer)	
			kuo_exception.messaggio_utente()
		end try
	end if

	setpointer (kpointer)	
	
else

//=== Se sono sulla testata della DW (il nome finisce x 't' ed e' un text)
//=== allora ordino le righe per quella colonna
	if kpointer <> HourGlass! then
		kpointer = setpointer(HourGlass!)
	end if

	if kpointer <> SizeNS! and kpointer <> SizeNESW! and kpointer <> SizeWE! and kpointer <> SizeNWSE! then 
		
		k_name = dwo.Name
		IF dwo.Type = "text" and MidA(k_name, LenA(trim(k_name)), 1) = "t" THEN
	
	//		string k_gruppo
	//		k_gruppo = this.Describe("DataWindow.group")
			
			k_x = integer(this.describe(trim(k_name)+".x")) &
				  + integer(this.describe(trim(k_name)+".width"))
			k_x_1 = PixelsToUnits(xpos, XPixelsToUnits!)
	
	//--- per evitare il riordine quando sono vicino ai confini 
	//--- funziona solo sulla prima parte del dw
	//		if not (k_x_1 < k_x * (1 - 0.10)) and not (k_x_1 > k_x * (1 + 0.10)) then return
	
			k_colore = long(this.Describe(string(trim(k_name)) + ".color"))
			dwo.Color = RGB(255,0,0)
	
			k_name = LeftA(k_name, LenA(k_name) - 2) // tolgo la '_t' 
	
	//=== se campo char sort ascendente altrimenti discendente
			if LeftA(this.Describe(string(trim(k_name)) + ".colType"),4) = lower("char") then
	//=== se campo gia' sortato discendente lo faccio ascendente
				if trim(this.Describe(string(trim(k_name)) + ".tag")) = "D" then 
					k_tipo_sort = " A"
				else
					k_tipo_sort = " D"
				end if
			else
	//=== se campo gia' sortato ascendente lo faccio discendente
				if trim(this.Describe(string(trim(k_name)) + ".tag")) = "A" then 
					k_tipo_sort = " D"
				else
					k_tipo_sort = " A"
				end if
			end if
	
			this.SetRedraw(false)
			this.modify(string(trim(k_name)) + ".tag='" + trim(k_tipo_sort) + "'") 
			This.SetSort(k_name + k_tipo_sort)
			This.Sort()
			this.GroupCalc()
			this.SetRedraw(true)
	
	////=== Tengo in memoria per la Ricerca su quale campo ho compiuto il SORT
	//		this.tag = k_name
			
			dwo.Color = k_colore
	
		end if
	end if

	setpointer (kpointer)	
end if

end event

