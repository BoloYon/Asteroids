@echo off
set /p msg=Enter commit message: 
call git add .
call git commit
call git push