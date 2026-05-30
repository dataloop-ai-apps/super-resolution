# Base image
FROM hub.dataloop.ai/dtlpy-runner-images/gpu:python3.12_cuda11.8_pytorch2

# Install TensorFlow (with its dependencies)
RUN ${DL_PYTHON_EXECUTABLE} -m pip install --no-cache-dir \
    tensorflow==2.16.1

# Install ISR without pulling its own deps plus supporting libs
RUN ${DL_PYTHON_EXECUTABLE} -m pip install --no-cache-dir \
    ISR --no-deps \
    absl-py \
    pyyaml \
    h5py \
    pillow \
    imageio \
    scipy \
    numpy \
    tqdm



# docker build --no-cache -t gcr.io/viewo-g/piper/agent/runner/apps/super-resolution:1.2.3 -f Dockerfile .
# docker run -it gcr.io/viewo-g/piper/agent/runner/apps/super-resolution:1.2.3 bash