$PBExportHeader$uo_dw_modifica_giri_barcode.sru
forward
global type uo_dw_modifica_giri_barcode from uo_d_std_1
end type
end forward

global type uo_dw_modifica_giri_barcode from uo_d_std_1
integer width = 3365
integer height = 2228
boolean titlebar = true
string title = "Visualizza/Modifica Cicli di Lavorazione del Barcode/Riferimento"
string dataobject = "d_giri_x_modif"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
string icon = "Form!"
boolean hsplitscroll = false
borderstyle borderstyle = styleraised!
boolean ki_attiva_standard_select_row = false
event ue_mostra_aggiornamenti_dw ( )
event ue_aggiornamenti_ok ( )
end type
global uo_dw_modifica_giri_barcode uo_dw_modifica_giri_barcode

type variables
//
public:

//--- Se NON voglio Aggiornare le TABELLE ma solo il DW imposto il flag
boolean ki_AGGIORNARE_TABELLE = TRUE

//--- Variabile dove memorizzo l'autorizzazione alla modifica
string ki_modifica_cicli_enabled ="0"
constant string ki_modifica_cicli_enabled_nulla="0"
constant string ki_modifica_cicli_enabled_modif="1"
constant string ki_modifica_cicli_enabled_visualizzazione="2"

//--- Varibile del tipo di controllo x autorizzare la modifica giri
int ki_modifica_giri_pianificati = 1 
int ki_modifica_giri_pianificati_si = 1 
int ki_modifica_giri_pianificati_no = 0 // non consente di modificare i giri x i barcode in pl gia' chiusi


//--- Varibile di stato che indica la modalita' x la quale sto esponendo le FILE
constant string ki_modalita_modifica_scelta_fila="0"
constant string ki_modalita_modifica_giri_riga="1"
constant string ki_modalita_modifica_giri_righe="2"
constant string ki_modalita_modifica_giri_visualizza="3"

//--- Varibile di stato che indica se modifica 1 barcode solo o tutto il Riferim ancora da trattare
constant int ki_modif_tutto_riferimento_si = 1
constant int ki_modif_tutto_riferimento_no = 0
int ki_modif_tutto_riferimento = 0

st_tab_barcode kist_tab_barcode

//-------------------------------------------------------------------------------------------------------------------------------------------
private:

st_tab_barcode kist_tab_barcode_contati

//--- la dw contenente i barcode da modificare, attenersi a quanto segue:
//--- se devo modificare solo un singolo barcode da dw deve contenere le seguenti colonne:
//--- barcode_barcode
//--- se devo modificare tutti i barcode del Riferimento:
//--- num_int, data_int
//--- inoltre, tutti i dw devono contenere le seguenti colonne: 
//--- barcode_fila_1, barcode_fila_2, barcode_fila_1p, barcode_fila_2p
//--- barcode_tipo_cicli
//--- PUOI USARE IL D_MODIFICA_GIRI_BARCODE
datawindow kidw_barcode_da_modificare // ex kidw_barcode_da_modificare
//--- Questa DW invece contiene gli eventuali barcode da non modificare 
//--- l'unica colonna necessaria e': barcode_barcode
datawindow kidw_barcode_da_non_modificare

end variables

forward prototypes
private function st_esito aggiorna_barcode_giri ()
private subroutine aggiorna_barcode_giri_seleziona_barcode ()
private function integer check_modifica_giri ()
public subroutine modifica_giri (st_tab_barcode kst_tab_barcode, string k_modalita_modifica_file, integer k_modif_tutto_riferimento, ref datawindow kdw_barcode_da_modificare, ref datawindow kdw_barcode_da_non_modificare)
private subroutine resize ()
public function boolean autorizza_modifica_giri () throws uo_exception
private subroutine esponi_numero_figli ()
public function boolean aggiorna_barcode_giri_esegui (st_tab_barcode ast_tab_barcode) throws uo_exception
end prototypes

event ue_mostra_aggiornamenti_dw();//---
//--- mettere qui il codice che aggiorna la dw
//---

end event

