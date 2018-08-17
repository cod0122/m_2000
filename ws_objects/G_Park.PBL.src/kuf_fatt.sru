$PBExportHeader$kuf_fatt.sru
forward
global type kuf_fatt from nonvisualobject
end type
end forward

global type kuf_fatt from nonvisualobject
end type
global kuf_fatt kuf_fatt

type variables
//
public st_tab_arfa kist_tab_arfa
private string ki_dw_stampa_fattura = "d_stampa_fattura_cliente"
private datastore kidw_stampa_fattura
private int ki_fattura_riga_corpo = 0
private constant int ki_fattura_riga_corpo_max= 20
private string ki_stampante_predefinita = " "
private st_fattura_stampa kist_fattura_stampa_riga_old
private int ki_pag_fattura=0
private string ki_path_risorse=""

end variables

forward prototypes
public function st_esito select_riga (ref st_tab_contratti k_st_tab_contratti)
public function st_esito tb_delete (st_tab_arfa kst_tab_arfa)
public subroutine if_isnull_testa (ref st_tab_arfa kst_tab_arfa)
public function st_esito tb_fattura_no_id_meca ()
public function st_esito tb_delete_tab_prof ()
public function st_esito tb_delete_x_rif ()
public function st_esito get_tipo_pagamento (ref st_tab_arfa kst_tab_arfa)
public function st_esito get_note (ref st_tab_arfa kst_tab_arfa)
public function st_esito get_tipo_documento (ref st_tab_arfa kst_tab_arfa)
public function st_esito get_totali (ref st_tab_arfa kst_tab_arfa, ref st_fattura_totali kst_fattura_totali)
public function st_esito get_scadenze (ref st_tab_arfa kst_tab_arfa, ref st_fattura_scadenze kst_fattura_scadenze)
public function boolean stampa_fattura_emissione (string titolo) throws uo_exception
public function boolean produci_fattura_open ()
public function boolean produci_fattura_piede_scadenze (ref st_fattura_scadenze kst_fattura_scadenze)
public function boolean produci_fattura_riga (ref st_fattura_stampa kst_fattura_stampa)
public function boolean produci_fattura_testa (ref st_fattura_stampa kst_fattura_stampa)
public function boolean produci_fattura_piede_totali (readonly st_fattura_totali kst_fattura_totali)
public function st_esito get_cliente (ref st_tab_arfa kst_tab_arfa)
public function st_esito anteprima (ref datawindow kdw_anteprima, st_tab_arfa kst_tab_arfa)
public function boolean produci_fattura_piede_note (ref st_tab_arfa kst_tab_arfa)
public function long produci_fattura_nuova_pagina ()
public function integer stampa_fattura (ds_fatture kds_fatture) throws uo_exception
public function integer aggiorna_fattura_flag_stampa (ds_fatture kds_fatture) throws uo_exception
public function integer stampa_fattura_nuova (ds_fatture kds_fatture) throws uo_exception
public function integer produci_fattura (ref ds_fatture kds_fatture) throws uo_exception
public function integer get_fatture_da_stampare (ds_fatture kds_fatture) throws uo_exception
public function st_esito produci_fattura_set_dw_loghi (ref datawindow kdw_1)
public function st_esito produci_fattura_set_dw_loghi (ref datastore kdw_1)
end prototypes

