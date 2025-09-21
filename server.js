// server.js
const express = require('express');
const app = express();
const port = 3000;

// Your product data array
const products = [
  // ... your product data objects
];

// Add headers to allow your Flutter app to access the API
app.use((req, res, next) => {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
  next();
});

// A simple endpoint that returns a list of products
app.get('/products', (req, res) => {
  res.json(products);
});

app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});