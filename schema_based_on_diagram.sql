CREATE TABLE patients (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100),
	date_of_birth DATE
);

CREATE TABLE treatments (
	id SERIAL PRIMARY KEY,
	type VARCHAR(100),
	name VARCHAR(100)
);

CREATE TABLE medical_histories (
	id SERIAL PRIMARY KEY,
	admitted_at TIMESTAMP,
	patient_id INTEGER REFERENCES patients(id),
	status VARCHAR(100)
);

CREATE TABLE invoices (
	id SERIAL PRIMARY KEY,
	total_amount DECIMAL,
	generated_at TIMESTAMP,
	payed_at TIMESTAMP,
	medical_history_id INTEGER REFERENCES medical_histories(id)
);

CREATE TABLE invoice_items (
	id SERIAL PRIMARY KEY,
	unit_price DECIMAL,
	quantity DECIMAL,
	total_price DECIMAL,
	invoice_id INTEGER REFERENCES invoices(id),
	treatment_id INTEGER REFERENCES treatments(id)
);