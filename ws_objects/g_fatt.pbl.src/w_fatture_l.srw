$PBExportHeader$w_fatture_l.srw
forward
global type w_fatture_l from w_g_tab0
end type
type rb_prova from radiobutton within w_fatture_l
end type
type rb_definitiva from radiobutton within w_fatture_l
end type
type cb_stampa_ok from commandbutton within w_fatture_l
end type
type cb_stampa_annulla from commandbutton within w_fatture_l
end type
type dw_periodo from uo_dw_periodo within w_fatture_l
end type
type gb_stampa from groupbox within w_fatture_l
end type
end forward

global type w_fatture_l from w_g_tab0
integer width = 2898
integer height = 2084
string title = "Documenti di Vendita"
boolean ki_toolbar_window_presente = true
rb_prova rb_prova
rb_definitiva rb_definitiva
cb_stampa_ok cb_stampa_ok
cb_stampa_annulla cb_stampa_annulla
dw_periodo dw_periodo
gb_stampa gb_stampa
end type
global w_fatture_l w_fatture_l

type variables
//
//private date ki_data_ini 
//private date ki_data_fin 

private string ki_mostra_nascondi_in_lista="S"
private string ki_win_titolo_orig_save = ""

kuf_fatt kiuf_fatt
ds_fatture kids_fatture

end variables

forward prototypes
protected function integer visualizza ()
private function string cancella ()
private function string inizializza ()
protected subroutine attiva_menu ()
protected subroutine smista_funz (string k_par_in)
private subroutine cambia_periodo_elenco ()
public subroutine popola_ds_fatture_da_lista ()
private subroutine stampa_fatture ()
public subroutine stampa_fatture_lancia ()
protected subroutine open_start_window ()
public subroutine u_produce_fatture_elettroniche ()
end prototypes

protected function integer visualizza ();////
//string k_cod_art
//long k_cod_cli, k_mis_x, k_mis_y, k_mis_z
//double k_dose
//st_open_w k_st_open_w
//kuf_menu_window kuf1_menu_window
//
//
//if dw_lista_0.getrow() > 0 then
//
//	k_cod_cli = dw_lista_0.getitemnumber( &
//						dw_lista_0.getrow(), "cod_cli") 
//	k_cod_art = dw_lista_0.getitemstring( &
//						dw_lista_0.getrow(), "cod_art") 
//	k_dose = dw_lista_0.getitemnumber( &
//						dw_lista_0.getrow(), "listino_dose") 
//	k_mis_x = dw_lista_0.getitemnumber( &
//						dw_lista_0.getrow(), "listino_mis_x") 
//	k_mis_y = dw_lista_0.getitemnumber( &
//						dw_lista_0.getrow(), "listino_mis_y") 
//	k_mis_z = dw_lista_0.getitemnumber( &
//						dw_lista_0.getrow(), "listino_mis_z") 
//
//
////
////=== Parametri : 
////=== struttura st_open_w
////=== dati particolare programma
////
////=== Si potrebbero passare:
////=== key1=codice cli; key2=cod sl-pt
//
//	K_st_open_w.id_programma = "li"
//	K_st_open_w.flag_primo_giro = "S"
//	K_st_open_w.flag_modalita = "vi"
//	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN_NO
//	K_st_open_w.flag_leggi_dw = " "
//	K_st_open_w.flag_cerca_in_lista = " "
//	K_st_open_w.key1 = trim(string(k_cod_cli)) // cod cliente
//	K_st_open_w.key2 = trim(k_cod_art) // cod articolo 
//	K_st_open_w.key3 = trim(string(k_dose)) // dose
//	K_st_open_w.key4 = trim(string(k_mis_x)) // misure imballo
//	K_st_open_w.key5 = trim(string(k_mis_y)) // misure imballo
//	K_st_open_w.key6 = trim(string(k_mis_z)) // misure imballo
//	K_st_open_w.flag_where = " "
//	
//	kuf1_menu_window = create kuf_menu_window 
//	kuf1_menu_window.open_w_tabelle(k_st_open_w)
//	destroy kuf1_menu_window
//								
//else
//
//	messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")
//
//end if
//
return (0)
end function

