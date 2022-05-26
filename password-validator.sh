#! /bin/bash

#FLAGS
while getopts 'f:' OPTION
do
  case "$OPTION" in
    f) Filename=${OPTARG}
  esac  
done

#VARIABLES 
PasswordStr=""
PasswordLen=""
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

function isPassFormFile(){
#check if Filename is emmpty  
if [[ -z "$Filename" ]]
then
  return 1
else
  return 0
fi
}

function readPassFromFile(){
while read  line; do
# reading each line and appand it to passwordStr var
PasswordStr+=$line
done < $1
}


#START PASSWORD VALIDATION

# CHECK IF PASSWORD IS FROM FILE
if isPassFormFile
then
  readPassFromFile $Filename
else
  PasswordStr="${@}"
fi

#SET PASSWORD LENGTH
PasswordLen=${#PasswordStr}

#CHECK THE PASSWORD
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
