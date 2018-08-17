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
end prototypes

public subroutine _readme ();//-------------------------------------------------------------------------------------
//--- Funzione di zoom o anteprima in formato tab
//-------------------------------------------------------------------------------------
// di solto è scatenata cliccando su un link come un codice 
//
// andrebbe chiamata così

// 		st_open_w kst_open_w
//		kuf_elenco kuf1_elenco
//		kuf1_elenco = create kuf_elenco
//		kst_open_w.key1 = "titolo"										    TITOLO DA FAR APPARIRE NEL TAB APERTO
//		kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)   IL DATAOBJECT DA COPIARE DEL DW
//		kst_open_w.key3 = "0"     											EVENTUALE NR RIGA SELEZIONATA
//		kst_open_w.key4 = "titolo_wind_chiamante"				    TITOLO DELLA WINDOW CHIAMANTE X INDIVIDUARLA DA ELENCO
//		kst_open_w.key12_any = kdsi_elenco_output				DS CON I DATI DA COPIARE NEL DW
//		kuf1_elenco.u_open(kst_open_w)
//		if isvalid(kuf1_elenco) then destroy kuf1_elenco
end subroutine

on kuf_elenco.create
call super::create
end on

on kuf_elenco.destroy
call super::destroy
end on

