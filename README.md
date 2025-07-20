# Node.js Docker Template 🐳🚀

A comprehensive, production-ready Docker template for Node.js applications with **zero local dependencies**. Create, develop, test, and deploy Node.js apps using only Docker and Make - no need to install Node.js, npm, or any packages on your host machine.

## ✨ Features

- 🚀 **Zero Local Dependencies** - Everything runs in Docker containers
- 🔥 **Hot Reload Development** - Real-time code changes with volume mounting
- 🏗️ **Multi-Stage Production Builds** - Optimized production builds with minimal image size
- 🌐 **Multiple Deployment Options** - Express API server, static file serving, or background services
- 📦 **Enhanced Package Management** - Install, update, and manage dependencies in containers
- 🔧 **Comprehensive DevOps** - Health checks, monitoring, debugging, and cleanup tools
- 🎯 **Intelligent Environment Management** - Flexible configuration with .env support
- 🧪 **Testing & Quality Tools** - Built-in testing, linting, and security scanning
- 💾 **Backup & Restore** - Project configuration backup and restore capabilities
- 🎨 **Rich CLI Experience** - Colorized output and comprehensive help system

## ✅ Requirements

- **Docker** (20.10+)
- **Make** (available by default in Unix/Linux/macOS; for Windows use WSL, Git Bash, or chocolatey)
- **Git** (optional, for version control)

---

## 🚀 Quick Start

### 1. Create a new Node.js app

```bash
make create
```

This command:
- Creates a new Node.js project structure with Express.js
- Configures package.json with modern settings
- Creates sample API endpoints and middleware
- Installs dependencies automatically

### 2. Start development server

```bash
make dev
```

