$PBExportHeader$kuo_sqlca_db_crm.sru
forward
global type kuo_sqlca_db_crm from kuo_sqlca_db_0
end type
end forward

global type kuo_sqlca_db_crm from kuo_sqlca_db_0
end type
global kuo_sqlca_db_crm kuo_sqlca_db_crm

type variables

end variables

forward prototypes
public function boolean db_connetti () throws uo_exception
public subroutine u_crea_schema () throws uo_exception
public function boolean if_connessione_bloccata () throws uo_exception
public subroutine u_crea_tb_crm_clie_classi () throws uo_exception
public subroutine u_crea_tb_crm_clie_settori () throws uo_exception
public subroutine u_crea_tb_crm_art () throws uo_exception
public subroutine u_crea_tb_crm_anagrafe () throws uo_exception
public subroutine u_crea_tb_crm_clienti_contatti () throws uo_exception
public subroutine u_crea_tb_crm_contratti () throws uo_exception
public subroutine u_crea_tb_crm_gruppi () throws uo_exception
public subroutine u_crea_tb_crm_confermaordine () throws uo_exception
public subroutine u_crea_tb_crm_listino () throws uo_exception
public subroutine u_crea_tb_crm_pt () throws uo_exception
public subroutine u_crea_tb_crm_previsioni () throws uo_exception
public subroutine u_crea_tb_crm_cntr_tot_mese () throws uo_exception
public function st_esito db_crea_table (string k_table, string k_sql) throws uo_exception
end prototypes

public function boolean db_connetti () throws uo_exception;//---
//--- Effettua la connessione al DB "esterno" leggendo i parametri da TAB
//---
boolean k_return=false
st_tab_db_cfg kst_tab_db_cfg
st_esito kst_esito
datastore kds_tab_db_cfg
kuf_db_cfg kuf1_db_cfg

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

	
try
	kuf1_db_cfg = create kuf_db_cfg
	
//--- piglia i dati di connessione dal DB	
	kst_tab_db_cfg.codice = kuf1_db_cfg.kki_codice_xcrm
	kuf1_db_cfg.get_profilo_db(kst_tab_db_cfg)   // recupera i dati delprofilo di connessione

	k_return = db_connetti(kst_tab_db_cfg)
	
catch (uo_exception kuo_exception)	
	throw kuo_exception
	
finally
	destroy kuf1_db_cfg
	

end try

return k_return
end function

public subroutine u_crea_schema () throws uo_exception;//---------------------------------------------------------------------------------------------------------------------------
//---
//--- Crea il database di scambio con il CRM
//--- 
//--- lancia exception
//---------------------------------------------------------------------------------------------------------------------------
//
string k_table, k_sql

try 

	setpointer(kkg.pointer_attesa)

	db_connetti( )

//	EXECUTE IMMEDIATE ()create database db_crm_m2000;() using this;
//	if this.sqlcode = 0 then 
//		commit using this;
//	end if

	u_crea_tb_crm_clie_classi()	
	
	u_crea_tb_crm_clie_settori()
	
	u_crea_tb_crm_art()
	
	u_crea_tb_crm_anagrafe()
	
	u_crea_tb_crm_clienti_contatti()
	
	u_crea_tb_crm_contratti()
	
	u_crea_tb_crm_gruppi()
	
	u_crea_tb_crm_confermaordine()
	
	u_crea_tb_crm_listino()
	
	u_crea_tb_crm_pt()
	
	u_crea_tb_crm_cntr_tot_mese()

	u_crea_tb_crm_previsioni()

	setpointer(kkg.pointer_default)
	
catch(uo_exception kuo_exception)
	throw kuo_exception

finally
		db_disconnetti( )


end try


end subroutine

