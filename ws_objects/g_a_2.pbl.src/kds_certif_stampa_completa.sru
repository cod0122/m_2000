$PBExportHeader$kds_certif_stampa_completa.sru
forward
global type kds_certif_stampa_completa from uo_datastore_0
end type
end forward

global type kds_certif_stampa_completa from uo_datastore_0
string dataobject = "d_att_stampa_2016"
end type
global kds_certif_stampa_completa kds_certif_stampa_completa

type variables
//
datawindowchild kidwc_nested

end variables

forward prototypes
public function boolean u_compone_attestato (kds_certif_stampa ads_certif_stampa) throws uo_exception
public subroutine u_set_img () throws uo_exception
public function string u_get_nome_doc ()
end prototypes

public function boolean u_compone_attestato (kds_certif_stampa ads_certif_stampa) throws uo_exception;//---
//--- imposta il dw composite per la stampa: ATTESTATO + ALLEGATI
//--- 
//--- inp: kds_certif_stampa l'attestato da copiare nel documento
//--- out:
//--- rit: TRUE = ok impostato
//---
boolean k_return=false
integer k_rc
string k_rcx


this.Object.DataWindow.Print.Margin.Top = '400'
this.Object.DataWindow.Print.Margin.Bottom = '300'
this.Object.DataWindow.Print.Margin.Left = '400'
this.Object.DataWindow.Print.Margin.Right = '400'

if ads_certif_stampa.rowcount() > 0 then

//--- prepara il datastore composite di stampa
	k_rcx = this.Modify("dw_1.DataObject='" + trim(ads_certif_stampa.dataobject) + "' ")
	this.settransobject(kguo_sqlca_db_magazzino)
	
	this.retrieve(1, ads_certif_stampa.getitemnumber(1, "id_meca")) // retrieve delle pagine allegate con le info del Lotto
	this.getchild( "dw_1", kidwc_nested)
	if kidwc_nested.rowcount( ) > 0 then
		kidwc_nested.deleterow(1)
	end if
	k_rc = ads_certif_stampa.rowscopy(1,1,primary!,kidwc_nested,1,primary!) // copia l'attestato sul datastore composite da stampare

//--- Imposta immagini e risorse grafiche della stampa nel Report dw_1
	u_set_img( )
	
	this.Object.DataWindow.Print.DocumentName = u_get_nome_doc()
	
	k_return = true
end if

return k_return
end function

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





