LOAD CSV FROM '/Users/jaerts/Google Drive/Teaching/I0U19A/graphs/biogrid/neo4j_relationships.csv' AS line
MERGE (n:A {number:line[0]})
WITH line, n
MERGE (m:B {number:line[1]})
WITH m,n
MERGE (n)-[:INTERACTS_WITH {proof: line[2]}]->(m);

