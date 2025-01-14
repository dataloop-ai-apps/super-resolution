FROM dataloopai/dtlpy-agent:cpu.py3.10.opencv
USER 1000
RUN pip install --user \
    tensorflow \
    ISR --no-deps \
    pyyaml