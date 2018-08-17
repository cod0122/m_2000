$PBExportHeader$kds_meca_x_pilota_queue.sru
forward
global type kds_meca_x_pilota_queue from kds_db_magazzino
end type
end forward

global type kds_meca_x_pilota_queue from kds_db_magazzino
end type
global kds_meca_x_pilota_queue kds_meca_x_pilota_queue

forward prototypes
public function long u_retrieve (st_tab_meca ast_tab_meca[])
end prototypes

public function long u_retrieve (st_tab_meca ast_tab_meca[]);//-------------------------------------------------------------------------------
//--- Torna alcuni campi Lotto
//--- Inpu: st_tab_meca[]:  id_meca
//--- Out: questo datastore
//--- Rit: il numero degli Lotti estratti
//--- lancia exception x errore grave
//-------------------------------------------------------------------------------
long k_return
date k_data_da
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
	
	k_idx_max = upperbound(ast_tab_meca)

	for k_idx = 1 to k_idx_max step 999
	
//--- fa le query per blocchi di 1000 valori altrimenti la query va in errore	
		if k_where_in_trovato then 
			k_union = " union all "  // sono a una seconda o più query
		else
			k_union = " "
		end if
	
		k_sql = "select nvl(meca.consegna_data,~'~') as consegna_data" &
					+ ", nvl(meca.data_int, ~'~') as data_int " &
					+ ", nvl(meca.num_int, 0) as num_int " &
					+ ", nvl(meca.clie_3, 0) as clie_3 " &
					+ ", nvl(clienti.e1an, 0) as e1an " &
					+ ", nvl(clienti.e1codrs, ~'~') as e1codrs " &
				 + " from meca inner join clienti on " &
				 + "  clienti.codice = meca.clie_3 " &
  				 + " where meca.id = " + string(ast_tab_meca[k_idx].id) + " "
		if k_idx_max = 1 then  // se solo un APID prova a ottimizzare
			k_sql += " and meca.id = "
		else
         k_sql += " and meca.id in ( "
		end if
		k_where_in_trovato = false
		
//--- ciclo IN con il numero APID da estrarre 		
		if k_idx_max < (k_idx + 999) then  // se il max numero di elementi è meno di 1000 
			k_ctr_max = k_idx_max  // fisso il numero elementi da estrarre uguale al max
		else
			k_ctr_max = k_idx + 999 // fissa il numero elementi da estrarre a 1000 + il punto di start
		end if
		for k_ctr = k_idx to k_ctr_max
			if ast_tab_meca[k_ctr].id > 0 then
				if not k_where_in_trovato then
					k_where_in_trovato = true
				else
					k_sql += " ,"
				end if
				k_sql += " " + string(ast_tab_meca[k_ctr].id) + " "
			end if
		next
		if	k_where_in_trovato then
			if k_idx_max > 1 then  // se ho solo un APID prova a ottimizzare quindi evita la IN
				k_sql += ")" 
			end if
//			k_sql += " group by meca.wasrst ,meca.id "
			k_sql_totale += k_union + k_sql  // aggiungo eventuale 'union all'
		end if
	next

//--- Eseguo la query totale !!!	
	if k_sql_totale > " " then
		this.Object.DataWindow.Table.Select = k_sql
		this.settransobject( kguo_sqlca_db_e1)
		k_rc = this.retrieve()
	end if

//--- popolo l'array con i valori trovati
	if k_rc > 0 then
		k_return = k_rc
	else
		if k_rc = 0 then
		else
			k_return = k_rc
			kguo_exception.inizializza()
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = k_rc
			kst_esito.SQLErrText = "Errore in lettura dati Lotto, il primo il " + string(k_idx) + " con ID " + string(ast_tab_meca[k_idx].id) &
					 + " ,l'ultimo il " + string(k_idx_max) + " con ID " + string(ast_tab_meca[k_idx_max].id)
					 
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

return k_return

end function

on kds_meca_x_pilota_queue.create
call super::create
end on

on kds_meca_x_pilota_queue.destroy
call super::destroy
end on

