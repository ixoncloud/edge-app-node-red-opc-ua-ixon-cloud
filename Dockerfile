FROM nodered/node-red:4.0.3-22

RUN npm install \
  node-red-contrib-opcua \
  node-red-dashboard

# Additional Node-RED protocol nodes (commented for inspiration):
# Uncomment the relevant lines below to add support for other protocols as needed:

# Modbus (for Modbus TCP communication with PLCs)
# RUN npm install node-red-contrib-modbus

# Siemens S7 (for communication with Siemens PLCs)
# RUN npm install node-red-contrib-s7

# Ethernet/IP (for Rockwell/Allen-Bradley PLCs)
# RUN npm install node-red-contrib-ethernet-ip

# Mitsubishi MELSEC (for Mitsubishi PLC communication)
# RUN npm install node-red-contrib-mcprotocol

COPY flows.json /data/flows.json

# Expose Node-RED's default port
EXPOSE 1880
# Expose OPCUA port
EXPOSE 53881

# Expose Modbus TCP port
# EXPOSE 502

# Expose Siemens S7 ports
# EXPOSE 102

# Expose Ethernet/IP ports
# EXPOSE 44818

# Expose Mitsubishi MELSEC port
# EXPOSE 1025

CMD ["npm", "start"]
