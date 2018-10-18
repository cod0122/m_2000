$PBExportHeader$kuf_meca_set_e1srst.sru
forward
global type kuf_meca_set_e1srst from kuf_parent
end type
end forward

global type kuf_meca_set_e1srst from kuf_parent
end type
global kuf_meca_set_e1srst kuf_meca_set_e1srst

type variables
//
kuf_armo kiuf_armo
end variables

forward prototypes
public function long u_set_stato_lotto_da_e1 () throws uo_exception
public function st_esito u_batch_run () throws uo_exception
end prototypes

public function long u_set_stato_lotto_da_e1 () throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------
//--- Importa STATO lotto da E1 (lotti APERTI e con lo stato non a 95)
//--- 
//--- Input: 
//--- out: 
//--- Rit: numero lotti aggiornati con un valore > di spazio
//--- Lancia EXCEPTION se errori gravi 
//--- 
//--------------------------------------------------------------------------------------------------------------
long k_return
long k_riga, k_righe, k_righe_daelab, k_riga300, k_riga_ds, k_rc, k_riga_tab
datetime k_datetime
datastore kds_1
kuf_e1_asn kuf1_e1_asn
kuf_armo kuf1_armo
st_tab_e1_asn kst_tab_e1_asn[], kst_tab_e1_asn_vuoto[]
st_tab_meca kst_tab_meca
st_esito kst_esito


//setpointer()

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try
	
	kds_1 = create datastore
	kds_1.dataobject = "ds_meca_aperti_nostato95"
	kds_1.settransobject( kguo_sqlca_db_magazzino )
	k_righe = kds_1.retrieve() // estrazione ID lotti x aggiornare lo STATO
	
	kuf1_e1_asn = create kuf_e1_asn
	kuf1_armo = create kuf_armo

	for k_riga = 1 to k_righe
		
//--- Aggiorna non più di 300 righe alla volta...		
		if (k_righe - k_riga) < 300 then
			k_righe_daelab = k_righe - k_riga
		else
			k_righe_daelab = 300 - 1
		end if
		k_riga300 = k_riga + k_righe_daelab 
		
		k_riga_tab = 0
		kst_tab_e1_asn[] = kst_tab_e1_asn_vuoto[]
		
		for k_riga_ds = k_riga to k_riga300
			k_riga_tab ++
			kst_tab_e1_asn[k_riga_tab].wammcu = kkg.E1MCU
//--- Prepara l'array per get dello STATO del ASN da E1
			kst_tab_e1_asn[k_riga_tab].waapid = string(kds_1.getitemnumber( k_riga_ds, "id"))
		next
//--- Get dello STATO del ASN su E1
		kuf1_e1_asn.u_get_stato(kst_tab_e1_asn[])
		
//--- Imposta lo STATO del ASN
		k_riga_tab = 0
		for k_riga_ds = k_riga to k_riga300
			k_riga_tab ++
			if kst_tab_e1_asn[k_riga_tab].wasrst > " " then
				if trim(kds_1.getitemstring( k_riga_ds, "e1srst")) <> trim(kst_tab_e1_asn[k_riga_tab].wasrst) then
					k_return ++
					kds_1.setitem(k_riga_ds, "e1srst", kst_tab_e1_asn[k_riga_tab].wasrst)
					kds_1.setitem(k_riga_ds, "x_datins", kGuf_data_base.prendi_x_datins())
					kds_1.setitem(k_riga_ds, "x_utente", kGuf_data_base.prendi_x_utente())
					
//--- se ASN annullato allora ANNULLA anche il Lotto					
					if kst_tab_e1_asn[k_riga_tab].wasrst = kuf1_e1_asn.kki_status_canceled then
						if isnumber(kst_tab_e1_asn[k_riga_tab].waapid) then
							kst_tab_meca.id = long(kst_tab_e1_asn[k_riga_tab].waapid)
							kuf1_armo.set_lotto_annullato_no_sr(kst_tab_meca)
							kst_tab_meca.meca_blk_descrizione = kuf1_armo.get_meca_blk_descrizione(kst_tab_meca)
							kst_tab_meca.meca_blk_descrizione = "Annullato in automatico il " + string(kGuf_data_base.prendi_x_datins(), "dd.mmm.yy hh:mm") &
							                             + " durante l'importazione 'stato' da E1." + kst_tab_meca.meca_blk_descrizione
							kuf1_armo.set_meca_blk_descrizione(kst_tab_meca)
						end if
					end if
					
				end if
			else
				kds_1.setitem(k_riga_ds, "e1srst", " ")
			end if
		next
		
		k_rc = kds_1.update( )  // AGGIORNA STATO!!
		if k_rc > 0 then
			kguo_sqlca_db_magazzino.db_commit( )
		else
			kst_esito.sqlcode = k_return
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.SQLErrText = "Errore in aggiornamento 'Stato' Lotto da E1. Il primo ID era " + string(kds_1.getitemnumber(k_riga, "id")) &
			                       + "~r~nErrore: " + trim(kst_esito.nome_oggetto) + ") "
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
		k_riga = k_riga_ds - 1
	next
	
	
catch (uo_exception kuo_exception) 
	throw kuo_exception
	
finally
	if isvalid(kds_1) then destroy kds_1
	if isvalid(kuf1_e1_asn) then destroy kuf1_e1_asn
	if isvalid(kuf1_armo) then destroy kuf1_armo

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

//--- Imposta STATO Lotto di E1 su MECA
	k_ctr = u_set_stato_lotto_da_e1( )
	if k_ctr > 0 then
		kst_esito.SQLErrText = "Operazione conclusa correttamente." &
									+ "Sono stati aggiornati " + string(k_ctr) + " STATI Lotto di E1 (wasrst). Dati ottenuti dal Sistema E-ONE" 
	else
		kst_esito.SQLErrText = "Operazione conclusa. Nessun nuovo STATO Lotto E1  (wasrst) importato da E-ONE."
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try


return kst_esito
end function

on kuf_meca_set_e1srst.create
call super::create
end on

on kuf_meca_set_e1srst.destroy
call super::destroy
end on

event constructor;call super::constructor;//
kiuf_armo = create kuf_armo

end event

event destructor;call super::destructor;//
if isvalid(kiuf_armo) then destroy kiuf_armo

end event

