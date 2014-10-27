### Learning Docker http://docker.io/ by creating a RabbitMQ container.

### To build:

	Spostarsi nella directory e lanciare il comando
    sudo docker build tornabene/docker-rabbitmq .
  
### To run:

    sudo docker pull tornabene/docker-rabbitmq
    sudo docker run -d --name rabbitmq.ntipa.it -p 5672:5672 -p 15672:15672 -p 9922:22  tornabene/docker-rabbitmq
    
### To persist your data:

Here we persistently save our data to the host machine's ``/opt/ntipa/rabbitmq`` directory.

    mkdir -p /opt/rabbitmq/ntipa
    chmod 777 /opt/rabbitmq/ntipa
    sudo docker run -d --name rabbitmq.ntipa.it -p 5672:5672 -p 15672:15672 -p 9922:22  tornabene/docker-rabbitmq -v /opt/ntipa/rabbitmq:/var/lib/rabbitmq/ntipa tornabene/docker-rabbitmq