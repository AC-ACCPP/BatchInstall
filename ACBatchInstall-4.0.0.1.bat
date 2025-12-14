@echo off
@setlocal enableextensions
@cd /d "%~dp0"
del %CD%\temp1.txt %CD%\temp2.txt %CD%\temp3.txt %CD%\temp4.txt
mode con:cols=140 lines=40
for /f "tokens=4-7 delims=[.] " %%i in ('ver') do (if %%i==Version (set v=%%j.%%k) else (set v=%%i.%%j))
if _%1_==_payload_  goto :payload

:getadmin
    echo %~nx0: elevating self
    set vbs=%temp%\getadmin.vbs
    echo Set UAC = CreateObject^("Shell.Application"^)                >> "%vbs%"
    echo UAC.ShellExecute "%~s0", "payload %~sdp0 %*", "", "runas", 1 >> "%vbs%"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
goto :eof

:payload
echo                                      xxxxxxxxxxxxxxxxxxxxx                       
echo                              xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo                         xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                   
echo                     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx               
echo                   xxxxxxxxxxxxxxx                        xxxxxxxxxxxxxxxx            
echo                xxxxxxxxxxxxx        xxxxxxxxxxxxx             xxxxxxxxxxxxx          
echo              xxxxxxxxxxxx       xxxxxx        xxx                xxxxxxxxxxxxx       
echo            xxxxxxxxxxx     xxxxxxx          xxxxx                    xxxxxxxxxx      
echo           xxxxxxxxxx     xxxxxxxx      xxxxxxxxxxxxxxxxxxx           xxxxxxxxxxx    
echo         xxxxxxxxxx    xxxxxxxx      xxxxxxxxxxxxxxxxxxxxxx              xxxxxxxxxx   
echo        xxxxxxxxxx    xxxxxx      xxxxxxxxxxxx          xxx                xxxxxxxxx  
echo        xxxxxxxxx    xxxxx      xxxxxxxxxx            xxxxx                 xxxxxxxxx
echo       xxxxxxxx    xxxxxx     xxxxxxxxxx        xxxxxxxxxxxxxxxxxxxxxxxx     xxxxxxxxx
echo       xxxxxxxx    xxxxx     xxxxxxxxx        xxxxxxxxxx   xxxxxx    xxxxx    xxxxxxxx
echo      xxxxxxxxx   xxxxx      xxxxxxxxx      xxxxxxxxx      xxxxx      xxxx    xxxxxxxx
echo      xxxxxxxx    xxxx       xxxxxxxxx     xxxxxxxx        xxxxx      xxxx    xxxxxxxx
echo      xxxxxxxx    xxxx       xxxxxxxxx     xxxxxxxx        xxxxx     xxxxx    xxxxxxxx
echo      xxxxxxxx    xxxx       xxxxxxxxx     xxxxxxxx        xxxxx xxxxxxxx     xxxxxxxx
echo      xxxxxxxx    xxxx       xxxxxxxxx     xxxxxxxx        xxxxxxxxxx         xxxxxxxx
echo      xxxxxxxxx    xxxx       xxxxxxxx      xxxxxxx        xxxxx  xxxxxxx     xxxxxxxx
echo       xxxxxxxx     xxxx       xxxxxxxx      xxxxxxx       xxxxx   xxx xxx   xxxxxxxxx
echo       xxxxxxxx      xxx        xxxxxxxx      xxxxxx       xxxxx   xxxxxx   xxxxxxxxx 
echo        xxxxxxxxx      xxxx       xxxxxxxxx     xxxxxxx            xxx     xxxxxxxxx  
echo         xxxxxxxxx       xxxx      xxxxxxxxx       xxxxxx          xxx    xxxxxxxxx   
echo          xxxxxxxxxx        xxx       xxxxxxxx        xxxxxx            xxxxxxxxxx    
echo            xxxxxxxxxx         xxx       xxxxxxx          xxxxx       xxxxxxxxxxx     
echo             xxxxxxxxxxx                   xxxxxxx                 xxxxxxxxxxx     
echo                xxxxxxxxxxxx                   xxxxxxx           xxxxxxxxxxxx         
echo                  xxxxxxxxxxxxxxx                  xxxxxxxxxxxxxxxxxxxxxxxx 
echo                     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx              
echo                        xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                   
echo                            xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                      
echo                                    xxxxxxxxxxxxxxxxxxxxx                 
echo                                                                           (v.4.0.0.2)
echo.
echo.
echo Checking currently installed files, this may take a moment...
wmic /output:temp3.txt product get Name

