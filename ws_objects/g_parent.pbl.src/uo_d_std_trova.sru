$PBExportHeader$uo_d_std_trova.sru
forward
global type uo_d_std_trova from datawindow
end type
end forward

global type uo_d_std_trova from datawindow
integer width = 1925
integer height = 396
string title = "Trova dati in Elenco  (tasto F3)"
string dataobject = "d_trova_0"
boolean border = false
string icon = "Query5!"
event u_keydwn pbm_dwnkey
event u_keyenter pbm_dwnprocessenter
end type
global uo_d_std_trova uo_d_std_trova

type variables
//--- usato per il "TROVA", e' il campo proposto per default e Altro...
public int ki_trova_campo_def = 1
private GraphicObject kiany_oggetto_trova 

end variables

forward prototypes
public subroutine set_cerca_in_any (integer k_campo)
public function graphicobject get_obj_trova ()
private function string get_trova_nome_colonna ()
public function boolean u_trova ()
public subroutine u_scegli_tipo ()
private subroutine set_cerca_in_dw (integer k_campo_default, ref datawindow adw_1)
private subroutine set_cerca_in_lv (integer k_campo, ref listview alv_1)
private function boolean u_trova_in_lv ()
private function boolean u_trova_in_dw ()
public function boolean set_obj_trova (ref graphicobject aany_oggetto) throws uo_exception
end prototypes

event u_keydwn;////
////--- se tasto ESC provo l'undo
//	if key = KeyESCape! then
//		THIS.visible = false
//	end if
//
//
//
end event

event u_keyenter;//	
	u_trova()

end event

public subroutine set_cerca_in_any (integer k_campo);//
//--- Imposta nel controllo le Colonne dell'oggetto su cui fare la ricerca
//

boolean k_this=false
int k_ctr=0, k_nro_colonne=0, k_start_pos, k_ctr_colonna
long k_n_righe=0
string k_count, k_titolo, k_char
string k_nome_colonna, k_nome_colonna_t, k_nome_colonna_default
datawindow kdw_1
listview klv_1
kuf_utility kuf1_utility



//--- fisso l'elenco di ricerca 	

	CHOOSE CASE kiany_oggetto_trova.TypeOf()


		CASE DataWindow!

			kdw_1 = kiany_oggetto_trova
			if kdw_1.rowcount( ) = 0 then   
				kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_not_fnd )
				kguo_exception.setmessage("La ricerca puo' essere fatta solo su un elenco dati pieno. Prego posizionarsi su elenco e riprovare." )
				kguo_exception.messaggio_utente( )
			else
				k_this=true
				set_cerca_in_dw(k_campo, kdw_1)
			end if


		CASE listview!

			klv_1 = kiany_oggetto_trova
			if klv_1.TotalItems ( ) = 0 then   
				kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_not_fnd )
				kguo_exception.setmessage("La ricerca puo' essere fatta solo su un elenco dati pieno. Prego posizionarsi su elenco e riprovare." )
				kguo_exception.messaggio_utente( )
			else
				
				k_this=true
				set_cerca_in_lv(k_campo, klv_1)
			end if
	
	end choose

	if k_this then
		u_scegli_tipo()
	end if
	
	
end subroutine

public function graphicobject get_obj_trova ();//---
//--- Torna l'oggetto su cui fare il TROVA
//---


return  kiany_oggetto_trova




end function

private function string get_trova_nome_colonna ();
long k_ctr, k_rc, k_pos
string k_valore,k_nome_colonna


//--- Cerca il nome del campo
k_nome_colonna = trim(this.getitemstring(1, "k_campo"))

k_ctr=1
k_valore = this.getvalue("k_campo", k_ctr)
k_pos = Pos(k_valore, "~t", 1)
k_valore = trim(Left(k_valore, k_pos - 1))
do while k_valore <> k_nome_colonna and len(trim(k_valore)) > 0 
	k_ctr++
	k_valore = this.getvalue("k_campo", k_ctr)
	k_pos = Pos(k_valore, "~t", 1)
	k_valore = trim(Left(k_valore, k_pos - 1))
