$PBExportHeader$kuf_sicurezza.sru
forward
global type kuf_sicurezza from nonvisualobject
end type
end forward

global type kuf_sicurezza from nonvisualobject
end type
global kuf_sicurezza kuf_sicurezza

type variables
private:
//--- Tipo Modalita operativa su cui opera la windows carattere funzione
constant string ki_ELENCO="e"         
constant string ki_INSERIMENTO="i"     
constant string ki_MODIFICA="m"       
constant string ki_CANCELLAZIONE="c"   
constant string ki_VISUALIZZAZIONE="v"
constant string ki_INTERROGAZIONE="q" 
constant string ki_STAMPA="s" 
constant string ki_CHIUDI_PL="p"      
constant string ki_AUTORIZZATO="a"      
constant string ki_NAVIGATORE="n" 
constant string ki_ANTEPRIMA="v" //"t" 
constant string ki_BATCH="b" 

public:
string ki_sr_titolo = ""    //contiene l'ultimo TITOLO della funzione cercata in autorizza_funzione()

end variables

forward prototypes
public function boolean autorizza_funzione (ref st_open_w kst_open_w)
end prototypes

public function boolean autorizza_funzione (ref st_open_w kst_open_w);//
//
//=== Controlla se funzione Autorizzata o meno 
//
boolean k_return = false
long k_ctr, k_ctr_idx, k_ctr_save


ki_sr_titolo = ""

//--- trovo le autorizzazioni del programma
k_ctr = 1
k_ctr_idx = UpperBound(kGst_tab_menu_window[])
do while k_ctr <= k_ctr_idx 
	if trim(kst_open_w.id_programma) = trim(kGst_tab_menu_window[k_ctr].id) then
		kst_open_w.operazioni_autorizzate = trim(kGst_tab_menu_window[k_ctr].funzioni)
		exit
	end if
	k_ctr++
loop

if k_ctr <= k_ctr_idx then
	
	ki_sr_titolo = trim(kGst_tab_menu_window[k_ctr].titolo)

//--- funzione ANTEPRIMA e VISUALIZZAIONE e STAMPA sono state equiparate			
//	if kst_open_w.flag_modalita = kkg_flag_modalita.anteprima or kst_open_w.flag_modalita = kkg_flag_modalita.stampa then
//		kst_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
//	end if

	choose case kst_open_w.flag_modalita
			
//--- funzione ELENCO e NAVIGAZIONE  sono state equiparate		
		case kkg_flag_modalita.elenco
			k_ctr_save = k_ctr
			k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr].funzioni), upper(ki_elenco)  )
			if k_ctr = 0 then
				k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr_save].funzioni), upper(ki_navigatore)  )
			end if
			
//--- funzione ANTEPRIMA e VISUALIZZAIONE e NAVIGAZIONE e STAMPA sono state equiparate			
		case kkg_flag_modalita.visualizzazione
			k_ctr_save = k_ctr
			k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr].funzioni), upper(ki_visualizzazione)  )
			if k_ctr = 0 then
				k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr_save].funzioni), upper(ki_anteprima)  )
				if k_ctr = 0 then
					k_ctr = PosA ( upper(kGst_tab_menu_window[k_ctr_save].funzioni), upper(ki_navigatore ) )
					if k_ctr = 0 then
						k_ctr = PosA ( upper(kGst_tab_menu_window[k_ctr_save].funzioni), upper(ki_stampa ) )
						if k_ctr = 0 then //--- se sono autorizzato a Modificare lo sono anche per Visualizzare, nooo?
							k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr_save].funzioni), upper(ki_modifica) )
						end if
					end if
				end if
			end if
			
		case kkg_flag_modalita.modifica
			k_ctr_save = k_ctr
			k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr].funzioni), upper(ki_modifica)  )
			if k_ctr = 0 then //--- se sono autorizzato a cancellare lo sono anche per modificare, nooo?
				k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr_save].funzioni), upper(ki_cancellazione) )
			end if
			
		case kkg_flag_modalita.duplica
		case kkg_flag_modalita.inserimento
			k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr].funzioni), upper(ki_inserimento)  )
			
		case kkg_flag_modalita.cancellazione
			k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr].funzioni), upper(ki_cancellazione) )
			
		case kkg_flag_modalita.stampa
			k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr].funzioni), upper(ki_stampa)  )
			
		case kkg_flag_modalita.chiudi_pl
			k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr].funzioni), upper(ki_chiudi_pl)  )
			
		case kkg_flag_modalita.BATCH
			k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr].funzioni), upper(ki_BATCH)  )
		
//--- funzione NAVIGATORE è simile a ELENCO, VISUALIZZAZIONE			
		case kkg_flag_modalita.navigatore
			k_ctr_save = k_ctr
			k_ctr = PosA ( upper(kGst_tab_menu_window[k_ctr].funzioni), upper(ki_navigatore ) )
			if k_ctr = 0 then
				k_ctr = PosA ( upper(kGst_tab_menu_window[k_ctr_save].funzioni), upper(ki_visualizzazione ) )
				if k_ctr = 0 then
					k_ctr = PosA ( upper(kGst_tab_menu_window[k_ctr_save].funzioni), upper(ki_elenco ) )
				end if
			end if
			
			
	end choose

	if k_ctr > 0 then
		k_return = true
	end if

end if


return k_return

end function

on kuf_sicurezza.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_sicurezza.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

