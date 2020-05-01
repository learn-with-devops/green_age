# Download the Base CentOS
FROM centos:latest

# Who is writing
MAINTAINER  Anand Reddy <anand@cisco.com>

# Update OS
RUN yum -y update

# Install Apache
RUN yum install -y httpd && yum install -y wget && yum install -y vim

# WorkDir
WORKDIR /var/www/html

# Remove the workspace
RUN rm -rf /var/www/html/*

# Copy the wesite into Image
COPY . /var/www/html/

# Expose 80 port
EXPOSE 80

# Start the Apache when ever it converts container
ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]
