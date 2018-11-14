$PBExportHeader$kuf_pdf.sru
forward
global type kuf_pdf from nonvisualobject
end type
end forward

global type kuf_pdf from nonvisualobject
end type
global kuf_pdf kuf_pdf

type variables
//
private string ki_stampa_pdf[]
private int ki_stampa_pdf_idx

end variables
forward prototypes
public subroutine u_inizializza ()
public subroutine u_add_file (string a_path_file)
public function integer u_print_pdf () throws uo_exception
private function boolean u_print_esegui (string a_file) throws uo_exception
end prototypes

public subroutine u_inizializza ();//
string k_stampa_pdf_vuota[]

//--- riporta il path nella directory di base (es. c:\at_m2000)
kGuf_data_base.setta_path_default ()

ki_stampa_pdf_idx = 0
ki_stampa_pdf[] = k_stampa_pdf_vuota[]


end subroutine

public subroutine u_add_file (string a_path_file);//
ki_stampa_pdf_idx ++
ki_stampa_pdf[ki_stampa_pdf_idx] = a_path_file

end subroutine

public function integer u_print_pdf () throws uo_exception;//--------------------------------------------------------------------------------------------------------------
//--- Esegue la Stampa dei pdf indicati nell'array  instance:  ki_stampa_pdf[]
//--- 
//--- Input: 
//--- out: 
//--- Rit: numero di documenti stampati
//--- Lancia EXCEPTION se errori gravi 
//--- 
//--------------------------------------------------------------------------------------------------------------
int k_return 
int k_nr_doc, k_ind, k_nr_doc_printed


try

	kguo_exception.inizializza()

	if ki_stampa_pdf_idx > upperbound(ki_stampa_pdf) then
		k_nr_doc = upperbound(ki_stampa_pdf)  // Mooolto strano questa sforamento della tabella!!!
		kguo_exception.kist_esito.SQLErrText = "Stampa PDF, indice interno " + string(ki_stampa_pdf_idx) + " stranamente maggiore della tabella " + string(k_nr_doc) + " !!! Non blocco l'esecuzione."
		kguo_exception.kist_esito.esito = kkg_esito.ko
		kguo_exception.kist_esito.nome_oggetto = this.classname()
	else
		k_nr_doc = ki_stampa_pdf_idx
	end if
			
		
	for k_ind = 1 to k_nr_doc
		try
			if ki_stampa_pdf[k_ind] > " " then
				sleep(1)
				if this.u_print_esegui(ki_stampa_pdf[k_ind]) then
					k_nr_doc_printed ++
				else
//--- non blocca l'esecuzione ma segnala nel log		
					kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
					kguo_exception.kist_esito.sqlerrtext = "Stampa del file '" + ki_stampa_pdf[k_ind] + "' non effettuata,~n~r" & 
						+ "verificare se il file è corretto o presente." 
				end if
			end if
		catch (uo_exception kuo_exception)
//--- non blocca l'esecuzione ma segnala nel log		
			kguo_exception.kist_esito = kuo_exception.kist_esito
		end try
	end for

//--- Segnala solo nel log		
	if kguo_exception.kist_esito.esito <> kkg_esito.ok then
		kguo_exception.scrivi_log( )
	end if

	k_return = k_nr_doc_printed

catch (uo_exception kuo1_exception)
		throw kuo1_exception
	
finally
	
end try

return k_return
end function

private function boolean u_print_esegui (string a_file) throws uo_exception;//
//---  Stampa un file con l'appilicazione del sistema
//
boolean k_return = false
kuf_utility kuf1_utility


try

	kuf1_utility = create kuf_utility 
	
	k_return = kuf1_utility.u_print_file(a_file)
	
catch (uo_exception kuo_exception)
		kuo_exception.scrivi_log( )
		throw kuo_exception
	
finally
	if isvalid(kuf1_utility) then destroy kuf1_utility
	
end try

return k_return	

end function

on kuf_pdf.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_pdf.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

