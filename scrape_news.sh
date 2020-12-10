#!/bin/bash
wget -q -nv https://www.ynetnews.com/category/3082 >/dev/null 2>/dev/null  
grep -o -E '(")https://www.ynetnews.com/article/[a-zA-Z0-9]{9}(#autoplay)?(")'\
 3082 | sort -u | sed 's/"//g' | sed 's/#autoplay//g' > links
touch results.csv
wc -l <links >> results.csv
while read -r line; do
	echo -n $line >> results.csv 
	wget -q -nv -O tmp $line >/dev/null 2>/dev/null
	bb=`grep -o -E "Netanyahu" tmp | wc -l`
	ga=`grep -o -E "Gantz" tmp | wc -l`
	if [[ $bb -eq 0 ]]&&[[ $ga -eq 0 ]]
	then
		echo ", -" >> results.csv
	else
		echo ", Netanyahu, "$bb", Gantz, "$ga >> results.csv
	fi
done <links
rm -rf 3082 tmp links