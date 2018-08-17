$PBExportHeader$uo_armo_riga.sru
forward
global type uo_armo_riga from uo_d_std_1
end type
end forward

global type uo_armo_riga from uo_d_std_1
string dataobject = "d_armo_riga"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = false
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_d_std_1_attiva_cerca = false
event u_resize ( boolean a_visible )
event u_resize_false ( )
event u_set_m_cubi ( )
event u_visualizza ( )
event u_posiziona ( )
event u_modifica ( )
event type integer u_aggiorna ( long a_riga )
end type
global uo_armo_riga uo_armo_riga

type variables
//
kuf_listino kiuf_listino
kuf_sl_pt kiuf_sl_pt
private uo_d_std_1 ki_this

end variables
forward prototypes
private subroutine u_dw_riga_ricalcolo_1 (ref st_tab_armo ast_tab_armo, ref st_tab_listino ast_tab_listino)
private subroutine u_dw_riga_ricalcolo (ref st_tab_armo ast_tab_armo)
public subroutine u_video_sl_pt_misure (st_tab_sl_pt kst_tab_sl_pt)
end prototypes

event u_resize(boolean a_visible);//
//--- da riempire
end event

event u_resize_false();//


	this.event u_resize(false)
	

	
end event

event u_set_m_cubi();//======================================================================
//=== 
//======================================================================
//
long k_riga=0, k_riga1=0, k_progressivo
st_tab_armo kst_tab_armo 
st_tab_listino kst_tab_listino


try
	
	kst_tab_armo.id_listino = this.getitemnumber(1, "id_listino" )
	if kst_tab_armo.id_listino > 0 then		

		kst_tab_armo.colli_2 = this.getitemnumber(1, "colli_2" )
		kst_tab_listino.id = kst_tab_armo.id_listino
		if not isvalid(kiuf_listino) then kiuf_listino = create kuf_listino
		kiuf_listino.get_dati_x_armo(kst_tab_listino)   // get dati da listino

		u_dw_riga_ricalcolo_1(kst_tab_armo, kst_tab_listino) // calcola

		//this.setitem( 1, "listino_occup_ped", kst_tab_listino.occup_ped )
		this.setitem( 1, "peso_kg", kst_tab_armo.peso_kg)
		//this.setitem( 1, "m_cubi", kst_tab_armo.m_cubi)

	end if
		
	if kst_tab_armo.m_cubi = 0 then
		kst_tab_armo.larg_2 = this.getitemnumber(1, "larg_2")
		kst_tab_armo.lung_2 = this.getitemnumber(1, "lung_2")
		kst_tab_armo.alt_2 = this.getitemnumber(1, "alt_2")
		kst_tab_armo.m_cubi = (kst_tab_armo.larg_2/1000 *  kst_tab_armo.lung_2/1000 *  kst_tab_armo.alt_2/1000)
		this.setitem( 1, "m_cubi", kst_tab_armo.m_cubi)
	end if
	
	if isnull(kst_tab_armo.m_cubi) then kst_tab_armo.m_cubi = 0.00 

	this.setitem( 1, "m_cubi", kst_tab_armo.m_cubi)
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try


	
end event

event u_visualizza();//======================================================================
//=== 
//======================================================================
//
kuf_utility kuf1_utility


	setredraw(false)

	kuf1_utility = create kuf_utility
	this.object.b_ok.visible = false 
	this.object.b_esci.visible = true 
     kuf1_utility.u_proteggi_dw("1", 0, ki_this )
	this.event u_resize(true)
	destroy kuf1_utility

	setredraw(true)


end event

event u_posiziona();//
//--- posizione
//
//--- DA RIEMPIRE
//


end event

event u_modifica();//======================================================================
//=== 
//======================================================================
//
// DA RIEMPIRE

	
end event

event type integer u_aggiorna(long a_riga);//======================================================================
//=== 
//======================================================================
//

// DA RIEMPIRE

