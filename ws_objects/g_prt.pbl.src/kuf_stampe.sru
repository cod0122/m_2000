$PBExportHeader$kuf_stampe.sru
forward
global type kuf_stampe from nonvisualobject
end type
end forward

global type kuf_stampe from nonvisualobject
end type
global kuf_stampe kuf_stampe

type variables
//
public st_stampe kist_stampe
public st_stampe kist_stampe_restore
public st_stampe kist_stampe_orig
public st_stampe kist_stampe_save
public st_stampe kist_stampe_add_testata

private constant string ki_logo_tabulato = "logo_notrasp.png" //"\logo.png"
private constant string ki_box_bianco = "box_bianco.bmp" //"\box_bianco.bmp"

public constant string ki_stampa_tipo_datawindow = "dw"
public constant string ki_stampa_tipo_datastore = "ds"
public constant string ki_stampa_tipo_grafico = "gr"
public constant string ki_stampa_tipo_datastore_diretta = "dsd"
public constant string ki_stampa_tipo_dw_diretta = "dwd"
public constant string ki_stampa_tipo_dw_rtf = "rtf"
public constant string ki_stampa_tipo_datastore_diretta_BATCH = "dsb"
public constant string ki_stampa_tipo_datastore_pdf_BATCH = "pdfb"

private constant string kki_dirEmail = "email"

//--- X modica font esempio il grgio con il neretto
public constant string ki_stampa_modificafont_NO = "no"

//--- elenco stampanti
private string ki_stampanti_elenco=""

//--- tabella 4 dim 
//--- [1,1] = nome testata (TEXT); [1,2]=proprieta visible; [1,3]=nome colonna da DB (edit o similare); [1,4]=nome colonna computed (che inizia x K_)
private string ki_tab_nome_oggetto[100,4]

private string ki_nome_dw_copia_x_stampa = ""
private string ki_sintax_dw_copia_x_stampa = ""

end variables

forward prototypes
public subroutine salva_personalizzazioni (ref datawindow kdw_print)
public subroutine personalizza_dw_print (ref datawindow kdw_inp, ref datawindow kdw_out)
public function boolean u_dammi_stampante (ref st_stampante kst_stampante)
public function string smista_stampe (ref datawindow kdw_print)
public subroutine dw_print_add_testata ()
public subroutine u_dw_personalizza_restore ()
public subroutine u_dw_personalizza_save ()
public subroutine u_dw_personalizza_inizializza_colonna (integer k_colonna)
public subroutine personalizza_dw_print_save (ref datawindow kdw_inp, ref datawindow kdw_out, ref datawindow kdw_orig)
public subroutine personalizza_dw_print_ripri ()
private function integer stampa_grafico ()
private function string dw_copia_x_stampa (integer k_tipo, datawindow k_dw_source, ref datawindow k_dw_target)
public subroutine u_dw_personalizza_restore_orig ()
public function boolean if_abilitare_pdf ()
public function st_esito ddlb_set_stampanti (ref dropdownlistbox kddlb_out)
public function string get_stampanti ()
private subroutine dw_copia_attributi (ref datastore k_ds_source, ref datawindow k_dw_target)
private subroutine dw_copia_attributi_innestate (ref datawindow k_dw_padre, ref datawindowchild k_dwc_iinnestata)
private subroutine olddw_estrae_nomi_col ()
private function string get_stampanti_definite ()
public function string get_stampanti_dwddlb_values ()
public function string get_stampante_da_nome (string a_nome)
public function string get_path_tempemail ()
private function string dw_set_fzoom_invisibili (string a_datawindow_syntax)
private function string u_get_dw_nomi_col (string a_datawindow_syntax)
public function string u_dw_sintax_pulizia (string a_datawindow_syntax)
end prototypes

public subroutine salva_personalizzazioni (ref datawindow kdw_print);//
//
//
//kuf_stampe kuf1_stampe

pointer oldpointer

//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


//--- Salvo le impostazioni personalizzate nella dw di stampa in .ini	
//	kuf1_stampe = create kuf_stampe
//	kuf1_stampe.kist_stampe_save.dw_print = kdw_print 
    kist_stampe_save.dw_print = kdw_print 
	u_dw_personalizza_save ()
//	destroy kuf1_stampe
				
	
	SetPointer(oldpointer)


end subroutine

public subroutine personalizza_dw_print (ref datawindow kdw_inp, ref datawindow kdw_out);//---
//--- Valorizza datawindows
//---
//---
string k_section, k_rcx
string k_nome, k_nome_testo, k_testo, k_visible, k_knome, k_syntax
int k_ctr, k_colcount, k_riga
kuf_utility kuf1_utility


//--- estrazione dei nomi dei txt
	kist_stampe_add_testata.dw_print = kdw_inp
	k_syntax = u_get_dw_nomi_col(kist_stampe_add_testata.dw_print.describe("DataWindow.Syntax"))

	kuf1_utility = create kuf_utility
	
//--- trova la larghezza orizzontale del datawindow
	k_riga = 1
	do while len(trim(ki_tab_nome_oggetto[k_riga, 1])) > 0  and k_riga < 100
	
		k_nome = trim(ki_tab_nome_oggetto[k_riga, 3])
		k_nome_testo = trim(ki_tab_nome_oggetto[k_riga, 1]) 
		k_knome = trim(ki_tab_nome_oggetto[k_riga, 4]) 
		
		k_rcx = trim(kdw_inp.Describe(k_nome_testo + ".text"))
		if len(trim(k_rcx)) > 0 and trim(k_rcx) <> "!" then
			k_testo = kuf1_utility.u_stringa_pulisci_x_msg(k_rcx)
//			k_testo = trim(k_rcx)
		end if

		if len(trim(k_testo)) > 0 then
			k_visible = trim(ki_tab_nome_oggetto[k_riga, 2])
			k_ctr = kdw_out.insertrow(0)
			if k_ctr > 0 then
				kdw_out.setitem(k_ctr, "progressivo", k_riga) 
				kdw_out.setitem(k_ctr, "titolo", k_testo) 
				kdw_out.setitem(k_ctr, "nome_campo", k_nome) 
				kdw_out.setitem(k_ctr, "nome_testata", k_nome_testo) 
				if trim(k_visible) = "1" then
					kdw_out.setitem(k_ctr, "flag_stampa", "S") 
				else
					kdw_out.setitem(k_ctr, "flag_stampa", "N") 
				end if
			end if
		end if
		
		k_riga++
		
	loop




end subroutine

public function boolean u_dammi_stampante (ref st_stampante kst_stampante);//---
//--- Trova la stampante indicata
//---
//--- input: reference della struttura st_stampante, riempire il campo 'trova'  
//--- 
//--- output: true/false x trovata/non trovata
//---
//
boolean k_return=false 
int k_ctr=1
st_stampante kst_stampante1


	kst_stampante1.stringa=PrintGetPrinters ()
	if len(trim(kst_stampante1.stringa)) > 0 then
		do while &
			k_ctr > 0 & 
			and kst_stampante1.porta <> kst_stampante.trova &
			and kst_stampante1.driver <> kst_stampante.trova &
			and kst_stampante1.nome <> kst_stampante.trova 
	
			k_ctr = pos (kst_stampante1.stringa, "~t")
			if k_ctr > 0 then
				kst_stampante1.nome = left(kst_stampante1.stringa, k_ctr -1)
			
				kst_stampante1.stringa = mid(kst_stampante1.stringa, k_ctr +1)
				k_ctr = pos (kst_stampante1.stringa, "~t")
				if k_ctr > 0 then
					kst_stampante1.driver = left(kst_stampante1.stringa, k_ctr -1)
				
					kst_stampante1.stringa = mid(kst_stampante1.stringa, k_ctr +1)
					k_ctr = pos (kst_stampante1.stringa, "~n")
					if k_ctr > 0 then
						kst_stampante1.porta = left(kst_stampante1.stringa, k_ctr -2)
						kst_stampante1.stringa = mid(kst_stampante1.stringa, k_ctr +1)
					else
						kst_stampante1.porta = mid(kst_stampante1.stringa, k_ctr +1)
					end if
				end if
			end if
			
		loop 
	
		if kst_stampante1.porta = kst_stampante.trova & 
			or kst_stampante1.driver = kst_stampante.trova & 
			or kst_stampante1.nome = kst_stampante.trova then 
			
			k_return = true
			
			kst_stampante.porta = kst_stampante1.porta
			kst_stampante.driver = kst_stampante1.driver
			kst_stampante.nome = kst_stampante1.nome
	
		end if
		
	end if

	
return k_return


end function

public function string smista_stampe (ref datawindow kdw_print);//
//
//
string k_return, k_ls_err
string k_scelta, k_size, k_msg, k_nome_dw, k_appox
long k_nr_rek
int k_rc
long k_rcl
int k_dwc_num, k_rc_dwc
string k_rcx
DataWindowChild kdwc_source


pointer oldpointer


//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

//
//=== Lancia le rispettive routine di stampa
	
	k_nr_rek = 0

	k_scelta = trim(kist_stampe.tipo)
	k_nome_dw = trim(kist_stampe.dataobject) 

	choose case trim( k_scelta )
	
		case  ki_stampa_tipo_datawindow  //stampa la dw scaricata su disco

			kdw_print.dataobject = k_nome_dw
			
			if len(trim(kist_stampe.dw_syntax)) > 0 then
				kdw_print.Create ( trim(kist_stampe.dw_syntax), k_ls_err )
			end if
			
			k_size = kGuf_data_base.profilestring_leggi_scrivi(1, "moduli", "0")
			
			kdw_print.settransobject ( sqlca )
			if isvalid(kdw_print) and isvalid(kist_stampe.dw_print) then
				if not isnull(kdw_print) and not isnull(kist_stampe.dw_print) then
					if kist_stampe.dw_print.rowcount( ) > 0 then
                    						      // source          target
						dw_copia_x_stampa(1, kist_stampe.dw_print, kdw_print) 

						k_nr_rek = kdw_print.rowcount() 
					end if
				end if
			end if
			if k_nr_rek <= 0 then
				k_msg = "Nessuna Stampa da effettuare (1),~n~rper la richiesta fatta"
			end if
	
	
		case ki_stampa_tipo_datastore  //stampa il Datastore 

			k_nome_dw = kist_stampe.ds_print.dataobject
			kdw_print.dataobject = k_nome_dw
			
//			if len(trim(kist_stampe.dw_syntax)) > 0 then
//				kdw_print.Create ( trim(kist_stampe.dw_syntax), k_ls_err )
//			end if
			
			kdw_print.settransobject ( sqlca )

			k_size = kGuf_data_base.profilestring_leggi_scrivi(1, "moduli", "0")
			kist_stampe.dw_print = create datawindow
			kdw_print.dataobject = kist_stampe.ds_print.dataobject
			k_nr_rek = kist_stampe.ds_print.rowcount()
			k_rc=kist_stampe.ds_print.RowsCopy(1, k_nr_rek, Primary!, kdw_print, 1, Primary!)
		
			if isvalid(kdw_print) then
				if not isnull(kdw_print) then
                    						   // source          target
//					dw_copia_x_stampa(1, kdw_print, kdw_print) 

					k_nr_rek = kdw_print.rowcount() 
				end if
			end if
			if k_nr_rek <= 0 then
				k_msg = "Nessuna Stampa da effettuare (2),~n~rper la richiesta fatta"
			end if


		case ki_stampa_tipo_grafico  //stampa graphic-control

			kdw_print.dataobject = k_nome_dw
			
			if len(trim(kist_stampe.dw_syntax)) > 0 then
				kdw_print.Create ( trim(kist_stampe.dw_syntax), k_ls_err )
			end if
			
			k_size = kGuf_data_base.profilestring_leggi_scrivi(1, "moduli", "0")
			
			kdw_print.settransobject ( sqlca )
			if isvalid(kdw_print) and isvalid(kist_stampe.dw_print) then
				if not isnull(kdw_print) and not isnull(kist_stampe.dw_print) then
                    						   // source          target
					dw_copia_x_stampa(2, kist_stampe.dw_print, kdw_print) 

					k_nr_rek = kdw_print.rowcount() 
				end if
			end if
			if k_nr_rek <= 0 then
				k_msg = "Nessuna Stampa da effettuare (3),~n~rper la richiesta fatta"
			end if



		case ki_stampa_tipo_datastore_diretta  //stampa il Datastore Diretta

			kdw_print.dataobject = k_nome_dw
			
			if len(trim(kist_stampe.dw_syntax)) > 0 then
				kdw_print.Create ( trim(kist_stampe.dw_syntax), k_ls_err )
			end if
			
			kdw_print.settransobject ( sqlca )

			k_size = kGuf_data_base.profilestring_leggi_scrivi(1, "moduli", "0")
			kist_stampe.dw_print = create datawindow
			k_rc=kist_stampe.ds_print.rowcount()
			kdw_print.dataobject = kist_stampe.ds_print.dataobject
			
			if isvalid(kdw_print) then

				k_nr_rek = kist_stampe.ds_print.rowcount() 

				k_dwc_num=1
				k_rc_dwc = kist_stampe.ds_print.GetChild("dw_"+string(k_dwc_num), kdwc_source) 
				if k_rc_dwc > 0 then

//------------------------------------------------------------------------
//--- opera sulle eventuali dw innestate (composite dw)			
//------------------------------------------------------------------------
					
					k_nr_rek = kdw_print.setfullstate(kist_stampe.blob_print)

//--- Imposta le Risorse grafiche anche delle DW innestate (composite dw)	
					k_dwc_num=1
					k_rc = kdw_print.GetChild("dw_"+string(k_dwc_num), kdwc_source) 
					do while k_rc = 1
						dw_copia_attributi_innestate(kdw_print, kdwc_source)   //--- copio attributi Pictures da DS nella dw_print come il nomefile del logo
						k_dwc_num ++
						k_rc = kdw_print.GetChild("dw_"+string(k_dwc_num), kdwc_source) 
					loop
//---------------------------------------------------------------------------					
				else
					dw_copia_attributi (kist_stampe.ds_print, kdw_print)   //--- copio attributi Pictures da DS nella dw_print come il nomefile del logo

//--- opera su normali dw/ds			
					k_nr_rek =  kist_stampe.ds_print.RowsCopy(1, kist_stampe.ds_print.rowcount(), Primary!,  kdw_print, 1, Primary!)
				end if
					 
			end if
			if k_nr_rek <= 0 then
				k_msg = "Nessuna Stampa da effettuare (4),~n~rper la richiesta fatta"
			end if


		case ki_stampa_tipo_dw_diretta  //stampa il DW Diretta

			kdw_print.dataobject = k_nome_dw
			
			if len(trim(kist_stampe.dw_syntax)) > 0 then
				kdw_print.Create ( trim(kist_stampe.dw_syntax), k_ls_err )
			end if
			
			kdw_print.settransobject ( sqlca )

			k_size = kGuf_data_base.profilestring_leggi_scrivi(1, "moduli", "0")
			kist_stampe.dw_print = create datawindow
			k_rc=kist_stampe.dw_print.rowcount()
			kdw_print.dataobject = kist_stampe.dw_print.dataobject
			k_rc=kist_stampe.dw_print.RowsCopy(1,kist_stampe.dw_print.rowcount(), Primary!,  kdw_print, 1, Primary!)
			
			if isvalid(kdw_print) then

				k_nr_rek = kdw_print.rowcount() 
				
			end if
			if k_nr_rek <= 0 then
				k_msg = "Nessuna Stampa da effettuare (5),~n~rper la richiesta fatta"
			end if


		case ki_stampa_tipo_dw_rtf

			kdw_print.dataobject = k_nome_dw
			
			if len(trim(kist_stampe.dw_syntax)) > 0 then
				kdw_print.Create ( trim(kist_stampe.dw_syntax), k_ls_err )
			end if
			
			k_size = kGuf_data_base.profilestring_leggi_scrivi(1, "moduli", "0")
			
			kdw_print.settransobject ( sqlca )
			if isvalid(kdw_print) then
				kdw_print.pasteRTF(kist_stampe.dw_print.copyRTF(false))
				k_nr_rek = kist_stampe.dw_print.rowcount() 
				
			end if
			if k_nr_rek <= 0 then
				k_msg = "Nessuna Stampa da effettuare (6),~n~rper la richiesta fatta"
			end if
	
		case else 
			k_nr_rek = 0 
			k_msg = "Funzione non riconosciuta !!"

	end choose

