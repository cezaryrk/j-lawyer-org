# syntax=docker/dockerfile:1
# check=skip=SecretsUsedInArgOrEnv
FROM mysql:5.7

LABEL org.opencontainers.image.authors="j-dimension info@j-lawyer.org"

# set default access data
ENV MYSQL_ROOT_PASSWORD="mysql"
ENV MYSQL_USER="jlawyer"
ENV MYSQL_PASSWORD="jlawyer"

# create folders, permissions and set parameter in /etc/my.cnf
RUN mkdir -p /var/lib/mysql && \
    mkdir -p /var/run/mysqld && \
    mkdir -p /var/log/mysql && \
    chown -R mysql:mysql /var/lib/mysql && \
    chown -R mysql:mysql /var/run/mysqld && \
    chown -R mysql:mysql /var/log/mysql && \
    chmod -R 755 /var/lib/mysql && \
    chmod -R 755 /var/run/mysqld && \
    chmod -R 755 /var/log/mysql && \
    sed -i -e "s/\(\[client\]\)/[mysql]\n\n\1/g" /etc/my.cnf && \
    sed -i -e "s/\(\[client\]\)/\1\ndefault-character-set = utf8/g" /etc/my.cnf && \
    sed -i -e "s/\(\[mysql\]\)/\1\ndefault-character-set = utf8/g" /etc/my.cnf && \
    sed -i -e "s/\(\[mysqld\]\)/\1\ninit_connect='SET NAMES utf8'\ncharacter-set-server = utf8\ncollation-server=utf8_unicode_ci\nbind-address = 0.0.0.0/g" /etc/my.cnf &&\
    sed -i -e "s/\(docker_init_database_dir() {\)/\1\n\tchmod -R 755 \/var\/lib\/mysql\n/g" /usr/local/bin/docker-entrypoint.sh
    
VOLUME /var/lib/mysql

COPY ./create_database.sql /docker-entrypoint-initdb.d/10_create_database.sql
COPY ./grant_permission.sh /docker-entrypoint-initdb.d/20_grant_permission.sh
RUN chmod +x /docker-entrypoint-initdb.d/*.sh

EXPOSE 3306/tcp
EXPOSE 33060/tcp
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["mysqld"]