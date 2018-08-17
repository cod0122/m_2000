$PBExportHeader$kuf_fpilota.sru
forward
global type kuf_fpilota from nonvisualobject
end type
end forward

global type kuf_fpilota from nonvisualobject
end type
global kuf_fpilota kuf_fpilota

forward prototypes
public function st_esito apri_fpilota_out (string k_tipo, ref st_txt_fpilota_out kst_txt_fpilota_out)
public function st_esito chiudi_fpilota_out (string k_tipo, ref st_txt_fpilota_out kst_txt_fpilota_out)
public function st_esito leggi_fpilota_out (string k_tipo, ref st_txt_fpilota_out kst_txt_fpilota_out)
public function st_esito path_fpilota_out (string k_tipo, ref st_txt_fpilota_out kst_txt_fpilota_out)
end prototypes

public function st_esito apri_fpilota_out (string k_tipo, ref st_txt_fpilota_out kst_txt_fpilota_out);//
//====================================================================
//=== Open file Esiti Pilota di out SIG_TXT 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Non Aperto 
//===              byte = lunghezza file   
//===   
//====================================================================
//
int k_rc
st_esito kst_esito
kuf_utility kuf1_utility


	kst_esito.esito = "0"
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""

	kst_txt_fpilota_out.path_temp = kuf1_data_base.profilestring_leggi_scrivi(1, "temp", " ") 
	if not DirectoryExists ( kst_txt_fpilota_out.path_temp ) then
		k_rc = CreateDirectory ( kst_txt_fpilota_out.path_temp ) 
		if k_rc < 0 then
			kst_esito.esito = "1"
			kst_esito.sqlcode = k_rc
			kst_esito.SQLErrText = "Generazione Cartella temporanea Fallita: " + kst_txt_fpilota_out.path_temp 
		end if
	end if
	
	if kst_esito.esito = "0" then

		kst_txt_fpilota_out.path_temp = kst_txt_fpilota_out.path_temp + "\fpil_out.txt"
//--- copia solo se ci sono state modifiche sulla dimens. del file
		kst_txt_fpilota_out.byte = FileLength(kst_txt_fpilota_out.path_temp)
		if isnull(kst_txt_fpilota_out.byte) then 
			kst_txt_fpilota_out.byte = 0
		end if
		if FileLength(kst_txt_fpilota_out.path) <> kst_txt_fpilota_out.byte then
			k_rc = FileCopy(kst_txt_fpilota_out.path, kst_txt_fpilota_out.path_temp, true)
//         kuf1_utility = create kuf_utility
//			k_rc = kuf1_utility.u_copia_file(kst_txt_fpilota_out.path, kst_txt_fpilota_out.path_temp, false)
//			destroy kuf1_utility
			if k_rc < 0 then
				kst_esito.esito = "1"
				kst_esito.sqlcode = k_rc
				kst_esito.SQLErrText = "Copia del File 'Esiti Pilota' su Temporaneo Fallita!"
			else
				kst_txt_fpilota_out.byte = FileLength(kst_txt_fpilota_out.path_temp)
			end if
		end if
	
	
		if kst_esito.esito = "0" then
		
			if kst_txt_fpilota_out.byte > 0 then
			
				kst_txt_fpilota_out.FileNum = FileOpen(kst_txt_fpilota_out.path_temp, LineMode!, Read!, Shared!)
				
				if kst_txt_fpilota_out.FileNum < 0 then
					kst_esito.esito = "1"
					kst_esito.sqlcode = kst_txt_fpilota_out.FileNum
					kst_esito.SQLErrText = "Apertura fallita dell'archivio 'Esiti Pilota'"
				end if
				
			else
				kst_esito.esito = "1"
				kst_esito.sqlcode = 0
				if kst_txt_fpilota_out.byte = 0 then
					kst_esito.SQLErrText = "Archivio 'Esiti Pilota' Vuoto"
				else	
					if kst_txt_fpilota_out.byte < 0 then
						kst_esito.SQLErrText = "Archivio 'Esiti Pilota' non Trovato"
					else
						kst_esito.SQLErrText = "Archivio 'Esiti Pilota' illeggibile"
					end if
				end if
			end if
		end if
	end if
	
