$PBExportHeader$kuf_wm_pklist.sru
forward
global type kuf_wm_pklist from kuf_parent
end type
end forward

global type kuf_wm_pklist from kuf_parent
end type
global kuf_wm_pklist kuf_wm_pklist

type variables
//
//--- Molti campi erano Constant  ma è poi impossibili usarli nelle Query per cui nisba!
//

//---- campo STATO del PK-LIST Mandante
string kki_STATO_nuovo = "1" // nuovo PKL
string kki_STATO_NON_importare = "2" // se non e' da Importare come Riferimento
string kki_STATO_importato = "4" // importato nel Riferimento
string kki_STATO_chiuso = "9" // PKL chiusa

//--- campo che identifica il tipo di PKL
string kki_TIPO_cliente = "2" // importata da PKL generata dal Mandante
string kki_TIPO_interna = "3" // generata da Riferimento  'FITTIZIA'

//--- campo ELIMINATO 
protected string kki_ELIMINATO_SI = "S"  // riga Cancellata
//--- campo InSped (in spedizione...)
protected string kki_INSPED = "S"  // riga in spedizione
//--- campo Sped (spediito)
protected string kki_SPED_si = "S"  // riga spediita (bolla stampata)
protected string kki_SPED_no = "N"  // riga NON spediita (bolla NON stampata)


//--- campo Tipo Importazione (come e' stato creato il packing?)
string kki_TPIMPORTAZIONE_ELETTRONICO = "E" //caricato elettronicamente da Tabella esterna
string kki_TPIMPORTAZIONE_MANUALE = "M" //l'operatore ha caricato manualmente tutti i campi

end variables

forward prototypes
public function boolean u_open_applicazione (ref st_tab_wm_pklist kst_tab_wm_pklist, string k_flag_modalita)
public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_wm_pklist kst_tab_wm_pklist)
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_wm_pklist_righe kst_tab_wm_pklist_righe)
public function integer add_wm_pklist (ref st_wm_pklist kst_wm_pklist) throws uo_exception
public function boolean if_da_importare (ref st_wm_pklist kst_wm_pklist) throws uo_exception
public function integer u_tree_open (string k_modalita, st_wm_pklist kst_wm_pklist[], ref datawindow kdw_anteprima)
public function boolean u_open (st_wm_pklist kst_wm_pklist[], st_open_w kst_open_w)
public function boolean set_da_importare (st_wm_pklist kst_wm_pklist) throws uo_exception
public function boolean if_tipo_interna (ref st_wm_pklist kst_wm_pklist) throws uo_exception
public function boolean if_tipo_cliente (ref st_wm_pklist kst_wm_pklist) throws uo_exception
end prototypes

public function boolean u_open_applicazione (ref st_tab_wm_pklist kst_tab_wm_pklist, string k_flag_modalita);//---
//--- Apre la Window x le diverse funzioni
//---
//--- Input: st_tab_wm_pklist.id_wm_pklist
//--- Out: TRUE = finestra aperta; FASE=operazione non eseguita
//---


boolean k_return = false
st_esito kst_esito 
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window



if kst_tab_wm_pklist.id_wm_pklist > 0 or k_flag_modalita = kkg_flag_modalita.inserimento then
	
	if k_flag_modalita = kkg_flag_modalita.inserimento then kst_tab_wm_pklist.id_wm_pklist = 0
	
	k_return = true
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	K_st_open_w.id_programma = get_id_programma( k_flag_modalita )
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_modalita = k_flag_modalita
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = trim(string(kst_tab_wm_pklist.id_wm_pklist)) // id wm pklist
	K_st_open_w.key2 = " "
	K_st_open_w.key3 = " " 
	K_st_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(k_st_open_w)
	destroy kuf1_menu_window


end if

return k_return


end function

public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_wm_pklist kst_tab_wm_pklist);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datastore  di  anteprima
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

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.anteprima) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if isvalid(kdw_anteprima)  then
		if kdw_anteprima.dataobject = "d_wm_pklist_1"  then
			if kdw_anteprima.object.id_wm_pklist [1] = kst_tab_wm_pklist.id_wm_pklist   then
				kst_tab_wm_pklist.id_wm_pklist  = 0 
			end if
		end if
	end if

	if kst_tab_wm_pklist.id_wm_pklist  > 0 then
	
			kdw_anteprima.dataobject = "d_wm_pklist_1"		
			kdw_anteprima.settransobject(sqlca)
	
