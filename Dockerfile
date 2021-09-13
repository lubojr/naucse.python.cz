FROM python:3.6-bullseye

COPY Pipfile \
    Pipfile.lock \
    /
RUN python3 -m pip install pipenv
RUN pipenv install

COPY . /

CMD ["pipenv", "run", "serve", "--host", "0.0.0.0"]
