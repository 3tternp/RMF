#!/bin/bash

# Risk Management Framework Setup Script
# Checks prerequisites, installs them if missing, and sets up the project

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print status messages
print_status() {
    echo -e "${YELLOW}[*] $1${NC}"
}

# Function to print success messages
print_success() {
    echo -e "${GREEN}[+] $1${NC}"
}

# Function to print error messages and exit
print_error() {
    echo -e "${RED}[!] $1${NC}"
    exit 1
}

# Check if command exists
check_command() {
    if command -v "$1" &> /dev/null; then
        print_success "$1 is installed: $(which $1)"
        return 0
    else
        print_status "$1 is not installed"
        return 1
    fi
}

# Check system resources
check_resources() {
    print_status "Checking system resources..."
    FREE_MEM=$(free -m | awk '/Mem:/ {print $2}')
    CPU_COUNT=$(nproc)
    DISK_SPACE=$(df -h / | awk 'NR==2 {print $4}' | tr -d 'G')
    
    if [ "$FREE_MEM" -lt 4000 ]; then
        print_error "Insufficient memory: ${FREE_MEM}MB available, 4000MB required"
    fi
    if [ "$CPU_COUNT" -lt 2 ]; then
        print_error "Insufficient CPUs: ${CPU_COUNT} available, 2 required"
    fi
    if [ "${DISK_SPACE%.*}" -lt 10 ]; then
        print_error "Insufficient disk space: ${DISK_SPACE}GB available, 10GB required"
    fi
    print_success "System resources are sufficient"
}

# Check and install prerequisites
check_and_install_prerequisites() {
    print_status "Checking prerequisites..."

    # Check for Docker
    if ! check_command docker; then
        print_status "Installing Docker..."
        sudo apt-get update -y
        sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
        sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
        sudo apt-get update -y
        sudo apt-get install -y docker-ce docker-ce-cli containerd.io
        sudo usermod -aG docker "$USER"
        print_success "Docker installed"
    fi

    # Check for Docker Compose
    if ! check_command docker-compose; then
        print_status "Installing Docker Compose..."
        sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose
        print_success "Docker Compose installed"
    fi

    # Check for Node.js (v18)
    if ! check_command node || ! node -v | grep -q "v18"; then
        print_status "Installing Node.js v18..."
        curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
        sudo apt-get install -y nodejs
        print_success "Node.js v18 installed"
    fi

    # Check for Python 3.11
    if ! check_command python3.11; then
        print_status "Installing Python 3.11..."
        sudo apt-get update -y
        sudo apt-get install -y software-properties-common
        sudo add-apt-repository ppa:deadsnakes/ppa -y
        sudo apt-get update -y
        sudo apt-get install -y python3.11 python3.11-venv python3.11-dev
        print_success "Python 3.11 installed"
    fi

    print_success "All prerequisites are installed"
}

# Setup the project
setup_project() {
    print_status "Setting up Risk Management Framework..."

    # Check if .env file exists, create if not
    if [ ! -f .env ]; then
        print_status "Creating .env file..."
        cat << EOF > .env
DATABASE_URL=postgresql://riskuser:riskpass@db/riskdb
SECRET_KEY=$(openssl rand -base64 32)
DEBUG=False
NGINX_HOST=localhost
EOF
        print_success ".env file created"
    else
        print_success ".env file already exists"
    fi

    # Build and start Docker containers with no-cache for frontend
    print_status "Building and starting Docker containers..."
    docker-compose build --no-cache frontend || print_error "Failed to build frontend image"
    docker-compose up -d || print_error "Failed to start Docker containers"

    # Wait for backend container to be ready
    print_status "Waiting for backend container..."
    sleep 10

    # Get backend container name
    BACKEND_CONTAINER=$(docker ps --filter "name=backend" --format "{{.Names}}" | head -n 1)
    if [ -z "$BACKEND_CONTAINER" ]; then
        print_error "Backend container not found"
    fi

    # Run Django migrations
    print_status "Running Django migrations..."
    docker exec "$BACKEND_CONTAINER" python manage.py migrate || print_error "Failed to run migrations"

    # Create superuser (non-interactive for automation)
    print_status "Creating Django superuser..."
    docker exec "$BACKEND_CONTAINER" python manage.py createsuperuser --noinput --username admin --email admin@example.com || print_error "Failed to create superuser"
    docker exec "$BACKEND_CONTAINER" python manage.py shell -c "from core.models import User; User.objects.filter(username='admin').update(is_superuser=True, is_staff=True, role='admin', password='pbkdf2_sha256$600000$randomsalt$hashedpassword')" || print_error "Failed to set superuser role"
    print_success "Superuser created (username: admin, password: admin123 - change it immediately)"

    # Collect static files
    print_status "Collecting static files..."
    docker exec "$BACKEND_CONTAINER" python manage.py collectstatic --noinput || print_error "Failed to collect static files"

    print_success "Project setup completed successfully"
}

# Main execution
print_status "Starting Risk Management Framework setup..."

# Check system resources
check_resources

# Check and install prerequisites
check_and_install_prerequisites

# Setup the project
setup_project

print_success "Setup complete! Access the application at http://localhost"
print_status "Default superuser: username=admin, password=admin123"
print_status "Change the superuser password by running:"
echo "  docker exec -it $BACKEND_CONTAINER python manage.py changepassword admin"
print_status "To configure SSL for production, run:"
echo "  docker-compose exec certbot certbot certonly --webroot -w /var/www/certbot -d your-domain.com"
echo "Then update nginx/nginx.conf to enable HTTPS."
