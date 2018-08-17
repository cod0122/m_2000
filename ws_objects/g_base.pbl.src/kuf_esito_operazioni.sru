$PBExportHeader$kuf_esito_operazioni.sru
forward
global type kuf_esito_operazioni from kuf_parent
end type
end forward

global type kuf_esito_operazioni from kuf_parent
end type
global kuf_esito_operazioni kuf_esito_operazioni

type variables
//
datastore kids_esito_operazioni

//--- tipi di operazione
constant string kki_tipo_operazione_generica = "XX"
constant string kki_tipo_operazione_ctco_to_listino = "CL"
constant string kki_tipo_operazione_dpco_to_listino = "DP"
constant string kki_tipo_operazione_rdco_to_listino = "RD"
constant string kki_tipo_operazione_pubblica_web_utenti = "WU"
constant string kki_tipo_operazione_esporta_documenti = "ED"
constant string kki_tipo_operazione_check_tabelle = "TB"
constant string kki_tipo_operazione_dup_listini = "DL"
constant string kki_tipo_operazione_meca_chiusura = "MC"

private st_tab_esito_operazioni kist_tab_esito_operazioni, kist_tab_esito_operazioni_array[]
private long ki_tab_add_riga=0
end variables

forward prototypes
public function datetime tb_add (st_tab_esito_operazioni kst_tab_esito_operazioni) throws uo_exception
public function boolean tb_add_riga (string k_esito, boolean k_esito_ko) throws uo_exception
public function st_esito anteprima (datastore kdw_anteprima, st_tab_esito_operazioni kst_tab_esito_operazioni)
public function boolean tb_delete_obsoleti (st_tab_esito_operazioni kst_tab_esito_operazioni) throws uo_exception
public subroutine inizializza (string tipo_operazione) throws uo_exception
public function boolean link_call (ref datastore ads_1, string a_campo_link) throws uo_exception
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
end prototypes

public function datetime tb_add (st_tab_esito_operazioni kst_tab_esito_operazioni) throws uo_exception;//
//--- Consolida su DB le righe aggiunte in array
//--- Riempire l'array kist_tab_esito_operazioni_array[]  con i valori da registrare in tabella
//---
//--- inp: st_tab_esito_operazioni.st_tab_g_0.esegui_commit
//--- out: Timestamp dell'operazione
//--- lancia exception
//
datetime k_return=datetime(date(0))
long k_righe=0, k_ctr=0, k_rc=0, k_ctr1=0
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()
//kguo_exception.set_esito(kst_esito)

//kst_open_w = kst_open_w
//kst_open_w.flag_modalita = kkg_flag_modalita.inserimento
//kst_open_w.id_programma = get_id_programma(kst_open_w.flag_modalita ) 
//
////--- controlla se utente autorizzato alla funzione in atto
//kuf1_sicurezza = create kuf_sicurezza
//k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
//destroy kuf1_sicurezza
//
//if not k_return then
//
//	kst_esito.sqlcode = sqlca.sqlcode
//	kst_esito.SQLErrText = "Operazione di Inserimento Esiti non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
//	kst_esito.esito = kkg_esito.no_aut
//
//else

//try
	
	if ki_tab_add_riga > 0 then
		kids_esito_operazioni.reset()
		for k_ctr1 = 1 to ki_tab_add_riga
			
			k_ctr = kids_esito_operazioni.insertrow(0) 
			kids_esito_operazioni.setitem(k_ctr1, "id_esito_operazioni", 0)
			kids_esito_operazioni.setitem(k_ctr1, "tipo_operazione", kist_tab_esito_operazioni_array[k_ctr].tipo_operazione )
			kids_esito_operazioni.setitem(k_ctr1, "ts_operazione", kist_tab_esito_operazioni_array[k_ctr].ts_operazione )
			kids_esito_operazioni.setitem(k_ctr1, "ts_esito", kist_tab_esito_operazioni_array[k_ctr].ts_esito )
			kids_esito_operazioni.setitem(k_ctr1, "x_datins", kist_tab_esito_operazioni_array[k_ctr].x_datins ) 
			kids_esito_operazioni.setitem(k_ctr1, "x_utente", kist_tab_esito_operazioni_array[k_ctr].x_utente ) 
			kids_esito_operazioni.setitem(k_ctr1, "esito_ko", kist_tab_esito_operazioni_array[k_ctr].esito_ko )
			kids_esito_operazioni.setitem(k_ctr1, "esito", kist_tab_esito_operazioni_array[k_ctr].esito )
			
		end for

