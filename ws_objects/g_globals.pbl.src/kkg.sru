$PBExportHeader$kkg.sru
$PBExportComments$generiche o obsolete
forward
global type kkg from nonvisualobject
end type
end forward

global type kkg from nonvisualobject
end type
global kkg kkg

type variables
public:

//--- Versione Procedura
constant double VERSIONE=19.0924

//--- icone risorse grafiche
constant string PATH_SEP ="\" 

//--- icone risorse grafiche
constant string risorsa_elenco = "\folder.gif" 

// Costanti generiche 
constant string ADATTA_WIN="s" //flag se adattare le win al risoluz.vidio (s=si)
constant string ADATTA_WIN_NO="n" //flag se adattare le win al risoluz.vidio (n=no)
constant string ADATTA_WIN_MAX="m" //flag window a MAXIMIZE!
constant string key_funzione_aggiorna = "F11"
constant pointer POINTER_DEFAULT = Arrow!
constant pointer POINTER_ATTESA = HourGlass!

//--- data a zero
constant date DATA_ZERO=date(0) //data a zero
constant date DATA_NO=date(1990, 01, 01) //data praticamente da considerare nulla
constant date DATA_START_E1=date(2016,10,03) //data di partenza di E1
constant time TIME_ZERO=time(0)
//datetime DATETIME_ZERO=datetime(date(0)) //datetime(date(0)) 

//--- 'sicurezza' vive solo x mantenere la compatibilita' con il passato
constant int PWD_MAX=1 // privilegio massimo
constant int PWD_LIV_2=2  // privilegio da operatore massimo
constant int PWD_LIV_3=3  // privilegio magazzino con PL
constant int PWD_LIV_4=4  // privilegio magazzino entrate-uscite
constant int PWD_QUERY=5  //privilegio operat consultativo

//--- caratteri particolari
constant string ACAPO="~n~r"

//--- Icona principale
constant string MAIN_ICON = "main.ico"



end variables
on kkg.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kkg.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

