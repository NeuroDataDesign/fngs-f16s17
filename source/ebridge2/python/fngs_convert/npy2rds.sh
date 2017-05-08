#!/bin/bash
# call from a directory where you want
# to have your npy files converted to rds files.
# written by eric bridgeford
#
# Usage:
#   ./npy2rds.sh /path/to/your/roi_timeseries
#

cd $(dirname "$0")

echo "$(pwd)"

while read -r npyline; do
    ./npy2csv.py $npyline ${npyline//.npy/.csv}
    ./csv2rds.R ${npyline//.npy/.csv} ${npyline//.npy/.rds}
done < <(find $1 -wholename "*.npy")

cd -
echo "$(pwd)"
