$PBExportHeader$kds_e1_asn_get_stato.sru
forward
global type kds_e1_asn_get_stato from kds_e1_asn
end type
end forward

global type kds_e1_asn_get_stato from kds_e1_asn
string dataobject = "ds_e1_asn_get_stato"
end type
global kds_e1_asn_get_stato kds_e1_asn_get_stato

type variables
//
public string kk1_wasrst_non_rilevato = "NC" 

end variables

forward prototypes
public function long u_get_stato (ref st_tab_e1_asn ast_tab_e1_asn[]) throws uo_exception
end prototypes

public function long u_get_stato (ref st_tab_e1_asn ast_tab_e1_asn[]) throws uo_exception;//-------------------------------------------------------------------------------
//--- Get campo STATO del ASN (wasrst) per una serie di APID (id_meca formato string)
//--- Inpu: st_tab_e1_asn[]:  waapid + wammcu ('         270')
//--- Out: st_tab_e1_asn[].wasrst
//--- Rit: il numero degli STATI rilavati
//--- lancia exception x errore grave
//-------------------------------------------------------------------------------
long k_return
string k_sql, k_union, k_sql_totale
boolean k_where_in_trovato=false
int k_rc, k_idx, k_idx_max, k_idx_20, k_riga_find, k_riga, k_righe, k_ctr, k_ctr_max
st_tab_e1_asn kst_tab_e1_asn
st_esito kst_esito

try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	this.db_connetti( )
	
	k_idx_max = upperbound(ast_tab_e1_asn)

	for k_idx = 1 to k_idx_max step 999
	
//--- fa le query per blocchi di 1000 valori altrimenti la query va in errore	
		if k_where_in_trovato then 
			k_union = " union all "  // sono a una seconda o più query
		else
			k_union = " "
		end if
	
		k_sql = "select nvl(f4801.wasrst,~'~') as wasrst, nvl(f4801.waapid, ~'~') as waapid " &
				 + " from PRODDTA.F4801_ADT  f4801 " &
  				 + " where f4801.wamcu = ~'" + ast_tab_e1_asn[k_idx].wammcu + "~'"
		if k_idx_max = 1 then  // se solo un APID prova a ottimizzare
			k_sql += " and f4801.waapid = "
		else
         k_sql += " and f4801.waapid in ( "
		end if
		k_where_in_trovato = false
		
//--- ciclo IN con il numero APID da estrarre 		
		if k_idx_max < (k_idx + 999) then  // se il max numero di elementi è meno di 1000 
			k_ctr_max = k_idx_max  // fisso il numero elementi da estrarre uguale al max
		else
			k_ctr_max = k_idx + 999 // fissa il numero elementi da estrarre a 1000 + il punto di start
		end if
		for k_ctr = k_idx to k_ctr_max
			if ast_tab_e1_asn[k_ctr].waapid > " " then
				if not k_where_in_trovato then
					k_where_in_trovato = true
				else
					k_sql += " ,"
				end if
				k_sql += "~'" + ast_tab_e1_asn[k_ctr].waapid + "~'"
			end if
		next
		if	k_where_in_trovato then
			if k_idx_max > 1 then  // se ho solo un APID prova a ottimizzare quindi evita la IN
				k_sql += ")" 
			end if
			k_sql += " group by f4801.wasrst ,f4801.waapid "
			k_sql_totale += k_union + k_sql  // aggiungo eventuale 'union all'
		end if
	next

//--- Eseguo la query totale !!!	
	if k_sql_totale > " " then
		this.Object.DataWindow.Table.Select = k_sql
		this.settransobject(kguo_sqlca_db_e1)
		k_rc = this.retrieve()
	end if

//--- popolo l'array con i valori trovati
	if k_rc > 0 then
		k_righe = this.rowcount( )
		for k_riga = 1 to k_idx_max
			k_riga_find = this.find( "waapid = '" + ast_tab_e1_asn[k_riga].waapid + "'", 1, k_righe)
			if k_riga_find > 0 then
				ast_tab_e1_asn[k_riga].wasrst = this.getitemstring(k_riga_find, "wasrst")
				k_return ++
			else
				ast_tab_e1_asn[k_riga].wasrst = kk1_wasrst_non_rilevato
			end if
		next
	else
		if k_rc = 0 then
			for k_riga = 1 to k_idx_max
				ast_tab_e1_asn[k_riga].wasrst = kk1_wasrst_non_rilevato
			next
		else
			k_return = k_rc
			kguo_exception.inizializza()
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = k_rc
			kst_esito.SQLErrText = "Errore in lettura STATO dalla tabella ASN di E1 per il numero APID: il primo è " + trim(ast_tab_e1_asn[1].waapid) &
					 + " ,l'ultimo=" + string(k_idx_max) + " è " + ast_tab_e1_asn[k_idx_max].waapid 
					 
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

return k_return

end function

on kds_e1_asn_get_stato.create
call super::create
end on

on kds_e1_asn_get_stato.destroy
call super::destroy
end on