public function st_esito select_riga (ref st_tab_contratti k_st_tab_contratti);//
//--- Leggo Contratto specifico
//
long k_codice
st_esito kst_esito


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//	k_codice = k_st_tab_contratti.codice
//
//	
//	
//	select 
//			 mc_co,
//			 sc_cf,
//			 sl_pt,
//			 data,
//			 data_scad,
//			 cod_cli,
//			 descr,
//			 cert_st_dose_min,
//			 cert_st_dose_max,
//			 cert_st_data_ini,
//			 cert_st_data_fin
//	 into 
//			:k_st_tab_contratti.mc_co,
//			:k_st_tab_contratti.sc_cf,
//			:k_st_tab_contratti.sl_pt,
//			:k_st_tab_contratti.data,
//			:k_st_tab_contratti.data_scad,
//			:k_st_tab_contratti.cod_cli,
//			:k_st_tab_contratti.descr,
//			:k_st_tab_contratti.cert_st_dose_min,
//			:k_st_tab_contratti.cert_st_dose_max,
//			:k_st_tab_contratti.cert_st_data_ini,
//			:k_st_tab_contratti.cert_st_data_fin
//		from contratti
//		where 
//		codice = :k_codice
//		using sqlca;
//
	
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.d.d.t., bolla di sped. (codice=" + string(k_codice) + ") : " &
									 + trim(SQLCA.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = "100"
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = "2"
			else	
				kst_esito.esito = "1"
			end if
		end if
	end if
	
//return string(sqlca.sqlcode, "0000000000") + trim(sqlca.SQLErrText) + " "
return kst_esito


end function

public function st_esito tb_delete (st_tab_arfa kst_tab_arfa);//
//====================================================================
//=== Cancella il rek dalla tabella ARFA (Fatture) 
//=== 
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//=== 
//====================================================================
//
int k_resp
boolean k_return
st_esito kst_esito
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita_cancellazione
kst_open_w.id_programma = kkg_id_programma_fatture

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Cancellazione Fattura non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = "1"

else

//
////=== Controllo se contratti definiti nei Piani di Trattamento
//DECLARE c_fattura CURSOR FOR  
//	  SELECT num_fatt, data_fatt
//   	 FROM arfa 
//	   WHERE num_bolla_out = :kst_tab_sped.num_bolla_out
//		      and data_bolla_out = :kst_tab_sped.data_bolla_out;
//
// 	   
//open c_fattura;
//if sqlca.sqlCode = 0 then
//
//	fetch c_fattura INTO :kst_tab_arfa.num_fatt, :kst_tab_arfa.data_fatt;
//
//	if sqlca.sqlCode = 0 then
//		k_resp = messagebox ("Eliminazione Bolla di Spedizione " &
//			   + string(kst_tab_sped.num_bolla_out, "####0") + " del " &
//				+ string(kst_tab_sped.data_bolla_out, "dd.mm.yyyy"), &	
//           "Documento di Trasporto gia' in Fattura:  ~n~r" &
//			   + string(kst_tab_arfa.num_fatt, "####0") + " del " &
//				+ string(kst_tab_arfa.data_fatt, "dd.mm.yyyy") + " ~n~r" &
//				+ "Vuoi eliminare definitivamente anche la fattura ?", &
//				  question!, yesno!, 2)
//		if k_resp = 1 then
////			kuf1_fatt = create kuf_fatt
////			kst_esito = kuf1_fatt.tb_delete(kst_tab_arfa)
////			destroy kst_tab_fatt
//			if kst_esito.esito = "100" then // se errore 100 me ne frego e resetto
//				kst_esito.esito = "0"
//			end if
//
//		else
//			kst_esito.esito = "2"
//			kst_esito.sqlcode = 0
//			kst_esito.SQLErrText = "Operazione non eseguita, perche' interrotta dall'utente" 
//		end if
//	end if
//	close c_fattura;
//end if
//
	
	if kst_esito.esito = "0" then
	
	//--- cancella prima tutte le righe varie
		delete from arfa_v
				WHERE num_fatt = :kst_tab_arfa.num_fatt
						and data_fatt = :kst_tab_arfa.data_fatt;
	
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = &
	"Errore durante la cancellazione delle righe Varie della Fattura ~n~r" &
					+ string(kst_tab_arfa.num_fatt, "####0") + " del " &
					+ string(kst_tab_arfa.data_fatt, "dd.mm.yyyy") &	
					+ " ~n~rErrore-tab.ARSP:"	+ trim(sqlca.SQLErrText)
			kst_esito.esito = "1"
		else
	
	//--- se tutto ok cancella anche le altre righe
			delete from arfa
				WHERE num_fatt = :kst_tab_arfa.num_fatt
						and data_fatt = :kst_tab_arfa.data_fatt;
			
			if sqlca.sqlcode <> 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = &
	"Errore durante la cancellazione della Fattura ~n~r" &
					+ string(kst_tab_arfa.num_fatt, "####0") + " del " &
					+ string(kst_tab_arfa.data_fatt, "dd.mm.yyyy") &	
					+ " ~n~rErrore-tab.ARFA:"	+ trim(sqlca.SQLErrText)
				if sqlca.sqlcode = 100 then
					kst_esito.esito = "100"
				else
					if sqlca.sqlcode > 0 then
						kst_esito.esito = "2"
					else
						kst_esito.esito = "1"
					end if
				end if
			end if
		end if
	end if
end if


return kst_esito

end function

public subroutine if_isnull_testa (ref st_tab_arfa kst_tab_arfa);//---
//--- toglie i NULL ai campi della tabella 
//---

if isnull(kst_tab_arfa.stampa) then kst_tab_arfa.stampa = " "
if isnull(kst_tab_arfa.tipo_riga) then kst_tab_arfa.tipo_riga = " "
if isnull(kst_tab_arfa.tipo_doc) then kst_tab_arfa.tipo_doc = " "
if isnull(kst_tab_arfa.colli) then	kst_tab_arfa.colli = 0
if isnull(kst_tab_arfa.colli_out) then	kst_tab_arfa.colli_out = 0
if isnull(kst_tab_arfa.peso_kg_out) then	kst_tab_arfa.peso_kg_out = 0
if isnull(kst_tab_arfa.iva) then	kst_tab_arfa.iva = 0
if isnull(kst_tab_arfa.clie_3) then	kst_tab_arfa.clie_3 = 0
if isnull(kst_tab_arfa.prezzo_u) then	kst_tab_arfa.prezzo_u = 0
if isnull(kst_tab_arfa.prezzo_t) then	kst_tab_arfa.prezzo_t = 0
if isnull(kst_tab_arfa.peso_kg_out) then	kst_tab_arfa.peso_kg_out = 0
if isnull(kst_tab_arfa.cod_pag) then	kst_tab_arfa.cod_pag = 0
if isnull(kst_tab_arfa.num_bolla_out) then	kst_tab_arfa.num_bolla_out = 0
if isnull(kst_tab_arfa.id_armo) then	kst_tab_arfa.id_armo = 0

end subroutine

public function st_esito tb_fattura_no_id_meca ();//
//====================================================================
//=== Ritorna se esistono righe in fattura diverse dal id Riferimento 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK esistono; 1=Non esistono
//===                                     100=not found
//===                                     2=Errore Grave
//===                                     3=altro errore
//====================================================================
//
long k_ctr
st_tab_meca kst_tab_meca
st_esito kst_esito


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


//--- ci sono righe varie?
	select count(*) 
		 into :k_ctr
			from arfa_v
		 where num_fatt = :kist_tab_arfa.num_fatt
		       and data_fatt = :kist_tab_arfa.num_fatt
				 	using sqlca;

	
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Ricerca in fattura righe no Riferimento " &
									 + trim(SQLCA.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = "100"
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = "3"
			else	
				kst_esito.esito = "2"
			end if
		end if
	else
		if k_ctr > 0 then
			kst_esito.esito = "0"
		else
			kst_esito.esito = "1"
		end if
	end if
		
//--- se non ho trovato righe allora vedo altre righe fattura		
	if kst_esito.esito = "1" then
		
		select distinct id_meca 
		   into :kst_tab_meca.id
			from armo 
			where id_armo = :kist_tab_arfa.id_armo
			using sqlca;
		
		if sqlca.sqlcode = 0 then
			select count(*) 
				 into :k_ctr
					from arfa
				 where num_fatt = :kist_tab_arfa.num_fatt
						 and data_fatt = :kist_tab_arfa.num_fatt
						 and id_armo not in
							(select id_armo from armo 
							where id_meca = :kst_tab_meca.id)
							using sqlca;
		
			
			if sqlca.sqlcode <> 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Ricerca in fattura righe no Riferimento (kuf_fatt.tb_fattura_no_id_meca) " &
											 + trim(SQLCA.SQLErrText)
				if sqlca.sqlcode = 100 then
					kst_esito.esito = "100"
				else
					if sqlca.sqlcode > 0 then
						kst_esito.esito = "3"
					else	
						kst_esito.esito = "2"
					end if
				end if
			else
				if k_ctr > 0 then
					kst_esito.esito = "0"
				else
					kst_esito.esito = "1"
				end if
			end if
		else
			kst_esito.esito = "2"
			kst_esito.SQLErrText = "Errore in Ricerca id Riferimento (kuf_fatt.tb_fattura_no_id_meca) " &
											 + trim(SQLCA.SQLErrText)
		end if
	end if	

return kst_esito


end function

public function st_esito tb_delete_tab_prof ();//
//====================================================================
//=== 
//=== Cancella Profis con i dati fattura specifica
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK!; 100=not found
//===                                     1=errore grave
//===                                     2=errore > 0
//=== 
//====================================================================
//
st_esito kst_esito
int k_ctr=0



kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


//--- 
	delete 
		 from prof
		 WHERE num_fatt = :kist_tab_arfa.num_fatt
				 and data_fatt = :kist_tab_arfa.data_fatt
		 using sqlca;
		 
   if sqlca.sqlcode <> 0 then
	   if sqlca.sqlcode < 0 then
			kst_esito.esito = "1"
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in Cancellaz.righe di Raccordo Profis (kuf_fatt.tb_delete_tab_prof)~n~r" + trim(sqlca.SQLErrText) 
		end if
	end if


return kst_esito

end function

public function st_esito tb_delete_x_rif ();//
//====================================================================
//=== Cancella il rek dalla tabella ARFA (Fatture) con i dati del Riferimento
//=== 
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===                : 3=INFORMAZIONE 
//=== 
//====================================================================
//
int k_ctr
boolean k_return, k_flag_fattura_vuota
st_esito kst_esito, kst_esito1, kst_esito2, kst_esito3
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza
kuf_ricevute kuf1_ricevute

kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


kst_open_w.flag_modalita = kkg_flag_modalita_cancellazione
kst_open_w.id_programma = kkg_id_programma_fatture

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Cancellazione Fattura non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = "1"

else

//=== 
	DECLARE c_fattura_v CURSOR FOR  
	  SELECT num_fatt, data_fatt
   	 FROM arfa 
	   WHERE id_armo = :kist_tab_arfa.id_armo
		using sqlca;
	
	
	open c_fattura_v;
	
	fetch c_fattura_v into :kist_tab_arfa.num_fatt, :kist_tab_arfa.data_fatt;

	kuf1_ricevute = create kuf_ricevute

	kst_esito1.SQLErrText = " "
	kst_esito1.esito = "0"
	do while sqlca.sqlcode = 0 

//--- controllo se ci sono righe varie in fattura
		select count (*)   
		    into :k_ctr 
			 from arfa_v
			 WHERE num_fatt = :kist_tab_arfa.num_fatt
					 and data_fatt = :kist_tab_arfa.data_fatt
			 using sqlca;

		if sqlca.sqlcode = 0 and k_ctr > 0 then			 
			kst_esito1.sqlcode = 0
			kst_esito1.SQLErrText = trim(kst_esito1.SQLErrText) &
	            + "La fattura ha delle righe Varie che NON sono state eliminate, controllare la n." &
				   + string(kist_tab_arfa.num_fatt, "####0") + " del " &
					+ string(kist_tab_arfa.data_fatt, "dd.mm.yyyy") + "~n~r" 
			kst_esito1.esito = "3"
		end if

//--- ci sono righe diverse oltre a quelle del riferimento?
		kst_esito3 = tb_fattura_no_id_meca()
		if kst_esito3.esito = "0" then
			k_flag_fattura_vuota = false
		else
			k_flag_fattura_vuota = true
		end if			

//--- controllo se ci sono righe del PROFIS gia' contabilizzate
		select count (*)   
		    into :k_ctr 
			 from prof
			 WHERE num_fatt = :kist_tab_arfa.num_fatt
					 and data_fatt = :kist_tab_arfa.data_fatt
					 and profis = 'S'
			 using sqlca;
		if sqlca.sqlcode = 0 and k_ctr > 0 then			 
			kst_esito1.sqlcode = 0
			kst_esito1.SQLErrText = trim(kst_esito1.SQLErrText) &
	            + "Fattura già in contabilita', prego controllare n." &
				   + string(kist_tab_arfa.num_fatt, "####0") + " del " &
					+ string(kist_tab_arfa.data_fatt, "dd.mm.yyyy") + "~n~r" 
			kst_esito1.esito = "3"
		end if
//--- cancella righe PROFIS
		if k_flag_fattura_vuota then
			kst_esito1 = tb_delete_tab_prof()
		end if

//--- controllo se ci sono righe RIBA gia' presentate
      kuf1_ricevute.kist_tab_ricevute.num_fatt = kist_tab_arfa.num_fatt
      kuf1_ricevute.kist_tab_ricevute.data_fatt = kist_tab_arfa.data_fatt
		kst_esito2 = kuf1_ricevute.ric_gia_presentate()
		if kst_esito2.esito = "0" then
			kst_esito1.SQLErrText = trim(kst_esito1.SQLErrText) &
	            + "Fattura con Effetti già presentati alla Banca, prego controllare n." &
				   + string(kist_tab_arfa.num_fatt, "####0") + " del " &
					+ string(kist_tab_arfa.data_fatt, "dd.mm.yyyy") + "~n~r" 
			kst_esito1.esito = "3"
		else
			if kst_esito2.esito = "100" then
				if k_flag_fattura_vuota then
//--- cancella righe EFFETTI
					kst_esito2 = kuf1_ricevute.tb_delete_x_fatt()
					if kst_esito2.esito <> "0" and kst_esito2.sqlcode < 0 then
						kst_esito1.SQLErrText = trim(kst_esito1.SQLErrText) &
								+ "Errore in Cancellaz. Effetti Fattura, prego controllare n." &
								+ string(kist_tab_arfa.num_fatt, "####0") + " del " &
								+ string(kist_tab_arfa.data_fatt, "dd.mm.yyyy") + "~n~r" &
								+ trim(kst_esito1.SQLErrText)
						kst_esito1.esito = ""
					end if
				end if
			else
				kst_esito1.SQLErrText = trim(kst_esito1.SQLErrText) &
						+ "Errore in lettura Effetti già presentati alla Banca, prego controllare n." &
						+ string(kist_tab_arfa.num_fatt, "####0") + " del " &
						+ string(kist_tab_arfa.data_fatt, "dd.mm.yyyy") + "~n~r" 
				kst_esito1.esito = "1"
			end if
		end if
	   

		fetch c_fattura_v into :kist_tab_arfa.num_fatt, :kist_tab_arfa.data_fatt;
		
	loop
	
	close c_fattura_v;

	if kst_esito1.esito <> "0" and kst_esito1.esito <> "3" then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = &
		"Errore durante la cancellazione della Fattura ~n~r" &
						+ string(kist_tab_arfa.num_fatt, "####0") + " del " &
						+ string(kist_tab_arfa.data_fatt, "dd.mm.yyyy") &	
						+ " ~n~rErrore-tab.ARFA:"	+ trim(kst_esito1.SQLErrText)
			kst_esito.esito = "2"
	else
		if kst_esito1.esito = "3" then
			kst_esito.SQLErrText = trim(kst_esito.SQLErrText) + trim(kst_esito1.SQLErrText)
		end if

//--- se tutto ok cancella anche le righe
		delete from arfa
				WHERE num_fatt = :kist_tab_arfa.num_fatt
						and data_fatt = :kist_tab_arfa.data_fatt;
			
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = &
	"Errore durante la cancellazione della Fattura ~n~r" &
					+ string(kist_tab_arfa.num_fatt, "####0") + " del " &
					+ string(kist_tab_arfa.data_fatt, "dd.mm.yyyy") &	
					+ " ~n~rErrore-tab.ARFA:"	+ trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = "100"
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = "2"
				else
					kst_esito.esito = "1"
				end if
			end if
		end if
	end if

end if


return kst_esito

end function

public function st_esito get_tipo_pagamento (ref st_tab_arfa kst_tab_arfa);//--
//---  Torna il Tipo Pagamento della Fattura indicata
//---
st_esito kst_esito 


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_arfa.num_fatt > 0 then 
   select max(cod_pag)
	   into :kst_tab_arfa.cod_pag
	   from  ARFA
       where ARFA.NUM_FATT   =  :kst_tab_arfa.NUM_FATT 
                 and ARFA.DATA_FATT =  :kst_tab_arfa.DATA_FATT 
       using sqlca;
		 
	if sqlca.sqlcode = 100 then
		select max(cod_pag)
			into :kst_tab_arfa.cod_pag
			from  ARFA_V
			 where ARFA_v.NUM_FATT   =  :kst_tab_arfa.NUM_FATT 
						  and ARFA_v.DATA_FATT =  :kst_tab_arfa.DATA_FATT 
			 using sqlca;
	end if
	
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Lettura Tipo Pagamento Fattura n. " + string(kst_tab_arfa.NUM_FATT ) + " del " + string(kst_tab_arfa.DATA_FATT ) + " (arfa) " &
									 + trim(SQLCA.SQLErrText)
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
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca numero Fattura per Lettura Tipo Pagamento Fattura (arfa) " 
	kst_esito.esito = kkg_esito_err_logico
end if


return kst_esito
end function

public function st_esito get_note (ref st_tab_arfa kst_tab_arfa);//
//--- Leggo Contratto specifico
//
long k_codice
st_esito kst_esito


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

    select
                  FAT1.NOTE_1,
                  FAT1.NOTE_2,
                  FAT1.NOTE_3,
                  FAT1.NOTE_4,
                  FAT1.NOTE_5
			into 
				:kst_tab_arfa.note_1,
				:kst_tab_arfa.note_2,
				:kst_tab_arfa.note_3,
				:kst_tab_arfa.note_4,
				:kst_tab_arfa.note_5
		from fat1
              where FAT1.NUM_FATT    = :kst_tab_arfa.NUM_FATT   and
                        FAT1.DATA_FATT   = :kst_tab_arfa.DATA_FATT
		using sqlca;

	
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Lettura della Tabella Note di Fattura (num.=" + string(kst_tab_arfa.NUM_FATT) &
										+ " del " + string(kst_tab_arfa.DATA_FATT) + "). Err.: " &
									 	+ trim(SQLCA.SQLErrText)
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
	
return kst_esito


end function

public function st_esito get_tipo_documento (ref st_tab_arfa kst_tab_arfa);//--
//---  Torna il Tipo Documento  (NC=nota di credito, FT=fattura)
//---
st_esito kst_esito 
int k_ctr

kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_arfa.num_fatt > 0 then 
	
	  select count(*)
		into :k_ctr
				from  ARFA 
				where ARFA.NUM_FATT   = :kst_tab_arfa.NUM_FATT
						and ARFA.DATA_FATT = :kst_tab_arfa.DATA_FATT
					  and ARFA.TIPO_DOC     = "NC"
	using sqlca;
	
	if sqlca.sqlcode <> 0 then
		
		select count(*)
				into :k_ctr
						from  ARFA_V
						where ARFA_V.NUM_FATT   = :kst_tab_arfa.NUM_FATT
								and ARFA_V.DATA_FATT = :kst_tab_arfa.DATA_FATT
							  and ARFA_V.TIPO_DOC     = "NC"
			using sqlca;
	end if				
	if k_ctr > 0 and sqlca.sqlcode = 0 then
		kst_tab_arfa.TIPO_DOC	= "NC"
	else
		if sqlca.sqlcode >= 0 then
			kst_tab_arfa.TIPO_DOC	= "FT"
		else	
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Lettura Tipo Documento n. " + string(kst_tab_arfa.NUM_FATT ) + " del " + string(kst_tab_arfa.DATA_FATT ) + " (arfa) " &
									 + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito_db_ko
		end if
	end if
	
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca numero Fattura per Lettura Tipo Pagamento Fattura (arfa) " 
	kst_esito.esito = kkg_esito_err_logico
end if


return kst_esito
end function

public function st_esito get_totali (ref st_tab_arfa kst_tab_arfa, ref st_fattura_totali kst_fattura_totali);//--
//---  Torna i Totali Fattura (Imponibili + IVA + eccc...) della Fattura indicata x metterli in stampa
//--- input: st_tab_arfa con estremi fattura
//--- out: st_fattura_totali tutta valorizzata
//---
int k_ind=0
st_esito kst_esito 
st_tab_iva kst_tab_iva
st_fattura_totali kst_fattura_totali_null
kuf_ausiliari kuf1_ausiliari



kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


kst_fattura_totali = kst_fattura_totali_null
kst_fattura_totali.totale = 0

if kst_tab_arfa.num_fatt > 0 then 


	declare get_totali_c1 cursor for
               select 
                          IVA,
                          sum(PREZZO_T)
                     from  v_arfa_tot_imponibili 
                     where NUM_FATT   = :kst_tab_arfa.NUM_FATT
                           and DATA_FATT = :kst_tab_arfa.DATA_FATT
				group by iva
			 using sqlca;

									
//--- ciclo lettura totali imponibili
	open get_totali_c1;
	if sqlca.sqlcode = 0 then

		fetch get_totali_c1 into
			:kst_tab_arfa.iva
			,:kst_tab_arfa.prezzo_t;

		kuf1_ausiliari = create kuf_ausiliari

		do while sqlca.sqlcode = 0 and k_ind < 5

			k_ind++

			if kst_tab_arfa.iva > 0 then
				kst_tab_iva.codice = kst_tab_arfa.iva
				kuf1_ausiliari.tb_select( kst_tab_iva )
			else
				kst_tab_iva.aliq = 0
			end if
			
//--- Totale GENERALE
			if kst_tab_arfa.prezzo_t > 0 then
				kst_fattura_totali.totale += kst_tab_arfa.prezzo_t
				if kst_tab_iva.aliq > 0 then
					kst_fattura_totali.totale += kst_tab_arfa.prezzo_t * (kst_tab_iva.aliq / 100)
				end if
			end if
			
//--- Imponibili+IVA
			choose case k_ind
				case 1
					kst_fattura_totali.cod_1 =  kst_tab_iva.codice 
					kst_fattura_totali.imponibile_1 = kst_tab_arfa.prezzo_t
					if kst_tab_iva.aliq > 0 then
						kst_fattura_totali.iva_1 =  kst_tab_iva.aliq 
						kst_fattura_totali.imposta_1 =  kst_tab_arfa.prezzo_t * (kst_tab_iva.aliq / 100)
						kst_fattura_totali.iva_des_1 =  kst_tab_iva.des 
					else
						kst_fattura_totali.iva_1 =  0 
						kst_fattura_totali.imposta_1 =  0
						if len(trim(kst_tab_iva.des)) > 0 then 
							kst_fattura_totali.iva_des_1 =  trim(kst_tab_iva.des)
						else
							kst_fattura_totali.iva_des_1 =  " "
						end if
					end if
				case 2
					kst_fattura_totali.cod_2 =  kst_tab_iva.codice 
					kst_fattura_totali.imponibile_2 = kst_tab_arfa.prezzo_t
					if kst_tab_iva.aliq > 0 then
						kst_fattura_totali.iva_2 =  kst_tab_iva.aliq 
						kst_fattura_totali.imposta_2 =  kst_tab_arfa.prezzo_t * (kst_tab_iva.aliq / 100)
						kst_fattura_totali.iva_des_2 =  kst_tab_iva.des 
					else
						kst_fattura_totali.iva_2 =  0 
						kst_fattura_totali.imposta_2 =  0
						if len(trim(kst_tab_iva.des)) > 0 then 
							kst_fattura_totali.iva_des_2 =  trim(kst_tab_iva.des)
						else
							kst_fattura_totali.iva_des_2 =  " "
						end if
					end if
				case 3
					kst_fattura_totali.cod_3 =  kst_tab_iva.codice 
					kst_fattura_totali.imponibile_3 = kst_tab_arfa.prezzo_t
					if kst_tab_iva.aliq > 0 then
						kst_fattura_totali.iva_3 =  kst_tab_iva.aliq 
						kst_fattura_totali.imposta_3 =  kst_tab_arfa.prezzo_t * (kst_tab_iva.aliq / 100)
						kst_fattura_totali.iva_des_3 =  kst_tab_iva.des 
					else
						kst_fattura_totali.iva_3 =  0 
						kst_fattura_totali.imposta_3 =  0
						if len(trim(kst_tab_iva.des)) > 0 then 
							kst_fattura_totali.iva_des_3 =  trim(kst_tab_iva.des)
						else
							kst_fattura_totali.iva_des_3 =  " "
						end if
					end if
				case 4
					kst_fattura_totali.cod_4 =  kst_tab_iva.codice 
					kst_fattura_totali.imponibile_4 = kst_tab_arfa.prezzo_t
					if kst_tab_iva.aliq > 0 then
						kst_fattura_totali.iva_4 =  kst_tab_iva.aliq 
						kst_fattura_totali.imposta_4 =  kst_tab_arfa.prezzo_t * (kst_tab_iva.aliq / 100)
						kst_fattura_totali.iva_des_4 =  kst_tab_iva.des 
					else
						kst_fattura_totali.iva_4 =  0 
						kst_fattura_totali.imposta_4 =  0
						if len(trim(kst_tab_iva.des)) > 0 then 
							kst_fattura_totali.iva_des_4 =  trim(kst_tab_iva.des)
						else
							kst_fattura_totali.iva_des_4 =  " "
						end if
					end if
				case else
					if kst_tab_iva.aliq > 0 then
						kst_esito.sqlcode = 0
						kst_esito.SQLErrText = "Calcolo Totali Fattura n. " + string(kst_tab_arfa.NUM_FATT ) + " del " + string(kst_tab_arfa.DATA_FATT ) + " (arfa) " &
													 + ": Attenzione Troppi Cod.IVA diversi.  "
						kst_esito.esito = kkg_esito_err_logico
					end if
			end choose

			

			fetch get_totali_c1 into
				:kst_tab_arfa.iva
				,:kst_tab_arfa.prezzo_t;
		loop

		destroy kuf1_ausiliari

	 	close get_totali_c1;
	end if
	
	if k_ind = 0 then
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Calcolo Totali Fattura  n. " + string(kst_tab_arfa.NUM_FATT ) + " del " + string(kst_tab_arfa.DATA_FATT ) + " (arfa) " &
										 + trim(SQLCA.SQLErrText)
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
	else
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Calcolo Totali Fattura n. " + string(kst_tab_arfa.NUM_FATT ) + " del " + string(kst_tab_arfa.DATA_FATT ) + " (arfa) " &
										 + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito_db_ko
		end if
	end if
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca numero Fattura per Calcolo Totali Fattura  (arfa) " 
	kst_esito.esito = kkg_esito_err_logico
end if


return kst_esito
end function

public function st_esito get_scadenze (ref st_tab_arfa kst_tab_arfa, ref st_fattura_scadenze kst_fattura_scadenze);//--
//---  Torna Scadenze (Importo + data) della Fattura indicata x metterli in stampa
//--- input: st_tab_arfa con estremi fattura
//--- out: kst_fattura_scadenze tutta valorizzata
//---
int k_ind=0
st_esito kst_esito 
st_tab_ricevute kst_tab_ricevute
st_ricevute_scadenze kst_ricevute_scadenze
kuf_ricevute kuf1_ricevute


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_arfa.num_fatt > 0 then 


	kuf1_ricevute = create kuf_ricevute
	kst_tab_ricevute.num_fatt = kst_tab_arfa.num_fatt
	kst_tab_ricevute.data_fatt = kst_tab_arfa.data_fatt
	kst_esito = kuf1_ricevute.get_scadenze( kst_tab_ricevute, kst_ricevute_scadenze)
	destroy kuf1_ricevute
	
	if kst_esito.esito = kkg_esito_ok then
		
		for k_ind =1 to 6

			choose case k_ind
				case 1
					if kst_ricevute_scadenze.importo_1 > 0 then
						kst_fattura_scadenze.importo_1 = kst_ricevute_scadenze.importo_1
						kst_fattura_scadenze.data_1 = kst_ricevute_scadenze.data_1
					else
						kst_fattura_scadenze.importo_1 = 0
					end if
				case 2
					if kst_ricevute_scadenze.importo_2 > 0 then
						kst_fattura_scadenze.importo_2 = kst_ricevute_scadenze.importo_2
						kst_fattura_scadenze.data_2 = kst_ricevute_scadenze.data_2
					else
						kst_fattura_scadenze.importo_2 = 0
					end if
				case 3
					if kst_ricevute_scadenze.importo_3 > 0 then
						kst_fattura_scadenze.importo_3 = kst_ricevute_scadenze.importo_3
						kst_fattura_scadenze.data_3 = kst_ricevute_scadenze.data_3
					else
						kst_fattura_scadenze.importo_3 = 0
					end if
				case 4
					if kst_ricevute_scadenze.importo_4 > 0 then
						kst_fattura_scadenze.importo_4 = kst_ricevute_scadenze.importo_4
						kst_fattura_scadenze.data_4 = kst_ricevute_scadenze.data_4
					else
						kst_fattura_scadenze.importo_4 = 0
					end if
				case 5
					if kst_ricevute_scadenze.importo_5 > 0 then
						kst_fattura_scadenze.importo_5 = kst_ricevute_scadenze.importo_5
						kst_fattura_scadenze.data_5 = kst_ricevute_scadenze.data_5
					else
						kst_fattura_scadenze.importo_5 = 0
					end if
				case else
					if kst_ricevute_scadenze.importo_6 > 0 then
						kst_esito.sqlcode = 0
						kst_esito.SQLErrText = "Scadenze Fattura n. " + string(kst_tab_arfa.NUM_FATT ) + " del " + string(kst_tab_arfa.DATA_FATT ) + " (arfa) " &
													 + ": Attenzione Troppe Scadenze.  "
						kst_esito.esito = kkg_esito_err_logico
					end if
			end choose
				
		next

	end if
	
	if k_ind = 0 then
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Calcolo Totali Fattura  n. " + string(kst_tab_arfa.NUM_FATT ) + " del " + string(kst_tab_arfa.DATA_FATT ) + " (arfa) " &
										 + trim(SQLCA.SQLErrText)
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
	else
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Calcolo Totali Fattura n. " + string(kst_tab_arfa.NUM_FATT ) + " del " + string(kst_tab_arfa.DATA_FATT ) + " (arfa) " &
										 + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito_db_ko
		end if
	end if
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca numero Fattura per Calcolo Totali Fattura  (arfa) " 
	kst_esito.esito = kkg_esito_err_logico
end if


return kst_esito
end function

public function boolean stampa_fattura_emissione (string titolo) throws uo_exception;//
//--- stampa fatture - richiama il gestore delle stampa
//--- input:  titolo     un titolo per la stampa
//--- out: true = OK, false = non stampata
//---
boolean k_stampato=true
int k_errore=0, k_rc
st_stampe kst_stampe

	if kidw_stampa_fattura.rowcount() > 0 then

//		kdw_1 = create datawindow
//		string k_do
//		k_do = 
//		kdw_1.DataObject = "d_txt_fpilota_out" //trim(k_do) //kidw_stampa_fattura.DataObject 
////		k_rc=kdw_1.SetTransObject(SQLCA)
//		
//		k_rc=kdw_1.insertrow(0)
//		
//		long k_fRow = 0
//		k_fRow = kdw_1.rowcount()
//		k_fRow = kidw_stampa_fattura.RowCount()
//		k_rc=kidw_stampa_fattura.RowsCopy(1,k_fRow, Primary!, kdw_1, 1, Primary!)
//		k_fRow = kdw_1.rowcount()

		kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datastore_diretta
		produci_fattura_set_dw_loghi(kidw_stampa_fattura)
		kst_stampe.ds_print = kidw_stampa_fattura
		kst_stampe.titolo = trim(titolo)
		kst_stampe.stampante_predefinita = ki_stampante_predefinita

		k_errore = kuf1_data_base.stampa_dw(kst_stampe)
		if k_errore <> 0 then
			k_stampato=false
		end if
	end if
	
 

return k_stampato

end function

public function boolean produci_fattura_open ();//---
//--- Apre l'output di stampa
//---
boolean k_return=true
kuf_base kuf1_base		


	kuf1_base = create kuf_base
		
//--- piglia la stampante della fattura	
	ki_stampante_predefinita = trim(mid(kuf1_base.prendi_dato_base( "stamp_fattura"),2))


	destroy kuf1_base


return k_return
end function

public function boolean produci_fattura_piede_scadenze (ref st_fattura_scadenze kst_fattura_scadenze);//---
//--- In stampa Scadenze di piede fattura
//---
boolean k_return=true
long k_riga


//--- ricava riga 
	k_riga = kidw_stampa_fattura.getrow( ) 
	
//--- stampa totali IVA	
	if kst_fattura_scadenze.importo_1 > 0 then
		kidw_stampa_fattura.setitem(k_riga, "scadenza_1",  string(kst_fattura_scadenze.importo_1, "###,###,##0.00") + " il "+ string(kst_fattura_scadenze.data_1))  
	end if
	if kst_fattura_scadenze.importo_2 > 0 then
		kidw_stampa_fattura.setitem(k_riga, "scadenza_2",  string(kst_fattura_scadenze.importo_1, "###,###,##0.00") + " il "+ string(kst_fattura_scadenze.data_2))  
	end if
	if kst_fattura_scadenze.importo_3 > 0 then
		kidw_stampa_fattura.setitem(k_riga, "scadenza_3",  string(kst_fattura_scadenze.importo_1, "###,###,##0.00") + " il "+ string(kst_fattura_scadenze.data_3))  
	end if
	if kst_fattura_scadenze.importo_4 > 0 then
		kidw_stampa_fattura.setitem(k_riga, "scadenza_4",  string(kst_fattura_scadenze.importo_1, "###,###,##0.00") + " il "+ string(kst_fattura_scadenze.data_4))  
	end if
//	if kst_fattura_scadenze.importo_5 > 0 then
//		kidw_stampa_fattura.setitem(k_riga, "scadenza_5",  string(kst_fattura_scadenze.importo_1, "###,###,##0.00") + " il "+ string(kst_fattura_scadenze.data_5))  
//	end if



return k_return

end function

public function boolean produci_fattura_riga (ref st_fattura_stampa kst_fattura_stampa);//---
//--- Corpo Fattura: Riga di Dettaglio
//---
boolean k_return=true
string k_stampante
long k_riga
kuf_base kuf1_base		



//--- piglia la riga ( che e' poi il numero pagina del lotto di fatture in elaborazione)
	k_riga = kidw_stampa_fattura.getrow(  ) 

	if  kst_fattura_stampa.kst_tab_arfa.num_bolla_out > 0 then
		if kst_fattura_stampa.kst_tab_arfa.num_bolla_out <> kist_fattura_stampa_riga_old.kst_tab_arfa.num_bolla_out then
			kist_fattura_stampa_riga_old.kst_tab_arfa.num_bolla_out = kst_fattura_stampa.kst_tab_arfa.num_bolla_out
			ki_fattura_riga_corpo++
			kidw_stampa_fattura.setitem(k_riga, "descr_" + string(ki_fattura_riga_corpo), &
									"Ns. d.d.t. nr.  " + string(kst_fattura_stampa.kst_tab_arfa.num_bolla_out) &
									+ "  del  " + string(kst_fattura_stampa.kst_tab_arfa.data_bolla_out) &
									)
		end if
	end if
	if kst_fattura_stampa.kst_tab_armo.dose > 0 and kst_fattura_stampa.kst_tab_armo.dose <> kist_fattura_stampa_riga_old.kst_tab_armo.dose then
		kist_fattura_stampa_riga_old.kst_tab_armo.dose = kst_fattura_stampa.kst_tab_armo.dose
		ki_fattura_riga_corpo++
		kidw_stampa_fattura.setitem(k_riga, "descr_" + string(ki_fattura_riga_corpo), &
								"kGy : " + string(kst_fattura_stampa.kst_tab_armo.dose, "##0.0#") &
								)
	end if


//--- se supero il nr-massimo di righe per facciata faccio salto pagina	
	if ki_fattura_riga_corpo > ki_fattura_riga_corpo_max then
		

//--- Nuova PAGINA		
		k_riga=produci_fattura_nuova_pagina()
		if k_riga = 0 then k_return = false
		ki_fattura_riga_corpo = 0
		
	end if

	if k_return then
		
//--- riga fattura	
		ki_fattura_riga_corpo++
		kidw_stampa_fattura.setitem(k_riga, "art_" + string(ki_fattura_riga_corpo),  kst_fattura_stampa.kst_tab_armo.art)  
		kidw_stampa_fattura.setitem(k_riga, "descr_" + string(ki_fattura_riga_corpo),  kst_fattura_stampa.kst_tab_prodotti.des)
		if  kst_fattura_stampa.kst_tab_arfa.colli_out > 0 then
			choose case  kst_fattura_stampa.kst_tab_arfa.tipo_l
				case kuf_listino.ki_tipo_prezzo_a_peso
					kidw_stampa_fattura.setitem(k_riga, "um_" + string(ki_fattura_riga_corpo),  "Kg.")  
				case kuf_listino.ki_tipo_prezzo_a_metro_cubo
					kidw_stampa_fattura.setitem(k_riga, "um_" + string(ki_fattura_riga_corpo),  "M.C.")  
				case else
					kidw_stampa_fattura.setitem(k_riga, "um_" + string(ki_fattura_riga_corpo),  "N.")  
			end choose
		else
			kidw_stampa_fattura.setitem(k_riga, "um_" + string(ki_fattura_riga_corpo),  " ")  
		end if
	
		kidw_stampa_fattura.setitem(k_riga, "qta_" + string(ki_fattura_riga_corpo),  kst_fattura_stampa.kst_tab_arfa.colli_out)  
		kidw_stampa_fattura.setitem(k_riga, "prezzo_" + string(ki_fattura_riga_corpo),  kst_fattura_stampa.kst_tab_arfa.prezzo_u)  
		kidw_stampa_fattura.setitem(k_riga, "imponibile_" + string(ki_fattura_riga_corpo),  kst_fattura_stampa.kst_tab_arfa.prezzo_t)  
		kidw_stampa_fattura.setitem(k_riga, "iva_" + string(ki_fattura_riga_corpo),  kst_fattura_stampa.kst_tab_arfa.iva)  

	end if
	
return k_return

end function

public function boolean produci_fattura_testa (ref st_fattura_stampa kst_fattura_stampa);//---
//--- Apre l'output di stampa
//---
boolean k_return=true
string k_stampante,  k_rcx, k_file
long k_riga
int k_rc
kuf_base kuf1_base		


//--- imposta il dw
	k_riga = kidw_stampa_fattura.insertrow( 0 ) 
	kidw_stampa_fattura.setrow(k_riga)

	
//--- riga indirizzo	
	k_rc=kidw_stampa_fattura.setitem(k_riga, "indirizzo_riga_1",  kst_fattura_stampa.kst_tab_clienti.RAG_SOC_10)  
	k_rc=kidw_stampa_fattura.setitem(k_riga, "indirizzo_riga_2",  kst_fattura_stampa.kst_tab_clienti.RAG_SOC_11)  
	k_rc=kidw_stampa_fattura.setitem(k_riga, "indirizzo_riga_3",  kst_fattura_stampa.kst_tab_clienti.INDI_1)  
	kidw_stampa_fattura.setitem(k_riga, "indirizzo_riga_4",  kst_fattura_stampa.kst_tab_clienti.CAP_1+" " &
																	+ trim(kst_fattura_stampa.kst_tab_clienti.LOC_1) + " " &
																	+ trim(kst_fattura_stampa.kst_tab_clienti.PROV_1) )  

    if len(trim(kst_fattura_stampa.kst_tab_clienti.kst_tab_nazioni.nome)) > 0 then
		k_rc=kidw_stampa_fattura.setitem(k_riga, "indirizzo_riga_5",  kst_fattura_stampa.kst_tab_clienti.kst_tab_nazioni.nome)  
	end if

//--- riga numero fattura	
	kidw_stampa_fattura.setitem(k_riga, "codice",  string(kst_fattura_stampa.kst_tab_arfa.clie_3))  
	kidw_stampa_fattura.setitem(k_riga, "piva",  kst_fattura_stampa.kst_tab_clienti.p_iva)  
	if  kst_fattura_stampa.kst_tab_arfa.tipo_doc = "NC" then
		kidw_stampa_fattura.setitem(k_riga, "causale",  "Nota di Credito ")  
	else
		kidw_stampa_fattura.setitem(k_riga, "causale",  "Fattura ")  
	end if
	kidw_stampa_fattura.setitem(k_riga, "numero_fattura",  kst_fattura_stampa.kst_tab_arfa.num_fatt)  
	kidw_stampa_fattura.setitem(k_riga, "data_fattura",  string(kst_fattura_stampa.kst_tab_arfa.data_fatt))  

//--- riga tipo pagamento e banca di appoggio	
	kidw_stampa_fattura.setitem(k_riga, "pagamento", string(kst_fattura_stampa.kst_tab_pagam.codice,"####")+ " " + trim(kst_fattura_stampa.kst_tab_pagam.des))  
	if kst_fattura_stampa.kst_tab_pagam.tipo = kuf_ausiliari.ki_tab_pagam_tipo_rim_diretta then
		kidw_stampa_fattura.setitem(k_riga, "banca", " ")  
	else
		kidw_stampa_fattura.setitem(k_riga, "banca",  trim(kst_fattura_stampa.kst_tab_clienti.banca)+" "&
		                                                                     + string(kst_fattura_stampa.kst_tab_clienti.abi)+" "&
																	 + string(kst_fattura_stampa.kst_tab_clienti.cab))  
	end if


return k_return

end function

public function boolean produci_fattura_piede_totali (readonly st_fattura_totali kst_fattura_totali);//---
//--- In stampa i totali di piede fattura
//---
boolean k_return=true
long k_riga, k_ctr, k_ctr1


//--- ricava riga 
	k_riga = kidw_stampa_fattura.getrow( ) 
	
//--- stampa totali IVA	
	if kst_fattura_totali.imponibile_1 > 0 then
		kidw_stampa_fattura.setitem(k_riga, "imponibile_tot_1",  kst_fattura_totali.imponibile_1)  
		if kst_fattura_totali.iva_1 > 0 then
			kidw_stampa_fattura.setitem(k_riga, "iva_tot_1",  kst_fattura_totali.iva_1)  
			kidw_stampa_fattura.setitem(k_riga, "imposta_tot_1",  kst_fattura_totali.imposta_1)  
		else
			kidw_stampa_fattura.setitem(k_riga, "iva_tot_1",  kst_fattura_totali.cod_1)  
		end if
		kidw_stampa_fattura.setitem(k_riga, "iva_des_1",  kst_fattura_totali.iva_des_1)  
	end if
	if kst_fattura_totali.imponibile_2 > 0 then
		kidw_stampa_fattura.setitem(k_riga, "imponibile_tot_2",  kst_fattura_totali.imponibile_2)  
		if kst_fattura_totali.iva_2 > 0 then
			kidw_stampa_fattura.setitem(k_riga, "iva_tot_2",  kst_fattura_totali.iva_2)  
			kidw_stampa_fattura.setitem(k_riga, "imposta_tot_2",  kst_fattura_totali.imposta_2)  
		else
			kidw_stampa_fattura.setitem(k_riga, "iva_tot_2",  kst_fattura_totali.cod_2)  
		end if
		kidw_stampa_fattura.setitem(k_riga, "iva_des_2",  kst_fattura_totali.iva_des_2)  
	end if
	if kst_fattura_totali.imponibile_3 > 0 then
		kidw_stampa_fattura.setitem(k_riga, "imponibile_tot_3",  kst_fattura_totali.imponibile_3)  
		if kst_fattura_totali.iva_3 > 0 then
			kidw_stampa_fattura.setitem(k_riga, "iva_tot_3",  kst_fattura_totali.iva_3)  
			kidw_stampa_fattura.setitem(k_riga, "imposta_tot_3",  kst_fattura_totali.imposta_3)  
		else
			kidw_stampa_fattura.setitem(k_riga, "iva_tot_3",  kst_fattura_totali.cod_3)  
		end if
		kidw_stampa_fattura.setitem(k_riga, "iva_des_3",  kst_fattura_totali.iva_des_3)  
	end if
	if kst_fattura_totali.imponibile_4 > 0 then
		kidw_stampa_fattura.setitem(k_riga, "imponibile_tot_4",  kst_fattura_totali.imponibile_4)  
		if kst_fattura_totali.iva_4 > 0 then
			kidw_stampa_fattura.setitem(k_riga, "iva_tot_4",  kst_fattura_totali.iva_4)  
			kidw_stampa_fattura.setitem(k_riga, "imposta_tot_4",  kst_fattura_totali.imposta_4)  
		else
			kidw_stampa_fattura.setitem(k_riga, "iva_tot_4",  kst_fattura_totali.cod_4)  
		end if
		kidw_stampa_fattura.setitem(k_riga, "iva_des_4",  kst_fattura_totali.iva_des_4)  
	end if

//--- stampa totale generale	
	kidw_stampa_fattura.setitem(k_riga, "divisa", "Euro")  
	kidw_stampa_fattura.setitem(k_riga, "totale_generale", string( kst_fattura_totali.totale, "###,###,##0.00"))  
	

//--- stampa il numero pagina (n di nn)
	for k_ctr = 1 to ki_pag_fattura   
		k_ctr1 = k_riga - ki_pag_fattura + k_ctr
		kidw_stampa_fattura.setitem(k_ctr1, "pagina",  " Pag. " + trim(string(k_ctr)) + "  di " + trim(string(ki_pag_fattura)) )  
	end for



return k_return

end function

public function st_esito get_cliente (ref st_tab_arfa kst_tab_arfa);//--
//---  Torna il Tipo Pagamento della Fattura indicata
//---
st_esito kst_esito 


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_arfa.num_fatt > 0 then 
   select max(clie_3)
	   into :kst_tab_arfa.clie_3
	   from  ARFA
       where ARFA.NUM_FATT   =  :kst_tab_arfa.NUM_FATT 
                 and ARFA.DATA_FATT =  :kst_tab_arfa.DATA_FATT 
       using sqlca;
		 
	if sqlca.sqlcode = 100 then
		select max(clie_3)
			into :kst_tab_arfa.clie_3
			from  ARFA_V
			 where ARFA_v.NUM_FATT   =  :kst_tab_arfa.NUM_FATT 
						  and ARFA_v.DATA_FATT =  :kst_tab_arfa.DATA_FATT 
			 using sqlca;
	end if
	
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Lettura Cliente Fattura n. " + string(kst_tab_arfa.NUM_FATT ) + " del " + string(kst_tab_arfa.DATA_FATT ) + " (arfa) " &
									 + trim(SQLCA.SQLErrText)
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
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca numero Fattura per Lettura Cliente Fattura (arfa) " 
	kst_esito.esito = kkg_esito_err_logico
end if


return kst_esito
end function

public function st_esito anteprima (ref datawindow kdw_anteprima, st_tab_arfa kst_tab_arfa);//
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
int k_n_fatture_stampate=0
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility
ds_fatture kds_fatture


kst_esito.esito = "0"
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita_anteprima
kst_open_w.id_programma = kkg_id_programma_barcode

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito_no_aut

else

	if kst_tab_arfa.num_fatt > 0 then

		kdw_anteprima.dataobject = ki_dw_stampa_fattura		
		kdw_anteprima.settransobject(sqlca)

		kuf1_utility = create kuf_utility
		kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
		destroy kuf1_utility

		kdw_anteprima.reset()	

//--- retrive dell'attestato 
	
		try 
			
			kds_fatture = create ds_fatture
			kds_fatture.insertrow(0)
			kds_fatture.object.num_fatt[1] =  kst_tab_arfa.num_fatt
			kds_fatture.object.data_fatt[1] =  kst_tab_arfa.data_fatt
			
//--- produci_fattura	
			k_n_fatture_stampate = produci_fattura(kds_fatture)
		
			if k_n_fatture_stampate > 0 then
				produci_fattura_set_dw_loghi(kdw_anteprima)
				kidw_stampa_fattura.rowscopy(1,kidw_stampa_fattura.rowcount(),Primary!,kdw_anteprima,1,Primary!)
			end if
			catch (uo_exception kuo_exception)
				kst_esito = kuo_exception.get_st_esito()

			finally
				destroy kds_fatture
				
		end try
	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessun Documento da visualizzare: ~n~r" + "nessun numero fattura indicato"
		kst_esito.esito = kkg_esito_err_formale
		
	end if
end if


return kst_esito

end function

public function boolean produci_fattura_piede_note (ref st_tab_arfa kst_tab_arfa);//---
//--- In stampa Scadenze di piede fattura
//---
boolean k_return=true
long k_riga


//--- ricava riga 
	k_riga = kidw_stampa_fattura.getrow( ) 
	
//--- stampa NOTE	
	if len(trim(kst_tab_arfa.note_1)) > 0 then
		kidw_stampa_fattura.setitem(k_riga, "note_1",  trim(kst_tab_arfa.note_1))  
	end if
	if len(trim(kst_tab_arfa.note_2)) > 0 then
		kidw_stampa_fattura.setitem(k_riga, "note_2",  trim(kst_tab_arfa.note_2))  
	end if
	if len(trim(kst_tab_arfa.note_3)) > 0 then
		kidw_stampa_fattura.setitem(k_riga, "note_3",  trim(kst_tab_arfa.note_3))  
	end if
	if len(trim(kst_tab_arfa.note_4)) > 0 then
		kidw_stampa_fattura.setitem(k_riga, "note_4",  trim(kst_tab_arfa.note_4))  
	end if
	if len(trim(kst_tab_arfa.note_5)) > 0 then
		kidw_stampa_fattura.setitem(k_riga, "note_5",  trim(kst_tab_arfa.note_5))  
	end if


return k_return

end function

public function long produci_fattura_nuova_pagina ();//---
//--- Ripete la Testata della Pagina Precedente
//---
long k_riga, k_riga_prec
int k_rc


//--- imposta il dw
	k_riga = kidw_stampa_fattura.insertrow( 0 ) 
	
	if k_riga > 1 then
		kidw_stampa_fattura.setrow(k_riga)	
		k_riga_prec = k_riga - 1
		ki_pag_fattura++

//		kidw_stampa_fattura.setitem(k_riga_prec, "divisa", " ")  
//		kidw_stampa_fattura.setitem(k_riga_prec, "totale", " ")  
	
//--- riga indirizzo	
		kidw_stampa_fattura.setitem(k_riga, "indirizzo_riga_1",  kidw_stampa_fattura.object.indirizzo_riga_1[k_riga_prec])  
		kidw_stampa_fattura.setitem(k_riga, "indirizzo_riga_2",  kidw_stampa_fattura.object.indirizzo_riga_2[k_riga_prec])  
		kidw_stampa_fattura.setitem(k_riga, "indirizzo_riga_3",  kidw_stampa_fattura.object.indirizzo_riga_3[k_riga_prec])  
		kidw_stampa_fattura.setitem(k_riga, "indirizzo_riga_4",  kidw_stampa_fattura.object.indirizzo_riga_4[k_riga_prec])  
		kidw_stampa_fattura.setitem(k_riga, "indirizzo_riga_5",  kidw_stampa_fattura.object.indirizzo_riga_5[k_riga_prec])  

//--- riga numero fattura	
		kidw_stampa_fattura.setitem(k_riga, "codice",  kidw_stampa_fattura.object.codice[k_riga_prec])  
		kidw_stampa_fattura.setitem(k_riga, "piva",  kidw_stampa_fattura.object.piva[k_riga_prec])  
		kidw_stampa_fattura.setitem(k_riga, "causale",  kidw_stampa_fattura.object.causale[k_riga_prec])  
		kidw_stampa_fattura.setitem(k_riga, "numero_fattura",  kidw_stampa_fattura.object.numero_fattura[k_riga_prec])  
		kidw_stampa_fattura.setitem(k_riga, "data_fattura",  kidw_stampa_fattura.object.data_fattura[k_riga_prec])  

//--- riga tipo pagamento e banca di appoggio	
		kidw_stampa_fattura.setitem(k_riga, "pagamento",  kidw_stampa_fattura.object.pagamento[k_riga_prec])  
		kidw_stampa_fattura.setitem(k_riga, "banca",  kidw_stampa_fattura.object.banca[k_riga_prec])  
	else
		k_riga = 0
	end if

return k_riga

end function

public function integer stampa_fattura (ds_fatture kds_fatture) throws uo_exception;//
//--- stampa fatture (RISTAMPA)
//--- input:  ds_fatture (datastore con elenco fatture)
//--- out: Numero fatture prodotte
//---
boolean k_stampato=true, k_sicurezza=true
int k_ctr=0, k_n_fatture_stampate=0
st_esito kst_esito 
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza
uo_exception kuo_exception


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""


kst_open_w.flag_modalita = kkg_flag_modalita_stampa
kst_open_w.id_programma = kkg_id_programma_fatture

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_sicurezza then
	k_stampato = false

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Stampa Fattura non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = KKG_ESITO_no_aut
	
	kuo_exception = create uo_exception
	kuo_exception.set_esito(kst_esito)
	throw kuo_exception

end if

	if kds_fatture.rowcount() > 0 then
	
//--- produci_fattura	
		k_n_fatture_stampate = produci_fattura(kds_fatture)
	
		if k_n_fatture_stampate > 0 then
//=== stampa dw
			k_stampato=stampa_fattura_emissione( trim("N. Fattura da " &
						 + trim(string(kds_fatture.object.NUM_FATT[1])) + " del " + trim(string(kds_fatture.object.DATA_FATT[1])))) 
	
			if not k_stampato then k_n_fatture_stampate = 0
		end if
	end if
	



return k_n_fatture_stampate

end function

public function integer aggiorna_fattura_flag_stampa (ds_fatture kds_fatture) throws uo_exception;//
//--- Aggiorna il flag si "STAMPA" sulle fatture
//--- input:  datastore ds_fatture con l'elenco delle fatture da aggiornare
//--- out: numero fatture aggiornate
//---
int k_ctr=0, k_n_fatture=0
long k_riga_fatture=0
st_esito kst_esito 
uo_exception kuo_exception
st_tab_arfa kst_tab_arfa





	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""

	

	if kds_fatture.rowcount() > 0 then
		
		for k_riga_fatture = 1 to kds_fatture.rowcount()

			kst_tab_arfa.NUM_FATT = kds_fatture.object.NUM_FATT[k_riga_fatture]
			kst_tab_arfa.DATA_FATT = kds_fatture.object.DATA_FATT[k_riga_fatture]

	//--- se tutto ok cancella anche le altre righe
    			update ARFA
         			  set STAMPA           = "S"
					WHERE num_fatt = :kst_tab_arfa.num_fatt
						and data_fatt = :kst_tab_arfa.data_fatt
						using sqlca;
			
			if sqlca.sqlcode >= 0 then
    				update ARFA_V
         			  set STAMPA           = "S"
					WHERE num_fatt = :kst_tab_arfa.num_fatt
						and data_fatt = :kst_tab_arfa.data_fatt
						using sqlca;
			end if
				
			if sqlca.sqlcode < 0 then
				
				kuf1_data_base.db_rollback_1()
				
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = &
	"Errore durante la aggiornamento 'stampa' Fattura ~n~r" &
					+ string(kst_tab_arfa.num_fatt, "####0") + " del " &
					+ string(kst_tab_arfa.data_fatt, "dd.mm.yyyy") &	
					+ " ~n~rErrore-tab.ARFA:"	+ trim(sqlca.SQLErrText)
				kst_esito.esito = kkg_esito_db_ko
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito)
				throw kuo_exception
			end if
											  
			k_n_fatture++

//---
		next

		kst_esito = kuf1_data_base.db_commit_1()
		if kst_esito.esito <> kkg_esito_ok then
			kuo_exception = create uo_exception
			kuo_exception.set_esito( kst_esito)
			throw kuo_exception
		end if
	
	end if



return k_n_fatture

end function

public function integer stampa_fattura_nuova (ds_fatture kds_fatture) throws uo_exception;//
//--- stampa fatture mai stampate
//--- input:  ds_fatture (datastore con elenco fatture)
//--- out: Numero fatture prodotte
//---
boolean k_stampato=true, k_sicurezza=true
int k_ctr=0, k_n_fatture_stampate=0
st_esito kst_esito 
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza
kuf_menu_window kuf1_menu_window
uo_exception kuo_exception


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""


kst_open_w.flag_modalita = kkg_flag_modalita_stampa
kst_open_w.id_programma = kkg_id_programma_fatture

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_sicurezza then
	k_stampato = false

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Stampa Fattura non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = KKG_ESITO_no_aut
	
	kuo_exception = create uo_exception
	kuo_exception.set_esito(kst_esito)
	throw kuo_exception

end if

if kds_fatture.rowcount() > 0 then

//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key=codice prodotto;
		
	Kst_open_w.id_programma = kkg_id_programma_fatture_nuove_stampa
	Kst_open_w.flag_primo_giro = "S"
	Kst_open_w.flag_modalita = kkg_flag_modalita_stampa
	Kst_open_w.flag_adatta_win = KK_ADATTA_WIN_NO
	Kst_open_w.flag_leggi_dw = "N"
	kst_open_w.key12_any = kds_fatture   // datastore
	kst_open_w.flag_where = " "
	
		
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(kst_open_w)
	destroy kuf1_menu_window

end if




return k_n_fatture_stampate

end function

public function integer produci_fattura (ref ds_fatture kds_fatture) throws uo_exception;//
//--- Costruisce le fatture da stampare
//--- input:  st_tab_arfa_ini e _fin     da valorizzare num_fatt + data_fatt dalla fattura alla fattura 
//--- out: true = OK, false = non stampata
//---
boolean k_stampato=true, k_sicurezza=true, k_boolean= true
int k_ctr=0, k_n_fatture_prodotte=0
string ki_stampante
long k_riga_fatture=0
st_esito kst_esito 
uo_exception kuo_exception
st_tab_arfa kst_tab_arfa
st_tab_armo kst_tab_armo
st_tab_prodotti kst_tab_prodotti
st_tab_clienti kst_tab_clienti
st_tab_arsp kst_tab_arsp
st_tab_pagam kst_tab_pagam
st_open_w kst_open_w
st_fattura_stampa kst_fattura_stampa
st_fattura_totali kst_fattura_totali
st_fattura_scadenze kst_fattura_scadenze
kuf_clienti kuf1_clienti
kuf_sped kuf1_sped
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility
kuf_armo kuf1_armo
kuf_ausiliari kuf1_ausiliari
//datastore kds_fattura




//declare produci_fattura_selez_c1 cursor for
//               select distinct
//                          NUM_FATT,
//                          DATA_FATT
//                     from  v_arfa_tot_imponibili 
//                     where NUM_FATT   between
//                           :kst_tab_arfa_ini.NUM_FATT and :kst_tab_arfa_fin.NUM_FATT   
//                           and DATA_FATT between
//                           :kst_tab_arfa_ini.DATA_FATT and :kst_tab_arfa_fin.DATA_FATT   
//			       order by 
//					   DATA_FATT,
//					   NUM_FATT 
//				using sqlca;


declare produci_fattura_c1 cursor for
               select
                          ARFA.ID_ARMO,
                          ARFA.NUM_BOLLA_OUT,
                          ARFA.DATA_BOLLA_OUT,
                          ARMO.NUM_INT,
                          ARMO.DATA_INT,
                          ARFA.TIPO_RIGA,
                          ARMO.ART,
                          ARFA.IVA,
                          ARMO.DOSE,
                          ARFA.COLLI,
                          ARFA.COLLI_OUT,
                          ARFA.PESO_KG_OUT,
                          ARFA.PREZZO_U,
                          ARFA.PREZZO_T,
                          ARFA.TIPO_DOC,
                          ARFA.STAMPA,
                          ARFA.TIPO_L,
                          ARFA.COD_PAG,
                          PRODOTTI.DES,
                          PRODOTTI.GRUPPO,
                          ARMO.MAGAZZINO
                     from  ARFA inner join ARMO on
                               ARMO.ID_ARMO         = ARFA.ID_ARMO
						left outer join PRODOTTI on
                               PRODOTTI.CODICE      = ARMO.ART
                     where ARFA.NUM_FATT   = :kst_tab_arfa.NUM_FATT
                           and ARFA.DATA_FATT = :kst_tab_arfa.DATA_FATT
                  union all
               select     0,
                          0,
                          date(0),
                          0,
                          date(0),
                          'V',
                          ' ',
                          ARFA_V.IVA,
                          0,
                          ARFA_V.COLLI,
                          ARFA_V.COLLI,
                          0,
                          ARFA_V.PREZZO_U,
                          ARFA_V.PREZZO_T,
                          ARFA_V.TIPO_DOC,
                          ARFA_V.STAMPA,
                          'C',
                          ARFA_V.COD_PAG,
                          ARFA_V.COMM,
                          0,
                          0
                     from  ARFA_V
                     where ARFA_V.NUM_FATT   = :kst_tab_arfa.NUM_FATT
                           and ARFA_V.DATA_FATT = :kst_tab_arfa.DATA_FATT
			       order by 
                          TIPO_RIGA,
                          NUM_BOLLA_OUT,
					   DATA_BOLLA_OUT,
                         ART,
                         DOSE,
                         PREZZO_U
				using sqlca;
//                     order by 3, 2, 8, 4, 5, 9, 11, 15 



	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""

	
//	//--- controllo anomalie sul num.fattura
//	if isnull(kst_tab_arfa_ini.NUM_FATT) or kst_tab_arfa_ini.NUM_FATT = 0 or isnull(kst_tab_arfa_ini.DATA_FATT) or kst_tab_arfa_ini.DATA_FATT <= kkg_data_zero then
//		kuo_exception = create uo_exception
//		kuo_exception.setmessage( "Numero Fattura non Indicato" )
//		throw kuo_exception
//	end if
//	if isnull(kst_tab_arfa_ini.NUM_FATT) or kst_tab_arfa_ini.NUM_FATT = 0 then
//		kst_tab_arfa_fin.NUM_FATT = kst_tab_arfa_ini.NUM_FATT
//		kst_tab_arfa_fin.DATA_FATT = kst_tab_arfa_ini.DATA_FATT
//	end if
//	if kst_tab_arfa_ini.NUM_FATT > kst_tab_arfa_fin.NUM_FATT  and kst_tab_arfa_ini.DATA_FATT >= kst_tab_arfa_fin.DATA_FATT then
//		kuo_exception = create uo_exception
//		kuo_exception.setmessage( "Numero Fattura iniziale " + string(kst_tab_arfa_ini.NUM_FATT) +" del " + string (kst_tab_arfa_ini.DATA_FATT, "yyyy") & 
//													  + " minore del numero di Fine"+ string(kst_tab_arfa_fin.NUM_FATT) +" del " + string (kst_tab_arfa_fin.DATA_FATT, "yyyy") ) 
//		throw kuo_exception
//	end if

	
//	kidw_produci_fattura.Object.DataWindow.Print.DocumentName = "Fattura_da_" &
//                + trim(string(kst_tab_arfa_ini.NUM_FATT)) + "_a_" + trim(string(kst_tab_arfa_fin.NUM_FATT))


	kuf1_utility = create kuf_utility
	kuf1_armo = create kuf_armo
	kuf1_ausiliari = create kuf_ausiliari 
	kuf1_clienti = create kuf_clienti

	kidw_stampa_fattura.reset()

	if kds_fatture.rowcount() > 0 then
       

		if sqlca.sqlcode = 0 then	
			k_boolean = produci_fattura_open()
			if not k_boolean then
				kst_esito.sqlcode = 0
				kst_esito.sqlerrtext = "Apertura Report Fallita."
				kst_esito.esito = kkg_esito_no_esecuzione
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito )
				throw kuo_exception
			end if
		end if
		
//--------------------------------------- CICLO PRINCIPALE ------------------------------------------------------------------
		for k_riga_fatture = 1 to kds_fatture.rowcount()

			kst_tab_arfa.NUM_FATT = kds_fatture.object.NUM_FATT[k_riga_fatture]
			kst_tab_arfa.DATA_FATT = kds_fatture.object.DATA_FATT[k_riga_fatture]
											  
//--- rileva il tipo documento (NC=nota di credito)
			kst_esito = get_tipo_documento( kst_tab_arfa )
			if kst_esito.esito <> kkg_esito_ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito )
				throw kuo_exception
			end if
	
