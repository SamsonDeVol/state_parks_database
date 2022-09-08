<h1 style="text-align: center">National Parks Database</h1>
<body style="background-color: rgba(168,126,204,0.3); text-align: center">
<form method="post">
  Query: <input type="text" name="user_query">
  <input type="submit"><br>
</form>
<form method="post"> 
	<input type="submit" name="display_parks"
			value="Display Parks"/> 	
	<input type="submit" name="query1"
			value="Query 1"/> 
  <input type="submit" name="query2"
			value="Query 2"/> 
  <input type="submit" name="query3"
			value="Query 3"/> 
  <input type="submit" name="query4"
			value="Query 4"/> 
  <input type="submit" name="query5"
			value="Query 5"/> 
</form> 
<?php

# Load new db and read from sql file
$db = new SQLite3('database.db', SQLITE3_OPEN_CREATE | SQLITE3_OPEN_READWRITE);
$db->query(file_get_contents('schema.sql'));

$result = 0;
# Basic table to display Parks entity
# C&P format for 5 queries following
if(isset($_POST['query1'])) { 
  echo "<p>Query 1: Ranger Danger</p>"; 
  $result = $db->query('SELECT I.pname AS park, W.species AS dead_on_sight
  FROM INHABITATION AS I, POPULAR_WILDLIFE AS W
  WHERE W.species = I.species AND W.species IN
  (SELECT species 
  FROM POPULAR_WILDLIFE 
  WHERE threat_level = \'dead_on_sight\')
  ORDER BY dead_on_sight
  LIMIT 5');
}
if(isset($_POST['query2'])) { 
  echo "<p>Query 2: Scared Shitless</p>"; 
  $result = $db->query('SELECT I.pname AS park, W.species AS dead_on_sight, A.aname AS attraction_with_open_restroom
  FROM (INHABITATION AS I JOIN POPULAR_WILDLIFE AS W ON I.species = W.species)
  JOIN ATTRACTION AS A ON I.pname = A.pname
  WHERE A.open = 1 AND A.restroom = 1 AND W.species IN
  (SELECT species FROM POPULAR_WILDLIFE
  WHERE threat_level = \'dead_on_sight\')
  GROUP BY dead_on_sight
  ORDER BY A.aname ASC
  LIMIT 5;
  ');
} 
if(isset($_POST['query3'])) { 
  echo "<p>Query 3: Can't Stop Won't Stop</p>"; 
  $result = $db->query('SELECT P.name, A.type, A.description 
  FROM PARK AS P, ACTIVITY AS A 
  WHERE P.name IN 
  (SELECT pname 
  FROM LODGING 
  WHERE open_date = "2022-01-01" AND close_date = "2022-12-31")
  ORDER BY P.name DESC
  LIMIT 5;
  ');
} 
if(isset($_POST['query4'])) { 
  echo "<p>Query 4: Trail and Chow</p>"; 
  $result = $db->query('SELECT A1.pname AS park, A1.aname AS trail, T.length AS length, A2.aname AS center_with_food
  FROM ((ATTRACTION AS A1 NATURAL JOIN TRAIL AS T) JOIN (ATTRACTION AS A2 NATURAL JOIN VISITOR_CENTER AS VC) ON A1.pname = A2.pname)
  WHERE T.length >= 10 AND A1.open = 1 AND A2.open = 1 AND VC.food = 1
  ORDER BY A1.aname
  LIMIT 5;
  ');
} 
if(isset($_POST['query5'])) { 
  echo "<p>Query 5: Most Attractive</p>"; 
  $result = $db->query('SELECT name, COUNT(pname) AS attractions, size/COUNT(pname) AS acres_per_attraction
  FROM (PARK AS P LEFT JOIN ATTRACTION AS A ON (P.name = A.pname))
  GROUP BY pname HAVING COUNT(pname) > 0
  ORDER BY size/COUNT(pname) ASC
  LIMIT 5;
  ');
} 
if(isset($_POST['user_query'])) { 
  echo $_POST["user_query"];
  $result = $db->query($_POST["user_query"]);
}
else if(isset($_POST['display_parks'])) { 
  echo "<p> Display Parks </p>";
  $result = $db->query('SELECT * FROM "PARK"');
} 

if($result){
  echo "<table border='1' style='background-color: white; margin-left: auto; 
  margin-right: auto'>";
  # Print table names
  $i = 0;
  while($name = $result->columnName($i)){
    echo "<th>{$name}</th>";
    $i = $i+1;
  }

  # Print table tuples
  while($row = $result->fetchArray(SQLITE3_ASSOC)){
    echo "<tr>";
    foreach($row as $row){
      echo "<td>{$row}</td>";
    };
    echo "</tr>";
  }
  echo "</table>";
}
?>
</body>
<body2 style="text-align: left">
  <h3>
    Query Descriptions 
  </h3>
  <h4>
    Query 1: Ranger Danger - list of parks with dead-on-sight wildlife and the dead-on-sight wildlife
  </h4>
  <p>
  SELECT I.pname AS park, W.species AS dead_on_sight <br>
  FROM INHABITATION AS I, POPULAR_WILDLIFE AS W <br> 
  WHERE W.species = I.species AND W.species IN <br> 
  &nbsp &nbsp (SELECT species <br>
  &nbsp &nbsp FROM POPULAR_WILDLIFE <br>
  &nbsp &nbsp WHERE threat_level = 'dead_on_sight') <br>
  ORDER BY dead_on_sight <br>
  LIMIT 5; <br>
  </p>
  <h4>
    Query 2: Scared Shitless - Which attractions you can find OPEN restrooms at in parks with dead on sight wildlife
  </h4>
  <p>
  SELECT I.pname AS park, W.species AS dead_on_sight, A.aname AS <br>
  attraction_with_open_restroom <br>
  FROM (INHABITATION AS I JOIN POPULAR_WILDLIFE AS W ON I.species = W.species) <br>
  JOIN ATTRACTION AS A ON I.pname = A.pname <br>
  WHERE A.open = 1 AND A.restroom = 1 AND W.species IN <br> 
  &nbsp &nbsp (SELECT species <br> 
  &nbsp &nbsp  FROM POPULAR_WILDLIFE <br> 
  &nbsp &nbsp  WHERE threat_level = 'dead_on_sight') <br> 
  GROUP BY dead_on_sight <br>
  ORDER BY A.aname ASC <br> 
  LIMIT 5; <br>

  </p>
  <h4>
    Query 3: Can’t Stop Won't Stop - Activities from parks that has a lodge open year round.
  </h4>
  <p>
  SELECT P.name, A.type, A.description <br>
  FROM PARK AS P, ACTIVITY AS A <br>
  WHERE P.name IN <br>
  &nbsp &nbsp (SELECT pname <br>
  &nbsp &nbsp FROM LODGING <br>
  &nbsp &nbsp WHERE open_date = '2022-01-01' AND close_date =  '2022-12-31') <br>
  ORDER BY P.name DESC <br>
  LIMIT 5; <br>

  </p>
  <h4>
    Query 4: Trail and Chow - Parks with long hikes (10 miles or more) and open visitor centers with food to refuel
  </h4>
  <p>
  SELECT A1.pname AS park, A1.aname AS trail, T.length AS length, A2.aname AS center_with_food
  FROM ((ATTRACTION AS A1 NATURAL JOIN TRAIL AS T) JOIN (ATTRACTION AS A2 NATURAL JOIN VISITOR_CENTER AS VC) ON A1.pname = A2.pname)
  WHERE T.length >= 10 AND A1.open = 1 AND A2.open = 1 AND VC.food = 1
  ORDER BY A1.aname
  LIMIT 5;
  </p>
  <h4>
    Query 5: Most Attractive - Parks with the highest ratio of attractions per acre (or least acres per attraction)
  </h4>
  <p>
  SELECT A1.pname AS park, A1.aname AS trail, T.length AS length, A2.aname AS center_with_food <br>
  FROM ((ATTRACTION AS A1 NATURAL JOIN TRAIL AS T) JOIN (ATTRACTION AS A2 NATURAL JOIN VISITOR_CENTER AS VC) ON A1.pname = A2.pname) <br>
  WHERE T.length >= 10 AND A1.open = 1 AND A2.open = 1 AND VC.food = 1 <br>
  ORDER BY A1.aname <br>
  LIMIT 5; <br>
</body2>