private function string cancella ();//
string k_errore = "0 ", k_errore1 = "0 "
long k_riga
st_tab_arfa kst_tab_arfa
st_tab_clienti kst_tab_clienti
st_esito kst_esito

try
	
	k_riga = dw_lista_0.getselectedrow(0)	
	if k_riga > 0 then
		kst_tab_arfa.id_fattura = dw_lista_0.getitemnumber(k_riga, "id_fattura")
		kst_tab_arfa.num_fatt = dw_lista_0.getitemnumber(k_riga, "num_fatt")
		kst_tab_arfa.data_fatt = dw_lista_0.getitemdate(k_riga, "data_fatt")
		kst_tab_arfa.clie_3 = dw_lista_0.getitemnumber(k_riga, "id_cliente")
		kst_tab_clienti.rag_soc_10 = dw_lista_0.getitemstring(k_riga, "clienti_rag_soc_10")
	
	//--- posso cancellare il documento?
		if kiuf_fatt.if_cancella(kst_tab_arfa) then
			
			if isnull(kst_tab_clienti.rag_soc_10) = true or trim(kst_tab_clienti.rag_soc_10) = "" then
				kst_tab_clienti.rag_soc_10 = "Clienti senza Nominativo " 
			end if
			
		//=== Richiesta di conferma della eliminazione del rek
			if messagebox("Elimina Fattura", "Sei sicuro di voler Cancellare la Fattura: ~n~r" &
						+ "Fattura nr. " + string(kst_tab_arfa.num_fatt, "#####") + " del " + string(kst_tab_arfa.data_fatt) &
						+ " cliente " + string(kst_tab_arfa.clie_3)  + " del " + trim(kst_tab_clienti.rag_soc_10),  &
						question!, yesno!, 2) = 1 then
				
	//=== Cancella la riga dal data windows di lista
				kst_esito = kiuf_fatt.tb_delete( kst_tab_arfa ) 
				if kst_esito.esito = kkg_esito.ok then
			
					dw_lista_0.setitemstatus(k_riga, 0, primary!, new!)
					dw_lista_0.deleterow(k_riga)
		
					dw_lista_0.setfocus()
		
				else
		
					messagebox("Problemi durante Cancellazione - Operazione fallita !!", &
									trim(kst_esito.sqlerrtext) )
			
					attiva_tasti()
		
				end if
		
		
			else
				messagebox("Elimina Fattura", "Operazione Annullata !!")
		
			end if
		end if
	else
		messagebox("Elimina Fattura", "Selezionare una riga dall'elenco. ")
	end if

catch(uo_exception kuo_exception)
	kuo_exception.messaggio_utente()

end try

return " "
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
int k_importa = 0
st_tab_arfa kst_tab_arfa
kuf_listino kuf1_listino
pointer oldpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

//=== Legge le righe del dw salvate l'ultima volta (importfile)
	if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima volta il tasto e' false 

		k_importa = kGuf_data_base.dw_importfile(trim(ki_syntaxquery), dw_lista_0)

	end if
		
	if k_importa <= 0 then // Nessuna importazione eseguita
		
		if len(trim(ki_st_open_w.key1)) > 0 then 
			kst_tab_arfa.clie_3 = long(trim(ki_st_open_w.key1))
		else
			kst_tab_arfa.clie_3 = 0
		end if
		if dw_lista_0.retrieve(dw_periodo.get_data_ini(), dw_periodo.get_data_fin(), kst_tab_arfa.clie_3) < 1 then
			k_return = "1Nessuna Fattura per il periodo: " + string(dw_periodo.get_data_ini()) + " - " + string(dw_periodo.get_data_fin())

			SetPointer(oldpointer)
			messagebox("Elenco Fatture", &
					"Nessuna Fattura per il periodo: " + string(dw_periodo.get_data_ini()) + " - " + string(dw_periodo.get_data_fin()))

		end if		
	end if

	ki_win_titolo_orig = ki_win_titolo_orig_save
	ki_win_titolo_orig += " dal " + string(dw_periodo.get_data_ini()) + " al " + string(dw_periodo.get_data_fin())
	kiw_this_window.title = ki_win_titolo_orig

	attiva_tasti()

