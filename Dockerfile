FROM centos
MAINTAINER WangXianfeng wang-xianfeng@qq.com
#下载java8
RUN yum -y update \
	&& mkdir /usr/java \
	&& curl -L -k -b  "oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u172-b11/a58eab1ec242421181065cdc37240b08/jdk-8u172-linux-x64.tar.gz  | gunzip -c | tar x \
    && mv jdk1.8.0_172 /usr/java/jdk1.8.0_172 \
    && yum -y install kde-l10n-Chinese && yum -y reinstall glibc-common \
    && localedef -c -f UTF-8 -i zh_CN zh_CN.UTF-8 \
	&& /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
	&& echo 'Asia/Shanghai' > /etc/timezone \
        && yum clean all \
        && rm -rf /var/cache/yum/*
#设置jdk环境变量	
ENV LANG zh_CN.UTF-8 \
 LC_ALL zh_CN.UTF-8 \
 JAVA_HOME /usr/java/jdk1.8.0_172 \
 JRE_HOME /usr/java/jdk1.8.0_172/jre \
 PATH $PATH:$JAVA_HOME/bin:$JRE_HOME/bin \
 CLASSPATH .:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib

CMD ["java -version"]
