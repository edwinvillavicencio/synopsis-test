CREATE OR REPLACE FUNCTION firstapi.delete_user(_username character varying)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    DELETE FROM Users WHERE username = _username;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'User with username % not found', _username;
    END IF;
END;
$function$
;