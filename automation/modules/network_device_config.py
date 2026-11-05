from nornir import InitNornir
from nornir.core.task import Task, Result
from nornir_netmiko.tasks import netmiko_send_config
from nornir_utils.plugins.functions import print_result

def configure_device(task: Task, configuration: list) -> Result:
    """
    Function to configure a network device using a list of configuration commands.
    
    Args:
        task (Task): Nornir task object.
        configuration (list): List of configuration commands to apply.
    
    Returns:
        Result: Nornir result object with the outcome of the configuration.
    """
    # Send configuration commands to the network device
    result = task.run(task=netmiko_send_config, config_commands=configuration)
    return result

def main():
    # Initialize Nornir with the default configuration
    nr = InitNornir(config_file="config.yaml")
    
    # Define the configuration commands to be applied
    config_commands = [
        "interface Gi1/0/1",
        "description Configured by Nornir",
        "no shutdown"
    ]
    
    # Run the configure_device function on all hosts
    result = nr.run(task=configure_device, configuration=config_commands)
    
    # Print the result of the operation
    print_result(result)

if __name__ == "__main__":
    main()