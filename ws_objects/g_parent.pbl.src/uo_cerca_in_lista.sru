$PBExportHeader$uo_cerca_in_lista.sru
forward
global type uo_cerca_in_lista from userobject
end type
type sle_cerca from singlelineedit within uo_cerca_in_lista
end type
type cb_cerca_1 from commandbutton within uo_cerca_in_lista
end type
end forward

global type uo_cerca_in_lista from userobject
integer width = 1655
integer height = 312
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
sle_cerca sle_cerca
cb_cerca_1 cb_cerca_1
end type
global uo_cerca_in_lista uo_cerca_in_lista

type variables

DataWindow  ki_dw_cerca

end variables

forward prototypes
public subroutine cerca_in_lista (integer k_campo)
end prototypes

public subroutine cerca_in_lista (integer k_campo);//=== Posiziona control edit
kuf_utility kuf1_utility

GraphicObject k_which_control

//--- cerca il dw con il fuoco
k_which_control = GetFocus()

if TypeOf(k_which_control) = DataWindow! then
	ki_dw_cerca = k_which_control
	
	if ki_dw_cerca.RowCount( ) > 1 then
		
		kuf1_utility = create kuf_utility

		cb_cerca_1.tag = trim(string(k_campo))
		
		sle_cerca.x = ki_dw_cerca.x + (ki_dw_cerca.width - sle_cerca.width) / 2
		sle_cerca.y = ki_dw_cerca.y + (ki_dw_cerca.height - sle_cerca.height) / 4

//=== Valorizzo il testo del edit con il testo della testata della colonna
		if sle_cerca.text = "" or isnull(sle_cerca.text) = true then
			sle_cerca.text=kuf1_utility.u_stringa_pulisci(ki_dw_cerca.describe(&
					ki_dw_cerca.describe("#" + trim(string(cb_cerca_1.tag)) + ".name") + &
							"_t.text"))
	
		end if
	
		sle_cerca.visible = true
		sle_cerca.setfocus()
	
		cb_cerca_1.visible = true
		cb_cerca_1.x = sle_cerca.x + sle_cerca.width + 5
		cb_cerca_1.y = sle_cerca.y 	
		cb_cerca_1.default = true
	
		cb_cerca_1.bringtotop = true
		sle_cerca.bringtotop = true
	

//=== Disattivo flag di 'prima volta'
//		if ki_st_open_w.flag_primo_giro = 'S' then
//			ki_st_open_w.flag_primo_giro = ''
//		end if
		
		destroy kuf1_utility
	end if
end if

end subroutine

on uo_cerca_in_lista.create
this.sle_cerca=create sle_cerca
this.cb_cerca_1=create cb_cerca_1
this.Control[]={this.sle_cerca,&
this.cb_cerca_1}
end on

on uo_cerca_in_lista.destroy
destroy(this.sle_cerca)
destroy(this.cb_cerca_1)
end on

type sle_cerca from singlelineedit within uo_cerca_in_lista
boolean visible = false
integer x = 306
integer y = 52
integer width = 1161
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 16776960
textcase textcase = upper!
integer limit = 40
end type

on getfocus;//
	this.selecttext( 1, LenA(this.text))
end on

type cb_cerca_1 from commandbutton within uo_cerca_in_lista
boolean visible = false
integer x = 69
integer y = 48
integer width = 210
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cerca..."
end type

event clicked;//
//=== Posiziono sulla anagrafica specificata
long k_riga, k_inizio_find
string k_campo, k_tipo_campo
string k_find, k_nome_colonna
pointer oldpointer  // Declares a pointer variable
GraphicObject k_which_control


//sle_cerca.visible = false
//cb_cerca_1.visible = false

k_campo = upper(trim(ki_dw_cerca.describe(&
	ki_dw_cerca.describe("#" + trim(string(cb_cerca_1.tag)) + ".name") + "_t.text")))


//=== Se ho scritto qualcosa e se e' diverso dal nome della testata della col.
if LenA(trim(sle_cerca.text)) > 0 and sle_cerca.text <> k_campo	then
	
//=== Se NON sono in ricerca lancio INIZIALIZZA()
	if this.text = "Cerca..." then 

//=== Puntatore Cursore da attesa.....
		oldpointer = SetPointer(HourGlass!)

		k_inizio_find = ki_dw_cerca.getrow()
		
		k_nome_colonna = ki_dw_cerca.describe("#" + trim(string(cb_cerca_1.tag)) + ".name")
//					
      k_tipo_campo = ki_dw_cerca.Describe(k_nome_colonna+".Coltype")
		choose case upper(LeftA(k_tipo_campo,2))
					
			case 'CH'
				k_find =	"upper("+k_nome_colonna + ") like '" + &
		   	    trim(sle_cerca.text) + "%'"
			case 'DA'
				if isdate(trim(sle_cerca.text)) then
					k_find =	" "+k_nome_colonna + " >= date('"  &
			   	         + string(date(trim(sle_cerca.text))) + "') "
				else
					messagebox("Ricerca fallita", trim(sle_cerca.text) + " non sembra una data valida")
				end if
			case else
				k_find =	k_nome_colonna + " >= " + &
		   	    trim(sle_cerca.text) 
				
		end choose
	
		k_inizio_find++
		k_riga = ki_dw_cerca.Find( k_find , k_inizio_find,  &
		       ki_dw_cerca.RowCount( ))
	
		if k_riga <= 0 and k_inizio_find > 1 then //allora ricerco ancora dalla prima riga
			k_riga = ki_dw_cerca.Find( k_find , 1, k_inizio_find )
		end if

		if k_riga <= 0 then
			SetPointer(oldpointer)
			messagebox("Ricerca fallita", "Dato richiesto non trovato in lista")
		else
			ki_dw_cerca.SelectRow(0, FALSE)
			ki_dw_cerca.scrolltorow(k_riga)
			ki_dw_cerca.selectrow(k_riga, true)
			ki_dw_cerca.setrow(k_riga)

		end if

		SetPointer(oldpointer)

	end if
else
	
	sle_cerca.text = ""
	
end if

sle_cerca.visible = false
cb_cerca_1.visible = false

////=== Se NON sono in ricerca lancio INIZIALIZZA()
//if this.text <> "Cerca..." then 
//	inizializza_lista()
//end if

this.text = "Cerca..."

//					
//					choose case upper(left(ki_dw_cerca.Describe(k_campo+".Coltype"),2))
//					
//						case 'CH'
//							if pos(k_filtro, "%", 1) > 0 then
//								if len(k_filtro_like) = 0 then
//									k_filtro_like = k_campo + " like '" + k_filtro + "'"
//									k_filtro = ""
//								else
//									k_filtro = "ERRORE"
//								end if
//							else	
//								k_filtro = "'" + k_filtro + "'"
//							end if
//					
//						case 'DA'
//							k_filtro = "'"+string(date(k_filtro), "dd/mm/yyyy")+"'"
//
//					end choose
//					
//
end event