@echo off

reg export HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall temp1.txt >nul
find "Asheron's Call" temp1.txt| find "DisplayName" > temp2.txt
for /f "tokens=2,3 delims==" %%a in (temp2.txt) do (echo %%a > temp4.txt)


del %CD%\temp1.txt %CD%\temp2.txt

reg export HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node temp1.txt >nul
find "Decal 3.0" temp1.txt| find "DisplayName" > temp2.txt
for /f "tokens=2,3 delims==" %%a in (temp2.txt) do (echo %%a >> temp4.txt)

del %CD%\temp1.txt %CD%\temp2.txt

reg export HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall temp1.txt >nul
find "MSXML" temp1.txt| find "DisplayName" > temp2.txt
for /f "tokens=2,3 delims==" %%a in (temp2.txt) do (echo %%a >> temp4.txt)

del %CD%\temp1.txt %CD%\temp2.txt

reg export HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DirectX temp1.txt >nul
find "4.09.00.0904" temp1.txt| find "Version" > temp2.txt
for /f "tokens=2,3 delims==" %%a in (temp2.txt) do (echo "DirectX 9.0c" >> temp4.txt)

del %CD%\temp1.txt %CD%\temp2.txt

reg export "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup" temp1.txt >nul
find "4.8.04084" temp1.txt| find "Version" > temp2.txt
for /f "tokens=2,3 delims==" %%a in (temp2.txt) do (echo "Microsoft .NET Framework 4.0" >> temp4.txt)

del %CD%\temp1.txt %CD%\temp2.txt

cmd /c dism /online /get-featureinfo /featurename:NetFx3 > temp1.txt
find "State : Enabled" temp1.txt > temp2.txt
echo "Microsoft .NET Framework 3.5" >> temp4.txt

del %CD%\temp1.txt %CD%\temp2.txt

find "Thwarglauncher" temp3.txt > temp2.txt
echo "Thwarglauncher" >> temp4.txt

del %CD%\temp1.txt %CD%\temp2.txt

find "MSXML 4.0 SP3 Parser" temp3.txt > temp2.txt
echo "MSXML 4.0 SP3 Parser" >> temp4.txt

del %CD%\temp1.txt %CD%\temp2.txt

find "MSXML 4.0 SP2 Parser and SDK" temp3.txt > temp2.txt
echo "MSXML 4.0 SP2 Parser and SDK" >> temp4.txt

del %CD%\temp1.txt %CD%\temp2.txt

find "Microsoft Visual C++ 2005 Redistributable" temp3.txt > temp2.txt
echo "Microsoft Visual C++ 2005 Redistributable" >> temp4.txt

del %CD%\temp1.txt %CD%\temp2.txt %CD%\temp3.txt

goto curl_Check

:curl_Check
	IF EXIST C:\Windows\System32\curl.exe (
		goto install 
	) else (
		echo Curl is not currently installed, please visit https://curl.se/download.html before continuing the installation...)
    		pause >nul
		goto install
	)

:install
	echo.
	echo.
	echo Asheron's Call and Decal Plugins work best when using the default directories, so please keep that in mind during installation
	pause
	echo.
	echo.
	goto ac_Check

:ac_Check
	findstr /m "Asheron's Call" temp4.txt >Nul
	if %errorlevel%==0 (
		goto ac_Reinstall
	) else (
		goto ac_Download
	)

:ac_Reinstall
	echo Asheron's Call has already been installed on this machine
        :PROMPT
	SET /P AREYOUSURE=Do you want to re-install Asheron's Call (Y/[N])?
	IF /I "%AREYOUSURE%" NEQ "Y" GOTO directX_Check
	goto ac_Download

:ac_Download
	echo.
	echo.
	echo Downloading Asheron's Call from WebArchive, this may take a few minutes...
	curl.exe --output "%CD%\ac1install.exe" --url https://web.archive.org/web/20201121104423/http://content.turbine.com/sites/clientdl/ac1/ac1install.exe
	echo Download complete
	echo Launching the installer...
	"%CD%\ac1install.exe"
	goto ac_EOR

:directX_Check
	findstr /m "DirectX 9.0c" temp4.txt >Nul
	if %errorlevel%==0 (
		goto directX_Reinstall
	) else (
		goto directX_Download
	)

