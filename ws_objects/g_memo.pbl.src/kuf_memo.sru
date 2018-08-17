$PBExportHeader$kuf_memo.sru
forward
global type kuf_memo from kuf_parent
end type
end forward

global type kuf_memo from kuf_parent
end type
global kuf_memo kuf_memo

type variables
//
//--- tipo dati nel memo 
public constant string kki_tipo_memo_rtf = 'RTF'  //tipo dati RTF

private st_memo kist_memo
private w_memo kiw_memo

//--- Servizi / settori che fanno i memo (definire qui gli oggetti da chiamare con "aggiorna_sv"
private kuf_clienti kiuf1_clienti
private kuf_armo_inout kiuf1_armo_inout

//--- tipo visualizzazione MEMO: x Utente, x Lotto, x Cliente
public constant string kki_tipovisualizza_xUTENTE = "U"
public constant string kki_tipovisualizza_xMECA = "E"
public constant string kki_tipovisualizza_xANAG = "A"

//--- flag x identificare range di stati 
public constant string kki_memo_daleggere = "0"
public constant string kki_memo_letti = "1"
public constant string kki_memo_rimossi = "2"
public constant string kki_memo_attivi = "3"
public constant string kki_memo_tutti = "4"

end variables

forward prototypes
public function long get_ult_id_memo () throws uo_exception
public function boolean if_esiste (st_tab_memo ast_tab_memo) throws uo_exception
public subroutine if_isnull (ref st_tab_memo ast_tab_memo)
public function long tb_add (st_tab_memo ast_tab_memo) throws uo_exception
public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_memo ast_tab_memo)
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
public function string get_note (st_tab_memo ast_tab_memo) throws uo_exception
public function datetime get_x_datains (st_tab_memo ast_tab_memo) throws uo_exception
public function datetime get_dataora_ins (st_tab_memo ast_tab_memo) throws uo_exception
public function boolean tb_delete (st_tab_memo ast_tab_memo) throws uo_exception
public function string get_tipo_memo (st_tab_memo ast_tab_memo) throws uo_exception
public subroutine set_kuf_clienti (kuf_clienti auf_clienti)
public function string get_titolo (st_tab_memo ast_tab_memo) throws uo_exception
public function st_esito u_check_dati (ref datastore ads_inp) throws uo_exception
private function boolean tb_update_memo (ref st_tab_memo ast_tab_memo) throws uo_exception
public function boolean tb_update (ref st_tab_memo ast_tab_memo) throws uo_exception
public function string get_memo (ref st_tab_memo ast_tab_memo) throws uo_exception
public subroutine set_kuf_meca (kuf_armo_inout auf_armo_inout)
public function int get_permessi (st_tab_memo ast_tab_memo) throws uo_exception
public subroutine get_memo_altri_dati (ref st_tab_memo ast_tab_memo) throws uo_exception
public function boolean u_if_sicurezza (ref st_tab_memo ast_tab_memo, string a_flag_modalita) throws uo_exception
public function boolean u_attiva_funzione (st_memo ast_memo, string a_flag_modalita) throws uo_exception
public function st_memo get_st_memo ()
public subroutine set_st_memo (st_memo kst_memo)
public function long aggiorna (st_memo ast_memo) throws uo_exception
private subroutine aggiorna_altri_archivi (st_memo ast_memo) throws uo_exception
public subroutine tb_delete_altri_archivi (st_tab_memo ast_tab_memo)
public function boolean u_open_ds (st_open_w ast_open_w) throws uo_exception
private subroutine u_open_window_old (string a_flag_modalita)
end prototypes

public function long get_ult_id_memo () throws uo_exception;//
//====================================================================
//=== Torna l'ultimo ID_MEMO inserito
//=== 
//=== Input: 
//=== Output:                   
//=== Ritorna long contenente l'id_memo
//===           		  
//====================================================================
st_esito kst_esito
long	k_id_memo


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


SELECT max(id_memo)
INTO :k_id_memo
FROM memo
using kguo_sqlca_db_magazzino;


 if kguo_sqlca_db_magazzino.sqlcode <> 0 then
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura ultimo id caricato in tab. MEMO " + "~n~r" + trim(sqlca.SQLErrText) 
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if
end if

if isnull(k_id_memo) then k_id_memo = 0

return k_id_memo



end function

public function boolean if_esiste (st_tab_memo ast_tab_memo) throws uo_exception;//
//====================================================================
//=== Torna se c'è il MEMO 
//=== 
//=== Input: st_tab_memo.id_memo     
//=== Output:                   
//=== Ritorna true se trova almeno un id per id memo passato
//===           		  
//====================================================================

boolean	k_return = false
st_esito kst_esito
integer k_esiste

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


SELECT 1
INTO :k_esiste
FROM memo
where id_memo = :ast_tab_memo.id_memo
using kguo_sqlca_db_magazzino;

 if kguo_sqlca_db_magazzino.sqlcode <> 0 then
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore controllo esistenza Memo~n~r" + trim(sqlca.SQLErrText) 
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if
end if

if k_esiste>0 then k_return = true

return k_return
end function

public subroutine if_isnull (ref st_tab_memo ast_tab_memo);//---
//--- toglie i NULL ai campi della tabella 
//---

if isnull(ast_tab_memo.id_memo) then	ast_tab_memo.id_memo = 0
if isnull(ast_tab_memo.TIPO_MEMO) then ast_tab_memo.TIPO_MEMO = "RTF"
if isnull(ast_tab_memo.note) then ast_tab_memo.note = ""
if isnull(ast_tab_memo.titolo) then ast_tab_memo.titolo = ""
if isnull(ast_tab_memo.tipo_sv) then ast_tab_memo.tipo_sv = ""
if isnull(ast_tab_memo.permessi) then ast_tab_memo.permessi = 0
if isnull(ast_tab_memo.dataora_ins) then ast_tab_memo.dataora_ins = datetime(date(0))
if isnull(ast_tab_memo.utente_ins) then ast_tab_memo.utente_ins = ""
if isnull(ast_tab_memo.memo) then ast_tab_memo.memo = blob("")

