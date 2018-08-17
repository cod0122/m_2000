$PBExportHeader$w_stampa_barcode.srw
forward
global type w_stampa_barcode from w_g_tab_3
end type
end forward

global type w_stampa_barcode from w_g_tab_3
end type
global w_stampa_barcode w_stampa_barcode

forward prototypes
protected subroutine stampa ()
end prototypes

protected subroutine stampa ();//
// stampa codice a barre standard CODE 39
//
// 1'' (inches) = 2,54 cm 
// ogni carattere è composto da 5 barre e 4 spazi (=9 elementi)
// ogni elemento può essere fine o grosso (narrow o wide)
// 3 dei 9 elementi deve essere wide (ecco xchè si chiama 'code 39')
// la tabella k_char_barcode è di 44, ogni stringa contiene 9 caratteri che indicano 
// la sequenza 'sottile' e 'grosso' iniziando dall'elemento barra poi spazio poi barra ecc... 
// la codebar intera è composta da una zona franca di almeno 0,1'' + il carattere di 
// inizio '*' + il codice + il carattere di fine '*' + zona franca di almeno 0,1''
string k_char_barcode[0 to 43, 0 to 1], k_char_bar_sp=""
long k_id_print=0
int k_coord_x=0, k_coord_y=0, k_spessore=0, k_altezza=0
int k_ctr=0, k_ctr1=0
string k_add_line, k_rc

