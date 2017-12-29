#!/usr/bin/env ruby
require 'mongo'

Mongo::Logger.logger.level = ::Logger::FATAL

client = Mongo::Client.new([ '127.0.0.1:27017' ], :database => 'flights')
collection = client[:airports]
airports = Hash.new

client[:airports].find.each do |airport|
  airports[airport['name']] = airport['icao']
end

from_airports = Array.new
File.open('flights.csv').each do |line|
  from_airports.push(line.chomp.split(',')[0])
end

airport_matches = Hash.new
counter = 0
from_airports.each do |from_airport|
  counter += 1
  if counter%100 == 0
    STDERR.puts counter
  end

  found = false

  # 1. Find exact match
  if airports.include?(from_airport)
    puts 1
    airport_matches[from_airport] = airports[from_airport]
    # puts [from_airport, airports[from_airport]].join("\t")
    found = true
  end
  
  # 2. Find first part of airport name in flights file
  if not found
    matches = Array.new
    airports.keys.each do |key|
      modified_key = key.sub(/ .*/,'')
      if from_airport =~ /#{modified_key}/
        matches.push(key)
      end
    end
    if matches.length == 1
      puts 2
      # puts [from_airport, matches[0], airports[matches[0]]].join("\t")
      airport_matches[from_airport] = airports[from_airport]
      found = true
    end
  end

  # 3. Find first part of flights file in airport name
  if not found
    matches = Array.new
    airports.keys.each do |key|
      modified_from_airport = from_airport.sub(/ .*/,'')
      if key =~ /#{modified_from_airport}/
        matches.push(key)
      end
    end
    if matches.length == 1
      # puts [from_airport, matches[0], airports[matches[0]]].join("\t")
      airport_matches[from_airport] = airports[from_airport]
      puts 3
      found = true
    end
  end

  # 4. Not found
  if not found
    puts 4
    # puts from_airport
  end
end

outfile = File.open('airport_matches.txt','w')
airport_matches.keys.each do |k|
  outfile.puts [k, airport_matches[k]].join("\t")
end
outfile.close