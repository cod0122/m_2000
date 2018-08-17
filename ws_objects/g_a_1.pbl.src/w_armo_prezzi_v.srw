$PBExportHeader$w_armo_prezzi_v.srw
forward
global type w_armo_prezzi_v from w_g_tab_3
end type
end forward

global type w_armo_prezzi_v from w_g_tab_3
boolean ki_fai_nuovo_dopo_update = false
boolean ki_fai_nuovo_dopo_insert = false
boolean ki_fai_proteggi_dopo_update = true
end type
global w_armo_prezzi_v w_armo_prezzi_v

type variables
//
private kuf_armo_prezzi_v kiuf_armo_prezzi_v
private int ki_selectedtab=1
private st_tab_armo_prezzi_v kist_tab_armo_prezzi_v
private st_tab_armo kist_tab_armo

end variables

forward prototypes
protected function string inizializza () throws uo_exception
protected function integer inserisci ()
protected subroutine riempi_id ()
protected subroutine open_start_window ()
protected function string aggiorna ()
protected subroutine inizializza_1 () throws uo_exception
protected subroutine pulizia_righe ()
protected function string check_dati ()
private subroutine put_video_voce (st_tab_armo_prezzi_v kst_tab_armo_prezzi_v)
public function integer leggi_dwc ()
protected subroutine attiva_tasti_0 ()
end prototypes

protected function string inizializza () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_return="0 "
int k_rc, k_righe_x_costi_aperti=0 
st_esito kst_esito
st_tab_armo_prezzi_v kst_tab_armo_prezzi_v
kuf_utility kuf1_utility
datawindowchild kdwc_1
pointer oldpointer  // Declares a pointer variable


ki_selectedtab=1


if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

	k_rc = tab_1.tabpage_1.dw_1.retrieve(kist_tab_armo.id_armo, kist_tab_armo_prezzi_v.id_armo_prezzo_v, kist_tab_armo_prezzi_v.id_armo_prezzo ) 

	choose case k_rc

		case is < 0				
			messagebox("Operazione fallita", &
				"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
				"(ID riga cercato :" + trim(string(kist_tab_armo.id_armo)) + ")~n~r" )
			cb_ritorna.postevent(clicked!)

		case 0
			messagebox("Ricerca fallita", &
					"La riga lotto non e' in archivio ~n~r" + &
				"(ID riga cercato: " + trim(string(kist_tab_armo.id_armo)) + ")~n~r" )

			cb_ritorna.postevent(clicked!)

		case is > 0		
			
		//--- Inabilita campi alla modifica se Vsualizzazione
			kuf1_utility = create kuf_utility 
			if trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.inserimento and trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.modifica then
				kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_1.dw_1)
			else		
		//--- S-protezione campi 
				kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)
			end if
			destroy kuf1_utility
					
		
		//--- Se inserimento.... 
			if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento then
				inserisci()
				
		//--- legge righe del dwc
				k_righe_x_costi_aperti = leggi_dwc( )
		//--- c'e' almeno una VOCE COSTO APERTA?
				if k_righe_x_costi_aperti = 0 then
		
					messagebox("Operazione non disponibile", &
							"La riga lotto non ha costi disponibili ('APERTI') da poter aggiungere in questa fase ~n~r" + &
						"(id riga: " + trim(string(kist_tab_armo.id_armo)) + ")~n~r" )
		
					cb_ritorna.postevent(clicked!)
					
				else
					attiva_tasti()
					
// se c'e' solo 1 costo allora becco subito quello 				
					if k_righe_x_costi_aperti = 1 then 
						k_rc = tab_1.tabpage_1.dw_1.getchild("armo_prezzi_v_id_armo_prezzo", kdwc_1)
						kst_tab_armo_prezzi_v.id_armo_prezzo = kdwc_1.getitemnumber(1, "id_armo_prezzo")
						tab_1.tabpage_1.dw_1.setitem(1, "armo_prezzi_v_id_armo_prezzo", kst_tab_armo_prezzi_v.id_armo_prezzo)
						put_video_voce(kst_tab_armo_prezzi_v)
						tab_1.tabpage_1.dw_1.SetItemStatus( 1, 0, Primary!, NotModified!)
						tab_1.tabpage_1.dw_1.setredraw(true)
						tab_1.tabpage_1.dw_1.setfocus()
						tab_1.tabpage_1.dw_1.setcolumn("descr")
					else
						tab_1.tabpage_1.dw_1.SetItemStatus( 1, 0, Primary!, NotModified!)
						tab_1.tabpage_1.dw_1.setredraw(true)
						tab_1.tabpage_1.dw_1.setfocus()
						tab_1.tabpage_1.dw_1.setcolumn("armo_prezzi_v_id_armo_prezzo")
						
					end if
					
				end if
			else
				attiva_tasti()
			end if
			
		
		end choose
	end if


