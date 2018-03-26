FROM ubuntu:17.10
MAINTAINER tim@chaubet.be
LABEL ptmagic.version="1.4.0"

ENV TZ 'Europe/Brussels'

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
 && echo $TZ > /etc/timezone \
 && rm /etc/localtime \
 && apt-get install -y net-tools \
                       iputils-ping \
                       curl \
                       wget \
                       unzip \
                       tzdata \
 && curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg \
 && mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg \
 && sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-artful-prod artful main" > /etc/apt/sources.list.d/dotnetdev.list' \
 && apt-get update \
 && apt-get install -y dotnet-sdk-2.1.3 \
                       aspnetcore-store-2.0.6 \
 && mkdir -p /opt/pt-magic/ptm-binance \
 && cd /opt/pt-magic/ptm-binance \
 && wget https://github.com/Legedric/ptmagic/releases/download/1.4.0/PTMagic.1.4.0.zip \
 && unzip *.zip \
 && mv PTMagic\ 1.4.0/* . \
 && mv PTMagic/* . \
 && rm *.zip \
 && ls -hl \
 && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
 && dpkg-reconfigure -f noninteractive tzdata \
 && apt-get clean

VOLUME ["/mnt/profittrailer","/mnt/ptmagic"]

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["PTMagic.dll"]