return k_return


end function

protected subroutine attiva_menu ();//--- Attiva/Dis. Voci di menu



//
//--- Attiva/Dis. Voci di menu personalizzate
//
	if not ki_menu.m_strumenti.m_fin_gest_libero1.visible then
		ki_menu.m_strumenti.m_fin_gest_libero1.text = "Cambia periodo estrazione fatture " 
		ki_menu.m_strumenti.m_fin_gest_libero1.microhelp =  "Cambia il periodo di estrazione elenco fatture"
		ki_menu.m_strumenti.m_fin_gest_libero1.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText = "Periodo,"+ki_menu.m_strumenti.m_fin_gest_libero1.text
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName = "Custom015!"
//		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero1.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
		
		ki_menu.m_strumenti.m_fin_gest_libero2.text = "Stampa fatture selezionate " 
		ki_menu.m_strumenti.m_fin_gest_libero2.microhelp =  "Stampa fatture selezionate"
		ki_menu.m_strumenti.m_fin_gest_libero2.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemText = "Stampa,"+ki_menu.m_strumenti.m_fin_gest_libero2.text
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName = kguo_path.get_risorse() + kkg.path_sep + "printer16x16.gif"
//		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero2.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true
		
		ki_menu.m_strumenti.m_fin_gest_libero5.text = "Produce Fattura Elettronica (formato XML) " 
		ki_menu.m_strumenti.m_fin_gest_libero5.microhelp =  "Produce Fattura Elettronica (formato XML) " 
		ki_menu.m_strumenti.m_fin_gest_libero5.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemText = "XML,"+ki_menu.m_strumenti.m_fin_gest_libero5.text
		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemName = kguo_path.get_risorse() + kkg.path_sep + "aereo32.png"
//		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero5.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemVisible = true
	end if	
	
//---
	super::attiva_menu()


end subroutine

protected subroutine smista_funz (string k_par_in);//
//===

choose case LeftA(k_par_in, 2) 


	case KKG_FLAG_RICHIESTA.libero1		//cambia date di estrazione
		cambia_periodo_elenco()

	case KKG_FLAG_RICHIESTA.libero2		//stampa fatture
		stampa_fatture_lancia()

	case KKG_FLAG_RICHIESTA.libero5		//produce fatture elettroniche
		u_produce_fatture_elettroniche()

	case else
		super::smista_funz(k_par_in)

end choose



end subroutine

private subroutine cambia_periodo_elenco ();//---
//--- Visualizza il box x il cambio del Periodo di elenco fatture 
//---


dw_periodo.event ue_visible( )

end subroutine

public subroutine popola_ds_fatture_da_lista ();//---
//--- riempie la  ds_fatture  da dw di elenco
//---
long k_riga, k_riga_ds
st_tab_arfa kst_tab_arfa
st_tab_clienti kst_tab_clienti
st_tab_prof kst_tab_prof
st_esito kst_esito
kuf_prof kuf1_prof 

kuf1_prof = create kuf_prof

if not isvalid(kids_fatture) then 
	kids_fatture = create ds_fatture
else
	kids_fatture.reset()
end if


for k_riga = 1 to dw_lista_0.rowcount()

//--- se selezionata la metto da stampare
	if dw_lista_0.IsSelected ( k_riga)   then

		kst_tab_arfa.num_fatt = dw_lista_0.getitemnumber(k_riga, "num_fatt")
		kst_tab_arfa.data_fatt = dw_lista_0.getitemdate(k_riga, "data_fatt")
	
		if kst_tab_arfa.num_fatt > 0 then

			k_riga_ds = kids_fatture.insertrow(0)
			kst_tab_prof.num_fatt = kst_tab_arfa.num_fatt
			kst_tab_prof.data_fatt = kst_tab_arfa.data_fatt
			kids_fatture.setitem(k_riga_ds,"num_fatt", kst_tab_arfa.num_fatt)
			kids_fatture.setitem(k_riga_ds,"data_fatt", kst_tab_arfa.data_fatt)
			kids_fatture.setitem(k_riga_ds,"modo_stampa", dw_lista_0.getitemstring(k_riga, "modo_stampa"))
			try 
				if kuf1_prof.if_fattura_presente( kst_tab_prof ) = kuf1_prof.kki_fattura_in_profis_si then
					kids_fatture.setitem(k_riga_ds,"prof", 1) 
				else
					kids_fatture.setitem(k_riga_ds,"prof", 0) 
				end if
			catch ( uo_exception kuo_exception)
				kids_fatture.setitem(k_riga_ds,"prof", 2) 
			finally 
			end try
			
		end if			
	end if		
	
