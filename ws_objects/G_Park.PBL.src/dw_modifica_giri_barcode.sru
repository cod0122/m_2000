$PBExportHeader$dw_modifica_giri_barcode.sru
forward
global type dw_modifica_giri_barcode from uo_d_std_1
end type
end forward

global type dw_modifica_giri_barcode from uo_d_std_1
boolean visible = false
boolean titlebar = true
string title = "Visualizza/Modifica Cicli di Lavorazione del Barcode/Riferimento"
string dataobject = "d_giri_x_modif"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean hsplitscroll = false
borderstyle borderstyle = styleraised!
boolean ki_attiva_standard_select_row = false
end type
global dw_modifica_giri_barcode dw_modifica_giri_barcode

type variables
//---
//--- Varibile di stato che indica la modalita' x la quale sto nelle esponendo le FILE
public constant char ki_modalita_modifica_scelta_fila="0"
public constant char ki_modalita_modifica_giri_riga="1"
public constant char ki_modalita_modifica_giri_righe="2"
public constant char ki_modalita_modifica_giri_visualizza="3"

//--- Varibile di stato che indica se modifica 1 barcode solo o tutto il Riferim ancora da trattare
public constant int ki_modif_tutto_riferimento_si = 1
public constant int ki_modif_tutto_riferimento_no = 0
public int ki_modif_tutto_riferimento = 0

private st_tab_barcode kist_tab_barcode

//--- la dw contenente i barcode da modificare, attenersi a quanto segue:
//--- se devo modificare solo un singolo barcode da dw deve contenere le seguenti colonne:
//--- barcode_barcode
//--- se devo modificare tutti i barcode del Riferimento:
//--- num_int, data_int
//--- inoltre, tutti i dw devono contenere le seguenti colonne: 
//--- barcode_fila_1, barcode_fila_2, barcode_fila_1p, barcode_fila_2p
//--- barcode_tipo_cicli
private datawindow kidw_barcode_da_modificare // ex kidw_barcode_da_modificare
//--- Questa DW invece contiene gli eventuali barcode da non modificare 
//--- l'unica colonna necessaria e': barcode_barcode
private datawindow kidw_barcode_da_non_modificare


end variables
forward prototypes
private function st_esito aggiorna_barcode_giri ()
private subroutine aggiorna_barcode_giri_seleziona_barcode ()
private function integer check_modifica_giri ()
public subroutine modifica_giri (st_tab_barcode kst_tab_barcode, string k_modalita_modifica_file, integer k_modif_tutto_riferimento, ref datawindow kdw_barcode_da_modificare, ref datawindow kdw_barcode_da_non_modificare)
end prototypes

private function st_esito aggiorna_barcode_giri ();//
//
long k_riga, k_riga_find, k_riga_selected, k_ctr
string k_errore, k_msg
string k_find
int k_elaboro=0
st_esito kst_esito, kst_esito_update, kst_esito_return, kst_esito_err
kuf_barcode kuf1_barcode



	kst_esito_update.esito = "0"
	kst_esito_return.esito = "0" 
	
	k_riga = this.getrow()

	if k_riga > 0 then

//--- se richiesto di aggiornare solo un barcode
		if this.object.aggiorna_rif[k_riga] = "0" then
			k_msg = "Sara' modificato solo il Barcode " &
						+ trim(this.object.barcode_barcode.primary[k_riga]) + "~n~r"  &
						+ "~n~r" &
						+ "Procedere con l'operazione?"
			k_elaboro = 1
		else
			if this.object.aggiorna_righe_selezionate[k_riga]  = "1" then
				k_msg = "Attenzione, saranno modificate Tutte le righe Selezionate!!~n~r"  &
						+ "~n~r" &
						+ "Procedere con l'operazione?"
				k_elaboro = 1
			else
			   if this.object.aggiorna_righe_selezionate[k_riga] = ki_modalita_modifica_scelta_fila then
					k_elaboro = 1
				else
