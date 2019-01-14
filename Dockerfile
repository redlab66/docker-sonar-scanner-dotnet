FROM openjdk:8u181-jdk
LABEL Maintainer="Yann Ponzoni (Mobioos) <yann.ponzoni@redfabriq.com>"

ENV SONAR_HOST_URL 'http://localhost:9000'
ENV SONAR_LOGIN 'changeme'
ENV SONAR_PASSWORD 'changeme'

# Install basics (see: https://askubuntu.com/questions/165676/how-do-i-fix-a-e-the-method-driver-usr-lib-apt-methods-http-could-not-be-foun)
RUN apt-get update                                                                                                     \
 && apt-get install -y apt-transport-https

# Install dotnet (see: https://dotnet.microsoft.com/learn/dotnet/hello-world-tutorial)
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg                    \
 && mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/                                                                       \
 && wget -q https://packages.microsoft.com/config/debian/9/prod.list                                                   \
 && mv prod.list /etc/apt/sources.list.d/microsoft-prod.list                                                           \
 && chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg                                                           \
 && chown root:root /etc/apt/sources.list.d/microsoft-prod.list                                                        \
 && apt-get update                                                                                                     \
 && apt-get install -y dotnet-sdk-2.1

# Install sonar-scanner (see: https://docs.sonarqube.org/display/SCAN/Install+the+SonarScanner+for+MSBuild)
ADD https://github.com/SonarSource/sonar-scanner-msbuild/releases/download/4.5.0.1761/sonar-scanner-msbuild-4.5.0.1761-netcoreapp2.0.zip /tmp/sonarscanner-msbuild.zip
RUN unzip /tmp/sonarscanner-msbuild.zip -d /opt/sonarscanner/                                                          \
 && chmod -v +x /opt/sonarscanner/sonar-scanner-*/bin/*                                                                \
 && ln -s /opt/sonarscanner/sonar-scanner-*/bin/sonar-scanner       /usr/local/bin                                     \
 && ln -s /opt/sonarscanner/sonar-scanner-*/bin/sonar-scanner-debug /usr/local/bin

# Define entrypoint
COPY entrypoint.sh /entrypoint.sh

# Write the configuration file from envvars
ENTRYPOINT ["/entrypoint.sh"]