//--- Aggiorna!!!		
		k_righe = kids_esito_operazioni.update()
	
		if k_righe < 0 then 
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlerrtext = "Errore durante inserimento Esito Operazione (tab. esito_operazioni) : " + string(k_righe)
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
			
//--- azzera il contatore di righe da aggiornare		
		ki_tab_add_riga = 0
	
		if k_righe > 0 then
			if kst_tab_esito_operazioni.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_esito_operazioni.st_tab_g_0.esegui_commit) then
				kst_esito = kGuf_data_base.db_commit_1( )
				if kst_esito.esito = kkg_esito.ok then
					k_return = kist_tab_esito_operazioni_array[1].ts_operazione 
				else
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
				
				end if
			end if
		end if
		
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Nessun Esito Operazione da registrare in archivio (tab. esito_operazioni) "
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//catch (uo_exception kuo_exception)
//	if k_righe > 0 then
//		kGuf_data_base.db_rollback_1( )
//	end if
//	throw kuo_exception
//	
//end try



return k_return

end function

public function boolean tb_add_riga (string k_esito, boolean k_esito_ko) throws uo_exception;//
//--- Aggiunge una riga all'array da scrivere poi in tabella con la funzione tb_add
//---
//--- inp: stringa con l'ESITO, la comunicazione da scrivere, il tipo di esito se TRUE=esito di errore
//--- out: TRUE = ok
//--- lancia exception
//
boolean k_return=false
//st_open_w kst_open_w
//kuf_sicurezza kuf1_sicurezza



//kst_esito.esito = kkg_esito.ok
//kst_esito.sqlcode = 0
//kst_esito.SQLErrText = ""
//kst_esito.nome_oggetto = this.classname()
//kguo_exception.set_esito(kst_esito)

//kst_open_w = kst_open_w
//kst_open_w.flag_modalita = kkg_flag_modalita.inserimento
//kst_open_w.id_programma = get_id_programma(kst_open_w.flag_modalita ) 
//
////--- controlla se utente autorizzato alla funzione in atto
//kuf1_sicurezza = create kuf_sicurezza
//k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
//destroy kuf1_sicurezza
//
//if not k_return then
//
//	kst_esito.sqlcode = sqlca.sqlcode
//	kst_esito.SQLErrText = "Operazione di Inserimento Esiti non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
//	kst_esito.esito = kkg_esito.no_aut
//
//else

try
	if len(trim(k_esito)) > 0 then

		ki_tab_add_riga++
		kist_tab_esito_operazioni_array[ki_tab_add_riga].tipo_operazione = kist_tab_esito_operazioni.tipo_operazione
		kist_tab_esito_operazioni_array[ki_tab_add_riga].ts_operazione = kist_tab_esito_operazioni.ts_operazione 
		kist_tab_esito_operazioni_array[ki_tab_add_riga].ts_esito = kGuf_data_base.prendi_dataora( )
		kist_tab_esito_operazioni_array[ki_tab_add_riga].x_datins = kGuf_data_base.prendi_x_datins( )
		kist_tab_esito_operazioni_array[ki_tab_add_riga].x_utente = kGuf_data_base.prendi_x_utente( )
		kist_tab_esito_operazioni_array[ki_tab_add_riga].esito = (k_esito)
		
		if k_esito_ko then 
			kist_tab_esito_operazioni_array[ki_tab_add_riga].esito_ko = "S" 
		else
			kist_tab_esito_operazioni_array[ki_tab_add_riga].esito_ko = "N" 
		end if 
		
		k_return=true
		
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

//end if


return k_return

end function