:directX_Reinstall
	echo.
	echo.
	echo DirectX 9.0c has already been installed on this machine
        :PROMPT
	SET /P AREYOUSURE=Do you want to re-install DirectX 9.0c (Y/[N])?
	IF /I "%AREYOUSURE%" NEQ "Y" GOTO visualC_Check
	goto directX_Download

:directX_Download
	echo.
	echo.
	echo Downloading DirectX 9.0
	echo Don't forget to uncheck 'Install the Bing Bar' option during install, otherwise the install will fail...
	curl.exe --output "%CD%\dxwebsetup.exe" --url https://files.treestats.net/dxwebsetup.exe
	echo Download complete
	echo Launching the installer...
	"%CD%\dxwebsetup.exe"
	echo.
	echo.
        :PROMPT
	SET /P AREYOUSURE=Did DirectX 9.0 install correctly (Y/[N])?
	IF /I "%AREYOUSURE%" NEQ "Y" GOTO directX_Download
	goto visualC_Check

:visualC_Check
	findstr /m "Microsoft Visual C++ 2005 Redistributable" temp4.txt >Nul
	if %errorlevel%==0 (
		goto visualC_Reinstall
	) else (
		goto visualC_Download
	)

:visualC_Reinstall
	echo.
	echo.
	echo Microsoft Visual C++ 2005 Service Pack 1 has already been installed on this machine
        :PROMPT
	SET /P AREYOUSURE=Do you want to re-install Microsoft Visual C++ 2005 Service Pack 1 (Y/[N])?
	IF /I "%AREYOUSURE%" NEQ "Y" GOTO net4_Check
	goto visualC_Download

:visualC_Download
	echo.
	echo.
	echo Downloading Microsoft Visual C++ 2005 Service Pack 1
	curl.exe --output "%CD%\vcredist_x86.exe" --url https://files.treestats.net/vcredist_x86.exe
	echo Download complete
	echo Launching the installer...
	"%CD%\vcredist_x86.exe"
	echo.
	echo.

:net4_Check
	findstr /m ".NET Framework 4.0" temp4.txt >Nul
	if %errorlevel%==0 (
		goto net4_Reinstall
	) else (
		goto net4_Download
	)

:net4_Reinstall
	echo.
	echo.
	echo .NET Framework 4.0 has already been installed on this machine
        :PROMPT
	SET /P AREYOUSURE=Do you want to re-install .NET Framework 4.0 (Y/[N])?
	IF /I "%AREYOUSURE%" NEQ "Y" GOTO net3.5_Check
	goto net4_Download

:net4_Download
	echo.
	echo.
	echo Downloading .NET Framework 4.0 from https://dotnet.microsoft.com/en-us/download/dotnet-framework/net40
	curl.exe --output "%CD%\dotNetFx40_Full_setup.exe" --url https://download.microsoft.com/download/1/B/E/1BE39E79-7E39-46A3-96FF-047F95396215/dotNetFx40_Full_setup.exe
	echo Download complete
	echo Launching the installer...
	"%CD%\dotNetFx40_Full_setup.exe"
	echo.
	echo.
	goto windows_Check

:windows_Check
	if %v% == 6.1 goto net3.5_Install
	if %v% == 6.0 goto net3.5_Install
	if %v% == 5.2 goto net3.5_Install
	if %v% == 5.1 goto net3.5_Install
	if %v% == 5.0 goto net3.5_Install
	if %v% == 4.10 goto net3.5_Install
goto net3.5_Feature

:net3.5_Check
	findstr /m ".NET Framework 3.5" temp4.txt >Nul
	if %errorlevel%==0 (
		goto windows_Check
	) else (
		goto decal_Check
	)

:net3.5_Install
	echo.
	echo.
	echo Downloading .NET Framework 3.5 SP1 from https://dotnet.microsoft.com/en-us/download/dotnet-framework/net35-sp1
	start "" https://dotnet.microsoft.com/en-us/download/dotnet-framework/thank-you/net35-sp1-web-installer
	echo Download complete
	echo Attempting to launch the installer...
	"%CD%\net35-sp1-web-installer.exe"
	echo.
	echo.
	goto decal_Check

:net3.5_Feature
	echo.
	echo.
	echo Enabling .NET Framework 3.5
	start cmd /c dism /online /enable-feature /featurename:NetFx3
	echo.
	echo.
	goto decal_Check

:decal_Check
	findstr /m "Decal" temp4.txt >Nul
	if %errorlevel%==0 (
		goto decal_Reinstall
	) else (
		goto decal_Download
	)

