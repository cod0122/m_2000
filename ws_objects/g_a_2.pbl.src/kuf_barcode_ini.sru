$PBExportHeader$kuf_barcode_ini.sru
forward
global type kuf_barcode_ini from kuf_parent
end type
end forward

global type kuf_barcode_ini from kuf_parent
end type
global kuf_barcode_ini kuf_barcode_ini

forward prototypes
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function boolean if_sicurezza (string aflag_modalita) throws uo_exception
private function string u_decod_clie (long a_id_cliente) throws uo_exception
private function string u_get_next_barcode (string k_barcode) throws uo_exception
private function string u_get_start_barcode (long a_id_cliente) throws uo_exception
private function integer u_crea_barcode (st_tab_barcode ast_tab_barcode, integer a_nr_barcode) throws uo_exception
public function integer lotto_genera_barcode (st_tab_barcode ast_tab_barcode) throws uo_exception
public function boolean if_da_generare (st_tab_barcode ast_tab_barcode) throws uo_exception
public function integer get_nr_barcode_da_generare (st_tab_barcode ast_tab_barcode) throws uo_exception
public function boolean if_stampati (st_tab_barcode ast_tab_barcode) throws uo_exception
public function integer get_nr_barcode_generati (st_tab_barcode ast_tab_barcode) throws uo_exception
public function integer get_nr_barcode_x_id_armo (st_tab_barcode ast_tab_barcode) throws uo_exception
public function integer u_distruggi_barcode (st_tab_barcode ast_tab_barcode, integer a_nr_barcode) throws uo_exception
public function integer u_e1_importa_barcode (st_tab_barcode ast_tab_barcode) throws uo_exception
public function integer u_e1_importa_barcode_batch () throws uo_exception
private function boolean u_add_barcode (st_tab_barcode ast_tab_barcode) throws uo_exception
end prototypes

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
kuf_barcode kuf1_barcode


kuf1_barcode = create kuf_barcode
return kuf1_barcode.if_sicurezza(ast_open_w)



end function

public function boolean if_sicurezza (string aflag_modalita) throws uo_exception;//
kuf_barcode kuf1_barcode


kuf1_barcode = create kuf_barcode
return kuf1_barcode.if_sicurezza(aflag_modalita)



end function

private function string u_decod_clie (long a_id_cliente) throws uo_exception;//
//--------------------------------------------------------------------------------------------
//--- Codifica il codice cliente nel codice barcode di 3 caratteri
//--- 
//---  input: cod cliente
//---  Outout: 
//---  Ritorna: codice per comporre il barcode
//---  Se errore lancia EXCEPTION
//---                                     
//--------------------------------------------------------------------------------------------
//
string k_return=""
string K_BARC_CLIENTE="", k_BARC_CLIENTE_CHAR_1, k_BARC_CLIENTE_CHAR_2, K_BARC_CLIENTE_SUFF
int K_BARC_CLIENTE_APPO=0, K_BARC_CLIENTE_IDX_ALFA=0

string K_ALFA, K_ALFA1, K_BARC_CLIENTE_ALFA[0 to 30] 
int K_ALFA1_LENGTH, K_ALFA_LENGTH

//st_esito kst_esito


try
	
//--- Puntatore Cursore da attesa.....
	SetPointer(kkg.POINTER_ATTESA)

//   	kst_esito.esito = kkg_esito.ok
//   	kst_esito.sqlcode = 0
//   	kst_esito.SQLErrText = ""
//   	kst_esito.nome_oggetto = this.classname()

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


//#--- 7.3.2006 --------------------> PROBABILMENTE può essere usato fino a 9999 ma bisogna provare
	 if a_id_cliente > 9000 then
		kguo_exception.inizializza()
		kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_non_eseguito)
		kguo_exception.setmessage("BARCODE NON GENERABILE perchè Codice Cliente troppo ALTO " &
                            + string(a_id_cliente) + ". Eccede limite massimo consentito di 9000!! ")
		throw kguo_exception
	end if

//#--- il barcode x i clienti fino a 999 piglia l'intero codice ad es. goglio=37  diventa '037'    
	if a_id_cliente < 1000 then
		K_BARC_CLIENTE = string(a_id_cliente, "000")
	else

//#--- il barcode x i clienti fino da 1000 - 3599 codifica il primo byte come char alfa es. il codice 1037  diventa 'A37'    
     	K_BARC_CLIENTE_APPO = a_id_cliente / 100 //# piglia solo i primi numeri es. 3827 diventa 38
      	K_BARC_CLIENTE_SUFF = string((a_id_cliente - K_BARC_CLIENTE_APPO * 100), "00")  // qui memorizza la parte NUMERICA
                                 
//#--- 31122010  Se i clienti sono piu' di 3599 allora la lettera passa dalla prima alla seconda posizione nei 3 caratteri disponibili                                 
//#--- 31122010      se poi i clienti sono piu' di (3600+2600) 6299 allora la lettera passa dalla seconda alla terza posizione nei 3 caratteri disponibili                                 
		 if K_BARC_CLIENTE_APPO < 36 then
			 K_BARC_CLIENTE_IDX_ALFA = K_BARC_CLIENTE_APPO - 10
			 K_BARC_CLIENTE = trim(K_BARC_CLIENTE_ALFA[K_BARC_CLIENTE_IDX_ALFA]) + trim(K_BARC_CLIENTE_SUFF)
		 else
			 k_BARC_CLIENTE_CHAR_1 = mid(K_BARC_CLIENTE_SUFF,1,1)
			 k_BARC_CLIENTE_CHAR_2 = mid(K_BARC_CLIENTE_SUFF,2,2)
			 
//#--- il barcode x i clienti fino da 3600 - 6199 codifica il secondo byte come char alfa es. il codice 5037  diventa '3N7'    
            if K_BARC_CLIENTE_APPO < 62 then //# ovvero ha gia' passato i primi 10 (solo numeri) e ha gia' fatto 1 giri alfabetici (26 char)
				 K_BARC_CLIENTE_IDX_ALFA = K_BARC_CLIENTE_APPO - 36
