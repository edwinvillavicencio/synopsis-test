CREATE OR REPLACE FUNCTION firstapi.create_pet(
    name VARCHAR,
    categoryId BIGINT,
    status VARCHAR
)
RETURNS SETOF firstapi.create_pet_return_type AS $$
DECLARE
    pet_id BIGINT;
    result firstapi.create_pet_return_type;  -- Variable de tipo compuesto
BEGIN
    -- Insertar nuevo pet
    INSERT INTO firstapi.pets (name, category_id, status)
    VALUES (name, categoryId, status)
    RETURNING id INTO pet_id;

    -- Asignamos el valor a la variable 'result'
    result.id := pet_id;

    -- Retornar el registro con el id generado
    RETURN NEXT result;

    -- No es necesario un RETURN final, ya que RETURN NEXT ya maneja el flujo
END;
$$ LANGUAGE plpgsql;