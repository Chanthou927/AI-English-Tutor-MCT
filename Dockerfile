# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /app

# Install system dependencies required for audio/AI libraries
# portaudio19-dev is critical for pyaudio
# ffmpeg is often needed for audio processing
RUN apt-get update && apt-get install -y \
    portaudio19-dev \
    ffmpeg \
    libasound2-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy the requirements file into the container
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose the port the app runs on (Streamlit usually uses 8501)
EXPOSE 8501

# Command to run the app
# CHANGE 'main.py' to your actual filename (e.g., app.py, streamlit_app.py)
CMD ["streamlit", "run", "main.py", "--server.port=8501", "--server.address=0.0.0.0"]
