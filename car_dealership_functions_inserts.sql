-- Customer table INSERTS and FUNCTIONS
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


-- Car table INSERTS and FUNCTIONS

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


-- Sales_person table INSERTS and FUNCTIONS

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


-- Mechanic table INSERTS and FUNCTIONS

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


-- Parts_required table INSERTS and FUNCTIONS

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


-- Services table INSERTS and FUNCTIONS
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

-- Invoice table INSERTS and FUNCTIONS
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


-- Car_history table INSERTS and FUNCTIONS

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