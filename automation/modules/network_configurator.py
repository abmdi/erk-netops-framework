import logging
from nornir import InitNornir
from nornir.plugins.tasks.networking import netmiko_send_command
from nornir.plugins.functions.text import print_result

# Initialize logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def configure_network_device(task, command):
    """
    Execute a configuration command on a network device.

    :param task: Nornir task object
    :param command: Configuration command to execute
    """
    # Send command to the device using Netmiko
    result = task.run(task=netmiko_send_command, command_string=command)
    # Log the result
    logger.info(f"Device {task.host}: {result.result}")

def main():
    # Initialize Nornir with default configuration
    nr = InitNornir(config_file="config.yaml")

    # Define the command to execute on each device
    command_to_run = "show version"

    # Run the configuration task on all devices in the inventory
    result = nr.run(task=configure_network_device, command=command_to_run)

    # Print the result
    print_result(result)

if __name__ == "__main__":
    main()