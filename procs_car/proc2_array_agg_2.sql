
\echo a 
select car_dump(nextval('car.car_break_seq')::text);
\echo b
select split_polygons(currval('car.car_break_seq')::text);
\echo c 
select inserto_array_agg(currval('car.car_break_seq')::text);