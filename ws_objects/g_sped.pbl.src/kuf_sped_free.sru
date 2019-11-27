$PBExportHeader$kuf_sped_free.sru
forward
global type kuf_sped_free from kuf_parent
end type
end forward

global type kuf_sped_free from kuf_parent
end type
global kuf_sped_free kuf_sped_free

type variables
//
private kuf_sped kiuf_sped
public constant string kki_sped_flg_stampa_bolla_da_stamp="N"
public constant string kki_sped_flg_stampa_bolla_stampata="S"
public constant string kki_sped_flg_stampa_fatturato="F"
private string ki_dw_stampa_ddt = "d_ddt_st_ed7_10_2019f"

end variables

forward prototypes
public subroutine _readme ()
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function st_esito tb_insert (ref st_tab_sped_free ast_tab_sped_free) throws uo_exception
public subroutine if_isnull (ref st_tab_sped_free kst_tab_sped_free)
public function long get_ultimo_id () throws uo_exception
private function st_esito tb_update_json (ref st_tab_sped_free kst_tab_sped_free) throws uo_exception
public function st_esito tb_update (ref st_tab_sped_free ast_tab_sped_free) throws uo_exception
public function boolean tb_delete (st_tab_sped_free kst_tab_sped_free) throws uo_exception
public function boolean if_stampato (st_tab_sped_free ast_tab_sped_free) throws uo_exception
public function datetime get_data_stampa (st_tab_sped_free ast_tab_sped_free) throws uo_exception
public function st_esito u_check_dati (ref datastore ads_inp) throws uo_exception
public function boolean u_open_stampa (st_tab_sped_free kst_tab_sped_free[]) throws uo_exception
public function integer get_ddt_da_stampare (ref st_sped_ddt kst_sped_ddt[]) throws uo_exception
private function st_esito tb_update_exec (ref st_tab_sped_free ast_tab_sped_free, string a_nome_campo, string a_valore) throws uo_exception
public subroutine set_sped_stampato (st_tab_sped_free kst_tab_sped_free) throws uo_exception
public function string get_sped_stampa (ref st_tab_sped_free ast_tab_sped_free) throws uo_exception
end prototypes

public subroutine _readme ();//---
//--- DDT con contenuto Libero
//--- 
end subroutine

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
return kiuf_sped.if_sicurezza(ast_open_w)

end function

public function st_esito tb_insert (ref st_tab_sped_free ast_tab_sped_free) throws uo_exception;//
//====================================================================
//=== Insert new row in  sped_free 
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
st_esito kst_esito
st_tab_sped_free kst_tab_sped_free
kuf_sped kuf1_sped


	try
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = ""
		kst_esito.nome_oggetto = this.classname()
	
//--- controlla se utente autorizzato alla funzione in atto
		if_sicurezza(kkg_flag_modalita.inserimento )
	
		if_isnull(ast_tab_sped_free)

		ast_tab_sped_free.stampa = kuf1_sped.kki_sped_flg_stampa_bolla_da_stamp

		ast_tab_sped_free.x_datins = kGuf_data_base.prendi_x_datins()
		ast_tab_sped_free.x_utente = kGuf_data_base.prendi_x_utente()

//--- INSERT dati non JSON 
		insert into sped_free
					  	(data_bolla_out 
					   , num_bolla_out
					 	, clie_2 
					 	, clie_3
						, stampa
						, data_stampa 
					 	, form_di_stampa 
					 	, x_datins 
						, x_utente )
					values (
					  	:ast_tab_sped_free.data_bolla_out
					  	, :ast_tab_sped_free.num_bolla_out
					 	, :ast_tab_sped_free.clie_2
					 	, :ast_tab_sped_free.clie_3
					 	, :ast_tab_sped_free.stampa
						, :ast_tab_sped_free.data_stampa
					 	, :ast_tab_sped_free.form_di_stampa
					 	, :ast_tab_sped_free.x_datins
						, :ast_tab_sped_free.x_utente)
					using kguo_sqlca_db_magazzino ;
					
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Fallito Inserimento nuovo 'DDT libero' " &
							+ ", dati generici (sped_free): " + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

		//select SCOPE_IDENTITY() into :ast_tab_contratti_doc.id_contratto_doc from contratti_doc
		//			using kguo_sqlca_db_magazzino ;
		ast_tab_sped_free.id_sped_free = get_ultimo_id()
					
