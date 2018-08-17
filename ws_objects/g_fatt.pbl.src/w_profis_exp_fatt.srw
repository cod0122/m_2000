$PBExportHeader$w_profis_exp_fatt.srw
forward
global type w_profis_exp_fatt from w_super
end type
type dw_exp_fatt from datawindow within w_profis_exp_fatt
end type
end forward

global type w_profis_exp_fatt from w_super
integer width = 1737
integer height = 836
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = child!
long backcolor = 8388608
string icon = "Asterisk!"
integer animationtime = 50
event u_open ( )
dw_exp_fatt dw_exp_fatt
end type
global w_profis_exp_fatt w_profis_exp_fatt

type variables
//
//st_open_w ki_st_open_w
private w_profis_exp_fatt kiw_this
private kuf_prof_exp kiuf_prof_exp
private boolean ki_permetti_chiusura=false 

end variables

forward prototypes
protected subroutine smista_funz (string k_par_in)
public subroutine chiudi ()
public subroutine chiudi_immediato ()
public subroutine u_retrieve ()
public subroutine esporta_movimenti ()
private function string get_path ()
private subroutine set_path ()
public subroutine u_resize ()
end prototypes

event u_open();//

try 

		if isnull(ki_st_open_w.key1) then ki_st_open_w.key1 = ""

		this.title = "<" + trim(ki_st_open_w.id_programma) + "> " + ki_st_open_w.window_title 
	
//--- punta all'oggetto kuf_trova x fare il trova
		kiw_this = this
	
//--- dimensioni
		this.width = 1800
		this.height = 950

		u_retrieve( )
	
		ki_st_open_w.flag_primo_giro = "N"
		this.show( )	
		this.SetPosition(topmost! )

catch(uo_exception kuo_exception )
	post event close( )

end try


end event

protected subroutine smista_funz (string k_par_in);//===
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//=== Ritorna ...: 0=tutto OK; 1=Errore
//===


choose case k_par_in 


//	case KKG_FLAG_RICHIESTA.stampa		//richiesta stampa
//		stampa()

	case KKG_FLAG_RICHIESTA.esci		//richiesta uscita
		if isvalid(kiuf_prof_exp) then kiuf_prof_exp.u_close_window_prof_exp_fatt()




end choose

end subroutine

public subroutine chiudi ();//
if not ki_permetti_chiusura then
	ki_permetti_chiusura = true
	kiuf_prof_exp.post u_close_window_prof_exp_fatt( )
else
	close(kiw_this)
end if

end subroutine

public subroutine chiudi_immediato ();//
	ki_permetti_chiusura = true
	chiudi()

end subroutine

public subroutine u_retrieve ();//
long k_riga=0
string k_path=""
ust_tab_prof kust_tab_prof_ini, kust_tab_prof_fin


try
	kust_tab_prof_ini = create ust_tab_prof
	kust_tab_prof_fin = create ust_tab_prof
	
	kiuf_prof_exp.get_num_fatt_primo(kust_tab_prof_ini)
	kiuf_prof_exp.get_num_fatt_ultimo(kust_tab_prof_fin)
	
	dw_exp_fatt.reset( )
	k_riga = dw_exp_fatt.insertrow( 0)
	dw_exp_fatt.setitem( k_riga, "dal", kust_tab_prof_ini.num_fatt )
	dw_exp_fatt.setitem( k_riga, "al", kust_tab_prof_fin.num_fatt )
	dw_exp_fatt.setitem( k_riga, "anno", year(kust_tab_prof_ini.data_fatt) )
	dw_exp_fatt.setitem( k_riga, "profis", "1" )
	dw_exp_fatt.setitem( k_riga, "aggiorna", 1 )

	k_path = get_path()	
	dw_exp_fatt.setitem (k_riga, "cartella", trim(k_path))

	ki_st_open_w.flag_primo_giro = "S"

	u_resize( )
	
	dw_exp_fatt.visible = true 
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally
	if isvalid(kust_tab_prof_ini) then destroy kust_tab_prof_ini
	if isvalid(kust_tab_prof_fin) then destroy kust_tab_prof_fin

	
end try



end subroutine

public subroutine esporta_movimenti ();//
string k_path=""
long k_nr_fatt=0
datastore ds_exp_fatt
kuf_file_explorer kuf1_file_explorer


try
	dw_exp_fatt.accepttext( )
	if dw_exp_fatt.getitemnumber(1,"dal") > 0 and dw_exp_fatt.getitemnumber(1,"al") > 0 and dw_exp_fatt.getitemnumber(1,"anno") > 0   &
					and len(trim(dw_exp_fatt.getitemstring(1,"cartella"))) > 0 then
		
		if dw_exp_fatt.getitemnumber(1,"dal") > dw_exp_fatt.getitemnumber(1,"al") then
			messagebox("Operazione Interrotta", "Numeri indicati incongruenti", stopsign!)
		else
		
			if messagebox("Conferma Operazione", "Genera Archivio contabile fatture per STERIGENICS", question!, yesno!, 2) = 1 then

