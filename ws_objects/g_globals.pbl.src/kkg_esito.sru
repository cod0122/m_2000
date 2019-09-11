$PBExportHeader$kkg_esito.sru
$PBExportComments$Esito x gestione Errore
forward
global type kkg_esito from nonvisualobject
end type
end forward

global type kkg_esito from nonvisualobject
end type
global kkg_esito kkg_esito

type variables
//--- Ritorno ESITO
constant string OK="0" // nessun errore
constant string DB_KO="1" // errore grave DB sqlcode < 0
constant string KO="A" // errore grave ma non da DB, ma de sempio da WINSOCKET
constant string NOT_FND="100" // errore record non trovato sqlcode = 100
constant string DB_WRN="3" // errore con avvertimento (warning)
constant string NO_AUT="2" // errore Utente non Autorizzato
constant string BLOK="5" // errore Bloccante
constant string NO_ESECUZIONE="6" // operazione chiusa in modo gestito dal pgm o dall'Utente 
constant string ERR_FORMALE="7" // errore formale dei dati (es. not numeric) 
constant string ERR_LOGICO="8" // errore congruenza dei dati  
constant string DATI_INSUFF="I" // errore dati insufficienti  
constant string DATI_WRN="W" // solo avvertimento 
constant string TRACE="T" // x verifica flusso pgm da Trace
constant string PWD_INSCAD="PWDINSCAD" // pwd in scadenza
constant string PWD_SCADUTA="PWDSCAD" // pwd in scaduta
constant string PWD_VUOTA="PWDVUOTA" // pwd vuota

end variables
on kkg_esito.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kkg_esito.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