//				   if kidw_barcode_da_modificare.classname() = "dw_meca" then
					if ki_modif_tutto_riferimento = ki_modif_tutto_riferimento_si then
						k_msg = "Saranno modificati i Barcode NON ANCORA PIANIFICATI~n~r"  &
							+ "per la Lavorazione dell'intero Lotto~n~r" &
							+ "Procedere con l'operazione?"
					else
						k_elaboro = 1
					end if
				end if
			end if
			if k_elaboro <> 1 then
				k_elaboro = messagebox("Aggiornamento Giri di Lavorazione", & 
											k_msg, &
											question!, yesno!, 2)
			end if
		end if
						
		if k_elaboro = 1 then
	
//--- se devo aggiornare l'inteo riferimento seleziono le righe 
//			   and kidw_barcode_da_modificare.classname() <> "dw_meca" then
			if this.object.aggiorna_rif.primary[k_riga]  = "1" &
				and ki_modif_tutto_riferimento <> ki_modif_tutto_riferimento_si then
				if this.object.aggiorna_righe_selezionate.primary[k_riga] = "0" then
					kidw_barcode_da_modificare.selectrow(0, false)
				end if
				this.object.aggiorna_righe_selezionate.primary[k_riga] = "1"
				aggiorna_barcode_giri_seleziona_barcode()
			end if

//			kist_tab_barcode.pl_barcode = dw_dett_0.object.codice.primary[dw_dett_0.getrow()]
			if isnull(kist_tab_barcode.pl_barcode) then kist_tab_barcode.pl_barcode = 0
			
			kuf1_barcode = create kuf_barcode

			kuf1_barcode.kist_tab_barcode.fila_1 = this.object.barcode_fila_1.primary.original[k_riga]	
			kuf1_barcode.kist_tab_barcode.fila_2 = this.object.barcode_fila_2.primary.original[k_riga]
			kuf1_barcode.kist_tab_barcode.fila_1p = this.object.barcode_fila_1p.primary.original[k_riga]	
			kuf1_barcode.kist_tab_barcode.fila_2p = this.object.barcode_fila_2p.primary.original[k_riga]
			
//--- ciclo per eventuali modifiche su piu' righe
			if this.object.aggiorna_righe_selezionate.primary[k_riga]  = "1" then
				k_riga_selected = kidw_barcode_da_modificare.getselectedrow(0)
			else
//--- se ho selezionati piu' di una riga faccio con getrow()				
				k_riga_selected = kidw_barcode_da_modificare.getselectedrow(0)
				if k_riga_selected > 0 then
					k_ctr = k_riga_selected 
					if kidw_barcode_da_modificare.getselectedrow(k_ctr) > 0 then
						k_riga_selected = kidw_barcode_da_modificare.getrow()
					end if
				else
					k_riga_selected = kidw_barcode_da_modificare.getrow()
				end if

			end if

			do
				
//--- se devo aggiornare l'intero riferimento ometto il barcode 
				if this.object.aggiorna_righe_selezionate.primary[k_riga]  = "1" then
					
//--- non e' abilitato per modificare piu' di un riferimento
//					if kidw_barcode_da_modificare.classname() <> "dw_meca" then
					if ki_modif_tutto_riferimento <> ki_modif_tutto_riferimento_si then
						kuf1_barcode.kist_tab_barcode.barcode = kidw_barcode_da_modificare.object.barcode_barcode.primary[k_riga_selected]    	
						kuf1_barcode.kist_tab_barcode.num_int = kidw_barcode_da_modificare.object.barcode_num_int.primary.original[k_riga_selected]	
						kuf1_barcode.kist_tab_barcode.data_int = kidw_barcode_da_modificare.object.barcode_data_int.primary.original[k_riga_selected]
						kuf1_barcode.kist_tab_barcode.fila_1 = kidw_barcode_da_modificare.object.barcode_fila_1.primary.original[k_riga_selected]	
						kuf1_barcode.kist_tab_barcode.fila_2 = kidw_barcode_da_modificare.object.barcode_fila_2.primary.original[k_riga_selected]
						kuf1_barcode.kist_tab_barcode.fila_1p = kidw_barcode_da_modificare.object.barcode_fila_1p.primary.original[k_riga_selected]	
						kuf1_barcode.kist_tab_barcode.fila_2p = kidw_barcode_da_modificare.object.barcode_fila_2p.primary.original[k_riga_selected]
					else
						kst_esito.esito = "99"
						kst_esito.sqlerrtext = "w_pl_barcode:Aggiorna_barcode_giri:Non e' possibile aggiornare piu' di un Riferimento alla volta"
						kuf1_barcode.kist_tab_barcode.barcode = " "
						kuf1_barcode.kist_tab_barcode.num_int = 0
						kuf1_barcode.kist_tab_barcode.data_int = date(0)
					end if
				else
