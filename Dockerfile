FROM python:3.9-alpine3.13
LABEL mainteiner="Jean Paul Bernhardt"

ENV PYTHONUNBUFFERED 1

# RUN mkdir /tmp
COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true"]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
        fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        -D \
        django-user

ENV PATH="/py/bin:$PATH"

USER django-user 