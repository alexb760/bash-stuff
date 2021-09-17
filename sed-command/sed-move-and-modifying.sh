#!/usr/bin/env bash
files='list-file-to-move.txt'
n=1
while read line;
do
	#echo "$line"
	# check if exist
	if [ -f $line ]
	then
		echo "$line"
		# if the file comes from windows it may need to conver from DOS to UNIX
		echo "convert to unix format first"
		#sed -i 's/^M$//' "$line"
		# Now lets modify base on firs argument we want to remove that special annotation.
		# we can remove by replace by blank space, or delete that line
		# sed -i '/@AwesomeAnnotation//'
		sed -i '/@AwesomeAnnotation/d' "$line"
		# Now lets try someting more complex
		# Lets try to modify the las character from a special line by a specific pattern
		# first lets remove any blank space at the end of that line (EOL)
		sed -E -i 's/(extends .+)\s+/\1/' "$line"
		# removing the last character if exist such character.
		if grep -E -oh 'extends .+([1])' $line; then
			echo "removing extra 1 from $line"
			sed -E -i 's/(extends .+).$/\1/' "$line"
	        fi

		if grep -oh 'UtilClass1.' $line; then
			echo "removing extra parameter"
			sed -i 's/UtilClass1./UtilClass./' $line
		fi
		# Now moving into its new directory
		# if this is a git repository I recomend use `git mv new_dir $line`
		# if not, then just `mv $line new_dir `
		mv $line src-to/
	fi

done < $files
