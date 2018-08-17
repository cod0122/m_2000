$PBExportHeader$kuf_armo_checkmappa.sru
forward
global type kuf_armo_checkmappa from nonvisualobject
end type
end forward

global type kuf_armo_checkmappa from nonvisualobject
end type
global kuf_armo_checkmappa kuf_armo_checkmappa

type variables
//
private kuf_sped kiuf_sped 
datastore kids_testa, kids_righe
end variables

forward prototypes
public function st_esito u_check_dati (ref datastore ads_inp_testa, ref datastore ads_inp_righe) throws uo_exception
private function integer get_nr_colli () throws uo_exception
private function boolean if_anagrafiche_ok (ref st_tab_meca ast_tab_meca) throws uo_exception
private function boolean if_contratto_congruente () throws uo_exception
private function boolean if_contratto_scaduto () throws uo_exception
private function boolean if_bolla_in_ok (st_tab_meca ast_tab_meca) throws uo_exception
private function integer get_nr_colli_delete () throws uo_exception
private function long if_num_data_congruenti (st_tab_meca kst_tab_meca) throws uo_exception
public function boolean if_barcode_da_gen (st_tab_meca ast_tab_meca) throws uo_exception
private function boolean if_articoli_nocontratto () throws uo_exception
public function boolean if_carico_nodose ()
end prototypes

public function st_esito u_check_dati (ref datastore ads_inp_testa, ref datastore ads_inp_righe) throws uo_exception;//-------------------------------------------------------------------------------------------------------------------------
//--- Controllo dati del LOTTO
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
long k_nr_barcode=0, k_nr_colli=0, k_nr_colli_delete=0
st_esito kst_esito, kst_esito1
st_tab_meca kst_tab_meca, kst_tab_meca_data
st_tab_armo kst_tab_armo
st_tab_listino kst_tab_listino
st_tab_barcode kst_tab_barcode
st_tab_contratti kst_tab_contratti
kuf_armo kuf1_armo
kuf_barcode kuf1_barcode
kuf_listino kuf1_listino


try
	setpointer(kkg.pointer_attesa) 
	
	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kuf1_listino = create kuf_listino
	kids_testa = create datastore
	kids_righe = create datastore
	kuf1_armo = create kuf_armo

	k_nr_righe = ads_inp_testa.rowcount()
	k_nr_errori = 0
	k_riga_testa = ads_inp_testa.getrow()
	kids_testa.dataobject = ads_inp_testa.dataobject
	ads_inp_testa.rowscopy(1, k_nr_righe, primary!, kids_testa, 1, primary!)
	kids_righe.dataobject = ads_inp_righe.dataobject
	ads_inp_righe.rowscopy(1, ads_inp_righe.rowcount(), primary!, kids_righe, 1, primary!)
	ads_inp_righe.rowscopy(1, ads_inp_righe.rowcount(), delete!, kids_righe, 1, delete!)
	
//--- raccolgo qlc dato che mi servirà
	kst_tab_meca.stato = ads_inp_testa.getitemnumber( k_riga_testa, "stato")
	kst_tab_meca.id = ads_inp_testa.getitemnumber(k_riga_testa, "id_meca")
	kst_tab_meca.clie_1 = ads_inp_testa.getitemnumber( k_riga_testa, "clie_1")
	kst_tab_meca.clie_2 = ads_inp_testa.getitemnumber( k_riga_testa, "clie_2")
	kst_tab_meca.clie_3 = ads_inp_testa.getitemnumber( k_riga_testa, "clie_3")
	kst_tab_meca.num_bolla_in = ads_inp_testa.getitemstring( k_riga_testa, "num_bolla_in")
	kst_tab_meca.data_bolla_in = ads_inp_testa.getitemdate( k_riga_testa, "data_bolla_in")
	kst_tab_meca.area_mag = ads_inp_testa.getitemstring( k_riga_testa, "area_mag")
	kst_tab_meca.num_int = ads_inp_testa.getitemnumber(k_riga_testa, "num_int")
	kst_tab_meca.data_int = ads_inp_testa.getitemdate(k_riga_testa, "data_int")
	kst_tab_meca.data_ent = ads_inp_testa.getitemdatetime(k_riga_testa, "data_ent")

	kuf1_armo.if_isnull_meca(kst_tab_meca)
	
//--- controllo se esistono documenti con data maggiore ma numero minore		
	if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.DB_WRN or kst_esito.esito = kkg_esito.DATI_WRN then
//--- controllo...	
		if kst_tab_meca.id > 0 then
		else
			kst_tab_meca_data.id = if_num_data_congruenti(kst_tab_meca)
			if kst_tab_meca_data.id > 0  then
				kst_esito.esito = kkg_esito.DATI_WRN
				if trim(kst_esito.SQLErrText) > " " then kst_esito.SQLErrText += "~n~r"  // aggiungo a capo se necessario
				kst_esito.sqlerrtext += "Data in conflitto con Documenti già emessi in precedenza, ad esempio per il Lotto con ID = " + string(kst_tab_meca_data.id) 
				k_nr_errori++
			end if
		end if
	end if

