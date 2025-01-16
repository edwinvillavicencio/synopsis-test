CREATE TABLE firstapi.addresses (
	id bigserial NOT NULL,
	user_id int8 NOT NULL,
	street varchar(255) NULL,
	city varchar(255) NULL,
	state varchar(255) NULL,
	zip varchar(10) NULL,
	CONSTRAINT addresses_pkey PRIMARY KEY (id)
);

ALTER TABLE firstapi.addresses ADD CONSTRAINT addresses_user_id_fkey FOREIGN KEY (user_id) REFERENCES firstapi.users(id) ON DELETE CASCADE;