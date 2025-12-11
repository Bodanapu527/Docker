# Base image
FROM python:3.10-slim

# Image creator information (deprecated but acceptable in interview)
MAINTAINER Venkat Reddy <venkat@example.com>

# Labels (metadata)
LABEL project="demo-app"
LABEL version="1.0"
LABEL author="Venkat"

# Build-time argument
ARG APP_ENV=production

# Set environment variable
ENV ENVIRONMENT=$APP_ENV

# Set working directory
WORKDIR /usr/src/app

# Copy requirements file (COPY)
COPY requirements.txt .

# Install dependencies (RUN)
RUN pip install --no-cache-dir -r requirements.txt

# Add source code (ADD supports archive extraction)
ADD src/ ./src/

# Create a non-root user (RUN + USER)
RUN useradd -ms /bin/bash appuser
USER appuser

# Expose application port
EXPOSE 5000

# OnBuild instruction (executes when another image uses this as base)
ONBUILD COPY . /usr/src/app/onbuild-data

# Set entrypoint (main program)
ENTRYPOINT ["python", "src/app.py"]

# CMD will act as default arguments to entrypoint
CMD ["--start"]