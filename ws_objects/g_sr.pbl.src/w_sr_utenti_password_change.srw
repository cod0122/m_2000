$PBExportHeader$w_sr_utenti_password_change.srw
forward
global type w_sr_utenti_password_change from w_sr_utenti_password
end type
end forward

global type w_sr_utenti_password_change from w_sr_utenti_password
integer width = 2501
integer height = 1108
string title = "Cambia Password Utente"
windowtype windowtype = popup!
string icon = "UserObject5!"
end type
global w_sr_utenti_password_change w_sr_utenti_password_change

forward prototypes
protected subroutine attiva_tasti ()
protected function string inizializza ()
protected function string check_dati ()
protected function string aggiorna_tabelle ()
end prototypes

protected subroutine attiva_tasti ();//
super::attiva_tasti()

if cb_aggiorna.enabled = true then 
	cb_aggiorna.default = true
end if

end subroutine

protected function string inizializza ();//
	super::inizializza()

	if dw_pwd.getrow() > 0 then

		kist_tab_sr_utenti.password = dw_pwd.getitemstring(dw_pwd.getrow(), "password_w")
		
		dw_pwd.setitem(dw_pwd.getrow(), "password_w", "")
		dw_pwd.setitem(dw_pwd.getrow(), "password_1", "")
		dw_pwd.setitem(dw_pwd.getrow(), "password_2", "")
		dw_pwd.ResetUpdate ( ) 
		
//		if Len(trim(kist_tab_sr_utenti.password)) = 0 then
//		end if
		set_pos_cursore()
	end if

return "0"
end function

protected function string check_dati ();//
//=== Controllo dati inseriti
string k_return = " ", k_errore = "0"
st_esito kst_esito
st_tab_sr_utenti kst_tab_sr_utenti
kuf_sr_sicurezza kuf1_sr_sicurezza


if dw_pwd.rowcount() > 0 then 

	kuf1_sr_sicurezza = create kuf_sr_sicurezza
	
	kst_tab_sr_utenti.codice = upper(trim(dw_pwd.getitemstring(dw_pwd.getrow(), "codice")))
	kst_tab_sr_utenti.password = upper(trim(dw_pwd.getitemstring(dw_pwd.getrow(), "password_w")))
	kst_esito = kuf1_sr_sicurezza.tb_select(kst_tab_sr_utenti)
	if kst_esito.esito = kkg_esito.ok then
		try 
			kuf1_sr_sicurezza.check_cambia_password (kst_tab_sr_utenti)
		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()
		end try
	end if
		
	if kst_esito.esito <> kkg_esito.ok then
		k_return = "Errata digitatazione nel campo '" + string(dw_pwd.object.password_t.text) + "', modifica non autorizzata~n~r" &
		           + "Prego ripetere l'immissione." + "~n~r"
		k_errore = "1"
	end if

	if k_errore = "0" then
		if trim(dw_pwd.getitemstring(dw_pwd.getrow(), "password_1")) = trim(dw_pwd.getitemstring(dw_pwd.getrow(), "password_2")) then
			k_errore = "0"
		else
			k_return = "Errata la digitazione nel campo '" + string(dw_pwd.object.password_2_t.text) + "'.~n~r" &
						  + "Prego ripetere l'immissione." + "~n~r"
			k_errore = "1"
			dw_pwd.setitem(dw_pwd.getrow(), "password_2", "")
			
		end if
	end if

	if k_errore = "0" then
		kst_tab_sr_utenti.codice = upper(trim(dw_pwd.getitemstring(dw_pwd.getrow(), "codice")))
		kst_tab_sr_utenti.password = upper(trim(dw_pwd.getitemstring(dw_pwd.getrow(), "password_1")))
		
		kst_esito = kuf1_sr_sicurezza.check_password_sintax (kst_tab_sr_utenti)
		
		if kst_esito.esito <> kkg_esito.ok then
			
			k_return = trim(kst_esito.sqlerrtext) + "~n~r" &
						  + "Prego ripetere l'immissione." + "~n~r"
			k_errore = "1"
		end if
	end if

	destroy kuf1_sr_sicurezza

	
end if

	
return k_errore + k_return

end function

protected function string aggiorna_tabelle ();//
//=== Completa gestione aggiornamento tabelle : Check dati + Update
//=== Ritorna 1 char: 0=Tutto OK; 
//                  : 1=Errore grave e/o aggiuornam. non eseguito;
//===	              : 2=Errore Non grave richiesto di non aggiornare i dati
//===               : 3=
//
string k_return="0 "
string k_errore= "0 ", k_errore1 = "0 ", k_errore_dati = "0 "
//string k_errore_check

kuf_sr_sicurezza kuf1_sr_sicurezza
st_tab_sr_utenti kst_tab_sr_utenti
st_esito kst_esito


dw_pwd.accepttext( )

//=== Controllo congruenza dei dati caricati. 
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 
//===                : 4=OK con incongruenze, richiesta se fare aggiornamento
//===                : 5=ON con avvertenze generiche, richiesta se fare aggiornamento
//===      il resto della stringa contiene la descrizione dell'errore   
k_return = check_dati()

