### Learning Docker http://docker.io/ by creating a RabbitMQ container.

### To build:

    sudo docker build github.com/tornabene/docker-rabbitmq.git

### To run:

    sudo docker pull tornabene/docker-rabbitmq
    sudo docker run -d --name test1 -p 5672:5672 -p 15672:15672 -p 9922:15672  tornabene/docker-rabbitmq
    
### To persist your data:

Here we persistently save our data to the host machine's ``/opt/rabbitmq/ntipa`` directory.

    mkdir -p /opt/rabbitmq/ntipa
    chmod 777 /opt/rabbitmq/ntipa
    sudo docker run -h rabbitmq.ntipa.it -p 5672:5672 -p 15672:15672 -v /opt/rabbitmq/ntipa:/var/lib/rabbitmq/ntipa tornabene/docker-rabbitmq

Since RabbitMQ uses the ``$HOSTNAME`` in its data path, we need to explicitly set it for the container.

    $  sudo docker run -h rabbitmq.ntipa.it -p 5672:5672 -p 15672:15672 -v /opt/rabbitmq/ntipa:/var/lib/rabbitmq/ntipa tornabene/docker-rabbitmq
    WARNING: Docker detected local DNS server on resolv.conf. Using default external servers: [8.8.8.8 8.8.4.4]
    
                  RabbitMQ 3.1.5. Copyright (C) 2007-2013 GoPivotal, Inc.
      ##  ##      Licensed under the MPL.  See http://www.rabbitmq.com/
      ##  ##
      ##########  Logs: /var/log/rabbitmq/rabbit@rabbithost.log
      ######  ##        /var/log/rabbitmq/rabbit@rabbithost-sasl.log
      ##########
                  Starting broker... completed with 6 plugins.