event ue_aggiornamenti_ok();//---
//--- mettere qui il codice da fare dopo che aggiornamenti fatti OK!
//---

end event

private function st_esito aggiorna_barcode_giri ();//
//
long k_riga, k_riga_find, k_riga_selected, k_ctr, k_record_aggiornati=0
string k_errore, k_msg
string k_find
int k_elaboro=0
st_esito kst_esito, kst_esito_update, kst_esito_return, kst_esito_err
st_tab_barcode kst_tab_barcode
kuf_barcode kuf1_barcode
//datastore kds_barcode_figli


	kst_esito_update.esito = kkg_esito.ok
	kst_esito_return.esito = kkg_esito.ok 
	
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
					k_msg = "Modificare il Trattamento? " 
					k_elaboro = 1
				else
//				   if kidw_barcode_da_modificare.classname() = "dw_meca" then
					if ki_modif_tutto_riferimento = ki_modif_tutto_riferimento_si then
						k_msg = "Saranno modificati i Barcode NON ANCORA PIANIFICATI~n~r"  &
							+ "per la Lavorazione dell'intero Lotto~n~r" &
							+ "Procedere con l'operazione?"
					else
						k_msg = "Modificare il Trattamento? " 
						k_elaboro = 1
					end if
				end if
			end if
//			if k_elaboro <> 1 then
				k_elaboro = messagebox("Aggiornamento Giri di Lavorazione", & 
											k_msg, &
											question!, yesno!, 2)
//			end if
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
				if k_riga_selected > 0 then //09122014
				else
					k_riga_selected = kidw_barcode_da_modificare.getrow()
				end if
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
						kst_esito.esito = kkg_esito.err_logico
						kst_esito.sqlerrtext = "Aggiorna_barcode_giri: Non e' possibile aggiornare piu' di un Riferimento alla volta"
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

				if LenA(trim(kuf1_barcode.kist_tab_barcode.barcode)) = 0 then	
					kst_esito.esito = kkg_esito.err_logico
					kst_esito.sqlerrtext = "w_pl_barcode:Aggiorna_barcode_giri:Elaborazione non riconosciuta! - Errore Interno"
				else

					kuf1_barcode.kist_tab_barcode.pl_barcode = 0

//--- cerco il Barcode da aggiornare					
					kst_esito = kuf1_barcode.kicursor_barcode_1_open()
					if kst_esito.esito = kkg_esito.ok then
						kst_esito = kuf1_barcode.kicursor_barcode_1_fetch()
					end if
					
					do while kst_esito.esito = kkg_esito.ok and kst_esito_update.esito = kkg_esito.ok
			
//--- cerco il barcode nella lista dei pianificati	se non sono nella dw dei pianificati
						k_riga_find = 0

						if isvalid(kidw_barcode_da_NON_modificare) and not isnull(kidw_barcode_da_NON_modificare) then
							k_riga_find = kidw_barcode_da_non_modificare.find("barcode_barcode = '" &
									+ trim(kuf1_barcode.kist_tab_barcode.barcode) + "' ", 1, &
									  kidw_barcode_da_non_modificare.rowcount()) 
						end if
							 
//--- solo se non ho trovato il barcode allora modifico i giri
						if k_riga_find <= 0 then 
							
							kist_tab_barcode.barcode = trim(kuf1_barcode.kist_tab_barcode.barcode)

//--- aggiorna solo i barcode non ancora associati ad altro PL 
							if kuf1_barcode.kist_tab_barcode.pl_barcode = 0 or isnull(kuf1_barcode.kist_tab_barcode.pl_barcode) &
							  				 or kist_tab_barcode.pl_barcode = kuf1_barcode.kist_tab_barcode.pl_barcode &
								then
								
								try 
									
//--- AGGIORNA TABELLE									
									if aggiorna_barcode_giri_esegui(kist_tab_barcode) then

										
