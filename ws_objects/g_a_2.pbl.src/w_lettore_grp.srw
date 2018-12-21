$PBExportHeader$w_lettore_grp.srw
forward
global type w_lettore_grp from w_g_tab0
end type
type dw_modifica from uo_dw_modifica_giri_barcode within w_lettore_grp
end type
end forward

global type w_lettore_grp from w_g_tab0
integer width = 3570
integer height = 1612
string title = "Groupage da Palmare"
boolean ki_toolbar_window_presente = true
dw_modifica dw_modifica
end type
global w_lettore_grp w_lettore_grp

type variables
//
kuf_lettore_grp kiuf1_lettore_grp
private string ki_mostra_nascondi_in_lista = "S" 
private boolean ki_modifica_giri = false
private datawindow kidw_x_modifica_giri

end variables

forward prototypes
public function string inizializza ()
private function string cancella ()
private function integer visualizza ()
protected function string check_dati ()
protected function integer modifica ()
protected subroutine open_start_window ()
protected subroutine riempi_id ()
private subroutine modifica_giri (string k_modalita_modifica_file)
protected subroutine smista_funz (string k_par_in)
protected subroutine attiva_menu ()
private subroutine abilita_modifica_giri ()
public function integer aggiorna_groupage ()
public function integer u_delete_file_all ()
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
string k_codice 
int k_importa = 0
pointer oldpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


//--- eventualmente ho passato il Barcode
	if LenA(trim(ki_st_open_w.key1)) = 0 then
		k_codice = ""
	else
		k_codice = trim(ki_st_open_w.key1)
	end if


////=== Legge le righe del dw salvate l'ultima volta (importfile)
//	if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima volta il tasto e' false 
//
//		k_importa = kGuf_data_base.dw_importfile(trim(ki_syntaxquery), dw_lista_0)
//
//	end if
		
	if k_importa <= 0 then // Nessuna importazione eseguita

//--- provo ad importare i nuovi Groupage dalla Cartella comune con il lettore
		kiuf1_lettore_grp.popola_tab_lettore_grp()

		if dw_lista_0.retrieve()  < 1 then //k_codice, 0, 0, 0, 0) < 1 then
			k_return = "1Nessun Groupage Trovato "

			SetPointer(oldpointer)
			
			if k_codice = "" then k_codice = "ricerca completa"
			messagebox("Lista Archivio Groupage da Lettore Vuota", &
					"Nessun Codice Trovato per la richiesta fatta (" + k_codice + ") ")
		end if

	end if		



return k_return



end function

private function string cancella ();//
string k_return="0 "
string k_descr
long k_codice
//string k_errore = "0 ", k_errore1 = "0 "
long k_riga
st_esito kst_esito
st_tab_lettore_grp kst_tab_lettore_grp



//--- cancello tutto il grp se il 'fuoco' e sul primo dw 
k_riga = dw_dett_0.rowcount()	
if k_riga = 0 then
	k_riga = dw_lista_0.rowcount()	
end if
if k_riga > 0 then
	if kidw_selezionata.dataobject = "d_lettore_grp_padri_l" then
		dw_lista_0.setrow(dw_lista_0.getselectedrow( 0 ))
		k_riga = dw_lista_0.getrow( )
		kst_tab_lettore_grp.id = 0
		kst_tab_lettore_grp.padre = dw_lista_0.getitemstring(k_riga, "barcode")
		kst_tab_lettore_grp.timestamp_inizio = dw_lista_0.getitemstring(k_riga, "timestamp_inizio")
		k_descr = "L'intero Groupade del Barcode padre " +  kst_tab_lettore_grp.padre
	else
		dw_dett_0.setrow(dw_dett_0.getselectedrow( 0 ))
		k_riga = dw_dett_0.getrow( )
		kst_tab_lettore_grp.id = dw_dett_0.getitemnumber(k_riga, "id")
		kst_tab_lettore_grp.padre = ""
		kst_tab_lettore_grp.timestamp_inizio = ""
		k_descr = "il solo Barcode Figlio " +  dw_dett_0.getitemstring(k_riga, "barcode")
	end if
