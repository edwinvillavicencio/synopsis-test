CREATE TABLE firstapi.pets (
	id bigserial NOT NULL,
	"name" varchar(255) NOT NULL,
	category_id int8 NULL,
	status varchar(50) NULL,
	CONSTRAINT pets_pkey PRIMARY KEY (id),
	CONSTRAINT pets_status_check CHECK (((status)::text = ANY ((ARRAY['available'::character varying, 'pending'::character varying, 'sold'::character varying])::text[])))
);

ALTER TABLE firstapi.pets ADD CONSTRAINT pets_category_id_fkey FOREIGN KEY (category_id) REFERENCES firstapi.categories(id) ON DELETE SET NULL;