//			kuf1_utility = create kuf_utility
//			kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
//			destroy kuf1_utility
	
			kdw_anteprima.reset()	
	//--- retrive  
			k_rc=kdw_anteprima.retrieve(kst_tab_wm_pklist.id_wm_pklist )
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessun Packing-List da visualizzare: ~n~r" + "nessun Codice indicato"
			kst_esito.esito = kkg_esito.blok
			
		end if
end if


return kst_esito

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
string k_rcx
st_tab_wm_pklist  kst_tab_wm_pklist
st_tab_wm_pklist_righe kst_tab_wm_pklist_righe
st_esito kst_esito
uo_exception kuo_exception
datastore kdsi_elenco_output   //ds da passare alla windows di elenco
st_open_w kst_open_w 
kuf_wm_pklist_testa kuf1_wm_pklist_testa

try
	SetPointer(kkg.pointer_attesa )
	
	kdsi_elenco_output = create datastore
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	
	choose case a_campo_link
	
		case "idpkl"
			// prima verifica che in dw non contenga già il ID univoco del PKL
			kst_tab_wm_pklist.id_wm_pklist = 0
			k_rcx = adw_link.describe("id_wm_pklist.x")
			if k_rcx <> "!" and isnumber(k_rcx) then
				kst_tab_wm_pklist.id_wm_pklist  = adw_link.getitemnumber(adw_link.getrow(), "id_wm_pklist")
			end if
			if kst_tab_wm_pklist.id_wm_pklist  > 0 then
			else
			// cerca il ID univoco del PKL dal idpkl (nome pkl)
				kst_tab_wm_pklist.idpkl  = adw_link.getitemstring(adw_link.getrow(), a_campo_link)
				kuf1_wm_pklist_testa = create kuf_wm_pklist_testa
				kst_tab_wm_pklist.id_wm_pklist  = kuf1_wm_pklist_testa.get_id_wm_pklist(kst_tab_wm_pklist)
			end if
			if kst_tab_wm_pklist.id_wm_pklist  > 0 then
				kst_esito = this.anteprima( kdsi_elenco_output, kst_tab_wm_pklist )
				if kst_esito.esito <> kkg_esito.ok then
					kuo_exception = create uo_exception
					kuo_exception.set_esito( kst_esito)
					throw kuo_exception
				end if
				kst_open_w.key1 = "Packing List Mandante  (id.=" + trim(string(kst_tab_wm_pklist.id_wm_pklist )) + ") " 
			else
				k_return = false
			end if
	
		case "id_wm_pklist", "id_wm_pklist_padre"
			kst_tab_wm_pklist.id_wm_pklist  = adw_link.getitemnumber(adw_link.getrow(), a_campo_link)
			if kst_tab_wm_pklist.id_wm_pklist  > 0 then
				kst_esito = this.anteprima( kdsi_elenco_output, kst_tab_wm_pklist )
				if kst_esito.esito <> kkg_esito.ok then
					kuo_exception = create uo_exception
					kuo_exception.set_esito( kst_esito)
					throw kuo_exception
				end if
				kst_open_w.key1 = "Packing List Mandante  (id.=" + trim(string(kst_tab_wm_pklist.id_wm_pklist )) + ") " 
			else
				k_return = false
			end if
	
		case "id_wm_pklist_riga"
			kst_tab_wm_pklist_righe.id_wm_pklist  = adw_link.getitemnumber(adw_link.getrow(), "id_wm_pklist_riga")
			if kst_tab_wm_pklist_righe.id_wm_pklist  > 0 then
				kdsi_elenco_output.dataobject = "d_wm_pklist_righe"
				kst_esito = this.anteprima( kdsi_elenco_output, kst_tab_wm_pklist_righe )
				if kst_esito.esito <> kkg_esito.ok then
					kuo_exception = create uo_exception
					kuo_exception.set_esito( kst_esito)
					throw kuo_exception
				end if
				kst_open_w.key1 = "Righe del Packing-List Mandante  (id.=" + trim(string(kst_tab_wm_pklist_righe.id_wm_pklist_riga )) + ") " 
			else
				k_return = false
			end if
	
		case "b_wm_pklist_righe"
			kst_tab_wm_pklist_righe.id_wm_pklist  = adw_link.getitemnumber(adw_link.getrow(), "id_wm_pklist")
			if kst_tab_wm_pklist_righe.id_wm_pklist  > 0 then
				kdsi_elenco_output.dataobject = "d_wm_pklist_righe_l_1"
				kst_esito = this.anteprima( kdsi_elenco_output, kst_tab_wm_pklist_righe )
				if kst_esito.esito <> kkg_esito.ok then
					kuo_exception = create uo_exception
					kuo_exception.set_esito( kst_esito)
					throw kuo_exception
				end if
				kst_open_w.key1 = "Righe del Packing-List Mandante  (id.=" + trim(string(kst_tab_wm_pklist_righe.id_wm_pklist )) + ") " 
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
			kst_open_w.id_programma = get_id_programma( kkg_flag_modalita.elenco ) //kkg_id_programma_elenco
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
			kGuf_menu_window.open_w_tabelle(kst_open_w)
	
	
		else
			
			kuo_exception = create uo_exception
			kuo_exception.setmessage( "Nessun valore disponibile. " )
			throw kuo_exception
			
			
		end if
	
	end if