//--- modifico i dati nel dw
										if k_riga_selected > 0 then  //09122014
										
											k_record_aggiornati ++
										
											if ki_modif_tutto_riferimento <> ki_modif_tutto_riferimento_si then
												kidw_barcode_da_modificare.object.barcode_tipo_cicli.primary[k_riga_selected] = kist_tab_barcode.tipo_cicli
											end if
											kidw_barcode_da_modificare.object.barcode_fila_1.primary[k_riga_selected] = kist_tab_barcode.fila_1 
											kidw_barcode_da_modificare.object.barcode_fila_2.primary[k_riga_selected] = kist_tab_barcode.fila_2 
											kidw_barcode_da_modificare.object.barcode_fila_1p.primary[k_riga_selected] = kist_tab_barcode.fila_1p
											kidw_barcode_da_modificare.object.barcode_fila_2p.primary[k_riga_selected] = kist_tab_barcode.fila_2p
										end if
										
									end if
									
								catch (uo_exception kuo_exception)
									kst_esito = kuo_exception.get_st_esito()
									
								end try
									
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
				
			loop while  k_riga_selected > 0 and kst_esito.esito = kkg_esito.ok
						

			if kst_esito_update.esito = kkg_esito.ok then
					
				if ki_AGGIORNARE_TABELLE then  // flag di aggiornamento!
//=== Se tutto OK faccio la COMMIT		
					kst_esito = kguo_sqlca_db_magazzino.db_commit( )
					if kst_esito.esito = kkg_esito.ko then
						if this.object.aggiorna_rif[k_riga] = "0" then
							messagebox("Errore nel consolidamento ", "Problemi durante l'aggiornamento del Barcode n. " &
								+ trim(kuf1_barcode.kist_tab_barcode.barcode) + "." &
								+ " ~n~rErrore:" + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) )
						else
							messagebox("Errore nel consolidamento ", "Problemi durante l'aggiornamento del Riferimento n. " &
								+ string(kuf1_barcode.kist_tab_barcode.num_int) + "." &
								+ " ~n~rErrore:" + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) )
						end if
					end if
				end if
			else
				
//--- scrive log degli errori				
				kst_esito_err.esito = kkg_esito.err_formale
				kst_esito_err.sqlcode = sqlca.sqlcode
				kst_esito_err.sqlerrtext ="Cod.:" + trim(kst_esito_update.esito) + &
									", " + kst_esito.SQLErrText 
				kGuf_data_base.errori_scrivi_esito("W", kst_esito_update) 

				if kst_esito.esito <> kkg_esito.err_logico then
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
					if ki_AGGIORNARE_TABELLE then  // flag di aggiornamento!
						kguo_sqlca_db_magazzino.db_rollback( )
					end if
				end if
				
			end if
			
			if k_record_aggiornati = 0 then
				if kst_esito_return.esito = kkg_esito.ok then
					kst_esito_return.esito = kkg_esito.no_esecuzione
					kst_esito_return.sqlerrtext = "Nessun aggiornamento eseguito"
					if this.object.aggiorna_rif[k_riga] = "0" then
						messagebox("Operazione non eseguita", &
							"Impossibile aggiornare il Barcode " + trim(kuf1_barcode.kist_tab_barcode.barcode) + ". ")
					else
						messagebox("Operazione non eseguita", &
							"Impossibile aggiornare i barcode del Riferimento n. " + string(kuf1_barcode.kist_tab_barcode.num_int) + ". ")
					end if
				end if
			end if
			
		else
//--- operazione annullata			
			kst_esito_return.esito = kkg_esito.no_esecuzione 
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
//----------------------------------------------------------------------------------------------------
//--- Controllo se giri modificati in modo congruente
//--- Ritorna  : 0=tutto OK; 1=errore logico
//--- 
//----------------------------------------------------------------------------------------------------

string k_errore_txt = ""
integer k_errore = 0
int k_riga
st_esito kst_esito
st_tab_sl_pt kst_tab_sl_pt
kuf_sl_pt kuf1_sl_pt



//--- Controllo il primo tab
k_riga = this.getrow()

if k_riga > 0 then


