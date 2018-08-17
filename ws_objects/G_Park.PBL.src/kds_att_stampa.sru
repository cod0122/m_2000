$PBExportHeader$kds_att_stampa.sru
$PBExportComments$datasore x stampa attestato con pagine info lotto
forward
global type kds_att_stampa from uo_datastore_0
end type
end forward

global type kds_att_stampa from uo_datastore_0
string dataobject = "d_att_stampa_2016"
end type
global kds_att_stampa kds_att_stampa

forward prototypes
public subroutine u_set_attestato_dw (string a_nome)
end prototypes

public subroutine u_set_attestato_dw (string a_nome);//--- 
//--- Imposta il nome del dataobject dell'attestato da stampare
//---

this.Modify("dw_1.DataObject='" + trim(a_nome) + "' ")
this.settransobject(kguo_sqlca_db_magazzino)

end subroutine

on kds_att_stampa.create
call super::create
end on

on kds_att_stampa.destroy
call super::destroy
end on

