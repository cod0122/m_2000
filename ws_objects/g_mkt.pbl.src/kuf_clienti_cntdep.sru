$PBExportHeader$kuf_clienti_cntdep.sru
forward
global type kuf_clienti_cntdep from kuf_parent
end type
end forward

global type kuf_clienti_cntdep from kuf_parent
end type
global kuf_clienti_cntdep kuf_clienti_cntdep

type variables
//
private kuf_clienti kiuf_clienti
private string ki_path_export
private datastore kids_clienti_cntdep_l_xbcode 
private datastore kids_clienti_cntdep_l_xpklist
private string ki_datetimex

end variables

forward prototypes
public subroutine _readme ()
public function st_esito u_batch_run () throws uo_exception
private function string u_esporta_dati_aco (long k_id_cliente) throws uo_exception
private function long u_elabora_ds_exp_regcdp (long k_id_cliente) throws uo_exception
private function long u_elabora_ds_exp (ref datastore ads_ds_clienti_cntdep_cfg_xupd) throws uo_exception
private function long u_elabora_ds_exp_regcdp_xpklist (long k_id_cliente) throws uo_exception
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
public function st_esito anteprima (ref datastore kds_anteprima, st_tab_clienti_cntdep_cfg kst_tab_clienti_cntdep_cfg)
end prototypes

public subroutine _readme ();//
//--- Dati Registro Conto Deposito per ACO
//
end subroutine

public function st_esito u_batch_run () throws uo_exception;//---
//--- Lancio operazioni Batch
//---
string k_string
st_esito kst_esito


try 

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "" 
	kst_esito.nome_oggetto = this.classname()

	k_string = u_esporta_dati_aco(0) 
	if len(trim(k_string)) > 0 then
		kst_esito.SQLErrText = "Operazione conclusa. " + k_string 
	else
		kst_esito.SQLErrText = "Operazione non eseguita. Nessun Dato esportato."
	end if

catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	throw kuo_exception
	
finally
	
end try


return kst_esito
end function

private function string u_esporta_dati_aco (long k_id_cliente) throws uo_exception;//---
//--- Esporta dati Registro Conto Deposito ACO
//---
// 
long k_righe=0, k_rc
string k_file, k_return
datastore kds_ds_clienti_cntdep_cfg_xupd 
st_esito kst_esito


	try 

		kst_esito.esito = kkg_esito.ok  
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = ""
		kst_esito.nome_oggetto = this.classname()

		if not isvalid(kiuf_clienti) then kiuf_clienti = create kuf_clienti
		ki_datetimex = "_" + string(kguo_g.get_datetime_current( ), "yymmddhhm")

		kds_ds_clienti_cntdep_cfg_xupd = create datastore
		kds_ds_clienti_cntdep_cfg_xupd.dataobject = "ds_clienti_cntdep_cfg_xupd"
		kds_ds_clienti_cntdep_cfg_xupd.settransobject(kguo_sqlca_db_magazzino)

		kds_ds_clienti_cntdep_cfg_xupd.retrieve(k_id_cliente)
		
		k_righe = u_elabora_ds_exp(kds_ds_clienti_cntdep_cfg_xupd)
		
		if k_righe > 0 then

			if kds_ds_clienti_cntdep_cfg_xupd.update() > 0 then
					
				kguo_sqlca_db_magazzino.db_commit( )
					
				k_file = ki_path_export + kkg.path_sep + "ACO_reg_contodeposito_cfg" + ki_datetimex + ".pdf"
				if kds_ds_clienti_cntdep_cfg_xupd.saveas(k_file, PDF!, true, EncodingUTF8!) > 0 then
				end if
					
			else
				
				kst_esito.esito = kkg_esito_db_ko
				kst_esito.sqlerrtext = "Errore in aggiornamento dati Cliente: contatori Registro Conto Deposito non aggiornati, procedere manualmente."
				kst_esito.sqlcode = -1
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
					
			end if
				
		end if
			

	catch (uo_exception kuo_exception)
		throw kuo_exception
		
	finally
		if k_righe > 0 then
			k_return = "Dati Registro esportati nella cartella " + ki_path_export + ". Prodotto il file di riepilogo " + k_file + " di " + string(k_righe)
		else
			k_return = "Prodotto il file " + k_file + " vuoto! "
		end if
		
		if isvalid(kds_ds_clienti_cntdep_cfg_xupd) then destroy kds_ds_clienti_cntdep_cfg_xupd
		
	end try
	
