$PBExportHeader$kkg_flag_modalita.sru
$PBExportComments$Modalità Operativa di Lavoro delle Windows
forward
global type kkg_flag_modalita from nonvisualobject
end type
end forward

global type kkg_flag_modalita from nonvisualobject
end type
global kkg_flag_modalita kkg_flag_modalita

type variables
//--- Tipo Modalita operativa su cui opera la windows
constant string ELENCO="el"          //menu funz.=e
constant string INSERIMENTO="in"     //menu funz.=i
constant string MODIFICA="mo"        //menu funz.=m
constant string CANCELLAZIONE="ca"   //menu funz.=c
constant string VISUALIZZAZIONE="vi" //menu funz.=v
constant string DUPLICA="dp" //menu funz.=i
constant string STAMPA="st"       	 //menu funz.=s
constant string INTERROGAZIONE="qy"  //menu funz.=q
constant string CHIUDI_PL="cp"       //menu funz.=p
constant string NAVIGATORE="nv"      //menu funz.=n
constant string ANTEPRIMA="an"       //menu funz.=v //t
constant string BATCH="bt"       	 //menu funz.=b
constant string MEMO="me"       	 //funz. particolare di memo allegati
constant string ALTRO="xx"       	 //da usare solo se devo fare qls di mooolto strano

//--- descrizioni delle modalità
constant string DES_ELENCO="Elenco"          //menu funz.=e
constant string DES_INSERIMENTO="Nuovo"     //menu funz.=i
constant string DES_MODIFICA="Modifica"        //menu funz.=m
constant string DES_CANCELLAZIONE="Rimuove"   //menu funz.=c
constant string DES_VISUALIZZAZIONE="Visualizza" //menu funz.=v
constant string DES_DUPLICA="Duplica" //menu funz.=i
constant string DES_STAMPA="Stampa"       	 //menu funz.=s
constant string DES_INTERROGAZIONE="Interroga"  //menu funz.=q
constant string DES_CHIUDI_PL="Chiude Piano di Trattamento"       //menu funz.=p
constant string DES_NAVIGATORE="Esplora"      //menu funz.=n
constant string DES_ANTEPRIMA="Anteprima"       //menu funz.=v //t
constant string DES_BATCH="Non interattiva (batch)"       	 //menu funz.=b
constant string DES_MEMO="MEMO"       	 //funz. particolare di memo allegati
constant string DES_ALTRO="non precisata"       	 //da usare solo se devo fare qls di mooolto strano

end variables
on kkg_flag_modalita.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kkg_flag_modalita.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

