
\echo RUN :run
select car_dump(nextval('car.car_break_seq')::text);
select split_polygons(currval('car.car_break_seq')::text);
select inserto_array_agg(currval('car.car_break_seq')::text);