//#--- non capisco xche' ma il IDX a ZERO non piglia la A x cui forzo!
				if K_BARC_CLIENTE_IDX_ALFA = 0 then
					K_BARC_CLIENTE =  trim(k_BARC_CLIENTE_CHAR_1) + "A" + trim(k_BARC_CLIENTE_CHAR_2)  //# es.  il cliente '3600' diventa '0A0'
				else
					K_BARC_CLIENTE =  trim(k_BARC_CLIENTE_CHAR_1) + trim(K_BARC_CLIENTE_ALFA[K_BARC_CLIENTE_IDX_ALFA]) + trim(k_BARC_CLIENTE_CHAR_2)  //# es.  il cliente '3723' diventa '2B3'
				end if
			else
//#--- il barcode x i clienti fino da 6200 - 8899 codifica il terzo byte come char alfa es. il codice 8037  diventa '37Q'    
				if K_BARC_CLIENTE_APPO < 89 then //# ovvero ha gia' passato i primi 10 (solo numeri) e ha gia' fatto 2 giri alfabetici (26 char)
					K_BARC_CLIENTE_IDX_ALFA = K_BARC_CLIENTE_APPO - 62
//#--- non capisco xche' ma il IDX a ZERO non piglia la A x cui forzo!
					if K_BARC_CLIENTE_IDX_ALFA = 0 then
						K_BARC_CLIENTE =  trim(k_BARC_CLIENTE_CHAR_1) + trim(k_BARC_CLIENTE_CHAR_2) + "A"   //# es.  il cliente '6200' diventa '0A0'
					else
						K_BARC_CLIENTE =  trim(k_BARC_CLIENTE_CHAR_1) + trim(k_BARC_CLIENTE_CHAR_2) + trim(K_BARC_CLIENTE_ALFA[K_BARC_CLIENTE_IDX_ALFA])  //# es.  il cliente '6423' diventa '23C'
					end if
				else
//#--- SE ARRIVA QUI MEGLIO ALLARMARSI SIAMO ALLA FINE E I BARCODE INIZIANO CON '#'
			 		K_BARC_CLIENTE =  '#' + trim(k_BARC_CLIENTE_CHAR_1) + trim(k_BARC_CLIENTE_CHAR_2)  //# es.  il cliente '9023' diventa '#23'
				end if
			end if
		end if
	end if
	k_return = trim(K_BARC_CLIENTE)

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	SetPointer(kkg.POINTER_ATTESA)
	
end try

return k_return

end function

private function string u_get_next_barcode (string k_barcode) throws uo_exception;//
//--------------------------------------------------------------------------------------------
//--- compone il BARCODE successivo a quello indicato
//--- 
//---  input: barcode da incrementare
//---  Outout:  
//---  Ritorna: barcode successivo
//---  Se errore lancia EXCEPTION
//---                                     
//--------------------------------------------------------------------------------------------
//
//
string k_return=""
string k_barcode_pref, k_barcode_cliente=""
string K_ALFA, K_ALFA1, K_BARC_CLIENTE_ALFA[0 to 30] 
int K_ALFA1_LENGTH, K_ALFA_LENGTH
int k_barcode_num=0, K_CTR1
st_tab_barcode kst_tab_barcode

kuf_barcode kuf1_barcode


try
	
//--- Puntatore Cursore da attesa.....
	SetPointer(kkg.POINTER_ATTESA)

	
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
	
//--- compone il BARCODE di partenza ovvero la codifica del cliente, poi get del progressivo del barcode generato: 2 ALFA+PROGRESSIVO num di 3
	k_barcode_cliente = left(k_barcode, 3)
	k_barcode_pref = mid(k_barcode,4,2)
	k_barcode_num = integer(mid(k_barcode,6,3))

	kuf1_barcode = create kuf_barcode

//--- cicla fino a che non trova il barcode giusto 
	do
		
//--- Imposta il prefisso NUMERICO e se superiore a 999 anche il nuovo ALFA
		if k_barcode_num < 999 then
			k_barcode_num ++
		else
			k_barcode_num = 1
//--- calcola il nuova ALFA
//--- posizionamento sull'attuale codice	
			for K_CTR1 = 1 to K_ALFA1_LENGTH
				if mid(k_barcode_pref,2,1) = mid(K_ALFA1,K_CTR1,1) then  
					exit
				end if 
			next 
//--- non ho trovato il codice?	
			if mid(k_barcode_pref,2,1) <> mid(K_ALFA1,K_CTR1,1) then  
				
				k_barcode_pref = replace(k_barcode_pref, 2, 1, mid(K_ALFA1,1,1))
			//	mid(k_barcode_pref,2,2) = mid(K_ALFA1,1,1)   
	
				for K_CTR1 = 1 to K_ALFA_LENGTH
					if mid(k_barcode_pref,1,1) = mid(K_ALFA,K_CTR1,1) then  
						exit 
					end if
				next 
			
				if mid(k_barcode_pref,1,1) <> mid(K_ALFA,K_CTR1,1) then  
					k_barcode_pref = replace(k_barcode_pref, 1, 1, mid(K_ALFA,1,1))
		//			mid(k_barcode_pref,1,1) = mid(K_ALFA,1,1)
				else
					K_CTR1 = K_CTR1 + 1
					k_barcode_pref = replace(k_barcode_pref, 1, 1, mid(K_ALFA,K_CTR1,1))
	//				mid(k_barcode_pref,1,1) = mid(K_ALFA,K_CTR1,K_CTR1)
				end if
			else
				K_CTR1 = K_CTR1 + 1
				k_barcode_pref = replace(k_barcode_pref, 2, 1, mid(K_ALFA1,K_CTR1,1))
	//			mid(k_barcode_pref,2,2) = mid(K_ALFA1,K_CTR1,K_CTR1)
			end if 
		end if 
		
		kst_tab_barcode.barcode = string(k_barcode_cliente, "@@@") + string(k_barcode_pref,"@@") + string(k_barcode_num, "000") //compone il bcode
	
	loop while kuf1_barcode.if_esiste(kst_tab_barcode) //rimane nel ciclo fino a che non esiste su tab quindi è NUOVO

	k_return = kst_tab_barcode.barcode

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	SetPointer(kkg.POINTER_ATTESA)
	
end try

