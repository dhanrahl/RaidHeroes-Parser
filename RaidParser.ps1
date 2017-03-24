#Location of Output Folder Path
$FolderPath = "$env:USERPROFILE\Dropbox\Raid Parses\$OutputFolder"

#Variables for Folder Creation; Currently this creates folders with a "M-dd & M-dd" naming scheme for 2 raid days a week.
$RaidDay = (Get-Date).ToString("M/dd/yyyy")
$RaidDay1 = (Get-Date).ToString("M-dd")
$RaidDay2 = (Get-Date).AddDays(-2).ToString("M-dd")
$RaidDayFolder = "$env:USERPROFILE\Dropbox\Raid Parses\$RaidDay1 & $RaidDay2"
$RaidFolder = Get-ChildItem $FolderPath | Sort-Object -Property CreationTime | Select-Object -Last 1
$RaidFolderCreation = Get-ChildItem $FolderPath | Where-Object {$_.CreationTime.Date -Match $RaidDay}
$RaidFolderCreation1 = (Get-Date).AddDays(-2).ToString("M/dd/yyyy")
$RaidFolderCreation2 = Get-ChildItem $FolderPath | Where-Object {$_.CreationTime.Date -Match $RaidFolderCreation1} 

#Variable for File Deletion
$TestPatchRemove = Test-Path $FolderPath\*.evtc

#Locations of Boss EVTC Logs
$ValeGuardian = "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\15438\*.evtc"
$ValeGuardianCopy = Get-ChildItem "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\15438\*.evtc" | sort LastWriteTime | select -last 1
$ValeGuardianLog = "$FolderPath\ValeGuardian.evtc"

$Gorseval = "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\15429\*.evtc"
$GorsevalCopy = Get-ChildItem "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\15429\*.evtc" | sort LastWriteTime | select -last 1
$GorsevalLog = "$FolderPath\Gorseval.evtc"

$Sabetha = "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\15375\*.evtc"
$SabethaCopy = Get-ChildItem "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\15375\*.evtc" | sort LastWriteTime | select -last 1
$SabethaLog = "$FolderPath\Sabetha.evtc"

$Slothasor = "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\16123\*.evtc"
$SlothasorCopy = Get-ChildItem "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\16123\*.evtc" | sort LastWriteTime | select -last 1
$SlothasorLog = "$FolderPath\Slothasor.evtc"

$Matthias = "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\16115\*.evtc"
$MatthiasCopy = Get-ChildItem "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\16115\*.evtc" | sort LastWriteTime | select -last 1
$MatthiasLog = "$FolderPath\Matthias.evtc"

$KeepConstruct = "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\16235\*.evtc"
$KeepConstructCopy = Get-ChildItem "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\16235\*.evtc" | sort LastWriteTime | select -last 1
$KeepConstructLog = "$FolderPath\KeepConstruct.evtc"

$Xera = "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\16246\*.evtc"
$XeraCopy = Get-ChildItem "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\16246\*.evtc" | sort LastWriteTime | select -last 1
$XeraLog = "$FolderPath\Xera.evtc"

$Cairn = "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\17194\*.evtc"
$CairnCopy = Get-ChildItem "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\17194\*.evtc" | sort LastWriteTime | select -last 1
$CairnLog = "$FolderPath\Cairn.evtc"

$MursaatOverseer = "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\17172\*.evtc"
$MursaatOverseerCopy = Get-ChildItem "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\17172\*.evtc" | sort LastWriteTime | select -last 1
$MursaatOverseerLog = "$FolderPath\MursaatOverseer.evtc"

$Samarog = "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\17188\*.evtc"
$SamarogCopy = Get-ChildItem "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\17188\*.evtc" | sort LastWriteTime | select -last 1
$SamarogLog = "$FolderPath\Samarog.evtc"

$Deimos = "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\17154\*.evtc"
$DeimosCopy = Get-ChildItem "$env:USERPROFILE\Documents\arcdps\arcdps.cbtlogs\17154\*.evtc" | sort LastWriteTime | select -last 1
$DeimosLog = "$FolderPath\Deimos.evtc"

#Checks location of Raid Folders to see if a folder exists for the two raid days. If no folder is present it will create a folder. Else Find and match the last known folder and set it as $OutputFolder for parsing.