return kst_esito

end function

public function st_esito chiudi_fpilota_out (string k_tipo, ref st_txt_fpilota_out kst_txt_fpilota_out);//
//====================================================================
//=== Chiudi file Pilota di out SIG_TXT 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore in Close
//===   
//====================================================================
//
st_esito kst_esito



	kst_esito.esito = "0"
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
		
	kst_txt_fpilota_out.byte = FileClose(kst_txt_fpilota_out.FileNum)
	if kst_txt_fpilota_out.byte < 0 then
		kst_esito.esito = "1"
		kst_esito.sqlcode = kst_txt_fpilota_out.FileNum
		kst_esito.SQLErrText = "Chiusura fallita dell'archivio 'Esiti Pilota'"
	end if


return kst_esito

end function

public function st_esito leggi_fpilota_out (string k_tipo, ref st_txt_fpilota_out kst_txt_fpilota_out);//
//====================================================================
//=== Legge rek nel file Esiti Pilota SIG_TXT 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore in READ 
//===                                     2=errore formale in un campo 
//===                                     3=rec vuoto 
//===                                     100=eof 
//=== 
//====================================================================
//
string k_record = " "
st_esito kst_esito



	kst_esito.esito = "0"
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""

//--- Inizializzo i campi
	kst_txt_fpilota_out.barcode = MidA(k_record, 1, 8)
	kst_txt_fpilota_out.g1_fila_1 = 0
	kst_txt_fpilota_out.g1_fila_2 = 0
	kst_txt_fpilota_out.g2_fila_1 = 0
	kst_txt_fpilota_out.g2_fila_2 = 0
	kst_txt_fpilota_out.data_ini = date(0)
	kst_txt_fpilota_out.ora_ini = time(0)
	kst_txt_fpilota_out.data_fin = date(0)
	kst_txt_fpilota_out.ora_fin = time(0)


	kst_txt_fpilota_out.byte = FileRead(kst_txt_fpilota_out.FileNum, k_record)
	
	choose case kst_txt_fpilota_out.byte

//--- EOF
		case -100
			kst_esito.esito = "100"

//--- Errore grave
		case is < 0
			kst_esito.esito = "1"
			kst_esito.sqlcode = kst_txt_fpilota_out.byte
			kst_esito.SQLErrText = "Lettura fallita del record 'Esiti Pilota'"

//--- Rec vuoto
		case 0
			kst_esito.esito = "3"

//--- Se lettura OK fa controlli formali			
		case else
			kst_txt_fpilota_out.barcode = MidA(k_record, 1, 8)
			
			if isnumber(trim(MidA(k_record, 22, 2))) then
				kst_txt_fpilota_out.g1_fila_1 = long(trim(MidA(k_record, 22, 2)))
			else
				kst_esito.esito = "2"
				kst_esito.sqlcode = kst_txt_fpilota_out.byte
				kst_esito.SQLErrText = "Errore Formato Giro 1 Fila 1, nel record di uscita del Pilota" &
					                     + " ("  + trim(MidA(k_record, 22, 2)) + ") "
			end if
//			if kst_esito.esito = "0" then
				if isnumber(trim(MidA(k_record, 25, 2))) then
					kst_txt_fpilota_out.g1_fila_2 = long(trim(MidA(k_record, 25, 2)))
				else
					kst_esito.esito = "2"
					kst_esito.sqlcode = kst_txt_fpilota_out.byte
					kst_esito.SQLErrText = "Errore Formato Giro 1 Fila 2, nel record di uscita del Pilota" &
					                      + " (" + trim(MidA(k_record, 25, 2)) + ") "
				end if
