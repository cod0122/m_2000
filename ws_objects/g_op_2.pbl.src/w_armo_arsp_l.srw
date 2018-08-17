$PBExportHeader$w_armo_arsp_l.srw
forward
global type w_armo_arsp_l from w_g_tab0
end type
type dw_periodo from uo_dw_periodo within w_armo_arsp_l
end type
end forward

global type w_armo_arsp_l from w_g_tab0
integer width = 3355
integer height = 1728
string title = "Elenco breve delle Entrate-Uscite"
boolean ki_toolbar_window_presente = true
boolean ki_esponi_msg_dati_modificati = false
boolean ki_sincronizza_window_consenti = false
boolean ki_consenti_modifica = false
boolean ki_consenti_inserisci = false
dw_periodo dw_periodo
end type
global w_armo_arsp_l w_armo_arsp_l

type variables

end variables

forward prototypes
protected function string inizializza ()
protected subroutine open_start_window ()
protected subroutine attiva_menu ()
public subroutine smista_funz (string k_par_in)
private subroutine cambia_periodo_elenco ()
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
long k_clie_1, k_clie_2, k_rc
string k_rc1, k_style, k_key
int k_ctr
int k_importa = 0
double k_dose
date k_data_ini, k_data_fin
window k_window
datawindowchild kdwc_barcode
pointer oldpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

//--- nessun taso funzionale attivo
	ki_nessun_tasto_funzionale=true


	if LenA(trim(ki_st_open_w.key1)) = 0 then
		k_clie_1 = 0
	else
		k_clie_1 = long(trim(ki_st_open_w.key1))
	end if

	if LenA(trim(ki_st_open_w.key2)) = 0 then
		k_clie_2 = 0
	else
		k_clie_2 = long(trim(ki_st_open_w.key2))
	end if

	if LenA(trim(ki_st_open_w.key3)) = 0 or &
		isnull(trim(ki_st_open_w.key3)) then
		k_dose = 0
	else
		k_dose = double(trim(ki_st_open_w.key3))
	end if
	
	k_data_fin = dw_periodo.get_data_fin()
	k_data_ini = dw_periodo.get_data_ini()

 
//	k_window = kGuf_data_base.prendi_win_attiva()

//	k_window.title = "Periodo: Entrate dal " + string(k_data_ini, "dd/mm/yy") & 
//	                      + " al " + string(k_data_fin, "dd/mm/yy") &
//								 + "; Uscite dal " + string(k_data_ini_out, "dd/mm/yy") & 
//	                      + " al " + string(k_data_fin, "dd/mm/yy") &
//
	dw_lista_0.title = "Lotti entrati dal " + string(k_data_ini, "dd/mm/yyyy") & 
	                      + " al " + string(k_data_fin, "dd/mm/yyyy") 
	dw_dett_0.title = "Spedizioni dal " + string(k_data_ini, "dd/mm/yyyy") & 
	                      + " al " + string(k_data_fin, "dd/mm/yyyy")  
	
	if ki_st_open_w.flag_primo_giro <> "S" then  //solo la prima volta non eseguo reset
		dw_lista_0.reset()
		dw_dett_0.reset()
	end if

//=== Legge le righe del dw salvate l'ultima volta (importfile)
	if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima volta il tasto e' false 

		mostra_nascondi_dw( )  // mostra anche la funzione di sotto
		
		k_key = trim(ki_st_open_w.key1)+trim(ki_st_open_w.key2)+trim(ki_st_open_w.key3)&
      		  +trim(ki_st_open_w.key4)+trim(ki_st_open_w.key5)+trim(ki_st_open_w.key6)&
		  		  +trim(ki_st_open_w.key7)+trim(ki_st_open_w.key8)+trim(ki_st_open_w.key9)
		
		k_importa = kGuf_data_base.dw_importfile(trim(k_key), dw_lista_0)

	end if
	
	if k_importa <= 0 then // Nessuna importazione eseguita

	   dw_lista_0.getchild("barcode", kdwc_barcode)
	   kdwc_barcode.settransobject(sqlca)
	   kdwc_barcode.insertrow(0)
 
		k_rc=dw_lista_0.retrieve(k_data_ini, k_data_fin)
		
	end if								 
	
//=== Legge le righe del dw salvate l'ultima volta (importfile)
	if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima volta il tasto e' false 

		k_key = trim(ki_st_open_w.key1)+trim(ki_st_open_w.key2)+trim(ki_st_open_w.key3)&
      		  +trim(ki_st_open_w.key4)+trim(ki_st_open_w.key5)+trim(ki_st_open_w.key6)&
		  		  +trim(ki_st_open_w.key7)+trim(ki_st_open_w.key8)+trim(ki_st_open_w.key9)
		
		k_importa = kGuf_data_base.dw_importfile(trim(k_key), dw_dett_0)

	end if
		
	if k_importa <= 0 then // Nessuna importazione eseguita
		k_rc=dw_dett_0.retrieve(k_data_ini, k_data_fin, k_clie_2, 0)
	end if

//=== Puntatore Cursore Ripristino
	SetPointer(oldpointer)


return k_return



end function

