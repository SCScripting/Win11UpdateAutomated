# Provides output for a readiness report for WIndows 11 upgrades
Write-Output "=== Windows 11 Readiness Report ==="

# --- CPU Check ---
$cpu = Get-CimInstance Win32_Processor | Select-Object -ExpandProperty Name
Write-Output "CPU: $cpu"

# --- RAM Check ---
$ram = [math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB,2)
if ($ram -ge 4) {
    Write-Output "RAM: $ram GB (OK)"
} else {
    Write-Output "RAM: $ram GB (Insufficient)"
}

# --- Disk Space Check (on C:) ---
$disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"
$diskGB = [math]::Round($disk.Size / 1GB,2)
if ($diskGB -ge 64) {
    Write-Output "Disk: $diskGB GB (OK)"
} else {
    Write-Output "Disk: $diskGB GB (Insufficient)"
}

# --- TPM Check ---
try {
    $tpm = Get-WmiObject -Namespace "root\cimv2\security\microsofttpm" -Class Win32_Tpm -ErrorAction Stop
    if ($tpm.SpecVersion -like "*2.0*") {
        Write-Output "TPM: Version 2.0 (OK)"
    } else {
        Write-Output "TPM: Found but not 2.0"
    }
} catch {
    Write-Output "TPM: Not Present"
}

# --- Secure Boot Check ---
try {
    $sb = Confirm-SecureBootUEFI -ErrorAction Stop
    if ($sb -eq $true) {
        Write-Output "Secure Boot: Enabled (OK)"
    } else {
        Write-Output "Secure Boot: Disabled"
    }
} catch {
    Write-Output "Secure Boot: Not Supported / Legacy BIOS"
}

# --- UEFI Firmware Check ---
$firmware = (Get-CimInstance Win32_ComputerSystem).BootupState
if ($firmware -like "*UEFI*") {
    Write-Output "Firmware: UEFI (OK)"
} else {
    Write-Output "Firmware: Legacy BIOS"
}

Write-Output "=== End of Report ==="
