$PBExportHeader$kuf_meca_dosimbozza.sru
forward
global type kuf_meca_dosimbozza from kuf_parent
end type
end forward

global type kuf_meca_dosimbozza from kuf_parent
end type
global kuf_meca_dosimbozza kuf_meca_dosimbozza

type variables
 
end variables

forward prototypes
public function boolean get_id_meca_da_barcode_dosimetro (ref st_tab_meca_dosimbozza kst_tab_meca_dosimbozza) throws uo_exception
public function boolean tb_add_barcode (st_tab_meca_dosimbozza kst_tab_meca_dosimbozza) throws uo_exception
public function boolean if_esiste_barcode (st_tab_meca_dosimbozza kst_tab_meca_dosimbozza) throws uo_exception
public function boolean set_barcode_dosimetro (ref st_tab_meca_dosimbozza kst_tab_meca_dosimbozza) throws uo_exception
public function boolean if_esiste_barcode_dosimetro (ref st_tab_meca_dosimbozza kst_tab_meca_dosimbozza) throws uo_exception
public function boolean get_id_meca_da_barcode (ref st_tab_meca_dosimbozza kst_tab_meca_dosimbozza) throws uo_exception
public function integer get_barcode (ref st_tab_meca_dosimbozza kst_tab_meca_dosimbozza[]) throws uo_exception
public subroutine tb_delete_x_barcode_lav (st_tab_meca_dosimbozza ast_tab_meca_dosimbozza) throws uo_exception
public subroutine tb_delete_x_id_meca (st_tab_meca_dosimbozza ast_tab_meca_dosimbozza) throws uo_exception
public function integer if_esiste_barcode_lav (st_tab_meca_dosimbozza ast_tab_meca_dosimbozza) throws uo_exception
public function boolean if_esiste (st_tab_meca_dosimbozza ast_tab_meca_dosimbozza) throws uo_exception
public subroutine tb_delete (st_tab_meca_dosimbozza ast_tab_meca_dosimbozza) throws uo_exception
public function integer if_esiste_barcode_lav_con_dosim (st_tab_meca_dosimbozza ast_tab_meca_dosimbozza) throws uo_exception
public subroutine if_isnull (ref st_tab_meca_dosimbozza kst_tab_meca_dosimbozza)
public function date get_data_x_certif (ref st_tab_meca_dosimbozza kst_tab_meca_dosimbozza) throws uo_exception
public function long get_ultimo_id () throws uo_exception
public function long if_gia_usato_barcode (st_tab_meca_dosimbozza kst_tab_meca_dosimbozza) throws uo_exception
public function st_esito u_check_dati (ref datastore ads_inp) throws uo_exception
public function long if_gia_usato_dosimetro (st_tab_meca_dosimbozza ast_tab_meca_dosimbozza) throws uo_exception
end prototypes

public function boolean get_id_meca_da_barcode_dosimetro (ref st_tab_meca_dosimbozza kst_tab_meca_dosimbozza) throws uo_exception;//
//--------------------------------------------------------------------------------------------
//--- Torna ID_MECA da meca_dosimbozza per il barcode Dosimetro
//--- 
//--- 
//---  input: barcode_dosimetro
//---  Outout: ID_MECA
//---  Ritorna: TRUE x id_meca trovato
//---                                     
//--------------------------------------------------------------------------------------------
//
boolean k_return=FALSE
st_esito kst_esito


   kst_esito.esito = kkg_esito.ok
   kst_esito.sqlcode = 0
   kst_esito.SQLErrText = ""
   kst_esito.nome_oggetto = this.classname()



   SELECT max(id_meca)
          INTO 
               :kst_tab_meca_dosimbozza.id_meca 
          FROM meca_dosimbozza  
         WHERE meca_dosimbozza.barcode_dosimetro = :kst_tab_meca_dosimbozza.barcode_dosimetro
             using kguo_sqlca_db_magazzino;
         
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
   
		if isnull(kst_tab_meca_dosimbozza.id_meca) then 
         	kst_tab_meca_dosimbozza.id_meca = 0
      	end if
   
   else
      kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
      kst_esito.SQLErrText = "Tab.Dosimetri Lotto (dosimetro=" + trim(kst_tab_meca_dosimbozza.barcode_dosimetro) + ") " &
                            + "~n~r"  + trim(kguo_sqlca_db_magazzino.SQLErrText)
      if kguo_sqlca_db_magazzino.sqlcode = 100 then
         kst_esito.esito = kkg_esito.not_fnd
         kst_tab_meca_dosimbozza.id_meca = 0
      else
         if kguo_sqlca_db_magazzino.sqlcode > 0 then
            kst_esito.esito = kkg_esito.db_wrn
            kst_tab_meca_dosimbozza.id_meca = 0
         else  
            kst_esito.esito = kkg_esito.db_ko
         end if
      end if
   end if
 
	if kst_esito.esito = kkg_esito.db_ko then
		
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception
		
	end if

   	if kst_tab_meca_dosimbozza.id_meca > 0 then
		k_return = TRUE
	end if


return k_return

end function

public function boolean tb_add_barcode (st_tab_meca_dosimbozza kst_tab_meca_dosimbozza) throws uo_exception;//
//-------------------------------------------------------------------------------------------------------------
//--- Aggiunge Barcode nella tabella DOSIMETRIE LOTTI (meca_dosimbozza)
//--- 
//--- Input: kst_tab_meca_dosimbozza: id_meca, barcode, barcode_lav
//--- Out: TRUE=tutto OK
//--- lancia Exception: SI 
//--- 
//-------------------------------------------------------------------------------------------------------------
boolean k_return=false
boolean k_sicurezza=true
//long k_rcn
//st_tab_meca kst_tab_meca
st_esito kst_esito
st_open_w kst_open_w
kuf_barcode kuf1_barcode
kuf_sicurezza kuf1_sicurezza


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

	
	kst_tab_meca_dosimbozza.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_meca_dosimbozza.x_utente = kGuf_data_base.prendi_x_utente()

	if_isnull(kst_tab_meca_dosimbozza)

	if kst_tab_meca_dosimbozza.id_meca > 0 then
		
