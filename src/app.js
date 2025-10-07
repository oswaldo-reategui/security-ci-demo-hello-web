const express = require('express');
const app = express();

// Minimal hardening
app.disable('x-powered-by');

// A very small health endpoint
app.get('/health', (_req, res) => {
  res.status(200).json({ status: 'ok' });
});

module.exports = app;