return k_return
end function

private function long u_elabora_ds_exp_regcdp (long k_id_cliente) throws uo_exception;//----------------------------------------------------------------------------------------------------------
//--- Elabora i dati da esportare per: impostare ornumvia = numero Registro del Conto Deposito per cliente
//---						e torna il nr righe trattate
//---
//--- inp: id  cliente del Registro da esportare
//--- out: nr righe trattate
//---
//----------------------------------------------------------------------------------------------------------
long k_ornumvia_progr, k_row_max, k_row
int k_ornumvia_x_len, k_rc
string k_orrifdes_packinglist, k_ornumvia_x, k_file


try

	k_row_max = kids_clienti_cntdep_l_xbcode.retrieve(k_id_cliente)
	
	if k_row_max > 0 then
		k_ornumvia_x = kids_clienti_cntdep_l_xbcode.getitemstring(1, "ornumvia")
		k_ornumvia_x_len = len(k_ornumvia_x)
		k_ornumvia_progr = long(left(k_ornumvia_x, k_ornumvia_x_len - 1))

		for k_row = 1 to k_row_max
			
			if k_orrifdes_packinglist <> kids_clienti_cntdep_l_xbcode.getitemstring(k_row, "orrifdes") then
				k_orrifdes_packinglist = kids_clienti_cntdep_l_xbcode.getitemstring(k_row, "orrifdes")
				k_ornumvia_progr ++
			end if
			k_rc = kids_clienti_cntdep_l_xbcode.setitem(k_row, "ornumvia", string(k_ornumvia_progr, "#")+"|")
			if k_rc < 0 then
				kguo_exception.inizializza( )
				kguo_exception.kist_esito.esito = kkg_esito.ko
				kguo_exception.kist_esito.nome_oggetto = this.classname()
				kguo_exception.kist_esito.sqlerrtext = "Esportazione dati Registro Conto Deposito in errore su operazione di aggiornamento numero Registro sul file"
				throw kguo_exception
			end if
		next
		if k_row_max > 0 then
			k_file = ki_path_export + kkg.path_sep + "ACO_reg_contodeposito" + ki_datetimex + "_" + string(k_id_cliente, "#") + ".car"
			if kids_clienti_cntdep_l_xbcode.saveas(k_file, text!, false, EncodingUTF8!) < 0 then
				kguo_exception.inizializza( )
				kguo_exception.kist_esito.esito = kkg_esito.ko
				kguo_exception.kist_esito.nome_oggetto = this.classname()
				kguo_exception.kist_esito.sqlerrtext = "Esportazione dati Registro Conto Deposito in errore su operazione generazione del file: " + k_file
				throw kguo_exception
			end if
		end if
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	
end try

return k_row_max
end function

private function long u_elabora_ds_exp (ref datastore ads_ds_clienti_cntdep_cfg_xupd) throws uo_exception;//----------------------------------------------------------------------------------------------------------
//--- Elabora i dati da esportare per: impostare ornumvia = numero Registro del Conto Deposito per cliente
//---						e torna il ds per aggiornare i parametri dei dati da esportare
//---
//--- inp: id il datastore ads_ds_clienti_cntdep_cfg_xupd con i dati del CLIENTE x il Registro da esportare
//--- out: nr righe trattate
//---
//----------------------------------------------------------------------------------------------------------
st_tab_clienti_cntdep_cfg kst_tab_clienti_cntdep_cfg 
long k_ornumvia_progr, k_row_max, k_row, k_row_xupd
int k_idpkl_len, k_ornumvia_x_len, k_rc
string k_orrifdes_packinglist, k_ornumvia_x, k_idpkl
st_tab_meca kst_tab_meca
st_tab_wm_pklist kst_tab_wm_pklist
kuf_armo kuf1_armo
kuf_wm_pklist kuf1_wm_pklist


