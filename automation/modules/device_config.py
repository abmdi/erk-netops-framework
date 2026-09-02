from nornir import InitNornir
from nornir.plugins.tasks.networking import netmiko_send_config
from nornir.plugins.functions.text import print_result

def configure_device(task, config_commands):
    """
    Configure a network device using a list of configuration commands.

    Parameters:
    - task: The Nornir task object.
    - config_commands: A list of configuration commands to be sent to the device.
    """
    # Send configuration commands to the device
    result = task.run(
        task=netmiko_send_config,
        config_commands=config_commands
    )
    return result

def main():
    """
    Main function to initialize Nornir and execute the device configuration task.
    """
    # Initialize Nornir with default configuration
    nr = InitNornir(config_file="config.yaml")

    # List of configuration commands to be applied
    config_commands = [
        "interface GigabitEthernet0/1",
        "description Connected to Core Switch",
        "ip address 192.168.1.1 255.255.255.0",
        "no shutdown"
    ]

    # Execute the configuration task on all devices in inventory
    result = nr.run(
        task=configure_device,
        config_commands=config_commands
    )

    # Print the result of the configuration task
    print_result(result)

if __name__ == "__main__":
    main()