//--- legge CLIENTE
			kst_esito = get_cliente( kst_tab_arfa )
			if kst_esito.esito <> kkg_esito_ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito )
				throw kuo_exception
			else
				if kst_tab_arfa.clie_3 > 0 and kst_tab_arfa.clie_3 <> kst_tab_clienti.codice then 
					kst_tab_clienti.codice = kst_tab_arfa.clie_3
		//--- reperisce l'indirizzo dal cliente
					kst_esito = kuf1_clienti.leggi_x_fattura( "1",  kst_tab_clienti)
					if kst_esito.esito <> kkg_esito_ok then
						kuo_exception = create uo_exception
						kuo_exception.set_esito( kst_esito )
						throw kuo_exception
					end if
				end if
			end if
			
	//--- legge tipo di pagamento
			kst_esito = get_tipo_pagamento(kst_tab_arfa)
			if kst_esito.esito <> kkg_esito_ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito )
				throw kuo_exception
			end if
			if kst_tab_arfa.COD_PAG > 0 then
				kst_tab_pagam.codice = kst_tab_arfa.cod_pag
				kst_esito = kuf1_ausiliari.tb_select( kst_tab_pagam )
				if kst_esito.esito <> kkg_esito_ok then
					kuo_exception = create uo_exception
					kuo_exception.set_esito( kst_esito )
					throw kuo_exception
				end if
				kuf1_ausiliari.if_isnull_tb(kst_tab_pagam)
			end if
			
	//--- reperisce Metri Cubi di entrata solo se il tipo prezzo a Mt.Cubi
			if kst_tab_arfa.TIPO_L = kuf_listino.ki_tipo_prezzo_a_metro_cubo then
				if kst_tab_arfa.id_armo > 0 then
					kst_tab_armo.id_armo = kst_tab_arfa.id_armo
					kst_esito = kuf1_armo.leggi_riga(  "R", kst_tab_armo )
					if kst_esito.esito <> kkg_esito_ok then
						kuo_exception = create uo_exception
						kuo_exception.set_esito( kst_esito )
						throw kuo_exception
					end if
				end if
				kuf1_armo.if_isnull_armo(kst_tab_armo)
					kst_tab_armo.m_cubi = kst_tab_armo.m_cubi / kst_tab_armo.COLLI_2 * kst_tab_arfa.COLLI
			end if
	
	//--- reperisce dati dalla riga di Bolla
	//		if kst_tab_arfa.id_armo > 0 then
	//			kst_tab_arsp.num_bolla_out = kst_tab_arfa.num_bolla_out
	//			kst_tab_arsp.data_bolla_out = kst_tab_arfa.data_bolla_out
	//			kst_tab_arsp.id_armo = kst_tab_arfa.id_armo
	//			kst_esito = kuf1_sped.select_riga(  kst_tab_arsp )
	//			if kst_esito.esito <> "0" then
	//				kuo_exception.set_esito( kst_esito )
	//				throw kuo_exception
	//			end if
	//			kuf1_sped.if_isnull_riga(kst_tab_arsp)
	//		end if
		
