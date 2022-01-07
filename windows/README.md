The powershell's analogs:
```Powershell
Get-Location = pwd
Set-Location = cd
Get-ChildItem = ls
Get-ChildItem -Filter "*azure*" -Recurse -File = find . -type f -iname "azure"
Copy-Item = cp
Remove-Item = rm
New-Item -ItemType Directory -Name 'MyNewFolder' = mkdir MyNewFolder
New-Item -ItemType File -Name test  = touch test
Get-Content = cat
Get-Content -Tail 10 file = tail file
```
Thanks: https://mathieubuisson.github.io/powershell-linux-bash/