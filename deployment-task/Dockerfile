FROM python:3.6.12

RUN pip install --upgrade pip && pip install pipenv

ENV WORKDIR /app/
WORKDIR ${WORKDIR}

RUN git clone https://github.com/aws/efs-utils
WORKDIR ${WORKDIR}/efs-utils
RUN apt-get update && apt-get -y install binutils nfs-common stunnel4
RUN pwd
RUN ls -l
RUN ./build-deb.sh
RUN apt-get -y install ./build/amazon-efs-utils*deb

WORKDIR ${WORKDIR}
COPY Pipfile Pipfile.lock ${WORKDIR}

ARG EFS_ENDPOINT
RUN echo $EFS_ENDPOINT

RUN mkdir efs
RUN ls -l

COPY deploy.sh ${WORKDIR}
RUN chmod +x deploy.sh

ENTRYPOINT ["./deploy.sh"]
