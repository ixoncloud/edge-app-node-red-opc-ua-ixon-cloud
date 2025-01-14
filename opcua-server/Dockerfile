# Use the official lightweight Python image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONUNBUFFERED=1


# Install system dependencies required for cryptography
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        libssl-dev \
        libffi-dev \
        python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip to the latest version
RUN pip install --upgrade pip

# Install pip dependencies, including opcua and cryptography
RUN pip install --no-cache-dir opcua cryptography

# Create and set the working directory
WORKDIR /app

# Copy the OPC UA server script into the container
COPY opcua_server.py .

# Expose port 50000 for OPC UA communication
EXPOSE 50000

# Define the default command to run the server
CMD ["python", "opcua_server.py"]
