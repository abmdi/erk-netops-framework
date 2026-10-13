from nornir import InitNornir
from nornir.core.task import Task, Result
from nornir_netmiko.tasks import netmiko_send_config
from nornir_utils.plugins.functions import print_result

def configure_device(task: Task, config_commands: list):
    """
    Configures a network device with the provided list of configuration commands.
    :param task: Nornir task object containing host information.
    :param config_commands: List of configuration commands to apply.
    :return: Result object containing the command output.
    """
    # Send configuration commands to the device using Netmiko
    result = task.run(
        task=netmiko_send_config,
        config_commands=config_commands
    )
    return Result(host=task.host, result=result.result)

def main():
    # Initialize Nornir with default configuration
    nr = InitNornir(config_file="config.yaml")
    
    # Define the configuration commands to apply to the devices
    config_commands = [
        "interface GigabitEthernet0/1",
        "description Configured by Nornir",
        "no shutdown"
    ]
    
    # Run the configure_device task on all hosts in the inventory
    result = nr.run(
        task=configure_device,
        config_commands=config_commands
    )
    
    # Print the result of the task execution
    print_result(result)

if __name__ == "__main__":
    main()