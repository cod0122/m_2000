$PBExportHeader$uo_d_memo_allarme.sru
forward
global type uo_d_memo_allarme from datawindow
end type
end forward

global type uo_d_memo_allarme from datawindow
integer width = 1925
integer height = 396
string title = "ALLERT"
string dataobject = "d_memo_allarme"
boolean vscrollbar = true
boolean border = false
string icon = "Asterisk!"
boolean livescroll = true
event u_keyenter pbm_dwnprocessenter
end type
global uo_d_memo_allarme uo_d_memo_allarme

type variables
private kuf_memo_allarme kiuf_memo_allarme 
private boolean ki_notifica_a_video = true

end variables

forward prototypes
public subroutine u_deleterow (long a_riga)
public subroutine u_clicked (long a_riga)
public subroutine set_kuf_memo_allarme (ref kuf_memo_allarme auf_memo_allarme)
public function integer get_nr_avvisi ()
public function boolean if_notifica ()
end prototypes

event u_keyenter;//	
if this.getrow( ) > 0 then
	u_clicked(this.getrow( ))
end if

end event

public subroutine u_deleterow (long a_riga);//
//--- ESEGUE 
//

	this.deleterow(a_riga)
	


end subroutine

public subroutine u_clicked (long a_riga);
end subroutine

public subroutine set_kuf_memo_allarme (ref kuf_memo_allarme auf_memo_allarme);//
kiuf_memo_allarme = auf_memo_allarme

end subroutine

public function integer get_nr_avvisi ();//
integer k_tot=0, k_riga=0

if this.rowcount( ) > 0 then 
	for k_riga = 1 to this.rowcount( )
		k_tot += this.getitemnumber(k_riga, "k_numero")
	next
	return k_tot
else
	return 0
end if



end function

public function boolean if_notifica ();//
return ki_notifica_a_video



end function

on uo_d_memo_allarme.create
end on

on uo_d_memo_allarme.destroy
end on

event clicked;//	
string k_nome
st_memo_allarme kst_memo_allarme


	k_nome = dwo.name
	choose case k_nome
		case"p_img_del"
			if row > 0 then
				u_deleterow(row)
			end if
		
		case "k_descr" 
				if row > 0 then
					kst_memo_allarme.d_memo_allarme = create datastore
					kst_memo_allarme.d_memo_allarme.dataobject = "d_memo_allarme"
					this.rowscopy( row, row, primary!, kst_memo_allarme.d_memo_allarme, 1, primary!) 
					kiuf_memo_allarme.u_apri_link(kst_memo_allarme)
					kiuf_memo_allarme.set_visualizza_allarme()
				end if	
				
		case "b_notifiche"
			if this.object.b_notifiche.text = "Disattiva Notifiche" then
				this.object.b_notifiche.text = "ATTIVA NOTIFICHE" 
				ki_notifica_a_video = false
			else
				this.object.b_notifiche.text = "Disattiva Notifiche" 
				ki_notifica_a_video = true
			end if
			
	end choose
 
end event

event constructor;//
//kiuf_memo_allarme = create kuf_memo_allarme
//string k_str 
//k_str = kguo_path.get_risorse( ) + kkg.PATH_SEP + "cancel16.png"
this.object.p_img_del.filename = kguo_path.get_risorse( ) + kkg.PATH_SEP + "cancel16.png"

end event

