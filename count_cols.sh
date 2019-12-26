#Shubhkarman Sohi
#NSID - sss669
#student Number - 11219687

#!/bin/sh

#initial values for variables
#to be used for delimetere in file and file name
DEL='\t'
COUNTER=1

#checks if number of arguments are greater than 1
if [ $# -gt 1 ]
then 
	#runs a for loop on each of those arguments
	for val in "$@"
	do
		#checks if the argument is -h, if true then echos the required text
        	if [ $val == "-h" ]
		then
                	echo "count_cols.sh [-h] [-d delimiter] [file]"
			COUNTER=$((COUNTER+1))
		fi

		#checks if the argument is -d, if true the following happens
		if [ $val == "-d" ]
		then
			#if true the counter is maintained and increased by 1
			# to obtain the value after -d
			COUNTER=$((COUNTER+1))

			#gets the value after -d and saves it in DEL
			DEL="${!COUNTER}"
			COUNTER=$((COUNTER+1))

			#gets the name of the file
			FILENAME="${!COUNTER}"

			#checks if the file exists, if it does then
			#counts the number of column spaces and ass 1 to then and
			#returns the same
			if [ -f $FILENAME ]
			then
				COLUMNS=`head -1 $FILENAME | tr -dc "$DEL" | wc -c`
				expr $COLUMNS + 1
				exit 0
			else
				echo "Ivalid file name"
				exit 1
			fi
		else
			echo "Invalid filename"
			exit 1
		fi  
	
	done
fi

#if input arguments are 1
if [ $# -eq 1 ]
then 
	#if the argument is -h
	if [ $1 == "-h" ]
	then 
		echo "count_cols.sh [-h] [-d delimiter] [file]"
		exit 0
	fi

	#if the argument is a file name then this checks if the file exists
	if [ -f $1 ]
	then 
		#then returns the number of columns plus 1
		COLUMNS=`head -1 $1 | tr -dc '\t' | wc -c`
		expr $COLUMNS + 1
		exit 0
	else
		echo "Invalid filename"
		exit 1
	fi
fi

#if the input is given from a pipe
#this checks for that 
if [ -p /dev/stdin ]
then 
	#puts the output in a variable
	read LINE

	#save the variable in a text file and pass it to the pipe
	#finally return the number of colums plus 1
	echo "$LINE" > foobar.txt
	COLUMNS=`head -1 foobar.txt | tr -dc '\t' | wc -c`
	expr $COLUMNS + 1
	rm -f foobar.txt
else
	echo "no arguments given"
	exit 1
fi
