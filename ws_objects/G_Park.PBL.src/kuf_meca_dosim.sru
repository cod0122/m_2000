$PBExportHeader$kuf_meca_dosim.sru
forward
global type kuf_meca_dosim from kuf_armo
end type
end forward

global type kuf_meca_dosim from kuf_armo
end type
global kuf_meca_dosim kuf_meca_dosim

type variables

end variables

forward prototypes
public function boolean get_id_meca_da_barcode_dosimetro (ref st_tab_meca_dosim kst_tab_meca_dosim) throws uo_exception
public function string genera_barcode () throws uo_exception
public function string get_ultimo_numero_barcode () throws uo_exception
public function boolean tb_add_barcode (st_tab_meca_dosim kst_tab_meca_dosim) throws uo_exception
public function string get_ultimo_numero_barcode_da_tab (string k_inizio_barcode) throws uo_exception
public function string get_ultimo_numero_barcode_da_base () throws uo_exception
public function boolean set_ultimo_numero_barcode_in_base (st_tab_meca_dosim kst_tab_meca_dosim) throws uo_exception
public function boolean if_esiste_barcode (st_tab_meca_dosim kst_tab_meca_dosim) throws uo_exception
public function boolean set_barcode_dosimetro (ref st_tab_meca_dosim kst_tab_meca_dosim) throws uo_exception
public function boolean if_esiste_barcode_dosimetro (ref st_tab_meca_dosim kst_tab_meca_dosim) throws uo_exception
public function integer if_gia_usato_barcode (ref st_tab_meca_dosim kst_tab_meca_dosim) throws uo_exception
public function integer if_gia_usato_dosimetro (ref st_tab_meca_dosim kst_tab_meca_dosim) throws uo_exception
public function boolean get_id_meca_da_barcode (ref st_tab_meca_dosim kst_tab_meca_dosim) throws uo_exception
public function st_tab_meca convalida (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception
public function boolean if_esiste (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception
public function st_esito anteprima_dosim (ref datawindow adw_anteprima, st_tab_meca ast_tab_meca)
public subroutine set_convalida (st_tab_meca ast_tab_meca) throws uo_exception
public function long add_email_invio (st_tab_meca ast_tab_meca) throws uo_exception
public function int get_barcode (ref st_tab_meca_dosim kst_tab_meca_dosim[]) throws uo_exception
public function long get_ultimo_id_meca_dosim () throws uo_exception
public subroutine tb_delete_x_barcode_lav (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception
public subroutine tb_delete_x_id_meca (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception
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

public function string genera_barcode () throws uo_exception;//
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
pointer kpointer  // Declares a pointer variable


try
	
//--- Puntatore Cursore da attesa.....
	kpointer = SetPointer(HourGlass!)

   	kst_esito.esito = kkg_esito_ok
   	kst_esito.sqlcode = 0
   	kst_esito.SQLErrText = ""
   	kst_esito.nome_oggetto = this.classname()


//--- piglia l'ultimo barcode generato
	k_barcode_intero = get_ultimo_numero_barcode( )  // Ultimo Barcode caricato
	
//--- divide il bcode in 2 ALFA+PROGRESSIVO
	kst_tab_base.dosimetro_barcode_mask = left(trim(k_barcode_intero),3)
	k_barcode_progr = mid(trim(k_barcode_intero),4)
	if len(trim(k_barcode_progr)) = 0 then
		k_barcode_pref = "AA"
		k_barcode_num = 0
	else
		k_barcode_pref = left(k_barcode_progr,2) 
		k_barcode_num = integer(mid(k_barcode_progr,3,3))
	end if
			

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
	kst_esito = get_id_meca_da_data(kst_tab_armo)  // becca il primo id lotto ad una certa data
	if kst_esito.esito = kkg_esito_ok then
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
				k_barcode_pref = replace(k_barcode_pref,2,1, mid(K_ALFA1,1,1)  ) 
			
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
	SetPointer(kpointer)
	
end try

return k_return

end function

public function string get_ultimo_numero_barcode () throws uo_exception;//
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
   	if len(trim(k_barcode_intero)) > 3 or isnull(k_barcode_intero) then
      	kst_tab_base.dosimetro_ult_barcode = get_ultimo_numero_barcode_da_tab(left(trim(k_barcode_intero),3) )  // Ultimo Barcode caricato in TABELLA
			if len(trim(kst_tab_base.dosimetro_ult_barcode)) > 0  then
				k_barcode_intero = left(trim(k_barcode_intero),3) + trim(kst_tab_base.dosimetro_ult_barcode)
			end if		
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

	
	kst_tab_meca_dosim.x_datins = kuf1_data_base.prendi_x_datins()
	kst_tab_meca_dosim.x_utente = kuf1_data_base.prendi_x_utente()

	if_isnull_meca(kst_tab_meca_dosim)

	if kst_tab_meca_dosim.id_meca > 0 then
		
//--- 28.7.2010 disabilito la sicurezza su richiesta di Baglioni		
//		kuf1_barcode = create kuf_barcode
//		kst_open_w.flag_modalita = kkg_flag_modalita_modifica
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

//			kst_tab_meca.id = kst_tab_meca_dosim.id_meca
//			if if_convalidato(kst_tab_meca) then
//--- 160715: esiste già il id_meca+barcode+barcode_lav? 
			if if_esiste(kst_tab_meca_dosim) then
				
				if if_esiste_barcode(kst_tab_meca_dosim) then
					
					try
						set_ultimo_numero_barcode_in_base(kst_tab_meca_dosim)	// AGGIORNA ANCHE TAB BASE				
						
					catch (uo_exception kuo_exception)
						throw kuo_exception
						
					end try
					
				end if
//160715				    set barcode = :kst_tab_meca_dosim.barcode,
				
				update meca_dosim
					 	set barcode_dosimetro = :kst_tab_meca_dosim.barcode_dosimetro,
						x_datins = :kst_tab_meca_dosim.x_datins, 
						x_utente =	:kst_tab_meca_dosim.x_utente   
					where id_meca = :kst_tab_meca_dosim.id_meca
					using kguo_sqlca_db_magazzino;
					
			else

				try
					set_ultimo_numero_barcode_in_base(kst_tab_meca_dosim)	// AGGIORNA ANCHE TAB BASE		
					
				catch (uo_exception kuo1_exception)
					throw kuo1_exception
					
				end try

				kst_tab_meca_dosim.id_meca_dosim = get_ultimo_id_meca_dosim( )
				kst_tab_meca_dosim.id_meca_dosim += 1

				INSERT INTO meca_dosim
						( id_meca_dosim,
						  barcode_lav,
						  id_meca,   
						  barcode,
						  barcode_dosimetro,
						  x_datins,
						  x_utente
						)  
				  VALUES 
							( 
							:kst_tab_meca_dosim.id_meca_dosim,   
							:kst_tab_meca_dosim.barcode_lav,   
							:kst_tab_meca_dosim.id_meca,   
							:kst_tab_meca_dosim.barcode,   
							:kst_tab_meca_dosim.barcode_dosimetro,   
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
						if kst_tab_meca_dosim.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca_dosim.st_tab_g_0.esegui_commit) then
							kuf1_data_base.db_rollback_1( )
						end if
						kst_esito.esito = kkg_esito.db_ko
						
						kguo_exception.inizializza( )
						kguo_exception.set_esito(kst_esito)
						throw kguo_exception
						
					end if
				end if
			else
				if kst_tab_meca_dosim.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca_dosim.st_tab_g_0.esegui_commit) then
					kst_esito = kuf1_data_base.db_commit_1( )
				end if
				if kst_esito.esito = kkg_esito.ok then
					k_return = TRUE
				end if
			end if
	
	
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


   	kst_esito.esito = kkg_esito_ok
   	kst_esito.sqlcode = 0
   	kst_esito.SQLErrText = ""
   	kst_esito.nome_oggetto = this.classname()

	if len(trim(k_inizio_barcode)) = 0 then
		
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Lettura ultimo barcode in tab. Dosimetri Lotto "  + "~n~rSono richiesti i primi 3 caratteri identificativi del barcode"
		kst_esito.esito = kkg_esito_no_esecuzione
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception
		
	else

		SELECT max(substr(barcode,4,5))
				 INTO :k_barcode_progr
				 FROM meca_dosim  
				where substr(barcode,1,3) = :k_inizio_barcode
					 using sqlca;
				
		if sqlca.sqlcode = 0 then
		
			if isnull(k_barcode_progr) then 
				k_barcode_progr = "AA000"
			end if
		
		else
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.Dosimetri Lotto " &
										 + "~n~r"  + trim(SQLCA.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = kkg_esito_not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito_db_wrn
				else  
					kst_esito.esito = kkg_esito_db_ko
				end if
			end if
	   end if
 
		if kst_esito.esito = kkg_esito_db_ko then
			
			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito )
			throw kguo_exception
			
		end if
	
		if len(trim(k_barcode_progr)) > 0 then
			k_return = k_barcode_progr
		end if
   end if


return k_return

end function

public function string get_ultimo_numero_barcode_da_base () throws uo_exception;//
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
st_tab_base kst_tab_base
st_esito kst_esito
kuf_base kuf1_base


try
	
   kst_esito.esito = kkg_esito_ok
   kst_esito.sqlcode = 0
   kst_esito.SQLErrText = ""
   kst_esito.nome_oggetto = this.classname()



   	kuf1_base = create kuf_base

//--- piglia i primi 3 caratteri che identifcano il barcode
	kst_tab_base.dosimetro_barcode_mask = trim(MidA(kuf1_base.prendi_dato_base( "dosimetro_barcode_mask"),2))
	if len(trim(kst_tab_base.dosimetro_barcode_mask)) = 0 then kst_tab_base.dosimetro_barcode_mask = "DSM"

//--- piglia l'ultimo barcode generato dal BASE
   	kst_tab_base.dosimetro_ult_barcode = trim(MidA(kuf1_base.prendi_dato_base( "dosimetro_ult_barcode"),2))


//--- se tutto ok torna il Barcode
	if len(trim(kst_tab_base.dosimetro_ult_barcode)) > 0  then
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

public function boolean set_ultimo_numero_barcode_in_base (st_tab_meca_dosim kst_tab_meca_dosim) throws uo_exception;//
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
	
   kst_esito.esito = kkg_esito_ok
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
	if kst_esito.esito = kkg_esito_ok then
		kst_tab_base.st_tab_g_0.esegui_commit = kst_tab_meca_dosim.st_tab_g_0.esegui_commit 
		kst_tab_base.key = "dosimetro_ult_barcode"
		kst_tab_base.key1 = kst_tab_base.dosimetro_ult_barcode
		kst_esito  = kuf1_base.metti_dato_base(kst_tab_base)
	end if
	
	if kst_esito.esito <> kkg_esito_ok then
		kst_esito.esito = kkg_esito_ok
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


kst_esito.esito = kkg_esito_blok
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
//--- Aggiuorna Barcode Dosimetro in archivio
//---
//--- Inp.: st_tab_meca_dosim id_meca, barcode_dosimetro 
//--- Out.: 
//--- Ritorna: TRUE = ok
//--- Lancia excepetion se errore
//--- 
boolean k_return = FALSE
long k_contati=0
st_esito kst_esito
uo_exception kuo_exception


	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

		
	update meca_dosim 
			set barcode_dosimetro = :kst_tab_meca_dosim.barcode_dosimetro
		where meca_dosim.id_meca = :kst_tab_meca_dosim.id_meca
		using sqlca;

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Aggiornamento barcode Dosimetro in tab. Dosimetria Lotti (id Lotto=" + string(kst_tab_meca_dosim.id_meca) + ")   ~n~r" + trim(SQLCA.SQLErrText)
		kst_esito.esito = kkg_esito_db_ko
		
	end if

//---- COMMIT....	
	if kst_esito.esito = kkg_esito_db_ko then
		if kst_tab_meca_dosim.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca_dosim.st_tab_g_0.esegui_commit) then
			kuf1_data_base.db_rollback_1( )
		end if
		
		kuo_exception.set_esito( kst_esito )
		throw kuo_exception
		
	else
		if kst_tab_meca_dosim.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca_dosim.st_tab_g_0.esegui_commit) then
			kuf1_data_base.db_commit_1( )
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


	kst_esito.esito = kkg_esito_ok
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
			kst_esito.esito = kkg_esito_db_ko
			
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


	kst_esito.esito = kkg_esito_ok
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
			kst_esito.SQLErrText = "Tab.Dosimetria Lotti (id Lotto=" + string(kst_tab_meca_dosim.id_meca) + ")   ~n~r" + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito_db_ko
			
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


	kst_esito.esito = kkg_esito_ok
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
			kst_esito.SQLErrText = "Tab.Dosimetria Lotti (id Lotto=" + string(kst_tab_meca_dosim.id_meca) + ")   ~n~r" + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito_db_ko
			
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
//--- Inp: st_tab_meca_dosim.  id_meca / dosim_lotto_dosim / dosim_rapp_a_s / data_int / num_int
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
st_tab_sl_pt kst_tab_sl_pt
st_tab_dosimetrie kst_tab_dosimetrie
st_tab_contratti kst_tab_contratti
st_tab_base kst_tab_base
st_tab_prodotti kst_tab_prodotti
kuf_contratti kuf1_contratti
kuf_ausiliari kuf1_ausiliari
kuf_armo kuf1_armo
kuf_sl_pt kuf1_sl_pt
kuf_base kuf1_base
pointer kp_oldpointer


try
//--- Puntatore Cursore da attesa..... 
	kp_oldpointer = SetPointer(HourGlass!)

	kuf1_contratti = create kuf_contratti
	kuf1_ausiliari = create kuf_ausiliari
	kuf1_sl_pt = create kuf_sl_pt
	kuf1_base = create kuf_base 

//--- get numero/data lotto (riferimento)
	kst_tab_meca.id = ast_tab_meca_dosim.id_meca
	get_num_int(kst_tab_meca)	

//--- get dati di Convalida
	kst1_tab_meca.id = ast_tab_meca_dosim.id_meca
	get_err_lav(kst1_tab_meca)	
 
//--- get codice contratto	
	kst_tab_meca.id = ast_tab_meca_dosim.id_meca
	kst_tab_contratti.codice = get_contratto(kst_tab_meca)	

//--- con il codice contratto get del Capitolato (sc-cf)
	kst_esito = kuf1_contratti.get_co_cf_pt(kst_tab_contratti)
	if kst_esito.esito <> kkg_esito_ok and kst_esito.esito <> kkg_esito_db_wrn then
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	setnull(kst_tab_meca.err_lav_ok)
	setnull(kst_tab_meca.note_lav_ok)
	
//	kst_esito = kuf1_armo.leggi_riga("D", kst_tab_armo) 

	if kst_esito.esito = kkg_esito_ok then

//		tab_1.tabpage_1.dw_1.setitem(k_riga, "data_int", kst_tab_armo.data_int)

//--- get dei dati dosimetrici (la curva) x la convalida
		kst_tab_dosimetrie.lotto_dosim = trim(ast_tab_meca_dosim.dosim_lotto_dosim)
		kst_tab_dosimetrie.coeff_a_s = ast_tab_meca_dosim.dosim_rapp_a_s
		kst_tab_dosimetrie.dose = 0
		kst_esito = kuf1_ausiliari.tb_dosimetrie_select(kst_tab_dosimetrie) 

		if kst_esito.esito = kkg_esito_ok then
			
			kst_tab_sl_pt.cod_sl_pt = kst_tab_contratti.sl_pt
			kst_esito = kuf1_sl_pt.select_riga(kst_tab_sl_pt)
			
			if kst_esito.esito = kkg_esito_ok then

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
//--- get codice articolo
				kst_tab_meca.id = ast_tab_meca_dosim.id_meca
				select max(gruppo)
				   into :kst_tab_prodotti.gruppo
				   from prodotti inner join armo on prodotti.codice = armo.art
					where armo.id_meca = :ast_tab_meca_dosim.id_meca
					using kguo_sqlca_db_magazzino;
				if isnull(kst_tab_prodotti.gruppo) then kst_tab_prodotti.gruppo = 0

//--- se ha il capitolato prendo il valore di riferimento dal contratto minimo + la Tolleranza		
//				if LenA(trim(kst_tab_contratti.sc_cf)) > 0 then 
					k_dose_max = kst_tab_sl_pt.dose_min * (1 + kst_tab_base.valid_t_dose_min/100)
//					k_dose_max = kst_tab_sl_pt.dose_max * (1 + kst_tab_base.valid_t_dose_min/100)
//				else
//					k_dose_max = kst_tab_sl_pt.dose_max 
//				end if
	
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
					kst_tab_meca.note_lav_ok = &
								 "Dose " &
								 + string(kst_tab_dosimetrie.dose, "#####0.00") &
								 + " fuori dal range previsto nel PT (" &
								 + string(kst_tab_sl_pt.dose_min) &
								 + "-" + string(kst_tab_sl_pt.dose_max) + ")"
				end if
			else
				kst_tab_meca.note_lav_ok = "Piano di Lavorazione non trovato "
			end if
		else
			kst_tab_meca.note_lav_ok = "Lotto Dosimetrico non trovato per il rapporto A/S calcolato"
		end if
	else
		kst_tab_meca.note_lav_ok = "Lotto non trovato "
	end if

//------------------------------------------------------------------------------------------------------- 
//--- se sono stati rilevati errori di dosimetria	
	if k_errore then

		choose case kst1_tab_meca.err_lav_ok
//--- se era da "Prima Convalida"
			case kuf_armo.ki_err_lav_ok_da_conv
				kst_tab_meca.err_lav_ok = kuf_armo.ki_err_lav_ok_conv_ko_da_aut
//--- se era in "anomalia da autorizzare...."
			case kuf_armo.ki_err_lav_ok_conv_ko_da_aut
				kst_tab_meca.err_lav_ok = kuf_armo.ki_err_lav_ok_conv_ko_bloc
//--- se era in "OK da autorizzare...."
			case kuf_armo.ki_err_lav_ok_conv_da_aut
				kst_tab_meca.err_lav_ok = kuf_armo.ki_err_lav_ok_conv_ko_da_aut
//--- se era in "BLOCCATO...."
			case kuf_armo.ki_err_lav_ok_conv_ko_bloc
				kst_tab_meca.err_lav_ok = kuf_armo.ki_err_lav_ok_conv_ko_sbloc
				kst_tab_meca.note_lav_ok += " - Sbloccato "
//--- in caso di valore non identificato (es. NULL)				
			case else
				kst_tab_meca.err_lav_ok = kuf_armo.ki_err_lav_ok_conv_ko_da_aut
		end choose

	else	
		
//--- se dosimetria OK	
		if not k_errore then
			
			choose case kst1_tab_meca.err_lav_ok
//--- se era da "Prima Convalida" si e' deciso di dare immediatamente l'autorizzazione
				case kuf_armo.ki_err_lav_ok_da_conv
					kst_tab_meca.err_lav_ok = kuf_armo.ki_err_lav_ok_conv_aut_ok
//--- se era in "anomalia da autorizzare...."
				case kuf_armo.ki_err_lav_ok_conv_ko_da_aut
					kst_tab_meca.err_lav_ok = kuf_armo.ki_err_lav_ok_conv_aut_ok
//--- se era in "OK da autorizzare...."
				case kuf_armo.ki_err_lav_ok_conv_da_aut
					kst_tab_meca.err_lav_ok = kuf_armo.ki_err_lav_ok_conv_aut_ok
//--- se era in "BLOCCATO...."
				case kuf_armo.ki_err_lav_ok_conv_ko_bloc
					kst_tab_meca.err_lav_ok = kuf_armo.ki_err_lav_ok_conv_aut_ok
//--- in caso di valore non identificato (es. NULL)				
				case else
					kst_tab_meca.err_lav_ok = kuf_armo.ki_err_lav_ok_conv_aut_ok
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
	if isvalid(kuf1_contratti) then destroy kuf1_contratti
	if isvalid(kuf1_ausiliari) then destroy kuf1_ausiliari
	if isvalid(kuf1_sl_pt) then destroy kuf1_sl_pt
	if isvalid(kuf1_base) then destroy kuf1_base 
	
	SetPointer(kp_oldpointer)

end try

return kst_tab_meca


end function

public function boolean if_esiste (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception;//
//==============================================================================
//=== Controllo se Riferimento-Dosimetria Esiste x ID_MECA+BARCODE_LAV 
//=== 
//=== Inp: id oppure num/data_int
//=== Out: id (sempre)
//=== Ritorna BOOLEAN : TRUE=ESISTE, FALSE=NON ESISTE;
//===   
//==============================================================================
boolean k_return=false
st_esito kst_esito
int k_ctr


kst_esito.esito = kkg_esito.blok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if ast_tab_meca_dosim.id_meca > 0 then
	
	if isnull(ast_tab_meca_dosim.barcode) then ast_tab_meca_dosim.barcode = ""
	if isnull(ast_tab_meca_dosim.barcode_lav) then ast_tab_meca_dosim.barcode_lav = ""

	//			and barcode = :ast_tab_meca_dosim.barcode

	select distinct 1
		into :k_ctr
		from meca_dosim 
		where id_meca = :ast_tab_meca_dosim.id_meca
			and barcode_lav = :ast_tab_meca_dosim.barcode_lav
		using kguo_sqlca_db_magazzino ;
		
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = sqlca.sqlerrtext
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

public function st_esito anteprima_dosim (ref datawindow adw_anteprima, st_tab_meca ast_tab_meca);//
//=== 
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
//=== 
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
	
	//kst_open_w = kst_open_w
	//kst_open_w.flag_modalita =
	//kst_open_w.id_programma = kkg_id_programma_dosimetria
	
	k_return = if_sicurezza(kkg_flag_modalita.anteprima)
	
	////--- controlla se utente autorizzato alla funzione in atto
	//kuf1_sicurezza = create kuf_sicurezza
	//k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	//destroy kuf1_sicurezza
	
	if not k_return then
		
		kst_esito = kguo_exception.get_st_esito( )
		
	//	kst_esito.sqlcode = sqlca.sqlcode
	//	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata: " + trim(kst_open_w.id_programma) + " funz.: " + trim(kst_open_w.flag_modalita)
	//	kst_esito.esito = "100"
	
	else
	
		if ast_tab_meca.num_int > 0 then
	
			adw_anteprima.dataobject = "d_convalida_dosim"		
			adw_anteprima.settransobject(sqlca)
	
			kuf1_utility = create kuf_utility
			kuf1_utility.u_dw_toglie_ddw(1, adw_anteprima)
			destroy kuf1_utility
	
			adw_anteprima.reset()	
	//--- retrive dell'attestato 
			k_rc=adw_anteprima.retrieve(ast_tab_meca.num_int, year(ast_tab_meca.data_int))
	
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
//kuf_base kuf1_base
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


	ast_tab_meca.x_datins = kuf1_data_base.prendi_x_datins() // datetime(today(), now())
	ast_tab_meca.x_utente = kuf1_data_base.prendi_x_utente() 

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

	if kst_esito.esito <> kkg_esito_ok and kst_esito.esito <> kkg_esito_db_wrn then
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

public function long add_email_invio (st_tab_meca ast_tab_meca) throws uo_exception;//------------------------------------------------------------------------------------------------------------------------
//--- Fa il Carico nella tabella email-invio 
//--- Inp: st_tab_meca valorizzata con i campi necessari
//--- Out: il ID del email_invio
//------------------------------------------------------------------------------------------------------------------------
//
long k_return=0 
kuf_email_invio kuf1_email_invio
kuf_email_funzioni kuf1_email_funzioni
kuf_email kuf1_email
kuf_clienti kuf1_clienti 
st_tab_clienti kst_tab_clienti
st_tab_clienti_web kst_tab_clienti_web
st_tab_email_invio kst_tab_email_invio
st_tab_email kst_tab_email
st_tab_email_funzioni kst_tab_email_funzioni
st_esito kst_esito


try
	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if ast_tab_meca.id > 0 then 
	else
		kguo_exception.inizializza( )
		kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_non_eseguito )
		kguo_exception.set_nome_oggetto(this.classname( ) )
		kguo_exception.setmessage( "Manca id Lotto. Generazione e-mail non eseguita. ")
		throw kguo_exception
	end if

//--- get del codice cliente 
	this.get_clie(ast_tab_meca)

//--- get dell'indirizzo e-mail del cliente
	kst_tab_clienti_web.id_cliente = ast_tab_meca.clie_3
	kuf1_clienti = create kuf_clienti
	kst_tab_email_invio.email = kuf1_clienti.get_email_prontomerce(kst_tab_clienti_web)
//--- se e-mail NON impostata sul cliente NON invio nulla!!!
	if trim(kst_tab_email_invio.email) > " " then
	
		kuf1_email_invio = create kuf_email_invio
		kuf1_email = create kuf_email
		kuf1_email_funzioni = create kuf_email_funzioni
		
		kst_tab_email_invio.id_cliente =  ast_tab_meca.clie_3
		kst_tab_email_invio.flg_allegati = kuf1_email_invio.ki_allegati_no
		kst_tab_email_invio.allegati_cartella = ""			
		kst_tab_email_invio.cod_funzione = kuf1_email_funzioni.kki_cod_funzione_prontomerce  // INFO che è un PRONTO MERCE
	
//--- get del Prototio della e-mail
		kst_tab_email_funzioni.cod_funzione = kst_tab_email_invio.cod_funzione
		kst_tab_email.id_email = kuf1_email_funzioni.get_id_email_xcodfunzione(kst_tab_email_funzioni)
		if kst_tab_email.id_email = 0 then
			kguo_exception.inizializza( )
			kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_not_fnd )
			kguo_exception.set_nome_oggetto(this.classname( ) )
			kguo_exception.setmessage( "Impostare da 'Proprietà della Procedura' il Prototipo e-mail da utilizzare per l'invio funzionale '" + trim(kst_tab_email_funzioni.cod_funzione)+"' ")
			throw kguo_exception
		end if
		
