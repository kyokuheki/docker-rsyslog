FROM alpine
LABEL maintainer Kenzo Okuda <kyokuheki@gmail.comt>

RUN apk add --no-cache \
    logrotate \
    rsyslog \
    tar

COPY assets/logrotate.conf /etc/logrotate.conf

RUN set -x \
 && chmod 644 /etc/logrotate.conf \
 && mkdir -p /var/spool/rsyslog

VOLUME ["/etc/rsyslog", "/var/log", "/var/run/dev", "/run/systemd/journal"]
EXPOSE 514 514/udp

USER 0

CMD set -x; \
    rm -vf /var/run/rsyslogd.pid; \
    crond -l 2 -f & \
    /usr/sbin/rsyslogd -n -f /etc/rsyslog/rsyslog.conf -i /var/run/rsyslogd.pid;