//                                  k_char_bar_sp='bsbsbsbsb'
//k_char_barcode[00,0]='0';  k_char_barcode[00,1]='nnnwwnwnn'
//k_char_barcode[01,0]='1';  k_char_barcode[01,1]='wnnwnnnnw'
//k_char_barcode[02,0]='2';  k_char_barcode[02,1]='nnwwnnnnw'
//k_char_barcode[03,0]='3';  k_char_barcode[03,1]='wnwwnnnnn'
//k_char_barcode[04,0]='4';  k_char_barcode[04,1]='nnnwwnnnw'
//k_char_barcode[05,0]='5';  k_char_barcode[05,1]='wnnwwnnnn'
//k_char_barcode[06,0]='6';  k_char_barcode[06,1]='nnwwwnnnn'
//k_char_barcode[07,0]='7';  k_char_barcode[07,1]='nnnwnnwnw'
//k_char_barcode[08,0]='8';  k_char_barcode[08,1]='wnnwnnwnn'
//k_char_barcode[09,0]='9';  k_char_barcode[09,1]='nnwwnnwnn'
//k_char_barcode[10,0]='a';  k_char_barcode[10,1]='wnnnnwnnw'
//k_char_barcode[11,0]='b';  k_char_barcode[11,1]='nnwnnwnnw'
//k_char_barcode[12,0]='c';  k_char_barcode[12,1]='wnwnnwnnn'
//k_char_barcode[13,0]='d';  k_char_barcode[13,1]='nnnnwwnnw'
//k_char_barcode[14,0]='e';  k_char_barcode[14,1]='wnnnwwnnn'
//k_char_barcode[15,0]='f';  k_char_barcode[15,1]='nnwnwwnnn'
//k_char_barcode[16,0]='g';  k_char_barcode[16,1]='nnnnnwwnw'
//k_char_barcode[17,0]='h';  k_char_barcode[17,1]='wnnnnwwnn'
//k_char_barcode[18,0]='i';  k_char_barcode[18,1]='nnwnnwwnn'
//k_char_barcode[19,0]='j';  k_char_barcode[19,1]='nnnnwwwnn'
//k_char_barcode[20,0]='k';  k_char_barcode[20,1]='wnnnnnnww'
//k_char_barcode[21,0]='l';  k_char_barcode[21,1]='nnwnnnnww'
//k_char_barcode[22,0]='m';  k_char_barcode[22,1]='wnwnnnnwn'
//k_char_barcode[23,0]='n';  k_char_barcode[23,1]='nnnnwnnww'
//k_char_barcode[24,0]='o';  k_char_barcode[24,1]='wnnnwnnwn'
//k_char_barcode[25,0]='p';  k_char_barcode[25,1]='nnwnwnnwn'
//k_char_barcode[26,0]='q';  k_char_barcode[26,1]='nnnnnnwww'
//k_char_barcode[27,0]='r';  k_char_barcode[27,1]='wnnnnnwwn'
//k_char_barcode[28,0]='s';  k_char_barcode[28,1]='nnwnnnwwn'
//k_char_barcode[29,0]='t';  k_char_barcode[29,1]='nnnnwnwwn'
//k_char_barcode[30,0]='u';  k_char_barcode[30,1]='wwnnnnnnw'
//k_char_barcode[31,0]='v';  k_char_barcode[31,1]='nwwnnnnnw'
//k_char_barcode[32,0]='w';  k_char_barcode[32,1]='wwwnnnnnn'
//k_char_barcode[33,0]='x';  k_char_barcode[33,1]='nwnnwnnnw'
//k_char_barcode[34,0]='y';  k_char_barcode[34,1]='wwnnwnnnn'
//k_char_barcode[35,0]='z';  k_char_barcode[35,1]='nwwnwnnnn'
//k_char_barcode[36,0]='-';  k_char_barcode[36,1]='nwnnnnwnw'
//k_char_barcode[37,0]='.';  k_char_barcode[37,1]='wwnnnnwnn'
//k_char_barcode[38,0]=' ';  k_char_barcode[38,1]='nwwnnnwnn'
//k_char_barcode[39,0]='*';  k_char_barcode[39,1]='nwnnwnwnn'
//k_char_barcode[40,0]='$';  k_char_barcode[40,1]='nwnwnwnnn'
//k_char_barcode[41,0]='/';  k_char_barcode[41,1]='nwnwnnnwn'
//k_char_barcode[42,0]='+';  k_char_barcode[42,1]='nwnnnwnwn'
//k_char_barcode[43,0]='%';  k_char_barcode[43,1]='nnnwnwnwn'
//
//
//
//
////k_id_print = PrintOpen( )
//
////tab_1.tabpage_1.dw_1.print(k_id_print, 0, 0)
//
//k_coord_x = 950
//k_coord_y = 3530
//k_altezza = 1600 + k_coord_y
//
//	for k_ctr1 = 1 to 9
//      if mid(k_char_barcode[39,1],k_ctr1,1) = 'n' then
//			k_spessore = 10
//		else
//			k_spessore = 25
//		end if
//		
//      if mid(k_char_bar_sp,k_ctr1,1) = 'b' then
//			
//			
//         k_add_line = 'line(band=detail '  &
//			           + 'x1="' + trim(string(k_coord_x)) + '" '  &
//		              + 'y1="' + trim(string(k_coord_y)) + '" '  &
//			  			  + 'x2="' + trim(string(k_coord_x)) + '" '  &
//			 			  + 'y2="' + trim(string(k_altezza)) + '" '  &
//			 			  + 'name=l_1 visible="1" pen.style="5" ' &
//						  + 'pen.width="' + trim(string(k_spessore)) + '" '  &
//						  + 'pen.color="0"  background.mode="2" background.color="1073741824" )'
//						 
//			k_rc=tab_1.tabpage_1.dw_1.modify('create ' + trim(k_add_line)) 
			k_rc=tab_1.tabpage_1.dw_1.modify('create line(band=footer x1="10" y1="10" x2="274" y2="232"  name=l_1 visible="1" pen.style="0" pen.width="1000" pen.color="0"  background.mode="2" background.color="1073741824" )')
