$PBExportHeader$w_docprod.srw
forward
global type w_docprod from w_g_tab_3
end type
type ln_1 from line within tabpage_4
end type
end forward

global type w_docprod from w_g_tab_3
integer x = 169
integer y = 148
integer width = 2999
integer height = 756
string title = "Documento per l~'esportazione"
boolean ki_fai_nuovo_dopo_update = false
boolean ki_fai_exit_dopo_update = true
boolean ki_msg_dopo_update = false
end type
global w_docprod w_docprod

type variables
//
private kuf_docprod kiuf_docprod
private kuf_clienti kiuf_clienti
private st_tab_docprod kist_tab_docprod 
private boolean ki_ricopri_dati=false

end variables

forward prototypes
protected function string aggiorna ()
protected function integer cancella ()
protected function string check_dati ()
private subroutine riempi_id ()
protected function string inizializza ()
protected subroutine open_start_window ()
protected subroutine leggi_liste ()
private subroutine proteggi_campi ()
end prototypes

protected function string aggiorna ();//
//======================================================================
//=== Aggiorna tabelle 
//=== Ritorna 1 chr : 0=tutto OK; 1=errore grave I-O;
//=== 				  : 2=
//===					  : 3=Commit fallita
//===		dal char 2 in poi spiegazione dell'errore
//======================================================================

string k_return="0 ", k_errore="0 "
st_tab_docprod kst_tab_docprod
boolean k_new_rec
st_esito kst_esito


choose case tab_1.selectedtab 

	case 1 

		//=== Aggiorna, se modificato, la TAB_1	
		if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0 then
		
//--- imposto dati utente e data aggiornamento
			tab_1.tabpage_1.dw_1.setitem(1, "x_datins", kGuf_data_base.prendi_x_datins())
			tab_1.tabpage_1.dw_1.setitem(1, "x_utente", kGuf_data_base.prendi_x_utente())

			if tab_1.tabpage_1.dw_1.update() = 1 then 
		
//--- Se tutto OK faccio la COMMIT		
				kst_esito = kguo_sqlca_db_magazzino.db_commit()
				if kst_esito.esito <> kkg_esito.ok then
					k_return = "3" + "Archivio " + tab_1.tabpage_1.text + " ~n~rErrore: " + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) 
		
				else // Tutti i Dati Caricati in Archivio
					k_return ="0 "
				end if
				
			else
				kguo_sqlca_db_magazzino.db_rollback( )
				k_return="1Fallito aggiornamento archivio '" + tab_1.tabpage_1.text + "' ~n~r" 
			end if
		end if

		
		
end choose

//=== errore : 0=tutto OK o NON RICHIESTA; 1=errore grave I-O;
//=== 		 : 2=LIBERO
//===			 : 3=Commit fallita

if LeftA(k_return, 1) = "1" then
	messagebox("Operazione di Aggiornamento Non Eseguita !!", &
		MidA(k_return, 2))
else
	if LeftA(k_return, 1) = "3" then
		messagebox("Registrazione dati : problemi nella 'Commit' !!", &
			"Consiglio : chiudere e ripetere le operazioni eseguite")
	end if
end if


return k_return

end function

protected function integer cancella ();//
//=== Cancellazione rekord dal DB
//=== Ritorna : 0=OK 1=KO 2=non eseguita
//
int k_return=2
string k_errore = "0 "
long k_riga
st_tab_clienti kst_tab_clienti
st_tab_docprod kst_tab_docprod
st_esito kst_esito



//=== 
choose case tab_1.selectedtab 
	case 1 

		//=== Controllo se sul dettaglio c'e' qualche cosa
		k_riga = tab_1.tabpage_1.dw_1.rowcount()	
		if k_riga > 0 then
			kst_tab_docprod.id_docprod = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_docprod")
			kst_tab_docprod.doc_num = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "doc_num")
			kst_tab_docprod.doc_data = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "doc_data")
			kst_tab_clienti.codice = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_cliente")
			kst_tab_clienti.rag_soc_10 = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "rag_soc_10")
		end if
		
		if k_riga > 0 and kst_tab_docprod.id_docprod > 0 then	
			if isnull(kst_tab_clienti.codice) or kst_tab_clienti.codice = 0 then
				kst_tab_clienti.rag_soc_10 = "*** senza nome ***" 
			end if
			
		//=== Richiesta di conferma della eliminazione del rek
		
			if messagebox("Elimina Rif. al Documento", "Sei sicuro di voler Cancellare : ~n~r" + &
						string(kst_tab_docprod.id_docprod, "####0") + " di " + string(kst_tab_clienti.codice) + " " + trim(kst_tab_clienti.rag_soc_10) &
						+ "~n~rdocumento numero  " + string(kst_tab_docprod.doc_num) + "  del  " + string(kst_tab_docprod.doc_data), &
						question!, yesno!, 2) = 1 then
		 
			
		//=== Cancella la riga dal data windows di lista
				try
					if not kiuf_docprod.tb_delete( kst_tab_docprod ) then
						
						kst_esito.esito = kkg_esito.no_esecuzione
						kst_esito.sqlerrtext = "Cancellazione del id  " + string(kst_tab_docprod.id_docprod, "####0") + ". Non eseguita! "  
						
					end if
					
				catch (uo_exception kuo_exception)
					kst_esito = kuo_exception.get_st_esito()
					
				end try
				
				if kst_esito.esito = kkg_esito.ok then
					k_return = 0 
		