end if

if isnull(k_descr) = true or trim(k_descr) = "" then
	k_descr = "Nessuna denominazione" 
end if

if k_riga > 0 and isnull(k_codice) = false then	
	
//=== Richiesta di conferma della eliminazione del rek

	if messagebox("Elimina Groupage", "Sei sicuro di voler Cancellare il~n~r" &
				+ "~n~r" + trim(k_descr), &
				question!, yesno!, 2) = 1 then
 
//=== Cancella !!!

		 if kst_tab_lettore_grp.id > 0 then
			kst_esito = kiuf1_lettore_grp.tb_delete(kst_tab_lettore_grp) 
		else
			kst_esito = kiuf1_lettore_grp.tb_delete_all(kst_tab_lettore_grp) 
		end if
	
		if kst_esito.esito <> kkg_esito.ok then
			k_return = "1"
			messagebox("Problemi durante Cancellazione - Operazione fallita", &
						   "Errore cod. " + string(kst_esito.esito) + "~n~r" + trim(kst_esito.sqlerrtext), &
							stopsign!) 	

		else

			if kidw_selezionata.dataobject = "d_lettore_grp_padri_l" then
				
//--- cancello riga a video
				if k_riga > 0 then
					dw_lista_0.deleterow(k_riga)
					dw_dett_0.reset( )
				end if
				if k_riga >= dw_lista_0.rowcount() then
					dw_lista_0.selectrow(k_riga, true)
					dw_lista_0.setrow( k_riga)
					dw_lista_0.setfocus()
				end if
				if dw_lista_0.rowcount() > 0 then
					if k_riga > dw_lista_0.rowcount() then
						k_riga = dw_lista_0.rowcount()
					end if
					if k_riga > 0 then
						dw_lista_0.selectrow(k_riga, true)
						dw_lista_0.setrow( k_riga)
					end if
				end if
			else
				if k_riga > 0 then
					dw_dett_0.deleterow(k_riga)
				end if
				if dw_dett_0.rowcount() > 0 then
					if k_riga > dw_dett_0.rowcount() then
						k_riga = dw_dett_0.rowcount()
					end if
					if k_riga > 0 then
						dw_dett_0.selectrow(k_riga, true)
						dw_dett_0.setrow( k_riga)
					end if
					dw_dett_0.setfocus( )
				else
					dw_lista_0.setfocus( )
				end if
			end if

			attiva_tasti()
	

		end if
	else
		messagebox("Elimina Groupage", "Operazione Annullata !!")
	end if

//	dw_dett_0.setcolumn(1)

end if

return(k_return)
end function

private function integer visualizza ();//===
//=== Lettura del rek da modificare
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
int k_return, k_rc, k_taborder
long k_key
int k_ctr
string k_rc1="", k_style, k_colore
st_tab_lettore_grp kst_tab_lettore_grp
kuf_utility kuf1_utility



	kst_tab_lettore_grp.padre = dw_lista_0.getitemstring(dw_lista_0.getrow(), "barcode")
	kst_tab_lettore_grp.timestamp_inizio = dw_lista_0.getitemstring(dw_lista_0.getrow(), "timestamp_inizio")
	
	ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica 

	dw_dett_0.reset( )
	k_return = dw_dett_0.retrieve( kst_tab_lettore_grp.padre, kst_tab_lettore_grp.timestamp_inizio  ) 
	
	ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione 

////--- Attivo ddw 
//	datawindowchild kdwc_1
//	k_rc = dw_dett_0.getchild("barcode", kdwc_1)
//	k_rc = kdwc_1.settransobject(sqlca)
//	if kdwc_1.rowcount() = 0 then
//		kdwc_1.retrieve("*", 0, 0, 0, 0)
//	end if


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
long k_riga
//string k_key, k_rag_soc_10
//string k_descr, k_mc_co = "", k_sc_cf=""
//long k_codice, k_codice_1, k_clie
//string k_rag_soc




	k_riga = dw_dett_0.getrow()



	if isnull(dw_dett_0.getitemstring ( k_riga, "barcode")) then
		k_return = k_return + "Manca il barcode figlio '" + &
		             trim(dw_dett_0.object.descr_t.text) + "'~n~r" 
		k_errore = "3"
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
st_tab_lettore_grp kst_tab_lettore_grp
kuf_utility kuf1_utility	

