$PBExportHeader$w_meca_l.srw
forward
global type w_meca_l from w_g_tab0
end type
type dw_data from uo_d_std_1 within w_meca_l
end type
type dw_stampa from datawindow within w_meca_l
end type
end forward

global type w_meca_l from w_g_tab0
integer width = 3328
integer height = 1964
string title = "Lotti"
boolean ki_toolbar_window_presente = true
boolean ki_esponi_msg_dati_modificati = false
boolean ki_sincronizza_window_consenti = false
boolean ki_reset_dopo_save_ok = false
dw_data dw_data
dw_stampa dw_stampa
end type
global w_meca_l w_meca_l

type variables

private st_tab_meca kist_tab_meca
private string ki_ultimo_codice_cercato="999999"
private date ki_data_start, ki_data_start_old
private kuf_armo kiuf_armo

end variables

forward prototypes
protected function integer visualizza ()
private function string cancella ()
private function string inizializza ()
protected subroutine attiva_menu ()
protected subroutine smista_funz (string k_par_in)
protected subroutine open_start_window ()
public function integer u_retrieve_dw_lista ()
private subroutine cambia_data ()
protected function integer modifica ()
public function integer u_open_riferimenti_autorizza ()
private subroutine call_memo ()
public subroutine stampa_choose_run ()
protected subroutine stampa ()
end prototypes

protected function integer visualizza ();//
st_tab_g_0 kst_tab_g_0
long k_riga


k_riga = dw_lista_0.getrow()	
if k_riga > 0 then

	kst_tab_g_0.id = dw_lista_0.getitemnumber(k_riga, "id_meca") // id
	kiuf_armo.u_open_applicazione(kst_tab_g_0, kkg_flag_modalita.visualizzazione )
								
else

	messagebox("Operazione non eseguita", "Selezionare una riga dall'elenco")

end if

return (1)
end function

private function string cancella ();//
string k_errore = "0 ", k_errore1 = "0 ", k_rag_soc=""
long k_riga
st_tab_meca kst_tab_meca
st_esito kst_esito


k_riga = dw_lista_0.getselectedrow(0)	
if k_riga > 0 then
	kst_tab_meca.id = dw_lista_0.getitemnumber(k_riga, "id_meca")
	kst_tab_meca.data_int = dw_lista_0.getitemdate(k_riga, "data_int")
	kst_tab_meca.num_int = dw_lista_0.getitemnumber(k_riga, "num_int")
	kst_tab_meca.clie_1 = dw_lista_0.getitemnumber(k_riga, "clie_1")
	k_rag_soc = dw_lista_0.getitemstring(k_riga, "rag_soc_10")
	
	if isnull(k_rag_soc) then k_rag_soc = "*senza nome* "
	
//=== Richiesta di conferma della eliminazione del rek
	if messagebox("Elimina RIFERIMENTO LOTTO   " +  string(kst_tab_meca.id, "####0"), "Sei sicuro di voler CANCELLARE definitivamente la riga: ~n~r" &
	         + "Numero: " + string(kst_tab_meca.num_int, "#####") + "   del  " + string(kst_tab_meca.data_int) + "  ID: " + string(kst_tab_meca.id, "####0") &
	         + "~n~rMandante: " + string(kst_tab_meca.clie_1, "#")  + " " + trim(k_rag_soc), &
				question!, yesno!, 2) = 1 then
				
		try 		
			
//=== Cancella la riga dal data windows di lista
			kst_tab_meca.st_tab_g_0.esegui_commit = "N"
			kst_esito = kiuf_armo.tb_delete_riferimento(kst_tab_meca ) 
			if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn then
	
				kguo_sqlca_db_magazzino.db_commit()
				dw_lista_0.setitemstatus(k_riga, 0, primary!, new!)
				dw_lista_0.deleterow(k_riga)

				dw_lista_0.setfocus()

			else
				kguo_sqlca_db_magazzino.db_rollback()

				messagebox("Problemi durante Cancellazione - Operazione fallita !!", trim(kst_esito.sqlerrtext ) ) 	

			end if
			
		catch (uo_exception kuo1_exception)
			k_errore = "1" + kst_esito.sqlerrtext
			kuo1_exception.messaggio_utente()
			
		finally
			attiva_tasti()
			
			
		end try

	else
		messagebox("Elimina RIFERIMENTO LOTTO", "Operazione Annullata !!")

	end if