end for


destroy kuf1_prof


end subroutine

private subroutine stampa_fatture ();//---
//--- Visualizza il box x il cambio del stampa di elenco fatture 
//---

gb_stampa.x = (kiw_this_window.width  - gb_stampa.width) / 4
gb_stampa.y = (kiw_this_window.height - gb_stampa.height) / 4
rb_prova.x = gb_stampa.x + 78 
rb_prova.y = gb_stampa.y + 115
rb_definitiva.x = rb_prova.x 
rb_definitiva.y = gb_stampa.y + 203
cb_stampa_ok.x = gb_stampa.x + 78
cb_stampa_ok.y = gb_stampa.y + 319
cb_stampa_annulla.x = gb_stampa.x + 585
cb_stampa_annulla.y = cb_stampa_ok.y

gb_stampa.visible = true
rb_prova.visible = true
rb_definitiva.visible = true
cb_stampa_ok.visible = true
cb_stampa_annulla.visible = true

end subroutine

public subroutine stampa_fatture_lancia ();//--
//--- Lancia Aggiornamento e Stampa delle fatture 
//---
LONG k_riga_fatture=0
st_tab_arfa kst_tab_arfa[]
st_esito kst_esito
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window




try 
	popola_ds_fatture_da_lista()
	if kids_fatture.rowcount( ) > 0 then
		
		
//		kiuf_fatt.stampa_fattura (kids_fatture)
//
////--- Aggiornamento STAMAPATE se NON di PROVA	
//		if rb_definitiva.checked then
//
////			kiuf_fatt.aggiorna_fattura_flag_stampa(kids_fatture)
//	
//			if kids_fatture.rowcount() > 0 then
//				for k_riga_fatture = 1 to kids_fatture.rowcount()
//					kst_tab_arfa[k_riga_fatture].NUM_FATT = kids_fatture.object.NUM_FATT[k_riga_fatture]
//					kst_tab_arfa[k_riga_fatture].DATA_FATT = kids_fatture.object.DATA_FATT[k_riga_fatture]
//				next
//			end if
//		
//	//--- aggiorna flag di stampa
//			kiuf_fatt.aggiorna_fattura_flag_stampa(kst_tab_arfa[])
//
//	//--- aggiorna tabelle tipo PROFIS, SCADENZE....		
//			kst_esito = kiuf_fatt.aggiorna_tabelle_correlate(kst_tab_arfa[])
//			if kst_esito.esito = kkg_esito.db_ko then
//				kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_db_ko )
//				kguo_exception.set_esito( kst_esito )
//			end if
//			
//
//		end if

//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
		K_st_open_w.id_programma = kkg_id_programma_fatture_stampa
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = kkg_flag_modalita.stampa
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
		K_st_open_w.flag_leggi_dw = " "
		K_st_open_w.flag_cerca_in_lista = " "
		K_st_open_w.key12_any = kids_fatture  // datastore fattori
		K_st_open_w.key1 = " "
		K_st_open_w.key2 = " "
		K_st_open_w.key3 = " " 
		K_st_open_w.flag_where = " "
		
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(k_st_open_w)
		destroy kuf1_menu_window
	
								
	else
		kguo_exception.setmessage( "Selezionare almeno una Fattura da stampare")
		kguo_exception.messaggio_utente( )
	end if

	
	
	
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally

end try



end subroutine

protected subroutine open_start_window ();//
kiuf_fatt = create kuf_fatt
ki_win_titolo_orig_save = ki_win_titolo_orig

ki_toolbar_window_presente=true

//--- inizializza box periodo
dw_periodo.inizializza( kiw_this_window )

