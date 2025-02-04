@echo off
cd /d "D:\Personal Projects\movie-app"
start /b "" cmd /c "npm run dev"
timeout /t 5 >nul
start http://localhost:3000/
exit