else
	messagebox("Elimina RIFERIMENTO LOTTO", "Selezionare una riga dall'elenco. ")
end if

return k_errore
end function

private function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Parametro IN : k_id_vettore
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
string k_key
long  k_riga=0
int k_importa = 0
pointer oldpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

//--- Se non ho richiesto un codice particolare mi fermo x chiedere
	if ki_st_open_w.flag_primo_giro = "S" and kist_tab_meca.id = 0 and kist_tab_meca.clie_1 = 0 then

		dw_guida.setitem(1,"codice", "")
		dw_guida.setcolumn("codice")
		dw_guida.setfocus( )
		
	else
		if kist_tab_meca.id > 0 or kist_tab_meca.clie_1 > 0 or ki_st_open_w.flag_primo_giro <> "S" then

			if kist_tab_meca.id > 0 then
				if trim(dw_guida.getitemstring(1,"codice")) > " " then
				else
					dw_guida.setitem(1,"codice", "id" + string(kist_tab_meca.id ))
				end if
			end if

			dw_guida.event ue_buttonclicked( )
//			
//			if kist_tab_meca.id > 0 or kist_tab_meca.clie_1 > 0 then
//		
//				if u_retrieve_dw_lista() < 1 then
//					k_return = "1Lotti Non trovati "
//			
//					SetPointer(oldpointer)
//					messagebox("Elenco Lotti Vuota", &
//							"Nesun Codice Trovato per la richiesta fatta")
//				end if		
//			end if
		end if
	end if
		


return k_return


end function

protected subroutine attiva_menu ();//--- Attiva/Dis. Voci di menu


//
//--- Attiva/Dis. Voci di menu personalizzate
//
	ki_menu.m_finestra.m_fin_stampa.text = "Stampa Lotti"
	ki_menu.m_finestra.m_fin_stampa.toolbaritemText = "Stampa,Stampa Lotti"

	if not ki_menu.m_strumenti.m_fin_gest_libero1.visible then
	
		ki_menu.m_strumenti.m_fin_gest_libero1.text = "Cambia data estrazione Lotti"
		ki_menu.m_strumenti.m_fin_gest_libero1.microhelp = "Cambia data estrazione Lotti"
		ki_menu.m_strumenti.m_fin_gest_libero1.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText = "Data,"+ki_menu.m_strumenti.m_fin_gest_libero1.text
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName = "Custom015!"
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero1.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
		
	end if
	if NOT ki_menu.m_strumenti.m_fin_gest_libero2.enabled then
		ki_menu.m_strumenti.m_fin_gest_libero2.text = "Autorizza Lotto"
		ki_menu.m_strumenti.m_fin_gest_libero2.microhelp = "Autorizzazioni Lotto "
		ki_menu.m_strumenti.m_fin_gest_libero2.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero2.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true // ki_menu.m_strumenti.m_fin_gest_libero2.enabled
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemText = "Autorizza,"+ki_menu.m_strumenti.m_fin_gest_libero2.text
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName = "Error!"
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
	end if	
	

	super::attiva_menu()


end subroutine

protected subroutine smista_funz (string k_par_in);//
//===

choose case k_par_in 


	case KKG_FLAG_RICHIESTA.libero1		//cambia data estrazione scadenze
		cambia_data()
		

	case KKG_FLAG_RICHIESTA.libero2 //Chiama Lotto x le Autorizzazioni
		u_open_riferimenti_autorizza( )


	case KKG_FLAG_RICHIESTA.modifica		//richiesta modif
		modifica( )
		

	case KKG_FLAG_RICHIESTA.visualizzazione		//richiesta Vis
		visualizza( )
		
		
	case else
		super::smista_funz(k_par_in)

end choose



end subroutine