//
////			Printline(k_id_print, k_coord_x, k_coord_y, k_coord_x, k_altezza, k_spessore)
//		end if
//		k_coord_x = k_coord_x + k_spessore
//		
//	next
//
//
//for k_ctr = 0 to 12
//	
//	for k_ctr1 = 1 to 9
//      if mid(k_char_barcode[k_ctr,1],k_ctr1,1) = 'n' then
//			k_spessore = 100
//		else
//			k_spessore = 25
//		end if
//		
//      if mid(k_char_bar_sp,k_ctr1,1) = 'b' then
//			
//         k_add_line = 'line(band=detail '  &
//			           + 'x1="' + trim(string(k_coord_x)) + '" '  &
//		              + 'y1="' + trim(string(k_coord_y)) + '" '  &
//			  			  + 'x2="' + trim(string(k_coord_x)) + '" '  &
//			 			  + 'y2="' + trim(string(k_altezza)) + '" '  &
//			 			  + 'name=l_1 visible="1" pen.style="5" ' &
//						  + 'pen.width="' + trim(string(k_spessore)) + '" '  &
//						  + 'pen.color="0"  background.mode="2" background.color="0" )'
//						 
//			tab_1.tabpage_1.dw_1.modify('create ' + trim(k_add_line)) 
////			Printline(k_id_print, k_coord_x, k_coord_y, k_coord_x, k_altezza, k_spessore)
//		end if
//		k_coord_x = k_coord_x + k_spessore
//		
//	next
//next
//
//	for k_ctr1 = 1 to 9
//      if mid(k_char_barcode[39,1],k_ctr1,1) = 'n' then
//			k_spessore = 10
//		else
//			k_spessore = 25
//		end if
//		
//      if mid(k_char_bar_sp,k_ctr1,1) = 'b' then
//			
//         k_add_line = 'line(band=detail ' &
//			           + 'x1="' + trim(string(k_coord_x)) + '" ' &
//		              + 'y1="' + trim(string(k_coord_y)) + '" '  &
//			  			  + 'x2="' + trim(string(k_coord_x)) + '" '  &
//			 			  + 'y2="' + trim(string(k_altezza)) + '" '  &
//			 			  + 'name=l_1 visible="1" pen.style="5" ' &
//						  + 'pen.width="' + trim(string(k_spessore)) + '" '  &
//						  + 'pen.color="0"  background.mode="2" background.color="0" )'
//						 
//			tab_1.tabpage_1.dw_1.modify('create ' + trim(k_add_line)) 
////			Printline(k_id_print, k_coord_x, k_coord_y, k_coord_x, k_altezza, k_spessore)
//		end if
//		k_coord_x = k_coord_x + k_spessore
//		
//	next
//
//
////PrintClose(k_id_print)
//
//
//
//
end subroutine

on w_stampa_barcode.create
call super::create
end on

on w_stampa_barcode.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type cb_ritorna from w_g_tab_3`cb_ritorna within w_stampa_barcode
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_stampa_barcode
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_stampa_barcode
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_stampa_barcode
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_stampa_barcode
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_stampa_barcode
end type

type tab_1 from w_g_tab_3`tab_1 within w_stampa_barcode
integer width = 1595
end type

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
integer width = 1559
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
integer width = 1504
string dataobject = "d_etich_ped"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_1::clicked;//
//
// stampa codice a barre standard CODE 39
//
// 1'' (inches) = 2,54 cm 
// ogni carattere è composto da 5 barre e 4 spazi (=9 elementi)
// ogni elemento può essere fine o grosso (narrow o wide)
// 3 dei 9 elementi deve essere wide (ecco xchè si chiama 'code 39')
// la tabella k_char_barcode è di 44, ogni stringa contiene 9 caratteri che indicano 
// la sequenza 'sottile' e 'grosso' iniziando dall'elemento barra poi spazio poi barra ecc... 
// la codebar intera è composta da una zona franca di almeno 0,1'' + il carattere di 
// inizio '*' + il codice + il carattere di fine '*' + zona franca di almeno 0,1''
string k_char_barcode[0 to 43, 0 to 1], k_char_bar_sp=""
long k_id_print=0
int k_coord_x=0, k_coord_y=0, k_spessore=0, k_altezza=0
int k_ctr=0, k_ctr1=0, k_num_line=0
string k_add_line, k_rc

                                  k_char_bar_sp='bsbsbsbsb'
