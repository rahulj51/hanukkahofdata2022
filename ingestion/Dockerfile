FROM python:3.10-slim
WORKDIR /code
ADD requirements.txt requirements.txt
RUN pip install -r requirements.txt
COPY ./  /code
RUN chmod +x wait-for-postgres.sh