//--- 28.7.2010 disabilito la sicurezza su richiesta di Baglioni		
//		kuf1_barcode = create kuf_barcode
//		kst_open_w.flag_modalita = kkg_flag_modalita.modifica
//		kst_open_w.id_programma = kuf1_barcode.get_id_programma(kst_open_w.flag_modalita) // kkg_id_programma_riferimenti
//		destroy kuf1_barcode 
////--- controlla se utente autorizzato alla funzione in atto
//		kuf1_sicurezza = create kuf_sicurezza
//		k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
//		destroy kuf1_sicurezza
//	
		if not k_sicurezza then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Modifica dati Barcode Lotto non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata (" + trim(kst_open_w.id_programma) + "/" +trim(kst_open_w.flag_modalita) + ") "
			kst_esito.esito = kkg_esito.no_aut
			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito )		
			throw kguo_exception
			
		else

//--- esiste già il barcode? 
			if if_esiste(kst_tab_meca_dosimbozza) then
				
				
				update meca_dosimbozza
					 	set barcode_dosimetro = :kst_tab_meca_dosimbozza.barcode_dosimetro,
						x_datins = :kst_tab_meca_dosimbozza.x_datins, 
						x_utente =	:kst_tab_meca_dosimbozza.x_utente   
					where id_meca = :kst_tab_meca_dosimbozza.id_meca
					using kguo_sqlca_db_magazzino;
					
			else


				INSERT INTO meca_dosimbozza
						( 
						  barcode,
						  barcode_lav,
						  id_meca,   
						  barcode_dosimetro,
						  x_datins,
						  x_utente
						)  
				  VALUES 
							( 
							:kst_tab_meca_dosimbozza.barcode,   
							:kst_tab_meca_dosimbozza.barcode_lav,   
							:kst_tab_meca_dosimbozza.id_meca,   
							:kst_tab_meca_dosimbozza.barcode_dosimetro,   
							:kst_tab_meca_dosimbozza.x_datins,   
							:kst_tab_meca_dosimbozza.x_utente   
							)  
							using kguo_sqlca_db_magazzino;
			end if
	
			if kguo_sqlca_db_magazzino.sqlcode <> 0 then
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Errore durante aggiornamento Tab.Dosimetrie Lotti (meca_dosimbozza) "  + "~n~r"  + trim(kguo_sqlca_db_magazzino.SQLErrText)
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
				if kst_tab_meca_dosimbozza.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca_dosimbozza.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_rollback( )
				end if
				
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito )
				throw kguo_exception
				
			else
				if kst_tab_meca_dosimbozza.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca_dosimbozza.st_tab_g_0.esegui_commit) then
					kst_esito = kguo_sqlca_db_magazzino.db_commit( )
				end if
				if kst_esito.esito = kkg_esito.ok then
					k_return = TRUE
				end if
			end if
			
		end if
	
	end if
	


return k_return

end function

public function boolean if_esiste_barcode (st_tab_meca_dosimbozza kst_tab_meca_dosimbozza) throws uo_exception;//
//====================================================================
//=== Controllo se esiste gia' lo stesso Barcode Dosimetria sia in tabella BARCODE che nella meca_dosimbozza
//=== 
//=== Inp: barcode, id_meca (se omesso assume zero)
//=== Out: 
//=== Ritorna BOOLEAN : TRUE=ESISTE, FALSE=NON ESISTE;
//===   
//====================================================================
boolean k_return=false
st_esito kst_esito
int k_ctr
st_tab_barcode kst_tab_barcode
kuf_barcode kuf1_barcode
uo_exception kuo_exception


kst_esito.esito = kkg_esito.blok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try

	kuf1_barcode = create kuf_barcode

	if len(trim(kst_tab_meca_dosimbozza.barcode)) > 0 then

		
		if isnull(kst_tab_meca_dosimbozza.id_meca) then kst_tab_meca_dosimbozza.id_meca = 0

//--- controllo prima di tutto se esiste gia' un Barcode di Trattamento in tabella 
		kst_tab_barcode.barcode = kst_tab_meca_dosimbozza.barcode
		kst_tab_barcode.id_meca = kst_tab_meca_dosimbozza.id_meca	
		if not kuf1_barcode.if_esiste( kst_tab_barcode ) then

//--- Se non esiste allora cerco in tabella meca_dosimbozza			
			select 1
				into :k_ctr
				from meca_dosimbozza 
				where meca_dosimbozza.id_meca > :kst_tab_meca_dosimbozza.id_meca and meca_dosimbozza.barcode = :kst_tab_meca_dosimbozza.barcode
				using sqlca;
				
			if sqlca.sqlcode = 0 then
		
				if k_ctr = 1 then
					k_return = true
				end if
				
			else
				if sqlca.sqlcode = 100 then
					k_return = false
				else
					kst_esito.sqlcode = sqlca.sqlcode
					kst_esito.SQLErrText = "Errore durante verifica esistenza Barcode Dosimetria (meca_dosimbozza): " + kst_tab_meca_dosimbozza.barcode  + " ~n~r " + sqlca.sqlerrtext
					kuo_exception = create uo_exception
					kuo_exception.set_esito( kst_esito )
					throw kuo_exception
				end if
			end if
		end if
	end if


catch (uo_exception kuo1_exception)
	throw kuo1_exception
	

finally
	destroy kuf1_barcode
	

end try	
	
return k_return


end function

