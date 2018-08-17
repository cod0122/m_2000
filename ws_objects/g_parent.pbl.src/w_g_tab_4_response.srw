$PBExportHeader$w_g_tab_4_response.srw
forward
//    <one line to give the program's name and a brief idea of what it does.>
//    Copyright (C) 2010  ALBERTO TREBBI
//
//    This program (M2000) is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <http://www.gnu.org/licenses/>.
global type w_g_tab_4_response from w_g_tab
end type
end forward

global type w_g_tab_4_response from w_g_tab
string title = "WINDOWS STANDARD RESPONSE"
string menuname = ""
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
end type
global w_g_tab_4_response w_g_tab_4_response

on w_g_tab_4_response.create
call super::create
end on

on w_g_tab_4_response.destroy
call super::destroy
end on

type cb_ritorna from w_g_tab`cb_ritorna within w_g_tab_4_response
end type

type st_stampa from w_g_tab`st_stampa within w_g_tab_4_response
end type

