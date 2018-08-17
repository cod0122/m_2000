$PBExportHeader$w_treeview.srw
forward
global type w_treeview from w_g_tab0
end type
end forward

global type w_treeview from w_g_tab0
integer width = 2930
integer height = 1496
string title = "Tabella Configurazione Navigatore"
end type
global w_treeview w_treeview

forward prototypes
protected function integer modifica ()
protected function string inizializza ()
protected function integer visualizza ()
end prototypes

protected function integer modifica ();//===
//=== Lettura del rek da modificare
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
int k_return, k_riga
string k_rc="", k_rc1="", k_style=""
int k_ctr=0
kuf_utility kuf1_utility
st_tab_treeview kst_tab_treeview


k_riga = dw_lista_0.getrow() //getselectedrow( 0)	

if k_riga > 0 then
	kst_tab_treeview.id = dw_lista_0.getitemstring(k_riga, "id")
		
	k_return = dw_dett_0.retrieve( kst_tab_treeview.id ) 
	
	if k_return > 0 then
		
		ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica 
	
	end if	

end if

//--- S-Protezione campi per abilitare la modifica 
	kuf1_utility = create kuf_utility
	kuf1_utility.u_proteggi_dw("0", 0, dw_dett_0)
	destroy kuf1_utility

attiva_tasti()

return k_return

end function

protected function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Parametro IN : k_id_vettore
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 ", k_key = " ", k_rcx=""
int k_importa = 0
kuf_base kuf1_base



//=== Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa)

//
//	if LenA(trim(ki_st_open_w.key1)) = 0 then
//		k_codice = 0
//	else
//		k_codice = long(trim(ki_st_open_w.key1))
//	end if



//=== Legge le righe del dw salvate l'ultima volta (importfile)
	if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima volta il tasto e' false 

		k_key = trim(ki_st_open_w.key1)+trim(ki_st_open_w.key2)+trim(ki_st_open_w.key3)&
      		  +trim(ki_st_open_w.key4)+trim(ki_st_open_w.key5)+trim(ki_st_open_w.key6)&
		  		  +trim(ki_st_open_w.key7)+trim(ki_st_open_w.key8)+trim(ki_st_open_w.key9)
		
		k_importa = kGuf_data_base.dw_importfile(trim(k_key), dw_lista_0)

	end if
		
	if k_importa <= 0 then // Nessuna importazione eseguita

		if dw_lista_0.retrieve() < 1 then
			k_return = "1Nessun record Trovato "

			SetPointer(kkg.pointer_default)
			messagebox("Archivio Vuoto", &
					"Nessun Codice Trovato per la richiesta fatta")
		end if

	end if		

//--- becco il valore del Tipo di modulo usato x la stampa dei barcode
	kuf1_base = create kuf_base
	k_rcx = trim(kuf1_base.prendi_dato_base("barcode_modulo"))
	if left(k_rcx,1)  = "0" then
		kGuf_data_base.Ki_barcode_modulo = mid(k_rcx,2,1)
		ki_menu.set_modulo_barcode()
	else
		kGuf_data_base.Ki_barcode_modulo=""
	end if
	destroy kuf1_base

	attiva_tasti()

	SetPointer(kkg.pointer_default)

return k_return



end function

protected function integer visualizza ();//===
//=== Lettura del rek da modificare
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
int k_return, k_riga
string k_rc="", k_rc1="", k_style=""
int k_ctr=0
kuf_utility kuf1_utility
st_tab_treeview kst_tab_treeview


k_riga = dw_lista_0.getrow() //getselectedrow( 0)	

if k_riga > 0 then
	kst_tab_treeview.id = dw_lista_0.getitemstring(k_riga, "id")
		
	k_return = dw_dett_0.retrieve( kst_tab_treeview.id ) 
	
	if k_return > 0 then
		
		ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica 
	
	end if	

end if

//--- Protezione campi per disabilitare la modifica 
	kuf1_utility = create kuf_utility
	kuf1_utility.u_proteggi_dw("1", 0, dw_dett_0)
	destroy kuf1_utility

attiva_tasti()

return k_return

end function

on w_treeview.create
call super::create
end on

on w_treeview.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event u_open;call super::u_open;//
	u_resize()

end event

type st_ritorna from w_g_tab0`st_ritorna within w_treeview
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_treeview
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_treeview
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_treeview
end type

type st_stampa from w_g_tab0`st_stampa within w_treeview
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_treeview
end type

type cb_modifica from w_g_tab0`cb_modifica within w_treeview
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_treeview
end type

type cb_cancella from w_g_tab0`cb_cancella within w_treeview
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_treeview
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_treeview
integer x = 59
boolean enabled = true
string dataobject = "d_tab_treeview"
end type

type st_orizzontal from w_g_tab0`st_orizzontal within w_treeview
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_treeview
integer height = 484
string dataobject = "d_tab_treeview_l"
end type

type dw_guida from w_g_tab0`dw_guida within w_treeview
end type

