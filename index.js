
const express = require('express');
const cors = require('cors');
const app = express();
const PORT = process.env.PORT || 5000;
const { Pool } = require('pg');

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

app.use(cors());
app.use(express.json());

app.post('/api/register', async (req, res) => {
  const { name, email, password, role } = req.body;
  const user = await pool.query(
    'INSERT INTO users (name, email, password_hash, role) VALUES ($1, $2, $3, $4) RETURNING *',
    [name, email, password, role]
  );
  res.json(user.rows[0]);
});

app.post('/api/ens', async (req, res) => {
  const { user_id, bl_number, vessel_name, port_loading, port_discharge } = req.body;
  const result = await pool.query(
    'INSERT INTO ens_applications (user_id, bl_number, vessel_name, port_loading, port_discharge, status) VALUES ($1, $2, $3, $4, $5, $6) RETURNING *',
    [user_id, bl_number, vessel_name, port_loading, port_discharge, 'Submitted']
  );
  res.json(result.rows[0]);
});

app.listen(PORT, () => console.log(`Server running on ${PORT}`));
