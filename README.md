
# sonar-scanner-dotnet

Implementation of the sonar-scanner for dotnet projects

Image is actually hosted under `registry.gitlab.com/kirrk/utils/sonarscanner-dotnet:latest` 

## Basic Usage

### Launch container

You'll need to define variables :
- `SOURCE_PATH` : The path to your local sources to scan
- `SONAR_HOST_URL` : The host of sonar (http://something:9000 )
- `SONAR_LOGIN` : The user sonar will use to perform analysis
- `SONAR_PASSWORD` : The password of the given user

```bash
docker run                                                      \
  -v ${SOURCE_PATH}:/app                                        \
  -e SONAR_HOST_URL=${SONAR_HOST_URL}                           \
  -e SONAR_LOGIN=${SONAR_LOGIN}                                 \
  -e SONAR_PASSWORD=${SONAR_PASSWORD}                           \
  -it                                                           \
  registry.gitlab.com/kirrk/utils/sonarscanner-dotnet:latest
```

### Inside container

You'll need to define variables :
- `PROJECT_ROOT` : The root of the project to scan
- `SONAR_PROJECT_KEY` : The key of the sonar project to scan (Visible on SonarQube)

```bash
cd ${PROJECT_ROOT}
dotnet /opt/sonarscanner/SonarScanner.MSBuild.dll begin /key:${SONAR_PROJECT_KEY}
dotnet build
dotnet /opt/sonarscanner/SonarScanner.MSBuild.dll end
```

## Advanced usage

### Gitlab-CI

