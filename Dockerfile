# Base image
FROM dataloopai/dtlpy-agent:gpu.cuda.11.5.py3.8.tf2.5

# Install primary dependencies
RUN pip install \
    ISR --no-deps

RUN pip install \
    pyyaml \
    dtlpy \
    numpy==1.23.4



# docker build -t gcr.io/viewo-g/piper/agent/runner/apps/super-resolution:1.2.2 -f Dockerfile .
# docker run -it gcr.io/viewo-g/piper/agent/runner/apps/super-resolution:1.2.2 bash