return k_return

end function

private function string u_get_start_barcode (long a_id_cliente) throws uo_exception;//
//--------------------------------------------------------------------------------------------
//--- Creazione dei BARCODE della riga Lotto
//--- 
//---  input: id_cliente da codificare
//---  Outout:  
//---  Ritorna: barcode da cui iniziare
//---  Se errore lancia EXCEPTION
//---                                     
//--------------------------------------------------------------------------------------------
//
//
string k_return=""
string k_barcode_pref, k_barcode_cliente=""
int k_barcode_num=0, K_CTR1
string k_esito=""
kuf_barcode kuf1_barcode
kuf_base kuf1_base


try
	
//--- Puntatore Cursore da attesa.....
	SetPointer(kkg.POINTER_ATTESA)

//   	kst_esito.esito = kkg_esito.ok
//   	kst_esito.sqlcode = 0
//   	kst_esito.SQLErrText = ""
//   	kst_esito.nome_oggetto = this.classname()

	kuf1_barcode = create kuf_barcode

//--- compone il BARCODE di partenza ovvero la codifica del cliente, poi get del progressivo del barcode generato: 2 ALFA+PROGRESSIVO num di 3
	k_barcode_cliente = u_decod_clie(a_id_cliente)
	
	kuf1_base = create kuf_base
//--- get dell'attuale il prefisso ALFA
	k_esito = kuf1_base.prendi_dato_base( "barcode_pref")
	if left(k_esito,1) <> "0" then
		kguo_exception.inizializza( )
		kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_non_eseguito)
		kguo_exception.setmessage("Errore durante accesso alle PROPRIETA' per leggere il Prefisso dei barcode. Err.=" + trim(k_esito))
	else
		k_barcode_pref = trim(mid(k_esito,2))
		if k_barcode_pref > " " then
		else
			k_barcode_pref = "AA"   // se vuoto imposta "AA"
		end if
	end if
//--- get dell'attuale il prefisso NUMERICO
	k_esito = kuf1_base.prendi_dato_base( "barcode_progr")
	if left(k_esito,1) <> "0" then
		kguo_exception.inizializza( )
		kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_non_eseguito)
		kguo_exception.setmessage("Errore durante accesso alle PROPRIETA' per leggere il Prefisso dei barcode. Err.=" + trim(k_esito))
	else
		k_barcode_num = integer(trim(mid(k_esito,2)))
	end if
	
	k_return = string(k_barcode_cliente, "@@@") + string(k_barcode_pref, "@@") + string(k_barcode_num, "000")

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	SetPointer(kkg.POINTER_ATTESA)
	
end try

return k_return

end function

private function integer u_crea_barcode (st_tab_barcode ast_tab_barcode, integer a_nr_barcode) throws uo_exception;//
//--------------------------------------------------------------------------------------------
//--- Creazione dei BARCODE della riga Lotto
//--- 
//---  input: ID_ARMO, nr barcode da creare
//---  Outout: 
//---  Ritorna: nr barcode creati
//---  Se errore lancia EXCEPTION
//---                                     
//--------------------------------------------------------------------------------------------
//	
//#------------------------------------------------------------------------------------------------------------------------------------
//#--- Il barcode NORMALE di lavorazione alla GAMMARAD e' composto sostanzialmente cosi':
//#    e' un code-39 di 8 caratteri 'cccxxnnn'
//#    ccc  = codice di 3 calcolato sul codice cliente (vedi algoritmo in get_cod_da_clie) - barcode_mask
//#    xx   = progressivo alfanumerico    - barcode_pref
//#    nnn = progressivo 0-999 numerico  - barcode_num
//#------------------------------------------------------------------------------------------------------------------------------------
//
int k_return=0
int K_CTR
string k_esito=""
st_tab_armo kst_tab_armo
st_tab_meca kst_tab_meca
st_tab_base kst_tab_base
st_esito kst_esito
kuf_armo kuf1_armo
kuf_barcode kuf1_barcode
kuf_base kuf1_base


try
	
//--- Puntatore Cursore da attesa.....
	SetPointer(kkg.POINTER_ATTESA)

   	kst_esito.esito = kkg_esito.ok
   	kst_esito.sqlcode = 0
   	kst_esito.SQLErrText = ""
   	kst_esito.nome_oggetto = this.classname()


	kuf1_armo = create kuf_armo
	kuf1_barcode = create kuf_barcode

	if ast_tab_barcode.id_meca > 0 then
	else
		kst_tab_armo.id_armo = ast_tab_barcode.id_armo
		kuf1_armo.get_id_meca(kst_tab_armo)
		ast_tab_barcode.id_meca = kst_tab_armo.id_meca
	end if
	kst_tab_meca.id = ast_tab_barcode.id_meca
	kuf1_armo.get_clie(kst_tab_meca)

//--- compone il BARCODE di partenza ovvero la codifica del cliente, poi get del progressivo del barcode generato: 2 ALFA+PROGRESSIVO num di 3
	ast_tab_barcode.barcode = u_get_start_barcode(kst_tab_meca.clie_3)
	

	for k_ctr = 1 to a_nr_barcode

//--- get del barcode		
		ast_tab_barcode.barcode = u_get_next_barcode(ast_tab_barcode.barcode)

//--- carica su tabella 
		u_add_barcode(ast_tab_barcode)

//--- Aggiorna su tab BASE il dato dell'ultimo barcode caricato
		kuf1_base = create kuf_base 
		kst_tab_base.st_tab_g_0.esegui_commit = ast_tab_barcode.st_tab_g_0.esegui_commit 
		kst_tab_base.key = "barcode_progr"
		kst_tab_base.key1 = string(mid(ast_tab_barcode.barcode,6,3))
		kst_esito  = kuf1_base.metti_dato_base(kst_tab_base)
		kst_tab_base.st_tab_g_0.esegui_commit = ast_tab_barcode.st_tab_g_0.esegui_commit 
		kst_tab_base.key = "barcode_pref"
		kst_tab_base.key1 = string(mid(ast_tab_barcode.barcode,4,2))
		kst_esito  = kuf1_base.metti_dato_base(kst_tab_base)

		
	next
	k_return = a_nr_barcode

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	SetPointer(kkg.POINTER_ATTESA)
	
