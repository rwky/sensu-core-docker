FROM ubuntu:16.04
MAINTAINER Rowan Wookey <admin@rwky.net>
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80  --recv-keys EB9C94BB && \
echo "deb http://repositories.sensuapp.org/apt sensu main" > /etc/apt/sources.list.d/sensu.list && \
apt-get -q update && apt-get -yq install sensu build-essential libsasl2-dev && apt-get clean && \
for p in cpu-checks disk-checks docker filesystem-checks http load-checks mailer memory-checks network-checks ssl; do sensu-install -p $p; done
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
VOLUME /etc/sensu
ENV PATH=/opt/sensu/bin:/opt/sensu/embedded/bin/:$PATH
CMD ["sensu-client", "-d", "/etc/sensu/conf.d"]
