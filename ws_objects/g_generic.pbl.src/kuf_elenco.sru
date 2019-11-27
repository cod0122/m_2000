$PBExportHeader$kuf_elenco.sru
forward
global type kuf_elenco from kuf_parent
end type
end forward

global type kuf_elenco from kuf_parent
end type
global kuf_elenco kuf_elenco

type variables
//
public constant string ki_esci_dopo_scelta = "S"

end variables

forward prototypes
public subroutine _readme ()
public function boolean u_open_zoom (string a_titolo, string a_campo_link, ref datastore adsi_elenco_output)
end prototypes

public subroutine _readme ();//-------------------------------------------------------------------------------------
//--- Funzione di zoom o anteprima in formato tab
//-------------------------------------------------------------------------------------
// di solto è scatenata cliccando su un link come un codice 
//
// andrebbe chiamata così
//		kuf_elenco kuf1_elenco
//		kuf1_elenco = create kuf_elenco

//		kuf1_elenco.u_open_zoom(a_campo_link, kdsi_elenco_output) //CAMPO DI LINK + DATASTORE CON I DATI
	
//	oppure

// 	st_open_w kst_open_w
//		kst_open_w.key1 = "titolo"										   TITOLO DA FAR APPARIRE NEL TAB APERTO
//		kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)   	IL NOME DEL DATAOBJECT 
//		kst_open_w.key3 = "0"     											EVENTUALE NR RIGA SELEZIONATA
//		kst_open_w.key4 = "titolo_wind_chiamante"				    	TITOLO DELLA WINDOW CHIAMANTE X INDIVIDUARLA DA ELENCO
//		kst_open_w.key5 = riservato 
//		kst_open_w.key6 = campo_link				    					CAMPO CHE HA SCATENATO LO ZOOM
//		kst_open_w.key12_any = kdsi_elenco_output						DATASTORE CON I DATI
//		kuf1_elenco.u_open(kst_open_w)

//		if isvalid(kuf1_elenco) then destroy kuf1_elenco
//
end subroutine

public function boolean u_open_zoom (string a_titolo, string a_campo_link, ref datastore adsi_elenco_output);//---
//--- Apre la funzione di ZOOM
//--- Inp: necessario adsi_elenco_output + a_campo_link 
//--- Out: TRUE = finestra aperta; FASE=operazione non eseguita
//---
boolean k_return = true
st_open_w kst_open_w

	if adsi_elenco_output.rowcount() > 0 then
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
		//kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
		kst_open_w.flag_leggi_dw = " "
		kst_open_w.flag_cerca_in_lista = " "
		kst_open_w.key1 = trim(a_titolo)
		kst_open_w.key2 = trim(adsi_elenco_output.dataobject)
		kst_open_w.key3 = string(adsi_elenco_output.getrow())     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = kGuf_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key6 = a_campo_link
		kst_open_w.key12_any = adsi_elenco_output
		kst_open_w.flag_where = " "
		u_open(kst_open_w)
		k_return = true
	end if

return k_return


end function

on kuf_elenco.create
call super::create
end on

on kuf_elenco.destroy
call super::destroy
end on

