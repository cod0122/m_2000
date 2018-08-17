$PBExportHeader$uo_toolbar_programmi.sru
forward
global type uo_toolbar_programmi from tab
end type
type tabpage_1 from userobject within uo_toolbar_programmi
end type
type tabpage_1 from userobject within uo_toolbar_programmi
end type
type tabpage_2 from userobject within uo_toolbar_programmi
end type
type tabpage_2 from userobject within uo_toolbar_programmi
end type
type tabpage_3 from userobject within uo_toolbar_programmi
end type
type tabpage_3 from userobject within uo_toolbar_programmi
end type
type tabpage_4 from userobject within uo_toolbar_programmi
end type
type tabpage_4 from userobject within uo_toolbar_programmi
end type
type tabpage_5 from userobject within uo_toolbar_programmi
end type
type tabpage_5 from userobject within uo_toolbar_programmi
end type
type tabpage_6 from userobject within uo_toolbar_programmi
end type
type tabpage_6 from userobject within uo_toolbar_programmi
end type
type tabpage_7 from userobject within uo_toolbar_programmi
end type
type tabpage_7 from userobject within uo_toolbar_programmi
end type
type tabpage_8 from userobject within uo_toolbar_programmi
end type
type tabpage_8 from userobject within uo_toolbar_programmi
end type
type tabpage_9 from userobject within uo_toolbar_programmi
end type
type tabpage_9 from userobject within uo_toolbar_programmi
end type
type tabpage_10 from userobject within uo_toolbar_programmi
end type
type tabpage_10 from userobject within uo_toolbar_programmi
end type
type tabpage_11 from userobject within uo_toolbar_programmi
end type
type tabpage_11 from userobject within uo_toolbar_programmi
end type
type tabpage_12 from userobject within uo_toolbar_programmi
end type
type tabpage_12 from userobject within uo_toolbar_programmi
end type
type tabpage_13 from userobject within uo_toolbar_programmi
end type
type tabpage_13 from userobject within uo_toolbar_programmi
end type
type tabpage_14 from userobject within uo_toolbar_programmi
end type
type tabpage_14 from userobject within uo_toolbar_programmi
end type
type tabpage_15 from userobject within uo_toolbar_programmi
end type
type tabpage_15 from userobject within uo_toolbar_programmi
end type
end forward

global type uo_toolbar_programmi from tab
integer width = 4443
integer height = 140
integer textsize = -14
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
boolean raggedright = true
boolean powertips = true
boolean showpicture = false
boolean boldselectedtext = true
boolean createondemand = true
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
tabpage_10 tabpage_10
tabpage_11 tabpage_11
tabpage_12 tabpage_12
tabpage_13 tabpage_13
tabpage_14 tabpage_14
tabpage_15 tabpage_15
event u_rbuttonup pbm_rbuttonup
end type
global uo_toolbar_programmi uo_toolbar_programmi

type variables

long ki_tab_toolbar_programmi_handle[16]
string ki_tab_toolbar_programmi_titolo[16]
boolean ki_tab_toolbar_programmi_occupata[16]
st_toolbar_programmi kist_toolbar_programmi
end variables

forward prototypes
public subroutine aggiungi_voce ()
public subroutine cancella_voce ()
public subroutine attiva_voce ()
public subroutine set_height (integer k_height)
public subroutine check_voci ()
public subroutine set_visible ()
end prototypes

event u_rbuttonup;//
	parent.triggerevent(rbuttonup!)

end event

public subroutine aggiungi_voce ();//
//--- aggiunge una voce
//
int k_ind, k_pos 

check_voci() // cancella voci zombie

//--- check se voce già presente 
for k_ind = 1 to 15
	if ki_tab_toolbar_programmi_handle[k_ind] = kist_toolbar_programmi.handle then exit
next

//--- proseguo nell'aggiungere un nuovo tab solo se non ho trovato la window
if ki_tab_toolbar_programmi_handle[k_ind] = kist_toolbar_programmi.handle then 
	kist_toolbar_programmi.posizione_tab = k_ind
