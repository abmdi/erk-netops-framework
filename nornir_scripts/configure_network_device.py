from nornir import InitNornir
from nornir.core.task import Task, Result
from nornir_netmiko.tasks import netmiko_send_config
from nornir_utils.plugins.functions import print_result

def configure_device(task: Task, config_commands: list) -> Result:
    """
    Task to configure a network device using Netmiko.

    Args:
        task (Task): Nornir task object.
        config_commands (list): List of configuration commands to be sent to the device.

    Returns:
        Result: Result object with the outcome of the task execution.
    """
    # Send configuration commands to the device
    result = task.run(
        task=netmiko_send_config,
        config_commands=config_commands
    )
    return result

def main():
    """
    Main function to initialize Nornir and execute the configuration task.
    """
    # Initialize Nornir with the default configuration file
    nr = InitNornir(config_file="config.yaml")

    # Define the configuration commands to be sent to the devices
    config_commands = [
        "interface GigabitEthernet0/1",
        "description Configured by Nornir",
        "ip address 192.168.1.1 255.255.255.0",
        "no shutdown"
    ]

    # Run the configuration task against the target devices
    result = nr.run(
        task=configure_device,
        config_commands=config_commands
    )

    # Print the result of the task execution
    print_result(result)

if __name__ == "__main__":
    main()