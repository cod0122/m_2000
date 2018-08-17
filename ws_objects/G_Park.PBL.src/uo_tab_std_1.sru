$PBExportHeader$uo_tab_std_1.sru
forward
global type uo_tab_std_1 from tab
end type
type tabpage_1 from userobject within uo_tab_std_1
end type
type dw_1 from uo_d_std_1 within tabpage_1
end type
type tabpage_1 from userobject within uo_tab_std_1
dw_1 dw_1
end type
type tabpage_2 from userobject within uo_tab_std_1
end type
type dw_2 from uo_d_std_1 within tabpage_2
end type
type tabpage_2 from userobject within uo_tab_std_1
dw_2 dw_2
end type
type tabpage_3 from userobject within uo_tab_std_1
end type
type dw_3 from uo_d_std_1 within tabpage_3
end type
type tabpage_3 from userobject within uo_tab_std_1
dw_3 dw_3
end type
type tabpage_4 from userobject within uo_tab_std_1
end type
type dw_4 from uo_d_std_1 within tabpage_4
end type
type tabpage_4 from userobject within uo_tab_std_1
dw_4 dw_4
end type
type tabpage_5 from userobject within uo_tab_std_1
end type
type dw_5 from uo_d_std_1 within tabpage_5
end type
type tabpage_5 from userobject within uo_tab_std_1
dw_5 dw_5
end type
type tabpage_6 from userobject within uo_tab_std_1
end type
type dw_6 from uo_d_std_1 within tabpage_6
end type
type tabpage_6 from userobject within uo_tab_std_1
dw_6 dw_6
end type
type tabpage_7 from userobject within uo_tab_std_1
end type
type dw_7 from uo_d_std_1 within tabpage_7
end type
type tabpage_7 from userobject within uo_tab_std_1
dw_7 dw_7
end type
type tabpage_8 from userobject within uo_tab_std_1
end type
type dw_8 from uo_d_std_1 within tabpage_8
end type
type tabpage_8 from userobject within uo_tab_std_1
dw_8 dw_8
end type
type tabpage_9 from userobject within uo_tab_std_1
end type
type dw_9 from uo_d_std_1 within tabpage_9
end type
type tabpage_9 from userobject within uo_tab_std_1
dw_9 dw_9
end type
end forward

global type uo_tab_std_1 from tab
integer width = 2304
integer height = 1056
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
boolean raggedright = true
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
event u_attiva_tab ( integer a_index )
end type
global uo_tab_std_1 uo_tab_std_1

type variables
protected integer ki_tab_1_index_new=0
protected integer ki_tab_1_index_old=0
protected boolean ki_tabpage_visible[10] // memorizza i tabpage visibili e no 

protected datawindow kidw_tabselezionato 

end variables

forward prototypes
public subroutine dati_modif_accept ()
end prototypes

event u_attiva_tab(integer a_index);//
//--- mettere qui il codice persolaizzato
//

end event

public subroutine dati_modif_accept ();//
	if this.tabpage_1.dw_1.enabled then this.tabpage_1.dw_1.accepttext()
	if this.tabpage_1.dw_1.enabled then this.tabpage_2.dw_2.accepttext()
	if this.tabpage_1.dw_1.enabled then this.tabpage_3.dw_3.accepttext()
	if this.tabpage_1.dw_1.enabled then this.tabpage_4.dw_4.accepttext()
	if this.tabpage_1.dw_1.enabled then this.tabpage_5.dw_5.accepttext()
	if this.tabpage_1.dw_1.enabled then this.tabpage_6.dw_6.accepttext()
	if this.tabpage_1.dw_1.enabled then this.tabpage_7.dw_7.accepttext()
	if this.tabpage_1.dw_1.enabled then this.tabpage_8.dw_8.accepttext()
	if this.tabpage_1.dw_1.enabled then this.tabpage_9.dw_9.accepttext()

end subroutine

on uo_tab_std_1.create
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

on uo_tab_std_1.destroy
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

event key;//
//=== Controllo quale tasto da tastiera ha premuto
int k_ind


//--- se ho più di 5 righe non faccio tab avanti/indietro con pagGiù o pagSu ma lascio come paginata 
if not isvalid(kidw_tabselezionato) or kidw_tabselezionato.rowcount( ) < 6 then

	choose case key
			
		case keypagedown!
			
			if ki_tab_1_index_new < 9 then
				k_ind = ki_tab_1_index_new + 1
				for k_ind = k_ind to 9
					if ki_tabpage_visible[k_ind] then
						exit
					end if
				next
				if ki_tabpage_visible[k_ind] then
					this.selectedtab = k_ind
				end if
			end if
			
	
		case keypageup!
			
			if ki_tab_1_index_new > 1 then
				k_ind = ki_tab_1_index_new - 1
				for k_ind = k_ind to 1 step -1
					if ki_tabpage_visible[k_ind] then
						exit
					end if
				next
				if ki_tabpage_visible[k_ind] then
					this.selectedtab = k_ind
				end if
			end if
			
	end choose
	
end if


end event

event selectionchanged;//
long k_riga=0


	
	ki_tab_1_index_new=newindex
	ki_tab_1_index_old=oldindex

//
	dati_modif_accept()

	if oldindex > 0 then  //la prima volta e' a -1