public function boolean set_barcode_dosimetro (ref st_tab_meca_dosimbozza kst_tab_meca_dosimbozza) throws uo_exception;//---
//--- Aggiorna Barcode Dosimetro in archivio
//---
//--- Inp.: st_tab_meca_dosimbozza id_meca, barcode, barcode_dosimetro 
//--- Out.: 
//--- Ritorna: TRUE = ok
//--- Lancia excepetion se errore
//--- 
boolean k_return = FALSE
long k_contati=0
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

		
	update meca_dosimbozza 
			set barcode_dosimetro = :kst_tab_meca_dosimbozza.barcode_dosimetro
		where meca_dosimbozza.id_meca = :kst_tab_meca_dosimbozza.id_meca
		     and meca_dosimbozza.barcode = :kst_tab_meca_dosimbozza.barcode
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Aggiornamento barcode Dosimetro in tab. Dosimetria Lotti (id Lotto=" + string(kst_tab_meca_dosimbozza.id_meca) + ")   ~n~r" + trim(SQLCA.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		
	end if


//---- COMMIT....	
	if kst_esito.esito = kkg_esito.db_ko then
		if kst_tab_meca_dosimbozza.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca_dosimbozza.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
		
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception
		
	else
		if kst_tab_meca_dosimbozza.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca_dosimbozza.st_tab_g_0.esegui_commit) then
			kst_esito = kguo_sqlca_db_magazzino.db_commit( )
		end if
	end if
	
	k_return=true

return k_return



end function

public function boolean if_esiste_barcode_dosimetro (ref st_tab_meca_dosimbozza kst_tab_meca_dosimbozza) throws uo_exception;//---
//--- Controlla se codice barcode Dosimetro esite in archivio (ultimo anno)
//---
//--- Inp.: st_tab_meca_dosimbozza  barcode_dosimetro = da controllare
//--- Out.: st_tab_meca_dosimbozza id_meca
//--- Ritorna: TRUE codice esistente
//--- Lancia excpetion se errore
//--- 
boolean k_return = FALSE
date k_data_meno1anno
long k_contati=0
st_esito kst_esito
uo_exception kuo_exception


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	try
		
		k_data_meno1anno = relativedate(kg_dataoggi, -365)

		select max(id_meca)
				into :kst_tab_meca_dosimbozza.id_meca
				from meca_dosimbozza inner join meca on meca_dosimbozza.id_meca = meca.id
			where meca_dosimbozza.id_meca <> :kst_tab_meca_dosimbozza.id_meca
					  and meca.data_int > :k_data_meno1anno
					  and barcode_dosimetro = :kst_tab_meca_dosimbozza.barcode_dosimetro
			using sqlca;

		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.Dosimetria Lotti (id Lotto=" + string(kst_tab_meca_dosimbozza.id_meca) + ")   ~n~r" + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			
			kuo_exception.set_esito( kst_esito )
			throw kuo_exception
		end if

//--- se ho trovato il codice allora torna TRUE
		if kst_tab_meca_dosimbozza.id_meca > 0 then
			k_return = TRUE
		end if
			
	catch (uo_exception kuo1_exception)
		throw kuo1_exception
	
	end try
	


return k_return



end function

public function boolean get_id_meca_da_barcode (ref st_tab_meca_dosimbozza kst_tab_meca_dosimbozza) throws uo_exception;//
//====================================================================
//=== Trova ID del Lotto dal Barcode Dosimetria in tabella meca_dosimbozza
//=== 
//=== Inp: barcode
//=== Out: id_meca 
//=== Ritorna BOOLEAN : TRUE=ESISTE, FALSE=NON ESISTE;
//===   
//====================================================================
boolean k_return=false
st_esito kst_esito


kst_esito.esito = kkg_esito.blok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


	if len(trim(kst_tab_meca_dosimbozza.barcode)) > 0 then


//--- Se non esiste allora cerco in tabella meca_dosimbozza			
		select distinct id_meca
			into :kst_tab_meca_dosimbozza.id_meca
			from meca_dosimbozza 
			where meca_dosimbozza.barcode = :kst_tab_meca_dosimbozza.barcode
			using kguo_sqlca_db_magazzino;
			
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
	
			k_return = true
			
		else
			if kguo_sqlca_db_magazzino.sqlcode = 100 then
				k_return = false
			else
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Errore durante lettura ID Lotto da Barcode Dosimetria (meca_dosimbozza): " + kst_tab_meca_dosimbozza.barcode  + " ~n~r " + kguo_sqlca_db_magazzino.sqlerrtext
				kguo_exception.inizializza()
				kguo_exception.set_esito( kst_esito )
				throw kguo_exception
			end if
		end if
	end if

	
return k_return


end function

public function integer get_barcode (ref st_tab_meca_dosimbozza kst_tab_meca_dosimbozza[]) throws uo_exception;//
//----------------------------------------------------------------------------------------------------
//--- Torna array di codici Barcode di Dosimetro (ce ne possono essere + di 1 x barcode di lavorazione)
//--- 
//--- Input : kst_tab_meca_dosimbozza_dosim.id_meca e barcode_lav
//--- Out: kst_tab_meca_dosimbozza_dosim[n].barcode 
//--- Ritorna: numero di barcode di dosimetria trovati
//---					
//--- Exception se erore con st_esito valorizzato
//---					
//---   
//-----------------------------------------------------------------------------------------------------
int k_return = 0
int k_ind=0
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_meca_dosimbozza[1].barcode = ""

	if kst_tab_meca_dosimbozza[1].id_meca > 0 then
	
		declare  c_get_barcode cursor for
			select barcode
				from meca_dosimbozza 
				where meca_dosimbozza.id_meca = :kst_tab_meca_dosimbozza[1].id_meca
				    and meca_dosimbozza.barcode_lav = :kst_tab_meca_dosimbozza[1].barcode_lav
					 group by barcode
					 order by barcode
				using kguo_sqlca_db_magazzino;

		open c_get_barcode;	
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			k_ind = 1

			fetch c_get_barcode into :kst_tab_meca_dosimbozza[k_ind].barcode;
			do while kguo_sqlca_db_magazzino.sqlcode = 0
				k_ind ++
				fetch c_get_barcode into :kst_tab_meca_dosimbozza[k_ind].barcode;
			loop

		end if
		close c_get_barcode;	
	
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_tab_meca_dosimbozza[1].barcode = ""
			
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore durante lettura cod. Barcode per il Dosimetri " + trim(kguo_sqlca_db_magazzino.sqlerrtext)
			kguo_exception.inizializza()
			kguo_exception.set_esito( kst_esito )
			throw  kguo_exception
		end if
		
		if k_ind > 0 then
			k_return = k_ind - 1
		else
			kst_tab_meca_dosimbozza[1].barcode = ""
		end if
	end if

	