Your app will be available at: [http://localhost:3000](http://localhost:3000)

Features:
- 🔥 Hot reload with nodemon
- 📁 Volume mounting for instant changes
- 🐛 Debugging support with source maps
- 🔧 Express.js integration

### 3. Production deployment

```bash
make prod
```

Available at: [http://localhost:8000](http://localhost:8000)

---

## 🛠️ Complete Command Reference

### 🎯 Project Setup

| Command | Description |
|---------|-------------|
| `make help` | Show comprehensive help with all available commands |
| `make create` | Create new Node.js project structure |

### 🚀 Development Commands

| Command | Description |
|---------|-------------|
| `make dev` | Start development server with hot-reload |
| `make dev-detached` | Start development server in background |
| `make dev-logs` | Show development container logs |
| `make dev-shell` | Access development container shell |

### 🏗️ Production Commands

| Command | Description |
|---------|-------------|
| `make prod` | Start production server |
| `make prod-detached` | Start production server (background) |
| `make prod-logs` | Show production container logs |

### 📦 Package Management

| Command | Description | Example |
|---------|-------------|---------|
| `make install pkg=<n>` | Install runtime package | `make install pkg=axios` |
| `make install-dev pkg=<n>` | Install dev dependency | `make install-dev pkg=jest` |
| `make update` | Update all packages to latest versions | |

### 🔧 Container Management

| Command | Description |
|---------|-------------|
| `make stop` | Stop all running containers |
| `make restart` | Restart containers |
| `make clean` | Clean containers, volumes, and build cache |
| `make rebuild` | Rebuild containers from scratch |
| `make prune` | Remove unused Docker resources |

### 📊 Monitoring & Debugging

| Command | Description |
|---------|-------------|
| `make status` | Show container status and health |
| `make logs` | Show container logs (all services) |
| `make health` | Check container health status |
| `make debug` | Debug application in development mode |
| `make inspect` | Inspect container configuration |

### 🧪 Testing & Quality

| Command | Description |
|---------|-------------|
| `make test` | Run unit tests in container |
| `make test-watch` | Run tests in watch mode |
| `make lint` | Run linting checks |
| `make security` | Run security audit |

### 💾 Backup & Restore

| Command | Description |
|---------|-------------|
| `make backup` | Backup project data and configuration |
| `make restore` | Restore from backup (interactive) |

---

## 🌱 Environment Configuration

Customize your Node.js project by creating a `.env` file in the root directory. Use `.example.env` as a template.

### Key Configuration Options

```bash
# Application Settings
APP_NAME=my-node-app                      # Your project name
NODE_ENV=development                      # Environment mode
PORT=3000                                 # Application port

# Port Configuration  
DEV_PORT=3000                             # Development server port
PROD_PORT=8000                            # Production server port

# Database Configuration
DATABASE_URL=mongodb://localhost:27017/myapp  # Database connection string
REDIS_URL=redis://localhost:6379             # Redis connection string

# Security Settings
JWT_SECRET=your-super-secret-key          # JWT secret for authentication
CORS_ORIGIN=*                             # CORS allowed origins

# Performance Settings
NODE_OPTIONS=--max-old-space-size=2048    # Memory allocation
UV_THREADPOOL_SIZE=4                      # Thread pool size

# User Configuration (for file permissions)
UID=1000                                  # Host user ID
GID=1000                                  # Host group ID
```

### Example `.env` file

```properties
APP_NAME=my-api
NODE_ENV=development
PORT=3000

# Ports
DEV_PORT=3000
PROD_PORT=8000

# Database
DATABASE_URL=mongodb://localhost:27017/myapi
REDIS_URL=redis://localhost:6379

# Security
JWT_SECRET=your-jwt-secret-here
CORS_ORIGIN=http://localhost:3000

# Performance
NODE_OPTIONS=--max-old-space-size=2048
UV_THREADPOOL_SIZE=4

# Docker optimizations
DOCKER_BUILDKIT=1
COMPOSE_DOCKER_CLI_BUILD=1
```

---

## 🏗️ Architecture & Features

### Multi-Stage Docker Build

The Dockerfile provides optimized builds for different environments:

- **Dependencies Stage**: Shared dependency installation with caching
- **Development Stage**: Hot-reload with full dev dependencies and debugging tools
- **Build Stage**: Production build with optimizations and pruning
- **Production Stage**: Minimal runtime environment with security hardening

### Health Checks & Monitoring

All containers include:
- 🏥 Built-in health checks with custom endpoints
- 📊 Container status monitoring
- 📋 Comprehensive logging with structured output
- 🔄 Automatic restart policies
- 📈 Basic performance metrics

### Security Features

- 🔒 Non-root user execution
- 🛡️ Security headers and CORS configuration
- 🚫 Minimal attack surface with distroless production images
- 🔐 Proper file permissions and secrets management
- 🔍 Dependency vulnerability scanning

### Performance Optimizations

- ⚡ Multi-layer caching for faster builds
- 🗜️ Gzip compression for responses
- 📦 Efficient Docker layer utilization
- 💾 Volume mounting for development
- 🔄 Connection pooling and keep-alive

---

## 📂 Project Structure

```text
node-docker-template/
├── docker-compose.yml      # Multi-profile Docker Compose config
├── Dockerfile             # Multi-stage build configuration  
├── Makefile               # Complete automation and task management
├── nginx.conf             # Nginx reverse proxy configuration
├── .env                   # Environment variables
├── .example.env           # Environment template
├── .dockerignore          # Docker build context optimization
├── .gitignore             # Git ignore rules
├── package.json           # Node.js dependencies and scripts
└── README.md              # This comprehensive guide
```

### Generated Node.js Project Structure

After running `make create`, your project will have:

```text
my-node-app/
├── src/                   # Application source code
│   ├── app.js            # Main Express application
│   ├── server.js         # Server entry point
│   ├── config/           # Configuration files
│   ├── controllers/      # Request controllers
│   ├── middleware/       # Custom middleware
│   ├── models/           # Data models
│   ├── routes/           # API routes
│   ├── services/         # Business logic
│   └── utils/            # Utility functions
├── tests/                # Test files
├── docs/                 # Documentation
├── package.json          # Dependencies and scripts
├── .eslintrc.js          # ESLint configuration
├── .prettierrc           # Prettier configuration
└── jest.config.js        # Jest testing configuration
```

---

## 🚀 Deployment Strategies

### Development Environment

Perfect for local development with instant feedback:

```bash
make dev-detached     # Run in background
make dev-logs         # Monitor logs
make dev-shell        # Access container shell
```

- ✅ Hot reload with nodemon
- ✅ Full debugging capabilities
- ✅ Source maps for error tracking
- ✅ Development middleware enabled

### Production Environment

Optimized for production deployment:

```bash
make prod-detached    # Start production server in background
```

- ✅ Optimized for performance
- ✅ Security hardening enabled
- ✅ Health checks and monitoring
- ✅ Graceful shutdown handling
- ✅ Resource usage optimization

---

## 🔧 API Endpoints

The template includes sample API endpoints:

### Health & Status
- `GET /health` - Health check endpoint
- `GET /api/status` - Application status and metrics

### Sample API
- `GET /api/users` - Get all users
- `GET /api/users/:id` - Get user by ID
- `POST /api/users` - Create new user
- `PUT /api/users/:id` - Update user
- `DELETE /api/users/:id` - Delete user

### Authentication (Optional)
- `POST /api/auth/login` - User login
- `POST /api/auth/register` - User registration
- `POST /api/auth/refresh` - Refresh token

---

## 🧪 Testing Strategy

### Unit Tests
```bash
make test              # Run all tests
make test-watch        # Run tests in watch mode
```

### Integration Tests
```bash
make test-integration  # Run integration tests
```

### Security Testing
```bash
make security          # Run security audit
```

---

## 🚨 Troubleshooting

### Common Issues

**Port already in use:**
```bash
make stop              # Stop all containers
make clean             # Clean everything
```

**Build errors:**
```bash
make debug             # Check compilation errors
make rebuild           # Rebuild from scratch
```

**Container health issues:**
```bash
make health            # Check container status
make logs              # View detailed logs
```

**Performance issues:**
```bash
make prune             # Clean Docker resources
```

### Advanced Debugging

**Access container shell:**
```bash
make dev-shell         # Development container
```

**Inspect container configuration:**
```bash
make inspect           # View container details
```

**Monitor resource usage:**
```bash
make status            # Container status and ports
```

---

## 💡 Tips & Best Practices

### Development Workflow

1. **Initial Setup:**
   ```bash
   make create          # Create project (once)
   make dev            # Start development
   ```

2. **Daily Development:**
   ```bash
   make dev-detached   # Background development server
   make dev-logs       # Monitor in separate terminal
   ```

3. **Package Management:**
   ```bash
   make install pkg=express           # Runtime dependencies
   make install-dev pkg=jest          # Development dependencies
   ```

4. **Testing & Quality:**
   ```bash
   make test           # Run unit tests
   make lint           # Check code quality
   make security       # Security audit
   ```

### Production Deployment

1. **Environment Setup:**
   - Configure `.env` for production settings
   - Set appropriate resource limits
   - Configure monitoring and logging

2. **Security Checklist:**
   - Update JWT secrets and API keys
   - Configure CORS for production domains
   - Enable security headers
   - Run security audit

3. **Performance Optimization:**
   - Enable production optimizations
   - Configure reverse proxy (Nginx)
   - Set up load balancing if needed

---

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- Node.js Community for the amazing runtime
- Express.js Team for the robust web framework
- Docker Community for containerization excellence
- Open Source Community for continuous inspiration

---

**Ready to build something amazing? Start with `make create` and let Docker handle the rest!** 🚀

Happy coding! 🧑‍💻