public function st_esito anteprima (datastore kdw_anteprima, st_tab_esito_operazioni kst_tab_esito_operazioni);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datastore di anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: come Standard
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
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
//kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.anteprima) 
//
////--- controlla se utente autorizzato alla funzione in atto
//kuf1_sicurezza = create kuf_sicurezza
//k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
//destroy kuf1_sicurezza
//
//if not k_return then
//
//	kst_esito.sqlcode = sqlca.sqlcode
//	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
//	kst_esito.esito = kkg_esito.no_aut
//
//else

	if isvalid(kdw_anteprima)  then
		if kdw_anteprima.dataobject = "d_esito_operazioni_anteprima"  then
			if kdw_anteprima.object.esito_operazioni_ts_operazione[1] = kst_tab_esito_operazioni.ts_operazione then
				kst_tab_esito_operazioni.ts_operazione = datetime(date(0))
			end if
		end if
	end if

	if date(kst_tab_esito_operazioni.ts_operazione) > date(0) then
	
//			kdw_anteprima.dataobject = "d_esito_operazioni_l"		
			kdw_anteprima.dataobject = "d_esito_operazioni_anteprima"		
			kdw_anteprima.settransobject(sqlca)
	
//			kuf1_utility = create kuf_utility
//			kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
//			destroy kuf1_utility
	
			kdw_anteprima.reset()	
	//--- retrive 
			k_rc=kdw_anteprima.retrieve(kst_tab_esito_operazioni.ts_operazione )  //esempio di come si aspetta il datetime: 24/12/2009 16.59.33
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessun Esito operazione da visualizzare: ~n~r" + "nessun Codice indicato"
			kst_esito.esito = kkg_esito.blok
			
		end if
//end if


return kst_esito

end function

public function boolean tb_delete_obsoleti (st_tab_esito_operazioni kst_tab_esito_operazioni) throws uo_exception;//
//====================================================================
//=== 
//=== Cancella Esiti vecchi di 6 mesi x tipo_operazione
//=== 
//=== Inp: st_tab_esito_operazioni.tipo_operazione
//=== Ritorna: TRUE = OK
//===                   
//=== Lancia EXCEPTION x errore
//=== 
//====================================================================
//
boolean k_return=false
date k_data_delete
st_esito kst_esito
int k_ctr=0


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_esito_operazioni.ts_operazione = datetime(relativedate(kg_dataoggi, -180))

//--- 
	delete 
		 from esito_operazioni
		 WHERE ts_operazione < :kst_tab_esito_operazioni.ts_operazione
		             and tipo_operazione = :kst_tab_esito_operazioni.tipo_operazione
		 using sqlca;
		 
   if sqlca.sqlcode <> 0 then
	   if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in Pulizia Esiti, " + kst_esito.nome_oggetto + ", ~n~r" + trim(sqlca.SQLErrText) 

			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		end if
	end if

	if sqlca.sqlcode < 0 then
		if kst_tab_esito_operazioni.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_esito_operazioni.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
	else
		if kst_tab_esito_operazioni.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_esito_operazioni.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	end if

k_return=true

return k_return

end function

public subroutine inizializza (string tipo_operazione) throws uo_exception;//
//--- inizializzo i dati ESITO uguali per tutta l'operazione in corso
//--- 
//--- inp: tipo_operazione (solo tra i valori richiesti)
//
st_tab_esito_operazioni kst_tab_esito_operazioni


kist_tab_esito_operazioni.ts_operazione = kGuf_data_base.prendi_dataora( )
kist_tab_esito_operazioni.tipo_operazione = tipo_operazione

ki_tab_add_riga = 0

try
	
	kst_tab_esito_operazioni = kist_tab_esito_operazioni
	
//--- pulizia dei vecchi record x Tipo Operazione
	kst_tab_esito_operazioni.st_tab_g_0.esegui_commit = "N"
 	tb_delete_obsoleti(kst_tab_esito_operazioni)
	 
catch (uo_exception kuo_exception)
	throw kuo_exception
	 
end try
end subroutine

public function boolean link_call (ref datastore ads_1, string a_campo_link) throws uo_exception;//
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
boolean k_return=true
st_tab_esito_operazioni kst_tab_esito_operazioni
st_esito kst_esito
uo_exception kuo_exception
datastore kdsi_elenco_output   //ds da passare alla windows di elenco
st_open_w kst_open_w 
pointer kp_oldpointer



kp_oldpointer = SetPointer(hourglass!)


kdsi_elenco_output = create datastore

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