//---	scrivi valore path su INI
				k_path=dw_exp_fatt.getitemstring(1, "cartella")
				if isnull(k_path) then k_path = "" 
				kGuf_data_base.profilestring_leggi_scrivi(kGuf_data_base.ki_profilestring_operazione_scrivi , "arch_esolver_fatt", trim(k_path))

//--- lancia esportazione fatture	
				ds_exp_fatt = create datastore
				ds_exp_fatt.dataobject = dw_exp_fatt.dataobject
				dw_exp_fatt.rowscopy( 1, dw_exp_fatt.rowcount(), primary!, ds_exp_fatt,1,primary!)
				if isvalid(kiuf_prof_exp) then k_nr_fatt = kiuf_prof_exp.u_exp_fatt(ds_exp_fatt)
				
				if k_nr_fatt > 0 then
					k_path = trim(k_path) + KKG.PATH_SEP + kiuf_prof_exp.kki_nome_file_fatture
//					messagebox("Operazione Terminata", "Esportati " + string(k_nr_fatt) + " documenti. ")
					if messagebox("Esportazione terminata correttamente", "Vuoi vedere il file con i " + string(k_nr_fatt) + " documenti prodotti." + "~n~rsalvato nella cartella: " +  k_path , Question!, yesno!, 2) = 1 then
						SetPointer(kkg.pointer_attesa)
						kuf1_file_explorer = create kuf_file_explorer
						kuf1_file_explorer.of_execute( k_path )
						destroy kuf1_file_explorer
					end if
					if isvalid(kiuf_prof_exp) then kiuf_prof_exp.u_close_window_prof_exp_fatt( )
					
				else
					messagebox("Operazione Terminata", "Nessun documento esportato. ")
				end if
				
			else
				messagebox("Operazione Interrotta", "Come richiesto, nessuna operazione eseguita")
			end if
		
		end if
		
	else
		
		messagebox("Operazione Interrotta", "Campi in mappa incompleti", stopsign!)
		
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally
	if isvalid(ds_exp_fatt) then destroy ds_exp_fatt
	
end try

end subroutine

private function string get_path ();//
string k_path="",k_nulla=""
int k_ret

k_path = trim(kGuf_data_base.profilestring_leggi_scrivi(kGuf_data_base.ki_profilestring_operazione_leggi, "arch_esolver_fatt", k_nulla))

if isnull(k_path) then k_path = ".." 

return k_path 



end function

private subroutine set_path ();//
string k_path=".."
int k_ret


k_path = dw_exp_fatt.getitemstring (1, "cartella")
if len(trim(k_path)) > 0 then
else
	k_path=".."
end if

k_ret = GetFolder ( "Sceglire la Cartella di esportazione x ESOLVER", k_path )

if k_ret = 1 then
	dw_exp_fatt.setitem(1, "cartella", trim(k_path))
else
	if k_ret < 0 then
//--- ERRORE	
	end if
end if


end subroutine

public subroutine u_resize ();//
dw_exp_fatt.x = 1
dw_exp_fatt.y = 1
dw_exp_fatt.width = this.width -10
dw_exp_fatt.height = this.height - 20

dw_exp_fatt.setfocus()
dw_exp_fatt.bringtotop = true

//


end subroutine

on w_profis_exp_fatt.create
int iCurrent
call super::create
this.dw_exp_fatt=create dw_exp_fatt
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_exp_fatt
end on

on w_profis_exp_fatt.destroy
call super::destroy
destroy(this.dw_exp_fatt)
end on

event open;//
if isvalid(message.powerobjectparm) then 
	
	ki_st_open_w = message.powerobjectparm

	if isnull(ki_st_open_w.key1) then ki_st_open_w.key1 = ""

	this.title = "<" + trim(ki_st_open_w.id_programma) + "> " + ki_st_open_w.window_title 
	
//--- punta all'oggetto kuf_prof_exp
	kiuf_prof_exp = ki_st_open_w.key12_any
	kiw_this = this
	kiuf_prof_exp.set_w_profis_exp_fatt(kiw_this)
	
//--- espone i dati
	post event u_open( )
	
else
	post event close( )
end if


end event

type dw_exp_fatt from datawindow within w_profis_exp_fatt
event u_keydwn pbm_dwnkey
event u_keyenter pbm_dwnprocessenter
boolean visible = false
integer x = 27
integer y = 16
integer width = 1701
integer height = 752
integer taborder = 10
boolean bringtotop = true
string title = "Filtra dati in Elenco"
string dataobject = "d_profis_exp_fatt"
boolean border = false
end type

event buttonclicked;//

if dwo.name = "b_ok" and this.rowcount() > 0 then
	esporta_movimenti( )
else
	
	if dwo.name = "b_annulla" then
		if isvalid(kiuf_prof_exp) then kiuf_prof_exp.u_close_window_prof_exp_fatt( )
	else
		if dwo.name = "b_path_file" then
			set_path()
		end if
	end if
end if

end event

