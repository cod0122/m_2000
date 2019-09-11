$PBExportHeader$kds_certif_stampa.sru
forward
global type kds_certif_stampa from uo_datastore_0
end type
end forward

global type kds_certif_stampa from uo_datastore_0
string dataobject = "d_att_stampa_ed1b01_2013"
end type
global kds_certif_stampa kds_certif_stampa

type variables
//
private string ki_att_stampa_default = "d_certif_stampa_2008_6" 
private string ki_att_stampa_gold = "d_att_stampa_ed7_07_2018" //"d_att_stampa_ed6_05_2016" //"d_att_stampa_ed5_09_2015" //"d_att_stampa_ed4_01_2013" // "d_att_stampa_ed3_03_2012" //"d_att_stampa_ed9_05_2011" //"d_att_stampa_ed8_04_2010" //"d_att_stampa_ed7_08_2009"
private string ki_att_stampa_silver = "d_att_stampa_ed4b07_2018" //"d_att_stampa_ed3b05_2016" //"d_att_stampa_ed2b09_2015" //"d_att_stampa_ed1b01_2013" //"d_att_stampa_ed0b03_2012" //"d_att_stampa_ed9b05_2011" //"d_att_stampa_ed8b04_2010" //"d_att_stampa_ed7_08_2009"
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
public subroutine u_set_attestato_dw (string a_nome)
public subroutine u_set_img () throws uo_exception
public subroutine u_set_test (boolean a_flag_stampa_di_test)
public function string u_get_nome_doc ()
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
//--- imposta il dataobject corretto datawindow dell'attestato (Gold/Silver)
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
	if kst_tab_certif.data_stampa > kkg.data_zero then				
		ki_flag_ristampa=true
	end if
	if trim(kst_tab_certif.form_di_stampa) > " " then  // se il nome del form non e' impostato metto quello vecchio
		if ki_flag_ristampa then
			this.dataobject = trim(kst_tab_certif.form_di_stampa)   //--- SONO IN RISTAMPA piglio il vecchio form
		end if
	end if

	k_return=true

//--- cerca il nuovo form 
	if trim(this.dataobject) > " " then
	else

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

	if trim(this.dataobject) > " "  then 
		this.settransobject(sqlca)
	end if

	this.Object.DataWindow.Print.Margin.Top = '400'
	this.Object.DataWindow.Print.Margin.Bottom = '300'
	this.Object.DataWindow.Print.Margin.Left = '500'
	this.Object.DataWindow.Print.Margin.Right = '500'


catch (uo_exception kuo_exception)
	throw kuo_exception 
	
finally
	if isvalid(kuf1_certif) then destroy kuf1_certif
	if isvalid(kuf1_armo) then destroy kuf1_armo
	if isvalid(kuf1_artr) then destroy kuf1_artr
	if isvalid(kuf1_wm_pklist) then destroy kuf1_wm_pklist

end try 

return k_return

end function

public subroutine u_set_attestato_dw (string a_nome);//--- 
//--- Imposta il nome del dataobject dell'attestato da stampare
//---

this.Modify("dw_1.DataObject='" + trim(a_nome) + "' ")
this.settransobject(kguo_sqlca_db_magazzino)

end subroutine

public subroutine u_set_img () throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------
//--- Preparazione alla Stampa Attestato di Trattamento
//--- 
//--- Inut: datastore gia' popolato
//--- out: imposta i nomi delle immagini da stampare
//--- Rit: nulla
//--- 
//------------------------------------------------------------------------------------------------------------------
//
//--- 
string k_path_risorse, k_rcx, k_path_risorse_OLD
string k_file 
string k_flg_img_bn, k_flg_mat_farmaceutico
long k_rc, k_riga, k_riga_ds
st_esito kst_esito
uo_exception kuo1_exception



try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	k_rcx=this.Describe("k_flg_img_bn.tag")
	if k_rcx <> "!" then
		k_flg_img_bn = trim(this.getitemstring(1, "k_flg_img_bn"))   // becco se i logo devono essere fatti in biano e nero
	else
		k_flg_img_bn = "0"
	end if
