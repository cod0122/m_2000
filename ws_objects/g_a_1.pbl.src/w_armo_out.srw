$PBExportHeader$w_armo_out.srw
forward
global type w_armo_out from w_g_tab_3
end type
end forward

global type w_armo_out from w_g_tab_3
boolean ki_fai_nuovo_dopo_update = false
boolean ki_fai_nuovo_dopo_insert = false
boolean ki_fai_inizializza_dopo_update = true
end type
global w_armo_out w_armo_out

type variables
//
private kuf_armo_out kiuf_armo_out
private int ki_selectedtab=1
end variables

forward prototypes
protected function string inizializza () throws uo_exception
public subroutine leggi_dwc ()
protected subroutine open_start_window ()
protected function string aggiorna ()
protected subroutine inizializza_1 () throws uo_exception
protected function string check_dati ()
protected subroutine riempi_id ()
protected function integer inserisci ()
protected function integer cancella ()
protected subroutine pulizia_righe ()
protected subroutine attiva_tasti_0 ()
end prototypes

protected function string inizializza () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_return="0 "
int k_rc 
st_tab_armo_out kst_tab_armo_out
st_esito kst_esito
kuf_utility kuf1_utility
//
pointer oldpointer  // Declares a pointer variable

ki_selectedtab=1

if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)
//
//
	if LenA(trim(ki_st_open_w.key1)) = 0 then
		kst_tab_armo_out.id_armo = 0
	else
		kst_tab_armo_out.id_armo = long(trim(ki_st_open_w.key1))  // id Lotto
	end if


//--- Se inserimento.... 
//   if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento then
////		post inserisci()
//	else