If ($RaidFolder = $RaidFolderCreation2) { #Determined today is RaidDay2, setting directory as $OutputFolder
    New-Variable -ErrorAction Ignore -Name "OutputFolder" -Value (Get-ChildItem -Directory -Path "$env:USERPROFILE\Dropbox\Raid Parses" | Sort-Object -Property CreationTime | select -last 1)
    Write-Host "Successfuly set variable for OutputFolder"
}
Else {  
        If ($RaidFolder = $RaidDay) { #Checks to see if the raid folder that exists is from today, incase of new log file after running the script.
            Write-Host "Failure: Today was not a raid day"
            Pause
            QUIT
        }
        Else { #Determined that there is no folder created for RaidDay1 & RaidDay2, proceed with folder creation and setting directory as $OutputFolder
            New-Item -Path "$env:USERPROFILE\Dropbox\Raid Parses" -Name "$RaidDay1 & $RaidDay2" -ItemType Directory 
            New-Variable -ErrorAction Ignore -Name "OutputFolder" -Value (Get-ChildItem -Directory -Path "$env:USERPROFILE\Dropbox\Raid Parses" | Sort-Object -Property CreationTime | select -last 1)
            Write-Host "Successfully created new parse folder and set OutputFolder variable" 
        }
}

#Parsing the logs. Checks the most recent EVTC log and compares to current date.

    if ( (Get-ChildItem $ValeGuardian | sort LastWriteTime | select -last 1).LastWriteTime -ge (get-date).Date ) {
        #If Get-ChildItem returned TRUE, run Get-ChildItem on directory to copy and rename
        ($ValeGuardianCopy).CopyTo($ValeGuardianLog)
        Write-Host "ValeGuardian has been modified today and copied to $FolderPath"
        &'C:\Users\D''han Rahl\Desktop\raid_heroes.exe' $ValeGuardianLog
        }
    else {
        Write-Host "Vale Guardian was NOT created today"
    }  

    if ( (Get-ChildItem $Gorseval | sort LastWriteTime | select -last 1).LastWriteTime -ge (get-date).Date ) {
        ($GorsevalCopy).CopyTo($GorsevalLog)
        Write-Host "Gorseval has been modified today and copied to $FolderPath"
        &'C:\Users\D''han Rahl\Desktop\raid_heroes.exe' $GorsevalLog
        }
    else {
        Write-Host "Gorseval was NOT created today"
    }  

    if ( (Get-ChildItem $Sabetha | sort LastWriteTime | select -last 1).LastWriteTime -ge (get-date).Date ) {
        ($SabethaCopy).CopyTo($SabethaLog)
        Write-Host "Sabetha has been modified today and copied to $FolderPath"
        &'C:\Users\D''han Rahl\Desktop\raid_heroes.exe' $SabethaLog
        }
    else {
        Write-Host "Sabetha was NOT created today"
    }  

    if ( (Get-ChildItem $Slothasor | sort LastWriteTime | select -last 1).LastWriteTime -ge (get-date).Date ) {
        ($SlothasorCopy).CopyTo($SlothasorLog)
        Write-Host "Slothasor has been modified today and copied to $FolderPath"
        &'C:\Users\D''han Rahl\Desktop\raid_heroes.exe' $SlothasorLog
        }
    else {
        Write-Host "Slothasor was NOT created today"
    }  

    if ( (Get-ChildItem $Matthias | sort LastWriteTime | select -last 1).LastWriteTime -eq (get-date).Date ) {
        ($MatthiasCopy).CopyTo($MatthiasLog)
        Write-Host "Matthias has been modified today and copied to $FolderPath"
        &'C:\Users\D''han Rahl\Desktop\raid_heroes.exe' $MatthiasLog
        }
    else {
        Write-Host "Matthias was NOT created today"
    }  

    if ( (Get-ChildItem $KeepConstruct | sort LastWriteTime | select -last 1).LastWriteTime -ge (get-date).Date ) {
        ($KeepConstructCopy).CopyTo($KeepConstructLog)
        Write-Host "KeepConstruct has been modified today and copied to $FolderPath"
        &'C:\Users\D''han Rahl\Desktop\raid_heroes.exe' $KeepConstructLog
        }
    else {
        Write-Host "Keep Construct was NOT created today"
    }  

    if ( (Get-ChildItem $Xera | sort LastWriteTime | select -last 1).LastWriteTime -ge (get-date).Date ) {
        ($XeraCopy).CopyTo($XeraLog)
        Write-Host "Xera has been modified today and copied to $FolderPath"
        &'C:\Users\D''han Rahl\Desktop\raid_heroes.exe' $XeraLog
        }
    else {
        Write-Host "Xera was NOT created today"
    }  

    if ( (Get-ChildItem $Cairn | sort LastWriteTime | select -last 1).LastWriteTime -ge (get-date).Date ) {
        ($CairnCopy).CopyTo($CairnLog)
        Write-Host "Cairn has been modified today and copied to $FolderPath"
        &'C:\Users\D''han Rahl\Desktop\raid_heroes.exe' $CairnLog
        }
    else {
        Write-Host "Cairn was NOT created today"
    }  

    if ( (Get-ChildItem $MursaatOverseer | sort LastWriteTime | select -last 1).LastWriteTime -ge (get-date).Date ) {
        ($MursaatOverseerCopy).CopyTo($MursaatOverseerLog)
        Write-Host "MursaatOverseer has been modified today and copied to $FolderPath"
        &'C:\Users\D''han Rahl\Desktop\raid_heroes.exe' $MursaatOverseerLog
        }
    else {
        Write-Host "Mursaat Overseer was NOT created today"
    }  

    if ( (Get-ChildItem $Samarog | sort LastWriteTime | select -last 1).LastWriteTime -ge (get-date).Date ) {
        ($SamarogCopy).CopyTo($SamarogLog)
        Write-Host "Samarog has been modified today and copied to $FolderPath"
        &'C:\Users\D''han Rahl\Desktop\raid_heroes.exe' $SamarogLog
        }
    else {
        Write-Host "Samarog was NOT created today"
    }  

    if ( (Get-ChildItem $Deimos | sort LastWriteTime | select -last 1).LastWriteTime -ge (get-date).Date ) {
        ($DeimosCopy).CopyTo($DeimosLog)
        Write-Host "Deimos has been modified today and copied to $OutputFolder."
        }
    else {
        Write-Host "Deimos was NOT created today."
    }  

