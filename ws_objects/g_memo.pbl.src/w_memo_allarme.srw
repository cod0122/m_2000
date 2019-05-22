$PBExportHeader$w_memo_allarme.srw
forward
global type w_memo_allarme from window
end type
type dw_memo_allarme from uo_d_memo_allarme within w_memo_allarme
end type
end forward

global type w_memo_allarme from window
integer x = -32768
integer y = -32768
integer width = 2002
integer height = 516
boolean titlebar = true
boolean controlmenu = true
boolean resizable = true
long backcolor = 553648127
string icon = "Asterisk!"
integer transparency = 20
windowanimationstyle openanimation = bottomroll!
windowanimationstyle closeanimation = toproll!
integer animationtime = 50
event u_open ( )
dw_memo_allarme dw_memo_allarme
end type
global w_memo_allarme w_memo_allarme

type variables
//
private w_memo_allarme kiw_this
private kuf_memo_allarme kiuf_memo_allarme
private graphicobject ki_obj
private boolean ki_permetti_chiusura=false

private int ki_open_timer=0

private int li_ScreenHt = 0, li_ScreenWid = 0
private st_open_w ki_st_open_w

end variables
forward prototypes
protected subroutine smista_funz (string k_par_in)
public subroutine u_attiva_allarme (datastore ads_memo_allarme) throws uo_exception
public subroutine set_posizione_hide ()
public function boolean if_visible ()
public subroutine set_posizione ()
public subroutine u_show ()
public subroutine u_hide ()
end prototypes

event u_open();//

try 

//		dw_memo_allarme.Modify("p_img_del.Filename='" + trim(kguo_path.get_risorse( ) + kkg.path_sep + "cancel16.png'"))
//		dw_memo_allarme.Modify("b_aggiorna.Filename='" + trim(kguo_path.get_risorse( ) + kkg.path_sep + "refresh16.png'"))
		dw_memo_allarme.set_kuf_memo_allarme(kiuf_memo_allarme)

//--- dimensioni
//		this.width = 2000
//		this.height = 490
//	
		
//manda in crash m2000		Timer(1)	
	
//		this.visible = false	
//		this.SetPosition(topmost! )

		ki_st_open_w.flag_primo_giro = "N"

catch(uo_exception kuo_exception )
	post event close( )

end try

end event

protected subroutine smista_funz (string k_par_in);//===
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//=== Ritorna ...: 0=tutto OK; 1=Errore
//===


choose case k_par_in 


//	case KKG_FLAG_RICHIESTA.stampa		//richiesta stampa
//		stampa()

	case KKG_FLAG_RICHIESTA.esci		//richiesta uscita
		post close (kiw_this)

end choose

end subroutine

public subroutine u_attiva_allarme (datastore ads_memo_allarme) throws uo_exception;//		
long k_y


try
//	kiuf_memo_allarme.kids_memo_allarme.rowscopy(1, kiuf_memo_allarme.kids_memo_allarme.rowcount( ) ,primary!, dw_memo_allarme, 1, primary!)

	ads_memo_allarme.rowscopy(1, ads_memo_allarme.rowcount( ) ,primary!, dw_memo_allarme, 1, primary!)
	ads_memo_allarme.reset()

	if dw_memo_allarme.rowcount( ) > 2 then
		if dw_memo_allarme.rowcount( ) < 9 then
			this.height = dw_memo_allarme.rowcount( ) * 120 + 120
		else
			this.height = 8 * 120 + 120
		end if
		
		k_y = (li_ScreenHt - this.Height ) - 260 
		if k_y > 100 then
			this.y = k_y
		end if

//		u_resize()
	
	end if
	
//	ki_obj = kiuf_memo_allarme.get_obj_su_cui_memo_allarmere( )
//	dw_memo_allarme.set_obj_memo_allarme(ki_obj)
//	dw_memo_allarme.ki_memo_allarme_campo_def = kiuf_memo_allarme.get_num_campo_memo_allarme()
//	dw_memo_allarme.set_cerca_in_any(dw_memo_allarme.ki_memo_allarme_campo_def ) //imposta i parametri x trova

//	if not this.visible or This.WindowState = Minimized! then
//		This.WindowState = normal!
//		this.visible = true	
//	end if
	this.SetPosition(topmost! )
	dw_memo_allarme.bringtotop = true

