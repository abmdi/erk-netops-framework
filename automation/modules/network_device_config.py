python
from netmiko import ConnectHandler
from typing import List

class NetworkDeviceConfig:
    def __init__(self, device_type: str, host: str, username: str, password: str):
        """
        Initialize the NetworkDeviceConfig with device connectivity information.
        """
        self.device_params = {
            'device_type': device_type,
            'host': host,
            'username': username,
            'password': password,
        }

    def send_command(self, command: str) -> str:
        """
        Connect to the device and send a single command.
        """
        with ConnectHandler(**self.device_params) as net_connect:
            # Execute the command on the network device
            output = net_connect.send_command(command)
            return output

    def send_config_set(self, config_commands: List[str]) -> str:
        """
        Connect to the device and send a set of configuration commands.
        """
        with ConnectHandler(**self.device_params) as net_connect:
            # Send configuration commands to the device
            output = net_connect.send_config_set(config_commands)
            return output

if __name__ == "__main__":
    # Example usage: Replace with actual credentials and device details
    device = NetworkDeviceConfig(
        device_type='cisco_ios',
        host='192.168.1.1',
        username='admin',
        password='admin123'
    )

    # Send a single command
    print(device.send_command('show ip interface brief'))

    # Send a set of configuration commands
    config_commands = [
        'interface GigabitEthernet0/1',
        'description Connected to LAN',
        'no shutdown'
    ]
    print(device.send_config_set(config_commands))
