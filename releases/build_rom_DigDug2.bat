@powershell -NoProfile -ExecutionPolicy Unrestricted "$s=[scriptblock]::create((gc \"%~f0\"|?{$_.readcount -gt 1})-join\"`n\");&$s" %*&goto:eof
#==============================================================
$zip="digdug2.zip"
$ifiles=`
    "d23_3.1d","d23_1.1b",`
    "d21_6.3m","d21_7.3n",`
    "d21_4.1k",`
    "d21_5.3b",`
    "d21-7.5k","d21-7.5k","d21-7.5k","d21-7.5k",`
    "d21-6.4c",`
    "d21-3.3m",`
    "d21-5.5b"

$ofile="a.digdug2.rom"
$ofileMd5sumValid="2e652e5d6a114b7bd21a96e954b7f148"

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