end try

return k_return

end function

public function integer lotto_genera_barcode (st_tab_barcode ast_tab_barcode) throws uo_exception;//
//--------------------------------------------------------------------------------------------
//--- Genera i BARCODE x l'intero lotto
//--- 
//--- 
//---  input: ID_MECA o ID_ARMO
//---  Outout: 
//---  Ritorna: numero barcode generati/distrutti
//---                                     
//--------------------------------------------------------------------------------------------
//	
//#------------------------------------------------------------------------------------------------------------------------------------
//#--- Il barcode NORMALE di lavorazione alla GAMMARAD e' composto sostanzialmente cosi':
//#    e' un code-39 di 8 caratteri 'cccxxnnn'
//#    ccc  = codice di 3 calcolato sul codice cliente (vedi algoritmo in get_cod_da_clie) - barcode_mask
//#    xx   = progressivo alfanumerico    - barcode_pref
//#    nnn = progressivo 0-999 numerico  - barcode_num
//#------------------------------------------------------------------------------------------------------------------------------------
//
int k_return=0
int k_barcode_num=0, k_barcode_aggiornati=0
int k_nr_righe=0, k_riga = 0
st_tab_armo kst_tab_armo
st_tab_meca_dosim kst_tab_meca_dosim
st_esito kst_esito
kuf_armo kuf1_armo
kuf_barcode kuf1_barcode
kuf_meca_dosim kuf1_meca_dosim
datastore kds_id_armo_x_id_meca


try
	
//--- Puntatore Cursore da attesa.....
	SetPointer(kkg.POINTER_ATTESA)

   	kst_esito.esito = kkg_esito.ok
   	kst_esito.sqlcode = 0
   	kst_esito.SQLErrText = ""
   	kst_esito.nome_oggetto = this.classname()

	if ast_tab_barcode.id_meca > 0 or ast_tab_barcode.id_armo > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Generazioe Barcode del Lotto non eseguita. Manca id Lotto"
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	kuf1_armo = create kuf_armo
	kuf1_barcode = create kuf_barcode

//--- se non ho passato il ID_MECA lo reperisco da ID_RMO 
	if ast_tab_barcode.id_meca > 0 then
	else
		kst_tab_armo.id_armo = ast_tab_barcode.id_armo
		kst_esito = kuf1_armo.get_id_meca_da_id_armo(kst_tab_armo)
		if kst_esito.esito <> kkg_esito.ok then
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		ast_tab_barcode.id_meca = kst_tab_armo.id_meca
	end if

//--- estrazione righe lotto da fare il barcode
	kds_id_armo_x_id_meca = create datastore
	kds_id_armo_x_id_meca.dataobject = "ds_id_armo_x_id_meca"
	kds_id_armo_x_id_meca.settransobject(kguo_sqlca_db_magazzino)
	k_nr_righe = kds_id_armo_x_id_meca.retrieve(ast_tab_barcode.id_meca)

//--- CICLO PER TRATTARE TUTTE LE RIGHE CARICATE
	k_riga = 1
	do while k_nr_righe >= k_riga
		
		k_barcode_aggiornati = 0
		ast_tab_barcode.id_armo = kds_id_armo_x_id_meca.getitemnumber(k_riga, "id_armo")  // get del ID_RMO su cui lavorare
		
//--- nr colli caricati da trattare
		kst_tab_armo.id_armo = ast_tab_barcode.id_armo
		kst_tab_armo.colli_2 = kuf1_armo.get_colli_entrati_riga_datrattare(kst_tab_armo)

//--- nr barcode già generati	
		k_barcode_num = kuf1_barcode.get_nr_barcode_x_id_armo(ast_tab_barcode)
	
//--- se nr barcode generati superiore al numero barcode caricati ne distruggo una parte (tento gli ultimi)	
		if k_barcode_num > kst_tab_armo.colli_2 then
			
			k_barcode_aggiornati = u_distruggi_barcode(ast_tab_barcode, (k_barcode_num - kst_tab_armo.colli_2))
			
		else
			if kst_tab_armo.colli_2 > 0 then

//--- se colli entrati uguali a quelli già fatti come barcode faccio la rigenerazione!
				if k_barcode_num = kst_tab_armo.colli_2 then
					ast_tab_barcode.st_tab_g_0.esegui_commit = "S"
					u_distruggi_barcode(ast_tab_barcode, k_barcode_num)
					k_barcode_num = 0 // li ho rimossi quindi posso azzerare
				end if		
			
//--- poi cmq genera quelli ancora da fare, probabilmente tutti!
				ast_tab_barcode.st_tab_g_0.esegui_commit = "S"
				k_barcode_aggiornati = u_crea_barcode(ast_tab_barcode, (kst_tab_armo.colli_2 - k_barcode_num))
			end if
			
		end if
		
		k_return += k_barcode_aggiornati
		
		k_riga++  // incrementa la riga successiva da leggere
	loop
	
	if k_return > 0 then 
		
		ast_tab_barcode.st_tab_g_0.esegui_commit = "S"
		kuf1_barcode.set_flg_dosimetro_all(ast_tab_barcode)  // Flegga il dosimetro sul giusto barcode
		
//--- genera barcode dosimetri	
		kuf1_meca_dosim = create kuf_meca_dosim
		kst_tab_meca_dosim.id_meca = ast_tab_barcode.id_meca
		kst_tab_meca_dosim.st_tab_g_0.esegui_commit = "S"
		kuf1_meca_dosim.u_genera_rimuove_barcode(kst_tab_meca_dosim)
		
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kuf1_meca_dosim) then destroy kuf1_meca_dosim
	SetPointer(kkg.POINTER_ATTESA)
	
end try

return k_return

end function

public function boolean if_da_generare (st_tab_barcode ast_tab_barcode) throws uo_exception;//
//--- Valuta se BARCODE sono da generare
//
//--- input: st_tab_barcode.id_meca
//--- rit: TRUE=da generare
//
boolean k_return = false
kuf_barcode kuf1_barcode


kuf1_barcode = create kuf_barcode
if kuf1_barcode.get_nr_barcode(ast_tab_barcode) > 0 then
else
	k_return = true  // Barcode ancora da generare
