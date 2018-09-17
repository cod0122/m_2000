echo COMPILAZIONE POWER BUILDER 
echo pause

echo compilazione:

echo  cd "\Sterigenics\icone" 
echo  pbc170.exe /d "C:\Sterigenics\app\m_2000.pbt" /o "C:\Sterigenics\app\m_2000.exe" /r "C:\Sterigenics\icone\g_m2000.pbr" /w n /f /m n /x 32 /bg y /p "PowerBuilder Enterprise Series" /cp "Appeon" /de "Appeon Product File" /v "18.09.17.1" /fv "18.09.17.1" /ge 0

echo  da cmd C:\Program Files (x86)\Windows Kits\10\bin\10.0.16299.0\x86 fare la signature del programma
C:"\Program Files (x86)\Windows Kits\10\bin\10.0.16299.0\x86\SignTool" sign /fd SHA1 /a /f C:\Sterigenics\cert\m2000Cert.pfx /p cinacina C:\Sterigenics\app\m_2000.exe

pause