//--- 
//string k_path_risorse, k_rcx, k_path_risorse_OLD
//string k_file 
//string k_flg_img_bn, k_flg_mat_farmaceutico
//long k_rc, k_riga, k_riga_ds
//st_esito kst_esito
//uo_exception kuo1_exception
//
//
//
//try
//
//	kst_esito.esito = kkg_esito.ok
//	kst_esito.sqlcode = 0
//	kst_esito.SQLErrText = ""
//	kst_esito.nome_oggetto = kidwc_nested.classname()
//
//	k_rcx=kidwc_nested.Describe("k_flg_img_bn.tag")
//	if k_rcx <> "!" then
//		k_flg_img_bn = trim(kidwc_nested.getitemstring(1, "k_flg_img_bn"))   // becco se i logo devono essere fatti in biano e nero
//	else
//		k_flg_img_bn = "0"
//	end if
//	if trim(kidwc_nested.Describe("txt_p_img.text")) <> "!" and len(trim(kidwc_nested.Describe("txt_p_img.text"))) > 0 then
//		k_file = trim(kidwc_nested.Describe("txt_p_img.text")) 
//		if k_flg_img_bn = "1" then
//			k_file = mid(k_file, 1, len(k_file) - 4) + "_bn" + right(k_file, 4)
//		end if
//		k_path_risorse = kguo_path.get_risorse( ) + kkg.path_sep +  k_file 
//	else
//		k_path_risorse = kguo_path.get_risorse( ) + kkg.path_sep + "logo_orig_bn.bmp"  //solo x mantenere vecchia compatibilità
//	end if
//	k_rcx=kidwc_nested.Modify("p_img.Filename='" + k_path_risorse + "'")
//
//	if len(trim(kidwc_nested.Describe("txt_p_img_0.text"))) > 0 then
//		k_file = trim(kidwc_nested.Describe("txt_p_img_0.text")) 
//		if k_flg_img_bn = '1' then
//			k_file = mid(k_file, 1, len(k_file) - 4) + "_bn" + right(k_file, 4)
//		end if
//		k_path_risorse = kguo_path.get_risorse( ) + kkg.path_sep +  k_file 
//		k_rcx=kidwc_nested.Modify("p_img_0.Filename='" + k_path_risorse + "'")
//	end if
//	if len(trim(kidwc_nested.Describe("txt_p_img_1.text"))) > 0 then
//		k_file = trim(kidwc_nested.Describe("txt_p_img_1.text")) 
//		if k_flg_img_bn = '1' then
//			k_file = mid(k_file, 1, len(k_file) - 4) + "_bn" + right(k_file, 4)
//		end if
//		k_path_risorse = kguo_path.get_risorse( ) + kkg.path_sep +  k_file 
//		k_rcx=kidwc_nested.Modify("p_img_1.Filename='" + k_path_risorse + "'")
//	end if
//	if len(trim(kidwc_nested.Describe("txt_p_img_2.text"))) > 0 then
//		k_file = trim(kidwc_nested.Describe("txt_p_img_2.text")) 
//		if k_flg_img_bn = '1' then
//			k_file = mid(k_file, 1, len(k_file) - 4) + "_bn" + right(k_file, 4)
//		end if
//		k_path_risorse = kguo_path.get_risorse( ) + kkg.path_sep +  k_file 
//		k_rcx=kidwc_nested.Modify("p_img_2.Filename='" + k_path_risorse + "'")
//	end if
//	if len(trim(kidwc_nested.Describe("txt_p_img_4.text"))) > 0 then
//		k_file = trim(kidwc_nested.Describe("txt_p_img_4.text")) 
//		if k_flg_img_bn = '1' then
//			k_file = mid(k_file, 1, len(k_file) - 4) + "_bn" + right(k_file, 4)
//		end if
//		k_path_risorse = kguo_path.get_risorse( ) + kkg.path_sep +  k_file 
//		k_rcx=kidwc_nested.Modify("p_img_4.Filename='" + k_path_risorse + "'")
//	end if
//	if len(trim(kidwc_nested.Describe("txt_p_img_5.text"))) > 0 then
//		k_file = trim(kidwc_nested.Describe("txt_p_img_5.text")) 
//		if k_flg_img_bn = '1' then
//			k_file = mid(k_file, 1, len(k_file) - 4) + "_bn" + right(k_file, 4)
//		end if
//		k_path_risorse = kguo_path.get_risorse( ) + kkg.path_sep +  k_file 
//		k_rcx=kidwc_nested.Modify("p_img_5.Filename='" + k_path_risorse + "'")
//	end if
//
//
//catch(uo_exception kuo_exception)
//	throw kuo_exception
//
//finally
//	
//end try
//



end subroutine

public function string u_get_nome_doc ();//---
//--- Torna nome da dare al documento, es da esporre in stampa
//---
string k_return="attestato"
string k_rag_soc
kuf_utility kuf1_utility


if this.rowcount( ) > 0 then
	if not isvalid(kidwc_nested) then this.getchild( "dw_1", kidwc_nested)
	k_rag_soc = trim(kidwc_nested.getitemstring(1, "rag_soc_10_2"))
	kuf1_utility = create kuf_utility
	k_rag_soc = mid(kuf1_utility.u_stringa_compatta(k_rag_soc), 1, 8)
	destroy kuf1_utility
	
	k_return = "attestato_" + trim(string(kidwc_nested.getitemnumber(1, "certif_num_certif"))) + "_" + trim(k_rag_soc) 
end if

return k_return
end function

on kds_certif_stampa_completa.create
call super::create
end on

on kds_certif_stampa_completa.destroy
call super::destroy
end on