end if

return k_return




end function

public function integer get_nr_barcode_da_generare (st_tab_barcode ast_tab_barcode) throws uo_exception;//
//---------------------------------------------------------------------------------------------------------------------------
//--- Torna il numero barcode da generare per Lotto
//--- 
//---  input: ID_MECA 
//---  Outout: 
//---  Ritorna: numero barcode da generare se positivo da distruggere se negativo
//---                                     
//---------------------------------------------------------------------------------------------------------------------------
//	
int k_return=0
int k_barcode_num=0
st_tab_armo kst_tab_armo
st_esito kst_esito
//kuf_armo kuf1_armo
kuf_barcode kuf1_barcode


try
	
//--- Puntatore Cursore da attesa.....
	SetPointer(kkg.POINTER_ATTESA)

   	kst_esito.esito = kkg_esito.ok
   	kst_esito.sqlcode = 0
   	kst_esito.SQLErrText = ""
   	kst_esito.nome_oggetto = this.classname()

	if ast_tab_barcode.id_meca > 0 or ast_tab_barcode.id_armo > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Conteggio Barcode da generare per Lotto non eseguita. Manca id Lotto"
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
//	kuf1_armo = create kuf_armo
	kuf1_barcode = create kuf_barcode


//--- estrazione righe lotto da fare il barcode
	select sum(colli_2)
	      into :kst_tab_armo.colli_2
		  from armo
		  where id_meca = :ast_tab_barcode.id_meca and cod_sl_pt > " " and magazzino <> 1
		using kguo_sqlca_db_magazzino;
		
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.sqlerrtext = "Errore durante lettura Colli entrati per Conteggio Barcode da generare per Lotto." + "~n~rErrore: " +trim(kst_esito.sqlerrtext) 
			kguo_exception.inizializza()
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			kst_tab_armo.colli_2 = 0
		end if
			
//--- nr barcode già generati	x lotto
		k_barcode_num = kuf1_barcode.get_nr_barcode(ast_tab_barcode)
	
//--- quanti da fare o disfare?
		if kst_tab_armo.colli_2 > 0 then
			k_return = kst_tab_armo.colli_2 - k_barcode_num
		else
			k_return = 0 - k_barcode_num
		end if
				 
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	SetPointer(kkg.POINTER_ATTESA)
	
end try

return k_return

end function

public function boolean if_stampati (st_tab_barcode ast_tab_barcode) throws uo_exception;//
//--- Valuta se BARCODE sono stati stampati (almeno 1)
//
//--- input: st_tab_barcode.id_meca
//--- rit: TRUE=già stampati
//
boolean k_return = false
kuf_barcode kuf1_barcode


kuf1_barcode = create kuf_barcode
if kuf1_barcode.get_nr_barcode_stampati(ast_tab_barcode) > 0 then
	k_return = true  // Barcode stampati
end if

return k_return




end function

public function integer get_nr_barcode_generati (st_tab_barcode ast_tab_barcode) throws uo_exception;//
//---------------------------------------------------------------------------------------------------------------------------
//--- Torna il numero barcode già generati per Lotto
//--- 
//---  input: ID_MECA 
//---  Outout: 
//---  Ritorna: numero barcode generati
//---                                     
//---------------------------------------------------------------------------------------------------------------------------
//	
int k_return=0
int k_barcode_num=0
st_esito kst_esito
kuf_barcode kuf1_barcode


try
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if ast_tab_barcode.id_meca > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Conteggio Barcode generati per Lotto non eseguita. Manca id Lotto"
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	kuf1_barcode = create kuf_barcode

//--- nr barcode già generati	x lotto
	k_barcode_num = kuf1_barcode.get_nr_barcode(ast_tab_barcode)
	
//--- quanti da fare o disfare?
	if k_barcode_num > 0 then
		k_return = k_barcode_num
	end if
				 
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	
end try

return k_return

end function

public function integer get_nr_barcode_x_id_armo (st_tab_barcode ast_tab_barcode) throws uo_exception;//
//---------------------------------------------------------------------------------------------------------------------------
//--- Torna il numero barcode già generati per Lotto
//--- 
//---  input: ID_ARMO 
//---  Outout: 
//---  Ritorna: numero barcode generati
//---                                     
//---------------------------------------------------------------------------------------------------------------------------
//	
int k_return=0
int k_barcode_num=0
st_esito kst_esito
kuf_barcode kuf1_barcode


try
	
//--- Puntatore Cursore da attesa.....
	SetPointer(kkg.POINTER_ATTESA)

   	kst_esito.esito = kkg_esito.ok
   	kst_esito.sqlcode = 0
   	kst_esito.SQLErrText = ""
   	kst_esito.nome_oggetto = this.classname()

	if ast_tab_barcode.id_armo > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Conteggio Barcode generati per Lotto non eseguita. Manca id riga Lotto"
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	kuf1_barcode = create kuf_barcode

//--- nr barcode già generati	x lotto
	k_barcode_num = kuf1_barcode.get_nr_barcode_x_id_armo(ast_tab_barcode)
	
	if k_barcode_num > 0 then
		k_return = k_barcode_num
	end if
				 
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	SetPointer(kkg.POINTER_ATTESA)
	
end try

return k_return

end function

public function integer u_distruggi_barcode (st_tab_barcode ast_tab_barcode, integer a_nr_barcode) throws uo_exception;//
//--------------------------------------------------------------------------------------------
//--- Rimozione dei BARCODE dalla riga Lotto
//--- 
//---  input: ID_ARMO, nr barcode da cancellare (ZERO = tutte)
//---  Outout: 
//---  Ritorna: nr barcode cancellati
//---  Se errore lancia EXCEPTION
//---                                     
//--------------------------------------------------------------------------------------------
//
int k_return = 0
int k_ctr, k_righe
st_esito kst_esito
datastore kds_barcode
kuf_barcode kuf1_barcode