//--- carica i dati nel formato JSON
		kst_tab_sped_free = ast_tab_sped_free
		kst_tab_sped_free.st_tab_g_0.esegui_commit = "N"
		tb_update_json(kst_tab_sped_free)

		kst_tab_sped_free.st_tab_g_0.esegui_commit = ast_tab_sped_free.st_tab_g_0.esegui_commit
		ast_tab_sped_free = kst_tab_sped_free

		if kst_tab_sped_free.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_sped_free.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
			
	catch	(uo_exception kuo_exception)
		if kuo_exception.kist_esito.esito = kkg_esito.db_ko then
			if ast_tab_sped_free.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_sped_free.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
			kguo_exception.scrivi_log( )
		end if
		throw kuo_exception
	
	finally
	
	end try
		


return kst_esito

end function

public subroutine if_isnull (ref st_tab_sped_free kst_tab_sped_free);//---
//--- Inizializza i campi della tabella 
//---
int k_i_col


if isnull(kst_tab_sped_free.id_sped_free ) then kst_tab_sped_free.id_sped_free = 0
if isnull(kst_tab_sped_free.clie_2 ) then kst_tab_sped_free.clie_2 = 0
if isnull(kst_tab_sped_free.clie_2 ) then kst_tab_sped_free.clie_2 = 0
if isnull(kst_tab_sped_free.data_bolla_out) then kst_tab_sped_free.data_bolla_out = date(0)
if isnull(kst_tab_sped_free.num_bolla_out) then kst_tab_sped_free.num_bolla_out = ""
if isnull(kst_tab_sped_free.stampa) then kst_tab_sped_free.stampa = ""
if isnull(kst_tab_sped_free.data_stampa) then kst_tab_sped_free.data_stampa = datetime(date(0), time(0))
if isnull(kst_tab_sped_free.form_di_stampa) then kst_tab_sped_free.form_di_stampa = ""


if isnull(kst_tab_sped_free.x_datins) then kst_tab_sped_free.x_datins = datetime(date(0))
if isnull(kst_tab_sped_free.x_utente) then kst_tab_sped_free.x_utente = " "

for k_i_col = 1 to upperbound(kst_tab_sped_free.intestazione_ind[])
	if isnull(kst_tab_sped_free.intestazione_ind[k_i_col]) then kst_tab_sped_free.intestazione_ind[k_i_col] = ""
next

end subroutine

public function long get_ultimo_id () throws uo_exception;//
//====================================================================
//=== Torna l'ultimo ID caricato 
//=== 
//=== Ritorna: ultimo id caricato
//=== 
//====================================================================
long k_return
st_esito kst_esito



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

   SELECT   max(id_sped_free)
       into :k_return
		 FROM sped_free
			using kguo_sqlca_db_magazzino ;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura DDT a contenuto libero (cercato ultimo ID caricato) ~n~r:" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception 
	end if




return k_return




end function

private function st_esito tb_update_json (ref st_tab_sped_free kst_tab_sped_free) throws uo_exception;//
//====================================================================
//=== Update/Insert the row in  sped_free campo JSON
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
int k_idx, k_idx_max, k_i_col
string k_json_key[100]
string k_json_val[100]
string k_json
st_esito kst_esito
//kuf_utility kuf1_utility

	try
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = ""
		kst_esito.nome_oggetto = this.classname()

		//kuf1_utility = create kuf_utility
		
		if kst_tab_sped_free.id_sped_free > 0 then
	
			if_isnull(kst_tab_sped_free)
	
	//--- pulizia di tutto il campo JSON
