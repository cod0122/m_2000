$PBExportHeader$w_barcode_associa_dosimetria.srw
forward
global type w_barcode_associa_dosimetria from w_g_tab0
end type
end forward

global type w_barcode_associa_dosimetria from w_g_tab0
boolean ki_esponi_msg_dati_modificati = false
boolean ki_sincronizza_window_consenti = false
boolean ki_resize_inizializza_y = false
boolean ki_riparte_dopo_save_ok = true
boolean ki_reset_dopo_save_ok = false
end type
global w_barcode_associa_dosimetria w_barcode_associa_dosimetria

type variables

private kuf_meca_dosim_barcode kiuf_meca_dosim_barcode
private kuf_armo kiuf_armo
private st_tab_meca_dosim kist_tab_meca_dosim
private int ki_len_barcode_pkl = 8
private int ki_len_barcode = 8
private datastore ki_ds_dosimetrie_x_tipo
private long ki_row_old
end variables

forward prototypes
protected function string check_dati ()
protected function string inizializza () throws uo_exception
protected subroutine open_start_window ()
protected function string aggiorna_tabelle ()
public subroutine pulizia_righe ()
protected function integer inserisci ()
public function boolean u_check_dosim_tipo (long k_row)
end prototypes

protected function string check_dati ();//
//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK con errori non gravi
//===                : 5=OK con avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================
//
string k_return ="0" 
long k_riga, k_righe, k_riga_find
st_tab_meca_dosim kst_tab_meca_dosim, kst_tab_meca_dosim_Barcode, kst_tab_meca_dosim_Dosimetro
st_tab_meca kst_tab_meca
st_esito kst_esito 


kst_esito.esito = kkg_esito.ok  
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try

//	dw_dett_0.object.t_info.visible = false
//	dw_dett_0.object.t_info.text = ""

	k_righe = dw_dett_0.rowcount()

//--- Controllo che non abbia digitato lo stesso codice su più righe	
	for k_riga = 1 to (k_righe - 1)
		dw_dett_0.setitem(k_riga,"t_info", "")

		kst_tab_meca_dosim_Barcode.barcode = trim(dw_dett_0.getitemstring(k_riga, "meca_dosim_barcode"))    // PRIMA COLONNA
		if (kst_tab_meca_dosim_Barcode.barcode) > " " then
			for k_riga_find = (k_riga + 1) to k_righe 
				if kst_tab_meca_dosim_Barcode.barcode = trim(dw_dett_0.getitemstring(k_riga_find, "meca_dosim_barcode")) &
						or kst_tab_meca_dosim_Barcode.barcode = trim(dw_dett_0.getitemstring(k_riga_find, "barcode_dosimetro")) then
					kst_esito.esito = kkg_esito.ko
					kst_esito.sqlerrtext = "codice Barcode " + trim(kst_tab_meca_dosim_Barcode.barcode) + " presente su più righe! "
					dw_dett_0.setitem (k_riga, "t_info", "BARCODE SU PIU' RIGHE!!")
				end if
			next	
		end if
		kst_tab_meca_dosim_Dosimetro.barcode_dosimetro = trim(dw_dett_0.getitemstring(k_riga, "barcode_dosimetro"))   // SECONDA COLONNA
		if (kst_tab_meca_dosim_Dosimetro.barcode_dosimetro) > " " then
			for k_riga_find = (k_riga + 1) to k_righe 
				if kst_tab_meca_dosim_Dosimetro.barcode_dosimetro = trim(dw_dett_0.getitemstring(k_riga_find, "meca_dosim_barcode")) &
						or kst_tab_meca_dosim_Dosimetro.barcode_dosimetro = trim(dw_dett_0.getitemstring(k_riga_find, "barcode_dosimetro")) then
					kst_esito.esito = kkg_esito.ko
					kst_esito.sqlerrtext = "codice Barcode " + trim(kst_tab_meca_dosim_Dosimetro.barcode_dosimetro) + " presente su più righe! "
					dw_dett_0.setitem (k_riga, "t_info", "BARCODE SU PIU' RIGHE!!")
				end if
			next	
		end if
	next
	dw_dett_0.setitem(k_riga,"t_info", "")
	
// prosegue i controlli
	for k_riga = 1 to k_righe

