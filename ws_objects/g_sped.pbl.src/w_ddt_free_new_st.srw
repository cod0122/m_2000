$PBExportHeader$w_ddt_free_new_st.srw
forward
global type w_ddt_free_new_st from w_fatture_new_st
end type
type ddlb_copie from dropdownlistbox within w_ddt_free_new_st
end type
type gb_copie from groupbox within w_ddt_free_new_st
end type
end forward

global type w_ddt_free_new_st from w_fatture_new_st
integer height = 2276
string title = ""
ddlb_copie ddlb_copie
gb_copie gb_copie
end type
global w_ddt_free_new_st w_ddt_free_new_st

type variables
//
private st_sped_ddt kist_sped_ddt[]
private int k_ddlb_copie_index=2
end variables

forward prototypes
private function boolean check_lista_se_ristampa ()
protected function string inizializza () throws uo_exception
private subroutine popola_lista_da_st ()
protected subroutine inizializza_lista ()
protected function string leggi_liste ()
protected subroutine open_start_window ()
private subroutine popola_st_da_lista ()
protected subroutine stampa ()
private subroutine popola_lista_no_st ()
end prototypes

private function boolean check_lista_se_ristampa ();//
//---
//--- Controlla se almeno una bolla già stampata vuol dire (x ora) RISTAMPA
//---
boolean k_return = false
long k_riga
st_tab_sped_free kst_tab_sped_free
kuf_sped_free kuf1_sped_free
st_esito kst_esito
pointer kpointer_orig


kpointer_orig = setpointer(hourglass!)

kuf1_sped_free = create kuf_sped_free

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


for k_riga = 1 to upperbound(kist_sped_ddt[])
	
	kst_tab_sped_free.num_bolla_out = kist_sped_ddt[k_riga].kst_tab_sped_free.num_bolla_out
	kst_tab_sped_free.data_bolla_out = kist_sped_ddt[k_riga].kst_tab_sped_free.data_bolla_out
	kst_tab_sped_free.id_sped_free = kist_sped_ddt[k_riga].kst_tab_sped_free.id_sped_free

	try 
		if kst_tab_sped_free.num_bolla_out > " " then

//--- piglia dati ddt
			if kst_tab_sped_free.id_sped_free > 0 then
				
					
				if kuf1_sped_free.if_stampato(kst_tab_sped_free) then //get_sped_stampa(kst_tab_sped_free)
					
					k_return = true
					
					exit
					
				end if
					
			else
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Codice ID del ddt non indicato~n~r" &
							+ string(kst_tab_sped_free.num_bolla_out, "####0") + " del " &
							+ string(kst_tab_sped_free.data_bolla_out, "dd.mm.yyyy")
				kst_esito.esito = kkg_esito.ko
			end if
		end if	
	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito() 
		
	
	end try
	
end for

if kst_esito.esito <> kkg_esito.ok then
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	kguo_exception.messaggio_utente( )
end if

destroy kuf1_sped_free

setpointer(kpointer_orig)  


return k_return
end function

protected function string inizializza () throws uo_exception;//---
boolean k_bolla_trovata=false
long k_ctr
st_sped_ddt kst_sped_ddt_vuota[]
ki_st_open_w.flag_modalita = kkg_flag_modalita.stampa
kuf_sped_free kuf1_sped_free



try 
	setpointer(kkg.pointer_attesa)

	dw_documenti.reset( )
	
//--- pone i link nel dw
	u_personalizza_dw()

	for k_ctr = 1 to UpperBound(kist_sped_ddt[])
		if kist_sped_ddt [k_ctr].kst_tab_sped_free.id_sped_free > 0 then 
			k_bolla_trovata = true
			exit
		end if
	next
	
	if not k_bolla_trovata then

		kuf1_sped_free = create kuf_sped_free
		kuf1_sped_free.get_ddt_da_stampare(kist_sped_ddt[])
			
	end if
	
	popola_lista_da_st()
	
	kist_sped_ddt[] = kst_sped_ddt_vuota[]
	
	dw_documenti.setfocus()

	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		this.postevent(close!)

	finally
		if isvalid(kuf1_sped_free) then destroy kuf1_sped_free
		setpointer(kkg.pointer_default)  
		
end try

return "0"

end function

