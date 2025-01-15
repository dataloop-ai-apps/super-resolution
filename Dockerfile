# Base image
FROM dataloopai/dtlpy-agent:cpu.py3.10.opencv

# Switch to non-root user
USER 1000

# Upgrade pip and setuptools to avoid dependency issues
RUN pip install --user --upgrade pip setuptools

# Install primary dependencies
RUN pip install --user \
    tensorflow \
    ISR --no-deps \
    pyyaml \
    absl-py \
    dtlpy

# Install TensorFlow-related auxiliary dependencies
RUN pip install --user \
    astunparse \
    flatbuffers \
    gast \
    google-pasta \
    grpcio \
    h5py \
    keras \
    libclang \
    opt-einsum \
    tensorboard \
    tensorflow-io-gcs-filesystem \
    termcolor \
    "ml-dtypes<0.5.0,>=0.4.0"

# Reinstall TensorFlow to ensure compatibility
RUN pip install --user --upgrade --force-reinstall tensorflow

# Install specific NumPy version
RUN pip install --user numpy==1.24.3

# Install additional dependencies
RUN pip install --user \
    pyaml \
    dataclasses \
    dtlpymetrics \
    inquirer
