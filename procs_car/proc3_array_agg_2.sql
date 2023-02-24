\car_dump :var_proc
select car_dump(:var_proc)
\split polygons :var_proc
select split_polygons(:var_proc)
\insert_array_agg :var_proc
select inserto_array_agg(:var_proc)