//	if trim(this.Describe("txt_p_img.text")) <> "!" and len(trim(this.Describe("txt_p_img.text"))) > 0 then
	k_rcx=trim(this.Describe("txt_p_img.text"))
	if k_rcx <> "!" and k_rcx > " " then
		k_file = trim(this.Describe("txt_p_img.text")) 
		if k_flg_img_bn = "1" then
			k_file = mid(k_file, 1, len(k_file) - 4) + "_bn" + right(k_file, 4)
		end if
		k_path_risorse = kguo_path.get_risorse( ) + kkg.path_sep +  k_file 
		k_rcx=this.Modify("p_img.Filename='" + k_path_risorse + "'")
//	else
//		k_path_risorse = kguo_path.get_risorse( ) + kkg.path_sep + "logo_orig_bn.bmp"  //solo x mantenere vecchia compatibilità
	end if
	//k_rcx=this.Modify("p_img.Filename='" + k_path_risorse + "'")

	//if len(trim(this.Describe("txt_p_img_0.text"))) > 0 then
	k_rcx=trim(this.Describe("txt_p_img_0.text"))
	if k_rcx <> "!" and k_rcx > " " then
		k_file = trim(this.Describe("txt_p_img_0.text")) 
		if k_flg_img_bn = '1' then
			k_file = mid(k_file, 1, len(k_file) - 4) + "_bn" + right(k_file, 4)
		end if
		k_path_risorse = kguo_path.get_risorse( ) + kkg.path_sep +  k_file 
		k_rcx=this.Modify("p_img_0.Filename='" + k_path_risorse + "'")
	end if

//	if len(trim(this.Describe("txt_p_img_1.text"))) > 0 then
	k_rcx=trim(this.Describe("txt_p_img_1.text"))
	if k_rcx <> "!" and k_rcx > " " then
		k_file = trim(this.Describe("txt_p_img_1.text")) 
		if k_flg_img_bn = '1' then
			k_file = mid(k_file, 1, len(k_file) - 4) + "_bn" + right(k_file, 4)
		end if
		k_path_risorse = kguo_path.get_risorse( ) + kkg.path_sep +  k_file 
		k_rcx=this.Modify("p_img_1.Filename='" + k_path_risorse + "'")
	end if

//	if len(trim(this.Describe("txt_p_img_2.text"))) > 0 then
	k_rcx=trim(this.Describe("txt_p_img_2.text"))
	if k_rcx <> "!" and k_rcx > " " then
		k_file = trim(this.Describe("txt_p_img_2.text")) 
		if k_flg_img_bn = '1' then
			k_file = mid(k_file, 1, len(k_file) - 4) + "_bn" + right(k_file, 4)
		end if
		k_path_risorse = kguo_path.get_risorse( ) + kkg.path_sep +  k_file 
		k_rcx=this.Modify("p_img_2.Filename='" + k_path_risorse + "'")
	end if

//	if len(trim(this.Describe("txt_p_img_4.text"))) > 0 then
	k_rcx=trim(this.Describe("txt_p_img_4.text"))
	if k_rcx <> "!" and k_rcx > " " then
		k_file = trim(this.Describe("txt_p_img_4.text")) 
		if k_flg_img_bn = '1' then
			k_file = mid(k_file, 1, len(k_file) - 4) + "_bn" + right(k_file, 4)
		end if
		k_path_risorse = kguo_path.get_risorse( ) + kkg.path_sep +  k_file 
		k_rcx=this.Modify("p_img_4.Filename='" + k_path_risorse + "'")
	end if

	//if len(trim(this.Describe("txt_p_img_5.text"))) > 0 then
	k_rcx=trim(this.Describe("txt_p_img_5.text"))
	if k_rcx <> "!" and k_rcx > " " then
		k_file = trim(this.Describe("txt_p_img_5.text")) 
		if k_flg_img_bn = '1' then
			k_file = mid(k_file, 1, len(k_file) - 4) + "_bn" + right(k_file, 4)
		end if
		k_path_risorse = kguo_path.get_risorse( ) + kkg.path_sep +  k_file 
		k_rcx=this.Modify("p_img_5.Filename='" + k_path_risorse + "'")
	end if