//--- recupero diversi dati x riempire la tab email-invio			
		kuf1_email.get_riga(kst_tab_email)
		kst_tab_email_invio.oggetto = kst_tab_email.oggetto
		kst_tab_email_invio.link_lettera = kst_tab_email.link_lettera
		kst_tab_email_invio.flg_lettera_html = kst_tab_email.flg_lettera_html
		kst_tab_email_invio.flg_ritorno_ricev = kst_tab_email.flg_ritorno_ricev
		kst_tab_email_invio.email_di_ritorno = kst_tab_email.email_di_ritorno
		kst_tab_email_invio.id_oggetto = ast_tab_meca.id
		kuf1_email_invio.if_isnull(kst_tab_email_invio)

//--- get del DDT mandante		
		this.get_num_bolla_in(ast_tab_meca)
		
//--- Composizione dell'OGGETTO: somma alla dicitura del Prototipo il ddt del mandante a anche il Nome quando cliente diverso da mandante
		if ast_tab_meca.num_bolla_in > " " then
			kst_tab_email_invio.oggetto = trim(kst_tab_email_invio.oggetto) + " D.D.T. n. " + trim(ast_tab_meca.num_bolla_in)
			if ast_tab_meca.data_bolla_in > date(0) then
				kst_tab_email_invio.oggetto += " del " + string(ast_tab_meca.data_bolla_in)
			end if
		end if
		if ast_tab_meca.num_int > 0 then
			kst_tab_email_invio.oggetto = trim(kst_tab_email_invio.oggetto) + " rif. interno " + string(ast_tab_meca.num_int)
		end if
		if kst_tab_email_invio.id_cliente <> ast_tab_meca.clie_1 then // se cliente mandante diverso aggiungo il nome
			kst_tab_clienti.codice = ast_tab_meca.clie_1
			kuf1_clienti.get_nome(kst_tab_clienti)
			kst_tab_email_invio.oggetto = trim(kst_tab_email_invio.oggetto) + " di " + trim(kst_tab_clienti.rag_soc_10)
		end if

		kst_tab_email_invio.note = "da Convalida dosimetria, Lotto " + string(ast_tab_meca.num_int) + "  " +  string(ast_tab_meca.data_int) + "   id " + string(ast_tab_meca.id) + " "  
		