//--- Controllo dati LOTTO
	try
		if_bolla_in_ok(kst_tab_meca)

	catch (uo_exception kuo_exception)
		kst_esito1 = kuo_exception.get_st_esito()
		if kst_esito.esito = kkg_esito.ok or (kst_esito1.esito <> kkg_esito.ok and kst_esito1.esito <> kkg_esito.DB_WRN and kst_esito1.esito <> kkg_esito.DATI_WRN) then  // se ho preso ERR GRAVE allora aggiorna errore
			kst_esito.esito = kst_esito1.esito
		end if
		if trim(kst_esito.SQLErrText) > " " then kst_esito.SQLErrText += "~n~r"  // aggiungo a capo se necessario
		kst_esito.sqlerrtext += kst_esito1.sqlerrtext 
	end try

//--- Controllo che non ci sia valorizzata solo la Descrizione e non il codice blocco (19-06-2017)
	if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.DB_WRN or kst_esito.esito = kkg_esito.DATI_WRN then
//--- controllo...	
//		if kst_tab_meca.id > 0 then
//		else
			if ads_inp_testa.getitemnumber(k_riga_testa, "meca_blk_id_meca_causale") > 0 then
			else
				if trim(ads_inp_testa.getitemstring(k_riga_testa, "meca_blk_descrizione")) > " " then 
					kst_esito.esito = kkg_esito.DATI_INSUFF
					if trim(kst_esito.SQLErrText) > " " then kst_esito.SQLErrText += "~n~r"  // aggiungo a capo se necessario
					kst_esito.sqlerrtext += "Attenzione in presenza della descrizione è necessario caricare anche il codice Blocco nel campo '" + trim(ads_inp_testa.describe("meca_blk_id_meca_causale_t.text")) + "' "
					k_nr_errori++
				end if
			end if
		end if
//	end if

//--- Se STATO di BLOCCATO evito alcuni controlli 
	if kst_tab_meca.stato <> kuf1_armo.ki_meca_stato_blk then

//--- Controllo delle anagrafiche caricate
		try
			if_anagrafiche_ok(kst_tab_meca)

		catch (uo_exception kuo1_exception)
			kst_esito1 = kuo1_exception.get_st_esito()
			if kst_esito.esito = kkg_esito.ok or (kst_esito1.esito <> kkg_esito.ok and kst_esito1.esito <> kkg_esito.DB_WRN and kst_esito1.esito <> kkg_esito.DATI_WRN) then  // se ho preso ERR GRAVE allora aggiorna errore
				kst_esito.esito = kst_esito1.esito
			end if
			if trim(kst_esito.SQLErrText) > " " then kst_esito.SQLErrText += "~n~r"  // aggiungo a capo se necessario
			kst_esito.sqlerrtext += kst_esito1.sqlerrtext 
		end try

//--- Controlla i CONTRATTI
		try
			kst_tab_meca.contratto = ads_inp_testa.getitemnumber( k_riga_testa, "contratto")
			if kst_tab_meca.contratto > 0 then
				if_contratto_scaduto( )  
				if_contratto_congruente( )  
			else
				if not if_articoli_nocontratto( ) then
					kst_esito.esito = kkg_esito.err_logico
					if trim(kst_esito.SQLErrText) > " " then kst_esito.SQLErrText += "~n~r"  // aggiungo a capo se necessario
					kst_esito.sqlerrtext = "Righe Articolo caricate senza il codice Contratto! "
					k_nr_errori++
//				else
//					kst_esito.esito = kkg_esito.DATI_WRN
//					if trim(kst_esito.SQLErrText) > " " then kst_esito.SQLErrText += "~n~r"  // aggiungo a capo se necessario
//					kst_esito.sqlerrtext += "Manca '" + trim(ads_inp_testa.describe("gb_contratto.text")) + "' "
//					k_nr_errori++
				end if
			end if

//--- Controlla DATA ENTRATA LOTTO
			if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.DB_WRN or kst_esito.esito = kkg_esito.DATI_WRN then
				if date(kst_tab_meca.data_ent) > kkg.data_zero and date(kst_tab_meca.data_ent) < kst_tab_meca.data_int then
					kst_esito.esito = kkg_esito.DATI_WRN
					if trim(kst_esito.SQLErrText) > " " then kst_esito.SQLErrText += "~n~r"  // aggiungo a capo se necessario
					kst_esito.sqlerrtext += "Data di Entrata " + string(kst_tab_meca.data_ent, "dd.mmm.yy") + " è minore della data Lotto " + string(kst_tab_meca.data_int, "dd.mmm.yy")
					k_nr_errori++
				end if
			end if

