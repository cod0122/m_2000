$PBExportHeader$kuf_memo_inout.sru
forward
global type kuf_memo_inout from kuf_parent
end type
end forward

global type kuf_memo_inout from kuf_parent
end type
global kuf_memo_inout kuf_memo_inout

forward prototypes
public function boolean crea_memo_cliente (ref st_memo ast_memo) throws uo_exception
public function boolean crea_memo_meca (ref st_memo ast_memo) throws uo_exception
public function boolean crea_memo (ref st_memo ast_memo, st_open_w ast_open_w) throws uo_exception
public subroutine memo_xmeca (ref st_tab_meca_memo ast_tab_meca_memo, ref st_tab_memo ast_tab_memo) throws uo_exception
public subroutine memo_xcliente (ref st_tab_clienti_memo ast_tab_clienti_memo, ref st_tab_memo ast_tab_memo) throws uo_exception
end prototypes

public function boolean crea_memo_cliente (ref st_memo ast_memo) throws uo_exception;//
//--- Crea in automatico un MEMO fascicolato x il CLIENTE con anche gli allegati
//---
//--- Inp: st_memo.st_tab_clienti_memo.id_cliente, st_tab_meca_link[...] (allegati)
//--- Out: st_memo valorizzata
//--- Rit: TRUE = OK caricato
//
boolean k_return = false
int a_file_nr, k_riga, k_nr_allegati=0
st_tab_clienti kst_tab_clienti 
st_tab_memo_link kst_tab_memo_link[]
st_memo kst_memo
kuf_clienti kuf1_clienti
kuf_memo kuf1_memo
kuf_memo_allarme kuf1_memo_allarme
kuf_memo_link kuf1_memo_link
kuf_utility kuf1_utility
kuf_sr_sicurezza kuf1_sr_sicurezza


try   

	if ast_memo.st_tab_clienti_memo.id_cliente > 0 then

		if NOT isvalid(kuf1_clienti) then kuf1_clienti = create kuf_clienti 
		if NOT isvalid(kuf1_memo) then kuf1_memo = create kuf_memo 
		if NOT isvalid(kuf1_memo_link) then kuf1_memo_link = create kuf_memo_link 
		if NOT isvalid(kuf1_utility) then kuf1_utility = create kuf_utility 
		
		memo_xcliente(ast_memo.st_tab_clienti_memo, ast_memo.st_tab_memo)   	// imposta dati standard del memo 

		ast_memo.st_tab_memo.permessi = kuf1_sr_sicurezza.ki_permessi_scrittura 

		kst_tab_clienti.codice = ast_memo.st_tab_clienti_memo.id_cliente
		kuf1_clienti.get_nome(kst_tab_clienti)
		ast_memo.st_tab_memo.memo = blob("{\rtf1\ansi Memo generato in automatico, settore '" + ast_memo.st_tab_memo.tipo_sv + "' per " + " " + trim(kst_tab_clienti.rag_soc_10 ) + " (" + string(ast_memo.st_tab_clienti_memo.id_cliente) + "), leggere la sezione 'Allegati' \par }")
		
		ast_memo.st_tab_memo.id_memo = kuf1_memo.aggiorna(ast_memo)		// inserisce il memo su DB

		kst_tab_memo_link[] = ast_memo.st_tab_memo_link[]
		a_file_nr = upperbound(ast_memo.st_tab_memo_link[])
		for k_riga = 1 to a_file_nr
			
			kst_tab_memo_link[k_riga].id_memo_link = 0
			kst_tab_memo_link[k_riga].id_memo = ast_memo.st_tab_memo.id_memo
			kst_tab_memo_link[k_riga].tipo_memo_link = kuf1_utility.u_get_ext_file(kst_tab_memo_link[k_riga].link)
			kst_tab_memo_link[k_riga].nome = kuf1_utility.u_get_nome_file(kst_tab_memo_link[k_riga].link)
			kst_tab_memo_link[k_riga].titolo = "Allegato " + kst_tab_memo_link[k_riga].nome
			
		next
		if a_file_nr > 0 then
			k_nr_allegati = kuf1_memo_link.crea_memo_link(kst_tab_memo_link[])  // aggiunge gli allegati
		end if
		
		if a_file_nr = k_nr_allegati then
			k_return = true
		end if
		
	end if
		
		
catch (uo_exception	kuo_exception)
	throw kuo_exception
		
end try
	
	
return k_return 

end function

