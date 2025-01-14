from opcua import ua, Server
import time
import logging

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("opcua_server")


def main():
    try:
        # Initialize the OPC UA server
        server = Server()

        # Set the endpoint to listen on all interfaces within the container
        endpoint_url = "opc.tcp://0.0.0.0:50000"
        server.set_endpoint(endpoint_url)
        logger.info(f"Setting OPC UA endpoint to {endpoint_url}")

        # Disable all security policies by setting to NoSecurity
        server.set_security_policy([ua.SecurityPolicyType.NoSecurity])
        logger.info("Security policies set to NoSecurity")

        # Register a custom namespace
        uri = "http://example.com/opcua"
        idx = server.register_namespace(uri)
        logger.info(f"Registered namespace '{uri}' with index {idx}")

        # Get the Objects node, which is the root for custom objects
        objects = server.get_objects_node()

        # Add a new object to the Objects node
        myobj = objects.add_object(idx, "MyDevice")
        logger.info("Added object 'MyDevice' to the Objects node")

        # Add the RoomTemperature variable as Float32
        room_temp = myobj.add_variable(
            idx,
            "RoomTemperature",
            25.0,
            varianttype=ua.VariantType.Float
        )
        room_temp.set_writable()  # Make the variable writable by clients
        room_temp.set_attribute(
            ua.AttributeIds.Description,
            ua.DataValue(ua.LocalizedText("This is a custom float variable."))
        )
        logger.info("Added variable 'RoomTemperature' with initial value 25.0")

        # Add the SetpointTemperature variable as Float32
        setpoint_temp = myobj.add_variable(
            idx,
            "SetpointTemperature",
            22.0,
            varianttype=ua.VariantType.Float
        )
        setpoint_temp.set_writable()  # Make the variable writable by clients
        setpoint_temp.set_attribute(
            ua.AttributeIds.Description,
            ua.DataValue(ua.LocalizedText("This is a custom float variable."))
        )
        logger.info(
            "Added variable 'SetpointTemperature' with initial value 22.0")

        # Start the OPC UA server
        server.start()
        logger.info(f"OPC UA Server is running at {endpoint_url}")

        try:
            # Keep the server running indefinitely
            while True:
                time.sleep(1)
        except KeyboardInterrupt:
            # Stop the server gracefully on interruption
            logger.info("Shutting down OPC UA Server...")
        finally:
            server.stop()
            logger.info("OPC UA Server stopped")
    except Exception as e:
        logger.error(f"An error occurred: {e}")


if __name__ == "__main__":
    main()