//--- Controllo la presenza in elenco della EMAIL
		kst_tab_email_invio.id_email_invio = kuf1_email_invio.if_presente_x_id_oggetto(kst_tab_email_invio)

//--- CARICO dati nella tabella EMAIL_INVIO	
		k_return = 0
		kst_tab_email_invio.st_tab_g_0.esegui_commit = ast_tab_meca.st_tab_g_0.esegui_commit
		if kst_tab_email_invio.id_email_invio > 0 then
			if kuf1_email_invio.tb_update(kst_tab_email_invio)  then 
				
				k_return = kst_tab_email_invio.id_email_invio
			end if
		else
			if kuf1_email_invio.tb_add(kst_tab_email_invio)  then 
			
				k_return = kst_tab_email_invio.id_email_invio
			end if
		end if		
		if k_return = 0 then
			kst_esito.esito = kkg_esito.no_esecuzione
			kst_esito.sqlerrtext = "Errore durante preparazione e-mail da inviare!"
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

	end if
	
catch (uo_exception kuo_exception)	
	throw kuo_exception
	
finally
	
end try



return k_return

end function

public function int get_barcode (ref st_tab_meca_dosim kst_tab_meca_dosim[]) throws uo_exception;//
//----------------------------------------------------------------------------------------------------
//--- Torna array di codici Barcode di Dosimetro (ce ne possono essere + di 1 x barcode di lavorazione)
//--- 
//--- Input : kst_tab_meca_dosim_dosim.id_meca e barcode_lav
//--- Out: kst_tab_meca_dosim_dosim[n].barcode 
//--- Ritorna: 0= numero di barcode di dosimetria trovati
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
			kst_esito.SQLErrText = "Errore durante lettura cod. Barcode per il Dosimetri " + trim(kguo_sqlca_db_magazzino.sqlerrtext)
			kguo_exception.inizializza()
			kguo_exception.set_esito( kst_esito )
			throw  kguo_exception
		end if
		
		if k_ind > 0 then
			k_return = k_ind
		else
			kst_tab_meca_dosim[1].barcode = ""
		end if
	end if

	