//			kst_tab_clienti.rag_soc_10 = kuf1_utility.u_stringa_pulisci(kst_tab_clienti.rag_soc_10)
//			kst_tab_clienti.rag_soc_11 = kuf1_utility.u_stringa_pulisci(kst_tab_clienti.rag_soc_11)
		
			kst_fattura_stampa.kst_tab_arfa = kst_tab_arfa
			kst_fattura_stampa.kst_tab_clienti = kst_tab_clienti
			kst_fattura_stampa.kst_tab_pagam = kst_tab_pagam
			kst_fattura_stampa.kst_tab_armo = kst_tab_armo
			
			k_boolean = produci_fattura_testa(kst_fattura_stampa)
			if not k_boolean then
				kst_esito.sqlcode = 0
				kst_esito.sqlerrtext = "Fattura: Stampa Testata."
				kst_esito.esito = kkg_esito_no_esecuzione
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito )
				throw kuo_exception
			end if

		
//--- Righe Fattura		
			ki_fattura_riga_corpo=0             //--- resetta il numero di riga di dettaglio
			ki_pag_fattura=1   //--- pagine fattura
			
			open produci_fattura_c1;
			if sqlca.sqlcode = 0 then	

				fetch produci_fattura_c1 into
                          :kst_tab_arfa.ID_ARMO,
                          :kst_tab_arfa.NUM_BOLLA_OUT,
                          :kst_tab_arfa.DATA_BOLLA_OUT,
                          :kst_tab_armo.NUM_INT,
                          :kst_tab_armo.DATA_INT,
                          :kst_tab_arfa.TIPO_RIGA,
                          :kst_tab_armo.ART,
                          :kst_tab_arfa.IVA,
                          :kst_tab_armo.DOSE,
                          :kst_tab_arfa.COLLI,
                          :kst_tab_arfa.COLLI_OUT,
                          :kst_tab_arfa.PESO_KG_OUT,
                          :kst_tab_arfa.PREZZO_U,
                          :kst_tab_arfa.PREZZO_T,
                          :kst_tab_arfa.TIPO_DOC,
                          :kst_tab_arfa.STAMPA,
                          :kst_tab_arfa.TIPO_L,
                          :kst_tab_arfa.COD_PAG,
                          :kst_tab_prodotti.DES,
                          :kst_tab_prodotti.GRUPPO,
                          :kst_tab_armo.MAGAZZINO;

				do while sqlca.sqlcode = 0
		
						kst_fattura_stampa.kst_tab_arfa = kst_tab_arfa
						kst_fattura_stampa.kst_tab_prodotti = kst_tab_prodotti
						kst_fattura_stampa.kst_tab_armo = kst_tab_armo
						k_boolean = produci_fattura_riga(kst_fattura_stampa)
						if not k_boolean then
							kst_esito.sqlcode = 0
							kst_esito.sqlerrtext = "Fattura: Stampa Riga: " + kst_tab_armo.art
							kst_esito.esito = kkg_esito_no_esecuzione
							kuo_exception = create uo_exception
							kuo_exception.set_esito( kst_esito )
							throw kuo_exception
						end if
					
					
						fetch produci_fattura_c1 into
									  :kst_tab_arfa.ID_ARMO,
									  :kst_tab_arfa.NUM_BOLLA_OUT,
									  :kst_tab_arfa.DATA_BOLLA_OUT,
									  :kst_tab_armo.NUM_INT,
									  :kst_tab_armo.DATA_INT,
									  :kst_tab_arfa.TIPO_RIGA,
									  :kst_tab_armo.ART,
									  :kst_tab_arfa.IVA,
									  :kst_tab_armo.DOSE,
									  :kst_tab_arfa.COLLI,
									  :kst_tab_arfa.COLLI_OUT,
									  :kst_tab_arfa.PESO_KG_OUT,
									  :kst_tab_arfa.PREZZO_U,
									  :kst_tab_arfa.PREZZO_T,
									  :kst_tab_arfa.TIPO_DOC,
									  :kst_tab_arfa.STAMPA,
									  :kst_tab_arfa.TIPO_L,
									  :kst_tab_arfa.COD_PAG,
									  :kst_tab_prodotti.DES,
									  :kst_tab_prodotti.GRUPPO,
									  :kst_tab_armo.MAGAZZINO;
	
				loop

				close produci_fattura_c1;

			end if
