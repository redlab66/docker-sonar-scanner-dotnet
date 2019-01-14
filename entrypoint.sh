#!/usr/bin/env bash

set +e

# Write the configuration file from env vars
echo "
<SonarQubeAnalysisProperties  xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns=\"http://www.sonarsource.com/msbuild/integration/2015/1\">
  <Property Name=\"sonar.host.url\">${SONAR_HOST_URL}</Property>
  <Property Name=\"sonar.login\">${SONAR_LOGIN}</Property>
  <Property Name=\"sonar.password\">${SONAR_PASSWORD}</Property>
</SonarQubeAnalysisProperties>
" > /opt/sonarscanner/SonarQube.Analysis.xml

# Execute given CMD
exec "$@"