//					if kidw_barcode_da_modificare.classname() <> "dw_meca" then
					if ki_modif_tutto_riferimento <> ki_modif_tutto_riferimento_si then
						kuf1_barcode.kist_tab_barcode.barcode = this.object.barcode_barcode.primary[k_riga]    	
					else
						kuf1_barcode.kist_tab_barcode.barcode = "*"
					end if
					kuf1_barcode.kist_tab_barcode.num_int = this.object.meca_num_int.primary.original[k_riga]	
					kuf1_barcode.kist_tab_barcode.data_int = this.object.meca_data_int.primary.original[k_riga]
				end if

				if len(trim(kuf1_barcode.kist_tab_barcode.barcode)) = 0 then	
					kst_esito.esito = "99"
					kst_esito.sqlerrtext = "w_pl_barcode:Aggiorna_barcode_giri:Elaborazione non riconosciuta! - Errore Interno"
				else

					kuf1_barcode.kist_tab_barcode.pl_barcode = 0

//--- cerco il Barcode da aggiornare					
					kst_esito = kuf1_barcode.kicursor_barcode_1_open()
					if kst_esito.esito = "0" then
						kst_esito = kuf1_barcode.kicursor_barcode_1_fetch()
					end if
					
					do while kst_esito.esito = "0" and kst_esito_update.esito = "0"
			
//--- cerco il barcode nella lista dei pianificati	se non sono nella dw dei pianificati
						k_riga_find = 0
//ufo						if kidw_barcode_da_modificare.classname() <> "dw_lista_0" then
						if not isnull(kidw_barcode_da_NON_modificare) then
							k_riga_find = kidw_barcode_da_non_modificare.find("barcode_barcode = '" &
									+ trim(kuf1_barcode.kist_tab_barcode.barcode) + "' ", 1, &
									  kidw_barcode_da_non_modificare.rowcount()) 
						end if
							 
//--- solo se non ho trovato il barcode allora modifico i giri
						if k_riga_find = 0 then 
							
							kist_tab_barcode.barcode = trim(kuf1_barcode.kist_tab_barcode.barcode)
							kist_tab_barcode.tipo_cicli = this.object.barcode_tipo_cicli.primary[k_riga] 
							kist_tab_barcode.fila_1 = this.object.barcode_fila_1.primary[k_riga] 
							kist_tab_barcode.fila_2 = this.object.barcode_fila_2.primary[k_riga] 
							kist_tab_barcode.fila_1p = this.object.barcode_fila_1p.primary[k_riga] 
							kist_tab_barcode.fila_2p = this.object.barcode_fila_2p.primary[k_riga] 

//--- aggiorna solo i barcode non ancora associati ad altro PL
							if kuf1_barcode.kist_tab_barcode.pl_barcode = 0 &
							   or kist_tab_barcode.pl_barcode = kuf1_barcode.kist_tab_barcode.pl_barcode &
								then
							
//--- aggiorno i giri sul barcode			
								kist_tab_barcode.st_tab_g_0.esegui_commit = "N" 
								kst_esito_update = kuf1_barcode.tb_update_campo( kist_tab_barcode, "barcode_update_giri")

