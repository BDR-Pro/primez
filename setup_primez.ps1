# PowerShell Setup Script for primez on Windows

# if not adminn then exit

if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "You do not have sufficient permissions to run this script. Please run this script as an administrator."
    exit
}

$binaryName = "prime.exe"
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$executablePath = Join-Path -Path $scriptPath -ChildPath $binaryName

# Define target directory within USERPROFILE
$targetDir = Join-Path -Path $env:USERPROFILE -ChildPath "bin"

# Ensure target directory exists
if (-not (Test-Path -Path $targetDir)) {
    New-Item -ItemType Directory -Force -Path $targetDir
    Write-Host "Created directory: $targetDir"
}

# Define target path for the binary
$targetPath = Join-Path -Path $targetDir -ChildPath $binaryName

# Copy binary to the target directory
Copy-Item -Path $executablePath -Destination $targetPath -Force
Write-Host "primez has been copied to $targetPath"
echo " "

# Attempt to add the target directory to the user PATH environment variable

[System.Environment]::SetEnvironmentVariable("PATH", $targetDir, "User")
[System.Environment]::SetEnvironmentVariable("PATH", $targetPath, "User")
[System.Environment]::SetEnvironmentVariable("primez", $targetPath, "User")

Write-Host "$targetDir added to your PATH"
echo " "

$Env:PATH += ";C:\Users\$Env:USERNAME\bin"
Write-Host "Added $targetPath to your PATH"
echo " "



Write-Host "Please restart your shell or open a new shell to use primez."
echo " "

Write-Host "Setup complete. You can now run 'primez' from anywhere."

echo " "


$Env:PATH -split ';'

echo " "

Write-Host "primez has been installed to $Env:primez"

