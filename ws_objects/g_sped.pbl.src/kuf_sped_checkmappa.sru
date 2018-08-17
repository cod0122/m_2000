$PBExportHeader$kuf_sped_checkmappa.sru
forward
global type kuf_sped_checkmappa from nonvisualobject
end type
end forward

global type kuf_sped_checkmappa from nonvisualobject
end type
global kuf_sped_checkmappa kuf_sped_checkmappa

type variables
//
private kuf_sped kiuf_sped 
end variables

forward prototypes
public function boolean if_num_data_congruenti (ref st_tab_sped kst_tab_sped) throws uo_exception
public function integer get_colli_da_sped (st_tab_arsp ast_tab_arsp) throws uo_exception
public function st_esito u_check_dati (ref datastore ads_inp_testa, ref datastore ads_inp_righe) throws uo_exception
public function boolean if_clie_2_alternativo_congruente (st_tab_sped kst_tab_sped) throws uo_exception
public function boolean if_clie_3_alternativo_congruente (long a_clie_1, long a_clie_2, long a_clie_3) throws uo_exception
end prototypes

public function boolean if_num_data_congruenti (ref st_tab_sped kst_tab_sped) throws uo_exception;//--
//---  Controlla che Num+Data ddt siano congruenti
//---
//---  input: st_tab_sped.num_bolla_out e data_bolla_out 
//---  otput: boolean = TRUE DDT congruente tutto OK;    FALSE=KO
//---  se ERRORE lancia un Exception
//---
boolean k_return = false
string k_presente
int k_anno
st_esito kst_esito 


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_sped.num_bolla_out > 0 then 

	k_anno = year(kst_tab_sped.data_bolla_out)

   	select distinct '1'
	   	into :k_presente
	   	from  sped
		 where 
				year(data_bolla_out) =  :k_anno
				and ( (num_bolla_out >  :kst_tab_sped.num_bolla_out and data_bolla_out <  :kst_tab_sped.data_bolla_out)
				        or (num_bolla_out <  :kst_tab_sped.num_bolla_out and data_bolla_out >  :kst_tab_sped.data_bolla_out) )
		 using kguo_sqlca_db_magazzino ;
		 
	if sqlca.sqlcode = 0 then
		if k_presente = '1' then
			k_return = false //--- KO!
		end if
	else
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "ATTENZIONE la data del DDT è impostata a " + string(kst_tab_sped.data_bolla_out ) + " (sped)~n~r " &
										 + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.set_esito( kst_esito ) 	
			throw kguo_exception
		else

//--- TUTTO OK!			
			k_return = TRUE
			
		end if
	end if
	
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca numero documento per controllo DDT (sped) " 
	kst_esito.esito = kkg_esito.err_logico
	kguo_exception.set_esito( kst_esito ) 	
	throw kguo_exception
end if



return k_return

end function

public function integer get_colli_da_sped (st_tab_arsp ast_tab_arsp) throws uo_exception;//---
//--- Calcola i colli da spedire 
//--- input: st_tab_arsp  id_armo + id_arsp
//--- rit. numero max colli spedibili se ZERO nessun collo da spedire
//--- Lancia Exception
//---
integer k_return=0
st_tab_armo kst_tab_armo, kst_tab_armo_dasped, kst_tab_armo_lav
st_tab_arsp kst_tab_arsp
st_tab_sped kst_tab_sped
st_tab_meca kst_tab_meca
st_tab_meca_qtna kst_tab_meca_qtna
st_tab_certif kst_tab_certif
kuf_armo kuf1_armo 	
kuf_meca_qtna kuf1_meca_qtna
kuf_certif kuf1_certif 
st_esito kst_esito


kst_esito.esito = kkg_esito.ok  
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kuf1_armo = create kuf_armo

//--- get del ID lotto
kst_tab_armo.id_armo = ast_tab_arsp.id_armo
if kst_tab_armo.id_meca > 0 then
else
	kuf1_armo.get_id_meca_da_id_armo(kst_tab_armo)
