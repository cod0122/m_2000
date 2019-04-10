$PBExportHeader$kuf_convalida_calc.sru
forward
global type kuf_convalida_calc from kuf_parent
end type
end forward

global type kuf_convalida_calc from kuf_parent
end type
global kuf_convalida_calc kuf_convalida_calc

forward prototypes
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function st_esito u_open (ref st_open_w ast_open_w)
end prototypes

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
boolean k_return 
kuf_meca_dosim kuf1_meca_dosim


kuf1_meca_dosim = create kuf_meca_dosim
k_return = kuf1_meca_dosim.if_sicurezza(ast_open_w)
destroy kuf1_meca_dosim

return k_return
end function

public function st_esito u_open (ref st_open_w ast_open_w);//---
//--- Apre la Window x le diverse funzioni
//---
//--- Input: st_open_w
//--- Out: TRUE = finestra aperta; FASE=operazione non eseguita
//---
//boolean k_return = false
string k_rc = ""
st_esito kst_esito 
kuf_menu_window kuf1_menu_window


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	
	ast_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
	ast_open_w.id_programma = get_id_programma( ast_open_w.flag_modalita )
	ast_open_w.flag_primo_giro = "S"
	if not isvalid(ast_open_w.key12_any) then ast_open_w.key12_any = this			// questo oggetto di gestione del trova

	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_conv_calc(ast_open_w)
	destroy kuf1_menu_window
	//k_return = true


return kst_esito

end function

on kuf_convalida_calc.create
call super::create
end on

on kuf_convalida_calc.destroy
call super::destroy
end on

