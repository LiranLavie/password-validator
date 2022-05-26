#! /bin/bash
 
#VARIABLES 
PasswordStr=${@}
PasswordLen=${#PasswordStr}
MinChar=10

#COLOR VARIABLES
Red='\033[0;31m'          
Green='\033[0;32m'

#REGEX VARIABLES
UpperCaseRegex="[A-Z]"
LowerCaseRegex="[a-z]"
AlfabetRegex="[a-zA-Z]"
DigitRegex="[0-9]"

#FUNCTIONS
function checkPassLen(){
if [[ $1 -ge $2 ]]
then
 return 0
else
 return 1 
fi
}

function checkAlphAndNum(){
if [[ $1 =~ $2 ]] && [[ $1 =~ $3 ]]
then
 return 0
else
 return 1
fi   
}

function checkCapitalCase(){
if [[ $1 =~ $2 ]] && [[ $1 =~ $3 ]]
then
 
 return 0
 
else
 return 1
fi     
}

#START PASSWORD VALIDATION 

#CHECK THE PASSWORD LENGTH
if checkPassLen $PasswordLen MinChar -qe 0
then
#CHECK FOR ALPHABET AND NUMBER
  if checkAlphAndNum $PasswordStr $AlfabetRegex $DigitRegex -qe 0
  then
#CHECK FOR UPPERCASE AND LOWERCASE
    if checkCapitalCase $PasswordStr $UpperCaseRegex $LowerCaseRegex -qe 0
    then
      echo -e "${Green}You have a secure password"
      exit 0
    else
      echo -e "${Red}Password must Include both the small and capital case letters."
      exit 1
    fi
  else
    echo -e "${Red}Password must contain both alphabet and number."
    exit 1
  fi
else
  echo -e "${Red}Password must have at least $MinChar characters."
  exit 1
fi