//--- Com'e' andata ?
	if k_nr_rek = 0 then

		k_return = "1" + k_msg

	else
		k_return = "0" + string( k_nr_rek, "00000" )
	end if
	
	SetPointer(oldpointer)



return k_return
end function

public subroutine dw_print_add_testata ();//---
//--- aggiunge la testata (logo+titolo+data) alla dw di stampa
//--- input: impostare in kist_stampe_add_testata il Titolo e dw_print
//---
long k_colcount=0, k_riga, k_pos_x, k_pos_x_max=0, k_width=0, k_pos_y=0, k_width_invisibile=0, k_y_testata=0
long k_ctr, k_ctr1, k_width_titoli, k_ind1, k_start_pos, k_dimensione_testata, k_end_pos
string k_rc, k_str, k_dw, k_path_risorse_box_bianco, k_path_risorse_logo, k_str_modify="", k_syntax
string k_xx, k_nome_tabulato=""
string k_visible_linea, k_visible_titolo, k_visible_titolo_2, k_visible_logo, k_visible_data_stampa, k_visible_pagina, k_visible_nome_tabulato, k_visible_tabulato
boolean k_testata_gia_presente = true
long kk_testata_altezza = 460 //520 //400 //--- in unita' PB
double k_conv_unita_pb=1
double k_logo_dim[4] // x,y,height,width


	
//--- chech unità di misura 0=pb, 3=1/1000 di CM, ecc... SPERIAMO SIA SOLO UNO DEI DUE...
	if kist_stampe_add_testata.dw_print.object.DataWindow.Units = '0' then
		k_conv_unita_pb = 1
	else
		k_conv_unita_pb = 6.75
	end if
	
	k_logo_dim[1] = 0.1 * k_conv_unita_pb // x
	k_logo_dim[2] = 0.1 * k_conv_unita_pb // y
	k_logo_dim[3] = 130 * k_conv_unita_pb // height
	k_logo_dim[4] = 1211 * k_conv_unita_pb // width 
	
//--- se la titolo 2 non esiste riduco la testata
	if len(trim(kist_stampe_add_testata.titolo_2)) = 0 then
		kk_testata_altezza = kk_testata_altezza * 0.8
	end if
	kk_testata_altezza = kk_testata_altezza * k_conv_unita_pb
	
//--- distruggo gli oggetti da mettere in testata (utile se sono al 'secondo giro')	
	if kist_stampe_add_testata.dw_print.describe( "testata1_titolo.text" ) = "!" then
		k_testata_gia_presente = false	
	else
		k_testata_gia_presente = true	
	end if

	k_visible_titolo = kist_stampe_add_testata.dw_print.describe( "testata1_titolo.visible" )
	if k_visible_titolo = "!" then 
	else
		k_str_modify += "destroy testata1_titolo "
	end if
	k_visible_linea = kist_stampe_add_testata.dw_print.describe( "testata1_linea.visible" )
	if k_visible_linea = "!" then 
	else
		k_str_modify += "destroy testata1_linea "
	end if
	k_visible_titolo_2 = kist_stampe_add_testata.dw_print.describe( "testata1_titolo_2.visible" )
	if k_visible_titolo_2 = "!" then 
		k_visible_titolo_2 = '1'
	else
		k_str_modify += "destroy testata1_titolo_2 "
	end if
	k_visible_logo = kist_stampe_add_testata.dw_print.describe( "testata1_logo.visible" )
	if k_visible_logo = "!" or k_visible_logo = "?" then 
	else
		k_str_modify += "destroy testata1_logo "
	end if
	k_visible_data_stampa = kist_stampe_add_testata.dw_print.describe( "testata1_data_stampa.visible" )
	if k_visible_data_stampa = "!" or k_visible_data_stampa = "?" then
		k_visible_data_stampa = '1'
	else
		k_str_modify += "destroy testata1_data_stampa "
	end if
	k_visible_pagina = kist_stampe_add_testata.dw_print.describe( "testata1_pagina.visible" )
	if k_visible_pagina = "!" or k_visible_pagina = "?" then
		k_visible_pagina = '1'
	else
		k_str_modify += "destroy testata1_pagina " 
	end if
	k_visible_nome_tabulato = kist_stampe_add_testata.dw_print.describe( "testata1_nome_tabulato.visible" )
	if k_visible_nome_tabulato = "!" or k_visible_nome_tabulato = "?" then
		k_visible_nome_tabulato = '1'
	else
		k_str_modify += "destroy testata1_nome_tabulato "
	end if
	k_visible_tabulato = kist_stampe_add_testata.dw_print.describe( "testata_box_sottofondo.visible" )
	if k_visible_tabulato = "!" or k_visible_tabulato = "?" then
	else
		k_str_modify += "destroy testata_box_sottofondo "
	end if
	k_visible_linea = '1'
	k_visible_titolo = '1'
	k_visible_logo = '1'
	
//	k_rc = kist_stampe_add_testata.dw_print.Modify( "destroy testata_box_sottofondo" )
//	k_rc = kist_stampe_add_testata.dw_print.Modify( "destroy testata1_logo" )
//	k_rc = kist_stampe_add_testata.dw_print.Modify( "destroy testata1_titolo" )
//	k_rc = kist_stampe_add_testata.dw_print.Modify( "destroy testata1_titolo_2" )
//	k_rc = kist_stampe_add_testata.dw_print.Modify( "destroy testata1_data_stampa" )
//	k_rc = kist_stampe_add_testata.dw_print.Modify( "destroy testata1_pagina" )
//	k_rc = kist_stampe_add_testata.dw_print.Modify( "destroy testata1_nome_tabulato" )
//--- se ho trovato qls applica le modifiche tutte insieme	
	if k_str_modify > " " then 
		k_xx = kist_stampe_add_testata.dw_print.Modify(k_str_modify)
		k_str_modify = "" 
	end if

//--- estrazione dei nomi dei txt
	k_syntax = u_get_dw_nomi_col(kist_stampe_add_testata.dw_print.describe("DataWindow.Syntax"))

//--- trova la larghezza orizzontale del datawindow
	k_ind1 = 1
	k_width_invisibile = 0
	do while trim(ki_tab_nome_oggetto[k_ind1, 1]) > " "  
//--- se oggetto invisibile lo devo poi sottrarre
		if ki_tab_nome_oggetto[k_ind1, 2] <> '1' then
			k_str = ki_tab_nome_oggetto[k_ind1, 1] + ".width"
			k_width_invisibile = k_width_invisibile + integer(trim(kist_stampe_add_testata.dw_print.Describe(k_str)))
		end if
			
//--- posizione colonna
		k_str = ki_tab_nome_oggetto[k_ind1, 1] + ".x"
		k_pos_x = integer(trim(kist_stampe_add_testata.dw_print.Describe(k_str)))
		if k_pos_x > k_pos_x_max then
			k_pos_x_max = k_pos_x
			k_str = ki_tab_nome_oggetto[k_ind1, 1] + ".width"
			k_width = integer(trim(kist_stampe_add_testata.dw_print.Describe(k_str))) + k_pos_x_max
		end if

		k_ind1++
	loop
//--- calcolo la larghezza della TESTATA 	
	k_width = k_width - k_width_invisibile

//--- se nessun campo di testata visibile allora la tolgo
	if k_visible_linea <> '1' and	k_visible_titolo <> '1' and k_visible_titolo_2 <> '1' and k_visible_logo <> '1' &
		and k_visible_data_stampa <> '1' and k_visible_pagina <> '1' and k_visible_nome_tabulato <> '1' then

//--- se era presente devo togliere le righe a spazio
		if not(k_testata_gia_presente) then
			k_dimensione_testata = 0
		else
			k_testata_gia_presente = false	
			k_dimensione_testata = -1 * kk_testata_altezza
		end if
	else

//--- sposta giu' la header di kk_testata_altezza solo se e' la prima volta
		if	not(k_testata_gia_presente) then
			k_dimensione_testata = kk_testata_altezza
		else
			k_dimensione_testata = 0
		end if
		
	end if
	
	if	k_dimensione_testata <> 0 then
			
//--- modifica dw aggiungendo la testata
		if k_width > 0 then
//--- allarga/restringe la header	di k_dimensione_testata	
			k_ctr = integer(kist_stampe_add_testata.dw_print.describe("DataWindow.Header.Height"))
			if k_ctr > 0 then
				k_ctr = k_ctr + k_dimensione_testata
				k_str_modify += "DataWindow.Header.Height='" + string(k_ctr)+ "' "
			end if
		end if

//--- porta giu' di k_dimensione_testata gli oggetti gia' presenti nella header		
		k_ind1 = 1 
		do while len(trim(ki_tab_nome_oggetto[k_ind1, 1])) > 0  
//--- se oggetto e' nella header
//			if trim(kist_stampe_add_testata.dw_print.Describe(ki_tab_nome_oggetto[k_ind1, 1] + ".band")) = "header" then
			k_str = trim(ki_tab_nome_oggetto[k_ind1, 1]) + ".y"
			k_rc = trim(kist_stampe_add_testata.dw_print.Describe(k_str))
			if isnumber(k_rc) then
				if integer(k_rc) <= k_dimensione_testata then
					k_pos_y = integer(k_rc) + k_dimensione_testata
					k_str_modify += k_str + "='" + string(k_pos_y)+ "' "
//					kist_stampe_add_testata.dw_print.Modify(k_str + "='" + string(k_pos_y)+ "'")
				end if
			end if
			k_ind1++
		loop
	end if
	

//--- Piglia il path di default delle ICONE
	k_path_risorse_logo = ki_logo_tabulato //kGuo_path.get_risorse() + kkg.path_sep + ki_logo_tabulato 
	k_path_risorse_box_bianco = ki_box_bianco //kGuo_path.get_risorse() + kkg.path_sep + ki_box_bianco 

//--- crea gli oggetti da mettere in testata	 
	if k_logo_dim[3] > k_dimensione_testata  then   	// HEIGHT
		k_logo_dim[3] = k_dimensione_testata 
		k_logo_dim[4] = k_logo_dim[3] * 4.45
	end if
	if k_logo_dim[4] > k_width then 	// WIDTH
		k_logo_dim[4] = k_width * 0.6 
		k_logo_dim[4] = k_logo_dim[4] / 4.45
	end if

	k_str_modify += &
		"create bitmap(band=foreground name=testata_box_sottofondo filename='" + trim(k_path_risorse_box_bianco) + "' x='" +string(0.1)+ "' y='" +string(0.1)+ "' height='" +string(k_dimensione_testata)+ "' width='" +string(k_width+50*k_conv_unita_pb)+ "' border='4'  visible='" + k_visible_linea + "' ) " 

	k_str_modify += &
		"create bitmap(band=foreground name=testata1_logo filename='" + trim(k_path_risorse_logo) + "' x='" +string(k_logo_dim[1])+ "' y='" +string(k_logo_dim[2])+ "' height='" +string(k_logo_dim[3])+ "' width='" +string(k_logo_dim[4])+ "' border='0'  visible='" + k_visible_logo + "' ) " 

	k_y_testata = 0.1 * k_conv_unita_pb //230

//	kist_stampe_add_testata.dw_print.Modify( &
	k_str_modify += &
		"create text(band=foreground name=testata1_nome_tabulato visible='" + k_visible_nome_tabulato + "' alignment='1' text='nome tabulato' border='0' color='0' x='" +string(k_width - 50*k_conv_unita_pb - 1400*k_conv_unita_pb) + "' y='" +string(0.1 + k_y_testata)+ "' height='" +string(90 * k_conv_unita_pb)+ "' width='" +string(1400 * k_conv_unita_pb)+ "' html.valueishtml='0' slideup=directlyabove  font.face='Arial' font.height='-10' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='" + string(kkg_colore.bianco) + "' ) "
					
	k_y_testata += k_dimensione_testata / 2.5 //230
	
//	kist_stampe_add_testata.dw_print.Modify( &
	k_str_modify += &
		"create text(band=foreground name=testata1_titolo visible='" + k_visible_titolo + "' alignment='2' text='Titolo'  border='0' color='0' x='" +string(20 * k_conv_unita_pb)+ "' y='" + string(10 * k_conv_unita_pb + k_y_testata) + "' height='" +string(90 * k_conv_unita_pb)+ "' width='" +string(k_width)+ "' html.valueishtml='0'  slideup=directlyabove  font.face='Arial' font.height='-14' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='" + string(kkg_colore.bianco) + "' ) " //3250 * k_conv_unita_pb
	if len(trim(kist_stampe_add_testata.titolo_2)) > 0 then
		k_y_testata += k_dimensione_testata / 3 //100
		k_str_modify += &
		"create text(band=foreground name=testata1_titolo_2 visible='" + k_visible_titolo_2 + "' alignment='0' text=' '   border='0' color='0' x='" +string(20 * k_conv_unita_pb)+ "' y='" + string(10 * k_conv_unita_pb + k_y_testata) + "' height='" +string(90 * k_conv_unita_pb)+ "' width='" +string(k_width)+ "' html.valueishtml='0'  slideup=directlyabove  font.face='Arial' font.height='-12' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='" + string(kkg_colore.bianco) + "' ) " //k_width - (420 * k_conv_unita_pb)
	end if

	k_y_testata += (k_dimensione_testata) / 3 //90
	k_str_modify += &
		"create text(band=foreground name=testata1_data_stampa alignment='0' text='Prodotto il ' border='0' color='0' x='" +string(20 * k_conv_unita_pb )+ "' y='" + string(10 * k_conv_unita_pb + k_y_testata ) + "' height='" +string(64 * k_conv_unita_pb)+ "' width='" +string(1600 * k_conv_unita_pb)+ "' html.valueishtml='0' visible='" + k_visible_data_stampa + "'  slideup=directlyabove  font.face='Arial' font.height='-10' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='" + string(kkg_colore.bianco) + "' ) " 
	
	k_rc = "~~t~~'Pag. ~~' + page() + ~~' di ~~' + pageCount() "									
	k_str_modify += &
		"create text(band=foreground name=testata1_pagina alignment='0' text='" + k_rc + "' border='0' color='0' x='" +string(10 * k_conv_unita_pb + k_width - 400)+ "' y='" + string(10 * k_conv_unita_pb + k_y_testata) + "' height='" +string(64 * k_conv_unita_pb)+ "' width='" +string(10 * k_conv_unita_pb + 380)+ "' html.valueishtml='0' visible='" + k_visible_pagina + "'  slideup=directlyabove  font.face='Arial' font.height='-10' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='" + string(kkg_colore.bianco) + "' ) " 

//--- se ho trovato qls applica le modifiche tutte insieme	
	if k_str_modify > " " then 
		k_xx = kist_stampe_add_testata.dw_print.Modify(k_str_modify)
		k_str_modify = "" 
	end if
	
	k_ctr = integer(kist_stampe_add_testata.dw_print.describe("testata1_logo.width"))
	k_ctr1 = integer(kist_stampe_add_testata.dw_print.describe("testata1_logo.x")) 
//	k_ctr2 = k_ctr1 + k_ctr
	k_width_titoli = k_width //- (k_ctr1 + k_ctr)
//	k_str_modify += "testata1_titolo.x='" + string(k_width_titoli) + "' "
//	kist_stampe_add_testata.dw_print.Modify("testata1_titolo.x='" + string(k_ctr2) + "'") 
	k_str_modify += "testata1_titolo.width='" + string(k_width_titoli) + "' "
//	k_rc = kist_stampe_add_testata.dw_print.Modify("testata1_titolo.width='" + string(k_width - k_ctr2) + "'") 
//--- titolo aggiunge apice ' con ~' 2 apici 
	k_xx = trim(kist_stampe_add_testata.titolo)
	if len(trim(k_xx)) > 0 then
		k_start_pos = pos(k_xx, "'", 1)
		DO WHILE k_start_pos > 0
			k_ctr = len(trim(k_xx)) - k_start_pos
			k_rc = "~~" + mid(k_xx, k_start_pos, k_ctr+1)
			k_xx = ReplaceA (k_xx, k_start_pos , k_ctr + 1, k_rc)
			k_start_pos = pos(k_xx, "'", k_start_pos+2)
		LOOP
		k_start_pos = pos(k_xx, "<", 1)
		if k_start_pos > 0 then  // accoda se c'è il nome della funzione che è di solito tra < e >
			k_end_pos = pos(k_xx, ">", k_start_pos+2)
			k_nome_tabulato = mid (k_xx, k_start_pos , k_end_pos)
			k_xx = mid (k_xx, k_end_pos + 1)
			k_xx += "  (" + trim(k_nome_tabulato) + ")"
		end if
	end if
	
	k_str_modify += "testata1_titolo.text='" + trim(k_xx) + "' "
