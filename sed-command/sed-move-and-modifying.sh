#!/usr/bin/env bash
files='sed-command/list-file-to-move.txt'
dir_to='sed-command/src-to'
dir_from='sed-command/src-from'
n=1
while read line;
do
	#echo "$line"
	# check if exist
	file_from="$dir_from$line"
	#echo "$file_from"
	if [ -f $file_from ]
	then
		echo "$file_from"
		# if the file comes from windows it may need to conver from DOS to UNIX
		echo "convert to unix format first"
		#sed -i 's/^M$//' "$file_from"
		# Now lets modify base on firs argument we want to remove that special annotation.
		# we can remove by replace by blank space, or delete that file_from
		# sed -i '/@AwesomeAnnotation//'
		sed -i '/@AwesomeAnnotation/d' "$file_from"
		# Now lets try someting more complex
		# Lets try to modify the las character from a special file_from by a specific pattern
		# first lets remove any blank space at the end of that file_from (EOL)
		sed -E -i 's/(extends .+)\s+/\1/' "$file_from"
		# removing the last character if exist such character.
		if grep -E -oh 'extends .+([1])' $file_from; then
			echo "removing extra 1 from $file_from"
			sed -E -i 's/(extends .+).$/\1/' "$file_from"
	        fi

		if grep -oh 'utilClass1.' $file_from; then
			echo "removing extra parameter"
			sed -i 's/utilClass1./UtilClass./' $file_from
		fi
		# moving into its new directory
		# if this is a git repository I recomend use `git mv new_dir $file_from`
		# if not, then just `mv $file_from new_dir `
		#mkdir src-to
		echo "Mock moving files"
		echo "from: $file_from"
		echo "to: $dir_to$line"
		# make sure the same dir structure exist in the destination folder
		## Git best practice. move file in a different commit. It will help to track changes in the future. ##
		#git mv "$file_from" "$dir_to$line"
	fi
	n=$((n+1))
done < $files
echo "total records $n"
