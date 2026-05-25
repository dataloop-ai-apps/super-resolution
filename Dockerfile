# Base image
FROM hub.dataloop.ai/dtlpy-runner-images/gpu:python3.12_cuda11.8_pytorch2

# Install runtime dependencies (TensorFlow/Keras required by ISR models)
RUN ${DL_PYTHON_EXECUTABLE} -m pip install --no-cache-dir \
    tensorflow==2.16.1 \
    ISR --no-deps \
    pyyaml \
    h5py \
    pillow \
    imageio \
    scipy \
    numpy \
    tqdm



# docker build -t gcr.io/viewo-g/piper/agent/runner/apps/super-resolution:1.2.3 -f Dockerfile .
# docker run -it gcr.io/viewo-g/piper/agent/runner/apps/super-resolution:1.2.3 bash