//---- VECCHIA GESTIONE DI ESPOSIZIONE FIRMA MECCANOGRAFICA
////---- gestione particolare per la firma 'meccanografica' e Materiale Farmaceutico -----------------------------------------------------------------
//	k_flg_mat_farmaceutico = trim(this.getitemstring(1, "k_mat_farmaceutico"))   // becco il tipo di materiale
//	if trim(this.Describe("txt_p_img_3.text")) <> "!" and len(trim(this.Describe("txt_p_img_3.text"))) > 0 then  // FIRMA!!
//		k_rcx=this.Modify("p_img_3.visible='0'") 
////--- controllo se materiale farmaceutico
//		if k_flg_mat_farmaceutico = "1" then //se mat farmaceutico 
//			this.modify("txt_p_img_3.text = 'firma_direttore_tecnico.gif' ")   
//		end if
//		if len(trim(this.Describe("txt_p_img_3.text"))) > 0 then
//			k_path_risorse = kguo_path.get_risorse( ) + kkg.path_sep + trim(this.Describe("txt_p_img_3.text"))   
//			k_rcx=this.Modify("p_img_3.Filename='" + k_path_risorse + "'")
//		end if
//		if k_flg_img_bn = "1" then
//			k_rcx=this.Modify("p_img_3.visible='0'") 
//		else
//			k_rcx=this.Modify("p_img_3.visible='1'") 
//		end if
//		
//	else
//		
////--- solo x mantenere vecchia compatibilità -----------------------------------------------------------------------------------------------------------
//			
////--- controllo se materiale farmaceutico
//		if k_flg_mat_farmaceutico = "1" then //se mat farmaceutico 
//			k_path_risorse_OLD = kguo_path.get_risorse( ) + kkg.path_sep + "firma_direttore_tecnico.gif"   //solo x mantenere vecchia compatibilità
//		else
//			k_path_risorse_OLD = kguo_path.get_risorse( ) + kkg.path_sep + "firma_direttore_stabilimento.bmp"   //solo x mantenere vecchia compatibilità
//		end if
//		k_rcx=this.Modify("p_firma.visible='0'")  //solo x mantenere vecchia compatibilità
//		k_rcx=this.Modify("p_firma.Filename='" + k_path_risorse_OLD + "'") //solo x mantenere vecchia compatibilità
//		k_rcx=this.Modify("p_firma.visible='1'") //solo x mantenere vecchia compatibilità
//		
//	end if



catch(uo_exception kuo_exception)
	throw kuo_exception

finally
	
end try




end subroutine

public subroutine u_set_test (boolean a_flag_stampa_di_test);//
//--- imposta il flag di TEST sul modulo 
//
	if a_flag_stampa_di_test then
		this.object.k_test[1] = '1'
	else
		this.object.k_test[1] = '0'
	end if 

end subroutine

public function string u_get_nome_doc ();//---
//--- Torna nome da dare al documento, es da esporre in stampa
//---
string k_return="attestato"
string k_rag_soc
kuf_utility kuf1_utility

if this.rowcount( ) > 0 then
	k_rag_soc = trim(this.getitemstring(1, "rag_soc_10_2"))
	kuf1_utility = create kuf_utility
	k_rag_soc = mid(kuf1_utility.u_stringa_compatta(k_rag_soc), 1, 8)
	destroy kuf1_utility
	
	k_return = "attestato_" + trim(string(this.object.certif_num_certif[1])) + "_" + trim(k_rag_soc) 
end if

return k_return
end function

on kds_certif_stampa.create
call super::create
end on

on kds_certif_stampa.destroy
call super::destroy
end on

