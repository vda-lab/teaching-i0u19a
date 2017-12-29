// To get number of beers per brewery
// Difficulty: easy
var mapFunction1 = function() {
  emit(this.brewery, 1)
}

var reduceFunction1 = function(key, value) {
  return Array.sum(value)
}

db.beers.mapReduce(
  mapFunction1,
  reduceFunction1,
  {out: "numberBeersPerBrewery"}
)

// To get strongest beer
// Don't use
var mapFunction2 = function() {
  for (var i = 0; i < this.beers.length; i++ ) {
    emit(this.beers[i].name, this.beers[i].alcoholpercentage)
  }
}
var reduceFunction2 = function(beer, percentage) {

}
db.breweries.mapReduce(
  mapFunction2,
  reduceFunction2,
  {out: "test"}
)

// To get average percentage per brewery
// Difficulty: hard
var mapFunction3 = function() {
  for (var i = 0; i < this.beers.length; i++ ) {
    emit(this.brewery,
         {count: 1, percentage: this.beers[i].alcoholpercentage})
  }
}
var reduceFunction3 = function(brewery, percentages) {
  reducedVal = {count: 0, total: 0}
  for ( var i = 0; i < percentages.length; i++ ) {
    reducedVal.count += percentages[i].count
    reducedVal.total += percentages[i].percentage
  }
  return reducedVal
}
var finalizeFunction3 = function(brewery, reducedVal) {
  return reducedVal.total/reducedVal.count
}
db.breweries.mapReduce(
  mapFunction3,
  reduceFunction3,
  {out: "avgPercentage",
   finalize: finalizeFunction3}
)

// Most common type of beer
// Difficulty: medium
// Count per type
var mapFunction4 = function() {
  for ( var i = 0; i < this.beers.length; i++ ) {
    emit(this.beers[i].type, 1)
  }
}
var reduceFunction4 = function(k,v) {
  return Array.sum(v)
}
db.breweries.mapReduce(
  mapFunction4,
  reduceFunction4,
  { out: "countPerType" }
)
