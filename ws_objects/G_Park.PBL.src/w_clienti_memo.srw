$PBExportHeader$w_clienti_memo.srw
forward
global type w_clienti_memo from w_g_tab_3
end type
type dw_rtf from datawindow within tabpage_1
end type
type ln_1 from line within tabpage_4
end type
end forward

global type w_clienti_memo from w_g_tab_3
integer x = 169
integer y = 148
integer width = 3680
integer height = 2088
string title = "Piano di Trattamento SL-PT"
boolean ki_sincronizza_window_consenti = false
boolean ki_fai_nuovo_dopo_update = false
boolean ki_fai_nuovo_dopo_insert = false
boolean ki_msg_dopo_update = false
end type
global w_clienti_memo w_clienti_memo

type variables
//
kuf_clienti kiuf_clienti
kuf_memo kiuf_memo
st_tab_clienti_memo kist_tab_clienti_memo
st_tab_memo kist_tab_memo
string ki_memo_rtf = ""

end variables

forward prototypes
private function integer inserisci ()
protected function integer cancella ()
private subroutine leggi_altre_tab ()
protected function string aggiorna ()
protected function string inizializza ()
protected subroutine open_start_window ()
protected subroutine attiva_tasti ()
protected function boolean dati_modif_1 ()
protected function string check_dati ()
protected subroutine inizializza_lista ()
end prototypes

private function integer inserisci ();//
int k_return=1, k_ctr


//=== Aggiunge una riga al data windows
	choose case tab_1.selectedtab 
	
		case  1 
	
			if tab_1.tabpage_1.dw_rtf.rowcount() > 0 then
				tab_1.tabpage_1.dw_rtf.reset() 
			end if

			k_ctr=tab_1.tabpage_1.dw_rtf.insertrow(0)
			tab_1.tabpage_1.dw_rtf.setredraw( false)

			if len(kist_tab_memo.memo) > 0 then
				tab_1.tabpage_1.dw_rtf.pasteRtf( string(kist_tab_memo.memo) )
			else
				tab_1.tabpage_1.dw_rtf.pasteRtf("")
			end if		
			tab_1.tabpage_1.dw_rtf.setredraw( true)

			tab_1.tabpage_1.dw_rtf.SetItemStatus( 1, 0, Primary!, NotModified!)

			ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento
			
		case 2 // dati listino
//			k_codice = tab_1.tabpage_1.dw_rtf.getitemstring(1, "codice")
			
			
	end choose	

	attiva_tasti()

	k_return = 0


return (k_return)



end function

protected function integer cancella ();
////
////=== Cancellazione rekord dal DB
////=== Ritorna : 0=OK 1=KO 2=non eseguita
////
int k_return=0
string k_desc, k_record, k_record_1
long k_key = 0, k_clie_1=0, k_clie_2
string k_errore = "0 ", k_errore1 = "0 ", k_nro_fatt
long k_riga, k_seq
date k_data
st_tab_clienti_m_r_f kst_tab_clienti_m_r_f


//=== 
choose case tab_1.selectedtab 
	case 1 
		k_record = " Contatto "
		k_riga = tab_1.tabpage_1.dw_rtf.getrow()	
		if k_riga > 0 then
			if tab_1.tabpage_1.dw_rtf.getitemstatus(k_riga, 0, primary!) <> new! and &
				tab_1.tabpage_1.dw_rtf.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
				k_key = tab_1.tabpage_1.dw_rtf.getitemnumber(k_riga, "codice")
				k_desc = tab_1.tabpage_1.dw_rtf.getitemstring(k_riga, "rag_soc_10")
				if isnull(k_desc) = true or trim(k_desc) = "" then
					k_desc = "senza ragione sociale" 
				end if
				k_record_1 = &
					"Sei sicuro di voler eliminare l'intera Anagrafica~n~r" + &
					string(k_key, "#####") +  &
					"~n~r" + trim(k_desc) + " ?"
			else
				tab_1.tabpage_1.dw_rtf.deleterow(k_riga)
			end if
		end if
	case 4
		k_record = " Associazione Anagrafiche "
		k_riga = tab_1.tabpage_4.dw_4.getrow()	
		if k_riga > 0 then
			if tab_1.tabpage_4.dw_4.getitemstatus(k_riga, 0, primary!) <> new! and &
				tab_1.tabpage_4.dw_4.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
				k_key = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "m_r_f_clie_3")
				k_clie_1 = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "clie_1")
				k_clie_2 = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "clie_2")
				k_record_1 = &
					"Sei sicuro di voler eliminare il legame con il~n~r" &
					+ "Mandante " + trim(string(k_clie_1)) + "  e  il Ricevente " &
					+ trim(string(k_clie_2)) + " ?"
			else
				tab_1.tabpage_4.dw_4.deleterow(k_riga)
			end if
		end if
