REM Remove the existing instance if necessary
docker buildx rm secure-edge-pro

REM Create and initialize the build environment
docker buildx create --name secure-edge-pro --config buildkitd-secure-edge-pro.toml
                     
REM Set the active builder
docker buildx use secure-edge-pro
