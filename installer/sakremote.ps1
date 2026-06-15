# 🌸 SakLinux Remote Desktop - Windows Launcher
# Run this to connect to SakLinux desktop via RDP

param(
    [string]$Method = "rdp",
    [string]$IP = ""
)

$ErrorActionPreference = "Stop"

# Colors
function Write-Pink($msg) { Write-Host $msg -ForegroundColor Magenta }
function Write-Deep($msg) { Write-Host $msg -ForegroundColor DarkMagenta }

Write-Host ""
Write-Pink "  🌸 SakLinux Remote Desktop"
Write-Deep "  ════════════════════════════"
Write-Host ""

# Get SakLinux IP if not provided
if (-not $IP) {
    Write-Host "  Detecting SakLinux IP..." -ForegroundColor Cyan
    try {
        $IP = wsl -d SakLinux -- hostname -I 2>&1 | Select-Object -First 1
        $IP = $IP.Trim().Split(" ")[0]
    } catch {
        Write-Host "  [ERR] Could not detect SakLinux IP" -ForegroundColor Red
        Write-Host "  Make sure SakLinux is running: wsl -d SakLinux" -ForegroundColor Yellow
        exit 1
    }
}

Write-Host "  SakLinux IP: $IP" -ForegroundColor White
Write-Host ""

switch ($Method.ToLower()) {
    { $_ -in @("rdp", "remote", "mstsc") } {
        Write-Pink "  Starting Windows Remote Desktop..."
        Write-Host ""
        Write-Host "  Connection:" -ForegroundColor Yellow
        Write-Host "    Address:  $IP" -ForegroundColor White
        Write-Host "    Port:     3389" -ForegroundColor White
        Write-Host "    User:     sakura" -ForegroundColor White
        Write-Host "    Password: sakura" -ForegroundColor White
        Write-Host ""

        # Make sure xRDP is running in SakLinux
        Write-Host "  Ensuring xRDP is running in SakLinux..." -ForegroundColor Cyan
        wsl -d SakLinux -- bash -c "pgrep xrdp > /dev/null || (sudo xrdp-sesman --nodaemon &>/dev/null & sudo xrdp --nodaemon &>/dev/null &)" 2>&1 | Out-Null
        Start-Sleep -Seconds 2

        # Launch RDP
        Write-Host "  Launching Remote Desktop Connection..." -ForegroundColor Cyan
        & mstsc /v:"${IP}:3389"
    }
    { $_ -in @("vnc", "tightvnc") } {
        Write-Pink "  Starting VNC connection..."

        # Make sure VNC is running
        Write-Host "  Ensuring VNC is running in SakLinux..." -ForegroundColor Cyan
        wsl -d SakLinux -- bash -c "pgrep x11vnc > /dev/null || sakremote vnc &" 2>&1 | Out-Null
        Start-Sleep -Seconds 2

        Write-Host ""
        Write-Host "  VNC Address: ${IP}:5900" -ForegroundColor White
        Write-Host ""

        # Try to launch VNC viewer
        $vncClients = @(
            "C:\Program Files\TightVNC\tvnviewer.exe",
            "C:\Program Files\RealVNC\VNC Viewer\vncviewer.exe",
            "C:\Program Files (x86)\TightVNC\tvnviewer.exe"
        )
        $found = $false
        foreach ($client in $vncClients) {
            if (Test-Path $client) {
                Start-Process $client -ArgumentList "${IP}:5900"
                $found = $true
                break
            }
        }
        if (-not $found) {
            Write-Host "  No VNC client found. Install one:" -ForegroundColor Yellow
            Write-Host "    - TightVNC: https://www.tightvnc.com" -ForegroundColor DarkGray
            Write-Host "    - RealVNC:  https://www.realvnc.com" -ForegroundColor DarkGray
            Write-Host "    - Remmina:   https://remmina.org" -ForegroundColor DarkGray
        }
    }
    { $_ -in @("xpra", "seamless") } {
        Write-Pink "  Starting Xpra connection..."

        # Make sure Xpra is running
        Write-Host "  Ensuring Xpra is running in SakLinux..." -ForegroundColor Cyan
        wsl -d SakLinux -- bash -c "pgrep xpra > /dev/null || sakremote xpra &" 2>&1 | Out-Null
        Start-Sleep -Seconds 2

        Write-Host ""
        Write-Host "  Xpra Address: ${IP}:14500" -ForegroundColor White
        Write-Host ""
        Write-Host "  Download xpra client: https://xpra.org" -ForegroundColor DarkGray
        Write-Host "  Then run: xpra attach tcp:${IP}:14500" -ForegroundColor DarkGray
    }
    default {
        Write-Host "  Usage:" -ForegroundColor Yellow
        Write-Host "    .\sakremote.ps1 rdp     # Windows Remote Desktop" -ForegroundColor White
        Write-Host "    .\sakremote.ps1 vnc     # VNC Viewer" -ForegroundColor White
        Write-Host "    .\sakremote.ps1 xpra    # Xpra seamless" -ForegroundColor White
    }
}

Write-Host ""
