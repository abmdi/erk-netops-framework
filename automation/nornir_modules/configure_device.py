from nornir import InitNornir
from nornir_netmiko.tasks import netmiko_send_config
from nornir_utils.plugins.functions import print_result

def configure_device(task, config_commands):
    """
    Configures a network device using provided configuration commands.
    
    :param task: Nornir task object
    :param config_commands: List of configuration commands to be sent to the device
    """
    # Execute the configuration commands on the device
    result = task.run(task=netmiko_send_config, config_commands=config_commands)
    return result

def main():
    # Initialize Nornir with configuration file
    nr = InitNornir(config_file="config.yaml")

    # Define the configuration commands to be executed
    commands = [
        "interface GigabitEthernet0/1",
        "description Configured by Nornir",
        "ip address 192.168.1.1 255.255.255.0",
        "no shutdown"
    ]

    # Run the configure_device task across all devices in the inventory
    result = nr.run(task=configure_device, config_commands=commands)

    # Print the result of the operation
    print_result(result)

if __name__ == "__main__":
    main()