//--- Coda Fattura: TOTALI + SCADENZE

//--- Calcola Totali
			kst_esito = get_totali( kst_tab_arfa, kst_fattura_totali )
			if kst_esito.esito <> kkg_esito_ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito )
				throw kuo_exception
			end if
			produci_fattura_piede_totali (kst_fattura_totali)

//--- stampa NOTE			
			kst_esito = get_note( kst_tab_arfa )
			if kst_esito.esito = kkg_esito_ok then
				produci_fattura_piede_note (kst_tab_arfa)		
			else
				if kst_esito.esito = kkg_esito_db_ko then
					kuo_exception = create uo_exception
					kuo_exception.set_esito( kst_esito )
					throw kuo_exception
				end if
			end if
			
			
//--- Piglia le Scadenze 
			kst_esito = get_scadenze( kst_tab_arfa, kst_fattura_scadenze )
			if kst_esito.esito <> kkg_esito_ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito )
				throw kuo_exception
			end if
			produci_fattura_piede_scadenze (kst_fattura_scadenze)

			k_n_fatture_prodotte++

//---
		next
//--------------------------------------- FINE CICLO PRINCIPALE ------------------------------------------------------------------
	
	
	end if
	
	destroy kuf1_armo
	destroy kuf1_utility
	destroy kuf1_ausiliari
	destroy kuf1_clienti