choose case a_campo_link

	case "esito_operazioni_ts_operazione"
		uo_d_std_1 kk
		kst_tab_esito_operazioni.ts_operazione = ads_1.getitemdatetime(ads_1.getrow(), a_campo_link)
		if date(kst_tab_esito_operazioni.ts_operazione) > date(0) then
			kst_esito = this.anteprima( kdsi_elenco_output, kst_tab_esito_operazioni)
			if kst_esito.esito <> kkg_esito.ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito)
				throw kuo_exception
			end if
			kst_open_w.key1 = "Log esiti Operazione del " + string(kst_tab_esito_operazioni.ts_operazione, "dd/mm/yyyy" ) + "  " &
			                                                                       + string(kst_tab_esito_operazioni.ts_operazione, "hh:mm" ) + " " 
		else
			k_return = false
		end if

end choose

if k_return then

	if kdsi_elenco_output.rowcount() > 0 then
	
		
	//--- chiamare la window di elenco
	//
	//=== Parametri : 
	//=== struttura st_open_w
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
		kst_open_w.id_programma = kkg_id_programma_elenco //get_id_programma( kst_open_w.flag_modalita ) //kkg_id_programma.elenco
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
		kst_open_w.flag_leggi_dw = " "
		kst_open_w.flag_cerca_in_lista = " "
		kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = kGuf_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key12_any = kdsi_elenco_output
		kst_open_w.flag_where = " "
//		kuf1_menu_window = create kuf_menu_window 
		kGuf_menu_window.open_w_tabelle(kst_open_w)
//		destroy kuf1_menu_window


	else
		
		kuo_exception = create uo_exception
		kuo_exception.setmessage( "Nessun valore disponibile. " )
		throw kuo_exception
		
		
	end if

end if

SetPointer(kp_oldpointer)



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
boolean k_return=true
st_tab_esito_operazioni kst_tab_esito_operazioni
st_esito kst_esito
uo_exception kuo_exception
datastore kdsi_elenco_output   //ds da passare alla windows di elenco
st_open_w kst_open_w 
pointer kp_oldpointer



kp_oldpointer = SetPointer(hourglass!)


kdsi_elenco_output = create datastore

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


choose case a_campo_link

	case "esito_operazioni_ts_operazione"
		uo_d_std_1 kk
		kst_tab_esito_operazioni.ts_operazione = adw_link.getitemdatetime(adw_link.getrow(), a_campo_link)
		if date(kst_tab_esito_operazioni.ts_operazione) > date(0) then
			kst_esito = this.anteprima( kdsi_elenco_output, kst_tab_esito_operazioni)
			if kst_esito.esito <> kkg_esito.ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito)
				throw kuo_exception
			end if
			kst_open_w.key1 = "Log esiti Operazione del " + string(kst_tab_esito_operazioni.ts_operazione, "dd/mm/yyyy" ) + "  " &
			                                                                       + string(kst_tab_esito_operazioni.ts_operazione, "hh:mm" ) + " " 
		else
			k_return = false
		end if

end choose

if k_return then

	if kdsi_elenco_output.rowcount() > 0 then
	
		
	//--- chiamare la window di elenco
	//
	//=== Parametri : 
	//=== struttura st_open_w
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
		kst_open_w.id_programma = kkg_id_programma_elenco //get_id_programma( kst_open_w.flag_modalita ) //kkg_id_programma.elenco
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
		kst_open_w.flag_leggi_dw = " "
		kst_open_w.flag_cerca_in_lista = " "
		kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = kGuf_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key12_any = kdsi_elenco_output
		kst_open_w.flag_where = " "
//		kuf1_menu_window = create kuf_menu_window 
		kGuf_menu_window.open_w_tabelle(kst_open_w)
//		destroy kuf1_menu_window


	else
		
		kuo_exception = create uo_exception
		kuo_exception.setmessage( "Nessun valore disponibile. " )
		throw kuo_exception
		
		
	end if

end if

SetPointer(kp_oldpointer)



return k_return

end function

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
//---- posso tornare sempre a TRUE
//

return TRUE

end function

on kuf_esito_operazioni.create
call super::create
end on

on kuf_esito_operazioni.destroy
call super::destroy
end on

event constructor;call super::constructor;//
kids_esito_operazioni = create datastore
kids_esito_operazioni.dataobject = "d_esito_operazioni_select"
kids_esito_operazioni.settransobject( sqlca )



end event

event destructor;call super::destructor;//
destroy kids_esito_operazioni

end event