//--- controlla solo le righe senza errori precedenti		
		if trim(dw_dett_0.getitemstring(k_riga, "t_info")) = "" then
			kst_tab_meca_dosim_Barcode.id_meca = 0
			kst_tab_meca_dosim_Barcode.barcode = ""
			kst_tab_meca_dosim_Dosimetro.barcode_dosimetro = ""

//--- probabile Barcode interno su prima colonna e Dosimetro sulla seconda
			kst_tab_meca_dosim_Barcode.barcode = dw_dett_0.getitemstring(k_riga, "meca_dosim_barcode")   // PRIMA COLONNA
			kst_tab_meca_dosim_Dosimetro.barcode_dosimetro = dw_dett_0.getitemstring(k_riga, "barcode_dosimetro")   // SECONDA COLONNA
	
//--- esiste il barcode?
//--- cerco dalla prima colonna
			kst_tab_meca_dosim.id_meca = 0
			if len(trim(kst_tab_meca_dosim_Barcode.barcode)) > 0 then
				kst_tab_meca_dosim.barcode = kst_tab_meca_dosim_Barcode.barcode
				if kiuf_meca_dosim_barcode.get_id_meca_da_barcode(kst_tab_meca_dosim) then
					
					kst_tab_meca_dosim_Barcode.id_meca = kst_tab_meca_dosim.id_meca
					kst_tab_meca_dosim_Barcode.barcode = kst_tab_meca_dosim.barcode
					
				else
		
//--- se non trovato cerco dalla seconda colonna
	
					kst_tab_meca_dosim.id_meca = 0
					kst_tab_meca_dosim.barcode = dw_dett_0.object.barcode_dosimetro[k_riga]
					if len(trim(kst_tab_meca_dosim.barcode)) > 0 then
						
						if kiuf_meca_dosim_barcode.get_id_meca_da_barcode(kst_tab_meca_dosim) then
							
							kst_tab_meca_dosim_Barcode.id_meca = kst_tab_meca_dosim.id_meca
							kst_tab_meca_dosim_Barcode.barcode = kst_tab_meca_dosim.barcode
						
//--- Il barcode interno e' sulla seconda colonna quindi forse il Dosimetro dovrebbe essere sulla prima colonna
							kst_tab_meca_dosim_Dosimetro.barcode_dosimetro = kst_tab_meca_dosim.barcode
							if isnull(kst_tab_meca_dosim_Dosimetro.barcode_dosimetro) then kst_tab_meca_dosim_Dosimetro.barcode_dosimetro = ""
		
						else
							kst_tab_meca_dosim_Barcode.barcode = ""   // NON TROVATO!!
						end if
					end if
				end if
			end if
		
		
			if len(trim(kst_tab_meca_dosim_Barcode.barcode)) = 0 then
//--- se non anora trovato: ERRORE
				kst_esito.esito = kkg_esito.not_fnd
				kst_esito.sqlerrtext = "Barcode interno non Trovato, probabile digitazione errata! "
				kst_esito.sqlcode = 0
				dw_dett_0.setitem (k_riga, "t_info", "BARCODE NON TROVATO")
			
			else
		
//--- Se trovato proseguo con i controlli

				kst_tab_meca.id = kst_tab_meca_dosim_Barcode.id_meca
				kiuf_armo.get_num_int(kst_tab_meca)
			
//--- Imposta dati Lotto in mappa
				dw_dett_0.setitem (k_riga, "id_meca", kst_tab_meca.id)
				dw_dett_0.setitem (k_riga, "num_int", kst_tab_meca.num_int)
				dw_dett_0.setitem (k_riga, "data_int", kst_tab_meca.data_int)
	
//--- esiste il Dosimetro?
				kst_tab_meca_dosim.id_meca = 0
				kst_tab_meca_dosim.barcode_dosimetro = kst_tab_meca_dosim_Dosimetro.barcode_dosimetro
				if len(trim(kst_tab_meca_dosim.barcode_dosimetro)) = 0 then
					
					//kst_esito.esito = kkg_esito.no_esecuzione
					//kst_esito.sqlerrtext = "Dosimetro non impostato, inutile salvare l'accoppiamento " 
					dw_dett_0.setitem (k_riga, "t_info", "DIGITARE IL DOSIMETRO")
			
				else
					
