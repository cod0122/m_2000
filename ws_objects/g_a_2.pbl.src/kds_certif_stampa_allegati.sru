$PBExportHeader$kds_certif_stampa_allegati.sru
forward
global type kds_certif_stampa_allegati from uo_datastore_0
end type
end forward

global type kds_certif_stampa_allegati from uo_datastore_0
string dataobject = "d_meca_1"
end type
global kds_certif_stampa_allegati kds_certif_stampa_allegati

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
public function boolean u_set_stampa () throws uo_exception
public function long u_retrieve (st_tab_certif ast_tab_certif) throws uo_exception
public function string u_get_nome_doc ()
end prototypes

public function boolean u_set_stampa () throws uo_exception;//---
//--- Prepara per la stampa
//--- 
//--- inp: 
//--- out:
//--- rit.: true = ok impostato
//---
boolean k_return=true


try 
	
	this.Object.DataWindow.Print.Margin.Top = '400'
	this.Object.DataWindow.Print.Margin.Bottom = '300'
	this.Object.DataWindow.Print.Margin.Left = '500'
	this.Object.DataWindow.Print.Margin.Right = '500'

	if this.dataobject <> ""  then 
		this.settransobject(sqlca)
	end if

catch (uo_exception kuo_exception)
	k_return=false
	throw kuo_exception 
	
finally

end try 

return k_return

end function

public function long u_retrieve (st_tab_certif ast_tab_certif) throws uo_exception;//-------------------------------------------------------------------------------
//--- Retrieve
//--- Inpu: ast_tab_certif:  id_meca
//--- Out: 
//--- Rit: numero righe 
//--- lancia exception x errore grave
//-------------------------------------------------------------------------------
long k_return 


try
	this.settransobject(kguo_sqlca_db_magazzino)
	k_return = this.retrieve(ast_tab_certif.id_meca )

catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

return k_return

end function

public function string u_get_nome_doc ();//---
//--- Torna nome da dare al documento, es da esporre in stampa
//---
string k_return="attestato_allegati"
//string k_rag_soc
//kuf_utility kuf1_utility

if this.rowcount( ) > 0 then
//	k_rag_soc = trim(this.getitemstring(1, "rag_soc_10_2"))
//	kuf1_utility = create kuf_utility
//	k_rag_soc = mid(kuf1_utility.u_stringa_compatta(k_rag_soc), 1, 8)
//	destroy kuf1_utility
	
	k_return = "attestato_" + trim(string(this.object.dw_1.object.certif_num_certif[1])) + "_allegati" 
end if

return k_return
end function

on kds_certif_stampa_allegati.create
call super::create
end on

on kds_certif_stampa_allegati.destroy
call super::destroy
end on