//--- modifico i dati nel dw
								if kst_esito_update.esito = "0" then
//									if kidw_barcode_da_modificare.classname() <> "dw_meca" then
									if ki_modif_tutto_riferimento <> ki_modif_tutto_riferimento_si then
										kidw_barcode_da_modificare.object.barcode_tipo_cicli.primary[k_riga_selected] = kist_tab_barcode.tipo_cicli
									end if
									kidw_barcode_da_modificare.object.barcode_fila_1.primary[k_riga_selected] = kist_tab_barcode.fila_1 
									kidw_barcode_da_modificare.object.barcode_fila_2.primary[k_riga_selected] = kist_tab_barcode.fila_2 
									kidw_barcode_da_modificare.object.barcode_fila_1p.primary[k_riga_selected] = kist_tab_barcode.fila_1p
									kidw_barcode_da_modificare.object.barcode_fila_2p.primary[k_riga_selected] = kist_tab_barcode.fila_2p
								end if
							end if
						end if
						
						kst_esito = kuf1_barcode.kicursor_barcode_1_fetch()
					
					loop
		
					if this.object.aggiorna_righe_selezionate.primary[k_riga]  = "1" then
						k_riga_selected = kidw_barcode_da_modificare.getselectedrow(k_riga_selected)
					else
						k_riga_selected = 0
					end if

//--- close del cursore 			
					kst_esito = kuf1_barcode.kicursor_barcode_1_close()
					
				end if
				
			loop while  k_riga_selected > 0 and kst_esito.esito = "0"
						

			if kst_esito_update.esito = "0" then
					
	//=== Se tutto OK faccio la COMMIT		
				k_errore = kuf1_data_base.db_commit()
				if left(k_errore, 1) <> "0" then
					kst_esito_return.esito = "1" 
					if this.object.aggiorna_rif[k_riga] = "0" then
						messagebox("Errore nel consolidamento ", &
							"Problemi durante l'aggiornamento del Barcode n. " &
							+ trim(kuf1_barcode.kist_tab_barcode.barcode) + ".")
					else
						messagebox("Errore nel consolidamento ", &
							"Problemi durante l'aggiornamento del Riferimento n. " &
							+ string(kuf1_barcode.kist_tab_barcode.num_int) + ".")
					end if
				end if
			else
				
//--- scrive log degli errori				
				kst_esito_err.esito = "1"
				kst_esito_err.sqlcode = sqlca.sqlcode
				kst_esito_err.sqlerrtext ="Cod.:" + trim(kst_esito.esito) + &
									", " + kst_esito.SQLErrText 
				kuf1_data_base.errori_scrivi_esito("W", kst_esito) 

				if kst_esito.esito <> "99" then
					kst_esito_return = kst_esito_update 
	
					if this.object.aggiorna_rif[k_riga] = "0" then
						messagebox("Fallito Aggiornamento", &
							"Barcode n. " + trim(kuf1_barcode.kist_tab_barcode.barcode) & 
							+ " non aggiornato. " &
							+ " ~n~r" + "(" + trim(kst_esito_update.sqlerrtext) + ")" + "~n~r")
					else
						messagebox("Fallito Aggiornamento", &
							"Riferimento n. " + string(kuf1_barcode.kist_tab_barcode.num_int) & 
								+ " non aggiornato. " &
								+ " ~n~r" + "(" + trim(kst_esito_update.sqlerrtext) + ")" + "~n~r")
					end if
					k_errore = kuf1_data_base.db_rollback()
				end if
			end if
						
		else
//--- operazione annullata			
			kst_esito_return.esito = "3" 
			messagebox("Operazione annullata", &
						"Elaborazione annullata dall'utente.")
		end if

				
		destroy kuf1_barcode 
				
	end if


return kst_esito_return

end function

private subroutine aggiorna_barcode_giri_seleziona_barcode ();//---
//--- seleziona i barcode dello stesso riferimento
//---
string k_find
int k_riga, k_riga_1

							
k_riga_1 = this.getrow()							
							
