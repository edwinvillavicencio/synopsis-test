CREATE TABLE firstapi.inventory (
	status varchar(50) NOT NULL,
	quantity int4 NOT NULL,
	CONSTRAINT inventory_pkey PRIMARY KEY (status),
	CONSTRAINT inventory_status_check CHECK (((status)::text = ANY ((ARRAY['available'::character varying, 'pending'::character varying, 'sold'::character varying])::text[])))
);