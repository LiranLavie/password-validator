
#VARIABLES 
$MinChar=10
#argument from command
$PasswordStr=$args[0]

#Functions
function checkPassLen(){    
if ($PasswordStr.length -gt 8) {
    return $true
}
else {
    return $false
 } 
} 

function checkAlphAndNum(){    
if ($PasswordStr -cmatch "[a-zA-Z]" -and $PasswordStr -cmatch "[0-9]" ) {
    return $true
}
else {
    return $false
 } 
}

function checkCapitalCase(){    
if ($PasswordStr -cmatch "[a-z]" -and $PasswordStr -cmatch "[A-Z]" ) {
    return $true
}
else {
    return $false
 } 
}

#START PASSWORD VALIDATION

#CHECK THE PASSWORD LENGTH
if (checkPassLen) {
#CHECK FOR ALPHABET AND NUMBER
  if (checkAlphAndNum) {
#CHECK FOR UPPERCASE AND LOWERCASE
    if (checkCapitalCase){
     Write-Host "You have a secure password." -ForegroundColor Green 
     exit 0   
    }
    else{
      Write-Host "Password must Include both the small and capital case letters." -ForegroundColor Red
      exit 1
    }     
  }
  else {
    Write-Host "Password must contain both alphabet and number." -ForegroundColor Red
    exit 1
  }  

}
else{
    Write-Host "Password must have at least $MinChar characters." -ForegroundColor Red
    exit 1
}