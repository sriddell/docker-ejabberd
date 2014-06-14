FROM ubuntu:14.04

RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

RUN apt-get update && apt-get install -y pwgen python-setuptools ejabberd ssl-cert openssl

RUN /usr/bin/easy_install supervisor
ADD ./supervisord.conf /etc/supervisord.conf
ADD ejabberd.cfg /etc/ejabberd/ejabberd.cfg
RUN touch /var/lib/ejabberd/dummy
ADD ./start.sh /start.sh

EXPOSE 5222
EXPOSE 5280
EXPOSE 5080

CMD ["/bin/bash", "/start.sh"]


