$PBExportHeader$uo_d_certif_stampa.sru
forward
global type uo_d_certif_stampa from uo_d_std_1
end type
end forward

global type uo_d_certif_stampa from uo_d_std_1
integer width = 3515
integer height = 1868
string title = "Certificato di Trattamento"
string dataobject = "d_att_stampa_ed1b01_2013"
end type
global uo_d_certif_stampa uo_d_certif_stampa

type variables
//
private string ki_att_stampa_default = "d_certif_stampa_2008_6" 
private string ki_att_stampa_gold = "d_att_stampa_ed6_05_2016" //"d_att_stampa_ed5_09_2015" //"d_att_stampa_ed4_01_2013" // "d_att_stampa_ed3_03_2012" //"d_att_stampa_ed9_05_2011" //"d_att_stampa_ed8_04_2010" //"d_att_stampa_ed7_08_2009"
private string ki_att_stampa_silver = "d_att_stampa_ed3b05_2016" //"d_att_stampa_ed2b09_2015" //"d_att_stampa_ed1b01_2013" //"d_att_stampa_ed0b03_2012" //"d_att_stampa_ed9b05_2011" //"d_att_stampa_ed8b04_2010" //"d_att_stampa_ed7_08_2009"
public boolean ki_flag_ristampa=false

private boolean ki_stampa_bianco_nero=false
private boolean ki_mat_farmaceutico=false
end variables

forward prototypes
public subroutine set_mat_farmaceutico ()
public subroutine set_stampa_bianco_nero ()
public function boolean if_stampa_bianco_nero ()
public function boolean if_mat_farmaceutico ()
public function boolean set_attestato (st_tab_certif kst_tab_certif) throws uo_exception
end prototypes

public subroutine set_mat_farmaceutico ();//---
//--- Indica se il Materiale e' di tipo farmaceutico, poiche' cambia la stampa dell'attestato
//---
ki_mat_farmaceutico = true


end subroutine

public subroutine set_stampa_bianco_nero ();//---
//--- Toglie originalità alla stampa
//---
ki_stampa_bianco_nero = true


end subroutine

public function boolean if_stampa_bianco_nero ();//---
//--- Torna se la stampa è da fare in BIANCO e NERO
//---
return ki_stampa_bianco_nero 


end function

public function boolean if_mat_farmaceutico ();//---
//--- Torna se la stampa è da fare in BIANCO e NERO
//---
return ki_mat_farmaceutico

end function

public function boolean set_attestato (st_tab_certif kst_tab_certif) throws uo_exception;//---
//--- imposta il corretto datawindow dell'attestato (Gold/Silver)
//--- 
//--- inp: st_tab_certif.num_certif, id_meca facoltatvo
//--- out:
//--- rit.: true = ok impostato
//---
boolean k_return=false
st_esito kst_esito
st_tab_meca kst_tab_meca
st_tab_armo kst_tab_armo
st_tab_artr kst_tab_artr
st_wm_pklist kst_wm_pklist
kuf_artr kuf1_artr
kuf_certif kuf1_certif
kuf_armo kuf1_armo
kuf_wm_pklist kuf1_wm_pklist


try 
	
	this.dataobject = ""
	ki_flag_ristampa=false
	
	kuf1_certif = create kuf_certif
	kuf1_armo = create kuf_armo
	kuf1_artr = create kuf_artr
	kuf1_wm_pklist = create kuf_wm_pklist

//--- Sono in RISTAMPA? 
	kuf1_certif.get_form_di_stampa(kst_tab_certif)
	if kst_tab_certif.data_stampa > kkg.data_zero and len(trim(kst_tab_certif.form_di_stampa)) > 0 then				
		ki_flag_ristampa=true
		if len(trim(kst_tab_certif.form_di_stampa)) > 0 then  // se il nome del form non e' impostato metto quello vecchio
			this.dataobject = trim(kst_tab_certif.form_di_stampa)   //--- SONO IN RISTAMPA piglio il vecchio form
		else
			this.dataobject = trim(ki_att_stampa_default)
		end if
		k_return=true
	end if	

//--- cerca il nuovo form 
	if this.dataobject = "" then 

		k_return=true

		this.dataobject = trim(ki_att_stampa_silver)
	
		if isnull(kst_tab_certif.id_meca) or kst_tab_certif.id_meca = 0 then 
			kst_tab_artr.num_certif = kst_tab_certif.num_certif
//			kst_tab_certif.id_meca = kuf1_artr.get_id_meca_da_num_certif(kst_tab_artr)
			kst_tab_armo.id_armo = kuf1_artr.get_id_armo_da_num_certif(kst_tab_artr)
			if kst_tab_armo.id_armo > 0 then
				kst_esito = kuf1_armo.get_id_meca_da_id_armo(kst_tab_armo)
				if kst_esito.esito = kkg_esito.db_ko then
					kguo_exception.inizializza( )
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
				end if
				kst_tab_certif.id_meca = kst_tab_armo.id_meca  
				if isnull(kst_tab_certif.id_meca)  then
					kst_tab_certif.id_meca = 0
				end if
			end if
		end if
		
		if kst_tab_certif.id_meca > 0 then
		
//--- c'e' un packing associato?		
			kst_tab_meca.id = kst_tab_certif.id_meca
			kuf1_armo.get_id_wm_pklist(kst_tab_meca)
			if kst_tab_meca.id_wm_pklist > 0 then
			
//--- se PKL di tipo CLIENTE quindi non fittizia allora stmpa il GOLD			
				kst_wm_pklist.st_tab_wm_pklist.id_wm_pklist = kst_tab_meca.id_wm_pklist
				if kuf1_wm_pklist.if_tipo_cliente(kst_wm_pklist) then
					
					this.dataobject = trim(ki_att_stampa_gold)			// stampa il GOLD!!!
				
				end if
			end if
		end if
	end if

	if this.dataobject <> ""  then 
		this.settransobject(sqlca)
	end if

catch (uo_exception kuo_exception)
	k_return=false
	throw kuo_exception 
	
finally
	if isvalid(kuf1_certif) then destroy kuf1_certif
	if isvalid(kuf1_armo) then destroy kuf1_armo
	if isvalid(kuf1_artr) then destroy kuf1_artr
	if isvalid(kuf1_wm_pklist) then destroy kuf1_wm_pklist

end try 

return k_return

end function

on uo_d_certif_stampa.create
call super::create
end on

on uo_d_certif_stampa.destroy
call super::destroy
end on

