python
from nornir import InitNornir
from nornir.core.task import Task, Result
from nornir_netmiko import netmiko_send_config

def configure_device(task: Task, config_commands: list):
    """
    Function to send configuration commands to a network device.

    :param task: Nornir task object
    :param config_commands: List of configuration commands to be sent
    :return: Result object with the output of the configuration
    """
    # Use Netmiko to send configuration commands to the device
    result = task.run(
        task=netmiko_send_config,
        config_commands=config_commands
    )
    return Result(
        host=task.host,
        result=result.result
    )

def main():
    # Initialize Nornir with a default configuration file
    nr = InitNornir(config_file="config.yaml")

    # Define the configuration commands to be applied to the devices
    config_commands = [
        "interface GigabitEthernet0/1",
        "description Configured by Nornir",
        "no shutdown"
    ]

    # Run the configure_device task on all devices in the inventory
    result = nr.run(
        task=configure_device,
        config_commands=config_commands
    )

    # Print the result of the configuration
    for host, task_result in result.items():
        print(f"{host}: {task_result[0].result}")

if __name__ == "__main__":
    main()
