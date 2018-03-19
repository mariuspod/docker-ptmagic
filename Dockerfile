FROM ubuntu:17.10
MAINTAINER tim@chaubet.be

RUN apt-get update \
 && apt-get install -y net-tools \
                       iputils-ping 

VOLUME ["/mnt/profittrailer","/mnt/ptmagic"]

CMD ["/bin/ping", "10.10.0.1"]


#FROM microsoft/aspnetcore-build:2.0 AS build-env
### https://docs.docker.com/engine/examples/dotnetcore/#prerequisites

#WORKDIR /app

# Copy csproj and restore as distinct layers
#COPY *.csproj ./
#RUN dotnet restore

# Copy everything else and build
#COPY . ./
#RUN dotnet publish -c Release -o out

# Build runtime image
#FROM microsoft/aspnetcore:2.0
#WORKDIR /app
#COPY --from=build-env /app/out .
#ENTRYPOINT ["dotnet", "aspnetapp.dll"]


#ENV PT_DL=https://github.com/Legedric/ptmagic/releases/download/1.3.1/PTMagic.1.3.1.zip
#VOLUME ["/app/ProfitTrailer"]
#ADD $PT_DL /opt
#ADD docker-entrypoint.sh /
#CMD ["/docker-entrypoint.sh"]
