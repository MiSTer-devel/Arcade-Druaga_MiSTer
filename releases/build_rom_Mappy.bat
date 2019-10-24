@powershell -NoProfile -ExecutionPolicy Unrestricted "$s=[scriptblock]::create((gc \"%~f0\"|?{$_.readcount -gt 1})-join\"`n\");&$s" %*&goto:eof
#==============================================================
$zip="mappy.zip"
$ifiles=`
    "mpx_3.1d","mpx_3.1d","mp1_2.1c","mpx_1.1b",`
    "mp1_6.3m","mp1_6.3m","mp1_7.3n","mp1_7.3n",`
    "mp1_4.1k",`
    "mp1_5.3b",`
    "mp1-7.5k","mp1-7.5k","mp1-7.5k","mp1-7.5k",`
    "mp1-6.4c",`
    "mp1-3.3m",`
    "mp1-5.5b"

$ofile="a.mappy.rom"
$ofileMd5sumValid="b276d97b0dc61ca668d140793fac44bf"

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