//--- trova il codice Dosimetro in TAB spero che i dati siano quelli su cui sto lavorando ora....
					if kiuf_meca_dosim_barcode.if_esiste_barcode_dosimetro(kst_tab_meca_dosim) then
						
						kst_tab_meca_dosim_Dosimetro.id_meca = kst_tab_meca_dosim.id_meca
					else
						kst_tab_meca_dosim_Dosimetro.barcode_dosimetro = kst_tab_meca_dosim.barcode_dosimetro
					end if
		
//--- se DOSIMETRO trovato spero appartenga allo stesso del barcode altrimenti ERRORE		
					if kst_tab_meca_dosim_Dosimetro.id_meca > 0 and  kst_tab_meca_dosim_Barcode.id_meca <> kst_tab_meca_dosim_Dosimetro.id_meca then
						kst_tab_meca.id = kst_tab_meca_dosim_Dosimetro.id_meca
						kiuf_armo.get_num_int(kst_tab_meca)
						kst_esito.esito = kkg_esito.not_fnd
						kst_esito.sqlerrtext = "Dosimetro già utilizzato in altro Lotto, cambiare il codice o rimuoverlo dal " + string(kst_tab_meca.num_int) + " del " + string(kst_tab_meca.data_int)
						kst_esito.sqlcode = 0
						dw_dett_0.setitem (k_riga, "t_info", "DOSIMETRO GIA' UTILIZZATO!!")
					end if
			
//--- Se i barcode sono uguali qls non va...
					if trim(kst_tab_meca_dosim_Barcode.barcode) = trim(kst_tab_meca_dosim_Dosimetro.barcode_dosimetro) then
						kst_esito.esito = kkg_esito.no_esecuzione
						kst_esito.sqlerrtext = "Codici barcode uguali, controlla meglio! "
						dw_dett_0.setitem (k_riga, "t_info", "ERRORE CODICI UGUALI!!")
					end if
	
				end if

//--- barcode gia' usato?
				kst_tab_meca_dosim.id_meca = 0
				kst_tab_meca_dosim.barcode = kst_tab_meca_dosim_Barcode.barcode
				if kiuf_meca_dosim_barcode.if_gia_usato_barcode(kst_tab_meca_dosim) > 1 then
					kst_esito.esito = kkg_esito.ko
					kst_esito.sqlerrtext = "Barcode interno già utilizzato in altro Lotto, probabile digitazione errata! "
					kst_esito.sqlcode = 0
					dw_dett_0.setitem (k_riga, "t_info", "BARCODE GIA' UTILIZZATO!!")
				end if		
				
//--- barcode dosimetro coerente con il tipo (AMBER/RED)?
				if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.dati_wrn then
					if not u_check_dosim_tipo(k_riga) then
						kst_esito.esito = kkg_esito.dati_wrn
						kst_esito.sqlerrtext = "Il Dosimetro non sembra dello stesso tipo (" + dw_dett_0.getitemstring(k_riga, "dosim_tipo") + ")."
						kst_esito.sqlcode = 0
						dw_dett_0.setitem (k_riga, "t_info", "TIPO DOSIMETRO!!")
					end if
				end if
				
			end if
			
		
//--- Se Tutto OK	
			if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.dati_wrn then
	//			dw_dett_0.object.t_info.text = "OK!"
				dw_dett_0.setitem (k_riga, "meca_dosim_barcode", kst_tab_meca_dosim_Barcode.barcode )
				dw_dett_0.setitem (k_riga, "barcode_dosimetro", kst_tab_meca_dosim_Dosimetro.barcode_dosimetro )
			end if
		
//		if len(trim(dw_dett_0.object.t_info.text)) > 0 then
//			dw_dett_0.object.t_info.visible = true
//		end if

		end if
	next

//--- imposta esito OK dove vuoto
	for k_riga = 1 to k_righe
		if trim(dw_dett_0.getitemstring(k_riga, "t_info")) = "" then
			dw_dett_0.setitem (k_riga, "t_info", "OK!")
		end if
	next

catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	k_return = "1" + trim(kst_esito.sqlerrtext)  // ERRORE


