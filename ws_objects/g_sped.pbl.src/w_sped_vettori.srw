$PBExportHeader$w_sped_vettori.srw
forward
global type w_sped_vettori from w_g_tab0
end type
end forward

global type w_sped_vettori from w_g_tab0
integer width = 3634
integer height = 2100
string title = "Vettori di Spedizione"
end type
global w_sped_vettori w_sped_vettori

type variables
//
private string ki_mostra_nascondi_in_lista = "S"
end variables

forward prototypes
public function string inizializza ()
private function string cancella ()
protected function integer check_rek (string k_codice)
private function integer visualizza ()
protected function string check_dati ()
protected function integer modifica ()
protected function integer inserisci ()
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
string k_return="0 ", k_key = " "
long k_codice 
string k_mc_co
int k_importa = 0
pointer oldpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


	if LenA(trim(ki_st_open_w.key1)) = 0 then
		k_codice = 0
	else
		k_codice = long(trim(ki_st_open_w.key1))
	end if


	if LenA(trim(ki_st_open_w.key2)) = 0 or &
		isnull(trim(ki_st_open_w.key2)) then
		k_mc_co = "*"
	else
		k_mc_co = trim(ki_st_open_w.key2)
	end if


//	dw_dett_0.visible = false


//=== Legge le righe del dw salvate l'ultima volta (importfile)
	if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima volta il tasto e' false 

		k_importa = kGuf_data_base.dw_importfile(trim(ki_syntaxquery), dw_lista_0)

	end if
		
	if k_importa <= 0 then // Nessuna importazione eseguita

		if dw_lista_0.retrieve(k_codice, k_mc_co) < 1 then
			k_return = "1Nessun Contratto Trovato "

			SetPointer(oldpointer)
			messagebox("Lista Archivio Contratti Vuota", &
					"Nessun Codice Trovato per la richiesta fatta")
		end if

	end if		



return k_return



end function

private function string cancella ();//
string k_return="0 "
string k_descr
long k_codice
string k_errore = "0 ", k_errore1 = "0 "
long k_riga
st_esito kst_esito
st_tab_sped_vettori kst_tab_sped_vettori
kuf_sped_vettori  kuf1_sped_vettori


//=== Controllo se sul dettaglio c'e' qualche cosa
k_riga = dw_dett_0.rowcount()	
if k_riga > 0 then
	k_codice = dw_dett_0.getitemnumber(1, "id")
	k_descr = dw_dett_0.getitemstring(1, "rag_soc_1")
end if
//=== Se sul dw non c'e' nessuna riga o nessun codice allora pesco dalla lista
if k_riga <= 0 or isnull(k_codice) then
	k_riga = dw_lista_0.getrow()	
	if k_riga > 0 then
		k_codice = dw_lista_0.getitemnumber(k_riga, "id")
		k_descr = dw_lista_0.getitemstring(k_riga, "rag_soc_1")
	end if
end if

if isnull(k_descr) = true or trim(k_descr) = "" then
	k_descr = "Nessuna denominazione" 
end if

if k_riga > 0 and isnull(k_codice) = false then	
	
//=== Richiesta di conferma della eliminazione del rek

	if messagebox("Elimina Vettore", "Sei sicuro di voler Cancellare il~n~r" + &
				"Vettore " + string(k_codice, "####0") + "~n~r" + trim(k_descr), &
				question!, yesno!, 2) = 1 then
 
//=== Creo l'oggetto che ha la funzione x cancellare la tabella
		kuf1_sped_vettori = create kuf_sped_vettori
		
//=== Cancella la riga dal data windows di lista
      kst_tab_sped_vettori.id = k_codice
		kst_esito = kuf1_sped_vettori.tb_delete(kst_tab_sped_vettori) 
		if kst_esito.esito = "0" then

			k_errore = kGuf_data_base.db_commit()
			if LeftA(k_errore, 1) <> "0" then
				messagebox("Problemi durante la Cancellazione !!", &
						"Controllare i dati. " + MidA(k_errore, 2))

			else

