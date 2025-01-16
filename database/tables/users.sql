CREATE TABLE firstapi.users (
	id bigserial NOT NULL,
	username varchar(255) NOT NULL,
	first_name varchar(255) NULL,
	last_name varchar(255) NULL,
	email varchar(255) NULL,
	"password" varchar(255) NULL,
	phone varchar(255) NULL,
	user_status int4 NULL,
	CONSTRAINT users_pkey PRIMARY KEY (id),
	CONSTRAINT users_username_key UNIQUE (username)
);