#prompt for user name
$usr = 
$runpath = 

#VS code settings
delete keybinds and settings, then hard symlink:
$vs_settings = "C:\Users\$usr\AppData\Roaming\Code\User"

New-Item -ItemType HardLink -Name "$vs_settings\keybindings.json" -Value "$runpath\vs-code\keybindings.json"
New-Item -ItemType HardLink -Name "$vs_settings\settings.json" -Value "$runpath\vs-code\settings.json"

#Atom settings
C:\Users\~.atom\config.cson