# Comic Image Text Extraction Environment

This project sets up a Dockerized development environment using Miniconda for processing comic images and extracting text via OCR.

## Prerequisites

* Docker: [Install Docker](https://docs.docker.com/get-docker/)
* Docker Compose: (Usually included with Docker Desktop, or [install separately](https://docs.docker.com/compose/install/))

## Setup

1.  **Create Project Structure:**
    Ensure you have the following files and directories in your project root:
    ```
    .
    ├── Dockerfile
    ├── docker-compose.yml
    ├── environment.yml
    ├── .dockerignore
    ├── README.md
    ├── notebooks/   <-- Create this directory for your Jupyter notebooks
    ├── data/        <-- Create this directory and place your comic image folders inside (not included)
    └── src/         <-- Create this directory for any custom Python modules
    ```

2.  **Place Comic Images:**
    Put the nested directories containing your comic images inside the `data/` folder.

## Running the Environment

1.  **Build and Start:**
    ```
    make build
    make run
    ```

3.  **Access Jupyter Notebook:**
    Open your web browser and navigate to `http://localhost:8888` or `http://127.0.0.1:8888`. You should see the Jupyter Notebook interface. Since we disabled token/password in the `Dockerfile` for local convenience, it should open directly.

4.  **Start Coding:**
    * Create new notebooks inside the `notebooks/` directory via the Jupyter interface.
    * Your comic images (not included) will be accessible within the container at `/app/data/`.
    * You can write reusable Python code in files within the `src/` directory and import them into your notebooks (e.g., `from src import my_module`).

## Stopping the Environment
```
make stop
```
