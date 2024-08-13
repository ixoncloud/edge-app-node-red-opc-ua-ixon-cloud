FROM nodered/node-red:latest

RUN npm install node-red-contrib-opcua

COPY flows.json /data/flows.json

# Expose Node-RED's default port
EXPOSE 1880
# Expose OPCUA port
EXPOSE 53881

CMD ["npm", "start"]
