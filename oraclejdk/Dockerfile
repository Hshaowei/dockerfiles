FROM hub.docker.dev.yunnex.com/library/alpine:3.9

LABEL maintainer="hushaowei@yunnex.com"

ENV GLIBC_VERSION 2.27-r0
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV TZ Asia/Shanghai
ENV JDK_VERSION 8u141
ENV JDK_FULL_VERSION 1.8.0_141

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
    apk add --no-cache --update-cache curl ca-certificates openssl tzdata && \
    curl -s -o /tmp/glibc-${GLIBC_VERSION}.apk http://192.168.1.11/resource/Alpine/glibc-${GLIBC_VERSION}.apk && \
    apk add --allow-untrusted /tmp/glibc-${GLIBC_VERSION}.apk && \
    rm -f /tmp/glibc-${GLIBC_VERSION}.apk && \
    curl -s -o /tmp/jdk-${JDK_VERSION}-linux-x64.tar.gz http://192.168.1.11/resource/Packages/jdk-${JDK_VERSION}-linux-x64.tar.gz && \
    mkdir -p /app/log && \
    tar -xf /tmp/jdk-${JDK_VERSION}-linux-x64.tar.gz -C /app && \
    ln -s /app/jdk${JDK_FULL_VERSION} /app/jdk && \
    rm -f /tmp/jdk-${JDK_VERSION}-linux-x64.tar.gz && \
    echo ${TZ} > /etc/timezone && \
    apk del tzdata 

ENV JAVA_HOME /app/jdk
ENV PATH ${PATH}:${JAVA_HOME}/bin

ARG JAVA_OPTS="-XX:+PrintFlagsFinal"
ARG JAVA_GC_LOG="/app/log/jvmgc.log"

# refs => http://calvin1978.blogcn.com/articles/jvmoption-7.html
ENV JAVA_OPTS   -Djava.security.egd=file:/dev/./urandom \
                -XX:AutoBoxCacheMax=20000 \
                -XX:+UnlockExperimentalVMOptions \
                -XX:+UseCGroupMemoryLimitForHeap \
                -XX:+AlwaysPreTouch \
                -XX:+PrintCommandLineFlags \
                -XX:+PrintGCDateStamps \
                -XX:+PrintGCDetails \
                -XX:+PrintGCApplicationStoppedTime \
                -Xloggc:${JAVA_GC_LOG} \
                ${JAVA_OPTS}

WORKDIR /tmp

CMD ["java","-version"]
