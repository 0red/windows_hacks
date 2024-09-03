# How to get the stored wifi passwords in Windows?
Use Power Shell and type

```posh

netsh wlan show profiles | Select-String -Pattern "All User Profile.+\:\s(.+)$"  | foreach {
	$k=$_.Matches.Value.split(":")[1].Trim(); 
	$p=netsh wlan show profile “$k” key=clear | Select-String -Pattern  "Key Content.+\:\s(.+)$"
	if ( $p.Matches.Count -gt 0 ) { 
		$p1= $p.Matches[0].Value.split(":")[1].Trim(); 
	} else {
		$p1=""
	}
	
	Write-Host "'$k'='$p1'"
}
```

Based on [https://www.pcworld.com/article/411078/how-to-find-saved-wi-fi-passwords-on-your-windows-10-pc.html]


# RegEdit Favourites

Save the registry:

```reg
Computer\HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Applets\Regedit\Favorites
```


# How to export/import PuTTY sessions list?

## Export
cmd.exe, requires elevated prompt due to regedit:

Only sessions (produces file putty-sessions.reg on the Desktop):

```bat
regedit /e "%USERPROFILE%\Desktop\putty-sessions.reg" HKEY_CURRENT_USER\Software\SimonTatham\PuTTY\Sessions
```
All settings except ssh keys (produces file putty.reg on the Desktop):
```bat
regedit /e "%USERPROFILE%\Desktop\putty.reg" HKEY_CURRENT_USER\Software\SimonTatham
```
## Import
Double-click on the *.reg file and accept the import.

Based on [https://stackoverflow.com/questions/13023920/how-to-export-import-putty-sessions-list]


# File Explorer max file size limit 
```
Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WebClient\Parameters

FileSizeLimitInBytes DWORD 4284217728
```
# Internet trusted zone

 
For the following site: 🔴https://🟢**www_site**.🟡*zzzdomain.com*

You have to add the following value in for 🔴https protocol:

Computer\HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\\🟡*zzzdomain.com*\\🟢**www_site**\🔴https DWORD 2


```
Computer\HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\zzzdomain.com
-->sub
Computer\HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\zzz.com\www_site
https DWORD 2
```
[https://specopssoft.com/blog/alternative-ways-to-update-trusted-sites/]

# delete PDF password
## Linux
[https://www.cyberciti.biz/faq/removing-password-from-pdf-on-linux/]

```sh
qpdf --decrypt protected.pdf unprotected_qpdf.pdf
gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=unencrypted_gs.pdf -c .setpdfwrite -f encrypted.pdf
```
## Windows
[https://sourceforge.net/projects/qpdf/]
```bat
"C:\Program Files\qpdf 11.9.1\bin\qpdf.exe" --decrypt encrypted.pdf unencrypted_win.pdf
```
