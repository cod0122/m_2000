$PBExportHeader$w_web_utenti.srw
forward
global type w_web_utenti from w_g_tab_3
end type
type ln_1 from line within tabpage_4
end type
end forward

global type w_web_utenti from w_g_tab_3
integer x = 169
integer y = 148
integer width = 2999
integer height = 756
string title = "Utente Web"
boolean ki_fai_nuovo_dopo_update = false
end type
global w_web_utenti w_web_utenti

type variables
//
private kuf_web_utenti kiuf_web_utenti
private kuf_clienti kiuf_clienti
private st_tab_web_utenti kist_tab_web_utenti 
private boolean ki_ricopri_dati=false

end variables

forward prototypes
private subroutine pulizia_righe ()
protected function string aggiorna ()
protected function integer cancella ()
protected function string check_dati ()
private subroutine riempi_id ()
protected function string inizializza ()
protected function integer inserisci ()
protected subroutine open_start_window ()
private subroutine put_video_cliente (st_tab_clienti kst_tab_clienti)
public subroutine set_iniz_dati_cliente (ref st_tab_clienti kst_tab_clienti)
public function boolean get_dati_cliente (ref st_tab_clienti kst_tab_clienti)
protected subroutine leggi_liste ()
private subroutine proteggi_campi ()
public subroutine put_video_login ()
end prototypes

private subroutine pulizia_righe ();//
//--- se mancano alcuni campi pulisco la riga
if len(trim(tab_1.tabpage_1.dw_1.getitemstring(1, "username"))) > 0 or len(trim(tab_1.tabpage_1.dw_1.getitemstring(1, "ragionesociale")))  > 0 then
else
	tab_1.tabpage_1.dw_1.reset( )
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
st_tab_web_utenti kst_tab_web_utenti
boolean k_new_rec
st_esito kst_esito

//=== 
choose case tab_1.selectedtab 

	case 1 

		//=== Aggiorna, se modificato, la TAB_1	
		if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0 then
		
//--- imposto dati utente e data aggiornamento
			tab_1.tabpage_1.dw_1.setitem(1, "x_datins", kGuf_data_base.prendi_x_datins())
			tab_1.tabpage_1.dw_1.setitem(1, "x_utente", kGuf_data_base.prendi_x_utente())

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
							kst_tab_web_utenti.idutente = kiuf_web_utenti.get_ultimo_id()	
							tab_1.tabpage_1.dw_1.setitem(1, "idutente", kst_tab_web_utenti.idutente)
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
st_tab_web_utenti kst_tab_web_utenti
st_esito kst_esito



//=== 
choose case tab_1.selectedtab 
	case 1 

		//=== Controllo se sul dettaglio c'e' qualche cosa
		k_riga = tab_1.tabpage_1.dw_1.rowcount()	
		if k_riga > 0 then
			kst_tab_web_utenti.idutente = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "idutente")
			kst_tab_clienti.codice = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_cliente")
			kst_tab_web_utenti.ragionesociale = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "ragionesociale")
		end if
		
		if k_riga > 0 and kst_tab_web_utenti.idutente > 0 then	
			if isnull(kst_tab_web_utenti.ragionesociale) or len(trim(kst_tab_web_utenti.ragionesociale)) = 0 then
				kst_tab_web_utenti.ragionesociale = "*** senza nome ***" 
			end if
			
//=== Richiesta di conferma della eliminazione del rek
		
			if messagebox("Elimina Utente WEB", "Sei sicuro di voler Cancellare : ~n~r" + &
						string(kst_tab_web_utenti.idutente, "####0") + " associato al Cliente " + string(kst_tab_clienti.codice) &
						+ "~n~rnome: " + trim(kst_tab_web_utenti.ragionesociale), &
						question!, yesno!, 2) = 1 then
		 
			
