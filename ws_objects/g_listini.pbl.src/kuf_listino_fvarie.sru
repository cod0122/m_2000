$PBExportHeader$kuf_listino_fvarie.sru
forward
global type kuf_listino_fvarie from nonvisualobject
end type
end forward

global type kuf_listino_fvarie from nonvisualobject
end type
global kuf_listino_fvarie kuf_listino_fvarie

forward prototypes
public function boolean if_voce_a_listino (long aid_listino_voce) throws uo_exception
public function boolean if_pregruppo_a_listino (long aid_listino_pregruppo) throws uo_exception
end prototypes

public function boolean if_voce_a_listino (long aid_listino_voce) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Controllo se la ID_LISTINO_VOCE è già presente su Listino
//--- 
//--- Inp:  long id_listino_voce
//--- Ritorna: TRUE = voce utilizzata a Listini; FALSE=voce non presente a Listino   
//---   
//--------------------------------------------------------------------------------------------------------------------------------------------------------

boolean k_return = false
long k_num
st_esito kst_esito
//datastore kds_1
st_tab_listino_pregruppo kst_tab_listino_pregruppo[]
st_tab_listino_pregruppi_voci kst_tab_listino_pregruppi_voci[]
st_tab_listino_link_pregruppi kst_tab_listino_link_pregruppi[]
kuf_listino_pregruppo kuf1_listino_pregruppo
kuf_listino_pregruppi_voci kuf1_listino_pregruppi_voci
kuf_listino_link_pregruppi kuf1_listino_link_pregruppi


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try
	
	if  aid_listino_voce = 0 or isnull (aid_listino_voce) then
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Voce Listino non elaborata. Manca ID"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
//	kds_1 = create datastore
//	kds_1.dataobject = "d_if_listino_cliente_estinto_no"
//	kds_1.settransobject( kguo_sqlca_db_magazzino )
//	k_if_estinto_no = kds_1.retrieve(kst_tab_listino.id )  
	
	kuf1_listino_pregruppo = create kuf_listino_pregruppo
	kuf1_listino_pregruppi_voci = create kuf_listino_pregruppi_voci
	kuf1_listino_link_pregruppi = create kuf_listino_link_pregruppi

//--- piglia tutti i gruppi collegati alla voce			
	kst_tab_listino_pregruppi_voci[1].id_listino_voce =  aid_listino_voce
	kuf1_listino_pregruppi_voci.get_all_id_listino_pregruppo( kst_tab_listino_pregruppi_voci[] )
	
	for k_num=1 to upperbound(kst_tab_listino_pregruppi_voci)
		if kst_tab_listino_pregruppi_voci[k_num].id_listino_pregruppo > 0 then 
//--- piglia tutti i gruppi collegati al gruppo contenente la voce			
			kst_tab_listino_pregruppo[1].id_listino_pregruppo =  kst_tab_listino_pregruppi_voci[k_num].id_listino_pregruppo
			kuf1_listino_pregruppo.get_all_id_listino_pregruppo( kst_tab_listino_pregruppo[] )
		end if
	next

//--- piglia tutti i Listini collegati al gruppo 		
	for k_num=1 to upperbound(kst_tab_listino_pregruppo)
		if kst_tab_listino_pregruppo[k_num].id_listino_pregruppo > 0 then 
			kst_tab_listino_link_pregruppi[1].id_listino_pregruppo =  kst_tab_listino_pregruppo[k_num].id_listino_pregruppo
			kuf1_listino_link_pregruppi.get_all_id_listino( kst_tab_listino_link_pregruppi[] )
		end if
	next
	
		
//--- Se esiste anche un solo collegamento allora torna TRUE
	if kst_tab_listino_link_pregruppi[1].id_listino > 0 then
		k_return = true
	end if
		

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	

finally
	

end try	


return k_return

end function

public function boolean if_pregruppo_a_listino (long aid_listino_pregruppo) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Controllo se la ID_LISTINO_PREGRUPPO è già presente su Listino
//--- 
//--- Inp:  long id_listino_pregruppo
//--- Ritorna: TRUE = voce utilizzata a Listini; FALSE=voce non presente a Listino   
//---   
//--------------------------------------------------------------------------------------------------------------------------------------------------------

boolean k_return = false
long k_num
st_esito kst_esito
//datastore kds_1
st_tab_listino_pregruppo kst_tab_listino_pregruppo[]
st_tab_listino_link_pregruppi kst_tab_listino_link_pregruppi[]
kuf_listino_pregruppo kuf1_listino_pregruppo
kuf_listino_link_pregruppi kuf1_listino_link_pregruppi


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try
	
	if  aid_listino_pregruppo = 0 or isnull (aid_listino_pregruppo) then
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Rilevazione Gruppo-Voci a Listino non elaborata. Manca ID"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
//	kds_1 = create datastore
//	kds_1.dataobject = "d_if_listino_cliente_estinto_no"
//	kds_1.settransobject( kguo_sqlca_db_magazzino )
//	k_if_estinto_no = kds_1.retrieve(kst_tab_listino.id )  
	
	kuf1_listino_pregruppo = create kuf_listino_pregruppo
	kuf1_listino_link_pregruppi = create kuf_listino_link_pregruppi

	
//--- piglia tutti i gruppi collegati al gruppo 			
	kst_tab_listino_pregruppo[1].id_listino_pregruppo = aid_listino_pregruppo
	kuf1_listino_pregruppo.get_all_id_listino_pregruppo( kst_tab_listino_pregruppo[] )

//--- piglia tutti i Listini collegati al gruppo 		
	for k_num=1 to upperbound(kst_tab_listino_pregruppo)
		if kst_tab_listino_pregruppo[k_num].id_listino_pregruppo > 0 then 
			kst_tab_listino_link_pregruppi[1].id_listino_pregruppo =  kst_tab_listino_pregruppo[k_num].id_listino_pregruppo
			kuf1_listino_link_pregruppi.get_all_id_listino( kst_tab_listino_link_pregruppi[] )
		end if
	next
	
		
//--- Se esiste anche un solo collegamento allora torna TRUE
	if kst_tab_listino_link_pregruppi[1].id_listino > 0 then
		k_return = true
	end if
		

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	

finally
	

end try	


return k_return

end function

on kuf_listino_fvarie.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_listino_fvarie.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

