$PBExportHeader$kuf_armo_nt.sru
forward
global type kuf_armo_nt from kuf_parent
end type
end forward

global type kuf_armo_nt from kuf_parent
end type
global kuf_armo_nt kuf_armo_nt

type variables
//
private st_tab_armo_nt ki_st_tab_armo_nt

end variables

forward prototypes
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public subroutine set_id_armo (long a_id_armo)
public subroutine set_st_tab_armo_nt (st_tab_armo_nt a_st_tab_armo_nt)
public function st_tab_armo_nt get_st_tab_armo_nt ()
public function boolean if_rimozione_ok (st_tab_armo_nt ast_tab_armo_nt) throws uo_exception
public function boolean tb_delete (st_tab_armo_nt ast_tab_armo_nt) throws uo_exception
public function boolean get_note (ref st_tab_armo_nt kst_tab_armo_nt) throws uo_exception
public subroutine if_isnull_armo_nt (ref st_tab_armo_nt kst_tab_armo_nt)
public subroutine tb_update_armo_nt (ref st_tab_armo_nt ast_tab_armo_nt) throws uo_exception
end prototypes

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//--- torno sempre OK
return true
end function

public subroutine set_id_armo (long a_id_armo);//
ki_st_tab_armo_nt.id_armo = a_id_armo

end subroutine

public subroutine set_st_tab_armo_nt (st_tab_armo_nt a_st_tab_armo_nt);//
ki_st_tab_armo_nt = a_st_tab_armo_nt

end subroutine

public function st_tab_armo_nt get_st_tab_armo_nt ();//
return ki_st_tab_armo_nt 


end function

public function boolean if_rimozione_ok (st_tab_armo_nt ast_tab_armo_nt) throws uo_exception;//
//====================================================================
//=== Torna se i record delle NOTE possono essere RIMOSSI
//=== 
//=== Input: st_tab_armo_nt.id_armo     
//=== Output:                   
//=== Ritorna: true = ok può essere rimosso
//===           		  
//====================================================================
//
boolean	k_return = false
st_tab_arsp kst_tab_arsp
kuf_sped kuf1_sped


if ast_tab_armo_nt.id_armo > 0 then
	
	kuf1_sped = create kuf_sped
	kst_tab_arsp.id_armo = ast_tab_armo_nt.id_armo
	if kuf1_sped.get_colli_x_id_armo(kst_tab_arsp) > 0 then
	else
		k_return = true
	end if
end if

return k_return
end function

public function boolean tb_delete (st_tab_armo_nt ast_tab_armo_nt) throws uo_exception;//
//-------------------------------------------------------------------------------------------------------
//--- Cancella il rek dalla tabella ARMO_NT
//--- 
//--- Input: st_tab_meca_qtna.id_armo
//--- Ritorna TRUE=CANCELLATO
//---   
//--- Lancia EXCEPTION        	
//---           	
//--------------------------------------------------------------------------------------------------------
//
boolean k_return=false
st_esito kst_esito
boolean k_autorizza


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	if ast_tab_armo_nt.id_armo > 0 then
	
	//--- controlla se utente autorizzato alla funzione in atto
		k_autorizza = if_sicurezza(kkg_flag_modalita.cancellazione)
	
		if k_autorizza then

			delete from armo_nt
				where id_armo = :ast_tab_armo_nt.id_armo
				using kguo_sqlca_db_magazzino ;
				
			if kguo_sqlca_db_magazzino.sqlcode <> 0 then
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Cancellazione 'Note riga Lotto' (id_armo: " + string(ast_tab_armo_nt.id_armo) + ") ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
				if kguo_sqlca_db_magazzino.sqlcode = 100 then
					kst_esito.esito = kkg_esito.not_fnd
				else
					if kguo_sqlca_db_magazzino.sqlcode > 0 then
						kst_esito.esito = kkg_esito.db_wrn
					else
						kst_esito.esito = kkg_esito.db_ko
					end if
				end if
			
			end if
		
	//---- COMMIT....	
			if kst_esito.esito = kkg_esito.db_ko then
				if ast_tab_armo_nt.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_armo_nt.st_tab_g_0.esegui_commit) then
					kGuf_data_base.db_rollback_1( )
				end if
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
				
			else
				if ast_tab_armo_nt.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_armo_nt.st_tab_g_0.esegui_commit) then
					kGuf_data_base.db_commit_1( )
				end if
				
				k_return = TRUE    //OK CANCELLATO
				
			end if
		end if
	end if
	
	
