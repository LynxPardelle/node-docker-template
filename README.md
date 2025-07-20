# Node.js Docker Template - Complete Guide 🐳🚀

**A comprehensive, production-ready Docker template for Node.js applications with zero local dependencies and nginx integration.**

> **💡 Everything you need to know in one place!** This unified guide contains all information for getting started, development, production deployment, nginx integration, and advanced usage.

---

## 📋 Table of Contents

1. [Quick Start](#quick-start)
2. [Features & Benefits](#features--benefits)
3. [Requirements](#requirements)
4. [Complete Command Reference](#complete-command-reference)
5. [Environment Configuration](#environment-configuration)
6. [Nginx Integration](#nginx-integration)
7. [Deployment Strategies](#deployment-strategies)
8. [Monitoring & Debugging](#monitoring--debugging)
9. [Testing & Quality](#testing--quality)
10. [Troubleshooting](#troubleshooting)
11. [Best Practices](#best-practices)
12. [Architecture Overview](#architecture-overview)
13. [Nginx Integration Summary](#nginx-integration-summary)

---

## 🚀 Quick Start

### 1. Create a new Node.js app
```bash
make create
```
This creates a complete Node.js project with Express.js, security middleware, and sample API endpoints.

### 2. Start development
```bash
make dev
```
Your app runs at [http://localhost:3000](http://localhost:3000) with hot reload.

### 3. Start production
```bash
make prod
```
Production server runs at [http://localhost:8000](http://localhost:8000).

### 4. Start with Nginx (Recommended for Production)
```bash
make nginx-detached          # Separate containers (scalable)
# OR
make prod-nginx-detached     # Single container (simple)
```
Access at [http://localhost](http://localhost) with nginx reverse proxy.

**Your app will be available at:**
- **Development**: [http://localhost:3000](http://localhost:3000)
- **Production**: [http://localhost:8000](http://localhost:8000) 
- **With Nginx**: [http://localhost](http://localhost)

---

## ✨ Features & Benefits

### 🏗️ Core Features
- **🚀 Zero Local Dependencies** - Everything runs in Docker containers
- **🔥 Hot Reload Development** - Real-time code changes with volume mounting
- **🏗️ Multi-Stage Production Builds** - Optimized builds with minimal image size
- **🌐 Nginx Reverse Proxy** - High-performance proxy with load balancing and security
- **📦 Enhanced Package Management** - Install, update, manage dependencies in containers
- **🔧 Comprehensive DevOps** - Health checks, monitoring, debugging, cleanup tools
- **🎯 Intelligent Environment Management** - Flexible configuration with .env support
- **🧪 Testing & Quality Tools** - Built-in testing, linting, and security scanning
- **💾 Backup & Restore** - Project configuration backup and restore capabilities
- **🎨 Rich CLI Experience** - Colorized output and comprehensive help system

### 🌐 Nginx Benefits

#### Performance
- **Static File Serving**: Nginx efficiently serves static files, reducing Node.js load
- **Gzip Compression**: Automatic compression for better performance
- **Connection Pooling**: Efficient connection management and keep-alive
- **Caching**: Built-in caching capabilities for static and dynamic content

#### Security
- **Rate Limiting**: Protect against abuse and DDoS attacks
- **Request Filtering**: Block malicious requests before they reach Node.js
- **Security Headers**: Automatic injection of security headers
- **SSL Termination**: Handle HTTPS certificates and SSL/TLS

#### Scalability
- **Load Balancing**: Distribute traffic across multiple Node.js instances
- **Zero-downtime Deployments**: Update backend without service interruption
- **Horizontal Scaling**: Easy to add more backend instances
- **Resource Isolation**: Separate containers for better resource management

---

## ✅ Requirements

- **Docker** (20.10+)
- **Make** (Unix/Linux/macOS default; Windows: WSL, Git Bash, or chocolatey)
- **Git** (optional, for version control)

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

### 🌐 Nginx Commands
| Command | Description |
|---------|-------------|
| `make nginx` | Start nginx reverse proxy with backend |
| `make nginx-detached` | Start nginx reverse proxy (background) |
| `make prod-nginx` | Start production with nginx reverse proxy |
| `make prod-nginx-detached` | Start production with nginx (background) |
| `make nginx-logs` | Show nginx container logs |
| `make nginx-status` | Check nginx status and configuration |
| `make nginx-reload` | Reload nginx configuration |

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

Create a `.env` file to customize your project. Use `.example.env` as a template.

### Essential Configuration
```bash
# Application Settings
APP_NAME=my-node-app
NODE_ENV=development
PORT=3000

# Port Configuration
DEV_PORT=3000                   # Development server port
PROD_PORT=8000                  # Production server port
NGINX_PORT=80                   # Nginx reverse proxy port

# Database Configuration
DATABASE_URL=mongodb://localhost:27017/myapp
REDIS_URL=redis://localhost:6379

# Security Settings
JWT_SECRET=your-super-secret-key
CORS_ORIGIN=*

# Nginx Configuration
NGINX_HOST=localhost
NGINX_WORKER_PROCESSES=auto

# Rate Limiting (nginx)
RATE_LIMIT_API=10r/s
RATE_LIMIT_LOGIN=1r/s
RATE_LIMIT_GLOBAL=30r/s

# Performance Settings
NODE_OPTIONS=--max-old-space-size=2048
UV_THREADPOOL_SIZE=4

# Docker Configuration
UID=1000
GID=1000
DOCKER_BUILDKIT=1
```

### Example Production `.env`
```bash
APP_NAME=my-api
NODE_ENV=production
PORT=3000

# Ports
DEV_PORT=3000
PROD_PORT=8000
NGINX_PORT=80

# Database
DATABASE_URL=mongodb://production-server:27017/myapi
REDIS_URL=redis://production-server:6379

# Security
JWT_SECRET=your-production-jwt-secret-here
CORS_ORIGIN=https://yourdomain.com

# Nginx
NGINX_HOST=yourdomain.com

# Performance
NODE_OPTIONS=--max-old-space-size=2048
UV_THREADPOOL_SIZE=4

# Docker optimizations
DOCKER_BUILDKIT=1
COMPOSE_DOCKER_CLI_BUILD=1
```

---

## 🌐 Nginx Integration

### Two Deployment Strategies

#### 1. Separate Containers (Recommended for Production)
```bash
make nginx-detached
```

**Benefits:**
- ✅ Independent scaling of nginx and Node.js
- ✅ Zero-downtime deployments
- ✅ Better resource isolation
- ✅ Easier horizontal scaling

**Use Cases:**
- Production environments
- High-traffic applications
- Multiple backend instances
- Kubernetes deployments

#### 2. Integrated Container (Simple Deployment)
```bash
make prod-nginx-detached
```

**Benefits:**
- ✅ Simplified deployment
- ✅ Single container to manage
- ✅ Reduced overhead
- ✅ Perfect for single-server deployments

**Use Cases:**
- Small to medium applications
- Development/staging environments
- Simple cloud deployments
- Docker Swarm single-node

### Nginx Features Included
- Reverse proxy configuration for Node.js backend
- Rate limiting for API endpoints and authentication
- Security headers (X-Frame-Options, X-XSS-Protection, etc.)
- Gzip compression for better performance
- Health check endpoints for monitoring
- Structured logging with JSON format option
- SSL/HTTPS ready configuration (commented out)

---

## 🚀 Deployment Strategies

### Development Environment
Perfect for local development with instant feedback:

```bash
make dev-detached     # Run in background
make dev-logs         # Monitor logs
make dev-shell        # Access container shell
```

**Features:**
- ✅ Hot reload with nodemon
- ✅ Full debugging capabilities
- ✅ Source maps for error tracking
- ✅ Development middleware enabled

### Standard Production
Optimized for production deployment:

```bash
make prod-detached    # Start production server in background
```

**Features:**
- ✅ Optimized for performance
- ✅ Security hardening enabled
- ✅ Health checks and monitoring
- ✅ Graceful shutdown handling
- ✅ Resource usage optimization

### Nginx Production (Recommended)
High-performance production with nginx:

```bash
# Option 1: Separate containers (scalable)
make nginx-detached

# Option 2: Integrated container (simple)
make prod-nginx-detached
```

**Additional Benefits:**
- 🚀 **Performance**: Static file serving, compression, connection pooling
- 🔒 **Security**: Rate limiting, request filtering, security headers
- ⚖️ **Load Balancing**: Distribute traffic across multiple Node.js instances
- 📊 **Monitoring**: Built-in status endpoint and detailed logging
- 🛡️ **DDoS Protection**: Connection limits and request throttling
- 🗜️ **Compression**: Automatic gzip compression for better performance
- 🌐 **SSL Termination**: Ready for HTTPS with minimal configuration

---

## 📊 Monitoring & Debugging

### Health Checks
All containers include comprehensive health checks:

- **Application Health**: `http://localhost:3000/health` (Node.js)
- **Nginx Status**: `http://localhost/nginx-status` (nginx)
- **Application via Nginx**: `http://localhost/health` (through proxy)

### Container Status
```bash
make status           # Show all container status
make nginx-status     # Detailed nginx status
make health          # Check health endpoints
```

### Log Management
```bash
make logs            # All container logs
make dev-logs        # Development logs
make prod-logs       # Production logs
make nginx-logs      # Nginx logs
```

### Debug Mode
```bash
make debug           # Start debug session
make dev-shell       # Access development container
make inspect         # Inspect container configuration
```

### Performance Monitoring
```bash
make perf            # Container performance stats
docker stats         # Real-time resource usage
```

---

## 🧪 Testing & Quality

### Running Tests
```bash
make test                    # Run all tests
make test-watch             # Run tests in watch mode
make test-coverage          # Run with coverage report
```

### Code Quality
```bash
make lint                   # Run linting checks
make lint-fix              # Auto-fix linting issues
make security              # Security audit
make security-fix          # Fix security vulnerabilities
```

### API Testing
```bash
make api-test              # Test API endpoints

# Manual API testing
curl http://localhost:3000/health
curl http://localhost:3000/api/users
curl http://localhost/health  # Through nginx
```

---

## 🔧 Troubleshooting

### Common Issues & Solutions

#### 1. **502 Bad Gateway** (nginx)
**Problem:** Backend not responding
**Solutions:**
```bash
# Check if Node.js container is running
make status

# Verify Node.js is accessible
curl http://localhost:3000/health

# Check nginx configuration
make nginx-status

# Restart services
make restart
```

#### 2. **Connection Refused**
**Problem:** Nginx not starting
**Solutions:**
```bash
# Check nginx configuration syntax
docker compose exec nginx nginx -t

# Verify port 80 is available
netstat -tlnp | grep :80

# Check logs for errors
make nginx-logs
```

#### 3. **Rate Limiting Issues**
**Problem:** Too many requests blocked
**Solutions:**
```bash
# Adjust rate limiting in nginx.conf
# Check client IP restrictions
# Modify environment variables:
RATE_LIMIT_API=20r/s
RATE_LIMIT_GLOBAL=50r/s
```

#### 4. **Build Failures**
**Problem:** Docker build fails
**Solutions:**
```bash
# Clean everything and rebuild
make clean
make rebuild

# Check Docker resources
make prune

# Verify Dockerfile syntax
docker build --target production .
```

#### 5. **Environment Issues**
**Problem:** Wrong configuration loaded
**Solutions:**
```bash
# Check environment info
make env-info

# Verify .env file exists
ls -la .env

# Copy example configuration
cp .example.env .env
```

### Debug Commands
```bash
# Test nginx configuration
docker compose exec nginx nginx -t

# Check nginx processes
docker compose exec nginx ps aux | grep nginx

# View detailed error logs
docker compose logs --details nginx

# Check container networking
docker compose exec nginx netstat -tlnp

# Inspect container details
docker inspect container-name

# Check volume mounts
docker compose exec nginx mount | grep app
```

---

## 🏆 Best Practices

### Development
1. **Use development profile** for local work: `make dev-detached`
2. **Monitor logs regularly**: `make dev-logs`
3. **Test early and often**: `make test-watch`
4. **Keep dependencies updated**: `make update`
5. **Use environment files**: Copy `.example.env` to `.env`

### Production
1. **Use nginx for production**: `make nginx-detached` or `make prod-nginx-detached`
2. **Monitor both nginx and Node.js** logs
3. **Implement proper SSL** for HTTPS
4. **Configure rate limiting** based on your needs
5. **Set up log rotation** for long-running deployments
6. **Use health checks** for automatic recovery
7. **Test configuration changes** before deployment

### Security
1. **Change default secrets** in production
2. **Use strong JWT secrets** and rotate them regularly
3. **Configure CORS properly** for your domain
4. **Enable rate limiting** to prevent abuse
5. **Use HTTPS in production** with proper certificates
6. **Regular security audits**: `make security`

### Performance
1. **Use nginx for static files** instead of Node.js
2. **Enable gzip compression** (already configured)
3. **Configure proper caching** headers
4. **Monitor resource usage**: `make perf`
5. **Use connection pooling** for databases
6. **Optimize Docker images** with multi-stage builds

### Scaling
1. **Use separate containers** for better scaling
2. **Implement load balancing** with nginx
3. **Use Docker Swarm or Kubernetes** for orchestration
4. **Monitor performance metrics** and scale accordingly
5. **Use database connection pooling**
6. **Cache frequently accessed data**

---

## 🏗️ Architecture Overview

### Multi-Stage Docker Build
The Dockerfile provides optimized builds for different environments:

- **Base Stage**: Shared foundation with Node.js and security updates
- **Dependencies Stage**: Production dependencies installation with caching
- **Dev Dependencies Stage**: All dependencies + development tools
- **Development Stage**: Hot-reload with full dev dependencies and debugging
- **Testing Stage**: Optimized environment for running tests
- **Build Stage**: Production build with optimizations and file cleanup
- **Production Stage**: Minimal runtime environment with security hardening
- **Production-PM2 Stage**: Advanced process management with PM2
- **Nginx Stage**: Standalone nginx reverse proxy container
- **Production-Nginx Stage**: Integrated nginx + Node.js container

### Project Structure
```text
node-docker-template/
├── docker-compose.yml      # Multi-profile Docker Compose config
├── Dockerfile             # Multi-stage build configuration
├── Makefile               # Complete automation and task management
├── nginx.conf             # Nginx reverse proxy configuration
├── package.json           # Node.js dependencies and scripts
├── .env                   # Environment variables (create from .example.env)
├── .example.env           # Environment template
├── .dockerignore          # Docker build context optimization
├── .gitignore             # Git ignore rules
├── README.md              # This comprehensive guide
└── src/                   # Application source code (created by make create)
    ├── app.js            # Main Express application
    ├── server.js         # Server entry point
    ├── config/           # Configuration files
    ├── controllers/      # Request controllers
    ├── middleware/       # Custom middleware
    ├── models/           # Data models
    ├── routes/           # API routes
    ├── services/         # Business logic
    └── utils/            # Utility functions
```

### Container Networking
- **Development**: Node.js on port 3000
- **Production**: Node.js on port 8000 (mapped from internal 3000)
- **Nginx Separate**: Nginx on port 80, proxying to app:3000
- **Nginx Integrated**: Single container with nginx on port 80, Node.js on internal 3000

### Volume Management
- **Development**: Source code mounted for hot reload
- **Production**: Named volumes for logs, uploads, and data persistence
- **Nginx**: Configuration files and logs properly mounted

---

## 🚀 Getting Started - Complete Workflow

### 1. Initial Setup
```bash
# Clone or download the template
git clone https://github.com/LynxPardelle/node-docker-template.git
cd node-docker-template

# Copy environment configuration
cp .example.env .env

# Edit .env with your settings
# (Use your preferred editor)

# Create the Node.js application
make create
```

### 2. Development
```bash
# Start development environment
make dev

# In another terminal, watch logs
make dev-logs

# Make changes to your code - hot reload will update automatically
# Access your app at http://localhost:3000
```

### 3. Testing
```bash
# Run tests
make test

# Run tests in watch mode while developing
make test-watch

# Check code quality
make lint
make security
```

### 4. Production Deployment

#### Option A: Standard Production
```bash
make prod-detached
```

#### Option B: With Nginx (Recommended)
```bash
# Separate containers (scalable)
make nginx-detached

# OR integrated container (simple)
make prod-nginx-detached
```

### 5. Monitoring
```bash
# Check status
make status

# View logs
make logs

# Check health
curl http://localhost/health
```

---

## 📊 Nginx Integration Summary

Successfully integrated nginx reverse proxy functionality into the Node.js Docker Template with comprehensive improvements for performance, security, and scalability.

### Changes Made

#### 1. Dockerfile Updates
- Added **nginx** stage for standalone reverse proxy
- Added **production-nginx** stage for integrated nginx + Node.js container
- Both stages include security hardening and proper user management
- Used supervisor to manage multiple processes in the integrated stage

#### 2. Docker Compose Updates
- Added `nginx` profile for separate nginx + backend containers
- Added `prod-nginx` profile for integrated container
- Added new volumes: `nginx_logs` and `supervisor_logs`
- Updated environment variables to include nginx configuration

#### 3. Makefile Updates
- Added comprehensive nginx commands:
  - `make nginx` / `make nginx-detached` - Start nginx with separate containers
  - `make prod-nginx` / `make prod-nginx-detached` - Start integrated container
  - `make nginx-logs` - View nginx logs
  - `make nginx-status` - Check nginx status and configuration
  - `make nginx-reload` - Reload nginx configuration
- Updated help system to include nginx commands
- Updated PHONY targets

#### 4. Configuration Updates
- Updated `nginx.conf` to support both deployment strategies
- Added nginx environment variables to `.example.env`
- Enhanced nginx upstream configuration with failover

#### 5. Application Updates
- Created basic `package.json` with Node.js dependencies
- Created sample Express.js application (`src/app.js`) with:
  - Health check endpoints (`/health`, `/nginx-status`)
  - Sample API routes
  - Security middleware (helmet, cors)
  - Proper error handling and graceful shutdown

### Usage Examples

#### Start nginx with load balancing
```bash
make nginx-detached
curl http://localhost/health
make nginx-status
```

#### Start production with integrated nginx
```bash
make prod-nginx-detached
curl http://localhost/api/status
docker logs my-node-app-prod-nginx
```

#### Monitor and manage
```bash
make nginx-logs          # View nginx logs
make nginx-reload        # Reload configuration
make nginx-status        # Check status
```

### Testing Status
All configurations have been tested:
- ✅ Dockerfile builds successfully for both nginx stages
- ✅ Docker Compose configurations validate without errors
- ✅ Make commands integrate properly with help system
- ✅ Sample application provides proper health check endpoints

### Files Modified/Created

#### Modified Files
- `Dockerfile` - Added nginx and production-nginx stages
- `docker-compose.yml` - Added nginx profiles and services
- `Makefile` - Added nginx commands and help
- `README.md` - Updated with nginx documentation
- `.example.env` - Added nginx environment variables
- `nginx.conf` - Updated upstream configuration

#### New Files
- `package.json` - Node.js application dependencies
- `src/app.js` - Sample Express.js application

---

## 📞 Support & Resources

### Quick Help
```bash
make help                    # Show all available commands
```

### Health Endpoints
- Development: `http://localhost:3000/health`
- Production: `http://localhost:8000/health`
- Nginx Proxy: `http://localhost/health`
- Nginx Status: `http://localhost/nginx-status`

### Sample API Endpoints (after `make create`)
- `GET /health` - Health check endpoint
- `GET /api/users` - Get all users
- `POST /api/users` - Create user
- `GET /api/users/:id` - Get user by ID
- `PUT /api/users/:id` - Update user
- `DELETE /api/users/:id` - Delete user
- `POST /api/auth/login` - User login (optional)
- `POST /api/auth/register` - User registration (optional)

### Documentation Benefits
This unified guide provides:
- ✅ **Zero redundancy** - No more repeated information
- ✅ **Better readability** - Everything in one place
- ✅ **Complete table of contents** - Easy navigation
- ✅ **Logical progression** - From beginner to expert
- ✅ **Single source of truth** - All documentation in one file
- ✅ **New developer friendly** - Clear onboarding path

---

**🎉 You're all set!** This template provides everything you need for modern Node.js development and deployment with Docker and nginx integration. The nginx integration is now complete and production-ready, providing significant improvements in performance, security, and scalability for Node.js applications.

**🚀 Happy coding!** 🚀

---

*For issues, feature requests, or contributions, visit: [GitHub Repository](https://github.com/LynxPardelle/node-docker-template)*