catch (uo_exception kuo1_exception)
	throw kuo1_exception 


finally
	if isvalid(kuf1_wm_pklist_testa) then destroy kuf1_wm_pklist_testa
	SetPointer(kkg.pointer_default)
	
end try	


return k_return

end function

public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_wm_pklist_righe kst_tab_wm_pklist_righe);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datastore  di  anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: come Standard
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return, k_elaborato=false
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.anteprima) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

//--- per Default retrieve sul DW indicato
	if not isvalid(kdw_anteprima)  then
		if kst_tab_wm_pklist_righe.id_wm_pklist_riga   > 0 then
			kdw_anteprima.dataobject = "d_wm_pklist_righe"		
			kdw_anteprima.settransobject(sqlca)
			kdw_anteprima.reset()	
			k_rc=kdw_anteprima.retrieve(kst_tab_wm_pklist_righe.id_wm_pklist_riga  )
		else
			k_elaborato = true
		end if
		
	else
//--- Altrimenti retrive sul DW puntuale passato
		
		choose case kdw_anteprima.dataobject
			case "d_wm_pklist_righe"  
				if kdw_anteprima.rowcount()> 0 then
					if kdw_anteprima.object.id_wm_pklist_riga  [1] = kst_tab_wm_pklist_righe.id_wm_pklist_riga    then
						kst_tab_wm_pklist_righe.id_wm_pklist_riga   = 0 
					end if
				end if
				if kst_tab_wm_pklist_righe.id_wm_pklist_riga > 0 then
					k_elaborato = true
					kdw_anteprima.settransobject(sqlca)
					kdw_anteprima.reset()	
					k_rc=kdw_anteprima.retrieve(kst_tab_wm_pklist_righe.id_wm_pklist_riga)
				end if
			
			case "d_wm_pklist_righe_l_1"  
				if kdw_anteprima.rowcount()> 0 then
					if kdw_anteprima.object.id_wm_pklist  [1] = kst_tab_wm_pklist_righe.id_wm_pklist    then
						kst_tab_wm_pklist_righe.id_wm_pklist  = 0
					end if
				end if
				if kst_tab_wm_pklist_righe.id_wm_pklist > 0 then
					k_elaborato = true
					kdw_anteprima.settransobject(sqlca)
					kdw_anteprima.reset()	
					k_rc=kdw_anteprima.retrieve(kst_tab_wm_pklist_righe.id_wm_pklist )
					
				end if
		end choose
		
	end if

	if not k_elaborato then
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna Riga di Packing-List da visualizzare: ~n~r" + "nessun Codice indicato"
		kst_esito.esito = kkg_esito.blok
			
	end if
end if


return kst_esito

end function

