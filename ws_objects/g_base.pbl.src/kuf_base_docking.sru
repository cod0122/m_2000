$PBExportHeader$kuf_base_docking.sru
forward
global type kuf_base_docking from nonvisualobject
end type
end forward

global type kuf_base_docking from nonvisualobject
end type
global kuf_base_docking kuf_base_docking

type variables
//--- Array per il Docking
private st_tab_base_docking kist_tab_base_docking[]

//--- Tipi di DOCKING STATE codificati in char 1
//WindowDockStateDocked! 
public constant string kki_WindowDockStateDocked = "D"
//WindowDockStateFloating! 
public constant string kki_WindowDockStateFloating = "F"
//WindowDockStateTabbedDocument! 
public constant string kki_WindowDockStateTabbedDocument = "T"
//WindowDockStateTabbedWindow! 
public constant string kki_WindowDockStateTabbedWindow = "W"

public boolean ki_m_abilitadockingpredefinito = false

end variables

forward prototypes
public function string get_dockingstate (string a_nome_window)
public function integer set_dockingstate (ref w_super aw_super)
public subroutine u_inizializza ()
public function boolean if_esiste (string a_wname) throws uo_exception
public function integer tb_update () throws uo_exception
public function integer tb_popola_st_tab_base_docking () throws uo_exception
public subroutine tb_delete () throws uo_exception
public subroutine u_reset () throws uo_exception
public subroutine u_set_dockingstate_window_opened ()
end prototypes

public function string get_dockingstate (string a_nome_window);//
//--- torna tipo e nome della window da aprire come docking
//--- st_w_docking.k_type = "" = nessuna window 
//
st_tab_base_docking kst_tab_base_docking
int k_ctr=1, k_w_ctr_w


kst_tab_base_docking.wstate = ""

k_w_ctr_w = upperbound(kist_tab_base_docking)
if a_nome_window > " " then
	a_nome_window = trim(a_nome_window)
else
	a_nome_window = ""
end if

for k_ctr = 1 to k_w_ctr_w

	if kist_tab_base_docking[k_ctr].wname = a_nome_window then
		kst_tab_base_docking.wstate = kist_tab_base_docking[k_ctr].wstate
		exit
	end if

next

return kst_tab_base_docking.wstate


end function

public function integer set_dockingstate (ref w_super aw_super);//
//--- Add/Update lo stato della window docking in array
//
st_tab_base_docking kst_tab_base_docking
int k_ctr=1, k_w_ctr_w
string k_nome_window

if isvalid(aw_super) then
	
	choose case aw_super.WindowDockState
		case WindowDockStateDocked!
			kst_tab_base_docking.wstate = kki_WindowDockStateDocked
		case WindowDockStateFloating!
			kst_tab_base_docking.wstate = kki_WindowDockStateFloating
		case WindowDockStateTabbedDocument!
			kst_tab_base_docking.wstate = kki_WindowDockStateTabbedDocument
		case WindowDockStateTabbedWindow!
			kst_tab_base_docking.wstate = kki_WindowDockStateTabbedWindow
		case else
			kst_tab_base_docking.wstate = ""
	end choose
	
	if kst_tab_base_docking.wstate > " " then
		k_w_ctr_w = upperbound(kist_tab_base_docking)
		
		k_nome_window = trim(aw_super.classname())
		
		for k_ctr = 1 to k_w_ctr_w
		
			if kist_tab_base_docking[k_ctr].wname = k_nome_window then
				kist_tab_base_docking[k_ctr].wstate = kst_tab_base_docking.wstate
				exit
			end if
		
		next
		
		//--- se non trovato lo aggiungo
		if k_ctr > k_w_ctr_w then
			kist_tab_base_docking[k_ctr].id_base = kguo_g.id_base
			kist_tab_base_docking[k_ctr].id_utente = kguo_utente.get_id_utente( )
			kist_tab_base_docking[k_ctr].wname = k_nome_window
			kist_tab_base_docking[k_ctr].wstate = kst_tab_base_docking.wstate
		end if
	end if
end if
	
return k_ctr


end function

public subroutine u_inizializza ();//
//--- resetta la tabella array 
//
st_tab_base_docking kst_tab_base_docking[]


kist_tab_base_docking[] = kst_tab_base_docking 


end subroutine

public function boolean if_esiste (string a_wname) throws uo_exception;//
//--- Torna a TRUE se rec trovato su tabella
//
boolean k_return=false
st_tab_base_docking kst_tab_base_docking
int k_rcn
string k_nome_window
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


kst_tab_base_docking.id_base = kguo_g.id_base
kst_tab_base_docking.id_utente = kguo_utente.get_id_utente( )
kst_tab_base_docking.wname = trim(a_wname)

select 1
	into :k_rcn
			from base_docking
			WHERE base_docking.id_base = :kst_tab_base_docking.id_base 
			        and base_docking.id_utente = :kst_tab_base_docking.id_utente
			        and base_docking.wname = :kst_tab_base_docking.wname
			using sqlca;
			
if k_rcn = 1 then
	k_return = true
end if

return k_return


end function

public function integer tb_update () throws uo_exception;//
//--- Aggiorna su tabella leggendo dall'array delle window docking 
//
st_tab_base_docking kst_tab_base_docking
int k_ctr=1, k_w_ctr_w, k_rec_aggiornati
//string k_nome_window
st_esito kst_esito


