$PBExportHeader$kuf_listino_duplica_massiva.sru
forward
global type kuf_listino_duplica_massiva from kuf_parent
end type
end forward

global type kuf_listino_duplica_massiva from kuf_parent
end type
global kuf_listino_duplica_massiva kuf_listino_duplica_massiva

type variables
private kuf_listino kiuf_listino
private kuf_esito_operazioni kiuf_esito_operazioni
end variables

forward prototypes
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public subroutine log_destroy ()
public function kuf_esito_operazioni log_inizializza () throws uo_exception
public function long u_duplica_listini (ref st_listino_duplica ast_listino_duplica[]) throws uo_exception
end prototypes

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
if ast_open_w.flag_modalita > " " then
	ast_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
end if

//--- le autorizzazioni sono le stesse del LISTINO
ast_open_w.id_programma = kiuf_listino.get_id_programma(ast_open_w.flag_modalita)
return kiuf_listino.if_sicurezza(ast_open_w)


end function

public subroutine log_destroy ();//
if isvalid(kiuf_esito_operazioni) then destroy kiuf_esito_operazioni


 
end subroutine

public function kuf_esito_operazioni log_inizializza () throws uo_exception;//
//--- inizializza il log delle operazioni	
	if not isvalid(kiuf_esito_operazioni) then kiuf_esito_operazioni = create kuf_esito_operazioni

	kiuf_esito_operazioni.inizializza( kiuf_esito_operazioni.kki_tipo_operazione_dup_listini )


 return kiuf_esito_operazioni
end function

public function long u_duplica_listini (ref st_listino_duplica ast_listino_duplica[]) throws uo_exception;//
//--- Duplica listini
//--- input:  st_listino_duplica = id_listino (da duplicare) + dati da cambiare rispetto agli originali
//--- Out: id_listino[] nuovi
//--- rit: Numero duplicati
//---
boolean k_stampato=true, k_sicurezza=true
int k_ctr=0, k_nr_duplicati=0, k_nr_da_duplicare, k_riga
st_tab_listino kst_tab_listino
st_esito kst_esito 


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""


if if_sicurezza(kkg_flag_modalita.inserimento) then

	k_nr_da_duplicare = upperbound(ast_listino_duplica[]) 

	for k_riga = 1 to k_nr_da_duplicare

		if ast_listino_duplica[k_riga].id_listino > 0 then
			
			kst_tab_listino.id = ast_listino_duplica[k_riga].id_listino
			kst_tab_listino.prezzo = ast_listino_duplica[k_riga].prezzo
			kst_tab_listino.prezzo_2 = ast_listino_duplica[k_riga].prezzo_2
			kst_tab_listino.prezzo_3 = ast_listino_duplica[k_riga].prezzo_3
			kst_tab_listino.attivo = ast_listino_duplica[k_riga].attivo
			
//--- DUPLICA
			ast_listino_duplica[k_riga].id_listino = kiuf_listino.tb_duplica(kst_tab_listino)
			 if ast_listino_duplica[k_riga].id_listino > 0 then
				k_nr_duplicati ++
			end if

		end if
		
	next
	
end if


return k_nr_duplicati

end function

on kuf_listino_duplica_massiva.create
call super::create
end on

on kuf_listino_duplica_massiva.destroy
call super::destroy
end on

event constructor;call super::constructor;//
kiuf_listino = create kuf_listino

end event

