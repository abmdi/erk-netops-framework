from nornir import InitNornir
from nornir.plugins.tasks.networking import netmiko_send_command, netmiko_send_config
from nornir.plugins.functions.text import print_result

def configure_device(task):
    """Send configuration commands to network devices using Netmiko."""
    # Define commands to be sent to the network device
    configuration_commands = [
        "interface GigabitEthernet0/1",
        "description Configured via Nornir",
        "no shutdown"
    ]

    # Send configuration commands to the device
    result = task.run(task=netmiko_send_config, config_commands=configuration_commands)
    
    # Verify the configuration by running a command
    verification_result = task.run(task=netmiko_send_command, command_string="show running-config interface GigabitEthernet0/1")
    
    # Log the verification output
    print_result(verification_result)

def main():
    # Initialize Nornir with configuration file
    nr = InitNornir(config_file="config.yaml")
    
    # Run the configuration task on all devices defined in the inventory
    result = nr.run(task=configure_device)
    
    # Print the result of the configuration task
    print_result(result)

if __name__ == "__main__":
    main()