//--- Controlla DATA di CONSEGNA
//			kst_tab_meca.consegna_data = ads_inp_testa.getitemdate( k_riga_testa, "consegna_data")
//			if kst_tab_meca.consegna_data > kguo_g.get_datazero( )  then
//				if kst_tab_meca.consegna_data < kst_tab_meca.data_int  then
//					kst_esito.esito = kkg_esito.err_logico
//					if trim(kst_esito.SQLErrText) > " " then kst_esito.SQLErrText += "~n~r"  // aggiungo a capo se necessario
//					kst_esito.sqlerrtext = "Data di consegna " + string(kst_tab_meca.consegna_data) + " minore della data del Lotto! "
//					k_nr_errori++
//				end if
//			else
//				if kuf1_base.if_e1_enabled( ) then  // E1 richiede la data di consegna
//					if trim(kst_esito.SQLErrText) > " " then kst_esito.SQLErrText += "~n~r"  // aggiungo a capo se necessario
//					kst_esito.sqlerrtext = "Manca '" + trim(ads_inp_testa.describe("gb_consegna_data.text")) + "' " 
//					k_nr_errori++
//				end if				
//			end if

			
		catch (uo_exception kuo2_exception)
			kst_esito1 = kuo2_exception.get_st_esito()
			if kst_esito.esito = kkg_esito.ok then 
				if (kst_esito1.esito <> kkg_esito.ok and kst_esito1.esito <> kkg_esito.DB_WRN and kst_esito1.esito <> kkg_esito.DATI_WRN) then  // se ho preso ERR GRAVE allora aggiorna errore
					kst_esito.esito = kst_esito1.esito
				end if
			end if
			kst_esito.sqlerrtext += kst_esito1.sqlerrtext + "~n~r" 
		end try
	
////--- differenti barcode da stampare?
//		if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.DB_WRN or kst_esito.esito = kkg_esito.DATI_WRN then  // se NON ho ERR GRAVE allora controllo
//			if kst_tab_meca.id > 0 then
//				kuf1_barcode = create kuf_barcode
//				kst_tab_barcode.id_meca = kst_tab_meca.id
//				k_nr_colli = get_nr_colli( )
//				k_nr_colli_delete = get_nr_colli_delete( )  // get del nr colli di righe rimosse dal dw
//				k_nr_barcode = kuf1_barcode.get_nr_barcode(kst_tab_barcode)
//				k_nr_barcode = k_nr_barcode - k_nr_colli_delete // tolgo dal conteggio dei barcode quelli che poi inevitabilmente saranno distrutti in quanto parte di righe cancellate
//				if k_nr_barcode <> k_nr_colli then
//					kst_esito.esito = kkg_esito.DATI_WRN
//					if k_nr_barcode > 0 then
//						kst_esito.sqlerrtext += "ATTENZIONE: ricorda di RIGENERARE i barcode in quanto il numero colli " &
//										+ string(k_nr_colli) + " risulta diverso dagli attuali "+ string(k_nr_barcode) +  " barcode!" &
//										 +" ~n~r" 
//					else
//						kst_esito.sqlerrtext += "ATTENZIONE: ricorda di RIGENERARE i barcode per i nuovi " &
//										+ string(k_nr_colli) + " colli caricati!" &
//										 +" ~n~r" 
//					end if
//				end if
//			end if
//		end if
	end if
	

//--- check dettaglio righe ------------------------------------------------------------------------------------------------------------------------------------------------------------
//
//--- se non ci sono righe di dettaglio (neanche tra le cancellate) allora legge la fattura
	k_nr_righe = ads_inp_righe.rowcount()
//	if k_nr_righe = 0 and ads_inp_righe.DeletedCount ( ) = 0 then
//		k_nr_errori++
//		kst_esito.esito = kkg_esito.err_logico
//		kst_esito.sqlerrtext += "Non ci sono righe caricate per questo documento " + "~n~r" 
//	end if
//
	k_riga = 1  
	do while (kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.DB_WRN or kst_esito.esito = kkg_esito.DATI_WRN) and k_riga <= k_nr_righe and k_nr_errori < 10

//--- Verifica Mt CUBI
		kst_tab_armo.alt_2 = ads_inp_righe.getitemnumber(k_riga, "alt_2")
		kst_tab_armo.m_cubi = ads_inp_righe.getitemnumber(k_riga, "m_cubi")
		if kst_tab_armo.m_cubi > 0 then
			if kst_tab_armo.alt_2 > 0 then
				// tutto OK
			else
				kst_esito.esito = kkg_esito.DATI_WRN
				if trim(kst_esito.SQLErrText) > " " then kst_esito.SQLErrText += "~n~r"  // aggiungo a capo se necessario
				kst_esito.sqlerrtext += "Riga Lotto n. " + string(k_riga) + ": Altezza pallet a ZERO ma Metri Cubi indicati maggiore di zero! " 
				k_nr_errori++
			end if
		else
			if kst_tab_armo.alt_2 > 0 then // m_cubi a ZERO ma altezza valorizzata
				kst_esito.esito = kkg_esito.err_logico
				if trim(kst_esito.SQLErrText) > " " then kst_esito.SQLErrText += "~n~r"  // aggiungo a capo se necessario
				kst_esito.sqlerrtext += "Riga Lotto n. " + string(k_riga) + ": Indicati Metri Cubi a ZERO ma il Pallet ha una altezza maggiore di zero! "
				k_nr_errori++
			end if
		end if

