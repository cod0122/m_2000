$PBExportHeader$w_alert.srw
forward
global type w_alert from w_super
end type
type dw_alert from uo_d_alert within w_alert
end type
end forward

global type w_alert from w_super
integer width = 1307
integer height = 212
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean border = false
windowtype windowtype = child!
long backcolor = 27448218
string icon = "Asterisk!"
boolean center = false
integer transparency = 20
integer animationtime = 50
event u_open ( )
dw_alert dw_alert
end type
global w_alert w_alert

type variables
//
private w_alert kiw_this
private kuf_alert kiuf_alert
private graphicobject ki_obj
private boolean ki_permetti_chiusura=false
private st_alert kist_alert 

private int ki_open_timer=0

private int li_ScreenHt = 0, li_ScreenWid = 0


end variables

forward prototypes
protected subroutine smista_funz (string k_par_in)
public subroutine u_trasparency ()
public subroutine u_attiva_allarme () throws uo_exception
public subroutine set_posizione ()
end prototypes

event u_open();//

try 

//		this.visible = false	
//		this.SetPosition(topmost! )
	kiuf_alert = create kuf_alert
	kiuf_alert.set_window(kiw_this) 
	kist_alert = ki_st_open_w.key12_any
	ki_st_open_w.flag_primo_giro = "N"
	u_attiva_allarme()

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

public subroutine u_trasparency ();//--- a un certo punto spegne la window
int t
t=THIS.Transparency
//IF Mod(ki_open_timer, 2) = 0 AND ki_open_timer > 4 THEN
	THIS.Transparency = This.Transparency + 10
//END IF
// close the window if no one is paying attention
If This.Transparency > 60 THEN
	this.visible = false
	timer(0)
END IF

end subroutine

public subroutine u_attiva_allarme () throws uo_exception;//		
long k_y


try
//	kiuf_alert.kids_alert.rowscopy(1, kiuf_alert.kids_alert.rowcount( ) ,primary!, dw_alert, 1, primary!)

//	ads_alert.rowscopy(1, ads_alert.rowcount( ) ,primary!, dw_alert, 1, primary!)
//	ads_alert.reset()


	set_posizione()
	
	if dw_alert.rowcount( ) = 0 then
		dw_alert.insertrow(0)
	end if

	choose case kist_alert.allarme 
		case kiuf_alert.kki_alert_KO 
			dw_alert.Modify("p_img.Filename='cancel16.png'")
		case kiuf_alert.kki_alert_OK 
			dw_alert.Modify("p_img.Filename='refresh16.png'")
		case kiuf_alert.kki_alert_NO 
			dw_alert.Modify("p_img.Filename=''")
	end choose
	dw_alert.setitem(1, "k_descr", kist_alert.descr)

	this.show( )

//--- dimensioni
//	this.width = 2000
//	this.height = 490
//	
	

//		if dw_alert.rowcount( ) < 9 then
//			this.height = dw_alert.rowcount( ) * 120 + 120
//		else
//			this.height = 8 * 120 + 120
//		end if
//		
//		k_y = (li_ScreenHt - this.Height ) - 260 
//		if k_y > 100 then
//			this.y = k_y
//		end if
//
	
	SetPosition(topmost! )
	dw_alert.bringtotop = true

	Timer(0.3)	

catch (uo_exception kguo_exception)
	throw kguo_exception
	
	
end try

end subroutine

public subroutine set_posizione ();//
//if not this.visible then

	this.width = 1300
	this.height = 190

	environment le_env
	
	// Get screen size from environment
	GetEnvironment( le_env )
	
	li_ScreenHt = PixelsToUnits( le_env.ScreenHeight, YPixelsToUnits! )
	li_ScreenWid = PixelsToUnits( le_env.ScreenWidth, XPixelsToUnits! )
	
	// open in lower right corner
	this.Move( ( li_ScreenWid - this.Width * 1.3 ), ( li_ScreenHt/2 - this.Height*2 ))
	
//end if

end subroutine

on w_alert.create
int iCurrent
call super::create
this.dw_alert=create dw_alert
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_alert
end on

on w_alert.destroy
call super::destroy
destroy(this.dw_alert)
end on

event open;call super::open;//
	if isvalid(message.powerobjectparm) then 
		
		ki_st_open_w = message.powerobjectparm

//		if isnull(ki_st_open_w.key1) then ki_st_open_w.key1 = ""
//		this.title = "<" + trim(ki_st_open_w.id_programma) + "> " + ki_st_open_w.window_title + " per: " + trim(ki_st_open_w.key1 )
	
//--- punta all'oggetto kuf_alert 
		kiw_this = this

		post event u_open()

	else
		post close(this)// event close( )
	end if
end event

event closequery;call super::closequery;////
////--- per chiuedere effettivamente la window chiedo il permesso 
//if isvalid(kiuf_alert) then
//	if not kiuf_alert.if_close_w_allarme() then
//		hide( )
//		return 1
//	end if
//end if
	
end event

event timer;call super::timer;//st_1.text = 'Timer Count: ' + string(il_open)

ki_open_timer ++

u_trasparency( )

end event

event resize;call super::resize;//
//
long k_y

dw_alert.x = 1
dw_alert.y = 1
if this.width > 100 then 
	dw_alert.width = this.width //- 90
end if
if this.height > 200 then
	dw_alert.height = this.height //- 160
end if

if dw_alert.width > 300 then
	dw_alert.object.k_descr.width = dw_alert.width //-250
end if

end event

type dw_alert from uo_d_alert within w_alert
event u_keydown pbm_keydown
integer width = 1298
integer height = 176
integer taborder = 10
string dataobject = "d_alert"
boolean vscrollbar = false
boolean livescroll = false
borderstyle borderstyle = StyleBox!
end type

event u_keydown;//
//--- se tasto ESC nascondo window
	if key = KeyESCape! then 
		parent.visible = false
	end if



end event

event clicked;call super::clicked;//
ki_open_timer = 0

end event