//
//--- Argomenti:  KEY1 = cliente, KEY2= Data Inizio -   KEY3 = Data Fine 
	if trim(ki_st_open_w.key2) = "" then
		if isdate(trim(ki_st_open_w.key2)) then
			dw_periodo.set_data_ini(date(trim(ki_st_open_w.key2)))
		else
			dw_periodo.set_data_ini(relativedate(kg_dataoggi, -365))
		end if
	else
		dw_periodo.set_data_ini(relativedate(kg_dataoggi, -365))
	end if
	if trim(ki_st_open_w.key3) = "" then
		if isdate(trim(ki_st_open_w.key3)) then
			dw_periodo.set_data_fin(date(trim(ki_st_open_w.key3)))
		else
			dw_periodo.set_data_fin(kg_dataoggi)
		end if
	else
		dw_periodo.set_data_ini(kg_dataoggi)
	end if
	
kids_fatture = create ds_fatture


end subroutine

public subroutine u_produce_fatture_elettroniche ();//--
//--- Produzione delle fatture elettroniche formato XML 
//---
LONG k_riga_fatture=0, k_nr_fatture=0
string k_path="..", k_nulla=""
int k_ret
st_fatt_elettronica kst_fatt_elettronica
st_esito kst_esito
kuf_fatt_elettronica kuf1_fatt_elettronica
kuf_file_explorer kuf1_file_explorer


try 
	popola_ds_fatture_da_lista()
	if kids_fatture.rowcount( ) > 0 then


		k_path = trim(kGuf_data_base.profilestring_leggi_scrivi(kGuf_data_base.ki_profilestring_operazione_leggi, "arch_xml_fatt", k_nulla))
		if trim(k_path) > " " then
		else
			k_path=".."
		end if
		
		k_ret = GetFolder ( "Sceglire la Cartella dove salvare le fatture nel formato XML", k_path )
		
		if k_ret = 1 then
			kGuf_data_base.profilestring_leggi_scrivi(kGuf_data_base.ki_profilestring_operazione_scrivi , "arch_xml_fatt", trim(k_path))
			
			kuf1_fatt_elettronica = create kuf_fatt_elettronica
			
			for k_riga_fatture = 1 to kids_fatture.rowcount()
				kst_fatt_elettronica.num_fattura_da = kids_fatture.object.NUM_FATT[k_riga_fatture]
				kst_fatt_elettronica.data_fattura_da = kids_fatture.object.DATA_FATT[k_riga_fatture]
				kst_fatt_elettronica.num_fattura_a = kids_fatture.object.NUM_FATT[k_riga_fatture]
				kst_fatt_elettronica.data_fattura_a = kids_fatture.object.DATA_FATT[k_riga_fatture]
				kst_fatt_elettronica.nome_file = trim(k_path)
				k_nr_fatture += kuf1_fatt_elettronica.esporta_fatt(kst_fatt_elettronica)
			next
			if k_nr_fatture = 0 then	
				kguo_exception.inizializza( )
				kguo_exception.setmessage( "Elaborazione terminata", "Nessuna Fattura prodotta")
				kguo_exception.messaggio_utente( )
			elseif k_nr_fatture = 1 then	
				kguo_exception.inizializza( )
				kguo_exception.setmessage( "Elaborazione terminata", "La Fattura " + string(kst_fatt_elettronica.num_fattura_da) + " è stata salvata nella cartella " + k_path)
		//		kguo_exception.messaggio_utente( )
				if messagebox("Operazione terminata correttamente",  "Vuoi aprire subito il Documento n." + string(kst_fatt_elettronica.num_fattura_da) + "~n~rsalvato nella cartella: " + kst_fatt_elettronica.nome_file, Question!, yesno!, 1) = 1 then
					SetPointer(kkg.pointer_attesa)
					kuf1_file_explorer = create kuf_file_explorer
					kuf1_file_explorer.of_execute( trim(kst_fatt_elettronica.nome_file))
					destroy kuf1_file_explorer
				end if
			else
				kguo_exception.inizializza( )
				kguo_exception.setmessage( "Elaborazione terminata", "Sono state salvate le " + string(k_nr_fatture) + " Fatture nella cartella " + k_path)
				kguo_exception.messaggio_utente( )
			end if
		else
			if k_ret < 0 then
		//--- ERRORE	
			end if
		end if
		
	else
		kguo_exception.inizializza( )
		kguo_exception.setmessage( "Selezionare almeno una Fattura dall'elenco")
		kguo_exception.messaggio_utente( )
	end if

	