end if

//--- prima piglio il numero colli da spedire e i colli entrati
kst_tab_armo_dasped.colli_2 = kuf1_armo.get_colli_da_sped(kst_tab_armo)
//--- get colli eventualmente inseriti in questo ddt (es.sono in modifica) x sommarli al totale
kst_tab_arsp.colli = 0
if ast_tab_arsp.id_arsp > 0 then
	kst_tab_arsp.id_arsp = ast_tab_arsp.id_arsp
	kst_tab_arsp.colli = kiuf_sped.get_colli(kst_tab_arsp)
end if
if isnull(kst_tab_arsp.colli) then kst_tab_arsp.colli = 0
kst_tab_armo_dasped.colli_2 += kst_tab_arsp.colli   // somma ai colli da spedire quelli eventuali di questo ddt

//--- se Lotto da Trattare devo fare alcune verifiche tipo la Quarantena
if kuf1_armo.if_da_trattare(kst_tab_armo) then
//--- calcola i colli trattati	
	kst_tab_armo_lav = kst_tab_armo
	kst_tab_armo_lav.colli_2 = kuf1_armo.get_colli_trattati(kst_tab_armo_lav)
	if kst_tab_armo_lav.colli_2 > 0 then // se ci sono colli trattati valuto se ho fatto l'ATTESTATO

//--- se lotto da Trattare verifica presenza Certificato
		kuf1_certif = create kuf_certif
		kst_tab_certif.id_meca = kst_tab_armo.id_meca
		kst_esito = kuf1_certif.get_num_certif(kst_tab_certif)
		if kst_esito.esito = kkg_esito.db_ko then
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
//--- se c'e' Attestato allora OK altrimenti prosegue x verificare se Parzialità consentite....		
		if kst_tab_certif.num_certif > 0 then
		else
			
//--- controlla se DDT possono essere spediti anche se ho ancora da trattare
			if NOT kiuf_sped.if_ddt_lavparziale() then

//--- Se NON posso fare parzialità almeno verifica se Lotto in Quarantena
				kuf1_meca_qtna = create kuf_meca_qtna
				kst_tab_meca_qtna.id_meca = kst_tab_armo.id_meca
				if NOT kuf1_meca_qtna.if_aperta(kst_tab_meca_qtna) then
//--- Se NO in Quarantena allora NON posso spedire e lancio exception
					kst_tab_meca.id = kst_tab_armo.id_meca
					kuf1_armo.get_num_int(kst_tab_meca)
					kst_esito.esito = kkg_esito.no_esecuzione
					kst_esito.sqlerrtext = "Manca l'Attestato, aprire la QUARANTENA se si vuole spedire il Lotto " + string(kst_tab_meca.num_int) + " del " + string(kst_tab_meca.data_int)
					kguo_exception.inizializza( )
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
				end if
			end if 
		end if
	end if
end if


if isnull(kst_tab_armo_dasped.colli_2) then kst_tab_armo_dasped.colli_2 = 0

k_return = kst_tab_armo_dasped.colli_2 + ast_tab_arsp.colli 

return k_return

end function

public function st_esito u_check_dati (ref datastore ads_inp_testa, ref datastore ads_inp_righe) throws uo_exception;//-------------------------------------------------------------------------------------------------------------------------
//--- Controllo dati del DDT di spedizione
//-------------------------------------------------------------------------------------------------------------------------
//--- Controllo formale e logico dei dati inseriti
//--- Ritorna st_esito con esito kkg_esito.ok=tutto OK; 
//---                   	:kkg_esito.err_logico=errore logico; 
//---                 	:kkg_esito.err_formale=errore formale;
//---			         	:kkg_esito.DATI_INSUFF=dati insufficienti; 
//---						:kkg_esito.DB_WRN=OK ma errore non grave
//---                	:kkg_esito.DATI_WRN=OK con degli avvertimenti
//---  sqlerrtext: contiene la descrizione dell'errore   
//-------------------------------------------------------------------------------------------------------------------------
long k_nr_righe
int k_riga, k_ctr, k_righe, k_riga_testa=0
int k_nr_errori 
st_esito kst_esito
st_tab_meca kst_tab_meca
st_tab_sped kst_tab_sped, kst_tab_sped_congruenza 
st_tab_arsp kst_tab_arsp
st_tab_clienti kst_tab_clienti
kuf_armo kuf1_armo
kuf_ausiliari kuf1_ausiliari
kuf_clienti kuf1_clienti
kuf_e1_asn kuf1_e1_asn