public function boolean crea_memo_meca (ref st_memo ast_memo) throws uo_exception;//
//--- Crea in automatico un MEMO fascicolato x il LOTTO con anche gli allegati
//---
//--- Inp: st_memo.st_tab_meca_memo.id_meca, st_tab_meca_link[...] (allegati)
//--- Out: st_memo valorizzata
//--- Rit: TRUE = OK caricato
//
boolean k_return = false
int a_file_nr, k_riga, k_nr_allegati=0
st_tab_clienti kst_tab_clienti 
st_tab_memo_link kst_tab_memo_link[]
st_tab_meca kst_tab_meca
st_memo kst_memo
kuf_armo kuf1_armo
kuf_clienti kuf1_clienti
kuf_memo kuf1_memo
kuf_memo_allarme kuf1_memo_allarme
kuf_memo_link kuf1_memo_link
kuf_utility kuf1_utility
kuf_sr_sicurezza kuf1_sr_sicurezza


try   

	if ast_memo.st_tab_meca_memo.id_meca > 0 then

		if NOT isvalid(kuf1_clienti) then kuf1_clienti = create kuf_clienti 
		if NOT isvalid(kuf1_armo) then kuf1_armo = create kuf_armo 
		if NOT isvalid(kuf1_memo) then kuf1_memo = create kuf_memo 
		if NOT isvalid(kuf1_memo_link) then kuf1_memo_link = create kuf_memo_link 
		if NOT isvalid(kuf1_utility) then kuf1_utility = create kuf_utility 
		
		memo_xmeca(ast_memo.st_tab_meca_memo, ast_memo.st_tab_memo)   	// imposta dati standard del memo 

		ast_memo.st_tab_memo.permessi = kuf1_sr_sicurezza.ki_permessi_scrittura 

		kst_tab_meca.id = ast_memo.st_tab_meca_memo.id_meca
		kuf1_armo.get_dati_rid(kst_tab_meca)
		kst_tab_clienti.codice = kst_tab_meca.clie_3
		kuf1_clienti.get_nome(kst_tab_clienti)
		ast_memo.st_tab_memo.memo = blob("{\rtf1\ansi Memo generato in automatico, settore '" + ast_memo.st_tab_memo.tipo_sv + "' " + " Lotto " + string(kst_tab_meca.num_int) + " " + string(kst_tab_meca.data_int) + " cliente " + " " + trim(kst_tab_clienti.rag_soc_10 ) + " (" + string(kst_tab_meca.clie_3) + "), leggere la sezione 'Allegati' \par }")
		
		ast_memo.st_tab_memo.id_memo = kuf1_memo.aggiorna(ast_memo)		// inserisce il memo su DB

		kst_tab_memo_link[] = ast_memo.st_tab_memo_link[]
		a_file_nr = upperbound(ast_memo.st_tab_memo_link[])
		for k_riga = 1 to a_file_nr
			
			kst_tab_memo_link[k_riga].id_memo_link = 0
			kst_tab_memo_link[k_riga].id_memo = ast_memo.st_tab_memo.id_memo
			kst_tab_memo_link[k_riga].tipo_memo_link = kuf1_utility.u_get_ext_file(kst_tab_memo_link[k_riga].link)
			kst_tab_memo_link[k_riga].nome = kuf1_utility.u_get_nome_file(kst_tab_memo_link[k_riga].link)
			kst_tab_memo_link[k_riga].titolo = "Allegato " + kst_tab_memo_link[k_riga].nome
			
		next
		if a_file_nr > 0 then
			k_nr_allegati = kuf1_memo_link.crea_memo_link(kst_tab_memo_link[])  // aggiunge gli allegati
		end if
		
		if a_file_nr = k_nr_allegati then
			k_return = true
		end if
		
	end if
		
		
catch (uo_exception	kuo_exception)
	throw kuo_exception
		
end try
	
	
return k_return 

end function

public function boolean crea_memo (ref st_memo ast_memo, st_open_w ast_open_w) throws uo_exception;//
//--- Crea in automatico un MEMO per un Oggetto non ancora identificato
//---
//--- Inp: st_memo riempita con le aree st_tab_meca_link[...] (allegati)
//---     st_open_w.id_programma + key11_ds con il ds caricato con il dato ad esempio id_meca da estrarre
//--- Out: st_memo valorizzata
//--- Rit: TRUE = OK caricato
//
boolean k_return = false
kuf_armo kuf1_armo
kuf_clienti kuf1_clienti
kuf_memo kuf1_memo
kuf_sr_sicurezza kuf1_sr_sicurezza