if isnull(ast_tab_memo.x_datins) then	ast_tab_memo.x_datins = datetime(date(0))
if isnull(ast_tab_memo.x_utente) then	ast_tab_memo.x_utente = ""




end subroutine

public function long tb_add (st_tab_memo ast_tab_memo) throws uo_exception;//
//--------------------------------------------------------------------
//--- Aggiunge riga in tabella  MEMO 
//--- 
//--- Input: st_tab_memo.id_memo
//--- Ritorna ID_MEMO
//--- 
//--- x errore grave lancia exception
//--------------------------------------------------------------------
// 
long k_return = 0
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
boolean k_autorizza

	
try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//	if if_sicurezza(kkg_flag_modalita.modifica ) then 

	//--- imposto dati utente e data aggiornamento
		ast_tab_memo.x_datins = kGuf_data_base.prendi_x_datins()
		ast_tab_memo.x_utente = kGuf_data_base.prendi_x_utente()
		
		if ast_tab_memo.dataora_ins > datetime(date(0)) then
		else
			ast_tab_memo.dataora_ins = kGuf_data_base.prendi_x_datins()
			ast_tab_memo.utente_ins = kGuf_data_base.prendi_x_utente()
		end if

	//--- toglie valori NULL
		if_isnull(ast_tab_memo)
		  // id_memo,
	    INSERT INTO memo
				 (
				  TIPO_MEMO,
				  tipo_sv,
				  permessi,
				  dataora_ins, 
				  utente_ins,
				  titolo,   
				  note,   
				  x_datins,
				  x_utente
				  )
			  VALUES ( 
				  :ast_tab_memo.TIPO_MEMO,
				  :ast_tab_memo.tipo_sv,
				  :ast_tab_memo.permessi,
				  :ast_tab_memo.dataora_ins, 
				  :ast_tab_memo.utente_ins, 
				  :ast_tab_memo.titolo,   
				  :ast_tab_memo.note,   
				  :ast_tab_memo.x_datins,   
				  :ast_tab_memo.x_utente
			      )
		USING kguo_sqlca_db_magazzino;
		
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore Aggiornamento MEMO~n~r" + trim(sqlca.SQLErrText) 
				if ast_tab_memo.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_memo.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_rollback( )
				end if
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito)
				throw kguo_exception
			end if
		else
			//ast_tab_memo.id_memo = long(kguo_sqlca_db_magazzino.SQLReturnData)
			ast_tab_memo.id_memo = get_ult_id_memo( ) // get del ID appena generato

			if len(ast_tab_memo.memo) > 0 then
				tb_update_memo(ast_tab_memo)  // aggiorna il BLOB con i dati (memo)
			end if
			if ast_tab_memo.id_memo > 0 then
				k_return = ast_tab_memo.id_memo
			end if
			
		end if
//	end if

		if ast_tab_memo.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_memo.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	
	
catch (uo_exception kuo_exception)
	throw kuo_exception 
end try



return k_return
end function

public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_memo ast_tab_memo);//
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
string k_memo
st_esito kst_esito
kuf_utility kuf1_utility


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
//	k_return = if_sicurezza(kkg_flag_modalita.anteprima)
//	
//	if not k_return then
//	
//		kst_esito.sqlcode = sqlca.sqlcode
//		kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
//		kst_esito.esito = kkg_esito.no_aut
//	
//	else
	
		if ast_tab_memo.id_memo > 0 then
		
			kdw_anteprima.dataobject = "d_memo_rtf"		
			kdw_anteprima.settransobject(sqlca)
		
			k_memo = get_memo(ast_tab_memo)
			
			kdw_anteprima.reset()	
			k_rc=kdw_anteprima.retrieve(ast_tab_memo.id_memo)
			if k_rc > 0 then
				kdw_anteprima.pasteRtf( k_memo ) // mette il testo RTF 
			end if
		
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessuna NOTA (memo) da visualizzare: ~n~r" + "nessun codice indicato"
			kst_esito.esito = kkg_esito.blok
			
		end if
//	end if

catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()

end try

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
boolean k_return=false
string k_modalita=""
st_memo kst_memo
//st_tab_memo kst_tab_memo
st_esito kst_esito
datastore kdsi_elenco_output   //ds da passare alla windows di elenco
st_open_w kst_open_w 
st_tab_clienti_memo kst_tab_clienti_memo
st_tab_meca_memo kst_tab_meca_memo
kuf_clienti kuf1_clienti
kuf_clienti_memo kuf1_clienti_memo
kuf_meca_memo kuf1_meca_memo
kuf_armo_inout kuf1_armo_inout
kuf_memo_inout kuf1_memo_inout


//SetPointer(kkg.pointer_attesa)


kdsi_elenco_output = create datastore

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


choose case a_campo_link

	case "p_memo", "id_memo", "p_id_memo"
		kst_memo.st_tab_memo.id_memo = adw_link.getitemnumber(adw_link.getrow(), "id_memo")
		if kst_memo.st_tab_memo.id_memo > 0 then
			if not if_esiste(kst_memo.st_tab_memo) then
				kst_memo.st_tab_memo.id_memo = 0
			end if
		end if
		if kst_memo.st_tab_memo.id_memo > 0 then
			k_return = true
			u_attiva_funzione(kst_memo, kkg_flag_modalita.visualizzazione)
		end if

//--- Nuovo MEMO
	case "p_id_memo_no", "p_memo_x"
		kst_memo.st_tab_memo.id_memo = 0
		kst_memo.st_tab_meca_memo.id_meca = 0
		kst_memo.st_tab_clienti_memo.id_cliente = 0
		if adw_link.describe("id_meca.color") <> "!" then
			kst_memo.st_tab_meca_memo.id_meca = adw_link.getitemnumber(adw_link.getrow(), "id_meca")
			if kst_memo.st_tab_meca_memo.id_meca > 0 then
				kuf1_armo_inout = create kuf_armo_inout