if ast_tab_barcode.id_armo > 0 then
   	kst_esito.esito = kkg_esito.ok
   	kst_esito.sqlcode = 0
   	kst_esito.SQLErrText = ""
   	kst_esito.nome_oggetto = this.classname()

	kuf1_barcode = create kuf_barcode

	kds_barcode = create datastore
	kds_barcode.dataobject = "ds_barcode_1"
	kds_barcode.settransobject( kguo_sqlca_db_magazzino )
	k_righe = kds_barcode.retrieve(ast_tab_barcode.id_armo)
	if k_righe > 0 then

//--- ordina i barcode dal più grande 		
		kds_barcode.setsort( "barcode desc" )
		kds_barcode.sort( )

//--- se ho passato un nr barcode troppo grande oppure a zero allora forza nr uguale al nr barcode massimo 		
		if k_righe < a_nr_barcode or a_nr_barcode = 0 then
			a_nr_barcode = k_righe
		end if
//--- cancella i barcode		
		for k_ctr = 1 to a_nr_barcode
			ast_tab_barcode.barcode = kds_barcode.getitemstring( k_ctr, "barcode")
			kst_esito = kuf1_barcode.tb_delete(ast_tab_barcode)  // CANCELLA
			if kst_esito.esito <> kkg_esito.ok then
				kst_esito.sqlerrtext = "Anomalia durante rimozione Barcode dal Lotto id riga = " + string(ast_tab_barcode.id_armo) &
				                 + "~n~r" +trim(kst_esito.sqlerrtext) 
				kguo_exception.inizializza()
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
			k_return ++
		next
	end if	
	
end if

return k_return 


end function

public function integer u_e1_importa_barcode (st_tab_barcode ast_tab_barcode) throws uo_exception;//
//--------------------------------------------------------------------------------------------
//---  Get dei barcode generati da E1 e add i barcode nella tabella di M2000
//---  
//---  input: ID_MECA o ID_ARMO
//---  Outout: 
//---  Ritorna: numero barcode trattati
//---                                     
//--------------------------------------------------------------------------------------------
//
int k_return=0
int k_nr_righe=0, k_riga = 0
st_tab_armo kst_tab_armo
st_tab_meca_dosim kst_tab_meca_dosim
st_tab_wm_pklist_righe kst_tab_wm_pklist_righe
st_tab_meca kst_tab_meca
st_get_e1barcode kst_get_e1barcode
st_tab_clienti kst_tab_clienti
st_esito kst_esito
kuf_armo kuf1_armo
kuf_barcode kuf1_barcode
kuf_meca_dosim kuf1_meca_dosim
kuf_wm_pklist_righe kuf1_wm_pklist_righe
kuf_e1_asn kuf1_e1_asn
kuf_clienti kuf1_clienti
datastore kds_id_armo_x_id_meca
kds_e1_asn_get_barcode kds1_e1_asn_get_barcode

try
	

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if ast_tab_barcode.id_meca > 0 or ast_tab_barcode.id_armo > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Errore in importazione codici barcode da E1. Manca ID Lotto"
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	kuf1_armo = create kuf_armo
	kuf1_barcode = create kuf_barcode
	kuf1_wm_pklist_righe = create kuf_wm_pklist_righe
	kuf1_e1_asn = create kuf_e1_asn
	kuf1_clienti = create kuf_clienti

//--- se non ho passato il ID_MECA lo reperisco da ID_RMO 
	if ast_tab_barcode.id_meca > 0 then
	else
		kst_tab_armo.id_armo = ast_tab_barcode.id_armo
		kst_esito = kuf1_armo.get_id_meca_da_id_armo(kst_tab_armo)
		if kst_esito.esito <> kkg_esito.ok then
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		ast_tab_barcode.id_meca = kst_tab_armo.id_meca
	end if

//--- estrazione dati barcode da E1 
	kst_get_e1barcode.apid = string(ast_tab_barcode.id_meca)
	kds1_e1_asn_get_barcode = kuf1_e1_asn.get_barcode(kst_get_e1barcode)
	k_nr_righe = kds1_e1_asn_get_barcode.rowcount( )

//--- aggiorna su MECA il WO/SO di E1
	if k_nr_righe > 0 then
		kst_tab_meca.id = ast_tab_barcode.id_meca
		kst_tab_meca.e1doco = kds1_e1_asn_get_barcode.getitemnumber(1, "f4801_adt_wadoco")  // get WO
		kst_tab_meca.e1rorn = kds1_e1_asn_get_barcode.getitemnumber(1, "f4211_e1rorn")  // get SO
		kst_tab_meca.st_tab_g_0.esegui_commit = "S"
		kuf1_armo.set_e1doco(kst_tab_meca)		
		kuf1_armo.set_e1rorn(kst_tab_meca)		
	end if

	kst_esito.SQLErrText = ""

////--- get eventuale prefisso dei barcode (pklbcodepref)
//	kst_tab_meca.id = ast_tab_barcode.id_meca
//	kuf1_armo.get_clie(kst_tab_meca)
//	if kst_tab_meca.clie_1 > 0 then
//		kst_tab_clienti.codice = kst_tab_meca.clie_1
//		kst_tab_clienti.pklbcodepref = kuf1_clienti.get_pklbcodepref(kst_tab_clienti)
//	else
//		kst_tab_clienti.pklbcodepref = ""
//	end if
	
//--- CICLO PER TRATTARE TUTTE LE RIGHE CARICATE
	for k_riga = 1 to k_nr_righe 
		
		kst_tab_wm_pklist_righe.id_meca = ast_tab_barcode.id_meca
//		if	trim(kst_tab_clienti.pklbcodepref) > " " then
//			kst_tab_wm_pklist_righe.wm_barcode = mid(trim(kds1_e1_asn_get_barcode.getitemstring(k_riga, "f4108_adt_iolot2")), len(trim(kst_tab_clienti.pklbcodepref)) + 1)  // prefisso bcode del cliente + barcode cliente
//		else
		kst_tab_wm_pklist_righe.wm_barcode = trim(kds1_e1_asn_get_barcode.getitemstring(k_riga, "f4108_adt_iolot2"))  // get barcode cliente
		if trim(kst_tab_wm_pklist_righe.wm_barcode) > " " then 