loop
if k_valore = k_nome_colonna then
	k_valore = this.getvalue("k_campo", k_ctr)
	k_pos = Pos(k_valore, "~t", 1)
	k_nome_colonna = trim(mid(k_valore, k_pos + 1))
end if


return k_nome_colonna


end function

public function boolean u_trova ();//
//--- ESEGUE LA RICERCA
//
boolean k_return = false

	
	if not isnull(kiany_oggetto_trova) and isvalid(kiany_oggetto_trova) then

		CHOOSE CASE kiany_oggetto_trova.TypeOf()
	
			CASE DataWindow!
				k_return=u_trova_in_dw()
	
			CASE listview!
				k_return = u_trova_in_lv()
		
		end choose
	end if
	

return k_return

end function

public subroutine u_scegli_tipo ();//
string k_tipo_campo, k_nome_colonna, k_campo
datawindow kdw_1
listview klv_1

	
	CHOOSE CASE kiany_oggetto_trova.TypeOf()

		CASE DataWindow!

			kdw_1 = kiany_oggetto_trova

			k_campo = trim(this.getitemstring(1, "k_campo"))   //k_campo = trim(data)
//--- Cerca il nome del campo
//			k_nome_colonna = trim(k_campo) 
			k_nome_colonna = get_trova_nome_colonna()

			if len(trim(k_nome_colonna)) > 0 then
			
				k_tipo_campo = kdw_1.Describe(k_nome_colonna+".Coltype")
				choose case upper(left(k_tipo_campo,2))
			
					case 'CH'
						this.Object.k_filtro.visible ='1'				
						this.Object.k_filtro_dt.visible ='0'				
						this.Object.k_filtro_nr.visible ='0'		
						this.setcolumn( "k_filtro")
						
					case 'DA'
						this.Object.k_filtro_dt.visible ='1'				
						this.Object.k_filtro.visible ='0'				
						this.Object.k_filtro_nr.visible ='0'				
						this.setcolumn( "k_filtro_dt")

					case else
						this.Object.k_filtro_nr.visible ='1'				
						this.Object.k_filtro.visible ='0'				
						this.Object.k_filtro_dt.visible ='0'				
						this.setcolumn( "k_filtro_nr")
						
				end choose
		
			end if

		CASE listview!

			klv_1 = kiany_oggetto_trova
			this.Object.k_filtro.visible ='1'				
			this.Object.k_filtro_dt.visible ='0'				
			this.Object.k_filtro_nr.visible ='0'				
			this.setcolumn( "k_filtro")
			
	end choose

end subroutine

private subroutine set_cerca_in_dw (integer k_campo_default, ref datawindow adw_1);//
//--- Imposta nel controllo le Colonne del DW su cui fare la ricerca
//
int k_ctr=0, k_nro_colonne=0, k_start_pos, k_ctr_colonna, k_rc
long k_n_righe=0
string k_count, k_titolo, k_char
string k_nome_colonna, k_nome_colonna_t, k_nome_colonna_default
kuf_utility kuf1_utility


	if k_campo_default = 0 or isnull(k_campo_default) then  //--- fisso la colonna di default x la ricerca se non impostata 
		k_campo_default = 1
	end if
	
	k_n_righe = adw_1.rowcount()


	if this.rowcount() > 0 or k_n_righe > 0 then
	
		k_titolo = adw_1.title

//--- Se e' uguale alla visualizz precedente allora non ripeto tutto
//		if this.title <> "Cerca dati in elenco: " + trim(k_titolo) then
	
			kuf1_utility = create kuf_utility

			this.title="Cerca dati in elenco: " + trim(k_titolo)
		
			k_count = adw_1.Describe("DataWindow.column.count")

			this.ClearValues("k_campo")
			this.setvalue("k_campo", 1, " ")
		
			k_nro_colonne = integer(k_count)
			k_ctr_colonna=0
			for k_ctr = 1 to k_nro_colonne
				
				k_nome_colonna = adw_1.Describe("#" + string(k_ctr) + ".name")