//datawindowchild kdwc_clienti_d

	kst_tab_lettore_grp.padre = dw_lista_0.getitemstring(dw_lista_0.getrow(), "barcode")
	kst_tab_lettore_grp.timestamp_inizio = dw_lista_0.getitemstring(dw_lista_0.getrow(), "timestamp_inizio")
	
	ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica 

	k_return = dw_dett_0.retrieve( kst_tab_lettore_grp.padre, kst_tab_lettore_grp.timestamp_inizio  ) 

//--- Attivo ddw 
	datawindowchild kdwc_1
	k_rc = dw_dett_0.getchild("barcode", kdwc_1)
	k_rc = kdwc_1.settransobject(sqlca)
	if kdwc_1.rowcount() = 0 then
		kdwc_1.retrieve("*", 0, 0, 0, 0)
	end if

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

protected subroutine open_start_window ();//
kiuf1_lettore_grp = create kuf_lettore_grp

//--- abilito la mod dei giri su barcode?
abilita_modifica_giri()




end subroutine

protected subroutine riempi_id ();//
long k_riga=0
int k_rc

//--- imposta campi automatici
if dw_dett_0.rowcount( ) > 0 then
	k_riga = dw_dett_0.getselectedrow( 0 )
	if k_riga = 0 then
		k_riga = 1
		dw_dett_0.selectrow( k_riga, true)
	end if
	k_rc=dw_dett_0.setitem(k_riga, "x_datins", kGuf_data_base.prendi_x_datins())
	k_rc=dw_dett_0.setitem(k_riga, "x_utente", kGuf_data_base.prendi_x_utente())
end if


end subroutine

private subroutine modifica_giri (string k_modalita_modifica_file);//
//--- k_modalita_modifica_file: 1=modalità modifica giri fila 1 e 2 
//
integer k_rec, k_riga
string k_dw_fuoco_nome
string k_aggiorna_rif
line kline_1
st_esito kst_esito
st_tab_barcode kst_tab_barcode
kuf_barcode kuf1_barcode
datawindow kidw_barcode_da_non_modificare


			
//if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica &
//   or ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then

//--- valorizza la dw sulla quale fare la modifica
	kidw_x_modifica_giri = kidw_selezionata
	setnull(kidw_barcode_da_non_modificare)

	dw_modifica.ki_modif_tutto_riferimento = dw_modifica.ki_modif_tutto_riferimento_no
	
	k_dw_fuoco_nome = kidw_selezionata.dataobject 

	choose case k_dw_fuoco_nome

		case "d_lettore_grp_padri_l"
			k_riga = dw_lista_0.getselectedrow( 0)
			if k_riga > 0 then
				kst_tab_barcode.barcode = dw_lista_0.object.barcode[k_riga]
			end if
			
		case "d_lettore_grp_figli_l"
			k_riga = dw_dett_0.getselectedrow( 0)
			if k_riga > 0 then
				kst_tab_barcode.barcode = dw_dett_0.object.barcode[k_riga]
			end if

	end choose


//--- leggo i dati delbarcode				
			kuf1_barcode = create kuf_barcode
			kst_esito = kuf1_barcode.select_barcode (kst_tab_barcode)
			destroy kuf1_barcode
			if kst_esito.esito <> kkg_esito.ok then
				k_riga = 0
			end if
				
