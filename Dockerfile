# Use an official Miniconda3 base image
FROM continuumio/miniconda3:latest

# Set the working directory in the container
WORKDIR /app

# Install system dependencies
# - git: useful for version control or fetching repos if needed
# - Tesseract OCR engine and English language pack (add more languages if needed, e.g., tesseract-ocr-jpn)
# Clean up apt cache afterwards to keep image size down
RUN apt-get update && apt-get install -y \
    git \
    tesseract-ocr \
    tesseract-ocr-eng \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy the Conda environment file into the container
COPY environment.yml .

# Create the Conda environment from the file
# This step installs Python and all specified libraries
RUN conda env create -f environment.yml

# ---- REMOVE the SHELL directive ----
# It seems it wasn't reliably setting the environment for CMD.
# We will activate explicitly in the CMD line instead.
# SHELL ["conda", "run", "-n", "imageproc_env", "/bin/bash", "-c"]

# Optional: Add a step to verify jupyter exists in the environment during build
# This helps catch installation issues earlier.
RUN echo "Verifying jupyter installation..." && \
    conda run -n imageproc_env which jupyter && \
    conda run -n imageproc_env jupyter --version && \
    echo "Verification complete."

# Create directories for notebooks and data within the container
# These will typically be mounted over by volumes in docker-compose
RUN mkdir notebooks data src

# Expose the default Jupyter Notebook port
EXPOSE 8888

# --- MODIFIED CMD ---
# Set the default command to run Jupyter Notebook using bash
# Explicitly activate the conda environment first, then execute jupyter
# - Listens on all interfaces (0.0.0.0)
# - Uses the exposed port 8888
# - Allows running as root (common in containers)
# - Disables token and password authentication for easier local dev access
#   (BE CAREFUL if exposing this container to networks)
# - Sets the working directory for notebooks
CMD ["/bin/bash", "-c", "source /opt/conda/bin/activate imageproc_env && jupyter notebook --ip=0.0.0.0 --port=8888 --allow-root --NotebookApp.token='' --NotebookApp.password='' --notebook-dir=/app/notebooks"]

# You can uncomment the line below and comment the CMD line above
# if you prefer JupyterLab (Note the activation is still needed)
# CMD ["/bin/bash", "-c", "source /opt/conda/bin/activate imageproc_env && jupyter lab --ip=0.0.0.0 --port=8888 --allow-root --NotebookApp.token='' --NotebookApp.password='' --notebook-dir=/app/notebooks"]