$PBExportHeader$w_g_clienti_l.srw
forward
global type w_g_clienti_l from window
end type
type dw_g_clienti_l from uo_d_g_clienti_l within w_g_clienti_l
end type
end forward

global type w_g_clienti_l from window
boolean visible = false
integer width = 1975
integer height = 596
boolean titlebar = true
boolean controlmenu = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = child!
long backcolor = 553648127
string icon = "Asterisk!"
boolean center = true
integer animationtime = 50
event u_open ( )
dw_g_clienti_l dw_g_clienti_l
end type
global w_g_clienti_l w_g_clienti_l

type variables
//
private w_g_clienti_l kiw_this
private kuf_g_clienti_l kiuf_g_clienti_l
private graphicobject ki_obj
private boolean ki_permetti_chiusura=false
private st_open_w ki_st_open_w
private string ki_nome_save
 
end variables

forward prototypes
protected subroutine smista_funz (string k_par_in)
public subroutine chiudi ()
public subroutine chiudi_immediato ()
public subroutine u_inizializza () throws uo_exception
public subroutine u_resize ()
end prototypes

event u_open();//

try 


		if isnull(ki_st_open_w.key1) then ki_st_open_w.key1 = ""

		this.title = "<" + trim(ki_st_open_w.id_programma) + "> " + ki_st_open_w.window_title + " per: " + trim(ki_st_open_w.key1 )
	
//--- punta all'oggetto kuf_g_clienti_l x fare il trova
		kiuf_g_clienti_l = ki_st_open_w.key12_any
		kiw_this = this
		kiuf_g_clienti_l.u_set_window_g_clienti_l(kiw_this) 
	
	//--- dimensioni
		this.width = 2300
		this.height = 2490

		u_inizializza()

		kiuf_g_clienti_l.u_cerca_cliente()
	
		this.show( )	
		this.SetPosition(topmost! )

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

public subroutine chiudi ();////
//if not ki_permetti_chiusura then
//	ki_permetti_chiusura = true
//	kiuf_g_clienti_l.post u_close_window_trova( )
//else
//	this.visible = false
//	//close(kiw_this)
//end if

end subroutine

public subroutine chiudi_immediato ();////
//	ki_permetti_chiusura = true
//	chiudi()

end subroutine

public subroutine u_inizializza () throws uo_exception;//		

try

	ki_st_open_w.flag_primo_giro = "S"

	u_resize( )

	dw_g_clienti_l.retrieve( )

catch (uo_exception kguo_exception)
	throw kguo_exception
	
	
end try

end subroutine

public subroutine u_resize ();//
dw_g_clienti_l.width = this.width - 50
dw_g_clienti_l.height = this.height - 150

dw_g_clienti_l.setfocus()
dw_g_clienti_l.bringtotop = true


end subroutine

on w_g_clienti_l.create
this.dw_g_clienti_l=create dw_g_clienti_l
this.Control[]={this.dw_g_clienti_l}
end on

on w_g_clienti_l.destroy
destroy(this.dw_g_clienti_l)
end on

event open;//
if isvalid(message.powerobjectparm) then 
	ki_st_open_w = message.powerobjectparm
	ki_nome_save = trim(this.ClassName())
	this.y = 50
//	kiuf_g_clienti_l = create kuf_g_clienti_l
	post event u_open()
else
	post event close( )
end if


end event

type dw_g_clienti_l from uo_d_g_clienti_l within w_g_clienti_l
boolean visible = true
integer y = 12
integer taborder = 10
boolean enabled = true
string title = ""
boolean minbox = true
boolean vscrollbar = true
end type

