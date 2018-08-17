$PBExportHeader$uo_datastore_0.sru
forward
global type uo_datastore_0 from datastore
end type
end forward

global type uo_datastore_0 from datastore
string dataobject = "d_nulla"
end type
global uo_datastore_0 uo_datastore_0

type variables
//
public:
st_errori_gestione kist_errori_gestione

end variables

on uo_datastore_0.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_datastore_0.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event dberror;//


kist_errori_gestione.nome_oggetto = classname()
kist_errori_gestione.sqlsyntax = trim(sqlsyntax)
kist_errori_gestione.sqlerrtext = trim(sqlerrtext)
kist_errori_gestione.sqldbcode = sqldbcode
kist_errori_gestione.sqlca = sqlca

kGuf_data_base.errori_gestione(kist_errori_gestione)

//=== tentativo di set transobject per il datawindows 
//this.settransobject ( sqlca )


RETURN 1 // Do not display system error message

end event

event constructor;//
kist_errori_gestione.nome_oggetto = classname()
kist_errori_gestione.sqlsyntax = ""
kist_errori_gestione.sqlerrtext = ""
kist_errori_gestione.sqldbcode = 0
setnull(kist_errori_gestione.sqlca) 

end event