//			end if
//			if kst_esito.esito = "0" then
				if isnumber(trim(MidA(k_record, 28, 2))) then
					kst_txt_fpilota_out.g2_fila_1 = long(trim(MidA(k_record, 28, 2)))
				else
					kst_esito.esito = "2"
					kst_esito.sqlcode = kst_txt_fpilota_out.byte
					kst_esito.SQLErrText = "Errore Formato Giro 2 Fila 1, nel record di uscita del Pilota" &
					                       + " (" + trim(MidA(k_record, 28, 2)) + ") "
				end if
//			end if
//			if kst_esito.esito = "0" then
				if isnumber( trim(MidA(k_record, 31, 2))) then
					kst_txt_fpilota_out.g2_fila_2 = long(trim(MidA(k_record, 31, 2)))
				else
					kst_esito.esito = "2"
					kst_esito.sqlcode = kst_txt_fpilota_out.byte
					kst_esito.SQLErrText = "Errore Formato Giro 2 Fila 2, nel record di uscita del Pilota " &
					                       + " (" + trim(MidA(k_record, 31, 2)) + ") "
				end if
//			end if
//			if kst_esito.esito = "0" then
				if isdate(MidA(k_record, 34, 10)) then
					kst_txt_fpilota_out.data_ini = date(MidA(k_record, 34, 10))
				else
					kst_esito.esito = "2"
					kst_esito.sqlcode = kst_txt_fpilota_out.byte
					kst_esito.SQLErrText = "Errore Formato Data Inizio, nel record di uscita del Pilota" & 
					                       + " (" + trim(MidA(k_record, 34, 10)) + ") "
				end if
//			end if
//			if kst_esito.esito = "0" then
				if istime(MidA(k_record, 45, 08)) then
					kst_txt_fpilota_out.ora_ini = time(MidA(k_record, 45, 08))
				else
					kst_esito.esito = "2"
					kst_esito.sqlcode = kst_txt_fpilota_out.byte
					kst_esito.SQLErrText = "Errore Formato Ora Inizio, nel record di uscita del Pilota" &
						                     + " (" + trim(MidA(k_record, 45, 8)) + ") "
				end if
//			end if
//			if kst_esito.esito = "0" then
				if isdate(MidA(k_record, 265, 10)) then
					kst_txt_fpilota_out.data_fin = date(MidA(k_record, 265, 10))
				else
					kst_esito.esito = "2"
					kst_esito.sqlcode = kst_txt_fpilota_out.byte
					kst_esito.SQLErrText = "Errore Formato Data Fine, nel record di uscita del Pilota" & 
						                     + " (" + trim(MidA(k_record, 265, 10)) + ") "
				end if
//			end if
//			if kst_esito.esito = "0" then
				if istime(MidA(k_record, 276, 08)) then
					kst_txt_fpilota_out.ora_fin = time(MidA(k_record, 276, 08))
				else
					kst_esito.esito = "2"
					kst_esito.sqlcode = kst_txt_fpilota_out.byte
					kst_esito.SQLErrText = "Errore Formato Ora Fine, nel record di uscita del Pilota" &
						                     + " ("  + trim(MidA(k_record, 276, 08)) + ") "
				end if
//			end if

	end choose



return kst_esito

end function

public function st_esito path_fpilota_out (string k_tipo, ref st_txt_fpilota_out kst_txt_fpilota_out);//
//====================================================================
//=== Reperisce il path del file Pilota di out "SIG_TXT" 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=File non Trovato
//===   
//====================================================================
//
string k_nulla=" "
st_esito kst_esito
kuf_base kuf1_base



	kst_esito.esito = "0"
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	
	kuf1_base = create kuf_base
	kst_txt_fpilota_out.path = trim(kuf1_base.prendi_dato_base("arch_pilota_out"))
	destroy kuf1_base

	if not fileexists(kst_txt_fpilota_out.path) then
		kst_esito.esito = "1"
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Archivio 'Esiti Pilota' non Trovato (" + trim(kst_txt_fpilota_out.path) + ")"
	end if



return kst_esito

end function

on kuf_fpilota.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_fpilota.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