//--- modifico i giri sulla dw dei riferimenti non pianificati 
		k_find = "barcode_num_int = " + string(this.object.meca_num_int.primary[k_riga_1]) &
					+ " and barcode_data_int = date('" &
					+ string(this.object.meca_data_int.primary[k_riga_1]) + "') " &
					+ " "

		k_riga = 1
		k_riga = kidw_barcode_da_modificare.find (k_find, k_riga, kidw_barcode_da_modificare.rowcount())
		
		do while k_riga > 0 and k_riga <= kidw_barcode_da_modificare.rowcount()
			kidw_barcode_da_modificare.selectrow(k_riga, true)
			k_riga++								
			if k_riga <= kidw_barcode_da_modificare.rowcount() then
				k_riga = kidw_barcode_da_modificare.find (k_find, k_riga, kidw_barcode_da_modificare.rowcount())
			end if

		loop
		

end subroutine

private function integer check_modifica_giri ();//
//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================

string k_errore_txt = ""
integer k_errore = 0
int k_riga
st_esito kst_esito
st_tab_sl_pt kst_tab_sl_pt
kuf_sl_pt kuf1_sl_pt



//poi prevedere anche il ripristino dei dati originali
//
//=== Controllo il primo tab
	k_riga = this.getrow()

	if k_riga > 0 then
//		if kidw_x_modifica_giri.classname() <> "dw_meca" &
		if ki_modif_tutto_riferimento <> ki_modif_tutto_riferimento_si &
			and this.object.barcode_tipo_cicli.primary[k_riga] = kkg_sl_pt_tipo_cicli_norm_1 &
			then
			this.object.barcode_tipo_cicli.primary[k_riga] = kkg_sl_pt_tipo_cicli_norm
		end if
		kst_tab_sl_pt.tipo_cicli = this.object.barcode_tipo_cicli.primary[k_riga]
		kst_tab_sl_pt.fila_1 = this.object.barcode_fila_1.primary[k_riga]
		kst_tab_sl_pt.fila_2 = this.object.barcode_fila_2.primary[k_riga]
		kst_tab_sl_pt.fila_1p = this.object.barcode_fila_1p.primary[k_riga]
		kst_tab_sl_pt.fila_2p = this.object.barcode_fila_2p.primary[k_riga]

//--- controllo di congruenza dei dati immessi
		kuf1_sl_pt = create kuf_sl_pt
		kst_esito=kuf1_sl_pt.check_formale_giri_in_lav(kst_tab_sl_pt)
		destroy kuf1_sl_pt	
	
		choose case kst_esito.esito
	
			case "1" //errore grave: incongruenze dati
				k_errore = 1 
				messagebox("Digitati dati incongruenti, operazione non eseguita", &
						  trim(kst_esito.sqlerrtext))
				
			case "2" //avvertenza: dati da rivedere
				
		end choose

	end if

//
return k_errore 

end function

public subroutine modifica_giri (st_tab_barcode kst_tab_barcode, string k_modalita_modifica_file, integer k_modif_tutto_riferimento, ref datawindow kdw_barcode_da_modificare, ref datawindow kdw_barcode_da_non_modificare);//--- 
//--- Attiva modalita per modificare i giri sul uno o piu' barcode
//---
//--- Input: st_tab_barcode valorizzare:
//							kst_tab_barcode.barcode, &
//			                 	kst_tab_barcode.num_int, &
//							kst_tab_barcode.data_int, &
//							kst_tab_barcode.fila_1, &
//							kst_tab_barcode.fila_2, &
//							kst_tab_barcode.fila_1p, &
//							kst_tab_barcode.fila_2p, &
//							kst_tab_barcode.pl_barcode &
//---           k_modalita_modifica_file vedi variabile di stato nelle istanze
//---           modif_tutto_riferimento indica se modificare solo uno o tutti i barcode del riferim (non trattati)
//---           datawindow kdw_barcode_da_modificare contenente i barcode da modificare (vedi istanze)
//---           datawindow kdw_barcode_da_non_modificare contenente i barcode eccezionali da NON modificare (vedi istanze)
//---
long k_rec



	ki_modif_tutto_riferimento = k_modif_tutto_riferimento
	kist_tab_barcode = kst_tab_barcode
	kidw_barcode_da_modificare = kdw_barcode_da_modificare
	kidw_barcode_da_non_modificare = kdw_barcode_da_non_modificare
	

		if len(trim(kst_tab_barcode.barcode)) > 0 &
			and not isnull(kst_tab_barcode.barcode) then

			this.settransobject (sqlca)
		
		//	ki_st_open_w.flag_primo_giro = ''
			this.setredraw(false)

