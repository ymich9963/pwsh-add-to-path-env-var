$Bin_install_path = 'C:\Program Files\test'

# Get user path variable
$User_Env_Path_Value = Get-ItemProperty -Path 'HKCU:\Environment' -Name Path 

# Change the backslashes to frontslashes so that -split can work
$Bin_install_path_frontslash = $Bin_install_path -replace "\\","/"
$User_Env_Path_Value_frontslash = $User_Env_Path_Value.Path -replace "\\", "/"

# Check if the install path exists by splitting the Path variable value
$Bin_path_check = $User_Env_Path_Value_frontslash -split $Bin_install_path_frontslash | Measure-Object 

if ($Bin_path_check.Count -igt 1) {
    Write-Output "Detected previous installation."
    Write-Output "Nothing was added to the system Path variable."
} else {
    Write-Output "Detected no previous install."
    Write-Output "Adding executable to system Path environment variable."
    $New_Path_Value = $User_Env_Path_Value.Path + ";" + $Bin_install_path + ";" 
    Set-ItemProperty -Path 'HKCU:\Environment' -Name Path -Value $New_Path_Value
}

Write-Output "Succesfully installed application."
Exit