return k_return


end function

public subroutine tb_delete_x_barcode_lav (st_tab_meca_dosimbozza ast_tab_meca_dosimbozza) throws uo_exception;//
//====================================================================
//=== Cancella il Dosimetro/i se appartiene al barcode di lavorazione
//=== Inp: barcode_lav
//=== Out:
//=== Ritorna:         Lancia Exception x errore
//====================================================================
boolean k_sicurezza
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try

//	k_sicurezza = if_sicurezza(kkg_flag_modalita.cancellazione)
	
//---- Cancellazione RIGA LOTTO										
	delete from meca_dosimbozza
		where barcode_lav = :ast_tab_meca_dosimbozza.barcode_lav
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = &
			"Errore in cancellazione Dosimetri associati al barocde " &
					+ trim(ast_tab_meca_dosimbozza.barcode_lav) + " " &
					+ "~n~rErrore-tab.meca_dosimbozza:"	+ trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko

		if ast_tab_meca_dosimbozza.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_dosimbozza.st_tab_g_0.esegui_commit) then
			kst_esito = kguo_sqlca_db_magazzino.db_rollback( )
		end if

		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	else

		if ast_tab_meca_dosimbozza.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_dosimbozza.st_tab_g_0.esegui_commit) then
			kst_esito = kguo_sqlca_db_magazzino.db_commit( )
		end if
	
	end if
										

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally

	
end try
		
		




end subroutine

public subroutine tb_delete_x_id_meca (st_tab_meca_dosimbozza ast_tab_meca_dosimbozza) throws uo_exception;//
//====================================================================
//=== Cancella tutti i Dosimetri del LOTTO
//=== Inp: id_meca
//=== Out:
//=== Ritorna:         Lancia Exception x errore
//====================================================================
boolean k_sicurezza
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try

//	k_sicurezza = if_sicurezza(kkg_flag_modalita.cancellazione)
	
//---- Cancellazione RIGA LOTTO										
	delete from meca_dosimbozza
		where id_meca = :ast_tab_meca_dosimbozza.id_meca
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = &
			"Errore in cancellazione Dosimetri associati al Lotto di ID = " &
					+ string(ast_tab_meca_dosimbozza.id_meca) + " " &
					+ "~n~rErrore-tab.meca_dosimbozza:"	+ trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko

		if ast_tab_meca_dosimbozza.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_dosimbozza.st_tab_g_0.esegui_commit) then
			kst_esito = kguo_sqlca_db_magazzino.db_rollback( )
		end if

		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	else

		if ast_tab_meca_dosimbozza.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_dosimbozza.st_tab_g_0.esegui_commit) then
			kst_esito = kguo_sqlca_db_magazzino.db_commit( )
		end if
	
	end if
										

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally

	
end try
		
		




end subroutine

public function integer if_esiste_barcode_lav (st_tab_meca_dosimbozza ast_tab_meca_dosimbozza) throws uo_exception;//
//==============================================================================
//=== Controllo se Riferimento-Dosimetria Esiste x BARCODE_LAV
//=== 
//=== Inp: barcode_lav
//=== Out: 
//=== Ritorna Numero di barcode trovati 
//===   
//==============================================================================
int k_return=0
st_esito kst_esito
int k_ctr


kst_esito.esito = kkg_esito.blok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if trim(ast_tab_meca_dosimbozza.barcode_lav) > " " then
	
//	if isnull(ast_tab_meca_dosimbozza.barcode) then ast_tab_meca_dosimbozza.barcode = ""
//	if isnull(ast_tab_meca_dosimbozza.barcode_lav) then ast_tab_meca_dosimbozza.barcode_lav = ""

	//			and barcode = :ast_tab_meca_dosimbozza.barcode

	select count(*)
		into :k_ctr
		from meca_dosimbozza 
		where barcode_lav = :ast_tab_meca_dosimbozza.barcode_lav
		using kguo_sqlca_db_magazzino ;

//			and barcode_lav = :ast_tab_meca_dosimbozza.barcode_lav
		
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in lettura esistenza Barcode Dosimetria: " + ast_tab_meca_dosimbozza.barcode + sqlca.sqlerrtext
		kguo_exception.inizializza()
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception
	end if
		
else
	kst_esito.esito = kkg_esito.ko
	kst_esito.SQLErrText = "Errore interno. Manca barcode dosimetria (2) x identificarlo, operazione bloccata! "
	kguo_exception.inizializza()
	kguo_exception.set_esito( kst_esito )
	throw kguo_exception
end if

if k_ctr > 0 and kguo_sqlca_db_magazzino.sqlcode = 0 then

	k_return = k_ctr
		
end if
	
	
return k_return


end function

