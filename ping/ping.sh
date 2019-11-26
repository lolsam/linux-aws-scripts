#!/bin/bash
cat /root/pinglist.txt | while read OUTPUT
do
 ping -c 3 "$OUTPUT" > /dev/null
 if [ $? -eq 0 ]; then
 echo "Server $OUTPUT is up"
else
 echo "Server $OUTPUT is down"
fi
done


#