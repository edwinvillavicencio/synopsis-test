CREATE TABLE firstapi.pettags (
	pet_id int8 NOT NULL,
	tag_id int8 NOT NULL,
	CONSTRAINT pettags_pkey PRIMARY KEY (pet_id, tag_id)
);

ALTER TABLE firstapi.pettags ADD CONSTRAINT pettags_pet_id_fkey FOREIGN KEY (pet_id) REFERENCES firstapi.pets(id) ON DELETE CASCADE;
ALTER TABLE firstapi.pettags ADD CONSTRAINT pettags_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES firstapi.tags(id) ON DELETE CASCADE;