public function boolean if_connessione_bloccata () throws uo_exception;//
//---	Torna FALSE=connessione OK, TRUE=connessione BLOCCATA
//--- da personalizzare
//
boolean k_return = false
st_tab_db_cfg kst_tab_db_cfg
kuf_db_cfg kuf1_db_cfg


	kuf1_db_cfg = create kuf_db_cfg
		
	kst_tab_db_cfg.codice = kuf1_db_cfg.kki_codice_xcrm
	if kuf1_db_cfg.if_connessione_bloccata(kst_tab_db_cfg) then    // Connessione bloccata?? speriamo di no
		k_return = true
	end if
	
return k_return
end function

public subroutine u_crea_tb_crm_clie_classi () throws uo_exception;//---------------------------------------------------------------------------------------------------------------------------
//---
//--- Crea il database di scambio con il CRM
//--- 
//--- lancia exception
//---------------------------------------------------------------------------------------------------------------------------
//
string k_table, k_sql

try 

	setpointer(kkg.pointer_attesa)

	db_connetti( )

//	EXECUTE IMMEDIATE "create database db_crm_m2000;" using this;
//	if this.sqlcode = 0 then 
//		commit using this;
//	end if

	
	k_table = "crm_clie_classi"
	k_sql = "CREATE TABLE  crm_clie_classi   "&
	 + " ( id_clie_classe  char(8) NOT NULL,  descr  nvarchar(80) ,  punteggio  char(2) ) "
	db_crea_table( k_table, k_sql)
	

	setpointer(kkg.pointer_default)
	
catch(uo_exception kuo_exception)
	throw kuo_exception

finally
		db_disconnetti( )


end try


end subroutine

public subroutine u_crea_tb_crm_clie_settori () throws uo_exception;//---------------------------------------------------------------------------------------------------------------------------
//---
//--- Crea il database di scambio con il CRM
//--- 
//--- lancia exception
//---------------------------------------------------------------------------------------------------------------------------
//
string k_table, k_sql

try 

	setpointer(kkg.pointer_attesa)

	db_connetti( )

//	EXECUTE IMMEDIATE "create database db_crm_m2000;" using this;
//	if this.sqlcode = 0 then 
//		commit using this;
//	end if

	
	k_table = "crm_clie_settori"
	k_sql = "CREATE TABLE  crm_clie_settori  ( id_clie_settore  char(8) ,  descr  nvarchar(80) ,  descr_eng  nvarchar(80) ) "
	db_crea_table( k_table, k_sql)
	

	setpointer(kkg.pointer_default)
	
catch(uo_exception kuo_exception)
	throw kuo_exception

finally
		db_disconnetti( )


end try


end subroutine

public subroutine u_crea_tb_crm_art () throws uo_exception;//---------------------------------------------------------------------------------------------------------------------------
//---
//--- Crea il database di scambio con il CRM
//--- 
//--- lancia exception
//---------------------------------------------------------------------------------------------------------------------------
//
string k_table, k_sql

try 

	setpointer(kkg.pointer_attesa)

	db_connetti( )

//	EXECUTE IMMEDIATE "create database db_crm_m2000;" using this;
//	if this.sqlcode = 0 then 
//		commit using this;
//	end if

	k_table = "crm_art"
	k_sql = "CREATE TABLE  crm_art  ( cod_art  char(12) ,  descr  nvarchar(40) ,  descr_mkt  nvarchar(40) ,  cod_gruppo  numeric(3,0) ,  iva  numeric(2,0) ,  magazzino  smallint  ) "
	db_crea_table( k_table, k_sql)
	

	setpointer(kkg.pointer_default)
	
catch(uo_exception kuo_exception)
	throw kuo_exception

finally
		db_disconnetti( )


end try


end subroutine

public subroutine u_crea_tb_crm_anagrafe () throws uo_exception;//---------------------------------------------------------------------------------------------------------------------------
//---
//--- Crea il database di scambio con il CRM
//--- 
//--- lancia exception
//---------------------------------------------------------------------------------------------------------------------------
//
string k_table, k_sql