protected subroutine open_start_window ();//
long k_rc=0
datawindowchild kdwc_cliente

	
	ki_sincronizza_window_consenti = false		// inizialmente nessuna sincronizzazione permessa
	
	kiuf_armo = create kuf_armo

//---
	kist_tab_meca.id = long(trim(ki_st_open_w.key1))  // ID lotto
	if isnull(kist_tab_meca.id ) then
		kist_tab_meca.id = 0
	end if
	kist_tab_meca.clie_1 =  long(trim(ki_st_open_w.key2))  // codice mandante/cliente
	if isnull(kist_tab_meca.clie_1) then
		kist_tab_meca.clie_1 = 0
	end if
	if trim(ki_st_open_w.key3) = "" then									// da quale data partire
		if isdate(trim(ki_st_open_w.key3)) then
			ki_data_start = date(trim(ki_st_open_w.key3))
		else
			ki_data_start = relativedate(kg_dataoggi, -180)
		end if
	else
		ki_data_start = relativedate(kg_dataoggi, -180)
	end if

	dw_guida.insertrow(0)


//	dw_guida.getchild("codice", kdwc_cliente)
//	kdwc_cliente.settransobject( sqlca)
//	kdwc_cliente.retrieve("%")
//	kdwc_cliente.insertrow(1)

//--- box di stampa
	dw_stampa.move((this.width - dw_stampa.width) / 3, (this.height - dw_stampa.height) / 3)
	dw_stampa.insertrow(1)
	

end subroutine

public function integer u_retrieve_dw_lista ();//---
//---  Fa la Retrieve
//---
long k_return=0	
	
	
	ki_win_titolo_custom = "" 
	if kist_tab_meca.id > 0 then
		ki_win_titolo_custom += "per ID lotto " + string(kist_tab_meca.id) 
	else
		if kist_tab_meca.id > 0 then
			ki_win_titolo_custom += "per WO di E1 " + string(kist_tab_meca.e1doco) + " (id Lotto " + string(kist_tab_meca.id) + ")"  
		
		else
			ki_win_titolo_custom = "dal " + string(ki_data_start) 
			if kist_tab_meca.clie_1 > 0 then
				ki_win_titolo_custom += " e anagrafica " + string(kist_tab_meca.clie_1) 
			end if
		end if
	end if
	
	dw_lista_0.reset()
	k_return = dw_lista_0.retrieve(ki_data_start, kist_tab_meca.clie_1, kist_tab_meca.id ) 
	
	if k_return > 0 then
		ki_sincronizza_window_consenti = true		// attivo sincronizzazione 
	else
		ki_sincronizza_window_consenti = false		// nessuna sincronizzazione permessa
	end if
	
	dw_lista_0.setfocus( )
	
	attiva_tasti( )

	
return k_return
	

end function

private subroutine cambia_data ();//---
//--- Visualizza il box x il cambio DATA
//---


dw_data.triggerevent("ue_visibile")

end subroutine

protected function integer modifica ();//
st_tab_g_0 kst_tab_g_0
long k_riga


k_riga = dw_lista_0.getrow()	
if k_riga > 0 then

	kst_tab_g_0.id = dw_lista_0.getitemnumber(k_riga, "id_meca") // id
	kiuf_armo.u_open_applicazione(kst_tab_g_0, kkg_flag_modalita.modifica )
								
else

	messagebox("Operazione non eseguita", "Selezionare una riga dell'elenco")

end if

return (1)
end function

public function integer u_open_riferimenti_autorizza ();//
//--- Chiama finestra di dettaglio
//
integer k_riga = 0
st_tab_g_0 kst_tab_g_0
kuf_meca_autorizza kuf1_meca_autorizza

try
	k_riga = dw_lista_0.getrow()	
	if k_riga > 0 then
		
		kst_tab_g_0.id = dw_lista_0.getitemnumber(k_riga, "id_meca") // id
		if kst_tab_g_0.id > 0 then
	
			kuf1_meca_autorizza = create kuf_meca_autorizza
			if kuf1_meca_autorizza.if_sicurezza(kkg_flag_modalita.modifica) then
				kuf1_meca_autorizza.u_open_applicazione(kst_tab_g_0, kkg_flag_modalita.modifica )
			else
				kuf1_meca_autorizza.u_open_applicazione(kst_tab_g_0, kkg_flag_modalita.visualizzazione )
			end if
		else
			messagebox("Operazione non eseguita", "ID Lotto non identificato")
									
		end if							
	else
	
		messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")
	
	end if

 
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()

 
end try
 