// non faccio + questo controllo xche' mi e' stato detto che se in sl-pt 
// allora non importa, l'operatore puo' fare le modifiche
////--- consentito solo la visualizzazione
//			if not ki_modifica_cicli_enabled then
//				k_modalita_modifica_file = ki_modalita_modifica_giri_visualizza
//			end if
			if isnull(kst_tab_barcode.fila_1) then
				kst_tab_barcode.fila_1 = 999
			end if
			if isnull(kst_tab_barcode.fila_1p) then
				kst_tab_barcode.fila_1p = 999
			end if
			if isnull(kst_tab_barcode.fila_2) then
				kst_tab_barcode.fila_2 = 999
			end if
			if isnull(kst_tab_barcode.fila_2p) then
				kst_tab_barcode.fila_2p = 999
			end if
		
			this.reset()
			k_rec = this.retrieve(kst_tab_barcode.barcode, &
			                              	kst_tab_barcode.num_int, &
									   	kst_tab_barcode.data_int, &
									   	kst_tab_barcode.fila_1, &
										kst_tab_barcode.fila_2, &
										kst_tab_barcode.fila_1p, &
										kst_tab_barcode.fila_2p, &
									 	kst_tab_barcode.pl_barcode &
									  )

			if k_rec > 0 then
				this.setitem ( k_rec, "modalita_modifica", k_modalita_modifica_file)

//--- imposto dati di dafault  
//--- modalita' modifica giri  
				if k_modalita_modifica_file <> ki_modalita_modifica_scelta_fila then
					if this.object.barcode_fila_1.primary[k_rec] > 0 &
					   or this.object.barcode_fila_1p.primary[k_rec] > 0 &
						then
						this.object.scelta_fila_1.primary[k_rec]="1"
					else
						this.object.scelta_fila_1.primary[k_rec]="0"
					end if
					if this.object.barcode_fila_2.primary[k_rec] > 0 &
					   or this.object.barcode_fila_2p.primary[k_rec] > 0 &
						then
						this.object.scelta_fila_2.primary[k_rec]="1"
					else
						this.object.scelta_fila_2.primary[k_rec]="0"
					end if
					this.object.aggiorna_righe_selezionate.primary[k_rec]="0"
					
				else
//--- modalita' scelta tra fila 1 o fila 2
					this.object.scelta_fila_1.primary[k_rec] = "0"
					this.object.scelta_fila_2.primary[k_rec] = "0"
					this.object.barcode_tipo_cicli.primary[k_rec] = kkg_sl_pt_tipo_cicli_norm
				end if
				if k_modif_tutto_riferimento = ki_modif_tutto_riferimento_si then
//--- toglie la specififca del barcode 					
					this.object.barcode_barcode.primary[k_rec] = "*"
//--- modifica l'intero Riferimento					
					this.object.aggiorna_rif.primary[k_rec] = "1"
				end if
				
				this.visible = true
				this.setredraw(true)
			
			else
			
				messagebox("Modifica Cicli di Trattamento", &
								"Barcode non trovato in archivio!!")
			end if
		
		else
			
			messagebox("Modifica Cicli di Trattamento", &
						"Dati selezionati non validi")
		end if

end subroutine

on dw_modifica_giri_barcode.create
call super::create
end on

