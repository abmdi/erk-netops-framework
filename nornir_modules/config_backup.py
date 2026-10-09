from nornir import InitNornir
from nornir.core.task import Task, Result
from nornir_netmiko.tasks import netmiko_send_command
from datetime import datetime
import os

def backup_configuration(task: Task) -> Result:
    """
    Function to back up the configuration of a network device.
    """
    # Define the command to fetch the running configuration
    command = "show running-config"
    
    # Execute the command on the device
    result = task.run(
        task=netmiko_send_command,
        command_string=command
    )
    
    # Get the current date and time for timestamping the backup
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    
    # Define the backup directory and ensure it exists
    backup_dir = f"backups/{task.host.name}"
    os.makedirs(backup_dir, exist_ok=True)
    
    # Construct the backup file name
    backup_file = f"{backup_dir}/{task.host.name}_config_{timestamp}.txt"
    
    # Write the configuration to a file
    with open(backup_file, 'w') as file:
        file.write(result.result)
    
    # Return a successful result
    return Result(
        host=task.host,
        result=f"Configuration backed up to {backup_file}"
    )

def main():
    """
    Main function to initialize Nornir and execute the backup task.
    """
    # Initialize Nornir with default configuration
    nr = InitNornir(config_file="config.yaml")
    
    # Run the backup_configuration task across all devices
    nr.run(task=backup_configuration)

if __name__ == "__main__":
    main()