//	kist_stampe_add_testata.dw_print.Modify("testata1_titolo.text='" + trim(k_xx) + "' ") 

//--- titolo 2 aggiunge apice ' con ~' 2 apici 
	if len(trim(kist_stampe_add_testata.titolo_2)) > 0 then
		k_xx = trim(kist_stampe_add_testata.titolo_2)
		if len(trim(k_xx)) > 0 then
			k_start_pos = pos(k_xx, "'", 1)
			DO WHILE k_start_pos > 0
				k_ctr = len(trim(k_xx)) - k_start_pos
				k_rc = "~~" + mid(k_xx, k_start_pos, k_ctr+1)
				k_xx = ReplaceA (k_xx, k_start_pos , k_ctr + 1, k_rc)
				k_start_pos = pos(k_xx, "'", k_start_pos+2)
			LOOP
		end if
		k_str_modify += "testata1_titolo_2.text='" + trim(k_xx) + "' "
		k_str_modify += "testata1_titolo_2.width='" + string(k_width_titoli) + "' "
//		kist_stampe_add_testata.dw_print.Modify("testata1_titolo_2.text='" + trim(k_xx) + "'") 
	end if

		
//--- se ho trovato qls applica le modifiche tutte insieme	
	if k_str_modify > " " then 
		k_xx = kist_stampe_add_testata.dw_print.Modify(k_str_modify)
		k_str_modify = "" 
	end if

	k_ctr = integer(kist_stampe_add_testata.dw_print.describe("testata1_nome_tabulato.width"))
//	k_str_modify += "testata1_nome_tabulato.x='" + string(k_width - k_ctr  - (70* k_conv_unita_pb)) + "'" + " "
//	kist_stampe_add_testata.dw_print.Modify("testata1_nome_tabulato.x='0.1'") // + string(k_width - k_ctr  - (70* k_conv_unita_pb)) + "'") 
	k_str_modify += "testata1_nome_tabulato.text=' tabulato:" + kist_stampe_add_testata.dataobject + "'" + " "
//	kist_stampe_add_testata.dw_print.Modify("testata1_nome_tabulato.text=' tabulato:" + kist_stampe_add_testata.dataobject + "'") 
	k_ctr = integer(kist_stampe_add_testata.dw_print.describe("testata1_pagina.width"))
//	k_str_modify += "testata1_pagina.x='" + string(k_width - (k_ctr * k_conv_unita_pb) - (70* k_conv_unita_pb)) + "'" + " "
//	kist_stampe_add_testata.dw_print.Modify("testata1_pagina.x='" + string(k_width - (k_ctr * k_conv_unita_pb) - (70* k_conv_unita_pb)) + "'") 
	k_str_modify += "testata1_data_stampa.width='" + string(k_width - (k_ctr * k_conv_unita_pb) - (150* k_conv_unita_pb)) + "'" + " "
//	kist_stampe_add_testata.dw_print.Modify("testata1_data_stampa.width='" + string(k_width - (k_ctr * k_conv_unita_pb) - (150* k_conv_unita_pb)) + "'") 
	k_str_modify += "testata1_data_stampa.text=' Prodotto il " + string(kguo_g.get_datetime_current(), "dd mmm yyyy hh:mm")  + " - Utente: " + lower(trim (kguo_utente.get_codice()))+ "'" + " "
//	kist_stampe_add_testata.dw_print.Modify("testata1_data_stampa.text=' Prodotto il " + string(today()) + "  " + string(now(), "hh:mm")  + " - da ut.: " + lower(trim (kguo_utente.get_codice()))+ "'") 

//--- se ho trovato qls applica le modifiche tutte insieme	
	if k_str_modify > " " then 
		k_xx = kist_stampe_add_testata.dw_print.Modify(k_str_modify)
		k_str_modify = "" 
	end if


end subroutine

public subroutine u_dw_personalizza_restore ();//---
//--- Ripristina le impostaz. personalizzate sulla dw
//---
//--- parametri di input: kist_stampe_restore
//---
//---
constant string k_tipo = "stampe"
string k_section, k_rcx 
string k_str, k_string, k_xx, k_nome, k_nome_testata, k_knome, k_str_modify="", k_syntax
st_profilestring_ini kst_profilestring_ini
int k_rc
int k_riga
long k_num


	k_section = k_tipo + "_" + trim(kist_stampe_restore.dw_print.dataobject)

	kst_profilestring_ini.operazione = "1"
	kst_profilestring_ini.valore = "1"
	kst_profilestring_ini.file = k_tipo 
	kst_profilestring_ini.titolo = k_tipo 

	kst_profilestring_ini.nome = k_section + "_orientation"
	k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
	k_rcx = kist_stampe_restore.dw_print.modify("DataWindow.Print.Orientation= '" &
									 + trim(kst_profilestring_ini.valore)  &
									 + "' ")

//
//	k_colcount = integer(kist_stampe_restore.dw_print.Describe("DataWindow.Column.Count"))
//
//	k_string = k_string + k_rcx 		
//
//	for k_ctr = 1 to k_colcount 
//
////--- estrae nome colonna
//		k_nome = trim(kist_stampe_restore.dw_print.Describe("#" + trim(string(k_ctr,"###")) + ".name"))
//
////--- cerco il nome della testata e costriosco il nome colonna e nome campo di testata
//		k_rcx=kist_stampe_restore.dw_print.Describe(k_nome + "_t" + ".visible") 
//		if len(trim(k_rcx)) = 0 or isnull(k_rcx) or trim(k_rcx) = "!" then
//			k_rcx=kist_stampe_restore.dw_print.Describe( "k_" + k_nome + "_t" + ".visible") 
//			if len(trim(k_rcx)) = 0 or isnull(k_rcx) or trim(k_rcx) = "!" then
//				k_rcx=kist_stampe_restore.dw_print.Describe( "t_" + trim(string(k_ctr,"###")) + ".visible") 
//				if len(trim(k_rcx)) = 0 or isnull(k_rcx) or trim(k_rcx) = "!" then
//					k_nome = ""
//				else
//					k_nome_testata = "t_" + trim(string(k_ctr,"###"))
//				end if
//			else
//				k_nome_testata = "k_" + k_nome + "_t"
//				k_nome = "k_" + k_nome
//			end if
//		else
//			k_nome_testata = k_nome + "_t"
//		end if


//--- estrazione dei nomi dei txt
	kist_stampe_add_testata = kist_stampe_restore
	k_syntax = u_get_dw_nomi_col(kist_stampe_add_testata.dw_print.describe("DataWindow.Syntax"))

//--- trova la larghezza orizzontale del datawindow
	k_riga = 1
	do while len(trim(ki_tab_nome_oggetto[k_riga, 1])) > 0  
	
		k_nome_testata = trim(ki_tab_nome_oggetto[k_riga, 1])
		k_nome = trim(ki_tab_nome_oggetto[k_riga, 3])
		k_knome = trim(ki_tab_nome_oggetto[k_riga, 4])

//
//--- se nome valido...
		if len(trim(k_nome)) > 0 then
		
//--- ripristina Proprieta' VISIBLE nel campo testo e colonna 
			kst_profilestring_ini.nome = k_section + "_" + k_nome + "_visible"
			k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
			if kst_profilestring_ini.esito = "0" &
					and trim(kst_profilestring_ini.valore) <> "nullo" &
					and trim(kst_profilestring_ini.valore) <> "!" then
				k_str_modify += k_nome + ".visible = '" &
											+ trim(kst_profilestring_ini.valore)  &
											+ "' "
//				k_rcx=kist_stampe_restore.dw_print.modify(k_nome + ".visible = '" &
//											+ trim(kst_profilestring_ini.valore)  &
//											+ "' " )
			else
				k_str_modify += k_nome + ".visible = '" &
											+ kist_stampe_orig.dw_print.describe(k_nome + ".visible") &
											+ "' "
//				k_rcx=kist_stampe_restore.dw_print.modify(k_nome + ".visible = '" &
//											+ kist_stampe_orig.dw_print.describe(k_nome + ".visible") &
//											+ "' " )  
			end if	
			if k_nome_testata > " " then
				k_str_modify += k_nome_testata + ".visible = '" &
										+ kist_stampe_orig.dw_print.describe(k_nome + ".visible") &
										+ "' " 
//				k_rcx=kist_stampe_restore.dw_print.modify(k_nome_testata + ".visible = '" &
//										+ kist_stampe_orig.dw_print.describe(k_nome + ".visible") &
//										+ "' " )  
			end if

//--- ripristina Proprieta' Width
			kst_profilestring_ini.nome = k_section + "_" + k_nome +"_w"
			k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
			if kst_profilestring_ini.esito = "0" &
				and trim(kst_profilestring_ini.valore) <> "nullo" &
				and trim(kst_profilestring_ini.valore) <> "!" then
				k_str_modify += k_nome + ".Width = " &
											+ trim(kst_profilestring_ini.valore)  &
											+ " "
//				k_rcx=kist_stampe_restore.dw_print.modify(k_nome + ".Width = " &
//											+ trim(kst_profilestring_ini.valore)  &
//											+ " " )
			else
				k_str_modify += k_nome + ".Width = " &
											+ kist_stampe_orig.dw_print.describe(k_nome + ".Width") &
											+ " " 
//				k_rcx=kist_stampe_restore.dw_print.modify(k_nome + ".Width = " &
//											+ kist_stampe_orig.dw_print.describe(k_nome + ".Width") &
//											+ " " )
			end if

//--- ripristina Proprieta' Height
			kst_profilestring_ini.nome = k_section + "_" + k_nome +"_h"
			k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
			if kst_profilestring_ini.esito = "0" &
					and trim(kst_profilestring_ini.valore) <> "nullo" &
					and trim(kst_profilestring_ini.valore) <> "!" then
				k_str_modify += k_nome + ".Height = " &
											+ trim(kst_profilestring_ini.valore)  &
											+ " " 
//				k_rcx=kist_stampe_restore.dw_print.modify(k_nome + ".Height = " &
//											+ trim(kst_profilestring_ini.valore)  &
//											+ " " )
			else
				k_str_modify += k_nome + ".Height = " &
											+ kist_stampe_orig.dw_print.describe(k_nome + ".Height") &
											+ " " 
//				k_rcx=kist_stampe_restore.dw_print.modify(k_nome + ".Height = " &
//											+ kist_stampe_orig.dw_print.describe(k_nome + ".Height") &
//											+ " " )  
			end if

			if k_knome > " " then
			
//--- ripristina Proprieta' VISIBLE nel campo K_
				kst_profilestring_ini.nome = k_section + "_" + k_knome + "_visible"
				k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
				if kst_profilestring_ini.esito = "0" &
						and trim(kst_profilestring_ini.valore) <> "nullo" &
						and trim(kst_profilestring_ini.valore) <> "!" then
					k_str_modify += k_knome + ".visible = '" &
												+ trim(kst_profilestring_ini.valore)  &
												+ "' " 
	//				k_rcx=kist_stampe_restore.dw_print.modify(k_knome + ".visible = '" &
	//											+ trim(kst_profilestring_ini.valore)  &
	//											+ "' " )
				else
					k_str_modify += k_knome + ".visible = '" &
												+ kist_stampe_orig.dw_print.describe(k_knome + ".visible") &
												+ "' "
	//				k_rcx=kist_stampe_restore.dw_print.modify(k_knome + ".visible = '" &
	//											+ kist_stampe_orig.dw_print.describe(k_knome + ".visible") &
	//											+ "' " )  
				end if										
		
//--- ripristina Proprieta' Width
				kst_profilestring_ini.nome = k_section + "_" + k_knome +"_w"
				k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
				if kst_profilestring_ini.esito = "0" &
						and trim(kst_profilestring_ini.valore) <> "nullo" &
						and trim(kst_profilestring_ini.valore) <> "!" then
					k_str_modify += k_knome + ".Width = " &
												+ trim(kst_profilestring_ini.valore)  &
												+ " " 
	//				k_rcx=kist_stampe_restore.dw_print.modify(k_knome + ".Width = " &
	//											+ trim(kst_profilestring_ini.valore)  &
	//											+ " " )
				else
					k_str_modify += k_knome + ".Width = " &
												+ kist_stampe_orig.dw_print.describe(k_knome + ".Width") &
												+ " " 
	//				k_rcx=kist_stampe_restore.dw_print.modify(k_knome + ".Width = " &
	//											+ kist_stampe_orig.dw_print.describe(k_knome + ".Width") &
	//											+ " " )
				end if
	
	//--- ripristina Proprieta' Height
				kst_profilestring_ini.nome = k_section + "_" + k_knome +"_h"
				k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
				if kst_profilestring_ini.esito = "0" &
						and trim(kst_profilestring_ini.valore) <> "nullo" &
						and trim(kst_profilestring_ini.valore) <> "!" then
					k_str_modify += k_knome + ".Height = " &
												+ trim(kst_profilestring_ini.valore)  &
												+ " "
	//				k_rcx=kist_stampe_restore.dw_print.modify(k_knome + ".Height = " &
	//											+ trim(kst_profilestring_ini.valore)  &
	//											+ " " )
				else
					k_str_modify += k_knome + ".Height = " &
												+ kist_stampe_orig.dw_print.describe(k_knome + ".Height") &
												+ " " 
	//				k_rcx=kist_stampe_restore.dw_print.modify(k_knome + ".Height = " &
	//											+ kist_stampe_orig.dw_print.describe(k_knome + ".Height") &
	//											+ " " )  
				end if
			end if
			
		end if
		
		k_riga++
	loop

//--- se ho trovato qls applica le modifiche tutte insieme	
	if k_str_modify > " " then 
		k_rcx = kist_stampe_restore.dw_print.Modify(k_str_modify)
		k_str_modify = ""
	end if


//return  trim(k_string) 

end subroutine

public subroutine u_dw_personalizza_save ();//---
//--- Salva le impostaz. personalizzate della dw
//---
//--- parametri di input:  kist_stampe_save.dw_print
//---
constant string k_tipo = "stampe"
string k_section, k_rcx 
string k_str, k_string, k_xx, k_nome, k_nome_testata, k_knome, k_syntax
st_profilestring_ini kst_profilestring_ini
int k_rc, k_riga
long k_num


	k_section = k_tipo + "_" + trim(kist_stampe_save.dw_print.dataobject)

	kst_profilestring_ini.operazione = "2"
	kst_profilestring_ini.valore = "0"
	kst_profilestring_ini.file = k_tipo
	kst_profilestring_ini.titolo = k_tipo
	
//	k_colcount = integer(kist_stampe_save.dw_print.Describe("DataWindow.Column.Count"))
//
//	k_string = k_string + k_rcx 		
//

//	for k_ctr = 1 to k_colcount 
//
////--- estrae nome colonna
//		k_nome = trim(kist_stampe_save.dw_print.Describe("#" + trim(string(k_ctr,"###")) + ".name"))

//--- estrazione dei nomi dei txt
	kist_stampe_add_testata = kist_stampe_save
	k_syntax = u_get_dw_nomi_col(kist_stampe_add_testata.dw_print.describe("DataWindow.Syntax"))

//--- trova la larghezza orizzontale del datawindow
	k_riga = 1
	do while len(trim(ki_tab_nome_oggetto[k_riga, 1])) > 0  
	
		k_nome_testata = trim(ki_tab_nome_oggetto[k_riga, 1])
		k_nome = trim(ki_tab_nome_oggetto[k_riga, 3])
		k_knome = trim(ki_tab_nome_oggetto[k_riga, 4])

////--- cerco il nome della testata e costriosco il nome colonna e nome campo di testata
//		k_rcx=kist_stampe_save.dw_print.Describe(k_nome + "_t" + ".visible") 
//		if len(trim(k_rcx)) = 0 or isnull(k_rcx) or trim(k_rcx) = "!" then
//			k_rcx=kist_stampe_save.dw_print.Describe( "k_" + k_nome + "_t" + ".visible") 
//			if len(trim(k_rcx)) = 0 or isnull(k_rcx) or trim(k_rcx) = "!" then
//				k_rcx=kist_stampe_save.dw_print.Describe( "t_" + trim(string(k_ctr,"###")) + ".visible") 
//				if len(trim(k_rcx)) = 0 or isnull(k_rcx) or trim(k_rcx) = "!" then
//					k_nome = ""
//				else
//					k_nome_testata = "t_" + trim(string(k_ctr,"###"))
//				end if
//			else
//				k_nome_testata = "k_" + k_nome + "_t"
//				k_nome = "k_" + k_nome
//			end if
//		else
//			k_nome_testata = k_nome + "_t"
//		end if
//
//--- se ho trovato un nome valido ok, altrimenti non elaboro
		if len(trim(k_nome)) > 0 then