try
	kuf1_armo = create kuf_armo
	kuf1_wm_pklist = create kuf_wm_pklist

	k_row_max = ads_ds_clienti_cntdep_cfg_xupd.rowcount( )
	
	for k_row_xupd = 1 to k_row_max
		
		kst_tab_meca.clie_3 = ads_ds_clienti_cntdep_cfg_xupd.getitemnumber(k_row_xupd, "id_cliente")
	
		k_row = u_elabora_ds_exp_regcdp(kst_tab_meca.clie_3)
		if k_row > 0 then
			k_ornumvia_x = kids_clienti_cntdep_l_xbcode.getitemstring(k_row, "ornumvia") //numero registro
			k_idpkl = trim(kids_clienti_cntdep_l_xbcode.getitemstring(k_row, "orrifdes")) //pakinglistcode
		else
			k_row = u_elabora_ds_exp_regcdp_xpklist(kst_tab_meca.clie_3)
			if k_row > 0 then
				k_ornumvia_x = kids_clienti_cntdep_l_xpklist.getitemstring(k_row, "ornumvia") //numero registro
				k_idpkl = trim(kids_clienti_cntdep_l_xpklist.getitemstring(k_row, "orrifdes")) //pakinglistcode
			end if
		end if

		if k_row > 0 then
//--- preleva i dati di ritorno dal ds da registrare in tab
			k_ornumvia_x_len = len(k_ornumvia_x)
			k_ornumvia_progr = long(left(k_ornumvia_x, k_ornumvia_x_len - 1))
			k_idpkl_len = len(k_idpkl)
			kst_tab_wm_pklist.idpkl = trim(left(k_idpkl, k_idpkl_len - 1))
			kst_tab_meca.id_wm_pklist = kuf1_wm_pklist.get_id_wm_pklist_da_idpkl(kst_tab_wm_pklist)
			kuf1_armo.get_id_da_id_wm_pklist(kst_tab_meca)
	//		k_row_xupd = ads_ds_clienti_cntdep_cfg_xupd.insertrow(0)
			ads_ds_clienti_cntdep_cfg_xupd.setitem(k_row_xupd, "registro_nr_ultimo", k_ornumvia_progr)
			ads_ds_clienti_cntdep_cfg_xupd.setitem(k_row_xupd, "id_meca_ultimo", kst_tab_meca.id)
			ads_ds_clienti_cntdep_cfg_xupd.setitem(k_row_xupd, "x_datins", kguf_data_base.prendi_x_datins( ) )
			ads_ds_clienti_cntdep_cfg_xupd.setitem(k_row_xupd, "x_utente", kguf_data_base.prendi_x_utente( ) )
	//		ads_ds_clienti_cntdep_cfg_xupd.setitemstatus(k_row_xupd, 0, primary!, DataModified!)
		end if
		
	next
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kuf1_armo) then destroy kuf1_armo
	if isvalid(kuf1_wm_pklist) then destroy kuf1_wm_pklist
	
	
end try

return k_row_max
end function

private function long u_elabora_ds_exp_regcdp_xpklist (long k_id_cliente) throws uo_exception;//----------------------------------------------------------------------------------------------------------
//--- Elabora i dati da esportare per: impostare ornumvia = numero Registro del Conto Deposito per cliente
//---						e torna il nr righe trattate
//---
//--- inp: id  cliente del Registro da esportare
//--- out: nr righe trattate
//---
//----------------------------------------------------------------------------------------------------------
long k_ornumvia_progr, k_row_max, k_row
int k_ornumvia_x_len, k_rc
string k_orrifdes_packinglist, k_ornumvia_x, k_file


