FROM jupyter/minimal-notebook:latest
RUN python -m pip install qiskit && \
    python -m pip install qiskit-aer && \
    python -m pip install qiskit[all] && \
    python -m pip install ipywidgets && \
    python -m pip install matplotlib && \
    python -m pip install seaborn