//--- se non sono attivi ne' il flag fila1 ne' fila2 allora c'e' un errore 
	if (this.object.scelta_fila_1.primary[k_riga] = "0" or isnull(this.object.scelta_fila_1.primary[k_riga])) &
			  and (this.object.scelta_fila_2.primary[k_riga] = "0" or isnull(this.object.scelta_fila_2.primary[k_riga])) then
	
	
		k_errore = 1 
		kguo_exception.inizializza( )
		kguo_exception.messaggio_utente("Imposta Giri di Trattamento", "Scegliere la fila di Trattamento, operazione non eseguita")
	
	else
	
	//--- se non e' attivo il campo di Scelta Fila allora azzero i giri della fila
		if this.object.scelta_fila_1.primary[k_riga] = "0" &
			or isnull(this.object.scelta_fila_1.primary[k_riga]) then
			this.object.barcode_fila_1.primary[k_riga] = 0
			this.object.barcode_fila_1p.primary[k_riga] = 0
		end if
		if this.object.scelta_fila_2.primary[k_riga] = "0" &
			or isnull(this.object.scelta_fila_2.primary[k_riga]) then
			this.object.barcode_fila_2.primary[k_riga] = 0
			this.object.barcode_fila_2p.primary[k_riga] = 0
		end if

		if ki_modif_tutto_riferimento <> ki_modif_tutto_riferimento_si &
			and this.object.barcode_tipo_cicli.primary[k_riga] = kuf1_sl_pt.ki_tipo_cicli_a_scelta &
			then
			this.object.barcode_tipo_cicli.primary[k_riga] = kuf1_sl_pt.ki_tipo_cicli_singolo
		end if
		kst_tab_sl_pt.tipo_cicli = this.object.barcode_tipo_cicli.primary[k_riga]
		kst_tab_sl_pt.fila_1 = this.object.barcode_fila_1.primary[k_riga]
		kst_tab_sl_pt.fila_2 = this.object.barcode_fila_2.primary[k_riga]
		kst_tab_sl_pt.fila_1p = this.object.barcode_fila_1p.primary[k_riga]
		kst_tab_sl_pt.fila_2p = this.object.barcode_fila_2p.primary[k_riga]

//--- 12.1.06 FORZO IL TIPO CICLI QUANDO NON VALORIZZATO (MA PERCHE' NON E' VALORIZZATO??=)	??????????????????????????
		if LenA(trim(kst_tab_sl_pt.tipo_cicli)) = 0 then
			if kst_tab_sl_pt.fila_1 > 0 and kst_tab_sl_pt.fila_2 > 0 then
				kst_tab_sl_pt.tipo_cicli = kuf1_sl_pt.ki_tipo_cicli_misto
			else
				kst_tab_sl_pt.tipo_cicli = kuf1_sl_pt.ki_tipo_cicli_singolo
			end if
		end if

//--- controllo di congruenza dei dati immessi
		kuf1_sl_pt = create kuf_sl_pt
		kst_esito=kuf1_sl_pt.check_formale_giri_in_lav(kst_tab_sl_pt)
		destroy kuf1_sl_pt	
	
		choose case kst_esito.esito
	
			case "1" //errore grave: incongruenze dati
				k_errore = 1 
				kguo_exception.inizializza( )
				kguo_exception.messaggio_utente("Digitati dati incongruenti, operazione non eseguita", trim(kst_esito.sqlerrtext))
				
			case "2" //avvertenza: dati da rivedere
				
		end choose

	end if


end if


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
long k_rec, k_riga
kuf_sl_pt kuf1_sl_pt


	ki_modif_tutto_riferimento = k_modif_tutto_riferimento
	kist_tab_barcode = kst_tab_barcode
	kidw_barcode_da_modificare = kdw_barcode_da_modificare
	kidw_barcode_da_non_modificare = kdw_barcode_da_non_modificare

//--- seleziona le righe		
//	kidw_barcode_da_modificare.selectrow(0, false)
	for k_riga = 1 to kdw_barcode_da_modificare.rowcount()
		if kdw_barcode_da_modificare.getselectedrow(k_riga - 1) = k_riga then
			kidw_barcode_da_modificare.selectrow(k_riga, true)
		end if
	end for
			

		if LenA(trim(kst_tab_barcode.barcode)) > 0 &
			and not isnull(kst_tab_barcode.barcode) then

			this.settransobject (sqlca)

