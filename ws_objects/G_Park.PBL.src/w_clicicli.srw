$PBExportHeader$w_clicicli.srw
forward
global type w_clicicli from w_g_tab0
end type
end forward

global type w_clicicli from w_g_tab0
int Width=2907
int Height=1512
boolean TitleBar=true
string Title="Cicli Produzione"
boolean Resizable=false
end type
global w_clicicli w_clicicli

forward prototypes
public function string inizializza ()
private function integer modifica ()
end prototypes

public function string inizializza ();//
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
int k_importa = 0
pointer oldpointer  // Declares a pointer variable
datawindowchild kdwc_clienti
datawindowchild kdwc_clienti_d1, kdwc_clienti_d2, kdwc_prod, kdwc_iva



//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


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


//	dw_dett_0.visible = false


//=== Legge le righe del dw salvate l'ultima volta (importfile)
	if cb_ritorna.enabled = false then  //solo la prima volta il tasto e' false 

		k_importa = kuf1_data_base.dw_importfile(trim(ki_st_open_w.key1) &
								          + trim(ki_st_open_w.key2), dw_lista_0)

	end if
		

//--- Attivo dw archivio CLIENTI
	dw_lista_0.getchild("clienti_rag_soc_10", kdwc_clienti)

	kdwc_clienti.settransobject(sqlca)

	if kdwc_clienti.rowcount() = 0 then
		kdwc_clienti.retrieve("%")
		kdwc_clienti.insertrow(1)
	end if


//--- Attivo dw archivio CLIENTI della seconda dw
	dw_dett_0.getchild("clie_1", kdwc_clienti_d1)

	kdwc_clienti_d1.settransobject(sqlca)

	if kdwc_clienti_d1.rowcount() = 0 then
		kdwc_clienti_d1.retrieve("%")
		kdwc_clienti_d1.insertrow(1)
	end if

//--- Attivo dw archivio CLIENTI della seconda dw
	dw_dett_0.getchild("clie_2", kdwc_clienti_d2)

	kdwc_clienti_d2.settransobject(sqlca)

	if kdwc_clienti_d2.rowcount() = 0 then
		kdwc_clienti_d2.retrieve("%")
		kdwc_clienti_d2.insertrow(1)
	end if

//--- Attivo dw archivio PRODOTTI della seconda dw
	dw_dett_0.getchild("art", kdwc_prod)

	kdwc_prod.settransobject(sqlca)

//--- Attivo dw archivio PRODOTTI della seconda dw
	kdwc_prod.getchild("iva", kdwc_iva)

	kdwc_iva.settransobject(sqlca)

	if kdwc_iva.rowcount() = 0 then
		kdwc_iva.retrieve(0)
		kdwc_iva.insertrow(1)
	end if

	if kdwc_prod.rowcount() = 0 then
		kdwc_prod.retrieve("%")
		kdwc_prod.insertrow(1)
	end if


	
	if k_importa <= 0 then // Nessuna importazione eseguita

		if dw_lista_0.retrieve(k_clie_1, k_clie_2) < 1 then
			k_return = "1Non trovate Anagrafiche "

			SetPointer(oldpointer)
			messagebox("Lista Cicli Produzione vuota", &
					"Nessun Codice Trovato per la richiesta fatta")

		end if		
	end if


return k_return



end function

private function integer modifica ();//===
//=== Lettura del rek da modificare
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
int k_return
long k_key


	k_key = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "clicicli_codice")
	
	k_return = dw_dett_0.retrieve( k_key ) 


return k_return

end function

on w_clicicli.create
call super::create
end on

on w_clicicli.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event closequery;//
int k_return 
//=== Chiamo l'evento della ancestor altrimenti non funziona il RETURN
k_return = Super::EVENT closequery ( )
RETURN k_return

end event

event resize;//
	this.setredraw(false)
//	tab_1.tabpage_art.dw_dett_1.width = dw_lista_0.width
//	tab_1.tabpage_scade.dw_dett_2.width = dw_lista_0.width
	this.setredraw(true)


end event

type cb_visualizza from w_g_tab0`cb_visualizza within w_clicicli
int Y=676
end type

type cb_modifica from w_g_tab0`cb_modifica within w_clicicli
int Y=792
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_clicicli
int Height=532
string DataObject="d_clicicli_l"
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_clicicli
int Y=1036
end type

type cb_cancella from w_g_tab0`cb_cancella within w_clicicli
int Y=912
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_clicicli
int Y=560
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_clicicli
int Y=1152
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_clicicli
int X=5
int Y=548
int Width=2848
int Height=780
string DataObject="d_clicicli"
end type

event dw_dett_0::clicked;//soppressione codice del padre
end event

type dw_filtro_0 from w_g_tab0`dw_filtro_0 within w_clicicli
boolean BringToTop=true
end type

type sle_cerca from w_g_tab0`sle_cerca within w_clicicli
boolean BringToTop=true
end type

type cb_cerca_1 from w_g_tab0`cb_cerca_1 within w_clicicli
boolean BringToTop=true
end type