//				kst_tab_meca_memo.id_meca = kst_memo.st_tab_meca_memo.id_meca
//				kuf1_armo_inout.get_id_memo_max_x_id_meca(kst_tab_meca_memo)
				if not isvalid(kuf1_meca_memo) then kuf1_meca_memo = create kuf_meca_memo
				if kuf1_meca_memo.if_esiste(kst_memo.st_tab_meca_memo) then
					k_modalita = kkg_flag_modalita.elenco
				else
					if not isvalid(kuf1_memo_inout) then kuf1_memo_inout = create kuf_memo_inout
					kuf1_memo_inout.memo_xmeca(kst_memo.st_tab_meca_memo, kst_memo.st_tab_memo)
					k_modalita = kkg_flag_modalita.inserimento
				end if
			end if
		end if
		if kst_memo.st_tab_meca_memo.id_meca = 0 then
			if adw_link.describe("id_cliente.color") <> "!" then
				kst_memo.st_tab_clienti_memo.id_cliente = adw_link.getitemnumber(adw_link.getrow(), "id_cliente")
				if kst_memo.st_tab_clienti_memo.id_cliente > 0 then
					kuf1_clienti = create kuf_clienti
//					kst_tab_clienti_memo.id_cliente = kst_memo.st_tab_clienti_memo.id_cliente
//					kuf1_clienti.get_id_memo_max_x_id_cliente(kst_tab_clienti_memo)
					if not isvalid(kuf1_clienti_memo) then kuf1_clienti_memo = create kuf_clienti_memo
					if kuf1_clienti_memo.if_esiste(kst_memo.st_tab_clienti_memo) then
						k_modalita = kkg_flag_modalita.elenco
					else
						if not isvalid(kuf1_memo_inout) then kuf1_memo_inout = create kuf_memo_inout
						kuf1_memo_inout.memo_xcliente(kst_memo.st_tab_clienti_memo, kst_memo.st_tab_memo)
						k_modalita = kkg_flag_modalita.inserimento
					end if
				end if
			end if
		end if
//		if kst_memo.st_tab_clienti_memo.id_cliente = 0 and kst_memo.st_tab_clienti_memo.id_cliente = 0 then 	
//			k_return = true
			kist_memo = kst_memo
			u_attiva_funzione(kst_memo, k_modalita) 
//		else
//			k_return = true
//			u_attiva_funzione(kst_memo, kkg_flag_modalita.visualizzazione)
//		end if
		
end choose


//SetPointer(kkg.pointer_default)



return k_return

end function

public function string get_note (st_tab_memo ast_tab_memo) throws uo_exception;//---------------------------------------------------------------------
//--- Torna NOTE 
//--- 
//--- Input: st_tab_memo.id_memo     
//--- Output:                   
//--- Ritorna il campo NOTE
//---           		  
//---  x errore lancia EXCEPTION
//---------------------------------------------------------------------
st_esito kst_esito
string	 k_return = ""


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


SELECT 
		  note
    INTO 
	 	  :ast_tab_memo.note
        FROM memo
        WHERE ( id_memo = :ast_tab_memo.id_memo)   
		using kguo_sqlca_db_magazzino;

 if kguo_sqlca_db_magazzino.sqlcode <> 0 then
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura Note dal documento (memo) id=" +string(ast_tab_memo.id_memo) + "~n~r" + trim(sqlca.SQLErrText) 
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if
else
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if trim(ast_tab_memo.note) > " " then
			k_return =  trim(ast_tab_memo.note)
		end if
	end if
end if


return k_return



end function

public function datetime get_x_datains (st_tab_memo ast_tab_memo) throws uo_exception;//---------------------------------------------------------------------
//--- Torna X_DATINS 
//--- 
//--- Input: st_tab_memo.id_memo     
//--- Output:                   
//--- Ritorna il campo X_DATINS
//---           		  
//---  x errore lancia EXCEPTION
//---------------------------------------------------------------------
st_esito kst_esito
datetime k_return = datetime(date(0))


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


SELECT 
		  x_datins
    INTO 
	 	  :ast_tab_memo.x_datins
        FROM memo
        WHERE ( id_memo = :ast_tab_memo.id_memo)   
		using kguo_sqlca_db_magazzino;

 if kguo_sqlca_db_magazzino.sqlcode <> 0 then
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura x_datins dal documento (memo) id=" +string(ast_tab_memo.id_memo) + "~n~r" + trim(sqlca.SQLErrText) 
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if
else
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if ast_tab_memo.x_datins > datetime(date(0)) then
			k_return =  ast_tab_memo.x_datins
		end if
	end if
end if


return k_return



end function

public function datetime get_dataora_ins (st_tab_memo ast_tab_memo) throws uo_exception;//---------------------------------------------------------------------
//--- Torna dataora_ins 
//--- 
//--- Input: st_tab_memo.id_memo     
//--- Output:                   
//--- Ritorna il campo dataora_ins
//---           		  
//---  x errore lancia EXCEPTION
//---------------------------------------------------------------------
st_esito kst_esito
datetime k_return = datetime(date(0))


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


SELECT 
		  dataora_ins
    INTO 
	 	  :ast_tab_memo.dataora_ins
        FROM memo
        WHERE ( id_memo = :ast_tab_memo.id_memo)   
		using kguo_sqlca_db_magazzino;

 if kguo_sqlca_db_magazzino.sqlcode <> 0 then
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura data di inserimento dal documento (memo) id=" +string(ast_tab_memo.id_memo) + "~n~r" + trim(sqlca.SQLErrText) 
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if
else
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if ast_tab_memo.dataora_ins > datetime(date(0)) then
			k_return =  ast_tab_memo.dataora_ins
		end if
	end if