return k_return

end function

public function boolean get_note (ref st_tab_armo_nt kst_tab_armo_nt) throws uo_exception;//
//====================================================================
//=== Torna le Note 
//=== 
//=== Input : kst_tab_armo_nt.id_armo 
//=== Ritorna: TRUE = note trovate almeno su una riga
//=== Lancia Exception  
//====================================================================
boolean k_return = false
st_esito kst_esito
	

kst_esito.esito = kkg_esito.ok  
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

	
	if kst_tab_armo_nt.id_armo > 0 then  
		
		select  
				  note_1,
				  note_2,
				  note_3,
				  note_4,
				  note_5,
				  note_6,
				  note_7,
				  note_8,
				  note_9,
				  note_10
		  into
				 :kst_tab_armo_nt.note[1],
				 :kst_tab_armo_nt.note[2],
				 :kst_tab_armo_nt.note[3],
				 :kst_tab_armo_nt.note[4],
				 :kst_tab_armo_nt.note[5],
				 :kst_tab_armo_nt.note[6],
				 :kst_tab_armo_nt.note[7],
				 :kst_tab_armo_nt.note[8],
				 :kst_tab_armo_nt.note[9],
				 :kst_tab_armo_nt.note[10]
			from armo_nt
			where id_armo = :kst_tab_armo_nt.id_armo 
			using kguo_sqlca_db_magazzino;

		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Lettura Note riga Lotto, id " + string(kst_tab_armo_nt.id_armo) + " " &
										 + "~n~r"  + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

	end if
	
	if_isnull_armo_nt(kst_tab_armo_nt)
	
//--- se trovo almeno 1 nota allora torna a TRUE	
	if kst_tab_armo_nt.note[1] > " " &
				 or kst_tab_armo_nt.note[2] > " " &
				 or kst_tab_armo_nt.note[3] > " " &
				 or kst_tab_armo_nt.note[4] > " " &
				 or kst_tab_armo_nt.note[5] > " " &
				 or kst_tab_armo_nt.note[6] > " " &
				 or kst_tab_armo_nt.note[7] > " " &
				 or kst_tab_armo_nt.note[8] > " " &
				 or kst_tab_armo_nt.note[9] > " " &
				 or kst_tab_armo_nt.note[10] > " " then
		k_return = true	 
	end if
	
	
	
	
return k_return

end function

public subroutine if_isnull_armo_nt (ref st_tab_armo_nt kst_tab_armo_nt);//---
//--- toglie i NULL ai campi della tabella 
//---
if isnull(kst_tab_armo_nt.id_armo) then kst_tab_armo_nt.id_armo = 0
if isnull(kst_tab_armo_nt.note[1]) then kst_tab_armo_nt.note[1] = "" 
if isnull(kst_tab_armo_nt.note[2]) then kst_tab_armo_nt.note[2] = "" 
if isnull(kst_tab_armo_nt.note[3]) then kst_tab_armo_nt.note[3] = "" 
if isnull(kst_tab_armo_nt.note[4]) then kst_tab_armo_nt.note[4] = "" 
if isnull(kst_tab_armo_nt.note[5]) then kst_tab_armo_nt.note[5] = "" 
if isnull(kst_tab_armo_nt.note[6]) then kst_tab_armo_nt.note[6] = "" 
if isnull(kst_tab_armo_nt.note[7]) then kst_tab_armo_nt.note[7] = "" 
if isnull(kst_tab_armo_nt.note[8]) then kst_tab_armo_nt.note[8] = "" 
if isnull(kst_tab_armo_nt.note[9]) then kst_tab_armo_nt.note[9] = "" 
if isnull(kst_tab_armo_nt.note[10]) then kst_tab_armo_nt.note[10] = "" 


end subroutine

