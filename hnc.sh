#!/bin/sh
#
# User: lmm
#
# Changelog:
#
# Who  | When       | What
# =====+============+===========================================================
# LMM  | 24/07/2017 | Initial research and implementations
# LMM  | 01/08/2017 | Added Array for seperate tests & Tested lengh of input
# LMM  | Wed Aug  2 10:16:35 UTC 2017 | Addition of test 2
# LMM  | Fri Aug  4 07:32:17 UTC 2017 | test 2 edits and test 3 implementation
################################################################################
#
# Description:
# Matching hostnames to a schema of...
# [CHAR(2)]-[VARCHAR(<=6)]-[VARCHAR(<=5)]-[CHAR(1)][DECIMAL(2,0)].DOMAIN.LOCAL
#
# Plan:
# 1st test for 253 ASCII characters or less total
# 2nd test check for and identify any illegal chars;
#    whitespace, symbols & punctuation (could just test legal chars)
# 3rd test for max 3 labels delimited by . with a max of 63 characters each
#    and minimum of 1 (does 63 include the .   ??) I could use an array for
#       this test for illegality of hostname vs rfc1123 & the hostname schema 
#         above (can't have more than 4 labels is 1 fail, more then 3
#            according schema above is another)
# 4th test labels for illegal hyphens at start and end of labels
# 5th test for failures of .DOMAIN & .LOCAL labels with correct error for each
# 6th delimit labels by hyphens in array to test against schema
# 7th test for individual failures of delimited first label seperated by hyphens
# Finally add color to tests for aesthetic purposes
# 8th Pass it options (inputs from various locations)

#colors
red='\033[0;31m'
green='\033[0;32m'
cyan='\033[0;36m'
noclr='\033[0m'

#results
pass=${green}pass${noclr}
fail=${red}fail${noclr}

declare -l mystring
mystring=$1
echo ${#mystring}
echo $mystring
#exit

################################################################################

# Lengh
if [ ${#mystring} -lt 254 ] ;then
  echo -e "Hostname lengh253 Test: $pass"
else
  echo -e "Hostname lengh253 Test: $fail"
fi



# Whitespace
if [[ $mystring =~ [[:space:]] ]] ;then 
   echo -e "Whitespace test: $fail"
else 
   echo -e "Whitespace test: $pass"
fi



# Punctuation & Symbols
if [[ $mystring =~ [^[:alnum:]\.-]+ ]] ;then
   echo -e "Symbol test: $fail"
else
   echo -e "Symbol test: $pass"
fi



# create array to segment at period (.)
set -f
   # avoid globing (expansion of *)
segments=(${mystring//./ })
echo "There are ${#segments[@]} segments"



# Segment test
if [ ${#segments[@]} -lt 4 ] ;then
   echo -e "Subdomain count test: $pass"
else
   echo -e "Subdomain count test: $fail"
fi

seg1=${segments[0]}
seg2=${segments[1]}
seg3=${segments[2]}

echo $seg1
echo $seg2
echo $seg3

