FROM python:2.7

RUN pip install locustio pyzmq

COPY startup.sh /

EXPOSE 5557 5558 8089

ENTRYPOINT ["/startup.sh"]
