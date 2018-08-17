$PBExportHeader$kuf_armo_out.sru
forward
global type kuf_armo_out from kuf_parent
end type
end forward

global type kuf_armo_out from kuf_parent
end type
global kuf_armo_out kuf_armo_out

forward prototypes
public subroutine get_all_id_armo_out (ref st_tab_armo_out ast_tab_armo_out[]) throws uo_exception
public function boolean tb_delete (st_tab_armo_out ast_tab_armo_out) throws uo_exception
public function long get_ultimo_id () throws uo_exception
public function st_esito u_check_dati (ref datastore ads_inp) throws uo_exception
public function long get_colli_x_id_armo (st_tab_armo_out ast_tab_armo_out) throws uo_exception
end prototypes

public subroutine get_all_id_armo_out (ref st_tab_armo_out ast_tab_armo_out[]) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Legge tab armo_out (tab ricorsiva)  per trovare tutti i record coinvolti con una determianto id_armo_out
//--- 
//--- Inp:  st_tab_armo_out[1].id_armo_out
//--- out: array st_tab_armo_out[] con tutti id_armo_out coinvolti
//---         
//---   
//--------------------------------------------------------------------------------------------------------------------------------------------------------
long k_ind=1
st_esito kst_esito
//datastore kds_1


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

declare c_get_all_id_armo_out cursor for
	select  a.id_armo_out
					from armo_out a
 				start with id_armo = :ast_tab_armo_out[1].id_armo
				using kguo_sqlca_db_magazzino;


try
	
	if  ast_tab_armo_out[1].id_armo = 0 or isnull (ast_tab_armo_out[1].id_armo) then
		open c_get_all_id_armo_out;
		
		if  kguo_sqlca_db_magazzino.sqlcode = 0 then
			k_ind = 0
			do while kguo_sqlca_db_magazzino.sqlcode = 0
				k_ind ++
				fetch c_get_all_id_armo_out  into :ast_tab_armo_out[k_ind].id_armo_out;
				if kguo_sqlca_db_magazzino.sqlcode < 0 then
					kst_esito.esito = kkg_esito.db_ko
					kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
					kst_esito.sqlerrtext = "Errore durante lettura riga Voci di Listino (armo_out). ID=" + string(ast_tab_armo_out[1].id_armo)
					kguo_exception.inizializza( )
					kguo_exception.set_esito(kst_esito)				
					throw kguo_exception
				end if
	
			loop
			close c_get_all_id_armo_out;
		else
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.sqlerrtext = "Errore preparazione lettura riga Voci di Listino (armo_out). ID=" + string(ast_tab_armo_out[1].id_armo)
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)				
				throw kguo_exception
			end if
		end if
//		kst_esito.esito = kkg_esito.no_esecuzione
//		kst_esito.sqlerrtext = "Voce Listino non eliminata. Manca ID"
//		kguo_exception.inizializza( )
//		kguo_exception.set_esito(kst_esito)
	end if

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	

finally
	

end try	




end subroutine

public function boolean tb_delete (st_tab_armo_out ast_tab_armo_out) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Cancella il rek dalla tabella armo_out
//--- 
//--- Inp:  st_tab_armo_out.id_armo_out
//--- Ritorna:  TRUE=operazione effettuata; FALSE=operazione non eseguita
//---   
//--------------------------------------------------------------------------------------------------------------------------------------------------------

boolean k_return = false
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try
	
		
//--- AUTORIZZATO ? --------------------------------------------------------------------------------------------------------------------------------------------------------
	if NOT this.if_sicurezza(kkg_flag_modalita.cancellazione) then
		kst_esito.esito = kkg_esito.no_aut
		kst_esito.SQLErrText = "Cancellazione 'Scarico Manuale' non Autorizzata (id riga=" + string(ast_tab_armo_out.id_armo_out)+": ~n~r" + "La funzione richiesta non e' stata abilitata"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- CANCELLA --------------------------------------------------------------------------------------------------------------------------------------------------------

//--- elimina riga		
	delete from armo_out
				where id_armo_out = :ast_tab_armo_out.id_armo_out
				using kguo_sqlca_db_magazzino;
			
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Cancellazione 'Scarico Manuale' (armo_out)  id=" + string(ast_tab_armo_out.id_armo_out) + ": " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = KKG_ESITO.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = KKG_ESITO.db_wrn
			else
				kst_esito.esito = KKG_ESITO.db_ko
			end if
		end if
	end if
		
//---- COMMIT.... 
	if kst_esito.esito = kkg_esito.db_ko then
		if ast_tab_armo_out.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_armo_out.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
		
//--- lancio EXCEPTION			
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	else
		k_return = true
		
		if ast_tab_armo_out.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_armo_out.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
		
		
	end if

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	

finally
	

end try	


return k_return

end function

