
# Setting up SSH Key-Based Authentication on Windows

Inastall choco:
```PowerShell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```
Reboot
```PowerShell
shutdown \r
```
Install vim
```PowerShell
choco install vim -y
```
Configure sshd
```PowerShell
vim C:\ProgramData\ssh\sshd_config
```
Comment these lines:
```bash
#Match Group administrators
# AuthorizedKeysFile __PROGRAMDATA__/ssh/administrators_authorized_keys
```
Allow access Windows using RSA keys in the sshd_config file:
```bash
PubkeyAuthentication yes
```
Add our key to  vim .ssh\authorized_keys
```Powershell
vim .\.ssh\authorized_keys
```
Restart service sshd
```PowerShell
restart-service sshd
```