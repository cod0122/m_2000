$PBExportHeader$kuf_e1.sru
forward
global type kuf_e1 from kuf_parent
end type
end forward

global type kuf_e1 from kuf_parent
end type
global kuf_e1 kuf_e1

forward prototypes
public function boolean link_call (ref datastore ads_1, string a_campo_link) throws uo_exception
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
public function boolean u_if_e1_enabled () throws uo_exception
public function boolean link_call_anteprima (ref datastore ads_link, string a_campo_link) throws uo_exception
public function st_esito anteprima (ref datastore kdw_anteprima, st_e1_anteprima kst_e1_anteprima)
public function st_esito anteprima_lav (ref datastore kdw_anteprima, st_e1_anteprima kst_e1_anteprima)
public function st_esito anteprima_apid (ref datastore kdw_anteprima, st_e1_anteprima kst_e1_anteprima)
end prototypes

public function boolean link_call (ref datastore ads_1, string a_campo_link) throws uo_exception;//=== 
//====================================================================
//=== Attiva LINK cliccato 
//===
//=== Par. Inut: 
//===               datastore su cui è stato attivato il LINK
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
boolean k_return=false



	if ads_1.rowcount() > 0 then
		if ads_1.getrow() > 0 then  
			k_return = link_call_anteprima(ads_1, a_campo_link)
		end if
	end if


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
boolean k_return=false
datastore kds_1


	kds_1 = create datastore
	kds_1.dataobject = adw_link.dataobject

	if adw_link.rowcount() > 0 then
		adw_link.rowscopy(1, adw_link.rowcount(), primary!, kds_1, 1, primary!)
		if adw_link.getrow() >0 then  
			kds_1.setrow(adw_link.getrow())
			k_return = link_call_anteprima(kds_1, a_campo_link)
		end if
	end if


return k_return 
end function

public function boolean u_if_e1_enabled () throws uo_exception;//
//====================================================================
//=== Check se E1 è stato attivato
//=== 
//=== inp: 
//=== out:
//=== Ritorna: TRUE = interfaccia con E1 attiva !!
//=== lancia exception x errore grave
//====================================================================
boolean k_return = false
st_esito kst_esito
kuf_base kuf1_base


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kuf1_base = create kuf_base
	
//--- verifica se E1 attivato
	k_return = kuf1_base.if_e1_enabled( )


catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kuf1_base) then destroy kuf1_base
	
end try

return k_return

end function

public function boolean link_call_anteprima (ref datastore ads_link, string a_campo_link) throws uo_exception;//--- 
//------------------------------------------------------------------
//--- Attiva LINK cliccato 
//---
//--- Par. Inut: 
//---               datawindow su cui è stato attivato il LINK
//---               nome campo di LINK
//--- 
//--- Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Grave
//---                                     2=Errore gestito
//---                                     3=altro errore
//---                                     100=Non trovato 
//--- 
//------------------------------------------------------------------
//
//--- 
long k_rc
long k_riga=0
boolean k_return=true
string k_dataobject, k_id_programma
st_e1_anteprima kst_e1_anteprima
st_esito kst_esito
datastore kdsi_elenco_output   //ds da passare alla windows di elenco
st_open_w kst_open_w 
kuf_menu_window kuf1_menu_window
kuf_sicurezza kuf1_sicurezza



SetPointer(kkg.pointer_attesa)

kdsi_elenco_output = create datastore

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

k_riga = ads_link.getrow()

kst_open_w.flag_modalita = kkg_flag_modalita.visualizzazione

choose case a_campo_link

	case "b_asn", "e1doco", "e1rorn"
		if ads_link.getrow() > 0 then
			kst_e1_anteprima.apid = string(ads_link.getitemnumber(ads_link.getrow(), "id_meca"))
			kst_e1_anteprima.doco = ads_link.getitemnumber(ads_link.getrow(), "e1doco")
			if isnull(kst_e1_anteprima.doco) then kst_e1_anteprima.doco = 0
			if NOT ads_link.Describe("e1rorn.Name") = "!" then
			//if kGuf_data_base.u_dw_if_col_exist(ads_link, "e1rorn") then
				kst_e1_anteprima.rorn = ads_link.getitemnumber(ads_link.getrow(), "e1rorn")
			end if
			if isnull(kst_e1_anteprima.rorn) then kst_e1_anteprima.rorn = 0
			if trim(kst_e1_anteprima.apid) > " " then
				kst_open_w.key1 = "Dati Lotto da E1 (ASN: " + trim(kst_e1_anteprima.apid) + " WO: " + string(kst_e1_anteprima.doco)+ ") " 
				k_id_programma = this.get_id_programma(kkg_flag_modalita.visualizzazione)
			else
				k_return = false
			end if
		else
			k_return = false
		end if

	case "b_e1doco_lav"
		if ads_link.getrow() > 0 then
			kst_e1_anteprima.doco = ads_link.getitemnumber(ads_link.getrow(), "e1doco")
			if isnull(kst_e1_anteprima.doco) then kst_e1_anteprima.doco = 0
