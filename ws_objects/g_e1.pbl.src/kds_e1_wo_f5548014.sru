$PBExportHeader$kds_e1_wo_f5548014.sru
forward
global type kds_e1_wo_f5548014 from uo_datastore_0
end type
end forward

global type kds_e1_wo_f5548014 from uo_datastore_0
string dataobject = "ds_e1_wo_f5548014_l"
end type
global kds_e1_wo_f5548014 kds_e1_wo_f5548014

forward prototypes
public function integer u_update () throws uo_exception
end prototypes

public function integer u_update () throws uo_exception;//-------------------------------------------------------------------------------
//--- Registra su tab i dati di lavorazione da inviare a E1
//--- 
//--- datastore con i dati da registrare in tabella
//--- 
//--- Rit: come UPDATE (-1 = ERRORE GRAVE)
//--- lancia exception x errore grave
//-------------------------------------------------------------------------------
int k_return = 0
long k_righe, k_riga


try
//	this.db_connetti( )
	this.settransobject(kguo_sqlca_db_magazzino)
	k_righe = this.rowcount( )
	for k_riga = 1 to k_righe
		this.setitem(k_riga, "osuser", kguo_utente.get_codice( ))
		this.setitem(k_riga, "x_datins", kGuf_data_base.prendi_x_datins())
		this.setitem(k_riga, "x_utente", kGuf_data_base.prendi_x_utente())
		//this.setitem(k_riga, "osmcu", kguo_g.E1MCU)							 // codice 270 = MINERBIO
		
	next
	
	k_return = update( )
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

return k_return

end function

on kds_e1_wo_f5548014.create
call super::create
end on

on kds_e1_wo_f5548014.destroy
call super::destroy
end on

