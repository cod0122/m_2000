$PBExportHeader$kds_e1_asn_ricevuti_l.sru
forward
global type kds_e1_asn_ricevuti_l from kds_e1_asn
end type
end forward

global type kds_e1_asn_ricevuti_l from kds_e1_asn
string dataobject = "ds_e1_asn_ricevuti_l"
end type
global kds_e1_asn_ricevuti_l kds_e1_asn_ricevuti_l

forward prototypes
public function long u_if_received (st_tab_e1_asn ast_tab_e1_asn) throws uo_exception
public function long u_get_received (st_tab_e1_asn ast_tab_e1_asn) throws uo_exception
public function boolean u_get_date_received (ref st_tab_e1_asn ast_tab_e1_asn) throws uo_exception
end prototypes

public function long u_if_received (st_tab_e1_asn ast_tab_e1_asn) throws uo_exception;//-------------------------------------------------------------------------------
//--- Verifica se WO o SO è nel datastore
//--- Inpu: st_tab_e1_asn:  wadoco /  warorn
//--- Out:
//--- Rit: riga del datastore se trovato che il WO è stato caricato a magazzino
//--- lancia exception x errore grave
//-------------------------------------------------------------------------------
long k_return 


try
	if ast_tab_e1_asn.wadoco > 0 then 
 		k_return = this.find("wadoco = " + string(ast_tab_e1_asn.wadoco) + " ", 1, this.rowcount( ))  // prima cerca il Work Order
	end if
	
	if k_return > 0  then
	else
		if isnumber(trim(ast_tab_e1_asn.warorn)) and trim(ast_tab_e1_asn.warorn) <> "0" then 
			k_return = this.find("sddoco = " + trim(ast_tab_e1_asn.warorn) + " ", 1, this.rowcount( ))  // ora cerca il Sales Order
			if k_return > 0  then
			else
				k_return = 0
			end if
		end if
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

return k_return

end function

public function long u_get_received (st_tab_e1_asn ast_tab_e1_asn) throws uo_exception;//-------------------------------------------------------------------------------
//--- Torna i Lotti Ricevuti a magazzino (stato > 05 and <95) con la data
//--- Inpu: ast_tab_e1_asn wammcu (=270)  wadoco (se zero tutti)
//--- Out:
//--- Rit: come retrieve
//--- lancia exception x errore grave
//-------------------------------------------------------------------------------
long k_return = 0


try
	this.db_connetti( )

	if isnull(ast_tab_e1_asn.wadoco) then ast_tab_e1_asn.wadoco = 0
	k_return = this.retrieve(ast_tab_e1_asn.wammcu, ast_tab_e1_asn.wadoco)

catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

return k_return

end function

public function boolean u_get_date_received (ref st_tab_e1_asn ast_tab_e1_asn) throws uo_exception;//-------------------------------------------------------------------------------
//--- Get della data di Carico del magazzino
//---    ricerca ottimizzata, fatta su un elenco riempito solo la prima volta
//--- Inp: st_tab_e1_asn: wamcu, wadoco, warorn
//--- Out: IRDSE = data di carico in formato juliano 1+anno+nr gg dell'anno 
//---      IRWWAST = ora di carico es. 131520  
//--- Rit: FALSE = non ancora caricato in magazzino
//--- lancia exception x errore grave
//-------------------------------------------------------------------------------
boolean k_return = false
long k_riga
st_tab_e1_asn kst_tab_e1_asn


try
	if this.rowcount( ) > 0 then
	else
		kst_tab_e1_asn.wammcu = ast_tab_e1_asn.wammcu
		kst_tab_e1_asn.wadoco = 0
		u_get_received(kst_tab_e1_asn)  // leggo tutto
	end if
	if this.rowcount( ) > 0 then
		k_riga = u_if_received(ast_tab_e1_asn)	
		if k_riga > 0 then
			ast_tab_e1_asn.IRDSE = this.getitemnumber(k_riga, "irdse")
			ast_tab_e1_asn.IRWWAST = this.getitemnumber(k_riga, "irwwast")
			if ast_tab_e1_asn.IRDSE > 0 then
				k_return = true
			end if
		end if
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

return k_return

end function

on kds_e1_asn_ricevuti_l.create
call super::create
end on

on kds_e1_asn_ricevuti_l.destroy
call super::destroy
end on

