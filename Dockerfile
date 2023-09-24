FROM python:3.6-bullseye

ENV PIPENV_SKIP_LOCK=true
RUN python3 -m pip install pipenv

COPY Pipfile \
    /
RUN pipenv install

COPY . /

CMD ["pipenv", "run", "serve", "--host", "0.0.0.0"]