//--- dimensiona la dw
			resize()
			
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
									   	999, &
										999, &
										999, &
										999, &
									 	0 &
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

//--- se sono in tipo_cicli "a scelta" ed è stata data la preferenza a FILA 1 o FILA 2....
					if this.object.barcode_tipo_cicli.primary[k_rec] = kuf1_sl_pt.ki_tipo_cicli_a_scelta then
						 if this.object.fila_pref.primary[k_rec] = "1" then
							this.object.scelta_fila_1.primary[k_rec]="1"
							this.object.scelta_fila_2.primary[k_rec]="0"
						else
							 if this.object.fila_pref.primary[k_rec] = "2" then
								this.object.scelta_fila_1.primary[k_rec]="0"
								this.object.scelta_fila_2.primary[k_rec]="1"
							end if
						end if
					end if
					
				else
//--- modalita' scelta tra fila 1 o fila 2
					this.object.scelta_fila_1.primary[k_rec] = "0"
					this.object.scelta_fila_2.primary[k_rec] = "0"
					this.object.barcode_tipo_cicli.primary[k_rec] = kuf1_sl_pt.ki_tipo_cicli_singolo
				end if
				if k_modif_tutto_riferimento = ki_modif_tutto_riferimento_si then
//--- toglie la specififca del barcode 					
					this.object.barcode_barcode.primary[k_rec] = "*"
//--- modifica l'intero Riferimento					
					this.object.aggiorna_rif.primary[k_rec] = "1"
				end if

//--- mette a video il numero dei figli, se ce ne sono
				esponi_numero_figli()				
				
				this.visible = true
				this.setredraw(true)
				this.BringToTop = TRUE
			
			else
			
				kguo_exception.inizializza( )
				kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_not_fnd )
				kguo_exception.setmessage("Modifica Cicli di Trattamento: Barcode " + trim(kst_tab_barcode.barcode) + " non trovato in archivio!!")
				kguo_exception.messaggio_utente( )
			end if
		
		else
			
			kguo_exception.inizializza( )
			kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_anomali )
			kguo_exception.setmessage("Modifica Cicli di Trattamento:  Dati selezionati non validi!!")
			kguo_exception.messaggio_utente( )
		end if

end subroutine

private subroutine resize ();//
//=== Dimensiona e Posiziona la dw nella window 
	this.setredraw(false)

	if this.object.cb_dettaglio.text = "Nascondi" then
		this.width = long(this.object.b_linea.x) + &
								  long(this.object.b_linea.width) * 1.2
		this.height = 210 + long(this.object.b_linea_fine.y) 
	else
		this.object.cb_dettaglio.text = "Dettaglio >>" 

		this.width = long(this.object.b_linea.x) + &
								  long(this.object.b_linea.width) * 1.2
		this.height = 200 + long(this.object.b_linea.y) 
	end if
		
	this.setredraw(true) 

	parent.triggerevent(resize!)
			
end subroutine

public function boolean autorizza_modifica_giri () throws uo_exception;//---
//--- controllo autorizzazione x cambio giri di lavorazione
//--- 
//--- Output:
//---            setta la variabile di stato ki_modifica_cicli_enabled
//---			TRUE=puo' fare qualcose; FALSE=non puo' fare nulla
//---
boolean k_return = true
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility
st_open_w k_st_open_w
kuf_barcode kuf1_barcode


	
	ki_modifica_cicli_enabled = ki_modifica_cicli_enabled_modif
	
	kuf1_utility = create kuf_utility 


//--- abilitazione alla modifica 
	K_st_open_w.id_programma = kkg_id_programma_pt_giri
	K_st_open_w.flag_modalita = kkg_flag_modalita.modifica
	
	kuf1_sicurezza = create kuf_sicurezza 
	if not kuf1_sicurezza.autorizza_funzione(k_st_open_w) then
		
		ki_modifica_cicli_enabled = ki_modifica_cicli_enabled_visualizzazione

