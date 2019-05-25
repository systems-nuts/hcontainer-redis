#!/bin/bash

#set -e

C_FILES=$(find . -type f -not -name 'sds.c' -name "*.c")
H_FILES=$(find . -type f -not -name 'sds.h' -name "*.h")


### Capture variadic function names ###
func_names="$(sed  -n '/#/!s/\(.* .*(.*\), *\.\.\.)/&/p' $C_FILES | tr -s ' '| cut -d '(' -f 1| rev| cut -d' ' -f 1 | rev | tr -d '*')"
#sed  -n '/#/!s/\(.* .*(.*\), *\.\.\.) {/&/p' $C_FILES | tr -s ' '| cut -d ' ' -f 2| cut -d'(' -f 1 | tr -d '*')"
echo $func_names

echo "replace calls to variadic functions"
### replace calls to variadic functions ###
for fn in $(sed  -n '/#/!s/\(.* .*(.*\), *\.\.\.) {/&/p' $C_FILES | tr -s ' '| cut -d '(' -f 1| rev| cut -d' ' -f 1 | rev | tr -d '*')
do
	#number of argument of the function
	echo $fn
	nb_comma=$(sed  -n "/#/!s/.* $fn(\(.*\), *\.\.\.).*/\1/p" $C_FILES | grep -o ',' | grep -c .)
	#sed  -n "s/.* $fn(\(.*\), *\.\.\.).*/\1/p" $C_FILES | grep -o ',' | grep -c .)
	echo nb comma of $fn is $nb_comma
	nb_arg=$((nb_comma+1))
	echo nb args of $fn is $nb_arg

	if [ "$nb_arg" == 1 ]
	then
		cva="call_vaarg"
	elif  [ "$nb_arg" == 2 ]
	then
		cva="call_vaarg_2"
	elif  [ "$nb_arg" == 3 ]
	then
		cva="call_vaarg_3"
	else
		echo "unsuported arg number!"
	fi

	echo using $cva

	#using call_vaarg
	sed -i "/\.\.\./!s/\($fn\)(/$cva(\1,/" $C_FILES

done

### replace '...' with vaarg_tab_t ###
#in $C_FILES
sed  -i '/#/!s/\(.* .*(.*\), *\.\.\.)/ \1, vaarg_tab_t* __vaarg_tab)/' $C_FILES
#in $H_FILES
sed  -i '/#/!s/\(.* .*(.*\), *\.\.\.)/ \1, vaarg_tab_t* __vaarg_tab)/' $H_FILES

