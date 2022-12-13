FROM --platform=$TARGETPLATFORM ubuntu:20.04

ENV USER_UID 1027
ENV USER_GID 100
ENV USERNAME user

WORKDIR /
COPY files /
#COPY --chown=$USERNAME:$USERNAME . .

# APT Mirror
RUN		sed -i 's/archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list \
	&&	apt-get update -qq \
	&&	apt-get install -y -qq apt-utils nano bash-completion software-properties-common sudo curl cron \
	&&	apt-get clean -q \
	&&	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
	&&	mkdir /var/run/sshd \
	&&	echo 'root:root' |chpasswd

# Create non-root user
RUN		groupadd --gid $USER_GID $USERNAME \
	&&	useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
	&&	apt-get update \
	&&	apt-get install -y sudo \
	&&	echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
	&&	chmod 0440 /etc/sudoers.d/$USERNAME

# Cron setting
RUN		echo "*/5 * * * * /restart.sh > /proc/1/fd/1 2>&1" >> /etc/cron.d/restart-cron \
	# Give the necessary rights to the user to run the cron
	&&	crontab -u $USERNAME /etc/cron.d/restart-cron \
	&&	chmod u+s /usr/sbin/cron

# Use on-root user
USER $USERNAME

ENTRYPOINT [ "/bin/bash", "/startup.sh" ]
