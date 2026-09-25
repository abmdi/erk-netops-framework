python
from netmiko import ConnectHandler
from typing import List

def configure_device(device_params: dict, config_commands: List[str]) -> str:
    """
    Connects to a network device and applies configuration commands.

    :param device_params: Dictionary containing device connection parameters.
                          Example: {'device_type': 'cisco_ios', 'host': '192.168.1.1', 'username': 'admin', 'password': 'password'}
    :param config_commands: List of configuration commands to apply.
                            Example: ['interface GigabitEthernet0/1', 'description Connected to Router A']
    :return: Result of the command execution.
    """
    try:
        # Establish SSH connection using the provided device parameters
        connection = ConnectHandler(**device_params)
        
        # Send configuration commands to the device
        output = connection.send_config_set(config_commands)
        
        # Disconnect the session
        connection.disconnect()
        
        # Return the output from the device after applying configurations
        return output

    except Exception as e:
        # Return the exception message if an error occurs
        return f"Failed to configure device: {str(e)}"

# Example device parameters and configuration commands
if __name__ == "__main__":
    device = {
        'device_type': 'cisco_ios',
        'host': '192.168.1.1',
        'username': 'admin',
        'password': 'password'
    }
    
    commands = [
        'interface GigabitEthernet0/1',
        'description Connected to Router A'
    ]

    # Configure the device and print the result
    result = configure_device(device, commands)
    print(result)
