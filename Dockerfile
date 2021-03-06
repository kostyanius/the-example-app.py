FROM ubuntu:20.04

WORKDIR /src

COPY ./requirements.txt .
RUN echo "nameserver 8.8.8.8" >>  /etc/resolv.conf
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y python3-pip
RUN pip3 install -r requirements.txt

COPY . .

EXPOSE 3000

CMD ["make", "run"]
