FROM python:3.8

RUN apt-get update
RUN pip install poetry

WORKDIR /tmp
ADD pyproject.toml /tmp
ADD poetry.lock /tmp

RUN poetry install

ADD controller.py /tmp
ADD crd.yaml /tmp

ENTRYPOINT  ["poetry", "run", "python", "-u", "/tmp/controller.py"]