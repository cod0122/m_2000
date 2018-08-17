$PBExportHeader$w_armo_arsp_l_old.srw
forward
global type w_armo_arsp_l_old from w_g_tab0
end type
end forward

global type w_armo_arsp_l_old from w_g_tab0
integer width = 3355
integer height = 1728
string title = "Elenco breve delle Entrate-Uscite"
end type
global w_armo_arsp_l_old w_armo_arsp_l_old

forward prototypes
protected function string inizializza ()
end prototypes

protected function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Parametro IN : k_id_vettore
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
long k_clie_1, k_clie_2 
string k_rc1, k_style, k_key
int k_ctr
int k_importa = 0
date k_data_ini, k_data_fin, k_data_ini_out
double k_dose
window k_window
datawindowchild kdwc_barcode
pointer oldpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

//--- nessun taso funzionale attivo
	ki_nessun_tasto_funzionale=true


	if len(trim(ki_st_open_w.key1)) = 0 then
		k_clie_1 = 0
	else
		k_clie_1 = long(trim(ki_st_open_w.key1))
	end if

	if len(trim(ki_st_open_w.key2)) = 0 then
		k_clie_2 = 0
	else
		k_clie_2 = long(trim(ki_st_open_w.key2))
	end if

	if len(trim(ki_st_open_w.key3)) = 0 or &
		isnull(trim(ki_st_open_w.key3)) then
		k_dose = 0
	else
		k_dose = double(trim(ki_st_open_w.key3))
	end if
	
	if len(trim(ki_st_open_w.key5)) = 0 or &
		isnull(trim(ki_st_open_w.key5)) then
		k_data_fin = today()
	else
		k_data_fin = date(trim(ki_st_open_w.key5))
	end if

	if len(trim(ki_st_open_w.key4)) = 0 or &
		isnull(trim(ki_st_open_w.key4)) then
		k_data_ini = relativedate(k_data_fin, -31)
	else
		k_data_ini = date(trim(ki_st_open_w.key4))
	end if

 
	k_data_ini_out = relativedate(k_data_fin, -31)
 
	k_window = kuf1_data_base.prendi_win_attiva()

//	k_window.title = "Periodo: Entrate dal " + string(k_data_ini, "dd/mm/yy") & 
//	                      + " al " + string(k_data_fin, "dd/mm/yy") &
//								 + "; Uscite dal " + string(k_data_ini_out, "dd/mm/yy") & 
//	                      + " al " + string(k_data_fin, "dd/mm/yy") &
//
	dw_lista_0.title = "Riferimenti entrati dal " + string(k_data_ini, "dd/mm/yyyy") & 
	                      + " al " + string(k_data_fin, "dd/mm/yyyy") 
	dw_dett_0.title = "D.d.t. senza la data di ritiro, inseriti dal " + string(k_data_ini_out, "dd/mm/yyyy") & 
	                      + " al " + string(k_data_fin, "dd/mm/yyyy")  
	
	if ki_st_open_w.flag_primo_giro <> "S" then  //solo la prima volta non eseguo reset
		dw_lista_0.reset()
		dw_dett_0.reset()
	end if

//=== Legge le righe del dw salvate l'ultima volta (importfile)
	if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima volta il tasto e' false 

		k_key = trim(ki_st_open_w.key1)+trim(ki_st_open_w.key2)+trim(ki_st_open_w.key3)&
      		  +trim(ki_st_open_w.key4)+trim(ki_st_open_w.key5)+trim(ki_st_open_w.key6)&
		  		  +trim(ki_st_open_w.key7)+trim(ki_st_open_w.key8)+trim(ki_st_open_w.key9)+trim(ki_st_open_w.key10)
		
		k_importa = kuf1_data_base.dw_importfile(trim(k_key), dw_lista_0)

	end if
	
	if k_importa <= 0 then // Nessuna importazione eseguita

	   dw_lista_0.getchild("barcode", kdwc_barcode)
	   kdwc_barcode.settransobject(sqlca)
	   kdwc_barcode.insertrow(0)
 
		dw_lista_0.retrieve(				&
												k_data_ini_out, &
												k_data_ini &
                         )
//												0, &
//		                              "*", &
//												"*", &
//												date(0), &
//												date(0), &
//												date(0), &
//												date(0), &
//												k_clie_1, &
//												k_clie_2, &
//												0, &
//												k_dose, &
//												k_data_ini_out, &
//												k_data_fin, &
//												date(0), &
//												date(0), &
//												0, &
//												0, &
//												0, &
//												"*", &
//												"*", &
//												date(0), &
//												date(0), &
//												"0", &
//												"%", &
//												0, &
//												date(0), &
//												date(0) &
//                         )
//
	//"*", "*", date(0), 