return k_return 

end function

protected function integer inserisci ();//
int k_return=1, k_ctr, k_rc
string k_errore="0 ", k_rcx
//long k_riga 
//st_tab_armo_prezzi_v kst_tab_armo_prezzi_v
kuf_utility kuf1_utility
//datawindowchild Kdwc_armo_prezzi_v_categ, Kdwc_armo_prezzi_v_catege_des


//=== Controllo se ho modificato dei dati nella DW DETTAGLIO
if left(dati_modif(""), 1) = "1" then //Richisto Aggiornamento

//=== Controllo congruenza dei dati caricati e Aggiornamento  
//=== Ritorna 1 char : 0=tutto OK; 1=errore grave;
//===                : 2=errore non grave dati aggiornati;
//===			         : 3=LIBERO
//===      il resto della stringa contiene la descrizione dell'errore   
	k_errore = aggiorna_dati()

end if


if LeftA(k_errore, 1) = "0" then


//=== Aggiunge una riga al data windows
	choose case ki_selectedtab 
		case  1 

//--- S-protezione campi per abilitare l'inserimento
			kuf1_utility = create kuf_utility
	     	kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)
			destroy kuf1_utility

			ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
			
			tab_1.tabpage_1.dw_1.setitem(1, "id_armo_prezzo_v", 0)
			
			tab_1.tabpage_1.dw_1.setitem(1, "segno", kiuf_armo_prezzi_v.kki_segno_piu)
			tab_1.tabpage_1.dw_1.setitem(1, "stato", kiuf_armo_prezzi_v.kki_stato_daFatt )
			tab_1.tabpage_1.dw_1.SetItemStatus( 1, 0, Primary!, NewModified!)

			tab_1.tabpage_1.dw_1.setfocus()
			tab_1.tabpage_1.dw_1.setcolumn("armo_prezzi_v_id_armo_prezzo")

			
			
		case 2 

		case 3 

		case 4 
			
		case 5 
			
	end choose	

	attiva_tasti()

	k_return = 0

end if

return (k_return)



end function

protected subroutine riempi_id ();//
//
long k_ctr = 0
st_tab_armo_prezzi_v kst_tab_armo_prezzi_v



	k_ctr = tab_1.tabpage_1.dw_1.getrow()
	
	if k_ctr > 0 then
	
		kst_tab_armo_prezzi_v.id_armo_prezzo_v = tab_1.tabpage_1.dw_1.getitemnumber(k_ctr, "id_armo_prezzo_v")
	
//=== Se non sono in caricamento allora prelevo l'id_armo_prezzo_v dalla dw
		if tab_1.tabpage_1.dw_1.getitemstatus(k_ctr, 0, primary!) <> newmodified! then
			kst_tab_armo_prezzi_v.id_armo_prezzo_v = tab_1.tabpage_1.dw_1.getitemnumber(k_ctr, "id_armo_prezzo_v")
		end if
		if isnull(kst_tab_armo_prezzi_v.id_armo_prezzo_v) or kst_tab_armo_prezzi_v.id_armo_prezzo_v = 0 then				
			tab_1.tabpage_1.dw_1.setitem(k_ctr, "id_armo_prezzo_v", 0)
		end if

//--- imposto dati utente e data aggiornamento
		tab_1.tabpage_1.dw_1.setitem(1, "x_datins", kGuf_data_base.prendi_x_datins())
		tab_1.tabpage_1.dw_1.setitem(1, "x_utente", kGuf_data_base.prendi_x_utente())

	end if



end subroutine

protected subroutine open_start_window ();//
int k_rc
datawindowchild  kdwc_1



	kiuf_armo_prezzi_v = create kuf_armo_prezzi_v

	ki_toolbar_window_presente=true



//--- Attivo dw archivio Prodotto
	k_rc = tab_1.tabpage_1.dw_1.getchild("armo_prezzi_v_id_armo_prezzo", kdwc_1)

	k_rc = kdwc_1.settransobject(kguo_sqlca_db_magazzino )


