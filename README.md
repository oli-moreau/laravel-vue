# Laravel 10 with Vue 3 Project in Docker Container

This is a Laravel 10 project with Vue 3 and Vue Router, intended to be run as a Docker container. The project runs a Laravel development server and Vue development server inside the container, making it easy to get started with development.

## Prerequisites

Before proceeding, make sure you have the following installed on your system:

- Docker: [Install Docker](https://www.docker.com/get-started)

## Getting Started

Follow the steps below to build and run the Laravel project inside a Docker container:

### 1. Clone the Repository

```bash
git clone https://github.com/oli-moreau/laravel-vue.git
cd laravel-vue
```

### 2. Build the Docker Image

```bash
docker build -t debian-laravel-vue .
docker run -d -p 8000:8000 -p  3306:3306 -p 5173:5173 --name debian-laravel-vue -v "$(pwd)":/var/www/html debian-laravel-vue
docker exec -it debian-laravel-vue bash
```

### 3. Start the development servers
```bash
php artisan serve --host=0.0.0.0
npm run dev -- --host
```
The development server is now available at http://localhost:8000/
