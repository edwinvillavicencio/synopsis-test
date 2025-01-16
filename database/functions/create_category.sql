CREATE OR REPLACE FUNCTION firstapi.create_category(category_id bigint, name text)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO categories (id, name)
    VALUES (category_id, name);
END;
$function$
;