//		date(0), date(0), date(0), k_clie_1, k_clie_2, 0, k_dose, &
//									 k_data_ini_out, k_data_fin)								 
	end if								 
	
//=== Legge le righe del dw salvate l'ultima volta (importfile)
	if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima volta il tasto e' false 

		k_key = trim(ki_st_open_w.key1)+trim(ki_st_open_w.key2)+trim(ki_st_open_w.key3)&
      		  +trim(ki_st_open_w.key4)+trim(ki_st_open_w.key5)+trim(ki_st_open_w.key6)&
		  		  +trim(ki_st_open_w.key7)+trim(ki_st_open_w.key8)+trim(ki_st_open_w.key9)+trim(ki_st_open_w.key10)
		
		k_importa = kuf1_data_base.dw_importfile(trim(k_key), dw_dett_0)

	end if
		
	if k_importa <= 0 then // Nessuna importazione eseguita
		dw_dett_0.retrieve(k_data_ini, k_data_fin, k_clie_2, 0)
	end if

//=== Puntatore Cursore Ripristino
	SetPointer(oldpointer)


return k_return



end function

on w_armo_arsp_l_old.create
call super::create
end on

on w_armo_arsp_l_old.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event closequery;//
int k_return 
string k_key


//=== Chiamo l'evento della ancestor altrimenti non funziona il RETURN
k_return = Super::EVENT closequery ( )

//=== Salva le righe del dw (saveas)
k_key = trim(ki_st_open_w.key1)+trim(ki_st_open_w.key2)+trim(ki_st_open_w.key3)&
        +trim(ki_st_open_w.key4)+trim(ki_st_open_w.key5)+trim(ki_st_open_w.key6)&
		  +trim(ki_st_open_w.key7)+trim(ki_st_open_w.key8)+trim(ki_st_open_w.key9)+trim(ki_st_open_w.key10)
kuf1_data_base.dw_saveas(trim(k_key), dw_dett_0)


RETURN k_return

end event

type cb_ritorna from w_g_tab0`cb_ritorna within w_armo_arsp_l_old
integer x = 2350
integer y = 1348
end type

type st_stampa from w_g_tab0`st_stampa within w_armo_arsp_l_old
end type

type st_ritorna from w_g_tab0`st_ritorna within w_armo_arsp_l_old
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_armo_arsp_l_old
end type

type cb_modifica from w_g_tab0`cb_modifica within w_armo_arsp_l_old
integer x = 2350
integer y = 908
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_armo_arsp_l_old
integer x = 2350
integer y = 1200
end type

type cb_cancella from w_g_tab0`cb_cancella within w_armo_arsp_l_old
integer x = 2350
integer y = 1052
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_armo_arsp_l_old
integer x = 2350
integer y = 768
end type

type sle_cerca from w_g_tab0`sle_cerca within w_armo_arsp_l_old
end type

type cb_cerca_1 from w_g_tab0`cb_cerca_1 within w_armo_arsp_l_old
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_armo_arsp_l_old
integer x = 32
integer width = 3269
integer height = 624
boolean titlebar = true
string title = "estrazione in esecuzione, periodo impostato a programma...."
string dataobject = "d_armo_l_1"
boolean border = true
boolean hsplitscroll = false
borderstyle borderstyle = stylelowered!
end type

event dw_lista_0::clicked;call super::clicked;//
datawindowchild kdwc_barcode

if row > 0 and dwo.Name = "barcode" then
	
	dw_lista_0.getchild("barcode", kdwc_barcode)

	kdwc_barcode.settransobject(sqlca)

	if dw_lista_0.rowcount() > 0 then

		if kdwc_barcode.retrieve(dw_lista_0.getitemnumber(row,"armo_id_meca")) > 0 then

			kdwc_barcode.insertrow(0)
			
		end if
	else
		kdwc_barcode.insertrow(0)

	end if

end if

end event

type dw_filtro_0 from w_g_tab0`dw_filtro_0 within w_armo_arsp_l_old
integer x = 768
integer y = 128
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_armo_arsp_l_old
integer y = 756
integer width = 3269
integer height = 624
boolean titlebar = true
string title = "estrazione in esecuzione, periodo impostato a programma...."
string dataobject = "d_arsp_l"
borderstyle borderstyle = stylelowered!
end type

event dw_dett_0::clicked;//soppressione codice del padre

end event