//--- Verifica PESO
		kst_tab_armo.alt_2 = ads_inp_righe.getitemnumber(k_riga, "alt_2")
		kst_tab_armo.peso_kg = ads_inp_righe.getitemnumber(k_riga, "peso_kg")
		if kst_tab_armo.peso_kg > 0 then
			if kst_tab_armo.alt_2 > 0 then
				// tutto OK
			else
				kst_esito.esito = kkg_esito.DATI_WRN
				if trim(kst_esito.SQLErrText) > " " then kst_esito.SQLErrText += "~n~r"  // aggiungo a capo se necessario
				kst_esito.sqlerrtext += "Riga Lotto n. " + string(k_riga) + ": Altezza pallet a ZERO ma PESO indicato maggiore di zero! " 
				k_nr_errori++
			end if
		else
			if kst_tab_armo.alt_2 > 0 then // m_cubi a ZERO ma altezza valorizzata
				kst_esito.esito = kkg_esito.err_logico
				if trim(kst_esito.SQLErrText) > " " then kst_esito.SQLErrText += "~n~r"  // aggiungo a capo se necessario
				kst_esito.sqlerrtext += "Riga Lotto n. " + string(k_riga) + ": Indicato PESO a ZERO ma il Pallet ha una altezza maggiore di zero! " 
				k_nr_errori++
			end if
		end if

//--- Verifica DIMENSIONI e PESO > 0 se da TRATTARE
		kst_tab_armo.larg_2 = ads_inp_righe.getitemnumber(k_riga, "larg_2")
		kst_tab_armo.lung_2 = ads_inp_righe.getitemnumber(k_riga, "lung_2")
		kst_tab_armo.alt_2 = ads_inp_righe.getitemnumber(k_riga, "alt_2")
		kst_tab_armo.peso_kg = ads_inp_righe.getitemnumber(k_riga, "peso_kg")
		if kst_tab_armo.larg_2 > 0 and kst_tab_armo.lung_2 > 0 and kst_tab_armo.alt_2 > 0 and kst_tab_armo.peso_kg > 0 then
		else
			kst_tab_armo.magazzino = ads_inp_righe.getitemnumber(k_riga, "magazzino")
			if kuf1_armo.if_magazzino_da_trattare(kst_tab_armo) then
				kst_esito.esito = kkg_esito.err_logico
				if trim(kst_esito.SQLErrText) > " " then kst_esito.SQLErrText += "~n~r"  // aggiungo a capo se necessario
				kst_esito.sqlerrtext += "Riga Lotto n. " + string(k_riga) + ": Pallet da Trattare, Dimensioni (larg-lung-alt) e Peso devono essere maggiori di ZERO! " 
				k_nr_errori++
			end if
		end if

		if kguo_g.if_e1_enabled( ) then  // E1 richiede il codice contratto del loro sistema
			kst_tab_listino.id = ads_inp_righe.getitemnumber( k_riga, "id_listino")
			if kst_tab_listino.id > 0 then
				kst_tab_listino.e1litm = kuf1_listino.get_e1litm(kst_tab_listino)
				if trim(kst_tab_listino.e1litm) > " " then
				else
					if trim(kst_esito.SQLErrText) > " " then kst_esito.SQLErrText += "~n~r"  // aggiungo a capo se necessario
					kst_esito.sqlerrtext = "Manca il codice di E-ONE su Listino. E' necessario censirlo in archivio! "
					k_nr_errori++
				end if
			end if
		end if

		k_riga++   
	loop



catch (uo_exception kuo3_exception)
	kst_esito = kuo3_exception.get_st_esito()
	k_nr_errori++
	if trim(kst_esito.SQLErrText) > " " then kst_esito.SQLErrText += "~n~r"  // aggiungo a capo se necessario
	kst_esito.sqlerrtext = "Esito Controlli: " + trim(kst_esito.sqlerrtext) + " "
			
finally
	setpointer(kkg.pointer_default) 
	if isvalid(kuf1_armo) then destroy kuf1_armo
	if isvalid(kuf1_listino) then destroy kuf1_listino

end try

return kst_esito
end function

private function integer get_nr_colli () throws uo_exception;//--
//---  Torna il nr di colli x barcode
//---
//---  input: datastore testata e righe
//---  otput: boolean TRUE = OK
//---  se ERRORE lancia un Exception
//---
int k_return = 0
long k_righe=0, k_riga=0


	k_righe = kids_righe.rowcount()

//--- cicla x controllare le righe
	for k_riga = 1 to k_righe
		if kids_righe.getitemnumber(k_riga, "magazzino") <> 1 and trim(kids_righe.getitemstring(k_riga, "cod_sl_pt")) > " " then
			k_return += kids_righe.getitemnumber(k_riga, "colli_2")
		end if
	end for




return k_return

end function

