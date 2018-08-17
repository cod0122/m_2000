$PBExportHeader$kuf_filtra.sru
forward
global type kuf_filtra from kuf_parent
end type
end forward

global type kuf_filtra from kuf_parent
end type
global kuf_filtra kuf_filtra

type variables
//
private graphicobject ki_obj_da_filtrare // oggetto (datawindow) con i dati da filtrare
private w_g_tab kiw_del_obj		// window contenente il dw con i dati da filtrare
private w_g_filtra kiw_filtra		// piccola window con i parametri di filtro
private string ki_titolo=""			// x evitare la rilettura delle colonne 
private datawindow kidw_filtra   // contiene il dw con le colonne filtrabili
end variables

forward prototypes
public function graphicobject get_obj_da_filtrare ()
public subroutine set_obj_da_filtrare (ref graphicobject a_obj)
public function w_g_filtra get_window_filtra ()
public subroutine set_window_filtra (ref w_g_filtra a_window)
public subroutine u_filtra (ref datawindow a_dw)
private subroutine u_open_window (string a_titolo)
public subroutine u_close_window_obj ()
private function graphicobject get_obj_filtro ()
public subroutine u_close_window_filtra ()
public function boolean u_attiva_filtro (ref graphicobject a_obj, ref w_g_tab a_window_obj, string a_titolo)
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function datawindow get_dw_filtra ()
public subroutine set_dw_filtra (datawindow adw_filtra)
end prototypes

public function graphicobject get_obj_da_filtrare ();//
return ki_obj_da_filtrare



end function

public subroutine set_obj_da_filtrare (ref graphicobject a_obj);//
ki_obj_da_filtrare = a_obj

end subroutine

public function w_g_filtra get_window_filtra ();//
return kiw_filtra 


end function

public subroutine set_window_filtra (ref w_g_filtra a_window);//
kiw_filtra = a_window


end subroutine

public subroutine u_filtra (ref datawindow a_dw);//
//--- Applica il filtro x i Dati indicati 
//--- Inp: a_dw = datawindow con i dati di filtro
//
//
string k_campo="", k_segno="", k_filtro="", k_filtro_s="", k_coltype=" "
string k_filtro_like="", k_err_filtro="", k_or_and="", k_operat
int k_ctr
datawindow kdw_1



	a_dw.accepttext()

	kdw_1 = get_obj_da_filtrare( )


				
	for k_ctr = 1 to a_dw.RowCount ( )

//		if k_ctr > 1 then
//			k_ctr = k_ctr - 1
			k_campo = trim(a_dw.getitemstring(k_ctr,"k_campo"))
			k_segno = trim(a_dw.getitemstring(k_ctr,"k_segno"))
			k_filtro = trim(a_dw.getitemstring(k_ctr,"k_filtro"))
			if k_ctr > 1 then
				k_or_and = a_dw.getitemstring(k_ctr - 1,"k_or_and")
				if len(trim(k_or_and)) > 0 then
					k_or_and = k_or_and + " "
				else
					k_or_and = "E"
					a_dw.setitem(k_ctr - 1,"k_or_and", k_or_and)
				end if
			else
				k_or_and = " "
			end if
			if trim(k_or_and) = "O" then
				k_operat = " OR "
			else
				if trim(k_or_and) = "E" then
					k_operat = " AND "
				else
					k_operat = " "
				end if
			end if
			
//			k_ctr++
//		end if
		
		if len(trim(k_campo)) > 0 and len(trim(k_segno)) >0 and len(trim(k_filtro)) > 0 then
			
			k_coltype = kdw_1.Describe(k_campo+".Coltype")
			
			choose case upper(left(k_coltype,2))
			
				case 'CH'
					if pos(k_filtro, "%", 1) > 0 then
						if len(trim(k_filtro_like)) = 0 then
							k_filtro_like = trim(k_campo) + " like '" + trim(k_filtro) + "'"
							k_filtro = ""
						else
							k_filtro = "ERRORE"
						end if
					else	
						k_filtro = "'" + k_filtro + "'"
					end if
			
				case 'DA'
					k_filtro = "date('"+string(date(k_filtro), "dd/mm/yyyy")+"')"

			end choose
			
			if len(k_filtro) > 0 then 
				if len(k_filtro_s) = 0 then
					k_filtro_s = k_campo + " " + k_segno + " " + k_filtro
				else
					k_filtro_s = k_filtro_s + k_operat + &
							 k_campo + " " + k_segno + " " + k_filtro
				end if
			end if
		end if			

	next

	if len(k_filtro_like) > 0 then 
		if len(k_filtro_s) > 0 then
			k_err_filtro = "Con il carattere %  e' permessa solo una riga,~n~r" + &
							"gli altri filtri sono stati esclusi "
		end if	
		k_filtro_s = k_filtro_like 
	end if

	k_ctr = kdw_1.setfilter(k_filtro_s)
	 
	if k_ctr < 1 then
		messagebox("Operazione NON eseguita", &
			"Dati del filtro incongruenti, ~n~r" + &
			"Controlla i dati e riprova")
	else
		
		k_ctr = kdw_1.filter()
		
		if len (trim(k_err_filtro)) > 0 then
			messagebox("Filtro eseguito solo Parzialmente", &
						k_err_filtro)
			a_dw.setfocus()
		else
			
			kdw_1.setfocus()
			
		end if						
	end if
		
	kdw_1.GroupCalc()

		
