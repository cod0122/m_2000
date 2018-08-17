$PBExportHeader$kuf_doctipo.sru
forward
global type kuf_doctipo from kuf_parent
end type
end forward

global type kuf_doctipo from kuf_parent
end type
global kuf_doctipo kuf_doctipo

type variables
//
//--- Tipi Documenti
public constant string kki_tipo_attestati = "A"
public constant string kki_tipo_ddt = "B"
public constant string kki_tipo_fatture = "F"
public constant string kki_tipo_contr_co = "X"
public constant string kki_tipo_contr_rd = "Y"
public constant string kki_tipo_report_PILOTA = "P"



end variables

forward prototypes
public function long get_id_doctipo_da_tipo (st_tab_doctipo kst_tab_doctipo) throws uo_exception
end prototypes

public function long get_id_doctipo_da_tipo (st_tab_doctipo kst_tab_doctipo) throws uo_exception;//
//-------------------------------------------------------------------------------------------------------------------
//--- Legge tabella DOCTIPO per reperire il ID dal codice TIPO
//--- 
//--- Input: st_tab_doctipo.tipo
//--- Out:  
//--- Ritorna  ID_DOCTIPO
//--- 
//--- lancia UO_EXCEPTION x errore
//---
//-------------------------------------------------------------------------------------------------------------------
long k_return = 0
st_esito kst_esito

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()



  SELECT   
		 id_doctipo
    INTO 
	 	  :kst_tab_doctipo.id_doctipo 
        FROM doctipo
        WHERE ( tipo = :kst_tab_doctipo.tipo   )   
		using kguo_sqlca_db_magazzino;


	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Tab. Tipi Documento (doctipo): " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	end if
	if kst_esito.esito = kkg_esito.db_ko then
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if kst_tab_doctipo.id_doctipo > 0 then
		k_return = kst_tab_doctipo.id_doctipo
	end if

return k_return

end function

on kuf_doctipo.create
call super::create
end on

on kuf_doctipo.destroy
call super::destroy
end on

