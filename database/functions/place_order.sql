CREATE OR REPLACE FUNCTION firstapi.place_order(_pet_id bigint, _quantity integer, _ship_date timestamp without time zone, _status character varying, _complete boolean)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE
    _order_id BIGINT;
BEGIN
    INSERT INTO Orders (pet_id, quantity, ship_date, status, complete)
    VALUES (_pet_id, _quantity, _ship_date, _status, _complete)
    RETURNING id INTO _order_id;

    RETURN _order_id;
END;
$function$
;