end if


return k_return



end function

public function boolean tb_delete (st_tab_memo ast_tab_memo) throws uo_exception;//
//--------------------------------------------------------------------
//--- Cancella rek nella tabella MEMO
//--- 
//--- Input: st_tab_memo.id_memo_memo
//--- Ritorna  TRUE=OK; 
//--- 
//--- x errore lancia exception
//--------------------------------------------------------------------
boolean k_return = false
long k_rcn
boolean k_rc
st_esito kst_esito
st_open_w kst_open_w
st_tab_memo kst_tab_memo



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if ast_tab_memo.id_memo > 0 then

//--- cancella prima gli Archivi correlati 
	kst_tab_memo = ast_tab_memo
	kst_tab_memo.st_tab_g_0.esegui_commit = "N"
	tb_delete_altri_archivi(kst_tab_memo) 
		
//--- cancella il MEMO	
	delete 
			from memo
			WHERE id_memo = :ast_tab_memo.id_memo 
			using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore Cancellazione NOTE  (id memo " + string(ast_tab_memo.id_memo) + ")~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText) 

			if ast_tab_memo.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_memo.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if

			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito)
			throw kguo_exception
		end if
	else
		
		if ast_tab_memo.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_memo.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if

		k_return = true
		
	end if


end if



return k_return

end function

public function string get_tipo_memo (st_tab_memo ast_tab_memo) throws uo_exception;//---------------------------------------------------------------------
//--- Torna TIPO 
//--- 
//--- Input: st_tab_memo.id_memo     
//--- Output:                   
//--- Ritorna il campo TIPO_MEMO
//---           		  
//---  x errore lancia EXCEPTION
//---------------------------------------------------------------------
st_esito kst_esito
string k_return = ""


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


SELECT 
		  TIPO_MEMO
    INTO 
	 	  :ast_tab_memo.TIPO_MEMO
        FROM memo
        WHERE ( id_memo = :ast_tab_memo.id_memo)   
		using kguo_sqlca_db_magazzino;

 if kguo_sqlca_db_magazzino.sqlcode <> 0 then
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura TIPO dal documento (memo) id=" +string(ast_tab_memo.id_memo) + "~n~r" + trim(sqlca.SQLErrText) 
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if
else
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if trim(ast_tab_memo.TIPO_MEMO) > " " then
			k_return =  (ast_tab_memo.TIPO_MEMO)
		end if
	end if
end if


return k_return



end function

public subroutine set_kuf_clienti (kuf_clienti auf_clienti);//
if not isvalid(kiuf1_clienti) then kiuf1_clienti = create kuf_clienti
kiuf1_clienti = auf_clienti

end subroutine

public function string get_titolo (st_tab_memo ast_tab_memo) throws uo_exception;//---------------------------------------------------------------------
//--- Torna NOTE 
//--- 
//--- Input: st_tab_memo.id_memo     
//--- Output:                   
//--- Ritorna il campo TITOLO
//---           		  
//---  x errore lancia EXCEPTION
//---------------------------------------------------------------------
st_esito kst_esito
string	 k_return = ""


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


SELECT 
		  titolo
    INTO 
	 	  :ast_tab_memo.titolo
        FROM memo
        WHERE ( id_memo = :ast_tab_memo.id_memo)   
		using kguo_sqlca_db_magazzino;

 if kguo_sqlca_db_magazzino.sqlcode <> 0 then
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in MEMO per leggere il Titolo (memo) id=" +string(ast_tab_memo.id_memo) + "~n~r" + trim(sqlca.SQLErrText) 
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if
else
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if trim(ast_tab_memo.titolo) > " " then
			k_return =  trim(ast_tab_memo.titolo)
		end if
	end if
end if


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
//---							               	W=OK con degli avvertimenti (NON bloccante) (kkg_esito.DATI_WRN);
//---  rit: 
//---
//---  per errore lancia EXCEPTION anche x i warning
//---
//------------------------------------------------------------------------------------------------------
//
int k_errori = 0
long k_nr_righe
int k_riga
string k_tipo_errore="0"
st_esito kst_esito
kuf_sr_sicurezza kuf1_sr_sicurezza



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
	
	k_nr_righe =ads_inp.rowcount()
	k_errori = 0
	k_riga =ads_inp.getnextmodified(0, primary!)

	do while k_riga > 0  and k_errori < 99

		if ads_inp.getitemstring ( k_riga, "titolo") > " " then  // presuppone una descrizione
		else
			k_errori ++
			k_tipo_errore="3"      // errore in questo campo: dati insuff.
			ads_inp.modify("titolo.tag = '" + k_tipo_errore + "' ")
			kst_esito.esito = kkg_esito.DATI_INSUFF
			kst_esito.sqlerrtext = "Manca valore nel campo " + trim(ads_inp.describe(ads_inp.describe("titolo.name") + "_t.text")) +  "~n~r"  
		end if

		if ads_inp.getitemstring ( k_riga, "note") > " " then  // presuppone un motivo/note
		else
			k_errori ++
			k_tipo_errore="3"      // errore in questo campo: dati insuff.
			ads_inp.modify("note.tag = '" + k_tipo_errore + "' ")
			kst_esito.esito = kkg_esito.DATI_INSUFF
			kst_esito.sqlerrtext += "Manca valore nel campo " + trim(ads_inp.describe(ads_inp.describe("note.name") + "_t.text")) +  "~n~r"  
		end if

		if isnull(ads_inp.getitemnumber ( k_riga, "permessi")) then  
			ads_inp.setitem(1, "permessi", kuf1_sr_sicurezza.ki_permessi_scrittura )
		end if


		if k_tipo_errore <> kkg_esito.ok  and k_tipo_errore <> kkg_esito.DB_WRN and k_tipo_errore <> kkg_esito.DATI_WRN then
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

		k_riga++
		k_riga = ads_inp.getnextmodified(k_riga, primary!)

	loop

	
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if k_errori > 0 then
		
	end if
	
