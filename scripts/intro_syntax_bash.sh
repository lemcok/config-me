#!/bin/bash
echo "hello world"
((sum=25+25))

echo "la suma es: $sum"
## Loop WHILE
valid=true
count=1
while [ $valid ]
do
echo $count
if [ $count -eq 5 ];
then
break
fi
((count++))
done

### Loop FOR
for(( counter=10; counter>0;counter-- ))
do
echo -n "$counter "
done
printf "\n"

### Get USER INPUT
echo "Enter you name: "
read name
echo "welcome $name to home!!"



