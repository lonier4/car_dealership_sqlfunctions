CREATE TABLE customer(
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	phone_number VARCHAR(100),
	email VARCHAR(100),
	payment_type VARCHAR(100)
);

SELECT *
FROM customer;

INSERT INTO customer(
	first_name,
	last_name,
	phone_number,
	email,
	payment_type
)
VALUES (
	'Fernando',
	'Casanova',
	123-456-7890,
	'fernandocasanova@aol.com',
	'credit card'
);

UPDATE customer
SET phone_number = 1234567890
WHERE customer_id = 1;

CREATE OR REPLACE FUNCTION add_customer( _first_name VARCHAR, _last_name VARCHAR, _phone INTEGER, _email VARCHAR, _payment_type VARCHAR)
RETURNS void
AS $$
BEGIN
	INSERT INTO customer( first_name, last_name, phone_number, email, payment_type)
	VALUES( _first_name, _last_name, _phone, _email, _payment_type);
END;	
$$
LANGUAGE plpgsql;

SELECT add_customer('Billy', 'Sky', 0987654321, 'billybob@aol.com', 'cash');

DROP FUNCTION add_customer;

-- Function error when calling 2nd and 3rd add_customer
SELECT add_customer('Clarice', 'Red', 2223334444, 'claricered@aol.com', 'jelly beans');
SELECT add_customer('Gabrielle', 'Orange', 7771119999, 'gabrielleorange@aol.com', 'jelly beans');

DELETE FROM customer
WHERE customer_id IN(2, 3, 4);

INSERT INTO customer(
	first_name,
	last_name,
	phone_number,
	email,
	payment_type
)
VALUES (
	'Clarice',
	'Red',
	2223334444,
	'claricered@aol.com',
	'jelly beans'
),
(
	'Gabrielle',
	'Orange',
	7771119999,
	'gabrielleorange@aol.com',
	'jelly beans'
);

CREATE TABLE car(
	car_id SERIAL PRIMARY KEY,
	year_ INTEGER,
	make VARCHAR(100),
	model VARCHAR(100),
	used_new VARCHAR(100),
	car_price INTEGER
);

SELECT *
FROM car;

CREATE OR REPLACE FUNCTION add_car(car_year INTEGER, car_make VARCHAR, car_model VARCHAR, _used_new VARCHAR, _car_price INTEGER)
RETURNS void
AS $$
BEGIN
	INSERT INTO car(year_, make, model, used_new, car_price)
	VALUES (car_year, car_make, car_model, _used_new, _car_price);	
END;
$$
LANGUAGE plpgsql;

SELECT add_car(2021, 'Honda', 'Civic', 'new', 25000);
SELECT add_car(1975, 'Chevy', 'Nova', 'used', 15000);
SELECT add_car(2000, 'Toyota', 'Tundra', 'used', 17500);

CREATE TABLE sales_person(
	sales_person_id SERIAL PRIMARY KEY,
	first_name VARCHAR(100),
	last_name VARCHAR(100)
);

SELECT *
FROM sales_person;

CREATE OR REPLACE FUNCTION add_sales_person(_first_name VARCHAR, _last_name VARCHAR)
RETURNS void
AS $$
BEGIN
	INSERT INTO sales_person(first_name, last_name)
	VALUES(_first_name, _last_name);
END;
$$
LANGUAGE plpgsql;

SELECT add_sales_person('Joe', 'Moneybags');
SELECT add_sales_person('Porticia', 'Ferdinand');

CREATE TABLE mechanic(
	mechanic_id SERIAL PRIMARY KEY,
	first_name  VARCHAR(100),
	last_name VARCHAR(100)
);

SELECT *
FROM mechanic;

INSERT INTO mechanic(
	first_name,
	last_name
)
VALUES(
	'Helena',
	'Santos'
),
(
	'Maya',
	'Carrolton'
);

CREATE TABLE parts_required(
	parts_id SERIAL PRIMARY KEY,
	parts_name VARCHAR(300)
);

SELECT *
FROM parts_required;

INSERT INTO parts_required(
	parts_name
)
VALUES(
	'brakes'
),
(
	'fuel filter'
),
(
	'alternator'
),
(
	'starter'
),
(
	'spark plug'
),
(
	'battery'	
),
(
	'tire'
);

CREATE TABLE services(
	service_ticket_id SERIAL PRIMARY KEY,
	service_price INTEGER,
	parts_id INTEGER,
	mechanic_id INTEGER NOT NULL,
	FOREIGN KEY(parts_id) REFERENCES parts_required(parts_id),
	FOREIGN KEY (mechanic_id) REFERENCES mechanic(mechanic_id)
);

SELECT *
FROM services;

INSERT INTO services(
	service_price,
	parts_id,
	mechanic_id
)
VALUES(
	100,
	1,
	2
),
(
	300,
	2,
	1
),
(
	750,
	3,
	1
),
(
	575,
	4,
	2
),
(
	1500,
	5,
	1
),
(
	425.50,
	6,
	2
),
(
	999.99,
	7,
	2
);

CREATE TABLE invoice(
	invoice_id SERIAL PRIMARY KEY,
	service_ticket_id INTEGER,
	customer_id INTEGER NOT NULL,
	car_id INTEGER NOT NULL,
	sales_person_id INTEGER,
	FOREIGN KEY (service_ticket_id) REFERENCES services(service_ticket_id),
	FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
	FOREIGN KEY (car_id) REFERENCES car(car_id),
	FOREIGN KEY (sales_person_id) REFERENCES sales_person(sales_person_id)
);

SELECT *
FROM invoice;

INSERT INTO invoice(
	service_ticket_id,
	customer_id,
	car_id,
	sales_person_id
)
VALUES(
	2,
	5,
	1,
	2
),
(
	1,
	6,
	2,
	1
),
(
	3,
	7,
	3,
	1
);

CREATE TABLE car_history(
	car_history_id SERIAL PRIMARY KEY,
	invoice_id INTEGER NOT NULL,
	mechanic_id INTEGER,
	FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id),
	FOREIGN KEY (mechanic_id) REFERENCES mechanic(mechanic_id)
);

SELECT *
FROM car_history;

INSERT INTO car_history(
	invoice_id,
	mechanic_id
)
VALUES(
	4,
	2
),
(
	5,
	1
),
(
	6,
	2
);

--Testing
SELECT *
FROM mechanic
JOIN services ON mechanic.mechanic_id = services.mechanic_id
WHERE parts_id =1;