//--- Se NO inserimento.... 
		k_rc = tab_1.tabpage_1.dw_1.retrieve( kst_tab_armo_out.id_armo ) 
		
		choose case k_rc

			case is < 0				
				messagebox("Operazione fallita", &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(ID cercato :" + trim(string(kst_tab_armo_out.id_armo)) + ")~n~r" )
				cb_ritorna.postevent(clicked!)

			case 0
	
				tab_1.tabpage_1.dw_1.reset()
				attiva_tasti()

				messagebox("Ricerca fallita", &
						"Mi spiace, Riga Lotto non in archivio ~n~r" + &
					"(ID cercato: " + trim(string(kst_tab_armo_out.id_armo)) + ")~n~r" )

				cb_ritorna.triggerevent("clicked!")

			case is > 0		
				attiva_tasti()
		
		end choose

//	end if


//--- legge datawindowchild			
//	leggi_dwc( )
	
end if


return k_return 

end function

public subroutine leggi_dwc ();
end subroutine

protected subroutine open_start_window ();//

	kiuf_armo_out = create kuf_armo_out







end subroutine

protected function string aggiorna ();//
//======================================================================
//=== Aggiorna tabelle 
//=== Ritorna 1 chr : 0=tutto OK; 1=errore grave I-O;
//=== 				  : 2=
//===					  : 3=Commit fallita
//===		dal char 2 in poi spiegazione dell'errore
//======================================================================

string k_return="0 ", k_errore="0 "
st_tab_armo_out kst_tab_armo_out
boolean k_new_rec
st_esito kst_esito

setpointer(kkg.pointer_attesa)

//choose case tab_1.selectedtab 
		
//=== Aggiorna, se modificato, la TAB_2 Voci-prezzi
	if left(k_return,1) = "0" and tab_1.tabpage_2.dw_2.getnextmodified(0, primary!) > 0 	then
	
		if tab_1.tabpage_2.dw_2.update() = 1 then

//=== Se tutto OK faccio la COMMIT		
			kst_esito = kguo_sqlca_db_magazzino.db_commit()
			if kst_esito.esito = kkg_esito.db_ko then
				k_return = "3" + "Archivio " + tab_1.tabpage_2.text + " " + kst_esito.sqlerrtext
			else // Tutti i Dati Caricati in Archivio
				k_return ="0 "
			end if
		else
			kst_esito = kguo_sqlca_db_magazzino.db_rollback()
			k_return="1Fallito aggiornamento archivio '" + tab_1.tabpage_2.text + "' ~n~r" 
		end if	
	end if

setpointer(kkg.pointer_default)
		
//end choose

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

protected subroutine inizializza_1 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
long k_id_armo
string k_scelta, k_id_armo_prec
kuf_utility kuf1_utility


ki_selectedtab = 2

k_id_armo = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_armo")  

//--- Acchiappo il id_armo VOCE x evitare la rilettura
if IsNumber(tab_1.tabpage_2.st_2_retrieve.Text) then
	k_id_armo_prec = (tab_1.tabpage_2.st_2_retrieve.Text)
else
	k_id_armo_prec = " "
end if
//--- Forza valore id_armo  per ricordarlo per le prossime richieste
tab_1.tabpage_2.st_2_retrieve.Text=string(k_id_armo, "####0")


if tab_1.tabpage_2.st_2_retrieve.text <> k_id_armo_prec then

	if tab_1.tabpage_2.dw_2.retrieve(k_id_armo)  < 1 then
		inserisci()
	end if
end if


attiva_tasti()




	


end subroutine

protected function string check_dati ();//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK ma errore non grave
//===                : 5=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================
//
string k_return = " "
string k_errore = "0"
st_esito kst_esito
datastore kds_inp

try
	setpointer(kkg.pointer_attesa)

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kds_inp = create datastore

//--- Controllo il primo tab
	if tab_1.tabpage_2.dw_2.getnextmodified(0, primary!) > 0 then
		kds_inp.dataobject = tab_1.tabpage_2.dw_2.dataobject
		tab_1.tabpage_2.dw_2.rowscopy( 1,tab_1.tabpage_2.dw_2.rowcount( ) ,primary!, kds_inp, 1, primary!)
		kst_esito = kiuf_armo_out.u_check_dati(kds_inp)
	end if
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	
finally
	choose case kst_esito.esito
		case kkg_esito.OK
			k_errore = "0"
		case kkg_esito.ERR_LOGICO
			k_errore = "1"
		case kkg_esito.err_formale
			k_errore = "2"
		case kkg_esito.DATI_INSUFF
			k_errore = "3"
		case kkg_esito.DB_WRN
			k_errore = "4"
		case kkg_esito.DATI_WRN
			k_errore = "5"
		case else
			k_errore = "1"
	end choose

	k_return = trim(kst_esito.sqlerrtext)
//--- Attenzione se ho interesse di conoscere i campi in errore scorrere i TAG di ciascun campo nel DATASTORE dove c'e' il tipo di errore riscontrato 	

	setpointer(kkg.pointer_default)
	
end try


return k_errore + k_return


end function

protected subroutine riempi_id ();//
long k_riga = 0
st_tab_armo_out kst_tab_armo_out



	
	if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then
	
		kst_tab_armo_out.id_armo = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_armo")
	

		if kst_tab_armo_out.id_armo > 0 then

			k_riga = tab_1.tabpage_2.dw_2.getnextmodified( 0, primary!)
			do while k_riga > 0

				if tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id_armo_out") > 0 then
				else
					tab_1.tabpage_2.dw_2.setitem(k_riga, "id_armo_out", 0)
				end if
				
				if tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id_armo") > 0 then
				else
					tab_1.tabpage_2.dw_2.setitem(k_riga, "id_armo" ,kst_tab_armo_out.id_armo)
				end if			
				
				tab_1.tabpage_2.dw_2.setitem(k_riga, "x_datins", kGuf_data_base.prendi_x_datins())
				tab_1.tabpage_2.dw_2.setitem(k_riga, "x_utente", kGuf_data_base.prendi_x_utente())
				
				k_riga = tab_1.tabpage_2.dw_2.getnextmodified( k_riga, primary!)
			loop
		end if
	end if
end subroutine

protected function integer inserisci ();//
int k_return=1
long k_riga, k_colli=0 
kuf_utility kuf1_utility
kuf_armo kuf1_armo
st_tab_armo kst_tab_armo


try

	setpointer(kkg.pointer_attesa)
	
//--- Aggiunge una riga al data windows
	choose case ki_selectedtab 
				
		case 2  
			kuf1_armo = create kuf_armo
			kst_tab_armo.id_armo = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_armo")
			k_colli=kuf1_armo.get_colli_in_giacenza(kst_tab_armo)
	
			if k_colli <= 0 then
				kguo_exception.messaggio_utente( "Operazione non consentita", "Riga già totalmente scaricata")
			else
				tab_1.tabpage_2.dw_2.ki_flag_modalita = kkg_flag_modalita.inserimento
		
//--- S-protezione campi per abilitare l'inserimento
				kuf1_utility = create kuf_utility
				kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_2.dw_2)
				kuf1_utility.u_proteggi_dw("0","armo_out_data", tab_1.tabpage_2.dw_2)
				kuf1_utility.u_proteggi_dw("0","descr", tab_1.tabpage_2.dw_2)
				kuf1_utility.u_proteggi_dw("0","colli", tab_1.tabpage_2.dw_2)
				destroy kuf1_utility
		
				k_riga = tab_1.tabpage_2.dw_2.insertrow(0)
				tab_1.tabpage_2.dw_2.setitem(k_riga, "id_armo", tab_1.tabpage_1.dw_1.getitemnumber(1, "id_armo"))
				tab_1.tabpage_2.dw_2.setitem(k_riga, "id_armo_out", 0)
				tab_1.tabpage_2.dw_2.setitem(k_riga, "armo_out_data", kguo_g.get_dataoggi( ) )
				tab_1.tabpage_2.dw_2.setitem(k_riga, "colli", 0)
				tab_1.tabpage_2.dw_2.setitem(k_riga, "colli_max", k_colli)
				tab_1.tabpage_2.dw_2.setitem(k_riga, "descr", "" )
				
				tab_1.tabpage_2.dw_2.SetItemStatus(k_riga, 0, Primary!, NotModified!)
		
				tab_1.tabpage_2.dw_2.setfocus()
				tab_1.tabpage_2.dw_2.setrow(k_riga)
				tab_1.tabpage_2.dw_2.setcolumn("descr")
			end if
			
	end choose	

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()

