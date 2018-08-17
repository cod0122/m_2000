$PBExportHeader$ds_fatture.sru
forward
global type ds_fatture from datastore
end type
end forward

global type ds_fatture from datastore
string dataobject = "ds_fatture"
end type
global ds_fatture ds_fatture

type variables
//--- valore per fattura selzionata
public constant integer kki_sel_si = 1
public constant integer kki_sel_no = 0 
//--- valori x fattura presente in profis
public constant integer kki_fattura_in_profis_si = 1
public constant integer kki_fattura_in_profis_no = 0
public constant integer kki_fattura_in_profis_non_rilev = 2

//--- Modo di stampa
public constant string kki_fattura_modo_stampa_esporta = "P" 
public constant string kki_fattura_modo_stampa_cartaceo = "S"
public constant string kki_fattura_modo_stampa_digitale = "D"
public constant string kki_fattura_modo_stampa_cartedig = "E"

end variables

on ds_fatture.create
call super::create
TriggerEvent( this, "constructor" )
end on

on ds_fatture.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

