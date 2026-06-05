@echo off
chcp 65001 >nul
cd /d "%~dp0"

echo 正在启动网站服务...
echo 本机访问: http://127.0.0.1:8080/index.html
echo 局域网访问: 将下面命令中的 IP 换成本机 IPv4 地址
echo   http://192.168.x.x:8080/index.html
echo 停止服务: 关闭本窗口，或在窗口内按 Ctrl 键再按 C 键
echo.

set "PY_CMD="
where python >nul 2>&1
if %errorlevel%==0 set "PY_CMD=python"

if not defined PY_CMD (
  where py >nul 2>&1
  if %errorlevel%==0 set "PY_CMD=py -3"
)

if not defined PY_CMD (
  echo [错误] 未找到 Python。请先安装 Python 并勾选 Add Python to PATH
  echo 下载: https://www.python.org/downloads/
  echo.
  pause
  exit /b 1
)

echo 使用命令: %PY_CMD% -m http.server ...
echo.
%PY_CMD% -m http.server 8080 --bind 0.0.0.0
if errorlevel 1 pause