//--- id della riga lotto
	if LenA(trim(ki_st_open_w.key1)) = 0 then
		kist_tab_armo.id_armo = 0
	else
		kist_tab_armo.id_armo = long(trim(ki_st_open_w.key1))  // id_armo
	end if
//--- id della riga costo
	if LenA(trim(ki_st_open_w.key2)) = 0 then
		kist_tab_armo_prezzi_v.id_armo_prezzo_v = 0
	else
		kist_tab_armo_prezzi_v.id_armo_prezzo_v = long(trim(ki_st_open_w.key2))  // id_armo_prezzo_v
	end if
//--- id della riga prezzo
	if LenA(trim(ki_st_open_w.key3)) = 0 then
		kist_tab_armo_prezzi_v.id_armo_prezzo = 0
	else
		kist_tab_armo_prezzi_v.id_armo_prezzo = long(trim(ki_st_open_w.key3))  // id_armo_prezzo
	end if


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
st_tab_armo_prezzi_v kst_tab_armo_prezzi_v
boolean k_new_rec
st_esito kst_esito

//=== 
//choose case tab_1.selectedtab 

//	case 1 

//=== Aggiorna, se modificato, la TAB_1	
	if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0 then
		if tab_1.tabpage_1.dw_1.GetItemStatus(1, 0,  primary!) = NewModified!	then
			k_new_rec = true
		else
			k_new_rec = false
		end if

		if tab_1.tabpage_1.dw_1.update() = 1 then 

//--- Se tutto OK faccio la COMMIT		
			kst_esito = kguo_sqlca_db_magazzino.db_commit()
			if kst_esito.esito <> kkg_esito.ok then
				k_return = "3" + "Archivio " + tab_1.tabpage_1.text + " ~n~rErrore: " + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) 
	
			else // Tutti i Dati Caricati in Archivio
				k_return ="0 "

//--- Se nuova riga Imposto il campo Contatore ID (SERIAL)				
				if k_new_rec then
					
					try 
						kst_tab_armo_prezzi_v.id_armo_prezzo_v = kiuf_armo_prezzi_v.get_ultimo_id()	
						tab_1.tabpage_1.dw_1.setitem(1, "id_armo_prezzo_v", kst_tab_armo_prezzi_v.id_armo_prezzo_v)
						tab_1.tabpage_1.dw_1.resetupdate( )
						ki_st_open_w.key2 = string( kst_tab_armo_prezzi_v.id_armo_prezzo_v)
						ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione

//--- Aggiorna la tabella ARMO PREZZI		
						kst_tab_armo_prezzi_v.colli = tab_1.tabpage_1.dw_1.getitemnumber(1, "colli")
						kst_tab_armo_prezzi_v.id_armo_prezzo = tab_1.tabpage_1.dw_1.getitemnumber(1, "armo_prezzi_v_id_armo_prezzo")
						kst_tab_armo_prezzi_v.segno = tab_1.tabpage_1.dw_1.getitemstring(1, "segno")
						kst_tab_armo_prezzi_v.stato = tab_1.tabpage_1.dw_1.getitemstring(1, "stato")
						kiuf_armo_prezzi_v.set_armo_prezzo(kst_tab_armo_prezzi_v)

						
					catch (uo_exception kuo_exception)
						kuo_exception.messaggio_utente()
						
					end try
					
				end if

			end if
			
		else
			kguo_sqlca_db_magazzino.db_rollback( )
			k_return="1Fallito aggiornamento archivio " //+ tab_1.tabpage_1.text 
		end if
	end if


		
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
			k_return="1Fallito aggiornamento archivio " //+ tab_1.tabpage_2.text + "' ~n~r" 
		end if	
	end if

		
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

protected subroutine inizializza_1 () throws uo_exception;//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
int k_rc=0
long k_riga
string k_codice_attuale, k_codice_prec
st_tab_armo kst_tab_armo
	

k_riga = tab_1.tabpage_1.dw_1.getrow() 
	
kst_tab_armo.id_meca = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_meca")

//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if not isnull(tab_1.tabpage_2.st_2_retrieve.text) then
	k_codice_prec = tab_1.tabpage_2.st_2_retrieve.text
else
	k_codice_prec = string(kst_tab_armo.id_meca)
end if

k_codice_attuale = "*"

//=== Forza valore Codice composto per ricordarlo per le prossime richieste
tab_1.tabpage_2.st_2_retrieve.text = k_codice_attuale

