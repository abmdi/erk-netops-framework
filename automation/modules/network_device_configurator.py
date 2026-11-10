from nornir import InitNornir
from nornir.core.task import Task, Result
from nornir_netmiko import netmiko_send_config
from nornir_utils.plugins.functions import print_result

def configure_device(task: Task, config_commands: list) -> Result:
    """
    Configures a network device using a list of configuration commands.

    Args:
        task (Task): Nornir task object for the current device.
        config_commands (list): List of configuration commands to be applied.

    Returns:
        Result: Nornir Result object containing the outcome of the configuration task.
    """
    # Send configuration commands to the device
    result = task.run(
        task=netmiko_send_config,
        config_commands=config_commands
    )
    return result

def main():
    # Initialize Nornir with the default configuration
    nr = InitNornir(config_file="config.yaml")

    # Define the configuration commands to be sent to devices
    config_commands = [
        "interface GigabitEthernet0/1",
        "description Configured by Nornir",
        "no shutdown"
    ]

    # Run the configuration task on all devices
    result = nr.run(
        task=configure_device,
        config_commands=config_commands
    )

    # Print the result of the configuration task
    print_result(result)

if __name__ == "__main__":
    main()