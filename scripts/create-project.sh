#!/bin/sh

echo "🚀 Creating Node.js project structure..."
echo "📂 Current directory:" && pwd
echo "📋 Directory contents before:"
ls -la
echo "👤 Running as user:" && id
echo "🔧 Setting up project..."

# Create package.json
cat > package.json << PACKAGE_EOF
{
  "name": "${APP_NAME:-my-node-app}",
  "version": "1.0.0",
  "description": "Node.js application built with Docker",
  "main": "src/server.js",
  "scripts": {
    "start": "node src/server.js",
    "dev": "nodemon src/server.js",
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage",
    "lint": "eslint src/",
    "lint:fix": "eslint src/ --fix",
    "security": "npm audit"
  },
  "keywords": ["node", "express", "docker", "api", "nginx"],
  "license": "MIT",
  "dependencies": {},
  "devDependencies": {}
}
PACKAGE_EOF

# Create directory structure
mkdir -p src/config src/controllers src/middleware src/models src/routes src/services src/utils
mkdir -p tests/unit tests/integration
mkdir -p docs
mkdir -p logs

# Create src/app.js
cat > src/app.js << 'APP_EOF'
const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');
const compression = require('compression');

const config = require('./config');
const routes = require('./routes');
const { errorHandler, notFound } = require('./middleware/error');

const app = express();

// Security middleware
app.use(helmet());
app.use(cors({
  origin: process.env.CORS_ORIGIN || '*',
  credentials: true
}));

// General middleware
app.use(compression());
app.use(morgan('combined'));
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true }));

// Health check endpoint
app.get('/health', (req, res) => {
  res.status(200).json({
    status: 'healthy',
    timestamp: new Date().toISOString(),
    uptime: process.uptime(),
    environment: process.env.NODE_ENV || 'development',
    version: process.env.npm_package_version || '1.0.0'
  });
});

// Nginx status endpoint (for nginx health checks)
app.get('/nginx-status', (req, res) => {
  res.status(200).json({
    status: 'ok',
    service: 'nginx-proxy-backend'
  });
});

// API routes
app.use('/api', routes);

// Error handling
app.use(notFound);
app.use(errorHandler);

module.exports = app;
APP_EOF

# Create src/server.js
cat > src/server.js << 'SERVER_EOF'
require('dotenv').config();
const app = require('./app');
const config = require('./config');

const PORT = process.env.PORT || config.port;

const server = app.listen(PORT, '0.0.0.0', () => {
  console.log(`🚀 Server running on port ${PORT} in ${process.env.NODE_ENV || 'development'} mode`);
});

// Graceful shutdown
process.on('SIGTERM', () => {
  console.log('SIGTERM signal received: closing HTTP server');
  server.close(() => {
    console.log('HTTP server closed');
    process.exit(0);
  });
});

process.on('SIGINT', () => {
  console.log('SIGINT signal received: closing HTTP server');
  server.close(() => {
    console.log('HTTP server closed');
    process.exit(0);
  });
});

module.exports = server;
SERVER_EOF

# Create src/config/index.js
cat > src/config/index.js << 'CONFIG_EOF'
module.exports = {
  port: process.env.PORT || 3000,
  nodeEnv: process.env.NODE_ENV || 'development',
  database: {
    url: process.env.DATABASE_URL || 'mongodb://localhost:27017/myapp'
  },
  redis: {
    url: process.env.REDIS_URL || 'redis://localhost:6379'
  },
  jwt: {
    secret: process.env.JWT_SECRET || 'your-super-secret-key',
    expiresIn: '24h'
  },
  cors: {
    origin: process.env.CORS_ORIGIN || '*'
  }
};
CONFIG_EOF

# Create src/routes/index.js
cat > src/routes/index.js << 'ROUTES_EOF'
const express = require('express');
const router = express.Router();

// Sample routes
router.get('/status', (req, res) => {
  res.json({
    message: 'API is running',
    timestamp: new Date().toISOString(),
    environment: process.env.NODE_ENV
  });
});

// Sample CRUD endpoints
let users = [
  { id: 1, name: 'John Doe', email: 'john@example.com' },
  { id: 2, name: 'Jane Smith', email: 'jane@example.com' }
];

router.get('/users', (req, res) => {
  res.json(users);
});

router.get('/users/:id', (req, res) => {
  const user = users.find(u => u.id === parseInt(req.params.id));
  if (!user) {
    return res.status(404).json({ error: 'User not found' });
  }
  res.json(user);
});

router.post('/users', (req, res) => {
  const { name, email } = req.body;
  if (!name || !email) {
    return res.status(400).json({ error: 'Name and email are required' });
  }
  
  const newUser = {
    id: Math.max(...users.map(u => u.id)) + 1,
    name,
    email
  };
  users.push(newUser);
  res.status(201).json(newUser);
});

router.put('/users/:id', (req, res) => {
  const userIndex = users.findIndex(u => u.id === parseInt(req.params.id));
  if (userIndex === -1) {
    return res.status(404).json({ error: 'User not found' });
  }
  
  const { name, email } = req.body;
  if (name) users[userIndex].name = name;
  if (email) users[userIndex].email = email;
  
  res.json(users[userIndex]);
});

router.delete('/users/:id', (req, res) => {
  const userIndex = users.findIndex(u => u.id === parseInt(req.params.id));
  if (userIndex === -1) {
    return res.status(404).json({ error: 'User not found' });
  }
  
  users.splice(userIndex, 1);
  res.status(204).send();
});

