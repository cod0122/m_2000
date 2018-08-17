$PBExportHeader$w_g_filtra.srw
forward
global type w_g_filtra from window
end type
type dw_filtra from datawindow within w_g_filtra
end type
end forward

global type w_g_filtra from window
boolean visible = false
integer width = 2181
integer height = 824
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = child!
long backcolor = 32041192
string icon = "Asterisk!"
boolean clientedge = true
boolean center = true
integer transparency = 80
integer animationtime = 50
event u_open ( )
dw_filtra dw_filtra
end type
global w_g_filtra w_g_filtra

type variables
//
private w_g_filtra kiw_this
private kuf_filtra kiuf_filtra
private graphicobject ki_obj
private boolean ki_permetti_chiusura=false
private st_open_w ki_st_open_w

end variables

forward prototypes
protected subroutine smista_funz (string k_par_in)
public subroutine chiudi ()
public subroutine chiudi_immediato ()
public subroutine inizializza ()
public subroutine u_resize ()
end prototypes

event u_open();//call super::u_open_preliminari;//


	if isnull(ki_st_open_w.key1) then ki_st_open_w.key1 = ""

	this.title = "<" + trim(ki_st_open_w.id_programma) + "> " + ki_st_open_w.window_title + " per: " + trim(ki_st_open_w.key1 )
	
//--- punta all'oggetto kuf_filtra x fare il filtro
	kiuf_filtra = ki_st_open_w.key12_any
	ki_obj = kiuf_filtra.get_obj_da_filtrare( )
	kiw_this = this
	kiuf_filtra.set_window_filtra(kiw_this)
	kiuf_filtra.set_dw_filtra(dw_filtra)
	
//---
	inizializza()
	
//--- dimensioni
	this.width = 2100
	this.height = 650

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

public subroutine chiudi ();//
if not ki_permetti_chiusura then
	ki_permetti_chiusura = true
	kiuf_filtra.post u_close_window_filtra( )
else
	close(kiw_this)
end if

end subroutine

public subroutine chiudi_immediato ();//
	ki_permetti_chiusura = true
	chiudi()

end subroutine

public subroutine inizializza ();//

	dw_filtra = kiuf_filtra.get_dw_filtra( )

	if NOT isnull(dw_filtra) then
		

		this.WindowState = normal!
		this.visible = true	
		this.bringtotop = true
		
		dw_filtra.visible = true

	else
	
		post event close( )
		
	end if
	

end subroutine

public subroutine u_resize ();//
dw_filtra.width = this.width 
dw_filtra.height = this.height - 130


end subroutine

on w_g_filtra.create
this.dw_filtra=create dw_filtra
this.Control[]={this.dw_filtra}
end on

on w_g_filtra.destroy
destroy(this.dw_filtra)
end on

event closequery;//
if not ki_permetti_chiusura then
	post chiudi( )
	return 1
end if

end event

event open;//
if isvalid(message.powerobjectparm) then 

	ki_st_open_w = message.powerobjectparm
//	kiuf_filtra = create kuf_filtra
	post event u_open( )
else
	post event close( )
end if


end event

type dw_filtra from datawindow within w_g_filtra
event u_keydwn pbm_dwnkey
event u_keyenter pbm_dwnprocessenter
boolean visible = false
integer width = 2002
integer height = 536
integer taborder = 10
string title = "Filtra dati in Elenco"
string dataobject = "d_filtro_0"
boolean border = false
end type

event u_keydwn;//
//--- se tasto ESC provo l'undo
	if key = KeyESCape! then
		THIS.visible = false
	end if



end event

event u_keyenter;//
	kiuf_filtra.u_filtra(dw_filtra)


end event

event buttonclicked;//

if dwo.name = "k_via" and this.rowcount() > 0 then

	if isvalid(kiuf_filtra) then kiuf_filtra.u_filtra(dw_filtra)

end if

end event

event editchanged;//	
	if dwo.name = "k_filtro" then
		if row > 1 then
			if len(trim(data)) > 0 then
				if len(trim(this.getitemstring(row - 1, "k_or_and"))) = 0 then
					this.setitem(row - 1, "k_or_and", "E")
				end if
				if len(trim(this.getitemstring(row - 1, "k_segno"))) = 0 then
					this.setitem(row - 1, "k_segno", "=")
				end if
			end if
		end if
	end if
	
	
end event

event getfocus;
//
//--- imposta l'info del numero di riga di partenza della ricerca
long k_riga
string k_rigax, k_titolo
datawindow kdw_1


//--- fisso l'elenco di ricerca 	
	kdw_1 = ki_obj

	k_titolo = kdw_1.title
	if len(trim(kdw_1.title)) > 0 and trim(kdw_1.title) <> "none" then
		k_titolo = "Filtra dati in elenco: " + trim(kdw_1.title)
	else
		k_titolo = "Filtra dati in elenco" 
	end if
	


end event

event itemerror;//
//=== Evita la messaggistica di sistema
return 1

end event

