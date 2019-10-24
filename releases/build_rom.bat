@powershell -NoProfile -ExecutionPolicy Unrestricted "$s=[scriptblock]::create((gc \"%~f0\"|?{$_.readcount -gt 1})-join\"`n\");&$s" %*&goto:eof
#==============================================================
$zip="todruaga.zip"
$ifiles=`
    "td2_3.1d","td2_1.1b",`
    "td1_6.3m","td1_6.3m","td1_7.3n","td1_7.3n",`
    "td1_4.1k",`
    "td1_5.3b",`
    "td1-7.5k",`
    "td1-6.4c",`
    "td1-3.3m",`
    "td1-5.5b"

$ofile="a.druaga.rom"
$ofileMd5sumValid="ef0d64d4d3fc4f594389d2b28c677c20"

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

