from netmiko import ConnectHandler

def configure_device(device_params, commands):
    """
    Connects to a network device and applies a list of configuration commands.

    :param device_params: Dictionary containing device connection parameters
    :param commands: List of configuration commands to apply
    :return: Output from the device after applying the commands
    """
    # Establish connection to the network device
    with ConnectHandler(**device_params) as net_connect:
        # Enter configuration mode
        net_connect.config_mode()
        
        # Send configuration commands to the device
        output = net_connect.send_config_set(commands)
        
        # Exit configuration mode
        net_connect.exit_config_mode()

        # Save configuration
        save_output = net_connect.save_config()
        
    return output + "\n" + save_output


if __name__ == "__main__":
    # Example device parameters
    device_params = {
        'device_type': 'cisco_ios',  # Device type
        'host': '192.168.1.1',       # IP address of the device
        'username': 'admin',         # Username for authentication
        'password': 'password',      # Password for authentication
        'secret': 'enable',          # Enable password
    }
    
    # Example configuration commands
    commands = [
        'interface GigabitEthernet0/1',
        'description Connected to Router',
        'ip address 192.168.2.1 255.255.255.0',
        'no shutdown'
    ]
    
    # Configure the device and print the results
    result = configure_device(device_params, commands)
    print("Configuration Output:\n", result)