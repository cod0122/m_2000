$PBExportHeader$uo_d_std_guida.sru
forward
global type uo_d_std_guida from datawindow
end type
end forward

global type uo_d_std_guida from datawindow
boolean visible = false
integer width = 2304
integer height = 96
boolean enabled = false
string title = "none"
string dataobject = "d_nulla"
boolean border = false
event ue_buttonclicked ( )
event ue_dwnkey pbm_dwnkey
event ue_retrieve_dinamico ( string k_campo,  string k_data )
event u_premuto_enter pbm_dwnprocessenter
end type
global uo_d_std_guida uo_d_std_guida

event ue_buttonclicked();//--- qui il codice del figlio. Eseguito una volta premuto INVIO o il pulsante OK


end event

event ue_dwnkey;////
//
//	if key = KeyEnter! then
//		this.accepttext( )
//		event ue_buttonclicked( )
//	end if
//




end event

event ue_retrieve_dinamico(string k_campo, string k_data);//--- qui il codice del figlio. Eseguito se ad esempio cambio il valore nel dw
//	this.accepttext( )
// ecc....


end event

event u_premuto_enter;//

	this.accepttext( )
	event ue_buttonclicked( )




end event

on uo_d_std_guida.create
end on

on uo_d_std_guida.destroy
end on

event buttonclicked;//
this.accepttext( )
event ue_buttonclicked( )
end event

event getfocus;//
this.SelectText( 1, Len( String( GetItemString( 1, 1 ) ) ))  // selezione intera del testo 

end event

event editchanged;//
	event ue_retrieve_dinamico(dwo.name, data) 


end event

event itemchanged;//
	event ue_retrieve_dinamico(dwo.name, data) 


end event