public function boolean if_esiste (st_tab_meca_dosimbozza ast_tab_meca_dosimbozza) throws uo_exception;//
//==============================================================================
//=== Controllo se Riferimento-Dosimetria Esiste x BARCODE
//=== 
//=== Inp: id oppure num/data_int
//=== Out: id (sempre)
//=== Ritorna: TRUE = esiste
//===   
//==============================================================================
boolean k_return=false
st_esito kst_esito
int k_ctr


kst_esito.esito = kkg_esito.blok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if trim(ast_tab_meca_dosimbozza.barcode) > " " then
	
//	if isnull(ast_tab_meca_dosimbozza.barcode) then ast_tab_meca_dosimbozza.barcode = ""
//	if isnull(ast_tab_meca_dosimbozza.barcode_lav) then ast_tab_meca_dosimbozza.barcode_lav = ""

	//			and barcode = :ast_tab_meca_dosimbozza.barcode

	select 1
		into :k_ctr
		from meca_dosimbozza 
		where barcode = :ast_tab_meca_dosimbozza.barcode
		using kguo_sqlca_db_magazzino ;

//			and barcode_lav = :ast_tab_meca_dosimbozza.barcode_lav
		
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in lettura esistenza Barcode di Dosimetria: " + ast_tab_meca_dosimbozza.barcode + sqlca.sqlerrtext
		kguo_exception.inizializza()
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception
	end if
		
else
	kst_esito.esito = kkg_esito.ko
	kst_esito.SQLErrText = "Errore interno. Manca id lotto x identificarlo, operazione bloccata! "
	kguo_exception.inizializza()
	kguo_exception.set_esito( kst_esito )
	throw kguo_exception
end if

if k_ctr > 0 and kguo_sqlca_db_magazzino.sqlcode = 0 then

	k_return = true
		
end if
	
	
return k_return


end function

public subroutine tb_delete (st_tab_meca_dosimbozza ast_tab_meca_dosimbozza) throws uo_exception;//
//====================================================================
//=== Cancella il Dosimetro
//=== Inp: barcode
//=== Out:
//=== Ritorna:         Lancia Exception x errore
//====================================================================
boolean k_sicurezza
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try

//	k_sicurezza = if_sicurezza(kkg_flag_modalita.cancellazione)
	
//---- Cancellazione RIGA LOTTO										
	delete from meca_dosimbozza
		where barcode = :ast_tab_meca_dosimbozza.barcode
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = &
			"Errore in cancellazione Dosimetro " &
					+ trim(ast_tab_meca_dosimbozza.barcode) + " " &
					+ "~n~rErrore-tab.meca_dosimbozza:" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko

		if ast_tab_meca_dosimbozza.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_dosimbozza.st_tab_g_0.esegui_commit) then
			kst_esito = kguo_sqlca_db_magazzino.db_rollback( )
		end if

		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	else

		if ast_tab_meca_dosimbozza.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_dosimbozza.st_tab_g_0.esegui_commit) then
			kst_esito = kguo_sqlca_db_magazzino.db_commit( )
		end if
	
	end if
										

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally

	
end try
		
		




end subroutine

public function integer if_esiste_barcode_lav_con_dosim (st_tab_meca_dosimbozza ast_tab_meca_dosimbozza) throws uo_exception;//
//==============================================================================
//=== Controllo se Riferimento-Dosimetria Esiste x BARCODE_LAV con Dosimetri
//=== 
//=== Inp: barcode_lav
//=== Out: 
//=== Ritorna Numero di barcode trovati CON dosimetri già associati
//===   
//==============================================================================
int k_return=0
st_esito kst_esito
int k_ctr


kst_esito.esito = kkg_esito.blok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if trim(ast_tab_meca_dosimbozza.barcode_lav) > " " then
	
//	if isnull(ast_tab_meca_dosimbozza.barcode) then ast_tab_meca_dosimbozza.barcode = ""
//	if isnull(ast_tab_meca_dosimbozza.barcode_lav) then ast_tab_meca_dosimbozza.barcode_lav = ""

	//			and barcode = :ast_tab_meca_dosimbozza.barcode

	select count(*)
		into :k_ctr
		from meca_dosimbozza 
		where barcode_lav = :ast_tab_meca_dosimbozza.barcode_lav
		    and barcode_dosimetro > " "
		using kguo_sqlca_db_magazzino ;

//			and barcode_lav = :ast_tab_meca_dosimbozza.barcode_lav
		
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in conteggio Barcode dosimetri già associati: " + ast_tab_meca_dosimbozza.barcode + sqlca.sqlerrtext
		kguo_exception.inizializza()
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception
	end if
		
else
	kst_esito.esito = kkg_esito.ko
	kst_esito.SQLErrText = "Errore interno. Manca barcode dosimetria (2) x identificarlo, operazione bloccata! "
	kguo_exception.inizializza()
	kguo_exception.set_esito( kst_esito )
	throw kguo_exception
end if

if k_ctr > 0 and kguo_sqlca_db_magazzino.sqlcode = 0 then

	k_return = k_ctr
		
end if
	
	
return k_return


end function

public subroutine if_isnull (ref st_tab_meca_dosimbozza kst_tab_meca_dosimbozza);//---
//--- toglie i NULL ai campi della tabella 
//---

