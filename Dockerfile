FROM python:3.6

RUN pip install git+https://github.com/locustio/locust.git

COPY startup.sh /

EXPOSE 5557 5558 8089

ENTRYPOINT ["/startup.sh"]