try

	k_row_max = kids_clienti_cntdep_l_xpklist.retrieve(k_id_cliente)
	
	if k_row_max > 0 then
		k_ornumvia_x = kids_clienti_cntdep_l_xpklist.getitemstring(1, "ornumvia")
		k_ornumvia_x_len = len(k_ornumvia_x)
		k_ornumvia_progr = long(left(k_ornumvia_x, k_ornumvia_x_len - 1))
	
		for k_row = 1 to k_row_max
			
			if k_orrifdes_packinglist <> kids_clienti_cntdep_l_xpklist.getitemstring(k_row, "orrifdes") then
				k_orrifdes_packinglist = kids_clienti_cntdep_l_xpklist.getitemstring(k_row, "orrifdes")
				k_ornumvia_progr ++
			end if
			k_rc = kids_clienti_cntdep_l_xpklist.setitem(k_row, "ornumvia", string(k_ornumvia_progr, "#")+"|")
			if k_rc < 0 then
				kguo_exception.inizializza( )
				kguo_exception.kist_esito.esito = kkg_esito.ko
				kguo_exception.kist_esito.nome_oggetto = this.classname()
				kguo_exception.kist_esito.sqlerrtext = "Esportazione dati Registro Conto Deposito (per Part Number) in errore su operazione di aggiornamento numero Registro sul file"
				throw kguo_exception
			end if
		next
		if k_row_max > 0 then
			k_file = ki_path_export + kkg.path_sep + "ACO_reg_contodeposito" + ki_datetimex + "_" + string(k_id_cliente, "#") + "PN.car"
			if kids_clienti_cntdep_l_xpklist.saveas(k_file, text!, false, EncodingUTF8!) < 0 then
				kguo_exception.inizializza( )
				kguo_exception.kist_esito.esito = kkg_esito.ko
				kguo_exception.kist_esito.nome_oggetto = this.classname()
				kguo_exception.kist_esito.sqlerrtext = "Esportazione dati Registro Conto Deposito (per Part Number) in errore su operazione generazione del file: " + k_file
				throw kguo_exception
			end if
		end if
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	
end try

return k_row_max
end function

public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception;//--------------------------------------------------------------------------------------------------------------
//--- Funzione di ZOOM: attiva LINK cliccato 
//---
//--- Par. Inut: 
//---               datawindow con i dati da visualizzare oppure su cui è stato attivato il LINK
//---               nome campo di LINK 
//--- 
//--- Ritorna TRUE tutto OK - FALSE: link non effettuato
//---
//--- Lancia EXCEPTION con  ST_ESITO  standard
//---
//----------------------------------------------------------------------------------------------------------------
// 
long k_rc
boolean k_return=true
kuf_elenco kuf1_elenco
datastore kdsi_elenco_output  
st_tab_clienti_cntdep_cfg kst_tab_clienti_cntdep_cfg
st_esito kst_esito
st_open_w kst_open_w 


try
	
	SetPointer(kkg.pointer_attesa)

	kdsi_elenco_output = create datastore
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_esito = this.anteprima( kdsi_elenco_output, kst_tab_clienti_cntdep_cfg )
	if kst_esito.esito <> kkg_esito.ok then
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if

	if isvalid(adw_link) then
		adw_link.dataobject = kdsi_elenco_output.dataobject
		kdsi_elenco_output.rowscopy(1,kdsi_elenco_output.rowcount(),Primary!,adw_link,1,Primary!)
	end if

	if kdsi_elenco_output.rowcount() > 0 then
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
		kst_open_w.key1 = "Elenco Anagrafiche in Conto Deposito"
		kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
		kst_open_w.key4 = ""
		kst_open_w.key12_any = kdsi_elenco_output
		kuf1_elenco = create kuf_elenco
		kuf1_elenco.u_open(kst_open_w)
	else
		kguo_exception.inizializza( )
		kguo_exception.setmessage(u_get_errmsg_nontrovato(kst_open_w.flag_modalita) )
		throw kguo_exception
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kuf1_elenco) then destroy kuf1_elenco
	SetPointer(kkg.pointer_default)