return k_return


end function

public function long get_ultimo_id_meca_dosim () throws uo_exception;//
//====================================================================
//=== Torna ultimo ID_MECA_DOSIM
//=== 
//=== Inp: 
//=== Out: 
//=== Ritorna id_meca_dosim 
//===   
//====================================================================
long k_return=0
st_tab_meca_dosim kst_tab_meca_dosim
st_esito kst_esito


kst_esito.esito = kkg_esito.blok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


//--- Se non esiste allora cerco in tabella MECA_DOSIM			
	select max(id_meca_dosim)
			into :kst_tab_meca_dosim.id_meca_dosim
			from meca_dosim         
			using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if kst_tab_meca_dosim.id_meca_dosim > 0 then
			k_return = kst_tab_meca_dosim.id_meca_dosim
	
		end if
	
	else
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
		else
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore durante ricerca ultimo ID in Barcode Dosimetria (meca_dosim)~n~r " + trim(kguo_sqlca_db_magazzino.sqlerrtext)
			kguo_exception.inizializza()
			kguo_exception.set_esito( kst_esito )
			throw kguo_exception
		end if
	end if

	
return k_return


end function

public subroutine tb_delete_x_barcode_lav (st_tab_meca_dosim ast_tab_meca_dosim) throws uo_exception;//
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

on kuf_meca_dosim.create
call super::create
end on

on kuf_meca_dosim.destroy
call super::destroy
end on

