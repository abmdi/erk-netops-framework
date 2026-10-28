python
from nornir import InitNornir
from nornir_netmiko.tasks import netmiko_send_command
from nornir_utils.plugins.functions import print_result

def get_interface_status(task, interface_name):
    """Retrieve the status of a specific interface."""
    # Command to retrieve interface status
    command = f"show interfaces {interface_name} status"
    # Execute command on the device
    result = task.run(task=netmiko_send_command, command_string=command)
    # Assign the result to the host
    task.host["interface_status"] = result.result

def main(interface_name):
    """Main function to initialize Nornir and run tasks."""
    # Initialize Nornir with default configuration
    nr = InitNornir(config_file="config.yaml")
    # Run the get_interface_status task against all hosts
    result = nr.run(task=get_interface_status, interface_name=interface_name)
    # Print the result of the task execution
    print_result(result)

if __name__ == "__main__":
    # Define the interface name you want to query
    INTERFACE_NAME = "GigabitEthernet0/1"
    # Execute the main function
    main(INTERFACE_NAME)
