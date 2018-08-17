$PBExportHeader$kuf_g_tab_elenco.sru
forward
global type kuf_g_tab_elenco from nonvisualobject
end type
end forward

global type kuf_g_tab_elenco from nonvisualobject
end type
global kuf_g_tab_elenco kuf_g_tab_elenco

forward prototypes
public subroutine imposta_link_standard (ref datawindow kdw_1)
public function boolean call_funzioni_standard (string k_tipo, readonly datawindow kdw_1) throws uo_exception
end prototypes

public subroutine imposta_link_standard (ref datawindow kdw_1);//
//--- Imposta nel DW i "Link Standard" ovvero il campo blu sottolinato con "manina" come cursore
//
//---
integer k_num_colonne_nr, k_ctr
string k_num_colonne, k_nome


	k_num_colonne = kdw_1.Object.DataWindow.Column.Count
	if isnumber(k_num_colonne) then
		k_num_colonne_nr = integer(k_num_colonne)
	else
		k_num_colonne_nr = 99
	end if
	do 

			k_nome=lower(kdw_1.Describe("#" + trim(string(k_ctr,"###"))+".name"))
			choose case k_nome
				case "barcode"
					
//--- se e' del tipo grid o tabular link sul valore alrimenti sul testo		
					if kdw_1.Object.DataWindow.Type <> "Form" then
						
						kdw_1.Modify("#" + trim(string(k_ctr,"###"))+&
									  ".Font.Underline = 1")
						kdw_1.Modify("#" + trim(string(k_ctr,"###"))+&
									  ".Color = '" + string(kk_colore_blu)+"' ")
						kdw_1.Modify("#" + trim(string(k_ctr,"###"))+&
									  ".pointer = 'HyperLink!' " )
					else
//--- ..... alrimenti sul testo		
						kdw_1.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
									  ".Font.Underline = 1")
						kdw_1.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
									  ".Color = '" + string(kk_colore_blu)+"' ")
						kdw_1.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
									  ".pointer = 'HyperLink!' " )
					  end if
								  
				case "num_int"

//--- per farlo diventare un link ho bisogno anche del campo "id_meca"

//--- se e' del tipo grid o tabular link sul valore alrimenti sul testo		
					if kdw_1.Object.DataWindow.Type <> "Form" then
						if len(trim(kdw_1.Describe("id_meca.x"))) > 1 then 
							kdw_1.Modify("#" + trim(string(k_ctr,"###"))+&
										  ".Font.Underline = 1")
							kdw_1.Modify("#" + trim(string(k_ctr,"###"))+&
										  ".Color = '" + string(kk_colore_blu)+"' ")
							kdw_1.Modify("#" + trim(string(k_ctr,"###"))+&
										  ".pointer = 'HyperLink!' " )
						end if
					else
						if len(trim(kdw_1.Describe("num_int_t.x"))) > 1 then 
							kdw_1.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
										  ".Font.Underline = 1")
							kdw_1.Modify(k_nome+ "_t" + trim(string(k_ctr,"###"))+&
										  ".Color = '" + string(kk_colore_blu)+"' ")
							kdw_1.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
										  ".pointer = 'HyperLink!' " )
						end if
					end if
			end choose

		k_ctr = k_ctr + 1 

	loop while k_ctr <= k_num_colonne_nr 
	
	





end subroutine

public function boolean call_funzioni_standard (string k_tipo, readonly datawindow kdw_1) throws uo_exception;//
//--- Chiama le window con funzione standard di consultazione
//--- Input:   k_tipo    = tipo di funzione standard da chiamare
//---             kdw_1   = data_window dalla quale prelevare i dati 
//--- Output: boolean TRUE = ok e' entrato in funzione; FALSE=non ha fatto niente
//
boolean k_return=true
int k_rc
st_esito kst_esito
st_tab_meca kst_tab_meca
st_tab_barcode kst_tab_barcode
uo_exception kuo_exception
kuf_armo kuf1_armo
kuf_barcode kuf1_barcode
kuf_sped kuf1_arsp
kuf_fatt kuf1_fatt
kuf_certif kuf1_certif
st_open_w kst_open_w 
st_tab_armo kst_tab_armo
datastore kdsi_elenco_output   //ds da passare alla windows di elenco
kuf_menu_window kuf1_menu_window


kdsi_elenco_output = create datastore

