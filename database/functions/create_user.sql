CREATE OR REPLACE FUNCTION firstapi.create_user(_username character varying, _first_name character varying, _last_name character varying, _email character varying, _password character varying, _phone character varying, _user_status integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO Users (username, first_name, last_name, email, password, phone, user_status)
    VALUES (_username, _first_name, _last_name, _email, _password, _phone, _user_status);
END;
$function$
;