try 

	setpointer(kkg.pointer_attesa)

	db_connetti( )

//	EXECUTE IMMEDIATE "create database db_crm_m2000;" using this;
//	if this.sqlcode = 0 then 
//		commit using this;
//	end if


	k_table = "crm_anagrafe"
	k_sql = "CREATE TABLE   crm_anagrafe  " &
	 + " ( id_cliente  integer NOT NULL " &
	  + " ,  tipo  char(1),  tipo_descr  nvarchar(24)  " &
	  + " ,  stato  char(1),   stato_descr  nvarchar(24)  " &
	  + " ,  data_attivazione  date  " &
	  + " ,  partitaiva  nvarchar(16)  " &
	  + " ,  codicefiscale  nvarchar(16) " &
	  + " ,  sede_rag_soc  nvarchar(80) " &
	  + " ,  sede_indi  nvarchar(30) " &
	  + " ,  sede_loc  nvarchar(30)  " &
	  + " ,  sede_cap  char(5) " &
	  + " ,  sede_prov  char(2) " &
	  + " ,  sede_nazione  char(3) " &
	  + " ,  nazione_nome  nvarchar(40) " &
	  + " ,  nazione_area  nvarchar(16) " &
	  + " ,  ddt_rag_soc  nvarchar(80) " &
	  + " ,  ddt_indi  nvarchar(30) " &
	  + " ,  ddt_loc  nvarchar(30) " &
	  + " ,  ddt_cap  char(5) " &
	  + " ,  ddt_prov  char(2) " &
	  + " ,  fatt_rag_soc  nvarchar(80) " &
	  + " ,  fatt_indi  nvarchar(30) " &
	  + " ,  fatt_loc  nvarchar(30) " &
	  + " ,  fatt_cap  char(5) " &
	  + " ,  fatt_prov  char(2) " &
	  + " ,  codice_pagamento  numeric(3,0) " &
	  + " ,  pagamento_descr  nvarchar(40) " &
	  + " ,  telefono  nvarchar(80) " &
	  + " ,  fax  nvarchar(32) " &
	  + " ,  banca  nvarchar(30) " &
	  + " ,  abi  numeric(5,0) " &
	  + " ,  cab  numeric(5,0) " &
	  + " ,  esente_iva  numeric(2,0) " &
	  + " ,  esente_iva_descr  nvarchar(80) " &
	  + " ,  esente_dal  date " &
	  + " ,  esente_al  date " &
	  + " ,  esente_fino_importo  numeric(11,2) " &
	  + " ,  esente_importo_minimo  numeric(11,2) " &
	  + " ,  escludi_scadenza_mese_1  smallint " &
	  + " ,  escludi_scadenza_mese_2  smallint " &
	  + " ,  cadenza_fatturazione  char(2) " &
	  + " ,  sede_zona  char(3) " &
	  + " ,  id_clie_settore  char(8) " &
	  + " ,  settore_descrizione  char(40) " &
	  + " ,  id_clie_classe  char(8) " &
	  + " ,  classe_descr  char(40) " &
	  + " ,  causale_entrata_merce  integer " &
	  + " ,  causale_descrizione_entrata_merce  char(30) " &
	  + " ,  fattura_da  char(1) " &
	  + " ,  fattura_da_descr  char(40) " &
	  + " ,  fatt_note  nvarchar(512) " &
	  + " ,  fatt_modo_stampa  char(1) " &
	  + " ,  fatt_modo_stampa_descr  char(40) " &
	  + " ,  fatt_modo_email  char(1) " &
	  + " ,  fatt_modo_email_descr  char(30) " &
	  + " ,  fatt_email_invio  char(1) " &
	  + " ,  fatt_email_invio_descr  char(30) " &
	  + " ,  id_cliente_link  integer " &
	  + " ,  qualifica  char(40) " &
	  + " ,  tipo_rapporto  char(8) " &
	  + " ,  altra_sede  nvarchar(160) " &
	  + " ,  cod_atecori  char(8) " &
	  + " ,  note_attivita  nvarchar(255) " &
	  + " ,  note_prodotti  nvarchar(255) " &
	  + " ,  cod_gruppo_prevalente  numeric(3,0) " &
	  + " ,  email_1  nvarchar(255) " &
	  + " ,  email_2  nvarchar(255) " &
	  + " ,  email_3  nvarchar(255) " &
	  + " ,  sito_web_1  nvarchar(255) " &
	  + " ,  sito_web_2  nvarchar(255) " &
	  + " ,  sito_blog_1  nvarchar(255) " &
	  + " ,  sito_blog_2  nvarchar(255) " &
	  + " ,  note_web  nvarchar(80) " &
	  +"  ) " 
	db_crea_table( k_table, k_sql)
	

	setpointer(kkg.pointer_default)
	