private function boolean if_anagrafiche_ok (ref st_tab_meca ast_tab_meca) throws uo_exception;//======================================================================
//--- Controllo dati Mandante/Ricevente/Cliente
//======================================================================
boolean k_return = false
int k_nr_errori 
st_esito kst_esito
st_tab_clienti kst_tab_clienti
kuf_clienti kuf1_clienti

try
	
	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kuf1_clienti = create kuf_clienti
	
	if ast_tab_meca.clie_1 = 0 then
		kst_esito.esito = kkg_esito.DATI_INSUFF
		if trim(kst_esito.SQLErrText) > " " then kst_esito.SQLErrText += "~n~r"  // aggiungo a capo se necessario
		kst_esito.sqlerrtext = "Manca il Mandante della merce "
		kguo_exception.inizializza()
		kguo_exception.set_esito( kst_esito ) 	
		throw kguo_exception
	else
		kst_tab_clienti.codice = ast_tab_meca.clie_1
		if not kuf1_clienti.if_attivo_attivoparziale(kst_tab_clienti) then
			kst_esito.esito = kkg_esito.KO
			if trim(kst_esito.SQLErrText) > " " then kst_esito.SQLErrText += "~n~r"  // aggiungo a capo se necessario
			kst_esito.sqlerrtext += "Il Mandante "+ string(kst_tab_clienti.codice) + "  non è nello stato di Attivo in Anagrafe " 
			kguo_exception.inizializza()
			kguo_exception.set_esito( kst_esito ) 	
			throw kguo_exception
		end if
	end if

	if NOT if_carico_nodose() then  // Ricevente e fatturato devono esserci x forza?
		if ast_tab_meca.clie_2 = 0 then
			kst_esito.esito = kkg_esito.DATI_INSUFF
			if trim(kst_esito.SQLErrText) > " " then kst_esito.SQLErrText += "~n~r"  // aggiungo a capo se necessario
			kst_esito.sqlerrtext = "Manca il Ricevente della merce " 
			kguo_exception.inizializza()
			kguo_exception.set_esito( kst_esito ) 	
		else
			kst_tab_clienti.codice = ast_tab_meca.clie_2
			if not kuf1_clienti.if_attivo_attivoparziale(kst_tab_clienti) then
				kst_esito.esito = kkg_esito.KO
				if trim(kst_esito.SQLErrText) > " " then kst_esito.SQLErrText += "~n~r"  // aggiungo a capo se necessario
				kst_esito.sqlerrtext += "Il Ricevente "+ string(kst_tab_clienti.codice) + "  non è nello stato di Attivo in Anagrafe " 
				kguo_exception.inizializza()
				kguo_exception.set_esito( kst_esito ) 	
				throw kguo_exception
			end if
		end if
		if ast_tab_meca.clie_3 = 0 then
			kst_esito.esito = kkg_esito.DATI_INSUFF
			if trim(kst_esito.SQLErrText) > " " then kst_esito.SQLErrText += "~n~r"  // aggiungo a capo se necessario
			kst_esito.sqlerrtext += "Manca il Cliente a cui fattuare " 
			kguo_exception.inizializza()
			kguo_exception.set_esito( kst_esito ) 	
		else
			kst_tab_clienti.codice = ast_tab_meca.clie_3
			if not kuf1_clienti.if_attivo(kst_tab_clienti) then
				kst_esito.esito = kkg_esito.KO
				if trim(kst_esito.SQLErrText) > " " then kst_esito.SQLErrText += "~n~r"  // aggiungo a capo se necessario
				kst_esito.sqlerrtext += "Il Cliente "+ string(kst_tab_clienti.codice) + "  non è nello stato di Attivo in Anagrafe " 
				kguo_exception.inizializza()
				kguo_exception.set_esito( kst_esito ) 	
				throw kguo_exception
			end if
		end if
	end if
	if kst_esito.esito <> kkg_esito.ok then
		throw kguo_exception
	end if

//--- TUTTO OK!			
	k_return = TRUE

catch (uo_exception kuo_exception1)
	kst_esito = kuo_exception1.get_st_esito()
	kst_esito.sqlerrtext = "Esito Controlli anagrafiche: " + trim(kst_esito.sqlerrtext) + " " 
	kguo_exception.inizializza()
	kguo_exception.set_esito( kst_esito ) 	
	throw kguo_exception
			
finally
	if isvalid(kuf1_clienti) then destroy kuf1_clienti

end try
	

return k_return 
end function

private function boolean if_contratto_congruente () throws uo_exception;//--
//---  Controlla che le righe CONTRATTO siano congruenti con quello indicato in TESTATA
//---
//---  input: datastore testata e righe
//---  otput: boolean TRUE = OK
//---  se ERRORE lancia un Exception
//---
boolean k_return = false
int k_righe = 0, k_riga = 0
st_tab_meca kst_tab_meca
st_tab_armo kst_tab_armo
st_tab_listino kst_tab_listino
st_tab_contratti kst_tab_contratti
st_esito kst_esito 
kuf_listino kuf1_listino
kuf_contratti kuf1_contratti


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kids_testa.rowcount() > 0 then

	kst_tab_meca.contratto = kids_testa.getitemnumber(1, "contratto")
	if isnull(kst_tab_meca.contratto) then kst_tab_meca.contratto = 0
	
	k_righe = kids_righe.rowcount()

	kuf1_listino = create kuf_listino
	kuf1_contratti = create kuf_contratti

