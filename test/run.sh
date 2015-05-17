timestamp() {
  date +"%T"
}

while [ 1 == 1 ]
do

timestamp
python test.py
timestamp

sleep 1m

done