private subroutine popola_lista_da_st ();//
//---
//--- riempie dw da oggetto st_sped_ddt
//---
long k_riga, k_riga_ins
int k_camion_caricato=0
st_tab_sped_free kst_tab_sped_free
st_tab_clienti kst_tab_clienti
kuf_sped_free kuf1_sped_free
kuf_wm_pklist_righe kuf1_wm_pklist_righe
st_esito kst_esito
pointer kpointer_orig
datastore kds_sped_free


kpointer_orig = setpointer(hourglass!)

kuf1_sped_free = create kuf_sped_free

kds_sped_free = create datastore
kds_sped_free.dataobject = "ds_sped_free"
kds_sped_free.settransobject(kguo_sqlca_db_magazzino)

dw_documenti.reset()

for k_riga = 1 to upperbound(kist_sped_ddt[])

	
	kst_tab_sped_free.num_bolla_out = kist_sped_ddt[k_riga].kst_tab_sped_free.num_bolla_out
	kst_tab_sped_free.data_bolla_out = kist_sped_ddt[k_riga].kst_tab_sped_free.data_bolla_out
	kst_tab_sped_free.id_sped_free = kist_sped_ddt[k_riga].kst_tab_sped_free.id_sped_free

//--- piglia dati ddt
	if kst_tab_sped_free.num_bolla_out > " " then
		
		k_riga_ins = dw_documenti.insertrow(0) //--- nuova riga 
	
		if kist_sped_ddt[k_riga].sel = 0 then
			dw_documenti.setitem(k_riga_ins,"sel", 0)
		else
			dw_documenti.setitem(k_riga_ins,"sel", 1)
		end if
			
		dw_documenti.setitem(k_riga_ins,"sped_free_num_bolla_out", kist_sped_ddt[k_riga].kst_tab_sped_free.num_bolla_out)
		dw_documenti.setitem(k_riga_ins,"sped_free_data_bolla_out", kist_sped_ddt[k_riga].kst_tab_sped_free.data_bolla_out)
		dw_documenti.setitem(k_riga_ins,"id_sped_free", kist_sped_ddt[k_riga].kst_tab_sped_free.id_sped_free)
		
		kds_sped_free.retrieve(kst_tab_sped_free.id_sped_free)
		if kds_sped_free.rowcount() > 0 then
			
			dw_documenti.setitem(k_riga_ins,"data_ora_rit", kds_sped_free.getitemstring(1, "data_ora_rit"))
			dw_documenti.setitem(k_riga_ins,"clie_2", kds_sped_free.getitemnumber(1, "clie_2"))

			dw_documenti.setitem(k_riga_ins,"intestazione", trim( kds_sped_free.getitemstring(1, "intestazione")))
		end if

//--- mette aggiorna data ritiro in automatico se DATA_RIT non impostata
		if trim(dw_documenti.getitemstring(k_riga_ins,"data_ora_rit")) > " " then
		else
			dw_documenti.setitem(k_riga_ins,"data_ora_rit", string(now(), "ddmmyyyyhhmm"))
		end if
//		else
//			dw_documenti.setitem(k_riga_ins,"updst_rit", "S")
//		end if

		dw_documenti.setitem(k_riga_ins,"colli_out", kst_tab_sped_free.colli )
		
//--- valuta se ddt completamente stampato	
//		if kst_tab_sped_free.stampa
		try
			if kst_tab_sped_free.stampa <> kuf1_sped_free.kki_sped_flg_stampa_bolla_da_stamp then
				if not kuf1_sped_free.if_stampato(kst_tab_sped_free) then
					kst_tab_sped_free.stampa = kuf1_sped_free.kki_sped_flg_stampa_bolla_da_stamp
				end if
			end if
		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()		
		end try
		dw_documenti.setitem(k_riga_ins,"stampato", kst_tab_sped_free.stampa )

////--- Camion Caricato (merce scaricata) da WM?		
//		try
//			k_camion_caricato = kuf1_sped.get_sped_camion_caricato(kst_tab_sped_free)
//			dw_documenti.setitem(k_riga_ins,"arsp_insped", k_camion_caricato )
//		catch (uo_exception kuo1_exception)
//			kst_esito = kuo1_exception.get_st_esito()		
//		end try
			
//--- se si è verificato un errore			
//		if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.db_wrn then
//			
//			kguo_exception.set_esito(kst_esito)
//			kguo_exception.messaggio_utente( )
//
//		end if
			
	end if
		
		