public function integer add_wm_pklist (ref st_wm_pklist kst_wm_pklist) throws uo_exception;//--------------------------------------------------------------------------------------------------------------------------------
//---	Aggiunge un nuovo Packing-List (Testata+Righe) in Tabella
//---
//---	Inp: st_wm_pklist.st_tab_wm_pklist /  st_wm_pklist.st_tab_wm_pklist_righe[]
//---	Out: Numero di Righe Caricate
//---	Lancia UO_EXCEPTION se si verifica un errore
//---
//--------------------------------------------------------------------------------------------------------------------------------
int k_return=0
int k_righe_insert=0
long k_ctr
st_esito kst_esito
st_tab_wm_pklist_righe kst_tab_wm_pklist_righe
kuf_wm_pklist_testa kuf1_wm_pklist_testa
kuf_wm_pklist_righe kuf1_wm_pklist_righe


	try

		kuf1_wm_pklist_testa = create kuf_wm_pklist_testa
		kuf1_wm_pklist_righe = create kuf_wm_pklist_righe
		
		kst_wm_pklist.st_tab_wm_pklist.dtimportazione = kguo_g.get_datetime_current( )
		kst_wm_pklist.st_tab_wm_pklist.stato = kki_STATO_nuovo
	
		kst_wm_pklist.st_tab_wm_pklist.st_tab_g_0.esegui_commit="N"
		if kuf1_wm_pklist_testa.tb_add(kst_wm_pklist.st_tab_wm_pklist) then

			for k_ctr = 1 to UpperBound (kst_wm_pklist.st_tab_wm_pklist_righe)
				if kst_wm_pklist.st_tab_wm_pklist_righe[k_ctr].colli > 0 then
					kst_tab_wm_pklist_righe = kst_wm_pklist.st_tab_wm_pklist_righe[k_ctr]
					kst_tab_wm_pklist_righe.id_wm_pklist = kst_wm_pklist.st_tab_wm_pklist.id_wm_pklist
					kst_tab_wm_pklist_righe.stato = kki_STATO_nuovo
					kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit="N"
					if kuf1_wm_pklist_righe.tb_add(kst_tab_wm_pklist_righe) then
						k_righe_insert++  // nr righe caricate
					end if
				end if
			next
			
		end if
	
		if kst_esito.esito = kkg_esito.db_ko then
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

	catch (uo_exception kuo_exception)
		throw kuo_exception
		
	finally
//--- se almeno 1 riga è stata caricata faccio COMMIT		
		if k_righe_insert > 0 then
			kst_esito = kguo_sqlca_db_magazzino.db_commit()
		else
			kst_esito = kguo_sqlca_db_magazzino.db_rollback()
		end if
		if isvalid(kuf1_wm_pklist_testa) then destroy kuf1_wm_pklist_testa
		if isvalid(kuf1_wm_pklist_righe) then destroy kuf1_wm_pklist_righe
		
		k_return = k_righe_insert

	end try

	
return k_return






end function

public function boolean if_da_importare (ref st_wm_pklist kst_wm_pklist) throws uo_exception;//--------------------------------------------------------------------------------------------------------------------------------
//---	Controlla se PKL da Importare ovvero ancora da Generare il Riferimento Lotto
//---
//---	Inp: st_wm_pklist.id_wm_pklist
//---	Out: TRUE = DA Importare ; FALSE = Gia' Importata
//---	Lancia UO_EXCEPTION se si verifica un errore
//---
//--------------------------------------------------------------------------------------------------------------------------------
boolean k_return=false
int k_righe_insert=0
st_esito kst_esito
kuf_wm_pklist_testa kuf1_wm_pklist_testa


	try

		if kst_wm_pklist.st_tab_wm_pklist.id_wm_pklist > 0 then
			
			kuf1_wm_pklist_testa = create kuf_wm_pklist_testa
	
			kst_esito = kuf1_wm_pklist_testa.get_stato(kst_wm_pklist.st_tab_wm_pklist )
			
			if kst_esito.esito = kkg_esito.ok then
	
				if kst_wm_pklist.st_tab_wm_pklist.stato = kki_STATO_nuovo then
					k_return = true
				else
					k_return = false
				end if
				
			end if
			
		end if

	catch (uo_exception kuo_exception)
		throw kuo_exception
		
	finally
		destroy kuf1_wm_pklist_testa

	end try

	
return k_return






end function

public function integer u_tree_open (string k_modalita, st_wm_pklist kst_wm_pklist[], ref datawindow kdw_anteprima);//
//--- Chiama applicazioni di dettaglio
//
integer k_return = 0, k_rc = 0
integer k_ind=1
st_tab_wm_pklist kst_tab_wm_pklist[]
datastore kds_1
st_esito kst_esito
st_open_w kst_open_w