//--- Se tutto OK faccio la COMMIT		
					kst_esito = kguo_sqlca_db_magazzino.db_commit()
					if kst_esito.esito <> kkg_esito.ok then
						k_return = 1
						
						k_errore = "Operzione fallita (COMMIT)!! ~n~rErrore: " + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) 
						messagebox("Problemi durante la Cancellazione !!", k_errore)
		
					else
						
						tab_1.tabpage_1.dw_1.deleterow(k_riga)
		
					end if
		
					tab_1.tabpage_1.dw_1.setfocus()
		
				else
					k_return = 1
					k_errore = "Operazione fallita !! ~n~r" + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) 

					kst_esito = kguo_sqlca_db_magazzino.db_rollback()
					if kst_esito.esito <> kkg_esito.ok then
						k_errore += k_errore + "~n~rErrore anche durante il recupero dell'errore: ~n~r" + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) + "~n~rControllare i dati. "
					end if
						
					messagebox("Problemi durante Cancellazione", k_errore ) 	
		
				end if
		
		
			else
				k_return = 2
				messagebox("Elimina Rif. al Documento", "Operazione Annullata !!")
			end if
		
			tab_1.tabpage_1.dw_1.setcolumn(1)
		
		end if


//--- Cancella la Condizione
	case 3 

end choose	


choose case tab_1.selectedtab 
	case 1 
		tab_1.tabpage_1.dw_1.setfocus()
		tab_1.tabpage_1.dw_1.setcolumn(1)
//	case 3
//		tab_1.tabpage_3.dw_3.setfocus()
//		tab_1.tabpage_3.dw_3.setcolumn(1)
end choose	


		
attiva_tasti()


return k_return

end function

protected function string check_dati ();//
//----------------------------------------------------------------------------------------------------------
//--- Controllo formale e logico dei dati inseriti
//--- Ritorna 1 char  : 0=tutto OK; 1=errore logico; 2=errore formale;
//---			              3=dati insufficienti; 4=OK con errori non gravi
//---                          5=OK con avvertimenti
//---      il resto della stringa contiene la descrizione dell'errore   
//----------------------------------------------------------------------------------------------------------
//--- Controllo dati inseriti
string k_return = " ", k_errore = "0"
int k_nr_errori 
st_tab_docprod kst_tab_docprod
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//choose case tab_1.selectedtab 
//	case  1 
//		
////--- controllo se USERNAME già assegnato		
//			try
//				kst_tab_docprod.id_docprod = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_docprod")
//				kst_tab_docprod.username = tab_1.tabpage_1.dw_1.getitemstring(1, "username")
//				if kiuf_docprod.if_esiste_username( kst_tab_docprod) then
//					k_return = tab_1.tabpage_1.text + ": 'Login' gia' assegnato ad altro Utente " 
//					k_errore = "1"
//					k_nr_errori++
//				end if
//				
//			catch (uo_exception kuo_exception)
//				kst_esito = kuo_exception.get_st_esito()
//				if kst_esito.esito = kkg_esito.ok then
//					if kst_tab_docprod.id_docprod > 0 then
//						k_return = tab_1.tabpage_1.text + ": Errore durante controllo del 'Login' " + trim(kst_esito.sqlerrtext )
//						k_errore = "4"
//						k_nr_errori++
//					end if
//				end if	
//			end try
//		
////--- controllo se sono stati caricati Utenti collegati al Cliente
//		if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
//
//			if tab_1.tabpage_1.dw_1.rowcount() > 0 then
//				try
//					kst_tab_docprod.idcliente = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente")
//					kst_tab_docprod.id_docprod = kiuf_docprod.get_ultimo_cliente(kst_tab_docprod)
//				catch (uo_exception kuo1_exception)
//					kst_esito = kuo1_exception.get_st_esito()
//				end try
//				if kst_esito.esito = kkg_esito.ok then
//					if kst_tab_docprod.id_docprod > 0 then
//						k_return = tab_1.tabpage_1.text + ": Utente gia' associato al cliente " + string(kst_tab_docprod.idcliente ) 
//						k_errore = "4"
//						k_nr_errori++
//					end if
//				end if	
//			end if	
//		end if
////		if k_errore = "4" or k_errore = "0" then 
////			if tab_1.tabpage_1.dw_1.getitemstring( 1, "stato") = kiuf_docprod.kki_STATO_accettato then
////				k_errore = "4"
////				k_nr_errori++
////				k_return = tab_1.tabpage_1.text + ": Lo Stato 'ACCETTATO' rende il documento IMMODIFICABILE, controlla meglio.  "
////			end if
////		end if
//
//
//end choose