end for

destroy kuf1_sped_free
destroy kds_sped_free 

setpointer(kpointer_orig)  



end subroutine

protected subroutine inizializza_lista ();//
//=== Routine STANDARD
//=== Ritorna 0=ok 1=errore
//
int k_return=0
string k_inizializza



//=== Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa)


	dw_documenti.ki_d_std_1_primo_giro = true

	dw_documenti.SetRedraw (false)
	dw_documenti.SetRedraw (false)

	try
		
		k_inizializza = inizializza() //Reimposta i tasti e fa la retrieve di lista
			
		
	catch (uo_exception kuo_exception)
		
	end try
	
//=== Se le INIZIALIZZA tornano con errore = 2 allora chiudo la windows	
	if LeftA(k_inizializza,1) <> "2" then

//--- fa delle cose personalizzate per i figli
		inizializza_post()
		
		attiva_tasti()

		dw_documenti.SetRedraw (true)
		post fine_primo_giro()

	 	SetPointer(kkg.pointer_default)

	else

	 	SetPointer(kkg.pointer_default)

//--- FORZA USCITA!!!
		post close(this)
	end if
	
	


end subroutine

protected function string leggi_liste ();//
//======================================================================
//=== Liste Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
long k_riga


	try
		dw_documenti.setredraw(false)
	
		k_riga = dw_documenti.getrow()
		
		inizializza()
		
		if k_riga > dw_documenti.rowcount() or k_riga = 0 then
			k_riga = dw_documenti.rowcount() 
		end if
		if k_riga > 0 then
			dw_documenti.sort()
			if k_riga > 3 then
				dw_documenti.scrolltorow(k_riga - 3)
			else
				dw_documenti.scrolltorow(k_riga)
			end if
			dw_documenti.setrow(k_riga)
			dw_documenti.selectrow(0 , false)
			dw_documenti.selectrow(k_riga , true)
		else
	
			k_return = "1 "
	
		end if
		
		dw_documenti.setredraw(true)
		
	catch (uo_exception kuo_ecxception)

	end try
	
return k_return





end function

protected subroutine open_start_window ();//---
boolean k_bolla_trovata=false
long k_ctr
st_sped_ddt kst_sped_ddt_vuota[]
ki_st_open_w.flag_modalita = kkg_flag_modalita.stampa
kuf_sped kuf1_sped


try 
	setpointer(kkg.pointer_attesa)

	pb_ok.picturename = "printer.gif" //kGuo_path.get_risorse() + KKG.PATH_SEP + "printer.gif"
	st_aggiorna_lista.enabled  = TRUE

//--- per default fa le copie 2+1 (ricevente+Interna+cliente se diverso dal ricevente)
	ddlb_copie.selectitem(k_ddlb_copie_index)
	

	if isvalid(ki_st_open_w.key12_any[]) then 
		kist_sped_ddt[]	 = ki_st_open_w.key12_any   //--- argomento Struttura con le bolle da mettere in elenco
	else
		kist_sped_ddt[]	 = kst_sped_ddt_vuota[]		
	end if

//--- controlla se ddt già stampate o no (piu' o meno)
	if check_lista_se_ristampa( ) then
		rb_prova.checked = true
	else
		rb_definitiva.checked = true
	end if

	post inizializza_lista()

catch (uo_exception kuo_exception)
	setpointer(kkg.pointer_default)
	kuo_exception.messaggio_utente()
	this.postevent(close!)

finally
	if isvalid(kuf1_sped) then destroy kuf1_sped
	setpointer(kkg.pointer_default)
		
end try


end subroutine

private subroutine popola_st_da_lista ();//
//---
//--- riempie la  st_sped_ddt   da DW
//---
long k_riga=0, k_riga_ins=0
string k_diprova = "N"
st_sped_ddt kst_sped_ddt[]
pointer kpointer_orig


kpointer_orig = setpointer(hourglass!)

kist_sped_ddt[] = kst_sped_ddt[]

if rb_prova.checked then k_diprova = "S"

for k_riga = 1 to dw_documenti.rowcount()


	if dw_documenti.getitemnumber(k_riga,"id_sped_free") > 0 then
		