//				k_riga = dw_barcode.getrow() 
//				if k_riga > 0 then		
//					kst_tab_barcode.pl_barcode = 0
//					kst_tab_barcode.barcode = dw_barcode.object.barcode_barcode.primary[k_riga]
//					kst_tab_barcode.num_int = dw_barcode.object.barcode_num_int.primary[k_riga]
//					kst_tab_barcode.data_int = dw_barcode.object.barcode_data_int.primary[k_riga]
//					kst_tab_barcode.fila_1 = dw_barcode.object.barcode_fila_1.primary[k_riga]
//					kst_tab_barcode.fila_1p = dw_barcode.object.barcode_fila_1p.primary[k_riga]
//					kst_tab_barcode.fila_2 = dw_barcode.object.barcode_fila_2.primary[k_riga]
//					kst_tab_barcode.fila_2p = dw_barcode.object.barcode_fila_2p.primary[k_riga]
//				end if	
//					
//
//	
//			end if			
//

	if k_riga > 0 then

		dw_modifica.modifica_giri(&
										kst_tab_barcode &
										,k_modalita_modifica_file &
										,dw_modifica.ki_modif_tutto_riferimento &
										,kidw_x_modifica_giri &
										,kidw_barcode_da_non_modificare &
										)
										
		
	else
		messagebox("Modifica Cicli di Trattamento", &
						"Selezionare una riga nella lista")
	end if	

//else
//	messagebox("Modifica non permessa", &
//						"In questa modalita' non e' consentita la modifica dei dati")
//end if
	 


end subroutine

protected subroutine smista_funz (string k_par_in);//---
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//===

choose case LeftA(k_par_in, 2) 


	case KKG_FLAG_RICHIESTA.libero1		//Importa i nuovi GRP
		leggi_liste()


	case KKG_FLAG_RICHIESTA.libero2		//modifica i cilci del riferimento
//--- controlle se consentito solo visualizzazione
//		if dw_modifica.ki_modifica_cicli_enabled = dw_modifica.ki_modifica_cicli_enabled_visualizzazione then
//			modifica_giri(dw_modifica.ki_modalita_modifica_giri_visualizza)
//		else
//			if dw_modifica.ki_modifica_cicli_enabled = dw_modifica.ki_modifica_cicli_enabled_modif then
				modifica_giri(dw_modifica.ki_modalita_modifica_giri_riga)
//			end if
//		end if

	case KKG_FLAG_RICHIESTA.libero5		//delete all file
		u_delete_file_all( )

	case KKG_FLAG_RICHIESTA.libero8		//Mette i Barcode in GRP
		aggiorna_groupage()



	case else // standard
		super::smista_funz(k_par_in)
		
end choose



end subroutine

protected subroutine attiva_menu ();//--- Attiva/Dis. Voci di menu


//--- ricopre lo standard
	if not ki_menu.m_finestra.m_fin_dettaglio.enabled then
		ki_menu.m_finestra.m_fin_dettaglio.enabled = true
		ki_menu.m_finestra.m_fin_dettaglio.toolbaritemvisible = true
	end if


//
//--- Attiva/Dis. Voci di menu personalizzate
//
//if not ki_menu.m_strumenti.m_fin_gest_libero1.visible then
//	ki_menu.m_strumenti.m_fin_gest_libero1.text = "Importa nuovi Groupage del Palmare"
//	ki_menu.m_strumenti.m_fin_gest_libero1.microhelp = "Importa nuovi Groupage del Palmare"
//	ki_menu.m_strumenti.m_fin_gest_libero1.visible = true
//	ki_menu.m_strumenti.m_fin_gest_libero1.enabled = true
//	ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
//	ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText = "Importa,Importa nuovi Groupage del Palmare"+ki_menu.m_strumenti.m_fin_gest_libero1.text
//	ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName = "Regenerate!"
//	ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
//end if	

if not ki_menu.m_strumenti.m_fin_gest_libero2.visible then
	ki_menu.m_strumenti.m_fin_gest_libero2.text = "&Cicli di Lavorazione"
	ki_menu.m_strumenti.m_fin_gest_libero2.microhelp = 	"Visualizza/Modifica i cicli di trattamento del Barcode/intero Riferimento di Entrata   "
	ki_menu.m_strumenti.m_fin_gest_libero2.enabled = ki_modifica_giri
	ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemtext = "Giri,"+ ki_menu.m_strumenti.m_fin_gest_libero2.text
	ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemvisible = true
	ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
	//ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemname = kGuo_path.get_risorse() + "\cicli.bmp"
	ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemname = "cicli.bmp"
	ki_menu.m_strumenti.m_fin_gest_libero2.visible = true