return trim(k_errore) + k_return


end function

private subroutine riempi_id ();//
//
long k_ctr = 0
st_tab_docprod kst_tab_docprod



	k_ctr = tab_1.tabpage_1.dw_1.getrow()
	
	if k_ctr > 0 then
	
		kst_tab_docprod.id_docprod = tab_1.tabpage_1.dw_1.getitemnumber(k_ctr, "id_docprod")
	
//=== Se non sono in caricamento allora prelevo l'ID dalla dw
		if tab_1.tabpage_1.dw_1.getitemstatus(k_ctr, 0, primary!) <> newmodified! then
			kst_tab_docprod.id_docprod = tab_1.tabpage_1.dw_1.getitemnumber(k_ctr, "id_docprod")
		end if
	
		if isnull(kst_tab_docprod.id_docprod) or kst_tab_docprod.id_docprod = 0 then				
			tab_1.tabpage_1.dw_1.setitem(k_ctr, "id_docprod", 0)
		end if
		
	end if


end subroutine

protected function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_return="0 "
int k_rc 
st_uf_docpath kst_uf_docpath	
st_tab_docprod kst_tab_docprod
st_esito kst_esito
kuf_utility kuf1_utility
kuf_doctipo kuf1_doctipo
uo_exception kuo_exception


//
pointer oldpointer  // Declares a pointer variable

if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

//--- Se inserimento.... 
   if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento then
		inserisci()
	else
//--- Se NO inserimento.... 
		k_rc = tab_1.tabpage_1.dw_1.retrieve( kist_tab_docprod.id_docprod ) 
		
		choose case k_rc

			case is < 0				
				messagebox("Operazione fallita", &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(ID Rif. a Documento cercato:" + trim(string(kist_tab_docprod.id_docprod)) + ")~n~r" )
				cb_ritorna.postevent(clicked!)

			case 0
	
				tab_1.tabpage_1.dw_1.reset()
				attiva_tasti()

				messagebox("Ricerca fallita", &
						"Mi spiace, il codice 'Rif. a Documento' non e' in archivio ~n~r" + &
					"(ID cercato: "  &
					 + trim(string(kist_tab_docprod.id_docprod)) + ")~n~r" )

				cb_ritorna.triggerevent("clicked!")

			case is > 0		
//				if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
//				end if	
					
				try
//--- get del PATH dove registrerà il documento
					kst_tab_docprod.doc_data = tab_1.tabpage_1.dw_1.getitemdate(1, "doc_data")
					kst_tab_docprod.id_cliente = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente")
					kst_tab_docprod.id_docpath = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_docpath")
//					choose case tab_1.tabpage_1.dw_1.object.tipo[1]
//							
//						case kuf1_doctipo.kki_tipo_fatture
							kst_uf_docpath = kiuf_docprod.get_path(kst_tab_docprod)
							
						
//					end choose
					
					tab_1.tabpage_1.dw_1.setitem(1, "path", kst_uf_docpath.k_path_interno )
					tab_1.tabpage_1.dw_1.resetupdate( )
					
				catch (uo_exception kuo1_exception)
					kuo1_exception.messaggio_utente( )
				
				end try
				
				attiva_tasti()
		
		end choose

	end if

//--- protegge/sprotegge campi
	proteggi_campi()


//--- flag x sostituire i dati provenienti dal cliente	
	ki_ricopri_dati = false

////--- se inserimento inabilito gli altri TAB, sono inutili
//	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
//		ki_ricopri_dati = true
//	
//		tab_1.tabpage_1.dw_1.setcolumn("cliente_nome")
//		tab_1.tabpage_1.dw_1.setfocus()
//	else
//		if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
//			tab_1.tabpage_1.dw_1.setcolumn("username")
//			tab_1.tabpage_1.dw_1.setfocus()
//		end if
//	end if
	

	
	
end if


return k_return 

end function

protected subroutine open_start_window ();//
int k_rc

	kiuf_docprod = create kuf_docprod

//--- Acquisisce i dati da passati in Argomento
	if not isnumber(trim(ki_st_open_w.key1)) then
		kist_tab_docprod.id_docprod = 0
	else
		kist_tab_docprod.id_docprod = long(trim(ki_st_open_w.key1))
	end if



end subroutine

protected subroutine leggi_liste ();
end subroutine

private subroutine proteggi_campi ();//
//--- Protegge o meno a seconda dei casi
//
kuf_utility kuf1_utility



//--- 
	if ki_st_open_w.flag_modalita <> kkg_flag_modalita.inserimento and tab_1.tabpage_1.dw_1.getrow() > 0 then

		tab_1.tabpage_1.dw_1.setredraw(false)


	
//--- Inabilita campi alla modifica se Vsualizzazione
		kuf1_utility = create kuf_utility 
		if trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.inserimento and trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.modifica then
		
			kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_1.dw_1)

			kuf1_utility.u_proteggi_dw("1", "id_docprod", tab_1.tabpage_1.dw_1)
	
		else		
			