//--- provo almeno l'abilitazione alla visualizzazione
		K_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
		if not kuf1_sicurezza.autorizza_funzione(k_st_open_w) then
			
			ki_modifica_cicli_enabled =  ki_modifica_cicli_enabled_nulla
			k_return = false

		end if
	else

		if ki_modifica_giri_pianificati = ki_modifica_giri_pianificati_no then
			kuf1_barcode = create kuf_barcode
			
			try
//--- se barcode figlio non posso modificare i giri 				
				if not kuf1_barcode.if_barcode_figlio(kist_tab_barcode) then
//--- se giri barcode non modificabili quando gia' in pl chiusi.... 		
					if kuf1_barcode.if_barcode_in_pl_chiuso(kist_tab_barcode) then
//					if kuf1_barcode.if_barcode_in_pl(kist_tab_barcode) then
						k_return = false
					else
						k_return = true
					end if
				else
					k_return = false
				end if
				
			catch (uo_exception kuo_exception)
				throw kuo_exception				
			finally			
				destroy kuf1_barcode
			end try
			
		end if
	end if

	destroy kuf1_sicurezza
	destroy kuf1_utility

return k_return


end function

private subroutine esponi_numero_figli ();//
long k_ctr=0
kuf_barcode kuf1_barcode



try 
	if kist_tab_barcode_contati.barcode <> kist_tab_barcode.barcode then
		kist_tab_barcode_contati = kist_tab_barcode
		kuf1_barcode = create kuf_barcode
		k_ctr = kuf1_barcode.get_conta_figli( kist_tab_barcode_contati)
		if k_ctr > 0 then
			this.object.barcode_figli_conta[this.getrow()] = k_ctr
		else
			this.object.barcode_figli_conta[this.getrow()] = 0
		end if
	end if
catch (uo_exception kuo_exception)
	this.object.barcode_figli_conta[this.getrow()] = 0
end try



end subroutine

public function boolean aggiorna_barcode_giri_esegui (st_tab_barcode ast_tab_barcode) throws uo_exception;//---
//--- Aggiorna i GIRI sulla tabella BARCODE
//---
//--- input : st_tab_barcode.barcode
//---
//--- Lancia Exception
//
boolean k_return = false
long k_riga, k_ctr=1
st_esito kst_esito_update
st_tab_barcode kst_tab_barcode
kuf_barcode kuf1_barcode
datastore kds_barcode_figli



try 


		kst_esito_update.esito = kkg_esito.ok
		kst_esito_update.sqlcode = 0
		kst_esito_update.SQLErrText = ""
		kst_esito_update.nome_oggetto = this.classname()
	
	
		kist_tab_barcode.barcode = ast_tab_barcode.barcode
	
//--- mi chiedo se posso veramente aggiornare sti giri per questo barcode magari e' un figlio quindi NISBA
		k_return = autorizza_modifica_giri() 
		if k_return then

			kuf1_barcode = create kuf_barcode

			if this.rowcount( ) > 0 then
				k_riga = this.getrow()
				kist_tab_barcode.tipo_cicli = this.object.barcode_tipo_cicli.primary[k_riga] 
				kist_tab_barcode.fila_1 = this.object.barcode_fila_1.primary[k_riga] 
				kist_tab_barcode.fila_2 = this.object.barcode_fila_2.primary[k_riga] 
				kist_tab_barcode.fila_1p = this.object.barcode_fila_1p.primary[k_riga] 
				kist_tab_barcode.fila_2p = this.object.barcode_fila_2p.primary[k_riga] 
			end if
							
//--- AGGIORNA i giri sul tab barcode	!!!!!!!!!!!!!!!!!!!!!!!---------------------------------------------------------------------------------------------------		
			if ki_AGGIORNARE_TABELLE then  // SOLO se flag di aggiornamento ATTIVATO!!!!
				kist_tab_barcode.st_tab_g_0.esegui_commit = "N" 
				kst_esito_update = kuf1_barcode.tb_update_campo( kist_tab_barcode, "barcode_update_giri")
			end if