if k_codice_attuale <> k_codice_prec then

	k_rc=tab_1.tabpage_2.dw_2.retrieve(kst_tab_armo.id_meca)  

end if				
				

attiva_tasti()
//if tab_1.tabpage_2.dw_2.rowcount() = 0 then
//	tab_1.tabpage_2.dw_2.insertrow(0) 
//end if


tab_1.tabpage_2.dw_2.setfocus()
	
	

end subroutine

protected subroutine pulizia_righe ();//
long k_riga
long k_nr_righe


if tab_1.tabpage_1.dw_1.rowcount() > 0 then
	tab_1.tabpage_1.dw_1.accepttext()
end if

//=== Pulizia dei rek non validi sui vari TAB
	k_nr_righe = tab_1.tabpage_1.dw_1.rowcount()
	for k_riga = k_nr_righe to 1 step -1

		if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) = newmodified! then 
			if (isnull(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "descr"))  &
				 	or len(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "descr"))) = 0)  &
				and (isnull(tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "colli"))  &
				 	or tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "colli") = 0)  &
				then
		
				tab_1.tabpage_1.dw_1.deleterow(k_riga)

			end if
		end if
		
	next


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
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kds_inp = create datastore

//--- Controllo il primo tab
	if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0 then
		kds_inp.dataobject = tab_1.tabpage_1.dw_1.dataobject
		tab_1.tabpage_1.dw_1.rowscopy( 1,tab_1.tabpage_1.dw_1.rowcount( ) ,primary!, kds_inp, 1, primary!)
		kst_esito = kiuf_armo_prezzi_v.u_check_dati(kds_inp)
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
	
end try


return k_errore + k_return


end function

private subroutine put_video_voce (st_tab_armo_prezzi_v kst_tab_armo_prezzi_v);//
//--- Visualizza dati Pagamento
//
long k_riga=0
datawindowchild kdwc_1



