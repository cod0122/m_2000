$PBExportHeader$kuf_clicicli.sru
forward
global type kuf_clicicli from nonvisualobject
end type
end forward

global type kuf_clicicli from nonvisualobject
end type
global kuf_clicicli kuf_clicicli

forward prototypes
public function string tb_delete (long k_codice)
end prototypes

public function string tb_delete (long k_codice);//
//====================================================================
//=== Cancella il rek dalla tabella CLICICLI 
//=== 
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//====================================================================

string k_return = "0 "
long k_num
date k_data

	
	delete from clicicli
			where codice = :k_codice ;

	if sqlca.sqlCode <> 0 then

		k_return = "1" + SQLCA.SQLErrText

	end if


return k_return
end function

on kuf_clicicli.create
TriggerEvent( this, "constructor" )
end on

on kuf_clicicli.destroy
TriggerEvent( this, "destructor" )
end on