try   

	if NOT isvalid(kuf1_sr_sicurezza) then kuf1_sr_sicurezza = create kuf_sr_sicurezza 
	if NOT isvalid(kuf1_armo) then kuf1_armo = create kuf_armo 
	if NOT isvalid(kuf1_clienti) then kuf1_clienti = create kuf_clienti 

	choose case ast_open_w.id_programma
	
		case kuf1_armo.get_id_programma(kkg_flag_modalita.visualizzazione )
			ast_memo.st_tab_meca_memo.id_meca = ast_open_w.key11_ds.object.id_meca[1] 
			ast_memo.st_tab_meca_memo.tipo_sv = kuf1_sr_sicurezza.get_sr_settore(ast_open_w.id_programma)
			k_return = crea_memo_meca(ast_memo)

		case kuf1_clienti.get_id_programma(kkg_flag_modalita.visualizzazione )
			ast_memo.st_tab_clienti_memo.id_cliente = ast_open_w.key11_ds.object.codice[1] 
			ast_memo.st_tab_clienti_memo.tipo_sv = kuf1_sr_sicurezza.get_sr_settore(ast_open_w.id_programma)
			k_return = crea_memo_cliente(ast_memo)
			
	end choose

		
catch (uo_exception	kuo_exception)
	throw kuo_exception
		
end try
	
	
return k_return 

end function

public subroutine memo_xmeca (ref st_tab_meca_memo ast_tab_meca_memo, ref st_tab_memo ast_tab_memo) throws uo_exception;//
//--- Chiama la window per caricare il MEMO
//---
//--- Inp: st_tab_meca_memo.id_meca, tipo_sv, id_meca_memo (=0 è insert)
//
string k_settore
st_tab_meca kst_tab_meca 
st_tab_clienti kst_tab_clienti
kuf_armo kuf1_armo
kuf_armo_inout kuf1_armo_inout
kuf_clienti kuf1_clienti
datastore kds_sr_settori


try   

	kds_sr_settori = create datastore
	kds_sr_settori.dataobject = "ds_sr_settori"
	kds_sr_settori.settransobject(kguo_sqlca_db_magazzino)

	kuf1_armo = create kuf_armo
	kuf1_armo_inout = create kuf_armo_inout
	kuf1_clienti = create kuf_clienti
	
	if ast_tab_meca_memo.id_meca_memo > 0 then
		kuf1_armo_inout.get_id_memo(ast_tab_meca_memo)
	else
		ast_tab_meca_memo.id_memo = 0
	end if
		
	if ast_tab_meca_memo.id_meca  > 0 then
		
		kst_tab_meca.id = ast_tab_meca_memo.id_meca
		kuf1_armo.get_num_int(kst_tab_meca)
		kuf1_armo.get_clie(kst_tab_meca)
		if kst_tab_meca.clie_1 > 0 then
			kst_tab_clienti.codice = kst_tab_meca.clie_1
			kuf1_clienti.get_nome(kst_tab_clienti)
		end if
		
		k_settore = ""
		ast_tab_memo.tipo_sv = ast_tab_meca_memo.tipo_sv
		if trim(ast_tab_meca_memo.tipo_sv) > " " then
			if kds_sr_settori.retrieve(ast_tab_meca_memo.tipo_sv) > 0 then
				k_settore = kds_sr_settori.getitemstring(1, "descr")
			end if
		end if
//		if ast_tab_meca_memo.tipo_sv > " " then
//			ast_tab_memo.titolo = "Informazioni dal dip. '" + ast_tab_meca_memo.tipo_sv + "' per il Lotto " + string(kst_tab_meca.num_int) + " / " + string(kst_tab_meca.data_int)
//		else
//			ast_tab_memo.titolo = "Informazioni  per il Lotto " + string(kst_tab_meca.num_int) + " / " + string(kst_tab_meca.data_int)
//		end if
		if kst_tab_meca.clie_1 > 0 then
			ast_tab_memo.titolo = "Da " + trim(kguo_utente.get_nome( )) + " Lotto " + string(kst_tab_meca.num_int) + " " + string(kst_tab_meca.data_int) + " " + trim(kst_tab_clienti.rag_soc_10) + " (" + string(kst_tab_clienti.codice) + ")"
		else
			ast_tab_memo.titolo = "Informazioni Lotto " + string(kst_tab_meca.num_int) + " del " + string(kst_tab_meca.data_int)
		end if
		if k_settore > " " then
			ast_tab_memo.note = "Note dal dip. '" + k_settore + "'. Lotto id " + string(kst_tab_meca.id) + " nr. " + string(kst_tab_meca.num_int) + " " + string(kst_tab_meca.data_int)
		else
			ast_tab_memo.note = "Note Lotto id " + string(kst_tab_meca.id) + " nr. " + string(kst_tab_meca.num_int) + " " + string(kst_tab_meca.data_int)
		end if
		
		ast_tab_memo.id_memo = ast_tab_meca_memo.id_memo
		
		