on dw_modifica_giri_barcode.destroy
call super::destroy
end on

event buttonclicked;call super::buttonclicked;//
//
long k_riga, k_riga_count, k_riga_1
string k_errore
string k_find
st_tab_barcode kst_tab_barcode
st_tab_sl_pt kst_tab_sl_pt
st_esito kst_esito
kuf_barcode kuf1_barcode
kuf_sl_pt kuf1_sl_pt


	
	choose case dwo.name
			
		case "cb_esci"
			this.visible = false
//			kidw_x_modifica_giri.setfocus()
			
		case "cb_dettaglio"
//=== Dimensiona e Posiziona la dw nella window 
			if this.object.cb_dettaglio.text = "Dettaglio >>" then
				this.object.cb_dettaglio.text = "Nascondi" 
				this.width = long(this.object.b_linea.x) + &
										  long(this.object.b_linea.width) * 1.2
				this.height = 210 + long(this.object.b_linea_fine.y) 
			else
				this.object.cb_dettaglio.text = "Dettaglio >>" 
				this.width = long(this.object.b_linea.x) + &
										  long(this.object.b_linea.width) * 1.2
				this.height = 105 + long(this.object.b_linea.y) 
			end if
				
		
			this.setredraw(true)
			
		case "cb_aggiorna"
			this.accepttext()

			k_riga_1 = this.getrow() 

//--- se non e' attivo il campo di Scelta Fila allora azzero i giri della fila
			if this.object.scelta_fila_1.primary[k_riga_1] = "0" &
			   or isnull(this.object.scelta_fila_1.primary[k_riga_1]) then
			   this.object.barcode_fila_1.primary[k_riga_1] = 0
			   this.object.barcode_fila_1p.primary[k_riga_1] = 0
			end if
			if this.object.scelta_fila_2.primary[k_riga_1] = "0" &
			   or isnull(this.object.scelta_fila_2.primary[k_riga_1]) then
			   this.object.barcode_fila_2.primary[k_riga_1] = 0
			   this.object.barcode_fila_2p.primary[k_riga_1] = 0
			end if
			
//--- controllo dati immessi			
			if check_modifica_giri() = 0 then
		
//--- Aggiornamento 
//				kst_esito = aggiorna_barcode_giri()

//--- se aggiornamento tutto ok		
				if kst_esito.esito = "0" then
				
					this.visible = false
//					kidw_x_modifica_giri.setfocus()
		
				end if	
			end if
			
		case "cb_ripristina"
			k_riga = this.getrow() 
			kst_tab_sl_pt.cod_sl_pt = this.object.armo_cod_sl_pt.primary[k_riga]
			kuf1_sl_pt = create kuf_sl_pt
			kst_esito=kuf1_sl_pt.select_riga(kst_tab_sl_pt)
			destroy kuf1_sl_pt
			if kst_esito.esito = "0" then
				this.object.barcode_tipo_cicli.primary[k_riga]=kst_tab_sl_pt.tipo_cicli
				this.object.barcode_fila_1.primary[k_riga]=kst_tab_sl_pt.fila_1
				this.object.barcode_fila_2.primary[k_riga]=kst_tab_sl_pt.fila_2
				this.object.barcode_fila_1p.primary[k_riga]=kst_tab_sl_pt.fila_1p
				this.object.barcode_fila_2p.primary[k_riga]=kst_tab_sl_pt.fila_2p
				if kst_tab_sl_pt.fila_1 > 0 or kst_tab_sl_pt.fila_1p > 0 &
					then
					this.object.scelta_fila_1.primary[k_riga]="1"
				else
					this.object.scelta_fila_1.primary[k_riga]="0"
				end if
				if kst_tab_sl_pt.fila_2 > 0 or kst_tab_sl_pt.fila_2p > 0 &
					then
					this.object.scelta_fila_2.primary[k_riga]="1"
				else
					this.object.scelta_fila_2.primary[k_riga]="0"
				end if
				
			end if
			

	end choose


end event

