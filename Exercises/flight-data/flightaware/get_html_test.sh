echo "BEL11Y" > flight_and_airports.txt
curl https://flightaware.com/live/flight/BEL11Y | grep destination_IATA | head -n1 >> flight_and_airports.txt
echo "BEL88F" >> flight_and_airports.txt
curl https://flightaware.com/live/flight/BEL88F | grep destination_IATA | head -n1 >> flight_and_airports.txt
echo "CSA630" >> flight_and_airports.txt
curl https://flightaware.com/live/flight/CSA630 | grep destination_IATA | head -n1 >> flight_and_airports.txt
echo "DLH7MA" >> flight_and_airports.txt
curl https://flightaware.com/live/flight/DLH7MA | grep destination_IATA | head -n1 >> flight_and_airports.txt
echo "DLH9PJ" >> flight_and_airports.txt
curl https://flightaware.com/live/flight/DLH9PJ | grep destination_IATA | head -n1 >> flight_and_airports.txt
echo "IBE32HK" >> flight_and_airports.txt
curl https://flightaware.com/live/flight/IBE32HK | grep destination_IATA | head -n1 >> flight_and_airports.txt
echo "JAF218" >> flight_and_airports.txt
curl https://flightaware.com/live/flight/JAF218 | grep destination_IATA | head -n1 >> flight_and_airports.txt
echo "JAF3VT" >> flight_and_airports.txt
curl https://flightaware.com/live/flight/JAF3VT | grep destination_IATA | head -n1 >> flight_and_airports.txt
echo "MAC115" >> flight_and_airports.txt
curl https://flightaware.com/live/flight/MAC115 | grep destination_IATA | head -n1 >> flight_and_airports.txt