else

	for k_ind = 15 to 2 step -1
		if ki_tab_toolbar_programmi_occupata[k_ind] then exit
	next

	if ki_tab_toolbar_programmi_occupata[k_ind] then
		if k_ind < 15 then
			k_ind++ 
		else
			k_ind = 1
			do while ki_tab_toolbar_programmi_occupata[k_ind] and k_ind <= 15
				k_ind = k_ind + 1
			loop
			if k_ind = 15 then
				k_ind = 99
			end if
		end if
	end if 

	if k_ind > 0 and k_ind <= 15 then
		
		kist_toolbar_programmi.posizione_tab = k_ind
		ki_tab_toolbar_programmi_handle[k_ind] = kist_toolbar_programmi.handle
		
		k_pos = Pos(kist_toolbar_programmi.titolo, ">")
		if k_pos > 0 then
			ki_tab_toolbar_programmi_titolo[k_ind] = trim(mid(RightTrim(kist_toolbar_programmi.titolo), k_pos + 1))
		else
			ki_tab_toolbar_programmi_titolo[k_ind] = trim(kist_toolbar_programmi.titolo)
		end if
		
		ki_tab_toolbar_programmi_occupata[k_ind] = true
	
		choose case k_ind
				
			case 1
				tabpage_1.visible = ki_tab_toolbar_programmi_occupata[k_ind]
				tabpage_1.text = ki_tab_toolbar_programmi_titolo[k_ind]
				tabpage_1.PowerTipText = ki_tab_toolbar_programmi_titolo[k_ind]
			case 2
				tabpage_2.visible = ki_tab_toolbar_programmi_occupata[k_ind]
				tabpage_2.text = ki_tab_toolbar_programmi_titolo[k_ind]
				tabpage_2.PowerTipText = ki_tab_toolbar_programmi_titolo[k_ind]
			case 3
				tabpage_3.visible = ki_tab_toolbar_programmi_occupata[k_ind]
				tabpage_3.text = ki_tab_toolbar_programmi_titolo[k_ind]
				tabpage_3.PowerTipText = ki_tab_toolbar_programmi_titolo[k_ind]
			case 4
				tabpage_4.visible = ki_tab_toolbar_programmi_occupata[k_ind]
				tabpage_4.text = ki_tab_toolbar_programmi_titolo[k_ind]
				tabpage_4.PowerTipText = ki_tab_toolbar_programmi_titolo[k_ind]
			case 5
				tabpage_5.visible = ki_tab_toolbar_programmi_occupata[k_ind]
				tabpage_5.text = ki_tab_toolbar_programmi_titolo[k_ind]
				tabpage_5.PowerTipText = ki_tab_toolbar_programmi_titolo[k_ind]
			case 6
				tabpage_6.visible = ki_tab_toolbar_programmi_occupata[k_ind]
				tabpage_6.text = ki_tab_toolbar_programmi_titolo[k_ind]
				tabpage_6.PowerTipText = ki_tab_toolbar_programmi_titolo[k_ind]
			case 7
				tabpage_7.visible = ki_tab_toolbar_programmi_occupata[k_ind]
				tabpage_7.text = ki_tab_toolbar_programmi_titolo[k_ind]
				tabpage_7.PowerTipText = ki_tab_toolbar_programmi_titolo[k_ind]
			case 8
				tabpage_8.visible = ki_tab_toolbar_programmi_occupata[k_ind]
				tabpage_8.text = ki_tab_toolbar_programmi_titolo[k_ind]
				tabpage_8.PowerTipText = ki_tab_toolbar_programmi_titolo[k_ind]
			case 9
				tabpage_9.visible = ki_tab_toolbar_programmi_occupata[k_ind]
				tabpage_9.text = ki_tab_toolbar_programmi_titolo[k_ind]
				tabpage_9.PowerTipText = ki_tab_toolbar_programmi_titolo[k_ind]
			case 10
				tabpage_10.visible = ki_tab_toolbar_programmi_occupata[k_ind]
				tabpage_10.text = ki_tab_toolbar_programmi_titolo[k_ind]
				tabpage_10.PowerTipText = ki_tab_toolbar_programmi_titolo[k_ind]
			case 11
				tabpage_11.visible = ki_tab_toolbar_programmi_occupata[k_ind]
				tabpage_11.text = ki_tab_toolbar_programmi_titolo[k_ind]
				tabpage_11.PowerTipText = ki_tab_toolbar_programmi_titolo[k_ind]
			case 12
				tabpage_12.visible = ki_tab_toolbar_programmi_occupata[k_ind]
				tabpage_12.text = ki_tab_toolbar_programmi_titolo[k_ind]
				tabpage_12.PowerTipText = ki_tab_toolbar_programmi_titolo[k_ind]
			case 13
				tabpage_13.visible = ki_tab_toolbar_programmi_occupata[k_ind]
				tabpage_13.text = ki_tab_toolbar_programmi_titolo[k_ind]
				tabpage_13.PowerTipText = ki_tab_toolbar_programmi_titolo[k_ind]
			case 14
				tabpage_14.visible = ki_tab_toolbar_programmi_occupata[k_ind]
				tabpage_14.text = ki_tab_toolbar_programmi_titolo[k_ind]
				tabpage_14.PowerTipText = ki_tab_toolbar_programmi_titolo[k_ind]
			case 15
				tabpage_15.visible = ki_tab_toolbar_programmi_occupata[k_ind]
				tabpage_15.text = ki_tab_toolbar_programmi_titolo[k_ind]
				tabpage_15.PowerTipText = ki_tab_toolbar_programmi_titolo[k_ind]
				
		end choose
		
	else
		
		kist_toolbar_programmi.posizione_tab = 0
	
	end if

