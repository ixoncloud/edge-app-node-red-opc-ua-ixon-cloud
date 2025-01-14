REM Ensure the correct builder is in use
docker buildx use secure-edge-pro

cd opcua-server

REM Build the microsoft-opcua image
docker buildx build --platform linux/arm64/v8 --tag 192.168.140.1:5000/opcua-server:3.11 --push .

cd ..

cd node-red

REM Build the node-red image
docker buildx build --platform linux/arm64/v8 --tag 192.168.140.1:5000/node-red-opc-ua:4.0.3-22 --push .

cd ..
