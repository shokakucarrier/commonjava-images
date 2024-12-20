FROM quay.io/factory2/nos-java-base:latest

EXPOSE 8080

USER root

ADD start-service.sh /usr/local/bin/start-service.sh

RUN chmod +x /usr/local/bin/*

RUN mkdir -p /opt/indy-archive-service/log && \
  chmod -R 777 /opt/indy-archive-service && \
  chmod -R 777 /opt/indy-archive-service/log

ADD indy-archive-service-runner.jar /opt/indy-archive-service/indy-archive-service-runner.jar
RUN chmod +r /opt/indy-archive-service/indy-archive-service-runner.jar

# Run as non-root user
RUN chgrp -R 0 /opt && \
    chmod -R g=u /opt && \
    chgrp -R 0 /opt/indy-archive-service && \
    chmod -R g=u /opt/indy-archive-service && \
    chgrp -R 0 /opt/indy-archive-service/log && \
    chmod -R g=u /opt/indy-archive-service/log

USER 1001

ENTRYPOINT ["bash", "-c"]
CMD ["/usr/local/bin/start-service.sh"]