end choose	



//=== Se righe in lista
if k_riga > 0 and k_key > 0 then
	
//=== Richiesta di conferma della eliminazione del rek
	if messagebox("Elimina" + k_record, k_record_1, &
		question!, yesno!, 2) = 1 then
 
//=== Cancella la riga dal data windows di lista
		choose case tab_1.selectedtab 
			case 1 
				k_errore = kiuf_clienti.tb_delete(k_key) 
			case 4
				kst_tab_clienti_m_r_f.clie_1 = k_clie_1
				kst_tab_clienti_m_r_f.clie_2 = k_clie_2
				kst_tab_clienti_m_r_f.clie_3 = k_key
				k_errore = kiuf_clienti.tb_delete_m_r_f(kst_tab_clienti_m_r_f) 
		end choose	
		if left(k_errore, 1) = "0" then

			k_errore = kuf1_data_base.db_commit()
			if left(k_errore, 1) <> "0" then
				k_return = 1
				messagebox("Problemi durante la Cancellazione !!", &
						"Controllare i dati. " + mid(k_errore, 2))

			else
				
				choose case tab_1.selectedtab 
					case 1 
						tab_1.tabpage_1.dw_rtf.deleterow(k_riga)
					case 4 
						tab_1.tabpage_4.dw_4.deleterow(k_riga)
				end choose	

			end if

		else
			k_return = 1
			k_errore1 = k_errore
			k_errore = kuf1_data_base.db_rollback()

			messagebox("Problemi durante Cancellazione - Operazione fallita !!", &
							mid(k_errore1, 2) ) 	
			if left(k_errore, 1) <> "0" then
				messagebox("Problemi durante il recupero dell'errore !!", &
					"Controllare i dati. " + mid(k_errore, 2))
			end if

			attiva_tasti()

		end if


	else
		messagebox("Elimina" + k_record,  "Operazione Annullata !!")
		k_return = 2
	end if


end if


choose case tab_1.selectedtab 
	case 1 
		tab_1.tabpage_1.dw_rtf.setfocus()
		tab_1.tabpage_1.dw_rtf.setcolumn(1)
		tab_1.tabpage_1.dw_rtf.ResetUpdate ( ) 
	case 4
		tab_1.tabpage_4.dw_4.setfocus()
		tab_1.tabpage_4.dw_4.setcolumn(1)
		tab_1.tabpage_4.dw_4.ResetUpdate ( ) 
end choose	


return k_return

end function

private subroutine leggi_altre_tab ();
end subroutine

protected function string aggiorna ();//
//======================================================================
//=== Aggiorna tabelle 
//=== Ritorna 1 chr : 0=tutto OK; 1=errore grave I-O;
//=== 				  : 2=
//===					  : 3=Commit fallita
//===		dal char 2 in poi spiegazione dell'errore
//======================================================================

string k_return="0 ", k_errore="0 ", k_errore1="0 "
string k_memo_rtf=""
boolean k_new_rec
st_esito kst_esito
st_tab_memo kst_tab_memo


	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//--- Aggiorna, se modificato, la TAB_1	 
	try
		k_memo_rtf = trim(tab_1.tabpage_1.dw_rtf.CopyRTF(false))
		 
//--- carica il MEMO in tabella
		kst_tab_memo.id_memo = kist_tab_clienti_memo.id_memo
		kst_tab_memo.note = "Note del cliente " + string(kist_tab_clienti_memo.id_cliente) 
		kst_tab_memo.tipo_memo = kiuf_memo.kki_tipo_memo_rtf
		kst_tab_memo.memo = blob(k_memo_rtf)
		kst_tab_memo.id_memo = kiuf_memo.aggiorna(kst_tab_memo)
		
