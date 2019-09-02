#! /usr/bin/bash

pathOf(){
        find . -name $1 2>/tmp/s278068_err
}

pathOf_withErrors(){
	 find . -name $1
}


cd ../lab0

filesL=`ls -Rl ludicolo7 2>/tmp/s278068_err | grep -v ':$' | egrep -e '^(-|d|b|c|l|p|s)' | sort -rn -k 5`
files=`ls -R ludicolo7 2>/tmp/s278068_err  | grep -v ':$' | tr -s '\r\n' ' '`

let "n=0"
for file in $files
do
	pathToFile=`pathOf $file` 2>/tmp/s278068_err
	echo $pathToFile
	if [[ -f $pathToFile && -nez $pathToFile ]]
	then
		charCount1=`wc -c $pathToFile` 2>/tmp/s278068_err
		charCount2=($charCount1)
		charCount=${charCount2[0]}
		let "n+=charCount"
	fi
done
echo -e "\nChar count in ludicolo7's files: $n\n"

echo -e "Sorted(ludicolo7) by size: \n$filesL"

#-------------------------------------------------------------
echo -e "\nFiles whose names contain mi (list sorted by number of hard link): "
ls -Rl 2>/tmp/s278068_err | grep -v ':$' | egrep -e '^(-|d|b|c|l|p|s)' | sort -rn -k 2
#---------------------------------------------------------------
echo -e "\nProcessed file contents (deerling, magmortar, shellos, purrloin): "
cat `pathOf_withErrors deerling` `pathOf_withErrors magmortar` `pathOf_withErrors shellos` `pathOf_withErrors purrloin` | grep -v 'Ta'
#--------------------------------------------------------------
echo -e "\nSorted files(weepinbell8): "
elementsWeep=`ls -R weepinbell8  | grep -v ':$' | sort -r`
for elem in $elementsWeep
do
	if [ -f `pathOf_withErrors $elem` ]
	then
		echo $elem
	fi
done
#---------------------------------------------------------
fileStartWith_m=`ls | grep '^m' | sort`
echo -e "\nFile contents whose name starts with m: "
for elem in $fileStartsWith_m
do
	pathToFile=`pathOf_withErrors $elem`
        if [ -f $pathToFile ]
        then
                cat $pathToFile
        fi
done
#----------------------------------------------------------
echo -e "\nfirst four elements lab0: "
ls -Rl 2>/tmp/s278068_err | grep -v ':$' | egrep '^-' | sort -k 7n,8n | head -n 4

cd ../src