//			kst_e1_anteprima.rorn = ads_link.getitemnumber(ads_link.getrow(), "e1rorn")
//			if isnull(kst_e1_anteprima.rorn) then kst_e1_anteprima.rorn = 0
			if kst_e1_anteprima.doco > 0 then
				kst_open_w.key1 = "Dati Lavorazione trasmessi a E1 per il WO: " + string(kst_e1_anteprima.doco)+ ") " 
				k_id_programma = this.get_id_programma(kkg_flag_modalita.visualizzazione)
			else
				k_return = false
			end if
		else
			k_return = false
		end if

	case "b_e1apid_dett"
		if ads_link.getrow() > 0 then
			kst_e1_anteprima.apid = ads_link.getitemstring(ads_link.getrow(), "ehapid")
			if isnull(kst_e1_anteprima.apid) then kst_e1_anteprima.apid = ""
			if trim(kst_e1_anteprima.apid) > " " then
				kst_open_w.key1 = "Dati di carico trasmessi a E1 per il codice APID: " + trim(kst_e1_anteprima.apid)+ ") " 
				k_id_programma = this.get_id_programma(kkg_flag_modalita.visualizzazione)
			else
				k_return = false
			end if
		else
			k_return = false
		end if

end choose


if k_return then

//	kst_open_w.id_programma = k_id_programma 
//	
//	//--- controlla se utente autorizzato alla funzione in atto
//	kuf1_sicurezza = create kuf_sicurezza
//	k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
//	destroy kuf1_sicurezza
	
	if not k_return then
	
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Funzione non autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
	
	else
			kdsi_elenco_output.dataobject = k_dataobject		
			kdsi_elenco_output.settransobject(kguo_sqlca_db_e1)
	
			kdsi_elenco_output.reset()	
			
			choose case a_campo_link
						
			case "b_asn", "e1doco", "e1rorn"
				kst_esito = anteprima ( kdsi_elenco_output, kst_e1_anteprima )
			
			case "b_e1doco_lav"
				kst_esito = anteprima_lav ( kdsi_elenco_output, kst_e1_anteprima )
			
			case "b_e1apid_dett"
				kst_esito = anteprima_apid ( kdsi_elenco_output, kst_e1_anteprima )
				
			end choose
			if kst_esito.esito <> kkg_esito.ok then
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito)
				throw kguo_exception
			end if
			if isvalid(kdsi_elenco_output) then k_dataobject = kdsi_elenco_output.dataobject

	
//		else
//			kst_esito.sqlcode = 0
//			kst_esito.SQLErrText = "Nessuna dato da visualizzare: ~n~r" + "nessun codice indicato"
//			kst_esito.esito = kkg_esito.not_fnd
//			
//		end if
	end if
	


	if kdsi_elenco_output.rowcount() > 0 then
	
		
	//--- chiamare la window di elenco
	//
	//--- Parametri : 
	//--- struttura st_open_w
		kst_open_w.id_programma =kkg_id_programma_elenco
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
		kst_open_w.settrans = "db_e1"
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(kst_open_w)
		destroy kuf1_menu_window


	else
		
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		kguo_exception.setmessage(u_get_errmsg_nontrovato(kst_open_w.flag_modalita ))
		throw kguo_exception
		
		
	end if

end if

SetPointer(kkg.pointer_default)


return k_return

end function

public function st_esito anteprima (ref datastore kdw_anteprima, st_e1_anteprima kst_e1_anteprima);//
//--- 
//------------------------------------------------------------------
//--- Operazione di Anteprima (Testata ASN)
//---
//--- Par. Inut: 
//---               datawindow su cui fare l'anteprima
//---               dati tabella per estrazione dell'anteprima
//--- 
//--- Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Grave
//---                                     2=Errore gestito
//---                                     3=altro errore
//---                                     100=Non trovato 
//--- 
//------------------------------------------------------------------
//
long k_rc
boolean k_return=true
long k_nr_righe=0
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//kst_open_w = kst_open_w
//kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
//kst_open_w.id_programma = this.get_id_programma(kst_open_w.flag_modalita)
//
////--- controlla se utente autorizzato alla funzione in atto
//kuf1_sicurezza = create kuf_sicurezza
//k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
//destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if trim(kst_e1_anteprima.apid) > " " then