//				k_nome_colonna_t = adw_1.Describe(k_nome_colonna + "_t.text")
				k_nome_colonna_t=kuf1_utility.u_stringa_pulisci_x_msg(adw_1.Describe(k_nome_colonna + "_t.text"))
				
				if trim(k_nome_colonna_t) = "!" then
					k_nome_colonna_t = "Colonna " + string(k_ctr)
				end if
	
				k_ctr_colonna++
				k_rc=this.setvalue("k_campo", k_ctr_colonna, k_nome_colonna_t  + " ~t" + k_nome_colonna )    //
					
				if k_campo_default = k_ctr_colonna then  //--- fisso la colonna di default x la ricerca
					k_nome_colonna_default = trim(k_nome_colonna_t)
				end if

//				end if		
		
			next

			if this.rowcount() = 0 then
				this.insertrow(k_ctr)
			end if
			
			if len(k_nome_colonna_default) > 0 then
				this.setitem(1, "k_campo", k_nome_colonna_default)
			end if
		
			destroy kuf1_utility
			
//		end if
		
	end if



end subroutine

private subroutine set_cerca_in_lv (integer k_campo, ref listview alv_1);//
//--- Imposta nel controllo le Colonne del LISTVIEW su cui fare la ricerca
//
int k_ctr=0, k_nro_colonne=0, k_start_pos, k_ctr_colonna
long k_n_righe=0
string  k_titolo, k_char
string k_nome_colonna, k_nome_colonna_t, k_nome_colonna_default
integer k_larg_campo, k_rc
alignment k_align 


kuf_utility kuf1_utility


	if k_campo = 0 or isnull(k_campo) then  //--- fisso la colonna di default x la ricerca se non impostata 
		k_campo = 1
	end if
	
	k_n_righe = alv_1. TotalItems ( )


	if this.rowcount() > 0 or k_n_righe > 1 then
	

//--- Se e' uguale alla visualizz precedente allora non ripeto tutto
	
			kuf1_utility = create kuf_utility

			this.title="Cerca dati in elenco: " + trim(k_titolo)
	
//			this.x = (kiw_this_window.width - this.width) / 2 
//			this.y = kiw_this_window.y +  this.width / 2 
		
			this.ClearValues("k_campo")
			this.setvalue("k_campo", 1, " ")
		
			k_nro_colonne =  alv_1.TotalColumns ( )
			k_ctr_colonna=1
			for k_ctr = 1 to k_nro_colonne

				k_rc = alv_1.getColumn(k_ctr_colonna, k_nome_colonna_t , k_align, k_larg_campo)
				if k_rc >= 0 then
					k_nome_colonna = string(k_ctr_colonna)
					this.setvalue("k_campo", k_ctr_colonna, 	k_nome_colonna_t + "~t" + k_nome_colonna) 
		
					if k_campo = k_ctr_colonna then  //--- fisso la colonna di default x la ricerca
						k_nome_colonna_default = trim(k_nome_colonna_t)
					end if
		
					k_ctr_colonna++
				end if		
		
			next

			if this.rowcount() = 0 then
				this.insertrow(k_ctr)
			end if
			
			if len(k_nome_colonna_default) > 0 then
				this.setitem(1, "k_campo", k_nome_colonna_default)
			end if
		
			destroy kuf1_utility
			
		
	end if



end subroutine

private function boolean u_trova_in_lv ();//
//=== Trova il Testo indicato nel campo 
//
boolean k_return = false

long k_riga,  k_righe_tot
int k_nr_colonna, k_pos, k_ctr, k_ctr_1, k_rc
string  k_tipo_campo, k_cerca="", k_rigax, k_cerca_storico
boolean k_extendedselect
string k_find, k_nome_colonna="", k_valore_col
pointer oldpointer  // Declares a pointer variable
//GraphicObject k_which_control
listview klv_trova
listviewitem klv_listviewitem


klv_trova = kiany_oggetto_trova

this.accepttext( )
k_nome_colonna = get_trova_nome_colonna()
if not isnumber(k_nome_colonna) then
	k_nr_colonna = 1
else
	k_nr_colonna = integer(k_nome_colonna)
	if k_nr_colonna = 0 then k_nr_colonna = 1
end if

k_cerca = trim(this.getitemstring(1, "k_filtro"))

