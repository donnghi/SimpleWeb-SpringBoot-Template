cmd /c 
::cd %project_full_path%
echo Build Project
call mvn clean install -Pdev -Dmaven.test.skip=true

:: end
::pause