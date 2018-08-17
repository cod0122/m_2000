$PBExportHeader$kuf_memo_automat.sru
forward
global type kuf_memo_automat from nonvisualobject
end type
end forward

global type kuf_memo_automat from nonvisualobject
end type
global kuf_memo_automat kuf_memo_automat

type variables
//
//--- Carica un MEMO in Automatico 
//
end variables

forward prototypes
public subroutine crea_meca_memo (ref st_memo ast_memo) throws uo_exception
end prototypes

public subroutine crea_meca_memo (ref st_memo ast_memo) throws uo_exception;//
//--- Crea in automatico un MEMO x MECA con allegato
//---
//--- Inp: st_memo.st_tab_clienti_memo.id_cliente, st_tab_meca_link[...] (allegati)
//
int a_file_nr, k_riga
//st_tab_clienti_memo kst_tab_clienti_memo 
st_tab_clienti kst_tab_clienti 
st_tab_memo_link kst_tab_memo_link[]
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
		
//		kuf1_clienti.memo_set(ast_memo)   	// imposta dati standard del memo 

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
			kuf1_memo_link.crea_memo_link(kst_tab_memo_link[])  // aggiunge gli allegati
		end if
	
		
	end if
		
catch (uo_exception	kuo_exception)
	throw kuo_exception
		
end try
	


end subroutine

on kuf_memo_automat.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_memo_automat.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

