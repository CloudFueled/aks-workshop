const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());

// Health check
app.get('/health', (req, res) => {
  res.status(200).send({ status: 'OK', service: 'Imperial API' });
});

// Greet endpoint
app.post('/greet', (req, res) => {
  const { name } = req.body;
  if (!name) return res.status(400).send({ error: 'Name is required' });
  res.send({ message: `Greetings, ${name}. For the Empire!` });
});

app.listen(PORT, () => {
  console.log(`🚀 Imperial API running on port ${PORT}`);
});