//--- solo i documenti selezionati
		if not (rb_emissione_selezione.checked) or (dw_documenti.getitemnumber(k_riga, "sel")) = 1 then

			k_riga_ins++

			if rb_emissione_selezione.checked then
				kist_sped_ddt[k_riga_ins].sel = 1
			else
				if dw_documenti.getitemnumber(k_riga,"sel") = 0 then
					kist_sped_ddt[k_riga_ins].sel = 0 
				else
					kist_sped_ddt[k_riga_ins].sel = 1
				end if
			end if
			
			kist_sped_ddt[k_riga_ins].diprova = k_diprova
			
			kist_sped_ddt[k_riga_ins].kst_tab_sped.id_sped = dw_documenti.getitemnumber(k_riga,"id_sped_free")
			kist_sped_ddt[k_riga_ins].kst_tab_sped_free.id_sped_free = dw_documenti.getitemnumber(k_riga,"id_sped_free")
			kist_sped_ddt[k_riga_ins].kst_tab_sped_free.num_bolla_out = dw_documenti.getitemstring(k_riga,"sped_free_num_bolla_out")
			kist_sped_ddt[k_riga_ins].kst_tab_sped_free.data_bolla_out = dw_documenti.getitemdate(k_riga,"sped_free_data_bolla_out")
		
//--- valuta come valorizzare data e ora ritiro		
			if dw_documenti.getitemstring(k_riga,"no_rit") = "S" then
				kist_sped_ddt[k_riga_ins].kst_tab_sped_free.data_ora_rit = ""
			else
//				if dw_documenti.getitemstring(k_riga,"updst_rit")	= "S" then
//					kist_sped_ddt[k_riga_ins].kst_tab_sped_free.data_ora_rit = string(now(), "ddmmyyyyhhmm")
//				else
					kist_sped_ddt[k_riga_ins].kst_tab_sped_free.data_ora_rit = string(dw_documenti.getitemstring(k_riga,"data_ora_rit"))//, "dd/mm/yyyy") &
//																			//	+ " " + trim(dw_documenti.getitemstring(k_riga,"ora_rit"))
//				end if
			end if
			
			kist_sped_ddt[k_riga_ins].kst_tab_sped_free.clie_2 = dw_documenti.getitemnumber(k_riga,"clie_2")
			kist_sped_ddt[k_riga_ins].kst_tab_sped_free.colli = string(dw_documenti.getitemnumber(k_riga,"colli_out"))
			kist_sped_ddt[k_riga_ins].kst_tab_sped_free.stampa = dw_documenti.getitemstring(k_riga,"stampato")
		
		end if
	end if
		
		
end for


setpointer(kpointer_orig)  



end subroutine

protected subroutine stampa ();//--
//--- Lancia Aggiornamento e Stampa dei DDT 
//---
long k_riga_ddt=0, k_riga=0
int k_nr_ddt=0, k_ind=0, k_camion_caricato=0
boolean k_flag_camion_caricato_si=true
kuf_sped_ddt kuf1_sped_ddt
st_ddt_stampa kst_ddt_stampa[]
st_esito kst_esito
uo_exception kuo1_exception
pointer kpointer


kpointer = setpointer(hourglass!)

kuf1_sped_ddt = create kuf_sped_ddt
kuo1_exception = create uo_exception

kst_esito.esito = "0"
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try 
//--- set nell'area kist_sped_ddt[] delle bolle da stmpare dal DW	
	popola_st_da_lista()

//--- controllo array ai documenti?  
	if UpperBound(kist_sped_ddt[]) > 0 then
	
		for k_riga_ddt = 1 to UpperBound(kist_sped_ddt[])
			if kist_sped_ddt[k_riga_ddt].kst_tab_sped.id_sped > 0 then

				k_riga++
				kst_ddt_stampa[k_riga].NUM_BOLLA_OUT = kist_sped_ddt[k_riga_ddt].kst_tab_sped.NUM_BOLLA_OUT
				kst_ddt_stampa[k_riga].DATA_BOLLA_OUT = kist_sped_ddt[k_riga_ddt].kst_tab_sped_free.DATA_BOLLA_OUT
				kst_ddt_stampa[k_riga].ID_SPED = kist_sped_ddt[k_riga_ddt].kst_tab_sped_free.ID_SPED_FREE

				kst_ddt_stampa[k_riga].data_ora_rit = kist_sped_ddt[k_riga_ddt].kst_tab_sped_free.data_ora_rit
			
