$PBExportHeader$kuf_meca_fconv.sru
forward
global type kuf_meca_fconv from kuf_parent
end type
end forward

global type kuf_meca_fconv from kuf_parent
end type
global kuf_meca_fconv kuf_meca_fconv

type variables

end variables

forward prototypes
public function boolean tb_add (st_tab_meca_fconv ast_tab_meca_fconv) throws uo_exception
public function boolean tb_update (st_tab_meca_fconv ast_tab_meca_fconv) throws uo_exception
public function boolean set_forza_convalida (st_tab_meca_fconv ast_tab_meca_fconv) throws uo_exception
public function boolean if_convalida_forzata (st_tab_meca_fconv ast_tab_meca_fconv) throws uo_exception
public function boolean if_esiste (st_tab_meca_fconv ast_tab_meca_fconv) throws uo_exception
end prototypes

public function boolean tb_add (st_tab_meca_fconv ast_tab_meca_fconv) throws uo_exception;// funzione che fa l'insert sulla tabella meca_fconv
boolean	k_return = false
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

	
try
	if if_sicurezza(kkg_flag_modalita.modifica) then // ,"Inserimento 'Evento quarantena su lotto' non Autorizzata:") then

	//--- imposto dati utente e data aggiornamento
		ast_tab_meca_fconv.x_datins = kGuf_data_base.prendi_x_datins()
		ast_tab_meca_fconv.x_utente = kGuf_data_base.prendi_x_utente()
		
	//--- toglie valori NULL
//		if_isnull(ast_tab_meca_fconv)
		  
		  INSERT INTO meca_fconv  
				( id_meca,   
				  x_datins_fconv,   
				  x_utente_fconv,   
				  x_datins,   
				  x_utente)  
	  VALUES ( 
				  :ast_tab_meca_fconv.id_meca,   
				  :ast_tab_meca_fconv.x_datins_fconv,   
				  :ast_tab_meca_fconv.x_utente_fconv,   
				  :ast_tab_meca_fconv.x_datins,   
				  :ast_tab_meca_fconv.x_utente )  
		USING kguo_sqlca_db_magazzino;
		
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore in carico Forzatura Convalida~n~r" + trim(sqlca.SQLErrText) 
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito)
			end if
		else
			k_return = true
		end if

		if ast_tab_meca_fconv.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_fconv.st_tab_g_0.esegui_commit) then
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
				kguo_sqlca_db_magazzino.db_commit( )
			else
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
		end if				

		if kst_esito.esito = kkg_esito.db_ko then
			throw kguo_exception
		end if

	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception 
	
end try


return k_return

end function

public function boolean tb_update (st_tab_meca_fconv ast_tab_meca_fconv) throws uo_exception;// funzione che fa update sulla tabella meca_fconv
boolean	k_return = false
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

	
try
	if if_sicurezza(kkg_flag_modalita.modifica) then // ,"Inserimento 'Evento quarantena su lotto' non Autorizzata:") then

	//--- imposto dati utente e data aggiornamento
		ast_tab_meca_fconv.x_datins_fconv = ast_tab_meca_fconv.x_datins_fconv
		ast_tab_meca_fconv.x_utente_fconv = ast_tab_meca_fconv.x_utente_fconv
		ast_tab_meca_fconv.x_datins = kGuf_data_base.prendi_x_datins()
		ast_tab_meca_fconv.x_utente = kGuf_data_base.prendi_x_utente()
		
	//--- toglie valori NULL
//		if_isnull(ast_tab_meca_fconv)
		  
		  update meca_fconv  
				set id_meca = :ast_tab_meca_fconv.id_meca
				  ,x_datins_fconv = :ast_tab_meca_fconv.x_datins_fconv   
				  ,x_utente_fconv = :ast_tab_meca_fconv.x_utente_fconv 
				  ,x_datins = :ast_tab_meca_fconv.x_datins
				  ,x_utente = :ast_tab_meca_fconv.x_utente 
		USING kguo_sqlca_db_magazzino;
		
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore in aggiornameneto Forzatura Convalida~n~r" + trim(sqlca.SQLErrText) 
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito)
			end if
		else
			k_return = true
		end if

		if ast_tab_meca_fconv.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_fconv.st_tab_g_0.esegui_commit) then
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
				kguo_sqlca_db_magazzino.db_commit( )
			else
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
		end if				

		if kst_esito.esito = kkg_esito.db_ko then
			throw kguo_exception
		end if

	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception 
	