end try

attiva_tasti()

k_return = 0

setpointer(kkg.pointer_default)


return (k_return)



end function

protected function integer cancella ();//
//=== Cancellazione rekord dal DB
//=== Ritorna : 0=OK 1=KO 2=non eseguita
//
int k_return=0
string k_desc,k_desc_1,  k_record, k_record_1
long k_key = 0, k_id_listino_pregruppo=0
string k_listino_pregruppo_descr
string k_errore = "0 ",  k_nro_fatt
long k_riga, k_seq
date k_data
st_esito kst_esito
st_tab_listino_pregruppo kst_tab_listino_pregruppo
st_tab_armo_out kst_tab_armo_out
st_tab_listino_link_pregruppi kst_tab_listino_link_pregruppi



//=== 
choose case tab_1.selectedtab 

		
	case 2 
		k_record = " Voce "
		k_riga = tab_1.tabpage_2.dw_2.getrow()	
		if k_riga > 0 then
			if tab_1.tabpage_2.dw_2.getitemstatus(k_riga, 0, primary!) <> new! and &
				tab_1.tabpage_2.dw_2.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
				k_key = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id_armo_out")
				k_desc = tab_1.tabpage_2.dw_2.getitemstring(k_riga, "descr")
				if isnull(k_desc) = true or trim(k_desc) = "" then
					k_desc = "senza descrizione" 
				end if
				k_record_1 = &
					"Sei sicuro di voler rimuovere il movimento di scarico nr. " + &
					string(k_key, "#####") + " " + &
					"~n~r" + trim(k_desc) + " ?"
			else
				tab_1.tabpage_2.dw_2.deleterow(k_riga)
			end if
		end if
		
end choose	



//=== Se righe in lista
if k_riga > 0 and k_key > 0 then
	
//--- Richiesta di conferma della eliminazione del rek
	if messagebox("Elimina" + k_record, k_record_1, &
		question!, yesno!, 2) = 1 then
 
 
 		try
			