//		end if
			ast_tab_barcode.id_armo = kuf1_wm_pklist_righe.get_id_armo_da_wm_barcode(kst_tab_wm_pklist_righe)  // get del ID_RMO 
		
			if ast_tab_barcode.id_armo > 0 then
				ast_tab_barcode.barcode = trim(kds1_e1_asn_get_barcode.getitemstring( k_riga, "f3111_adt_wmlotn"))  // get barcode generato da E1
			else
				kst_esito.esito = kkg_esito.ko
				kst_esito.SQLErrText += "Errore in importazione codici Barcode da E1, ID riga Lotto non rilevata attraverso il barcode cliente (pk-list) " &
												+ trim(kst_tab_wm_pklist_righe.wm_barcode) + " ~n~rCodice ASN (id Lotto) " + string(kst_get_e1barcode.apid)
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
			if trim(ast_tab_barcode.barcode) > " " then
				
				ast_tab_barcode.st_tab_g_0.esegui_commit = "S"
				if u_add_barcode(ast_tab_barcode) then 	 //--- carica su tabella BARCODE
					k_return ++
				end if
				
			else
				kst_esito.esito = kkg_esito.no_esecuzione
				kst_esito.SQLErrText = "Errore in importazione codici Barcode E1, codice Barcode E1 di lavorazione vuoto (campo 'wmlotn' o 'sdlotn'), barcode cliente (pk-list) " &
												 + trim(kst_tab_wm_pklist_righe.wm_barcode) + " ~n~rCodice ASN (id Lotto) " + string(kst_get_e1barcode.apid)
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				//throw kguo_exception
			end if

		else
			kst_esito.esito = kkg_esito.no_esecuzione
			kst_esito.SQLErrText = "Errore in importazione codici Barcode da E1, codice Barcode cliente vuoto sulla tabella E1. " &
											 + " ~n~rCercato con il codice ASN (id Lotto) " + string(kst_get_e1barcode.apid)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
			
	next
	
	if k_return > 0 then 
		
		ast_tab_barcode.st_tab_g_0.esegui_commit = "S"
		kuf1_barcode.set_flg_dosimetro_all(ast_tab_barcode)  // Flegga il dosimetro sul giusto barcode
		
//--- genera barcode dosimetri	
		kuf1_meca_dosim = create kuf_meca_dosim
		kst_tab_meca_dosim.id_meca = ast_tab_barcode.id_meca
		kst_tab_meca_dosim.st_tab_g_0.esegui_commit = "S"
		kuf1_meca_dosim.u_genera_rimuove_barcode(kst_tab_meca_dosim)
		
	end if

//--- Imposta stato 'IN ATTENZIONE'
	kst_tab_meca.id = ast_tab_barcode.id_meca
	kst_tab_meca.st_tab_g_0.esegui_commit = "S"
	kst_esito = kuf1_armo.set_stato_in_attenzione_on(kst_tab_meca)
	if kst_esito.esito <> kkg_esito.ok then
		kst_esito.esito = kkg_esito.ko
		kst_esito.SQLErrText = "Stato 'In Attenzione' non impostato sul Lotto, procedere manualmente" + "~n~r"   + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	 
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kuf1_meca_dosim) then destroy kuf1_meca_dosim
	if isvalid(kuf1_wm_pklist_righe) then destroy kuf1_wm_pklist_righe
	if isvalid(kuf1_armo) then destroy kuf1_armo
	if isvalid(kuf1_barcode) then destroy kuf1_barcode
	if isvalid(kuf1_e1_asn) then destroy kuf1_e1_asn
	if isvalid(kuf1_clienti) then destroy kuf1_clienti
	
end try

return k_return

end function

public function integer u_e1_importa_barcode_batch () throws uo_exception;//
//--------------------------------------------------------------------------------------------
//---  Get dei barcode generati da E1 di tutti i lotti in attesa via BATCH
//---  
//---  input: 
//---  Out: 
//---  Ritorna: numero barcode importati
//---                                     
//--------------------------------------------------------------------------------------------
//
long k_return=0
long k_nr_righe=0, k_riga = 0, k_nr_lotti
date k_data_da
st_tab_barcode kst_tab_barcode
st_esito kst_esito, kst_esito_app
datastore kds_armo_nobarcode


try
	
//--- Puntatore Cursore da attesa.....
	SetPointer(kkg.POINTER_ATTESA)

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	k_data_da = relativedate(kguo_g.get_dataoggi( ), -120)  // indietro un po' di giorni

	kds_armo_nobarcode = create datastore
	kds_armo_nobarcode.dataobject = "ds_armo_nobarcode"
	kds_armo_nobarcode.settransobject(kguo_sqlca_db_magazzino)
	k_nr_righe = kds_armo_nobarcode.retrieve(k_data_da)

//--- CICLO PER TRATTARE TUTTI I LOTTI TROVATI SENZA BARCODE
	for k_riga = 1 to k_nr_righe 
		
		kst_tab_barcode.id_meca = kds_armo_nobarcode.getitemnumber(k_riga, "id_meca")
		
		try
			
			k_nr_lotti = u_e1_importa_barcode(kst_tab_barcode)
		
			if k_nr_lotti > 0 then
				k_return += k_nr_lotti
			end if
			
		catch (uo_exception kuo1_exception)
			kst_esito_app = kuo1_exception.get_st_esito()
			kst_esito.sqlerrtext += kst_esito_app.sqlerrtext
			if kst_esito.sqlcode >= 0 then  // se ho già settato un err GRAVE non lo reimposta 
				kst_esito.sqlcode = kst_esito_app.sqlcode 
				kst_esito.esito = kst_esito_app.esito
			end if
			
		end try
	next
	
//--- importazione conclusa ma ci sono Anomalie 	
	if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.no_esecuzione then
		if len(trim(kst_esito.sqlerrtext)) > 400 then
			kst_esito.sqlerrtext = left(trim(kst_esito.sqlerrtext), 400) + "..."
		end if
		if k_return > 0 then
			kst_esito.sqlerrtext = "Sono stati importati " + string(k_return) + " barcode. "
			if trim(kst_esito.sqlerrtext) > " " then
				kst_esito.sqlerrtext += "Fare attenzione alle ANOMALIE qui indicate ~n~r" + kst_esito.sqlerrtext
			end if
		else
			kst_esito.sqlerrtext = "Non ci sono barcode da importare. "
			if trim(kst_esito.sqlerrtext) > " " then
				kst_esito.sqlerrtext += "Fare attenzione alle ANOMALIE qui indicate ~n~r" + kst_esito.sqlerrtext
			end if
		end if
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	 
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kds_armo_nobarcode) then destroy kds_armo_nobarcode
	
	SetPointer(kkg.POINTER_ATTESA)
	