return k_riga

end function

private subroutine call_memo ();//
//=== Legge il rek dalla DW lista per la modifica
long k_riga
st_tab_meca_memo kst_tab_meca_memo 
st_memo kst_memo
kuf_memo kuf1_memo
kuf_memo_inout kuf1_memo_inout


try   
	k_riga = dw_lista_0.getrow()
	if k_riga > 0 then

		kuf1_memo = create kuf_memo
		kuf1_memo_inout = create kuf_memo_inout
	
		kst_tab_meca_memo.id_meca_memo = dw_lista_0.getitemnumber( k_riga, "id_meca_memo" ) 
		kst_tab_meca_memo.id_meca = dw_lista_0.getitemnumber( k_riga, "id_meca" ) 
			
		if kst_tab_meca_memo.id_meca  > 0 then
			kst_tab_meca_memo.tipo_sv = ki_st_open_w.sr_settore // kuf1_memo.kki_tipo_sv_QLT
			kst_memo.st_tab_meca_memo = kst_tab_meca_memo
			kuf1_memo_inout.memo_xmeca(kst_memo.st_tab_meca_memo, kst_memo.st_tab_memo)
			kuf1_memo.u_attiva_funzione(kst_memo,kkg_flag_modalita.inserimento )   // APRE FUNZIONE
			
		end if
	end if 
		
catch (uo_exception	kuo_exception)
	kuo_exception.messaggio_utente()
		
end try
	


end subroutine

public subroutine stampa_choose_run ();//
//long k_num_riga, k_riga
string k_tipo_stampa
int k_rc=0
long k_riga
st_tab_meca kst_tab_meca
st_stampe kst_stampe
kuf_meca_stampa kuf1_meca_stampa


try
	//=== Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa)
	
	dw_stampa.visible = false
	k_tipo_stampa = trim(dw_stampa.getitemstring(1, "tipo_stampa"))
	
	choose case k_tipo_stampa
			
		case "C"  // stampa dati lotto + report pilota (pdf)  selezionati
			kuf1_meca_stampa = create kuf_meca_stampa
//--- conta se ho selezionato più di un documento
			k_riga = dw_lista_0.getselectedrow(0)
			if k_riga > 0 then
				k_riga = dw_lista_0.getselectedrow(k_riga)
				kuf1_meca_stampa.u_inizializza_stampa_pdf()  // inizializza l'array che conterrà i pdf da stampare
				if k_riga > 0 then
//--- con più documenti fa tutto in PDF poi unisce il tutto e finalmente stampa
					k_riga = dw_lista_0.getselectedrow(0)
					do while k_riga > 0
						kuf1_meca_stampa.u_inizializza_stampa_pdf()  // inizializza l'array che conterrà i pdf da stampare
						kst_tab_meca.id = dw_lista_0.getitemnumber(k_riga, "id_meca")
						if kst_tab_meca.id > 0 then
							//--- Genera la stampa Report Lotto + Report Pilota e aggiunge i riferimenti ai PDF nell'array
							kuf1_meca_stampa.u_genera_pdf_completa(kst_tab_meca) //u_stampa_completa(kst_tab_meca)
						end if
						k_riga = dw_lista_0.getselectedrow(k_riga)
						sleep (1) // ritardo per lasciare il tempo di fare il pdf
						kuf1_meca_stampa.u_stampa_all_pdf( )  // stampa file PDF aggiunti nell'array 
					loop
				else