end if

if kist_toolbar_programmi.posizione_tab > 0 then
	this.selecttab(kist_toolbar_programmi.posizione_tab) 
end if

this.set_visible( )



end subroutine

public subroutine cancella_voce ();//
//--- Cancella una voce
//
int k_ind 

	check_voci() // cancella voci zombie

	k_ind=1
	do while ki_tab_toolbar_programmi_handle[k_ind] <> kist_toolbar_programmi.handle &
		      and k_ind <= 15
		k_ind ++
	loop
	if ki_tab_toolbar_programmi_handle[k_ind] = kist_toolbar_programmi.handle then
		
		kist_toolbar_programmi.posizione_tab = k_ind
		ki_tab_toolbar_programmi_handle[k_ind] = 0
		ki_tab_toolbar_programmi_titolo[k_ind] = " "
		
		ki_tab_toolbar_programmi_occupata[k_ind] = false
	
		choose case k_ind
			case 1
				tabpage_1.visible = ki_tab_toolbar_programmi_occupata[k_ind]
				tabpage_1.text = kist_toolbar_programmi.titolo
			case 2
				tabpage_2.visible = ki_tab_toolbar_programmi_occupata[k_ind]
				tabpage_2.text = kist_toolbar_programmi.titolo
			case 3
				tabpage_3.visible = ki_tab_toolbar_programmi_occupata[k_ind]
				tabpage_3.text = kist_toolbar_programmi.titolo
			case 4
				tabpage_4.visible = ki_tab_toolbar_programmi_occupata[k_ind]
				tabpage_4.text = kist_toolbar_programmi.titolo
			case 5
				tabpage_5.visible = ki_tab_toolbar_programmi_occupata[k_ind]
				tabpage_5.text = kist_toolbar_programmi.titolo
			case 6
				tabpage_6.visible = ki_tab_toolbar_programmi_occupata[k_ind]
				tabpage_6.text = kist_toolbar_programmi.titolo
			case 7
				tabpage_7.visible = ki_tab_toolbar_programmi_occupata[k_ind]
				tabpage_7.text = kist_toolbar_programmi.titolo
			case 8
				tabpage_8.visible = ki_tab_toolbar_programmi_occupata[k_ind]
				tabpage_8.text = kist_toolbar_programmi.titolo
			case 9
				tabpage_9.visible = ki_tab_toolbar_programmi_occupata[k_ind]
				tabpage_9.text = kist_toolbar_programmi.titolo
			case 10
				tabpage_10.visible = ki_tab_toolbar_programmi_occupata[k_ind]
				tabpage_10.text = kist_toolbar_programmi.titolo
			case 11
				tabpage_11.visible = ki_tab_toolbar_programmi_occupata[k_ind]
				tabpage_11.text = kist_toolbar_programmi.titolo
			case 12
				tabpage_12.visible = ki_tab_toolbar_programmi_occupata[k_ind]
				tabpage_12.text = kist_toolbar_programmi.titolo
			case 13
				tabpage_13.visible = ki_tab_toolbar_programmi_occupata[k_ind]
				tabpage_13.text = kist_toolbar_programmi.titolo
			case 14
				tabpage_14.visible = ki_tab_toolbar_programmi_occupata[k_ind]
				tabpage_14.text = kist_toolbar_programmi.titolo
			case 15
				tabpage_15.visible = ki_tab_toolbar_programmi_occupata[k_ind]
				tabpage_15.text = kist_toolbar_programmi.titolo
				
		
		end choose
	else
		
		kist_toolbar_programmi.posizione_tab = 0
	
	end if

	this.set_visible( )