//--- cancello riga a video
				k_codice = 0
				k_riga = dw_dett_0.rowcount()	
				if k_riga > 0 then
					k_codice = dw_dett_0.getitemnumber(1, "codice")
					dw_dett_0.deleterow(k_riga)
				end if
				if k_riga <= 0 or isnull(k_codice) then
					k_riga = dw_lista_0.getrow()	
					if k_riga > 0 then
						dw_lista_0.deleterow(k_riga)
					end if
				end if

			end if

			dw_dett_0.setfocus()

		else
			k_errore = kGuf_data_base.db_rollback()

			messagebox("Problemi durante Cancellazione - Operazione fallita !!", &
						   "Errore cod. " + string(kst_esito.esito) + "~n~r" + trim(kst_esito.sqlerrtext)) 	
			if LeftA(k_errore, 1) <> "0" then
				messagebox("Problemi anche durante il recupero dell'errore !!", &
					"Controllare i dati. " + MidA(k_errore, 2))
			end if

			attiva_tasti()
	

		end if

//=== Distruggo l'oggetto che ha avuto la funzione x cancellare la tabella
		destroy kuf1_sped_vettori

	else
		messagebox("Elimina Vettore", "Operazione Annullata !!")
	end if

	dw_dett_0.setcolumn(1)

end if

return(k_return)
end function

protected function integer check_rek (string k_codice);//
int k_return = 0
st_tab_sped_vettori kst_tab_sped_vettori


	kst_tab_sped_vettori.id = dw_dett_0.getitemnumber(1, "id")  
	kst_tab_sped_vettori.rag_soc_1 = dw_dett_0.getitemstring(1, "rag_soc_1")  

	SELECT 
	      sped_vettori.id, 
         trim(sped_vettori.rag_soc_2)
   	 INTO :kst_tab_sped_vettori.id,
				:kst_tab_sped_vettori.rag_soc_2
    	FROM sped_vettori 
   	WHERE rag_soc_1 = :kst_tab_sped_vettori.rag_soc_1 
		      and id <> :kst_tab_sped_vettori.id ;

	if sqlca.sqlcode = 0 then 
		
		if LenA(trim(kst_tab_sped_vettori.rag_soc_2)) = 0 then 
			kst_tab_sped_vettori.rag_soc_2 = " "
		end if
		
		if messagebox("Vettore gia' in Archivio", & 
					"Trovato Vettore con codice: " + string(kst_tab_sped_vettori.id,"#####") + "~n~r" &
					+ trim(kst_tab_sped_vettori.rag_soc_1) +  "~n~r" + &
					+ trim(kst_tab_sped_vettori.rag_soc_2) +  "~n~r" + &
					"Vuoi proseguire ugualmente?", question!, yesno!, 2) = 2 then
		

			dw_dett_0.reset()
//			inizializza()
		
			k_return = 1
		end if
	end if  

//	attiva_tasti()



return k_return


end function

private function integer visualizza ();//===
//=== Lettura del rek da modificare
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
int k_return, k_rc, k_taborder
long k_key
int k_ctr
string k_rc1="", k_style, k_colore
kuf_utility kuf1_utility

//datawindowchild kdwc_clienti_d


	k_key = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "id")
	
	ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione 

//	dw_dett_0.dataobject = "d_contratti" 
//	dw_dett_0.settransobject ( sqlca )
//
////--- Attivo dw archivio Clienti
//	k_rc = dw_dett_0.getchild("rag_soc_10", kdwc_clienti_d)
//
//	k_rc = kdwc_clienti_d.settransobject(sqlca)
//
//	if kdwc_clienti_d.rowcount() = 0 then
////		kdwc_clienti_d.retrieve("%")
//		kdwc_clienti_d.insertrow(1)
//	end if

	k_return = dw_dett_0.retrieve( k_key ) 


//--- protezione campi per visual
	kuf1_utility = create kuf_utility 
	kuf1_utility.u_proteggi_dw("1", 0, dw_dett_0)
	destroy kuf1_utility	

	attiva_tasti()

return k_return

end function

protected function string check_dati ();//
//=== Controllo dati inseriti
string k_return = ""
string k_errore = "0"
int k_rc=0
long k_riga, k_find_riga
string k_key, k_rag_soc_10
string k_descr, k_mc_co = "", k_sc_cf=""
long k_codice, k_codice_1, k_clie
string k_rag_soc




	k_riga = dw_dett_0.getrow()



	if isnull(dw_dett_0.getitemstring ( k_riga, "rag_soc_1")) then
		k_return = k_return + "Manca il dato '" + &
		             trim(dw_dett_0.object.descr_t.text) + "'~n~r" 
		k_errore = "3"
	end if

	if isnull(dw_dett_0.getitemstring ( k_riga, "rag_soc_2")) then
		dw_dett_0.setitem ( k_riga, "rag_soc_2", " ")
	end if


