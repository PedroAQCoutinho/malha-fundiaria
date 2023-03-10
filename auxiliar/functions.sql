DROP FUNCTION IF EXISTS anyarray_uniq(anyarray);
CREATE OR REPLACE FUNCTION anyarray_uniq(with_array anyarray)
	RETURNS anyarray AS
$BODY$
	DECLARE
		-- The variable used to track iteration over "with_array".
		loop_offset integer;

		-- The array to be returned by this function.
		return_array with_array%TYPE := '{}';
	BEGIN
		IF with_array IS NULL THEN
			return NULL;
		END IF;
		
		IF with_array = '{}' THEN
		    return return_array;
		END IF;

		-- Iterate over each element in "concat_array".
		FOR loop_offset IN ARRAY_LOWER(with_array, 1)..ARRAY_UPPER(with_array, 1) LOOP
			IF with_array[loop_offset] IS NULL THEN
				IF NOT EXISTS(
					SELECT 1 
					FROM UNNEST(return_array) AS s(a)
					WHERE a IS NULL
				) THEN
					return_array = ARRAY_APPEND(return_array, with_array[loop_offset]);
				END IF;
			-- When an array contains a NULL value, ANY() returns NULL instead of FALSE...
			ELSEIF NOT(with_array[loop_offset] = ANY(return_array)) OR NOT(NULL IS DISTINCT FROM (with_array[loop_offset] = ANY(return_array))) THEN
				return_array = ARRAY_APPEND(return_array, with_array[loop_offset]);
			END IF;
		END LOOP;

	RETURN return_array;
 END;
$BODY$ LANGUAGE plpgsql;



DROP FUNCTION IF EXISTS anyarray_sort(anyarray);
CREATE OR REPLACE FUNCTION anyarray_sort(with_array anyarray)
	RETURNS SETOF anyarray AS
$BODY$
	BEGIN
		RETURN QUERY SELECT 
			ARRAY_AGG(sorted_vals.val) AS array_value
		FROM
			(
				SELECT
					UNNEST(with_array) AS val
				ORDER BY
					val
			) AS sorted_vals
		;
	END;
$BODY$ LANGUAGE plpgsql;


DROP FUNCTION IF EXISTS array_sort(anyarray);
CREATE FUNCTION
  array_sort(
    array_vals_to_sort anyarray
  )
  RETURNS TABLE (
    sorted_array anyarray
  )
  AS $BODY$
    BEGIN
      RETURN QUERY SELECT
        ARRAY_AGG(val) AS sorted_array
      FROM
        (
          SELECT
            UNNEST(array_vals_to_sort) AS val
          ORDER BY
            val
        ) AS sorted_vals
      ;
    END;
  $BODY$
LANGUAGE plpgsql;