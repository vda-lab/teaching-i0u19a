#!/usr/bin/env ruby
# To run: cat beers.csv | csv2json.rb > beers.json
require 'json'

STDIN.each do |line|
  fields = line.chomp.split(/,/)
  types = fields[2].split(/;/)
  beer_document = {:beer => fields[1], :brewery => fields[4], :type => types, :alcoholpercentage => fields[3].to_f}
  puts beer_document.to_json
end
