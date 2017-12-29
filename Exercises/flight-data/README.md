# Data
## airports.csv

Source: http://openflights.org/data.html

Columns:
* Airport ID: Unique OpenFlights identifier for this airport.
* Name: Name of airport. May or may not contain the City name.
* City: Main city served by airport. May be spelled differently from Name.
* Country: Country or territory where airport is located. See countries.dat to cross-reference to ISO 3166-1 codes.
* IATA: 3-letter IATA code. Null if not assigned/unknown.
* ICAO: 4-letter ICAO code. Null if not assigned.
* Latitude: Decimal degrees, usually to six significant digits. Negative is South, positive is North.
* Longitude: Decimal degrees, usually to six significant digits. Negative is West, positive is East.
* Altitude: In feet.
* Timezone: Hours offset from UTC. Fractional hours are expressed as decimals, eg. India is 5.5.
* DST: Daylight savings time. One of E (Europe), A (US/Canada), S (South America), O (Australia), Z (New Zealand), N (None) or U (Unknown). See also: Help: Time
* Tz: database time zone	Timezone in "tz" (Olson) format, eg. "America/Los_Angeles".
* Type: Type of the airport. Value "airport" for air terminals, "station" for train stations, "port" for ferry terminals and "unknown" if not known. In airports.csv, only type=airport is included.
* Source: Source of this data. "OurAirports" for data sourced from OurAirports, "Legacy" for old data not matched to OurAirports (mostly DAFIF), "User" for unverified user contributions. In airports.csv, only source=OurAirports is included.

Load into database using:
```
mongoimport --fields airport_id,name,city,country,iata,icao,latitude,longitude,altitude,timezone,dst,tz,type,source --ignoreBlanks --type csv --db flights --collection airports --file airports.csv 
```

## routes.csv

Same datasource

Columns:
* Airline IATA: 2-letter (IATA) code of the airline.
* Airline ICAO: 3-letter (ICAO) code of the airline.
* Airline ID: Unique OpenFlights identifier for airline (see Airline).
* Source airport: 3-letter (IATA) code of the source airport.
* Source airport ID: Unique OpenFlights identifier for source airport (see Airport)
* Destination airport: 3-letter (IATA) code of the destination airport.
* Destination airport ID: Unique OpenFlights identifier for destination airport (see Airport)
* Codeshare: "Y" if this flight is a codeshare (that is, not operated by Airline, but another carrier), empty otherwise.
* Stops: Number of stops on this flight ("0" for direct)
* Equipment: 3-letter codes for plane type(s) generally used on this flight, separated by spaces

Load into database using:
```
mongoimport --fields iata,icao,airline_id,departure_airport_iata,departure_airport_id,destination_airport_iata,destination_airport_id,codeshare,stops,equipment_string --ignoreBlanks --type csv --db flights --collection routes --file routes.csv
```

To convert equipment_string to array equipment:
```
db.routes.find().forEach(function(x) {
  if ( x.equipment_string != null ) {
    x.equipment = x.equipment_string.toString().split(" ")
    db.routes.save(x)
  }
})
```

To remove now-redundant equipment_string:
```
db.routes.update({},{$unset: {equipment_string: ""}}, {multi: true})
```

## airlines.csv

Same datasource

Columns:
* Airline ID: Unique OpenFlights identifier for this airline.
* Name: Name of the airline.
* Alias: Alias of the airline. For example, All Nippon Airways is commonly known as "ANA".
* IATA: 2-letter IATA code, if available.
* ICAO: 3-letter ICAO code, if available.
* Callsign: Airline callsign.
* Country: Country or territory where airline is incorporated.
* Active: "Y" if the airline is or has until recently been operational, "N" if it is defunct. This field is not reliable: in particular, major airlines that stopped flying long ago, but have not had their IATA code reassigned (eg. Ansett/AN), will incorrectly show as "Y".

Load into database using:
```
mongoimport --fields airline_id,name,alias,iata,icao,callsign,country,active --ignoreBlanks --type csv --db flights --collection airlines --file airlines.csv 
```

## Linking airplane IDs with routes
Tracking information does not have departure and destination information. This can be obtained through flightaware.

**NOT FINISHED**

Script:
```
echo "AAB555" >> flights_and_airports.txt
curl https://flightaware.com/live/flight/AAB555 | grep destination_IATA | head -n1 >> flights_and_airports.txt
```
Then in flights_and_airports.txt: replace
```
.*destination_IATA', '([^']+)'.*origin_IATA', '([^']+)'.*
```
with
```
\t$2\t$1
```

## Tracking data (as replacement for including them into routes)
Columns:
* time
* id
* hex
* flight
* squawk
* category
* lon
* lat
* altitude
* speed
* vert_rate

Remove all headers and combine into 1 file
```
cd flights_brussels_airport_february
ls *.csv > load_tracking.sh
```

Add to each of the lines in `load_tracking.sh`:
```
sleep 3
mongoimport --headerline --ignoreBlanks --type csv --db flights --collection tracking --file <the-csv-file>
```

And load:
```
sh load_tracking.sh
```

# Exam questions
## data modeling
flight tracking data

routes: [
  { from_airport: ...
    from_long: ...
    ...
    to_airport: ...
    to_long: ...
    flights: [
      { liftoff: 201705010815, <= =~ ID of flight
        flightnr: BEL88F,
        category: A3,
        tracking: [
          { time: ...,
            long: ...,
            lat: ...,
            speed: ...,
            vert_rate: ... },
          { time: ...,
            ... }]},
      { liftoff: 201705020815,
        flightnr: ...
        ... }]},
  { from_airport: ...
    ...}]

## mongodb
* describe the data model: which collections, which fields, ...
* how many airplanes were tracked on May 1, 2017?
* how many airplanes were tracked on May 1, 2017 for each category?
* how many flights stored in DB?
* list from_airport and to_airport (no other columns) for 5 routes
* how many countries have airports for which we have no routes?

## neo4j
* how mahy routes between BRU and Tokyo via Atlanta?
* idem without using a certain airline
