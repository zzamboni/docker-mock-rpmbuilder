FROM centos:centos7
MAINTAINER Marco Mornati <marco@mornati.net>

RUN rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

RUN yum clean all
RUN yum -y update

#Install Mock Package
RUN yum -y install mock rpm-build
RUN yum -y install rubygem-bundler libxml2-devel libxslt-devel libicu-devel

#Configure users
RUN useradd -u 1000 builder
RUN usermod -a -G mock builder

VOLUME ["/rpmbuild"]

ADD ./build-rpm.sh /build-rpm.sh
RUN chmod +x /build-rpm.sh
# This fails because it requires to run in privileged mode, which cannot be done ATM from the Dockerfile
#RUN /usr/bin/mock -r epel-7-x86_64 init

#RUN setcap cap_sys_admin+ep /usr/sbin/mock

USER builder
ENV HOME /home/builder
CMD ["/build-rpm.sh"]
