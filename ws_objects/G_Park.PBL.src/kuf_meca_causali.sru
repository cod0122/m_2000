$PBExportHeader$kuf_meca_causali.sru
forward
global type kuf_meca_causali from kuf_parent
end type
end forward

global type kuf_meca_causali from kuf_parent
end type
global kuf_meca_causali kuf_meca_causali

forward prototypes
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function boolean if_sicurezza (string aflag_modalita) throws uo_exception
public function integer get_clie_1 (st_tab_meca_causali ast_tab_meca_causali) throws uo_exception
public subroutine get_dati (ref st_tab_meca_causali ast_tab_meca_causali) throws uo_exception
end prototypes

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;kuf_armo kuf1_armo

kuf1_armo = create kuf_armo
return kuf1_armo.if_sicurezza(ast_open_w)
end function

public function boolean if_sicurezza (string aflag_modalita) throws uo_exception;kuf_armo kuf1_armo

kuf1_armo = create kuf_armo
return kuf1_armo.if_sicurezza(aflag_modalita)
end function

public function integer get_clie_1 (st_tab_meca_causali ast_tab_meca_causali) throws uo_exception;//
//====================================================================
//=== Legge il codice Mandante
//=== 
//===  input: st_tab_meca_causali.ID_MECA_CAUSALE 
//===  Out: --
//===  Rit.: codice Mandante 
//===        
//===  Lancia EXCEPTION x errore grave
//===                                     
//====================================================================
//
integer k_return=0
st_esito kst_esito


	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	 
	SELECT clie_1
			 INTO :ast_tab_meca_causali.clie_1
			 FROM meca_causali
			WHERE ID_MECA_CAUSALE = :ast_tab_meca_causali.ID_MECA_CAUSALE
				 using kguo_sqlca_db_magazzino ;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Lettura tab. Causali per codice Mandante. Causale " + string(ast_tab_meca_causali.ID_MECA_CAUSALE) + ") " &
									 + "~n~rErrore: "  + trim(SQLCA.SQLErrText)
		kst_esito.esito = kkg_esito_db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if isnull(ast_tab_meca_causali.clie_1) then ast_tab_meca_causali.clie_1 = 0
	
	k_return = ast_tab_meca_causali.clie_1
	

return k_return

end function

public subroutine get_dati (ref st_tab_meca_causali ast_tab_meca_causali) throws uo_exception;//
//====================================================================
//=== Torna diversi dati dell'archivio
//=== 
//=== 
//===  input: st_tab_meca_causali.ID_MECA_CAUSALE 
//===  Out: st_tab_meca_causali.*
//===  Rit.:
//===        
//===  Lancia EXCEPTION x errore grave
//===                                     
//====================================================================
//
integer k_return=0
st_esito kst_esito


	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	 
         select distinct
                MECA_CAUSALI.DESCRIZIONE
                ,MECA_CAUSALI.CLIE_1
                ,MECA_CAUSALI.ART
                ,MECA_CAUSALI.cod_blk
                ,MECA_CAUSALI.rich_autorizz
                ,MECA_CAUSALI.flag_ddt_si
            into
                 :ast_tab_meca_causali.DESCRIZIONE
                ,:ast_tab_meca_causali.CLIE_1
                ,:ast_tab_meca_causali.art
			 FROM meca_causali
			WHERE ID_MECA_CAUSALE = :ast_tab_meca_causali.ID_MECA_CAUSALE
				 using kguo_sqlca_db_magazzino ;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Lettura tabella Causali. Causale " + string(ast_tab_meca_causali.ID_MECA_CAUSALE) + ") " &
									 + "~n~rErrore: "  + trim(SQLCA.SQLErrText)
		kst_esito.esito = kkg_esito_db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if


end subroutine

on kuf_meca_causali.create
call super::create
end on

on kuf_meca_causali.destroy
call super::destroy
end on

