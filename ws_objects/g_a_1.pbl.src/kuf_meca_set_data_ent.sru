$PBExportHeader$kuf_meca_set_data_ent.sru
forward
global type kuf_meca_set_data_ent from kuf_parent
end type
end forward

global type kuf_meca_set_data_ent from kuf_parent
end type
global kuf_meca_set_data_ent kuf_meca_set_data_ent

type variables
//
kuf_armo kiuf_armo
end variables

forward prototypes
public function long u_set_data_ent () throws uo_exception
public function long u_set_data_ent_lotto (ref st_tab_meca ast_tab_meca) throws uo_exception
public function st_esito u_batch_run () throws uo_exception
public function string u_set_consegna_data_ora (st_tab_meca kst_tab_meca) throws uo_exception
end prototypes

public function long u_set_data_ent () throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------
//--- Importa data di entrata merce da E1 e la registra sull'archivio Lotti MECA
//--- 
//--- Input: 
//--- out: 
//--- Rit: numero righe aggiornate su MECA 
//--- Lancia EXCEPTION se errori gravi 
//--- 
//--------------------------------------------------------------------------------------------------------------
long k_return=0
long k_riga, k_righe
datetime k_datetime
datastore kds_1
kuf_e1_asn kuf1_e1_asn
st_tab_e1_asn kst_tab_e1_asn
st_tab_meca kst_tab_meca
st_esito kst_esito


//setpointer()

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try
	kds_1 = create datastore
	kds_1.dataobject = "ds_meca_senza_data_ent"
	kds_1.settrans(kguo_sqlca_db_magazzino)
	k_datetime = datetime(date(0),time(0))
	k_righe = kds_1.retrieve(k_datetime)     // estrae tutti i Lotti aperti senza data di entrata

	kuf1_e1_asn = create kuf_e1_asn

	for k_riga = 1 to k_righe

		kst_tab_e1_asn.wadoco = kds_1.getitemnumber( k_riga, "e1doco")
		kst_tab_e1_asn.warorn = string(kds_1.getitemnumber( k_riga, "e1rorn"))
		if kst_tab_e1_asn.wadoco > 0 or trim(kst_tab_e1_asn.warorn) > " " then
			kst_tab_meca.data_ent = kuf1_e1_asn.u_get_date_received(kst_tab_e1_asn)	
			if kst_tab_meca.data_ent > datetime(kkg.data_zero, time(0)) then
				kst_tab_meca.id = kds_1.getitemnumber( k_riga, "id")
				kst_tab_meca.st_tab_g_0.esegui_commit = "S"
				kiuf_armo.set_data_ent(kst_tab_meca)
				k_return ++

				kst_tab_meca.clie_3 = kds_1.getitemnumber( k_riga, "clie_3")
				u_set_consegna_data_ora(kst_tab_meca)
				
				
			end if
		end if
		
	next
	kguo_sqlca_db_magazzino.db_commit( )

	
catch (uo_exception kuo_exception) 
	k_return = 0
	kguo_sqlca_db_magazzino.db_rollback( )
	throw kuo_exception
	
finally
	if isvalid(kds_1) then destroy kds_1
//	setpointer(kp_originale)

end try

return k_return


end function

public function long u_set_data_ent_lotto (ref st_tab_meca ast_tab_meca) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------
//--- Importa data di entrata merce da E1 per un preciso Lotto e la registra sull'archivio Lotti MECA
//--- 
//--- Input: st_tab_meca.id e1doco e1rorn
//--- out: st_tab_meca.data_ent
//--- Rit: numero righe aggiornate su MECA 
//--- Lancia EXCEPTION se errori gravi 
//--- 
//--------------------------------------------------------------------------------------------------------------
long k_return=0
long k_riga, k_righe
datetime k_datetime
datastore kds_1
kuf_e1_asn kuf1_e1_asn
st_tab_e1_asn kst_tab_e1_asn
st_esito kst_esito


//setpointer()

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try
	if ast_tab_meca.id > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Errore in Importazione data entrata lotto da E1. Manca il ID Lotto"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
		
	kuf1_e1_asn = create kuf_e1_asn

	kst_tab_e1_asn.wadoco = ast_tab_meca.e1doco
	kst_tab_e1_asn.warorn = string(ast_tab_meca.e1rorn)
	if kst_tab_e1_asn.wadoco > 0 or trim(kst_tab_e1_asn.warorn) > " " then
		ast_tab_meca.data_ent = kuf1_e1_asn.u_get_date_received(kst_tab_e1_asn)	
		if ast_tab_meca.data_ent > datetime(kkg.data_zero, time(0)) then
			kiuf_armo.set_data_ent(ast_tab_meca)
			k_return ++
		end if
	end if
	
	if ast_tab_meca.st_tab_g_0.esegui_commit = "N" then
	else
		kguo_sqlca_db_magazzino.db_commit( )
	end if
	
catch (uo_exception kuo_exception) 
	k_return = 0
	if ast_tab_meca.st_tab_g_0.esegui_commit = "N" then
	else
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception
	
finally

end try

return k_return


end function

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

//--- Imposta Data di entrata merce di E1 su MECA
	k_ctr = u_set_data_ent( )
	if k_ctr > 0 then
		kst_esito.SQLErrText = "Operazione conclusa correttamente." &
									+ "Sono state registrate " + string(k_ctr) + " date di entrata Lotto a magazzino. Dati ottenuti dal Sistema E-ONE" 
	else
		kst_esito.SQLErrText = "Operazione conclusa. Nessuna nuova data di entrata Lotto a magazzino importata da E-ONE."
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try


return kst_esito
end function

public function string u_set_consegna_data_ora (st_tab_meca kst_tab_meca) throws uo_exception;//
//--- Calcola la Data e l'ora prevista di Consegna del Materiale
//
string k_msg_warning


k_msg_warning = kiuf_armo.u_get_consegna_tempi(kst_tab_meca)

if trim(k_msg_warning) > " " then
	kguo_exception.inizializza( )
	kguo_exception.setmessage(k_msg_warning)
else
	
	kiuf_armo.set_consegna_data(kst_tab_meca)
	kiuf_armo.set_consegna_ora(kst_tab_meca)
	
end if

return k_msg_warning


end function

on kuf_meca_set_data_ent.create
call super::create
end on

on kuf_meca_set_data_ent.destroy
call super::destroy
end on

event constructor;call super::constructor;//
kiuf_armo = create kuf_armo

end event

event destructor;call super::destructor;//
if isvalid(kiuf_armo) then destroy kiuf_armo

end event

