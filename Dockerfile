FROM ubuntu:16.04
MAINTAINER Zacharias Georgiou <zgeorg03@cs.ucy.ac.cy>
ENV REFRESHED_AT 2018-08-22
RUN apt-get update -qq
RUN apt-get install -y default-jre wget

ENV SPARK_RELEASE spark-2.1.1-bin-hadoop2.7

RUN wget https://archive.apache.org/dist/spark/spark-2.1.1/$SPARK_RELEASE.tgz \
#RUN wget http://www-us.apache.org/dist/spark/spark-2.1.1/$SPARK_RELEASE.tgz  \
    && mkdir /spark \
    && tar -zxvf $SPARK_RELEASE.tgz -C /spark

RUN rm $SPARK_RELEASE.tgz

EXPOSE 4040

ENV SPARK_HOME /spark/${SPARK_RELEASE}
ENV PATH ${PATH}:${SPARK_HOME}/bin

## Submiting to spark
COPY submit.sh /home/
RUN chmod 755 /home/submit.sh

## Copy Configuration
COPY configuration.properties /home/

## Copy Insights
COPY insights.ins /home/

## Jar
COPY StreamSight-0.0.1.jar /home/

ENV MASTER_NODE "local[2]"

#CMD [ "/bin/bash" ]
CMD [ "/home/submit.sh" ]
