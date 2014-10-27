# Ntipa RabbitMQ
#
# VERSION               0.0.1

FROM      ubuntu:14.04
MAINTAINER Tindaro Tornaebne "tindaro.tornabene@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

ADD rabbitmq-signing-key-public.asc /tmp/rabbitmq-signing-key-public.asc
RUN apt-key add /tmp/rabbitmq-signing-key-public.asc

RUN echo "deb http://www.rabbitmq.com/debian/ testing main" > /etc/apt/sources.list.d/rabbitmq.list
RUN apt-get update 
RUN apt-get install -y openssh-server
RUN apt-get -y install supervisor
RUN apt-get install -yqq inetutils-ping net-tools
WORKDIR /etc/supervisor/conf.d
RUN mkdir -p   /var/run/sshd /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# configure the "ntipa" and "root" users
RUN echo 'root:ntipa' |chpasswd
RUN groupadd ntipa && useradd ntipa -s /bin/bash -m -g ntipa -G ntipa && adduser ntipa sudo
RUN echo 'ntipa:ntipa' |chpasswd	
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

RUN apt-get -qq -y install rabbitmq-server
RUN /usr/sbin/rabbitmq-plugins enable rabbitmq_management
RUN echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config




ADD run.sh /run.sh
ADD set_rabbitmq_password.sh /set_rabbitmq_password.sh
RUN chmod 755 /*.sh
RUN  /run.sh
EXPOSE 5672 15672 4369 22

CMD ["/usr/bin/supervisord"]