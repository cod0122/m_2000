$PBExportHeader$kuf_g_tab_elenco.sru
forward
global type kuf_g_tab_elenco from nonvisualobject
end type
end forward

global type kuf_g_tab_elenco from nonvisualobject
end type
global kuf_g_tab_elenco kuf_g_tab_elenco

on kuf_g_tab_elenco.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_g_tab_elenco.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