end try

return k_return

end function

private function boolean u_add_barcode (st_tab_barcode ast_tab_barcode) throws uo_exception;//
//--------------------------------------------------------------------------------------------
//--- Aggiunge BARCODE in archivio
//--- 
//---  input: ID_ARMO, ID_MECA, BARCODE
//---  Outout: 
//---  Ritorna: TRUE = barcode inserito
//---  Se errore lancia EXCEPTION
//---                                     
//--------------------------------------------------------------------------------------------
//
boolean k_return=false
int k_ctr, k_righe
st_tab_armo kst_tab_armo
st_tab_meca kst_tab_meca
st_tab_sl_pt kst_tab_sl_pt
st_esito kst_esito
datastore kds_barcode
kuf_barcode kuf1_barcode
kuf_armo kuf1_armo
kuf_sl_pt kuf1_sl_pt 



if ast_tab_barcode.id_armo > 0 and trim(ast_tab_barcode.barcode) > " " then
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kuf1_armo = create kuf_armo
	kuf1_sl_pt = create kuf_sl_pt
	kuf1_barcode = create kuf_barcode

//--- get del codice SL-PT
	kst_tab_armo.id_armo = ast_tab_barcode.id_armo
	kst_tab_sl_pt.cod_sl_pt = kuf1_armo.get_cod_sl_pt(kst_tab_armo)
	if trim(kst_tab_sl_pt.cod_sl_pt) > " " then
		kst_esito = kuf1_sl_pt.select_riga(kst_tab_sl_pt)
		if kst_esito.esito <> kkg_esito.ok then
			kst_esito.sqlerrtext = "Anomalia durante aggiornamento Barcode in archivio (lettura Piano di Lavoro codice = " + trim(kst_tab_sl_pt.cod_sl_pt) &
								  + ")~n~r" +trim(kst_esito.sqlerrtext) 
			kguo_exception.inizializza()
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	else
		kst_tab_sl_pt.cod_sl_pt = ""
	end if
	
//--- get del id_meca	
	if ast_tab_barcode.id_meca > 0 then
	else
		kst_tab_armo.id_armo = ast_tab_barcode.id_armo
		kst_esito = kuf1_armo.get_id_meca_da_id_armo(kst_tab_armo)
		if kst_esito.esito <> kkg_esito.ok then
			kst_esito.sqlerrtext = "Anomalia durante aggiornamento Barcode in archivio (lettura id Lotto da id riga = " + string(kst_tab_armo.id_armo)  &
								  + ")~n~r" +trim(kst_esito.sqlerrtext) 
			kguo_exception.inizializza()
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		ast_tab_barcode.id_meca = kst_tab_armo.id_meca
	end if
	
//--- get del num_int	
	if ast_tab_barcode.num_int > 0 then
	else
		try
			kst_tab_meca.id = ast_tab_barcode.id_meca
			kuf1_armo.get_num_int(kst_tab_meca)
			ast_tab_barcode.num_int = kst_tab_meca.num_int
			ast_tab_barcode.data_int = kst_tab_meca.data_int
		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()
			kst_esito.sqlerrtext = "Anomalia durante aggiornamento Barcode in archivio (lettura Numero Lotto id riga = " + string(ast_tab_barcode.id_armo)  &
								  + ")~n~r" +trim(kst_esito.sqlerrtext) 
			kguo_exception.inizializza()
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end try
		
//--- get del MAGAZZINO	
		try
			kst_tab_armo.id_armo = ast_tab_barcode.id_armo
			kuf1_armo.get_magazzino(kst_tab_armo)
			if kst_tab_armo.magazzino <> kuf1_armo.kki_magazzino_datrattare then
				ast_tab_barcode.causale = kuf1_barcode.ki_causale_non_trattare
			end if
		catch (uo_exception kuo1_exception)
			kst_esito = kuo1_exception.get_st_esito()
			kst_esito.sqlerrtext = "Anomalia durante aggiornamento Barcode in archivio (lettura Numero Lotto id riga = " + string(ast_tab_barcode.id_armo)  &
								  + ")~n~r" +trim(kst_esito.sqlerrtext) 
			kguo_exception.inizializza()
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end try
			
   		ast_tab_barcode.data = kguo_g.get_dataoggi( )
		ast_tab_barcode.BARCODE_lav = ""
		ast_tab_barcode.groupage = kuf1_barcode.ki_barcode_groupage_NO
		ast_tab_barcode.tipo_cicli = kst_tab_sl_pt.tipo_cicli
		ast_tab_barcode.fila_1 = kst_tab_sl_pt.fila_1
		ast_tab_barcode.fila_2 = kst_tab_sl_pt.fila_2
		ast_tab_barcode.fila_1p = kst_tab_sl_pt.fila_1p
		ast_tab_barcode.fila_2p = kst_tab_sl_pt.fila_2p
		ast_tab_barcode.pl_barcode = 0
		ast_tab_barcode.pl_barcode_progr = 0
		ast_tab_barcode.FLG_DOSIMETRO = kuf1_barcode.ki_flg_dosimetro_no

		try
			if kuf1_barcode.tb_add(ast_tab_barcode) then // CARICA IL BARCODE!!!
				k_return = true
			end if
		catch (uo_exception kuo2_exception)
			kst_esito = kuo2_exception.get_st_esito()
			kst_esito.sqlerrtext = "Errore durante inserimento Barcode in archivio codice = " + trim(ast_tab_barcode.BARCODE)  &
								  + ")~n~r" +trim(kst_esito.sqlerrtext) 
			kguo_exception.inizializza()
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end try
	end if	
	
end if

return k_return

end function

on kuf_barcode_ini.create
call super::create
end on

on kuf_barcode_ini.destroy
call super::destroy
end on