//--- associa il MEMO al cliente		
		kist_tab_clienti_memo.id_memo = kst_tab_memo.id_memo
		kist_tab_clienti_memo.tipo_sv = kiuf_memo.kki_tipo_sv_MKT
		kst_esito = kiuf_clienti.tb_update(kist_tab_clienti_memo)

	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito()
		
	end try

	if kst_esito.esito <> kkg_esito_ok then
		
		k_errore1 = "1" + string(kst_esito.sqlcode) + " " + kst_esito.sqlerrtext
		k_return = "1" + "Archivio " + tab_1.tabpage_1.text + MidA(k_errore1, 2)
			
	else // Tutti i Dati Caricati in Archivio
		ki_memo_rtf = k_memo_rtf
		
		k_return ="0 "

		tab_1.tabpage_1.dw_rtf.resetupdate( )
	end if 


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

protected function string inizializza ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_return="0", k_scelta
string k_stato = "0"
string  k_key
string k_fine_ciclo=""
int k_ctr=0
int k_err_ins, k_rc
st_tab_clienti kst_tab_clienti
st_tab_memo kst_tab_memo
kuf_utility kuf1_utility

//=== 
//tab_1.tabpage_4.dw_41.settransobject(sqlca)


if tab_1.tabpage_1.dw_rtf.rowcount() = 0 then
	
	k_scelta = trim(ki_st_open_w.flag_modalita)
	
	k_key = trim(ki_st_open_w.key1)  //--- ID MEMO
	
	if kist_tab_clienti_memo.id_cliente = 0 then
	
		k_return = "2"
		
	else
		
		if kist_tab_clienti_memo.id_memo = 0 then
			k_err_ins = inserisci()
			tab_1.tabpage_1.dw_rtf.setfocus()
		else
			k_rc = tab_1.tabpage_1.dw_rtf.retrieve(kist_tab_clienti_memo.id_memo) 
			
			choose case k_rc
	
				case is < 0				
					messagebox("Operazione fallita", &
						"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
						"(Codice cercato:" + string(kist_tab_clienti_memo.id_memo) + ")~n~r" )
					k_return ="E "   //Uscita Immediata
//					cb_ritorna.postevent(clicked!)
	
				case 0
		
					tab_1.tabpage_1.dw_rtf.reset()
					k_err_ins = inserisci()
					tab_1.tabpage_1.dw_rtf.setfocus()
					
				case is > 0		
					ki_st_open_w.flag_modalita = kkg_flag_modalita_modifica
					if k_scelta = kkg_flag_modalita_inserimento then
						messagebox("Memo Trovato ", &
							"Memo gia' in archivio ~n~r" + &
							"(Codice cercato :" + trim(k_key) + ")~n~r" )
					end if
	
					try
						kist_tab_clienti_memo.id_cliente = kiuf_clienti.get_id_cliente_memo(kist_tab_clienti_memo)
						
						kst_tab_memo.id_memo = kist_tab_clienti_memo.id_memo
						ki_memo_rtf = kiuf_memo.get_memo(kst_tab_memo)  
						if len(ki_memo_rtf) > 0 then
							tab_1.tabpage_1.dw_rtf.setredraw( false)
							tab_1.tabpage_1.dw_rtf.pasteRtf( ki_memo_rtf ) // mette il testo RTF a video
							tab_1.tabpage_1.dw_rtf.setredraw( true)
						end if

					catch (uo_exception kuo_exception)
						kuo_exception.messaggio_utente()
					end try
	
					tab_1.tabpage_1.dw_rtf.setcolumn(1)
					tab_1.tabpage_1.dw_rtf.setfocus()
		
			end choose
	
		end if
	end if
end if

if k_return = "0" then
	if ki_st_open_w.flag_primo_giro = "S" then
		if kist_tab_clienti_memo.id_cliente > 0 then
			kst_tab_clienti.codice = kist_tab_clienti_memo.id_cliente
			kiuf_clienti.get_nome( kst_tab_clienti )
			ki_st_open_w.window_title =  ki_st_open_w.window_title + " di   " + string(kist_tab_clienti_memo.id_cliente) + "  " + trim(kst_tab_clienti.rag_soc_10 ) + " "
		else
			ki_st_open_w.window_title =  ki_st_open_w.window_title + "  Anagrafica non indicata" 
		end if
		set_titolo_window()
	end if
	