catch (uo_exception kguo_exception)
	throw kguo_exception
	
	
end try

end subroutine

public subroutine set_posizione_hide ();//
	this.x = 32767
	this.y = 32767

end subroutine

public function boolean if_visible ();//
boolean k_return = false

if this.visible and this.x < 32000 then
	k_return = true
end if

return k_return
end function

public subroutine set_posizione ();//
//if not this.visible then

	this.width = 2000 
	this.height = 490

	long ll_row
	environment le_env
	
	// Get screen size from environment
	GetEnvironment( le_env )
	
	li_ScreenHt = PixelsToUnits( le_env.ScreenHeight, YPixelsToUnits! )
	li_ScreenWid = PixelsToUnits( le_env.ScreenWidth, XPixelsToUnits! )
	
	// open in lower right corner
	this.Move( ( li_ScreenWid - this.Width ) - 80, ( li_ScreenHt - this.Height ) - 260 )
	
	this.title = "ALLARMI MEMO " + " DAL " + string(kiuf_memo_allarme.get_data_allarme_ini( ))
	
//end if

end subroutine

public subroutine u_show ();//
set_posizione( )
this.show( )

end subroutine

public subroutine u_hide ();//
this.hide( )
set_posizione_hide( )

end subroutine

on w_memo_allarme.create
this.dw_memo_allarme=create dw_memo_allarme
this.Control[]={this.dw_memo_allarme}
end on

on w_memo_allarme.destroy
destroy(this.dw_memo_allarme)
end on

event open;//
	if isvalid(message.powerobjectparm) then 
		
		this.x = 32767
		this.y = 32767
		ki_st_open_w = message.powerobjectparm

		ki_st_open_w.flag_primo_giro = "S"

		if isnull(ki_st_open_w.key1) then ki_st_open_w.key1 = ""

//--- punta all'oggetto kuf_memo_allarme 
		kiuf_memo_allarme = ki_st_open_w.key12_any
		kiw_this = this
		kiuf_memo_allarme.set_window(kiw_this) 

		post event u_open()

	else
		post close(this)// event close( )
	end if
end event

event closequery;//--- per chiuedere effettivamente la window chiedo il permesso 
if isvalid(kiuf_memo_allarme) then
//	if not kiuf_memo_allarme.if_close_w_allarme() then
		u_hide( )
		return 1
//	end if
end if
	
end event

event timer;//call super::timer;////st_1.text = 'Timer Count: ' + string(il_open)
//
//ki_open_timer ++
//
//IF Mod(ki_open_timer, 2) = 0 AND ki_open_timer > 4 THEN
//	THIS.Transparency = This.Transparency + 10
//END IF
//// close the window if no one is paying attention
//If This.Transparency > 60 THEN
//	this.visible = false
//END IF
end event

event resize;call super::resize;//
//
long k_y

dw_memo_allarme.x = 0
dw_memo_allarme.y = 0
dw_memo_allarme.width = newwidth
dw_memo_allarme.height = newheight
//if newwidth > 100 then 
//	dw_memo_allarme.width = newwidth - 90
//end if
//if newheight > 200 then
//	dw_memo_allarme.height = newheight - 130
//end if

if dw_memo_allarme.width > 300 then
	dw_memo_allarme.object.k_descr.width = dw_memo_allarme.width -250
end if

end event

type dw_memo_allarme from uo_d_memo_allarme within w_memo_allarme
event u_keydown pbm_keydown
integer width = 1920
integer height = 360
integer taborder = 10
boolean hscrollbar = true
boolean ki_notifica_a_video = true
end type

event u_keydown;//
//--- se tasto ESC nascondo window
	if key = KeyESCape! then 
		parent.u_hide( )
	end if



end event

event clicked;call super::clicked;//
ki_open_timer = 0

end event

event buttonclicked;call super::buttonclicked;//
st_memo_allarme kst_memo_allarme

try

	if dwo.name = "b_aggiorna" then
		if kiuf_memo_allarme.set_allarme_utente(kst_memo_allarme) then
			kiuf_memo_allarme.u_attiva_memo_allarme_on()
		end if
	end if

catch (uo_exception kuo_exception)
	
end try
end event

