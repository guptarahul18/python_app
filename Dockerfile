# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file first
COPY requirements.txt /app/

# Install venv and create a virtual environment
RUN apt-get update && apt-get install -y python3-venv && \
    python3 -m venv /opt/venv

# Activate the virtual environment and install dependencies
RUN /opt/venv/bin/pip install --upgrade pip && \
    /opt/venv/bin/pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application source code
COPY . /app

# Set the environment path for the virtual environment
ENV PATH="/opt/venv/bin:$PATH"

# Expose port 8501 for Streamlit
EXPOSE 8501

# Run Streamlit when the container launches
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]