//--- cicla x controllare le righe
	for k_riga = 1 to k_righe
		kst_tab_listino.id = kids_righe.getitemnumber(k_riga, "id_listino")
		if kst_tab_listino.id > 0 then
			kst_tab_listino.contratto = kuf1_listino.get_contratto(kst_tab_listino)			
//--- i contratti testata e riga devono essere uguali
			if kst_tab_listino.contratto > 0 then
				if kst_tab_listino.contratto <> kst_tab_meca.contratto then
					kst_esito.esito = kkg_esito.err_logico
					if trim(kst_esito.SQLErrText) > " " then kst_esito.SQLErrText += "~n~r"  // aggiungo a capo se necessario
					kst_esito.sqlerrtext = "Articolo alla riga " + string(k_riga) + " appartiene ad un Contratto differente (" + string(kst_tab_listino.contratto) + ")!"
					kguo_exception.inizializza()
					kguo_exception.set_esito( kst_esito ) 	
					throw kguo_exception
				end if
//--- il contratti testata e riga devono essere uguali
				kst_tab_meca.data_int = kids_testa.getitemdate(1, "data_int")
				kst_tab_contratti.codice = kst_tab_listino.contratto
				kst_tab_contratti.data_scad = kuf1_contratti.get_data_scad(kst_tab_contratti)
				if kst_tab_contratti.data_scad < kst_tab_meca.data_int then
					kst_esito.esito = kkg_esito.err_logico
					if trim(kst_esito.SQLErrText) > " " then kst_esito.SQLErrText += "~n~r"  // aggiungo a capo se necessario
					kst_esito.sqlerrtext = "Articolo alla riga " + string(k_riga) + " appartiene a un Contratto scaduto il " + string(kst_tab_contratti.data_scad) + "!"
					kguo_exception.inizializza()
					kguo_exception.set_esito( kst_esito ) 	
					throw kguo_exception
				end if
			end if
		end if
	end for

//--- TUTTO OK!			
	k_return = TRUE
	
else
	kst_esito.sqlcode = 0
	if trim(kst_esito.SQLErrText) > " " then kst_esito.SQLErrText += "~n~r"  // aggiungo a capo se necessario
	kst_esito.SQLErrText = "Manca testata del documento per fare il controllo " 
	kst_esito.esito = kkg_esito.err_logico
	kguo_exception.set_esito( kst_esito ) 	
	throw kguo_exception
end if



return k_return

end function

private function boolean if_contratto_scaduto () throws uo_exception;//--
//---  Controlla scadenza CONTRATTO 
//---
//---  input: datastore della testata 
//---  otput: boolean TRUE = OK
//---  se ERRORE lancia un Exception
//---
boolean k_return = false
st_tab_meca kst_tab_meca
st_tab_contratti kst_tab_contratti
st_esito kst_esito 
kuf_contratti kuf1_contratti


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kids_testa.rowcount() > 0 then

	kst_tab_meca.contratto = kids_testa.getitemnumber(1, "contratto")
	kst_tab_meca.data_int = kids_testa.getitemdate(1, "data_int")

	kuf1_contratti = create kuf_contratti

//--- il contratto non deve essere scaduto
	if kst_tab_meca.contratto > 0 then
		kst_tab_contratti.codice = kst_tab_meca.contratto
		kst_tab_contratti.data_scad = kuf1_contratti.get_data_scad(kst_tab_contratti)
		if kst_tab_contratti.data_scad < kst_tab_meca.data_int then
			kst_esito.esito = kkg_esito.err_logico
			if trim(kst_esito.SQLErrText) > " " then kst_esito.SQLErrText += "~n~r"  // aggiungo a capo se necessario
			kst_esito.sqlerrtext = "Contratto " + string(kst_tab_meca.contratto) + " scaduto il " + string(kst_tab_contratti.data_scad) + "!"
			kguo_exception.inizializza()
			kguo_exception.set_esito( kst_esito ) 	
			throw kguo_exception
		end if
	end if
//--- il Capitolato non deve essere scaduto
	kst_tab_contratti.sc_cf = kids_testa.getitemstring(1, "contratti_sc_cf")
	if trim(kst_tab_contratti.sc_cf) > " " then
		kst_tab_contratti.data_scad = kuf1_contratti.get_sc_cf_data_scad(kst_tab_contratti)
		if kst_tab_contratti.data_scad < kst_tab_meca.data_int then
			kst_esito.esito = kkg_esito.err_logico
			if trim(kst_esito.SQLErrText) > " " then kst_esito.SQLErrText += "~n~r"  // aggiungo a capo se necessario
			kst_esito.sqlerrtext = "Capitolato " + trim(kst_tab_contratti.sc_cf) + " scaduto il " + string(kst_tab_contratti.data_scad) + "!"
			kguo_exception.inizializza()
			kguo_exception.set_esito( kst_esito ) 	
			throw kguo_exception
		end if
	end if

