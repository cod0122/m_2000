$PBExportHeader$kkg_magazzino.sru
$PBExportComments$Tipi di Magazzino
forward
global type kkg_magazzino from nonvisualobject
end type
end forward

global type kkg_magazzino from nonvisualobject
end type
global kkg_magazzino kkg_magazzino

type variables
constant int TUTTI=0 //ok per tutti i Magazzini
constant int NOBARCODE=1 //magazzino materiale vario 
constant int LAVORAZIONE=2 //magazzino PRINCIPALE di trattamento 
constant int ALTRO=3 //altro magazzino 
constant int DEP=4 //magazino conto deposito
constant int RD=6 //magazino Ricerca Sviluppo

end variables

on kkg_magazzino.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kkg_magazzino.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