try
	
	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kuf1_ausiliari = create kuf_ausiliari
	kuf1_clienti = create kuf_clienti

	k_nr_righe = ads_inp_testa.rowcount()
	k_nr_errori = 0
	k_riga_testa = 1 //ads_inp_testa.getrow()

	kst_tab_sped.clie_2 = ads_inp_testa.getitemnumber( k_riga_testa, "clie_2")
	if kst_tab_sped.clie_2 = 0 then
		kst_esito.esito = kkg_esito.DATI_INSUFF
		kst_esito.sqlerrtext = "Manca il codice Ricevente " + "~n~r" 
		k_nr_errori++
	else
		kst_tab_clienti.codice = kst_tab_sped.clie_2  
		if not kuf1_clienti.if_attivo_attivoparziale(kst_tab_clienti) then
			kst_esito.esito = kkg_esito.KO
			kst_esito.sqlerrtext += "Il Ricevente "+ string(kst_tab_clienti.codice) + "  non è nello stato di Attivo in Anagrafe " + "~n~r" 
			k_nr_errori++
		end if
	end if
	kst_tab_sped.clie_3 = ads_inp_testa.getitemnumber( k_riga_testa, "clie_3")
	if kst_tab_sped.clie_3 = 0 then
		kst_esito.esito = kkg_esito.DATI_INSUFF
		kst_esito.sqlerrtext += "Manca il codice Cliente a cui fattuare " + "~n~r" 
		k_nr_errori++
	else
		kst_tab_clienti.codice = kst_tab_sped.clie_3  
		if not kuf1_clienti.if_attivo(kst_tab_clienti) then
			kst_esito.esito = kkg_esito.KO
			kst_esito.sqlerrtext += "Il Cliente "+ string(kst_tab_clienti.codice) + " non è nello stato di Attivo in Anagrafe " + "~n~r" 
			k_nr_errori++
		end if
	end if
	
	kst_tab_sped.causale = ads_inp_testa.getitemstring( k_riga_testa, "causale")
	if trim(kst_tab_sped.causale) > " " then
	else
		kst_esito.esito = kkg_esito.DATI_INSUFF
		kst_esito.sqlerrtext += "Manca '" + trim(ads_inp_testa.describe("caus_codice_t.text")) + "' ~n~r" 
		k_nr_errori++
	end if
	
	kst_tab_sped.aspetto = ads_inp_testa.getitemstring( k_riga_testa, "aspetto")
	if trim(kst_tab_sped.aspetto) > " " then
	else
		kst_esito.esito = kkg_esito.DATI_INSUFF
		kst_esito.sqlerrtext += "Manca '" + trim(ads_inp_testa.describe("aspetto_t.text")) + "' ~n~r" 
		k_nr_errori++
	end if
	
	kst_tab_sped.cura_trasp = ads_inp_testa.getitemstring( k_riga_testa, "cura_trasp")
	if trim(kst_tab_sped.cura_trasp) = "V" then
		if trim(ads_inp_testa.getitemstring( k_riga_testa, "vett_1")) > " " then
		else
			kst_esito.esito = kkg_esito.DATI_INSUFF
			kst_esito.sqlerrtext += "Manca '" + trim(ads_inp_testa.describe("vett_1_t.text")) + "' ~n~r" 
			k_nr_errori++
		end if
	end if
	
	kst_tab_sped.porto = ads_inp_testa.getitemstring( k_riga_testa, "porto")
	if trim(kst_tab_sped.porto) > " " then
	else
		kst_esito.esito = kkg_esito.DATI_INSUFF
		kst_esito.sqlerrtext += "Manca '" + trim(ads_inp_testa.describe("porto_t.text")) + "' ~n~r" 
		k_nr_errori++
	end if
	
	kst_tab_sped.colli = ads_inp_testa.getitemnumber( k_riga_testa, "colli")
	if kst_tab_sped.colli > 0 then
	else
		kst_esito.esito = kkg_esito.DATI_INSUFF
		kst_esito.sqlerrtext += "Manca '" + trim(ads_inp_testa.describe("colli_t.text")) + "' ~n~r" 
		k_nr_errori++
	end if


