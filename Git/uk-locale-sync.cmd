@echo off
REM Author: Dr Jon Nicholson
REM 
REM Copyright 2016 ZiNET Data Solutions Limited, UK
REM 
REM Licensed under the Apache License, Version 2.0 (the "License");
REM you may not use this file except in compliance with the License.
REM You may obtain a copy of the License at
REM 
REM     http://www.apache.org/licenses/LICENSE-2.0
REM 
REM Unless required by applicable law or agreed to in writing, software
REM distributed under the License is distributed on an "AS IS" BASIS,
REM WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
REM See the License for the specific language governing permissions and
REM limitations under the License.

SETLOCAL EnableDelayedExpansion

set ORIGIN=https://github.com/Access4LearningUK
set UPSTREAM=https://github.com/Access4Learning
set REPOSITORIES=
set BRANCHES=develop
SET ERROR=0

echo.
echo Syncing A4L (UK) repositories
echo -----------------------------
echo Uses:
echo - origin repositories from %ORIGIN%, and
echo - upstream repositories from %UPSTREAM%
echo Syncs branches:
echo - master,%BRANCHES%
echo.

choice /c 123X /n /m "Which frameworks do you want to sync? [1] Java, [2] .NET, [3] both, [X] to quit:   "
if errorlevel 4 goto end
if errorlevel 3 set REPOSITORIES=sif3-framework-dotnet,sif3-framework-java
if errorlevel 2 set REPOSITORIES=sif3-framework-dotnet
if errorlevel 1 set REPOSITORIES=sif3-framework-java

for %%D in (%REPOSITORIES%) do (
	echo.
	echo - Syncing '%%D'
	
	if exist %%D (
		echo -- Repository found, no need to clone
	) else (
		echo -- Cloning repository from %ORIGIN%/%%D.git
		git clone %ORIGIN%/%%D.git
		
		if !ERRORLEVEL! NEQ 0 goto error
		
		echo.
		cd %%D
		echo -- Adding upstream %UPSTREAM%/%%D.git
		git remote add upstream %UPSTREAM%/%%D.git
		
		if !ERRORLEVEL! NEQ 0 goto error
		
		echo.
		echo -- Adding all branches in %BRANCHES%
		for %%B in (%BRANCHES%) do (
			git checkout -b %%B origin/%%B
			
			if !ERRORLEVEL! NEQ 0 goto error
		)
		
		cd ..
	)
	
	cd %%D
	
	for %%B in (master,%BRANCHES%) do (
		echo.
		echo - Checkout %%B
		git checkout %%B
		
		if !ERRORLEVEL! NEQ 0 goto error
		
		echo.
		echo - Pulling from origin
		git pull origin %%B
		
		if !ERRORLEVEL! NEQ 0 goto error
		
		echo.
		echo - Pulling from upstream
		git pull upstream %%B
		
		if !ERRORLEVEL! NEQ 0 goto error
		
		echo.
		echo - Pushing to origin
		git push origin %%B
		
		if !ERRORLEVEL! NEQ 0 goto error
		
		echo.
		echo -- Finished %%D/%%B
	)
	
	cd ..
	
	echo.
	echo -- Finished %%D
	echo.
)

goto end

:error
echo.
echo Last command returned an error. Quitting until it's resolved.
echo.

:end