public subroutine tb_update_armo_nt (ref st_tab_armo_nt ast_tab_armo_nt) throws uo_exception;//
//====================================================================
//=== Aggiunge riga nella tabella ARMO_NT
//=== 
//=== Input: st_tab_armo_nt
//===
//=== Ritorna tab. ST_ESITO, Esiti:  STANDARD; 
//=== 
//====================================================================
long k_rcn
int k_presente=0, k_ctr=0
boolean k_rc
st_esito kst_esito
st_open_w kst_open_w


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
//	kst_tab_meca.x_datins = kGuf_data_base.prendi_x_datins()
//	kst_tab_meca.x_utente = kGuf_data_base.prendi_x_utente()

	if_isnull_armo_nt(ast_tab_armo_nt)

	if ast_tab_armo_nt.id_armo > 0 then
	else
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Aggiornamento delle Note Lotto non eseguito, manca ID riga lotto"
		kst_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- controlla se utente autorizzato alla funzione in atto
	kst_open_w.flag_modalita = kkg_flag_modalita.modifica
	k_rc = if_sicurezza(kst_open_w.flag_modalita)

	if not k_rc then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Modifica Note Lotto non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- Ci sono delle NOTE oppure array vuota?
	k_ctr = 1
	do until trim(ast_tab_armo_nt.note[k_ctr]) > " " or k_ctr = 10 
		k_ctr++
	loop

//---- verifica se sono presenti le note su DB
	k_presente = 0
	select distinct 1
	   into :k_presente
		from armo_nt
	   where id_armo =:ast_tab_armo_nt.id_armo
					using kguo_sqlca_db_magazzino;

	if k_presente = 1 then

//--- ho trovato almeno una nota piena Aggiorna altrimenti DELETE!	
		if trim(ast_tab_armo_nt.note[k_ctr]) > " " then 
			update armo_nt 
					set note_1 = :ast_tab_armo_nt.note[1],
					 note_2 = :ast_tab_armo_nt.note[2],
					 note_3 = :ast_tab_armo_nt.note[3],
					 note_4 = :ast_tab_armo_nt.note[4],
					 note_5 = :ast_tab_armo_nt.note[5],
					 note_6 = :ast_tab_armo_nt.note[6],
					 note_7 = :ast_tab_armo_nt.note[7],
					 note_8 = :ast_tab_armo_nt.note[8],
					 note_9 = :ast_tab_armo_nt.note[9],
					 note_10 = :ast_tab_armo_nt.note[10]
		   where id_armo =:ast_tab_armo_nt.id_armo
					using kguo_sqlca_db_magazzino;
		else
			tb_delete(ast_tab_armo_nt)
		end if
	else

//--- ho trovato almeno una nota piena Carica altrimenti NULLA		
		if trim(ast_tab_armo_nt.note[k_ctr]) > " " then 
			INSERT INTO armo_nt
				( id_armo,   
				  note_1,
				  note_2,
				  note_3,
				  note_4,
				  note_5,
				  note_6,
				  note_7,
				  note_8,
				  note_9,
				  note_10
				)  
		  VALUES 
					( 
					:ast_tab_armo_nt.id_armo,   
					 :ast_tab_armo_nt.note[1],
					 :ast_tab_armo_nt.note[2],
					 :ast_tab_armo_nt.note[3],
					 :ast_tab_armo_nt.note[4],
					 :ast_tab_armo_nt.note[5],
					 :ast_tab_armo_nt.note[6],
					 :ast_tab_armo_nt.note[7],
					 :ast_tab_armo_nt.note[8],
					 :ast_tab_armo_nt.note[9],
					 :ast_tab_armo_nt.note[10]
					)  
					using kguo_sqlca_db_magazzino;
		end if
	end if

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante inserimento Tab.dati Note Lotto (armo_nt) "  + "~n~r"  + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
			
catch (uo_exception kuo_exception)			
	if ast_tab_armo_nt.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_armo_nt.st_tab_g_0.esegui_commit) then
		kst_esito = kguo_sqlca_db_magazzino.db_commit( )
	end if
	throw kuo_exception

end try
	

end subroutine

on kuf_armo_nt.create
call super::create
end on

on kuf_armo_nt.destroy
call super::destroy
end on

