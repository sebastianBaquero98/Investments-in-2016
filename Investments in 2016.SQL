--- SOLUTION # 1 (1132ms - Beats 5.89%)
SELECT
    ROUND(SUM(tiv_2016),2) as tiv_2016
FROM
    Insurance
WHERE (tiv_2015) in
    (SELECT
        tiv_2015
    FROM
        Insurance
    GROUP BY
        tiv_2015
    HAVING
        COUNT(*) > 1)
    AND (lat,lon) IN
    (SELECT
       lat,
       lon
    FROM
        Insurance
    GROUP BY
        lat,lon
    HAVING COUNT(*) =1)
    
    
    
    
--- SOLUTION #2 (445ms - Beats 71.73%)
SELECT
    ROUND(SUM(tiv_2016), 2) as tiv_2016
FROM
    (SELECT *,
        count(*) OVER (PARTITION BY tiv_2015) as tiv_count,
        count(*) OVER (PARTITION BY lat, lon) as lat_lon_count
    FROM insurance
    ) t 
WHERE tiv_count > 1 AND lat_lon_count = 1;
