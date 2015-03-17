echo %EMULATED%
IF "%EMULATED%" EQU "true" (
	GOTO:EOF
)

%windir%\system32\inetsrv\appcmd set config -section:applicationPools -applicationPoolDefaults.processModel.idleTimeout:00:00:00
%windir%\system32\inetsrv\appcmd set config -section:applicationPools -applicationPoolDefaults.recycling.periodicRestart.time:00:00:00

REM   Attempt to set the execution policy by using PowerShell version 3.0 syntax.
PowerShell -Version 3.0 -ExecutionPolicy Unrestricted .\Execute-StartupTasks.ps1 >> "%TEMP%\StartupLog.txt" 2>&1