//--- valuta tipo numero copie da fare
				choose case k_ddlb_copie_index 
					case 1 
						kst_ddt_stampa[k_riga].tipo_num_copie = kuf1_sped_ddt.kki_tipo_num_copie_doppia_c
					case 2
						kst_ddt_stampa[k_riga].tipo_num_copie = kuf1_sped_ddt.kki_tipo_num_copie_tripla
					case 3
						kst_ddt_stampa[k_riga].tipo_num_copie = kuf1_sped_ddt.kki_tipo_num_copie_generica
				end choose
				kist_sped_ddt[k_riga_ddt].kst_tab_sped.NUM_BOLLA_OUT = 0  // stampa effettuata pulisco lo slot x toglierlo dall'elenco
				kist_sped_ddt[k_riga_ddt].kst_tab_sped.ID_SPED = 0  // stampa effettuata pulisco lo slot x toglierlo dall'elenco
				kst_ddt_stampa[k_riga].print_ddt_libero = true
			end if
		next
		
//--- se tutto OK  procedo con l'emissione		
		if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn then	
			
	//--- STAMPA se richiesto esplicitamente 
			if rb_modo_stampa_s.checked  then
			
				k_nr_ddt = kuf1_sped_ddt.stampa_ddt (kst_ddt_stampa[])  // STAMPA
			
				kuo1_exception.kist_esito = kst_esito
				if k_nr_ddt = 0 then
					kuo1_exception.set_tipo(kuo1_exception.kk_st_uo_exception_tipo_dati_insufficienti )
					kuo1_exception.setmessage("Nessun documento Stampato")
				else
					kuo1_exception.set_tipo(kuo1_exception.kk_st_uo_exception_tipo_ok )
					if k_nr_ddt = 1 then
						kuo1_exception.setmessage("Fine elaborazione, 1 documento stampato")
					else
						kuo1_exception.setmessage("Fine elaborazione, " + string(k_nr_ddt) + " documenti stampati")
					end if
				end if
				kuo1_exception.messaggio_utente( )
			end if
		
	//--- PDF!!!
			if not rb_modo_stampa_s.checked then
			
//				k_nr_ddt = kuf1_sped_ddt.stampa_ddt_digitale (kist_sped_ddt[])
			
				if k_nr_ddt = 0 then
					kuo1_exception.set_tipo(kuo1_exception.kk_st_uo_exception_tipo_dati_insufficienti )
					kuo1_exception.setmessage(" Nessun documento digitalizzato ")
				else
					kuo1_exception.set_tipo(kuo1_exception.kk_st_uo_exception_tipo_ok )
					if k_nr_ddt = 1 then
						kuo1_exception.setmessage("Fine elaborazione, 1 documento digitale emesso")
					else
						kuo1_exception.setmessage("Fine elaborazione, " + string(k_nr_ddt) + " documenti digitali emessi")
					end if
				end if
				kuo1_exception.messaggio_utente( )
			
			end if
		
			if k_nr_ddt > 0 then
//--- x DEFAULT Aggiorna DB (rb_DEFINITIVA)
				if not rb_prova.checked then
//--- aggiorna dati di stampa
					if cbx_aggiorna_stato.checked then
						
						kuf1_sped_ddt.set_ddt_free_aggiorna(kst_ddt_stampa[])  // AGGIORNA!!!!! 
						
//--- funzione utile alla sincronizzazione con la window di ritorno (come il navigatore)
						kiuf1_sync_window.u_window_set_funzione_aggiornata(ki_st_open_w)
						
					end if
					

				end if
			end if
		end if

//--- se tutto OK e stampato il cartaceo e ho stampato qls allora cancello i ddt stampati dall'elenco
		if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn then	
			popola_lista_no_st( )
		end if
		
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log()
//	kGuf_data_base.errori_scrivi_esito("W", kst_esito)  //--- scrive il LOG
	kuo_exception.messaggio_utente()
	
finally
	if isvalid(kuf1_sped_ddt) then destroy kuf1_sped_ddt
	if isvalid(kuo1_exception) then destroy kuo1_exception

	setpointer(kpointer)
	
//--- se richiesto ed elenco vuoto esce dalla funzione	
	if cbx_chiude.checked then
		if dw_documenti.rowcount( ) = 0 then
			cb_ritorna.event clicked( )
		end if
	end if
		