return k_n_fatture_prodotte

end function

public function integer get_fatture_da_stampare (ds_fatture kds_fatture) throws uo_exception;//
//--- Aggiorna il flag si "STAMPA" sulle fatture
//--- input:  datastore ds_fatture con l'elenco delle fatture da aggiornare
//--- out: numero fatture aggiornate
//---
int k_ctr=0, k_n_fatture=0
long k_riga_fatture=0
date k_data_meno3mesi, k_dataoggi
string k_dataoggix
st_esito kst_esito 
uo_exception kuo_exception
st_tab_arfa kst_tab_arfa
kuf_base kuf1_base




	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""

  	declare  c_get_fatture_da_stampare  cursor for
	         SELECT
				arfa.num_fatt,   
				arfa.data_fatt 
				FROM arfa 
				 where  (arfa.data_fatt > :k_data_meno3mesi 
						 and (arfa.stampa is null or arfa.stampa <> 'S')) 
				 group by 
					 arfa.data_fatt 
					,arfa.num_fatt   
				using sqlca;
	

//--- data oggi
	kuf1_base = create kuf_base
	k_dataoggix = mid(kuf1_base.prendi_dato_base("dataoggi"),2)
	destroy kuf1_base
	if isdate(k_dataoggix) then
		k_dataoggi = date(k_dataoggix)
	else
		k_dataoggi = today()
	end if
	
