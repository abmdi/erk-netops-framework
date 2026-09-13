python
from netmiko import ConnectHandler
from datetime import datetime
import os

def backup_device_config(device_params, backup_directory):
    """
    Connect to a network device using Netmiko and back up its configuration.

    :param device_params: Dictionary containing device connection parameters.
    :param backup_directory: Directory path where the backup will be stored.
    """
    # Establish SSH connection to the device
    with ConnectHandler(**device_params) as net_connect:
        # Send command to retrieve the device's running configuration
        config_output = net_connect.send_command("show running-config")
    
    # Create backup directory if it doesn't exist
    os.makedirs(backup_directory, exist_ok=True)
    
    # Create a timestamped filename for the backup
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    filename = f"{device_params['host']}_backup_{timestamp}.txt"
    filepath = os.path.join(backup_directory, filename)
    
    # Write the configuration to a file
    with open(filepath, 'w') as backup_file:
        backup_file.write(config_output)
    
    print(f"Backup successful for {device_params['host']}. File saved as {filepath}")

# Example usage
if __name__ == "__main__":
    device = {
        'device_type': 'cisco_ios',
        'host': '192.168.1.1',
        'username': 'admin',
        'password': 'password',
        'secret': 'enable_password',  # Optional, if device requires enable mode
    }
    
    backup_device_config(device, './backups')
