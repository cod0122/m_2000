$PBExportHeader$kuf_stampe.sru
forward
global type kuf_stampe from nonvisualobject
end type
end forward

global type kuf_stampe from nonvisualobject
end type
global kuf_stampe kuf_stampe

forward prototypes
protected function integer st_dw (ref datawindow kdw_print, ref st_open_w kst_open_w)
public function string smista_stampe (ref datawindow kdw_print, ref st_open_w kst_open_w)
end prototypes

protected function integer st_dw (ref datawindow kdw_print, ref st_open_w kst_open_w);//
int k_file 
int k_bytes, k_ctr
long k_return=0
string k_path, k_nome_file, k_argomenti_sav,  k_argomenti_sav_chiave
string k_nome_col
real k_font_alt_dw, k_font_alt_default
long k_argomenti_sav_setrow, k_zoom
kuf_base kuf1_base


setpointer(hourglass!)

//--- pesco la dw da stampare 
	k_path = profilestring ( "confdb.ini", "ambiente", "arch_saveas", "save_dw")

	k_nome_file = trim(kdw_print.DataObject)
	
	k_file = fileopen( trim(k_path) + "\" + k_nome_file + ".arg", &
					linemode!, read!, lockreadwrite!)

	if k_file < 1 then

		k_return = 0

	else

//=== Cerco il rek con gli argomenti uguali 
		k_ctr = 1 // estensione del nome-file (nr. progressivo)
		k_bytes = fileread(k_file, k_argomenti_sav) //leggo argomenti del dw salvati in prec
		k_argomenti_sav_setrow = long(left(k_argomenti_sav, 10))
		k_argomenti_sav_chiave = trim(mid(k_argomenti_sav,11))
		if isnull(k_argomenti_sav_chiave) or k_argomenti_sav_chiave = "" then
			k_argomenti_sav_chiave = " "
		end if
		
		do  while  k_bytes > 0 

			k_ctr++
			k_bytes = fileread(k_file, k_argomenti_sav) //leggo argomenti del dw salvati in prec
			if k_bytes > 0 then
				k_argomenti_sav_setrow = long(left(k_argomenti_sav, 10))
			end if

		loop

		k_return = kdw_print.importfile( (trim(k_path) + "\" + k_nome_file + &
										".txt")) //" + string(k_ctr, "000"))) 
	
		if k_return < 1 then
			k_return = 0
		else
			
			if k_argomenti_sav_setrow > 0 then
				k_return = k_argomenti_sav_setrow   // nr riga su cui era posizionato (setrow())
			else
				k_return = 1
			end if
					
			kdw_print.setrow(k_return)
			kdw_print.scrolltorow(k_return)
			kdw_print.selectrow(0, false)
			kdw_print.selectrow(k_return, true)
					
			kdw_print.resetupdate()
				
		end if
		fileclose(k_file)

	end if				

return k_return

end function

public function string smista_stampe (ref datawindow kdw_print, ref st_open_w kst_open_w);//
//
//
string k_return
string k_scelta, k_size, k_msg, k_nome_dw
long k_nr_rek
int k_rc


pointer oldpointer

//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

//
//=== Lancia le rispettive routine di stampa
	
	k_nr_rek = 0

	k_scelta = trim(kst_open_w.key2)
	k_nome_dw = trim(kst_open_w.key3) 

	choose case trim( k_scelta )
	
		case "dw"  //stampa la dw scaricata su disco
			kdw_print.dataobject = k_nome_dw
			k_size = profilestring &
				( "confdb.ini", "moduli", "tabulato", "0")
			kdw_print.Modify("DataWindow.Print.Paper.Size='"+trim(k_size)+"'")
//    0 - Default, 1 - Letter 8.5x11, 2 - Letter Small 8.5x11....,

			kdw_print.settransobject ( sqlca )
			if isvalid(kdw_print) then

		      k_rc = kst_open_w.key11_dw.rowscopy(1,kst_open_w.key11_dw.rowcount(), &
				                        primary!,kdw_print,1,primary!)
				k_nr_rek = kst_open_w.key11_dw.rowcount() 

			end if
			if k_nr_rek = 0 then
				k_msg = "Nessuna Stampa da effettuare, ~n~rper la richiesta fatta"
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
on kuf_stampe.create
TriggerEvent( this, "constructor" )
end on

on kuf_stampe.destroy
TriggerEvent( this, "destructor" )
end on

