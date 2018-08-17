$PBExportHeader$uo_d_g_clienti_l.sru
forward
global type uo_d_g_clienti_l from uo_d_std_1
end type
end forward

global type uo_d_g_clienti_l from uo_d_std_1
integer width = 1925
integer height = 396
string title = "Trova dati in Elenco  (tasto F3)"
string dataobject = "d_clienti_l_rag_soc"
string icon = "Query5!"
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_dw_visibile_in_open_window = false
event u_keydwn pbm_dwnkey
event u_keyenter pbm_dwnprocessenter
end type
global uo_d_g_clienti_l uo_d_g_clienti_l

type variables
//--- usato per il "TROVA", e' il campo proposto per default e Altro...
public int ki_trova_campo_def = 1
private GraphicObject kiany_oggetto_trova 

end variables

on uo_d_g_clienti_l.create
call super::create
end on

on uo_d_g_clienti_l.destroy
call super::destroy
end on