//=== Cancella la riga dal data windows di lista
				try
					if not kiuf_web_utenti.tb_delete( kst_tab_web_utenti ) then
						
						kst_esito.esito = kkg_esito.no_esecuzione
						kst_esito.sqlerrtext = "Cancellazione Utente " + string(kst_tab_web_utenti.idutente, "####0") + " Non eseguita! "  
						
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

					kst_esito = kguo_sqlca_db_magazzino.db_commit()
					if kst_esito.esito <> kkg_esito.ok then
						k_errore += k_errore + "~n~rErrore anche durante il recupero dell'errore: ~n~r" + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) + "~n~rControllare i dati. "
					end if
						
					messagebox("Problemi durante Cancellazione", k_errore ) 	
		
				end if
		
			else
				k_return = 2
				messagebox("Elimina Utente Web", "Operazione Annullata !!")
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
st_tab_web_utenti kst_tab_web_utenti
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then

	choose case tab_1.selectedtab 
		case  1 
			
	//--- controllo se USERNAME già assegnato		
				try
					kst_tab_web_utenti.idutente = tab_1.tabpage_1.dw_1.getitemnumber(1, "idutente")
					kst_tab_web_utenti.username = tab_1.tabpage_1.dw_1.getitemstring(1, "username")
					if kiuf_web_utenti.if_esiste_username( kst_tab_web_utenti) then
						k_return = tab_1.tabpage_1.text + ": 'Login' gia' assegnato ad altro Utente " 
						k_errore = "1"
						k_nr_errori++
					end if
					
				catch (uo_exception kuo_exception)
					kst_esito = kuo_exception.get_st_esito()
					if kst_esito.esito = kkg_esito.ok then
						if kst_tab_web_utenti.idutente > 0 then
							k_return = tab_1.tabpage_1.text + ": Errore durante controllo del 'Login' " + trim(kst_esito.sqlerrtext )
							k_errore = "4"
							k_nr_errori++
						end if
					end if	
				end try
			
	//--- controllo se sono stati caricati Utenti collegati al Cliente
			if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
	
				if tab_1.tabpage_1.dw_1.rowcount() > 0 then
					try
						kst_tab_web_utenti.idcliente = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente")
						kst_tab_web_utenti.idutente = kiuf_web_utenti.get_ultimo_cliente(kst_tab_web_utenti)
					catch (uo_exception kuo1_exception)
						kst_esito = kuo1_exception.get_st_esito()
					end try
					if kst_esito.esito = kkg_esito.ok then
						if kst_tab_web_utenti.idutente > 0 then
							k_return = tab_1.tabpage_1.text + ": Utente gia' associato al cliente " + string(kst_tab_web_utenti.idcliente ) 
							k_errore = "4"
							k_nr_errori++
						end if
					end if	
				end if	
			end if
	//		if k_errore = "4" or k_errore = "0" then 
	//			if tab_1.tabpage_1.dw_1.getitemstring( 1, "stato") = kiuf_web_utenti.kki_STATO_accettato then
	//				k_errore = "4"
	//				k_nr_errori++
	//				k_return = tab_1.tabpage_1.text + ": Lo Stato 'ACCETTATO' rende il documento IMMODIFICABILE, controlla meglio.  "
	//			end if
	//		end if
	
	
	end choose

end if

return trim(k_errore) + k_return


end function

private subroutine riempi_id ();//
//
long k_ctr = 0
st_tab_web_utenti kst_tab_web_utenti



	k_ctr = tab_1.tabpage_1.dw_1.getrow()
	
	if k_ctr > 0 then
	
		kst_tab_web_utenti.idutente = tab_1.tabpage_1.dw_1.getitemnumber(k_ctr, "idutente")
	