//=== Se ho scritto qualcosa 
if len(trim(k_cerca)) > 0 then
	
////=== Se NON sono in ricerca lancio INIZIALIZZA()
//	if this.object.b_cerca.text = "Cerca" then 

//=== Puntatore Cursore da attesa.....
		oldpointer = SetPointer(HourGlass!)

//--- Salvo la proprieta' di Attivo multi-selezione delle righe 
		k_extendedselect = klv_trova.extendedselect  
		klv_trova.ExtendedSelect = false
	

		k_riga = klv_trova.SelectedIndex ( )
		if k_riga <= 0 then k_riga = 1
		k_righe_tot = klv_trova.totalitems()

		k_find = upper(trim(k_cerca))
	
		if len(trim(k_find)) > 0 then
	
			k_riga++
			
			klv_trova.getitem(k_riga, k_nr_colonna, k_valore_col)
			k_pos = pos (upper(k_valore_col), k_find, 1)
			do while k_pos <= 0 and k_righe_tot >= k_riga
				k_riga++
				klv_trova.getitem(k_riga, k_nr_colonna, k_valore_col)
				k_pos = pos (upper(k_valore_col), k_find, 1)
			loop

			if k_pos <= 0 and k_riga > 1 then //allora ricerco ancora dalla prima riga
				k_riga = 1
				klv_trova.getitem(k_riga, k_nr_colonna, k_valore_col)
				k_pos = pos (upper(k_valore_col), k_find, 1)
				do while k_pos <= 0 and k_righe_tot >= k_riga
					k_riga++
					klv_trova.getitem(k_riga, k_nr_colonna, k_valore_col)
					k_pos = pos (upper(k_valore_col), k_find, 1)
				loop
			end if

//--- inserisce nella lista delle ricerche storiche
			for k_ctr = 9 to 1 step -1
				if not isnull(this.getvalue("k_filtro", k_ctr)) and len(trim(this.getvalue("k_filtro", k_ctr))) > 0 then
					k_cerca_storico = this.getvalue( "k_filtro", k_ctr)
					k_pos = Pos(k_cerca_storico, "~t", 1)
					k_cerca_storico = trim(Left(k_cerca_storico, k_pos - 1))
					k_ctr_1 = k_ctr + 1
					k_rc=this.setvalue( "k_filtro", k_ctr_1, k_cerca_storico +" ~t" + k_cerca_storico )    //x pigliare il vero nome di colonna
				end if
			next
			k_cerca = trim(this.getitemstring(1,  "k_filtro"))
			k_rc=this.setvalue( "k_filtro", 1, k_cerca +"~t" + k_cerca )    //x pigliare il vero nome di colonna

			SetPointer(oldpointer)
			if k_riga <= 0 or k_righe_tot < k_riga then
//				messagebox("Ricerca fallita", "Dato richiesto non trovato in elenco")
				this.setitem(1, "k_flg_non_trovato", 1)
				k_rigax = "(DATO NON TROVATO IN ELENCO) "
			else
				
				this.setitem(1, "k_flg_non_trovato", 0)
				klv_trova.GetItem (k_riga, klv_listviewitem )
				klv_listviewitem.HasFocus = TRUE
				klv_listviewitem.Selected = TRUE
				klv_trova.SetItem(k_riga, klv_listviewitem)
				klv_trova.ExtendedSelect = k_ExtendedSelect
	//--- scroll della lista sull'indice trovato
				if not (kGuf_data_base.u_listview_scroll(klv_trova, k_riga)) then
					SetPointer(oldpointer)
					messagebox("Posizionamento fallito", "Il dato richiesto e' stato trovato alla riga " + string (k_riga) &
								  + "~n~rper posizionarsi sulla riga indicata agire con le frecce o la barra di scorrimento. ")
				end if
				
//				this.visible = false
				
				this.object.b_cerca.text  = "Cerca >>"
				k_rigax = "(TROVATO a riga " + string(k_riga) + ") "
				klv_trova.setfocus( )

				k_return = true
				
			end if
			this.setitem(1, "k_riga", k_rigax)
		else
			SetPointer(oldpointer)
		end if
		

	
end if


return k_return

end function

