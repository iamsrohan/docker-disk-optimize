param (
    [string]$ExportPath = "C:\"
)

# Function to check if the script is running with administrator privileges
function Test-IsAdmin {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Exit if the script is not run as administrator
if (-not (Test-IsAdmin)) {
    Write-Output "This script must be run as an administrator."
    exit 1
}

# Get the current user's profile directory and build the Docker data directory path
$UserProfile = [System.Environment]::GetFolderPath('LocalApplicationData')
$DockerDataDir = "$UserProfile\Docker\wsl\data"
$VhdxFile = "$DockerDataDir\ext4.vhdx"
$ExportFile = "$ExportPath\docker-desktop-data.tar"
$ImportPath = "$ExportPath"
$EstimatedExportTime = 300 # Estimated time for export in seconds (adjust as needed)

function Stop-Docker {
    Write-Output "Stopping Docker service..."
    Stop-Service -Name "com.docker.service"
}

function Export-DockerData {
    Write-Output "Exporting Docker data to $ExportFile..."
    $job = Start-Job -ScriptBlock {
        param ($ExportFile)
        wsl --export docker-desktop-data $ExportFile
    } -ArgumentList $ExportFile

    $elapsed = 0
    while ($true) {
        Start-Sleep -Seconds 1
        $elapsed++
        $percentComplete = [math]::Min(($elapsed / $EstimatedExportTime) * 100, 100)
        Write-Progress -Activity "Exporting Docker Data" -Status "$percentComplete% Complete" -PercentComplete $percentComplete
        if ($job.State -ne 'Running') { break }
    }
    Receive-Job -Job $job
    Remove-Job -Job $job
}

function Compact-Vhdx {
    Write-Output "Compacting VHDX file..."
    $diskpartScript = @"
select vdisk file="$VhdxFile"
attach vdisk readonly
compact vdisk
detach vdisk
exit
"@
    $diskpartScript | Out-File -FilePath "diskpart_script.txt" -Encoding ASCII
    diskpart /s diskpart_script.txt
    Remove-Item "diskpart_script.txt"
}

function Import-DockerData {
    Write-Output "Importing Docker data from $ExportFile..."
    wsl --import docker-desktop-data $ImportPath $ExportFile --version 2
}

function Start-Docker {
    Write-Output "Starting Docker service..."
    Start-Service -Name "com.docker.service"
}

function Delete-ExportFile {
    Write-Output "Deleting export file $ExportFile..."
    Remove-Item $ExportFile -Force
}

# Main script
Stop-Docker
Export-DockerData
Compact-Vhdx
Import-DockerData
Delete-ExportFile
Start-Docker
Write-Output "Docker optimization complete."