finally
	
	if kst_esito.esito <> kkg_esito.ok then

		if kst_esito.esito = kkg_esito.no_esecuzione then

			k_return = "3" + trim(kst_esito.sqlerrtext)  // ERRORE
		else 
			if kst_esito.esito = kkg_esito.dati_wrn then
				k_return = "4" + trim(kst_esito.sqlerrtext)  // ERRORE WARNING
			else 
				k_return = "1" + trim(kst_esito.sqlerrtext)  // ERRORE
			end if
		end if
		
	end if
	
end try
	
	
return k_return	
	
	
end function

protected function string inizializza () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_return= "0"
long k_riga=0
kuf_utility kuf1_utility


try

//	dw_dett_0.object.t_info.visible = false

	if (kist_tab_meca_dosim.id_meca) > 0 then
		k_riga = dw_dett_0.retrieve(kist_tab_meca_dosim.id_meca ) 
	end if
		
	choose case k_riga

		case is < 0				
			messagebox("Operazione fallita", &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(Lotto cercato id: " + string(kist_tab_meca_dosim.id_meca) + ")~n~r" )
					
			k_return = "2"   // USCITA!

		case 0
			dw_dett_0.reset()
			if (kist_tab_meca_dosim.id_meca) > 0 then
				messagebox("Accoppiamento Dosimetri", &
						"Nessun barcode per la dosimetria trovato. Lotto senza dosimetri o barcode non ancora generati e/o stampati.~n~r" + &
						"Lotto cercato id: " + string(kist_tab_meca_dosim.id_meca) + "~n~r" )
				k_return = "2"   // USCITA!
			else
//			if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
				inserisci()
			end if
			
		case is > 0		
				if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
					messagebox("Accoppiamento Dosimetri", &
						"Attenzione il lotto ha già dei dosimetri accoppiati in archivio~n~r" + &
						"(Lotto cercato id:  " + string(kist_tab_meca_dosim.id_meca) + ")~n~r" )
		
					inserisci()
					
				else
					
					if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
				
						dw_dett_0.setrow(1)
						dw_dett_0.scrolltorow(1)
//						if trim(dw_dett_0.object.meca_dosim_barcode[1]) > " " then
//							dw_dett_0.setcolumn("meca_dosim_barcode")
//						end if
						
					end if
					
					dw_dett_0.setfocus()
				end if
					
		
	end choose

//	attiva_tasti()

//--- Inabilita campi alla modifica se Vsualizzazione
   kuf1_utility = create kuf_utility 
   if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.visualizzazione then
	
      kuf1_utility.u_proteggi_dw("1", 0, dw_lista_0)

	else		
		
//--- se Funzione MODIFICA
	   	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
			kuf1_utility.u_proteggi_dw("0", 0, dw_lista_0)
		end if

	end if
	destroy kuf1_utility

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if dw_dett_0.rowcount( ) > 0 then
		dw_dett_0.setrow(1)
		dw_dett_0.setcolumn("meca_dosim_barcode")
		dw_dett_0.setfocus( )
	end if

end try

return k_return

end function

protected subroutine open_start_window ();//

//--- crea oggetto da usare nell'intera window
	kiuf_meca_dosim_barcode = create kuf_meca_dosim_barcode
	kiuf_armo = create kuf_armo

//--- Salva Argomenti programma chiamante
	if isnumber(trim(ki_st_open_w.key1)) then // ID MECA
		kist_tab_meca_dosim.id_meca = long(trim(ki_st_open_w.key1))
		ki_exit_dopo_save_ok = TRUE // dopo save ESCO
	else
		kist_tab_meca_dosim.id_meca = 0
	end if

	ki_ds_dosimetrie_x_tipo = create datastore
	ki_ds_dosimetrie_x_tipo.dataobject = "ds_dosimetrie_x_tipo"
	ki_ds_dosimetrie_x_tipo.settransobject( kguo_sqlca_db_magazzino )
end subroutine

protected function string aggiorna_tabelle ();//
//=== Update delle Tabelle
string k_return = "0 "
long k_riga, k_righe
dwItemStatus k_status
st_tab_meca_dosim kst_tab_meca_dosim
st_esito kst_esito

	try 
	
		kst_esito.esito = kkg_esito.ok  
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = ""
		kst_esito.nome_oggetto = this.classname()

		k_righe = dw_dett_0.rowcount()
		for k_riga = 1 to k_righe
			k_status = dw_dett_0.getitemstatus(k_riga, 0, primary!)
			if k_status = DataModified! or k_status = New! or  k_status = NewModified! then
				kst_tab_meca_dosim.id_meca = dw_dett_0.object.id_meca[k_riga]
				kst_tab_meca_dosim.barcode_dosimetro = dw_dett_0.object.barcode_dosimetro[k_riga]
				kst_tab_meca_dosim.barcode = dw_dett_0.object.meca_dosim_barcode[k_riga]
				kiuf_meca_dosim_barcode.set_barcode_dosimetro(kst_tab_meca_dosim)
			end if
		next
		
		dw_dett_0.resetupdate( ) 
		
	catch(uo_exception kuo_exception)
	
		kst_esito = kuo_exception.get_st_esito()
		k_return = "1" + kst_esito.sqlerrtext
	
	end try

	
return k_return


end function

public subroutine pulizia_righe ();//
//=== pulizia righe
long k_riga, k_righe

	
	dw_dett_0.accepttext()

	k_righe = dw_dett_0.rowcount()
	for k_riga = k_righe to 1 step -1 
		if trim(dw_dett_0.getitemstring(k_riga, "meca_dosim_barcode")) > " " and trim(dw_dett_0.getitemstring(k_riga, "barcode_dosimetro")) > " " then
		else
			dw_dett_0.deleterow(k_riga)
		end if
	next
		
		

end subroutine

protected function integer inserisci ();//
long k_riga


k_riga = dw_dett_0.insertrow(0)
dw_dett_0.setrow(k_riga)
dw_dett_0.scrolltorow(k_riga)
dw_dett_0.setcolumn(1)

return k_riga
end function

public function boolean u_check_dosim_tipo (long k_row);//
boolean k_return = true
string k_dosim_tipo, k_barcode_dosimetro,  k_barcode_dosimetro2,  k_barcode_dosimetro1
long k_rows, k_row_i
int k_pos

		
		k_barcode_dosimetro = dw_dett_0.getitemstring(k_row, "barcode_dosimetro")
		if len(k_barcode_dosimetro) > 2 then
			k_barcode_dosimetro2 = left(k_barcode_dosimetro, 2)   // per quelli as esempio che iniziano per NW
			k_barcode_dosimetro1 = left(k_barcode_dosimetro, 1)   // per quelli ad esempio che iniziano per Y
			k_dosim_tipo = dw_dett_0.getitemstring(k_row, "dosim_tipo")
			k_rows = ki_ds_dosimetrie_x_tipo.rowcount( )
			if k_rows > 0 then
				if ki_ds_dosimetrie_x_tipo.getitemstring(k_row, "dosim_tipo") <> k_dosim_tipo then
					k_rows = ki_ds_dosimetrie_x_tipo.retrieve(k_dosim_tipo)
				end if
			else
				k_rows = ki_ds_dosimetrie_x_tipo.retrieve(k_dosim_tipo)
			end if
			for k_row_i = 1 to k_rows
				k_pos = pos(ki_ds_dosimetrie_x_tipo.getitemstring(k_row_i, "lotto_dosim"), k_barcode_dosimetro2) 
				if  k_pos = 0 then
					k_pos = pos(ki_ds_dosimetrie_x_tipo.getitemstring(k_row_i, "lotto_dosim"), k_barcode_dosimetro1) 
				end if
				if  k_pos > 0 then
					dw_dett_0.setitem(k_row, "k_border_color", kkg_colore.verde)
					exit
				end if
			next
			if k_row_i > k_rows then
				dw_dett_0.setitem(k_row, "k_border_color", kkg_colore.rosso)
				k_return = false
			end if
		else
			dw_dett_0.setitem(k_row, "k_border_color", kkg_colore.olive)
		end if

return k_return

end function

on w_barcode_associa_dosimetria.create
call super::create
end on

on w_barcode_associa_dosimetria.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;//
if isvalid(ki_ds_dosimetrie_x_tipo) then destroy ki_ds_dosimetrie_x_tipo

end event

type st_ritorna from w_g_tab0`st_ritorna within w_barcode_associa_dosimetria
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_barcode_associa_dosimetria
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_barcode_associa_dosimetria
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_barcode_associa_dosimetria
end type

type st_stampa from w_g_tab0`st_stampa within w_barcode_associa_dosimetria
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_barcode_associa_dosimetria
end type

type cb_modifica from w_g_tab0`cb_modifica within w_barcode_associa_dosimetria
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_barcode_associa_dosimetria
end type

type cb_cancella from w_g_tab0`cb_cancella within w_barcode_associa_dosimetria
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_barcode_associa_dosimetria
end type

event cb_inserisci::clicked;//
inserisci()

end event

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_barcode_associa_dosimetria
integer y = 128
integer height = 1184
boolean enabled = true
string dataobject = "d_barcode_accoppia_dosimetro"
boolean vscrollbar = false
string icon = "Database!"
boolean hsplitscroll = false
boolean ki_link_standard_attivi = false
boolean ki_button_standard_attivi = false
boolean ki_colora_riga_aggiornata = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_dw_visibile_in_open_window = true
end type

event dw_dett_0::editchanged;//
long k_row = 1, k_righe
st_tab_meca_dosim kst_tab_meca_dosim


choose case dwo.name
	
	case "meca_dosim_barcode"
		if len(data) = ki_len_barcode then
			this.accepttext( )
			if this.getitemnumber( 1, "id_meca") > 0 then
			else
				try
					kst_tab_meca_dosim.barcode = data
					if kiuf_meca_dosim_barcode.get_id_meca_da_barcode(kst_tab_meca_dosim) then
						k_righe = this.retrieve(kst_tab_meca_dosim.id_meca)
						k_row = this.find("meca_dosim_barcode = '" + trim(data) +"'", 1, k_righe)
						if k_row > 0 then
							this.setitem(k_row, "meca_dosim_barcode", data)
							this.setrow(k_row)
							this.scrolltorow(k_row)
						else
							this.setitem(1, "meca_dosim_barcode", "")
						end if
					end if
				catch (uo_exception kuo_exception)
				end try
			end if
			this.setcolumn("barcode_dosimetro")
		end if

	case "barcode_dosimetro"
		if len(data) = ki_len_barcode_pkl then
			this.accepttext( )
			k_righe = this.rowcount( )
			if row < k_righe then
				k_row = (row + 1)
				setrow(k_row)
				scrolltorow(k_row)
				this.setcolumn("meca_dosim_barcode")
			else
				//--- cerca una riga ancora da riempire
				k_row = this.find("barcode_dosimetro = ''", 1, k_righe)
				if k_row > 0 then
					setrow(k_row)
					scrolltorow(k_row)
					this.setcolumn("meca_dosim_barcode")
				else
					cb_aggiorna.event clicked( )
				end if
			end if
		end if

end choose
end event

event dw_dett_0::u_pigiato_enter;//
//--- per evitare che la PISTOLA influisca con il CRLF finale!
return -1
end event

event dw_dett_0::itemchanged;//
//
//string k_dosim_tipo, k_barcode_dosimetro
//long k_rows
//
//
//choose case dwo.name
//	
//	case "meca_dosim_barcode"
////		this.modify("r_border.pen.color = '" + string(kkg_colore.olive) + "' ")
//
//	case "barcode_dosimetro"
//
//end choose


end event

event dw_dett_0::itemfocuschanged;//



choose case dwo.name
	
	case "meca_dosim_barcode" &
			,"barcode_dosimetro"

//--- check prima sulla riga precedente
		if ki_row_old > 0 then
			u_check_dosim_tipo(ki_row_old)			
		end if
		ki_row_old = row
		u_check_dosim_tipo(row)			

end choose

end event

event dw_dett_0::clicked;//
attiva_tasti()
end event

type st_orizzontal from w_g_tab0`st_orizzontal within w_barcode_associa_dosimetria
integer x = 626
integer y = 40
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_barcode_associa_dosimetria
integer y = 140
integer height = 116
boolean enabled = false
boolean ki_db_conn_standard = false
boolean ki_dw_visibile_in_open_window = false
end type

type dw_guida from w_g_tab0`dw_guida within w_barcode_associa_dosimetria
end type

