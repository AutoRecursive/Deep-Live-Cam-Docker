# Deep Live Cam

A Dockerized real-time camera application with integrated deep learning capabilities.

## Project Overview

Deep Live Cam is a containerized real-time camera application that can:
- Capture real-time camera feed
- Perform real-time analysis using deep learning models
- Support GPU acceleration with CUDA

## System Requirements

- Docker
- NVIDIA GPU with CUDA support
- X11 server (for GUI support)

## Quick Start

1. Clone the repository
```bash
git clone [repository-url]
cd deep-live-cam
```

2. Build Docker image
```bash
docker build -t deeplivecam .
```

3. Make the start script executable
```bash
chmod +x start.sh
```

4. Run the application
```bash
./start.sh
```

## Configuration

The application can be configured through:
- Docker environment variables
- Volume mounts (e.g., `~/data:/app/pics` for saving pictures)

## Project Structure

```
deep-live-cam/
├── Dockerfile           # Docker configuration
├── start.sh            # Application startup 
```

## License

MIT License

## Contact

For questions or suggestions, please open an Issue.
