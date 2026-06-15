# 🌸 SakLinux Build Script
# Builds the SakLinux rootfs as a WSL tarball

param(
    [switch]$NoCache
)

$ErrorActionPreference = "Stop"
$buildDir = $PSScriptRoot
$tarName = "saklinux-rootfs.tar.gz"

Write-Host ""
Write-Host "  🌸 Building SakLinux v1.0.0" -ForegroundColor Magenta
Write-Host "  ═══════════════════════════════" -ForegroundColor DarkGray
Write-Host ""

# Check Docker
if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Host "  [ERR] Docker is required to build SakLinux" -ForegroundColor Red
    Write-Host "  Install Docker Desktop: https://docker.com/products/docker-desktop" -ForegroundColor Yellow
    exit 1
}

# Build
Write-Host "  [1/3] Building Docker image..." -ForegroundColor Cyan
$buildArgs = @("build", "-t", "saklinux-builder", $buildDir)
if ($NoCache) { $buildArgs += "--no-cache" }
& docker @buildArgs

if ($LASTEXITCODE -ne 0) {
    Write-Host "  [ERR] Docker build failed" -ForegroundColor Red
    exit 1
}

Write-Host "  [2/3] Exporting rootfs..." -ForegroundColor Cyan
$containerId = & docker create saklinux-builder
if (-not $containerId) {
    Write-Host "  [ERR] Failed to create container" -ForegroundColor Red
    exit 1
}

$tarPath = Join-Path $buildDir $tarName
& docker export $containerId | gzip -c > $tarPath
& docker rm $containerId | Out-Null

if (-not (Test-Path $tarPath)) {
    Write-Host "  [ERR] Failed to export rootfs" -ForegroundColor Red
    exit 1
}

$size = [Math]::Round((Get-Item $tarPath).Length / 1MB, 2)

Write-Host "  [3/3] Cleaning up..." -ForegroundColor Cyan
& docker rmi saklinux-builder 2>&1 | Out-Null

Write-Host ""
Write-Host "  ✅ SakLinux built successfully!" -ForegroundColor Green
Write-Host "  📦 Output: $tarPath" -ForegroundColor White
Write-Host "  💾 Size: $size MB" -ForegroundColor DarkGray
Write-Host ""
Write-Host "  To install:" -ForegroundColor Yellow
Write-Host "    sak install saklinux" -ForegroundColor White
Write-Host ""
Write-Host "  To test locally:" -ForegroundColor Yellow
Write-Host "    wsl --import SakLinux C:\WSL\SakLinux $tarPath" -ForegroundColor White
Write-Host ""
