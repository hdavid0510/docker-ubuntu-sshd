FROM ubuntu:18.04

WORKDIR /

RUN apt-get update -qq \
	&& apt-get install -y -qq \
		apt-utils openssh-server nano bash-completion software-properties-common \
	&& apt-get clean -q \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /var/run/sshd \
	&& echo 'root:root' |chpasswd \
	&& sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
	&& sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
	&& mkdir /root/.ssh \
	&& touch /root/.ssh/authorized_keys

COPY files /

EXPOSE 22
ENTRYPOINT [ "/startup.sh" ]