//if isnull(kst_tab_meca_dosimbozza.dosim_assorb) then	kst_tab_meca_dosimbozza.dosim_assorb = 0
if isnull(kst_tab_meca_dosimbozza.id_meca_dosimbozza) then	kst_tab_meca_dosimbozza.id_meca_dosimbozza = 0
if isnull(kst_tab_meca_dosimbozza.id_meca) then	kst_tab_meca_dosimbozza.id_meca = 0
if isnull(kst_tab_meca_dosimbozza.dosim_spessore) then	kst_tab_meca_dosimbozza.dosim_spessore = 0
if isnull(kst_tab_meca_dosimbozza.dosim_rapp_a_s) then	kst_tab_meca_dosimbozza.dosim_rapp_a_s = 0 
if isnull(kst_tab_meca_dosimbozza.dosim_lotto_dosim) then	kst_tab_meca_dosimbozza.dosim_lotto_dosim = ""
if isnull(kst_tab_meca_dosimbozza.dosim_temperatura) then	kst_tab_meca_dosimbozza.dosim_temperatura = 0 	
if isnull(kst_tab_meca_dosimbozza.dosim_umidita) then	kst_tab_meca_dosimbozza.dosim_umidita = 0 	
if isnull(kst_tab_meca_dosimbozza.dosim_data) then	kst_tab_meca_dosimbozza.dosim_data = date(0)
if isnull(kst_tab_meca_dosimbozza.dosim_dose) then	kst_tab_meca_dosimbozza.dosim_dose = 0.00
if isnull(kst_tab_meca_dosimbozza.x_data_dosim_lettura) then	kst_tab_meca_dosimbozza.x_data_dosim_lettura = datetime(date(0))
if isnull(kst_tab_meca_dosimbozza.x_utente_dosim_lettura) then	kst_tab_meca_dosimbozza.x_utente_dosim_lettura = ""
if isnull(kst_tab_meca_dosimbozza.x_datins) then	kst_tab_meca_dosimbozza.x_datins = datetime(date(0))
if isnull(kst_tab_meca_dosimbozza.x_utente) then	kst_tab_meca_dosimbozza.x_utente = ""
if isnull(kst_tab_meca_dosimbozza.barcode)  then kst_tab_meca_dosimbozza.barcode = ""
if isnull(kst_tab_meca_dosimbozza.barcode_dosimetro)  then kst_tab_meca_dosimbozza.barcode_dosimetro = ""
if isnull(kst_tab_meca_dosimbozza.barcode_lav)  then kst_tab_meca_dosimbozza.barcode_lav = ""




end subroutine

public function date get_data_x_certif (ref st_tab_meca_dosimbozza kst_tab_meca_dosimbozza) throws uo_exception;//
//--------------------------------------------------------------------------------------------
//--- Torna la DATA di generazione per il CERTIFICATO
//--- 
//--- 
//---  input: id_meca
//---  Output: le date lette
//---  Ritorna: data da pigliare se data(0) allora non trovata
//---  lancia EXCEPTION x errore                          
//--------------------------------------------------------------------------------------------
//
date k_return=kkg.data_zero
st_tab_meca kst_tab_meca
st_esito kst_esito
kuf_armo kuf1_armo


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try
	if kst_tab_meca_dosimbozza.id_meca > 0 then
	
		SELECT max(dosim_data)
				 ,max(x_data_dosim_lettura)
				 INTO 
						:kst_tab_meca_dosimbozza.dosim_data
						,:kst_tab_meca_dosimbozza.x_data_dosim_lettura
				 FROM meca_dosimbozza  
				WHERE meca_dosimbozza.id_meca = :kst_tab_meca_dosimbozza.id_meca
					 using kguo_sqlca_db_magazzino;
				
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
//--- x default piglia la data di convalida
			if kst_tab_meca_dosimbozza.dosim_data > kguo_g.get_datazero( ) then 
				k_return = kst_tab_meca_dosimbozza.dosim_data
			end if
//--- se data di lettura superiore a quella precedente
			if date(kst_tab_meca_dosimbozza.x_data_dosim_lettura) > kguo_g.get_datazero( ) then 
				if date(kst_tab_meca_dosimbozza.x_data_dosim_lettura) > k_return then
					k_return = date(kst_tab_meca_dosimbozza.x_data_dosim_lettura)
				end if
			end if
			
//--- check date di autorizzazione e sblocco su meca magari ce n'e' una più recente
			kuf1_armo = create kuf_armo
			kst_tab_meca.id = kst_tab_meca_dosimbozza.id_meca
			kuf1_armo.get_dati_certif(kst_tab_meca) 
			if date(kst_tab_meca.x_data_cert_f_st) > k_return then  // data sblocco + recente?
				k_return = date(kst_tab_meca.x_data_cert_f_st)
			end if
			if date(kst_tab_meca.x_data_cert_alim) > k_return then  // data aut alimentari + recente?
				k_return = date(kst_tab_meca.x_data_cert_alim)
			end if
			if date(kst_tab_meca.x_data_cert_farma) > k_return then  // data aut farmaceutici + recente?
				k_return = date(kst_tab_meca.x_data_cert_farma)
			end if
			
		
		else
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Tab.Dosimetri Lotto (id=" + string(kst_tab_meca_dosimbozza.id_meca) + ") " &
										 + "~n~r"  + trim(kguo_sqlca_db_magazzino.SQLErrText)
			if kguo_sqlca_db_magazzino.sqlcode = 100 then
				kst_esito.esito = kkg_esito.not_fnd
				kst_tab_meca_dosimbozza.id_meca = 0
			else
				if kguo_sqlca_db_magazzino.sqlcode > 0 then
					kst_esito.esito = kkg_esito.db_wrn
					kst_tab_meca_dosimbozza.id_meca = 0
				else  
					kst_esito.esito = kkg_esito.db_ko
				end if
			end if
		end if
	 
		if kst_esito.esito = kkg_esito.db_ko then
			
			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito )
			throw kguo_exception
			
		end if
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Manca il numero Lotto, impossibile estrarre la data in Dosimetria. Operazione non eseguita"	
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception

	
finally
	if isvalid(kuf1_armo) then destroy kuf1_armo

end try

return k_return

end function

public function long get_ultimo_id () throws uo_exception;//
//--------------------------------------------------------------------------------------------------------
//--- Tona l'ultimo ID caricato
//--- 
//---  output: id_meca_dosimbozza
//---  lancia exception           
//--- 
//--------------------------------------------------------------------------------------------------------
long k_return = 0
st_esito kst_esito 
st_tab_meca_dosimbozza kst_tab_meca_dosimbozza


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


