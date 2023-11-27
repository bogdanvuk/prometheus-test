FROM ubuntu:20.04
WORKDIR /app

COPY requirements.txt requirements.txt

RUN apt update \
    && apt install -y python3-pip \
    && pip3 install --upgrade pip \
    && pip3 install wheel

RUN pip3 install -r requirements.txt
COPY . .
EXPOSE 5000
ENV FLASK_APP=test_app/app.py

CMD ["flask", "run", "--host", "0.0.0.0"]