end if



return k_return 

end function

protected subroutine open_start_window ();//
	kiuf_clienti = create kuf_clienti
	kiuf_memo = create kuf_memo

	if isnumber(trim(ki_st_open_w.key1)) then
		kist_tab_clienti_memo.id_memo = long(trim(ki_st_open_w.key1))  //--- ID MEMO
	else
		kist_tab_clienti_memo.id_memo = 0
	end if
	if isnumber(trim(ki_st_open_w.key2)) then
		kist_tab_clienti_memo.id_cliente = long(trim(ki_st_open_w.key2))  //--- ID CLIENTE
	else
		kist_tab_clienti_memo.id_cliente = 0
	end if
	if len(trim(ki_st_open_w.key3)) > 0 then
		kist_tab_memo.memo = blob(trim(ki_st_open_w.key3))
	else
		kist_tab_memo.memo = blob(string(today()))
	end if		

end subroutine

protected subroutine attiva_tasti ();//
//super::attiva_tasti()		 

//if ki_memo_rtf = trim(tab_1.tabpage_1.dw_rtf.CopyRTF(false)) then
//	cb_aggiorna.enabled = false
//else
	cb_aggiorna.enabled = true
//end if
attiva_menu()

end subroutine

protected function boolean dati_modif_1 ();//
boolean k_return = false
//st_tab_clienti_memo kst_tab_clienti_memo


//kst_tab_clienti_memo.memo = blob(tab_1.tabpage_1.dw_rtf.copyrtf( ))

tab_1.tabpage_1.dw_rtf.setredraw( false)
tab_1.tabpage_1.dw_rtf.accepttext( )

if ki_memo_rtf = trim(tab_1.tabpage_1.dw_rtf.CopyRTF(false)) then
else
	k_return = true
end if
tab_1.tabpage_1.dw_rtf.setredraw( true)

return k_return
end function

protected function string check_dati ();//
return  "0 "   //tutto OK

end function

protected subroutine inizializza_lista ();//
if trim(inizializza( )) = "E" then
	cb_ritorna.event clicked( )
else
	fine_primo_giro()
	attiva_tasti()
end if
end subroutine

on w_clienti_memo.create
int iCurrent
call super::create
end on

on w_clienti_memo.destroy
call super::destroy
end on

event close;call super::close;//
if isvalid(kiuf_clienti) then destroy kiuf_clienti

end event

event resize;call super::resize;//
tab_1.tabpage_1.dw_rtf.width = tab_1.tabpage_1.dw_1.width 
tab_1.tabpage_1.dw_rtf.height = tab_1.tabpage_1.dw_1.height
tab_1.tabpage_1.dw_rtf.x = tab_1.tabpage_1.dw_1.x 
tab_1.tabpage_1.dw_rtf.y = tab_1.tabpage_1.dw_1.y  

end event

type st_ritorna from w_g_tab_3`st_ritorna within w_clienti_memo
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_clienti_memo
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_clienti_memo
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_clienti_memo
integer x = 2711
integer y = 1424
end type

type st_stampa from w_g_tab_3`st_stampa within w_clienti_memo
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_clienti_memo
integer x = 1152
integer y = 1440
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_clienti_memo
integer x = 768
integer y = 1440
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_clienti_memo
integer x = 1970
integer y = 1424
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_clienti_memo
integer x = 2341
integer y = 1424
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_clienti_memo
integer x = 1600
integer y = 1424
boolean enabled = false
end type

event cb_inserisci::clicked;//
//=== 
string k_errore="0"

//=== Nuovo Rekord
	choose case tab_1.selectedtab 
		case  1, 3 
	
			k_errore = LeftA(dati_modif(parent.title), 1)

//=== Controllo se ho modificato dei dati nella DW DETTAGLIO
			if k_errore = "1" then //Fare gli aggiornamenti

