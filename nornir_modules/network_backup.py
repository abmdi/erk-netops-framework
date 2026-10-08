python
from nornir import InitNornir
from nornir.plugins.tasks.networking import netmiko_send_command
from nornir.plugins.functions.text import print_result
from datetime import datetime

def backup_config(task):
    """Backup the running configuration of a network device."""
    # Send command to get the running configuration
    command = "show running-config"
    result = task.run(task=netmiko_send_command, command_string=command)

    # Create a filename based on hostname and current date
    hostname = task.host.name
    date_str = datetime.now().strftime('%Y%m%d')
    filename = f"{hostname}_running_config_{date_str}.txt"

    # Save the configuration to a local file
    with open(filename, 'w') as config_file:
        config_file.write(result.result)

    # Log a message indicating successful backup
    task.host.data['backup_status'] = f"Configuration backed up to {filename}"

def main():
    # Initialize Nornir with default configuration file
    nr = InitNornir(config_file="nornir_config.yaml")

    # Run the backup task on all devices
    result = nr.run(task=backup_config)

    # Print the result of the operation
    print_result(result)

if __name__ == "__main__":
    main()
