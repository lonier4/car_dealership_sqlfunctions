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

CREATE TABLE sales_person(
	sales_person_id SERIAL PRIMARY KEY,
	first_name VARCHAR(100),
	last_name VARCHAR(100)
);

SELECT *
FROM sales_person;

CREATE TABLE mechanic(
	mechanic_id SERIAL PRIMARY KEY,
	first_name  VARCHAR(100),
	last_name VARCHAR(100)
);

SELECT *
FROM mechanic;

CREATE TABLE parts_required(
	parts_id SERIAL PRIMARY KEY,
	parts_name VARCHAR(300)
);

SELECT *
FROM parts_required;

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

CREATE TABLE car_history(
	car_history_id SERIAL PRIMARY KEY,
	invoice_id INTEGER NOT NULL,
	mechanic_id INTEGER,
	FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id),
	FOREIGN KEY (mechanic_id) REFERENCES mechanic(mechanic_id)
);

SELECT *
FROM car_history;