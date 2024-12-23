FROM --platform=$TARGETPLATFORM ubuntu:22.04

ENV USER_UID 1080
ENV USER_GID 1000
ENV USERNAME ubuntu

WORKDIR /
COPY files /
#COPY --chown=$USERNAME:$USERNAME . .

# APT Mirror
RUN		sed -i 's/archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list \
	&&	apt-get -qq update \
	&&	apt-get -qqy -o=Dpkg::Use-Pty=0 install apt-utils nano bash-completion software-properties-common sudo curl cron \
	&&	apt-get -qq clean \
	&&	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
	&&	mkdir /var/run/sshd \
	&&	echo 'root:root' |chpasswd

# Create non-root user
RUN		groupadd -f --gid $USER_GID $USERNAME \
	&&	useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
	&&	echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
	&&	chmod 0440 /etc/sudoers.d/$USERNAME

# Cron setting, Give the necessary rights to the user to run the cron
RUN		crontab -u $USERNAME /etc/cron.d/restart-cron \
	&&	chmod u+s /usr/sbin/cron

# Use on-root user
USER $USERNAME

ENTRYPOINT [ "/bin/bash", "/entrypoint.sh" ]
