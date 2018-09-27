$PBExportHeader$kuf_meca_dosim.sru
forward
global type kuf_meca_dosim from kuf_parent
end type
end forward

global type kuf_meca_dosim from kuf_parent
end type
global kuf_meca_dosim kuf_meca_dosim

type variables
 ////--- flag campo Stato della Dosimetrica SPOSTATI NEL KUF_MECA_DOSIM
public constant string ki_err_lav_ok_da_conv = " "
public constant string ki_err_lav_ok_conv_ko_da_aut = "K"
public constant string ki_err_lav_ok_conv_da_aut = "A"
public constant string ki_err_lav_ok_conv_aut_ok = "2"
public constant string ki_err_lav_ok_conv_ko_bloc = "B"
public constant string ki_err_lav_ok_conv_ko_sbloc = "1"

public constant string ki_dosim_flg_tipo_dose_MINIMA = "M"
public constant string ki_dosim_flg_tipo_dose_MASSIMA = "X"
public constant string ki_dosim_flg_tipo_dose_ALTRO = "A"

end variables

forward prototypes
public function boolean get_id_meca_da_barcode_dosimetro (ref st_tab_meca_dosim kst_tab_meca_dosim) throws uo_exception
public function boolean tb_add_barcode (st_tab_meca_dosim kst_tab_meca_dosim) throws uo_exception
public function string get_ultimo_numero_barcode_da_tab (string k_inizio_barcode) throws uo_exception
public function boolean if_esiste_barcode (st_tab_meca_dosim kst_tab_meca_dosim) throws uo_exception
public function boolean set_barcode_dosimetro (ref st_tab_meca_dosim kst_tab_meca_dosim) throws uo_exception
public function boolean if_esiste_barcode_dosimetro (ref st_tab_meca_dosim kst_tab_meca_dosim) throws uo_exception
public function integer if_gia_usato_barcode (ref st_tab_meca_dosim kst_tab_meca_dosim) throws uo_exception
public function integer if_gia_usato_dosimetro (ref st_tab_meca_dosim kst_tab_meca_dosim) throws uo_exception
public function boolean get_id_meca_da_barcode (ref st_tab_meca_dosim kst_tab_meca_dosim) throws uo_exception
public function st_tab_meca convalida (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception
public subroutine set_convalida (st_tab_meca ast_tab_meca) throws uo_exception
public function integer get_barcode (ref st_tab_meca_dosim kst_tab_meca_dosim[]) throws uo_exception
public subroutine tb_delete_x_barcode_lav (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception
public subroutine tb_delete_x_id_meca (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception
public function integer if_esiste_barcode_lav (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception
public function boolean if_esiste (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception
public subroutine tb_delete (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception
public function integer if_esiste_barcode_lav_con_dosim (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception
public function integer u_genera_rimuove_barcode (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
public subroutine if_isnull (ref st_tab_meca_dosim kst_tab_meca_dosim)
public function date get_data_x_certif (ref st_tab_meca_dosim kst_tab_meca_dosim) throws uo_exception
public subroutine set_barcode (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception
public function boolean if_dosimetria_gia_definitivo (string a_err_lav_ok)
public function boolean if_dosimetria_gia_autorizzata (string a_err_lav_ok)
public function string get_err_lav_ok_descr (string a_err_lav_ok)
public function boolean if_dosimetria_convalidata_ok (string a_err_lav_ok)
public function st_esito anteprima_dosim (ref datawindow adw_anteprima, st_tab_meca_dosim ast_tab_meca_dosim)
public function st_esito anteprima_dosim_l (ref datawindow adw_anteprima, st_tab_meca_dosim ast_tab_meca_dosim)
public subroutine set_convalida_x_barcode (readonly st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception
public function st_tab_meca_dosim convalida_dosim (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception
public subroutine get_err_lav_ok (ref st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception
public subroutine get_dosim_dose_min (ref st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception
public subroutine get_dosim_dose_max (ref st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception
public function boolean set_ultimo_numero_barcode_dsm_in_base (st_tab_meca_dosim kst_tab_meca_dosim) throws uo_exception
public subroutine tb_delete_completa (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception
private function string get_ultimo_numero_barcode_da_base () throws uo_exception
private function string get_ultimo_numero_barcode () throws uo_exception
private function string genera_barcode () throws uo_exception
public function boolean add_avviso_pronto_merce (st_tab_meca ast_tab_meca) throws uo_exception
public subroutine tb_delete_x_barcode_dosimetro_l (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception
private subroutine get_convalida_esito (ref st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception
public function integer get_nr_dosim_letti (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception
public function boolean if_consenti_forza_convalida (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception
private subroutine set_convalida_lotto (readonly st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception
public subroutine set_forza_convalida (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception
private subroutine set_convalida_lotto_ripristino (readonly st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception
public function integer get_nr_dosim_non_letti (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception
public subroutine get_dosim_dosemax_min (ref st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception
public function date get_dosim_data_max (readonly st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception
end prototypes

public function boolean get_id_meca_da_barcode_dosimetro (ref st_tab_meca_dosim kst_tab_meca_dosim) throws uo_exception;//
//--------------------------------------------------------------------------------------------
//--- Torna ID_MECA da MECA_DOSIM per il barcode Dosimetro
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
               :kst_tab_meca_dosim.id_meca 
          FROM meca_dosim  
         WHERE meca_dosim.barcode_dosimetro = :kst_tab_meca_dosim.barcode_dosimetro
             using kguo_sqlca_db_magazzino;
         
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
   
		if isnull(kst_tab_meca_dosim.id_meca) then 
         	kst_tab_meca_dosim.id_meca = 0
      	end if
   
   else
      kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
      kst_esito.SQLErrText = "Tab.Dosimetri Lotto (dosimetro=" + trim(kst_tab_meca_dosim.barcode_dosimetro) + ") " &
                            + "~n~r"  + trim(kguo_sqlca_db_magazzino.SQLErrText)
      if kguo_sqlca_db_magazzino.sqlcode = 100 then
         kst_esito.esito = kkg_esito.not_fnd
         kst_tab_meca_dosim.id_meca = 0
      else
         if kguo_sqlca_db_magazzino.sqlcode > 0 then
            kst_esito.esito = kkg_esito.db_wrn
            kst_tab_meca_dosim.id_meca = 0
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

   	if kst_tab_meca_dosim.id_meca > 0 then
		k_return = TRUE
	end if


return k_return

end function

public function boolean tb_add_barcode (st_tab_meca_dosim kst_tab_meca_dosim) throws uo_exception;//
//-------------------------------------------------------------------------------------------------------------
//--- Aggiunge Barcode nella tabella DOSIMETRIE LOTTI (meca_dosim)
//--- 
//--- Input: kst_tab_meca_dosim: id_meca, barcode, barcode_lav
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

	
	kst_tab_meca_dosim.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_meca_dosim.x_utente = kGuf_data_base.prendi_x_utente()

	if_isnull(kst_tab_meca_dosim)

	if kst_tab_meca_dosim.id_meca > 0 then
	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Manca id Lotto, generazione Dosimetro barcode non eseguita!"
		kst_esito.esito = kkg_esito.ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito )		
		throw kguo_exception
	end if		
		
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
//		if not k_sicurezza then
//			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
//			kst_esito.SQLErrText = "Modifica Dosimetri barcode del Lotto non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata (" + trim(kst_open_w.id_programma) + "/" +trim(kst_open_w.flag_modalita) + ") "
//			kst_esito.esito = kkg_esito.no_aut
//			kguo_exception.inizializza( )
//			kguo_exception.set_esito( kst_esito )		
//			throw kguo_exception
//			
//		else


//			kst_tab_meca.id = kst_tab_meca_dosim.id_meca
//			if if_convalidato(kst_tab_meca) then
//--- 160715: esiste già il barcode? 
	if if_esiste(kst_tab_meca_dosim) then
				
//				if if_esiste_barcode(kst_tab_meca_dosim) then
//					
//					try
//						set_ultimo_numero_barcode_dsm_in_base(kst_tab_meca_dosim)	// AGGIORNA ANCHE TAB BASE				
//						
//					catch (uo_exception kuo_exception)
//						throw kuo_exception
//						
//					end try
//					
//				end if
//160715				    set barcode = :kst_tab_meca_dosim.barcode,
				
		update meca_dosim
					 	set barcode_dosimetro = :kst_tab_meca_dosim.barcode_dosimetro,
						id_dosimpos = :kst_tab_meca_dosim.id_dosimpos, 
						sl_pt_dosimpos_seq = :kst_tab_meca_dosim.sl_pt_dosimpos_seq , 
						x_datins = :kst_tab_meca_dosim.x_datins, 
						x_utente =	:kst_tab_meca_dosim.x_utente   
					where id_meca = :kst_tab_meca_dosim.id_meca
					using kguo_sqlca_db_magazzino;
					
	else

//				try
//					set_ultimo_numero_barcode_dsm_in_base(kst_tab_meca_dosim)	// AGGIORNA ANCHE TAB BASE		
//					
//				catch (uo_exception kuo1_exception)
//					throw kuo1_exception
//					
//				end try

//				if trim(kst_tab_meca_dosim.barcode) > " " then
//				else
//					//kst_tab_meca_dosim.barcode = get_ultimo_id_meca_dosim( )
//					kst_tab_meca_dosim.barcode = 1

		INSERT INTO meca_dosim
						( 
						  barcode,
						  barcode_lav,
						  id_meca,   
						  barcode_dosimetro,
						  id_dosimpos,
						  sl_pt_dosimpos_seq,
						  x_datins,
						  x_utente
						)  
				  VALUES 
							( 
							:kst_tab_meca_dosim.barcode,   
							:kst_tab_meca_dosim.barcode_lav,   
							:kst_tab_meca_dosim.id_meca,   
							:kst_tab_meca_dosim.barcode_dosimetro,   
							:kst_tab_meca_dosim.id_dosimpos,
							:kst_tab_meca_dosim.sl_pt_dosimpos_seq,
							:kst_tab_meca_dosim.x_datins,   
							:kst_tab_meca_dosim.x_utente   
							)  
							using kguo_sqlca_db_magazzino;
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante aggiornamento Tab.Dosimetrie Lotti (meca_dosim) "  + "~n~r"  + trim(kguo_sqlca_db_magazzino.SQLErrText)
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
		if kst_tab_meca_dosim.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca_dosim.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
		
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception
		
	else
		if kst_tab_meca_dosim.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca_dosim.st_tab_g_0.esegui_commit) then
			kst_esito = kguo_sqlca_db_magazzino.db_commit( )
		end if
		if kst_esito.esito = kkg_esito.ok then
			k_return = TRUE
		end if
	end if


return k_return

end function

public function string get_ultimo_numero_barcode_da_tab (string k_inizio_barcode) throws uo_exception;//
//--------------------------------------------------------------------------------------------
//--- Torna obbligatoriamente l'ultimo progressivo del BARCODE registrato in tabella
//--- 
//--- 
//---  input: 
//---  Outout: 
//---  Ritorna: STRINGA 	con lultimo progr Barcode trovato
//---                                     
//--------------------------------------------------------------------------------------------
//
string k_return=""
string k_barcode_progr
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if len(trim(k_inizio_barcode)) = 3 then
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Lettura ultimo barcode Dosimetro"  + "~n~rSono richiesti i primi 3 caratteri identificativi del barcode"
		kst_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception
		
	end if

	SELECT max(substring(barcode,4,5))
				 INTO :k_barcode_progr
				 FROM meca_dosim  
				where substring(barcode,1,3) = :k_inizio_barcode
					 using sqlca;
				
	if sqlca.sqlcode = 0 then
	
		if k_barcode_progr > " " then
		else
			k_barcode_progr = "AA000"
		end if
	
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in lettura Numero massimo a cui è giunto il Dosimetro " + trim(k_inizio_barcode) &
									 + "~n~r"  + trim(SQLCA.SQLErrText)
		if sqlca.sqlcode > 0 then
			k_barcode_progr = "AA000"
		else
			kst_esito.esito = kkg_esito.db_ko
		end if
	end if

	if kst_esito.esito = kkg_esito.db_ko then
		
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception
		
	end if

	if trim(k_barcode_progr) > " " then
		k_return = trim(k_barcode_progr)
	end if

return k_return

end function

public function boolean if_esiste_barcode (st_tab_meca_dosim kst_tab_meca_dosim) throws uo_exception;//
//====================================================================
//=== Controllo se esiste gia' lo stesso Barcode Dosimetria sia in tabella BARCODE che nella MECA_DOSIM
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

	if len(trim(kst_tab_meca_dosim.barcode)) > 0 then

		
		if isnull(kst_tab_meca_dosim.id_meca) then kst_tab_meca_dosim.id_meca = 0

//--- controllo prima di tutto se esiste gia' un Barcode di Trattamento in tabella 
		kst_tab_barcode.barcode = kst_tab_meca_dosim.barcode
		kst_tab_barcode.id_meca = kst_tab_meca_dosim.id_meca	
		if not kuf1_barcode.if_esiste( kst_tab_barcode ) then

//--- Se non esiste allora cerco in tabella MECA_DOSIM			
			select 1
				into :k_ctr
				from meca_dosim 
				where meca_dosim.id_meca > :kst_tab_meca_dosim.id_meca and meca_dosim.barcode = :kst_tab_meca_dosim.barcode
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
					kst_esito.SQLErrText = "Errore durante verifica esistenza Barcode Dosimetria (meca_dosim): " + kst_tab_meca_dosim.barcode  + " ~n~r " + sqlca.sqlerrtext
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

public function boolean set_barcode_dosimetro (ref st_tab_meca_dosim kst_tab_meca_dosim) throws uo_exception;//---
//--- Aggiorna Etichetta Dosimetro in archivio
//---
//--- Inp.: st_tab_meca_dosim id_meca, barcode dosimetro (DSM...), barcode_dosimetro (etichetta) 
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


	kst_tab_meca_dosim.x_datins = kGuf_data_base.prendi_x_datins() 
	kst_tab_meca_dosim.x_utente = kGuf_data_base.prendi_x_utente() 

	update meca_dosim 
			set barcode_dosimetro = :kst_tab_meca_dosim.barcode_dosimetro
					,x_datins = :kst_tab_meca_dosim.x_datins 
					,x_utente = :kst_tab_meca_dosim.x_utente 
		where meca_dosim.id_meca = :kst_tab_meca_dosim.id_meca
		     and meca_dosim.barcode = :kst_tab_meca_dosim.barcode
		using sqlca;

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Aggiornamento barcode Dosimetro in tab. Dosimetria Lotti (id Lotto=" + string(kst_tab_meca_dosim.id_meca) + ")   ~n~r" + trim(SQLCA.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		
	end if

//---- COMMIT....	
	if kst_esito.esito = kkg_esito.db_ko then
		if kst_tab_meca_dosim.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca_dosim.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
		kguo_exception.inizializza()
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception
		
	else
		if kst_tab_meca_dosim.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca_dosim.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	end if
	
	k_return=true

return k_return



end function

public function boolean if_esiste_barcode_dosimetro (ref st_tab_meca_dosim kst_tab_meca_dosim) throws uo_exception;//---
//--- Controlla se codice barcode Dosimetro esite in archivio (ultimo anno)
//---
//--- Inp.: st_tab_meca_dosim  barcode_dosimetro = da controllare
//--- Out.: st_tab_meca_dosim id_meca
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
				into :kst_tab_meca_dosim.id_meca
				from meca_dosim inner join meca on meca_dosim.id_meca = meca.id
			where meca_dosim.id_meca <> :kst_tab_meca_dosim.id_meca
					  and meca.data_int > :k_data_meno1anno
					  and barcode_dosimetro = :kst_tab_meca_dosim.barcode_dosimetro
			using sqlca;

		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.Dosimetria Lotti (id Lotto=" + string(kst_tab_meca_dosim.id_meca) + ")   ~n~r" + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			
			kuo_exception.set_esito( kst_esito )
			throw kuo_exception
		end if

//--- se ho trovato il codice allora torna TRUE
		if kst_tab_meca_dosim.id_meca > 0 then
			k_return = TRUE
		end if
			
	catch (uo_exception kuo1_exception)
		throw kuo1_exception
	
	end try
	


return k_return



end function

public function integer if_gia_usato_barcode (ref st_tab_meca_dosim kst_tab_meca_dosim) throws uo_exception;//---
//--- Controlla se codice Barcode x il Dosimetro è già stato usato in passato (ultimo anno)
//---
//--- Inp.: st_tab_meca_dosim id_meca (facoltativo) = quello attuale da escludere dalla conta, barcode = da controllare
//--- Out.: 
//--- Ritorna: int numero di volte  Utlizzato
//--- Lancia excpetion se errore
//--- 
int k_return= 0
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

		select count(*)
				into :k_contati
				from meca_dosim inner join meca on meca_dosim.id_meca = meca.id
			where meca_dosim.id_meca <> :kst_tab_meca_dosim.id_meca
					  and meca.data_int > :k_data_meno1anno
					  and barcode = :kst_tab_meca_dosim.barcode
			using sqlca;

		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in lettura Tab.Convalida Dosimetrie per barcode (cod=" + trim(kst_tab_meca_dosim.barcode) + ")   ~n~r" + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			
			kuo_exception.set_esito( kst_esito )
			throw kuo_exception
		end if

//--- se ho trovato dei codici allora torna TRUE
		if k_contati > 0 then
			k_return = k_contati
		end if

	catch (uo_exception kuo1_exception)
		throw kuo1_exception
	
	end try
	

return k_return




end function

public function integer if_gia_usato_dosimetro (ref st_tab_meca_dosim kst_tab_meca_dosim) throws uo_exception;//---
//--- Controlla se codice barcode Dosimetro è già stato usato in passato (ultimo anno)
//---
//--- Inp.: st_tab_meca_dosim id_meca (facoltativo) = quello attuale da escludere dalla conta, barcode_dosimetro = da controllare
//--- Out.: -
//--- Ritorna: int numero di volte già Utlizzato
//--- Lancia excpetion se errore
//--- 
int k_return = 0
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

		select count(*)
				into :k_contati
				from meca_dosim inner join meca on meca_dosim.id_meca = meca.id
			where meca_dosim.id_meca <> :kst_tab_meca_dosim.id_meca
					  and meca.data_int > :k_data_meno1anno
					  and barcode_dosimetro = :kst_tab_meca_dosim.barcode_dosimetro
			using sqlca;

		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in lettura Tab.Convalida Dosimetrie per dosimetro (cod=" + trim(kst_tab_meca_dosim.barcode_dosimetro) + ")   ~n~r" + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			
			kuo_exception.set_esito( kst_esito )
			throw kuo_exception
		end if

//--- se ho trovato dei codici allora torna TRUE
		if k_contati > 0 then
			k_return = k_contati
		end if
			
	catch (uo_exception kuo1_exception)
		throw kuo1_exception
	
	end try
	

return k_return



end function

public function boolean get_id_meca_da_barcode (ref st_tab_meca_dosim kst_tab_meca_dosim) throws uo_exception;//
//====================================================================
//=== Trova ID del Lotto dal Barcode Dosimetria in tabella MECA_DOSIM
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


	if len(trim(kst_tab_meca_dosim.barcode)) > 0 then


//--- Se non esiste allora cerco in tabella MECA_DOSIM			
		select distinct id_meca
			into :kst_tab_meca_dosim.id_meca
			from meca_dosim 
			where meca_dosim.barcode = :kst_tab_meca_dosim.barcode
			using kguo_sqlca_db_magazzino;
			
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
	
			k_return = true
			
		else
			if kguo_sqlca_db_magazzino.sqlcode = 100 then
				k_return = false
			else
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Errore durante lettura ID Lotto da Barcode Dosimetria (meca_dosim): " + kst_tab_meca_dosim.barcode  + " ~n~r " + kguo_sqlca_db_magazzino.sqlerrtext
				kguo_exception.inizializza()
				kguo_exception.set_esito( kst_esito )
				throw kguo_exception
			end if
		end if
	end if

	
return k_return


end function

public function st_tab_meca convalida (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception;//
//--- Controllo dati di Convalida Dosimetrica 
//--- Inp: st_tab_meca_dosim.  id_meca / dosim_lotto_dosim / dosim_rapp_a_s 
//--- out: 
//--- Ritorno: st_tab_meca.  note_lav_ok / err_lav_ok
//---
//--- Lancia EXCEPTION x errore grave
//---
boolean k_errore = true
long k_riga
string k_rc
double k_dose_min, k_dose_max
st_esito kst_esito
//st_tab_armo kst_tab_armo 
st_tab_meca kst_tab_meca, kst1_tab_meca
st_tab_armo kst_tab_armo
st_tab_sl_pt kst_tab_sl_pt
st_tab_dosimetrie kst_tab_dosimetrie
//st_tab_contratti kst_tab_contratti
st_tab_base kst_tab_base
st_tab_prodotti kst_tab_prodotti
//kuf_contratti kuf1_contratti
kuf_ausiliari kuf1_ausiliari
kuf_armo kuf1_armo
kuf_sl_pt kuf1_sl_pt
kuf_base kuf1_base
pointer kp_oldpointer


try
//--- Puntatore Cursore da attesa..... 
	kp_oldpointer = SetPointer(HourGlass!)

//	kuf1_contratti = create kuf_contratti
	kuf1_ausiliari = create kuf_ausiliari
	kuf1_sl_pt = create kuf_sl_pt
	kuf1_base = create kuf_base 
	kuf1_armo = create kuf_armo

//--- get numero/data lotto (riferimento)
	kst_tab_meca.id = ast_tab_meca_dosim.id_meca
	kuf1_armo.get_num_int(kst_tab_meca)	

//--- get dati di Convalida
	kst1_tab_meca.id = ast_tab_meca_dosim.id_meca
	kuf1_armo.get_err_lav(kst1_tab_meca)	

//--- get del codice PT x Lotto
	kst_tab_armo.id_meca = ast_tab_meca_dosim.id_meca
	kuf1_armo.get_cod_sl_pt_x_id_meca(kst_tab_armo)
 
////--- get codice contratto	
//	kst_tab_meca.id = ast_tab_meca_dosim.id_meca
//	kst_tab_contratti.codice = kuf1_armo.get_contratto(kst_tab_meca)	

////--- con il codice contratto get del Capitolato (sc-cf)
//	kst_esito = kuf1_contratti.get_co_cf_pt(kst_tab_contratti)
//	if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.db_wrn then
//		kguo_exception.inizializza( )
//		kguo_exception.set_esito(kst_esito)
//		throw kguo_exception
//	end if
	
	setnull(kst_tab_meca.err_lav_ok)
	setnull(kst_tab_meca.note_lav_ok)
	
//	if kst_esito.esito = kkg_esito.ok then

//--- get della DOSE attraverso il coff_a_s nella tabella DOSIMETRIE(la curva) x fare la convalida
		kst_tab_dosimetrie.lotto_dosim = trim(ast_tab_meca_dosim.dosim_lotto_dosim)
		kst_tab_dosimetrie.coeff_a_s = ast_tab_meca_dosim.dosim_rapp_a_s
		kst_tab_dosimetrie.dose = 0
		kst_esito = kuf1_ausiliari.tb_dosimetrie_select(kst_tab_dosimetrie) 

		if kst_esito.esito = kkg_esito.ok then
			
//--- get dati x dosimetria da tab PT
			kst_tab_sl_pt.cod_sl_pt = kst_tab_armo.cod_sl_pt
			kuf1_sl_pt.get_dati_xconvalida(kst_tab_sl_pt)
			
			if kst_tab_sl_pt.dosetgminmin > 0 and kst_tab_sl_pt.dosetgminmax > 0 then
				k_dose_min = kst_tab_sl_pt.dosetgminmin   // dose minima come dose di verifica
				k_dose_max = kst_tab_sl_pt.dosetgminmax   // dose massima come dose di verifica
				
			else
//--- get dell'eventuale tolleranza per la validazione dosimetrica
				kst_tab_base.valid_t_dose_min = 0
				k_rc = kuf1_base.prendi_dato_base("valid_tolleranza_dose_min")
				if LeftA(k_rc,1) = "0" then
					if isnumber (trim(MidA(k_rc,2))) then
						kst_tab_base.valid_t_dose_min = integer(MidA(k_rc,2))
					end if
				end if
 
//--- valorizzo la tolleranza di misurazione della dose min-max				
				k_dose_min = kst_tab_sl_pt.dose_min * (1 - kst_tab_base.valid_t_dose_min/100)
//*** 14-7-2005 ********** ATTENZIONE SU RICHIESTA DELLA ZAMBONI DISATTIVO CONTROLLO CON LA TOLLERANZA **************
//*** 03-1-2006 ********** ATTENZIONE SU RICHIESTA DI BASCHIERI RIATTIVO IL CONTROLLO CON LA TOLLERANZA **************
//*** 04-4-2011 ********** ATTENZIONE SU RICHIESTA DI BASCHIERI ATTIVO IL CONTROLLO CON LA TOLLERANZA SOLO SU DOSE MINIMA **************
//*** 04-4-2011 ********** ATTENZIONE SU RICHIESTA DI ZAMBONI TOLGO IL CHECK SU PRESENZA CAPITOLATO  **************
//*** 05-4-2011 ********** ATTENZIONE SU RICHIESTA DI ZAMBONI IN VIA ECCEZIONALE EVITO IL CONTROLLO SE GRUPPI=17;85;209  **************

//--- se ha il capitolato prendo il valore di riferimento dal contratto minimo + la Tolleranza		
//				if LenA(trim(kst_tab_contratti.sc_cf)) > 0 then 
					k_dose_max = kst_tab_sl_pt.dose_min * (1 + kst_tab_base.valid_t_dose_min/100)
//					k_dose_max = kst_tab_sl_pt.dose_max * (1 + kst_tab_base.valid_t_dose_min/100)
//				else
//					k_dose_max = kst_tab_sl_pt.dose_max 
//				end if
			end if
	
//--- get Gruppo articolo
			kst_tab_meca.id = ast_tab_meca_dosim.id_meca
			select max(gruppo)
				   into :kst_tab_prodotti.gruppo
				   from prodotti inner join armo on prodotti.codice = armo.art
					where armo.id_meca = :ast_tab_meca_dosim.id_meca
					using kguo_sqlca_db_magazzino;
			if isnull(kst_tab_prodotti.gruppo) then kst_tab_prodotti.gruppo = 0

//--- Verifica la DOSE			
			if (kst_tab_dosimetrie.dose >= k_dose_min and kst_tab_dosimetrie.dose <= k_dose_max) &
							OR (kst_tab_prodotti.gruppo = 17  &
								OR kst_tab_prodotti.gruppo = 85  &
								OR kst_tab_prodotti.gruppo = 209)  &
							then   // TOGLIERE L'ECCEZIONE IL PRIMA POSSIBILE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
				k_errore = false
				kst_tab_meca.note_lav_ok = "Verifica dosimetrica convalidata "
//					tab_1.tabpage_1.dw_1.setitem(k_riga, "err_lav_ok", kuf_armo.ki_err_lav_ok_conv_da_aut)
//					tab_1.tabpage_1.dw_1.setitem(k_riga, "note_lav_ok", "Verifica dosimetrica convalidata ")
			else
				if kst_tab_sl_pt.dosetgminmin > 0 and kst_tab_sl_pt.dosetgminmax > 0 then
					kst_tab_meca.note_lav_ok = &
								 "Dose " &
								 + string(kst_tab_dosimetrie.dose, "#####0.00") &
								 + " fuori dal range previsto nel PT (" &
								 + string(kst_tab_sl_pt.dosetgminmin) &
								 + "-" + string(kst_tab_sl_pt.dosetgminmax) + ")"
				else
					kst_tab_meca.note_lav_ok = &
								 "Dose " &
								 + string(kst_tab_dosimetrie.dose, "#####0.00") &
								 + " fuori dal range previsto nel PT (" &
								 + string(kst_tab_sl_pt.dose_min) &
								 + "-" + string(kst_tab_sl_pt.dose_max) + ")"
				end if
			end if
//			else
//				kst_tab_meca.note_lav_ok = "Piano di Lavorazione non trovato "
//			end if
		else
			kst_tab_meca.note_lav_ok = "Lotto Dosimetrico non trovato per il rapporto A/S calcolato"
		end if
//	else
//		kst_tab_meca.note_lav_ok = "Lotto non trovato "
//	end if

//------------------------------------------------------------------------------------------------------- 
//--- se sono stati rilevati errori di dosimetria	
	if k_errore then

		choose case kst1_tab_meca.err_lav_ok
//--- se era da "Prima Convalida"
			case ki_err_lav_ok_da_conv
				kst_tab_meca.err_lav_ok = ki_err_lav_ok_conv_ko_da_aut
//--- se era in "anomalia da autorizzare...."
			case ki_err_lav_ok_conv_ko_da_aut
				kst_tab_meca.err_lav_ok = ki_err_lav_ok_conv_ko_bloc
//--- se era in "OK da autorizzare...."
			case ki_err_lav_ok_conv_da_aut
				kst_tab_meca.err_lav_ok = ki_err_lav_ok_conv_ko_da_aut
//--- se era in "BLOCCATO...."
			case ki_err_lav_ok_conv_ko_bloc
				kst_tab_meca.err_lav_ok = ki_err_lav_ok_conv_ko_sbloc
				kst_tab_meca.note_lav_ok += " - Sbloccato "
//--- in caso di valore non identificato (es. NULL)				
			case else
				kst_tab_meca.err_lav_ok = ki_err_lav_ok_conv_ko_da_aut
		end choose

	else	
		
//--- se dosimetria OK	
		if not k_errore then
			
			choose case kst1_tab_meca.err_lav_ok
//--- se era da "Prima Convalida" si e' deciso di dare immediatamente l'autorizzazione
				case ki_err_lav_ok_da_conv
					kst_tab_meca.err_lav_ok = ki_err_lav_ok_conv_aut_ok
//--- se era in "anomalia da autorizzare...."
				case ki_err_lav_ok_conv_ko_da_aut
					kst_tab_meca.err_lav_ok = ki_err_lav_ok_conv_aut_ok
//--- se era in "OK da autorizzare...."
				case ki_err_lav_ok_conv_da_aut
					kst_tab_meca.err_lav_ok = ki_err_lav_ok_conv_aut_ok
//--- se era in "BLOCCATO...."
				case ki_err_lav_ok_conv_ko_bloc
					kst_tab_meca.err_lav_ok = ki_err_lav_ok_conv_aut_ok
//--- in caso di valore non identificato (es. NULL)				
				case else
					kst_tab_meca.err_lav_ok = ki_err_lav_ok_conv_aut_ok
			end choose
			
		end if
	end if			
	if isnull(kst_tab_meca.note_lav_ok) then
		kst_tab_meca.err_lav_ok = kst_tab_meca.err_lav_ok
		kst_tab_meca.note_lav_ok = kst_tab_meca.note_lav_ok
//	else
//		if isnull(kst_tab_meca.err_lav_ok) then
//			kst_tab_meca.note_lav_ok += " - prima lettura da verificare "
//		end if
	end if
//------------------------------------------------------------------------------------------------------- 

catch (uo_exception kuo_exception)	
	kuo_exception.inizializza( )
	kuo_exception.set_esito(kst_esito)
	throw kuo_exception

finally
//	if isvalid(kuf1_contratti) then destroy kuf1_contratti
	if isvalid(kuf1_ausiliari) then destroy kuf1_ausiliari
	if isvalid(kuf1_sl_pt) then destroy kuf1_sl_pt
	if isvalid(kuf1_base) then destroy kuf1_base 
	if isvalid(kuf1_armo) then destroy kuf1_armo
	
	SetPointer(kp_oldpointer)

end try

return kst_tab_meca


end function

public subroutine set_convalida (st_tab_meca ast_tab_meca) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------
//--- Aggiorna dati Dosimetrici su MECA e MECA_DOSIM
//--- 
//---  input: st_tab_meca.id + st_tab_meca.st_tab_meca_dosim.* valorizzati
//---  lancia exception           
//--- 
//--------------------------------------------------------------------------------------------------------
integer k_ctr
st_esito kst_esito 
st_tab_meca kst_tab_meca_appo
st_tab_barcode kst_tab_barcode
kuf_armo kuf1_armo 
kuf_barcode kuf1_barcode


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if ast_tab_meca.id > 0 then
	else
		kst_esito.esito = kkg_esito.dati_insuff
		kst_esito.sqlcode = 0 
		kst_esito.SQLErrText = "Manca ID del Lotto. Operazione di Convalida dosimetrica non eseguita. " 
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if


	ast_tab_meca.x_datins = kGuf_data_base.prendi_x_datins() // datetime(today(), now())
	ast_tab_meca.x_utente = kGuf_data_base.prendi_x_utente() 

//--- leggo lo stato Attuale
	select err_lav_ok  into :kst_tab_meca_appo.err_lav_ok
		from meca
		where id = :ast_tab_meca.id
		using kguo_sqlca_db_magazzino;

//--- se stato passato a null					
	if isnull(ast_tab_meca.err_lav_ok) or len(trim(ast_tab_meca.err_lav_ok)) = 0 then
		ast_tab_meca.err_lav_ok = ki_err_lav_ok_da_conv
	end if

//--- Aggiorna lo stato e le note della rilevazione dosimetrica	
	update meca set 	 
			 err_lav_ok  = :ast_tab_meca.err_lav_ok
			 ,note_lav_ok = :ast_tab_meca.note_lav_ok
			 ,x_datins = :ast_tab_meca.x_datins
			 ,x_utente = :ast_tab_meca.x_utente
		where id = :ast_tab_meca.id
		using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode 
		kst_esito.SQLErrText = "Errore durante aggiornamento Convalida dosimetrica su Lotto, id lotto: " + string(ast_tab_meca.id) + "~n~r" &
		                  + trim(kguo_sqlca_db_magazzino.sqlerrtext)
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if	
						
//--- check se dosimetria già esistente 
	k_ctr = 0
	select distinct 1 into :k_ctr from meca_dosim 
			 where id_meca = :ast_tab_meca.id using kguo_sqlca_db_magazzino;

// se dosim esistente faccio update								 
	if k_ctr > 0 then
		update meca_dosim set 	 
				 dosim_dose  = :ast_tab_meca.st_tab_meca_dosim.dosim_dose
				 ,dosim_data  = :ast_tab_meca.st_tab_meca_dosim.dosim_data
				 ,dosim_flg_tipo_dose = :ast_tab_meca.st_tab_meca_dosim.dosim_flg_tipo_dose 
				 ,dosim_lotto_dosim = :ast_tab_meca.st_tab_meca_dosim.dosim_lotto_dosim 
				 ,dosim_assorb = :ast_tab_meca.st_tab_meca_dosim.dosim_assorb 
				 ,dosim_spessore = :ast_tab_meca.st_tab_meca_dosim.dosim_spessore
				 ,dosim_rapp_a_s = :ast_tab_meca.st_tab_meca_dosim.dosim_rapp_a_s
				 ,dosim_temperatura = :ast_tab_meca.st_tab_meca_dosim.dosim_temperatura
				 ,dosim_umidita = :ast_tab_meca.st_tab_meca_dosim.dosim_umidita
			where id_meca = :ast_tab_meca.id
			using kguo_sqlca_db_magazzino;
	
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode 
			kst_esito.SQLErrText = "Errore durante aggiornamento dati di Convalida dosimetrica, id lotto: " + string(ast_tab_meca.id) + "~n~r" &
									+ trim(kguo_sqlca_db_magazzino.sqlerrtext)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if	

//--- aggiorno l'utente che ha compiuto l'operazione
//---        se ho appena confermato prima lettura ovvero OK o KO 
		if (isnull(kst_tab_meca_appo.err_lav_ok) or kst_tab_meca_appo.err_lav_ok = ki_err_lav_ok_da_conv) &
			    and (ast_tab_meca.err_lav_ok = ki_err_lav_ok_conv_aut_ok or ast_tab_meca.err_lav_ok = ki_err_lav_ok_conv_ko_da_aut &
			    or ast_tab_meca.err_lav_ok = ki_err_lav_ok_conv_aut_ok) then
			
			update meca_dosim set 	 
				 x_datins = :ast_tab_meca.x_datins
				 ,x_utente = :ast_tab_meca.x_utente
			where id_meca = :ast_tab_meca.id
			using kguo_sqlca_db_magazzino;
								
		else

//--- se ho ero nello stato di PRIMA LETTURA ovvero sono quindi in conferma della Seconda Lettura... 
			if kst_tab_meca_appo.err_lav_ok = ki_err_lav_ok_conv_ko_da_aut &
					or kst_tab_meca_appo.err_lav_ok = ki_err_lav_ok_conv_da_aut then
										
				ast_tab_meca.st_tab_meca_dosim.x_data_dosim_verifica = ast_tab_meca.x_datins
				ast_tab_meca.st_tab_meca_dosim.x_utente_dosim_verifica = ast_tab_meca.x_utente
			
				update meca_dosim set 	 
						x_data_dosim_verifica = :ast_tab_meca.st_tab_meca_dosim.x_data_dosim_verifica
						,x_utente_dosim_verifica = :ast_tab_meca.st_tab_meca_dosim.x_utente_dosim_verifica
					where id_meca = :ast_tab_meca.id
					using kguo_sqlca_db_magazzino;
				
			else
//--- se sto Sbloccando la dosimetria in Anomalia.... 
				if ast_tab_meca.err_lav_ok = ki_err_lav_ok_conv_ko_sbloc  then
										
					ast_tab_meca.st_tab_meca_dosim.x_data_dosim_sblocco_ko = ast_tab_meca.x_datins
					ast_tab_meca.st_tab_meca_dosim.x_utente_dosim_sblocco_ko = ast_tab_meca.x_utente
										
					update meca_dosim set 	 
							x_data_dosim_sblocco_ko = :ast_tab_meca.st_tab_meca_dosim.x_data_dosim_sblocco_ko
							,x_utente_dosim_sblocco_ko = :ast_tab_meca.st_tab_meca_dosim.x_utente_dosim_sblocco_ko
					where id_meca = :ast_tab_meca.id
						using kguo_sqlca_db_magazzino;
						
				end if
			end if
		end if

		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode 
			kst_esito.SQLErrText = "Errore durante aggiornamento altri dati di Convalida dosimetrica, id lotto: " + string(ast_tab_meca.id) + "~n~r" &
									+ trim(kguo_sqlca_db_magazzino.sqlerrtext)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if	
			
	else
		
		kst_esito.sqlcode = 0
		kst_esito.esito = kkg_esito.ko
		kst_esito.SQLErrText = "Errore in carico dati di Convalida dosimetrica, id lotto: " + string(ast_tab_meca.id) + "~n~r" &
								+ "Manca la riga dati in tabella Dosimetria da aggiornare (meca_dosim) "
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
////---- Nuova Dosimetria carico i dati!		
//		insert into meca_dosim  	 
//				 (id_meca
//				 ,dosim_dose  
//				 ,dosim_data
//				 ,dosim_lotto_dosim
//				 ,dosim_assorb
//				 ,dosim_spessore
//				 ,dosim_rapp_a_s
//				 ,dosim_temperatura
//				 ,dosim_umidita
//				 ,x_datins
//				 ,x_utente)
//				 values
//				 (:ast_tab_meca.id
//				 ,:ast_tab_meca.st_tab_meca_dosim.dosim_dose
//				 ,:ast_tab_meca.st_tab_meca_dosim.dosim_data
//				 ,:ast_tab_meca.st_tab_meca_dosim.dosim_lotto_dosim 
//				 ,:ast_tab_meca.st_tab_meca_dosim.dosim_assorb 
//				 ,:ast_tab_meca.st_tab_meca_dosim.dosim_spessore
//				 ,:ast_tab_meca.st_tab_meca_dosim.dosim_rapp_a_s
//				 ,:ast_tab_meca.st_tab_meca_dosim.dosim_temperatura
//				 ,:ast_tab_meca.st_tab_meca_dosim.dosim_umidita
//				 ,:ast_tab_meca.x_datins
//				 ,:ast_tab_meca.x_utente
//				 )
//			using kguo_sqlca_db_magazzino;
//		if kguo_sqlca_db_magazzino.sqlcode < 0 then
//			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode 
//			kst_esito.SQLErrText = "Errore durante inserimento dati di Convalida dosimetrica, id lotto: " + string(ast_tab_meca.id) + "~n~r" &
//									+ trim(kguo_sqlca_db_magazzino.sqlerrtext)
//			kguo_exception.inizializza( )
//			kguo_exception.set_esito(kst_esito)
//			throw kguo_exception
//		end if	
	end if

//-----------------------------------------------------------------------------------------------------------------------
//--- Aggiorna dati di convalida sui singoli BARCODE 
	kst_tab_barcode.num_int = ast_tab_meca.num_int				
	kst_tab_barcode.data_int = ast_tab_meca.data_int				
	kst_tab_barcode.data_lav_ok = ast_tab_meca.st_tab_meca_dosim.dosim_data 
	kst_tab_barcode.err_lav_ok = ast_tab_meca.err_lav_ok				
	kst_tab_barcode.note_lav_ok = ast_tab_meca.note_lav_ok
	
	kuf1_barcode = create kuf_barcode
	kst_tab_barcode.st_tab_g_0.esegui_commit = ast_tab_meca.st_tab_g_0.esegui_commit
	kst_esito = kuf1_barcode.tb_update_campo(kst_tab_barcode, "data_lav_ok_x_rif")

	if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.db_wrn then
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
//-----------------------------------------------------------------------------------------------------------------------



//---- COMMIT....	
	if ast_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if

catch (uo_exception kuo_exception)
	if ast_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception


end try
		


end subroutine

public function integer get_barcode (ref st_tab_meca_dosim kst_tab_meca_dosim[]) throws uo_exception;//
//----------------------------------------------------------------------------------------------------
//--- Torna array di codici Barcode di Dosimetro (ce ne possono essere + di 1 x barcode di lavorazione)
//--- 
//--- Input : kst_tab_meca_dosim_dosim.id_meca e barcode_lav
//--- Out: kst_tab_meca_dosim_dosim[n].barcode 
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

	kst_tab_meca_dosim[1].barcode = ""

	if kst_tab_meca_dosim[1].id_meca > 0 then
	
		declare  c_get_barcode cursor for
			select barcode
				from meca_dosim 
				where meca_dosim.id_meca = :kst_tab_meca_dosim[1].id_meca
				    and meca_dosim.barcode_lav = :kst_tab_meca_dosim[1].barcode_lav
					 group by barcode
					 order by barcode
				using kguo_sqlca_db_magazzino;

		open c_get_barcode;	
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			k_ind = 1

			fetch c_get_barcode into :kst_tab_meca_dosim[k_ind].barcode;
			do while kguo_sqlca_db_magazzino.sqlcode = 0
				k_ind ++
				fetch c_get_barcode into :kst_tab_meca_dosim[k_ind].barcode;
			loop

		end if
		close c_get_barcode;	
	
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_tab_meca_dosim[1].barcode = ""
			
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in lettura del Dosimetro (del barcode '" + trim(kst_tab_meca_dosim[1].barcode_lav) + "') " + trim(kguo_sqlca_db_magazzino.sqlerrtext)
			kguo_exception.inizializza()
			kguo_exception.set_esito( kst_esito )
			throw  kguo_exception
		end if
		
		if k_ind > 0 then
			k_return = k_ind - 1
		else
			kst_tab_meca_dosim[1].barcode = ""
		end if
	end if

	
return k_return


end function

public subroutine tb_delete_x_barcode_lav (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception;//
//====================================================================
//=== Cancella Dosimetro/i che appartiene al barcode di lavorazione e
//===     resetta il flag sul barcode
//=== Inp: barcode_lav
//=== Out:
//=== Ritorna:         Lancia Exception x errore
//====================================================================
boolean k_sicurezza
st_esito kst_esito
st_tab_barcode kst_tab_barcode 
kuf_barcode kuf1_barcode


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try

//	k_sicurezza = if_sicurezza(kkg_flag_modalita.cancellazione)
	
//---- Cancellazione DOSIMETRI										
	delete from meca_dosim
		where barcode_lav = :ast_tab_meca_dosim.barcode_lav
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = &
			"Errore in cancellazione Dosimetri associati al barocde " &
					+ trim(ast_tab_meca_dosim.barcode_lav) + " " &
					+ "~n~rErrore-tab.meca_dosim:"	+ trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko

		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	else

//--- reset del flag dosimetro sul barcode
		kuf1_barcode = create kuf_barcode
		kst_tab_barcode.barcode = ast_tab_meca_dosim.barcode_lav
		kuf1_barcode.set_flg_dosimetro_reset(kst_tab_barcode)

		if ast_tab_meca_dosim.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_dosim.st_tab_g_0.esegui_commit) then
			kst_esito = kguo_sqlca_db_magazzino.db_commit( )
		end if
	
	end if
										

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally

	
end try
		
		




end subroutine

public subroutine tb_delete_x_id_meca (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception;//
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
	delete from meca_dosim
		where id_meca = :ast_tab_meca_dosim.id_meca
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = &
			"Errore in cancellazione Dosimetri associati al Lotto di ID = " &
					+ string(ast_tab_meca_dosim.id_meca) + " " &
					+ "~n~rErrore-tab.meca_dosim:"	+ trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko

		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	else

		if ast_tab_meca_dosim.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_dosim.st_tab_g_0.esegui_commit) then
			kst_esito = kguo_sqlca_db_magazzino.db_commit( )
		end if
	
	end if
										

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally

	
end try
		
		




end subroutine

public function integer if_esiste_barcode_lav (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception;//
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


if trim(ast_tab_meca_dosim.barcode_lav) > " " then
	
//	if isnull(ast_tab_meca_dosim.barcode) then ast_tab_meca_dosim.barcode = ""
//	if isnull(ast_tab_meca_dosim.barcode_lav) then ast_tab_meca_dosim.barcode_lav = ""

	//			and barcode = :ast_tab_meca_dosim.barcode

	select count(*)
		into :k_ctr
		from meca_dosim 
		where barcode_lav = :ast_tab_meca_dosim.barcode_lav
		using kguo_sqlca_db_magazzino ;

//			and barcode_lav = :ast_tab_meca_dosim.barcode_lav
		
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in lettura esistenza Barcode Dosimetria: " + ast_tab_meca_dosim.barcode + sqlca.sqlerrtext
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

public function boolean if_esiste (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception;//
//==============================================================================
//=== Controllo se Riferimento-Dosimetria Esiste x BARCODE
//=== 
//=== Inp: barcode
//=== Out: 
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


if trim(ast_tab_meca_dosim.barcode) > " " then
	
//	if isnull(ast_tab_meca_dosim.barcode) then ast_tab_meca_dosim.barcode = ""
//	if isnull(ast_tab_meca_dosim.barcode_lav) then ast_tab_meca_dosim.barcode_lav = ""

	//			and barcode = :ast_tab_meca_dosim.barcode

	select 1
		into :k_ctr
		from meca_dosim 
		where barcode = :ast_tab_meca_dosim.barcode
		using kguo_sqlca_db_magazzino ;

//			and barcode_lav = :ast_tab_meca_dosim.barcode_lav
		
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in lettura esistenza Barcode di Dosimetria: " + ast_tab_meca_dosim.barcode + sqlca.sqlerrtext
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

public subroutine tb_delete (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception;//
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

	if trim(ast_tab_meca_dosim.barcode) > " " or trim(ast_tab_meca_dosim.barcode_lav) > " " then

		
	//---- Cancellazione DOSIMETRO x il suo barcode		
		if trim(ast_tab_meca_dosim.barcode) > " " then
			delete from meca_dosim
				where barcode = :ast_tab_meca_dosim.barcode
				using kguo_sqlca_db_magazzino;
		else
			if trim(ast_tab_meca_dosim.barcode_lav) > " " then
				delete from meca_dosim
					where barcode_lav = :ast_tab_meca_dosim.barcode_lav
					using kguo_sqlca_db_magazzino;
			end if
		end if
	
	
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = &
				"Errore in cancellazione Dosimetro " &
						+ trim(ast_tab_meca_dosim.barcode) + " " &
						+ "~n~rErrore-tab.meca_dosim:" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
	
			kguo_exception.inizializza()
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		else
	
			if ast_tab_meca_dosim.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_dosim.st_tab_g_0.esegui_commit) then
				kst_esito = kguo_sqlca_db_magazzino.db_commit( )
			end if
		
		end if
											
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally

	
end try
		
		




end subroutine

public function integer if_esiste_barcode_lav_con_dosim (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception;//
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


if trim(ast_tab_meca_dosim.barcode_lav) > " " then
	
//	if isnull(ast_tab_meca_dosim.barcode) then ast_tab_meca_dosim.barcode = ""
//	if isnull(ast_tab_meca_dosim.barcode_lav) then ast_tab_meca_dosim.barcode_lav = ""

	//			and barcode = :ast_tab_meca_dosim.barcode

	select count(*)
		into :k_ctr
		from meca_dosim 
		where barcode_lav = :ast_tab_meca_dosim.barcode_lav
		    and barcode_dosimetro > " "
		using kguo_sqlca_db_magazzino ;

//			and barcode_lav = :ast_tab_meca_dosim.barcode_lav
		
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in conteggio Barcode dosimetri già associati: " + ast_tab_meca_dosim.barcode + sqlca.sqlerrtext
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

public function integer u_genera_rimuove_barcode (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception;//---
//--- Genera barcode dosimetri
//---
//--- input: st_tab_meca_dosim.id_meca / barcode_lav
//--- 		se passato il barcode allora fa solo quello
//--- out: numero bcode generati
//---
int k_return = 0
long k_nr_barcode=0, k_riga_barcode, k_ind
int k_nr_bcode_associati=0, k_nr_dosimpos
datastore kds_1, kds_sl_pt_dosimpos
kuf_barcode kuf1_barcode
kuf_armo kuf1_armo
kuf_sl_pt kuf1_sl_pt
st_tab_meca_dosim kst_tab_meca_dosim, kst_tab_meca_dosim_ultimo, kst_tab_meca_dosim_delete
st_tab_armo kst_tab_armo
st_tab_sl_pt kst_tab_sl_pt
st_esito kst_esito 


try
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	kst_esito.st_tab_g_0 = ast_tab_meca_dosim.st_tab_g_0 

//	if_sicurezza(kkg_flag_modalita.inserimento) 
	if trim(ast_tab_meca_dosim.barcode_lav) > " " then 
	else
		ast_tab_meca_dosim.barcode_lav = ""
	end if

	if ast_tab_meca_dosim.id_meca > 0 then 
               
//--- leggo i barcode del lotto 
		kds_1 = create datastore
		kds_1.dataobject = "ds_barcode_set_flg_dosimetro"
		kds_1.settransobject(kguo_sqlca_db_magazzino)
		k_nr_barcode = kds_1.retrieve(ast_tab_meca_dosim.id_meca)
	
	end if
	
	if k_nr_barcode > 0 then

//--- get del codice PT per leggere i dati di dove mettere i Dosimetri
		kuf1_armo = create kuf_armo
		kst_tab_armo.id_armo = kds_1.getitemnumber(1, "id_armo")
		kst_tab_sl_pt.cod_sl_pt = kuf1_armo.get_cod_sl_pt(kst_tab_armo)
//--- get dei dati da PT circa il nr dosimetri		
		kuf1_sl_pt = create kuf_sl_pt
		if trim(kst_tab_sl_pt.cod_sl_pt) > " " then
			kuf1_sl_pt.get_dosim_dati(kst_tab_sl_pt)
			if kst_tab_sl_pt.dosim_x_bcode > 0 then
			else
				kst_tab_sl_pt.dosim_x_bcode = 1
			end if
		else
			kst_tab_sl_pt.dosim_x_bcode = 1
		end if

//--- leggo i barcode del lotto 
		if trim(kst_tab_sl_pt.cod_sl_pt) > " " then 
			kds_sl_pt_dosimpos = create datastore
			kds_sl_pt_dosimpos.dataobject = "ds_sl_pt_dosimpos_l"
			kds_sl_pt_dosimpos.settransobject(kguo_sqlca_db_magazzino)
			k_nr_dosimpos = kds_sl_pt_dosimpos.retrieve(kst_tab_sl_pt.cod_sl_pt)
		end if

//--- calcolo dove mettere i dosimetri: se richiesto + di uno allora il primo barcode deve contenere il dosimetro
		if kst_tab_sl_pt.dosim_x_bcode > 0 then
			k_riga_barcode = 1
			for k_riga_barcode = 1 to k_nr_barcode
				if kds_1.getitemstring(k_riga_barcode, "flg_dosimetro") = kuf1_barcode.ki_flg_dosimetro_si then
				
//--- faccio tutto il LOTTO o solo il BARCODE di lavorazione indicato?					
					if ast_tab_meca_dosim.barcode_lav = "" or ast_tab_meca_dosim.barcode_lav = kds_1.getitemstring(k_riga_barcode, "barcode") then 
						
//--- torna nr barcode che sono già associati 	
						kst_tab_meca_dosim.barcode_lav = kds_1.getitemstring(k_riga_barcode, "barcode")
						k_nr_bcode_associati = if_esiste_barcode_lav_con_dosim(kst_tab_meca_dosim)
						if k_nr_bcode_associati > kst_tab_sl_pt.dosim_x_bcode then
							tb_delete_x_barcode_lav(kst_tab_meca_dosim)  // rimuove solo il barcode_lav x rifarlo
						end if
						if kst_tab_sl_pt.dosim_x_bcode > k_nr_bcode_associati then
							
							k_nr_bcode_associati ++
							for k_ind = k_nr_bcode_associati to kst_tab_sl_pt.dosim_x_bcode
								
								//--- Aggiunge posizione del dosimetro								
								if k_nr_dosimpos >= k_ind then
									kst_tab_meca_dosim.id_dosimpos = kds_sl_pt_dosimpos.getitemnumber( k_ind, "id_dosimpos")
									kst_tab_meca_dosim.sl_pt_dosimpos_seq = kds_sl_pt_dosimpos.getitemnumber( k_ind, "seq")
								else
									kst_tab_meca_dosim.id_dosimpos = 0
									kst_tab_meca_dosim.sl_pt_dosimpos_seq = 0
								end if
								
								//--- genera uno o più barcode per etichetta
								kst_tab_meca_dosim.id_meca = ast_tab_meca_dosim.id_meca
								kst_tab_meca_dosim.barcode = genera_barcode( )  // genera il barcode 
								kst_tab_meca_dosim.st_tab_g_0.esegui_commit = "N"  // no COMMIT altrimenti chiude il CURSORE
								if tb_add_barcode(kst_tab_meca_dosim)  then // insert barcode in tabella
									try
										kst_tab_meca_dosim_ultimo = kst_tab_meca_dosim
//										set_ultimo_numero_barcode_dsm_in_base(kst_tab_meca_dosim)	// AGGIORNA ANCHE TAB BASE		
									
									catch (uo_exception kuo1_exception)
										throw kuo1_exception
									
									end try
								end if
								
							next
							
							set_ultimo_numero_barcode_dsm_in_base(kst_tab_meca_dosim_ultimo)	// AGGIORNA ANCHE TAB BASE		
						
						end if
					end if
				else
					kst_tab_meca_dosim_delete.barcode_lav = kds_1.getitemstring(k_riga_barcode, "barcode")
					if trim(kst_tab_meca_dosim_delete.barcode_lav) > " " then
						tb_delete(kst_tab_meca_dosim_delete)  // rimuove i/il barcode dosimetro non richiesto
					end if
				end if
			next
			if ast_tab_meca_dosim.st_tab_g_0.esegui_commit = "N" then
			else
				kguo_sqlca_db_magazzino.db_commit( )
			end if
		end if
	end if
	
catch (uo_exception kuo_exception)
	if ast_tab_meca_dosim.st_tab_g_0.esegui_commit = "N" then
	else
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception
	
finally
	if isvalid(kds_1) then destroy kds_1
	if isvalid(kds_sl_pt_dosimpos) then destroy kds_sl_pt_dosimpos
	if isvalid(kuf1_sl_pt) then destroy kuf_sl_pt
	if isvalid(kuf1_armo) then destroy kuf1_armo
	
end try

return k_return

end function

public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception;//
//=== 
//====================================================================
//=== Attiva LINK cliccato 
//===
//=== Par. Inut: 
//===               datawindow su cui è stato attivato il LINK
//===               nome campo di LINK
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Grave
//===                                     2=Errore gestito
//===                                     3=altro errore
//===                                     100=Non trovato 
//=== 
//====================================================================
//
//=== 
long k_rc
string k_rcx
boolean k_return=false
string k_dataobject
st_tab_meca_dosim kst_tab_meca_dosim
st_esito kst_esito
datastore kdsi_elenco_output, kds_1   //ds da passare alla windows di elenco
st_open_w kst_open_w 
kuf_menu_window kuf1_menu_window


SetPointer(kkg.pointer_attesa)

kdsi_elenco_output = create datastore

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""


if adw_link.getrow() = 0 then
else
	choose case a_campo_link
	
		case "b_barcode_dosim_l", "flg_dosimetro" 
			kst_tab_meca_dosim.barcode_lav = adw_link.getitemstring(adw_link.getrow(), "barcode")
			if trim(kst_tab_meca_dosim.barcode_lav) > " " then
				k_dataobject = "d_meca_dosim_l_x_barcode_lav"
				kst_open_w.key1 = "Barcode dosimetri associati al barcode di lavorazione " + trim(kst_tab_meca_dosim.barcode_lav) + ") "
				k_return = true	
			end if
	
		case "b_meca_dosim_barcode_l"
			kst_tab_meca_dosim.id_meca = adw_link.getitemnumber(adw_link.getrow(), "id_meca")
			if kst_tab_meca_dosim.id_meca > 0 then
				kds_1 = create datastore
				kds_1.dataobject = "ds_meca_dosim_tot_x_id_meca"
				kds_1.settransobject(kguo_sqlca_db_magazzino)
				if kds_1.retrieve(kst_tab_meca_dosim.id_meca) > 0 then
					if kds_1.getitemnumber(1, "contati") > 1 then
						k_dataobject = "d_meca_dosim_l"
						kst_open_w.key1 = "Elenco dosimetri del Lotto id " + string(kst_tab_meca_dosim.id_meca) 
					else
						k_dataobject = "d_meca_dosim"
						kst_open_w.key1 = "Dosimetro del Lotto id " + string(kst_tab_meca_dosim.id_meca) 
					end if
				end if
				k_return = true
			end if
	
		case "meca_dosim_barcode" &
		 		, "b_meca_dosim_barcode"
			kst_tab_meca_dosim.barcode = adw_link.getitemstring(adw_link.getrow(), "meca_dosim_barcode")
			if trim(kst_tab_meca_dosim.barcode) > " " then
				k_dataobject = "d_convalida_dosim_x_barcode"
				kst_open_w.key1 = "Barcode dosimetro " + trim(kst_tab_meca_dosim.barcode) + ") "
				k_return = true
			end if

	end choose
end if


if k_return then

	try
		k_return = if_sicurezza(kkg_flag_modalita.elenco)
	catch (uo_exception kuo_exception)
		throw kuo_exception
	end try

	if not k_return then
	
	else
		kdsi_elenco_output.dataobject = k_dataobject		
		kdsi_elenco_output.settransobject(sqlca)

		kdsi_elenco_output.reset()	
		
		choose case a_campo_link
					
			case "b_barcode_dosim_l", "flg_dosimetro"  
				k_rc=kdsi_elenco_output.retrieve(kst_tab_meca_dosim.barcode_lav)
		
			case "b_meca_dosim_barcode_l"
				k_rc=kdsi_elenco_output.retrieve(kst_tab_meca_dosim.id_meca)
					
			case "meca_dosim_barcode" &
		 			, "b_meca_dosim_barcode"
				k_rc=kdsi_elenco_output.retrieve(kst_tab_meca_dosim.barcode)
		
		end choose

	end if
	

	if kdsi_elenco_output.rowcount() > 0 then
	
		
	//--- chiamare la window di elenco
	//
	//=== Parametri : 
	//=== struttura st_open_w
		kst_open_w.id_programma = kkg_id_programma.elenco  //kkg_id_programma_elenco
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
		kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
		kst_open_w.flag_leggi_dw = " "
		kst_open_w.flag_cerca_in_lista = " "
		kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = kGuf_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key12_any = kdsi_elenco_output
		kst_open_w.flag_where = " "
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(kst_open_w)
		destroy kuf1_menu_window


//	else
//		
//		kguo_exception.inizializza()
//		kguo_exception.setmessage(u_get_errmsg_nontrovato(kst_open_w.flag_modalita ))
//		throw kguo_exception
//		
		
	end if

end if

SetPointer(kkg.pointer_default)



return k_return

end function

public subroutine if_isnull (ref st_tab_meca_dosim kst_tab_meca_dosim);//---
//--- toglie i NULL ai campi della tabella 
//---

if isnull(kst_tab_meca_dosim.dosim_assorb) then	kst_tab_meca_dosim.dosim_assorb = 0
if isnull(kst_tab_meca_dosim.dosim_spessore) then	kst_tab_meca_dosim.dosim_spessore = 0
if isnull(kst_tab_meca_dosim.dosim_rapp_a_s) then	kst_tab_meca_dosim.dosim_rapp_a_s = 0 
if isnull(kst_tab_meca_dosim.dosim_lotto_dosim) then	kst_tab_meca_dosim.dosim_lotto_dosim = ""
if isnull(kst_tab_meca_dosim.dosim_temperatura) then	kst_tab_meca_dosim.dosim_temperatura = 0 	
if isnull(kst_tab_meca_dosim.dosim_umidita) then	kst_tab_meca_dosim.dosim_umidita = 0 	
if isnull(kst_tab_meca_dosim.dosim_data) then	kst_tab_meca_dosim.dosim_data = date(0)
if isnull(kst_tab_meca_dosim.dosim_dose) then	kst_tab_meca_dosim.dosim_dose = 0
if isnull(kst_tab_meca_dosim.x_data_dosim_verifica) then	kst_tab_meca_dosim.x_data_dosim_verifica = datetime(date(0))
if isnull(kst_tab_meca_dosim.x_utente_dosim_verifica) then	kst_tab_meca_dosim.x_utente_dosim_verifica = ""
if isnull(kst_tab_meca_dosim.x_data_dosim_sblocco_ko) then	kst_tab_meca_dosim.x_data_dosim_verifica = datetime(date(0))
if isnull(kst_tab_meca_dosim.x_utente_dosim_sblocco_ko) then	kst_tab_meca_dosim.x_utente_dosim_sblocco_ko = "" 
if isnull(kst_tab_meca_dosim.x_datins) then	kst_tab_meca_dosim.x_datins = datetime(date(0))
if isnull(kst_tab_meca_dosim.x_utente) then	kst_tab_meca_dosim.x_utente = ""
if isnull(kst_tab_meca_dosim.barcode)  then kst_tab_meca_dosim.barcode = ""
if isnull(kst_tab_meca_dosim.barcode_dosimetro)  then kst_tab_meca_dosim.barcode_dosimetro = ""
if isnull(kst_tab_meca_dosim.barcode_lav)  then kst_tab_meca_dosim.barcode_lav = ""
if isnull(kst_tab_meca_dosim.dosim_flg_tipo_dose) then	kst_tab_meca_dosim.dosim_flg_tipo_dose = ""
if isnull(kst_tab_meca_dosim.id_dosimpos) then	kst_tab_meca_dosim.id_dosimpos = 0
if isnull(kst_tab_meca_dosim.sl_pt_dosimpos_seq) then	kst_tab_meca_dosim.sl_pt_dosimpos_seq = 0




end subroutine

public function date get_data_x_certif (ref st_tab_meca_dosim kst_tab_meca_dosim) throws uo_exception;//
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
	if kst_tab_meca_dosim.id_meca > 0 then
	
		SELECT max(dosim_data)
				 ,max(x_data_dosim_verifica)
				 ,max(x_data_dosim_sblocco_ko)
				 INTO 
						:kst_tab_meca_dosim.dosim_data
						,:kst_tab_meca_dosim.x_data_dosim_verifica
						,:kst_tab_meca_dosim.x_data_dosim_sblocco_ko
				 FROM meca_dosim  
				WHERE meca_dosim.id_meca = :kst_tab_meca_dosim.id_meca
					 using kguo_sqlca_db_magazzino;
				
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
//--- x default piglia la data di convalida
			if kst_tab_meca_dosim.dosim_data > kguo_g.get_datazero( ) then 
				k_return = kst_tab_meca_dosim.dosim_data
			end if
//--- se data di verifica superiore a quella precedente
			if date(kst_tab_meca_dosim.x_data_dosim_verifica) > kguo_g.get_datazero( ) then 
				if date(kst_tab_meca_dosim.x_data_dosim_verifica) > k_return then
					k_return = date(kst_tab_meca_dosim.x_data_dosim_verifica)
				end if
			end if
//--- x se data di Sblocco superiore a quella precedente
			if date(kst_tab_meca_dosim.x_data_dosim_sblocco_ko) > kguo_g.get_datazero( ) then 
				if date(kst_tab_meca_dosim.x_data_dosim_sblocco_ko) > k_return then
					k_return = date(kst_tab_meca_dosim.x_data_dosim_sblocco_ko)
				end if
			end if
			
//--- check date di autorizzazione e sblocco su meca magari ce n'e' una più recente
			kuf1_armo = create kuf_armo
			kst_tab_meca.id = kst_tab_meca_dosim.id_meca
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
			kst_esito.SQLErrText = "Tab.Dosimetri Lotto (id=" + string(kst_tab_meca_dosim.id_meca) + ") " &
										 + "~n~r"  + trim(kguo_sqlca_db_magazzino.SQLErrText)
			if kguo_sqlca_db_magazzino.sqlcode = 100 then
				kst_esito.esito = kkg_esito.not_fnd
				kst_tab_meca_dosim.id_meca = 0
			else
				if kguo_sqlca_db_magazzino.sqlcode > 0 then
					kst_esito.esito = kkg_esito.db_wrn
					kst_tab_meca_dosim.id_meca = 0
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

public subroutine set_barcode (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------
//--- Aggiorna Barcode Dosimetro (DSM...) per 
//--- 
//---  input: st_tab_meca.id + st_tab_meca.st_tab_meca_dosim.* valorizzati
//---  lancia exception           
//--- 
//--------------------------------------------------------------------------------------------------------
integer k_ctr
st_esito kst_esito 
st_tab_meca kst_tab_meca_appo
st_tab_barcode kst_tab_barcode
kuf_armo kuf1_armo 
kuf_barcode kuf1_barcode


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if trim(ast_tab_meca_dosim.barcode_lav) > " " then
	else
		kst_esito.esito = kkg_esito.dati_insuff
		kst_esito.sqlcode = 0 
		kst_esito.SQLErrText = "Manca BARCODE di Trattamento del Lotto. Operazione di aggiornamento barcode dosimetro non eseguita. " 
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	ast_tab_meca_dosim.x_datins = kGuf_data_base.prendi_x_datins() 
	ast_tab_meca_dosim.x_utente = kGuf_data_base.prendi_x_utente() 

//--- Aggiorna lo stato e le note della rilevazione dosimetrica	
	update meca_dosim set 	 
			 barcode = :ast_tab_meca_dosim.barcode
			 ,x_datins = :ast_tab_meca_dosim.x_datins
			 ,x_utente = :ast_tab_meca_dosim.x_utente
		where barcode_lav = :ast_tab_meca_dosim.barcode_lav
		using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode 
		kst_esito.SQLErrText = "Errore durante aggiornamento Barcode dosimetro, barcode di trattamento: " + string(ast_tab_meca_dosim.barcode_lav) + "~n~r" &
		                  + trim(kguo_sqlca_db_magazzino.sqlerrtext)
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if	

//---- COMMIT....	
	if ast_tab_meca_dosim.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_dosim.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if

catch (uo_exception kuo_exception)
	if ast_tab_meca_dosim.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_dosim.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception


end try
		


end subroutine

public function boolean if_dosimetria_gia_definitivo (string a_err_lav_ok);//---
//--- Controllo se la Dosimetria e' gia' nello stato Definitivo quindi non modificabile
//---
//--- Ritorna:  TRUE = gia' definitivo;  FALSE = non definitivo
//---
boolean k_definitivo=false

	if a_err_lav_ok = ki_err_lav_ok_conv_ko_sbloc &
		or a_err_lav_ok = ki_err_lav_ok_conv_aut_ok &
	   then
		
		k_definitivo = true
		
	end if

return k_definitivo


end function

public function boolean if_dosimetria_gia_autorizzata (string a_err_lav_ok);//---
//--- Controllo flag Dosimetria se e' gia' stata Autorizzata la Prima Rilevazione Dosimetrica
//---
//--- Ritorna:  TRUE = gia' autorizzato;  FALSE = non autorizzato
//---
boolean k_autorizzato=false

	if not isnull(a_err_lav_ok) and a_err_lav_ok <> ki_err_lav_ok_da_conv &
		and a_err_lav_ok <> ki_err_lav_ok_conv_ko_da_aut &
		and a_err_lav_ok <> ki_err_lav_ok_conv_da_aut then
		
		k_autorizzato = true
		
	end if

return k_autorizzato


end function

public function string get_err_lav_ok_descr (string a_err_lav_ok);//---
//--- Restituisce la descrizione dello stato del flag della Dosimetria
//---
//--- Parametri di input: kst_tab_meca flag err_lav_ok valorizzato
//--- Ritorna:  stringa col testo
//---
string k_testo=" "

	choose case a_err_lav_ok
		case ki_err_lav_ok_da_conv
			k_testo = "da Convalidare"
		case ki_err_lav_ok_conv_ko_da_aut
			k_testo = "Anomalia da Verificare"
		case ki_err_lav_ok_conv_da_aut
			k_testo = "da Verificare"
		case ki_err_lav_ok_conv_aut_ok
			k_testo = "Convalidato"
		case ki_err_lav_ok_conv_ko_bloc
			k_testo = "Blocco x Anomalia"
		case ki_err_lav_ok_conv_ko_sbloc
			k_testo = "Rilasciato"
		case else
			k_testo = "da Convalidare"
		
	end choose


return k_testo


end function

public function boolean if_dosimetria_convalidata_ok (string a_err_lav_ok);//---
//--- Convalida OK? oppure era in KO ma Sbloccato?
//---
boolean k_return = false


	if a_err_lav_ok = ki_err_lav_ok_conv_aut_ok &
			or a_err_lav_ok = ki_err_lav_ok_conv_ko_sbloc then
		k_return = true
	end if


return k_return
end function

public function st_esito anteprima_dosim (ref datawindow adw_anteprima, st_tab_meca_dosim ast_tab_meca_dosim);//
//====================================================================
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
//st_open_w kst_open_w
st_esito kst_esito
//kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility


try
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	k_return = if_sicurezza(kkg_flag_modalita.anteprima)
	
	if not k_return then
		
		kst_esito = kguo_exception.get_st_esito( )

	else
	
//		if ast_tab_meca.num_int > 0 then
		if trim(ast_tab_meca_dosim.barcode) > " " then 
	
			adw_anteprima.dataobject = "d_convalida_dett" //"d_convalida_dosim"		
			adw_anteprima.settransobject(sqlca)
	
			kuf1_utility = create kuf_utility
			kuf1_utility.u_dw_toglie_ddw(1, adw_anteprima)
			destroy kuf1_utility
	
			adw_anteprima.reset()
			
			k_rc=adw_anteprima.retrieve(ast_tab_meca_dosim.barcode) // ast_tab_meca.num_int, year(ast_tab_meca.data_int))
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessuna Convalida-Dosimetrica da visualizzare: ~n~r" + "nessun codice indicato"
			kst_esito.esito = "1"
			
		end if
	end if

catch(uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()

end try


return kst_esito

end function

public function st_esito anteprima_dosim_l (ref datawindow adw_anteprima, st_tab_meca_dosim ast_tab_meca_dosim);//
//====================================================================
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
//st_open_w kst_open_w
st_esito kst_esito
//kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility


try
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	k_return = if_sicurezza(kkg_flag_modalita.anteprima)
	
	if not k_return then
		
		kst_esito = kguo_exception.get_st_esito( )

	else
	
		if ast_tab_meca_dosim.id_meca > 0 then
	
			adw_anteprima.dataobject = "d_convalida_dosim_l" //"d_convalida_dosim"		
			adw_anteprima.settransobject(sqlca)
	
			kuf1_utility = create kuf_utility
			kuf1_utility.u_dw_toglie_ddw(1, adw_anteprima)
			destroy kuf1_utility
	
			adw_anteprima.reset()
			
			k_rc=adw_anteprima.retrieve(ast_tab_meca_dosim.barcode) // ast_tab_meca.num_int, year(ast_tab_meca.data_int))
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Convalida-Dosimetrica: ~n~r" + "nessun id Lotto indicato"
			kst_esito.esito = "1"
			
		end if
	end if

catch(uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()

end try


return kst_esito

end function

public subroutine set_convalida_x_barcode (readonly st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception;//--------------------------------------------------------------------------------------------------------
//--- Aggiorna dati Dosimetrici su MECA e MECA_DOSIM per BARCODE della dosimetria
//--- 
//---  input: st_tab_meca.id + st_tab_meca.st_tab_meca_dosim.* valorizzati
//---  lancia exception           
//--- 
//--------------------------------------------------------------------------------------------------------
integer k_ctr, k_trovato=0
st_esito kst_esito 
//st_tab_meca kst_tab_meca
st_tab_meca_dosim kst_tab_meca_dosim
st_tab_barcode kst_tab_barcode
//kuf_armo kuf1_armo 
kuf_barcode kuf1_barcode


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if ast_tab_meca_dosim.id_meca > 0 or trim(ast_tab_meca_dosim.barcode) = "" then
	else
		kst_esito.esito = kkg_esito.dati_insuff
		kst_esito.sqlcode = 0 
		kst_esito.SQLErrText = "Mancano i dati per eseguire la Convalida dosimetrica. " 
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	ast_tab_meca_dosim.x_datins = kGuf_data_base.prendi_x_datins() // datetime(today(), now())
	ast_tab_meca_dosim.x_utente = kGuf_data_base.prendi_x_utente() 

	kuf1_barcode = create kuf_barcode
						
//--- get dell'esito dosimetria precedente se già esistente 
	//k_ctr = 0
	select err_lav_ok into :kst_tab_meca_dosim.err_lav_ok 
	       from meca_dosim 
			 where barcode = :ast_tab_meca_dosim.barcode 
			 using kguo_sqlca_db_magazzino;
	if kst_tab_meca_dosim.err_lav_ok > " " then
	else
//--- oggi marzo/2016 per Compatibilità con il vecchio sistema per un po' tengo anche la lettura sul LOTTO
		select err_lav_ok into :kst_tab_meca_dosim.err_lav_ok 
	       from meca
			 where id = :ast_tab_meca_dosim.id_meca 
			 using kguo_sqlca_db_magazzino;
	end if

//--- se dosim esistente faccio update								 
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		update meca_dosim set 	 
				 dosim_dose  = :ast_tab_meca_dosim.dosim_dose
				 ,dosim_data  = :ast_tab_meca_dosim.dosim_data
				 ,dosim_flg_tipo_dose = :ast_tab_meca_dosim.dosim_flg_tipo_dose 
				 ,dosim_lotto_dosim = :ast_tab_meca_dosim.dosim_lotto_dosim 
				 ,dosim_assorb = :ast_tab_meca_dosim.dosim_assorb 
				 ,dosim_spessore = :ast_tab_meca_dosim.dosim_spessore
				 ,dosim_rapp_a_s = :ast_tab_meca_dosim.dosim_rapp_a_s
				 ,dosim_temperatura = :ast_tab_meca_dosim.dosim_temperatura
				 ,dosim_umidita = :ast_tab_meca_dosim.dosim_umidita
			 	 ,err_lav_ok  = :ast_tab_meca_dosim.err_lav_ok
			 	 ,note_lav_ok = :ast_tab_meca_dosim.note_lav_ok
			where barcode = :ast_tab_meca_dosim.barcode
			using kguo_sqlca_db_magazzino;
	
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode 
			kst_esito.SQLErrText = "Errore durante aggiornamento dati di Convalida dosimetrica, Barcode: " + trim(ast_tab_meca_dosim.barcode) + "~n~r" &
									+ trim(kguo_sqlca_db_magazzino.sqlerrtext)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if	

//--- aggiorno data e utente che ha compiuto l'operazione
//---        se ho appena confermato prima lettura ovvero OK o KO 
		if (isnull(kst_tab_meca_dosim.err_lav_ok) or kst_tab_meca_dosim.err_lav_ok = ki_err_lav_ok_da_conv) &
			    and (ast_tab_meca_dosim.err_lav_ok = ki_err_lav_ok_conv_aut_ok &
				 or ast_tab_meca_dosim.err_lav_ok = ki_err_lav_ok_conv_ko_da_aut &
			    or ast_tab_meca_dosim.err_lav_ok = ki_err_lav_ok_conv_aut_ok) then
			
			update meca_dosim set 	 
				 x_datins = :ast_tab_meca_dosim.x_datins
				 ,x_utente = :ast_tab_meca_dosim.x_utente
			where barcode = :ast_tab_meca_dosim.barcode
			using kguo_sqlca_db_magazzino;
								
		else

//--- se ho ero nello stato di PRIMA LETTURA ovvero sono quindi in conferma della Seconda Lettura... 
			if kst_tab_meca_dosim.err_lav_ok = ki_err_lav_ok_conv_ko_da_aut &
					or kst_tab_meca_dosim.err_lav_ok = ki_err_lav_ok_conv_da_aut then
										
				ast_tab_meca_dosim.x_data_dosim_verifica = ast_tab_meca_dosim.x_datins
				ast_tab_meca_dosim.x_utente_dosim_verifica = ast_tab_meca_dosim.x_utente
			
				update meca_dosim set 	 
						x_data_dosim_verifica = :ast_tab_meca_dosim.x_data_dosim_verifica
						,x_utente_dosim_verifica = :ast_tab_meca_dosim.x_utente_dosim_verifica
					where barcode = :ast_tab_meca_dosim.barcode
					using kguo_sqlca_db_magazzino;
				
			else
				
//--- se sto Sbloccando la dosimetria in Anomalia.... 
				if ast_tab_meca_dosim.err_lav_ok = ki_err_lav_ok_conv_ko_sbloc  then
										
					ast_tab_meca_dosim.x_data_dosim_sblocco_ko = ast_tab_meca_dosim.x_datins
					ast_tab_meca_dosim.x_utente_dosim_sblocco_ko = ast_tab_meca_dosim.x_utente
										
					update meca_dosim set 	 
							x_data_dosim_sblocco_ko = :ast_tab_meca_dosim.x_data_dosim_sblocco_ko
							,x_utente_dosim_sblocco_ko = :ast_tab_meca_dosim.x_utente_dosim_sblocco_ko
						where barcode = :ast_tab_meca_dosim.barcode
						using kguo_sqlca_db_magazzino;
						
				end if
			end if
		end if
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode 
			kst_esito.SQLErrText = "Errore durante aggiornamento altri dati di Convalida dosimetrica, barcode: " + trim(ast_tab_meca_dosim.barcode) + "~n~r" &
									+ trim(kguo_sqlca_db_magazzino.sqlerrtext)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if	
	end if

//--- Aggiorna stato del LOTTO solo se HO letto TUTTE le dosimetrie, quindi leggo se ho dei dosimetri non letti
	k_trovato = 0
	select distinct 1 into :k_trovato
			from meca_dosim
			where id_meca = :ast_tab_meca_dosim.id_meca
			      and (err_lav_ok = '' or err_lav_ok is null)
			using kguo_sqlca_db_magazzino;
			
	if k_trovato = 1 then // se ho trovato dosimetrie non lette allora NON AGGIORNA
	
	else
		if kguo_sqlca_db_magazzino.sqlcode > 0 and k_trovato = 0 then // Dosimetrie TUTTE lette

			kst_tab_meca_dosim = ast_tab_meca_dosim
			set_convalida_lotto(kst_tab_meca_dosim)  // AGGIORNA DEFINITIVAMENTE IL LOTTO
			
		end if
	end if

//-----------------------------------------------------------------------------------------------------------------------
//--- Aggiorna dati di convalida sul singolo BARCODE Trattato  
	kst_tab_barcode.barcode = ast_tab_meca_dosim.barcode_lav			
	kst_tab_barcode.data_lav_ok = ast_tab_meca_dosim.dosim_data
	kst_tab_barcode.err_lav_ok = ast_tab_meca_dosim.err_lav_ok				
	kst_tab_barcode.note_lav_ok = ast_tab_meca_dosim.note_lav_ok
	
	kst_tab_barcode.st_tab_g_0.esegui_commit = ast_tab_meca_dosim.st_tab_g_0.esegui_commit
	kst_esito = kuf1_barcode.tb_update_campo(kst_tab_barcode, "data_lav_ok_x_barcode")

	if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.db_wrn then
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
//-----------------------------------------------------------------------------------------------------------------------


//---- COMMIT....	
	if ast_tab_meca_dosim.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_dosim.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if


catch (uo_exception kuo_exception)
	if ast_tab_meca_dosim.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_dosim.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception


finally
//	if isvalid(kuf1_armo) then destroy kuf1_armo
	if isvalid(kuf1_barcode) then destroy kuf1_barcode


end try

end subroutine

public function st_tab_meca_dosim convalida_dosim (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception;//
//--- Controllo dati di Convalida Dosimetrica 
//--- Inp: st_tab_meca_dosim.  id_meca / dosim_lotto_dosim / dosim_rapp_a_s 
//--- out: 
//--- Ritorno: st_tab_meca.  note_lav_ok / err_lav_ok
//---
//--- Lancia EXCEPTION x errore grave
//---
boolean k_errore 
long k_riga
string k_rc
double k_dose_min, k_dose_max
st_esito kst_esito
//st_tab_armo kst_tab_armo 
st_tab_meca kst1_tab_meca  //kst_tab_meca,
st_tab_meca_dosim kst_tab_meca_dosim
st_tab_armo kst_tab_armo
st_tab_sl_pt kst_tab_sl_pt
st_tab_dosimetrie kst_tab_dosimetrie
st_tab_base kst_tab_base
st_tab_prodotti kst_tab_prodotti
kuf_ausiliari kuf1_ausiliari
kuf_armo kuf1_armo
kuf_sl_pt kuf1_sl_pt
kuf_base kuf1_base


try
//--- Puntatore Cursore da attesa..... 
	setPointer(kkg.pointer_attesa)

	kst_tab_meca_dosim = ast_tab_meca_dosim
	
	if ast_tab_meca_dosim.dosim_flg_tipo_dose = ki_dosim_flg_tipo_dose_MASSIMA or ast_tab_meca_dosim.dosim_flg_tipo_dose = ki_dosim_flg_tipo_dose_ALTRO then
		kst_tab_meca_dosim.note_lav_ok = "Verifica dosimetrica non necessaria"
		kst_tab_meca_dosim.err_lav_ok = kst_tab_meca_dosim.err_lav_ok
		k_errore = false
	else
		k_errore = true
	
		kuf1_ausiliari = create kuf_ausiliari
		kuf1_sl_pt = create kuf_sl_pt
		kuf1_base = create kuf_base 
		kuf1_armo = create kuf_armo
	
		setnull(kst_tab_meca_dosim.err_lav_ok)
		setnull(kst_tab_meca_dosim.note_lav_ok)

//--- get numero/data lotto (riferimento)
		kst1_tab_meca.id = ast_tab_meca_dosim.id_meca
		kuf1_armo.get_num_int(kst1_tab_meca)	

//--- get stato dosimetria
		get_err_lav_ok(kst_tab_meca_dosim)	

//--- get dati di Convalida
		kst1_tab_meca.id = ast_tab_meca_dosim.id_meca
		kuf1_armo.get_err_lav(kst1_tab_meca)	

//--- get del codice PT x Lotto
		kst_tab_armo.id_meca = ast_tab_meca_dosim.id_meca
		kuf1_armo.get_cod_sl_pt_x_id_meca(kst_tab_armo)
 

		kst_tab_meca_dosim.dosim_dose = 0

//--- get della DOSE attraverso il coff_a_s nella tabella DOSIMETRIE(la curva) x fare la convalida
		kst_tab_dosimetrie.lotto_dosim = trim(ast_tab_meca_dosim.dosim_lotto_dosim)
		kst_tab_dosimetrie.coeff_a_s = ast_tab_meca_dosim.dosim_rapp_a_s
		kst_tab_dosimetrie.dose = 0
		kst_esito = kuf1_ausiliari.tb_dosimetrie_select(kst_tab_dosimetrie) 

		if kst_esito.esito = kkg_esito.ok then
			
			kst_tab_meca_dosim.dosim_dose = kst_tab_dosimetrie.dose
			
//--- get dati x dosimetria da tab PT
			kst_tab_sl_pt.cod_sl_pt = kst_tab_armo.cod_sl_pt
			kuf1_sl_pt.get_dati_xconvalida(kst_tab_sl_pt)
			
			if kst_tab_sl_pt.dosetgminmin > 0 and kst_tab_sl_pt.dosetgminmax > 0 then
				k_dose_min = kst_tab_sl_pt.dosetgminmin   // dose minima come dose di verifica
				k_dose_max = kst_tab_sl_pt.dosetgminmax   // dose massima come dose di verifica
				
			else
//--- get dell'eventuale tolleranza per la validazione dosimetrica
				kst_tab_base.valid_t_dose_min = 0
				k_rc = kuf1_base.prendi_dato_base("valid_tolleranza_dose_min")
				if LeftA(k_rc,1) = "0" then
					if isnumber (trim(MidA(k_rc,2))) then
						kst_tab_base.valid_t_dose_min = integer(MidA(k_rc,2))
					end if
				end if
 
//--- valorizzo la tolleranza di misurazione della dose min-max				
				k_dose_min = kst_tab_sl_pt.dose_min * (1 - kst_tab_base.valid_t_dose_min/100)
//*** 14-7-2005 ********** ATTENZIONE SU RICHIESTA DELLA ZAMBONI DISATTIVO CONTROLLO CON LA TOLLERANZA **************
//*** 03-1-2006 ********** ATTENZIONE SU RICHIESTA DI BASCHIERI RIATTIVO IL CONTROLLO CON LA TOLLERANZA **************
//*** 04-4-2011 ********** ATTENZIONE SU RICHIESTA DI BASCHIERI ATTIVO IL CONTROLLO CON LA TOLLERANZA SOLO SU DOSE MINIMA **************
//*** 04-4-2011 ********** ATTENZIONE SU RICHIESTA DI ZAMBONI TOLGO IL CHECK SU PRESENZA CAPITOLATO  **************
//*** 05-4-2011 ********** ATTENZIONE SU RICHIESTA DI ZAMBONI IN VIA ECCEZIONALE EVITO IL CONTROLLO SE GRUPPI=17;85;209  **************

//--- se ha il capitolato prendo il valore di riferimento dal contratto minimo + la Tolleranza		
//				if LenA(trim(kst_tab_contratti.sc_cf)) > 0 then 
//					k_dose_max = kst_tab_sl_pt.dose_max * (1 + kst_tab_base.valid_t_dose_min/100)
//				else
//					k_dose_max = kst_tab_sl_pt.dose_max 
//				end if
	
				k_dose_max = kst_tab_sl_pt.dose_min * (1 + kst_tab_base.valid_t_dose_min/100)
			end if

//--- get Gruppo articolo
			select gruppo
				into :kst_tab_prodotti.gruppo
				from prodotti inner join armo on prodotti.codice = armo.art
				where armo.id_armo in
					(select id_armo
					    from barcode
						 where barcode = :ast_tab_meca_dosim.barcode_lav)
					using kguo_sqlca_db_magazzino;
			if isnull(kst_tab_prodotti.gruppo) then kst_tab_prodotti.gruppo = 0

//--- Verifica la DOSE			
			if (kst_tab_dosimetrie.dose >= k_dose_min and kst_tab_dosimetrie.dose <= k_dose_max) &
							OR (kst_tab_prodotti.gruppo = 17  &
								OR kst_tab_prodotti.gruppo = 85  &
								OR kst_tab_prodotti.gruppo = 209)  &
							then   // TOGLIERE L'ECCEZIONE IL PRIMA POSSIBILE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
				k_errore = false
				kst_tab_meca_dosim.note_lav_ok = "Verifica dosimetrica convalidata "
//					tab_1.tabpage_1.dw_1.setitem(k_riga, "err_lav_ok", kuf_armo.ki_err_lav_ok_conv_da_aut)
//					tab_1.tabpage_1.dw_1.setitem(k_riga, "note_lav_ok", "Verifica dosimetrica convalidata ")
			else
				if kst_tab_sl_pt.dosetgminmin > 0 and kst_tab_sl_pt.dosetgminmax > 0 then
					kst_tab_meca_dosim.note_lav_ok = &
								 "Dose " &
								 + string(kst_tab_dosimetrie.dose, "#####0.00") &
								 + " fuori dal range previsto nel PT (" &
								 + string(kst_tab_sl_pt.dosetgminmin) &
								 + "-" + string(kst_tab_sl_pt.dosetgminmax) + ")"
				else
					kst_tab_meca_dosim.note_lav_ok = &
								 "Dose " &
								 + string(kst_tab_dosimetrie.dose, "#####0.00") &
								 + " fuori dal range previsto nel PT (" &
								 + string(kst_tab_sl_pt.dose_min) &
								 + "-" + string(kst_tab_sl_pt.dose_max) + ")"
				end if
			end if
//			else
//				kst_tab_meca.note_lav_ok = "Piano di Lavorazione non trovato "
//			end if
		else
			kst_tab_meca_dosim.note_lav_ok = "Lotto Dosimetrico (curva) non trovato per il rapporto A/S calcolato"
		end if
	end if

//------------------------------------------------------------------------------------------------------- 
//--- se sono stati rilevati errori di dosimetria	
	if trim(kst_tab_meca_dosim.err_lav_ok) > " " then
	else
//--- oggi Marzo/2016 faccio questo x mantenere la compatibilotà col passato ma è da togliere 		
		kst_tab_meca_dosim.err_lav_ok = kst1_tab_meca.err_lav_ok
	end if
	
	if k_errore then

		choose case kst_tab_meca_dosim.err_lav_ok
//--- se era da "Prima Convalida"
			case ki_err_lav_ok_da_conv
				kst_tab_meca_dosim.err_lav_ok = ki_err_lav_ok_conv_ko_da_aut
//--- se era in "anomalia da autorizzare...."
			case ki_err_lav_ok_conv_ko_da_aut
				kst_tab_meca_dosim.err_lav_ok = ki_err_lav_ok_conv_ko_bloc
//--- se era in "OK da autorizzare...."
			case ki_err_lav_ok_conv_da_aut
				kst_tab_meca_dosim.err_lav_ok = ki_err_lav_ok_conv_ko_da_aut
//--- se era in "BLOCCATO...."
			case ki_err_lav_ok_conv_ko_bloc
				kst_tab_meca_dosim.err_lav_ok = ki_err_lav_ok_conv_ko_sbloc
				kst_tab_meca_dosim.note_lav_ok += " - Sbloccato "
//--- in caso di valore non identificato (es. NULL)				
			case else
				kst_tab_meca_dosim.err_lav_ok = ki_err_lav_ok_conv_ko_da_aut
		end choose

	else	
		
//--- se dosimetria OK	
		if not k_errore then
			
			choose case kst_tab_meca_dosim.err_lav_ok
//--- se era da "Prima Convalida" si e' deciso di dare immediatamente l'autorizzazione
				case ki_err_lav_ok_da_conv
					kst_tab_meca_dosim.err_lav_ok = ki_err_lav_ok_conv_aut_ok
//--- se era in "anomalia da autorizzare...."
				case ki_err_lav_ok_conv_ko_da_aut
					kst_tab_meca_dosim.err_lav_ok = ki_err_lav_ok_conv_aut_ok
//--- se era in "OK da autorizzare...."
				case ki_err_lav_ok_conv_da_aut
					kst_tab_meca_dosim.err_lav_ok = ki_err_lav_ok_conv_aut_ok
//--- se era in "BLOCCATO...."
				case ki_err_lav_ok_conv_ko_bloc
					kst_tab_meca_dosim.err_lav_ok = ki_err_lav_ok_conv_aut_ok
//--- in caso di valore non identificato (es. NULL)				
				case else
					kst_tab_meca_dosim.err_lav_ok = ki_err_lav_ok_conv_aut_ok
			end choose
			
		end if
	end if			
	if isnull(kst_tab_meca_dosim.note_lav_ok) then
		kst_tab_meca_dosim.err_lav_ok = ""
		kst_tab_meca_dosim.note_lav_ok = ""
	end if
//------------------------------------------------------------------------------------------------------- 

catch (uo_exception kuo_exception)	
	kuo_exception.inizializza( )
	kuo_exception.set_esito(kst_esito)
	throw kuo_exception

finally
	if isvalid(kuf1_ausiliari) then destroy kuf1_ausiliari
	if isvalid(kuf1_sl_pt) then destroy kuf1_sl_pt
	if isvalid(kuf1_base) then destroy kuf1_base 
	if isvalid(kuf1_armo) then destroy kuf1_armo
	
//	SetPointer(kkg.pointer_default)

end try

return kst_tab_meca_dosim


end function

public subroutine get_err_lav_ok (ref st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception;//
//-------------------------------------------------------------------------------------------------------
//--- get campi ERR_LAV_OK 
//--- 
//--- Input : st_tab_meca_dosim.barcode 
//--- out: st_tab_meca_dosim.err_lav_ok
//--- Ritorna: nulla 
//--- Exception se erore con st_esito valorizzato
//---					
//---   
//--------------------------------------------------------------------------------------------------------
st_esito kst_esito

	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


//--- conta il numero di colli entrati
	select err_lav_ok
		into :ast_tab_meca_dosim.err_lav_ok
		from meca_dosim 
		where meca_dosim.barcode = :ast_tab_meca_dosim.barcode
		using kguo_sqlca_db_magazzino ;
	
	if sqlca.sqlcode <> 0 then
		ast_tab_meca_dosim.err_lav_ok = ""
		if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore durante lettura dati dello Stato di Convalida. Barcode: " + trim(ast_tab_meca_dosim.barcode) + ". Err.: " + trim(sqlca.sqlerrtext)
			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito )
			throw kguo_exception
		end if
	end if
	
	

end subroutine

public subroutine get_dosim_dose_min (ref st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception;//
//-------------------------------------------------------------------------------------------------------
//--- get valore MINIMO dose
//--- 
//--- Input : st_tab_meca_dosim.id_meca 
//--- out: st_tab_meca_dosim.dosim_dose
//--- Ritorna: nulla 
//--- Exception se errore con st_esito valorizzato
//---					
//---   
//--------------------------------------------------------------------------------------------------------
st_esito kst_esito
st_tab_meca_dosim kst_tab_meca_dosim


	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_meca_dosim.dosim_flg_tipo_dose = ki_dosim_flg_tipo_dose_MINIMA	
	ast_tab_meca_dosim.dosim_dose = 0.00

	select min(dosim_dose)
		into :ast_tab_meca_dosim.dosim_dose
		from meca_dosim 
		where (meca_dosim.id_meca = :ast_tab_meca_dosim.id_meca
					)
		        and (meca_dosim.dosim_flg_tipo_dose is null
				       or meca_dosim.dosim_flg_tipo_dose = :kst_tab_meca_dosim.dosim_flg_tipo_dose
						 or meca_dosim.dosim_flg_tipo_dose = ''
						 )
			 and meca_dosim.barcode > ' '
		using kguo_sqlca_db_magazzino ;

//18092018				 and barcode_dosimetro > ' '
//           		      or meca_dosim.barcode_lav in 
// 				 		 (select barcode_lav from barcode where id_meca = :ast_tab_meca_dosim.id_meca)
	
	
	if sqlca.sqlcode <> 0 then
		if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in lettura dose MINIMA tra i valori Minimi Convalidati, Lotto: " + string(ast_tab_meca_dosim.id_meca) + ". Err.: " + trim(sqlca.sqlerrtext)
			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito )
			throw kguo_exception
		end if
	end if
	
	if ast_tab_meca_dosim.dosim_dose > 0 then
	else
		ast_tab_meca_dosim.dosim_dose = 0.00
	end if

end subroutine

public subroutine get_dosim_dose_max (ref st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception;//
//-------------------------------------------------------------------------------------------------------
//--- get valore max DOSE
//--- 
//--- Input : st_tab_meca_dosim.id_meca 
//--- out: st_tab_meca_dosim.dosim_dose
//--- Ritorna: nulla 
//--- Exception se errore con st_esito valorizzato
//---					
//---   
//--------------------------------------------------------------------------------------------------------
st_esito kst_esito
st_tab_meca_dosim kst_tab_meca_dosim


	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_meca_dosim.dosim_flg_tipo_dose = ki_dosim_flg_tipo_dose_MASSIMA
	ast_tab_meca_dosim.dosim_dose = 0.00

	select max(dosim_dose)
		into :ast_tab_meca_dosim.dosim_dose
		from meca_dosim 
		where (meca_dosim.id_meca = :ast_tab_meca_dosim.id_meca
					)
				and meca_dosim.dosim_flg_tipo_dose = :kst_tab_meca_dosim.dosim_flg_tipo_dose
			 and meca_dosim.barcode > ' '
		using kguo_sqlca_db_magazzino ;

//18092018			    and barcode_dosimetro > ' '
	
	if sqlca.sqlcode <> 0 then
		if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in lettura dose MAX tra i valori Massimi Convalidati el Lotto: " + string(ast_tab_meca_dosim.id_meca) + ". Err.: " + trim(sqlca.sqlerrtext)
			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito )
			throw kguo_exception
		end if
	end if
	
	if ast_tab_meca_dosim.dosim_dose > 0 then
	else
		ast_tab_meca_dosim.dosim_dose = 0.00
	end if

end subroutine

public function boolean set_ultimo_numero_barcode_dsm_in_base (st_tab_meca_dosim kst_tab_meca_dosim) throws uo_exception;//
//--------------------------------------------------------------------------------------------
//--- Imposta ultimo  BARCODE  sul BASE
//--- 
//--- 
//---  input: barcode
//---  Outout: 
//---  Ritorna: STRINGA 	con lultimo progr Barcode trovato
//---                                     
//--------------------------------------------------------------------------------------------
//
boolean k_return=false
st_tab_base kst_tab_base
st_esito kst_esito
kuf_base kuf1_base


try
	
   kst_esito.esito = kkg_esito.ok
   kst_esito.sqlcode = 0
   kst_esito.SQLErrText = ""
   kst_esito.nome_oggetto = this.classname()

  	kuf1_base = create kuf_base

	kst_tab_base.dosimetro_barcode_mask = left(trim(kst_tab_meca_dosim.barcode),3)
	kst_tab_base.dosimetro_ult_barcode = mid(trim(kst_tab_meca_dosim.barcode),4)

//--- Setta i primi 3 caratteri che identifcano il barcode
	kst_tab_base.st_tab_g_0.esegui_commit = "N"
	kst_tab_base.key = "dosimetro_barcode_mask"
	kst_tab_base.key1 = kst_tab_base.dosimetro_barcode_mask
	kst_esito  = kuf1_base.metti_dato_base(kst_tab_base)

//--- piglia l'ultimo barcode generato dal BASE
	if kst_esito.esito = kkg_esito.ok then
		kst_tab_base.st_tab_g_0.esegui_commit = kst_tab_meca_dosim.st_tab_g_0.esegui_commit 
		kst_tab_base.key = "dosimetro_ult_barcode"
		kst_tab_base.key1 = kst_tab_base.dosimetro_ult_barcode
		kst_esito = kuf1_base.metti_dato_base(kst_tab_base)
	end if
	
	if kst_esito.esito <> kkg_esito.ok then
		kst_esito.esito = kkg_esito.ko
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Errore durante registrazione dati Barcode Dosimetrici in tabella (BASE)."
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
   
	k_return = true 
	
catch (uo_exception kuo_exception)
	throw kuo_exception


finally 
   	destroy kuf1_base

end try

return k_return

end function

public subroutine tb_delete_completa (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception;//
//====================================================================
//=== Cancella Dosimetro se non ancora in PL e nel caso 
//===     resetta il flag sul barcode di lavorazione
//=== Inp: barcode, barcode_lav
//=== Out:
//=== Ritorna:         Lancia Exception x errore
//====================================================================
boolean k_sicurezza
st_esito kst_esito
st_tab_barcode kst_tab_barcode 
kuf_barcode kuf1_barcode


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try

//	k_sicurezza = if_sicurezza(kkg_flag_modalita.cancellazione)

	if trim(ast_tab_meca_dosim.barcode) > " " then
	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Operazione di cancellazione Dosimetro interrotta, manca il codice! " 
		kst_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- verifica che il barcode di lavorazione non sia stato pianificato
	if trim(ast_tab_meca_dosim.barcode_lav) > " " then
		kst_tab_barcode.barcode = ast_tab_meca_dosim.barcode_lav
		kuf1_barcode = create kuf_barcode
		if kuf1_barcode.if_barcode_in_pl(kst_tab_barcode) then
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Il dosimetro " + trim(ast_tab_meca_dosim.barcode) + " non può essere rimosso,~n~r"  &
						+ " barcode " + trim(kst_tab_barcode.barcode) + " già trattato o pianificato."
			kst_esito.esito = kkg_esito.no_esecuzione
			kguo_exception.inizializza()
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if

//---- Cancellazione DOSIMETRO									
	delete from meca_dosim
		where barcode = :ast_tab_meca_dosim.barcode
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = &
			"Errore in cancellazione Dosimetri associati al barocde " &
					+ trim(ast_tab_meca_dosim.barcode_lav) + " " &
					+ "~n~rErrore-tab.meca_dosim:"	+ trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko

		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	else

		if trim(ast_tab_meca_dosim.barcode_lav) > " " then
			if if_esiste_barcode_lav(ast_tab_meca_dosim) = 0 then // se non ci sono più dosimetri 
//--- reset del flag dosimetro sul barcode
				kuf1_barcode = create kuf_barcode
				kst_tab_barcode.barcode = ast_tab_meca_dosim.barcode_lav
				kuf1_barcode.set_flg_dosimetro_reset(kst_tab_barcode)
			end if
		end if

		if ast_tab_meca_dosim.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_dosim.st_tab_g_0.esegui_commit) then
			kst_esito = kguo_sqlca_db_magazzino.db_commit( )
		end if
	
	end if

catch (uo_exception kuo_exception)
	if ast_tab_meca_dosim.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_dosim.st_tab_g_0.esegui_commit) then
		kst_esito = kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception
	
finally
	if isvalid(kuf1_barcode) then destroy kuf1_barcode
	
end try
		
		




end subroutine

private function string get_ultimo_numero_barcode_da_base () throws uo_exception;//
//--------------------------------------------------------------------------------------------
//--- Torna ultimo progressivo del BARCODE 
//--- 
//--- 
//---  input: 
//---  Outout: 
//---  Ritorna: STRINGA 	con l'ultimo progr Barcode impostato sul BASE 'DSM+progressivo' 
//---                                     
//--------------------------------------------------------------------------------------------
//
string k_return=""
st_tab_base kst_tab_base
st_esito kst_esito
kuf_base kuf1_base


try
	
   kst_esito.esito = kkg_esito.ok
   kst_esito.sqlcode = 0
   kst_esito.SQLErrText = ""
   kst_esito.nome_oggetto = this.classname()

  	kuf1_base = create kuf_base

//--- piglia i primi 3 caratteri che identifcano il barcode
	kst_tab_base.dosimetro_barcode_mask = trim(mid(kuf1_base.prendi_dato_base( "dosimetro_barcode_mask"),2))
	if trim(kst_tab_base.dosimetro_barcode_mask) > " " then
	else
		kst_tab_base.dosimetro_barcode_mask = "DSM"
	end if

//--- piglia suffisso ultimo barcode impostato sul BASE
   kst_tab_base.dosimetro_ult_barcode = trim(mid(kuf1_base.prendi_dato_base( "dosimetro_ult_barcode"),2))

//--- se tutto ok torna il Barcode
	if trim(kst_tab_base.dosimetro_ult_barcode) > " "  then
       k_return = trim(kst_tab_base.dosimetro_barcode_mask) + trim(kst_tab_base.dosimetro_ult_barcode)
	else
       k_return = trim(kst_tab_base.dosimetro_barcode_mask) + "AA000"
	end if
   
catch (uo_exception kuo_exception)
	throw kuo_exception


finally 
  	destroy kuf1_base

end try

return k_return

end function

private function string get_ultimo_numero_barcode () throws uo_exception;//
//--------------------------------------------------------------------------------------------
//--- Torna ultimo progressivo del BARCODE 
//--- 
//--- 
//---  input: 
//---  Outout: 
//---  Ritorna: STRINGA 	con lultimo progr Barcode trovato
//---                                     
//--------------------------------------------------------------------------------------------
//
string k_return=""
string k_barcode_intero=""
st_tab_base kst_tab_base
st_esito kst_esito


try
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//--- cerca ultimo barcode nelBASE
	k_barcode_intero = get_ultimo_numero_barcode_da_base( )
	
//--- se non trovato cerca in tabella MECA_DOSIM
	kst_tab_base.dosimetro_ult_barcode = get_ultimo_numero_barcode_da_tab(left(trim(k_barcode_intero),3) )  // Ultimo Barcode caricato in TABELLA
	if len(trim(kst_tab_base.dosimetro_ult_barcode)) > 0  then
		k_barcode_intero = left(trim(k_barcode_intero),3) + trim(kst_tab_base.dosimetro_ult_barcode)
	end if		

//--- se OK torna il Barcode
	if len(trim(k_barcode_intero)) > 3  then
      k_return = trim(k_barcode_intero)
	else
      k_return = trim(k_barcode_intero) + "AA000"
	end if
   
catch (uo_exception kuo_exception)
	throw kuo_exception


finally 

end try

return k_return

end function

private function string genera_barcode () throws uo_exception;//
//--------------------------------------------------------------------------------------------
//--- Torna il nuovo BARCODE 
//--- 
//--- 
//---  input: 
//---  Outout: 
//---  Ritorna: STRINGA 	con il valore del nuovo Barcode
//---                                     
//--------------------------------------------------------------------------------------------
//
string k_return=""
string k_barcode_progr, k_barcode_alfa="", k_barcode_pref, k_barcode_inizio="", k_barcode_intero=""
string K_ALFA, K_ALFA1, K_BARC_CLIENTE_ALFA[0 to 30] 
int K_ALFA1_LENGTH, K_ALFA_LENGTH
int k_barcode_num=0, K_CTR1
boolean k_barcode_ok= false
date k_data_meno90gg
st_tab_base kst_tab_base
st_tab_meca_dosim kst_tab_meca_dosim
st_tab_armo kst_tab_armo
st_esito kst_esito
kuf_armo kuf1_armo
pointer kpointer  // Declares a pointer variable

 
try
	
//--- Puntatore Cursore da attesa.....
	kpointer = SetPointer(HourGlass!)

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//--- piglia l'ultimo barcode generato
	k_barcode_intero = get_ultimo_numero_barcode( )  // Ultimo Barcode caricato
	
//--- divide il bcode in 2 ALFA (mask) + PROGRESSIVO (2 alfa + 3 numerici)
	kst_tab_base.dosimetro_barcode_mask = left(trim(k_barcode_intero),3)
	k_barcode_progr = mid(trim(k_barcode_intero),4)
	if trim(k_barcode_progr) > " " and isnumber(mid(k_barcode_progr,3,3)) then
		k_barcode_pref = left(k_barcode_progr,2) 
		k_barcode_num = integer(mid(k_barcode_progr,3,3))
	else
		k_barcode_pref = "AA"
		k_barcode_num = 0
	end if
			
	kuf1_armo = create kuf_armo
	
//#-------------------------------------------------------------------------------
//#--- Il barcode alla GAMMARAD e' composto sostanzialmente cosi':
//#    e' un code-39 di 8 caratteri 'cccxxnnn'
//#    ccc  = codice di 3 deciso nelle Proprietà se non ho messo nulla imposta DSM
//#    xx   = progressivo alfanumerico
//#    nnn = progressivo 0-999 numerico
//#-------------------------------------------------------------------------------


//--- Tabella x incremento prima parte del barcode 1 e 2 carattere
     K_ALFA  = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
     K_ALFA_LENGTH = len(trim(K_ALFA)) - 2
     K_ALFA1 = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
     K_ALFA1_LENGTH = len(trim(K_ALFA1)) - 2

     K_BARC_CLIENTE_ALFA [0] = "A"
     K_BARC_CLIENTE_ALFA [1] = "B"
     K_BARC_CLIENTE_ALFA [2] = "C"
     K_BARC_CLIENTE_ALFA [3] = "D"
     K_BARC_CLIENTE_ALFA [4] = "E"
     K_BARC_CLIENTE_ALFA [5] = "F"
     K_BARC_CLIENTE_ALFA [6] = "G"
     K_BARC_CLIENTE_ALFA [7] = "H"
     K_BARC_CLIENTE_ALFA [8] = "I"
     K_BARC_CLIENTE_ALFA [9] = "J"
     K_BARC_CLIENTE_ALFA [10] = "K"
     K_BARC_CLIENTE_ALFA [11] = "L"
     K_BARC_CLIENTE_ALFA [12] = "M"
     K_BARC_CLIENTE_ALFA [13] = "N"
     K_BARC_CLIENTE_ALFA [14] = "O"
     K_BARC_CLIENTE_ALFA [15] = "P"
     K_BARC_CLIENTE_ALFA [16] = "Q"
     K_BARC_CLIENTE_ALFA [17] = "R"
     K_BARC_CLIENTE_ALFA [18] = "S"
     K_BARC_CLIENTE_ALFA [19] = "T"
     K_BARC_CLIENTE_ALFA [20] = "U"
     K_BARC_CLIENTE_ALFA [21] = "V"
     K_BARC_CLIENTE_ALFA [22] = "W"
     K_BARC_CLIENTE_ALFA [23] = "X"
     K_BARC_CLIENTE_ALFA [24] = "Y"
     K_BARC_CLIENTE_ALFA [25] = "Z"

	k_data_meno90gg = relativedate(kg_dataoggi, -90)
	kst_tab_armo.data_int = k_data_meno90gg
	kst_esito = kuf1_armo.get_id_meca_da_data(kst_tab_armo)  // becca il primo id lotto ad una certa data
	if kst_esito.esito = kkg_esito.ok then
		kst_tab_meca_dosim.id_meca = kst_tab_armo.id_meca
	else
		kst_tab_meca_dosim.id_meca = 0
	end if

	do while not k_barcode_ok

		if k_barcode_num < 999 then
			k_barcode_num = k_barcode_num + 1
		else
			k_barcode_num = 001 
		
			for K_CTR1 = 1 to K_ALFA1_LENGTH
				if mid(k_barcode_pref,2,1) = mid(K_ALFA1,K_CTR1,1) then  
					exit 
				end if 
			end for 
			
			if mid(k_barcode_pref,2,1) <> mid(K_ALFA1,K_CTR1,1) then  
				k_barcode_pref = replace(k_barcode_pref,2,1, mid(K_ALFA1,1,1)) 
			
				for K_CTR1 = 1 to K_ALFA_LENGTH
					if mid(k_barcode_pref,1,1) = mid(K_ALFA,K_CTR1,1) then  
						exit 
					end if
				end for 
			
				if mid(k_barcode_pref,1,1) <> mid(K_ALFA,K_CTR1,1) then  
					k_barcode_pref = replace(k_barcode_pref,1,1,mid(K_ALFA,1,1))
				else
					K_CTR1 = K_CTR1 + 1
					k_barcode_pref = replace(k_barcode_pref,1,1,mid(K_ALFA,K_CTR1,1))
				end if
			else
				K_CTR1 = K_CTR1 + 1
				k_barcode_pref = replace(k_barcode_pref,2,1,mid(K_ALFA1,K_CTR1,1))
			end if 

		
		end if
	

		kst_tab_meca_dosim.barcode = trim(kst_tab_base.dosimetro_barcode_mask) + trim(k_barcode_pref) + string(k_barcode_num,"000")

	
//---controllo se i barcode esistono gia'	in tab BARCODE e MECA_DOSIM
		if kst_tab_meca_dosim.id_meca = 0 then
			k_barcode_ok = true   // OK BUONO !!!
		else
			if not if_esiste_barcode(kst_tab_meca_dosim) then
				k_barcode_ok = true   // OK BUONO !!!
			end if
		end if

			
	loop
   
  	if k_barcode_ok then
		k_return = trim(kst_tab_base.dosimetro_barcode_mask) + trim(k_barcode_pref) + string(k_barcode_num,"000")
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kuf1_armo) then destroy kuf1_armo
	SetPointer(kpointer)
	
end try

return k_return

end function

public function boolean add_avviso_pronto_merce (st_tab_meca ast_tab_meca) throws uo_exception;//------------------------------------------------------------------------------------------------------------------------
//--- Carica la tabella Pronto Merce per fare poi il carico nella tabella email-invio 
//--- Inp: st_tab_meca id_meca
//--- Out: il ID del meca_ptmerce
//------------------------------------------------------------------------------------------------------------------------
//
boolean k_return=false 
datetime k_inserito
kuf_meca_ptmerce kuf1_meca_ptmerce
st_tab_meca_ptmerce kst_tab_meca_ptmerce
st_esito kst_esito


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if ast_tab_meca.id > 0 then 
	else
		kguo_exception.inizializza( )
		kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_non_eseguito )
		kguo_exception.set_nome_oggetto(this.classname( ) )
		kguo_exception.setmessage( "Manca id Lotto. Carico dell'avviso in archivio Pronto Merce non eseguito. ")
		throw kguo_exception
	end if

	
	kuf1_meca_ptmerce = create kuf_meca_ptmerce
		

//--- CARICO dati nella tabella EMAIL_INVIO	
	kst_tab_meca_ptmerce.st_tab_g_0.esegui_commit = ast_tab_meca.st_tab_g_0.esegui_commit
	kst_tab_meca_ptmerce.id_meca = ast_tab_meca.id
	k_inserito = kuf1_meca_ptmerce.tb_add(kst_tab_meca_ptmerce)  

	if date(k_inserito) > date(0) then	
		k_return = true
	else		
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Errore durante il carico dell'avviso in tabella Pronto Merce del Lotto, id " + string(kst_tab_meca_ptmerce.id_meca) + "!"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

catch (uo_exception kuo_exception)	
	throw kuo_exception
	
finally
	if isvalid(kuf1_meca_ptmerce) then destroy kuf1_meca_ptmerce
	
	
end try



return k_return

end function

public subroutine tb_delete_x_barcode_dosimetro_l (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception;//
//====================================================================
//=== Cancella Dosimetro x barcode di lavorazione e barcode_dosimetro
//===     resetta il 
//=== Inp: id_meca + barcode_lav + barcode_dosimetro
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
	
//---- Cancellazione DOSIMETRO									
	delete from meca_dosim
		where meca_dosim.id_meca = :ast_tab_meca_dosim.id_meca
		     and meca_dosim.barcode_lav = :ast_tab_meca_dosim.barcode_lav
		     and meca_dosim.barcode_dosimetro = :ast_tab_meca_dosim.barcode_dosimetro
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = &
			"Errore in cancellazione Dosimetro associato al barcode " &
					+ trim(ast_tab_meca_dosim.barcode_lav) + " " &
					+ " e dosimetro " + trim(ast_tab_meca_dosim.barcode_dosimetro) + " " &
					+ "~n~rErrore:"	+ trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko

		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if
										

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally

	
end try
		
		




end subroutine

private subroutine get_convalida_esito (ref st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception;//--------------------------------------------------------------------------------------------------------
//--- Ottiene l'esito più negativo dai dati Dosimetrici caricati
//--- 
//---  inp: st_tab_meca_dosim.id_meca 
//---  Out: st_tab_meca_dosim.err_lav_ok e note_lav_ok
//---  lancia exception           
//--- 
//--------------------------------------------------------------------------------------------------------
integer k_ctr, k_trovato=0
st_esito kst_esito 
st_tab_meca_dosim kst_tab_meca_dosim


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if ast_tab_meca_dosim.id_meca > 0 then
	else
		kst_esito.esito = kkg_esito.dati_insuff
		kst_esito.sqlcode = 0 
		kst_esito.SQLErrText = "Manca id Lotto per ottenete l'esito della Convalida dosimetrica dai dosimetri. " 
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- Cerca l'esito peggiore che ho tra i Barcode del Lotto convalidato	
		kst_tab_meca_dosim.note_lav_ok = ""
		kst_tab_meca_dosim.err_lav_ok = ki_err_lav_ok_conv_ko_bloc // cerca almeno un barcode con lo stato di BLOCCATO metto il Lotto in quello stato
		select max(note_lav_ok) into :kst_tab_meca_dosim.note_lav_ok  
			from meca_dosim
			where id_meca = :ast_tab_meca_dosim.id_meca
					  and err_lav_ok = :kst_tab_meca_dosim.err_lav_ok
			using kguo_sqlca_db_magazzino;
		if trim(kst_tab_meca_dosim.note_lav_ok) > " " or kguo_sqlca_db_magazzino.sqlcode < 0 then
		else
			kst_tab_meca_dosim.err_lav_ok = ki_err_lav_ok_conv_ko_da_aut // cerca almeno un barcode con lo stato di ERRATO metto il Lotto in quello stato
			select max(note_lav_ok) into :kst_tab_meca_dosim.note_lav_ok  
				from meca_dosim
				where id_meca = :ast_tab_meca_dosim.id_meca
						  and err_lav_ok = :kst_tab_meca_dosim.err_lav_ok
				using kguo_sqlca_db_magazzino;
		end if
		if trim(kst_tab_meca_dosim.note_lav_ok) > " " or kguo_sqlca_db_magazzino.sqlcode < 0 then
		else
			kst_tab_meca_dosim.err_lav_ok = ki_err_lav_ok_conv_da_aut // cerca almeno un barcode con lo stato DA AUTORIZZARE
			select max(note_lav_ok) into :kst_tab_meca_dosim.note_lav_ok  
				from meca_dosim
				where id_meca = :ast_tab_meca_dosim.id_meca
						  and err_lav_ok = :kst_tab_meca_dosim.err_lav_ok
				using kguo_sqlca_db_magazzino;
		end if
		if trim(kst_tab_meca_dosim.note_lav_ok) > " " or kguo_sqlca_db_magazzino.sqlcode < 0 then
		else
			kst_tab_meca_dosim.err_lav_ok = ki_err_lav_ok_conv_ko_sbloc // cerca almeno un barcode con lo stato SBLOCCATO
			select max(note_lav_ok) into :kst_tab_meca_dosim.note_lav_ok  
				from meca_dosim
				where id_meca = :ast_tab_meca_dosim.id_meca
						  and err_lav_ok = :kst_tab_meca_dosim.err_lav_ok
				using kguo_sqlca_db_magazzino;
		end if 
		if trim(kst_tab_meca_dosim.note_lav_ok) > " " or kguo_sqlca_db_magazzino.sqlcode < 0 then
		else
			kst_tab_meca_dosim.err_lav_ok = ki_err_lav_ok_conv_ko_da_aut // cerca almeno un barcode con lo stato KO Prima Lettura 
			select max(note_lav_ok) into :kst_tab_meca_dosim.note_lav_ok  
				from meca_dosim
				where id_meca = :ast_tab_meca_dosim.id_meca
						  and err_lav_ok = :kst_tab_meca_dosim.err_lav_ok
				using kguo_sqlca_db_magazzino;
		end if
		if trim(kst_tab_meca_dosim.note_lav_ok) > " " or kguo_sqlca_db_magazzino.sqlcode < 0 then
		else
			kst_tab_meca_dosim.err_lav_ok = ki_err_lav_ok_conv_aut_ok // cerca almeno un barcode con lo stato OK
			kst_tab_meca_dosim.dosim_flg_tipo_dose = ki_dosim_flg_tipo_dose_MINIMA // per DOSE MINIMA
			select max(note_lav_ok) into :kst_tab_meca_dosim.note_lav_ok  
				from meca_dosim
				where id_meca = :ast_tab_meca_dosim.id_meca
						  and err_lav_ok = :kst_tab_meca_dosim.err_lav_ok
						  and dosim_flg_tipo_dose = :kst_tab_meca_dosim.dosim_flg_tipo_dose
				using kguo_sqlca_db_magazzino;
		end if
		if trim(kst_tab_meca_dosim.note_lav_ok) > " " or kguo_sqlca_db_magazzino.sqlcode < 0 then
		else
			kst_tab_meca_dosim.err_lav_ok = ki_err_lav_ok_conv_aut_ok // cerca almeno un barcode con lo stato OK
			kst_tab_meca_dosim.dosim_flg_tipo_dose = ki_dosim_flg_tipo_dose_MASSIMA // per DOSE MASSIMA
			select max(note_lav_ok) into :kst_tab_meca_dosim.note_lav_ok  
				from meca_dosim
				where id_meca = :ast_tab_meca_dosim.id_meca
						  and err_lav_ok = :kst_tab_meca_dosim.err_lav_ok
						  and dosim_flg_tipo_dose = :kst_tab_meca_dosim.dosim_flg_tipo_dose
				using kguo_sqlca_db_magazzino;
		end if
		if trim(kst_tab_meca_dosim.note_lav_ok) > " " or kguo_sqlca_db_magazzino.sqlcode < 0 then
		else
			kst_tab_meca_dosim.err_lav_ok = ki_err_lav_ok_conv_aut_ok // cerca almeno un barcode con lo stato OK
			kst_tab_meca_dosim.dosim_flg_tipo_dose = ki_dosim_flg_tipo_dose_ALTRO // per DOSE ALTRA
			select max(note_lav_ok) into :kst_tab_meca_dosim.note_lav_ok  
				from meca_dosim
				where id_meca = :ast_tab_meca_dosim.id_meca
						  and err_lav_ok = :kst_tab_meca_dosim.err_lav_ok
						  and dosim_flg_tipo_dose = :kst_tab_meca_dosim.dosim_flg_tipo_dose
				using kguo_sqlca_db_magazzino;
		end if
		if trim(kst_tab_meca_dosim.note_lav_ok) > " " or kguo_sqlca_db_magazzino.sqlcode < 0 then
		else
			kst_tab_meca_dosim.err_lav_ok = ki_err_lav_ok_da_conv  // ??? QUI NON DOVREBBE MAI FINIRCI!!!
		end if

		if kguo_sqlca_db_magazzino.sqlcode < 0 then		
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.sqlerrtext = kguo_sqlca_db_magazzino.sqlerrtext
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

		ast_tab_meca_dosim.err_lav_ok = kst_tab_meca_dosim.err_lav_ok
		ast_tab_meca_dosim.note_lav_ok = kst_tab_meca_dosim.note_lav_ok
		
catch (uo_exception kuo_exception)
	throw kuo_exception

finally


end try

end subroutine

public function integer get_nr_dosim_letti (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception;//
//==============================================================================
//=== Torna numero dosimetri Barcode letti per Lotto 
//=== 
//=== Inp: id_meca
//=== Out: 
//=== Ritorna Numero di barcode trovati 
//===   
//==============================================================================
int k_return=0
st_esito kst_esito
int k_ctr


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


	if ast_tab_meca_dosim.id_meca > 0 then
			
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Errore in conteggio dosimetri barcode letti. Manca id Lotto, operazione bloccata! "
		kguo_exception.inizializza()
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception
	end if

	select count(*)
		into :k_ctr
		from meca_dosim 
			where id_meca = :ast_tab_meca_dosim.id_meca
			      and err_lav_ok > ' '
		using kguo_sqlca_db_magazzino ;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in conteggio dosimetri barcode letti: " + string(ast_tab_meca_dosim.id_meca) + ". Errore: " + kguo_sqlca_db_magazzino.sqlerrtext
		kguo_exception.inizializza()
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception
	end if


if k_ctr > 0 and kguo_sqlca_db_magazzino.sqlcode = 0 then

	k_return = k_ctr
		
end if
	
	
return k_return


end function

public function boolean if_consenti_forza_convalida (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception;//
//====================================================================
//=== Torna se Lotto puo' essere Forzato a Lotto Convalidato
//=== 
//=== Input: st_tab_meca_dosim.id_meca     
//=== Output:                   
//=== Ritorna true se OK da aprire
//===           		  
//====================================================================

boolean k_return = false
st_esito kst_esito
st_tab_meca kst_tab_meca
kuf_armo kuf1_armo 


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	if get_nr_dosim_letti(ast_tab_meca_dosim) > 0 then

		kuf1_armo = create kuf_armo
		kst_tab_meca.id = ast_tab_meca_dosim.id_meca  
		if kuf1_armo.if_convalidato(kst_tab_meca) then
			if get_nr_dosim_non_letti(ast_tab_meca_dosim) > 0 then
				k_return = true  // se Lotto convalidato senza avere letto tutti i dosimetri allora è stato forzato xtanto consento altra forzatura
			end if
		else
			k_return = true
		end if
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	if isvalid(kuf1_armo) then destroy kuf1_armo

end try

	
return k_return
end function

private subroutine set_convalida_lotto (readonly st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception;//--------------------------------------------------------------------------------------------------------
//--- Aggiorna dati Dosimetrici definitivi sul Lotto (MECA)
//--- 
//---  input: st_tab_meca.id 
//---  lancia exception           
//--- 
//--------------------------------------------------------------------------------------------------------
integer k_ctr, k_trovato=0
st_esito kst_esito 
st_tab_meca kst_tab_meca
st_tab_meca_dosim kst_tab_meca_dosim
st_tab_barcode kst_tab_barcode
kuf_armo kuf1_armo 
kuf_barcode kuf1_barcode


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if ast_tab_meca_dosim.id_meca > 0 then
	else
		kst_esito.esito = kkg_esito.dati_insuff
		kst_esito.sqlcode = 0 
		kst_esito.SQLErrText = "Manca id Lotto per eseguire la definitiva Convalida dosimetrica. " 
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if


//--- Verifica come aggiornare il FLAG sul LOTTO ovvero con il più importante dei Barcode su MECA 
//---      ad esempio se flag BARCODE Blocco e anche in errore metto il blocco su MECA 
//--- Cerca l'esito peggiore che ho tra i Barcode del Lotto convalidato	
	kst_tab_meca_dosim.id_meca = ast_tab_meca_dosim.id_meca
	get_convalida_esito(kst_tab_meca_dosim)

	kuf1_armo = create kuf_armo
	kuf1_barcode = create kuf_barcode

//--- Aggiorna flag dosimetria su LOTTO			
	kst_tab_meca.id = ast_tab_meca_dosim.id_meca
	kst_tab_meca.err_lav_ok = kst_tab_meca_dosim.err_lav_ok  // Imposta lo STATO per il Lotto
	kst_tab_meca.note_lav_ok = kst_tab_meca_dosim.note_lav_ok
	kst_tab_meca.st_tab_g_0.esegui_commit = ast_tab_meca_dosim.st_tab_g_0.esegui_commit
	kuf1_armo.set_err_lav_ok(kst_tab_meca)

//--- Aggiorna dati di convalida su tutti i BARCODE Trattati a cui manca  
	kst_tab_barcode.id_meca = ast_tab_meca_dosim.id_meca		
	kst_tab_barcode.data_lav_ok = ast_tab_meca_dosim.dosim_data
	kst_tab_barcode.err_lav_ok = ast_tab_meca_dosim.err_lav_ok				
	kst_tab_barcode.note_lav_ok = ast_tab_meca_dosim.note_lav_ok
	
	kst_tab_barcode.st_tab_g_0.esegui_commit = ast_tab_meca_dosim.st_tab_g_0.esegui_commit
	kst_esito = kuf1_barcode.tb_update_campo(kst_tab_barcode, "data_lav_ok_x_id_meca_barcode_altri")
	
	if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.db_wrn then
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- Preparazione Invio avviso via e-mail 
	if kst_tab_meca_dosim.err_lav_ok = ki_err_lav_ok_conv_aut_ok &
			or kst_tab_meca_dosim.err_lav_ok = ki_err_lav_ok_conv_ko_sbloc then
		try
			kst_tab_meca.id = ast_tab_meca_dosim.id_meca
			kuf1_armo.get_num_int(kst_tab_meca)
			kst_tab_meca.st_tab_g_0.esegui_commit = ast_tab_meca_dosim.st_tab_g_0.esegui_commit
			add_avviso_pronto_merce(kst_tab_meca)    // pronto merce
		catch (uo_exception kuo1_exception)
			kst_esito = kuo1_exception.get_st_esito()
			if kst_esito.esito = kkg_esito.db_ko then
				throw kuo1_exception
			else
				kuo1_exception.messaggio_utente()
			end if
		//add_email_invio(kst_tab_meca)    // pronto merce
		end try
	end if

//---- COMMIT....	
	if ast_tab_meca_dosim.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_dosim.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if


catch (uo_exception kuo_exception)
	if ast_tab_meca_dosim.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_dosim.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception


finally
	if isvalid(kuf1_armo) then destroy kuf1_armo
	if isvalid(kuf1_barcode) then destroy kuf1_barcode


end try

end subroutine

public subroutine set_forza_convalida (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------
//--- Forza/Ripristina Convalida Lotto anche se tutti i Barcode Dosimetro non convalidati 
//--- 
//---  input: st_tab_meca_dosim.id_lotto
//---  lancia exception           
//--- 
//--------------------------------------------------------------------------------------------------------
integer k_ctr
st_esito kst_esito 
st_tab_meca_dosim kst_tab_meca_dosim
st_tab_meca_fconv kst_tab_meca_fconv
kuf_meca_fconv kuf1_meca_fconv


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if ast_tab_meca_dosim.id_meca > 0 then
	else
		kst_esito.esito = kkg_esito.dati_insuff
		kst_esito.sqlcode = 0 
		kst_esito.SQLErrText = "Manca id Lotto. Operazione di Forzatura Convalida Lotto non eseguita. " 
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	kst_tab_meca_dosim = ast_tab_meca_dosim

	kst_tab_meca_dosim.st_tab_g_0.esegui_commit = "N" 

//--- Aggiornan Forzatura Convalida Lotto
	kuf1_meca_fconv = create kuf_meca_fconv
	kst_tab_meca_fconv.id_meca = kst_tab_meca_dosim.id_meca
	kst_tab_meca_dosim.st_tab_g_0.esegui_commit = kst_tab_meca_fconv.st_tab_g_0.esegui_commit
	if kuf1_meca_fconv.set_forza_convalida(kst_tab_meca_fconv) then
		
//--- Forzatura Convalida Lotto attiva o rimossa?
		if kuf1_meca_fconv.if_convalida_forzata(kst_tab_meca_fconv) then
			
//--- Rimuove dati CONVALIDA SUL LOTTO!!!			
			set_convalida_lotto_ripristino(kst_tab_meca_dosim)
		else
			
//--- Imposta dati CONVALIDA SUL LOTTO!!!			
			set_convalida_lotto(kst_tab_meca_dosim)
		end if
	end if
	if ast_tab_meca_dosim.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_dosim.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if
	
catch (uo_exception kuo_exception)
	if ast_tab_meca_dosim.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_dosim.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception

finally
	if isvalid(kuf1_meca_fconv) then destroy kuf1_meca_fconv
	
end try
		


end subroutine

private subroutine set_convalida_lotto_ripristino (readonly st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception;//--------------------------------------------------------------------------------------------------------
//--- Ripristina i dati Dosimetrici sul Lotto (MECA)
//--- 
//---  input: st_tab_meca.id 
//---  lancia exception           
//--- 
//--------------------------------------------------------------------------------------------------------
integer k_ctr, k_trovato=0
st_esito kst_esito 
st_tab_meca kst_tab_meca
st_tab_meca_dosim kst_tab_meca_dosim
st_tab_barcode kst_tab_barcode
st_tab_meca_ptmerce kst_tab_meca_ptmerce
kuf_armo kuf1_armo 
kuf_barcode kuf1_barcode
kuf_meca_ptmerce kuf1_meca_ptmerce


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if ast_tab_meca_dosim.id_meca > 0 then
	else
		kst_esito.esito = kkg_esito.dati_insuff
		kst_esito.sqlcode = 0 
		kst_esito.SQLErrText = "Manca id Lotto per eseguire il Ripristino dati di Convalida Lotto. " 
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	kuf1_armo = create kuf_armo
	kuf1_barcode = create kuf_barcode
	kuf1_meca_ptmerce = create kuf_meca_ptmerce

//--- Aggiorna flag dosimetria su LOTTO			
	kst_tab_meca.id = ast_tab_meca_dosim.id_meca
	kst_tab_meca.err_lav_ok = ""  // Imposta lo STATO per il Lotto
	kst_tab_meca.note_lav_ok = ""
	kst_tab_meca.st_tab_g_0.esegui_commit = ast_tab_meca_dosim.st_tab_g_0.esegui_commit
	kuf1_armo.set_err_lav_ok(kst_tab_meca)

// quwato non so come farlo //--- Aggiorna dati di convalida su tutti i BARCODE Trattati a cui manca  
//	kst_tab_barcode.id_meca = ast_tab_meca_dosim.id_meca		
//	kst_tab_barcode.data_lav_ok = ast_tab_meca_dosim.dosim_data
//	kst_tab_barcode.err_lav_ok = ast_tab_meca_dosim.err_lav_ok				
//	kst_tab_barcode.note_lav_ok = ast_tab_meca_dosim.note_lav_ok
//	
//	kst_tab_barcode.st_tab_g_0.esegui_commit = ast_tab_meca_dosim.st_tab_g_0.esegui_commit
//	kst_esito = kuf1_barcode.tb_update_campo(kst_tab_barcode, "data_lav_ok_x_id_meca_barcode_altri")
//	
//	if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.db_wrn then
//		kguo_exception.inizializza( )
//		kguo_exception.set_esito(kst_esito)
//		throw kguo_exception
//	end if

//--- Rimozione Invio avviso via e-mail 
	kst_tab_meca.id = ast_tab_meca_dosim.id_meca
	kuf1_armo.get_num_int(kst_tab_meca)
	kst_tab_meca_ptmerce.st_tab_g_0.esegui_commit = ast_tab_meca_dosim.st_tab_g_0.esegui_commit
	kst_tab_meca_ptmerce.id_meca = kst_tab_meca.id
	kuf1_meca_ptmerce.tb_delete(kst_tab_meca_ptmerce)    // rimozione pronto merce

//---- COMMIT....	
	if ast_tab_meca_dosim.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_dosim.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if


catch (uo_exception kuo_exception)
	if ast_tab_meca_dosim.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_dosim.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception


finally
	if isvalid(kuf1_armo) then destroy kuf1_armo
	if isvalid(kuf1_barcode) then destroy kuf1_barcode
	if isvalid(kuf1_meca_ptmerce) then destroy kuf1_meca_ptmerce

end try

end subroutine

public function integer get_nr_dosim_non_letti (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception;//
//==============================================================================
//=== Torna numero dosimetri Barcode NON ancora letti per Lotto 
//=== 
//=== Inp: id_meca
//=== Out: 
//=== Ritorna Numero di barcode trovati 
//===   
//==============================================================================
int k_return=0
st_esito kst_esito
int k_ctr


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


	if ast_tab_meca_dosim.id_meca > 0 then
			
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Errore in conteggio dosimetri barcode non letti. Manca id Lotto, operazione bloccata! "
		kguo_exception.inizializza()
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception
	end if

	select count(*)
		into :k_ctr
		from meca_dosim 
			where id_meca = :ast_tab_meca_dosim.id_meca
			      and (err_lav_ok <= ' ' or err_lav_ok is null)
		using kguo_sqlca_db_magazzino ;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in conteggio dosimetri barcode Non letti: " + string(ast_tab_meca_dosim.id_meca) + ". Errore: " + kguo_sqlca_db_magazzino.sqlerrtext
		kguo_exception.inizializza()
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception
	end if


if k_ctr > 0 and kguo_sqlca_db_magazzino.sqlcode = 0 then

	k_return = k_ctr
		
end if
	
	
return k_return


end function

public subroutine get_dosim_dosemax_min (ref st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception;//
//-------------------------------------------------------------------------------------------------------
//--- get valore MASSIMO tra le dosi MINIME 
//--- 
//--- Input : st_tab_meca_dosim.id_meca 
//--- out: st_tab_meca_dosim.dosim_dose
//--- Ritorna: nulla 
//--- Exception se errore con st_esito valorizzato
//---					
//---   
//--------------------------------------------------------------------------------------------------------
st_esito kst_esito
st_tab_meca_dosim kst_tab_meca_dosim


	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_meca_dosim.dosim_flg_tipo_dose = ki_dosim_flg_tipo_dose_MINIMA	
	ast_tab_meca_dosim.dosim_dose = 0.00

	select max(dosim_dose)
		into :ast_tab_meca_dosim.dosim_dose
		from meca_dosim 
		where (meca_dosim.id_meca = :ast_tab_meca_dosim.id_meca
           		      or meca_dosim.barcode_lav in 
 				 		 (select barcode_lav from barcode where id_meca = :ast_tab_meca_dosim.id_meca)
					)
		        and (meca_dosim.dosim_flg_tipo_dose is null
				       or meca_dosim.dosim_flg_tipo_dose = :kst_tab_meca_dosim.dosim_flg_tipo_dose
						 or meca_dosim.dosim_flg_tipo_dose = ''
						 )
		using kguo_sqlca_db_magazzino ;
	
	if sqlca.sqlcode <> 0 then
		if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in lettura dose MAX tra i valori Minimi Convalidati, Lotto: " + string(ast_tab_meca_dosim.id_meca) + ". Err.: " + trim(sqlca.sqlerrtext)
			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito )
			throw kguo_exception
		end if
	end if
	
	if ast_tab_meca_dosim.dosim_dose > 0 then
	else
		ast_tab_meca_dosim.dosim_dose = 0.00
	end if

end subroutine

public function date get_dosim_data_max (readonly st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception;//
//-------------------------------------------------------------------------------------------------------
//--- get valore max DATA 
//--- 
//--- Input : st_tab_meca_dosim.id_meca 
//--- out: 
//--- Ritorna: st_tab_meca_dosim.dosim_data 
//--- Exception se errore con st_esito valorizzato
//---					
//---   
//--------------------------------------------------------------------------------------------------------
date k_return 
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	select max(dosim_data)
		into :ast_tab_meca_dosim.dosim_data
		from meca_dosim 
		where meca_dosim.id_meca = :ast_tab_meca_dosim.id_meca
                 	or meca_dosim.barcode_lav in 
   							(select barcode_lav from barcode where id_meca = :ast_tab_meca_dosim.id_meca)
		using kguo_sqlca_db_magazzino ;
	
	if sqlca.sqlcode <> 0 then
		if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in lettura data MAX tra i valori disponibili in Convalida Lotto: " + string(ast_tab_meca_dosim.id_meca) + ". Err.: " + trim(sqlca.sqlerrtext)
			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito )
			throw kguo_exception
		end if
	end if
	
	if ast_tab_meca_dosim.dosim_data > kkg.data_zero then
		k_return = ast_tab_meca_dosim.dosim_data  
	else
		k_return = kkg.data_no
	end if

return k_return 
end function

on kuf_meca_dosim.create
call super::create
end on

on kuf_meca_dosim.destroy
call super::destroy
end on