module.exports = router;
ROUTES_EOF

# Create src/middleware/error.js
cat > src/middleware/error.js << 'ERROR_EOF'
const notFound = (req, res, next) => {
  const error = new Error(`Not Found - ${req.originalUrl}`);
  res.status(404);
  next(error);
};

const errorHandler = (err, req, res, next) => {
  const statusCode = res.statusCode !== 200 ? res.statusCode : 500;
  res.status(statusCode);
  res.json({
    error: err.message,
    stack: process.env.NODE_ENV === 'production' ? null : err.stack,
    timestamp: new Date().toISOString()
  });
};

module.exports = { notFound, errorHandler };
ERROR_EOF

# Create test files
cat > tests/unit/app.test.js << 'TEST_EOF'
const request = require('supertest');
const app = require('../../src/app');

describe('App', () => {
  test('GET /health should return 200', async () => {
    const response = await request(app)
      .get('/health')
      .expect(200);
    
    expect(response.body.status).toBe('healthy');
  });

  test('GET /nginx-status should return 200', async () => {
    const response = await request(app)
      .get('/nginx-status')
      .expect(200);
    
    expect(response.body.status).toBe('ok');
    expect(response.body.service).toBe('nginx-proxy-backend');
  });
  
  test('GET /api/status should return 200', async () => {
    const response = await request(app)
      .get('/api/status')
      .expect(200);
    
    expect(response.body.message).toBe('API is running');
  });
  
  test('GET /api/users should return users array', async () => {
    const response = await request(app)
      .get('/api/users')
      .expect(200);
    
    expect(Array.isArray(response.body)).toBe(true);
  });
});
TEST_EOF

# Create configuration files
cat > .eslintrc.js << 'ESLINT_EOF'
module.exports = {
  env: {
    node: true,
    es2021: true,
    jest: true,
  },
  extends: [
    'eslint:recommended',
    'prettier'
  ],
  parserOptions: {
    ecmaVersion: 'latest',
    sourceType: 'module',
  },
  rules: {
    'no-console': process.env.NODE_ENV === 'production' ? 'warn' : 'off',
    'no-unused-vars': ['error', { argsIgnorePattern: '^_' }],
    'prefer-const': 'error',
    'no-var': 'error',
    'object-shorthand': 'error',
    'prefer-template': 'error',
    'template-curly-spacing': 'error',
    'arrow-spacing': 'error',
    'comma-dangle': ['error', 'es5'],
    'semi': ['error', 'always'],
    'quotes': ['error', 'single'],
    'indent': ['error', 2],
    'linebreak-style': ['error', 'unix'],
    'eol-last': 'error',
    'no-trailing-spaces': 'error',
  },
};
ESLINT_EOF

cat > .prettierrc << 'PRETTIER_EOF'
{
  "singleQuote": true,
  "trailingComma": "es5",
  "tabWidth": 2,
  "semi": true,
  "printWidth": 80,
  "bracketSpacing": true,
  "arrowParens": "avoid",
  "endOfLine": "lf"
}
PRETTIER_EOF

cat > jest.config.js << 'JEST_EOF'
module.exports = {
  testEnvironment: 'node',
  collectCoverageFrom: [
    'src/**/*.js',
    '!src/server.js',
  ],
  coverageDirectory: 'coverage',
  coverageReporters: ['text', 'lcov', 'html'],
  testMatch: [
    '**/tests/**/*.test.js',
  ],
  setupFilesAfterEnv: [],
  testTimeout: 10000,
  verbose: true,
  collectCoverage: false, // Set to true to always collect coverage
  coverageThreshold: {
    global: {
      branches: 70,
      functions: 70,
      lines: 70,
      statements: 70
    }
  }
};
JEST_EOF

cat > ecosystem.config.js << ECOSYSTEM_EOF
module.exports = {
  apps: [{
    name: '${APP_NAME:-my-node-app}',
    script: 'src/server.js',
    instances: 'max',
    exec_mode: 'cluster',
    env: {
      NODE_ENV: 'production',
      PORT: 3000
    },
    env_production: {
      NODE_ENV: 'production',
      PORT: 3000
    },
    error_file: './logs/err.log',
    out_file: './logs/out.log',
    log_file: './logs/combined.log',
    time: true,
    max_memory_restart: '500M',
    node_args: '--max-old-space-size=1024',
    merge_logs: true,
    log_date_format: 'YYYY-MM-DD HH:mm:ss Z',
    watch: false,
    ignore_watch: ['node_modules', 'logs', 'coverage'],
    instances_health_check: true,
    min_uptime: '10s',
    max_restarts: 10,
    autorestart: true,
    cron_restart: '0 2 * * *',
    kill_timeout: 5000,
    listen_timeout: 8000,
    wait_ready: true
  }]
};
ECOSYSTEM_EOF

echo "📦 Installing dependencies..."
npm i express cors helmet morgan compression dotenv
npm i -D nodemon jest supertest eslint eslint-config-prettier eslint-plugin-prettier prettier

echo "📋 Directory contents after:"
ls -la
echo "📁 Source directory contents:"
ls -la src/
echo "🧪 Tests directory contents:"
ls -la tests/

echo "✅ Node.js project created successfully!"
echo "📦 Dependencies installed"
echo "🚀 Run make dev to start development server"
