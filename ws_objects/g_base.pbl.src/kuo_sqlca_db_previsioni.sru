$PBExportHeader$kuo_sqlca_db_previsioni.sru
forward
global type kuo_sqlca_db_previsioni from kuo_sqlca_db_0
end type
end forward

global type kuo_sqlca_db_previsioni from kuo_sqlca_db_0
end type
global kuo_sqlca_db_previsioni kuo_sqlca_db_previsioni

type variables

end variables

forward prototypes
public function boolean db_connetti () throws uo_exception
public function boolean if_connessione_bloccata () throws uo_exception
end prototypes

public function boolean db_connetti () throws uo_exception;//---
//--- Effettua la connessione al DB "esterno" leggendo i parametri da TAB
//---
boolean k_return=false
st_tab_db_cfg kst_tab_db_cfg
st_esito kst_esito
datastore kds_tab_db_cfg
kuf_db_cfg kuf1_db_cfg

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

	
try
	kuf1_db_cfg = create kuf_db_cfg
	
//--- piglia i dati di connessione dal DB	
	kst_tab_db_cfg.codice = kuf1_db_cfg.kki_codice_xprevisioni
	kuf1_db_cfg.get_profilo_db(kst_tab_db_cfg)   // recupera i dati delprofilo di connessione

	k_return = db_connetti(kst_tab_db_cfg)
	
catch (uo_exception kuo_exception)	
	throw kuo_exception
	
finally
	destroy kuf1_db_cfg
	

end try

return k_return
end function

public function boolean if_connessione_bloccata () throws uo_exception;//
//---	Torna FALSE=connessione OK, TRUE=connessione BLOCCATA
//--- da personalizzare
//
boolean k_return = false
st_tab_db_cfg kst_tab_db_cfg
kuf_db_cfg kuf1_db_cfg


	kuf1_db_cfg = create kuf_db_cfg
		
	kst_tab_db_cfg.codice = kuf1_db_cfg.kki_codice_xprevisioni
	if kuf1_db_cfg.if_connessione_bloccata(kst_tab_db_cfg) then    // Connessione bloccata?? speriamo di no
		k_return = true
	end if
	
return k_return
end function

on kuo_sqlca_db_previsioni.create
call super::create
end on

on kuo_sqlca_db_previsioni.destroy
call super::destroy
end on

event constructor;call super::constructor;//
 ki_db_descrizione = "DB delle PREVISIONI (ACCESS)"
end event

