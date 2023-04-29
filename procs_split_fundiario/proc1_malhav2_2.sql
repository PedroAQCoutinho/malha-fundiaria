


SELECT sample_data(:run::int);
SELECT f_dump(:run::int);
SELECT split_polygons(:run::int);
select inserto_array_agg(:run::int);

INSERT INTO malhav2.aux_distinct (cd_grid)
SELECT :run::int















