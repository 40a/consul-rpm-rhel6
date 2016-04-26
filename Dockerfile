# default build is for CentOS7, change the base image to fit your build.
FROM centos:centos6
MAINTAINER Sebastien Le Digabel "sledigabel@gmail.com"

RUN yum update -y
RUN yum install -y rpmdevtools mock

RUN cd /root && rpmdev-setuptree
ADD sources/* /root/rpmbuild/SOURCES/
ADD spec/* /root/rpmbuild/SPECS/
RUN ln -s /root/rpmbuild/RPMS /RPMS

VOLUME ["/RPMS"]

CMD set -x && cd /root && spectool -g -R rpmbuild/SPECS/consul.spec && rpmbuild -ba rpmbuild/SPECS/consul.spec