k_char_barcode[00,0]='0';  k_char_barcode[00,1]='nnnwwnwnn'
k_char_barcode[01,0]='1';  k_char_barcode[01,1]='wnnwnnnnw'
k_char_barcode[02,0]='2';  k_char_barcode[02,1]='nnwwnnnnw'
k_char_barcode[03,0]='3';  k_char_barcode[03,1]='wnwwnnnnn'
k_char_barcode[04,0]='4';  k_char_barcode[04,1]='nnnwwnnnw'
k_char_barcode[05,0]='5';  k_char_barcode[05,1]='wnnwwnnnn'
k_char_barcode[06,0]='6';  k_char_barcode[06,1]='nnwwwnnnn'
k_char_barcode[07,0]='7';  k_char_barcode[07,1]='nnnwnnwnw'
k_char_barcode[08,0]='8';  k_char_barcode[08,1]='wnnwnnwnn'
k_char_barcode[09,0]='9';  k_char_barcode[09,1]='nnwwnnwnn'
k_char_barcode[10,0]='a';  k_char_barcode[10,1]='wnnnnwnnw'
k_char_barcode[11,0]='b';  k_char_barcode[11,1]='nnwnnwnnw'
k_char_barcode[12,0]='c';  k_char_barcode[12,1]='wnwnnwnnn'
k_char_barcode[13,0]='d';  k_char_barcode[13,1]='nnnnwwnnw'
k_char_barcode[14,0]='e';  k_char_barcode[14,1]='wnnnwwnnn'
k_char_barcode[15,0]='f';  k_char_barcode[15,1]='nnwnwwnnn'
k_char_barcode[16,0]='g';  k_char_barcode[16,1]='nnnnnwwnw'
k_char_barcode[17,0]='h';  k_char_barcode[17,1]='wnnnnwwnn'
k_char_barcode[18,0]='i';  k_char_barcode[18,1]='nnwnnwwnn'
k_char_barcode[19,0]='j';  k_char_barcode[19,1]='nnnnwwwnn'
k_char_barcode[20,0]='k';  k_char_barcode[20,1]='wnnnnnnww'
k_char_barcode[21,0]='l';  k_char_barcode[21,1]='nnwnnnnww'
k_char_barcode[22,0]='m';  k_char_barcode[22,1]='wnwnnnnwn'
k_char_barcode[23,0]='n';  k_char_barcode[23,1]='nnnnwnnww'
k_char_barcode[24,0]='o';  k_char_barcode[24,1]='wnnnwnnwn'
k_char_barcode[25,0]='p';  k_char_barcode[25,1]='nnwnwnnwn'
k_char_barcode[26,0]='q';  k_char_barcode[26,1]='nnnnnnwww'
k_char_barcode[27,0]='r';  k_char_barcode[27,1]='wnnnnnwwn'
k_char_barcode[28,0]='s';  k_char_barcode[28,1]='nnwnnnwwn'
k_char_barcode[29,0]='t';  k_char_barcode[29,1]='nnnnwnwwn'
k_char_barcode[30,0]='u';  k_char_barcode[30,1]='wwnnnnnnw'
k_char_barcode[31,0]='v';  k_char_barcode[31,1]='nwwnnnnnw'
k_char_barcode[32,0]='w';  k_char_barcode[32,1]='wwwnnnnnn'
k_char_barcode[33,0]='x';  k_char_barcode[33,1]='nwnnwnnnw'
k_char_barcode[34,0]='y';  k_char_barcode[34,1]='wwnnwnnnn'
k_char_barcode[35,0]='z';  k_char_barcode[35,1]='nwwnwnnnn'
k_char_barcode[36,0]='-';  k_char_barcode[36,1]='nwnnnnwnw'
k_char_barcode[37,0]='.';  k_char_barcode[37,1]='wwnnnnwnn'
k_char_barcode[38,0]=' ';  k_char_barcode[38,1]='nwwnnnwnn'
k_char_barcode[39,0]='*';  k_char_barcode[39,1]='nwnnwnwnn'
k_char_barcode[40,0]='$';  k_char_barcode[40,1]='nwnwnwnnn'
k_char_barcode[41,0]='/';  k_char_barcode[41,1]='nwnwnnnwn'
k_char_barcode[42,0]='+';  k_char_barcode[42,1]='nwnnnwnwn'
k_char_barcode[43,0]='%';  k_char_barcode[43,1]='nnnwnwnwn'




