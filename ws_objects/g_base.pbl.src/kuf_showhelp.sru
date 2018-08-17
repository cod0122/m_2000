$PBExportHeader$kuf_showhelp.sru
forward
global type kuf_showhelp from nonvisualobject
end type
end forward

global type kuf_showhelp from nonvisualobject
end type
global kuf_showhelp kuf_showhelp

type variables
//---
private  string ki_file_help = ""   // vedi il CONSTRUCT

//--- comandi disponibiliù
public constant int kki_cmd_finder = 1   // ripropone l'ultimo stato 
public constant int kki_cmd_indice = 2 // visualizza tutti i 'contents topics'
public constant int kki_cmd_keyword = 3 // va nel "Topic" indicato come stringa
public constant int kki_cmd_topic = 4 // va nel "Topic" indicato come Numero 
end variables

forward prototypes
public function boolean u_showhelp (st_showhelp kst_showhelp)
end prototypes

public function boolean u_showhelp (st_showhelp kst_showhelp);//---
//---	Mostra Help 
//---
//--- Input:  st_showhelp:   id_help  codice x fare help contestuale (x default SPAZIO)
//---								cmd  	comando di comportamento  (VEDI KKI_CMD.* )
//---
boolean k_esito = true
int k_ret=0


	
	choose case kst_showhelp.cmd
			
		case kki_cmd_finder
			k_ret=ShowHelp(ki_file_help, Finder!)

		case kki_cmd_topic
			k_ret=ShowHelp(ki_file_help, Keyword!, kst_showhelp.id_help )
			
		case else
//			k_ret=ShowHelp(ki_file_help, Keyword!, "Funzioni Generali")
			k_ret=ShowHelp(ki_file_help, index!)
			
	end choose



return k_esito

end function

on kuf_showhelp.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_showhelp.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//
ki_file_help = KG_path_help + "\HelpFile.chm"

end event