end subroutine

public subroutine attiva_voce ();//
//--- Attiva una voce gia' presente
//
int k_ind 

	
//--- Trova la voce tra quelle presenti
	for k_ind = 1 to 15
		if ki_tab_toolbar_programmi_handle[k_ind] = kist_toolbar_programmi.handle then exit
	next

	if ki_tab_toolbar_programmi_handle[k_ind] = kist_toolbar_programmi.handle then
		this.selecttab(k_ind)
	else
		kist_toolbar_programmi.posizione_tab = 0
	end if

	this.set_visible( )

end subroutine

public subroutine set_height (integer k_height);//
this.height = k_height

end subroutine

public subroutine check_voci ();//
//--- Controlla voci se chiusa la cancella
//
int k_ind, k_pos 


	k_ind=15
	do while not ki_tab_toolbar_programmi_occupata[k_ind] and k_ind > 1
		if ki_tab_toolbar_programmi_handle[k_ind] > 0 then
			if not kguo_g.window_aperta_if(ki_tab_toolbar_programmi_handle[k_ind] ) then
				this.cancella_voce( )
			end if
		end if
		k_ind = k_ind - 1
	loop



end subroutine

public subroutine set_visible ();//
//--- nasconde se le window sono MAXIMIZED
//
window kwin_1
boolean k_visible=true

	kwin_1 = kGuf_data_base.prendi_win_la_prima()
	IF IsValid(kwin_1) THEN
		IF kwin_1.WindowState = maximized!  THEN
			k_visible = false
		end if
	end if
	parent.visible = k_visible
		
end subroutine

on uo_toolbar_programmi.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.tabpage_7=create tabpage_7
this.tabpage_8=create tabpage_8
this.tabpage_9=create tabpage_9
this.tabpage_10=create tabpage_10
this.tabpage_11=create tabpage_11
this.tabpage_12=create tabpage_12
this.tabpage_13=create tabpage_13
this.tabpage_14=create tabpage_14
this.tabpage_15=create tabpage_15
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6,&
this.tabpage_7,&
this.tabpage_8,&
this.tabpage_9,&
this.tabpage_10,&
this.tabpage_11,&
this.tabpage_12,&
this.tabpage_13,&
this.tabpage_14,&
this.tabpage_15}
end on

on uo_toolbar_programmi.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
destroy(this.tabpage_7)
destroy(this.tabpage_8)
destroy(this.tabpage_9)
destroy(this.tabpage_10)
destroy(this.tabpage_11)
destroy(this.tabpage_12)
destroy(this.tabpage_13)
destroy(this.tabpage_14)
destroy(this.tabpage_15)
end on

event constructor;//
int k_ind