catch(uo_exception kuo_exception)
	throw kuo_exception

finally
		db_disconnetti( )


end try


end subroutine

public subroutine u_crea_tb_crm_clienti_contatti () throws uo_exception;//---------------------------------------------------------------------------------------------------------------------------
//---
//--- Crea il database di scambio con il CRM
//--- 
//--- lancia exception
//---------------------------------------------------------------------------------------------------------------------------
//
string k_table, k_sql

try 

	setpointer(kkg.pointer_attesa)

	db_connetti( )

//	EXECUTE IMMEDIATE "create database db_crm_m2000;" using this;
//	if this.sqlcode = 0 then 
//		commit using this;
//	end if

	k_table = "crm_clienti_contatti"
	k_sql = "CREATE TABLE  crm_clienti_contatti  " &
	  + "( id_cliente  integer " &
	  + ", id_contatto  integer  " &
	  + ",  qualifica  nvarchar(40) " &
	  + ") "
	db_crea_table( k_table, k_sql)
	

	setpointer(kkg.pointer_default)
	
catch(uo_exception kuo_exception)
	throw kuo_exception

finally
		db_disconnetti( )


end try


end subroutine

public subroutine u_crea_tb_crm_contratti () throws uo_exception;//---------------------------------------------------------------------------------------------------------------------------
//---
//--- Crea il database di scambio con il CRM
//--- 
//--- lancia exception
//---------------------------------------------------------------------------------------------------------------------------
//
string k_table, k_sql

try 

	setpointer(kkg.pointer_attesa)

	db_connetti( )

//	EXECUTE IMMEDIATE "create database db_crm_m2000;" using this;
//	if this.sqlcode = 0 then 
//		commit using this;
//	end if

	
	k_table = "crm_contratti"
	k_sql = "CREATE TABLE  crm_contratti  ( " &
	 + "  id_cliente  integer " &
	 + " ,  tipo_contratto  char(2) " & 
	 + " ,  id_tipocontratto  integer  " &
	 + " ,  id_contratto  integer  " &
	 + " ,  anno  smallint " &
	 + " ,  attivo  char(1)  " &
	  + " ,  magazzino  smallint " &
	  + " ,  art  char(12)  " &
	  + " ,  offerta_data  date " &
	  + " ,  stato  char(1) " &
	  + " ,  data_stampa  date " &
	  + " ,  data_inizio  date " &
	  + " ,  data_fine  date " &
	  + " ,  oggetto  nvarchar(80) " &
	  + " ,  id_clie_settore  char(8) " &
	  + " ,  cod_gruppo  numeric(3,0) " &
	  + " ,  nome_contatto  nvarchar(80) " &
	  + " ,  prezzo  float " &
	  + " ,  prezzi  nvarchar(512) " &
	  + " ,  unita_misura  nvarchar(32) " &
	  + " ,  misure_varie  nvarchar(255) " &
	  + " ,  note  nvarchar(512) " &
	  + " ,  contratti_des  nvarchar(80) " &
	 + " ,  sk_dose_map_codice  nvarchar(16)  " &
	 + " ,  sk_dose_map_des  nvarchar(30)  " &
	 + " ,  altre_condizioni  nvarchar(255) " &
	  + " ,  consegna_des  nvarchar(80) " &
	  + " ,  ritiro_des  nvarchar(80) " &
	  + " ,  note_interne  nvarchar(255) " &
	  + ") "
	db_crea_table( k_table, k_sql)
	

	setpointer(kkg.pointer_default)
	
