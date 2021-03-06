FROM registry.access.redhat.com/rhel7:latest
MAINTAINER Armin M. Warda <armin.warda@gmail.com>

USER root
EXPOSE 3000

ENV GRAFANA_VERSION="4.6.0"
ENV GRAFANA_VERSION_PREV="4.5.2,4.4.3,4.3.1"

ADD root /
RUN yum -y install https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-"$GRAFANA_VERSION"-1.x86_64.rpm \
 && yum clean all
COPY run.sh /usr/share/grafana/
RUN ls -la    /usr/bin/fix-permissions /usr/share/grafana/run.sh \
 && chmod a+x /usr/bin/fix-permissions /usr/share/grafana/run.sh \
 && ls -la    /usr/bin/fix-permissions /usr/share/grafana/run.sh
RUN /usr/bin/fix-permissions /usr/share/grafana \
 && /usr/bin/fix-permissions /etc/grafana       \
 && /usr/bin/fix-permissions /var/lib/grafana   \
 && /usr/bin/fix-permissions /var/log/grafana 

WORKDIR /usr/share/grafana
ENTRYPOINT ["./run.sh"]