//--- se barcode 'padre' allora aggiorno anche i figli dello stesso SL-PT
			if kst_esito_update.esito = kkg_esito.ok then
				kst_tab_barcode = kist_tab_barcode
				if kuf1_barcode.get_conta_figli(kst_tab_barcode) > 0 then
					kds_barcode_figli = kuf1_barcode.get_figli_barcode_uguale_sl_pt(kst_tab_barcode)
					k_ctr = 1
					do while k_ctr <= kds_barcode_figli.rowcount( ) and kst_esito_update.esito = kkg_esito.ok
//--- Aggiorna Barcode Figli con lo stesso PT												
						kst_tab_barcode.barcode = kds_barcode_figli.object.barcode[k_ctr]
						
						if ki_AGGIORNARE_TABELLE then  // flag di aggiornamento!
							kist_tab_barcode.st_tab_g_0.esegui_commit = "N" 
							kst_esito_update = kuf1_barcode.tb_update_campo( kst_tab_barcode, "barcode_update_giri")
						end if
						k_ctr++
						
					loop
				end if
			end if
//-
			if kst_esito_update.esito <> kkg_esito.ok and kst_esito_update.esito <> kkg_esito.db_wrn and kst_esito_update.esito <> kkg_esito.not_fnd then
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito_update )
				throw kguo_exception
			end if		
			
			k_return = TRUE     //--- TUTTO OK!!!!
			
		end if
	
	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally
		destroy kuf1_barcode
	
end try 


return k_return 


end function

on uo_dw_modifica_giri_barcode.create
call super::create
end on

on uo_dw_modifica_giri_barcode.destroy
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
			kidw_barcode_da_modificare.setfocus()
			
		case "cb_dettaglio"
//=== Dimensiona e Posiziona la dw nella window 
			if this.object.cb_dettaglio.text = "Dettaglio >>" then
				this.object.cb_dettaglio.text = "Nascondi" 
			else
				this.object.cb_dettaglio.text = "Dettaglio >>" 
			end if
			resize()
			
		case "cb_aggiorna"
			this.accepttext()

			k_riga_1 = this.getrow() 

//--- controllo dati immessi			
			if check_modifica_giri() = 0 then
		
//--- Aggiornamento 
				kst_esito = aggiorna_barcode_giri()

//--- se aggiornamento tutto ok		
				if kst_esito.esito = kkg_esito.ok then
				
					this.visible = false
					kidw_barcode_da_modificare.setfocus()

//--- dopo che aggiornamenti OK esegue questa (DA PERSONALIZZARE) 					
					triggerevent("ue_aggiornamenti_ok")
		
				end if	

//--- aggiorna anche le dw a video (DA PERSONALIZZARE) 					
				triggerevent("ue_mostra_aggiornamenti_dw")

			end if
			
		case "cb_ripristina"
			k_riga = this.getrow() 
			kst_tab_sl_pt.cod_sl_pt = this.object.armo_cod_sl_pt.primary[k_riga]
			kuf1_sl_pt = create kuf_sl_pt
			kst_esito=kuf1_sl_pt.select_riga(kst_tab_sl_pt)
			destroy kuf1_sl_pt
			if kst_esito.esito = kkg_esito.ok then
				this.object.barcode_tipo_cicli.primary[k_riga]=kst_tab_sl_pt.tipo_cicli
				this.object.fila_pref.primary[k_riga]=kst_tab_sl_pt.fila_pref
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
				
//--- se sono in tipo_cicli "a scelta" ed è stata data la preferenza a FILA 1 o FILA 2....
				if this.object.barcode_tipo_cicli.primary[k_riga] = kuf1_sl_pt.ki_tipo_cicli_a_scelta then
					 if this.object.fila_pref.primary[k_riga] = "1" then
						this.object.scelta_fila_1.primary[k_riga]="1"
						this.object.scelta_fila_2.primary[k_riga]="0"
					else
						 if this.object.fila_pref.primary[k_riga] = "2" then
							this.object.scelta_fila_1.primary[k_riga]="0"
							this.object.scelta_fila_2.primary[k_riga]="1"
						end if
					end if
				end if
				
			end if
			

	end choose


end event