//--- S-protezione campi per riabilitare la modifica a parte la chiave
	      	kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)

//--- Inabilita campo ID alla modifica se Funzione MODIFICA
			if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
	
//--- protegge i campi chiave
				kuf1_utility.u_proteggi_dw("1", "id_docprod", tab_1.tabpage_1.dw_1)
			end if
		end if
		destroy kuf1_utility
		
	
		tab_1.tabpage_1.dw_1.setredraw(true)
	
	end if


end subroutine

on w_docprod.create
int iCurrent
call super::create
end on

on w_docprod.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;//
if isvalid(kiuf_docprod) then destroy 	kiuf_docprod
if isvalid(kiuf_clienti) then destroy 	kiuf_clienti



end event

type st_ritorna from w_g_tab_3`st_ritorna within w_docprod
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_docprod
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_docprod
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_docprod
integer x = 2711
integer y = 1468
end type

type st_stampa from w_g_tab_3`st_stampa within w_docprod
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_docprod
integer x = 1179
integer y = 1472
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_docprod
integer x = 645
integer y = 1468
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_docprod
integer x = 1970
integer y = 1468
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_docprod
integer x = 2341
integer y = 1468
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_docprod
integer x = 1600
integer y = 1468
boolean enabled = false
end type

type tab_1 from w_g_tab_3`tab_1 within w_docprod
integer y = 28
integer width = 3072
integer height = 1384
long backcolor = 32172778
end type

on tab_1.create
call super::create
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6,&
this.tabpage_7,&
this.tabpage_8,&
this.tabpage_9}
end on

on tab_1.destroy
call super::destroy
end on

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
integer width = 3035
integer height = 1256
long backcolor = 32172778
string text = "Documento"
string picturename = "Window!"
long picturemaskcolor = 553648127
string powertiptext = "Anagrafica listino"
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
integer y = 36
integer width = 3013
integer height = 1236
string dataobject = "d_docprod"
boolean minbox = true
boolean maxbox = true
string ki_flag_modalita = "vi"
end type

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
boolean visible = false
integer width = 3035
integer height = 1256
boolean enabled = false
string text = "tab"
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
boolean visible = true
integer x = 0
integer width = 2981
integer height = 1228
boolean enabled = true
string ki_flag_modalita = "vi"
end type

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
integer x = 594
integer y = 136
integer height = 144
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
integer width = 3035
integer height = 1256
boolean enabled = false
string text = "tab"
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
integer width = 2967
integer height = 1232
string ki_flag_modalita = "vi"
end type

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
integer width = 3035
integer height = 1256
boolean enabled = false
string text = "tab"
ln_1 ln_1
end type

on tabpage_4.create
this.ln_1=create ln_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ln_1
end on

on tabpage_4.destroy
call super::destroy
destroy(this.ln_1)
end on

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
integer y = 24
integer width = 2939
integer height = 1116
integer taborder = 10
string ki_flag_modalita = "vi"
end type

event buttonclicked;//
//=== Attivo/Disattivo visione grafico
if this.object.kgr_1.visible = "1" then
	tab_1.tabpage_4.dw_4.object.kcb_gr.text = "Grafico"
	tab_1.tabpage_4.dw_4.object.kgr_1.visible = "0" 
else
	tab_1.tabpage_4.dw_4.object.kcb_gr.text = "Dati"
	tab_1.tabpage_4.dw_4.object.kgr_1.visible = "1"
end if
//

end event

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
integer width = 3035
integer height = 1256
boolean enabled = false
string text = "tab"
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
integer width = 2935
integer height = 1172
string ki_flag_modalita = "vi"
end type

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
integer width = 3035
integer height = 1256
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
string ki_flag_modalita = "vi"
end type

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
integer width = 3035
integer height = 1256
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
string ki_flag_modalita = "vi"
end type

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
integer width = 3035
integer height = 1256
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
string ki_flag_modalita = "vi"
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
integer width = 3035
integer height = 1256
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
string ki_flag_modalita = "vi"
end type

type st_duplica from w_g_tab_3`st_duplica within w_docprod
end type

type ln_1 from line within tabpage_4
integer linethickness = 4
integer beginx = 361
integer beginy = 2376
integer endx = 2674
integer endy = 2376
end type