//--- Se nessun errore grave allora imposto i dati di default
	if trim(k_errore) = "0" or trim(k_errore) = "4" or trim(k_errore) = "5 "then


//--- se "inserimento" forzo a zero il codice, cosi' puo essere valorizzato automaticamente 
//--- da informix (campo serial)
		if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
			dw_dett_0.setitem(k_riga, "id", 0)
		end if

//--- imposta campi automatici
		k_rc=dw_dett_0.setitem(k_riga, "x_datins", kGuf_data_base.prendi_x_datins())
		k_rc=dw_dett_0.setitem(k_riga, "x_utente", kGuf_data_base.prendi_x_utente())

	end if



//--- 	
	if k_return = "" or isnull(k_return) then
		k_return = "  "
	end if

return trim(k_errore) + trim(k_return)


end function

protected function integer modifica ();//===
//=== Lettura del rek da modificare
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
int k_return, k_rc,  k_ctr, k_taborder
string k_style, k_rc1
long k_key
kuf_utility kuf1_utility	

//datawindowchild kdwc_clienti_d

	k_key = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "id")
	
	ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica 

	k_return = dw_dett_0.retrieve( k_key ) 

//--- S-protezione campi per riabilitare la modifica a parte la chiave
	kuf1_utility = create kuf_utility 
	kuf1_utility.u_proteggi_dw("0", 0, dw_dett_0)
//--- disabilita la modifica sul codice
	kuf1_utility.u_proteggi_dw("1", 1, dw_dett_0)
	destroy kuf1_utility	

	attiva_tasti()

	dw_dett_0.SetColumn(9)


return k_return

end function

protected function integer inserisci ();//
int k_rc, k_ctr, k_taborder
string k_rc1, k_style
kuf_utility kuf1_utility

//datawindowchild kdwc_clienti_d

	dw_dett_0.reset()

	ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento 

//	dw_dett_0.dataobject = "d_contratti"
//	dw_dett_0.settransobject ( sqlca )
//
////--- Attivo dw archivio Clienti
//	k_rc = dw_dett_0.getchild("rag_soc_10", kdwc_clienti_d)
//
//	k_rc = kdwc_clienti_d.settransobject(sqlca)
//
//	if kdwc_clienti_d.rowcount() = 0 then
////		kdwc_clienti_d.retrieve("%")
//		kdwc_clienti_d.insertrow(1)
//	end if

//=== Aggiunge una riga al data windows
	dw_dett_0.scrolltorow(dw_dett_0.insertrow(dw_dett_0.getrow() + 1))
	dw_dett_0.setcolumn(1)

//--- S-protezione campi per riabilitare la modifica a parte la chiave
	kuf1_utility = create kuf_utility 
	kuf1_utility.u_proteggi_dw("0", 0, dw_dett_0)
//--- disabilita la modifica sul codice
	kuf1_utility.u_proteggi_dw("1", 1, dw_dett_0)
	destroy kuf1_utility	

	attiva_tasti()
	
//=== Posiziona il cursore sul Data Windows
	dw_dett_0.setfocus() 

return (0)


end function

on w_sped_vettori.create
call super::create
end on

on w_sped_vettori.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type st_ritorna from w_g_tab0`st_ritorna within w_sped_vettori
integer x = 2821
integer y = 980
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_sped_vettori
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_sped_vettori
integer x = 2880
integer y = 1768
end type

type st_stampa from w_g_tab0`st_stampa within w_sped_vettori
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_sped_vettori
integer x = 2834
integer y = 1664
end type

type cb_modifica from w_g_tab0`cb_modifica within w_sped_vettori
integer x = 2926
integer y = 1240
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_sped_vettori
integer x = 2894
integer y = 1536
end type

type cb_cancella from w_g_tab0`cb_cancella within w_sped_vettori
integer x = 2880
integer y = 1384
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_sped_vettori
integer x = 2907
integer y = 1092
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_sped_vettori
integer y = 1152
integer width = 2779
integer height = 768
boolean enabled = true
string dataobject = "d_sped_vettori"
end type

event dw_dett_0::clicked;//soppressione codice del padre
end event

type st_orizzontal from w_g_tab0`st_orizzontal within w_sped_vettori
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_sped_vettori
integer width = 3291
integer height = 1024
string dataobject = "d_sped_vettori_l"
end type

