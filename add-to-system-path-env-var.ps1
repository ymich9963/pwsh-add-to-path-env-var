$Bin_install_path = 'C:\Program Files\test'

# Get system path variable
$Sys_Env_Path_Value = Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\' -Name Path 

# Change the backslashes to frontslashes so that -split can work
$Bin_install_path_frontslash = $Bin_install_path -replace "\\","/"
$Sys_Env_Path_Value_frontslash = $Sys_Env_Path_Value.Path -replace "\\", "/"

# Check if the install path exists by splitting the Path variable value
$Bin_path_check = $Sys_Env_Path_Value_frontslash -split $Bin_install_path_frontslash | Measure-Object 

if ($Bin_path_check.Count -igt 1) {
    Write-Output "Detected previous installation."
    Write-Output "Nothing was added to the system Path variable."
} else {
    Write-Output "Detected no previous install."
    Write-Output "Adding executable to system Path environment variable."
    $New_Path_Value = $Sys_Env_Path_Value.Path + ";" + $Bin_install_path + ";" 
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\' -Name Path -Value $New_Path_Value
}

Write-Output "Succesfully installed application."

Read-Host "Press Enter to exit"

Exit