//--- leggo lo stato Attuale
	select max(id_meca_dosimbozza)
	   into :kst_tab_meca_dosimbozza.id_meca_dosimbozza
		from meca_dosimbozza
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode 
		kst_esito.SQLErrText = "Errore durante lettura ultimo ID caricato su tab. lettura dosimetrica in bozza, errore " &
								+ string(kguo_sqlca_db_magazzino.sqlcode) + "~n~r" &
		                  + trim(kguo_sqlca_db_magazzino.sqlerrtext)
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if	

	if kst_tab_meca_dosimbozza.id_meca_dosimbozza > 0 then
		k_return = kst_tab_meca_dosimbozza.id_meca_dosimbozza
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

end try

return k_return


end function

public function long if_gia_usato_barcode (st_tab_meca_dosimbozza kst_tab_meca_dosimbozza) throws uo_exception;//---
//--- Controlla se codice Barcode x il Dosimetro è già stato usato in passato (ultimo anno)
//---
//--- Inp.: st_tab_meca_dosimbozza id_meca_dosimbozza attuale da escludere dalla conta, barcode = da controllare
//--- Out.: 
//--- Ritorna: id_meca ultimo numero lotto che lo ha già utlizzato
//--- Lancia exception se errore
//--- 
long k_return= 0
date k_data_meno1anno
st_esito kst_esito
uo_exception kuo_exception


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	try
		
		k_data_meno1anno = relativedate(kg_dataoggi, -365)

		select count(meca_dosimbozza.id_meca)
				into :kst_tab_meca_dosimbozza.id_meca
				from meca_dosimbozza inner join meca on meca_dosimbozza.id_meca = meca.id
			where meca_dosimbozza.id_meca_dosimbozza <> :kst_tab_meca_dosimbozza.id_meca_dosimbozza
						and meca_dosimbozza.id_meca <> :kst_tab_meca_dosimbozza.id_meca
					  	and meca.data_int > :k_data_meno1anno
					  	and barcode = :kst_tab_meca_dosimbozza.barcode
			using sqlca;

		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in lettura Tab.Letture Dosimetrie per barcode (cod=" + trim(kst_tab_meca_dosimbozza.barcode) + ")   ~n~r" + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			
			kuo_exception.set_esito( kst_esito )
			throw kuo_exception
		end if

//--- se ho trovato dei codici allora torna TRUE
		if kst_tab_meca_dosimbozza.id_meca > 0 then
			k_return = kst_tab_meca_dosimbozza.id_meca
		end if

	catch (uo_exception kuo1_exception)
		throw kuo1_exception
	
	end try
	

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
//---							           	W=OK con degli avvertimenti (NON bloccante) (kkg_esito.DATI_WRN);
//---  rit: 
//---
//---  per errore lancia EXCEPTION anche x i warning
//---
//---  CONSIGLIO DI COPIARE DA QUESTO ESTENDENDO I CONTROLLI
//---
//------------------------------------------------------------------------------------------------------
//
int k_errori = 0
long k_nr_righe, k_riga_trovato, k_riga
string k_tipo_errore="0"
st_tab_meca_dosimbozza kst_tab_meca_dosimbozza
st_tab_meca kst_tab_meca
st_esito kst_esito
kuf_armo kuf1_armo


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
// ESEMPIO
//	if trim(ads_inp.object.descr) > " "  then
//	else
//		k_errori ++
//		k_tipo_errore="3"      // errore in questo campo: dati insuff.
//		ads_inp.object.descr.tag = k_tipo_errore 
//		kst_esito.esito = kkg_esito.err_formale
//		kst_esito.sqlerrtext = "Manca descrizione nel campo " + trim(ads_inp.object.descr_t.text) +  "~n~r"  
//		kguo_exception.inizializza( )
//		kguo_exception.set_esito(kst_esito)
//		throw kguo_exception
//	end if
	
	kuf1_armo = create kuf_armo
	
	k_nr_righe =ads_inp.rowcount()
	k_errori = 0
	k_riga =ads_inp.getnextmodified(0, primary!)

	do while k_riga > 0 and k_errori < 99

		if trim(ads_inp.getitemstring (k_riga, "dosim_lotto_dosim")) > " " then
		else
			k_errori ++
			k_tipo_errore="3"      
			ads_inp.modify("dosim_lotto_dosim.tag = '" + k_tipo_errore + "' ")
			kst_esito.esito = kkg_esito.err_formale
			kst_esito.sqlerrtext = "riga " + string(k_riga) + ": Manca il Nome Lotto in " + trim(ads_inp.describe(ads_inp.describe("dosim_lotto_dosim.name") + "_t.text")) +  "~n~r"  
		end if
	