//=== Puntatore Cursore da attesa..... 
		SetPointer(kkg.pointer_attesa)

		this.visible = true

		choose case newindex
			case 1 
				kidw_tabselezionato = this.tabpage_1.dw_1
			case 2
				kidw_tabselezionato = this.tabpage_2.dw_2
			case 3
				kidw_tabselezionato = this.tabpage_3.dw_3
			case 4
				kidw_tabselezionato = this.tabpage_4.dw_4
			case 5
				kidw_tabselezionato = this.tabpage_5.dw_5
			case 6
				kidw_tabselezionato = this.tabpage_6.dw_6
			case 7
				kidw_tabselezionato = this.tabpage_7.dw_7
			case 8
				kidw_tabselezionato = this.tabpage_8.dw_8
			case 9
				kidw_tabselezionato = this.tabpage_9.dw_9
		end choose	
		
		event u_attiva_tab(newindex)
		
	end if
	


	
end event

type tabpage_1 from userobject within uo_tab_std_1
event create ( )
event destroy ( )
event key pbm_keydown
integer x = 18
integer y = 108
integer width = 2267
integer height = 932
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_1 dw_1
end type

on tabpage_1.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on tabpage_1.destroy
destroy(this.dw_1)
end on

event constructor;//
this.backcolor = parent.backcolor

end event

type dw_1 from uo_d_std_1 within tabpage_1
integer x = 55
integer y = 24
integer width = 686
integer height = 400
integer taborder = 10
boolean enabled = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = false
end type

type tabpage_2 from userobject within uo_tab_std_1
event create ( )
event destroy ( )
boolean visible = false
integer x = 18
integer y = 108
integer width = 2267
integer height = 932
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_2 dw_2
end type

on tabpage_2.create
this.dw_2=create dw_2
this.Control[]={this.dw_2}
end on

on tabpage_2.destroy
destroy(this.dw_2)
end on

type dw_2 from uo_d_std_1 within tabpage_2
integer x = 87
integer y = 40
integer width = 686
integer height = 400
integer taborder = 10
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = false
end type

type tabpage_3 from userobject within uo_tab_std_1
event create ( )
event destroy ( )
boolean visible = false
integer x = 18
integer y = 108
integer width = 2267
integer height = 932
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_3 dw_3
end type

on tabpage_3.create
this.dw_3=create dw_3
this.Control[]={this.dw_3}
end on

on tabpage_3.destroy
destroy(this.dw_3)
end on

type dw_3 from uo_d_std_1 within tabpage_3
integer x = 87
integer y = 40
integer width = 686
integer height = 400
integer taborder = 20
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = false
end type

type tabpage_4 from userobject within uo_tab_std_1
event create ( )
event destroy ( )
boolean visible = false
integer x = 18
integer y = 108
integer width = 2267
integer height = 932
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_4 dw_4
end type

on tabpage_4.create
this.dw_4=create dw_4
this.Control[]={this.dw_4}
end on

on tabpage_4.destroy
destroy(this.dw_4)
end on

type dw_4 from uo_d_std_1 within tabpage_4
integer x = 87
integer y = 40
integer width = 686
integer height = 400
integer taborder = 20
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = false
end type

type tabpage_5 from userobject within uo_tab_std_1
event create ( )
event destroy ( )
boolean visible = false
integer x = 18
integer y = 108
integer width = 2267
integer height = 932
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_5 dw_5
end type

on tabpage_5.create
this.dw_5=create dw_5
this.Control[]={this.dw_5}
end on

on tabpage_5.destroy
destroy(this.dw_5)
end on

type dw_5 from uo_d_std_1 within tabpage_5
integer x = 87
integer y = 40
integer width = 686
integer height = 400
integer taborder = 20
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = false
end type

type tabpage_6 from userobject within uo_tab_std_1
event create ( )
event destroy ( )
boolean visible = false
integer x = 18
integer y = 108
integer width = 2267
integer height = 932
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_6 dw_6
end type

on tabpage_6.create
this.dw_6=create dw_6
this.Control[]={this.dw_6}
end on

on tabpage_6.destroy
destroy(this.dw_6)
end on

type dw_6 from uo_d_std_1 within tabpage_6
integer x = 87
integer y = 40
integer width = 686
integer height = 400
integer taborder = 20
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = false
end type

type tabpage_7 from userobject within uo_tab_std_1
event create ( )
event destroy ( )
boolean visible = false
integer x = 18
integer y = 108
integer width = 2267
integer height = 932
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_7 dw_7
end type

on tabpage_7.create
this.dw_7=create dw_7
this.Control[]={this.dw_7}
end on

on tabpage_7.destroy
destroy(this.dw_7)
end on

type dw_7 from uo_d_std_1 within tabpage_7
integer x = 87
integer y = 40
integer width = 686
integer height = 400
integer taborder = 20
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = false
end type

type tabpage_8 from userobject within uo_tab_std_1
event create ( )
event destroy ( )
boolean visible = false
integer x = 18
integer y = 108
integer width = 2267
integer height = 932
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_8 dw_8
end type

on tabpage_8.create
this.dw_8=create dw_8
this.Control[]={this.dw_8}
end on

on tabpage_8.destroy
destroy(this.dw_8)
end on

type dw_8 from uo_d_std_1 within tabpage_8
integer x = 87
integer y = 40
integer width = 686
integer height = 400
integer taborder = 20
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = false
end type

type tabpage_9 from userobject within uo_tab_std_1
event create ( )
event destroy ( )
boolean visible = false
integer x = 18
integer y = 108
integer width = 2267
integer height = 932
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_9 dw_9
end type

on tabpage_9.create
this.dw_9=create dw_9
this.Control[]={this.dw_9}
end on

on tabpage_9.destroy
destroy(this.dw_9)
end on

type dw_9 from uo_d_std_1 within tabpage_9
integer x = 87
integer y = 40
integer width = 686
integer height = 400
integer taborder = 20
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = false
end type