end try


return k_return

end function

public function st_esito anteprima (ref datastore kds_anteprima, st_tab_clienti_cntdep_cfg kst_tab_clienti_cntdep_cfg);//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datawindow su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Grave
//===                                     2=Errore gestito
//===                                     3=altro errore
//===                                     100=Non trovato 
//=== 
//====================================================================
// 
long k_rc
boolean k_return
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = kkg_id_programma_anag

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if isvalid(kds_anteprima)  then
		if kds_anteprima.dataobject = "" or kds_anteprima.dataobject = "d_nulla" then
			kds_anteprima.dataobject = "d_clienti_l_aco"		
		end if
	end if


	kds_anteprima.settransobject(sqlca)

	kds_anteprima.reset()	
//--- retrive dell'attestato 
	k_rc=kds_anteprima.retrieve("%")

end if


return kst_esito

end function

on kuf_clienti_cntdep.create
call super::create
end on

on kuf_clienti_cntdep.destroy
call super::destroy
end on

event destructor;//
	if isvalid(kiuf_clienti) then destroy kiuf_clienti 
	
	if isvalid(kids_clienti_cntdep_l_xbcode) then destroy kids_clienti_cntdep_l_xbcode 
	if isvalid(kids_clienti_cntdep_l_xpklist) then destroy kids_clienti_cntdep_l_xpklist 
	
end event

event constructor;//
kuf_base kuf1_base
string k_esito=""


	kuf1_base = create kuf_base
	k_esito = kuf1_base.prendi_dato_base("aco_exp_regcdp_dir")
	if left(k_esito,1) = "0" then
		if trim(mid(k_esito,2)) > " " then
			ki_path_export = trim(mid(k_esito,2))
		else
			ki_path_export = kguo_path.get_base( )
			kguo_exception.kist_esito.nome_oggetto = this.classname()
			kguo_exception.kist_esito.esito = kkg_esito.not_fnd 
			kguo_exception.kist_esito.sqlcode = 0
			kguo_exception.kist_esito.SQLErrText = "Manca la cartella di esportazione dati 'Registro Conto Deposito' per ACO in Proprietà della Procedura: ora esporta in " + ki_path_export
			kguo_exception.scrivi_log( )
		end if
	else
		ki_path_export = kguo_path.get_base( )
		kguo_exception.kist_esito.nome_oggetto = this.classname()
		kguo_exception.kist_esito.esito = kkg_esito.db_ko 
		kguo_exception.kist_esito.sqlcode = 0
		kguo_exception.kist_esito.SQLErrText = "Errore di accesso al DB, per leggere la cartella di esportazione dati 'Registro Conto Deposito' per ACO in Proprietà della Procedura: ora esporta in " + ki_path_export
		kguo_exception.scrivi_log( )
	end if
	destroy kuf1_base


	kids_clienti_cntdep_l_xbcode = create datastore
	kids_clienti_cntdep_l_xbcode.dataobject = "ds_clienti_cntdep_l_xbcode"
	kids_clienti_cntdep_l_xbcode.settransobject(kguo_sqlca_db_magazzino) 
	
	kids_clienti_cntdep_l_xpklist = create datastore
	kids_clienti_cntdep_l_xpklist.dataobject = "ds_clienti_cntdep_l_xpklist"
	kids_clienti_cntdep_l_xpklist.settransobject(kguo_sqlca_db_magazzino) 
	
end event