//--- nome del campo .ini della testata				
			kst_profilestring_ini.valore = trim(k_nome_testata)
			kst_profilestring_ini.nome = k_section + "_" + k_nome + "_nome_testata"
			kGuf_data_base.profilestring_ini(kst_profilestring_ini)

//--- Proprieta' VISIBLE del campo Colonna ---------------------------------------------------
			k_rcx=kist_stampe_save.dw_print.Describe(k_nome + ".visible") 
			if len(trim(k_rcx)) > 0 and trim(k_rcx) <> "!" then
				kst_profilestring_ini.valore = trim(k_rcx)
				kst_profilestring_ini.nome = k_section + "_" + k_nome + "_visible"
				k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
			end if
		
//--- Proprieta' Width
			k_rcx=kist_stampe_save.dw_print.Describe(k_nome + ".Width") 
			if len(trim(k_rcx)) > 0 and trim(k_rcx) <> "!" then
				kst_profilestring_ini.valore = trim(k_rcx)
				kst_profilestring_ini.nome = k_section + "_" + k_nome +"_w" 
				k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
			end if

//--- Proprieta' Height
			k_rcx=kist_stampe_save.dw_print.Describe(k_nome + ".Height") 
			if len(trim(k_rcx)) > 0 and trim(k_rcx) <> "!" then
				kst_profilestring_ini.valore = trim(k_rcx)
				kst_profilestring_ini.nome = k_section + "_" + k_nome +"_h"
				k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
			end if

//--- Proprieta' Background.Color
			k_rcx=kist_stampe_save.dw_print.Describe(k_nome + ".Background.Color") 
			if len(trim(k_rcx)) > 0 and trim(k_rcx) <> "!" then
				kst_profilestring_ini.valore = trim(k_rcx)
				kst_profilestring_ini.nome = k_section + "_" + k_nome +"_BC"
				k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
			end if

//--- Proprieta' Color
			k_rcx=kist_stampe_save.dw_print.Describe(k_nome + ".Color") 
			if len(trim(k_rcx)) > 0 and trim(k_rcx) <> "!" then
				kst_profilestring_ini.valore = trim(k_rcx)
				kst_profilestring_ini.nome = k_section + "_" + k_nome +"_C"
				k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
			end if

//--- Proprieta' TEXT di TESTATA della colonna ---------------------------------------------------
			if k_nome_testata > " " then
				k_rcx=kist_stampe_save.dw_print.Describe( k_nome_testata + ".text") 
				if len(trim(k_rcx)) > 0 and trim(k_rcx) <> "!" then
					kst_profilestring_ini.valore = trim(k_rcx)
					kst_profilestring_ini.nome = k_section + "_" + k_nome_testata +"TXT"
					k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
				end if

//--- Proprieta' Background.Color di TESTATA della colonna
				k_rcx=kist_stampe_save.dw_print.Describe( k_nome_testata + ".Background.Color") 
				if len(trim(k_rcx)) > 0 and trim(k_rcx) <> "!" then
					kst_profilestring_ini.valore = trim(k_rcx)
					kst_profilestring_ini.nome = k_section + "_" + k_nome_testata +"BC"
					k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
				end if

//--- Proprieta' Color di TESTATA della colonna
				k_rcx=kist_stampe_save.dw_print.Describe( k_nome_testata + ".Color") 
				if len(trim(k_rcx)) > 0 and trim(k_rcx) <> "!" then
					kst_profilestring_ini.valore = trim(k_rcx)
					kst_profilestring_ini.nome = k_section + "_" + k_nome_testata +"C"
					k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
				end if
			end if


//--- Proprieta' VISIBLE nel campo K_ ---------------------------------------------------
			if k_nome_testata > " " then
				k_rcx=kist_stampe_save.dw_print.Describe(k_knome + ".visible") 
				if len(trim(k_rcx)) > 0 and trim(k_rcx) <> "!" then
					kst_profilestring_ini.valore = trim(k_rcx)
					kst_profilestring_ini.nome = k_section + "_" + k_knome + "_visible"
					k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
				end if
		
//--- Proprieta' Width
				k_rcx=kist_stampe_save.dw_print.Describe(k_knome + ".Width") 
				if len(trim(k_rcx)) > 0 and trim(k_rcx) <> "!" then
					kst_profilestring_ini.valore = trim(k_rcx)
					kst_profilestring_ini.nome = k_section + "_" + k_knome +"_w" 
					k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
				end if

//--- Proprieta' Height
				k_rcx=kist_stampe_save.dw_print.Describe(k_knome + ".Height") 
				if len(trim(k_rcx)) > 0 and trim(k_rcx) <> "!" then
					kst_profilestring_ini.valore = trim(k_rcx)
					kst_profilestring_ini.nome = k_section + "_" + k_knome +"_h"
					k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
				end if

//--- Proprieta' Background.Color
				k_rcx=kist_stampe_save.dw_print.Describe(k_knome + ".Background.Color") 
				if len(trim(k_rcx)) > 0 and trim(k_rcx) <> "!" then
					kst_profilestring_ini.valore = trim(k_rcx)
					kst_profilestring_ini.nome = k_section + "_" + k_knome +"_BC"
					k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
				end if

//--- Proprieta' Color
				k_rcx=kist_stampe_save.dw_print.Describe(k_knome + ".Color") 
				if len(trim(k_rcx)) > 0 and trim(k_rcx) <> "!" then
					kst_profilestring_ini.valore = trim(k_rcx)
					kst_profilestring_ini.nome = k_section + "_" + k_knome +"_C"
					k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
				end if
				
			end if
		end if
		
		k_riga++
	loop
//	next



end subroutine

public subroutine u_dw_personalizza_inizializza_colonna (integer k_colonna);//---
//--- Applica le impostaz. personalizzate sulla dw
//---
//--- parametri di input: kist_stampe_save
//---
constant string k_tipo = "stampe"
string k_section, k_rcx 
string k_str, k_xx, k_nome, k_nome_testata, k_knome, k_syntax
st_profilestring_ini kst_profilestring_ini
int k_rc
int k_ctr
long k_num


	k_section = k_tipo + "_" + trim(kist_stampe_save.dw_print.dataobject)
	k_ctr = k_colonna


	kst_profilestring_ini.operazione = "3"
	kst_profilestring_ini.valore = " "
	kst_profilestring_ini.titolo = k_tipo
	
//	k_colcount = integer(kist_stampe_save.dw_print.Describe("DataWindow.Column.Count"))
	
//--- estrae nomi testata colonne
	kist_stampe_add_testata = kist_stampe_save
	k_syntax = u_get_dw_nomi_col(kist_stampe_add_testata.dw_print.describe("DataWindow.Syntax"))

	
//--- estrae nome colonna
//	k_nome = trim(kist_stampe_save.dw_print.Describe("#" + trim(string(k_ctr,"###")) + ".name"))
	k_nome = ki_tab_nome_oggetto[k_ctr, 3]
	k_nome_testata = ki_tab_nome_oggetto[k_ctr, 1]
	k_knome = trim(ki_tab_nome_oggetto[k_ctr, 4])
		
//--- ripristina Proprieta' VISIBLE nel campo testo e colonna 
	k_rcx=kist_stampe_save.dw_print.Describe(trim(k_nome) + ".visible") 
	if k_rcx <> "!" then
		kst_profilestring_ini.nome = k_section + "_" + k_nome +"_visible"
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
	end if
	
	k_rcx=kist_stampe_save.dw_print.Describe(k_nome_testata + ".visible") 
	if k_rcx <> "!" then
		kst_profilestring_ini.nome = k_section + "_" + k_nome_testata +"_visible"
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
	end if
	
	k_rcx=kist_stampe_save.dw_print.Describe(k_knome + ".visible") 
	if k_rcx <> "!" then
		kst_profilestring_ini.nome = k_section + k_knome +"_visible"
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
	end if
	

//--- ripristina Proprieta' Width
//	k_rcx=kist_stampe_save.dw_print.Describe("#" + trim(string(k_ctr,"###")) + ".Width") 
	k_rcx=kist_stampe_save.dw_print.Describe(trim(k_nome) + ".Width") 
	if k_rcx <> "!" then
		kst_profilestring_ini.nome = k_section + "_" + k_nome +"_w"
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
	end if
	k_rcx=kist_stampe_save.dw_print.Describe(trim(k_knome) + ".Width") 
	if k_rcx <> "!" then
		kst_profilestring_ini.nome = k_section + "_" + k_knome +"_w"
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
	end if

//--- ripristina Proprieta' Height
//	k_rcx=kist_stampe_save.dw_print.Describe("#" + trim(string(k_ctr,"###")) + ".Height") 
	k_rcx=kist_stampe_save.dw_print.Describe(trim(k_nome) + ".Height") 
	if k_rcx <> "!" then
		kst_profilestring_ini.nome = k_section + "_" + k_nome +"_h"
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
	end if
	k_rcx=kist_stampe_save.dw_print.Describe(trim(k_knome) + ".Height") 
	if k_rcx <> "!" then
		kst_profilestring_ini.nome = k_section + "_" + k_knome +"_h"
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
	end if

//--- ripristina Proprieta' Background.Color
//	k_rcx=kist_stampe_save.dw_print.Describe("#" + trim(string(k_ctr,"###")) + ".Background.Color") 
	k_rcx=kist_stampe_save.dw_print.Describe(trim(k_nome) + ".Background.Color") 
	if k_rcx <> "!" then
		kst_profilestring_ini.nome = k_section + "_" + k_nome +"_BC"
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
	end if
	k_rcx=kist_stampe_save.dw_print.Describe(trim(k_knome) + ".Background.Color") 
	if k_rcx <> "!" then
		kst_profilestring_ini.nome = k_section + "_" + k_knome +"_BC"
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
	end if

//--- ripristina Proprieta' Foreground.Color
//	k_rcx=kist_stampe_save.dw_print.Describe("#" + trim(string(k_ctr,"###")) + ".Color") 
	k_rcx=kist_stampe_save.dw_print.Describe(trim(k_nome) + ".Color") 
	if k_rcx <> "!" then
		kst_profilestring_ini.nome = k_section + "_" + k_nome +"_C"
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
	end if
	k_rcx=kist_stampe_save.dw_print.Describe(trim(k_knome) + ".Color") 
	if k_rcx <> "!" then
		kst_profilestring_ini.nome = k_section + "_" + k_knome +"_C"
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
	end if

//--- ripristina Proprieta' TEXT di TESTATA della colonna
	k_rcx=kist_stampe_save.dw_print.Describe( k_nome_testata + ".text") 
	if k_rcx <> "!" then
		kst_profilestring_ini.nome = k_section + "_" + k_nome_testata +"TXT"
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
	end if

//--- ripristina Proprieta' Background.Color di TESTATA della colonna
	k_rcx=kist_stampe_save.dw_print.Describe( k_nome_testata + ".Background.Color") 
	if k_rcx <> "!" then
		kst_profilestring_ini.nome = k_section + "_" + k_nome_testata +"BC"
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
	end if

//--- ripristina Proprieta' Color di TESTATA della colonna
	k_rcx=kist_stampe_save.dw_print.Describe( k_nome_testata + ".Color") 
	if k_rcx <> "!" then
		kst_profilestring_ini.nome = k_section + "_" + k_nome_testata + "C"
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
	end if
	



end subroutine

public subroutine personalizza_dw_print_save (ref datawindow kdw_inp, ref datawindow kdw_out, ref datawindow kdw_orig);//---
//--- Valorizza datawindows
//---
//---
//--- Dalla DW di personalizzazioni imposto quella di stampa e salvo il tutto in .ini
//--- par. Input:   kdw_inp = dw di personalizzazione
//---               kdw_out = dw di stampa
//---
string k_section, k_rcx 
string k_nome, k_nome_testo, k_testo, k_visible, k_str_modify=""
int k_ctr, k_colcount,k_numcol
long k_righe, k_rc
//kuf_stampe kuf1_stampe


	
//	k_colcount = integer(kdw_.Describe("DataWindow.Column.Count"))

	kdw_inp.accepttext()

	k_righe = kdw_inp.rowcount()

	for k_ctr = 1 to k_righe

		k_numcol = (kdw_inp.getitemnumber(k_ctr, "progressivo") )
		k_nome = trim(kdw_inp.getitemstring(k_ctr, "nome_campo") )
		k_nome_testo = trim(kdw_inp.getitemstring(k_ctr, "nome_testata") )
		k_rcx = trim(kdw_inp.getitemstring(k_ctr, "flag_stampa")) 
		if trim(k_rcx) = "S" then
			k_visible = "1"
		else
			k_visible = "0"
		end if
		k_testo = trim(kdw_inp.getitemstring(k_ctr, "titolo")) 
//		k_ripristina = kdw_inp.getitemstring(k_ctr, "ripri") 
		
		k_str_modify += k_nome_testo + ".text ='" + k_testo + "' " + " "
//		k_rcx = trim(kdw_out.modify(k_nome_testo + ".text ='" + k_testo + "' "))
		k_str_modify += k_nome_testo + ".visible = '" + k_visible + "' " + " "
//		k_rcx = trim(kdw_out.modify(k_nome_testo + ".visible = '" + k_visible + "' "))
		if k_nome > " " then
			k_str_modify += k_nome + ".visible = '" + k_visible + "' " + " "
//			k_rcx = trim(kdw_out.modify(k_nome + ".visible = '" + k_visible + "' "))
			if kdw_out.describe( "k_" + k_nome + ".visible") <> "!" then
				k_str_modify += "k_" + k_nome + ".visible = '" + k_visible + "' " + " "
//				k_rcx = trim(kdw_out.modify("k_" + k_nome + ".visible = '" + k_visible + "' "))
			end if
		end if

	next

//--- se ho trovato qls applica le modifiche tutte insieme	
	if k_str_modify > " " then 
		k_rcx = kdw_out.Modify(k_str_modify)
		k_str_modify=""
	end if

//	kuf1_stampe = create kuf_stampe

//--- Salvo le impostazioni personalizzate della dw di stampa in .ini	
	kist_stampe_save.dw_print = kdw_out 
	u_dw_personalizza_save ()

	
//--- Dove indicato, inizializzo le impostazioni personalizzate della dw di stampa in .ini	
	for k_ctr = 1 to k_righe

		if kdw_inp.getitemstring(k_ctr, "ripri") = "S" then
		
			k_numcol = (kdw_inp.getitemnumber(k_ctr, "progressivo") )
			kist_stampe_save.dw_print = kdw_orig 
			u_dw_personalizza_inizializza_colonna ( k_numcol )
			
		end if

	next
	
//--- Imposto le impostazioni personalizzate nella dw di stampa da .ini	
//	kuf1_stampe.u_dw_personalizza_restore ( kdw_out, "stampe" )
	
//	destroy kuf1_stampe
	
end subroutine

public subroutine personalizza_dw_print_ripri ();//---
//--- Ripristino datawindows originale
//---
//--- par. Input:   kist_stampe_orig = dw originale
//---
int k_riga
string k_syntax

	

//--- estrazione dei nomi dei txt
	kist_stampe_add_testata = kist_stampe_orig
	k_syntax = u_get_dw_nomi_col(kist_stampe_add_testata.dw_print.describe("DataWindow.Syntax"))

//--- trova la larghezza orizzontale del datawindow
	k_riga = 1
	do while len(trim(ki_tab_nome_oggetto[k_riga, 1])) > 0  
	
		kist_stampe_save.dw_print = kist_stampe_orig.dw_print 
		u_dw_personalizza_inizializza_colonna ( k_riga )
		
		k_riga ++
			
	loop
	
end subroutine

private function integer stampa_grafico ();//
//--- stampa il Grafico (graph control) passato
//
int k_return, k_rc
long Job

Job = PrintOpen( )

k_rc = Print(Job, kist_stampe.titolo)
if k_rc > 0 then
	k_rc = kist_stampe.dw_print.object.kgr_1.Print(Job, 100,100) // 6000,4500)
end if
if k_rc <= 0 then
	k_return = -1
end if

//PrintPage(Job)

//w_sales.Print(Job, 1000,500, 6000,4500)

