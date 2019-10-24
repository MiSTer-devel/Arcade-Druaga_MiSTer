@powershell -NoProfile -ExecutionPolicy Unrestricted "$s=[scriptblock]::create((gc \"%~f0\"|?{$_.readcount -gt 1})-join\"`n\");&$s" %*&goto:eof
#==============================================================
$zip="motos.zip"
$ifiles=`
    "mo1_3.1d","mo1_1.1b",`
    "mo1_6.3m","mo1_7.3n",`
    "mo1_4.1k",`
    "mo1_5.3b",`
    "mo1-7.5k","mo1-7.5k","mo1-7.5k","mo1-7.5k",`
    "mo1-6.4c",`
    "mo1-3.3m",`
    "mo1-5.5b"

$ofile="a.motos.rom"
$ofileMd5sumValid="446203961cff53598233d2c50db390d8"

if (!(Test-Path "./$zip")) {
    echo "Error: Cannot find $zip file."
	echo ""
	echo "Put $zip into the same directory."
}
else {
    Expand-Archive -Path "./$zip" -Destination ./tmp/ -Force

    cd tmp
    Get-Content $ifiles -Enc Byte -Read 512 | Set-Content "../$ofile" -Enc Byte
    cd ..
    Remove-Item ./tmp -Recurse -Force

    $ofileMD5sumCurrent=(Get-FileHash -Algorithm md5 "./$ofile").Hash.toLower()
    if ($ofileMD5sumCurrent -ne $ofileMd5sumValid) {
        echo "Expected checksum: $ofileMd5sumValid"
        echo "  Actual checksum: $ofileMd5sumCurrent"
        echo ""
        echo "Error: Generated $ofile is invalid."
        echo ""
        echo "This is more likely due to incorrect $zip content."
    }
    else {
        echo "Checksum verification passed."
        echo ""
        echo "Copy $ofile into root of SD card along with the rbf file."
    }
}
echo ""
echo ""
pause