return 0




end event

private subroutine u_dw_riga_ricalcolo_1 (ref st_tab_armo ast_tab_armo, ref st_tab_listino ast_tab_listino);//--
//---  Ricalcolo dei campi in base al numero colli indicato in INPUT
//---

	
	if ast_tab_armo.colli_2 > 0 then
		if ast_tab_listino.occup_ped > 0 then
			ast_tab_armo.pedane = ast_tab_armo.colli_2 * ast_tab_listino.occup_ped / 100
		else
			ast_tab_armo.pedane = 0
		end if
		if ast_tab_listino.peso_kg > 0 then
			ast_tab_armo.peso_kg = ast_tab_armo.colli_2 * ast_tab_listino.peso_kg
		else
			ast_tab_armo.peso_kg = 0
		end if

		if ast_tab_listino.m_cubi_f > 0 then
		else
			ast_tab_listino.m_cubi_f = (ast_tab_listino.mis_x/1000 * ast_tab_listino.mis_y/1000 * ast_tab_listino.mis_z/1000)
		end if
		if ast_tab_listino.m_cubi_f > 0 then
			ast_tab_armo.m_cubi = ast_tab_armo.colli_2 * ast_tab_listino.m_cubi_f
		else
			ast_tab_armo.m_cubi = 0
		end if
	else
		ast_tab_listino.occup_ped = 0
		ast_tab_listino.peso_kg = 0
		ast_tab_armo.m_cubi = 0
	end if
	




end subroutine

private subroutine u_dw_riga_ricalcolo (ref st_tab_armo ast_tab_armo);//--
//---  Ricalcolo dei campi in base al numero colli indicato in INPUT
//---
st_tab_listino kst_tab_listino

try
	if ast_tab_armo.colli_2 > 0 then

		kst_tab_listino.occup_ped = this.getitemnumber(1, "listino_occup_ped")
		kst_tab_listino.peso_kg = this.getitemnumber(1, "listino_peso_kg")
		kst_tab_listino.m_cubi_f = this.getitemnumber(1, "listino_m_cubi")
		u_dw_riga_ricalcolo_1(ast_tab_armo, kst_tab_listino)

		if ast_tab_armo.pedane > 0 then
		else
			ast_tab_armo.pedane = this.getitemnumber(1, "pedane")
		end if
		if ast_tab_armo.peso_kg > 0 then
		else
			ast_tab_armo.peso_kg = this.getitemnumber(1, "peso_kg")
		end if
		if ast_tab_armo.m_cubi > 0 then
		else
			ast_tab_armo.m_cubi = this.getitemnumber(1, "m_cubi")
		end if
		
	else
		kst_tab_listino.occup_ped = 0
		kst_tab_listino.peso_kg = 0
		ast_tab_armo.m_cubi = 0
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try




end subroutine

public subroutine u_video_sl_pt_misure (st_tab_sl_pt kst_tab_sl_pt);//
//--- Mette in mappa i dati x/y/z + dose
//
double k_m_cubi = 0.00

	if kst_tab_sl_pt.mis_x > 0 then
		this.setitem(1, "larg_2", kst_tab_sl_pt.mis_z)
		this.setitem(1, "lung_2", kst_tab_sl_pt.mis_x)
		this.setitem(1, "alt_2", kst_tab_sl_pt.mis_y)
		k_m_cubi = (kst_tab_sl_pt.mis_x/1000 *  kst_tab_sl_pt.mis_y/1000 *  kst_tab_sl_pt.mis_z/1000)
		this.setitem( 1, "m_cubi", k_m_cubi)
	end if

	if kst_tab_sl_pt.dose > 0 then
		this.setitem(1, "dose", kst_tab_sl_pt.dose)
	end if
	
	
end subroutine

on uo_armo_riga.create
call super::create
end on

on uo_armo_riga.destroy
call super::destroy
end on

event constructor;call super::constructor;//
ki_this = this

end event