end try


return k_return

end function

public function boolean set_forza_convalida (st_tab_meca_fconv ast_tab_meca_fconv) throws uo_exception;// funzione che fa l'insert sulla tabella meca_fconv
boolean		k_return = false
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
boolean k_autorizza

//"Cancellazione 'Evento quarantena su lotto' non Autorizzata:

	
try
	if if_esiste(ast_tab_meca_fconv) then

		if if_convalida_forzata(ast_tab_meca_fconv) then
		//--- spegne la Forzatura
			ast_tab_meca_fconv.x_datins_fconv = datetime(date(0))
			ast_tab_meca_fconv.x_utente_fconv = ""
		else
		//--- riattiva la Forzatura
			ast_tab_meca_fconv.x_datins_fconv = kGuf_data_base.prendi_x_datins()
			ast_tab_meca_fconv.x_utente_fconv = kGuf_data_base.prendi_x_utente()
			k_return = tb_update(ast_tab_meca_fconv)  
		end if		
	else
		
		ast_tab_meca_fconv.x_datins_fconv = kGuf_data_base.prendi_x_datins()
		ast_tab_meca_fconv.x_utente_fconv = kGuf_data_base.prendi_x_utente()
		k_return = tb_add(ast_tab_meca_fconv)
		
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception 
	
end try



return k_return
end function

public function boolean if_convalida_forzata (st_tab_meca_fconv ast_tab_meca_fconv) throws uo_exception;// funzione che verifica se c'e' una forzatura attiva
boolean	k_return = false
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

	
try
	
	if ast_tab_meca_fconv.id_meca > 0 then

		select 
			  x_datins_fconv,   
			  x_utente_fconv   
			into
				  :ast_tab_meca_fconv.x_datins_fconv,   
				  :ast_tab_meca_fconv.x_utente_fconv
		  from meca_fconv  
		  where id_meca = :ast_tab_meca_fconv.id_meca
		  using kguo_sqlca_db_magazzino;
	  
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in verifica Forzatura Convalida~n~r" + trim(sqlca.SQLErrText) 
			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito)
			throw kguo_exception
		else
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
				if ast_tab_meca_fconv.x_datins_fconv > datetime(date(0)) &
						and trim(ast_tab_meca_fconv.x_utente_fconv) >  " " then
					k_return = true
				end if
			end if
		end if
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception 
	
end try


return k_return

end function

public function boolean if_esiste (st_tab_meca_fconv ast_tab_meca_fconv) throws uo_exception;// funzione che verifica l'esistenza del rek
boolean	k_return = false
int k_uno
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

	
try
	
	if ast_tab_meca_fconv.id_meca > 0 then

		select 1 
			into
				  :k_uno
			  from meca_fconv  
			  where id_meca = :ast_tab_meca_fconv.id_meca
			  using kguo_sqlca_db_magazzino;
	  
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in controllo esistenza dati di Forzatura Convalida~n~r" + trim(sqlca.SQLErrText) 
			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito)
			throw kguo_exception
		else
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
				if k_uno = 1 then
					k_return = true
				end if
			end if
		end if
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception 
	
end try


return k_return

end function

on kuf_meca_fconv.create
call super::create
end on

on kuf_meca_fconv.destroy
call super::destroy
end on

event constructor;call super::constructor;//--- solo per autorizzazione a FORZARE LA CONVALIDA Lotto anche con letture parziali dei dosimetri
//--- 

ki_msgErrDescr="Forza Convalida Lotto"
end event