tab_1.tabpage_1.dw_1.modify( "armo_prezzi_v_id_armo_prezzo.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
tab_1.tabpage_1.dw_1.setitem( tab_1.tabpage_1.dw_1.getrow(), "armo_prezzi_v_id_armo_prezzo", kst_tab_armo_prezzi_v.id_armo_prezzo )

tab_1.tabpage_1.dw_1.getchild("armo_prezzi_v_id_armo_prezzo", kdwc_1)
k_riga = kdwc_1.find( "id_armo_prezzo = " + string(kst_tab_armo_prezzi_v.id_armo_prezzo) + " " , 1, kdwc_1.rowcount())
if k_riga > 0 then
	tab_1.tabpage_1.dw_1.setitem(tab_1.tabpage_1.dw_1.getrow(), "listino_voci_descr", kdwc_1.getitemstring(k_riga, "descr")  )
	tab_1.tabpage_1.dw_1.setitem(tab_1.tabpage_1.dw_1.getrow(), "id_listino_voce", kdwc_1.getitemnumber(k_riga, "id_listino_voce")  )
	tab_1.tabpage_1.dw_1.setitem(tab_1.tabpage_1.dw_1.getrow(), "listino_voci_um", kdwc_1.getitemstring(k_riga, "um")  )
else
	tab_1.tabpage_1.dw_1.setitem(tab_1.tabpage_1.dw_1.getrow(), "listino_voci_descr", " " )
	tab_1.tabpage_1.dw_1.setitem(tab_1.tabpage_1.dw_1.getrow(), "id_listino_voce", 0  )
	tab_1.tabpage_1.dw_1.setitem(tab_1.tabpage_1.dw_1.getrow(), "listino_voci_um", " " )
end if

//--- x default mette la descrizione uguale a quella della Voce
//if len(trim(tab_1.tabpage_1.dw_1.getitemstring(tab_1.tabpage_1.dw_1.getrow(), "listino_voci_descr"))) > 0 or len(kdwc_1.getitemstring(k_riga, "descr")) > 0 then
//else
//	tab_1.tabpage_1.dw_1.setitem(tab_1.tabpage_1.dw_1.getrow(), "listino_voci_descr", kdwc_1.getitemstring(k_riga, "descr")  )
//end if

////--- x default mette la descrizione uguale a quella della Voce
//if len(trim(tab_1.tabpage_1.dw_1.getitemstring(tab_1.tabpage_1.dw_1.getrow(), "listino_voci_descr"))) > 0 then
//else
//	tab_1.tabpage_1.dw_1.setitem(tab_1.tabpage_1.dw_1.getrow(), "descr", kdwc_1.getitemstring(k_riga, "descr")  )
//end if


end subroutine

public function integer leggi_dwc ();int k_rc=0, k_return = 0
//st_tab_armo kst_tab_armo
datawindowchild  kdwc_1



		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
	
	//--- Attivo dw 
			k_rc = tab_1.tabpage_1.dw_1.getchild("armo_prezzi_v_id_armo_prezzo", kdwc_1)
			if kdwc_1.rowcount() < 2 then
				
//				kst_tab_armo.id_armo = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_armo")
				
				k_rc = kdwc_1.retrieve(kist_tab_armo.id_armo, kist_tab_armo_prezzi_v.id_armo_prezzo)
				k_return = k_rc
				
//				kdwc_1.insertrow(1)

		
			end if
		end if 


return k_return
end function

protected subroutine attiva_tasti_0 ();//
super::attiva_tasti_0()


cb_modifica.enabled = false
cb_cancella.enabled = false


end subroutine

on w_armo_prezzi_v.create
call super::create
end on

on w_armo_prezzi_v.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type st_ritorna from w_g_tab_3`st_ritorna within w_armo_prezzi_v
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_armo_prezzi_v
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_armo_prezzi_v
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_armo_prezzi_v
end type

type st_stampa from w_g_tab_3`st_stampa within w_armo_prezzi_v
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_armo_prezzi_v
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_armo_prezzi_v
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_armo_prezzi_v
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_armo_prezzi_v
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_armo_prezzi_v
end type

event cb_inserisci::clicked;//
//=== 
string k_errore="0"
st_open_w kst_open_w


kst_open_w = ki_st_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.inserimento

//--- controlla se utente autorizzato alla funzione in atto
if sicurezza(kst_open_w) then


//--- solo se faccio 'inserisci' sul primo tabulatore controlla se ho fatto modifiche
	if tab_1.selectedtab = 1 then
		k_errore = left(dati_modif(parent.title), 1)
	end if
	
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
	
	if left(k_errore, 1) = "0" then 
		
		ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
		inserisci()
		u_personalizza_dw ()
		
	end if

end if

post attiva_tasti()



end event

type tab_1 from w_g_tab_3`tab_1 within w_armo_prezzi_v
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
string text = "Costo"
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
integer width = 1207
string dataobject = "d_armo_prezzi_v"
boolean ki_link_standard_sempre_possibile = true
end type

event dw_1::itemchanged;//
long k_riga
st_tab_armo_prezzi_v kst_tab_armo_prezzi_v
datawindowchild kdwc_1

choose case dwo.name 

	case "armo_prezzi_v_id_armo_prezzo" 
		if len(trim(data)) > 0 then 
			kst_tab_armo_prezzi_v.id_armo_prezzo =  long(trim(data))
			post put_video_voce(kst_tab_armo_prezzi_v)
		else
			this.setitem(row, "listino_voci_descr", " " )
		end if

		
end choose 

post attiva_tasti()
	
end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
string text = "elenco"
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
boolean visible = true
boolean enabled = true
string dataobject = "d_armo_prezzi_v_x_id_meca"
end type

event dw_2::itemchanged;call super::itemchanged;//
long k_riga
st_tab_armo_prezzi_v kst_tab_armo_prezzi_v
datawindowchild kdwc_1

choose case dwo.name 

	case "armo_prezzi_v_id_armo_prezzo" 
		if len(trim(data)) > 0 then 
			tab_1.tabpage_2.dw_2.getchild(dwo.name, kdwc_1)
			k_riga = kdwc_1.find( "id_armo_prezzo = " + trim(data) + " " , 1, kdwc_1.rowcount())
			if k_riga > 0 then
				kst_tab_armo_prezzi_v.id_armo_prezzo =  long(trim(data))
				post put_video_voce(kst_tab_armo_prezzi_v)
			else
				tab_1.tabpage_2.dw_2.setitem(row, "listino_voci_descr", " " )
				tab_1.tabpage_2.dw_2.modify( dwo.name + ".Background.Color = '" + string(kkg_colore.ERR_DATO) + "' ") 
			end if
		else
			tab_1.tabpage_2.dw_2.setitem(row, "listino_voci_descr", " " )
		end if

		
end choose 

	
end event

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

