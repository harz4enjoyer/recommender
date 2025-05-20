// server.js
import express from 'express';
import { promises as fs } from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import cors from 'cors';

const app = express();
const PORT = 3000;

// ES Module fix for __dirname
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Path to JSON storage in public directory
const STORAGE_PATH = path.join(__dirname, '../public/persistent-storage/rezepte.json');

// Middleware
app.use(cors({
  origin: 'http://localhost:5173', // Vite dev server
  credentials: true
}));
app.use(express.json());

// Ensure storage directory exists
async function ensureDirectoryExists() {
  try {
    await fs.mkdir(path.join(__dirname, '../public/persistent-storage'), { recursive: true });
  } catch (error) {
    if (error.code !== 'EEXIST') throw error;
  }
}

// API endpoints
app.get('/api/json', async (req, res) => {
  try {
    const data = await fs.readFile(STORAGE_PATH, 'utf8');
    res.json(JSON.parse(data));
  } catch (error) {
    if (error.code === 'ENOENT') {
      // If file doesn't exist, return empty object
      res.json({});
    } else {
      res.status(500).json({ error: 'Error reading JSON file' });
    }
  }
});

app.post('/api/json', async (req, res) => {
  try {
    await ensureDirectoryExists();
    await fs.writeFile(STORAGE_PATH, JSON.stringify(req.body, null, 2));
    res.json({ message: 'File saved successfully' });
  } catch (error) {
    console.error('Error saving file:', error);
    res.status(500).json({ error: 'Error saving JSON file' });
  }
});

app.listen(PORT, () => {
  console.log(`API Server running on http://localhost:${PORT}`);
  console.log(`Saving data to: ${STORAGE_PATH}`);
});
