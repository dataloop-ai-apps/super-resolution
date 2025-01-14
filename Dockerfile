FROM dataloopai/dtlpy-agent:cpu.py3.10.opencv

RUN pip install --user \
    tensorflow \
    ISR --no-deps \
    pyyaml