//		kst_memo.st_tab_memo = ast_tab_memo
//		kst_memo.st_tab_meca_memo = ast_tab_meca_memo
		
	end if
		 
catch (uo_exception	kuo_exception)
	throw kuo_exception
		
end try
	
//return kst_memo


end subroutine

public subroutine memo_xcliente (ref st_tab_clienti_memo ast_tab_clienti_memo, ref st_tab_memo ast_tab_memo) throws uo_exception;//
//--- Fascicola MEMO x il Cliente
//---
//--- Inp: st_tab_clienti_memo.id_cliente, tipo_sv, id_cliente_memo (=0 è insert)
//
string k_settore
st_tab_clienti_memo kst_tab_clienti_memo 
st_tab_clienti kst_tab_clienti 
//st_tab_memo ast_tab_memo
datastore kds_sr_settori
kuf_clienti kuf1_clienti 
st_memo kst_memo

try   

	if ast_tab_clienti_memo.id_cliente  > 0 then

//--- imposta i dati di default del memo
		kst_memo.st_tab_clienti_memo = ast_tab_clienti_memo

		kuf1_clienti = create kuf_clienti
	
		kst_tab_clienti_memo = kst_memo.st_tab_clienti_memo
	
		kds_sr_settori = create datastore
		kds_sr_settori.dataobject = "ds_sr_settori"
		kds_sr_settori.settransobject(kguo_sqlca_db_magazzino)
		
		if kst_tab_clienti_memo.id_cliente_memo > 0 then
			kuf1_clienti.get_id_memo(kst_tab_clienti_memo)
		else
			kst_tab_clienti_memo.id_memo = 0
		end if
			
		kst_tab_clienti.codice = kst_tab_clienti_memo.id_cliente
		kuf1_clienti.get_nome(kst_tab_clienti)
		
		k_settore = ""
		ast_tab_memo.tipo_sv = kst_tab_clienti_memo.tipo_sv
		if trim(kst_tab_clienti_memo.tipo_sv) > " " then
			if kds_sr_settori.retrieve(kst_tab_clienti_memo.tipo_sv) > 0 then
				k_settore = kds_sr_settori.getitemstring(1, "descr")
			end if
		end if
//		if kst_tab_clienti_memo.tipo_sv > " " then
//			ast_tab_memo.titolo = "Informazioni da '" + kst_tab_clienti_memo.tipo_sv + "' per " + trim(kst_tab_clienti.rag_soc_10 )
//		else
			ast_tab_memo.titolo = "Da " + trim(kguo_utente.get_nome( )) + " per " + trim(kst_tab_clienti.rag_soc_10) + " " + trim(kst_tab_clienti.rag_soc_11) + " (" + string(kst_tab_clienti.codice) + ")"
//			ast_tab_memo.titolo = "Informazioni per " + trim(kst_tab_clienti.rag_soc_10 )
//		end if
		if k_settore > " " then
			ast_tab_memo.note = "Note dal dip. '" + k_settore + "' per " + string(kst_tab_clienti_memo.id_cliente) + " " + trim(kst_tab_clienti.rag_soc_10 ) 
		else
			ast_tab_memo.note = "Note per il " + string(kst_tab_clienti_memo.id_cliente) + " " + trim(kst_tab_clienti.rag_soc_10 ) 
		end if
		
		ast_tab_memo.id_memo = kst_tab_clienti_memo.id_memo
		
//		kst_memo.st_tab_memo = ast_tab_memo
//		kst_memo.st_tab_clienti_memo = kst_tab_clienti_memo
		
	end if
		
catch (uo_exception	kuo_exception)
	throw kuo_exception
		
end try
	
//return kst_memo

end subroutine

on kuf_memo_inout.create
call super::create
end on

on kuf_memo_inout.destroy
call super::destroy
end on