//--- data oggi -3 mesi
	k_data_meno3mesi = relativedate(kg_dataoggi, -1190)
	
	
	open c_get_fatture_da_stampare;

	if sqlca.sqlcode = 0 then

		fetch c_get_fatture_da_stampare 
				into
				:kst_tab_arfa.NUM_FATT
				,:kst_tab_arfa.DATA_FATT;
		
		do while sqlca.sqlcode = 0 

			k_riga_fatture = kds_fatture.insertrow(0)
			
			kds_fatture.object.NUM_FATT[k_riga_fatture] = kst_tab_arfa.NUM_FATT  
			kds_fatture.object.DATA_FATT[k_riga_fatture] = kst_tab_arfa.DATA_FATT 
			kds_fatture.object.sel[k_riga_fatture] = 1

			fetch c_get_fatture_da_stampare 
				into
				:kst_tab_arfa.NUM_FATT
				,:kst_tab_arfa.DATA_FATT;
				
		loop
	
		close c_get_fatture_da_stampare;
		
	end if
	
//--- se tutto ok cancella anche le altre righe
	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		if isnull(kst_tab_arfa.num_fatt) then kst_tab_arfa.num_fatt = 0
		if isnull(kst_tab_arfa.data_fatt) then kst_tab_arfa.data_fatt = date(0)
		kst_esito.SQLErrText = &
				"Errore durante lettura fatture da stampare ~n~r" &
							+ "Ultima fattura letta: " + string(kst_tab_arfa.num_fatt, "####0") + " del " &
							+ string(kst_tab_arfa.data_fatt, "dd.mm.yyyy") &	
							+ " ~n~rErrore-tab.ARFA:"	+ trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito_db_ko
		kuo_exception = create uo_exception
		kuo_exception.set_esito( kst_esito)
		throw kuo_exception
	end if



