$PBExportHeader$w_g_trova.srw
forward
global type w_g_trova from window
end type
type dw_trova from uo_d_std_trova within w_g_trova
end type
end forward

global type w_g_trova from window
boolean visible = false
integer width = 1947
integer height = 572
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = child!
long backcolor = 553648127
string icon = "Asterisk!"
boolean center = true
integer animationtime = 50
event u_open ( )
dw_trova dw_trova
end type
global w_g_trova w_g_trova

type variables
//
private w_g_trova kiw_this
private kuf_trova kiuf_trova
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
	
//--- punta all'oggetto kuf_trova x fare il trova
		kiuf_trova = ki_st_open_w.key12_any
		kiw_this = this
		kiuf_trova.u_set_window_trova(kiw_this) 
	
	//--- dimensioni
		this.width = 2000
		this.height = 490

		u_inizializza()
	
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
//	kiuf_trova.post u_close_window_trova( )
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
	kiuf_trova.u_set_obj_trova(dw_trova)  // imposta le colonne di ricerca sul DW

//	ki_obj = kiuf_trova.get_obj_su_cui_trovare( )
//	dw_trova.set_obj_trova(ki_obj)
//	dw_trova.ki_trova_campo_def = kiuf_trova.get_num_campo_trova()
//	dw_trova.set_cerca_in_any(dw_trova.ki_trova_campo_def ) //imposta i parametri x trova

	ki_st_open_w.flag_primo_giro = "S"

	u_resize( )
	
catch (uo_exception kguo_exception)
	throw kguo_exception
	
	
end try

end subroutine

public subroutine u_resize ();//
dw_trova.width = this.width 
dw_trova.height = this.height - 5

dw_trova.setfocus()
dw_trova.bringtotop = true


end subroutine

on w_g_trova.create
this.dw_trova=create dw_trova
this.Control[]={this.dw_trova}
end on

on w_g_trova.destroy
destroy(this.dw_trova)
end on

event open;//
if isvalid(message.powerobjectparm) then 
	ki_st_open_w = message.powerobjectparm
	ki_nome_save = trim(this.ClassName())
//	kiuf_trova = create kuf_trova
	post event u_open()
else
	post event close( )
end if


end event

event activate;//call super::activate;//

try
	if ki_st_open_w.flag_primo_giro <> 'S' and isvalid(kiuf_trova) then
	
		kiuf_trova.u_riattiva_funzione_trova(KKG_FLAG_RICHIESTA.trova)
	
	end if

catch (uo_exception kuo_exception)
	
end try 
 


end event

type dw_trova from uo_d_std_trova within w_g_trova
integer width = 1920
integer height = 360
integer taborder = 10
end type

event u_keydwn;//call super::u_keydwn;//
//--- se tasto ESC provo l'undo
	if key = KeyESCape! then 
		parent.visible = false
	end if



end event