:decal_Reinstall
	echo.
	echo.
	echo Decal 3.0 has already been installed on this machine
        :PROMPT
	SET /P AREYOUSURE=Do you want to re-install Decal 3.0 (Y/[N])?
	IF /I "%AREYOUSURE%" NEQ "Y" GOTO launcher_Check
	goto decal_Download

:decal_Download
       	:PROMPT
	SET /P AREYOUSURE=Do you want to install Decal (Y/[N])?
	IF /I "%AREYOUSURE%" NEQ "Y" GOTO launcher_Check
	echo Downloading Decal 3.0, this may take a few minutes...
	start "" https://decaldev.com/
	start ""  https://www.accpp.net/latest-decal-plugins
	curl.exe --output "%CD%\Decal.msi" --url https://decaldev.com/releases/2982/Decal.msi
	echo Download complete
	echo Launching the installer...
	"%CD%\Decal.msi"
	echo.
	echo.
	echo Go ahead and set your Decal location to the C:\Turbine\Asheron's Call\ folder
	echo Once Decal opens, click options and be sure your Decal Update URL is http://update.decaldev.com 
	echo Also enable Multiple Views and Dual Log before clicking OK to return to the main screen
	echo.
	echo Click the Update button to download the latest list of supported Decal Plugins
	echo.
	pause
	goto launcher_Check

:launcher_Check
	findstr /m "Thwarglauncher" temp4.txt >Nul
	if %errorlevel%==0 (
		goto launcher_Reinstall
	) else (
		goto launcher_Download
	)
		
:launcher_Reinstall
	echo.
	echo.
	echo Thwarglauncher has already been installed on this machine
        :PROMPT
	SET /P AREYOUSURE=Do you want to re-install Thwarglauncher (Y/[N])?
	IF /I "%AREYOUSURE%" NEQ "Y" GOTO 4k_Check
	goto launcher_Download

:launcher_Download
	echo.
	echo.
	echo Downloading ThwargLauncher from http://www.thwargle.com/, this may take a few minutes...
	start "" http://www.thwargle.com/
	curl.exe --output "%CD%\ThwargLauncherInstaller.exe" --url http://www.thwargle.com/thwarglauncher/updates/ThwargLauncherInstaller.exe
	echo Download complete
	echo Launching the installer...
	"%CD%\ThwargLauncherInstaller.exe"
	echo Next you need to hit the "Browse" button and add the ThwargLauncher.dll in C:\Program Files (x86)\Thwargle Games\ThwargLauncher
	goto 4k_Check

:4k_Check
	echo.
	echo.
	echo Configuring your display settings...
	echo Asheron's Call may error in full screen mode, please press Alt+Enter at game start to EXIT fullscreen
        :PROMPT
	SET /P AREYOUSURE=Do you have a 4K monitor/display (Y/[N])?
	IF /I "%AREYOUSURE%" NEQ "Y" GOTO ac_EOR
	goto 4k_Download

:4k_Download
	echo.
	echo.
	echo 4K display setup requires additional manual configuration, please use the following tutorial by FriendlyToad...
	start "" https://youtu.be/kjC6NrfgDbc
	goto ac_EOR
	
:ac_EOR
	echo.
	echo.
	echo Manually update your C:\Turbine\Asheron's Call files with the latest files
	echo To begin, downloaded the zip and replace the files in C:\Turbine\Asheron's Call with the unzipped files
	start "" https://mega.nz/#!Q98n0BiR!p5IugPS8ZkQ7uX2A_LdN3Un2_wMX4gZBHowgs1Qomng
	pause
	goto plugin_Unblock_Check

:plugin_Unblock_Check
	echo.
	echo.
	echo If you are running old Decal plugins that were installed via .DLL, you will need to run a separate script to "Unblock" the .DLL files.
        :PROMPT
	SET /P AREYOUSURE=Do you want run the Unblock script (Y/[N])?
	IF /I "%AREYOUSURE%" NEQ "Y" GOTO completed_Installation
	goto plugin_Unblock

:plugin_Unblock
	echo.
	echo.
	echo Downloading Unblock script from ACCPP Archive for "C:\Games\"
	start "" https://github.com/AC-ACCPP/BatchInstall/releases/download/1.0.0.0/UnblockScript-1.0.0.0.ps1
	echo.
	echo.
	echo To finish unblocking files, right-click the downloaded script and run with Powershell.
	echo.
	echo.
	goto completed_Installation

:completed_Installation
 
echo.
echo.
echo Installation complete
echo.
echo.

pause