private function boolean u_trova_in_dw ();//
//=== Trova il Testo indicato nel campo 
//
boolean k_return = false

long k_riga, k_inizio_find, k_ctr_1, k_ctr, k_rc, k_pos, k_flg_tipo_trova
string  k_tipo_campo, k_cerca="", k_rigax, k_cerca_storico
string k_find, k_nome_colonna="", k_valore, k_colonna
pointer oldpointer  // Declares a pointer variable
//GraphicObject k_which_control
datawindow kdw_trova 


kdw_trova = kiany_oggetto_trova

this.accepttext( )
//--- Cerca il nome del campo
k_nome_colonna = get_trova_nome_colonna()

if len(trim(k_nome_colonna)) > 0 then

	k_tipo_campo = kdw_trova.Describe(k_nome_colonna+".Coltype")
	k_flg_tipo_trova = this.getitemnumber( 1, "k_flg_tipo_trova")

	choose case upper(left(k_tipo_campo,2))

		case 'DA'
			k_cerca = trim(string(this.getitemdate(1, "k_filtro_dt")))
			
		case else
			if upper(left(k_tipo_campo,2)) = 'CH' then
				k_colonna = "k_filtro"
			else
				k_colonna = "k_filtro_nr"
			end if
			for k_ctr = 9 to 1 step -1
				if not isnull(this.getvalue(k_colonna, k_ctr)) and len(trim(this.getvalue(k_colonna, k_ctr))) > 0 then
					k_cerca_storico = this.getvalue(k_colonna, k_ctr)
					k_pos = Pos(k_cerca_storico, "~t", 1)
					k_cerca_storico = trim(Left(k_cerca_storico, k_pos - 1))
					k_ctr_1 = k_ctr + 1
					k_rc=this.setvalue(k_colonna, k_ctr_1, k_cerca_storico +"~t" + k_cerca_storico )    //x pigliare il vero nome di colonna
				end if
			next
			if upper(left(k_tipo_campo,2)) = 'CH' then
				k_cerca = trim(this.getitemstring(1, k_colonna))
			else
				k_cerca = trim(string(this.getitemnumber(1, k_colonna)))
			end if
			k_rc=this.setvalue(k_colonna, 1, k_cerca +"~t" + k_cerca )    //x pigliare il vero nome di colonna
			

	end choose
end if

//=== Se ho scritto qualcosa 
if len(trim(k_cerca)) > 0 then
	
////=== Se NON sono in ricerca lancio INIZIALIZZA()
//	if this.object.b_cerca.text = "Cerca" then 

//=== Puntatore Cursore da attesa.....
		oldpointer = SetPointer(HourGlass!)

		k_inizio_find = kdw_trova.GetSelectedRow(0) 
		if k_inizio_find = 0 then
			k_inizio_find = 1
		else
			k_inizio_find ++
		end if
//		k_inizio_find = kdw_trova.getrow() 
		
		choose case upper(left(k_tipo_campo,2))

			case 'CH'
				if k_flg_tipo_trova = 0 then
					k_find =	"upper("+k_nome_colonna + ") like '" + "%" + upper(trim(k_cerca)) + "%'"
				else
					k_find =	"upper("+k_nome_colonna + ") like '" + upper(trim(k_cerca)) + "%'"
				end if
			case 'DA'
				if isdate(trim(k_cerca)) then
					k_find =	" "+k_nome_colonna + " = date('"  &
			   	         + string(date(trim(k_cerca))) + "') "
				else
					k_find = ""
					SetPointer(oldpointer)
					messagebox("Ricerca non eseguita", trim(k_cerca) + " non sembra una data valida")
				end if
			case else
				if isnumber(trim(k_cerca)) then
					k_find =	k_nome_colonna + " = " + &
			   	    trim(k_cerca) 
				else
					k_find = ""
					SetPointer(oldpointer)
					messagebox("Ricerca non eseguita", "Il dato indicato non e' numerico")
				end if
				
		end choose
	
		if len(trim(k_find)) > 0 then
	
			k_riga = kdw_trova.Find( k_find , k_inizio_find,  kdw_trova.RowCount( ))
		
			if k_riga <= 0 and k_inizio_find > 1 then //allora ricerco ancora dalla prima riga
				k_riga = kdw_trova.Find( k_find , 1, k_inizio_find )
			end if
	
			SetPointer(oldpointer)
			if k_riga <= 0 then
