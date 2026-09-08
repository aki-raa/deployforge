# DeployForge

Infrastructure automation project demonstrating Infrastructure as Code, configuration management, container networking, reverse proxying, SSH hardening, health checks, and CI validation.

## Architecture

```text
Developer
    |
    v
GitHub Repository
    |
    v
GitHub Actions CI
    |
    +-------------------+
    |                   |
    v                   v
Terraform             Ansible
    |                   |
    v                   v
Docker Network        SSH
    |                   |
    +--------+----------+
             |
             v
      Ansible Target
             |
             v
          Nginx
             |
        Docker DNS
             |
             v
      DeployForge App
```

## Project Overview

DeployForge provisions and configures a containerized application using Terraform and Ansible.

Terraform manages the Docker infrastructure, including the custom Docker network and containers. Ansible connects to the target container over SSH and configures the server, installs Nginx, deploys the reverse-proxy configuration, and verifies application health.

The project also uses GitHub Actions to automatically validate the Terraform and Ansible configuration on pushes and pull requests.

## Technologies

* Linux / Ubuntu
* Bash
* Git & GitHub
* Docker
* Docker Networking
* Terraform
* Terraform Docker Provider
* Ansible
* SSH
* Nginx
* GitHub Actions
* Python

## Prerequisites

* Linux / WSL2 Ubuntu
* Docker
* Terraform
* Ansible
* Git
* SSH client

## Infrastructure

Terraform provisions:

* Custom Docker bridge network: `deployforge-net`
* Application container: `deployforge-app`
* Ansible target container: `deployforge-ansible-target`

### Ports

| Service     | Container Port | Host Port |
| ----------- | -------------: | --------: |
| Application |           8080 |      8090 |
| SSH         |             22 |      2222 |
| Nginx       |             80 |      8081 |

## Terraform

Terraform is responsible for provisioning the Docker infrastructure.

The configuration uses variables for:

* Network name
* Container names
* Docker images
* Application ports
* SSH port
* Nginx port

Terraform outputs provide useful deployment information such as the application URL, Nginx URL, container names, and SSH port.

### Terraform workflow

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

Infrastructure consistency is verified with:

```bash
terraform plan
```

The final validation achieved:

```text
No changes. Your infrastructure matches the configuration.
```

## Ansible

Ansible is used for configuration management of the target server.

The playbook:

1. Creates the application user
2. Creates the application directory
3. Deploys the application script
4. Installs Nginx
5. Removes the default Nginx site
6. Deploys the Nginx configuration using a Jinja2 template
7. Enables the DeployForge site
8. Validates the Nginx configuration
9. Starts Nginx when necessary
10. Performs an application health check

### Ansible features demonstrated

* Playbooks
* Variables
* Jinja2 templates
* Handlers
* Idempotent configuration
* SSH-based automation
* Privilege escalation
* Application health checks

A repeated playbook execution results in:

```text
changed=0
failed=0
unreachable=0
```

## Reverse Proxy

Nginx acts as the reverse proxy in front of the application.

The Nginx configuration uses Docker DNS service discovery:

```nginx
proxy_pass http://deployforge-app:8080;
```

This allows Nginx to communicate with the application container using its Docker container name instead of a hardcoded IP address.

External requests follow:

```text
localhost:8081
       |
       v
     Nginx
       |
       v
deployforge-app:8080
```

## SSH Security

The Ansible target is accessed using SSH key-based authentication.

Password authentication has been disabled:

```text
PasswordAuthentication no
```

The configuration was validated with:

```bash
sudo sshd -t
```

Password-only SSH authentication was tested and rejected:

```text
Permission denied (publickey).
```

## Health Check

Ansible verifies that Nginx successfully serves the application:

```yaml
- name: Check application health
  uri:
    url: http://localhost
    status_code: 200
```

The application was successfully verified with:

```text
HTTP/1.1 200 OK
```

## GitHub Actions CI

GitHub Actions automatically validates the infrastructure configuration.

The CI pipeline performs:

```text
Checkout
   |
   v
Terraform Setup
   |
   v
Terraform Format Check
   |
   v
Terraform Init
   |
   v
Terraform Validate
   |
   v
Python Setup
   |
   v
Ansible Installation
   |
   v
Ansible Syntax Check
```

The workflow runs on pushes and pull requests targeting the `main` branch.

## Project Structure

```text
deployforge/
├── .github/
│   └── workflows/
│       └── ci.yml
│
├── ansible/
│   ├── inventory.ini
│   ├── setup.yml
│   ├── app.sh
│   └── templates/
│       └── deployforge.conf.j2
│
├── app/
│   ├── Dockerfile
│   ├── app.sh
│   └── web/
│       └── index.html
│
├── docker/
│   └── Dockerfile.ansible
│
├── scripts/
│
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── .terraform.lock.hcl
│
├── .gitignore
└── README.md
```

## Running the Project

### 1. Build the application image

```bash
docker build -t deployforge-app ./app
```

### 2. Initialize Terraform

```bash
terraform -chdir=terraform init
```

### 3. Validate Terraform

```bash
terraform -chdir=terraform fmt -check
terraform -chdir=terraform validate
```

### 4. Provision the infrastructure

```bash
terraform -chdir=terraform apply
```

### 5. Configure the server with Ansible

```bash
ansible-playbook -i ansible/inventory.ini ansible/setup.yml
```

### 6. Verify the application

```bash
curl http://localhost:8081
```

Expected response:

```html
<!DOCTYPE html>
<html>
<head>
    <title>DeployForge</title>
</head>
<body>
    <h1>DeployForge Application</h1>
    <p>Application is running successfully.</p>
</body>
</html>
```

## Verification

The project was tested using:

```text
Terraform validate       PASS
Terraform plan            No changes
Ansible syntax check      PASS
Ansible idempotency       changed=0
Nginx configuration       PASS
Application health        HTTP 200
SSH key authentication    PASS
SSH password login        REJECTED
GitHub Actions CI         PASS
```

## Learning Outcomes

This project demonstrates practical experience with:

* Infrastructure as Code
* Configuration management
* Containerization
* Docker networking
* Docker DNS service discovery
* Reverse proxy configuration
* SSH automation
* Linux administration
* Infrastructure validation
* Idempotent automation
* CI pipeline validation
* Automated application health checks
