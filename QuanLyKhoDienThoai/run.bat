@echo off
REM Script để chạy ứng dụng Quản Lý Kho Điện Thoại
cd /d "%~dp0"

echo.
echo ========================================
echo   QUẢN LÝ KHO ĐIỆN THOẠI - Startup
echo ========================================
echo.

REM Kiểm tra thư mục build/classes tồn tại
if not exist "build\classes" (
    echo ❌ Lỗi: Thư mục build\classes không tồn tại!
    echo.
    echo 💡 Vui lòng biên dịch dự án trước bằng cách:
    echo    - Mở build.xml trong NetBeans hoặc
    echo    - Gọi: ant clean build
    echo.
    pause
    exit /b 1
)

echo ✅ Đang khởi động ứng dụng...
echo 📁 Thư mục: %cd%
echo.

REM Tạo classpath - Add all JARs từ lib và lib/lib
setlocal enabledelayedexpansion
set CLASSPATH=build\classes
for /r lib %%A in (*.jar) do (
    set CLASSPATH=!CLASSPATH!;%%A
)

REM Chạy ứng dụng
java -cp "%CLASSPATH%" GUI.Log_In

if %ERRORLEVEL% neq 0 (
    echo.
    echo ❌ Lỗi: Ứng dụng không thể khởi động (Error Code: %ERRORLEVEL%)
    pause
) else (
    echo.
    echo ✅ Ứng dụng đã thoát thành công
)

endlocal
