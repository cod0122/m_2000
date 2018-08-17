$PBExportHeader$w_utility_bar.srw
$PBExportComments$Utile x eseguire utlity con progress bar
forward
global type w_utility_bar from window
end type
type st_num from statictext within w_utility_bar
end type
type hpb_1 from hprogressbar within w_utility_bar
end type
end forward

global type w_utility_bar from window
integer width = 2670
integer height = 168
windowtype windowtype = child!
long backcolor = 0
string icon = "Warning!"
boolean center = true
st_num st_num
hpb_1 hpb_1
end type
global w_utility_bar w_utility_bar

forward prototypes
public subroutine u_start ()
end prototypes

public subroutine u_start ();//
//=== Estemporanea 
//=== Popola il LISTINO
//=== 
int k_errore=0
long k_rec=0, k_righe=0, k_update_righe=0
datastore kds


//=== Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa)

	kds = create datastore

	hpb_1.setrange(0,100)
	hpb_1.stepit()
	st_num.text = "Attendere..."

	kds.dataobject = "dsappo_meca_dosim_l"
	kds.settransobject(sqlca)
	k_righe = kds.retrieve()
	
	hpb_1.setrange(0,((k_righe/100) + 100))
	hpb_1.setstep = 1
	
	st_num.text = string(k_righe, "###,##0")
	
if messagebox ("Operazione di AGGIORNAMENTO", &
         "proseguire l'elaborazioe di " + string(k_righe, "###,##0") + " record?", &
						 question!, YesNo!, 2) = 1 then

	k_update_righe = 1000
	for k_rec = 1 to k_righe 
		
//		st_num.text = string(k_rec, "###,##0")+ "/" + string(k_righe, "###,##0")
		
		if trim(kds.getitemstring(k_rec, "barcode")) > " " then
		else
			kds.setitem(k_rec, "barcode", string(k_rec))
		end if
		kds.setitem(k_rec, "barcode_lav", kds.getitemstring(k_rec, "barcode_barcode"))
		k_update_righe --
		if k_update_righe = 0 then
			hpb_1.stepit()
			k_update_righe = 1000
			st_num.text = "Aggiorna..."
			k_errore = kds.update( )
			commit;
			st_num.text = "Esito: " + string(k_errore)
		end if
		
	end for
	hpb_1.stepit()
	
	st_num.text = "Aggiorna..."
	k_errore = kds.update( )
	if k_errore > 0 then
		hpb_1.offsetpos(50)
		commit;
		hpb_1.offsetpos(50)
	end if
	
//	kds.saveas("myxml.xml", XML!, false)
	
	SetPointer(kkg.pointer_default)
	if k_errore > 0 then
		MessageBox("Elaborazione Terminata", &
					"Aggiornati " + string(k_rec, "####") + " righe della tabella MECA_DOSIM~n~r" &
					, & 
					Information!)
	else
		MessageBox("Elaborazione in Errore", &
					"Parte o nessuna riga aggiornata in tabella MECA_DOSIM~n~r" &
					, & 
					Information!)
	end if
end if

close(this)
//return k_rec

end subroutine

on w_utility_bar.create
this.st_num=create st_num
this.hpb_1=create hpb_1
this.Control[]={this.st_num,&
this.hpb_1}
end on

on w_utility_bar.destroy
destroy(this.st_num)
destroy(this.hpb_1)
end on

event open;//
post u_start( )

end event

type st_num from statictext within w_utility_bar
integer x = 1147
integer y = 52
integer width = 480
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "0"
alignment alignment = center!
boolean focusrectangle = false
end type

type hpb_1 from hprogressbar within w_utility_bar
integer x = 37
integer y = 36
integer width = 2565
integer height = 88
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 10
end type