protected subroutine open_start_window ();//
date k_data_ini, k_data_fin


	if LenA(trim(ki_st_open_w.key5)) = 0 or &
		isnull(trim(ki_st_open_w.key5)) then
		k_data_fin = kguo_g.get_dataoggi( )
	else
		k_data_fin = date(trim(ki_st_open_w.key5))
	end if

	if LenA(trim(ki_st_open_w.key4)) = 0 or &
		isnull(trim(ki_st_open_w.key4)) then
		k_data_ini = relativedate(k_data_fin, -31)
	else
		k_data_ini = date(trim(ki_st_open_w.key4))
	end if

//--- inizializza box periodo
	dw_periodo.inizializza( kiw_this_window )
	dw_periodo.set_data_fin(k_data_fin)
	dw_periodo.set_data_ini(k_data_ini)

timer(900)
end subroutine

protected subroutine attiva_menu ();//
//--- Attiva/Dis. Voci di menu personalizzate
//
	if not ki_menu.m_strumenti.m_fin_gest_libero6.visible then
		
		ki_menu.m_strumenti.m_fin_gest_libero6.text = "Cambia il periodo di estrazione"
		ki_menu.m_strumenti.m_fin_gest_libero6.microhelp =  "Cambia periodo di estrazione"
		ki_menu.m_strumenti.m_fin_gest_libero6.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero6.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritemText = "Periodo,"+ki_menu.m_strumenti.m_fin_gest_libero6.text
		ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritemName = "Custom015!"
//		ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritembarindex=2
	
	end if
	
//--- Attiva/Dis. Voci di menu
	super::attiva_menu()


end subroutine

public subroutine smista_funz (string k_par_in);//
//===
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//=== Ritorna ...: 0=tutto OK; 1=Errore
//===


choose case k_par_in

	case kkg_flag_richiesta.libero6		//cambia data di estrazione
		cambia_periodo_elenco()
		
	case else
		super::smista_funz(k_par_in)

end choose

end subroutine

private subroutine cambia_periodo_elenco ();//---
//--- Visualizza il box x il cambio del Periodo di elenco fatture 
//---


dw_periodo.event ue_visible( )

end subroutine

on w_armo_arsp_l.create
int iCurrent
call super::create
this.dw_periodo=create dw_periodo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_periodo
end on

on w_armo_arsp_l.destroy
call super::destroy
destroy(this.dw_periodo)
end on

event closequery;//
int k_return 
string k_key


//=== Chiamo l'evento della ancestor altrimenti non funziona il RETURN
k_return = Super::EVENT closequery ( )

//=== Salva le righe del dw (saveas)
k_key = trim(ki_st_open_w.key1)+trim(ki_st_open_w.key2)+trim(ki_st_open_w.key3)&
        +trim(ki_st_open_w.key4)+trim(ki_st_open_w.key5)+trim(ki_st_open_w.key6)&
		  +trim(ki_st_open_w.key7)+trim(ki_st_open_w.key8)+trim(ki_st_open_w.key9)
kGuf_data_base.dw_saveas(trim(k_key), dw_dett_0)


RETURN k_return

end event

event timer;call super::timer;//
smista_funz(KKG_FLAG_RICHIESTA.refresh)

end event

type st_ritorna from w_g_tab0`st_ritorna within w_armo_arsp_l
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_armo_arsp_l
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_armo_arsp_l
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_armo_arsp_l
integer x = 2350
integer y = 1348
end type

type st_stampa from w_g_tab0`st_stampa within w_armo_arsp_l
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_armo_arsp_l
end type

type cb_modifica from w_g_tab0`cb_modifica within w_armo_arsp_l
integer x = 2350
integer y = 908
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_armo_arsp_l
integer x = 2350
integer y = 1200
end type

type cb_cancella from w_g_tab0`cb_cancella within w_armo_arsp_l
integer x = 2350
integer y = 1052
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_armo_arsp_l
integer x = 2350
integer y = 768
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_armo_arsp_l
integer x = 0
integer y = 832
integer width = 3269
integer height = 624
boolean enabled = true
boolean titlebar = true
string title = "estrazione in esecuzione, periodo impostato a programma...."
string dataobject = "d_arsp_l"
boolean border = true
boolean ki_link_standard_sempre_possibile = true
boolean ki_attiva_standard_select_row = true
boolean ki_d_std_1_attiva_cerca = true
end type

type st_orizzontal from w_g_tab0`st_orizzontal within w_armo_arsp_l
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_armo_arsp_l
integer x = 32
integer width = 3269
integer height = 624
boolean titlebar = true
string title = "estrazione in esecuzione, periodo impostato a programma...."
string dataobject = "d_armo_l_1"
boolean border = true
boolean ki_link_standard_sempre_possibile = true
end type

type dw_guida from w_g_tab0`dw_guida within w_armo_arsp_l
end type

type dw_periodo from uo_dw_periodo within w_armo_arsp_l
integer x = 219
integer y = 992
integer taborder = 50
boolean bringtotop = true
end type

event ue_clicked;call super::ue_clicked;//
try
	inizializza( )
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
end try

		
end event