end try


return kst_esito
 
 
 
end function

private function boolean tb_update_memo (ref st_tab_memo ast_tab_memo) throws uo_exception;//
//--------------------------------------------------------------------
//--- Aggiorna nella tabella  MEMO  il campo  DATI (memo)
//--- 
//--- Input: st_tab_memo.id_memo
//--- Ritorna TRUE = OK
//--- 
//--- x errore grave lancia exception
//--------------------------------------------------------------------
// 
boolean	k_return = false
boolean k_rc, k_senza_dati
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
boolean k_autorizza

	
try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//--- controllo se nel MEMO ci sono dati
		if len(ast_tab_memo.memo) > 0 then
			k_senza_dati = false
		else
			k_senza_dati = true
			ast_tab_memo.memo = blob("")
		end if
			
		UPDATEBLOB memo  
					SET 
						memo = :ast_tab_memo.memo
					WHERE id_memo = :ast_tab_memo.id_memo 
					using kguo_sqlca_db_magazzino;
			
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore Aggiornamento MEMO (BLOB)~n~r" + trim(sqlca.SQLErrText) 
				if ast_tab_memo.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_memo.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_rollback( )
				end if
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito)
				throw kguo_exception
			end if
		else
			k_return = true
		end if

		if ast_tab_memo.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_memo.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if

	
catch (uo_exception kuo_exception)
	throw kuo_exception 
	
end try


return k_return
end function

public function boolean tb_update (ref st_tab_memo ast_tab_memo) throws uo_exception;//
//--------------------------------------------------------------------
//--- Aggiorna tabella  MEMO 
//--- 
//--- Input: st_tab_memo.id_memo
//--- Ritorna TRUE = OK
//--- 
//--- x errore grave lancia exception
//--------------------------------------------------------------------
// 
boolean k_return = false
long k_memo_rtf_orig_len, k_memo_rtf_len
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_tab_memo kst_tab_memo
st_open_w kst_open_w
boolean k_autorizza

	
try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//	if if_sicurezza(kkg_flag_modalita.modifica ) then 

	//--- imposto dati utente e data aggiornamento
		ast_tab_memo.x_datins = kGuf_data_base.prendi_x_datins()
		ast_tab_memo.x_utente = kGuf_data_base.prendi_x_utente()
		
	//--- toglie valori NULL
		if_isnull(ast_tab_memo)
		  
		UPDATE memo  
				 SET
				      tipo_sv = :ast_tab_memo.tipo_sv,
				      permessi = :ast_tab_memo.permessi,
					  note = :ast_tab_memo.note,   
					  titolo = :ast_tab_memo.titolo,  
					  TIPO_MEMO = :ast_tab_memo.TIPO_MEMO,   
					  x_datins = :ast_tab_memo.x_datins,   
					  x_utente = :ast_tab_memo.x_utente
		WHERE id_memo = :ast_tab_memo.id_memo
		USING kguo_sqlca_db_magazzino;
		
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore Aggiornamento MEMO~n~r" + trim(sqlca.SQLErrText) 
				if ast_tab_memo.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_memo.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_rollback( )
				end if
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito)
				throw kguo_exception
			end if
		else
//--- aggiorna BLOB se cambiato
			kst_tab_memo = ast_tab_memo
			get_memo(kst_tab_memo)
			k_memo_rtf_len = len(ast_tab_memo.memo)
			k_memo_rtf_orig_len = len(kst_tab_memo.memo)
			if isnull(k_memo_rtf_len) then k_memo_rtf_len = 0 
			if isnull(k_memo_rtf_orig_len) then k_memo_rtf_orig_len = 0 
			if k_memo_rtf_len <> k_memo_rtf_orig_len then
				k_return = tb_update_memo(ast_tab_memo)  // aggiorna il BLOB con i dati (memo)
			end if
		end if
//	end if
		if ast_tab_memo.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_memo.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception 
end try



return k_return
end function

public function string get_memo (ref st_tab_memo ast_tab_memo) throws uo_exception;//
//====================================================================
//=== Torna ID MEMO 
//=== 
//=== Input: st_tab_memo.id_memo     
//=== Output:                   
//=== Ritorna il testo in rtf
//===           		  
//====================================================================
st_esito kst_esito
string	k_return = ""


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


SELECTBLOB   
		  memo
    INTO 
	 	  :ast_tab_memo.memo
        FROM memo
        WHERE ( id_memo = :ast_tab_memo.id_memo)   
		using kguo_sqlca_db_magazzino;

 if kguo_sqlca_db_magazzino.sqlcode <> 0 then
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura del documento RTF (memo) id=" +string(ast_tab_memo.id_memo) + "~n~r" + trim(sqlca.SQLErrText) 
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if
else
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if string(ast_tab_memo.memo) > " " then
			k_return =  trim(string(ast_tab_memo.memo))
		end if
	end if
end if


return k_return



end function

public subroutine set_kuf_meca (kuf_armo_inout auf_armo_inout);//
if not isvalid(kiuf1_armo_inout) then kiuf1_armo_inout = create kuf_armo_inout
kiuf1_armo_inout = auf_armo_inout

end subroutine

public function int get_permessi (st_tab_memo ast_tab_memo) throws uo_exception;//---------------------------------------------------------------------
//--- Torna campo PERMESSI 
//--- 
//--- Input: st_tab_memo.id_memo     
//--- Output:                   
//--- Ritorna il campo PERMESSI
//---           		  
//---  x errore lancia EXCEPTION
//---------------------------------------------------------------------
st_esito kst_esito
int	 k_return = 0


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