//k_id_print = PrintOpen( )

//tab_1.tabpage_1.dw_1.print(k_id_print, 0, 0)

k_num_line= 0
k_coord_x = 950 //950   
k_coord_y = 3400 // 3530
k_altezza = 1500 + k_coord_y   //1600

	for k_ctr1 = 1 to 9
      if MidA(k_char_barcode[39,1],k_ctr1,1) = 'n' then
			k_spessore = 10
		else
			k_spessore = 25
		end if
		
      if MidA(k_char_bar_sp,k_ctr1,1) = 'b' then
			
			k_num_line ++
         k_add_line = 'create line(band=detail '  &
			           + 'x1="' + trim(string(k_coord_x)) + '" '  &
		              + 'y1="' + trim(string(k_coord_y)) + '" '  &
			  			  + 'x2="' + trim(string(k_coord_x)) + '" '  &
			 			  + 'y2="' + trim(string(k_altezza)) + '" '  &
			 			  + 'name=l_' + trim(string(k_num_line)) + ' visible="1" pen.style="0" ' &
						  + 'pen.width="' + trim(string(k_spessore)) + '" '  &
						  + 'pen.color="0"  background.mode="2" background.color="0" )'

						 
			k_rc=tab_1.tabpage_1.dw_1.modify(k_add_line) 

		end if
		k_coord_x = k_coord_x + k_spessore
		
	next


for k_ctr = 0 to 12
	
	for k_ctr1 = 1 to 9
      if MidA(k_char_barcode[k_ctr,1],k_ctr1,1) = 'n' then
			k_spessore = 100
		else
			k_spessore = 25
		end if
		
      if MidA(k_char_bar_sp,k_ctr1,1) = 'b' then
			
			k_num_line ++
         k_add_line = 'create line(band=detail '  &
			           + 'x1="' + trim(string(k_coord_x)) + '" '  &
		              + 'y1="' + trim(string(k_coord_y)) + '" '  &
			  			  + 'x2="' + trim(string(k_coord_x)) + '" '  &
			 			  + 'y2="' + trim(string(k_altezza)) + '" '  &
			 			  + 'name=l_' + trim(string(k_num_line)) + ' visible="1" pen.style="0" ' &
						  + 'pen.width="' + trim(string(k_spessore)) + '" '  &
						  + 'pen.color="0"  background.mode="2" background.color="0" )'
						 
			k_rc=tab_1.tabpage_1.dw_1.modify(k_add_line) 
//			Printline(k_id_print, k_coord_x, k_coord_y, k_coord_x, k_altezza, k_spessore)
		end if
		k_coord_x = k_coord_x + k_spessore
		
	next
next

	for k_ctr1 = 1 to 9
      if MidA(k_char_barcode[39,1],k_ctr1,1) = 'n' then
			k_spessore = 10
		else
			k_spessore = 25
		end if
		
      if MidA(k_char_bar_sp,k_ctr1,1) = 'b' then
			
			
			k_num_line ++
         k_add_line = 'create line(band=detail '  &
			           + 'x1="' + trim(string(k_coord_x)) + '" '  &
		              + 'y1="' + trim(string(k_coord_y)) + '" '  &
			  			  + 'x2="' + trim(string(k_coord_x)) + '" '  &
			 			  + 'y2="' + trim(string(k_altezza)) + '" '  &
			 			  + 'name=l_' + trim(string(k_num_line)) + ' visible="1" pen.style="0" ' &
						  + 'pen.width="' + trim(string(k_spessore)) + '" '  &
						  + 'pen.color="0"  background.mode="2" background.color="0" )'
						 
			k_rc=tab_1.tabpage_1.dw_1.modify(k_add_line) 
//			Printline(k_id_print, k_coord_x, k_coord_y, k_coord_x, k_altezza, k_spessore)
		end if
		k_coord_x = k_coord_x + k_spessore
		
	next


//PrintClose(k_id_print)




end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
boolean visible = false
integer width = 1559
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
end type

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
integer width = 1559
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
end type

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
integer width = 1559
end type

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
end type

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
integer width = 1559
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
end type

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