try
	k_w_ctr_w = upperbound(kist_tab_base_docking)

	for k_ctr = 1 to k_w_ctr_w
	
		if kist_tab_base_docking[k_ctr].wname > " " and kst_tab_base_docking.id_utente > 0 then
			
			kst_tab_base_docking.id_base = kist_tab_base_docking[k_ctr].id_base
			kst_tab_base_docking.id_utente = kist_tab_base_docking[k_ctr].id_utente
			kst_tab_base_docking.wname = trim(kist_tab_base_docking[k_ctr].wname)
			kst_tab_base_docking.wstate = kist_tab_base_docking[k_ctr].wstate
			
			if if_esiste(kst_tab_base_docking.wname) then
				
				UPDATE base_docking
					set wname = :kst_tab_base_docking.wname,   
						wstate = :kst_tab_base_docking.wstate
					WHERE id_base = :kst_tab_base_docking.id_base 
				     and id_utente = :kst_tab_base_docking.id_utente
					using kguo_sqlca_db_magazzino ;
				
			else
				
				INSERT INTO base_docking
							( id_base
							,id_utente
							,wname
							,wstate)
						values
							(:kst_tab_base_docking.id_base
							,:kst_tab_base_docking.id_utente
							,:kst_tab_base_docking.wname
							,:kst_tab_base_docking.wstate)
					using kguo_sqlca_db_magazzino;
				
			end if
			if kguo_sqlca_db_magazzino.sqlcode <> 0 then
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Errore in aggiornamento proprietà 'doking-window' (base_docking):" + trim(kguo_sqlca_db_magazzino.SQLErrText)
				if sqlca.sqlcode >= 0 then
				else
					kst_esito.esito = kkg_esito.db_ko
					kguo_sqlca_db_magazzino.db_rollback( )
					kguo_exception.inizializza( )
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
				end if
			else
				k_rec_aggiornati ++

				if kst_tab_base_docking.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_base_docking.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_commit( )
				end if
			end if
		end if
	
	next
	

catch(uo_exception kuo_exception)
	throw kuo_exception

finally
	
end try

return k_rec_aggiornati


end function

public function integer tb_popola_st_tab_base_docking () throws uo_exception;//
//--- Popola l'array delle window docking leggendo da tabella 
//
st_tab_base_docking kst_tab_base_docking[]
datastore kds_1
int k_ctr=1, k_w_ctr_w, k_rec_caricati
st_esito kst_esito


try
	kist_tab_base_docking = kst_tab_base_docking

	kst_tab_base_docking[1].id_base = kguo_g.id_base
	kst_tab_base_docking[1].id_utente = kguo_utente.get_id_utente( )

	kds_1 = create datastore
	kds_1.dataobject = "ds_base_docking_l"
	kds_1.settransobject(kguo_sqlca_db_magazzino)
	k_w_ctr_w = kds_1.retrieve(kst_tab_base_docking[1].id_base, kst_tab_base_docking[1].id_utente)

	for k_ctr = 1 to k_w_ctr_w
		kst_tab_base_docking[k_ctr].wname = trim(kds_1.getitemstring(k_ctr, "wname"))
	
		if kst_tab_base_docking[k_ctr].wname > " " then
			k_rec_caricati++
			kist_tab_base_docking[k_rec_caricati].id_base = trim(kst_tab_base_docking[k_ctr].id_base)
			kist_tab_base_docking[k_rec_caricati].id_utente = kst_tab_base_docking[k_ctr].id_utente
			kist_tab_base_docking[k_rec_caricati].wname = trim(kst_tab_base_docking[k_ctr].wname)
			kist_tab_base_docking[k_rec_caricati].wstate = trim(kds_1.getitemstring(k_ctr, "wname"))
		end if
	
	next
	

catch(uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kds_1) then destroy kds_1
	
end try

return k_rec_caricati


end function

public subroutine tb_delete () throws uo_exception;//
//--- Rimuove su tabella le window docking 
//
st_tab_base_docking kst_tab_base_docking
st_esito kst_esito


try
	
	kst_tab_base_docking.id_base = kguo_g.id_base
	kst_tab_base_docking.id_utente = kguo_utente.get_id_utente( )
	delete from base_docking
			WHERE id_base = :kst_tab_base_docking.id_base 
			     and id_utente = :kst_tab_base_docking.id_utente
			using kguo_sqlca_db_magazzino ;
				
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in rimozione dati proprietà 'docking-window' (base_docking):" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if sqlca.sqlcode >= 0 then
		else
			kst_esito.esito = kkg_esito.db_ko
			kguo_sqlca_db_magazzino.db_rollback( )
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	else
		if kst_tab_base_docking.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_base_docking.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	end if

catch(uo_exception kuo_exception)
	throw kuo_exception

finally
	
end try



end subroutine

public subroutine u_reset () throws uo_exception;//
//--- Rimuove sia la tabella che l'array 
//
try
	u_inizializza()
	tb_delete()

catch (uo_exception kuo_exception)
	throw kuo_exception
end try
end subroutine

public subroutine u_set_dockingstate_window_opened ();//---
//--- Imposta lo state del doscking per tutte le window aperte
//---
w_super kw_all[]
int k_ctr, k_ind


if isvalid(kguo_g) then
	if kguo_g.window_aperte_get_all(kw_all) then
		k_ctr = upperbound(kw_all[])
		for k_ind = 1 to k_ctr
			set_dockingstate(kw_all[k_ind])
		next
	end if
end if

end subroutine

on kuf_base_docking.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_base_docking.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

