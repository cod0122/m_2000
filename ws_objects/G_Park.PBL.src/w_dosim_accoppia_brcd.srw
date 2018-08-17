$PBExportHeader$w_dosim_accoppia_brcd.srw
forward
global type w_dosim_accoppia_brcd from w_g_tab0
end type
end forward

global type w_dosim_accoppia_brcd from w_g_tab0
string title = "Accoppia barcode dosimetro"
boolean ki_sicronizza_window_consenti = false
end type
global w_dosim_accoppia_brcd w_dosim_accoppia_brcd

type variables
//
kuf_armo kiuf_armo

end variables

forward prototypes
protected subroutine open_start_window ()
protected function string aggiorna_tabelle ()
end prototypes

protected subroutine open_start_window ();//
kiuf_armo =create kuf_armo

end subroutine

protected function string aggiorna_tabelle ();//
string k_return = "1"
st_tab_meca kst_tab_meca


try

	if dw_dett_0.rowcount() > 0 then
		
		kst_tab_meca.st_tab_meca_dosim.id_meca = dw_dett_0.getitemnumber(1, "id_meca")
		kst_tab_meca.st_tab_meca_dosim.barcode = dw_dett_0.getitemstring(1, "barcode")
		kst_tab_meca.st_tab_meca_dosim.barcode_dosimetro = dw_dett_0.getitemstring(1, "barcode_dosimetro")
	
		kst_tab_meca.st_tab_g_0.esegui_commit = "S"
		kiuf_armo.set_barcode_dosimetro(kst_tab_meca)   // aggiorna tabella
		
		k_return = "0"
	end if
	
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
	
end try

return k_return

end function

on w_dosim_accoppia_brcd.create
call super::create
end on

on w_dosim_accoppia_brcd.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;//
if isvalid(kiuf_armo) then destroy kiuf_armo 

end event

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_dosim_accoppia_brcd
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_dosim_accoppia_brcd
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_dosim_accoppia_brcd
end type

type st_stampa from w_g_tab0`st_stampa within w_dosim_accoppia_brcd
end type

type st_ritorna from w_g_tab0`st_ritorna within w_dosim_accoppia_brcd
end type

type dw_trova from w_g_tab0`dw_trova within w_dosim_accoppia_brcd
end type

type dw_filtra from w_g_tab0`dw_filtra within w_dosim_accoppia_brcd
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_dosim_accoppia_brcd
end type

type cb_modifica from w_g_tab0`cb_modifica within w_dosim_accoppia_brcd
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_dosim_accoppia_brcd
end type

type cb_cancella from w_g_tab0`cb_cancella within w_dosim_accoppia_brcd
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_dosim_accoppia_brcd
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_dosim_accoppia_brcd
end type

type st_orizzontal from w_g_tab0`st_orizzontal within w_dosim_accoppia_brcd
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_dosim_accoppia_brcd
integer width = 3442
integer height = 436
string dataobject = "d_meca_dosim_brcd_dosim"
end type

event dw_lista_0::itemchanged;call super::itemchanged;//
int k_errore=0
string k_stato = ""
kuf_clienti kuf1_clienti
kuf_barcode kuf1_barcode
st_tab_barcode kst_tab_barcode
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti


try

	choose case dwo.nome 
	
		case "barcode" 
			
			kuf1_barcode = create kuf_barcode
			
			kst_tab_clienti.rag_soc_10 = ""
			kst_tab_meca.id = 0
			kst_tab_meca.st_tab_meca_dosim.barcode = trim(data)
			if Len(kst_tab_meca.st_tab_meca_dosim.barcode) > 0 then
				
				kst_tab_barcode.barcode = kst_tab_meca.st_tab_meca_dosim.barcode
				if kuf1_barcode.get_id_meca(kst_tab_barcode) then  // get del ID lotto
				
					if kst_tab_barcode.id_meca > 0 then
						kiuf_armo.get_dati_rid( kst_tab_meca)  // get di alcuni dati lotto
						if kst_tab_meca.clie_1 > 0 then
							kst_tab_clienti.codice = kst_tab_meca.clie_1
							kuf1_clienti.get_nome(kst_tab_clienti) // get del nominativo in anagrafe
							
						end if
					end if
					
				else
					k_stato = "LOTTO NON TROVATO"
				end if
				
				if kst_tab_meca.id = 0 then
					k_errore = 1
				else
					this.setitem(1, "id_meca", kst_tab_meca.id )
					this.setitem(1, "clie_1", kst_tab_meca.clie_1 )
					this.setitem(1, "num_int", kst_tab_meca.num_int )
					this.setitem(1, "data_int", kst_tab_meca.data_int )
					this.setitem(1, "rag_soc_10", kst_tab_clienti.rag_soc_10)
				end if
				
			end if
	
	end choose 
	
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	k_errore = 1
	
	
finally
	if isvalid(kuf1_barcode) then destroy kuf1_barcode
	if k_errore = 1 or kst_tab_meca.st_tab_meca_dosim.barcode = "" then
		this.setitem(1, "id_meca", 0 )
		this.setitem(1, "clie_1", 0)
		this.setitem(1, "num_int", 0 )
		this.setitem(1, "data_int", "")
		this.setitem(1, "rag_soc_10", "")
		this.setitem(1, "stato", k_stato)
	end if		
	
end try


return k_errore

	
end event

type dw_guida from w_g_tab0`dw_guida within w_dosim_accoppia_brcd
end type