SELECT 
		  permessi
    INTO 
	 	  :ast_tab_memo.permessi
        FROM memo
        WHERE ( id_memo = :ast_tab_memo.id_memo)   
		using kguo_sqlca_db_magazzino;

 if kguo_sqlca_db_magazzino.sqlcode <> 0 then
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in MEMO per leggere il tipo di Accesso permesso (memo) id=" +string(ast_tab_memo.id_memo) + "~n~r" + trim(sqlca.SQLErrText) 
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if
else
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if ast_tab_memo.permessi > 0 then
			k_return =  ast_tab_memo.permessi
		end if
	end if
end if


return k_return



end function

public subroutine get_memo_altri_dati (ref st_tab_memo ast_tab_memo) throws uo_exception;//
//====================================================================
//=== Torna dati del MEMO 
//=== 
//=== Input: st_tab_memo.id_memo     
//=== Output:  st_tab_memo                 
//=== 
//===           		  
//====================================================================
long k_righe=0
st_esito kst_esito
st_tab_memo kst_tab_memo
datastore kds_memo


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

	kst_tab_memo = ast_tab_memo

	kds_memo = create datastore
	kds_memo.dataobject = "ds_memo"
	kds_memo.settransobject(kguo_sqlca_db_magazzino)
	k_righe = kds_memo.retrieve(ast_tab_memo.id_memo)
	if k_righe	 > 0 then
		ast_tab_memo.dataora_ins = kds_memo.getitemdatetime( 1, "dataora_ins")
		ast_tab_memo.note = kds_memo.getitemstring( 1, "note")
		ast_tab_memo.tipo_memo = kds_memo.getitemstring( 1, "tipo_memo")
		ast_tab_memo.tipo_sv = kds_memo.getitemstring( 1, "tipo_sv")
		ast_tab_memo.permessi = kds_memo.getitemnumber( 1, "permessi")
		ast_tab_memo.titolo = kds_memo.getitemstring( 1, "titolo")
		ast_tab_memo.utente_ins = kds_memo.getitemstring( 1, "utente_ins")
		ast_tab_memo.x_datins = kds_memo.getitemdatetime( 1, "x_datins")
		ast_tab_memo.x_utente = kds_memo.getitemstring( 1, "x_utente")
	else
		if k_righe	 = 0 then
			this.if_isnull(ast_tab_memo)
			ast_tab_memo.id_memo = kst_tab_memo.id_memo
		else
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = k_righe
			kst_esito.SQLErrText = "Errore in Lettura dati del MEMO, id=" +string(ast_tab_memo.id_memo) //+ "~n~r" 
			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito)
			throw kguo_exception
		end if
	end if





end subroutine

public function boolean u_if_sicurezza (ref st_tab_memo ast_tab_memo, string a_flag_modalita) throws uo_exception;//---
//--- Verifica se Utente Autorizzato a vedere il MEMO
//---
//--- input: kst_tab_memo.id_memi, flag_modalita
//--- output: TRUE=autorizzato, FALSE=NO
//---------------------------------------------------------------------------------------------------------
boolean k_return=false
kuf_memo_sr kuf1_memo_sr 


	get_memo_altri_dati(ast_tab_memo)  // legge dati del MEMO

	if len(trim(ast_tab_memo.tipo_sv)) > 0 then
		kuf1_memo_sr  = create kuf_memo_sr 
		k_return = kuf1_memo_sr.u_if_sicurezza(ast_tab_memo, a_flag_modalita)
	else
		k_return = true
	end if
		
return k_return

end function

public function boolean u_attiva_funzione (st_memo ast_memo, string a_flag_modalita) throws uo_exception;//
//--- Attiva la window x gestire i MEMO (allegati e note varie ) dati 
//--- Inp: 	st_tab_memo.id_memo e il flag_modalita(visual, modifica, ....)
//
boolean k_return = false
st_open_w kst_open_w

	try
		kist_memo = ast_memo
		kst_open_w.flag_modalita = a_flag_modalita
		
		if a_flag_modalita = kkg_flag_modalita.inserimento then
			kst_open_w.key12_any = kist_memo   // devo evere preparato l'area da passare al gestore del MEMO 
		else
			if kist_memo.st_tab_memo.id_memo > 0 then
				
				get_memo_altri_dati(ast_memo.st_tab_memo)  // legge dati del MEMO
				kist_memo.st_tab_memo = ast_memo.st_tab_memo
				kst_open_w.key12_any = kist_memo
			
	//--- controlla se Utente autorizzato			
				if NOT u_if_sicurezza(kist_memo.st_tab_memo, a_flag_modalita) then
					kguo_exception.inizializza( )
					kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_noaut )
					kguo_exception.setmessage("Autorizzazione apertura MEMO non concessa. Tipo '" + kist_memo.st_tab_memo.tipo_sv + "' ")
					throw kguo_exception
				end if
			else
//--- se sono in elenco allora imposta i campi per il gestore				
				if a_flag_modalita = kkg_flag_modalita.elenco then
					kst_open_w.key2 = this.kki_memo_tutti
					kst_open_w.key3 = "0"
					if kist_memo.st_tab_meca_memo.id_meca > 0 then
						kst_open_w.key6 = string(kist_memo.st_tab_meca_memo.id_meca)
						kst_open_w.key1 = this.kki_tipovisualizza_xmeca
					else
						if kist_memo.st_tab_clienti_memo.id_cliente > 0 then
							kst_open_w.key5 = string(kist_memo.st_tab_clienti_memo.id_cliente)
							kst_open_w.key1 = this.kki_tipovisualizza_xanag
						end if
					end if
				end if
			end if
			
		end if
	
	//---- se window non ancora aperta
		if not isvalid(kiw_memo) then
			u_open(kst_open_w)	
	//	else
	//		kiw_memo.u_inizializza()
		end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

return k_return

end function

public function st_memo get_st_memo ();//
return kist_memo
end function