if upperbound(kst_wm_pklist) > 0 then

	choose case k_modalita  

		case kkg_flag_modalita.anteprima

			if kst_wm_pklist[k_ind].st_tab_wm_pklist.id_wm_pklist > 0 then
				kds_1 = create datastore
				kst_esito = anteprima ( kds_1, kst_wm_pklist[k_ind].st_tab_wm_pklist)
				if kst_esito.esito = kkg_esito.db_ko then
					k_return = 1
					kguo_exception.set_esito( kst_esito )
				// setmessage( "Accesso al Documento di Vendita non disponibile. ")
					kguo_exception.messaggio_utente( )
				else

					kdw_anteprima.dataobject = kds_1.dataobject
					kds_1.rowscopy( 1, kds_1.rowcount( ) , primary!, kdw_anteprima, 1, primary!)
					
				end if
				destroy kds_1
			end if

				
		case else
	
			kst_open_w.flag_modalita = k_modalita			
			
			if not this.u_open( kst_wm_pklist[], kst_open_w ) then  //Apre le Varie Funzioni
				k_return = 1
				
				kguo_exception.setmessage( "Operazione di Accesso al Packing List fallita. ")
				kguo_exception.messaggio_utente( )
			end if
				
					
	end choose		

end if	
 
 
return k_return

end function

public function boolean u_open (st_wm_pklist kst_wm_pklist[], st_open_w kst_open_w);//
//--- Chiama la giusta Funzionalità
//---
//--- Input: st_tab_.... con ID valorizzato se serve,  st_open_w.flag_modalita = tipo funzione da richiamare
//---
//
boolean  k_return = true
integer k_ind
st_esito kst_esito


k_ind=1 

//	for k_ind = 1 to upperbound(kst_tab_wm_pklist[])					
					
		choose case kst_open_w.flag_modalita  

			case kkg_flag_modalita.stampa
//				this.u_open_vmcs(kst_tab_sped[])		
				
			case kkg_flag_modalita.cancellazione
				if kst_wm_pklist[k_ind].st_tab_wm_pklist.id_wm_pklist > 0 then
					this.u_open_applicazione(kst_wm_pklist[k_ind].st_tab_wm_pklist, kkg_flag_modalita.cancellazione)
				end if
				
			case kkg_flag_modalita.modifica
				if kst_wm_pklist[k_ind].st_tab_wm_pklist.id_wm_pklist > 0 then
					this.u_open_applicazione(kst_wm_pklist[k_ind].st_tab_wm_pklist, kkg_flag_modalita.modifica)
				end if
				
			case kkg_flag_modalita.inserimento
				this.u_open_applicazione(kst_wm_pklist[k_ind].st_tab_wm_pklist, kkg_flag_modalita.inserimento)
//				exit 
				
			case kkg_flag_modalita.visualizzazione
				if kst_wm_pklist[k_ind].st_tab_wm_pklist.id_wm_pklist > 0 then
					this.u_open_applicazione(kst_wm_pklist[k_ind].st_tab_wm_pklist, kkg_flag_modalita.visualizzazione)
				end if
				
			case else
					
					
		end choose		
			
//	end for
 
return k_return

end function

public function boolean set_da_importare (st_wm_pklist kst_wm_pklist) throws uo_exception;//--------------------------------------------------------------------------------------------------------------------------------
//---	Rimette il PKL da Importare ovvero ancora da Generare il Riferimento Lotto
//---
//---	Inp: st_wm_pklist.st_tab_wm_pklist_righe[1].id_wm_pklist / id_meca
//---	Out: TRUE = Tutto OK ; FALSE = problemi
//---	Lancia UO_EXCEPTION se si verifica un errore
//---
//--------------------------------------------------------------------------------------------------------------------------------
boolean k_return=false
int k_righe_insert=0
st_esito kst_esito
kuf_wm_pklist_testa kuf1_wm_pklist_testa
kuf_wm_pklist_inout kuf1_wm_pklist_inout

//st_wm_pklist kst_wm_pklist

	try
		if kst_wm_pklist.st_tab_wm_pklist_righe[1].id_wm_pklist > 0 then
			if kst_wm_pklist.st_tab_wm_pklist_righe[1].id_meca > 0 then
			
				kuf1_wm_pklist_testa = create kuf_wm_pklist_testa
				kuf1_wm_pklist_inout = create kuf_wm_pklist_inout
	
