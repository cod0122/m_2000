$PBExportHeader$ust_tab_prof.sru
forward
global type ust_tab_prof from ust_parent
end type
end forward

global type ust_tab_prof from ust_parent
end type
global ust_tab_prof ust_tab_prof

type variables
//
public:
	long	id_fattura
	long	num_fatt
	date	data_fatt
	string	flag
	long	conto
	long	s_conto
	double importo
	integer iva
	string	tipo_doc
	integer cod_pag
	string	profis
	string	p_iva

public: 
	constant	string kki_flag_anagrafica = "A"
	constant string kki_flag_contropart = "C"
	
	constant	string kki_tipo_doc_fattura = "FT"
	constant string kki_tipo_doc_notacredito = "NC"
	
	constant string kki_profis_docInContab_si = 'S'
	constant string kki_profis_docInContab_no = 'N'
	
	
end variables

forward prototypes
public function long get_num_fatt ()
public function date get_data_fatt ()
public function string get_flag ()
public function long get_conto ()
public function long get_s_conto ()
public function double get_importo ()
public function integer get_iva ()
public function integer get_cod_pag ()
public function string get_tipo_doc ()
public function string get_profis ()
public function string get_p_iva ()
public subroutine set_cod_pag (integer a_cod_pag)
public subroutine set_conto (long a_conto)
public subroutine set_num_fatt (long a_num_fatt)
public subroutine set_s_conto (long a_s_conto)
public subroutine set_iva (integer a_iva)
public subroutine set_data_fatt (date a_data_fatt)
public subroutine set_flag (string a_flag)
public subroutine set_profis (string a_profis)
public subroutine set_p_iva (string a_p_iva)
public subroutine set_importo (double a_importo)
public subroutine set_tipo_doc (string a_tipo_doc)
public function long get_id_fattura ()
public subroutine set_id_fattura (long a_id_fattura)
end prototypes

public function long get_num_fatt ();//
if isnull(num_fatt) then num_fatt = 0

return num_fatt


end function

public function date get_data_fatt ();//
if isnull(data_fatt) then data_fatt = KKG.DATA_ZERO

return data_fatt


end function

public function string get_flag ();//
if isnull(flag) then flag = ""

return flag


end function

public function long get_conto ();//
if isnull(conto) then conto = 0

return conto


end function

public function long get_s_conto ();//
if isnull(s_conto) then s_conto = 0

return s_conto


end function

public function double get_importo ();//
if isnull(importo) then importo = 0.0

return importo


end function

public function integer get_iva ();//
if isnull(iva) then iva = 0

return iva


end function

public function integer get_cod_pag ();//
if isnull(cod_pag) then cod_pag = 0

return cod_pag


end function

public function string get_tipo_doc ();//
if isnull(tipo_doc) then tipo_doc = ""

return tipo_doc


end function

public function string get_profis ();//
if isnull(profis) then profis = ""

return profis


end function

public function string get_p_iva ();//
if isnull(p_iva) then p_iva = ""

return p_iva


end function

public subroutine set_cod_pag (integer a_cod_pag);//
if isnull(a_cod_pag) then a_cod_pag = 0

cod_pag = a_cod_pag


end subroutine

public subroutine set_conto (long a_conto);//
if isnull(a_conto) then a_conto = 0

conto = a_conto


end subroutine

public subroutine set_num_fatt (long a_num_fatt);//
if isnull(a_num_fatt) then a_num_fatt = 0

num_fatt = a_num_fatt


end subroutine

public subroutine set_s_conto (long a_s_conto);//
if isnull(a_s_conto) then a_s_conto = 0

s_conto = a_s_conto


end subroutine

public subroutine set_iva (integer a_iva);//
if isnull(a_iva) then a_iva = 0

iva = a_iva


end subroutine

public subroutine set_data_fatt (date a_data_fatt);//
if isnull(a_data_fatt) then a_data_fatt = KKG.DATA_ZERO

data_fatt = a_data_fatt


end subroutine

public subroutine set_flag (string a_flag);//
if isnull(a_flag) then a_flag = ""

flag = a_flag


end subroutine

public subroutine set_profis (string a_profis);//
if isnull(a_profis) then a_profis = ""

profis = a_profis


end subroutine

public subroutine set_p_iva (string a_p_iva);//
if isnull(a_p_iva) then a_p_iva = ""

p_iva = a_p_iva


end subroutine

public subroutine set_importo (double a_importo);//
if isnull(a_importo) then a_importo = 0.0

importo = a_importo


end subroutine

public subroutine set_tipo_doc (string a_tipo_doc);//
if isnull(a_tipo_doc) then a_tipo_doc = ""

tipo_doc = a_tipo_doc


end subroutine

public function long get_id_fattura ();//
if isnull(id_fattura) then id_fattura = 0

return id_fattura


end function

public subroutine set_id_fattura (long a_id_fattura);//
if isnull(a_id_fattura) then a_id_fattura = 0

id_fattura = a_id_fattura


end subroutine

on ust_tab_prof.create
call super::create
end on

on ust_tab_prof.destroy
call super::destroy
end on

