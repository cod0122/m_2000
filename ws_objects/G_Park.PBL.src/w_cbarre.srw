$PBExportHeader$w_cbarre.srw
forward
global type w_cbarre from w_g_tab0
end type
end forward

global type w_cbarre from w_g_tab0
int Width=2235
int Height=1460
boolean TitleBar=true
string Title="Codici a Barre Caricati"
boolean MaxBox=false
boolean Resizable=false
end type
global w_cbarre w_cbarre

forward prototypes
public function string inizializza ()
private function integer modifica ()
private function string check_dati ()
private subroutine attiva_tasti ()
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
string k_codice, k_tipo
int k_importa = 0
long k_num_int
date k_data_int, k_data_null
pointer oldpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


	if len(trim(ki_st_open_w.key1)) = 0 then
		k_num_int = 0
	else
		k_num_int = long(trim(ki_st_open_w.key1))
	end if

	if len(trim(ki_st_open_w.key2)) = 0 &
	   or isdate(trim(ki_st_open_w.key2)) = false then
		setnull(k_data_int)
	else
		k_data_int = date(trim(ki_st_open_w.key2))
	end if

//	if len(trim(mid(st_parametri.text, 50, 1))) = 0 or &
//		isnull(mid(st_parametri.text, 50, 1)) then
//		k_tipo = "%"
//	else
//		k_tipo = trim(mid(st_parametri.text, 50, 1))
//	end if

//	dw_dett_0.visible = false


//=== Legge le righe del dw salvate l'ultima volta (importfile)
	if cb_ritorna.enabled = false then  //solo la prima volta il tasto e' false 

		k_importa = kuf1_data_base.dw_importfile(trim(ki_st_open_w.key1) &
								          + trim(ki_st_open_w.key2), dw_lista_0)

	end if
		
	if k_importa <= 0 then // Nessuna importazione eseguita

		if dw_lista_0.retrieve(k_num_int, k_data_int) < 1 then
			k_return = "1Nessun Codice a Barre Trovato "

			SetPointer(oldpointer)
			messagebox("Lista Archivio Codici a Barre vuota", &
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
string k_key


	k_key = dw_lista_0.getitemstring(dw_lista_0.getrow(), "c_barre")
	
	k_return = dw_dett_0.retrieve( k_key ) 


return k_return

end function

private function string check_dati ();//
//=== Controllo dati inseriti
string k_return = " ", k_errore = "0"
int k_rc=0
long k_num_int, k_num_int_1
datetime k_data_int


k_num_int=dw_dett_0.getitemnumber(dw_dett_0.getrow(), "num_int")
k_data_int=dw_dett_0.getitemdatetime(dw_dett_0.getrow(), "data_int")

select num_int
  into :k_num_int_1
  from armo
  where num_int = :k_num_int
        and data_int = :k_data_int;
		  
if sqlca.sqlcode <> 0 then
	
	select num_int
	  into :k_num_int_1
	  from o_armo
	  where num_int = :k_num_int
			  and data_int = :k_data_int;
		  
	if sqlca.sqlcode <> 0 then
			  
		k_return = "Riferimento Non Trovato. "  + "~n~r"
		k_errore = "3"
		
	end if
end if

return k_errore + k_return


end function

private subroutine attiva_tasti ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================

long k_nr_righe

cb_ritorna.enabled = true
cb_inserisci.enabled = true
cb_ritorna.enabled = true

cb_aggiorna.enabled = false
cb_modifica.enabled = false
cb_cancella.enabled = false
cb_visualizza.enabled = false

//=== Nr righe ne DW lista
if dw_lista_0.getrow ( ) > 0 then
	cb_modifica.enabled = true
	cb_cancella.enabled = true
	cb_visualizza.enabled = true
	cb_visualizza.default = true
end if

//=== Nr righe ne DW dettaglio
if dw_dett_0.getrow ( ) > 0 and dw_dett_0.enabled = true then
	if ki_st_open_w.flag_modalita <> "vi" then
		cb_cancella.enabled = true
		cb_aggiorna.enabled = true
	end if
end if
            
attiva_menu()

end subroutine
on w_cbarre.create
call super::create
end on

on w_cbarre.destroy
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

end event

type cb_modifica from w_g_tab0`cb_modifica within w_cbarre
int X=1815
int Y=780
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_cbarre
int Width=2208
int Height=608
string DataObject="d_cbarre_l"
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_cbarre
int X=1815
int Y=1036
end type

type cb_cancella from w_g_tab0`cb_cancella within w_cbarre
int X=1815
int Y=908
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_cbarre
int X=1815
int Y=652
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_cbarre
int X=1815
int Y=1164
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_cbarre
int Y=640
int Width=1755
int Height=640
string DataObject="d_cbarre"
end type

event dw_dett_0::clicked;//soppressione codice del padre
end event

type dw_filtro_0 from w_g_tab0`dw_filtro_0 within w_cbarre
boolean BringToTop=true
end type

type sle_cerca from w_g_tab0`sle_cerca within w_cbarre
boolean BringToTop=true
end type

type cb_cerca_1 from w_g_tab0`cb_cerca_1 within w_cbarre
boolean BringToTop=true
end type