return k_n_fatture

end function

public function st_esito produci_fattura_set_dw_loghi (ref datawindow kdw_1);//---
//--- Imposta i loghi in Fattura
//---
string k_rcx, k_file
long k_riga
int k_rc
st_profilestring_ini kst_profilestring_ini
st_esito kst_esito



kst_esito.esito = KKG_ESITO_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""

//--- Loghi e loghetti
//--- path per reperire le ico del drag e drop
	if ki_path_risorse = "" then
		kst_profilestring_ini.operazione = "1"
		kst_profilestring_ini.valore = "\"
		kst_profilestring_ini.titolo = "risorse_grafiche" 
		kst_profilestring_ini.nome = "arch_graf"
		kuf1_data_base.profilestring_ini(kst_profilestring_ini)
		if kst_profilestring_ini.esito = "0" then
			ki_path_risorse = trim(kst_profilestring_ini.valore) 
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Operazione interrotta: ~n~r" + "cartella risorsa grafica non trovata (stampa_attestato_prepara)"
			kst_esito.esito = KKG_ESITO_blok
		end if
	end if
			
	if len(trim(ki_path_risorse)) > 0 then
		k_rcx=kdw_1.Modify("p_logo.Filename='" + ki_path_risorse + "\" + "logo_orig_blu.JPG" + "'")
	//				kdw_attestato.Object.p_logo.Filename="'" + ki_path_risorse + "'"
//		k_file = trim(kst_profilestring_ini.valore) + "\" + "logo_iso_blu.JPG" //trim(kdw_attestato.Describe("txt_p_logo_iso.text"))   //"logo_iso_certiquality2006.bmp"
		k_rcx=kdw_1.Modify("p_logo_iso.Filename='" +  ki_path_risorse + "\" + "logo_iso_blu.JPG"  + "'")
	end if
	

return kst_esito

end function

public function st_esito produci_fattura_set_dw_loghi (ref datastore kdw_1);//---
//--- Imposta i loghi in Fattura
//---
string k_rcx, k_file
long k_riga
int k_rc
st_profilestring_ini kst_profilestring_ini
st_esito kst_esito



kst_esito.esito = KKG_ESITO_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""

//--- Loghi e loghetti
//--- path per reperire le ico del drag e drop
	if ki_path_risorse = "" then
		kst_profilestring_ini.operazione = "1"
		kst_profilestring_ini.valore = "\"
		kst_profilestring_ini.titolo = "risorse_grafiche" 
		kst_profilestring_ini.nome = "arch_graf"
		kuf1_data_base.profilestring_ini(kst_profilestring_ini)
		if kst_profilestring_ini.esito = "0" then
			ki_path_risorse = trim(kst_profilestring_ini.valore) 
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Operazione interrotta: ~n~r" + "cartella risorsa grafica non trovata (stampa_attestato_prepara)"
			kst_esito.esito = KKG_ESITO_blok
		end if
	end if
			
	if len(trim(ki_path_risorse)) > 0 then
		k_rcx=kdw_1.Modify("p_logo.Filename='" + ki_path_risorse + "\" + "logo_orig_blu.JPG" + "'")
	//				kdw_attestato.Object.p_logo.Filename="'" + ki_path_risorse + "'"
//		k_file = trim(kst_profilestring_ini.valore) + "\" + "logo_iso_blu.JPG" //trim(kdw_attestato.Describe("txt_p_logo_iso.text"))   //"logo_iso_certiquality2006.bmp"
		k_rcx=kdw_1.Modify("p_logo_iso.Filename='" + trim(kst_profilestring_ini.valore) + "\" + "logo_iso_blu.JPG"  + "'")
	end if
	

return kst_esito

end function

on kuf_fatt.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_fatt.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;//
if isvalid(kidw_stampa_fattura) then destroy kidw_stampa_fattura


end event

event constructor;//
int k_rc=0

	kidw_stampa_fattura = create datastore
//	kidw_stampa_fattura.Object.DataWindow.ReadOnly='Yes'
	kidw_stampa_fattura.dataobject = ki_dw_stampa_fattura
	k_rc=kidw_stampa_fattura.SetTransObject(SQLCA)
	kidw_stampa_fattura.reset()

end event

