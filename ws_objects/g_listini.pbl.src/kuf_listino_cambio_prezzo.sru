$PBExportHeader$kuf_listino_cambio_prezzo.sru
forward
global type kuf_listino_cambio_prezzo from kuf_listino
end type
end forward

global type kuf_listino_cambio_prezzo from kuf_listino
end type
global kuf_listino_cambio_prezzo kuf_listino_cambio_prezzo

type variables
//---
//--- Solo x gestione Autorizzazioni Funzione 
//--- Funzione: cambio PREZZI a Listino
//---

end variables

forward prototypes
public function boolean u_cambia_stato (readonly st_listini_cambio_stato kast_listini_cambio_stato) throws uo_exception
end prototypes

public function boolean u_cambia_stato (readonly st_listini_cambio_stato kast_listini_cambio_stato) throws uo_exception;//--------------------------------------------------------------------------------------------------------------------------
//---
//--- Cambia lo stato del LISTINO
//---
//--- inp: st_listini_cambia_stato  stato / data_scad
//--- out: 
//---
//--- Ritorna: TRUE = OK
//--- LanciaEXCEPTION
//---
//--------------------------------------------------------------------------------------------------------------------------
boolean k_return = false
st_tab_listino kst_tab_listino
st_tab_contratti kst_tab_contratti


	if not isnull(kast_listini_cambio_stato.data_scad) and kast_listini_cambio_stato.data_scad > date(0) then

		kst_tab_contratti.data_scad = kast_listini_cambio_stato.data_scad
		kst_tab_listino.st_tab_g_0.esegui_commit = "S"

//--- Disattiva lo stato dei Listini alla Data
		if kast_listini_cambio_stato.stato = 0 then 
			
			k_return = set_stato_annullato_massivo(kst_tab_listino, kst_tab_contratti)			
			
		else
			
//--- Attiva lo stato dei Listini dalla Data
			if kast_listini_cambio_stato.stato = 1 then 
				
				k_return = set_stato_attivo_massivo(kst_tab_listino, kst_tab_contratti)			
			
			end if
		end if
	end if


return k_return



end function

on kuf_listino_cambio_prezzo.create
call super::create
end on

on kuf_listino_cambio_prezzo.destroy
call super::destroy
end on

