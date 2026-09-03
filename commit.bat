@echo off
setlocal

:: Garante que corre na pasta do script
cd /d "%~dp0"

:: Valida se foi passada uma mensagem de commit
if "%~1"=="" (
    echo [ERRO] Mensagem de commit em falta.
    echo Uso: commit.bat "a tua mensagem aqui"
    exit /b 1
)

:: Configura o Git LFS para o ficheiro refman.pdf
git lfs track "refman.pdf" >nul 2>&1
git add .gitattributes

:: Adiciona todas as alteracoes
git add .

:: Faz o commit com o argumento passado
git commit -m "%~1"
if errorlevel 1 (
    echo [ERRO] O commit falhou.
    exit /b %errorlevel%
)

:: Push para o origin main
echo A enviar alteracoes para origin main...
git push origin main
if errorlevel 1 (
    echo [ERRO] O push falhou.
    exit /b %errorlevel%
)

echo.
echo Sucesso! Alteracoes enviadas para origin main.