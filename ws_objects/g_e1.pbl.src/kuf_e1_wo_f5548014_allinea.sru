$PBExportHeader$kuf_e1_wo_f5548014_allinea.sru
forward
global type kuf_e1_wo_f5548014_allinea from kuf_e1_wo_f5548014
end type
end forward

global type kuf_e1_wo_f5548014_allinea from kuf_e1_wo_f5548014
end type
global kuf_e1_wo_f5548014_allinea kuf_e1_wo_f5548014_allinea

forward prototypes
public function st_esito u_batch_run () throws uo_exception
end prototypes

public function st_esito u_batch_run () throws uo_exception;//---
//--- Lancio operazioni Batch
//---
int k_ctr
st_esito kst_esito


try 

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//--- Allinea dati trattamento/dosimetria con E1
	k_ctr = u_allinea_datilav_e1( )
	if k_ctr > 0 then
		kst_esito.SQLErrText = "Operazione conclusa correttamente." &
							+ "Sono stati ripristinati " + string(k_ctr) + " record dati di 'irraggiamento' inviati in precedenza al Sistema E-ONE" 
	else
		kst_esito.SQLErrText = "Operazione conclusa. Nessun dato di 'irraggiamento' inviato per ripristino a E-ONE."
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try


return kst_esito
end function

on kuf_e1_wo_f5548014_allinea.create
call super::create
end on

on kuf_e1_wo_f5548014_allinea.destroy
call super::destroy
end on

