from nornir import InitNornir
from nornir.plugins.tasks.networking import netmiko_send_command
from nornir.plugins.tasks.files import write_file
from datetime import datetime

def backup_switch_config(task):
    """
    Task to backup the configuration of a Cisco switch.
    """
    # Send command to retrieve running configuration
    result = task.run(
        task=netmiko_send_command,
        command_string="show running-config"
    )
    
    # Format the filename with the device name and current date
    date_str = datetime.now().strftime("%Y%m%d")
    filename = f"backups/{task.host.name}_config_{date_str}.txt"
    
    # Write the configuration to a file
    task.run(
        task=write_file,
        content=result.result,
        filename=filename
    )

def main():
    # Initialize Nornir with default configuration
    nr = InitNornir(config_file="config.yaml")
    
    # Filter to only include Cisco devices
    cisco_devices = nr.filter(platform="ios")
    
    # Run backup task on each device
    cisco_devices.run(task=backup_switch_config)

if __name__ == "__main__":
    main()