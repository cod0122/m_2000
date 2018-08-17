$PBExportHeader$uo_d_sped_riga.sru
forward
global type uo_d_sped_riga from uo_d_std_1
end type
end forward

global type uo_d_sped_riga from uo_d_std_1
integer width = 3447
integer height = 1816
string dataobject = "d_sped_riga"
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_d_std_1_attiva_cerca = false
end type
global uo_d_sped_riga uo_d_sped_riga

forward prototypes
public function boolean u_retrieve (st_tab_arsp ast_tab_arsp) throws uo_exception
end prototypes

public function boolean u_retrieve (st_tab_arsp ast_tab_arsp) throws uo_exception;//
//--- retrieve della riga di spedizione 
//
boolean k_return = false
string k_sql_orig, k_stringn, k_string 
int k_ctr


	if ast_tab_arsp.id_arsp = 0 then
		
//---.Aggiorna SQL della dw   
   		k_sql_orig = this.object.Table.Select 
   		k_stringn = "where armo.id_armo = :k_id_armo "
   		k_string = "WHERE (arsp.id_arsp = :kid_riga and armo.id_armo = :k_id_armo)"
   		k_ctr = Pos(k_sql_orig, k_string, 1)
		if k_ctr > 0 then  
      		k_sql_orig = Replace(k_sql_orig, k_ctr, Len(k_string), (k_stringn))
		end if
		this.Object.DataWindow.Table.Select = k_sql_orig 

	end if

	retrieve(ast_tab_arsp.id_arsp, ast_tab_arsp.id_armo)

return k_return
end function

on uo_d_sped_riga.create
call super::create
end on

on uo_d_sped_riga.destroy
call super::destroy
end on

