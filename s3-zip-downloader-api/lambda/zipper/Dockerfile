# Use Python 3.10 slim
FROM python:3.10-slim

WORKDIR /app

# Copy dependencies and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy lambda code
COPY . .

# Default command if you want to run locally
CMD ["python", "handler.py"]