catch(uo_exception kuo_exception)
	throw kuo_exception

finally
		db_disconnetti( )


end try


end subroutine

public subroutine u_crea_tb_crm_gruppi () throws uo_exception;//---------------------------------------------------------------------------------------------------------------------------
//---
//--- Crea il database di scambio con il CRM
//--- 
//--- lancia exception
//---------------------------------------------------------------------------------------------------------------------------
//
string k_table, k_sql

try 

	setpointer(kkg.pointer_attesa)

	db_connetti( )

//	EXECUTE IMMEDIATE "create database db_crm_m2000;" using this;
//	if this.sqlcode = 0 then 
//		commit using this;
//	end if

	k_table = "crm_gruppi"
	k_sql = "CREATE TABLE  crm_gruppi  ( " &
	  + "  cod_gruppo  numeric(3,0)  " &
	  + " ,  descr  nvarchar(40)  " &
	  + " ,  descr_eng  nvarchar(40)  " &
	  + " ,  id_clie_settore  char(8)  " &
	  + ") "
	db_crea_table( k_table, k_sql)

	setpointer(kkg.pointer_default)
	
catch(uo_exception kuo_exception)
	throw kuo_exception

finally
		db_disconnetti( )


end try


end subroutine

public subroutine u_crea_tb_crm_confermaordine () throws uo_exception;//---------------------------------------------------------------------------------------------------------------------------
//---
//--- Crea il database di scambio con il CRM
//--- 
//--- lancia exception
//---------------------------------------------------------------------------------------------------------------------------
//
string k_table, k_sql

try 

	setpointer(kkg.pointer_attesa)

	db_connetti( )

//	EXECUTE IMMEDIATE "create database db_crm_m2000;" using this;
//	if this.sqlcode = 0 then 
//		commit using this;
//	end if
	
	k_table = "crm_confermaordine"
	k_sql = "CREATE TABLE  crm_confermaordine   " &
	  + " (  id_confermaordine  integer  " &
	  + " ,  id_tipocontratto  integer   " &
	  + " ,  id_contratto  integer   " &
	  + " ,  descr  nvarchar(50)   " &
	  + " ,  cod_contr_comm  char(12)   " &
	  + " ,  cod_capitolato  char(12)   " &
	  + " ,  cod_pt  char(12)   " &
	  + "  ,  data_ins  date  " &
	  + "  ,  data_scad  date  " &
	  + "  ,  id_cliente  integer  " &
	  + ") "
	db_crea_table( k_table, k_sql)
	

	setpointer(kkg.pointer_default)
	
catch(uo_exception kuo_exception)
	throw kuo_exception

finally
		db_disconnetti( )


end try


end subroutine

public subroutine u_crea_tb_crm_listino () throws uo_exception;//---------------------------------------------------------------------------------------------------------------------------
//---
//--- Crea il database di scambio con il CRM
//--- 
//--- lancia exception
//---------------------------------------------------------------------------------------------------------------------------
//
string k_table, k_sql

try 

	setpointer(kkg.pointer_attesa)

	db_connetti( )

