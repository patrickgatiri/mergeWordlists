#!/usr/bin/bash

#Combine multiple .txt wordlists into a single wordlist with no duplicate entries.
#Store the separate wordlists in the same directory and execute this script within that directory.

#Retrieve all the text files within the directory.
#Ignore hidden files.

if [ $# -lt 1 ]
then
	echo -e "Merge files by Patrick Gatiri. \n"
	echo -e "Usage : ./mergeFiles directoryName"
	echo -e "Note that the directory name should not include the trailing slash.\n"
	echo -e "Example : ./mergeFiles ."

	exit 1
fi

directoryName=$1

if ! [ -d $directoryName ]
then
	"Directory ${directoryName} not found"
	exit 1
fi

mapfile -t files < <(ls -la $directoryName | sed 1,3d | awk '{print $NF}' | sed '/^\./d' | sed -n '/\.txt$/p')
numberOfFiles=${#files[@]}

if [ $numberOfFiles -eq 0 ]
then
	echo "There are no text files to merge"
	exit 1
fi

workingDirectory=$(pwd)
workingDirectory+="/"
workingDirectory+=$directoryName
echo -e "Merging ${numberOfFiles} .txt files in ${workingDirectory}"

mergeFile=""

if [ -e "${directoryName}-mergeFile" ]
then
	if [ -e "${directoryName}-mergeFile-50" ]
	then
		echo "Final files have reached limit. Please delete some and try again"
		exit 1
	else
		for i in {1..50} 
		do
			if [ -e "${directoryName}-mergeFile-${i}" ]
			then
				continue
			else
				mergeFile="${directoryName}-mergeFile-${i}" 
				break
			fi
		done
	fi
else
	mergeFile="${directoryName}-mergeFile"
fi

touch $mergeFile
touch tempFile

#Dump the content of all the text files into a single file.
for (( i=0; i<${#files[@]}; i++))
do
	cat "$directoryName/${files[i]}" >> tempFile
done

sort -u tempFile >> $mergeFile

rm tempFile

echo -e "\nDone. Merged results can be found in ${mergeFile}"

exit 0