//--- resetta il Riferimento su tabelle interne PKLIST
				kst_wm_pklist.st_tab_wm_pklist.id_wm_pklist = kst_wm_pklist.st_tab_wm_pklist_righe[1].id_wm_pklist 
				kst_wm_pklist.st_tab_wm_pklist.st_tab_g_0.esegui_commit = kst_wm_pklist.st_tab_wm_pklist_righe[1].st_tab_g_0.esegui_commit
				kst_esito = kuf1_wm_pklist_testa.set_stato_nuovo(kst_wm_pklist.st_tab_wm_pklist )
			
				if kst_esito.esito = kkg_esito.ok then

//--- resetta il Riferimento e Barcode sulle righe del WM
					kuf1_wm_pklist_inout.toglie_id_meca_in_wm_receiptgammarad(kst_wm_pklist.st_tab_wm_pklist_righe[1])
	
					k_return = true
				else
					k_return = false
				end if
				
			end if
		end if

	catch (uo_exception kuo_exception)
		throw kuo_exception
		
	finally
		destroy kuf1_wm_pklist_testa
		destroy kuf1_wm_pklist_inout

	end try

	
return k_return






end function

public function boolean if_tipo_interna (ref st_wm_pklist kst_wm_pklist) throws uo_exception;//--------------------------------------------------------------------------------------------------------------------------------
//---	Controlla se PKL e' di tipo FITTIZIA uso solo interno, non generata dal PKL del cliente
//---
//---	Inp: st_wm_pklist.id_wm_pklist
//---	Out: TRUE = tipo Fittizia ; FALSE = altro tipo
//---	Lancia UO_EXCEPTION se si verifica un errore
//---
//--------------------------------------------------------------------------------------------------------------------------------
boolean k_return=false
int k_righe_insert=0
st_esito kst_esito
kuf_wm_pklist_testa kuf1_wm_pklist_testa


	try

		if kst_wm_pklist.st_tab_wm_pklist.id_wm_pklist > 0 then
			
			kuf1_wm_pklist_testa = create kuf_wm_pklist_testa
	
			kst_esito = kuf1_wm_pklist_testa.get_tipo(kst_wm_pklist.st_tab_wm_pklist )
			
			if kst_esito.esito = kkg_esito.ok then
	
				if kst_wm_pklist.st_tab_wm_pklist.stato = kki_tipo_interna then
					k_return = true
				else
					k_return = false
				end if
				
			end if
			
		end if

	catch (uo_exception kuo_exception)
		throw kuo_exception
		
	finally
		destroy kuf1_wm_pklist_testa

	end try

	
return k_return






end function

public function boolean if_tipo_cliente (ref st_wm_pklist kst_wm_pklist) throws uo_exception;//--------------------------------------------------------------------------------------------------------------------------------
//---	Controlla se PKL e' di tipo normale generata dal PKL del cliente
//---
//---	Inp: st_wm_pklist.id_wm_pklist
//---	Out: TRUE = tipo Cliente ; FALSE = altro tipo
//---	Lancia UO_EXCEPTION se si verifica un errore
//---
//--------------------------------------------------------------------------------------------------------------------------------
boolean k_return=false
int k_righe_insert=0
st_esito kst_esito
kuf_wm_pklist_testa kuf1_wm_pklist_testa


	try

		if kst_wm_pklist.st_tab_wm_pklist.id_wm_pklist > 0 then
			
			kuf1_wm_pklist_testa = create kuf_wm_pklist_testa
	
			kst_esito = kuf1_wm_pklist_testa.get_tipo(kst_wm_pklist.st_tab_wm_pklist )
			
			if kst_esito.esito = kkg_esito.ok then
	
				if isnull(kst_wm_pklist.st_tab_wm_pklist.tipo) or kst_wm_pklist.st_tab_wm_pklist.tipo = kki_TIPO_cliente then
					k_return = true
				else
					k_return = false
				end if
				
			end if
			
		end if

	catch (uo_exception kuo_exception)
		throw kuo_exception
		
	finally
		destroy kuf1_wm_pklist_testa

	end try

	
return k_return






end function

on kuf_wm_pklist.create
call super::create
end on

on kuf_wm_pklist.destroy
call super::destroy
end on

event constructor;call super::constructor;//
ki_nomeOggetto = "kuf_wm_pklist" 

end event