//	EXECUTE IMMEDIATE "create database db_crm_m2000;" using this;
//	if this.sqlcode = 0 then 
//		commit using this;
//	end if


	k_table = "crm_listino"
	k_sql = "CREATE TABLE  crm_listino  " &
	  + "  ( id_crm_listino  integer  " &
	  + "  , id_listino  integer  " &
	  + " ,  id_cliente  integer " &
	  + "  ,  cod_art  char(12) " &
	  + "  ,  dose  numeric(6,1) " &
	  + "  ,  prezzo  numeric(13,2)  " &
	  + " ,  id_voce  integer  " &
	  + "  , voce_decriz  varchar(80) " &
	  + "  ,  id_cond_fatt  integer  " &
	  + "  , cond_fatt_descriz  varchar(80) " &
	  + "  ,  campione  char(1) " &
	  + "  ,  misure  nvarchar(32) " &
	  + " ,  occup_ped  smallint  " &
	  + "  ,  magazzino  smallint  " &
	  + "  ,  id_confermaordine  integer " &
	  + ") "
	db_crea_table( k_table, k_sql)

	setpointer(kkg.pointer_default)
	
catch(uo_exception kuo_exception)
	throw kuo_exception

finally
		db_disconnetti( )


end try


end subroutine

public subroutine u_crea_tb_crm_pt () throws uo_exception;//---------------------------------------------------------------------------------------------------------------------------
//---
//--- Crea il database di scambio con il CRM
//--- 
//--- lancia exception
//---------------------------------------------------------------------------------------------------------------------------
//
string k_table, k_sql

try 

	setpointer(kkg.pointer_attesa)

	db_connetti( )

//	EXECUTE IMMEDIATE "create database db_crm_m2000;" using this;
//	if this.sqlcode = 0 then 
//		commit using this;
//	end if


	k_table = "crm_pt"
	k_sql = "CREATE TABLE  crm_pt   " &
	  + "( cod_pt  char(12)  " &
	  + ",  descr  nvarchar(50)  " &
	  + ",  tipo_cicli  nvarchar(16) " & 
	  + ",  fila_1  integer ,  fila_2  integer ,  fila_1p  smallint ,  fila_2p  smallint  " &
	  + ",  dose  numeric(6,2) ,  densita  nvarchar(20) ,  dose_min  numeric(6,2) ,  dose_max  numeric(6,2)  " &
	  + ",  composizione  nvarchar(80)  " &
	  + ",  peso  nvarchar(20)  " &
	  + ",  routine  char(1)  " &
	  + ",  dosimetrie_spec  nvarchar(80)  " &
	  + ",  note_descr  nvarchar(255)  " &
	  + ",  tipo  nvarchar(24)  " &
	  + ",  magazzino  smallint  " &
	  + ",  misure  nvarchar(24) " &
	  + ") "
	db_crea_table( k_table, k_sql)
	

	setpointer(kkg.pointer_default)
	
catch(uo_exception kuo_exception)
	throw kuo_exception

finally
		db_disconnetti( )


end try


end subroutine

public subroutine u_crea_tb_crm_previsioni () throws uo_exception;//---------------------------------------------------------------------------------------------------------------------------
//---
//--- Crea il database di scambio con il CRM
//--- 
//--- lancia exception
//---------------------------------------------------------------------------------------------------------------------------
//
string k_table, k_sql

try 

	setpointer(kkg.pointer_attesa)

	db_connetti( )

//	EXECUTE IMMEDIATE "create database db_crm_m2000;" using this;
//	if this.sqlcode = 0 then 
//		commit using this;
//	end if

	
	k_table = "crm_previsioni"
	k_sql = "CREATE TABLE  crm_previsioni   " &
	  + "( id_cliente   integer  " &
	  + " ,  mese  smallint  " &
	  + " ,  anno  smallint  " &
	  + " ,  colli  smallint  " &
	  + " ,  importo   numeric(15,2)  " &
	  + ") "
	db_crea_table( k_table, k_sql)

	setpointer(kkg.pointer_default)
	
catch(uo_exception kuo_exception)
	throw kuo_exception

finally
		db_disconnetti( )


end try


end subroutine

