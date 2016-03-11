FROM alpine:latest
MAINTAINER Max Gonzih <gonzih at gmail dot com>

RUN apk update
RUN apk add weechat tmux openssh mosh

RUN adduser -D irc

RUN mkdir -p /home/irc/.ssh
ADD authorized_keys /home/irc/.ssh/authorized_keys
RUN chown -R irc:irc /home/irc/.ssh
RUN chmod 700 /home/irc/.ssh/authorized_keys

RUN ssh-keygen -t rsa -b 4096 -P "" -f /etc/ssh/ssh_host_rsa_key

RUN echo 'AllowAgentForwarding no' >> /etc/ssh/sshd_config && \
    echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config && \
    echo 'PermitRootLogin no' >> /etc/ssh/sshd_config && \
    echo 'AuthorizedKeysFile .ssh/authorized_keys' >> /etc/ssh/sshd_config && \
    echo 'HostKey /etc/ssh/ssh_host_rsa_key' >> /etc/ssh/sshd_config

EXPOSE 60000-61000
EXPOSE 22

RUN passwd -u irc

CMD touch /var/log/sshd.log && /usr/sbin/sshd -f /var/log/sshd.log && tail -f /var/log/sshd.log