event u_constructor;call super::u_constructor;//
post event u_posiziona()

end event

event itemfocuschanged;call super::itemfocuschanged;//
//DA RIEMPIRE 
	
end event

event itemchanged;call super::itemchanged;//
string  k_sl_pt
long k_rc, k_riga=0
st_tab_sl_pt kst_tab_sl_pt
datawindowchild kdwc_x
st_tab_armo kst_tab_armo

	choose case dwo.name 

		case "m_cubi"
			this.modify( "m_cubi.Background.Color = '" + string(kkg_colore.bianco ) + "' ") 
			

		case "colli_2"
			this.modify( dwo.name + ".Background.Color = '" + string(kkg_colore.bianco ) + "' ") 
			this.modify( "pedane.Background.Color = '" + string(kkg_colore.bianco ) + "' ") 
			kst_tab_armo.colli_2 = integer(data)
			if kst_tab_armo.colli_2 = 0 then
				this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
				messagebox ("Verifica dati fallita", "Attenzione non è possibile caricare ZERO colli, prego verificare", StopSign!)
				return 1
			end if
			u_dw_riga_ricalcolo(kst_tab_armo)
			this.setitem(row, "pedane", kst_tab_armo.pedane)
			this.setitem(row, "peso_kg", kst_tab_armo.peso_kg)
			this.setitem(row, "m_cubi", kst_tab_armo.m_cubi)
//			if kst_tab_armo.colli_2 <> this.getitemnumber(row, "pedane") then
//				this.modify("pedane.Background.Color = '" + string(KKG_COLORE.BLU_CHIARO ) + "' ") 
//			end if
			
		case "pedane"
			this.modify( dwo.name + ".Background.Color = '" + string(kkg_colore.bianco ) + "' ") 
			if double(data) = 0 then
				this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
				if messagebox ("Verifica dati anomala", "Attenzione sono stati indicati ZERO pedane, proseguire?", Question!, YesNo!, 2 ) = 2 then
					return 1
				end if
			else
				if double(data) <> this.getitemnumber(row, "colli_2") then
					this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.BLU_CHIARO) + "' ") 
				end if
			end if
			
			
		case "cod_sl_pt" 
	
			k_sl_pt = upper(trim(data))
			this.modify("cod_sl_pt.background = " + string( kkg_colore.bianco ))
			if isnull(k_sl_pt) = false and LenA(trim(k_sl_pt)) > 0 then
				
				k_rc = this.getchild("cod_sl_pt", kdwc_x)
				k_rc = kdwc_x.find("cod_sl_pt =~""+(k_sl_pt)+"~"",0,kdwc_x.rowcount())
				k_riga = k_rc
				if k_riga <= 0 or isnull(k_riga) then
					try
						kst_tab_sl_pt.cod_sl_pt = k_sl_pt
						if not isvalid(kiuf_sl_pt) then destroy kiuf_sl_pt
						kiuf_sl_pt.get_misure(kst_tab_sl_pt)  // legge le misure dalla tabella
						post u_video_sl_pt_misure(kst_tab_sl_pt)
					catch (uo_exception kuo_exception)
						return 2
						this.modify("cod_sl_pt.background = " + string( kkg_colore.err_dato ))
					end try
				else
					kst_tab_sl_pt.mis_x =  kdwc_x.getitemnumber( k_riga, "mis_x")
					kst_tab_sl_pt.mis_y =  kdwc_x.getitemnumber( k_riga, "mis_y")
					kst_tab_sl_pt.mis_z =  kdwc_x.getitemnumber( k_riga, "mis_z")
					kst_tab_sl_pt.dose =  kdwc_x.getitemnumber( k_riga, "dose")
					post u_video_sl_pt_misure(kst_tab_sl_pt)
				end if
				
			end if

				
	end choose

end event

event clicked;call super::clicked;//
//=== Premuto pulsante nella DW
//
//
// DA RIEMPIRE
end event