//--- Verifica congruenza meca_clie_2 Ricevente del Lotto con il Ricevente del DDT
	kst_tab_sped_congruenza.clie_2 = ads_inp_testa.getitemnumber ( k_riga_testa, "clie_2")
	kst_tab_sped_congruenza.clie_3 = ads_inp_testa.getitemnumber ( k_riga_testa, "meca_clie_2")
	if kst_tab_sped_congruenza.clie_2 <> kst_tab_sped_congruenza.clie_3 then
		if not if_clie_2_alternativo_congruente(kst_tab_sped_congruenza) then 
			k_nr_errori++
			kst_esito.esito = kkg_esito.err_logico
			kst_esito.sqlerrtext += "Ricevente " + string(kst_tab_sped_congruenza.clie_2)   &
								 + " non congruente con il 'Ricevente Lotto diverso' (cod. " + string(kst_tab_sped_congruenza.clie_3) + ") "&
								 + " ~n~r" 
		end if
	end if

//--- controllo se esistono documenti con data maggiore ma numero minore		
	if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.DB_WRN then
		kst_tab_sped.num_bolla_out = ads_inp_testa.getitemnumber(k_riga_testa, "num_bolla_out")
		kst_tab_sped.data_bolla_out = ads_inp_testa.getitemdate(k_riga_testa, "data_bolla_out")
//--- controllo...	
		if NOT if_num_data_congruenti(kst_tab_sped) then
			kst_esito.esito = kkg_esito.DB_WRN
			kst_esito.sqlerrtext += "Data in conflitto con i DDT già emessi " + "~n~r" 
			k_nr_errori++
		end if
	end if

//--- check dettaglio righe ------------------------------------------------------------------------------------------------------------------------------------------------------------

//--- se non ci sono righe di dettaglio (neanche tra le cancellate) allora legge la fattura
	k_nr_righe = ads_inp_righe.rowcount()
	if k_nr_righe = 0 and ads_inp_righe.DeletedCount ( ) = 0 then
		k_nr_errori++
		kst_esito.esito = kkg_esito.err_logico
		kst_esito.sqlerrtext += "Non ci sono righe caricate per questo documento " + "~n~r" 
	end if

	kuf1_armo = create kuf_armo
	k_riga = 1  
	do while (kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.DB_WRN) and k_riga <= k_nr_righe and k_nr_errori < 10

		kst_tab_meca.id = ads_inp_righe.getitemnumber ( k_riga, "id_meca")
		if kst_tab_meca.id > 0 then
			kuf1_armo.get_clie(kst_tab_meca)
		end if

//--- Verifica congruenza clie_2 con le righe Lotto caricate
		if kst_tab_meca.clie_2 > 0 then
			kst_tab_sped.clie_2 = ads_inp_testa.getitemnumber ( k_riga_testa, "meca_clie_2")
			if kst_tab_meca.clie_2 <> kst_tab_sped.clie_2 then 
				k_nr_errori++
				kuf1_armo.get_num_int( kst_tab_meca )  // piglio x informare anche il numero lotto
				kst_esito.esito = kkg_esito.err_logico
				kst_esito.sqlerrtext += "Riga " + string(k_riga, "#####") + ": Ricevente " + string(kst_tab_meca.clie_2) + " del Lotto nr. "  &
									 + string(kst_tab_meca.num_int) + " del " + string(kst_tab_meca.data_int) + " id " + string(kst_tab_meca.id) &
									 + ", diverso da quello indicato nella Testata del DDT, cod. "+ string(kst_tab_sped.clie_2) +" ~n~r" 
			end if
		end if