//=== Se non sono in caricamento allora prelevo l'ID dalla dw
		if tab_1.tabpage_1.dw_1.getitemstatus(k_ctr, 0, primary!) <> newmodified! then
			kst_tab_web_utenti.idutente = tab_1.tabpage_1.dw_1.getitemnumber(k_ctr, "idutente")
		end if
	
		if isnull(kst_tab_web_utenti.idutente) or kst_tab_web_utenti.idutente = 0 then				
			tab_1.tabpage_1.dw_1.setitem(k_ctr, "idutente", 0)
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
//st_tab_web_utenti kst_tab_web_utenti
st_esito kst_esito
kuf_utility kuf1_utility
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
		k_rc = tab_1.tabpage_1.dw_1.retrieve( kist_tab_web_utenti.idutente ) 
		
		choose case k_rc

			case is < 0				
				messagebox("Operazione fallita", &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(ID Utente Web cercato:" + trim(string(kist_tab_web_utenti.idutente)) + ")~n~r" )
				cb_ritorna.postevent(clicked!)

			case 0
	
				tab_1.tabpage_1.dw_1.reset()
				attiva_tasti()

				messagebox("Ricerca fallita", &
						"Mi spiace, il codice 'Utente Web' non e' in archivio ~n~r" + &
					"(ID cercato: "  &
					 + trim(string(kist_tab_web_utenti.idutente)) + ")~n~r" )

				cb_ritorna.triggerevent("clicked!")

			case is > 0		
				if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
					
//--- legge tutte le DWC			
					leggi_liste()			
					
				end if	
				attiva_tasti()
		
		end choose

	end if

//--- protegge/sprotegge campi
	proteggi_campi()


//--- flag x sostituire i dati provenienti dal cliente	
	ki_ricopri_dati = false

//--- se inserimento inabilito gli altri TAB, sono inutili
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
		ki_ricopri_dati = true
	
		tab_1.tabpage_1.dw_1.setcolumn("cliente_nome")
		tab_1.tabpage_1.dw_1.setfocus()
	else
		if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
			tab_1.tabpage_1.dw_1.setcolumn("username")
			tab_1.tabpage_1.dw_1.setfocus()
		end if
	end if
	

	
	
end if


return k_return 

end function

protected function integer inserisci ();//
int k_return=1, k_ctr, k_rc
string k_errore="0 ", k_rcx
//date k_data
long k_riga 
string k_record_base
//int k_taborder
//string k_rc1, k_style
st_tab_web_utenti kst_tab_web_utenti
st_tab_clienti kst_tab_clienti
st_tab_clie_settori kst_tab_clie_settori

kuf_ausiliari kuf1_ausiliari
//window kw_window
kuf_base kuf1_base
kuf_utility kuf1_utility
datawindowchild Kdwc_clie_des, kdwc_clie_cod, Kdwc_nazione, kdwc_id_web_ruolo


//=== Controllo se ho modificato dei dati nella DW DETTAGLIO
//if left(dati_modif(""), 1) = "1" then //Richisto Aggiornamento

//=== Controllo congruenza dei dati caricati e Aggiornamento  
//=== Ritorna 1 char : 0=tutto OK; 1=errore grave;
//===                : 2=errore non grave dati aggiornati;
//===			         : 3=LIBERO
//===      il resto della stringa contiene la descrizione dell'errore   
//	k_errore = aggiorna_dati()

//end if


if LeftA(k_errore, 1) = "0" then


//=== Aggiunge una riga al data windows
	choose case tab_1.selectedtab 
		case  1 

			try
	
			
//--- legge tutte le DWC			
				leggi_liste()			
				
				if tab_1.tabpage_1.dw_1.rowcount() > 0 then
					
					k_riga = 1
				
					tab_1.tabpage_1.dw_1.reset() 
					
				end if
				
				tab_1.tabpage_1.dw_1.insertrow(0)
				
				ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
	
			
//--- popolo campi cliente se passato come argomento
				if kist_tab_web_utenti.idcliente > 0 then
					kst_tab_web_utenti.idcliente = kist_tab_web_utenti.idcliente 
					
					k_rc = tab_1.tabpage_1.dw_1.getchild("cliente_nome", Kdwc_clie_des)
	
					get_dati_cliente(kst_tab_clienti)
					put_video_cliente(kst_tab_clienti)
					
				end if

//--- piglia i dati di default 
				kiuf_web_utenti.if_isnull( kst_tab_web_utenti )
	
				tab_1.tabpage_1.dw_1.setitem(1, "stato", kst_tab_web_utenti.stato)
				tab_1.tabpage_1.dw_1.setitem(1, "statoweb", kst_tab_web_utenti.statoweb)
	

//--- legge dwc id_web_ruolo 
				if kst_tab_web_utenti.id_web_ruolo > 0 then
					k_rc = tab_1.tabpage_1.dw_1.setitem(1, "id_web_ruolo", kst_tab_web_utenti.id_web_ruolo  )
				else
					k_rc = tab_1.tabpage_1.dw_1.setitem(1, "id_web_ruolo", 0 )
					k_rc = tab_1.tabpage_1.dw_1.getchild("id_web_ruolo", Kdwc_id_web_ruolo)
					Kdwc_id_web_ruolo.retrieve()
					if Kdwc_id_web_ruolo.rowcount( ) > 0 then
						k_rc = tab_1.tabpage_1.dw_1.setitem(1, "id_web_ruolo", Kdwc_id_web_ruolo.getitemnumber(1, "id_web_ruolo"))
					end if
				end if
//--- legge dwc nazione 
				if len(trim(kst_tab_web_utenti.nazione )) > 0 then
					k_rc = tab_1.tabpage_1.dw_1.setitem(1, "nazione", kst_tab_web_utenti.nazione  )
				else
					k_rc = tab_1.tabpage_1.dw_1.setitem(1, "nazione", "" )
					k_rc = tab_1.tabpage_1.dw_1.getchild("nazione", Kdwc_nazione)
					Kdwc_nazione.retrieve()
					if Kdwc_nazione.rowcount( ) > 0 then
						k_rc = tab_1.tabpage_1.dw_1.setitem(1, "nazione", trim(Kdwc_nazione.getitemstring(1, "id_nazione")) )
					end if
				end if
				

//--- S-protezione campi per abilitare l'inserimento
				kuf1_utility = create kuf_utility
				kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)
				destroy kuf1_utility
		
//				tab_1.tabpage_1.dw_1.resetupdate( )
				tab_1.tabpage_1.dw_1.SetItemStatus( 1, 0, Primary!, NotModified!)

			
			
			catch (uo_exception kuo_exception)
				kuo_exception.messaggio_utente()
				
			end try
			
			
		case 2 

			
	end choose	

	attiva_tasti()

	k_return = 0

