
db.beers.aggregate([
  {$match: {alcoholpercentage: {$gt: 8}}},
  {$group: {_id: "$brewery", avg:{$avg: "$alcoholpercentage"}}}
])

db.beers.aggregate([
  {$group: {_id: "$brewery", avg:{$avg: "$alcoholpercentage"}}},
  {$match: {avg: {$gt: 10}}}
])
