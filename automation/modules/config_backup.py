python
from nornir import InitNornir
from nornir.core.filter import F
from nornir.plugins.tasks.networking import netmiko_send_command
from nornir.plugins.tasks.files import write_file

def backup_configuration(task):
    """
    Function to backup the running configuration from network devices.
    """
    # Send command to get the running configuration
    result = task.run(task=netmiko_send_command, command_string="show running-config")
    
    # Define backup file name using the host's name
    backup_file = f"backups/{task.host.name}_running_config.txt"
    
    # Write the configuration to a file
    task.run(task=write_file, content=result.result, filename=backup_file)

def main():
    """
    Main function to initialize Nornir and run configuration backup across devices.
    """
    # Initialize Nornir with default configuration
    nr = InitNornir(config_file="config.yaml")
    
    # Filter devices based on role or any other criteria
    devices = nr.filter(F(role="network_device"))
    
    # Run the backup task on filtered devices
    result = devices.run(task=backup_configuration)
    
    # Output the result of the backup process
    print(result)

if __name__ == "__main__":
    main()