//=== Ritorna 1 char: 0=Tutto OK; 1=Errore grave; 
//===	              : 2=Errore Non grave dati aggiornati
//===               : 3=
				k_errore = aggiorna_dati()		

			else

				if k_errore = "2" then //Aggiornamento non richiesto
					k_errore = "0"
				end if

			end if
			
	end choose
	
	if LeftA(k_errore, 1) = "0" then 
		inserisci()
	end if

end event

type tab_1 from w_g_tab_3`tab_1 within w_clienti_memo
boolean visible = true
integer x = 32
integer y = 52
integer width = 3040
integer height = 1396
long backcolor = 32435950
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
integer width = 3003
integer height = 1268
long backcolor = 32435950
string text = " MEMO "
long tabbackcolor = 32435950
long picturemaskcolor = 32435950
dw_rtf dw_rtf
end type

on tabpage_1.create
this.dw_rtf=create dw_rtf
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_rtf
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_rtf)
end on

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
integer x = 2171
integer y = 1032
integer width = 800
integer height = 228
boolean enabled = false
boolean ki_colora_riga_aggiornata = false
boolean ki_d_std_1_attiva_cerca = false
end type

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
boolean visible = false
integer width = 3003
integer height = 1268
boolean enabled = false
long backcolor = 32435950
string text = " Tutti i dati "
long tabbackcolor = 32435950
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
boolean visible = true
integer x = 0
integer width = 2981
integer height = 1228
boolean enabled = true
end type

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
integer width = 3003
integer height = 1268
boolean enabled = false
string text = ""
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
integer width = 2967
integer height = 1232
end type

event dw_3::itemchanged;call super::itemchanged;//



end event

event dw_3::getfocus;call super::getfocus;//getfocus
if This.getSelectedRow(0) <= 0 then
	This.SelectRow(1, TRUE)
end if
//

end event

event dw_3::clicked;call super::clicked;This.SetRow(row)
This.SelectRow(0, FALSE)
if row > 0 then
	This.SelectRow(row, TRUE)
end if

end event

event rowfocuschanged;//
This.SelectRow(0, FALSE)
this.SelectRow(currentrow, TRUE)

end event

event dw_3::ue_dwnkey;//

end event

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
integer width = 3003
integer height = 1268
boolean enabled = false
string text = ""
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
end type

event dw_4::getfocus;call super::getfocus;//getfocus
if This.getSelectedRow(0) <= 0 then
	This.SelectRow(1, TRUE)
end if
//

end event

event dw_4::clicked;call super::clicked;//
This.SetRow(row)
This.SelectRow(0, FALSE)
if row > 0 then
	This.SelectRow(row, TRUE)
end if

end event

event rowfocuschanged;//
This.SelectRow(0, FALSE)
this.SelectRow(currentrow, TRUE)

end event

event dw_4::ue_dwnkey;//

end event

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
integer width = 3003
integer height = 1268
boolean enabled = false
string text = ""
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
integer width = 2935
integer height = 1172
end type

event dw_5::clicked;call super::clicked;//
This.SetRow(row)
This.SelectRow(0, FALSE)
if row > 0 then
	This.SelectRow(row, TRUE)
end if

end event

event dw_5::getfocus;call super::getfocus;//getfocus
if This.getSelectedRow(0) <= 0 then
	This.SelectRow(1, TRUE)
end if
//

end event

event rowfocuschanged;//
This.SelectRow(0, FALSE)
this.SelectRow(currentrow, TRUE)

end event

event dw_5::ue_dwnkey;//
end event

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
integer width = 3003
integer height = 1268
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
end type

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
integer width = 3003
integer height = 1268
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
end type

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
integer width = 3003
integer height = 1268
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
integer width = 3003
integer height = 1268
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
end type

type dw_rtf from datawindow within tabpage_1
integer x = 59
integer y = 68
integer width = 878
integer height = 1016
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dw_rtf_memo"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;//
this.settransobject(sqlca)
end event

event editchanged;//
cb_aggiorna.enabled = true
attiva_menu()

end event

type ln_1 from line within tabpage_4
integer linethickness = 4
integer beginx = 361
integer beginy = 2376
integer endx = 2674
integer endy = 2376
end type

