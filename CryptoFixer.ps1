$testing = 1
$BadPath = "Bad_Path"
$GoodPath = "Good_Path"
$BadRoot = "Bad_Drive_Letter"
$GoodRoot = "Good_Drive_Letter"

$Bad = Get-ChildItem -Path $BadPath -Recurse | ?{!$_.PSIsContainer }
if($testing -eq 0){
    foreach($encrypt in $Bad){
        $baddir = [String]$encrypt.Directory
        $gooddir = $baddir.replace($BadRoot, $GoodRoot)
        $Good = Get-ChildItem $gooddir"\"$encrypt
        $diffsize = $encrypt.Length - $Good.Length
        if($diffsize -eq 512){
            Copy-Item $Good.fullname $baddir
            Write-Host "Fixed"
        }
        else{
            Write-Host "Not Encrypted"
        }
    }
}
else{
    foreach($encrypt in $Bad){
        $baddir = [String]$encrypt.Directory
        $gooddir = $baddir.replace($BadRoot, $GoodRoot)
        $Good = Get-ChildItem $gooddir"\"$encrypt
        $diffsize = $encrypt.Length - $Good.Length
        if($diffsize -eq 512){
            Write-Host "Encrypted"
        }
        else {
            Write-Host "Not Encrypted"
        }
    }
}
