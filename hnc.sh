#!/bin/sh
#
# User: lmm
#
# Date: Tue Aug  8 11:20:29 UTC 2017
#
# Changelog:
#
# Who  | When       | What
# =====+============+===========================================================
# LMM  | 24/07/2017 | Initial research and implementations
# LMM  | 01/08/2017 | Added Array for seperate tests & Tested lengh of input
# LMM  | 02/08/2017 | Addition of test 2
# LMM  | 04/08/2017 | test 2 edit, test 3+4+5+6 & color added
# LMM  | 08/08/2017 | Changes requested by JRS
################################################################################
#
# Description:
# A script to match the following hostname schema
# [CHAR(2)]-[VARCHAR(<=6)]-[VARCHAR(<=5)]-[CHAR(1)][DECIMAL(2,0)].DOMAIN.LOCAL
# The entries must fulfil FQDN requirements in accordance with RFC 952, unless 
# there is an updated requirement specified in RFC 1123  
#
#
# Plan:
# Test for blank entry
# A single regex to achieve schema test at the very end
# use functions where possible
# Turn debuggin on
# edit description: to do with RFC's and requirements of FQDN's
# Add non zero exits
# Change color implementation from ascii to t-put
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
if [ ${#mystring} -lt 254 ]; then
  echo -e "Hostname lengh253 Test: $pass"
else
  echo -e "Hostname lengh253 Test: $fail"
fi



# Whitespace
if [[ $mystring =~ [[:space:]] ]]; then 
   echo -e "Whitespace test: $fail"
else 
   echo -e "Whitespace test: $pass"
fi



# Punctuation & Symbols
if [[ $mystring =~ [^[:alnum:]\.-]+ ]]; then
   echo -e "Symbol test: $fail"
else
   echo -e "Symbol test: $pass"
fi



# create array to segment at period (.)
set -f
   # avoid globing (expansion of *)
segments=(${mystring//./ })
#echo "There are ${#segments[@]} segments"



# Subdomain count
if [ ${#segments[@]} -le 3 ]; then
   echo -e "Subdomain count test: $pass"
else
   echo -e "Subdomain count test: $fail"
fi



# Subdomain lenghs
for i in ${!segments[@]}; do
   if [[ ${#segments[i]} -le 63 ]]; then
      echo -e "Subdomain $((i+1)) lengh test: $pass"
   else
      echo -e "Subdomain $((i+1)) lengh test: $fail"
   fi
done



# Subdomain illegal hyphens
for i in ${!segments[@]}; do
   if [[ ${segments[i]} =~ ^\-+|\-\-+|\-+$ ]]; then
      echo -e "Subdomain $((i+1)) illegal hyphen test: $fail"
   else
      echo -e "Subdomain $((i+1)) illegal hyphen test: $pass"
   fi
done



echo "The following tests results can be affected by failure in previous tests"
# check for domain and .local
seg1=${segments[0]}
seg2=${segments[1]}
seg3=${segments[2]}

seg1array=(${seg1//-/ })
for i in ${seg1array[@]}; do
echo $i
done

if [[ ${seg1array[0]} =~ ^[a-z0-9]{2} ]]; then
   echo -e "Subdomain segment one test: $pass"
else
   echo -e "Subdomain segment one test: $fail"
fi

if [[ ${seg1array[1]} =~ ^[a-z0-9]{1,6} ]]; then
   echo -e "Subdomain segment two test: $pass"
else
   echo -e "Subdomain segment two test: $fail"
fi

if [[ ${seg1array[2]} =~ ^[a-z0-9]{1,5} ]]; then
   echo -e "Subdomain segment three test: $pass"
else
   echo -e "Subdomain segment three test: $fail"
fi

if [[ ${seg1array[3]} =~ ^[a-z][0-9]{2} ]]; then
   echo -e "Subdomain segment four test: $pass"
else
   echo -e "Subdomain segment four test: $fail"
fi

  


if [[ $seg2 == "domain" ]]; then
   echo -e ".domain included and in correct place: $pass"
else
   echo -e ".domain missing or is not correctly placed: $fail"
fi

if [[ $seg3 == "local" ]]; then
   echo -e ".local included and in correct place: $pass"
else
   echo -e ".local missing or is not correctly placed: $fail"
fi

exit