//--- Controlla se barcode dosimetro già presente in altra lettura
		if	k_tipo_errore = "0" or k_tipo_errore > "3" then
			kst_tab_meca_dosimbozza.id_meca_dosimbozza = ads_inp.getitemnumber(k_riga, "id_meca_dosimbozza")
			kst_tab_meca_dosimbozza.barcode = ads_inp.getitemstring(k_riga, "meca_dosimbozza_barcode")
			if trim(kst_tab_meca_dosimbozza.barcode) > " " then
				kst_tab_meca_dosimbozza.id_meca = this.if_gia_usato_barcode(kst_tab_meca_dosimbozza)
				if kst_tab_meca_dosimbozza.id_meca > 0 then
					kst_tab_meca.id = kst_tab_meca_dosimbozza.id_meca
					kuf1_armo.get_num_int(kst_tab_meca)
					k_errori ++
					k_tipo_errore=kkg_esito.DATI_WRN      
					ads_inp.modify("meca_dosimbozza_barcode.tag = '" + k_tipo_errore + "' ")
					kst_esito.esito = kkg_esito.ko
					kst_esito.sqlerrtext += "riga " + string(k_riga) + ": " + "Barcode Dosimetro già utilizzato nel Lotto " + string(kst_tab_meca.num_int) &
												  + "/" + string(kst_tab_meca.data_int, "dd mmm yy") + " id " + string(kst_tab_meca_dosimbozza.id_meca) + "~n~r"
				end if
			end if
			kst_tab_meca_dosimbozza.id_meca = ads_inp.getitemnumber(k_riga, "id_meca")
			kst_tab_meca_dosimbozza.id_meca_dosimbozza = ads_inp.getitemnumber(k_riga, "id_meca_dosimbozza")
			kst_tab_meca_dosimbozza.barcode_dosimetro = ads_inp.getitemstring(k_riga, "barcode_dosimetro")
			if trim(kst_tab_meca_dosimbozza.barcode_dosimetro) > " " then
				k_riga_trovato = ads_inp.find("barcode_dosimetro = '" + trim(kst_tab_meca_dosimbozza.barcode_dosimetro) + "' ", 1, k_nr_righe)
				if k_riga_trovato > 0 then 
					if k_riga = k_riga_trovato then
						k_riga_trovato = ads_inp.find("barcode_dosimetro = '" + trim(kst_tab_meca_dosimbozza.barcode_dosimetro) + "' ", 1, k_nr_righe)
					end if
					if k_riga_trovato > 0 and k_riga <> k_riga_trovato then
						k_errori ++
						k_tipo_errore="1"      
						ads_inp.modify("barcode_dosimetro.tag = '" + k_tipo_errore + "' ")
						kst_esito.esito = kkg_esito.ko
						kst_esito.sqlerrtext += "riga " + string(k_riga) + ": "  + "Etichetta Dosimetro già utilizzata in questo Lotto alla riga " + string(k_riga_trovato) &
												   + "~n~r"
					end if
				end if
//--- dopo il controllo in elenco lo faccio sui lotti su db					
				if k_riga_trovato = 0 or k_riga = k_riga_trovato then
					kst_tab_meca_dosimbozza.id_meca = this.if_gia_usato_dosimetro(kst_tab_meca_dosimbozza)  // controlla sui lotti storici
					if kst_tab_meca_dosimbozza.id_meca > 0 then
						kst_tab_meca.id = kst_tab_meca_dosimbozza.id_meca
						kuf1_armo.get_num_int(kst_tab_meca)
						k_errori ++
						k_tipo_errore=kkg_esito.DATI_WRN //"1"      
						ads_inp.modify("barcode_dosimetro.tag = '" + k_tipo_errore + "' ")
						kst_esito.esito = kkg_esito.ko
						kst_esito.sqlerrtext += "riga " + string(k_riga) + ": "  + "Etichetta Dosimetro '" + trim(kst_tab_meca_dosimbozza.barcode_dosimetro) &
						                             + "'già utilizzata nel Lotto " + string(kst_tab_meca.num_int) &
												  + "/" + string(kst_tab_meca.data_int, "dd mmm yy") + " id " + string(kst_tab_meca_dosimbozza.id_meca) + "~n~r"
					end if
				end if
			end if
		end if
	

		if k_tipo_errore > "0"  and k_tipo_errore < "4" and k_tipo_errore <> kkg_esito.DATI_WRN then
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

		k_riga = ads_inp.getnextmodified(k_riga, primary!)

	loop

	
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kuf1_armo) then destroy kuf1_armo
	if k_errori > 0 then
		
	end if
	
end try


return kst_esito
end function

public function long if_gia_usato_dosimetro (st_tab_meca_dosimbozza ast_tab_meca_dosimbozza) throws uo_exception;//---
//--- Controlla se codice barcode Dosimetro è già stato usato in passato (ultimo anno)
//---
//--- Inp.: st_tab_meca_dosimbozza id_meca_dosimbozza che è quello attuale da escludere dalla conta, barcode_dosimetro = da controllare
//--- Out.: -
//--- Ritorna: id_meca utimo Lotto in cui è stato già Utlizzato
//--- Lancia exception se errore
//--- 
long k_return = 0
date k_data_meno1anno
st_esito kst_esito
st_tab_meca_dosimbozza kst_tab_meca_dosimbozza


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	try
		
		k_data_meno1anno = relativedate(kg_dataoggi, -365)

		select max(meca_dosimbozza.id_meca)
				into :kst_tab_meca_dosimbozza.id_meca
				from meca_dosimbozza inner join meca on meca_dosimbozza.id_meca = meca.id
			where meca_dosimbozza.id_meca_dosimbozza <> :ast_tab_meca_dosimbozza.id_meca_dosimbozza
						and meca_dosimbozza.id_meca <> :ast_tab_meca_dosimbozza.id_meca
					  	and meca.data_int > :k_data_meno1anno
					  	and barcode_dosimetro = :ast_tab_meca_dosimbozza.barcode_dosimetro
			using  kguo_sqlca_db_magazzino;

		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in lettura Tab.Letture Dosimetrie per dosimetro (cod=" + trim(ast_tab_meca_dosimbozza.barcode_dosimetro) + ")   ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			
			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito )
			throw kguo_exception
		end if

//--- se ho trovato dei codici allora torna TRUE
		if kst_tab_meca_dosimbozza.id_meca > 0 then
			k_return = kst_tab_meca_dosimbozza.id_meca
		end if
			
	catch (uo_exception kuo_exception)
		throw kuo_exception
	
	end try
	

return k_return

end function

on kuf_meca_dosimbozza.create
call super::create
end on

on kuf_meca_dosimbozza.destroy
call super::destroy
end on

