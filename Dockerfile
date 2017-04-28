FROM localhost:5000/oracle/serverjre:8
MAINTAINER torsten.kleiber@web.de
RUN yum -y install xterm xauth libXtst
ADD $SW_FILE /tmp/
RUN yum -y install /tmp/$SW_FILE
RUN rm -f /tmp/$SW_FILE
ENV JAVA_HOME=/usr/java/default
CMD sqldeveloper