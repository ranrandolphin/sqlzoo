-- 1. How many stops are in the database.
SELECT count(*) FROM stops;

-- 2. Find the id value for the stop 'Craiglockhart'
SELECT id FROM stops WHERE name = 'Craiglockhart';

-- 3. Give the id and the name for the stops on the '4' 'LRT' service.
SELECT id, name FROM stops JOIN route ON stops.id = route.stop
WHERE num = 4
AND company  = 'LRT';

-- 4. The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53). 
-- Run the query and notice the two services that link these stops have a count of 2. 
-- Add a HAVING clause to restrict the output to these two routes.
SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING count(*) = 2;

-- 5. Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, 
-- without changing routes. 
-- Change the query so that it shows the services from Craiglockhart to London Road.
SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 AND b.stop = 149;

-- 6. The query shown is similar to the previous one, however by joining two copies of the stops table we can refer to stops by name rather than by number. 
-- Change the query so that the services between 'Craiglockhart' and 'London Road' are shown. 
-- If you are tired of these places try 'Fairmilehead' against 'Tollcross'
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart'
AND stopb.name = 'London Road'

-- 7. Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')
SELECT DISTINCT a.company, a.num
FROM route a
JOIN route b
ON a.num = b.num
WHERE a.stop = 115 AND b.stop = 137;

-- 8. Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'
SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON a.num = b.num
JOIN stops sa ON a.stop = sa.id
JOIN stops sb ON b.stop = sb.id
WHERE sa.name = 'Craiglockhart'
AND sb.name = 'Tollcross';

-- 9.Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, 
-- including 'Craiglockhart' itself, offered by the LRT company. 
-- Include the company and bus no. of the relevant services.
SELECT DISTINCT sa.name, a.company, a.num
FROM route a 
JOIN route b ON a.num = b.num AND a.company = b.company
JOIN stops sa ON sa.id = a.stop
JOIN stops sb ON sb.id = b.stop
WHERE sb.name = 'Craiglockhart';

-- 10. Find the routes involving two buses that can go from Craiglockhart to Sighthill.
-- Show the bus no. and company for the first bus, the name of the stop for the transfer,
-- and the bus no. and company for the second bus.
-- (Not correct actually！some tricks)
SELECT   a.num, a.company, trans1.name ,  c.num,  c.company
FROM route a JOIN route b
ON (a.company = b.company AND a.num = b.num)
JOIN ( route c JOIN route d ON (c.company = d.company AND c.num= d.num))
JOIN stops start ON (a.stop = start.id)
JOIN stops trans1 ON (b.stop = trans1.id)
JOIN stops trans2 ON (c.stop = trans2.id)
JOIN stops end ON (d.stop =  end.id)
WHERE  start.name = 'Craiglockhart' 
AND end.name = 'Sighthill'
AND  trans1.name = trans2.name 

-- (Need to add)
ORDER BY LENGTH(a.num), b.num, trans1.id, LENGTH(c.num), d.num;
-- Why?