end if

if not ki_menu.m_strumenti.m_fin_gest_libero5.visible then
	ki_menu.m_strumenti.m_fin_gest_libero5.text = "&Svuota Cartella"
	ki_menu.m_strumenti.m_fin_gest_libero5.microhelp = "Cancella tutti i file nella cartella dei Groupage generati dai lettori di barcode"
	ki_menu.m_strumenti.m_fin_gest_libero5.enabled = true
	ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemtext = "Svuota,"+ ki_menu.m_strumenti.m_fin_gest_libero5.text
	ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemvisible = true
	ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritembarindex=2
	//ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemname = kGuo_path.get_risorse() + "\cicli.bmp"
	ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemname = "Delete_2!"
	ki_menu.m_strumenti.m_fin_gest_libero5.visible = true
end if

if not ki_menu.m_strumenti.m_fin_gest_libero8.visible then
	ki_menu.m_strumenti.m_fin_gest_libero8.text = "Crea il Groupage, aggiorna i Barcode "
	ki_menu.m_strumenti.m_fin_gest_libero8.microhelp =  "Crea il Groupage, aggiorna i Giri nel Barcode e crea il Groupage"
	ki_menu.m_strumenti.m_fin_gest_libero8.visible = true
	ki_menu.m_strumenti.m_fin_gest_libero8.enabled = true
	ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritemVisible = true
	ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritemText = "Crea,"+ki_menu.m_strumenti.m_fin_gest_libero8.text
	ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritemName = "CheckIn5!"
	ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritembarindex=2
end if	


//---
	super::attiva_menu()



end subroutine

private subroutine abilita_modifica_giri ();//
//--- controllo autorizzazione x cambio giri di lavorazione
//

	try

		ki_modifica_giri = dw_modifica.autorizza_modifica_giri()
	
		if dw_modifica.ki_modifica_cicli_enabled = dw_modifica.ki_modifica_cicli_enabled_modif &
			and trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.inserimento &
			and trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.modifica then
			dw_modifica.ki_modifica_cicli_enabled = dw_modifica.ki_modifica_cicli_enabled_visualizzazione
		end if


	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()			
		ki_modifica_giri = false
		dw_modifica.ki_modifica_cicli_enabled = dw_modifica.ki_modifica_cicli_enabled_visualizzazione
		
	finally			
	end try

end subroutine

public function integer aggiorna_groupage ();//---
//--- Mette in Groupage i Barcode (se tutto ok!)
//---
integer k_return = 0
long k_riga=0, k_riga_figli=0
integer k_nr_grp=0
boolean k_aggiorna_db=false
st_tab_barcode kst_tab_barcode_padre, kst_tab_barcode_figlio
st_tab_lettore_grp kst_tab_lettore_grp
kuf_barcode kuf1_barcode
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


k_riga = dw_lista_0.getselectedrow( 0 )
if k_riga > 0 then

	kuf1_barcode = create kuf_barcode

	do while k_riga > 0 
	
			
		kst_tab_barcode_padre.barcode = trim(dw_lista_0.object.barcode[k_riga])  // piglia il PADRE
		kst_tab_barcode_padre.pl_barcode = dw_lista_0.object.pl_barcode[k_riga]
		
		dw_lista_0.setrow( k_riga )  //--- mette il fuoco x fare il VISUALIZZA()
		
		if visualizza( ) > 0 then  // legge i figli
		
			try 

//--- controllo se il barcode può essere PADRE 
				if kuf1_barcode.if_essere_barcode_padre(kst_tab_barcode_padre) then
					
//--- piglia i dati del padre
					kst_tab_barcode_padre.barcode = trim(dw_lista_0.object.barcode[k_riga])
					kuf1_barcode.select_barcode_trattamento(kst_tab_barcode_padre)

