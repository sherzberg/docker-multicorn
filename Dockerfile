##
# Multicorn 1.0.4 on Postgres 9.3
##
FROM ubuntu:14.04
MAINTAINER Mike Douglas http://www.github.com/mike-douglas/

RUN apt-get update -qq && apt-get upgrade -y

ENV DB_USER docker
ENV DB_PASS docker
ENV DB_NAME multicorn

RUN apt-get install -y build-essential python-dev python-pip postgresql postgresql-server-dev-9.3
RUN apt-get clean
RUN pip install pgxnclient
RUN pgxn install multicorn==1.0.4

# Open Postgres ports
RUN mkdir -p /etc/postgresql/9.3/main
RUN echo "host    all             all             0.0.0.0/0               md5" >> /etc/postgresql/9.3/main/pg_hba.conf
RUN echo "listen_addresses = '*'" >> /etc/postgresql/9.3/main/postgresql.conf
RUN echo "port = 5432" >> /etc/postgresql/9.3/main/postgresql.conf

EXPOSE 5432

ADD start.sh /start.sh
RUN chmod a+x /start.sh

VOLUME /src

CMD ["/start.sh"]

