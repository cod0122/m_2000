$PBExportHeader$kuf_report_etichette_lotti.sru
$PBExportComments$report x movimenti registro articolo 50
forward
global type kuf_report_etichette_lotti from nonvisualobject
end type
end forward

global type kuf_report_etichette_lotti from nonvisualobject
end type
global kuf_report_etichette_lotti kuf_report_etichette_lotti

type variables
//
private st_report_etichette_lotti kist_report_etichette_lotti
private st_tab_base kist_tab_base

//--- dati da restituire - il Report 
public datastore kids_report_etichette_lotti


end variables

forward prototypes
public subroutine get_st_report_etichette_lotti (ref st_report_etichette_lotti kst_report_etichette_lotti) throws uo_exception
public subroutine get_report (ref st_report_etichette_lotti kst_report_etichette_lotti) throws uo_exception
end prototypes

public subroutine get_st_report_etichette_lotti (ref st_report_etichette_lotti kst_report_etichette_lotti) throws uo_exception;//---
//--- Imposta  l'area st_report_etichette_lotti
//---
st_esito kst_esito
st_tab_meca kst_tab_meca
st_tab_armo kst_tab_armo
kuf_armo kuf1_armo


kuf1_armo = create kuf_armo

kst_esito = kuf1_armo.get_ultimo_doc_ins(kst_tab_meca)
if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.db_wrn then
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if

//kst_tab_armo.data_int = kst_tab_meca.data_int 
//kst_tab_armo.num_int = kst_tab_meca.num_int
//kst_esito = kuf1_armo.get_id_meca(kst_tab_armo)
//if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.db_wrn then
//	kguo_exception.set_esito(kst_esito)
//	throw kguo_exception
//end if

destroy kuf1_armo

kst_report_etichette_lotti.k_anno = year(kst_tab_meca.data_int) 
kst_report_etichette_lotti.k_clie_1 = 0
kst_report_etichette_lotti.k_num_da=kst_tab_meca.num_int
kst_report_etichette_lotti.k_num_a=kst_tab_meca.num_int
kst_report_etichette_lotti.k_area_dawmf = 0

end subroutine

public subroutine get_report (ref st_report_etichette_lotti kst_report_etichette_lotti) throws uo_exception;//---
//--- Genera Report Etichetta Lotti
//--- Inp: st_report_etichette_lotti.k_num_da e k_num_a e k_anno e clie_2
//--- out: 
//--- Lancia EXCPETION se errore
//---
int krc = 0, k_ctr, k_riga
string k_rcx=""
long kind=0, kriga=0
string k_sql_orig, k_stringn, k_string
st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad[]
kuf_wm_receiptgammarad kuf1_wm_receiptgammarad


kuf1_wm_receiptgammarad = create kuf_wm_receiptgammarad
//--- estrae dati dal DB

//--- Aggiorna SQL della 	kids_report_entrate_uscite
k_sql_orig = kids_report_etichette_lotti.Object.datawindow.Table.Select  
k_stringn = "vx_" + trim(kguo_utente.get_comp()) 
k_string = "vx_MAST"
k_ctr = PosA(k_sql_orig, k_string, 1)
DO WHILE k_ctr > 0 and trim(k_string) <> trim(k_stringn)  
	k_sql_orig = ReplaceA(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
	k_ctr = PosA(k_sql_orig, k_string, k_ctr+LenA(k_string))
LOOP
kids_report_etichette_lotti.Object.datawindow.Table.Select = k_sql_orig

if isnull(kst_report_etichette_lotti.k_clie_1) then  kst_report_etichette_lotti.k_clie_1 =  0

//--- Retrieve Datastore REPORT da restituire

krc = kids_report_etichette_lotti.retrieve(kst_report_etichette_lotti.k_anno, kst_report_etichette_lotti.k_num_da, kst_report_etichette_lotti.k_num_a,  kst_report_etichette_lotti.k_clie_1)

//--- get dal WMF dell'area di ubicazione dei lotti
if kst_report_etichette_lotti.k_area_dawmf = 1 then
	
	for k_riga = 1 to kids_report_etichette_lotti.rowcount( )
	
		kst_tab_wm_receiptgammarad[1].id_meca = kids_report_etichette_lotti.getitemnumber(k_riga, "id_meca")
		kuf1_wm_receiptgammarad.get_area_magazzino(kst_tab_wm_receiptgammarad[])
		
		if len(trim(kst_tab_wm_receiptgammarad[1].area_mag )) > 0 then
			kids_report_etichette_lotti.setitem( k_riga, "area_mag", trim(kst_tab_wm_receiptgammarad[1].area_mag))
			kids_report_etichette_lotti.setitem( k_riga, "k_flg_area_dawmf",  1)
		end if
		
	end for
end if

destroy kuf1_wm_receiptgammarad


end subroutine

event constructor;call super::constructor;//
//--- dati da restituire - il Report 
kids_report_etichette_lotti = create datastore
kids_report_etichette_lotti.dataobject = "d_etichette_lotti_x2"
kids_report_etichette_lotti.settransobject(sqlca)

end event

on kuf_report_etichette_lotti.create
call super::create
end on

on kuf_report_etichette_lotti.destroy
call super::destroy
end on

event destructor;call super::destructor;//
if not isnull(kids_report_etichette_lotti) then destroy kids_report_etichette_lotti




end event

