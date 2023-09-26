-- Create new db
create database humanClinic;

-- Create new tables
create table medical_histories(
  id int GENERATED ALWAYS AS IDENTITY,
  admitted_at timestamp,
  patient_id int,
  status varchar(80),
  PRIMARY KEY(id)
);

create table patients(
  id int GENERATED ALWAYS AS IDENTITY,
  name varchar(150),
  date_of_birth date,
  PRIMARY KEY(id)
);

create table treatments(
  id int GENERATED ALWAYS AS IDENTITY,
  type varchar(150),
  name varchar(150),
  PRIMARY KEY(id)
);

create table invoice_items(
  id int GENERATED ALWAYS AS IDENTITY,
  unit_price decimal(8,2),
  quantity int,
  total_price decimal(8,2),
  invoice_id int,
  treatment_id int,
  PRIMARY KEY(id)
);

create table invoices(
  id int GENERATED ALWAYS AS IDENTITY,
  total_amount decimal(8,2),
  generated_at timestamp,
  payed_at timestamp,
  medical_history_id int,
  PRIMARY KEY(id)
);


-- add foreign keys
ALTER TABLE medical_histories
ADD CONSTRAINT fk_patient_id
FOREIGN KEY(patient_id)
REFERENCES patients(id);

ALTER TABLE invoice_items
ADD CONSTRAINT fk_invoice_id
FOREIGN KEY(invoice_id)
REFERENCES invoices(id);

ALTER TABLE invoice_items
ADD CONSTRAINT fk_treatment_id
FOREIGN KEY(treatment_id)
REFERENCES treatments(id);

ALTER TABLE invoices
ADD CONSTRAINT fk_medical_history_id
FOREIGN KEY(medical_history_id)
REFERENCES medical_histories(id),
ADD CONSTRAINT unique_medical_history_id
UNIQUE (medical_history_id);

-- create junction (bridge) table
create table histories_treatments(
  id int GENERATED ALWAYS AS IDENTITY,
  medical_history_id int,
  treatment_id int,
  PRIMARY KEY(id)
);

ALTER TABLE histories_treatments
ADD CONSTRAINT fk_medical_history_id
FOREIGN KEY(medical_history_id)
REFERENCES medical_histories(id),
ADD CONSTRAINT fk_treatment_id
FOREIGN KEY(treatment_id)
REFERENCES treatments(id);