end if

return (k_return)



end function

protected subroutine open_start_window ();//
int k_rc
datawindowchild  kdwc_clienti_des, kdwc_clienti, kdwc_id_web_ruolo, kdwc_nazione

//	tab_1.tabpage_1.dw_1.object.b_cliente.filename = kGuo_path.get_risorse() + kkg_risorsa_elenco 

	kiuf_web_utenti = create kuf_web_utenti
	kiuf_clienti = create kuf_clienti

//--- Acquisisce i dati da passati in Argomento
	if not isnumber(trim(ki_st_open_w.key1)) then
		kist_tab_web_utenti.idutente = 0
	else
		kist_tab_web_utenti.idutente = long(trim(ki_st_open_w.key1))
	end if
	if not isnumber(trim(ki_st_open_w.key2)) then
		kist_tab_web_utenti.idcliente = 0
	else
		kist_tab_web_utenti.idcliente = long(trim(ki_st_open_w.key2))
	end if


//--- Attivo dw archivio Clienti
	k_rc = tab_1.tabpage_1.dw_1.getchild("id_cliente", kdwc_clienti)
	k_rc = kdwc_clienti.settransobject(sqlca)
	k_rc = kdwc_clienti.insertrow(1)

	k_rc = tab_1.tabpage_1.dw_1.getchild("cliente_nome", kdwc_clienti_des)
	k_rc = kdwc_clienti_des.settransobject(sqlca)
	k_rc = kdwc_clienti_des.insertrow(1)

	if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
		if kdwc_clienti.rowcount() < 2 then
			kdwc_clienti.retrieve("%")
			kdwc_clienti.RowsCopy(kdwc_clienti.GetRow(), kdwc_clienti.RowCount(), Primary!, kdwc_clienti_des, 1, Primary!)
			kdwc_clienti.setsort( "id_cliente A")
			kdwc_clienti.sort( )
			k_rc = kdwc_clienti.insertrow(1)
			k_rc = kdwc_clienti_des.insertrow(1)
		end if
	end if
//	kdwc_clienti.RowsCopy(kdwc_clienti.GetRow(), kdwc_clienti.RowCount(), Primary!, kdwc_clienti_des, 1, Primary!)

//--- Attivo dw vari
	k_rc = tab_1.tabpage_1.dw_1.getchild("id_web_ruolo", kdwc_id_web_ruolo)
	k_rc = kdwc_id_web_ruolo.settransobject(sqlca)
	k_rc = kdwc_id_web_ruolo.insertrow(1)

	k_rc = tab_1.tabpage_1.dw_1.getchild("nazione", kdwc_nazione)
	k_rc = kdwc_nazione.settransobject(sqlca)
	k_rc = kdwc_nazione.insertrow(1)

	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
		tab_1.tabpage_1.dw_1.object.b_copia.visible = true
		tab_1.tabpage_1.dw_1.object.b_login.visible = true
	else
		tab_1.tabpage_1.dw_1.object.b_copia.visible = false
		tab_1.tabpage_1.dw_1.object.b_login.visible = false
	end if
end subroutine

private subroutine put_video_cliente (st_tab_clienti kst_tab_clienti);//
//--- Visualizza dati Cliente 
//
long k_riga=0
st_esito kst_esito
datawindowchild kdwc_1



