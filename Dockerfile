FROM python:3.9-alpine as builder

WORKDIR /app

COPY requirements.txt .

RUN apk update \
    && apk add python3 \
    && apk add --update --no-cache --virtual .build-deps alpine-sdk python3-dev musl-dev libffi-dev \
    && pip install -U setuptools pip \
    && pip install --no-cache-dir -r requirements.txt \
    && apk --purge del .build-deps

# RUN pip install --no-cache-dir --upgrade -r /app/requirements.txt

# FROM python:3.9-alpine

# COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages 

COPY . .

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]