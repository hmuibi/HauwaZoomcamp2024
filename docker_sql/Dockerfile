FROM python:3.9

RUN pip install pandas

WORKDIR /app
COPY pipeline.py pipeline.py

ENTRYPOINT [ "python", "pipeline.py" ]  #overriding the entrypoint, here specifying that when we use docker, we want docker to use python pipeline.py