PrintClose(Job)

return k_return


end function

private function string dw_copia_x_stampa (integer k_tipo, datawindow k_dw_source, ref datawindow k_dw_target);//---
//--- Copia DW in DW mettendo anche le Prorieta' del sorgente
//--- le quali si possono aggiungere man mano che servono 
//---
//--- parametri di input:
//---    k_tipo tipo elaborazione: 2=stampa grafico
//---    k_dw_source  la dw sorgente
//---    k_dw_target  la dw in cui copiare
//---
//--- parametro di out: stringa se ""=OK se <> "" allora errore 
//---
long k_rc
string  k_rcx, k_rc1x, k_str, k_string, k_xx, k_nome, k_nome_testata, k_type, k_strx, k_knome, k_str_modify="",k_syntax
long k_ctr, k_colnum, k_colcount, k_riga
long k_num, k_righe, k_start_pos=0, k_righe_loop=0
string k_visible
boolean k_colonna_valorizzata


//--- se l'ho già trattata esco
	if ki_nome_dw_copia_x_stampa = k_dw_source.dataobject then
		
		k_dw_target.create(ki_sintax_dw_copia_x_stampa)
		return ""  // ESCE!!!!
		
	end if
	ki_sintax_dw_copia_x_stampa = k_dw_target.describe("DataWindow.Syntax")
	ki_nome_dw_copia_x_stampa = k_dw_source.dataobject

	k_righe = k_dw_source.rowcount()
	k_righe_loop = k_righe
	if k_righe_loop > 100 then k_righe_loop = 0 // limitato a 100 righe
	
//--- Copia delle RIGHE
	k_rc = k_dw_source.rowscopy(1, k_righe, primary!,k_dw_target,1, primary!)


//	k_colcount = integer(k_dw_source.Describe("DataWindow.Column.Count"))

//--- copia Proprieta' PRINT ORIENTATIONE della dw
	k_rcx=k_dw_target.modify("DataWindow.Print.Orientation= '" &
									+ trim(k_dw_source.describe("DataWindow.Print.Orientation")) + "'")

	k_string = k_string + k_rcx 		

//--- estrae nomi testata colonne
	kist_stampe_add_testata.dw_print = k_dw_source
	k_syntax = dw_set_fzoom_invisibili(kist_stampe_add_testata.dw_print.describe("DataWindow.Syntax"))
	if k_syntax > " " then
		kist_stampe_add_testata.dw_print.Modify(k_syntax)
	end if
	k_syntax = u_get_dw_nomi_col(kist_stampe_add_testata.dw_print.describe("DataWindow.Syntax"))
	if k_syntax > " " then
		kist_stampe_add_testata.dw_print.Modify(k_syntax)
	end if

//--- stampa grafico
	if k_tipo = 2 then
		k_rcx=k_dw_target.modify("kgr_1" + ".visible = 1")
	end if

//--- trova la larghezza orizzontale del datawindow
	k_colnum = 1
//	do while len(trim(ki_tab_nome_oggetto[k_colnum, 1])) > 0  
	for k_colnum = 1 to 40 // su 50 colonne

//	for k_colnum = 1 to k_colcount 

//--- estrae nome colonna
		k_nome = trim(ki_tab_nome_oggetto[k_colnum, 3])
		k_nome_testata = trim(ki_tab_nome_oggetto[k_colnum, 1])
		k_knome = trim(ki_tab_nome_oggetto[k_colnum, 4])

//--- tolgo eventuli DW child visibili 
		if k_nome > " " then
			k_rcx=(trim(k_dw_source.describe( k_nome + ".DDDW.Name" ))) 
			k_rc1x=(trim(k_dw_source.describe( k_nome + ".DDLB.VScrollBar" )))
			if (len(k_rcx) > 0 and k_rcx <> "!" ) or (len(k_rc1x) > 0 and k_rc1x <> "!") then
				k_str_modify += k_nome + ".Edit.DisplayOnly='Yes'" + " "
//				k_rcx=k_dw_target.modify( k_nome + ".Edit.DisplayOnly='Yes'") 
			end if
		end if		
		
		if k_nome > " " then
//--- copia Proprieta' VISIBLE
			k_visible = trim(ki_tab_nome_oggetto[k_colnum, 2])

//--- Forza a INVISIBILE se colonna si chiama 'FZOOM', poichè buona solo a video (funzione di ZOOM)
			if pos(k_nome,"fzoom",1) > 0 then k_visible = "0"
		
//--- se visible, se nessun valore nella colonna la toglie		
			if k_visible = "1" and k_righe_loop > 0 then 
				k_riga = 1
				k_colonna_valorizzata = false
				do 
//					k_type = upper(trim(string(k_dw_source.Describe(k_nome+".Coltype"))))
//					if trim(k_type) > " " then
//						k_strx = trim(string(k_dw_source.object.data[k_colnum,k_riga]))
//					end if
					
					k_type = upper(trim(string(k_dw_source.Describe(k_nome+".Coltype"))))
					choose case left(k_type, 2)
						case "CH"
							k_strx = trim(k_dw_source.getitemstring(k_riga, k_nome))
						case "DA"
							if left(k_type, 5) = "DATET" then
								k_strx = trim(string(k_dw_source.getitemdatetime(k_riga, k_nome)))
							else
								k_strx = trim(string(k_dw_source.getitemdate(k_riga, k_nome)))
							end if
						case "TI"
							k_strx = trim(string(k_dw_source.getitemtime(k_riga, k_nome)))
						case "IN", "NU", "LO", "UL", "DE"
							if len(trim(k_nome)) > 0 then
								k_strx = trim(string(k_dw_source.getitemnumber(k_riga, k_nome)))
							end if
						case else
							k_strx = "Tipo DATO '" + trim(k_type) + "' non riconosciuto col: " +  trim(k_nome)
							kguo_exception.inizializza( )
							kguo_exception.kist_esito.esito = kkg_esito.ko
							kguo_exception.kist_esito.sqlerrtext = "Tipo dato non riconosciuto: " + k_type + ", nome campo: " + k_nome + ", riga: " + string(k_riga)
							kguo_exception.kist_esito.nome_oggetto = this.classname( )
							kguo_exception.scrivi_log( )
					end choose
					
					if trim(string(k_strx)) > " " then
						k_colonna_valorizzata = true
					end if
					k_riga++
				loop while k_riga <= k_righe_loop and not k_colonna_valorizzata 
				if not k_colonna_valorizzata then
					k_visible = "0"
				end if
			end if
			k_str_modify +=  k_nome + ".visible = '" + k_visible + "' "
			k_string = k_string + k_rcx 										
		end if
		
		if k_knome > " " then
			k_visible = k_dw_source.Describe(k_knome + ".visible")
//--- Forza a INVISIBILE se colonna si chiama 'FZOOM', poichè buona solo a video (funzione di ZOOM)
			if pos(k_knome,"fzoom",1) > 0 then k_visible = "0"

//--- se visible, se nessun valore nella colonna la toglie		
			if k_visible = "1" and k_righe_loop > 0 then 
				k_riga = 1
				k_colonna_valorizzata = false
				do 
					k_type = upper(trim(string(k_dw_source.Describe(k_knome+".Coltype"))))
					if k_type > " " and k_type <> "!" then
						k_strx = trim(string(k_dw_source.object.data[k_colnum,k_riga]))
						k_strx = ""
						choose case left(k_type, 2)
							case "CH"
								k_strx = trim(k_dw_source.getitemstring(k_riga, k_knome))
							case "DA"
								if left(k_type, 5) = "DATET" then
									k_strx = trim(string(k_dw_source.getitemdatetime(k_riga, k_knome)))
								else
									k_strx = trim(string(k_dw_source.getitemdate(k_riga, k_knome)))
								end if
							case "TI"
								if left(k_type, 5) = "TIMES" then
									k_strx = trim(string(k_dw_source.getitemdatetime(k_riga, k_knome)))
								else
									k_strx = trim(string(k_dw_source.getitemtime(k_riga, k_knome)))
								end if
							case "RE"
								k_strx = "COLTYPE non riconosciuto: " + k_type
							case else
								k_strx = "COLTYPE non riconosciuto: " + k_type
						end choose
					end if
					if trim(string(k_strx)) = "" then
					else
						k_colonna_valorizzata = true
					end if
					k_riga++
				loop while k_riga <= k_righe_loop and not k_colonna_valorizzata 
				if not k_colonna_valorizzata then
					k_visible = "0"
				end if
			end if
			k_str_modify += k_knome + ".visible = '" + k_visible + "' "
			k_string = k_string + k_rcx 
		end if
		
		if k_nome > " " then
//--- copia Proprieta' WIDTH
			if pos(k_nome,"fzoom",1) > 0 then
				k_str_modify += k_nome + ".Width = 1" + " "
//				k_rcx=k_dw_target.modify(k_nome + ".Width = 1" )
			else
				k_str_modify += k_nome + ".Width = " + k_dw_source.Describe(k_nome + ".Width") + " "
//				k_rcx=k_dw_target.modify(k_nome + ".Width = " + k_dw_source.Describe(k_nome + ".Width") + " " )
			end if
			k_string = k_string + k_rcx 										
			k_str_modify += k_nome + ".Width = " + k_dw_source.Describe(k_nome + ".Width") + " "
//			k_rcx=k_dw_target.modify(k_nome + ".Width = " + k_dw_source.Describe(k_nome + ".Width") + " " )
			k_string = k_string + k_rcx 										
	
	//--- copia Proprieta' HEIGHT
			k_str_modify += k_nome + ".Height = " + k_dw_source.Describe(k_nome + ".Height") + " "
//			k_rcx=k_dw_target.modify(k_nome + ".Height = " + k_dw_source.Describe(k_nome + ".Height") + " " )
			k_string = k_string + k_rcx 										
			k_str_modify += k_nome + ".Height = " + k_dw_source.Describe(k_nome + ".Height") + " "
//			k_rcx=k_dw_target.modify(k_nome + ".Height = " + k_dw_source.Describe(k_nome + ".Height") + " " )
			k_string = k_string + k_rcx 										
	
	//--- Forza proprieta' NO BORDER 
			k_str_modify += k_nome + ".Border = '0'" + " "	
			// k_rcx=k_dw_target.modify(k_nome + ".Border = '0'")
			k_string = k_string + k_rcx 										
			k_str_modify += k_nome + ".Border = '0'" + " "	
			// k_rcx=k_dw_target.modify(k_nome + ".Border = '0'" )
			k_string = k_string + k_rcx 										
	
	//--- Forza Colore background a bianco
			k_str_modify += k_nome + ".Background.Color = '" + string(kkg_colore.BIANCO) + "' " + " "	
			// k_rcx=k_dw_target.modify(k_nome + ".Background.Color = '" + string(kkg_colore.BIANCO) + "' " )
			k_string = k_string + k_rcx 										
			k_str_modify += k_nome + ".Background.Color = '" + string(kkg_colore.BIANCO) + "' " + " "	
			// k_rcx=k_dw_target.modify(k_nome + ".Background.Color = '" + string(kkg_colore.BIANCO) + "' " )
			k_string = k_string + k_rcx 										
	
	//--- Forza Colore testo a nero
			k_str_modify += k_nome + ".Color = '" + string(kkg_colore.NERO) + "' " + " "	
			// k_rcx=k_dw_target.modify(k_nome + ".Color = '" + string(kkg_colore.NERO) + "' " )
			k_string = k_string + k_rcx 										
			k_str_modify += k_nome + ".Color = '" + string(kkg_colore.NERO) + "' " + " "	
			// k_rcx=k_dw_target.modify(k_nome + ".Color = '" + string(kkg_colore.NERO) + "' " )
			k_string = k_string + k_rcx 										
			
	//--- copia eventuale nome file '.bmp' 
			if k_dw_source.Describe(k_nome + ".Filename") <> "!" then
				k_str_modify += k_nome + ".Filename='" + k_dw_source.Describe(k_nome + ".Filename") + "' " + " "	
				// k_rcx=k_dw_target.modify(k_nome + ".Filename='" + k_dw_source.Describe(k_nome + ".Filename") + "' " )
				k_string = k_string + k_rcx 										
			end if
			
			if k_dw_source.Describe("b_" + trim(k_nome) + ".visible") <> "!" then
				k_str_modify += "b_" + trim(k_nome) + ".visible = '" + k_dw_source.Describe(trim(k_nome) + ".visible") + "' " + " "	
				// k_rcx=k_dw_target.modify( "b_" + trim(k_nome) + ".visible = " + k_dw_source.Describe(trim(k_nome) + ".visible") + " " )
			end if
		end if

		if k_nome_testata > " " and k_nome > " " then
//--- copia Proprieta' TESTATA della colonna
			k_str_modify += k_nome_testata  +  ".visible = '" + k_dw_source.Describe(k_nome + ".visible") + "' " + " "	
			// k_rcx=k_dw_target.modify( k_nome_testata  +  ".visible = " + k_dw_source.Describe(k_nome + ".visible") + " " )
		
////--- se errore provo ad aggiungere il prefisso k_ 
////--- copia Proprieta' TESTATA della colonna
//			k_str_modify += "k_" + k_nome_testata + ".visible = '" + k_dw_source.Describe("k_" + k_nome + ".visible") + "' " + " "	
//			// k_rcx=k_dw_target.modify( "k_" + k_nome_testata + ".visible = " + k_dw_source.Describe("k_" + k_nome + ".visible") + " " )
//			k_string = k_string + k_rcx 										
		end if
		
		if k_nome_testata > " " then
		
//--- copia Proprieta' TESTO della TESTATA della colonna
			k_xx = k_dw_source.Describe(k_nome_testata + ".text")
//--- toglie gli apici doppi dai campi
			if trim(k_xx) > " " and k_xx <> "!" then
				k_start_pos = pos(k_xx, '"', 1)
				DO WHILE k_start_pos > 0
					k_xx = ReplaceA (k_xx, k_start_pos, 1, " ")
					k_start_pos = pos(k_xx, '"', k_start_pos)
				LOOP
			end if
//--- aggiunge apice ' con ~' 2 apici 
			if trim(k_xx) > " " and k_xx <> "!" then
				k_start_pos = pos(k_xx, "'", 1)
				DO WHILE k_start_pos > 0
					k_ctr = len(trim(k_xx)) - k_start_pos
					k_rcx = "~~" + mid(k_xx, k_start_pos, k_ctr+1)
					k_xx = ReplaceA (k_xx, k_start_pos , k_ctr + 1, k_rcx)
					k_start_pos = pos(k_xx, "'", k_start_pos+2)
				LOOP
			end if
//		if len(trim(k_xx)) > 0 then
//			k_start_pos = Pos(k_xx, "'", 1)
//			DO WHILE k_start_pos > 0
//				k_ctr = len(trim(k_xx)) - k_start_pos
//				k_xx = replace (k_xx, k_start_pos - 1, k_ctr + 2, "~'" + mid(k_xx, k_start_pos, k_ctr+1))
//				k_start_pos = Pos(k_xx, "'", k_start_pos+2)
//			LOOP
//		end if
			k_str_modify += k_nome_testata + ".text = ' " + trim(k_xx) + "' " + " "	
			// k_rcx=k_dw_target.modify( k_nome_testata + ".text = ' " + trim(k_xx) + "' " )
//			k_xx = k_dw_source.Describe("k_" + k_nome_testata + ".text")
//--- toglie gli apici doppi dai campi
//			if trim(k_xx) > " " and k_xx <> "!" then
//				k_start_pos = pos(k_xx, '"', 1)
//				DO WHILE k_start_pos > 0
//					k_xx = ReplaceA (k_xx, k_start_pos, 1, " ")
//					k_start_pos = pos(k_xx, '"', k_start_pos)
//				LOOP
//			end if
//--- Forza Colore background a bianco (TESTATA della colonna)
			k_str_modify += k_nome_testata + ".Background.Color = '" + string(kkg_colore.BIANCO) + "' " + " "	
			// k_rcx=k_dw_target.modify( k_nome_testata + ".Background.Color = '" + string(kkg_colore.BIANCO) + "' " )
//--- Forza Colore testo a nero (TESTATA della colonna)
			k_str_modify += k_nome_testata  + ".Color = '" + string(kkg_colore.NERO) + "' " + " "	
			// k_rcx=k_dw_target.modify( k_nome_testata  + ".Color = '" + string(kkg_colore.NERO) + "' " )
//--- Forza Bold il testo (TESTATA della colonna)
			k_str_modify += k_nome_testata  + ".Font.Weight = '700'" + " "	