//--- un solo documento quindi esegue solo la stampa del DW + PDF
					kst_tab_meca.id = dw_lista_0.getitemnumber(dw_lista_0.getselectedrow(0), "id_meca")
					kuf1_meca_stampa.u_stampa_completa( kst_tab_meca )
				end if
			end if

	

		case "X"   // stampa dati lotto selezionati
			kuf1_meca_stampa = create kuf_meca_stampa
			k_riga = dw_lista_0.getselectedrow(0)
			do while k_riga > 0
				kst_tab_meca.id = dw_lista_0.getitemnumber(k_riga, "id_meca")
				if kst_tab_meca.id > 0 then
					kuf1_meca_stampa.u_stampa(kst_tab_meca)
				end if
				k_riga = dw_lista_0.getselectedrow(k_riga)
			loop
				
		case else  //scelta E 
	//--- stampa tutti i dati in elenco
			if not isvalid(kst_stampe.ds_print) then kst_stampe.ds_print = create datastore
			kst_stampe.ds_print.reset( )
			kst_stampe.ds_print.dataobject = dw_lista_0.dataobject
			//kst_stampe.ds_print.settransobject(kguo_sqlca_db_magazzino)
	//--- Aggiorna SQL della dw	
			k_rc = dw_lista_0.rowscopy(1, dw_lista_0.rowcount() , primary!, kst_stampe.ds_print, 1, primary!)
			if k_rc > 0 then
				kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datastore //ki_stampa_tipo_datastore_diretta
				kst_stampe.titolo = trim("Elenco Lotti")
				kGuf_data_base.stampa_dw(kst_stampe)
			end if
	end choose
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally
	attiva_tasti( )
	
end try



end subroutine

protected subroutine stampa ();//
dw_stampa.visible = true

end subroutine

on w_meca_l.create
int iCurrent
call super::create
this.dw_data=create dw_data
this.dw_stampa=create dw_stampa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_data
this.Control[iCurrent+2]=this.dw_stampa
end on

on w_meca_l.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_data)
destroy(this.dw_stampa)
end on

event u_open;call super::u_open;//
	ki_win_titolo_custom = " dalla data del " + string(ki_data_start) 

end event

type st_ritorna from w_g_tab0`st_ritorna within w_meca_l
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_meca_l
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_meca_l
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_meca_l
integer x = 2427
integer y = 1160
integer height = 92
integer taborder = 80
boolean cancel = true
end type

type st_stampa from w_g_tab0`st_stampa within w_meca_l
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_meca_l
integer x = 1801
integer y = 1252
end type

type cb_modifica from w_g_tab0`cb_modifica within w_meca_l
integer x = 1783
integer y = 1152
integer height = 96
integer taborder = 60
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_meca_l
integer x = 1134
integer y = 1160
integer height = 96
integer taborder = 100
end type

type cb_cancella from w_g_tab0`cb_cancella within w_meca_l
integer x = 2121
integer y = 1164
integer height = 96
integer taborder = 70
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_meca_l
integer x = 1467
integer y = 1156
integer height = 96
integer taborder = 50
boolean enabled = false
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_meca_l
integer x = 37
integer y = 876
integer width = 827
integer height = 524
end type

on dw_dett_0::rbuttondown;call w_g_tab0`dw_dett_0::rbuttondown;//
//=== Scateno l'evento sulla window
parent.triggerevent("rbuttondown")

end on

on dw_dett_0::getfocus;////
//long k_id_vettore
//
////=== Verifico se ho gia' fatto almeno una retrieve o una insert
//if dw_dett_0.getrow() = 0 then
//	if cb_modifica.enabled = true then
//		cb_modifica.triggerevent("clicked")
//	else
//		cb_inserisci.triggerevent("clicked")
//	end if
//end if
//
////=== Controlla quali tasti attivare
//attiva_tasti()
//
//k_id_vettore = this.getitemnumber(1, "id_vettore")
////k_desc = this.getitemstring(1, "desc")
//
////=== Imposto valori di default se non ce ne sono
////if isnull(k_id_c_pag) = true or isnull(k_desc) = true or &
////	(trim(k_id_c_pag) = "" and &
////	 trim(k_desc) = "") then
////	setitem(1, "tipo", 1)
////	setitem(1, "scad_p", 1)
////end if
//
end on

type st_orizzontal from w_g_tab0`st_orizzontal within w_meca_l
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_meca_l
integer width = 2807
integer height = 708
string dataobject = "d_meca_l"
borderstyle borderstyle = stylelowered!
boolean ki_link_standard_sempre_possibile = true
end type

