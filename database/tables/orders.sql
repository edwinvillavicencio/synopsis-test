CREATE TABLE firstapi.orders (
	id bigserial NOT NULL,
	pet_id int8 NOT NULL,
	quantity int4 NOT NULL,
	ship_date timestamp NULL,
	status varchar(50) NULL,
	complete bool DEFAULT false NULL,
	CONSTRAINT orders_pkey PRIMARY KEY (id),
	CONSTRAINT orders_status_check CHECK (((status)::text = ANY ((ARRAY['placed'::character varying, 'approved'::character varying, 'delivered'::character varying])::text[])))
);