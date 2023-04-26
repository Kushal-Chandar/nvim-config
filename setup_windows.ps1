$nvimConfigPath = $PWD
$nvimLinkPath = "$env:USERPROFILE\AppData\Local\nvim"

if (Test-Path $nvimLinkPath -PathType Container) {
  switch ((Get-Item $nvimLinkPath).Attributes) {
    { $_ -eq 'Directory' } {
      $response = Read-Host "A folder with the name 'nvim' already exists at the link path. Do you want to remove it? (Y/N)"
      if ($response.ToLower() -eq "y") {
        Remove-Item $nvimLinkPath -Recurse -Force
        Write-Host "Folder removed successfully."
      }
      else {
        Write-Host "Folder was not removed."
        return
      }
    }
    { $_ -eq 'ReparsePoint' } {
      $response = Read-Host "A symbolic link with the name 'nvim' already exists. Do you want to remove it? (Y/N)"
      if ($response.ToLower() -eq "y") {
        Remove-Item $nvimLinkPath -Force
        Write-Host "Symbolic link removed successfully."
      }
      else {
        Write-Host "Symbolic link was not removed."
        return
      }
    }
  }
}

New-Item -ItemType SymbolicLink -Path $nvimLinkPath -Target $nvimConfigPath
Write-Host "Symbolic link created successfully."