catch (uo_exception kuo_exception)
	if isvalid(kuf1_fatt_elettronica) then destroy kuf1_fatt_elettronica
	kuo_exception.messaggio_utente()
	
finally

end try



end subroutine

on w_fatture_l.create
int iCurrent
call super::create
this.rb_prova=create rb_prova
this.rb_definitiva=create rb_definitiva
this.cb_stampa_ok=create cb_stampa_ok
this.cb_stampa_annulla=create cb_stampa_annulla
this.dw_periodo=create dw_periodo
this.gb_stampa=create gb_stampa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_prova
this.Control[iCurrent+2]=this.rb_definitiva
this.Control[iCurrent+3]=this.cb_stampa_ok
this.Control[iCurrent+4]=this.cb_stampa_annulla
this.Control[iCurrent+5]=this.dw_periodo
this.Control[iCurrent+6]=this.gb_stampa
end on

on w_fatture_l.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_prova)
destroy(this.rb_definitiva)
destroy(this.cb_stampa_ok)
destroy(this.cb_stampa_annulla)
destroy(this.dw_periodo)
destroy(this.gb_stampa)
end on

event close;call super::close;//
if isvalid(kids_fatture) then destroy kids_fatture
if isvalid(kiuf_fatt) then destroy kiuf_fatt

end event

type st_ritorna from w_g_tab0`st_ritorna within w_fatture_l
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_fatture_l
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_fatture_l
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_fatture_l
integer x = 2427
integer y = 1160
integer height = 92
integer taborder = 90
boolean cancel = true
end type

type st_stampa from w_g_tab0`st_stampa within w_fatture_l
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_fatture_l
integer x = 1801
integer y = 1252
end type

event cb_visualizza::clicked;//
long k_riga=0
st_tab_arfa kst_tab_arfa
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


kst_tab_arfa.id_fattura =0
kst_tab_arfa.clie_3 = 0

k_riga = dw_lista_0.getselectedrow(0)
if k_riga > 0 then
	kst_tab_arfa.clie_3 = dw_lista_0.getitemnumber( k_riga, "id_cliente") 
	kst_tab_arfa.id_fattura = dw_lista_0.getitemnumber( k_riga, "id_fattura") 
else
	if len(trim(ki_st_open_w.key1)) > 0 then
		kst_tab_arfa.clie_3 = long(trim(ki_st_open_w.key1))
	end if
end if
	

if k_riga > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	K_st_open_w.id_programma = kkg_id_programma_fatture
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = trim(string(kst_tab_arfa.id_fattura)) // id fattura
	K_st_open_w.key2 = trim(string(kst_tab_arfa.clie_3)) // cod cliente
	K_st_open_w.key3 = " " 
	K_st_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(k_st_open_w)
	destroy kuf1_menu_window

								
else

	messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")

end if

return (0)

end event

type cb_modifica from w_g_tab0`cb_modifica within w_fatture_l
integer x = 1783
integer y = 1152
integer height = 96
integer taborder = 70
end type

event cb_modifica::clicked;//
long k_riga=0
st_tab_arfa kst_tab_arfa
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


kst_tab_arfa.id_fattura =0
kst_tab_arfa.clie_3 = 0

if dw_lista_0.rowcount() > 0 then

	k_riga = dw_lista_0.getselectedrow(0)
	if k_riga > 0 then

		kst_tab_arfa.clie_3 = dw_lista_0.getitemnumber( k_riga, "id_cliente") 
		kst_tab_arfa.id_fattura = dw_lista_0.getitemnumber( k_riga, "id_fattura") 
	else
		if len(trim(ki_st_open_w.key1)) > 0 then
			kst_tab_arfa.clie_3 = long(trim(ki_st_open_w.key1))
		end if
	end if
	
end if

if dw_lista_0.getselectedrow(0) > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	K_st_open_w.id_programma = kkg_id_programma_fatture
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_modalita = kkg_flag_modalita.modifica
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = trim(string(kst_tab_arfa.id_fattura)) // id fattura
	K_st_open_w.key2 = trim(string(kst_tab_arfa.clie_3)) // cod cliente
	K_st_open_w.key3 = " " 
	K_st_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(k_st_open_w)
	destroy kuf1_menu_window

								
else

	messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")

end if

return (0)

end event

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_fatture_l
integer x = 1134
integer y = 1160
integer height = 96
integer taborder = 100
end type

type cb_cancella from w_g_tab0`cb_cancella within w_fatture_l
integer x = 2121
integer y = 1164
integer height = 96
integer taborder = 80
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_fatture_l
integer x = 1467
integer y = 1156
integer height = 96
integer taborder = 60
boolean enabled = false
end type