public subroutine set_st_memo (st_memo kst_memo);//
kist_memo = kst_memo

end subroutine

public function long aggiorna (st_memo ast_memo) throws uo_exception;//--------------------------------------------------------------------
//--- Aggiorna riga in tabella  MEMO 
//--- 
//--- Input: st_tab_memo.id_memo (che può essere zero se nuovo)
//--- Ritorna ID_MEMO
//--- 
//--- x errore grave lancia exception
//--------------------------------------------------------------------
// 
long	k_return = 0
st_tab_memo kst_tab_memo

try

	kst_tab_memo = ast_memo.st_tab_memo
	kst_tab_memo.st_tab_g_0.esegui_commit = "N"
	
	if kst_tab_memo.id_memo > 0 then
		if if_esiste( kst_tab_memo) then
		else
			kst_tab_memo.id_memo = 0 
		end if
	end if

	if kst_tab_memo.id_memo	> 0 then
		tb_update(kst_tab_memo )
	else
		kst_tab_memo.id_memo = tb_add(kst_tab_memo)
	end if

//--- aggiorna altri archivi correlati al MEMO
	ast_memo.st_tab_memo.id_memo = kst_tab_memo.id_memo
	ast_memo.st_tab_clienti_memo.id_memo = kst_tab_memo.id_memo
	ast_memo.st_tab_meca_memo.id_memo = kst_tab_memo.id_memo
	ast_memo.st_tab_sl_pt_memo.id_memo = kst_tab_memo.id_memo
	ast_memo.st_tab_meca_memo.st_tab_g_0 = kst_tab_memo.st_tab_g_0
	aggiorna_altri_archivi(ast_memo)
	

