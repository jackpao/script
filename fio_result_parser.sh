#!/bin/sh


for f in ./*.txt;
do

        filename="$f"
        echo $filename
        read mode jobs blocksize <<<${filename//[^0-9]/ }
        echo $blocksize $jobs $mode
        if [[ "$filename" == *"$blocksize"k* ]]; then
                BS="$blocksize"k
        else
                BS="$blocksize"m
        fi

        if ! grep All $f -A 16 > f2;then
          echo "$f, run not successful!" >> result_failed.csv
          continue
        fi

        while read -r line
        do
                pattern="lat (usec): min="
                pattern2="lat (nsec): min="
                clat="clat"
                if echo "$line" | grep  "$pattern\|$pattern2" | grep -q -v "clat"; then
                        echo $line
                        avg=$(echo $line | cut -d "," -f3 | cut -d "=" -f2)
                        unit=$(echo $line | cut -d "(" -f2 | cut -d ")" -f1)
                        avg_unit=$avg$unit
                fi

                if echo "$line" | grep  "IOPS"; then
                        echo $line
                        IOPS=$(echo $line | cut -d "," -f1 | cut -d "=" -f2)
                fi

                if echo "$line" | grep -q -E "read|write"; then
                        echo $line
                        BW=$(echo $line | cut -d "(" -f2 | cut -d ")" -f1)
                        echo $BW
                fi
        done < f2
        echo "$f, $BS, $jobs, $BW, $IOPS, $avg_unit" >>result.csv
        #echo "$f, bk=$BS, num_jobs=$jobs, BW=$BW, IOPS=$IOPS, avg_lat=$avg_unit" >>result.csv
done