//--- Verifica congruenza clie_3 
		if kst_tab_meca.clie_3 > 0 then
			kst_tab_sped.clie_3 = ads_inp_testa.getitemnumber ( k_riga_testa, "clie_3")
			if kst_tab_meca.clie_3 <> kst_tab_sped.clie_3 then 
				k_nr_errori++
				if not if_clie_3_alternativo_congruente(kst_tab_meca.clie_1,kst_tab_meca.clie_2, kst_tab_sped.clie_3) then
					kuf1_armo.get_num_int( kst_tab_meca )  // piglio x informare anche il numero lotto
					kst_esito.esito = kkg_esito.err_logico
					kst_esito.sqlerrtext += "Riga " + string(k_riga, "#####") + ": Cliente " + string(kst_tab_sped.clie_3) + " del Lotto nr. "  &
										 + string(kst_tab_meca.num_int) + " del " + string(kst_tab_meca.data_int) + " id " + string(kst_tab_meca.id) &
										 + ", diverso da quello indicato nel DDT, cod. "+ string(kst_tab_meca.clie_3) +" ~n~r" 
				end if
			end if
		end if

//--- Verifica se stato 95
		kst_tab_meca.e1srst = trim(ads_inp_righe.getitemstring( k_riga, "e1srst"))
		if kst_tab_meca.e1srst <> kuf1_e1_asn.kki_status_released then 
			k_nr_errori++
			kst_esito.esito = kkg_esito.DATI_WRN
			kst_tab_meca.num_int = ads_inp_righe.getitemnumber( k_riga, "num_int")
			kst_tab_meca.data_int = ads_inp_righe.getitemdate( k_riga, "data_int")
			kst_esito.sqlerrtext += "Riga " + string(k_riga, "#####") + ": Lotto nr. "  &
									 + string(kst_tab_meca.num_int) + " del " + string(kst_tab_meca.data_int) + " id " + string(kst_tab_meca.id) &
									 + ", non è nello stato di 'RILASCIATO' (" + kuf1_e1_asn.kki_status_released + ") dal Sistema di E1, prego controllare~n~r" 
		end if

//--- riga già spedita?					
		kst_tab_arsp.id_armo = ads_inp_righe.getitemnumber ( k_riga, "id_armo")
		kst_tab_arsp.id_arsp = ads_inp_righe.getitemnumber ( k_riga, "id_arsp")
		if get_colli_da_sped(kst_tab_arsp) > 0 then
		else
			k_nr_errori++
			kuf1_armo.get_num_int( kst_tab_meca )  // piglio x informare anche il numero lotto
			kst_esito.esito = kkg_esito.err_logico
			kst_esito.sqlerrtext += "Riga " + string(k_riga, "#####") +": non ci sono colli da Spedire per questo Lotto nr. " +  &
									 + string(kst_tab_meca.num_int) + " del " + string(kst_tab_meca.data_int) + " id " + string(kst_tab_meca.id) &
									 +" ~n~r" 
		end if		
					
		k_riga++   
	loop



catch (uo_exception kuo_exception1)
	kst_esito = kuo_exception1.get_st_esito()
	k_nr_errori++
	kst_esito.sqlerrtext = "Controllo dati del DDT: '" + trim(kst_esito.sqlerrtext) + "'~n~r" 
			
finally
	if isvalid(kuf1_armo) then destroy kuf1_armo
	if isvalid(kuf1_clienti) then destroy kuf1_clienti

end try

return kst_esito
end function