//--- Rimozione in tab
			choose case tab_1.selectedtab 
				case 2
					kst_tab_armo_out.id_armo_out = k_key
					kiuf_armo_out.tb_delete(kst_tab_armo_out) 
			end choose	
		
		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()
			if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.db_wrn then
				if kst_esito.sqlcode > 0 then
					k_errore = "1" + trim(kst_esito.sqlerrtext) + "~n~rCodice errore: " + string(kst_esito.sqlcode)
				else
					k_errore = "1" + trim(kst_esito.sqlerrtext) 
				end if
			end if
			
		end try
		
		if left(k_errore, 1) = "0" then

			kst_esito = kguo_sqlca_db_magazzino.db_commit()
			if kst_esito.esito <> kkg_esito.ok then
				k_return = 1
				messagebox("Problemi durante la Cancellazione !!", &
					"Controllare i dati. " + trim(kst_esito.sqlerrtext))

			else
				
				choose case tab_1.selectedtab 
					case 2
						tab_1.tabpage_2.dw_2.deleterow(k_riga)
				end choose	

			end if

		else
			k_return = 1
			kst_esito = kguo_sqlca_db_magazzino.db_rollback()

			messagebox("Problemi durante Cancellazione - Operazione fallita !!", mid(k_errore, 2) ) 	
			if kst_esito.esito <> kkg_esito.ok then
				messagebox("Problemi durante il recupero dell'errore !!", &
					"Controllare i dati. " + trim(kst_esito.sqlerrtext))
			end if

			attiva_tasti()

		end if


	else
		messagebox("Elimina" + k_record,  "Operazione Annullata !!")
		k_return = 2
	end if


end if


choose case tab_1.selectedtab 
	case 2
		tab_1.tabpage_2.dw_2.setfocus()
		tab_1.tabpage_2.dw_2.setcolumn(1)
		tab_1.tabpage_2.dw_2.ResetUpdate ( ) 
end choose	


return k_return

end function

protected subroutine pulizia_righe ();//
long k_riga
long k_nr_righe


if tab_1.tabpage_2.dw_2.rowcount() > 0 then
	tab_1.tabpage_2.dw_2.accepttext()
end if

//=== Pulizia dei rek non validi sui vari TAB
	k_nr_righe = tab_1.tabpage_2.dw_2.rowcount()
	for k_riga = k_nr_righe to 1 step -1

		if tab_1.tabpage_2.dw_2.getitemstatus(k_riga, 0, primary!) = newmodified! then 
			if (isnull(tab_1.tabpage_2.dw_2.getitemstring ( k_riga, "descr"))  &
				 	or len(trim(tab_1.tabpage_2.dw_2.getitemstring ( k_riga, "descr"))) = 0)  &
				and (isnull(tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, "colli"))  &
				 	or tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, "colli") = 0)  &
				then
		
				tab_1.tabpage_2.dw_2.deleterow(k_riga)

			end if
		end if
		
	next


end subroutine

protected subroutine attiva_tasti_0 ();
super::attiva_tasti_0( )

if tab_1.selectedtab <> 2 then
	cb_cancella.enabled = false
	cb_inserisci.enabled = false
else
	cb_cancella.enabled = true
	cb_inserisci.enabled = true
end if

end subroutine

on w_armo_out.create
call super::create
end on

on w_armo_out.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type st_ritorna from w_g_tab_3`st_ritorna within w_armo_out
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_armo_out
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_armo_out
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_armo_out
end type

type st_stampa from w_g_tab_3`st_stampa within w_armo_out
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_armo_out
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_armo_out
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_armo_out
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_armo_out
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_armo_out
end type

type tab_1 from w_g_tab_3`tab_1 within w_armo_out
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
string text = "Entrata"
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
integer width = 1207
string dataobject = "d_armo"
end type

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
string text = "Scarico"
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
boolean visible = true
boolean enabled = true
string dataobject = "d_armo_out_l"
boolean ki_link_standard_sempre_possibile = true
end type

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
boolean enabled = false
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
end type

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
boolean enabled = false
end type

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
end type

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
boolean enabled = false
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
end type

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
end type

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
end type

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
end type

