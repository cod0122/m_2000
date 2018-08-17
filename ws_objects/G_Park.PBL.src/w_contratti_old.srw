$PBExportHeader$w_contratti_old.srw
forward
global type w_contratti_old from w_g_tab0
end type
end forward

global type w_contratti_old from w_g_tab0
int Width=2830
int Height=1732
boolean TitleBar=true
string Title="Contratti"
boolean Resizable=false
end type
global w_contratti_old w_contratti_old

forward prototypes
public function string inizializza ()
private function integer modifica ()
private function string check_dati ()
private function string cancella ()
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
long k_codice 
string k_tipo
int k_importa = 0
pointer oldpointer  // Declares a pointer variable





//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


	if len(trim(mid(st_parametri.text, 3, 20))) = 0 then
		k_codice = 0
	else
		k_codice = long(trim(mid(st_parametri.text, 3, 20)))
	end if


	if len(trim(mid(st_parametri.text, 50, 1))) = 0 or &
		isnull(mid(st_parametri.text, 50, 1)) then
		k_tipo = "*"
	else
		k_tipo = trim(mid(st_parametri.text, 50, 1))
	end if


//	dw_dett_0.visible = false


//=== Legge le righe del dw salvate l'ultima volta (importfile)
	if cb_ritorna.enabled = false then  //solo la prima volta il tasto e' false 

		k_importa = kuf1_data_base.dw_importfile(mid(st_parametri.text, 3, 20), dw_lista_0)

	end if
		
	if k_importa <= 0 then // Nessuna importazione eseguita

		if dw_lista_0.retrieve(k_codice, k_tipo) < 1 then
			k_return = "1Nessun Contratto Trovato "

			SetPointer(oldpointer)
			messagebox("Lista Archivio Contratti Vuota", &
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


	k_key = dw_lista_0.getitemstring(dw_lista_0.getrow(), "codice")
	
	k_return = dw_dett_0.retrieve( k_key ) 


return k_return

end function

private function string check_dati ();//
//=== Controllo dati inseriti
string k_return = "0 "
int k_rc=0

if isnull(dw_dett_0.getitemdatetime(dw_dett_0.getrow(), "data")) then 
	k_rc=dw_dett_0.setitem(dw_dett_0.getrow(), "data", today())
end if

k_rc=dw_dett_0.setitem(1, "x_datins", today())
k_rc=dw_dett_0.setitem(1, "x_utente", "Pwd:"+string(kg_pwd, "###"))

return k_return


end function

private function string cancella ();//
string k_return="0 "
string k_descr
string k_codice
string k_errore = "0 ", k_errore1 = "0 "
long k_riga
kuf_contratti  kuf1_contratti


//=== Controllo se sul dettaglio c'e' qualche cosa
k_riga = dw_dett_0.rowcount()	
if k_riga > 0 then
	k_codice = dw_dett_0.getitemstring(1, "codice")
	k_descr = dw_dett_0.getitemstring(1, "descr")
end if
//=== Se sul dw non c'e' nessuna riga o nessun codice allora pesco dalla lista
if k_riga <= 0 or isnull(k_codice) then
	k_riga = dw_lista_0.getrow()	
	if k_riga > 0 then
		k_codice = dw_lista_0.getitemstring(k_riga, "codice")
		k_descr = dw_lista_0.getitemstring(k_riga, "descr")
	end if
end if
if k_riga > 0 and isnull(k_codice) = false then	
	if isnull(k_descr) = true or trim(k_descr) = "" then
		k_descr = "Contratto senza descrizione" 
	end if
	
//=== Richiesta di conferma della eliminazione del rek

	if messagebox("Elimina Contratto", "Sei sicuro di voler Cancellare : ~n~r" + &
				k_codice + " " + trim(k_descr), &
				question!, yesno!, 1) = 1 then
 
//=== Creo l'oggetto che ha la funzione x cancellare la tabella
		kuf1_contratti = create kuf_contratti
		
//=== Cancella la riga dal data windows di lista
		k_errore = kuf1_contratti.tb_delete(k_codice) 
		if left(k_errore, 1) = "0" then

			k_errore = kuf1_data_base.db_commit()
			if left(k_errore, 1) <> "0" then
				messagebox("Problemi durante la Cancellazione !!", &
						"Controllare i dati. " + mid(k_errore, 2))

			else
				
				dw_dett_0.deleterow(k_riga)

			end if

			dw_dett_0.setfocus()

		else
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

//=== Distruggo l'oggetto che ha avuto la funzione x cancellare la tabella
		destroy kuf1_contratti

	else
		messagebox("Elimina Contratto", "Operazione Annullata !!")
	end if

	dw_dett_0.setcolumn(1)

end if

return(k_return)
end function

on w_contratti_old.create
call super::create
end on

on w_contratti_old.destroy
call super::destroy
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

event open;call super::open;int k_rc
datawindowchild  kdwc_clienti_d 
//
////--- Attivo dw archivio Clienti
//	k_rc = dw_lista_0.getchild("rag_soc", kdwc_clienti)
//
//	k_rc = kdwc_clienti.settransobject(sqlca)
//
//	if kdwc_clienti.rowcount() = 0 then
//		kdwc_clienti.retrieve("%")
//		kdwc_clienti.insertrow(1)
//	end if

//--- Attivo dw archivio Clienti
	k_rc = dw_dett_0.getchild("id_clie", kdwc_clienti_d)

	k_rc = kdwc_clienti_d.settransobject(sqlca)

	if kdwc_clienti_d.rowcount() = 0 then
		kdwc_clienti_d.retrieve("%")
		kdwc_clienti_d.insertrow(1)
	end if


end event

type cb_modifica from w_g_tab0`cb_modifica within w_contratti_old
int X=2350
int Y=908
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_contratti_old
int Width=2802
int Height=576
string DataObject="d_contratti_l"
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_contratti_old
int X=2350
int Y=1200
end type

type cb_cancella from w_g_tab0`cb_cancella within w_contratti_old
int X=2350
int Y=1052
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_contratti_old
int X=2350
int Y=768
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_contratti_old
int X=2350
int Y=1348
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_contratti_old
int X=18
int Y=588
int Width=2167
int Height=1032
string DataObject="d_contratti"
end type

event dw_dett_0::clicked;//soppressione codice del padre
end event

type dw_filtro_0 from w_g_tab0`dw_filtro_0 within w_contratti_old
boolean BringToTop=true
end type

type sle_cerca from w_g_tab0`sle_cerca within w_contratti_old
boolean BringToTop=true
end type

type cb_cerca_1 from w_g_tab0`cb_cerca_1 within w_contratti_old
boolean BringToTop=true
end type