//--- TUTTO OK!			
	k_return = TRUE
	
else
	kst_esito.sqlcode = 0
	if trim(kst_esito.SQLErrText) > " " then kst_esito.SQLErrText += "~n~r"  // aggiungo a capo se necessario
	kst_esito.SQLErrText = "Manca testata del documento per fare il controllo " 
	kst_esito.esito = kkg_esito.err_logico
	kguo_exception.set_esito( kst_esito ) 	
	throw kguo_exception
end if



return k_return

end function

private function boolean if_bolla_in_ok (st_tab_meca ast_tab_meca) throws uo_exception;//======================================================================
//--- Controllo dati Bolla
//======================================================================
boolean k_return = false
long k_rc=0, k_num_int
int k_anno 
st_esito kst_esito

	
	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	

	if trim(ast_tab_meca.num_bolla_in) > " " then
	else
		kst_esito.esito = kkg_esito.DATI_INSUFF
		if trim(kst_esito.SQLErrText) > " " then kst_esito.SQLErrText += "~n~r"  // aggiungo a capo se necessario
		kst_esito.sqlerrtext = "Manca 'numero DDT' " 
		kguo_exception.inizializza()
		kguo_exception.set_esito( kst_esito ) 	
		throw kguo_exception
	end if
	if ast_tab_meca.data_bolla_in > kkg.data_no then
	else
		kst_esito.esito = kkg_esito.DATI_INSUFF
		if trim(kst_esito.SQLErrText) > " " then kst_esito.SQLErrText += "~n~r"  // aggiungo a capo se necessario
		kst_esito.sqlerrtext = "Manca 'data DDT' " 
		kguo_exception.inizializza()
		kguo_exception.set_esito( kst_esito ) 	
		throw kguo_exception
	end if

	k_anno = year(ast_tab_meca.data_bolla_in)

//--- controlla che non ci sia già un documento con lo stesso NUMERO DDT  
	select max (meca.num_int)
		into :k_num_int
		from meca 
		where meca.clie_1 = :ast_tab_meca.clie_1
		    and meca.num_bolla_in = :ast_tab_meca.num_bolla_in and year(meca.data_bolla_in) = :k_anno
			and meca.id <> :ast_tab_meca.id
		using kguo_sqlca_db_magazzino;
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.esito = kkg_esito.db_ko
		if trim(kst_esito.SQLErrText) > " " then kst_esito.SQLErrText += "~n~r"  // aggiungo a capo se necessario
		kst_esito.sqlerrtext = "Errore in lettura numero DDT di entrata Lotto " +  trim(kguo_sqlca_db_magazzino.sqlerrtext)
		kguo_exception.inizializza()
		kguo_exception.set_esito( kst_esito ) 	
		throw kguo_exception
	end if
	if k_num_int > 0 then
		kst_esito.esito = kkg_esito.DATI_WRN
		if trim(kst_esito.SQLErrText) > " " then kst_esito.SQLErrText += "~n~r"  // aggiungo a capo se necessario
		kst_esito.sqlerrtext = "Attenzione: numero DDT " + string(ast_tab_meca.num_bolla_in) + " trovato anche nel LOTTO n. " + string(k_num_int) 
		kguo_exception.inizializza()
		kguo_exception.set_esito( kst_esito ) 	
	end if


	if NOT if_carico_nodose() then  // area magazzino deve esserci x forza?
		if trim(ast_tab_meca.area_mag) > " " then
		else
			kst_esito.esito = kkg_esito.DATI_WRN
			if trim(kst_esito.SQLErrText) > " " then kst_esito.SQLErrText += "~n~r"  // aggiungo a capo se necessario
			kst_esito.sqlerrtext += "Manca 'Area Magazzino'" 
			kguo_exception.inizializza()
			kguo_exception.set_esito( kst_esito ) 	
		end if
	end if
	
	if kst_esito.esito <> kkg_esito.ok then
		throw kguo_exception
	end if

//--- TUTTO OK!			
	k_return = TRUE
	

return k_return 
end function

private function integer get_nr_colli_delete () throws uo_exception;//--
//---  Torna il nr di colli x barcode di righe rimosse dal dw
//---
//---  input: datastore testata e righe
//---  otput: boolean TRUE = OK
//---  se ERRORE lancia un Exception
//---
int k_return = 0
long k_righe=0, k_riga=0


	k_righe = kids_righe.DeletedCount()

//--- cicla x controllare le righe
	for k_riga = 1 to k_righe
		if kids_righe.getitemnumber(k_riga, "magazzino", delete!, false) <> 1 and trim(kids_righe.getitemstring(k_riga, "cod_sl_pt", delete!, false)) > " " then
			k_return += kids_righe.getitemnumber(k_riga, "colli_2", delete!, false)
		end if
	end for




return k_return

end function