end subroutine

private subroutine u_open_window (string a_titolo);//
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


	K_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
	K_st_open_w.id_programma = this.get_id_programma(K_st_open_w.flag_modalita)
	K_st_open_w.flag_primo_giro = ""
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN_NO
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	k_st_open_w.key1 = a_titolo  				// descrizione filtro
	K_st_open_w.key12_any = this			// questo oggetto di gestione del filtro
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_filtra(k_st_open_w)
	destroy kuf1_menu_window
								

end subroutine

public subroutine u_close_window_obj ();//
//--- Chiude la window contenente l'obj da filtrare
//
if isvalid(kiw_del_obj) then kiw_del_obj.smista_funz(kkg_flag_richiesta_esci )  

end subroutine

private function graphicobject get_obj_filtro ();//
	return kiw_filtra.dw_filtra 



end function

public subroutine u_close_window_filtra ();//
//--- Chiude la window contenente il filtro
//
if isvalid(kiw_filtra) then kiw_filtra.chiudi_immediato()


end subroutine

public function boolean u_attiva_filtro (ref graphicobject a_obj, ref w_g_tab a_window_obj, string a_titolo);//
//--- Attiva la window x fare un filtro sui dati in elenco
//--- Inp: obj (datawindow) su cui fare il filtro
//---		window del obj (datawindow) su cui fare il filtro
//---        descrizione del filtro
//
boolean k_return = true
integer k_nr_colonne = 0 
//datawindow kidw_filtra

try 
	if isvalid(a_obj) then
	 
		set_obj_da_filtrare(a_obj)
		kiw_del_obj =  a_window_obj
		
		// se window non ancora aperta
		if not isnull(kiw_filtra) then
			u_open_window(a_titolo)			
		end if
	end if

catch (uo_exception kuo_exception)
	k_return = false

end try

return k_return

end function

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
return true
end function

public function datawindow get_dw_filtra ();//---torna il 'filtro' oggetto con i nomi delle colonne da filtrare
return kidw_filtra
			

end function

public subroutine set_dw_filtra (datawindow adw_filtra);//
//--- Imposta nel datastore le colonne da filtrare
//
int k_ctr=0, k_nro_colonne=0, k_start_pos, k_ctr_colonna=0
long k_n_righe=0
string k_count, k_titolo, k_char
string k_nome_colonna, k_nome_colonna_t
datawindow kdw_1
kuf_utility kuf1_utility


if NOT isnull(adw_filtra) then

//--- fisso l'elenco di ricerca 	
	kdw_1 = get_obj_da_filtrare( )
	k_n_righe = kdw_1.rowcount()

	if k_n_righe > 1 then
	
		k_titolo = kdw_1.tag
		
//--- Se e' uguale alla visualizz precedente allora non ripeto tutto
//		if ki_titolo <> "Filtra dati in elenco: " + trim(k_titolo) or  trim(k_titolo) = "" then
	
			kidw_filtra = adw_filtra

			kuf1_utility = create kuf_utility

			ki_titolo ="Filtra dati in elenco: " + trim(k_titolo)
	
			k_count = kdw_1.Describe("DataWindow.column.count")

			kidw_filtra.setvalue("k_campo", 1, " ")
		
			k_nro_colonne = integer(k_count)
			k_ctr_colonna = 1
			for k_ctr = 1 to k_nro_colonne
				
				k_nome_colonna = kdw_1.Describe("#" + string(k_ctr) + ".name")
				k_nome_colonna_t=kuf1_utility.u_stringa_pulisci_x_msg( kdw_1.Describe(k_nome_colonna + "_t.text") )
		
				if trim(k_nome_colonna_t) <> "!" then		
					k_ctr_colonna++
					kidw_filtra.setvalue("k_campo", k_ctr_colonna, 	k_nome_colonna_t + "~t" + k_nome_colonna) 
				end if		
				
			next
			
			for k_ctr = 1 to 5
				kidw_filtra.insertrow(k_ctr)
				kidw_filtra.setitem(k_ctr, "k_segno", "=") 
					
			next
		
			destroy kuf1_utility
			
//		end if
		
	end if

end if



end subroutine

on kuf_filtra.create
call super::create
end on

on kuf_filtra.destroy
call super::destroy
end on

event destructor;call super::destructor;//
if isvalid(kiw_filtra) then kiw_filtra.chiudi_immediato()





end event

