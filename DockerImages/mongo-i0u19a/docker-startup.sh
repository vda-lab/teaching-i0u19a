/entrypoint.sh mongod --rest --fork --logpath /dev/null
mongoimport --db i0u19a --collection beers --drop --file /startup/beers.json
while true; do sleep 1000; done