//--- retrive dell'attestato 
	
		try 

			kguo_sqlca_db_e1.db_connetti( )			
			kdw_anteprima.dataobject = "d_e1_dati_gen" //"d_e1_wo_f5548014_l_x_doco"
			kdw_anteprima.settransobject(kguo_sqlca_db_e1)
	
			kdw_anteprima.reset()	
			k_nr_righe = kdw_anteprima.retrieve(kst_e1_anteprima.apid, kkg.e1mcu)

		catch (uo_exception kuo_exception)
				kst_esito = kuo_exception.get_st_esito()

		finally
				
		end try
		

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna dato di E-ONE da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = kkg_esito.err_logico
		
	end if
end if


return kst_esito

end function

public function st_esito anteprima_lav (ref datastore kdw_anteprima, st_e1_anteprima kst_e1_anteprima);//
//--- 
//------------------------------------------------------------------
//--- Operazione di Anteprima (Testata ASN)
//---
//--- Par. Inut: 
//---               datawindow su cui fare l'anteprima
//---               dati tabella per estrazione dell'anteprima
//--- 
//--- Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Grave
//---                                     2=Errore gestito
//---                                     3=altro errore
//---                                     100=Non trovato 
//--- 
//------------------------------------------------------------------
//
long k_rc
boolean k_return=true
long k_nr_righe=0
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//kst_open_w = kst_open_w
//kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
//kst_open_w.id_programma = this.get_id_programma(kst_open_w.flag_modalita)
//
////--- controlla se utente autorizzato alla funzione in atto
//kuf1_sicurezza = create kuf_sicurezza
//k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
//destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_e1_anteprima.doco > 0 then

//--- retrive dell'attestato 
	
		try 

			kguo_sqlca_db_e1.db_connetti( )			
			kdw_anteprima.dataobject = "d_e1_wo_f5548014_l_x_doco" //"d_e1_wo_f5548014_l_x_doco"
			kdw_anteprima.settransobject(kguo_sqlca_db_e1)
	
			kdw_anteprima.reset()	
			k_nr_righe = kdw_anteprima.retrieve(kst_e1_anteprima.doco)

		catch (uo_exception kuo_exception)
				kst_esito = kuo_exception.get_st_esito()

		finally
				
		end try
		

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna dato di lavorazione da E-ONE da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = kkg_esito.err_logico
		
	end if
end if


return kst_esito

end function

public function st_esito anteprima_apid (ref datastore kdw_anteprima, st_e1_anteprima kst_e1_anteprima);//
//--- 
//------------------------------------------------------------------
//--- Operazione di Anteprima (Testata ASN)
//---
//--- Par. Inut: 
//---               datawindow su cui fare l'anteprima
//---               dati tabella per estrazione dell'anteprima
//--- 
//--- Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Grave
//---                                     2=Errore gestito
//---                                     3=altro errore
//---                                     100=Non trovato 
//--- 
//------------------------------------------------------------------
//
long k_rc
boolean k_return=true
long k_nr_righe=0
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//kst_open_w = kst_open_w
//kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
//kst_open_w.id_programma = this.get_id_programma(kst_open_w.flag_modalita)
//
////--- controlla se utente autorizzato alla funzione in atto
//kuf1_sicurezza = create kuf_sicurezza
//k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
//destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if trim(kst_e1_anteprima.apid) > " " then

//--- retrive dell'attestato 
	
		try 

			kguo_sqlca_db_e1.db_connetti( )			
			kdw_anteprima.dataobject = "d_e1_asn_f5547014_l"
			kdw_anteprima.settransobject(kguo_sqlca_db_e1)
	
			kdw_anteprima.reset()	
			k_nr_righe = kdw_anteprima.retrieve(kst_e1_anteprima.apid)

		catch (uo_exception kuo_exception)
				kst_esito = kuo_exception.get_st_esito()

		finally
				
		end try
		

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna dato di dettaglio da E-ONE da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = kkg_esito.err_logico
		
	end if
end if


return kst_esito

end function

on kuf_e1.create
call super::create
end on

on kuf_e1.destroy
call super::destroy
end on