type dw_guida from w_g_tab0`dw_guida within w_meca_l
event ue_itemchanged ( string k_nome,  string k_dato )
integer x = 32
integer y = 28
integer width = 2738
boolean enabled = true
string dataobject = "d_meca_guida"
end type

event dw_guida::ue_buttonclicked;call super::ue_buttonclicked;//---
boolean k_elabora=true
string k_codice_x, k_numero_x, k_anno_x, k_cliente_x
int k_pos
long k_codice
st_esito kst_esito
st_tab_armo kst_tab_armo


try
	kist_tab_meca.id = k_codice
	kist_tab_meca.clie_1 = 0
	kist_tab_meca.e1doco = 0

   kist_tab_meca.id = dw_guida.getitemnumber(1, "id_meca")
   if kist_tab_meca.id > 0 then
	else
      kist_tab_meca.id = 0
   end if

//--- solo se ricerco un codice diverso
	k_codice_x = trim(dw_guida.getitemstring(1, "codice"))
	if isnull(k_codice_x) then k_codice_x = ""
	if dw_lista_0.rowcount( ) > 0 and ki_ultimo_codice_cercato = k_codice_x and k_codice_x = "" and ki_data_start = ki_data_start_old then
		return
	end if
	
	ki_data_start_old = ki_data_start  //salva data inizio estrazione
	ki_ultimo_codice_cercato = k_codice_x //salva ultimo dati digitato

//--- se la stringa di ricerca è vuota allora mostra tutto			
	if len(k_codice_x) = 0 then 	

		u_retrieve_dw_lista()
		
		return
		
	end if
	
	//--- se n.lotto / anno 
	k_pos = pos(k_codice_x, "/", 1) 
	if k_pos > 1 then
		k_numero_x = trim(left(k_codice_x, k_pos - 1))
		k_anno_x = trim(mid(k_codice_x, k_pos + 1))
		if len(trim(k_anno_x)) < 4 then
			if len(trim(k_anno_x)) = 2 then
				k_anno_x = '20' + trim(k_anno_x)
			else
				k_anno_x = string(kguo_g.get_anno( ))
			end if
		end if
		if isnumber(k_numero_x) then
			kst_tab_armo.num_int = long(k_numero_x)
			kst_tab_armo.data_int = date(integer(k_anno_x), 01, 01)
			kiuf_armo.get_id_meca(kst_tab_armo)
			kist_tab_meca.id = kst_tab_armo.id_meca
			if kist_tab_meca.id > 0 then 
				u_retrieve_dw_lista()
			end if
		end if
		
		return
		
	end if

	//--- se ricerca per WO (wonnnnn)
	k_pos = pos(lower(k_codice_x), "wo", 1)  
	if k_pos > 0 then
		k_numero_x = trim(mid(k_codice_x, k_pos + 2))
		if isnumber(k_numero_x) then
			
			kist_tab_meca.e1doco = long(k_numero_x)
			kiuf_armo.get_id_meca_da_e1doco(kist_tab_meca)
			
			if kist_tab_meca.id > 0 then 
				u_retrieve_dw_lista()
			end if
			
		end if
			
		return 
	end if
		
	//--- se ricerca per ID LOTTO (idnnnnn)
	k_pos = pos(lower(k_codice_x), "id", 1)  
	if k_pos > 0 then
		k_numero_x = trim(mid(k_codice_x, k_pos + 2))
		if isnumber(k_numero_x) then
			
			kist_tab_meca.id = long(k_numero_x)
			u_retrieve_dw_lista()
			
		end if
			
		return 
	end if
		
	//--- se ricerca per CLIENTE (cnnnnn)
	k_pos = pos(lower(k_codice_x), "c", 1)  
	if k_pos > 0 then
		k_numero_x = trim(mid(k_codice_x, k_pos + 1))
		if isnumber(k_numero_x) then
			
			kist_tab_meca.clie_1 = long(k_numero_x)
			u_retrieve_dw_lista()
			
		end if
			
		return 
	end if
	
//		
	k_cliente_x = k_codice_x
	k_numero_x = k_codice_x
	k_anno_x = string(kguo_g.get_anno())

	
	if k_codice_x > " " then 
	else
		k_codice_x = "0"  
		k_numero_x = "0" 
	end if
	
	if not isnumber(k_codice_x) or not isnumber(k_numero_x) or not isnumber(k_anno_x) then
		kguo_exception.inizializza()
		kguo_exception.messaggio_utente( "Dato non accettato", "digitare: n.lotto o il numero e anno separati da '/' o il codice ID lotto ('IDnnnn') o il codice Cliente/Mandante ('Cnnnn') o il WO (WOnnnn)")
		
		return
		
	end if	
	
	k_codice = long(k_codice_x)
//		if k_codice < 50000 then // se minore di 50 mila sicuramente si tratta di un numero lotto o codice cliente altrimenti se > 5000 di un ID lotto 
	kst_tab_armo.num_int = k_codice
	kst_tab_armo.data_int = date(integer(k_anno_x), 01, 01)
	kiuf_armo.get_id_meca(kst_tab_armo)
	kist_tab_meca.id = kst_tab_armo.id_meca
//		kist_tab_meca.clie_1 = long(k_cliente_x)
//		else
//		kist_tab_meca.id = k_codice
//		kist_tab_meca.clie_1 = 0
//		end if
	if kist_tab_meca.id > 0 then //or kist_tab_meca.clie_1 > 0 then
		u_retrieve_dw_lista()
		
		return
		
	end if

	kst_esito.sqlerrtext = "digitare: n.lotto o il numero e anno separati da '/' o il codice ID lotto ('IDnnnn') o il codice Cliente/Mandante ('Cnnnn') o il WO (WOnnnn)"	
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception

catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	kguo_exception.inizializza()
	kguo_exception.messaggio_utente( "Dati non trovati", kst_esito.sqlerrtext)

end try
end event

event dw_guida::ue_dwnkey;//

end event

type dw_data from uo_d_std_1 within w_meca_l
event u_cb_ok ( )
integer x = 2382
integer y = 256
integer width = 827
integer height = 492
integer taborder = 80
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string title = "estrae dal"
string dataobject = "d_data"
boolean controlmenu = true
boolean hsplitscroll = false
boolean livescroll = false
end type

event u_cb_ok();//
	this.visible = false
	this.accepttext( )
	ki_data_start  = this.getitemdate( 1, "kdata")
//	inizializza()
	ki_ultimo_codice_cercato = ""
	dw_guida.event ue_buttonclicked( )
	

end event

event buttonclicked;call super::buttonclicked;//
st_stampe kst_stampe
pointer oldpointer  // Declares a pointer variable

	
//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)
	

if dwo.name = "b_ok" then
	
	event u_cb_ok( )
	
else
	if dwo.name = "b_annulla" then

		this.visible = false
	
	
	end if
end if

SetPointer(oldpointer)


end event

event ue_visibile;call super::ue_visibile;//
int k_rc

	this.width = long(this.object.kdata.x) + long(this.object.kdata.width) + 100
	this.height = long(this.object.b_ok.y) + long(this.object.b_ok.height) + 160

	this.x = (kiw_this_window.width  - this.width) / 4
	this.y = (kiw_this_window.height - this.height) / 4

	this.reset()
	k_rc = this.insertrow(0)
	k_rc = this.setitem(1, "kdata", ki_data_start)
	this.visible = true
	this.setfocus()
end event

event u_pigiato_enter;//
event u_cb_ok( )

end event

type dw_stampa from datawindow within w_meca_l
boolean visible = false
integer x = 974
integer y = 700
integer width = 1522
integer height = 780
integer taborder = 60
boolean bringtotop = true
boolean titlebar = true
string title = "Stampa dati Lotto in elenco"
string dataobject = "d_meca_l_tipo_stampa"
boolean border = false
end type

event buttonclicked;//
if dwo.name = "b_ok" then
	stampa_choose_run()
else
	if dwo.name = "b_annulla" then
		this.visible = false
	end if
end if
end event

