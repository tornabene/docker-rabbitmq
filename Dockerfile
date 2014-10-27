# RabbitMQ
#
# VERSION               0.0.1

FROM      ubuntu:14.04
MAINTAINER Tindaro Tornaebne "tindaro.tornabene@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

ADD rabbitmq-signing-key-public.asc /tmp/rabbitmq-signing-key-public.asc
RUN apt-key add /tmp/rabbitmq-signing-key-public.asc

RUN echo "deb http://www.rabbitmq.com/debian/ testing main" > /etc/apt/sources.list.d/rabbitmq.list
RUN apt-get -qq update > /dev/null
RUN apt-get -qq -y install rabbitmq-server > /dev/null
RUN apt-get -y install openssh-server && mkdir /var/run/sshd
RUN apt-get install -yqq inetutils-ping net-tools
RUN /usr/sbin/rabbitmq-plugins enable rabbitmq_management
RUN echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config

ADD run.sh /run.sh
ADD set_rabbitmq_password.sh /set_rabbitmq_password.sh
RUN chmod 755 ./*.sh

EXPOSE 5672 15672 4369 22
 
CMD ["/run.sh","/usr/sbin/sshd -D","/usr/sbin/rabbitmq-server"]