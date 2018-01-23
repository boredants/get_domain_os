Import-Module ActiveDirectory

Write-Host "`n*******************************************************"
Write-Host "*LIST COMPUTERS ON THE DOMAIN BY OPERATING SYSTEM TYPE*"
Write-Host "*******************************************************`n"

Write-Host @"
 1.  CentOS
 2.  Debian
 3.  Linux
 4.  Redhat Linux
 5.  Ubuntu
 6.  Mac OS X
 7.  Windows XP Professional
 8.  Windows 7 Enterprise
 9.  Windows 7 Professional
10.  Windows 8 Pro
11.  Windows 8.1 Pro
12.  Windows 10 Enterprise
13.  Windows 10 Pro
14.  Windows Server 2003
15.  Windows Server 2008 Enterprise
16.  Windows Server 2008 Standard
17.  Windows Server 2008 R2 Enterprise
18.  Windows Server 2008 R2 Standard
19.  Windows Server 2012 R2 Standard
20.  Windows Server 2012 Standard
21.  Windows Server 2016 Standard
"@

$prompt = Read-Host "`nChoose the number of the corresponding OS to list "

$outFile = Read-Host "`nEnter a filename to save the results "

$dateRange = Read-Host "`nEnter a date (M/D/YYY) to begin searching from, or press ENTER to search everything "

$choice = Switch($prompt)
	{
		1 {"CentOS"}
		2 {"Debian"}
		3 {"Linux"}
		4 {"redhat-linux-gnu"}
		5 {"Ubuntu"}
		6 {"Mac OS X"}
		7 {"Windows XP Professional"}
		8 {"Windows 7 Enterprise"}
		9 {"Windows 7 Professional"}
		10 {"Windows 8 Pro"}
		11 {"Windows 8.1 Pro"}
		12 {"Windows 10 Enterprise"}
		13 {"Windows 10 Pro"}
		14 {"Windows Server 2003"}
		15 {"Windows Server® 2008 Enterprise"}
		16 {"Windows Server® 2008 Standard"}
		17 {"Windows Server 2008 R2 Enterprise"}
		18 {"Windows Server 2008 R2 Standard"}
		19 {"Windows Server 2012 R2 Standard"}
		20 {"Windows Server 2012 Standard"}
		21 {"Windows Server 2016 Standard"}
	}

Write-Host "`nGetting $choice computers joined to the domain...  This could take some time..."

If ($dateRange) {
	Get-ADComputer -Filter * -Properties * | `
	where {$_.LastLogonDate -ge $dateRange -and $_.OperatingSystem -eq $choice} | `
	Select Name, OperatingSystem | ConvertTo-Csv -NoTypeInformation -Delimiter "," |`
 	% {$_ -replace '"',''}| Select-Object -Skip 1| Set-Content -Path $outFile

}else{

	Get-ADComputer -Filter * -Properties * | `
	where {$_.OperatingSystem -eq $choice} | `
	Select Name, OperatingSystem | ConvertTo-Csv -NoTypeInformation -Delimiter "," |`
 	% {$_ -replace '"',''}| Select-Object -Skip 1| Set-Content -Path $outFile
}

Write-Host "`nFinished...  Exiting...`n"