public function boolean if_clie_2_alternativo_congruente (st_tab_sped kst_tab_sped) throws uo_exception;//--
//---  Controlla che il Ricevente x rircerca Lotto sia Congruente con il Ricevente del DDT
//---
//---  input: st_tab_sped. clie_2 CHE DEVE ESSERE IL RICEVENTE DEL MATERIALE 
//---               + clie_3 CHE DEVE ESSERE IL RICEVENTE INDICATO SUL RIFERIMENTO (NON IL FATT)
//---  otput: boolean = TRUE ricevente congruente tutto OK;    FALSE=KO
//---  se ERRORE lancia un Exception
//---
boolean k_return = false
string k_presente=""
int k_anno
st_esito kst_esito 


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_sped.clie_2 > 0 then 

	select distinct '1'
	   	into :k_presente
            from m_r_f    
            where (m_r_f.clie_3 = :kst_tab_sped.clie_2 or m_r_f.clie_2 = :kst_tab_sped.clie_2 or  m_r_f.clie_1 = :kst_tab_sped.clie_2 )  
				   and (m_r_f.clie_3 = :kst_tab_sped.clie_3 or m_r_f.clie_2 = :kst_tab_sped.clie_3 or  m_r_f.clie_1 = :kst_tab_sped.clie_3 )  
		 using kguo_sqlca_db_magazzino ;
		 
	if sqlca.sqlcode = 0 then
		if k_presente = '1' then
			k_return = true
		end if
	else
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore durante controllo congruenza Ricevente DDT (sped) cod. " + string(kst_tab_sped.clie_2 ) + " con " + string(kst_tab_sped.clie_3 ) + "~n~r " &
										 + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.set_esito( kst_esito ) 	
			throw kguo_exception
			
		end if
	end if
	
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca codice ricevente per controllo DDT (sped) " 
	kst_esito.esito = kkg_esito.err_logico
	kguo_exception.set_esito( kst_esito ) 	
	throw kguo_exception
end if



return k_return

end function

public function boolean if_clie_3_alternativo_congruente (long a_clie_1, long a_clie_2, long a_clie_3) throws uo_exception;//--
//---  Controlla che il Fatturato diverso da quello impostato sul Lotto sia Congruente con il Mandante del DDT
//---
//---  input:  clie_1 CHE DEVE ESSERE IL MANDANTE INDICATO SUL LOTTO
//---            clie_2 CHE DEVE ESSERE IL RICEVENTE IMMESSO
//---            clie_3 CHE DEVE ESSERE IL CODICE IMMESSO
//---  otput: boolean = TRUE congruente tutto OK;    FALSE=KO
//---  se ERRORE lancia un Exception
//---
boolean k_return = false
string k_presente=""
int k_anno
st_esito kst_esito 


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if a_clie_1 > 0 and a_clie_2 > 0 and a_clie_3 > 0 then 

//--- se il cliente è sempre lo stesso OK!
	if a_clie_1 = a_clie_2 and a_clie_2 = a_clie_3 then 

		k_return = true
		
	else
		select distinct '1'
				into :k_presente
					from m_r_f    
					where (m_r_f.clie_1 = :a_clie_1 and m_r_f.clie_2 = :a_clie_2)  
						and (m_r_f.clie_3 = :a_clie_3)
			 using kguo_sqlca_db_magazzino ;
			 
		if sqlca.sqlcode = 0 then
			if k_presente = '1' then
				k_return = true
			end if
		else
			if sqlca.sqlcode < 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore durante controllo congruenza Fatturato DDT (sped) Mand/Ric/Fatt .:" + string(a_clie_1) + " / "+ string(a_clie_2 )+ " / "+ string(a_clie_3 ) + "~n~r " &
											 + trim(SQLCA.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.set_esito( kst_esito ) 	
				throw kguo_exception
				
			end if
		end if
	end if		
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca codice ricevente per controllo DDT (sped) " 
	kst_esito.esito = kkg_esito.err_logico
	kguo_exception.set_esito( kst_esito ) 	
	throw kguo_exception
end if



return k_return

end function

on kuf_sped_checkmappa.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_sped_checkmappa.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//
	kiuf_sped = create kuf_sped
	

end event