public function long get_ultimo_id () throws uo_exception;//
//====================================================================
//=== Torna l'ultimo ID riga LISTINO caricato in assoluto
//=== 
//=== Input: 
//=== Output: 
//=== Ritorna il codice id_armo_out se c'e'
//=== 
//=== Lancia EXCEPTION
//=== 
//====================================================================
long k_return = 0
st_esito kst_esito
st_tab_armo_out kst_tab_armo_out


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_armo_out.id_armo_out = 0
	
   SELECT   max(id_armo_out)
       into :kst_tab_armo_out.id_armo_out
		 FROM armo_out
			using sqlca;
	
	if sqlca.sqlcode = 0 then
		k_return = kst_tab_armo_out.id_armo_out
	else
		if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura riga listino  (cercato MAX CODICE) ~n~r:" + trim(sqlca.SQLErrText)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
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
//------------------------------------------------------------------------------------------------------
//
int k_errori = 0
long k_nr_righe, k_colli_sca=0, k_colli_max=0
long k_riga
string k_tipo_errore="0"
st_esito kst_esito
st_tab_armo kst_tab_armo
kuf_armo kuf1_armo


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	k_nr_righe = ads_inp.rowcount()
	for k_riga = 1 to k_nr_righe 

		if ads_inp.getitemstatus(k_riga, 0, primary!) = newmodified! &
				or ads_inp.getitemstatus(k_riga, 0, primary!) = datamodified! then 
				
			if trim(ads_inp.object.descr[k_riga]) > " "  then
			else
				k_errori ++
				k_tipo_errore=kkg_esito.DATI_INSUFF      // errore in questo campo: dati insuff.
				ads_inp.object.descr.tag = k_tipo_errore 
				kst_esito.esito = kkg_esito.err_formale
				kst_esito.sqlerrtext = "Manca il valore nel campo " + trim(ads_inp.object.descr_t.text) +  "~n~r"  
			end if
			
			if ads_inp.object.colli[k_riga] > 0  then
			else
				k_errori ++
				k_tipo_errore=kkg_esito.DATI_INSUFF      // errore in questo campo: dati insuff.
				ads_inp.object.colli.tag = k_tipo_errore 
				kst_esito.esito = kkg_esito.err_formale
				kst_esito.sqlerrtext += "Manca il valore nel campo " + trim(ads_inp.object.colli_t.text) +  "~n~r"  
			end if
	
		end if
		
	end for
	
//--- controlla se nr colli compatibile	
	if ads_inp.rowcount() > 0 then
		for k_riga = 1 to k_nr_righe // conteggio colli che sto scaricando
			if ads_inp.getitemnumber(k_riga, "id_armo") = 0 then
				k_colli_sca += ads_inp.getitemnumber(k_riga, "colli")
			end if
		end for	
		kuf1_armo = create kuf_armo
		kst_tab_armo.id_armo = ads_inp.getitemnumber(1, "id_armo")
		k_colli_max = kuf1_armo.get_colli_in_giacenza(kst_tab_armo)
		if k_colli_sca > k_colli_max  then
			k_errori ++
			k_tipo_errore=kkg_esito.ERR_LOGICO      // errore in questo campo: troppi colli
			ads_inp.object.colli.tag = k_tipo_errore 
			kst_esito.esito = kkg_esito.err_logico
			kst_esito.sqlerrtext += "Troppi colli scaricati max: " + string(k_colli_max) +  "~n~r"  
		end if
	end if
	
	if k_tipo_errore= kkg_esito.OK or k_tipo_errore=kkg_esito.DB_WRN  then
		for k_riga = 1 to k_nr_righe 
			if ads_inp.getitemnumber(k_riga, "id_armo_out") > 0 then
			else // controlla solo se nuova riga
				if ads_inp.getitemdate(k_riga, "armo_out_data") <> kguo_g.get_dataoggi( ) then
					k_errori ++
					k_tipo_errore=kkg_esito.DATI_WRN      // errore in questo campo: avvertimento
					ads_inp.object.colli.tag = k_tipo_errore 
					kst_esito.esito = kkg_esito.DATI_WRN 
					kst_esito.sqlerrtext += "Data impostata " + string(ads_inp.getitemdate(k_riga, "armo_out_data")) + " diversa da oggi " + string( kguo_g.get_dataoggi( )) +  "~n~r"  
				end if
			end if
		end for
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if k_errori > 0 then
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
end try


return kst_esito


 
 
 
end function

public function long get_colli_x_id_armo (st_tab_armo_out ast_tab_armo_out) throws uo_exception;//
//====================================================================
//=== Torna il nr colli scaricati x id_armo
//=== 
//=== Input : st_tab_armo_out.id_armo 
//=== Ritorna:	st_tab_armo_out_out.colli = tot colli scaricati x id_armo
//===   
//====================================================================
st_esito kst_esito

 
kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try
	ast_tab_armo_out.colli = 0

	select sum(armo_out.colli)
		into
			:ast_tab_armo_out.colli
		from armo_out 
		where armo_out.id_armo = :ast_tab_armo_out.id_armo
		using kguo_sqlca_db_magazzino ;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante lettura colli scaricati manualmente " + "~n~r"  + trim(kguo_sqlca_db_magazzino.sqlerrtext)
		kguo_exception.inizializza()
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception
	end if
	
	if isnull(ast_tab_armo_out.colli) then ast_tab_armo_out.colli = 0
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	  
end try

return ast_tab_armo_out.colli

end function

on kuf_armo_out.create
call super::create
end on

on kuf_armo_out.destroy
call super::destroy
end on