//			k_rcx=k_dw_target.modify( k_nome_testata  + ".Font.Weight = '700'") //'<400 - Normal, 700 - Bold>'
		end if

//--- campi K_		
		if k_knome > " " then
//--- toglie gli apici doppi dai campi
			k_xx = k_dw_source.Describe(k_knome + ".text")
			k_start_pos = pos(k_xx, '"', 1)
			DO WHILE k_start_pos > 0
				k_xx = ReplaceA (k_xx, k_start_pos, 1, " ")
				k_start_pos = pos(k_xx, '"', k_start_pos)
			LOOP
			k_str_modify += k_knome + ".text = ' " + trim(k_xx) + "' " + " "	
			// k_rcx=k_dw_target.modify( "k_" + k_nome_testata + ".text = ' " + trim(k_xx) + "' " )
			k_str_modify += k_knome  + ".Background.Color = '"+ string(kkg_colore.BIANCO) + "' " + " "	
			// k_rcx=k_dw_target.modify( "k_" + k_nome_testata  + ".Background.Color = '"+ string(kkg_colore.BIANCO) + "' " )
			k_str_modify += k_knome  + ".Color = '" + string(kkg_colore.NERO) + "' " + " "	
			// k_rcx=k_dw_target.modify( "k_" + k_nome_testata  + ".Color = '" + string(kkg_colore.NERO) + "' " )
			k_str_modify += k_knome + ".Font.Weight = '700'" + " "	
//			k_rcx=k_dw_target.modify( "k_" + k_nome_testata + ".Font.Weight = '700'") //'<400 - Normal, 700 - Bold>'
		end if

//
//		k_xx = k_dw_source.Describe("t_" + trim(string(k_colnum,"###")) + ".text")
////--- toglie gli apici doppi dai campi
//		if trim(k_xx) > " " and k_xx <> "!" then
//			k_start_pos = pos(k_xx, '"', 1)
//			DO WHILE k_start_pos > 0
//				k_xx = ReplaceA (k_xx, k_start_pos, 1, " ")
//				k_start_pos = pos(k_xx, '"', k_start_pos)
//			LOOP
//		end if
////--- aggiunge apice ' con '' 2 apici 
//		if trim(k_xx) > " " and k_xx <> "!" then
//			k_start_pos = pos(k_xx, "'", 1)
//			DO WHILE k_start_pos > 0
//				k_ctr = len(trim(k_xx)) - k_start_pos
//				k_xx = ReplaceA (k_xx, k_start_pos - 1, k_ctr + 2, "~'" + mid(k_xx, k_start_pos, k_ctr+1))
//				k_start_pos = pos(k_xx, "'", k_start_pos+2)
//			LOOP
//		end if
//		k_str_modify += "t_" + trim(string(k_colnum,"###")) + ".text = ' " + trim(k_xx) + "' " + " "	
//		// k_rcx=k_dw_target.modify( "t_" + trim(string(k_colnum,"###")) + ".text = ' " + trim(k_xx) + "' " )
//		k_string = k_string + k_rcx 										
//
////--- Visibile
//		k_str_modify += "t_" + trim(string(k_colnum,"###")) + ".visible = '" + k_dw_source.Describe("t_" + trim(string(k_colnum,"###")) + ".visible") + "' " + " "	
//		// k_rcx=k_dw_target.modify( "t_" + trim(string(k_colnum,"###")) + ".visible = " + k_dw_source.Describe("t_" + trim(string(k_colnum,"###")) + ".visible") + " " )
////--- Forza Colore background a bianco (TESTATA della colonna)
//		k_str_modify += "t_" + trim(string(k_colnum,"###")) + ".Background.Color = '" + string(kkg_colore.BIANCO) + "' " + " "	
//		// k_rcx=k_dw_target.modify( "t_" + trim(string(k_colnum,"###")) + ".Background.Color = '" + string(kkg_colore.BIANCO) + "' " )
//		k_string = k_string + k_rcx 										
////--- Forza Colore testo a nero (TESTATA della colonna)
//		k_str_modify += "t_" + trim(string(k_colnum,"###")) + ".Color = '" + string(kkg_colore.NERO) + "' " + " "	
//		// k_rcx=k_dw_target.modify( "t_" + trim(string(k_colnum,"###")) + ".Color = '" + string(kkg_colore.NERO) + "' " )
//		k_string = k_string + k_rcx 	
////--- Forza Bold il testo (TESTATA della colonna)
//		k_str_modify += "t_" + trim(string(k_colnum,"###")) + ".Font.Weight = '700'" + " "	
//		// k_rcx=k_dw_target.modify( "t_" + trim(string(k_colnum,"###")) + ".Font.Weight = '700'") //'<400 - Normal, 700 - Bold>'
//		k_string = k_string + k_rcx 	
	
	end for

//--- se ho trovato qls applica le modifiche tutte insieme	
	if k_str_modify > " " then 
		k_str = k_dw_target.Modify(k_str_modify)
	end if

return  trim(k_string) 

end function

public subroutine u_dw_personalizza_restore_orig ();//---
//--- Ripristina le impostaz. personalizzate sulla dw
//---
//--- parametri di input: kist_stampe_restore.dw_print = dw da valorizzare
//---                             kist_stampe_orig.dw_print = dw di origine
//---
//---
constant string k_tipo = "stampe"
string k_section, k_rcx 
string k_str, k_string, k_xx, k_nome, k_nome_testata, k_knome, k_str_modify="", k_syntax
int k_rc
int k_riga
long k_num


	k_section = k_tipo + "_" + trim(kist_stampe_restore.dw_print.dataobject)


//--- estrazione dei nomi dei txt
	kist_stampe_add_testata = kist_stampe_restore
	k_syntax = u_get_dw_nomi_col(kist_stampe_add_testata.dw_print.describe("DataWindow.Syntax"))

//--- trova la larghezza orizzontale del datawindow
	k_riga = 1
	do while len(trim(ki_tab_nome_oggetto[k_riga, 1])) > 0  
	
		k_nome_testata = trim(ki_tab_nome_oggetto[k_riga, 1])
		k_nome = trim(ki_tab_nome_oggetto[k_riga, 3])
		k_knome = trim(ki_tab_nome_oggetto[k_riga, 4])

//
//--- se nome valido...
		if len(trim(k_nome)) > 0 then
		
//--- ripristina Proprieta' VISIBLE nel campo testo e colonna 
			k_str_modify += k_nome + ".visible = '" &
											+ trim(kist_stampe_orig.dw_print.describe(k_nome + ".visible" ))  &
											+ "' "
//			k_rcx=kist_stampe_restore.dw_print.modify(k_nome + ".visible = '" &
//											+ trim(kist_stampe_orig.dw_print.describe(k_nome + ".visible" ))  &
//											+ "' " )
			if k_nome_testata > " " then
				k_str_modify += k_nome_testata + ".visible = '" &
										+  trim(kist_stampe_orig.dw_print.describe(k_nome_testata + ".visible")) &
										+ "' "
			end if
//			k_rcx=kist_stampe_restore.dw_print.modify(k_nome_testata + ".visible = '" &
//										+  trim(kist_stampe_orig.dw_print.describe(k_nome_testata + ".visible")) &
//										+ "' " )  

//--- ripristina Proprieta' Width
			k_str_modify += k_nome + ".Width = " &
										+ trim(kist_stampe_orig.dw_print.describe(k_nome + ".Width"))  &
										+ " "
//			k_rcx=kist_stampe_restore.dw_print.modify(k_nome + ".Width = " &
//											+ trim(kist_stampe_orig.dw_print.describe(k_nome + ".Width"))  &
//											+ " " )

//--- ripristina Proprieta' Height
			k_str_modify += k_nome + ".Height = " &
											+ trim(kist_stampe_orig.dw_print.describe(k_nome + ".Height") )  &
											+ " " 
//			k_rcx=kist_stampe_restore.dw_print.modify(k_nome + ".Height = " &
//											+ trim(kist_stampe_orig.dw_print.describe(k_nome + ".Height") )  &
//											+ " " )

//--- ripristina Proprieta' VISIBLE nel campo K_
			if k_knome > " " then
				k_str_modify += k_knome + ".visible = '" &
											+ trim(kist_stampe_orig.dw_print.describe(k_knome + ".visible") )  &
											+ "' " 
//				k_rcx=kist_stampe_restore.dw_print.modify(k_knome + ".visible = '" &
//											+ trim(kist_stampe_orig.dw_print.describe(k_knome + ".visible") )  &
//											+ "' " )
		
//--- ripristina Proprieta' Width
				k_str_modify += k_knome + ".Width = " &
											+ trim(kist_stampe_orig.dw_print.describe(k_knome + ".Width"))  &
											+ " "
//				k_rcx=kist_stampe_restore.dw_print.modify(k_knome + ".Width = " &
//											+ trim(kist_stampe_orig.dw_print.describe(k_knome + ".Width"))  &
//											+ " " )

//--- ripristina Proprieta' Height
				k_str_modify += k_knome + ".Height = " &
											+ trim(kist_stampe_orig.dw_print.describe(k_knome + ".Height"))  &
											+ " "
//				k_rcx=kist_stampe_restore.dw_print.modify(k_knome + ".Height = " &
//											+ trim(kist_stampe_orig.dw_print.describe(k_knome + ".Height"))  &
//											+ " " )

			end if
		end if
		
		k_riga++
	loop

//--- se ho trovato qls applica le modifiche tutte insieme	
	if k_str_modify > " " then 
		k_str = kist_stampe_restore.dw_print.Modify(k_str_modify)
		k_str_modify = ""
	end if



end subroutine

public function boolean if_abilitare_pdf ();//---
////--- Controlla se possibile Attivare la stampa di un PDF
////--- 
////---
////--- parametri di input:
////--- parametro di out: boolean true=ok
////---
boolean k_return
//string k_stampanti
//
//
//k_stampanti = PrintGetPrinters ( )
//
//if pos(k_stampanti, "Sybase DataWindow PS", 1) > 0 then
//	k_return = true
//else
//	k_return = false
//end if 


return  k_return

end function

public function st_esito ddlb_set_stampanti (ref dropdownlistbox kddlb_out);//
//--- Riempie un DropDownListBox con i valori contenuti nella stringa (sep da "~t")
//--- 
//--- Input: reference alla DDLB
//---           stringa con i valori separati da "~t"
//--- Output: st_esito
//---
string k_stringa, k_item_prec
long k_start_pos, k_trovato_pos, k_idx
st_profilestring_ini kst_profilestring_ini
st_esito  kst_esito

 
kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if ki_stampanti_elenco > " " then
	k_stringa = ki_stampanti_elenco
else
//--- leggo elenco stampanti
	kst_profilestring_ini.operazione = kGuf_data_base.ki_profilestring_operazione_leggi
	kst_profilestring_ini.file = "stampe" 
	kst_profilestring_ini.titolo = "stampanti" 
	kst_profilestring_ini.nome = "elenco"
	kGuf_data_base.profilestring_ini(kst_profilestring_ini)
	if kst_profilestring_ini.esito = "0" then
		k_stringa = trim(kst_profilestring_ini.valore) 
	end if
//--- se elenco salvato vuoto leggo dal Sistema
	if trim(k_stringa) > " " then
	else
		k_stringa = get_stampanti( )
	end if
end if

if isnull(k_stringa) or len(trim(k_stringa)) = 0 then 

	kst_esito.sqlcode = 0
	kst_esito.esito = kkg_esito.not_fnd
	kst_esito.sqlerrtext = "Nessuna stampante rilevata"
	kddlb_out.additem(" ")

else
	k_item_prec = kddlb_out.Text   // salva il valore della stampante che si vede 
	k_start_pos = 1
	k_trovato_pos = pos(k_stringa, ";",1)
	kddlb_out.reset()
	do while k_trovato_pos > 0
		kddlb_out.additem( trim(mid(k_stringa, k_start_pos, (k_trovato_pos - k_start_pos))))
		k_start_pos = k_trovato_pos + 1
		k_trovato_pos = pos(k_stringa, ";",k_start_pos)
	loop

	if kddlb_out.TotalItems() > 1 then
		if k_item_prec > " " then
			k_idx = kddlb_out.SelectItem(k_item_prec, 0)
		end if
	else
		if kddlb_out.TotalItems() = 0 then
			if k_item_prec > " " then
				kddlb_out.AddItem(k_item_prec)
			end if
		end if
	end if

end if

return kst_esito


end function

public function string get_stampanti ();//
//--- piglia dal sistema le stampanti (sono separate da tilde)
//--- poi le salva nel file di configurazione
//
string k_stampanti
st_profilestring_ini kst_profilestring_ini
long k_start_pos=1, k_trovato_pos

	ki_stampanti_elenco = ""
	k_stampanti = get_stampanti_definite()

	k_start_pos = 1
	k_trovato_pos = pos(k_stampanti, "~t",1)
	do while k_trovato_pos > 0
		
		ki_stampanti_elenco += trim(mid(k_stampanti, k_start_pos, (k_trovato_pos - k_start_pos))) + ";"
		k_trovato_pos = pos(k_stampanti, "~n",k_start_pos)
		if k_trovato_pos >  0 then 
			k_start_pos = k_trovato_pos + 1
			k_trovato_pos = pos(k_stampanti, "~t",k_start_pos)
		end if
		
	loop

//--- salvo elenco stampanti (inizializza poi scrive)
	kst_profilestring_ini.operazione = kGuf_data_base.ki_profilestring_operazione_scrivi
	kst_profilestring_ini.file = "stampe" 
	kst_profilestring_ini.titolo = "stampanti" 
	kst_profilestring_ini.nome = "elenco"
	kst_profilestring_ini.operazione = kGuf_data_base.ki_profilestring_operazione_inizializza
	kGuf_data_base.profilestring_ini(kst_profilestring_ini)
	kst_profilestring_ini.operazione = kGuf_data_base.ki_profilestring_operazione_scrivi
	kst_profilestring_ini.valore = ki_stampanti_elenco
	kGuf_data_base.profilestring_ini(kst_profilestring_ini)


return ki_stampanti_elenco

end function

private subroutine dw_copia_attributi (ref datastore k_ds_source, ref datawindow k_dw_target);//---
//--- Copia da DS a DW gli attributi come il nomefile delle Pictures
//--- 
//---
//--- parametri di input:
//--- 
//---    k_ds_source  la ds sorgente
//---    k_dw_target  la dw in cui copiare
//---
//---
long k_rc
string  k_rcx, k_rc1x, k_str, k_string, k_path, k_xx, k_nome, k_str_modify="" //, k_nome_testata, k_type, k_strx, k_knome
long k_ctr, k_ctr1, k_ctr2, k_ctr3, k_ctr4, k_max_nr_oggetti, k_colcount, k_riga, k_len_max
long k_num, k_righe, k_start_pos=0
string k_visible, k_dw_syntax, k_filename
boolean k_colonna_valorizzata




//--- copia Proprieta' PRINT ORIENTATIONE della dw
	k_rcx=k_dw_target.modify("DataWindow.Print.Orientation= '" + trim(k_ds_source.describe("DataWindow.Print.Orientation")) + "'")

//--- 
	k_ctr1 = 1
	k_nome=trim(k_dw_target.describe("#"+trim(string(k_ctr1))+".name")) // piglia il nome della colonna nella select
	do while k_nome <> "!" // len(trim(ki_tab_nome_oggetto[k_ctr1, 1])) > 0  

//--- copia Proprieta' VISIBLE
		k_rcx = k_dw_target.Describe(k_nome + ".width")
		if k_rcx <> "!" and k_rcx <> "?" then
			k_rcx = k_ds_source.Describe(k_nome + ".visible")
		end if
		if k_rcx <> "!" and k_rcx <> "?" then
			k_str_modify += k_nome + ".visible='" + k_rcx + "'" + " "
