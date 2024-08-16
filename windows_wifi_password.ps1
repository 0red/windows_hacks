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
