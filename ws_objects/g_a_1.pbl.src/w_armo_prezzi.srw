$PBExportHeader$w_armo_prezzi.srw
forward
global type w_armo_prezzi from w_g_tab_3
end type
end forward

global type w_armo_prezzi from w_g_tab_3
boolean ki_fai_nuovo_dopo_update = false
boolean ki_fai_nuovo_dopo_insert = false
boolean ki_fai_inizializza_dopo_update = true
end type
global w_armo_prezzi w_armo_prezzi

type variables
//
private kuf_armo_prezzi kiuf_armo_prezzi
private int ki_selectedtab=1
end variables

forward prototypes
protected function string inizializza () throws uo_exception
public subroutine leggi_dwc ()
protected subroutine open_start_window ()
protected function string aggiorna ()
protected subroutine inizializza_1 () throws uo_exception
protected function string check_dati ()
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
st_tab_armo_prezzi kst_tab_armo_prezzi
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
		kst_tab_armo_prezzi.id_armo_prezzo = 0
	else
		kst_tab_armo_prezzi.id_armo_prezzo = long(trim(ki_st_open_w.key1))  // id listino voce
	end if


//--- Se inserimento.... 
   if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento then
//		post inserisci()
	else

//--- Se NO inserimento.... 
		k_rc = tab_1.tabpage_1.dw_1.retrieve( kst_tab_armo_prezzi.id_armo_prezzo ) 
		
		choose case k_rc

			case is < 0				
				messagebox("Operazione fallita", &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(ID cercato :" + trim(string(kst_tab_armo_prezzi.id_armo_prezzo)) + ")~n~r" )
				cb_ritorna.postevent(clicked!)

			case 0
	
				tab_1.tabpage_1.dw_1.reset()
				attiva_tasti()

				messagebox("Ricerca fallita", &
						"Mi spiace, il codice Prezzo Riga non e' in archivio ~n~r" + &
					"(ID cercato: " + trim(string(kst_tab_armo_prezzi.id_armo_prezzo)) + ")~n~r" )

				cb_ritorna.triggerevent("clicked!")

			case is > 0		
				attiva_tasti()
		
		end choose

	end if

//--- se inserimento inabilito gli altri TAB, sono inutili
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
	
		tab_1.tabpage_2.enabled = false
		tab_1.tabpage_1.dw_1.setcolumn(1)
		tab_1.tabpage_1.dw_1.setfocus()
	else
		if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
			tab_1.tabpage_1.dw_1.setcolumn("stato")
			tab_1.tabpage_1.dw_1.setfocus()
		end if
	end if

	
//--- se NO inserimento 
	if ki_st_open_w.flag_modalita <> kkg_flag_modalita.inserimento and tab_1.tabpage_1.dw_1.getrow() > 0 then

		tab_1.tabpage_1.dw_1.setredraw(false)

//--- Inabilita campi alla modifica se Vsualizzazione
		kuf1_utility = create kuf_utility 
		if trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.inserimento and trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.modifica then
		
			kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_1.dw_1)

		else		
			
//--- S-protezione campi per riabilitare la modifica 
	      	kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)

		end if
		destroy kuf1_utility
		
	
		tab_1.tabpage_1.dw_1.setredraw(true)
	
	end if
	
//--- legge datawindowchild			
//	leggi_dwc( )
	
end if


return k_return 

end function

public subroutine leggi_dwc ();
end subroutine

protected subroutine open_start_window ();//
int k_rc


	kiuf_armo_prezzi = create kuf_armo_prezzi







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
st_tab_armo_prezzi kst_tab_armo_prezzi
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

		tab_1.tabpage_1.dw_1.setitem(1, "x_datins", kGuf_data_base.prendi_x_datins())
		tab_1.tabpage_1.dw_1.setitem(1, "x_utente", kGuf_data_base.prendi_x_utente())

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
						kst_tab_armo_prezzi.id_armo_prezzo = kiuf_armo_prezzi.get_ultimo_id()	
						tab_1.tabpage_1.dw_1.setitem(1, "id_armo_prezzo", kst_tab_armo_prezzi.id_armo_prezzo)
						tab_1.tabpage_1.dw_1.resetupdate( )
						
					catch (uo_exception kuo_exception)
						kuo_exception.messaggio_utente()
						
					end try
					
				end if

			end if
			
		else
			kguo_sqlca_db_magazzino.db_rollback( )
			k_return="1Fallito aggiornamento archivio '" + tab_1.tabpage_1.text 
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
			k_return="1Fallito aggiornamento archivio '" + tab_1.tabpage_2.text + "' ~n~r" 
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

protected subroutine inizializza_1 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
long k_id_armo_prezzo
string k_scelta, k_id_armo_prezzo_prec
kuf_utility kuf1_utility


ki_selectedtab = 2

k_id_armo_prezzo = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_armo_prezzo")  

//--- Acchiappo il id_armo_prezzo VOCE x evitare la rilettura
if IsNumber(tab_1.tabpage_2.st_2_retrieve.Text) then
	k_id_armo_prezzo_prec = (tab_1.tabpage_2.st_2_retrieve.Text)
else
	k_id_armo_prezzo_prec = " "
end if
//--- Forza valore id_armo_prezzo  per ricordarlo per le prossime richieste
tab_1.tabpage_2.st_2_retrieve.Text=string(k_id_armo_prezzo, "####0")



if tab_1.tabpage_2.st_2_retrieve.text <> k_id_armo_prezzo_prec then

	if tab_1.tabpage_2.dw_2.retrieve(0, k_id_armo_prezzo)  < 1 then
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

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kds_inp = create datastore

//--- Controllo il primo tab
	if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0 then
		kds_inp.dataobject = tab_1.tabpage_1.dw_1.dataobject
		tab_1.tabpage_1.dw_1.rowscopy( 1,tab_1.tabpage_1.dw_1.rowcount( ) ,primary!, kds_inp, 1, primary!)
		kst_esito = kiuf_armo_prezzi.u_check_dati(kds_inp)
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

protected subroutine attiva_tasti_0 ();
super::attiva_tasti_0( )

cb_cancella.enabled = false
cb_inserisci.enabled = false

end subroutine

on w_armo_prezzi.create
call super::create
end on

on w_armo_prezzi.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type st_ritorna from w_g_tab_3`st_ritorna within w_armo_prezzi
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_armo_prezzi
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_armo_prezzi
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_armo_prezzi
end type

type st_stampa from w_g_tab_3`st_stampa within w_armo_prezzi
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_armo_prezzi
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_armo_prezzi
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_armo_prezzi
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_armo_prezzi
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_armo_prezzi
end type

type tab_1 from w_g_tab_3`tab_1 within w_armo_prezzi
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
string text = "Voce"
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
integer width = 1207
string dataobject = "d_armo_prezzi"
end type

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
string text = "Variazioni"
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
boolean visible = true
boolean enabled = true
string dataobject = "d_armo_prezzi_v_x_id_armo_prezzo"
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