//--- controlla se GRP possibile			
					for k_riga_figli = 1 to dw_dett_0.rowcount( )
						
						kst_tab_barcode_figlio.barcode = trim(dw_dett_0.object.barcode[k_riga_figli])
						kst_tab_barcode_figlio.tipo_cicli = dw_dett_0.object.barcode_tipo_cicli[k_riga_figli]
						kst_tab_barcode_figlio.pl_barcode = dw_dett_0.object.pl_barcode[k_riga_figli]
						kst_tab_barcode_figlio.fila_1 = dw_dett_0.object.barcode_fila_1[k_riga_figli]
						kst_tab_barcode_figlio.fila_1p = dw_dett_0.object.barcode_fila_1p[k_riga_figli]
						kst_tab_barcode_figlio.fila_2 = dw_dett_0.object.barcode_fila_2[k_riga_figli]
						kst_tab_barcode_figlio.fila_2p = dw_dett_0.object.barcode_fila_2p[k_riga_figli]

//--- controllo se i barcode possono diventare PADRE e FIGLIO 
						if NOT kuf1_barcode.if_essere_barcode_figlio(kst_tab_barcode_figlio, kst_tab_barcode_padre) then
							kst_esito.esito = kkg_esito.db_ko
							kst_esito.sqlerrtext = "Barcode Figlio non possibile: " + kst_tab_barcode_figlio.barcode 
						end if

//--- AGGIORNA TABELLE: GIRI DEL FIGLIO				
//							dw_modifica.reset( )  // x sicurezza lo resetto così non piglia valori strani
//							if not dw_modifica.aggiorna_barcode_giri_esegui(kst_tab_barcode_figlio) then
//								kst_esito.esito = kkg_esito.db_ko
//								kst_esito.sqlerrtext = "Barcode Figlio non aggiornato: " + kst_tab_barcode_figlio.barcode 
//								exit    // ERRORE USCITA CICLO	
//							end if
							
						
					end for
				else
					kst_esito.esito = kkg_esito.db_ko
					kst_esito.sqlerrtext = "Barcode Padre non possibile: " + kst_tab_barcode_padre.barcode 
				end if
	
//				if kst_esito.esito = kkg_esito.ko then
//--- AGGIORNA TABELLE: GIRI DEL PADRE			
//					dw_modifica.reset( )  // x sicurezza lo resetto così non piglia valori strani
//					if not dw_modifica.aggiorna_barcode_giri_esegui(kst_tab_barcode_padre) then
//						kst_esito.esito = kkg_esito.db_ko
//						kst_esito.sqlerrtext = "Barcode Padre non aggiornato: " + kst_tab_barcode_padre.barcode 
//					end if
//				end if

//--- Se tutto OK aggiunge il GRP
				if kst_esito.esito = kkg_esito.ok then
					for k_riga_figli = 1 to dw_dett_0.rowcount( )
						
						kst_tab_barcode_figlio.barcode = trim(dw_dett_0.object.barcode[k_riga_figli])
						kst_tab_barcode_figlio.barcode_lav = kst_tab_barcode_padre.barcode
						
						kst_esito = kuf1_barcode.tb_aggiungi_figlio(kst_tab_barcode_figlio) // AGGIORNA TABELLE BARCODE
						if kst_esito.esito = kkg_esito.ok then
							k_aggiorna_db = true
						end if

					end for
				
//--- Toglie dall'archivio  LETTORE_GRP  il GRP  appena  impostato nei Barcode
					kst_tab_lettore_grp.padre = trim(kst_tab_barcode_padre.barcode)
					kst_tab_lettore_grp.timestamp_inizio = trim(dw_lista_0.object.timestamp_inizio[k_riga])
					kst_tab_lettore_grp.st_tab_g_0.esegui_commit = "N"
					kst_esito = kiuf1_lettore_grp.tb_delete_all(kst_tab_lettore_grp)
					
					if kst_esito.esito = kkg_esito.ok then
						dw_lista_0.deleterow(k_riga)
						dw_dett_0.reset( )
						k_riga --
						k_nr_grp++  // semplicemente il nr groupage generati
					end if
					
				else
					
					kguo_exception.set_esito(kst_esito)
					kguo_exception.messaggio_utente()
					
				end if
	