//k_errore_check = Left(k_errore_dati,1)

//choose case k_errore_check 
//
//	case "0" //Tutto OK!
//  	   k_return = "0" + Mid(k_errore_dati, 2)
//
//   case "1" //errore grave: incongruenze dati
//		messagebox("Digitati dati incongruenti, operazione non eseguita",  Mid(k_errore_dati, 2))
//		k_return="1" + Mid(k_errore_dati, 2)
//		
//	case "2" //errore grave: digitazione dati 
//		messagebox("Inseriti dati non validi, operazione non eseguita", Mid(k_errore_dati, 2))
//		k_return="1" + Mid(k_errore_dati, 2)
//		
//	case "3" //errore grave: mancanza dati
//		messagebox("Dati insufficienti, operazione non eseguita", Mid(k_errore_dati, 2))
//		k_return="1" + Mid(k_errore_dati, 2)
//		
//	case "4" //avvertenza: dati da rivedere
//		if messagebox("Rilevate probabili incongruenze", Mid(k_errore_dati, 2) + "~n~rEseguire comunque l'aggiornamento ?", question!, yesno!, 1) = 2 then
//			k_return = "1" + "Dati non aggiornati"
//		else
//			k_return = "0" + Mid(k_errore_dati, 2)
//		end if
//		
//	case else //avvertenze: altro
//		if messagebox("Richiesto Aggiornamento Archivio", Mid(k_errore_dati, 2) + "~n~rProseguire con l'aggiornamento ?", question!, yesno!, 1) = 2 then
//			k_return = "1" + "Dati non aggiornati"
//		else
//			k_return = "0" + Mid(k_errore_dati, 2)
//		end if
//		
//	end choose
		
//--- Aggiorna solo se Nessun errore o Richiesto esplicitamente
	if Left(k_return,1) = "0" then

		kst_tab_sr_utenti.id = dw_pwd.getitemnumber(dw_pwd.getrow(), "id")
		kst_tab_sr_utenti.password = dw_pwd.getitemstring(dw_pwd.getrow(), "password_1")
	
		kuf1_sr_sicurezza = create kuf_sr_sicurezza
		kst_esito = kuf1_sr_sicurezza.tb_update_password ( kst_tab_sr_utenti )
		destroy kuf1_sr_sicurezza
	
		if kst_esito.esito = "0" then
	
			dw_pwd.SetItemStatus(dw_pwd.getrow(), 0, Primary!, NotModified!)
	
		else
	
			k_return = "1Errore: " + trim(kst_esito.sqlerrtext)
			
	
		end if
	end if
	


return k_return


end function

on w_sr_utenti_password_change.create
call super::create
end on

on w_sr_utenti_password_change.destroy
call super::destroy
end on

event open;call super::open;//



dw_pwd.object.p_key.filename = kGuo_path.get_risorse() + "\Chiave.gif"


end event

type cb_ritorna from w_sr_utenti_password`cb_ritorna within w_sr_utenti_password_change
integer x = 2071
integer y = 956
end type

type cb_aggiorna from w_sr_utenti_password`cb_aggiorna within w_sr_utenti_password_change
integer x = 1522
integer y = 956
boolean default = true
end type

type dw_pwd from w_sr_utenti_password`dw_pwd within w_sr_utenti_password_change
integer x = 18
integer y = 12
integer width = 2469
integer height = 1076
string dataobject = "d_sr_utenti_password_change"
end type

event dw_pwd::editchanged;call super::editchanged;//
string k_esito
kuf_sr_sicurezza kuf1_sr_sicurezza
 

if dwo.name = "password_1" then
	if data > " " then
		kuf1_sr_sicurezza = create kuf_sr_sicurezza
		k_esito = kuf1_sr_sicurezza.check_password (data)
		if k_esito = "OK" then
			this.modify("password_1_colore.Brush.Color = " + string(kkg_colore.verde))
			this.modify("password_1_ok.visible = '1'")
		else
			this.modify("password_1_ok.visible = '0'")
			if k_esito = "NOLEN" then
				this.modify("password_1_colore.Brush.Color = " + string(kkg_colore.rosso))
			else
				this.modify("password_1_colore.Brush.Color = " + string(kkg_colore.giallo))
			end if
		end if
	else
		this.modify("password_1_colore.Brush.Color = " + string(kkg_colore.nero))
		this.modify("password_1_ok.visible = '0'")
	end if
else
	if dwo.name = "password_2" then
		if data > " " then
			if this.describe("password_1_colore.Brush.Color")  = string(kkg_colore.verde) then
				if this.getitemstring(1, "password_1") = data then
					this.modify("password_2_colore.Brush.Color = " + string(kkg_colore.verde))
					this.modify("password_2_ok.visible = '1'")
				else
					this.modify("password_2_colore.Brush.Color = " + string(kkg_colore.verde))
					this.modify("password_2_ok.visible = '0'")
				end if
			end if
		else
			this.modify("password_2_colore.Brush.Color = " + string(kkg_colore.nero))
			this.modify("password_2_ok.visible = '0'")
		end if
	end if
end if
end event

