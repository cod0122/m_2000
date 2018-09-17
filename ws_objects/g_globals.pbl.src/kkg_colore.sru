$PBExportHeader$kkg_colore.sru
$PBExportComments$Colori standard utilizzati
forward
global type kkg_colore from nonvisualobject
end type
end forward

global type kkg_colore from nonvisualobject
end type
global kkg_colore kkg_colore

type variables
//--- in numero
constant long NERO=65536 * (0) + 256 * (0) + (0) //colore (blu),(verde),(rosso)
constant long BIANCO=65536 * (255) + 256 * (255) + (255) //colore (blu),(verde),(rosso)
constant long GRIGIO=65536 * (223) + 256 * (223) + 223 //(192) //colore (blu),(verde),(rosso)
constant long ROSSO=65536 * (0) + 256 * (0) + (255) //colore (blu),(verde),(rosso)
constant long ROSSO_CHIARO=65536 * (136) + 256 * (136) + (255) //colore (blu),(verde),(rosso)
constant long GRANATA=65536 * (62) + 256 * (0) + (132) //colore (blu),(verde),(rosso)
constant long ERR_DATO=65536 * (217) + 256 * (217) + (255) //colore (blu),(verde),(rosso)
constant long BLU_SCURO=65536 * (113) + 256 * (0) + (0) //colore (blu),(verde),(rosso)
constant long BLU=65536 * (255) + 256 * (0) + (0) //colore (blu),(verde),(rosso)
constant long BLU_CHIARO=65536 * (255) + 256 * (211) + (168) //colore (blu),(verde),(rosso)
constant long VERDE=65536 * 64 + 256 * (128) + (0) //colore (blu),(verde),(rosso)
constant long GIALLO=65536 * 128 + 256 * (255) + (255) //colore (blu),(verde),(rosso)
constant long OLIVE=65536 * 128 + 256 * (128) + (64) //colore (blu),(verde),(rosso)


////--- in stringa
//constant string XNERO=string(65536 * (0) + 256 * (0) + (0)) //colore (blu),(verde),(rosso)
//constant string XBIANCO=string(65536 * (255) + 256 * (255) + (255)) //colore (blu),(verde),(rosso)
//constant string XGRIGIO=string(65536 * (223) + 256 * (223) + 223) //(192) //colore (blu),(verde),(rosso)
//constant string XROSSO=string(65536 * (0) + 256 * (0) + (255)) //colore (blu),(verde),(rosso)
//constant string XROSSO_CHIARO=string(65536 * (136) + 256 * (136) + (255)) //colore (blu),(verde),(rosso)
//constant string XGRANATA=string(65536 * (62) + 256 * (0) + (132)) //colore (blu),(verde),(rosso)
//constant string XERR_DATO=string(65536 * (217) + 256 * (217) + (255)) //colore (blu),(verde),(rosso)
//constant string XBLU_SCURO=string(65536 * (113) + 256 * (0) + (0)) //colore (blu),(verde),(rosso)
//constant string XBLU=string(65536 * (255) + 256 * (0) + (0)) //colore (blu),(verde),(rosso)
//constant string XBLU_CHIARO=string(65536 * (255) + 256 * (211) + (168)) //colore (blu),(verde),(rosso)
//constant string XVERDE=string(65536 * 64 + 256 * (128) + (0) )//colore (blu),(verde),(rosso)
//constant string XGIALLO=string(65536 * 128 + 255 * (128) + (255)) //colore (blu),(verde),(rosso)


constant string REC_UPDx =string(65536 * (230) + 256 * (230) + (255)) //colore (blu),(verde),(rosso)
constant string CAMPO_DISATTIVO=string(65536 * (223) + 256 * (223) + 223) //colore (blu),(verde),(rosso)

end variables

on kkg_colore.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kkg_colore.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