//						 set dati = JSON_MODIFY(dati, '$.voci', NULL)
			update sped_free
				 set dati = '{}'
						where id_sped_free = :kst_tab_sped_free.id_sped_free
						using kguo_sqlca_db_magazzino ;
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Fallito Aggiornamento 'DDT libero'  " + string(kst_tab_sped_free.id_sped_free) &
							+ ", pulizia area dati (sped_free): " + trim(kguo_sqlca_db_magazzino.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if

	//--- compone il campo JSON		
			k_idx_max = 0
			for k_i_col = 1 to upperbound(kst_tab_sped_free.Indirizzo_riga[])
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "Indirizzo_riga_" + string(k_i_col, "#"); k_json_val[k_idx_max] = trim(string(kst_tab_sped_free.Indirizzo_riga[k_i_col]))
			next
			k_idx_max ++; k_json_key[k_idx_max] = "$." + "aspetto"; k_json_val[k_idx_max] = trim(string(kst_tab_sped_free.aspetto))		
			k_idx_max ++; k_json_key[k_idx_max] = "$." + "causale"; k_json_val[k_idx_max] = trim(string(kst_tab_sped_free.causale))		
			k_idx_max ++; k_json_key[k_idx_max] = "$." + "colli"; k_json_val[k_idx_max] = trim(string(kst_tab_sped_free.colli))		
			k_idx_max ++; k_json_key[k_idx_max] = "$." + "consegna"; k_json_val[k_idx_max] = trim(string(kst_tab_sped_free.consegna))		
			k_idx_max ++; k_json_key[k_idx_max] = "$." + "data_ora_rit"; k_json_val[k_idx_max] = trim(string(kst_tab_sped_free.data_ora_rit))		
			k_idx_max ++; k_json_key[k_idx_max] = "$." + "data_ora_vett"; k_json_val[k_idx_max] = trim(string(kst_tab_sped_free.data_ora_vett))	
			k_idx_max ++; k_json_key[k_idx_max] = "$." + "dicit_ind_intest"; k_json_val[k_idx_max] = trim(string(kst_tab_sped_free.dicit_ind_intest))		
			k_idx_max ++; k_json_key[k_idx_max] = "$." + "dicit_ind_sped"; k_json_val[k_idx_max] = trim(string(kst_tab_sped_free.dicit_ind_sped))		
			k_idx_max ++; k_json_key[k_idx_max] = "$." + "intestazione"; k_json_val[k_idx_max] = trim(string(kst_tab_sped_free.intestazione))		
			for k_i_col = 1 to upperbound(kst_tab_sped_free.intestazione_ind[])
				if trim(string(kst_tab_sped_free.intestazione_ind[k_i_col])) > " " then
					k_idx_max ++; k_json_key[k_idx_max] = "$." + "intestazione_ind" + string(k_i_col, "#"); k_json_val[k_idx_max] = trim(string(kst_tab_sped_free.intestazione_ind[k_i_col]))
				end if
			next
			for k_i_col = 1 to upperbound(kst_tab_sped_free.descr[])
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "descr_" + string(k_i_col, "#"); k_json_val[k_idx_max] = trim(string(kst_tab_sped_free.descr[k_i_col]))		
			next
			for k_i_col = 1 to upperbound(kst_tab_sped_free.kgy[])
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "kgy_" + string(k_i_col, "#"); k_json_val[k_idx_max] = trim(string(kst_tab_sped_free.kgy[k_i_col]))	
			next
			for k_i_col = 1 to upperbound(kst_tab_sped_free.note[])
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "note_" + string(k_i_col, "#"); k_json_val[k_idx_max] = trim(string(kst_tab_sped_free.note[k_i_col]))		
			next
			for k_i_col = 1 to upperbound(kst_tab_sped_free.qta[])
				k_idx_max ++; k_json_key[k_idx_max] = "$." + "qta_" + string(k_i_col, "#"); k_json_val[k_idx_max] = trim(string(kst_tab_sped_free.qta[k_i_col]))
			next
//			for k_i_col = 1 to upperbound(kst_tab_sped_free.um[])
//				k_idx_max ++; k_json_key[k_idx_max] = "$." + "um" + string(k_i_col, "#"); k_json_val[k_idx_max] = trim(string(kst_tab_sped_free.um[k_i_col]))	
//			next
			k_idx_max ++; k_json_key[k_idx_max] = "$." + "peso_kg"; k_json_val[k_idx_max] = trim(string(kst_tab_sped_free.peso_kg))		
			k_idx_max ++; k_json_key[k_idx_max] = "$." + "porto"; k_json_val[k_idx_max] = trim(string(kst_tab_sped_free.porto))		
			k_idx_max ++; k_json_key[k_idx_max] = "$." + "sped_note"; k_json_val[k_idx_max] = trim(string(kst_tab_sped_free.sped_note))		
			k_idx_max ++; k_json_key[k_idx_max] = "$." + "tipo_copia"; k_json_val[k_idx_max] = trim(string(kst_tab_sped_free.tipo_copia))		
			k_idx_max ++; k_json_key[k_idx_max] = "$." + "trasporto"; k_json_val[k_idx_max] = trim(string(kst_tab_sped_free.trasporto))		
			k_idx_max ++; k_json_key[k_idx_max] = "$." + "vett_1"; k_json_val[k_idx_max] = trim(string(kst_tab_sped_free.vett_1))		
			k_idx_max ++; k_json_key[k_idx_max] = "$." + "vett_2"; k_json_val[k_idx_max] = trim(string(kst_tab_sped_free.vett_2))		
			k_idx_max ++; k_json_key[k_idx_max] = "$." + "resa"; k_json_val[k_idx_max] = trim(string(kst_tab_sped_free.resa))		
			k_idx_max ++; k_json_key[k_idx_max] = "$." + "annotazioni"; k_json_val[k_idx_max] = trim(string(kst_tab_sped_free.annotazioni))		

			kguo_sqlca_db_magazzino.sqlcode = 0
			k_idx = 0
			do while k_idx < k_idx_max and kguo_sqlca_db_magazzino.sqlcode = 0 
				k_idx ++
				update sped_free
						 set dati = replace(JSON_MODIFY(dati, :k_json_key[k_idx], :k_json_val[k_idx]), '\/', '/')
    														//	 , JSON_QUERY(:k_json_value))
						where id_sped_free = :kst_tab_sped_free.id_sped_free
						using kguo_sqlca_db_magazzino ;
			loop
			
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Fallito Aggiornamento 'DDT libero' " + string(kst_tab_sped_free.id_sped_free) &
								+ ", campo: " + k_json_key[k_idx] &
								+ " valore: "+ k_json_val[k_idx] + " (sped_free). " + trim(kguo_sqlca_db_magazzino.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if

			if kst_tab_sped_free.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sped_free.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
			
		end if
		
	catch	(uo_exception kuo_exception)
		if kuo_exception.kist_esito.esito = kkg_esito.db_ko then
			if kst_tab_sped_free.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sped_free.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
			kguo_exception.scrivi_log( )
		end if
		throw kuo_exception
	
	finally
		//if isvalid(kuf1_utility) then destroy kuf1_utility
	
	end try
		


return kst_esito

end function

public function st_esito tb_update (ref st_tab_sped_free ast_tab_sped_free) throws uo_exception;//
//====================================================================
//=== Update the row in  sped_free 
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
st_esito kst_esito
st_tab_sped_free kst_tab_sped_free


	try
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = ""
		kst_esito.nome_oggetto = this.classname()
	
//--- controlla se utente autorizzato alla funzione in atto
		if_sicurezza(kkg_flag_modalita.modifica )
	
		if ast_tab_sped_free.id_sped_free > 0 then
	
			if_isnull(ast_tab_sped_free)

//--- aggiorna i dati del Contratto (JSON)
			kst_tab_sped_free = ast_tab_sped_free
			kst_tab_sped_free.st_tab_g_0.esegui_commit = "N"
			tb_update_json(kst_tab_sped_free)
			
			kst_tab_sped_free.st_tab_g_0.esegui_commit = ast_tab_sped_free.st_tab_g_0.esegui_commit
			ast_tab_sped_free = kst_tab_sped_free

			kst_tab_sped_free.x_datins = kGuf_data_base.prendi_x_datins()
			kst_tab_sped_free.x_utente = kGuf_data_base.prendi_x_utente()

//--- aggiorna altri dati non JSON 
			update sped_free
					 set 
					  	data_bolla_out = :ast_tab_sped_free.data_bolla_out
					  	, num_bolla_out = :ast_tab_sped_free.num_bolla_out
					 	, clie_2 = :ast_tab_sped_free.clie_2
					 	, clie_3 = :ast_tab_sped_free.clie_3
					 	, stampa = :ast_tab_sped_free.stampa
						, data_stampa = :ast_tab_sped_free.data_stampa
					 	, form_di_stampa = :ast_tab_sped_free.form_di_stampa
					 	, x_datins = :ast_tab_sped_free.x_datins
						, x_utente = :ast_tab_sped_free.x_utente
					where id_sped_free = :ast_tab_sped_free.id_sped_free
					using kguo_sqlca_db_magazzino ;
					
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Fallito Aggiornamento 'DDT libero' " + string(ast_tab_sped_free.id_sped_free) &
								+ ", dati vari e di ultimo aggiornamento (sped_free): " + trim(kguo_sqlca_db_magazzino.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if

			if ast_tab_sped_free.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_sped_free.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
			
		end if
		
	catch	(uo_exception kuo_exception)
		if kuo_exception.kist_esito.esito = kkg_esito.db_ko then
			if ast_tab_sped_free.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_sped_free.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
			kguo_exception.scrivi_log( )
		end if
		throw kuo_exception
	
	finally
	
	end try
		


return kst_esito

end function

public function boolean tb_delete (st_tab_sped_free kst_tab_sped_free) throws uo_exception;//
//====================================================================
//=== Cancella il rek dalla tabella sped_free 
//=== 
//===           	
//====================================================================
//
boolean k_return
st_esito kst_esito
st_open_w kst_open_w


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if_sicurezza(kkg_flag_modalita.cancellazione)

	try

		if kst_tab_sped_free.id_sped_free > 0 then
	
			delete from sped_free
				where id_sped_free = :kst_tab_sped_free.id_sped_free
				using kguo_sqlca_db_magazzino;
			
			if sqlca.sqlcode < 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore in Cancellazione 'DDT libero' id " + string(kst_tab_sped_free.id_sped_free) + " (sped_free): " + trim(sqlca.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if

//---- COMMIT....	
			if kst_tab_sped_free.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sped_free.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
		
			k_return = true
		end if
		
	catch	(uo_exception kuo_exception)
		if kst_tab_sped_free.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sped_free.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
		throw kuo_exception

	finally
	
	end try

return k_return

end function

public function boolean if_stampato (st_tab_sped_free ast_tab_sped_free) throws uo_exception;//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Controlla se DDT stampato x id_sped_free
//--- 
//--- 
//--- Inp: st_tab_sped.id_sped_free
//--- Out: TRUE stampato
//---
//--- lancia exception
//---
//----------------------------------------------------------------------------------------------------------------
//
boolean k_return
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = " "
kst_esito.nome_oggetto = this.classname()

if ast_tab_sped_free.id_sped_free > 0 then

	SELECT max(stampa)
			into :ast_tab_sped_free.stampa
			 FROM sped_free
			 where  id_sped_free  = :ast_tab_sped_free.id_sped_free 
			 using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante ricerca se 'DDT libero' stampato (sped_free) id = " + string(ast_tab_sped_free.id_sped_free) + " " &
						 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = KKG_ESITO.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	if ast_tab_sped_free.stampa = kki_sped_flg_stampa_bolla_stampata then
		k_return = true  
	end if
	
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Operazione di verifica se 'DDT libero' già stampato non eseguito, manca il codice ID"
	kst_esito.esito = KKG_ESITO.no_esecuzione
	kguo_exception.inizializza()
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if
	

return k_return



end function

public function datetime get_data_stampa (st_tab_sped_free ast_tab_sped_free) throws uo_exception;//----------------------------------------------------------------------------------------------------------------
//--- 
//--- get Data di stampa
//--- 
//--- 
//--- Inp: st_tab_sped.id_sped_free
//--- Out: data_stampa
//---
//--- lancia exception
//---
//----------------------------------------------------------------------------------------------------------------
//
datetime k_return = datetime(date(0), time(0))
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = " "
kst_esito.nome_oggetto = this.classname()

if ast_tab_sped_free.id_sped_free > 0 then

	SELECT max(data_stampa)
			into :ast_tab_sped_free.data_stampa
			 FROM sped_free
			 where  id_sped_free  = :ast_tab_sped_free.id_sped_free 
			 using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura Data di stampa del 'DDT libero' (sped_free) id = " + string(ast_tab_sped_free.id_sped_free) + " " &
						 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = KKG_ESITO.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	if date(ast_tab_sped_free.data_stampa) > kkg_data_zero then
		k_return = ast_tab_sped_free.data_stampa  
	end if
	
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Operazione di lettura Data di stampa del 'DDT libero' non eseguita, manca il codice ID"
	kst_esito.esito = KKG_ESITO.no_esecuzione
	kguo_exception.inizializza()
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if
	

return k_return



end function

public function st_esito u_check_dati (ref datastore ads_inp) throws uo_exception;//------------------------------------------------------------------------------------------------------
//---  Controllo dati utente
//---  inp: datastore con i dati da controllare
//---  out: datastore con  	ads_inp.object.<nome campo>.tag che può valere:
//												0=tutto OK (kkg_esito.ok); 
//												1=errore logico (bloccante) (kkg_esito.ERR_LOGICO); 
//												2=errore forma  (bloccante) (kkg_esito.err_formale);
//												3=dati insufficienti  (bloccante) (kkg_esito.DATI_INSUFF);
//												4=KO ma errore non grave  (NON bloccante) (kkg_esito.DB_WRN);
//---							               	W=OK con degli avvertimenti (NON bloccante) (kkg_esito.DATI_WRN);
//---  rit: 
//---
//---  per errore lancia EXCEPTION anche x i warning
//---
//---  CONSIGLIO DI COPIARE DA QUESTO ESTENDENDO I CONTROLLI
//---
//------------------------------------------------------------------------------------------------------
//
int k_errori = 0
long k_nr_righe
int k_riga
string k_tipo_errore="0", k_type, k_valore
st_esito kst_esito



try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	
end try


return kst_esito
 
 
 
end function

public function boolean u_open_stampa (st_tab_sped_free kst_tab_sped_free[]) throws uo_exception;//---
//--- Stampa Sped
//---
//---

boolean k_return = false
long k_riga=0
integer k_ctr, k_index
//kuf_sped_ddt kuf1_sped_ddt
st_ddt_stampa kst_ddt_stampa[]
st_sped_ddt kst_sped_ddt[]
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window
			
		
//--- Cicla fino a che ci sono righe selezionate
	k_riga=0
	k_index = 1
	do while k_index <= UpperBound(kst_tab_sped_free)  //NOT k_fatt_selected_eof
		
		if kst_tab_sped_free[k_index].id_sped_free > 0 then
			k_riga++
			kst_sped_ddt[k_riga].kst_tab_sped_free.id_sped_free = kst_tab_sped_free[k_index].id_sped_free
			kst_sped_ddt[k_riga].kst_tab_sped_free.num_bolla_out = kst_tab_sped_free[k_index].num_bolla_out
		//	kst_sped_ddt[k_riga].kst_tab_sped_free.data_bolla_out = kst_tab_sped_free[k_index].data_bolla_out
			kst_sped_ddt[k_riga].sel = 1
				
		end if								
		k_index++
	loop

	if k_riga > 0 then	

		if_sicurezza(kkg_flag_modalita.stampa)

//=== Open Window
		kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.stampa)
		Kst_open_w.flag_primo_giro = "S"
		Kst_open_w.flag_modalita = kkg_flag_modalita.stampa
		Kst_open_w.flag_adatta_win = KKG.ADATTA_WIN_NO
		Kst_open_w.flag_leggi_dw = "N"
		kst_open_w.key12_any = kst_sped_ddt[]   // struttura
		kst_open_w.flag_where = " "
		
			
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(kst_open_w)
		destroy kuf1_menu_window

		k_return = true
	end if
		
//		try 
//			kuf1_sped_ddt = create kuf_sped_ddt
//			
//			kuf1_sped_ddt.stampa_ddt_nuovo (kst_ddt_stampa[])
//
//		catch (uo_exception kuo_exception1)
//			kuo_exception1.messaggio_utente()
//			
//		finally
//			if isvalid(kuf1_sped_ddt) then destroy kuf1_sped_ddt
//			
//		end try
//	end if
//	
		

return k_return



end function

public function integer get_ddt_da_stampare (ref st_sped_ddt kst_sped_ddt[]) throws uo_exception;//
//--- Cerca i documenti non ancora Stampati (vedi il flag di "STAMPA")
//--- input:  datastore ds_fatture con l'elenco delle fatture da aggiornare
//--- out: numero fatture aggiornate
//---
int k_ctr=0
long k_n_ddt=0
date k_data_meno6mesi, k_dataoggi
//string k_dataoggix
st_tab_sped_free kst_tab_sped_free
st_esito kst_esito 
uo_exception kuo_exception
//kuf_base kuf1_base




	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""

	kst_tab_sped_free.stampa = kki_sped_flg_stampa_bolla_da_stamp
  	declare  c_get_ddt_da_stampare  cursor for
	    SELECT distinct
				id_sped_free,
				num_bolla_out,   
				data_bolla_out 
				FROM v_sped_free 
				 where  (data_bolla_out > :k_data_meno6mesi 
						 and (stampa is null or stampa = :kst_tab_sped_free.stampa)) 
				 group by 
				 id_sped_free
				,data_bolla_out 
				,num_bolla_out  
				using sqlca;
	

//--- data oggi
	k_dataoggi = kguo_g.get_dataoggi( )
	
//--- data oggi -6 mesi
	k_data_meno6mesi = relativedate(kg_dataoggi, -185)
	
	
	open c_get_ddt_da_stampare;

	if sqlca.sqlcode = 0 then

		k_n_ddt++
		fetch c_get_ddt_da_stampare 
				into
				:kst_sped_ddt[k_n_ddt].kst_tab_sped_free.id_sped_free
				,:kst_sped_ddt[k_n_ddt].kst_tab_sped_free.NUM_BOLLA_OUT
				,:kst_sped_ddt[k_n_ddt].kst_tab_sped_free.DATA_BOLLA_OUT;
		
		do while sqlca.sqlcode = 0 

			kst_sped_ddt[k_n_ddt].sel = 1

			if isnull(kst_sped_ddt[k_n_ddt].kst_tab_sped_free.NUM_BOLLA_OUT) then kst_sped_ddt[k_n_ddt].kst_tab_sped_free.NUM_BOLLA_OUT = ""
			if isnull(kst_sped_ddt[k_n_ddt].kst_tab_sped_free.DATA_BOLLA_OUT) then kst_sped_ddt[k_n_ddt].kst_tab_sped_free.DATA_BOLLA_OUT = date(0)
			
			kst_tab_sped_free.num_bolla_out = kst_sped_ddt[k_n_ddt].kst_tab_sped_free.NUM_BOLLA_OUT
			kst_tab_sped_free.data_bolla_out = kst_sped_ddt[k_n_ddt].kst_tab_sped_free.DATA_BOLLA_OUT

			k_n_ddt++
			fetch c_get_ddt_da_stampare 
				into
				:kst_sped_ddt[k_n_ddt].kst_tab_sped_free.id_sped_free
				,:kst_sped_ddt[k_n_ddt].kst_tab_sped_free.NUM_BOLLA_OUT
				,:kst_sped_ddt[k_n_ddt].kst_tab_sped_free.DATA_BOLLA_OUT;
				
		loop
	
		close c_get_ddt_da_stampare;
		
	end if
	
//--- 
	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = &
				"Errore durante lettura DDT (libero) da stampare ~n~r" &
							+ "Ultimo ddt letto: " + trim(kst_tab_sped_free.NUM_BOLLA_OUT) + " del " &
							+ string(kst_tab_sped_free.DATA_BOLLA_OUT, "dd.mm.yyyy") &	
							+ " ~n~rErrore-tab.SPED:"	+ trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kuo_exception = create uo_exception
		kuo_exception.set_esito( kst_esito)
		throw kuo_exception
	end if



return k_n_ddt

end function

private function st_esito tb_update_exec (ref st_tab_sped_free ast_tab_sped_free, string a_nome_campo, string a_valore) throws uo_exception;//
//====================================================================
//=== Update/Insert the value in  sped_free campo JSON
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
int k_idx, k_idx_max, k_i_col
string k_json
st_esito kst_esito

	try
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = ""
		kst_esito.nome_oggetto = this.classname()

		if ast_tab_sped_free.id_sped_free > 0 then
			
			a_nome_campo = "$." + trim(a_nome_campo)
	
			update sped_free
					 set dati = replace(JSON_MODIFY(dati, :a_nome_campo, :a_valore), '\/', '/')
				where id_sped_free = :ast_tab_sped_free.id_sped_free
				using kguo_sqlca_db_magazzino ;

			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Fallito Aggiornamento 'DDT libero' " + string(ast_tab_sped_free.id_sped_free) &
								+ ", campo: " + a_nome_campo &
								+ " valore: "+ a_valore + " (sped_free). " + trim(kguo_sqlca_db_magazzino.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
	
			if ast_tab_sped_free.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_sped_free.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
		end if
		
	catch	(uo_exception kuo_exception)
		if kuo_exception.kist_esito.esito = kkg_esito.db_ko then
			if ast_tab_sped_free.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_sped_free.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
			kguo_exception.scrivi_log( )
		end if
		throw kuo_exception
	
	finally
		//if isvalid(kuf1_utility) then destroy kuf1_utility
	
	end try
		


return kst_esito

end function

public subroutine set_sped_stampato (st_tab_sped_free kst_tab_sped_free) throws uo_exception;//
//====================================================================
//=== Imposta a Stampata la Bolla di spedizione
//=== 
//=== 
//=== Input: st_tab_sped_free.id_sped
//===           + data_rit e ora_rit 
//=== Out: ST_ESITO
//===           		
//=== 
//====================================================================
//
st_esito kst_esito

	
kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()
	
	
if kst_tab_sped_free.id_sped_free > 0 then

	kst_tab_sped_free.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_sped_free.x_utente = kGuf_data_base.prendi_x_utente()

	kst_tab_sped_free.stampa = kki_sped_flg_stampa_bolla_stampata
	UPDATE sped_free
		  SET stampa = :kst_tab_sped_free.stampa
				,x_datins = :kst_tab_sped_free.x_datins
				,x_utente = :kst_tab_sped_free.x_utente
		WHERE id_sped_free = :kst_tab_sped_free.id_sped_free
		using kguo_sqlca_db_magazzino;

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante aggiornamento dati ddt come stampato ~n~r" &
					+ string(kst_tab_sped_free.id_sped_free, "####0") &
					+ " ~n~rErrore-tab.SPED_FREE:"	+ trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	end if
	
	tb_update_exec(kst_tab_sped_free, "data_ora_rit", kst_tab_sped_free.data_ora_rit) // aggiorna campo JSON
	
//---- COMMIT o ROLLBACK....	
	if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn  then
		if kst_tab_sped_free.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sped_free.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	else
		if kst_tab_sped_free.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sped_free.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
	end if

else
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Errore in aggiornamento ddt. Manca il codice ID di Spedizione Libero (id_sped_free)!" 
	kst_esito.esito = kkg_esito.err_logico
			
end if	

if kst_esito.esito <> kkg_esito.ok then
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if


end subroutine

public function string get_sped_stampa (ref st_tab_sped_free ast_tab_sped_free) throws uo_exception;//----------------------------------------------------------------------------------------------------------------
//--- 
//--- get Data di stampa
//--- 
//--- 
//--- Inp: st_tab_sped.id_sped_free
//--- Out: data_stampa
//---
//--- lancia exception
//---
//----------------------------------------------------------------------------------------------------------------
//
string k_return 
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = " "
kst_esito.nome_oggetto = this.classname()

if ast_tab_sped_free.id_sped_free > 0 then

	SELECT stampa
			into :ast_tab_sped_free.stampa
			 FROM v_sped_free
			 where  id_sped_free  = :ast_tab_sped_free.id_sped_free 
			 using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura indicatore di Stampa del 'DDT libero' (sped_free) id = " + string(ast_tab_sped_free.id_sped_free) + " " &
						 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = KKG_ESITO.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	if trim(ast_tab_sped_free.stampa) > " " then
		k_return = ast_tab_sped_free.stampa  
	end if
	
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Operazione di lettura indicatore di stampa del 'DDT libero' non eseguita, manca il codice ID"
	kst_esito.esito = KKG_ESITO.no_esecuzione
	kguo_exception.inizializza()
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if
	

return k_return



end function

on kuf_sped_free.create
call super::create
end on

on kuf_sped_free.destroy
call super::destroy
end on

event constructor;call super::constructor;//
kiuf_sped = create kuf_sped
end event

event destructor;call super::destructor;//
if isvalid(kiuf_sped) then destroy kiuf_sped

end event