//			k_rcx=k_dw_target.modify(k_nome + ".visible='" + k_ds_source.Describe(k_nome + ".visible") + "' " )

			k_nome  = "p_" + trim(k_nome)
			if k_ds_source.Describe(k_nome + ".visible") <> "!" then
	//--- copia Proprieta' WIDTH
		//		k_rcx=k_dw_target.modify(k_nome + ".width="  + k_ds_source.Describe(k_nome + ".width") + " " )
				k_str_modify += k_nome + ".width="  + k_ds_source.Describe(k_nome + ".width") + " "
	//			if k_rcx = "" then
	//--- copia Proprieta' HEIGHT
	//			k_rcx=k_dw_target.modify(k_nome + ".height=" + k_ds_source.Describe(k_nome + ".height") + " " )
				k_str_modify += k_nome + ".height=" + k_ds_source.Describe(k_nome + ".height") + " "
	//--- copia eventuale nome file '.bmp' 
	//			k_rcx=k_dw_target.modify(k_nome + ".filename='" + k_ds_source.Describe(k_nome + ".filename") + "' " )
				k_str_modify += k_nome + ".filename='" + k_ds_source.Describe(k_nome + ".filename") + "'" + " "
			end if
		end if
		
		k_ctr1++
		k_nome=k_dw_target.describe("#"+trim(string(k_ctr1))+".name")
	loop

//--- se ho trovato qls applica le modifiche tutte insieme	
	if k_str_modify > " " then 
		k_str = k_dw_target.Modify(k_str_modify)
		k_str_modify = ""
	end if
	
//--- controlla se ci sono delle immagini da fare vedere con la tecnica del campo TXT che riporta in nome del file --------------
//--- estrazione dell'intero contenuto del dw
	k_dw_syntax = k_ds_source.describe("DataWindow.Syntax")
	k_len_max = len(k_dw_syntax) - 10
//--- estrazione dei nomi dei txt
	k_path =  kguo_path.get_risorse( ) + kkg.path_sep
	k_ctr = 1
	k_ctr1 = 1
	k_max_nr_oggetti = 1
	k_ctr = pos(k_dw_syntax, "name=", k_ctr)    //cerca stringa 'name' ovvero tutti gli oggetti nel dw 
	DO WHILE k_ctr > 0 and k_max_nr_oggetti < 100
		k_ctr1 = k_ctr 
		if k_ctr1 < k_len_max then
