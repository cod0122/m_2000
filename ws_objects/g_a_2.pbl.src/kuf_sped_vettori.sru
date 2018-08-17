$PBExportHeader$kuf_sped_vettori.sru
forward
global type kuf_sped_vettori from nonvisualobject
end type
end forward

global type kuf_sped_vettori from nonvisualobject
end type
global kuf_sped_vettori kuf_sped_vettori

type variables
public st_tab_arsp kist_tab_arsp
end variables

forward prototypes
public function st_esito tb_delete (st_tab_sped_vettori kst_tab_sped_vettori)
end prototypes

public function st_esito tb_delete (st_tab_sped_vettori kst_tab_sped_vettori);//
//====================================================================
//=== Cancella il rek dalla tabella SPED_VETTORI (Vettori di spedizione) 
//=== 
//=== Ritorna  ST_ESITO
//=== 
//====================================================================
//
int k_resp
boolean k_return
st_esito kst_esito
st_tab_arfa kst_tab_arfa
st_open_w kst_open_w
kuf_fatt kuf1_fatt
kuf_sicurezza kuf1_sicurezza


kst_esito.esito = "0"
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""




kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
kst_open_w.id_programma = kkg_id_programma_sped_vettori

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Cancellazione Vettore non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = "1"

else

	//--- cancella prima tutte le righe
	delete from sped_vettori
			WHERE id = :kst_tab_sped_vettori.id;
	
		
	if sqlca.sqlcode <> 0 then
		if sqlca.sqlcode < 0 then
			
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = &
	"Errore durante la cancellazione 'Vettore' di Spedizione ~n~rid:"  &
					+ string(kst_tab_sped_vettori.id, "####0")  &	
					+ " ~n~rErrore-tab.sped_vettori:"	+ trim(sqlca.SQLErrText)
			kst_esito.esito = "1"
		else
			if sqlca.sqlcode = 100 then
				kst_esito.SQLErrText = "Vettore non trovato, ~n~rid:"  &
						+ string(kst_tab_sped_vettori.id, "####0")  &	
						+ " ~n~rErrore-tab.sped_vettori:"	+ trim(sqlca.SQLErrText)
				kst_esito.esito = "100"
			else
				kst_esito.SQLErrText = "Errore-tab.sped_vettori:"	+ trim(sqlca.SQLErrText)
				if sqlca.sqlcode > 0 then
					kst_esito.esito = "2"
				else
					kst_esito.esito = "1"
				end if
			end if
		end if
	end if
end if


return kst_esito

end function

on kuf_sped_vettori.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_sped_vettori.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

