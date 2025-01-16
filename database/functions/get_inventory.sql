CREATE OR REPLACE FUNCTION firstapi.get_inventory()
 RETURNS TABLE(status character varying, quantity integer)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT status, SUM(quantity)
    FROM Inventory
    GROUP BY status;
END;
$function$
;