event cb_inserisci::clicked;//
long k_riga=0
st_tab_arfa kst_tab_arfa
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


kst_tab_arfa.id_fattura =0
kst_tab_arfa.clie_3 = 0
//
//k_riga = dw_lista_0.getselectedrow(0)
//if k_riga > 0 then
//	kst_tab_arfa.clie_3 = dw_lista_0.getitemnumber( k_riga, "id_cliente") 
//	kst_tab_arfa.id_fattura = dw_lista_0.getitemnumber( k_riga, "id_fattura") 
//else
	if len(trim(ki_st_open_w.key1)) > 0 then
		kst_tab_arfa.clie_3 = long(trim(ki_st_open_w.key1))
	end if
//end if
	

//if dw_lista_0.getrow() > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	K_st_open_w.id_programma = kkg_id_programma_fatture
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = trim(string(kst_tab_arfa.id_fattura)) // id fattura
	K_st_open_w.key2 = trim(string(kst_tab_arfa.clie_3)) // cod cliente
	K_st_open_w.key3 = " " 
	K_st_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(k_st_open_w)
	destroy kuf1_menu_window

								
//else
//
//	messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")
//
//end if

return (0)
end event

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_fatture_l
integer x = 1769
integer y = 1104
integer width = 827
integer height = 524
integer taborder = 50
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

type st_orizzontal from w_g_tab0`st_orizzontal within w_fatture_l
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_fatture_l
integer width = 2807
integer height = 708
integer taborder = 120
string dataobject = "d_arfa_l_2"
borderstyle borderstyle = stylelowered!
end type

type dw_guida from w_g_tab0`dw_guida within w_fatture_l
end type

type rb_prova from radiobutton within w_fatture_l
boolean visible = false
integer x = 165
integer y = 1484
integer width = 818
integer height = 80
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "stampa di Prova / Duplicato"
boolean checked = true
end type

type rb_definitiva from radiobutton within w_fatture_l
boolean visible = false
integer x = 165
integer y = 1572
integer width = 539
integer height = 80
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "stampa Definitiva"
end type

type cb_stampa_ok from commandbutton within w_fatture_l
boolean visible = false
integer x = 165
integer y = 1688
integer width = 201
integer height = 72
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ok"
end type

event clicked;//
pointer oldpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)

//
gb_stampa.visible = false
rb_prova.visible = false
rb_definitiva.visible = false
cb_stampa_ok.visible = false
cb_stampa_annulla.visible = false

stampa_fatture_lancia()

SetPointer(oldpointer)


end event

type cb_stampa_annulla from commandbutton within w_fatture_l
boolean visible = false
integer x = 672
integer y = 1688
integer width = 279
integer height = 72
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
end type

event clicked;//
gb_stampa.visible = false
rb_prova.visible = false
rb_definitiva.visible = false
cb_stampa_ok.visible = false
cb_stampa_annulla.visible = false

end event

type dw_periodo from uo_dw_periodo within w_fatture_l
integer x = 91
integer y = 868
integer taborder = 130
boolean bringtotop = true
end type

event ue_clicked;call super::ue_clicked;//
inizializza( )

end event

type gb_stampa from groupbox within w_fatture_l
boolean visible = false
integer x = 87
integer y = 1396
integer width = 946
integer height = 404
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Stampa e Aggiorna"
end type