for k_ind=1 to 15
	ki_tab_toolbar_programmi_occupata[k_ind] = false
next
	

end event

event selectionchanged;//
any ktabpage

choose case oldindex
	case 1
		tabpage_1.tabtextcolor = KKG_COLORE.NERO
	case 2
		tabpage_2.tabtextcolor = KKG_COLORE.NERO
	case 3
		tabpage_3.tabtextcolor = KKG_COLORE.NERO
	case 4
		tabpage_4.tabtextcolor = KKG_COLORE.NERO
	case 5
		tabpage_5.tabtextcolor = KKG_COLORE.NERO
	case 6
		tabpage_6.tabtextcolor = KKG_COLORE.NERO
	case 7
		tabpage_7.tabtextcolor = KKG_COLORE.NERO
	case 8
		tabpage_8.tabtextcolor = KKG_COLORE.NERO
	case 9
		tabpage_9.tabtextcolor = KKG_COLORE.NERO
	case 10
		tabpage_10.tabtextcolor = KKG_COLORE.NERO
	case 11
		tabpage_11.tabtextcolor = KKG_COLORE.NERO
	case 12
		tabpage_12.tabtextcolor = KKG_COLORE.NERO
	case 13
		tabpage_13.tabtextcolor = KKG_COLORE.NERO
	case 14
		tabpage_14.tabtextcolor = KKG_COLORE.NERO
	case 15
		tabpage_15.tabtextcolor = KKG_COLORE.NERO
end choose
	 
choose case newindex
	case 1
		tabpage_1.tabtextcolor = KKG_COLORE.GRANATA
	case 2
		tabpage_2.tabtextcolor = KKG_COLORE.GRANATA
	case 3
		tabpage_3.tabtextcolor = KKG_COLORE.GRANATA
	case 4
		tabpage_4.tabtextcolor = KKG_COLORE.GRANATA
	case 5
		tabpage_5.tabtextcolor = KKG_COLORE.GRANATA
	case 6
		tabpage_6.tabtextcolor = KKG_COLORE.GRANATA
	case 7
		tabpage_7.tabtextcolor = KKG_COLORE.GRANATA
	case 8
		tabpage_8.tabtextcolor = KKG_COLORE.GRANATA
	case 9
		tabpage_9.tabtextcolor = KKG_COLORE.GRANATA
	case 10
		tabpage_10.tabtextcolor = KKG_COLORE.GRANATA
	case 11
		tabpage_11.tabtextcolor = KKG_COLORE.GRANATA
	case 12
		tabpage_12.tabtextcolor = KKG_COLORE.GRANATA
	case 13
		tabpage_13.tabtextcolor = KKG_COLORE.GRANATA
	case 14
		tabpage_14.tabtextcolor = KKG_COLORE.GRANATA
	case 15
		tabpage_15.tabtextcolor = KKG_COLORE.GRANATA
end choose




end event

event clicked;//
w_g_tab kwin_1



//--- Ripristina la dimensione
if index > 0 then
	if UpperBound(ki_tab_toolbar_programmi_handle) >= index and ki_tab_toolbar_programmi_handle[index] > 0 then
		kwin_1 = kGuf_data_base.prendi_win_uguale_handle(ki_tab_toolbar_programmi_handle[index])
		IF IsValid(kwin_1) THEN
			IF kwin_1.WindowState = minimized!  THEN
				kwin_1.setredraw( false)
				kwin_1.WindowState = normal!
				kwin_1.set_window_size( )
				kwin_1.setredraw(true)
			end if
			kwin_1.setfocus( )
		end if
	end if
end if

end event

type tabpage_1 from userobject within uo_toolbar_programmi
event u_rbuttonup pbm_rbuttonup
boolean visible = false
integer x = 18
integer y = 136
integer width = 4407
integer height = -12
long backcolor = 8388608
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

event u_rbuttonup;//
	parent.triggerevent(rbuttonup!)

end event

type tabpage_2 from userobject within uo_toolbar_programmi
event u_rbuttonup pbm_rbuttonup
boolean visible = false
integer x = 18
integer y = 136
integer width = 4407
integer height = -12
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