tab_1.tabpage_1.dw_1.modify( "id_cliente.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
tab_1.tabpage_1.dw_1.modify( "cliente_nome.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 

tab_1.tabpage_1.dw_1.setitem( 1, "id_cliente", kst_tab_clienti.codice)
tab_1.tabpage_1.dw_1.setitem( 1, "cliente_nome", kst_tab_clienti.rag_soc_10 )

if ki_ricopri_dati then

	tab_1.tabpage_1.dw_1.setitem( 1, "ragionesociale", kst_tab_clienti.rag_soc_10 )
	tab_1.tabpage_1.dw_1.setitem( 1, "indirizzo", kst_tab_clienti.indi_1 )
	tab_1.tabpage_1.dw_1.setitem( 1, "cap", kst_tab_clienti.cap_1 )
	tab_1.tabpage_1.dw_1.setitem( 1, "localita", kst_tab_clienti.loc_1 )
	tab_1.tabpage_1.dw_1.setitem( 1, "provincia", trim(kst_tab_clienti.prov_1) )
	tab_1.tabpage_1.dw_1.setitem( 1, "nazione", kst_tab_clienti.id_nazione_1 )
	tab_1.tabpage_1.dw_1.setitem( 1, "email", kst_tab_clienti.kst_tab_clienti_web.email )
	tab_1.tabpage_1.dw_1.setitem( 1, "email1", kst_tab_clienti.kst_tab_clienti_web.email1 )
	tab_1.tabpage_1.dw_1.setitem( 1, "email2", kst_tab_clienti.kst_tab_clienti_web.email2 )

//else
//
//	if isnull(tab_1.tabpage_1.dw_1.getitemstring( 1, "ragionesociale")) or len(trim(tab_1.tabpage_1.dw_1.getitemstring( 1, "ragionesociale") )) = 0 then
//		tab_1.tabpage_1.dw_1.setitem( 1, "ragionesociale", kst_tab_clienti.rag_soc_10 )
//	end if
//	if isnull(tab_1.tabpage_1.dw_1.getitemstring( 1, "indirizzo")) or len(trim(tab_1.tabpage_1.dw_1.getitemstring( 1, "indirizzo"))) = 0 then
//		tab_1.tabpage_1.dw_1.setitem( 1, "indirizzo", kst_tab_clienti.indi_1 )
//	end if
//	if isnull(tab_1.tabpage_1.dw_1.getitemstring( 1, "cap")) or len(trim(tab_1.tabpage_1.dw_1.getitemstring( 1, "cap"))) = 0 then
//		tab_1.tabpage_1.dw_1.setitem( 1, "cap", kst_tab_clienti.cap_1 )
//	end if
//	if isnull(tab_1.tabpage_1.dw_1.getitemstring( 1, "localita")) or len(trim(tab_1.tabpage_1.dw_1.getitemstring( 1, "localita"))) = 0 then
//		tab_1.tabpage_1.dw_1.setitem( 1, "localita", kst_tab_clienti.loc_1 )
//	end if
//	if isnull(tab_1.tabpage_1.dw_1.getitemstring( 1, "provincia")) or len(trim(tab_1.tabpage_1.dw_1.getitemstring( 1, "provincia"))) = 0 then
//		tab_1.tabpage_1.dw_1.setitem( 1, "provincia", trim(kst_tab_clienti.prov_1) )
//	end if
//	if isnull(tab_1.tabpage_1.dw_1.getitemstring( 1, "nazione")) or len(trim(tab_1.tabpage_1.dw_1.getitemstring( 1, "nazione"))) = 0 then
//		tab_1.tabpage_1.dw_1.setitem( 1, "nazione", kst_tab_clienti.id_nazione_1 )
//	end if
//	if isnull(tab_1.tabpage_1.dw_1.getitemstring( 1, "email")) or len(trim(tab_1.tabpage_1.dw_1.getitemstring( 1, "email"))) = 0 then
//		tab_1.tabpage_1.dw_1.setitem( 1, "email", kst_tab_clienti.kst_tab_clienti_web.email )
//	end if
//	if isnull(tab_1.tabpage_1.dw_1.getitemstring( 1, "email1")) or len(trim(tab_1.tabpage_1.dw_1.getitemstring( 1, "email1"))) = 0 then
//		tab_1.tabpage_1.dw_1.setitem( 1, "email1", kst_tab_clienti.kst_tab_clienti_web.email1 )
//	end if
//	if isnull(tab_1.tabpage_1.dw_1.getitemstring( 1, "email2")) or len(trim(tab_1.tabpage_1.dw_1.getitemstring( 1, "email2"))) = 0 then
//		tab_1.tabpage_1.dw_1.setitem( 1, "email2", kst_tab_clienti.kst_tab_clienti_web.email2 )
//	end if

end if

//attiva_tasti()


end subroutine

public subroutine set_iniz_dati_cliente (ref st_tab_clienti kst_tab_clienti);//			
	kst_tab_clienti.codice = 0
	kst_tab_clienti.rag_soc_10 = " "
	kst_tab_clienti.p_iva = " "
	kst_tab_clienti.cf = " "
	kst_tab_clienti.id_nazione_1 = " "
	kst_tab_clienti.cadenza_fattura = " "
	kst_tab_clienti.loc_1 = " "
	kst_tab_clienti.prov_1 = " "
	kst_tab_clienti.kst_tab_ind_comm.rag_soc_1_c  = " "
	kst_tab_clienti.kst_tab_ind_comm.rag_soc_2_c  = " "
	kst_tab_clienti.kst_tab_ind_comm.indi_c  = " "
	kst_tab_clienti.kst_tab_ind_comm.cap_c  = " "
	kst_tab_clienti.kst_tab_ind_comm.loc_c  = " "
	kst_tab_clienti.kst_tab_ind_comm.prov_c  = " "
	kst_tab_clienti.kst_tab_clienti_fatt.fattura_da  = " "
	kst_tab_clienti.iva  = 0
	kst_tab_clienti.kst_tab_clienti_fatt.note_1 = " "
	kst_tab_clienti.kst_tab_clienti_fatt.note_2 = " "

//	tab_1.tabpage_1.dw_1.setitem( 1, "ragionesociale", "" )
//	tab_1.tabpage_1.dw_1.setitem( 1, "indirizzo", "" )
//	tab_1.tabpage_1.dw_1.setitem( 1, "cap", "" )
//	tab_1.tabpage_1.dw_1.setitem( 1, "localita", "" )
//	tab_1.tabpage_1.dw_1.setitem( 1, "provincia", "" )
//	tab_1.tabpage_1.dw_1.setitem( 1, "nazione", "" )
//	tab_1.tabpage_1.dw_1.setitem( 1, "email", "" )
//	tab_1.tabpage_1.dw_1.setitem( 1, "email1", "" )
//	tab_1.tabpage_1.dw_1.setitem( 1, "email2", "" )
//
//	tab_1.tabpage_1.dw_1.setitem( 1, "username", "" )
//	tab_1.tabpage_1.dw_1.setitem( 1, "password", "" )

end subroutine

public function boolean get_dati_cliente (ref st_tab_clienti kst_tab_clienti);//
boolean k_return = false
st_esito kst_esito
//kuf_clienti kuf1_clienti


try
	
//	kuf1_clienti = create kuf_clienti

	if kiuf_clienti.leggi (kst_tab_clienti) then
		kst_tab_clienti.kst_tab_clienti_web.id_cliente = kst_tab_clienti.codice
		
		k_return = kiuf_clienti.leggi (kst_tab_clienti.kst_tab_clienti_web)
		
	end if

	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	

finally
//	destroy kuf1_clienti
	
end try

return k_return


end function

protected subroutine leggi_liste ();//
int k_rc
datawindowchild  kdwc_clienti_des, kdwc_clienti, kdwc_id_web_ruolo, kdwc_nazione

//--- Attivo dw archivio Clienti
//	k_rc = tab_1.tabpage_1.dw_1.getchild("id_cliente", kdwc_clienti)
//	k_rc = kdwc_clienti.settransobject(sqlca)
//	k_rc = kdwc_clienti.retrieve("%")
//	k_rc = kdwc_clienti.insertrow(1)
//	kdwc_clienti_des.setsort( "id_cliente asc")
//	kdwc_clienti_des.sort( )

	k_rc = tab_1.tabpage_1.dw_1.getchild("cliente_nome", kdwc_clienti_des)
	k_rc = kdwc_clienti_des.settransobject(sqlca)
	k_rc = kdwc_clienti_des.retrieve("%")
	k_rc = kdwc_clienti_des.insertrow(1)

//	kdwc_clienti.RowsCopy(kdwc_clienti.GetRow(), kdwc_clienti.RowCount(), Primary!, kdwc_clienti_des, 1, Primary!)
//	kdwc_clienti_des.setsort( "rag_soc_1 asc")
	kdwc_clienti_des.sort( )

//--- Attivo dw elenco Descrizioni  già usati
	k_rc = tab_1.tabpage_1.dw_1.getchild("id_web_ruolo", kdwc_id_web_ruolo)
	k_rc = kdwc_id_web_ruolo.settransobject(sqlca)
	k_rc = kdwc_id_web_ruolo.retrieve()
	k_rc = kdwc_id_web_ruolo.insertrow(1)
//--- 
	k_rc = tab_1.tabpage_1.dw_1.getchild("nazione", kdwc_nazione)
	k_rc = kdwc_nazione.settransobject(sqlca)
	k_rc = kdwc_nazione.retrieve()
	k_rc = kdwc_nazione.insertrow(1)


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

			kuf1_utility.u_proteggi_dw("1", "idutente", tab_1.tabpage_1.dw_1)
	
		else		
			
//--- S-protezione campi per riabilitare la modifica a parte la chiave
	      	kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)

//--- Inabilita campo ID alla modifica se Funzione MODIFICA
			if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
	
//--- protegge i campi chiave
				kuf1_utility.u_proteggi_dw("1", "idutente", tab_1.tabpage_1.dw_1)
			end if
		end if
		destroy kuf1_utility
		
	
		tab_1.tabpage_1.dw_1.setredraw(true)
	
	end if


end subroutine

public subroutine put_video_login ();//
st_tab_web_utenti kst_tab_web_utenti
kuf_utility kuf1_utility


kuf1_utility = create kuf_utility

kst_tab_web_utenti.ragionesociale = tab_1.tabpage_1.dw_1.getitemstring( 1, "cliente_nome")
kst_tab_web_utenti.idcliente = tab_1.tabpage_1.dw_1.getitemnumber( 1, "id_cliente")


if ki_ricopri_dati then

	kst_tab_web_utenti.ragionesociale = kuf1_utility.u_stringa_compatta(kst_tab_web_utenti.ragionesociale)
	kst_tab_web_utenti.username = kuf1_utility.u_replace( upper(left(kst_tab_web_utenti.ragionesociale,1)) + lower(mid(kst_tab_web_utenti.ragionesociale,2,4)), " ", "_") + trim(string(kst_tab_web_utenti.idcliente))
	tab_1.tabpage_1.dw_1.setitem( 1, "username", kst_tab_web_utenti.username )
	
	kst_tab_web_utenti.password = kst_tab_web_utenti.username + string(kst_tab_web_utenti.idcliente, "00000") + string(year(kg_dataoggi))
	tab_1.tabpage_1.dw_1.setitem( 1, "password", kst_tab_web_utenti.password )
	
//else
//
//	if isnull(kst_tab_web_utenti.username ) or len(trim(kst_tab_web_utenti.username)) = 0 then 
//		kst_tab_web_utenti.username = kuf1_utility.u_replace( upper(left(kst_tab_web_utenti.ragionesociale,1)) + lower(mid(kst_tab_web_utenti.ragionesociale,2,7)), " ", "_")
//		tab_1.tabpage_1.dw_1.setitem( 1, "username", kst_tab_web_utenti.username )
//	end if
//	if isnull(kst_tab_web_utenti.password ) or len(trim(kst_tab_web_utenti.password)) = 0 then 
//		kst_tab_web_utenti.password = kst_tab_web_utenti.username + string(kst_tab_web_utenti.idcliente, "00000") + string(year(kg_dataoggi))
//		tab_1.tabpage_1.dw_1.setitem( 1, "password", kst_tab_web_utenti.password )
//	end if
end if

destroy kuf1_utility


end subroutine

on w_web_utenti.create
int iCurrent
call super::create
end on

on w_web_utenti.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;//
if isvalid(kiuf_web_utenti) then destroy 	kiuf_web_utenti
if isvalid(kiuf_clienti) then destroy 	kiuf_clienti



end event

type st_ritorna from w_g_tab_3`st_ritorna within w_web_utenti
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_web_utenti
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_web_utenti
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_web_utenti
integer x = 2711
integer y = 1468
end type

type st_stampa from w_g_tab_3`st_stampa within w_web_utenti
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_web_utenti
integer x = 1179
integer y = 1472
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_web_utenti
integer x = 645
integer y = 1468
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_web_utenti
integer x = 1970
integer y = 1468
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_web_utenti
integer x = 2341
integer y = 1468
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_web_utenti
integer x = 1600
integer y = 1468
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

type tab_1 from w_g_tab_3`tab_1 within w_web_utenti
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
string text = "Utente WEB"
string picturename = "Window!"
long picturemaskcolor = 553648127
string powertiptext = "Anagrafica listino"
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
integer y = 36
integer width = 3013
integer height = 1236
string dataobject = "d_web_utenti"
boolean minbox = true
boolean maxbox = true
boolean hsplitscroll = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_cerca = false
end type

event dw_1::itemchanged;//
date k_data
string k_codice
string k_des
int k_errore=0
long k_riga, k_rc
st_esito kst_esito
st_tab_contratti k_st_tab_contratti
st_tab_clienti kst_tab_clienti
st_tab_web_utenti kst_tab_web_utenti
kuf_contratti kuf1_contratti
datawindowchild kdwc_1, kdwc_x, kdwc_x_des



choose case 	lower(dwo.name)

	case "cliente_nome" 
		if len(trim(data)) > 0 then 
			tab_1.tabpage_1.dw_1.getchild(dwo.name, kdwc_1)
			k_riga = kdwc_1.find( "rag_soc_1 like '" + trim(data) + "%" +"'" , 1, kdwc_1.rowcount())
			if k_riga > 0 then
				kst_tab_clienti.codice = kdwc_1.getitemnumber( k_riga, "id_cliente")
				get_dati_cliente(kst_tab_clienti)
				post put_video_cliente(kst_tab_clienti)
				post put_video_login()
			else
				tab_1.tabpage_1.dw_1.object.id_cliente[1] = 0
				tab_1.tabpage_1.dw_1.modify( dwo.name + ".Background.Color = '" + string(kkg_colore.ERR_DATO) + "' ") 
			end if
		else
			set_iniz_dati_cliente(kst_tab_clienti)
			post put_video_cliente(kst_tab_clienti)
			post put_video_login()
		end if

	case "id_cliente" 
		if len(trim(data)) > 0 then 
			tab_1.tabpage_1.dw_1.getchild( "cliente_nome" , kdwc_1)
			k_riga = kdwc_1.find( "id_cliente = " + trim(data) + " " , 1, kdwc_1.rowcount())
			if k_riga > 0 then
				kst_tab_clienti.codice = long(trim(data))
				get_dati_cliente(kst_tab_clienti)
				post put_video_cliente(kst_tab_clienti)
				post put_video_login()
			else
				tab_1.tabpage_1.dw_1.modify( dwo.name + ".Background.Color = '" + string(kkg_colore.ERR_DATO) + "' ") 
			end if
		else
			set_iniz_dati_cliente(kst_tab_clienti)
			post put_video_cliente(kst_tab_clienti)
			post put_video_login()
		end if


	case "id_web_ruolo" 
		if Len(trim(data)) > 0 then
			k_codice = RightTrim(data)
			k_rc = this.getchild("id_web_ruolo", kdwc_x)
			k_riga = kdwc_x.find("id_web_ruolo = "+ trim(k_codice)+" ",0,kdwc_x.rowcount())
			if k_riga <= 0 or isnull(k_riga) then
				k_errore = 2
				this.setitem(row, "descr_it", " - NON TROVATO -")
			else
				this.setitem(row, "descr_it", kdwc_x.getitemstring(k_riga, "descr_it"))
			end if
		else
			this.setitem(row, "web_ruoli_descr_it", "")
			this.setitem(row, "id_web_ruolo", "")
		end if


	case "nazione" 
		if Len(trim(data)) > 0 then
			k_codice = RightTrim(data)
			k_rc = this.getchild("nazione", kdwc_x)
			k_riga = kdwc_x.find("id_nazione = '"+ trim(k_codice)+"' ",0,kdwc_x.rowcount())
			if k_riga <= 0 or isnull(k_riga) then
				k_errore = 2
				this.setitem(row, "nazioni_nome", " - NON TROVATO -")
			else
				this.setitem(row, "nazioni_nome", kdwc_x.getitemstring(k_riga, "nome"))
			end if
		else
			this.setitem(row, "nazioni_nome", "")
			this.setitem(row, "nazione", 0)
		end if

			
end choose 

if k_errore = 0 then
	attiva_tasti()
end if

return k_errore
	
end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;//
int k_rc
datawindowchild  kdwc_x,  kdwc_x_des 


choose case dwo.name


	//--- Attivo dw archivio CLIENTI
	case "cliente_nome", "id_cliente"
		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
			k_rc = this.getchild("id_cliente", kdwc_x)
			if kdwc_x.rowcount() < 2 then
				kdwc_x.retrieve("%")
				k_rc = this.getchild("cliente_nome", kdwc_x_des)
				kdwc_x.RowsCopy(kdwc_x.GetRow(), kdwc_x.RowCount(), Primary!, kdwc_x_des, 1, Primary!)
				kdwc_x.setsort( "id_cliente A")
				kdwc_x.sort( )
				k_rc = kdwc_x.insertrow(1)
				k_rc = kdwc_x_des.insertrow(1)
			end if	
		end if
		

	case "id_web_ruolo", "nazione"
		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
	
	//--- Attivo dw diversi archivi 
			k_rc = this.getchild(dwo.name, kdwc_x)
			if kdwc_x.rowcount() < 2 then
				kdwc_x.retrieve()
				k_rc = kdwc_x.insertrow(1)
			end if
		end if 

		
end choose


end event

event dw_1::buttonclicked;call super::buttonclicked;//
boolean k_ricopri_dati
 st_tab_clienti kst_tab_clienti
 

if dwo.name = "b_copia" then
	
	if this.getitemnumber( 1, "id_cliente") > 0 then
	
		k_ricopri_dati = ki_ricopri_dati
		ki_ricopri_dati = true
		kst_tab_clienti.codice = this.getitemnumber( 1, "id_cliente")
		get_dati_cliente(kst_tab_clienti)
		put_video_cliente (kst_tab_clienti )
		
		ki_ricopri_dati = k_ricopri_dati
		
	end if
	
end if

if dwo.name = "b_login" then
	
		k_ricopri_dati = ki_ricopri_dati
		ki_ricopri_dati = true
		put_video_login()
		
		ki_ricopri_dati = k_ricopri_dati

end if
end event

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
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_attiva_standard_select_row = false
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
end type

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
integer width = 3035
integer height = 1256
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
end type

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
integer width = 3035
integer height = 1256
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
integer width = 3035
integer height = 1256
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
end type

type st_duplica from w_g_tab_3`st_duplica within w_web_utenti
end type

type ln_1 from line within tabpage_4
integer linethickness = 4
integer beginx = 361
integer beginy = 2376
integer endx = 2674
integer endy = 2376
end type