choose case k_tipo
		
	case "num_int" &
		,"num_int_t"
		kuf1_armo = create kuf_armo
		kst_tab_meca.id = kdw_1.getitemnumber(kdw_1.getrow(), "id_meca")
		kdsi_elenco_output.dataobject = kdw_1.dataobject
		kdsi_elenco_output.insertrow(0)
		kdsi_elenco_output.object.id_meca[1] = kdw_1.object.id_meca[1]
		kst_esito = kuf1_armo.anteprima_a_righe ( kdsi_elenco_output, kst_tab_meca )
		destroy kuf1_armo
		if kst_esito.esito <> kkg_esito_ok then
			kuo_exception = create uo_exception
			kuo_exception.set_esito( kst_esito)
			throw kuo_exception
		end if
		kst_open_w.key1 = "Dettaglio del Lotto (id=" + trim(string(kst_tab_meca.id))  + ") "
		
	case "barcode" &
		,"barcode_t"
		kst_tab_barcode.barcode = kdw_1.getitemstring(kdw_1.getrow(), "barcode")

		kuf1_barcode = create kuf_barcode
		kst_esito = kuf1_barcode.anteprima ( kdsi_elenco_output, kst_tab_barcode )
		destroy kuf1_barcode
		if kst_esito.esito <> kkg_esito_ok then
			kuo_exception = create uo_exception
			kuo_exception.set_esito( kst_esito)
			throw kuo_exception
		end if
		kst_open_w.key1 = "Dettaglio Barcode : " + trim(string(kst_tab_barcode.barcode,"@@@ @@@@@@@@@")) 
		
	case "b_barcode" 
		kst_tab_barcode.id_meca = kdw_1.getitemnumber(kdw_1.getrow(), "id_meca")

		kuf1_barcode = create kuf_barcode
		kst_esito = kuf1_barcode.anteprima_elenco ( kdsi_elenco_output, kst_tab_barcode )
		destroy kuf1_barcode
		if kst_esito.esito <> kkg_esito_ok then
			kuo_exception = create uo_exception
			kuo_exception.set_esito( kst_esito)
			throw kuo_exception
		end if
		kst_open_w.key1 = "Elenco Barcode per Lotto  (id=" + trim(string(kst_tab_barcode.id_meca)) + ") " 

	case "b_armo" 
		kst_tab_armo.id_meca = kdw_1.getitemnumber(kdw_1.getrow(), "id_meca")

		kuf1_armo = create kuf_armo
		kst_esito = kuf1_armo.anteprima_elenco ( kdsi_elenco_output, kst_tab_armo )
		destroy kuf1_armo
		if kst_esito.esito <> kkg_esito_ok then
			kuo_exception = create uo_exception
			kuo_exception.set_esito( kst_esito)
			throw kuo_exception
		end if
		kst_open_w.key1 = "Elenco Righe Lotto  (id=" + trim(string(kst_tab_armo.id_meca)) + ") " 

	case "b_arsp" 
		kst_tab_armo.id_meca = kdw_1.getitemnumber(kdw_1.getrow(), "id_meca")

		kuf1_arsp = create kuf_sped
		kst_esito = kuf1_arsp.anteprima_elenco ( kdsi_elenco_output, kst_tab_armo )
		destroy kuf1_arsp
		if kst_esito.esito <> kkg_esito_ok then
			kuo_exception = create uo_exception
			kuo_exception.set_esito( kst_esito)
			throw kuo_exception
		end if
		kst_open_w.key1 = "Elenco Righe Bolla di Spedizione  (id lotto=" + trim(string(kst_tab_armo.id_meca)) + ") " 
		
	case "b_arfa" 
		kst_tab_armo.id_meca = kdw_1.getitemnumber(kdw_1.getrow(), "id_meca")

		kuf1_fatt = create kuf_fatt
		kst_esito = kuf1_fatt.anteprima_elenco ( kdsi_elenco_output, kst_tab_armo )
		destroy kuf1_fatt
		if kst_esito.esito <> kkg_esito_ok then
			kuo_exception = create uo_exception
			kuo_exception.set_esito( kst_esito)
			throw kuo_exception
		end if
		kst_open_w.key1 = "Elenco Righe Bolla di Spedizione  (id lotto=" + trim(string(kst_tab_armo.id_meca)) + ") " 
		
	case "b_certif" 
		kst_tab_armo.id_meca = kdw_1.getitemnumber(kdw_1.getrow(), "id_meca")

		kuf1_certif = create kuf_certif
		kst_esito = kuf1_certif.anteprima_elenco ( kdsi_elenco_output, kst_tab_armo )
		destroy kuf1_certif
		if kst_esito.esito <> kkg_esito_ok then
			kuo_exception = create uo_exception
			kuo_exception.set_esito( kst_esito)
			throw kuo_exception
		end if
		kst_open_w.key1 = "Elenco Righe Attestato di Trattamento  (id lotto=" + trim(string(kst_tab_armo.id_meca)) + ") " 

		
	case else
		k_return = false
		
end choose

if kdsi_elenco_output.rowcount() > 0 then

	
//--- chiamare la window di elenco
//
//=== Parametri : 
//=== struttura st_open_w
	kst_open_w.id_programma =kkg_id_programma_elenco
	kst_open_w.flag_primo_giro = "S"
	kst_open_w.flag_modalita = "el"
	kst_open_w.flag_adatta_win = KK_ADATTA_WIN
	kst_open_w.flag_leggi_dw = " "
	kst_open_w.flag_cerca_in_lista = " "
	kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
	kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
	kst_open_w.key4 = kuf1_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
	kst_open_w.key12_any = kdsi_elenco_output
	kst_open_w.flag_where = " "
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(kst_open_w)
	destroy kuf1_menu_window

else
	
	messagebox("Elenco Dati", &
				"Nessun valore disponibile. ")
	
	
end if
	
return k_return


end function

on kuf_g_tab_elenco.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_g_tab_elenco.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

