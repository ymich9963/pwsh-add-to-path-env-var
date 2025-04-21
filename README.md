# Using PowerShell to Add a Path an Environment Variable
I couldn't find a good solution about this online, so I thought I should post the solution I had come up with to maybe help someone. It uses the `-split` operator to check if the user or system path value can be split into more than one item. If it can then it considers that the installation exists and doesn't add the path twice. A weird feature with this is that `-split` doesn't like backslashes so both the path string and the install path string have the backslashes replaced to do the check using `-split`. 

The most common method of doing this that I've seen is using this command,
```
[System.Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\NewDirectory", [System.EnvironmentVariableTarget]::User)
```
but this command modifies both User and System environment variables because they get loaded together for each user. The method used in the repo uses the windows registry to separate the two path variables.
