@echo off

setlocal enabledelayedexpansion

set FULLIMAGE=kalifullimage.tar
set FULLIMAGESPLIT=kalifullimage_split.7z.001
set EXPECTED_HASH=8f9fb198df5d48cac3e1a529e754e807dfa4b1f73f2594368bbb41aec3e595d9
set IMAGENAME=kalifullimage
set CONTAINERNAME=kaliSylosFiore


echo =============================================
echo   DOCKER STATUS CHECK
echo =============================================
echo.

:: Verifica se Docker è installato
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [NOT FOUND] Docker non installato oppure non in PATH.
    echo.
    echo Installa Docker Desktop da https://www.docker.com/products/docker-desktop
    pause
    exit /b 1
)

:: Mostra la versione
for /f "tokens=*" %%v in ('docker --version 2^>nul') do echo Versione Docker: %%v

:: Verifica se il servizio Docker è in esecuzione
echo.
echo Verifico lo stato del servizio Docker...
docker info >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] Servizio Docker in esecuzione.
) else (
    echo [ERROR] Docker installato ma servizio non in esecuzione.
    echo Avvia Docker Desktop.
    pause
    exit /b 1
)

:: Carica l'immagine se non presente
echo.
echo Verifico l'immagine %IMAGENAME%...
docker image inspect %IMAGENAME% >nul 2>&1
if %errorlevel%==0 (
    echo [OK] %IMAGENAME% presente
) else (

    echo [MISSING] %IMAGENAME% non presente

    :: Verifica se il file immagine è nella directory corrente
    echo Verifico la presenza del file immagine...
    if exist "%FULLIMAGE%" (
        echo [OK] File immagine %FULLIMAGE% nella cartella corrente
    ) else (
        echo [MISSING] File immagine %FULLIMAGE% non presente nella cartella corrente. Tento la ricostruzione
        7zr x %FULLIMAGESPLIT%
        if exist "%FULLIMAGE%" (
            echo [OK] File immagine %FULLIMAGE% ricostruito nella cartella corrente
        ) else (
            echo [ERROR] Impossibile ricostruire il file immagine %FULLIMAGE% nella cartella corrente
            pause
            exit /b 1
        )
    )

    :: Verifica se il file immagine è integro
    echo.
    echo Verifico la checksum del file immagine...
    for /f "tokens=1 delims= " %%H in ('certutil -hashfile "%FULLIMAGE%" SHA256 ^| find /v ":"') do (
        set CALC_HASH=%%H
    )
    if /I "!CALC_HASH!"=="%EXPECTED_HASH%" (
        echo [OK] File immagine integro
    ) else (
        echo [ERRORE] Il file immagine non integro
        echo Atteso:  %EXPECTED_HASH%
        echo Calcolato: %CALC_HASH%
        pause
        exit /b 1
    )

    echo Carico l'immagine %IMAGENAME%...
    docker load -i "%FULLIMAGE%"
    :: Verifica che l'immagine sia stata installata
    timeout /t 5 /nobreak >nul
    docker image inspect %IMAGENAME% >nul 2>&1
    if %errorlevel%==0 (
        echo [OK] %IMAGENAME% installata
    ) else (
        echo [ERROR] Errore durante il caricamento dell'immagine %IMAGENAME%
        pause
        exit /b 1
    )
)

:: Installa il container se non presente
echo.
echo Verifico il container %CONTAINERNAME%...
docker container inspect %CONTAINERNAME% >nul 2>&1
if %errorlevel%==0 (
    echo [OK] %CONTAINERNAME% presente

    :: Installa il container se non presente
    echo.
    echo Avvio il container %CONTAINERNAME% e mi collego al terminale...
    docker start %CONTAINERNAME%
    docker attach %CONTAINERNAME%
) else (
    echo [MISSING] Installo il container %CONTAINERNAME%...
    docker run --tty --interactive -p 3390:3390 -p 5000:5000 --name %CONTAINERNAME% %IMAGENAME%
    :: Verifica che il container sia stato installato
    docker container inspect %CONTAINERNAME% >nul 2>&1
    if %errorlevel%==0 (
        echo [OK] %CONTAINERNAME% installato
    )
)