end try


end subroutine

private subroutine popola_lista_no_st ();//
//---
//--- pulisce dw da righe stampate
//---
long k_riga, k_righe


k_righe = dw_documenti.rowcount( )

for k_riga = k_righe to 1 step -1

	if rb_modo_stampa_s.checked  then
		
		if dw_documenti.getitemnumber( k_riga, "sel") = 1 then
			dw_documenti.deleterow(k_riga)
		end if
		
	else
		
		dw_documenti.reset( )
		
	end if
		
end for




end subroutine

on w_ddt_free_new_st.create
int iCurrent
call super::create
this.ddlb_copie=create ddlb_copie
this.gb_copie=create gb_copie
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_copie
this.Control[iCurrent+2]=this.gb_copie
end on

on w_ddt_free_new_st.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.ddlb_copie)
destroy(this.gb_copie)
end on

type st_ritorna from w_fatture_new_st`st_ritorna within w_ddt_free_new_st
end type

type st_ordina_lista from w_fatture_new_st`st_ordina_lista within w_ddt_free_new_st
end type

type st_aggiorna_lista from w_fatture_new_st`st_aggiorna_lista within w_ddt_free_new_st
end type

type cb_ritorna from w_fatture_new_st`cb_ritorna within w_ddt_free_new_st
end type

type st_stampa from w_fatture_new_st`st_stampa within w_ddt_free_new_st
end type

type rb_emissione_tutto from w_fatture_new_st`rb_emissione_tutto within w_ddt_free_new_st
integer y = 420
end type

type rb_emissione_selezione from w_fatture_new_st`rb_emissione_selezione within w_ddt_free_new_st
integer y = 516
end type

type rb_definitiva from w_fatture_new_st`rb_definitiva within w_ddt_free_new_st
integer y = 1328
integer width = 878
string text = "EFFETTIVA (Aggiorna Archivi)"
end type

type rb_prova from w_fatture_new_st`rb_prova within w_ddt_free_new_st
integer y = 1240
string text = "Solo Ristampa (no Aggiornamenti) "
end type

type pb_ok from w_fatture_new_st`pb_ok within w_ddt_free_new_st
integer y = 1740
end type

type dw_documenti from w_fatture_new_st`dw_documenti within w_ddt_free_new_st
integer height = 1924
string dataobject = "d_sped_free_l5"
end type

type cbx_aggiorna_stato from w_fatture_new_st`cbx_aggiorna_stato within w_ddt_free_new_st
integer y = 1432
string text = "Aggiorna lo Stato in ~'Stampato~'"
end type

type cbx_update_profis from w_fatture_new_st`cbx_update_profis within w_ddt_free_new_st
boolean visible = false
integer x = 494
integer y = 1964
end type

type st_1 from w_fatture_new_st`st_1 within w_ddt_free_new_st
integer y = 1808
end type

type cbx_update_tab_varie from w_fatture_new_st`cbx_update_tab_varie within w_ddt_free_new_st
boolean visible = false
integer x = 251
integer y = 1964
end type

type rb_modo_stampa_e from w_fatture_new_st`rb_modo_stampa_e within w_ddt_free_new_st
integer y = 944
boolean enabled = false
end type

type rb_modo_stampa_s from w_fatture_new_st`rb_modo_stampa_s within w_ddt_free_new_st
integer y = 852
end type

type cbx_chiude from w_fatture_new_st`cbx_chiude within w_ddt_free_new_st
integer y = 1616
end type

type gb_aggiorna from w_fatture_new_st`gb_aggiorna within w_ddt_free_new_st
integer y = 1152
integer height = 404
end type

type gb_emissione from w_fatture_new_st`gb_emissione within w_ddt_free_new_st
integer y = 324
end type

type gb_produzione from w_fatture_new_st`gb_produzione within w_ddt_free_new_st
integer y = 744
integer height = 324
end type

type ddlb_copie from dropdownlistbox within w_ddt_free_new_st
integer x = 73
integer y = 104
integer width = 1061
integer height = 352
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Ricevente e Vettore se presente","Ricevente e Vettore ","Generica (solo una copia)"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//
k_ddlb_copie_index = index
end event

type gb_copie from groupbox within w_ddt_free_new_st
integer x = 27
integer y = 16
integer width = 1125
integer height = 256
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Numero Copie "
end type

