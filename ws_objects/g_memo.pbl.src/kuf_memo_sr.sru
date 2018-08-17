$PBExportHeader$kuf_memo_sr.sru
forward
global type kuf_memo_sr from kuf_parent
end type
end forward

global type kuf_memo_sr from kuf_parent
end type
global kuf_memo_sr kuf_memo_sr

type variables
//--- Gestione Sicurezza del memo  
private kuf_memo kuf1_memo

private constant string kki_tipo_sv_id_programma_MKT = "mkt" // oggetto del marketing
private constant string kki_tipo_sv_id_programma_ANA = "cll" // oggetto Anagrafiche Mand/Riceventi/Clienti
//private constant string kki_tipo_sv_id_programma_MAG = "meca_l"  //oggetto allegati al Riferimento
//private constant string kki_tipo_sv_id_programma_QLT = "riferim_e"  //oggetto allegati al Riferimento Qualità ad esmpio allo Sblocco lotto
private constant string kki_tipo_sv_id_programma_DSM = "convalida"  //oggetto allegati al Riferimento - dosimetria convalida
//private constant string kki_tipo_sv_id_programma_CRD = "ct_rd_l"  //oggetto x contratti RD
//private constant string kki_tipo_sv_id_programma_CCO = "ct_co_l"  //oggetto x contratti COMMERCIALI
//private constant string kki_tipo_sv_id_programma_CDP = "ct_dp_l"  //oggetto x contratti CONTO DEPOSITO

end variables

forward prototypes
public function boolean u_if_sicurezza (st_tab_memo ast_tab_memo, string a_flag_modalita) throws uo_exception
end prototypes

public function boolean u_if_sicurezza (st_tab_memo ast_tab_memo, string a_flag_modalita) throws uo_exception;//---
//--- Verifica se Utente Autorizzato a vedere il MEMO
//---
//--- input: ast_tab_memo.tipo_sv
//--- output: TRUE=autorizzato, FALSE=NO
//---------------------------------------------------------------------------------------------------------
boolean k_return=false
long k_id_utente = 0
st_tab_sr_utenti kst_tab_sr_utenti
//st_open_w kst_open_w
//kuf_armo kuf1_armo
//kuf_contratti_co kuf1_contratti_co
//kuf_contratti_dp kuf1_contratti_dp
//kuf_contratti_rd kuf1_contratti_rd
kuf_sr_sicurezza  kuf1_sr_sicurezza 

	
	kuf1_sr_sicurezza  = create kuf_sr_sicurezza 

//--- se l'utente è lo stesso creatore del documento allora impongo al massimo il permesso
	if isnumber(ast_tab_memo.utente_ins) then
		kst_tab_sr_utenti.id = long(ast_tab_memo.utente_ins)
	else
		kst_tab_sr_utenti.id = 0
	end if
	if kuf1_sr_sicurezza.if_utente_uguale(kst_tab_sr_utenti) then 
		ast_tab_memo.permessi = kuf1_sr_sicurezza.ki_permessi_completo
	end if
		
//	kst_open_w.flag_modalita = a_flag_modalita    //kkg_flag_modalita.visualizzazione
	k_id_utente = kguo_utente.get_id_utente( )
	if k_id_utente > 0 then
		k_return = kuf1_sr_sicurezza.autorizza_utente_settore(k_id_utente , ast_tab_memo.tipo_sv, ast_tab_memo.permessi, a_flag_modalita)
//			k_return = kuf1_sr_sicurezza.autorizza_funzione(kst_open_w)
	end if
	
	if isvalid(kuf1_sr_sicurezza) then destroy kuf1_sr_sicurezza
			
return k_return

end function

event constructor;call super::constructor;//
kuf1_memo = create kuf_memo

end event

on kuf_memo_sr.create
call super::create
end on

on kuf_memo_sr.destroy
call super::destroy
end on