private function long if_num_data_congruenti (st_tab_meca kst_tab_meca) throws uo_exception;//--
//---  Controlla che Num+Data lotto siano congruenti
//---
//---  input: st_tab_meca.num_int e data_int 
//---  otput: id_meca: 0 = LOTTO congruente;  > 0 = KO vedi id_meca 
//---  se ERRORE lancia un Exception
//---
long k_return = 0
string k_presente
int k_anno
st_esito kst_esito 


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_meca.num_int > 0 then 

	k_anno = year(kst_tab_meca.data_int)

   	select max(id)
	   	into :kst_tab_meca.id
	   	from  meca
		 where 
				year(meca.data_int) =  :k_anno
				and ( (meca.num_int > :kst_tab_meca.num_int and meca.data_int <  :kst_tab_meca.data_int)
				        or (meca.num_int < :kst_tab_meca.num_int and meca.data_int >  :kst_tab_meca.data_int) )
		 using kguo_sqlca_db_magazzino ;
		 
	if sqlca.sqlcode = 0 then
		if kst_tab_meca.id > 0 then
			k_return = kst_tab_meca.id //--- KO!
		end if
	else
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore durante controllo congruenza data LOTTO n. " + string(kst_tab_meca.num_int ) + " del " + string(kst_tab_meca.data_int ) + " (meca)~n~r " &
										 + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.set_esito( kst_esito ) 	
			throw kguo_exception
		else

//--- TUTTO OK!			
			k_return = 0
			
		end if
	end if
	
else
	kst_esito.sqlcode = 0
	if trim(kst_esito.SQLErrText) > " " then kst_esito.SQLErrText += "~n~r"  // aggiungo a capo se necessario
	kst_esito.SQLErrText = "Manca numero documento per controllo del LOTTO (meca) " 
	kst_esito.esito = kkg_esito.err_logico
	kguo_exception.set_esito( kst_esito ) 	
	throw kguo_exception
end if



return k_return

end function

public function boolean if_barcode_da_gen (st_tab_meca ast_tab_meca) throws uo_exception;//======================================================================
//--- Controlla se nr colli corrisponde al nr barcode
//--- rit: TRUE=barcode da generare/rimuovere; FALSE=nessuna operazione
//======================================================================
boolean k_return = false
long k_righe
st_esito kst_esito
datastore kds_1
	
	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kds_1 = create datastore
	kds_1.dataobject = "ds_barcode_dagen"
	kds_1.settransobject(kguo_sqlca_db_magazzino)
	
	k_righe = kds_1.retrieve(ast_tab_meca.id)

	if k_righe < 0 then
		kst_esito.sqlcode = k_righe
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlerrtext = "Errore in lettura numero Colli e Barcode del Lotto id="+ string(ast_tab_meca.id) +"~n~r" +  trim(kguo_sqlca_db_magazzino.sqlerrtext)
		kguo_exception.inizializza()
		kguo_exception.set_esito( kst_esito ) 	
		throw kguo_exception
	end if

//--- nr colli lotto diverso dal nr barcode generati	
	if k_righe > 0 then
		k_return = TRUE
	end if
	

return k_return 
end function

private function boolean if_articoli_nocontratto () throws uo_exception;//--
//---  Controlla che tutte le righe NON abbiano CONTRATTO
//---
//---  input: datastore testata e righe
//---  otput: boolean TRUE = OK tutte le righe senza Contratto; FALSE=almeno una riga con contratto
//---  se ERRORE lancia un Exception
//---
boolean k_return = true
int k_righe = 0, k_riga = 0
st_tab_listino kst_tab_listino
st_esito kst_esito 
kuf_listino kuf1_listino


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


	k_righe = kids_righe.rowcount()

	kuf1_listino = create kuf_listino

//--- cicla x controllare le righe
	for k_riga = 1 to k_righe
		kst_tab_listino.id = kids_righe.getitemnumber(k_riga, "id_listino")
		if kst_tab_listino.id > 0 then
			kst_tab_listino.contratto = kuf1_listino.get_contratto(kst_tab_listino)			
//--- i contratti testata e riga devono essere uguali
			if kst_tab_listino.contratto > 0 then
				k_return = false
				exit
			end if
		end if
	end for
	
return k_return

end function

public function boolean if_carico_nodose ();//--------------------------------------------------------------------------------------------------------------------------
//--- Verifica se richiesti dati ricevente/Fatturato o altri per un carico di tipo minimale quale di materiale di consumo
//--- rit: TRUE carico minimale, FALSE=carico normale per la lavorazione
//--------------------------------------------------------------------------------------------------------------------------
boolean k_return = true
st_tab_meca kst_tab_meca


if kids_testa.rowcount() > 0 then

//--- se manca il codice contratto allora le anagrafiche non devono esserci es. x materiale di consumo
	kst_tab_meca.contratto = kids_testa.getitemnumber(1, "contratto")
	if kst_tab_meca.contratto > 0 then 
		k_return = false
	end if
end if


return k_return


end function

on kuf_armo_checkmappa.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_armo_checkmappa.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//
	kiuf_sped = create kuf_sped
	

end event

