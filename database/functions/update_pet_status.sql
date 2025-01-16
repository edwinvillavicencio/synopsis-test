CREATE OR REPLACE FUNCTION firstapi.update_pet_status(_pet_id bigint, _status character varying)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE Pets
    SET status = _status
    WHERE id = _pet_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Pet with ID % not found', _pet_id;
    END IF;
END;
$function$
;