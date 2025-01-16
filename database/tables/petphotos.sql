CREATE TABLE firstapi.petphotos (
	id bigserial NOT NULL,
	pet_id int8 NOT NULL,
	photo_url text NOT NULL,
	CONSTRAINT petphotos_pkey PRIMARY KEY (id)
);

ALTER TABLE firstapi.petphotos ADD CONSTRAINT petphotos_pet_id_fkey FOREIGN KEY (pet_id) REFERENCES firstapi.pets(id) ON DELETE CASCADE;