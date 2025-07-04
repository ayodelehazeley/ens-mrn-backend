
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,
  role TEXT CHECK(role IN ('ENS', 'MRN', 'Admin', 'Finance', 'Validator')),
  status TEXT DEFAULT 'Active'
);

CREATE TABLE ens_applications (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  bl_number TEXT,
  vessel_name TEXT,
  port_loading TEXT,
  port_discharge TEXT,
  status TEXT DEFAULT 'Submitted',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE mrn_applications (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  vessel_name TEXT,
  imo_number TEXT,
  port_loading TEXT,
  port_discharge TEXT,
  eta DATE,
  etd DATE,
  status TEXT DEFAULT 'Submitted',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE payments (
  id SERIAL PRIMARY KEY,
  ens_application_id INTEGER REFERENCES ens_applications(id),
  user_id INTEGER REFERENCES users(id),
  amount NUMERIC,
  status TEXT,
  transaction_ref TEXT,
  date_paid TIMESTAMP
);

INSERT INTO users (name, email, password_hash, role) VALUES
('Admin', 'admin@example.com', 'adminpass', 'Admin'),
('ENS User', 'ens@example.com', 'enspass', 'ENS'),
('MRN User', 'mrn@example.com', 'mrnpass', 'MRN');
