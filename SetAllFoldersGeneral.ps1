# Force all folders in Windows 11 to use "General items" template

Write-Host "Setting all folders to use 'General items' template..."

# Path to shell settings
$basePath = "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell"

# Kill Explorer so registry edits take effect cleanly
Write-Host "Stopping Explorer..."
Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue

# Remove folder view cache
Write-Host "Clearing folder view cache..."
Remove-Item "$basePath\Bags" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$basePath\BagMRU" -Recurse -Force -ErrorAction SilentlyContinue

# Recreate structure
Write-Host "Creating new folder view defaults..."
New-Item -Path "$basePath\Bags" -Force | Out-Null
New-Item -Path "$basePath\Bags\AllFolders" -Force | Out-Null
New-Item -Path "$basePath\Bags\AllFolders\Shell" -Force | Out-Null

# Set FolderType to NotSpecified (General items)
New-ItemProperty -Path "$basePath\Bags\AllFolders\Shell" -Name "FolderType" -Value "NotSpecified" -PropertyType String -Force | Out-Null

Write-Host "Done. Restarting Explorer..."
Start-Process explorer.exe

Write-Host "All folders are now set to 'General items'."