//---- COMMIT se tutto OK....	
				if k_aggiorna_db then
					kGuf_data_base.db_commit_1( )
				else
					kGuf_data_base.db_rollback_1( )
				end if
	
			catch (uo_exception kuo_exception)
				kuo_exception.messaggio_utente()
//--- Rollback				
				if k_aggiorna_db then
					kGuf_data_base.db_rollback_1( )
				end if
				
				
			end try
			
		end if
	
		k_riga = dw_lista_0.getselectedrow( k_riga )
	
	loop
	

	
	destroy kuf1_barcode

	if k_nr_grp > 0 then
		kguo_exception.inizializza( )
		kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_ok )
		kguo_exception.setmessage( "Operazione Conclusa, generati " + string(k_nr_grp) + " Groupage. " )
		kguo_exception.messaggio_utente( )
	end if

else
	kguo_exception.inizializza( )
	kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_generico )
	kguo_exception.setmessage( "Selezionare almeno un Groupage dall'elenco ")
	kguo_exception.messaggio_utente( )
	
end if


k_return = k_nr_grp

return k_return


end function

public function integer u_delete_file_all ();//
int k_return
int k_resp, k_file_deleted


try
	
	k_resp = messagebox("Rimozione Archivi", "Procedere con la completa cancellazione di tutti i file presenti nella cartella dei Groupage. I dati protrebbero ancora non essere stati importati.", question!, yesno!, 2) 
	if k_resp = 1 then

		setpointer(kkg.pointer_attesa)

		k_file_deleted = kiuf1_lettore_grp.u_delete_file_all( )
		
		setpointer(kkg.pointer_default)
		
		if k_file_deleted > 0 then
			messagebox("Operazione Conclusa", "Sono stati cancellati " + string(k_file_deleted) + " file.", information!)
		else
			messagebox("Operazione Conclusa", "Non sono stati trovati file da cancellare.", information!)
		end if
		
		k_return = k_file_deleted
		
	end if

catch(uo_exception kuo_exception)
	setpointer(kkg.pointer_default)
	messagebox("Operazione Interrotta", "Si sono verificati degli errori durante la cancellazione dei file di groupage. Errore: " + trim(kuo_exception.get_errtext( )) , information!)

end try

return k_return

end function

on w_lettore_grp.create
int iCurrent
call super::create
this.dw_modifica=create dw_modifica
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_modifica
end on

on w_lettore_grp.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_modifica)
end on

event close;call super::close;//
if isvalid(kiuf1_lettore_grp) then destroy kiuf1_lettore_grp

end event

type st_ritorna from w_g_tab0`st_ritorna within w_lettore_grp
integer x = 2821
integer y = 980
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_lettore_grp
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_lettore_grp
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_lettore_grp
integer x = 2880
integer y = 1768
end type

type st_stampa from w_g_tab0`st_stampa within w_lettore_grp
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_lettore_grp
integer x = 2834
integer y = 1664
end type

type cb_modifica from w_g_tab0`cb_modifica within w_lettore_grp
integer x = 2926
integer y = 1240
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_lettore_grp
integer x = 2894
integer y = 1536
end type

type cb_cancella from w_g_tab0`cb_cancella within w_lettore_grp
integer x = 2880
integer y = 1384
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_lettore_grp
integer x = 2907
integer y = 1092
boolean enabled = false
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_lettore_grp
integer y = 1116
integer width = 2779
integer height = 768
boolean enabled = true
string dataobject = "d_lettore_grp_figli_l"
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_attiva_standard_select_row = true
boolean ki_d_std_1_attiva_cerca = true
end type

type st_orizzontal from w_g_tab0`st_orizzontal within w_lettore_grp
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_lettore_grp
integer width = 3291
integer height = 1024
string dataobject = "d_lettore_grp_padri_l"
boolean hscrollbar = false
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_sempre_possibile = true
end type

type dw_guida from w_g_tab0`dw_guida within w_lettore_grp
end type

type dw_modifica from uo_dw_modifica_giri_barcode within w_lettore_grp
integer x = 23
integer y = 320
integer width = 3479
integer height = 688
integer taborder = 110
boolean bringtotop = true
boolean enabled = true
end type