public subroutine u_crea_tb_crm_cntr_tot_mese () throws uo_exception;//---------------------------------------------------------------------------------------------------------------------------
//---
//--- Crea il database di scambio con il CRM
//--- 
//--- lancia exception
//---------------------------------------------------------------------------------------------------------------------------
//
string k_table, k_sql

try 

	setpointer(kkg.pointer_attesa)

	db_connetti( )

//	EXECUTE IMMEDIATE "create database db_crm_m2000;" using this;
//	if this.sqlcode = 0 then 
//		commit using this;
//	end if

	
	k_table = "crm_cntr_tot_mese"
	k_sql = "CREATE TABLE  crm_cntr_tot_mese   " &
	  + "( id_cliente   integer  " &
	  + "  ,  id_confermaordine  integer " &
	  + " ,  mese  smallint  " &
	  + " ,  anno  smallint  " &
	  + " ,  colli  smallint  " &
	  + " ,  pedane  numeric(6,1)  " &
	  + "  ,  importo_fatturato  numeric(15,2)  " &
	  + "  ,  importo_da_fatturare  numeric(15,2)  " &
	  + ") "
	db_crea_table( k_table, k_sql)


	setpointer(kkg.pointer_default)
	
catch(uo_exception kuo_exception)
	throw kuo_exception

finally
		db_disconnetti( )


end try


end subroutine

public function st_esito db_crea_table (string k_table, string k_sql) throws uo_exception;//-----------------------------------------------------------------------------------------------------------------------------------
//--- 
//--- CREA TABELLA 
//---
//--- Par. input	: k_table = nome della tabella
//--- 		         : k_sql = ddl della tabella
//---
//--- Ritorna st_esito : Vedi Standard
//---   
//-----------------------------------------------------------------------------------------------------------------------------------
string k_sql_d
st_esito kst_esito
st_errori_gestione kst_errori_gestione


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto =  this.classname()


//--- Cancello e ricreo view/tab
	k_sql_d = "drop view " + trim(k_table) + "  " 
	EXECUTE IMMEDIATE :k_sql_d using this;
	if this.sqlcode = 0 then 
		commit using this;
	end if
	k_sql_d = "drop table " + trim(k_table) + "  " 
	EXECUTE IMMEDIATE :k_sql_d using this;
	if this.sqlcode = 0 then 
		commit using this;
	end if
	
//	k_sql = " CREATE TABLE  " + trim(k_table) + "  (	" + k_sql + " ) "
	EXECUTE IMMEDIATE :k_sql using this;
	kst_esito.sqlerrtext = "Generazione terminata correttamente "
	if this.sqlcode <> 0 then
		if this.sqlcode > 0 then
			kst_esito.esito = kkg_esito.db_wrn
			kst_esito.sqlcode = this.sqlcode
			kst_esito.sqlerrtext = "Anomalie durante generazione Table '" &
			                       + trim(k_table) + "' err.: " + trim(this.SQLErrText)
		else
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = this.sqlcode
			kst_esito.sqlerrtext = "Generazione Table '" &
			                       + trim(k_table) + "' non riuscita: " + trim(this.SQLErrText)
		end if
		rollback using this;

		if kst_esito.sqlcode < 0 then
			
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		end if
		
//--- scrive l'errore su LOG
//		kst_errori_gestione.nome_oggetto = this.classname()
//		kst_errori_gestione.sqlsyntax = trim(kst_esito.sqlerrtext)
//		kst_errori_gestione.sqlerrtext = trim(this.SQLErrText)
//		kst_errori_gestione.sqldbcode = this.sqlcode
//		kst_errori_gestione.sqlca = this
//		kuf_data_base.errori_gestione(kst_errori_gestione)

	else
		commit using this;
	end if


return kst_esito
end function

on kuo_sqlca_db_crm.create
call super::create
end on

on kuo_sqlca_db_crm.destroy
call super::destroy
end on

event constructor;call super::constructor;//
 ki_db_descrizione = "DB di scambio dati con il CRM"
end event