//--- faccio la COMMIT
	if ast_memo.st_tab_memo.st_tab_g_0.esegui_commit <> "N" or isnull(ast_memo.st_tab_memo.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if

	if kst_tab_memo.id_memo > 0 then
		k_return = kst_tab_memo.id_memo
	end if

	
catch (uo_exception kuo_exception)
//--- faccio ROLLBACK
	if ast_memo.st_tab_memo.st_tab_g_0.esegui_commit <> "N" or isnull(ast_memo.st_tab_memo.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception
end try


return k_return
end function

private subroutine aggiorna_altri_archivi (st_memo ast_memo) throws uo_exception;//----------------------------------------------------------------------------------------------
//--- Aggiorna gli altri archivi collegati al MEMO
//---
//----------------------------------------------------------------------------------------------
long k_righe = 0, k_riga
st_tab_memo_utenti kst_tab_memo_utenti
kuf_clienti kuf1_clienti
kuf_armo_inout kuf1_armo_inout
kuf_memo_utenti kuf1_memo_utenti
kuf_sl_pt kuf1_sl_pt
datastore kds_sr_utenti_settori_profili_l


//---- aggiorna memo cliente
kuf1_clienti = create kuf_clienti
ast_memo.st_tab_clienti_memo.st_tab_g_0 = ast_memo.st_tab_memo.st_tab_g_0
if ast_memo.st_tab_clienti_memo.id_cliente > 0 then
	kuf1_clienti.memo_save(ast_memo.st_tab_clienti_memo)
else	
	kuf1_clienti.tb_delete(ast_memo.st_tab_clienti_memo)
end if

//----  aggiorna memo Lotto
kuf1_armo_inout = create kuf_armo_inout
ast_memo.st_tab_meca_memo.st_tab_g_0 = ast_memo.st_tab_memo.st_tab_g_0
if ast_memo.st_tab_meca_memo.id_meca > 0 then
	kuf1_armo_inout.memo_save(ast_memo.st_tab_meca_memo)
else	
	kuf1_armo_inout.tb_delete(ast_memo.st_tab_meca_memo)
end if

//----  aggiorna memo PT
kuf1_sl_pt = create kuf_sl_pt
ast_memo.st_tab_sl_pt_memo.st_tab_g_0 = ast_memo.st_tab_memo.st_tab_g_0
if trim(ast_memo.st_tab_sl_pt_memo.cod_sl_pt) > " " then
	kuf1_sl_pt.memo_save(ast_memo.st_tab_sl_pt_memo)
else	
	kuf1_sl_pt.tb_delete(ast_memo.st_tab_sl_pt_memo)
end if

//---- aggiorna Avvisi memo 
kuf1_memo_utenti = create kuf_memo_utenti
if ast_memo.st_tab_memo.tipo_sv > " " then
	kds_sr_utenti_settori_profili_l = create datastore
	kds_sr_utenti_settori_profili_l.dataobject = "d_sr_utenti_settori_profili_l"
	kds_sr_utenti_settori_profili_l.settransobject(kguo_sqlca_db_magazzino )
	k_righe = kds_sr_utenti_settori_profili_l.retrieve(ast_memo.st_tab_memo.tipo_sv)
	kst_tab_memo_utenti.id_memo = ast_memo.st_tab_memo.id_memo
	kst_tab_memo_utenti.st_tab_g_0 = ast_memo.st_tab_memo.st_tab_g_0
	for k_riga = 1 to k_righe
		kst_tab_memo_utenti.id_sr_utente = kds_sr_utenti_settori_profili_l.getitemnumber(k_riga, "sr_utenti_id")
		kuf1_memo_utenti.memo_save(kst_tab_memo_utenti)
	end for
end if
end subroutine

public subroutine tb_delete_altri_archivi (st_tab_memo ast_tab_memo);//
st_tab_clienti_memo kst_tab_clienti_memo
st_tab_meca_memo kst_tab_meca_memo
st_tab_sl_pt_memo kst_tab_sl_pt_memo
st_tab_memo_utenti kst_tab_memo_utenti
st_tab_memo_link kst_tab_memo_link
st_esito kst_esito
kuf_memo_link kuf1_memo_link
kuf_memo_utenti kuf1_memo_utenti
kuf_clienti kuf1_clienti
kuf_armo_inout kuf1_armo_inout
kuf_sl_pt kuf1_sl_pt

try 

//--- cancella prima il link agli allegati
		kuf1_memo_link = create kuf_memo_link
		kst_tab_memo_link.id_memo = ast_tab_memo.id_memo 
		kst_tab_memo_link.st_tab_g_0.esegui_commit = ast_tab_memo.st_tab_g_0.esegui_commit
		kuf1_memo_link.tb_delete_x_id_memo(kst_tab_memo_link)

//--- cancella il MEMO nel cliente		
		kuf1_clienti = create kuf_clienti
		kst_tab_clienti_memo.st_tab_g_0.esegui_commit = ast_tab_memo.st_tab_g_0.esegui_commit
		kst_tab_clienti_memo.id_memo = ast_tab_memo.id_memo
		kuf1_clienti.tb_delete(kst_tab_clienti_memo)
//--- cancella il MEMO nel Lotto		
		kuf1_armo_inout = create kuf_armo_inout
		kst_tab_meca_memo.st_tab_g_0.esegui_commit =  ast_tab_memo.st_tab_g_0.esegui_commit
		kst_tab_meca_memo.id_memo = ast_tab_memo.id_memo
		kuf1_armo_inout.tb_delete(kst_tab_meca_memo)
//--- cancella il MEMO nel PT		
		kuf1_sl_pt = create kuf_sl_pt
		kst_tab_sl_pt_memo.st_tab_g_0.esegui_commit =  ast_tab_memo.st_tab_g_0.esegui_commit
		kst_tab_sl_pt_memo.id_memo = ast_tab_memo.id_memo
		kuf1_sl_pt.tb_delete(kst_tab_sl_pt_memo)
//--- cancella Avviso MEMO Utenti
		kuf1_memo_utenti = create kuf_memo_utenti
		kst_tab_memo_utenti.st_tab_g_0.esegui_commit = ast_tab_memo.st_tab_g_0.esegui_commit
		kst_tab_memo_utenti.id_memo = ast_tab_memo.id_memo
		kuf1_memo_utenti.tb_delete(kst_tab_memo_utenti)


//finally 
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try



end subroutine

public function boolean u_open_ds (st_open_w ast_open_w) throws uo_exception;//
//--- Chiama la OPEN con nel key11 il ds con dentro i dati e key9 in nime del campo "id" della tabella 
//--- (se ci sono particolarità è meglio ereditarla e modificarla)
//---
//--- Input: st_open_w
//---
//
boolean k_return = false
long k_riga = 0
st_tab_clienti_memo kst_tab_clienti_memo
st_tab_meca_memo kst_tab_meca_memo
st_memo kst_memo
kuf_memo_inout kuf1_memo_inout


try
	ast_open_w.id_programma = trim(ast_open_w.id_programma)
	
	if ast_open_w.id_programma > " " then
		
		
		kuf1_memo_inout = create kuf_memo_inout
		
		choose case ast_open_w.key11_ds.dataobject 
			
			case "d_clienti_memo_l"
				if ast_open_w.key11_ds.rowcount() > 0 or ast_open_w.flag_modalita = kkg_flag_modalita.inserimento then
					kst_tab_clienti_memo.id_cliente = 0
					kst_tab_clienti_memo.id_cliente_memo = 0
					if ast_open_w.key11_ds.rowcount() > 0 then
						kst_tab_clienti_memo.id_cliente = ast_open_w.key11_ds.getitemnumber(1, "id_cliente")
						if ast_open_w.flag_modalita = kkg_flag_modalita.inserimento then
						else
							k_riga = ast_open_w.key11_ds.getrow()
							if k_riga = 0 then k_riga = 1
							kst_tab_clienti_memo.id_cliente_memo = ast_open_w.key11_ds.getitemnumber(k_riga, "id_cliente_memo")
						end if
					end if
					kuf1_memo_inout.memo_xcliente(kst_tab_clienti_memo, kst_memo.st_tab_memo)
					u_attiva_funzione(kst_memo, ast_open_w.flag_modalita )   // APRE FUNZIONE
					k_return = true
				end if
			
			case "d_meca_memo_l"
				if ast_open_w.key11_ds.rowcount() > 0 or ast_open_w.flag_modalita = kkg_flag_modalita.inserimento then
					kst_tab_meca_memo.id_meca = 0
					kst_tab_meca_memo.id_meca_memo = 0
					if ast_open_w.key11_ds.rowcount() > 0 then
						kst_tab_meca_memo.id_meca = ast_open_w.key11_ds.getitemnumber(1, "id_meca")
						if ast_open_w.flag_modalita = kkg_flag_modalita.inserimento then
						else
							k_riga = ast_open_w.key11_ds.getrow()
							if k_riga = 0 then k_riga = 1
							kst_tab_meca_memo.id_meca_memo = ast_open_w.key11_ds.getitemnumber(k_riga, "id_meca_memo")
						end if
					end if
					kuf1_memo_inout.memo_xmeca(kst_tab_meca_memo, kst_memo.st_tab_memo)
					u_attiva_funzione(kst_memo, ast_open_w.flag_modalita )   // APRE FUNZIONE
					k_return = true
				end if
			
			
		end choose
		
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
	
end try


return k_return



end function

private subroutine u_open_window_old (string a_flag_modalita);//
st_open_w k_st_open_w
	
	
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = a_flag_modalita
		K_st_open_w.id_programma = this.get_id_programma(K_st_open_w.flag_modalita) //kkg_id_programma_anag_memo
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = " "
		k_st_open_w.key12_any = this.kist_memo
		K_st_open_w.flag_where = " "
		
		kguf_menu_window.open_w_tabelle(k_st_open_w)
		
	




end subroutine

on kuf_memo.create
call super::create
end on

on kuf_memo.destroy
call super::destroy
end on

