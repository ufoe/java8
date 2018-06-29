# java8
基于centos构建java8 docker镜像

# 详细过程
## 基础镜像
基础镜像使用centos的latest版本
## 下载java8
```
yum -y update \
	&& mkdir /usr/java \
	&& curl -L -k -b  "oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u172-b11/a58eab1ec242421181065cdc37240b08/jdk-8u172-linux-x64.tar.gz  | gunzip -c | tar x \
    && mv jdk1.8.0_172 /usr/java/jdk1.8.0_172
```
创建目录/usr/java，下载jdk，并把jdk移入/usr/java

## 设置中文环境
使用docker pull centos，完了之后镜像无法显示中文。
```
#安装中文支持
yum -y install kde-l10n-Chinese && yum -y reinstall glibc-common 
#配置显示中文
localedef -c -f UTF-8 -i zh_CN zh_CN.UTF-8
```

## 设置时区为北京时间
```
/bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
echo 'Asia/Shanghai' > /etc/timezone
```
## 设置环境变量
```
ENV LANG zh_CN.UTF-8
ENV LC_ALL zh_CN.UTF-8
ENV JAVA_HOME /usr/java/jdk1.8.0_172
ENV JRE_HOME /usr/java/jdk1.8.0_172/jre
ENV PATH $PATH:$JAVA_HOME/bin:$JRE_HOME/bin
ENV CLASSPATH .:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib
```

# 构建镜像
```
docker build -t wangxianfeng/java8 .
```