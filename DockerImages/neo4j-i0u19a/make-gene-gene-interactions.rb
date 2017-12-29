#!/usr/bin/env ruby
relationships = Hash.new

puts ":START_ID,nr_proofs,proofs,:END_ID,:TYPE"
STDIN.each do |line|
  gene1, gene2, proof, species1, species2 = line.chomp.split(/\t/)
  next unless species1 == "9606" and species2 == "9606"
  a,b = [gene1, gene2].sort
  key = [a,b].join(";")
  unless relationships.has_key?(key)
    relationships[key] = {:gene1 => a, :gene2 => b, :nr_proofs => 0, :proofs => []}
  end
  relationships[key][:proofs].push(proof)
  relationships[key][:nr_proofs] += 1
end
relationships.keys.each do |k|
  r = relationships[k]
  puts [r[:gene1],r[:nr_proofs],'"' + r[:proofs].join(',') + '"',r[:gene2],"INTERACTS_WITH"].join(",")
end
