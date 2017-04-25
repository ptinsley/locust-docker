FROM python:3.6

RUN pip install git+https://github.com/locustio/locust.git

COPY startup.sh /

ENTRYPOINT ["/startup.sh"]
