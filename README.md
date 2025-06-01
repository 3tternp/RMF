# RMF
Risk Management Framework

A web-based Risk Management Framework built with Django, Django REST Framework (DRF), React, and Docker, aligned with NIST 800-53 standards. The application supports Role-Based Access Control (RBAC), risk registration, NIST 800-53 control catalog management, audit logging, and dashboard analytics, secured with Nginx and Let's Encrypt SSL.

Table of Contents

Features

Tech Stack

Project Structure

Prerequisites

Setup Instruction

Usage

Contributing

License

Features

Risk Register: Manage risks with categories, likelihood, impact, and ownership.

Control Catalog: Implement and track NIST 800-53 controls.

Audit Logging: Record audit findings linked to risks and controls.

Dashboard: Visualize total risks, controls, and open audits.

RBAC: Role-based access for administrators, risk managers, auditors, and viewers.

Secure Deployment: Dockerized with Nginx reverse proxy and Let's Encrypt SSL.

Tech Stack

Backend: Django 5.2.1, Django REST Framework, PostgreSQL

Frontend: React 18, Tailwind CSS

Infrastructure: Docker, Nginx, Certbot (Let's Encrypt)

Authentication: Django RBAC with custom user roles

Database: PostgreSQL 17

**Prerequisites**

Docker and Docker Compose

Node.js (for local frontend development, optional)

Python 3.11 (for local backend development, optional)

A registered domain for SSL (optional for local development)

**Setup Instructions:**

**Clone the Repository:**

git clone https://github.com/your-username/risk-management-framework.git

cd risk-management-framework

Configure Environment Variables:

Copy the .env.example to .env:

cp .env.example .env

Update .env with a secure SECRET_KEY and your domain (NGINX_HOST):

DATABASE_URL=postgresql://riskuser:riskpass@db/riskdb
SECRET_KEY=your-secure-secret-key
DEBUG=False
NGINX_HOST=riskmanagement.example.com

Build and Start Containers:

docker-compose up -d

Initialize the Database:

Access the backend container:

docker exec -it <backend-container-name> bash

Run migrations:

python manage.py migrate

Create a superuser:

python manage.py createsuperuser

Configure SSL (Production):

Run Certbot to obtain SSL certificates:

docker-compose exec certbot certbot certonly --webroot -w /var/www/certbot -d riskmanagement.example.com

Update nginx/nginx.conf to enable HTTPS (add SSL directives).

Access the Application:

Open http://riskmanagement.example.com (or http://localhost for local development).

Login with the superuser credentials or create users with roles (admin, risk_manager, auditor, viewer).

Usage

Dashboard: View aggregated metrics for risks, controls, and audits.

Risk Register: Add, update, or view risks with details like category, likelihood, and impact.

Control Catalog: Manage NIST 800-53 controls with implementation status.

Audit Log: Track audit activities linked to risks and controls.

Admin Panel: Access /admin/ for user and role management (admin role only).