//				messagebox("Ricerca fallita", "Dato richiesto non trovato in elenco")
				this.setitem(1, "k_flg_non_trovato", 1)
				k_rigax = "(DATO NON TROVATO IN ELENCO) "
			else
				
//				this.visible = false
				
				this.setitem(1, "k_flg_non_trovato", 0)
				kdw_trova.ExpandAllChildren(k_riga,1)
				kdw_trova.scrolltorow(k_riga)
				kdw_trova.SelectRow(0, FALSE)
				kdw_trova.selectrow(k_riga, true)
				kdw_trova.setrow(k_riga)
				this.object.b_cerca.text  = "Cerca >>"
				k_rigax = "(TROVATO a riga " + string(k_riga) + ") "
				kdw_trova.setfocus( )
				
				 k_return = true
				 
			end if
			this.setitem(1, "k_riga", k_rigax)
		else
			SetPointer(oldpointer)
		end if
		

	
end if


return k_return

end function

public function boolean set_obj_trova (ref graphicobject aany_oggetto) throws uo_exception;//---
//--- Imposta l'oggetto  'kiany_oggetto_trova'  su cui fare il TROVA
//---
boolean k_return = false


if isvalid(aany_oggetto) then
	if TypeOf(aany_oggetto) = DataWindow! or TypeOf(aany_oggetto) = Listview! then
		kiany_oggetto_trova = aany_oggetto
		 k_return = true
	else
		setnull(kiany_oggetto_trova)
		kguo_exception.inizializza( )
		kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_dati_insufficienti )
		kguo_exception.setmessage("Scegliere l'elenco su cui Cercare")
		throw kguo_exception
	end if
else
	setnull(kiany_oggetto_trova)
	kguo_exception.inizializza( )
	kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_dati_insufficienti )
	kguo_exception.setmessage("Scegliere prima l'elenco su cui Cercare")
	throw kguo_exception
end if


return k_return

end function

event buttonclicked;//	
u_trova( )
end event

event getfocus;
//
//--- imposta l'info del numero di riga di partenza della ricerca
long k_riga=0
string k_rigax, k_titolo
//GraphicObject kany_1
datawindow kdw_1
listview klv_1



//--- piglio l'oggetto con l'elenco di ricerca 	
//	kany_1 = get_obj_trova() 
if isvalid(kiany_oggetto_trova) then

	CHOOSE CASE kiany_oggetto_trova.TypeOf()

		CASE DataWindow!

			kdw_1 = kiany_oggetto_trova
			if kdw_1.rowcount( ) > 0 then   
				k_riga = kdw_1.GetSelectedRow(0) 
				if len(trim(kdw_1.title)) > 0 and trim(kdw_1.title) <> "none" then
					k_titolo = "Cerca dati in elenco: " + trim(kdw_1.title)
				else
					k_titolo = "Cerca dati in elenco" 
				end if
			end if

		CASE listview!

			klv_1 = kiany_oggetto_trova
			k_riga = klv_1.SelectedIndex ( )
			k_titolo = "Cerca dati in elenco "
			
	end choose

	if k_riga <= 0 then
		k_riga = 1
	else
		k_riga ++
	end if
	
	if this.rowcount( ) > 0 then
		if this.getitemnumber(1, "k_flg_non_trovato") = 1 then
			k_rigax = "(DATO NON TROVATO IN ELENCO) "
		else
			k_rigax = "(dalla riga " + string(k_riga) + ") "
		end if
		this.setitem(1, "k_riga", k_rigax)
		
		this.selecttext(1, Len(this.GetText()))
	end if
end if

this.title = k_titolo
	
	

end event

event itemchanged;//

if dwo.name = "k_campo" then
	post u_scegli_tipo()
end if

end event

event itemerror;//
//=== Evita la messaggistica di sistema
return 1

end event

on uo_d_std_trova.create
end on

on uo_d_std_trova.destroy
end on

