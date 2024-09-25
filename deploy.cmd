@echo off

call user_config.cmd

set user_wpswd=rokudev:%user_pass%


echo Deploying the project to the device...


set package_name=deply.zip
set manifest_file=manifest

set target_directory=.\
set zipper=7z
set transfer_tool=curl
%transfer_tool% -X POST http://%device_ip%:8060/keypress/HOME

echo "Delete the old package if exists"
if exist %target_directory%\%package_name% erase /F %target_directory%\%package_name%

echo "Creating the package"

%zipper% a -mx0 -r -tzip %package_name% %target_directory%\components\
%zipper% u -mx9 -tzip %package_name% %target_directory%\%manifest_file%
%zipper% u -mx9 -tzip %package_name% %target_directory%\resources\
%zipper% u -mx9 -tzip %package_name% %target_directory%\source\


%transfer_tool% -X POST -s -S http://%device_ip%:8060/keypress/HOME
ping 127.0.0.1 -n 10 > nul
echo "Deploying package %package_name% to the host %device_ip%"
%transfer_tool% --user %user_wpswd% --digest -s -S -F "mysubmit=Install" -F "archive=@./%package_name%" -F "passwd=" http://%device_ip%/plugin_install

exit /B
:no_settings
echo ERROR: IP address missing- Example usage: deploy 10.24.24.123
goto :exit_with_error

:exit_with_error
echo Error occurred.