#Renaming log files after being parsed by RaidHeroes.exe

 If (Test-Path $FolderPath\ValeGuardian_vg.html) {
    Rename-Item $FolderPath\ValeGurdian_vg.html "Vale Guardian.html"
    }
Else {  }

 If (Test-Path $FolderPath\Gorseval_gorse.html) {
    Rename-Item $FolderPath\Gorseval_gorse.html "Gorseval.html"
    }
Else {  }

 If (Test-Path $FolderPath\Sabetha_sab.html) {
    Rename-Item $FolderPath\Sabetha_sab.html "Sabetha.html"
    }
Else {  }

 If (Test-Path $FolderPath\Slothasor_sloth.html) {
    Rename-Item $FolderPath\Slothasor_sloth.html "Slothasor.html"
    }
Else {  }

 If (Test-Path $FolderPath\Matthias_matt.html) {
    Rename-Item $FolderPath\Matthias_matt.html "Matthias.html"
    }
Else {  }

 If (Test-Path $FolderPath\KeepConstruct_kc.html) {
    Rename-Item $FolderPath\KeepConstruct_kc.html "Keep Construct.html"
    }
Else {  }

 If (Test-Path $FolderPath\Xera_xera.html) {
    Rename-Item $FolderPath\Xera_xera.html "Xera.html"
    }
Else {  }

 If (Test-Path $FolderPath\Cairn_cairn.html) {
    Rename-Item $FolderPath\Cairn_cairn.html "Cairn.html"
    }
Else {  }

 If (Test-Path $FolderPath\MursaatOverseer_mo.html) {
    Rename-Item $FolderPath\MursaatOverseer_mo.html "Mursaat Overseer.html"
    }
Else {  }

 If (Test-Path $FolderPath\Samarog_sam.html) {
    Rename-Item $FolderPath\Samarog_sam.html "Samarog.html"
    }
Else {  }

 If (Test-Path $FolderPath\Deimos_dei.html) {
    Rename-Item $FolderPath\Deimos_dei.html "Deimos.html"
    }
Else {  }

If ($TestPatchRemove -eq $True ){ 
     Remove-Item $FolderPath\*.evtc
     Write-Host Files have been removed
}
Else { Write-Host No files to remove }

PAUSE