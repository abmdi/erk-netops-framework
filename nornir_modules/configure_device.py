from nornir import InitNornir
from nornir.core.task import Task, Result
from nornir_netmiko import netmiko_send_config
from nornir_utils.plugins.functions import print_result

def configure_device(task: Task, config_commands: list) -> Result:
    """
    Configure a network device using a list of configuration commands.

    :param task: The Nornir task object
    :param config_commands: List of configuration commands to be sent to the device
    :return: Nornir Result object
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

    # Define the configuration commands to send
    config_commands = [
        "interface GigabitEthernet0/1",
        "description Configured by Nornir",
        "no shutdown"
    ]

    # Run the configure_device task against all devices
    results = nr.run(
        task=configure_device,
        config_commands=config_commands
    )

    # Print the results of the task execution
    print_result(results)

if __name__ == "__main__":
    main()