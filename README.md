# Java Development Environment Template

A standardized Java development environment template using VS Code DevContainer and Google Cloud Workstations. Streamlines development setup with pre-configured tools and consistent environments across teams.

## ✨ Key Features

- Java 21 (Liberica JDK)
- VS Code DevContainer support
- Google Cloud Workstations integration
- Git hooks for automated code formatting
- Pre-configured development tools
- Ready-to-use development setup

## Table of Contents

- [Using VS Code DevContainer](#using-vs-code-devcontainer)
- [Using Google Cloud Workstations](#using-google-cloud-workstations)

## Using VS Code DevContainer

### Prerequisites

- [Visual Studio Code](https://code.visualstudio.com/)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- VS Code Extension:
  - [Remote Development](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack)

### Quick Start

1. Clone or copy the .devcontainer directory
2. Ensure Docker Desktop is running
3. Open the project directory in VS Code
4. VS Code will detect the `.devcontainer` directory and prompt to reopen the project in container
5. Click **"Reopen in Container"** in the bottom-right corner or click the green button **"><"** in the bottom-left corner and select **"Reopen in Container"**

### Additional Information

The development container provides:
- Pre-installed Java 21 (Liberica JDK)
- VS Code extensions for Java development

After container creation, the following setup is automatically performed:
1. Installation of Google Java Formatter
2. Configuration of Git Hooks

Note: Git configurations are automatically synchronized from the host machine to the container (Mac)

## Using Google Cloud Workstations

### Building Workstations Image

Open `workstations/cloudbuild.yaml` and modify the following variables:

- `_PROJECT_ID`: Your GCP project ID
- `_REPOSITORY_NAME`: Your Artifact Registry repository name
- `_IMAGE_NAME`: Your Workstations image name
- `_IMAGE_TAG`: Your Workstations image version

Then run the following commands:
```bash
export PROJECT_ID={Your GCP project ID}

cd workstations
gcloud builds submit --config=cloudbuild.yaml --project=${PROJECT_ID}
```

This will build and push a Docker image with pre-installed Java 21 environment to Artifact Registry.

### Setting up Workstations Environment

#### Step 1: Create a Workstation Cluster

Navigate to Google Cloud Workstations page, select Cluster Manager, and create a Workstation Cluster.

![Cluster Manager](https://i.imgur.com/HEXuM7H.jpeg)

![Create Workstation Cluster](https://i.imgur.com/7TvWtNM.jpeg)

After creation is complete:

![Workstation Cluster](https://i.imgur.com/OaY9fEV.jpeg)

Next, select Workstation Configurations:

![Workstation Configurations](https://i.imgur.com/0NLpbYu.jpeg)

#### Step 2: Create Workstation Configuration

1. Basic Information
   - Name: `config-spring`
   - Select your created cluster
   - Quick start: Disabled (recommended for lower costs)

2. Labels and Tags
   - Labels: Add labels to categorize and manage resources
   - Tags: Add tags to categorize and manage resources

![Basic Information](https://i.imgur.com/EuoyYBn.jpeg)

3. Machine Configuration
   - Series: Choose based on your needs:
     - N2: Recommended for development
     - E2: Cost-optimized general purpose workloads
     - T2D: AMD-based alternative with good price/performance ratio
   - Machine type: Select based on your development requirements:
     - n2-standard-2 (2 vCPU, 8 GB memory): Light development
     - n2-standard-4 (4 vCPU, 16 GB memory): Standard development
     - n2-standard-8 (8 vCPU, 32 GB memory): Heavy development
   - Zones: asia-east1-a and asia-east1-c
   - Auto-sleep: After 2 hours of inactivity (recommended for cost savings)

Note: Cost estimate for n2-standard-4 (asia-east1)
- Hourly rate: $0.224904
- Daily usage: 9 hours
- Monthly working days: 20 days
- Monthly cost estimate: $0.224904 × 9 × 20 = ~$40.48

Cost saving tips:
1. Use Auto-sleep feature
2. Stop workstation when not in use

![Machine Settings](https://i.imgur.com/Cm9AlqS.jpeg)

1. Environment Settings
   - Container image: Custom container image
   - Container image URL: `asia-east1-docker.pkg.dev/${PROJECT_ID}/${REPOSITORY_NAME}/${IMAGE_NAME}:${IMAGE_TAG}`
   - Service account: Compute Engine default service account
   - Storage: Create new empty persistent disk
   - Disk type: Balanced

![Environment Settings](https://i.imgur.com/ysfwalx.jpeg)

1. Access Control
   - Users and permissions: Users can create workstations through the console
   - Add authorized users or groups as needed
   - Keep Advanced options as default

![Users and Permissions](https://i.imgur.com/a4sZ8vL.jpeg)

Click CREATE to complete the configuration:

![Workstation Configurations](https://i.imgur.com/jQYJROP.jpeg)

#### Step 3: Create a Workstation

Navigate to the Workstations page:

![Workstations](https://i.imgur.com/0LdeXoM.jpeg)

Click CREATE WORKSTATION and configure the following:

![Create Workstation](https://i.imgur.com/0LdeXoM.jpeg)

Configure the following settings:
- Name: (e.g., w-samzhucn480th9v)
- Display Name: (e.g., sam)
- Configuration: Select your created configuration (e.g., config-spring)

![Create Workstation](https://i.imgur.com/aIRBfK6.jpeg)

After creation, your workstation will appear:

![your Workstation](https://i.imgur.com/brAHRWm.jpeg)

### Using Your Workstation

Start your workstation and click the Launch button to access it:

![Launch Workstation](https://i.imgur.com/omVzFKR.jpeg)

The environment comes pre-configured with Java 21, Google Java Format tool, and predefined extensions:

![Workstation Environment](https://i.imgur.com/n17kMEO.jpeg)

### Gemini Code Assistant

You can also enable Gemini Code Assistant to help with development:

![Gemini Code Assistant](https://i.imgur.com/wrHv4hx.jpeg)

Your development environment is now ready for Java development with all necessary tools and extensions installed.

### Quick Install Git Hooks

Run the following command to install Git Hooks. This will automatically configure the pre-commit hook for Java code formatting:

``` bash
curl -fsSL https://raw.githubusercontent.com/samzhu/java-dev-env-template/main/workstations/install-java-format-hooks.sh | bash
```

### Creating a Spring Boot Project

Spring Boot CLI is pre-installed in the environment for quick project creation.

``` bash
mkdir workspace && cd workspace

spring init --java-version=21 --dependencies=web,actuator sample-app.zip

unzip sample-app.zip -d sample-app
```

After extraction, open the `sample-app` directory in VS Code to start developing your Spring Boot application.

#### Additional Spring CLI Commands

Use `spring init --list` to view all available options:
- Dependencies: View all supported dependencies
- Java versions: Check supported Java versions
- Project types: See available project types
- Packaging options: JAR or WAR
- Language options: Java, Kotlin, or Groovy

You can type spring help to get more details `spring help init`.

Common usage examples:

```bash
# Create a Gradle project with Java
spring init --type=gradle-project \
            --java-version=21 \
            --dependencies=web,data-jpa \
            my-gradle-app.zip

# Create a project with custom name and description
spring init --name=MyApp \
            --description="My Spring Boot Application" \
            --package=com.example.myapp \
            custom-app.zip
```





