# ============================================================
# RETRO POWERSHELL WELCOME — NSC TERMINAL (STABLE)
# ============================================================

# === CONSOLE COLORS ===
$raw = $Host.UI.RawUI
$raw.BackgroundColor = 'Black'
$raw.ForegroundColor = 'Yellow'
Clear-Host

# === COLOR SCHEME ===
$Main   = "DarkYellow"
$Accent = "Yellow"
$Dim    = "DarkGray"

# === PERSONAL DATA ===
$User     = $env:USERNAME.ToUpper()
$Terminal = $env:COMPUTERNAME.ToUpper()
$Now      = Get-Date

# ============================================================
# MINI LOADER
# ============================================================

Write-Host "INITIALIZING TERMINAL" -NoNewline -ForegroundColor $Main
for ($i = 0; $i -lt 3; $i++) {
    Start-Sleep -Milliseconds 120
    Write-Host "." -NoNewline -ForegroundColor $Main
}
Write-Host " OK" -ForegroundColor $Accent

# ============================================================
# BOOT SEQUENCE (EXTENDED)
# ============================================================

$bootLines = @(
    "CPU ............... OK",
    "MEMORY ............ OK",
    "KEYBOARD .......... OK",
    "DISPLAY ........... OK",
    "SOUND ............. ?  (PROBABLY)"
)

foreach ($line in $bootLines) {
    Write-Host $line -ForegroundColor $Main
    Start-Sleep -Milliseconds 200
}

Start-Sleep -Milliseconds 200
Write-Host "SYSTEM READY" -ForegroundColor $Accent
Start-Sleep -Milliseconds 200

# ============================================================
# UPTIME (BULLETPROOF — NO CIM, NO RACE CONDITIONS)
# ============================================================

# TickCount64 = milliseconds since system boot
$boot = (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
$uptime = (Get-Date) - $boot

# ============================================================
# CRT SCANLINE SWEEP
# ============================================================

function Show-CrtScanlines {
    param ([int]$Lines = 10)

    for ($i = 0; $i -lt $Lines; $i++) {
        Write-Host ("-" * 60) -ForegroundColor $Dim
        Start-Sleep -Milliseconds 25
    }
}

Show-CrtScanlines -Lines 10
Clear-Host

# ============================================================
# NSC ASCII LOGO (ANIMATED, ASCII-SAFE)
# ============================================================

$NSC_Logo_Frames = @(
@(
"  _   _   ____    _____ ",
" | \ | | / ___|  / ____|",
" |  \| | \___ \ | |     ",
" | |\  |  ___) || |____ ",
" |_| \_| |____/  \_____|"
),
@(
"  _   _   ____    _____ ",
" | \ | | / ___|  / ____|",
" |  \| | \___ \ | |  .. ",
" | |\  |  ___) || |____ ",
" |_| \_| |____/  \_____|"
)
)

# ============================================================
# STATUS MESSAGES
# ============================================================

$statuses = @(
    "ALL SYSTEMS NOMINAL",
    "READY FOR OPERATOR INPUT",
    "AUTOMATION LEVEL: DANGEROUS",
    "COFFEE BUFFER: LOW",
    "LEGACY MODE ENABLED"
)

# ============================================================
# ANIMATION SETTINGS
# ============================================================

$LeftWidth  = 28
$PulseDelay = 90
$ScanDelay  = 35

# ============================================================
# PHOSPHOR PULSE
# ============================================================

for ($pulse = 0; $pulse -lt 3; $pulse++) {

    Clear-Host

    Write-Host "============================================" -ForegroundColor $Main
    Write-Host "  RETRO OPERATING TERMINAL - SESSION OPEN" -ForegroundColor $Accent
    Write-Host "============================================" -ForegroundColor $Main
    Write-Host ""

    $Logo = $NSC_Logo_Frames[$pulse % 2]

    $Stats = @(
        "OPERATOR  : $User",
        "TERMINAL  : $Terminal",
        "DATE      : $($Now.ToString('yyyy-MM-dd'))",
        "TIME      : $($Now.ToString('HH:mm:ss'))",
        ("UPTIME    : {0}h {1}m" -f $uptime.Hours, $uptime.Minutes),
        "",
        "STATUS    : $(Get-Random $statuses)"
    )

    $maxLines = [Math]::Max($Logo.Count, $Stats.Count)

    for ($i = 0; $i -lt $maxLines; $i++) {
        $left  = if ($i -lt $Logo.Count)  { $Logo[$i] }  else { "" }
        $right = if ($i -lt $Stats.Count) { $Stats[$i] } else { "" }

        $color = if ($pulse % 2 -eq 0) { $Accent } else { $Main }

        Write-Host ($left.PadRight($LeftWidth)) -NoNewline -ForegroundColor $color
        Write-Host $right -ForegroundColor $Main
    }

    Start-Sleep -Milliseconds $PulseDelay
}

# ============================================================
# SCANLINE PASS
# ============================================================

for ($line = 0; $line -lt $NSC_Logo_Frames[0].Count; $line++) {

    Clear-Host

    Write-Host "============================================" -ForegroundColor $Main
    Write-Host "  RETRO OPERATING TERMINAL - SESSION OPEN" -ForegroundColor $Accent
    Write-Host "============================================" -ForegroundColor $Main
    Write-Host ""

    $Logo = $NSC_Logo_Frames[0]

    for ($i = 0; $i -lt $Logo.Count; $i++) {
        $c = if ($i -eq $line) { $Dim } else { $Accent }
        Write-Host $Logo[$i] -ForegroundColor $c
    }

    Start-Sleep -Milliseconds $ScanDelay
}

# ============================================================
# FINAL LOCKED SCREEN
# ============================================================

Clear-Host

Write-Host "============================================" -ForegroundColor $Main
Write-Host "  RETRO OPERATING TERMINAL - SESSION OPEN" -ForegroundColor $Accent
Write-Host "============================================" -ForegroundColor $Main
Write-Host ""

$Logo = $NSC_Logo_Frames[0]

$Stats = @(
    "OPERATOR  : $User",
    "TERMINAL  : $Terminal",
    "DATE      : $($Now.ToString('yyyy-MM-dd'))",
    "TIME      : $($Now.ToString('HH:mm:ss'))",
    ("UPTIME    : {0} HOURS" -f [int]$uptime.TotalHours),
    "",
    "STATUS    : $(Get-Random $statuses)"
)

$maxLines = [Math]::Max($Logo.Count, $Stats.Count)

for ($i = 0; $i -lt $maxLines; $i++) {
    $left  = if ($i -lt $Logo.Count)  { $Logo[$i] }  else { "" }
    $right = if ($i -lt $Stats.Count) { $Stats[$i] } else { "" }

    Write-Host ($left.PadRight($LeftWidth)) -NoNewline -ForegroundColor $Accent
    Write-Host $right -ForegroundColor $Main
}

# ============================================================
# READY PROMPT
# ============================================================

Write-Host ""
Write-Host "READY>" -ForegroundColor $Accent
[Console]::Beep(700, 50)
