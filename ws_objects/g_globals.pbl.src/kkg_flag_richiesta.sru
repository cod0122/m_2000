$PBExportHeader$kkg_flag_richiesta.sru
$PBExportComments$Tipologia Operativa x lanciare la funzione
forward
global type kkg_flag_richiesta from nonvisualobject
end type
end forward

global type kkg_flag_richiesta from nonvisualobject
end type
global kkg_flag_richiesta kkg_flag_richiesta

type variables
//--- Tipo richiesta operativa MAX 2 caratteri (utile nel metodo standard SMISTA_FUNZ() )
constant string INSERIMENTO="in"  
constant string MODIFICA="mo"  
constant string CANCELLAZIONE="ca"  
constant string VISUALIZZAZIONE="vi" 
constant string STAMPA="st"  
constant string CONFERMA="co" 
constant string REFRESH="ag"  
constant string REFRESH_ROW="rr"  
constant string ESCI="ri"  
constant string FILTRO="fl" 
constant string SORT="or" 
constant string TROVA="f1" 
constant string TROVA_ANCORA="f2" 
constant string VISUALIZZ_PREDEFINITA="vp" 
constant string MOSTRA_NASCONDI_RIGHE="rg" 
constant string MOSTRA_NASCONDI_DW_DETT="dd"
constant string COPY="tc"
constant string PASTE="tp"
constant string LIBERO1="l1" 
constant string LIBERO2="l2" 
constant string LIBERO3="l3" 
constant string LIBERO4="l4" 
constant string LIBERO5="l5" 
constant string LIBERO6="l6" 
constant string LIBERO71="l71" 
constant string LIBERO72="l72" 
constant string LIBERO73="l73" 
constant string LIBERO74="l74" 
constant string LIBERO75="l75" 
constant string LIBERO8="l8" 
constant string LIBERO9="l9" 
constant string LIBERO10="la" 
constant string PROPRIETA="pr" 

end variables

on kkg_flag_richiesta.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kkg_flag_richiesta.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

