from nornir import InitNornir
from nornir.plugins.tasks.networking import netmiko_send_command
from nornir.plugins.tasks.files import write_file
from nornir.plugins.functions.text import print_result

def backup_configuration(task):
    # Send 'show running-config' command to the device
    command = "show running-config"
    result = task.run(task=netmiko_send_command, command_string=command)

    # Define backup file name based on device name
    backup_file = f"backups/{task.host.name}_running_config.txt"

    # Write the configuration to a file
    task.run(task=write_file, content=result.result, filename=backup_file)

def main():
    # Initialize Nornir with default configuration file
    nr = InitNornir(config_file="config.yaml")

    # Run the backup_configuration task for all devices
    result = nr.run(task=backup_configuration)

    # Print the result of the backup operation
    print_result(result)

if __name__ == "__main__":
    main()