event u_rbuttonup;//
	parent.triggerevent(rbuttonup!)

end event

type tabpage_3 from userobject within uo_toolbar_programmi
event u_rbuttonup pbm_rbuttonup
boolean visible = false
integer x = 18
integer y = 136
integer width = 4407
integer height = -12
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

event u_rbuttonup;//
	parent.triggerevent(rbuttonup!)

end event

type tabpage_4 from userobject within uo_toolbar_programmi
event u_rbuttonup pbm_rbuttonup
boolean visible = false
integer x = 18
integer y = 136
integer width = 4407
integer height = -12
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

event u_rbuttonup;//
	parent.triggerevent(rbuttonup!)

end event

type tabpage_5 from userobject within uo_toolbar_programmi
event u_rbuttonup pbm_rbuttonup
boolean visible = false
integer x = 18
integer y = 136
integer width = 4407
integer height = -12
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

event u_rbuttonup;//
	parent.triggerevent(rbuttonup!)

end event

type tabpage_6 from userobject within uo_toolbar_programmi
event u_rbuttonup pbm_rbuttonup
boolean visible = false
integer x = 18
integer y = 136
integer width = 4407
integer height = -12
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

event u_rbuttonup;//
	parent.triggerevent(rbuttonup!)

end event

type tabpage_7 from userobject within uo_toolbar_programmi
event u_rbuttonup pbm_rbuttonup
boolean visible = false
integer x = 18
integer y = 136
integer width = 4407
integer height = -12
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

event u_rbuttonup;//
	parent.triggerevent(rbuttonup!)

end event

type tabpage_8 from userobject within uo_toolbar_programmi
event u_rbuttonup pbm_rbuttonup
boolean visible = false
integer x = 18
integer y = 136
integer width = 4407
integer height = -12
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

event u_rbuttonup;//
	parent.triggerevent(rbuttonup!)

end event

type tabpage_9 from userobject within uo_toolbar_programmi
event u_rbuttonup pbm_rbuttonup
boolean visible = false
integer x = 18
integer y = 136
integer width = 4407
integer height = -12
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

event u_rbuttonup;//
	parent.triggerevent(rbuttonup!)

end event

type tabpage_10 from userobject within uo_toolbar_programmi
event u_rbuttonup pbm_rbuttonup
boolean visible = false
integer x = 18
integer y = 136
integer width = 4407
integer height = -12
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

event u_rbuttonup;//
	parent.triggerevent(rbuttonup!)

end event

type tabpage_11 from userobject within uo_toolbar_programmi
event u_rbuttonup pbm_rbuttonup
boolean visible = false
integer x = 18
integer y = 136
integer width = 4407
integer height = -12
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

event u_rbuttonup;//
	parent.triggerevent(rbuttonup!)

end event

type tabpage_12 from userobject within uo_toolbar_programmi
event u_rbuttonup pbm_rbuttonup
boolean visible = false
integer x = 18
integer y = 136
integer width = 4407
integer height = -12
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

event u_rbuttonup;//
	parent.triggerevent(rbuttonup!)

end event

type tabpage_13 from userobject within uo_toolbar_programmi
event u_rbuttonup pbm_rbuttonup
boolean visible = false
integer x = 18
integer y = 136
integer width = 4407
integer height = -12
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

event u_rbuttonup;//
	parent.triggerevent(rbuttonup!)

end event

type tabpage_14 from userobject within uo_toolbar_programmi
event u_rbuttonup pbm_rbuttonup
boolean visible = false
integer x = 18
integer y = 136
integer width = 4407
integer height = -12
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

event u_rbuttonup;//
	parent.triggerevent(rbuttonup!)

end event

type tabpage_15 from userobject within uo_toolbar_programmi
event u_rbuttonup pbm_rbuttonup
boolean visible = false
integer x = 18
integer y = 136
integer width = 4407
integer height = -12
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

event u_rbuttonup;//
	parent.triggerevent(rbuttonup!)

end event

