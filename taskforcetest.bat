@echo off

::JAVA environment
set LIB_OPTS="-Dcatalina.ext.dirs=$CATALINA_HOME/shared/lib:$CATALINA_HOME/common/lib"
set JAVA_OPTS=%JAVA_OPTS% %LIB_OPTS% -Xmx1024m -Xms1024m -XX:PermSize=1024m -XX:MaxPermSize=1024m -XX:+UseParallelGC -XX:ParallelGCThreads=4 -XX:-UseSplitVerifier
set CATALINA_OPTS=%CATALINA_OPTS% -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.autodiscovery=true -Djava.rmi.server.hostname=127.0.0.1 -Dcom.sun.management.jmxremote.port=9999 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false
set CATALINA_HOME="F:\Setup\apache-tomcat-9.0.8-windows-x86\apache-tomcat-9.0.8"

:: set all path of project need to build
set root_project_path="F:\Workspace\sourceCode"
set root_tomcat_path="F:\Setup\apache-tomcat-9.0.8-windows-x86\apache-tomcat-9.0.8"
set root_file_build_path="F:\Setup\apache-tomcat-9.0.8-windows-x86\apache-tomcat-9.0.8"

:: Get input from user
::set /p project_name=Directory name:
::echo %project_name%

set project_full_path=%cd%

set optimproject="optim"

doskey ls=dir /b $*
doskey ll=dir $*
doskey cat=type $*
doskey ..=cd..
doskey grep=find "$1" $2
doskey mv=ren $*
doskey rm=del $*

::project alias
doskey projectbuild=%root_file_build_path%"\projectbuild.bat"
::tomcat alias
::doskey tombin=cd %root_tomcat_path%\bin
::alias for remove all extracted folder in webapps
doskey remove_dcm_project=rmdir /S /Q %root_tomcat_path%"\webapps\"%project_name%

echo stoptom
::pkill -9 -f tomcat
::FOR /F "tokens=4 delims= " %%P IN ('netstat -a -n -o ^| findstr :8080') DO @ECHO TaskKill.exe /PID %%P
::for /f "skip=1 tokens=5" %1 in ('netstat -aon ^| find "8080"') do taskkill /F /PID %1 –
:: "%root_tomcat_path%\bin\shutdown.bat" run
:: delete folder in webapps

:optim
echo projectbuild
rmdir /S /Q %project_full_path%\target
call projectbuild
if %errorlevel% neq 0 exit /b %errorlevel%
echo remove projects deployed
::rmdir /S /Q %root_tomcat_path%"\webapps\"%project_name%
rmdir /S /Q %root_tomcat_path%"\webapps\"*.war
:: copy war to tomcat
echo copywar
echo path:%project_full_path%\target\*.war
xcopy %project_full_path%\target\*.war %root_tomcat_path%\webapps /Y
if %errorlevel% neq 0 exit /b %errorlevel%


::start tomcat
echo tomcat starting
"%root_tomcat_path%\bin\catalina.bat" jpda run

:: end
::pause