//			k_ctr1 = k_ctr1 + 5
			k_ctr2 = pos(k_dw_syntax, "txt_p_img", k_ctr1)
			if k_ctr2 <= 0 then k_ctr2 = pos(k_dw_syntax, "txt_p_", k_ctr1)
			if k_ctr2 > 0 then
				k_ctr = k_ctr2
				k_ctr2 = pos(k_dw_syntax, "_", k_ctr2)  + 1  // piglia la pos di "_" che segue txt
				k_ctr4 = pos(k_dw_syntax, "~"", k_ctr2) - k_ctr2   // piglia len del "p_img_" es. "p_img_lente" se carattere doppi apici
				k_ctr3 = pos(k_dw_syntax, " ", k_ctr2) - k_ctr2   // piglia len del "p_img_" es. "p_img_lente"
				if k_ctr3 > k_ctr4 then k_ctr3 = k_ctr4  // se c'e' prima doppi apici allora sistema la posizione
               k_nome = mid(k_dw_syntax, k_ctr2, k_ctr3 ) // carica il nime del file jpg o bmp o ecc....
//--- recupera il nome dell'immagine
				k_string = "txt_" + k_nome + ".text"
				k_filename = trim(k_ds_source.Describe(k_string))
				if k_filename <> "!" then
//--- set l'immagine
					k_str_modify += k_nome + ".filename='" + k_path + k_filename + "'" + " "
					k_str_modify += k_nome + ".width=" + k_ds_source.Describe(k_nome + ".width") + " "
					k_str_modify += k_nome + ".height=" + k_ds_source.Describe(k_nome + ".height") + " "
//					k_str=k_dw_target.Modify(k_nome + ".filename='" + k_path + k_filename + "'")
//					k_str=k_dw_target.Modify(k_nome + ".width=" + k_ds_source.Describe(k_nome + ".width") )
//					k_str=k_dw_target.Modify(k_nome + ".height=" + k_ds_source.Describe(k_nome + ".height") )
					
				end if
			  	k_max_nr_oggetti++
			end if
		end if
		k_ctr++
		k_ctr = pos(k_dw_syntax, "name=", k_ctr)
	LOOP	
	
//--- se ho trovato qls applica le modifiche tutte insieme	
	if k_str_modify > " " then 
		k_str = k_dw_target.Modify(k_str_modify)
		k_str_modify = ""
	end if
	
//	k_nome = "p_img"
//	k_rcx=k_dw_target.modify(k_nome + ".Filename='" + kGuo_path.get_risorse() + KKG.PATH_SEP + k_ds_source.Describe("txt_" + k_nome + ".text") + "' " )
//	k_rcx=k_dw_target.modify(k_nome + ".Width = " + k_ds_source.Describe(k_nome + ".Width") + " " )
//	k_rcx=k_dw_target.modify(k_nome + ".Height = " + k_ds_source.Describe(k_nome + ".Height") + " " )
//	k_nome = "p_img_0"
//	k_rcx=k_dw_target.modify(k_nome + ".Filename='" + kGuo_path.get_risorse() + KKG.PATH_SEP + k_ds_source.Describe("txt_" + k_nome + ".text") + "' " )
//	k_rcx=k_dw_target.modify(k_nome + ".Width = " + k_ds_source.Describe(k_nome + ".Width") + " " )
//	k_rcx=k_dw_target.modify(k_nome + ".Height = " + k_ds_source.Describe(k_nome + ".Height") + " " )
//	k_nome = "p_img_1"
//	k_rcx=k_dw_target.modify(k_nome + ".Filename='" + kGuo_path.get_risorse() + KKG.PATH_SEP + k_ds_source.Describe("txt_" + k_nome + ".text") + "' " )
//	k_rcx=k_dw_target.modify(k_nome + ".Width = " + k_ds_source.Describe(k_nome + ".Width") + " " )
//	k_rcx=k_dw_target.modify(k_nome + ".Height = " + k_ds_source.Describe(k_nome + ".Height") + " " )
//	k_nome = "p_img_2"
//	k_rcx=k_dw_target.modify(k_nome + ".Filename='" + kGuo_path.get_risorse() + KKG.PATH_SEP + k_ds_source.Describe("txt_" + k_nome + ".text") + "' " )
//	k_rcx=k_dw_target.modify(k_nome + ".Width = " + k_ds_source.Describe(k_nome + ".Width") + " " )
//	k_rcx=k_dw_target.modify(k_nome + ".Height = " + k_ds_source.Describe(k_nome + ".Height") + " " )
//	k_nome = "p_img_3"
//	k_rcx=k_dw_target.modify(k_nome + ".Filename='" + kGuo_path.get_risorse() + KKG.PATH_SEP + k_ds_source.Describe("txt_" + k_nome + ".text") + "' " )
//	k_rcx=k_dw_target.modify(k_nome + ".Width = " + k_ds_source.Describe(k_nome + ".Width") + " " )
//	k_rcx=k_dw_target.modify(k_nome + ".Height = " + k_ds_source.Describe(k_nome + ".Height") + " " )
//	k_nome = "p_img_4"
//	k_rcx=k_dw_target.modify(k_nome + ".Filename='" + kGuo_path.get_risorse() + KKG.PATH_SEP + k_ds_source.Describe("txt_" + k_nome + ".text") + "' " )
//	k_rcx=k_dw_target.modify(k_nome + ".Width = " + k_ds_source.Describe(k_nome + ".Width") + " " )
//	k_rcx=k_dw_target.modify(k_nome + ".Height = " + k_ds_source.Describe(k_nome + ".Height") + " " )




end subroutine

private subroutine dw_copia_attributi_innestate (ref datawindow k_dw_padre, ref datawindowchild k_dwc_iinnestata);//---
//--- Copia su DW innestate gli attributi come il nomefile delle Pictures
//--- 
//---
//--- parametri di input:
//--- 
//---    k_dw_padre  la datawindow padre
//---    k_dwc_iinnestata  la datawindowchild in cui operare
//---
//---
long k_rc
string  k_rcx, k_rc1x, k_str, k_path, k_string, k_xx, k_nome, k_str_modify="" //, k_nome_testata, k_type, k_strx, k_knome
long k_ctr, k_ctr1, k_ctr2, k_ctr3, k_ctr4, k_max_nr_oggetti, k_colcount, k_riga, k_len_max
long k_num, k_righe, k_start_pos=0
string k_visible, k_dw_syntax, k_filename
boolean k_colonna_valorizzata




//--- copia Proprieta' PRINT ORIENTATIONE della dw
	k_rcx=k_dwc_iinnestata.modify("DataWindow.Print.Orientation= '" + trim(k_dw_padre.describe("DataWindow.Print.Orientation")) + "'")

	
//--- controlla se ci sono delle immagini da fare vedere con la tecnica del campo TXT che riporta in nome del file --------------
//--- estrazione dell'intero contenuto del dw
	k_path = kguo_path.get_risorse( )  + kkg.path_sep
	k_dw_syntax = k_dwc_iinnestata.describe("DataWindow.Syntax")
	k_len_max = len(k_dw_syntax) - 10
//--- estrazione dei nomi dei txt
	k_ctr = 1
	k_max_nr_oggetti = 1
	k_ctr = pos(k_dw_syntax, "name=", k_ctr)    //cerca stringa 'name' ovvero tutti gli oggetti nel dw 
	DO WHILE k_ctr > 0 and k_max_nr_oggetti < 100
		k_ctr1 = k_ctr 
		if k_ctr1 < k_len_max then
//			k_ctr1 = k_ctr1 + 5
			k_ctr2 = pos(k_dw_syntax, "txt_p_img", k_ctr1)
			if k_ctr2 <= 0 then k_ctr2 = pos(k_dw_syntax, "txt_p_", k_ctr1)
			if k_ctr2 > 0 then
				k_ctr = k_ctr2
				k_ctr2 = pos(k_dw_syntax, "_", k_ctr2)  + 1  // piglia la pos di "_" che segue txt
				k_ctr4 = pos(k_dw_syntax, "~"", k_ctr2) - k_ctr2   // piglia len del "p_img_" es. "p_img_lente" se carattere doppi apici
				k_ctr3 = pos(k_dw_syntax, " ", k_ctr2) - k_ctr2   // piglia len del "p_img_" es. "p_img_lente"
				if k_ctr3 > k_ctr4 then k_ctr3 = k_ctr4  // se c'e' prima doppi apici allora sistema la posizione
               k_nome = mid(k_dw_syntax, k_ctr2, k_ctr3 ) // carica il nime del file jpg o bmp o ecc....
//--- recupera il nome dell'immagine
				k_string = "txt_" + k_nome + ".text"
				k_filename = trim(k_dwc_iinnestata.Describe(k_string))
				if k_filename <> "!" and k_filename <> "?" then
//--- set l'immagine
					k_str_modify += k_nome + ".filename='" + k_path + k_filename + "'" + " "
					k_str_modify += k_nome + ".width=" + k_dwc_iinnestata.Describe(k_nome + ".width") + " "
					k_str_modify += k_nome + ".height=" + k_dwc_iinnestata.Describe(k_nome + ".height") + " "
//					k_str=k_dwc_iinnestata.Modify(k_nome + ".filename='" + k_path + k_filename + "'")
//					k_str=k_dwc_iinnestata.Modify(k_nome + ".width='" + k_dwc_iinnestata.Describe(k_nome + ".width")  + "' ")
//					k_str=k_dwc_iinnestata.Modify(k_nome + ".height='" + k_dwc_iinnestata.Describe(k_nome + ".height")  + "' ")
					
				end if
			  	k_max_nr_oggetti++
			end if
		end if
		k_ctr++
		k_ctr = pos(k_dw_syntax, "name=", k_ctr)
	LOOP	
	
//--- se ho trovato qls applica le modifiche tutte insieme	
	if k_str_modify > " " then 
		k_str = k_dwc_iinnestata.Modify(k_str_modify)
		k_str_modify=""
	end if


end subroutine

private subroutine olddw_estrae_nomi_col ();//---
//--- Estrae da dw i nomi dei testi con indicazione di 'visible'
//--- input: impostare in kist_stampe_add_testata il Titolo e dw_print
//---
long k_colcount=0, k_riga, k_pos_x, k_pos_x_max=0, k_width=0, k_pos_y=0
long k_ctr, k_ctr1, k_ctr2, k_tab_nome_oggetto_ind, k_ind1, k_start_pos
string k_rc, k_str, k_dw
//string k_xx




//--- estrazione dell'intero contenuto del dw
	k_dw = kist_stampe_add_testata.dw_print.describe("DataWindow.Syntax")
//--- estrazione dei nomi dei txt
	k_tab_nome_oggetto_ind = 1
	k_ctr = 1
	k_ctr = pos(k_dw, "name=", k_ctr)
	DO WHILE k_ctr > 0 and k_tab_nome_oggetto_ind < 100
		k_ctr1 = pos(k_dw, "name=", k_ctr)
		if k_ctr1 > 0 then
			k_ctr1 = k_ctr1 + 5
			k_ctr2 = pos(k_dw, " ", k_ctr1) - k_ctr1
			if k_ctr2 > 0 then
				
//--- nome colonna K				
				ki_tab_nome_oggetto[k_tab_nome_oggetto_ind, 4] = left(ki_tab_nome_oggetto[k_tab_nome_oggetto_ind, 1], &
				          len(ki_tab_nome_oggetto[k_tab_nome_oggetto_ind, 1]) - 2) // tolgo _t dal campo testata
							 
//--- evita anche le colonne fzoom poichè servono solo come FUNZIONE di ZOOM 	a VIDEO
				if pos(ki_tab_nome_oggetto[k_tab_nome_oggetto_ind, 4], "fzoom", 1) > 0 then
					ki_tab_nome_oggetto[k_tab_nome_oggetto_ind, 2] = '0'
				else
					k_str = trim(trim(kist_stampe_add_testata.dw_print.Describe(ki_tab_nome_oggetto[k_tab_nome_oggetto_ind, 4] + ".visible")))
					if k_str = "!" or k_str = "?" then
						ki_tab_nome_oggetto[k_tab_nome_oggetto_ind, 4] = " "
					else
						ki_tab_nome_oggetto[k_tab_nome_oggetto_ind, 2] = k_str
					end if
				end if
				
//--- nome colonna DB				
				ki_tab_nome_oggetto[k_tab_nome_oggetto_ind, 3] = left(ki_tab_nome_oggetto[k_tab_nome_oggetto_ind, 1], &
				          len(ki_tab_nome_oggetto[k_tab_nome_oggetto_ind, 1]) - 2) // tolgo _t dal campo testata
							 
				if pos(ki_tab_nome_oggetto[k_tab_nome_oggetto_ind, 3], "fzoom", 1) > 0 then
					ki_tab_nome_oggetto[k_tab_nome_oggetto_ind, 2] = '0'
				else
					k_str = trim(trim(kist_stampe_add_testata.dw_print.Describe(ki_tab_nome_oggetto[k_tab_nome_oggetto_ind, 3] + ".visible")))
					if k_str = "!" or k_str = "?" then
						ki_tab_nome_oggetto[k_tab_nome_oggetto_ind, 3] = " "
					else
						ki_tab_nome_oggetto[k_tab_nome_oggetto_ind, 2] = k_str
					end if
				end if
			   k_tab_nome_oggetto_ind++
			end if
		end if
		k_ctr = k_ctr1
		k_ctr = pos(k_dw, "name=", k_ctr)
	LOOP	




end subroutine

private function string get_stampanti_definite ();//
//--- piglia dal sistema le stampanti (i valori sono separate da tilde ~t e infine dal newline ~n)
//
string k_printers


	k_printers = PrintGetPrinters ( )
	if trim(k_printers) > " " then 
	else
		k_printers = ""
	end if

return k_printers

end function

public function string get_stampanti_dwddlb_values ();//
//--- Torna le stampanti dal sistema per essere caricate in un dropdownlistbox di un datawidow
//
string k_stampanti, k_dwddlb
long k_start_pos=1, k_trovato_pos


	k_stampanti = get_stampanti_definite()

	k_start_pos = 1
	k_trovato_pos = pos(k_stampanti, "~t",1)
	do while k_trovato_pos > 0
		
		k_dwddlb += "/" + trim(mid(k_stampanti, k_start_pos, (k_trovato_pos - k_start_pos))) //+ "~n"
		k_trovato_pos = pos(k_stampanti, "~n", k_start_pos)
		if k_trovato_pos >  0 then 
			k_start_pos = k_trovato_pos + 1
			k_trovato_pos = pos(k_stampanti, "~t", k_start_pos)
		end if
		
	loop


return k_dwddlb

end function

public function string get_stampante_da_nome (string a_nome);//
//--- Torna la stampante completa di driver e percorso dal NOME 
//--- inp: nome stampante
//--- rit: stringa completa tipo: 'nome stampante: ~tindririzzo ~tdriver'
//
string k_stampanti, k_return, k_nome_printer
long k_start_pos, k_trovato_pos


	k_stampanti = get_stampanti_definite()

//--- aggiunge un tabulatore alla fine altrimenti non piglia l'ultima stampante
	if k_stampanti > " " then
		k_stampanti += "~n"
	end if

	k_start_pos = 1
	k_trovato_pos = pos(k_stampanti, "~t", 1)
	do while k_trovato_pos > 0
		k_nome_printer = trim(mid(k_stampanti, k_start_pos, (k_trovato_pos - k_start_pos))) 
		if a_nome = k_nome_printer then  //TROVATA LA STAMPANTE
			k_trovato_pos = pos(k_stampanti, "~n", k_start_pos)
			k_return = mid(k_stampanti, k_start_pos, (k_trovato_pos - k_start_pos)) // GET di tutta la stringa della stampante
			exit
		end if
		
		k_trovato_pos = pos(k_stampanti, "~n",k_start_pos)
		if k_trovato_pos >  0 then 
			k_start_pos = k_trovato_pos + 1
			k_trovato_pos = pos(k_stampanti, "~t",k_start_pos)
		end if
		
	loop


return k_return

end function

public function string get_path_tempemail ();//---
//--- Valorizza datawindows
//---
//---
string k_return


	
	k_return = kguo_path.get_temp( ) + kkg.path_sep + kki_dirEmail

	kguo_path.u_drectory_create(k_return) 
	

return k_return
end function

private function string dw_set_fzoom_invisibili (string a_datawindow_syntax);//---
//--- Impsta a NON 'visible' le colonne FZOOM
//--- input: describe("DataWindow.Syntax")       impostare in kist_stampe_add_testata il Titolo e dw_print
//--- rit: il DataWindow.Syntax modificato pronto per il Modify(k_str_modify)
long k_colcount=0, k_riga, k_pos_x, k_pos_x_max=0, k_width=0, k_pos_y=0
long k_ctr, k_ctr1, k_ctr2 
string k_rc, k_str, k_dw, k_nome_oggetto, k_str_modify = ""


/////// NON RIESCO A METTERE A INVISIBILE LE COLONNE FZOOM!!!!! 

//--- estrazione dell'intero contenuto del dw
//	k_dw = kist_stampe_add_testata.dw_print.describe("DataWindow.Syntax")
	k_dw = trim(a_DataWindow_syntax)
//--- estrazione dei nomi dei txt
	k_ctr = 1
	k_ctr = pos(k_dw, "text(", k_ctr)
	DO WHILE k_ctr > 0 
		k_ctr1 = pos(k_dw, "name=", k_ctr)
		if k_ctr1 > 0 then
			k_ctr1 = k_ctr1 + 5
			k_ctr2 = pos(k_dw, " ", k_ctr1) - k_ctr1
			if k_ctr2 > 0 then
//--- nome testata				
				k_nome_oggetto = mid(k_dw, k_ctr1, k_ctr2)
//--- evita le colonne fzoom poichè servono solo come FUNZIONE di ZOOM 	a VIDEO
				if pos(k_nome_oggetto, "fzoom", 1) > 0 then
					k_str_modify += "fzoom_t.visible='0'" + " " + "b_fzoom.visible='0'" + " " + "fzoom.visible='0'" + " " &
					          + "fzoom_t.width='0'" + " " + "b_fzoom.width='0'" + " " + "fzoom.width='0'"
					k_str_modify += k_nome_oggetto + ".visible='0' " 
								 
//					k_str = trim(kist_stampe_add_testata.dw_print.modify("fzoom_t.visible='0'"))
//					k_str = trim(kist_stampe_add_testata.dw_print.modify("b_fzoom.visible='0'"))
//					k_str = trim(kist_stampe_add_testata.dw_print.modify("fzoom.visible='0'"))
//					k_str = trim(kist_stampe_add_testata.dw_print.modify("fzoom_t.width='0'"))
//					k_str = trim(kist_stampe_add_testata.dw_print.modify("b_fzoom.width='0'"))
//					k_str = trim(kist_stampe_add_testata.dw_print.modify("fzoom.width='0'"))
				end if
			end if
		end if
		k_ctr = k_ctr1
		k_ctr = pos(k_dw, "text(", k_ctr)
	LOOP	
	
//	if k_str_modify > " " then 
//		k_str = kist_stampe_add_testata.dw_print.Modify(k_str_modify)
//	end if

	
//--- se ho trovato qls applica le modifiche tutte insieme	
	return trim(k_str_modify)
	




end function

private function string u_get_dw_nomi_col (string a_datawindow_syntax);//---
//--- Estrae da dw i nomi dei testi con indicazione di 'visible' popola la array: ki_tab_nome_oggetto
//--- input: describe("DataWindow.Syntax")       impostare in kist_stampe_add_testata il Titolo e dw_print
//--- Rit: kdw_1.Describe("DataWindow.Syntax")  che non serve a molto
long k_colcount=0, k_riga, k_pos_x, k_pos_x_max=0, k_width=0, k_pos_y=0
long k_ctr, k_pos_field, k_ctr2, k_tab_nome_oggetto_ind, k_ind1, k_start_pos, k_len
string k_rc, k_str, k_dw, k_nome_visible, k_modify, k_nome_campo_visible
string k_tab_nome_oggetto_VUOTA[100,4]
datawindow kdw_1


	ki_tab_nome_oggetto = k_tab_nome_oggetto_VUOTA   // svuota la tabella

//--- estrazione dell'intero contenuto del dw
//	k_dw = kdw_1.describe("DataWindow.Syntax")
	k_dw = trim(a_DataWindow_Syntax)
	kdw_1 = create datawindow
//	kdw_1.create(k_dw)
	kdw_1 = kist_stampe_add_testata.dw_print
//--- estrazione dei nomi dei txt
   k_tab_nome_oggetto_ind = 1
	k_ctr = 1
	k_ctr = pos(k_dw, "text(", k_ctr)
	DO WHILE k_ctr > 0 and k_tab_nome_oggetto_ind < 100
		k_pos_field = pos(k_dw, "name=", k_ctr)
		if k_pos_field > 0 then
			k_pos_field = k_pos_field + 5
			k_ctr2 = pos(k_dw, " ", k_pos_field) - k_pos_field
			if k_ctr2 > 0 then
//--- nome colonna TESTATA				
				ki_tab_nome_oggetto[k_tab_nome_oggetto_ind, 1] = mid(k_dw, k_pos_field, k_ctr2)
				k_nome_campo_visible = ki_tab_nome_oggetto[k_tab_nome_oggetto_ind, 1] + ".visible"
				k_str = kdw_1.Describe(k_nome_campo_visible)  // verifica se colonna esiste
				
//--- La colonna deve esistere e NON deve essere "fzoom" poichè servono solo come FUNZIONE di ZOOM a VIDEO
				if k_str <> "!" and pos(ki_tab_nome_oggetto[k_tab_nome_oggetto_ind, 1], "fzoom", 1) = 0 then

//--- nome colonna DETTAGLIO (tolgo '_t' dalla fine del nome)	
					if right(ki_tab_nome_oggetto[k_tab_nome_oggetto_ind, 1], 2) = "_t"  then
						k_len = len(ki_tab_nome_oggetto[k_tab_nome_oggetto_ind, 1]) 
					//k_ctr_t = pos(ki_tab_nome_oggetto[k_tab_nome_oggetto_ind, 1], "_t", 1)
					//if k_ctr_t > 1 then // in campo testata dovrebbere esserci la '_t'
						k_str = kdw_1.Describe(left(ki_tab_nome_oggetto[k_tab_nome_oggetto_ind, 1], k_len - 2) + ".visible")
						if k_str = "!" then
							k_nome_visible = ki_tab_nome_oggetto[k_tab_nome_oggetto_ind, 1]
						else
							ki_tab_nome_oggetto[k_tab_nome_oggetto_ind, 3] = left(ki_tab_nome_oggetto[k_tab_nome_oggetto_ind, 1], k_len - 2)
							k_nome_visible = ki_tab_nome_oggetto[k_tab_nome_oggetto_ind, 3]
						end if
					else 
						k_nome_visible = ki_tab_nome_oggetto[k_tab_nome_oggetto_ind, 1]
						k_len = len(trim(ki_tab_nome_oggetto[k_tab_nome_oggetto_ind, 1])) 
					end if
//--- Proprietà VISIBLE				
					k_str = kdw_1.Describe(k_nome_visible + ".visible")
					if k_str = "!" then
					else
						ki_tab_nome_oggetto[k_tab_nome_oggetto_ind, 2] = k_str   // Proprietà VISIBLE 
					end if

//--- nome colonna K_				
					k_str = kdw_1.Describe("k_" + left(ki_tab_nome_oggetto[k_tab_nome_oggetto_ind, 1], k_len - 2) + ".visible")
					if k_str = "!" then
					else
						ki_tab_nome_oggetto[k_tab_nome_oggetto_ind, 4] = "k_" + left(ki_tab_nome_oggetto[k_tab_nome_oggetto_ind, 1],k_len - 2) 
					end if

					k_tab_nome_oggetto_ind++
				end if
			end if
		end if
		k_ctr = k_pos_field
		k_ctr = pos(k_dw, "text(", k_ctr)
	LOOP	

return trim(kdw_1.Describe("DataWindow.Syntax"))


end function

public function string u_dw_sintax_pulizia (string a_datawindow_syntax);//---
//--- Pulizia della sintax di un datastore/datawindow del background ecc...
//---
//--- input:  area DataWindow_Syntax  da pulire es. ads_1.describe("DataWindow.Syntax")
//--- rit: 	  area DataWindow_Syntax  con le modifiche da applicare es.  kds_target.Modify(k_str_modify)
//---
long k_rc
string  k_rcx, k_rc1x, k_str, k_string, k_xx, k_nome, k_nome_testata, k_type, k_strx, k_knome, k_str_modify="", k_syntax
long k_ctr, k_colnum, k_colcount, k_riga
long k_num, k_righe, k_start_pos=0, k_righe_loop=0
string k_visible
datastore kds_target
boolean k_colonna_valorizzata


	kds_target = create datastore
	kds_target.create(a_DataWindow_Syntax)
	ki_sintax_dw_copia_x_stampa = a_DataWindow_Syntax
	//ki_nome_dw_copia_x_stampa = ads_1.dataobject

	k_string = k_string + k_rcx 		

//--- estrae nomi testata colonne
	//kist_stampe_add_testata.dw_print.dataobject = ads_1.dataobject
	k_syntax = dw_set_fzoom_invisibili(a_DataWindow_Syntax)
	if k_syntax > " " then
		kist_stampe_add_testata.dw_print.Modify(k_syntax)
	end if
	u_get_dw_nomi_col(a_DataWindow_Syntax)

//--- trova la larghezza orizzontale del datawindow
	k_colcount = upperbound(ki_tab_nome_oggetto, 1)
	for k_colnum = 1 to k_colcount 

//--- estrae nome colonna e proprietà visible
		k_nome = trim(ki_tab_nome_oggetto[k_colnum, 3])
		k_nome_testata = trim(ki_tab_nome_oggetto[k_colnum, 1])
		k_knome = trim(ki_tab_nome_oggetto[k_colnum, 4])

//--- tolgo eventuli DW child visibili 
		if k_nome > " " then
			k_rcx=(trim(kds_target.describe( k_nome + ".DDDW.Name" ))) 
			k_rc1x=(trim(kds_target.describe( k_nome + ".DDLB.VScrollBar" )))
			if (len(k_rcx) > 0 and k_rcx <> "!" ) or (len(k_rc1x) > 0 and k_rc1x <> "!") then
				k_str_modify += k_nome + ".Edit.DisplayOnly='Yes'" + " "
			end if
		end if		
		
		if k_nome > " " then

//--- Forza a INVISIBILE se colonna si chiama 'FZOOM', poichè buona solo a video (funzione di ZOOM)
			if pos(k_nome,'fzoom',1) > 0 then k_visible = '0'
		
	
//--- Forza proprieta' NO BORDER 
			k_str_modify += k_nome + ".Border = '0'" + " "	
			k_string = k_string + k_rcx 										
			k_str_modify += k_nome + ".Border = '0'" + " "	
			k_string = k_string + k_rcx 										

//--- Forza Colore background a bianco
			k_str_modify += k_nome + ".Background.Color = '" + string(kkg_colore.BIANCO) + "' " + " "	
			k_string = k_string + k_rcx 										
			k_str_modify += k_nome + ".Background.Color = '" + string(kkg_colore.BIANCO) + "' " + " "	
			k_string = k_string + k_rcx 										
	
//--- Forza Colore testo a nero
			k_str_modify += k_nome + ".Color = '" + string(kkg_colore.NERO) + "' " + " "	
			k_string = k_string + k_rcx 										
			k_str_modify += k_nome + ".Color = '" + string(kkg_colore.NERO) + "' " + " "	
			k_string = k_string + k_rcx 										
		
//--- copia eventuale nome file '.bmp' 
			if kds_target.Describe(k_nome + ".Filename") <> "!" then
				k_str_modify += k_nome + ".Filename='" + kds_target.Describe(k_nome + ".Filename") + "' " + " "	
				k_string = k_string + k_rcx 										
			end if
			
			if kds_target.Describe("b_" + k_nome + ".visible") <> "!" then
				k_str_modify += "b_" + k_nome + ".visible = '" + kds_target.Describe(k_nome + ".visible") + "' " + " "	
			end if
		end if

		if k_nome_testata > " " then
		
//--- copia Proprieta' TESTO della TESTATA della colonna
			k_xx = kds_target.Describe(k_nome_testata + ".text")
//--- toglie gli apici doppi dai campi
			if trim(k_xx) > " " and k_xx <> "!" then
				k_start_pos = pos(k_xx, '"', 1)
				DO WHILE k_start_pos > 0
					k_xx = ReplaceA (k_xx, k_start_pos, 1, " ")
					k_start_pos = pos(k_xx, '"', k_start_pos)
				LOOP
			end if
//--- aggiunge apice ' con ~' 2 apici 
			if trim(k_xx) > " " and k_xx <> "!" then
				k_start_pos = pos(k_xx, "'", 1)
				DO WHILE k_start_pos > 0
					k_ctr = len(trim(k_xx)) - k_start_pos
					k_rcx = "~~" + mid(k_xx, k_start_pos, k_ctr+1)
					k_xx = ReplaceA (k_xx, k_start_pos , k_ctr + 1, k_rcx)
					k_start_pos = pos(k_xx, "'", k_start_pos+2)
				LOOP
			end if
			k_str_modify += k_nome_testata + ".text = ' " + trim(k_xx) + "' " + " "	
//--- Forza Colore background a bianco (TESTATA della colonna)
			k_str_modify += k_nome_testata + ".Background.Color = '" + string(kkg_colore.BIANCO) + "' " + " "	
//--- Forza Colore testo a nero (TESTATA della colonna)
			k_str_modify += k_nome_testata  + ".Color = '" + string(kkg_colore.NERO) + "' " + " "	
//--- Forza Bold il testo (TESTATA della colonna)
			k_str_modify += k_nome_testata  + ".Font.Weight = '700'" + " "	
		end if

//--- campi K_		
		if k_knome > " " then
//--- toglie gli apici doppi dai campi
			k_xx = kds_target.Describe(k_knome + ".text")
			if trim(k_xx) > " " and k_xx <> "!" then
				k_start_pos = pos(k_xx, '"', 1)
				DO WHILE k_start_pos > 0
					k_xx = ReplaceA (k_xx, k_start_pos, 1, " ")
					k_start_pos = pos(k_xx, '"', k_start_pos)
				LOOP
				k_str_modify += k_knome + ".text = ' " + trim(k_xx) + "' " + " "	
				k_str_modify += k_knome  + ".Background.Color = '"+ string(kkg_colore.BIANCO) + "' " + " "	
				k_str_modify += k_knome  + ".Color = '" + string(kkg_colore.NERO) + "' " + " "	
				k_str_modify += k_knome + ".Font.Weight = '700'" + " "	
			end if
		end if

	
	end for

////--- se ho trovato qls applica le modifiche tutte insieme	
//	if k_str_modify > " " then 
//		k_str = kds_target.Modify(k_str_modify)
//	end if

return trim(k_str_modify)

end function

on kuf_stampe.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_stampe.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

