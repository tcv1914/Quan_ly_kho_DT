# Script để chạy ứng dụng Quản Lý Kho Điện Thoại
Set-Location $PSScriptRoot

# Kiểm tra thư mục build/classes tồn tại
if (-not (Test-Path "build/classes")) {
    Write-Host "❌ Lỗi: Thư mục build/classes không tồn tại!"
    Write-Host "💡 Vui lòng biên dịch dự án trước bằng lệnh:"
    Write-Host "   javac -encoding UTF-8 -d build/classes -cp `"lib/*;lib/lib/*`" -sourcepath src (Get-ChildItem -Path src -Filter *.java -Recurse | ForEach-Object { `$_.FullName })"
    exit 1
}

# Xây dựng classpath với tất cả các JAR files
$libs = @('build/classes')
Get-ChildItem -Path lib -Include *.jar -Recurse -ErrorAction SilentlyContinue | ForEach-Object { $libs += $_.FullName }
$classpath = $libs -join ';'

Write-Host "✅ Đang khởi động ứng dụng..."
Write-Host "📁 Thư mục: $(Get-Location)"
Write-Host ""

# Chạy ứng dụng
& java -cp $classpath GUI.Log_In

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Lỗi: Ứng dụng không thể khởi động (Exit Code: $LASTEXITCODE)"
} else {
    Write-Host "✅ Ứng dụng đã thoát thành công"
}
