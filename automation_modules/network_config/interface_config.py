from nornir import InitNornir
from nornir.core.task import Task, Result
from nornir_netmiko.tasks import netmiko_send_config
from nornir_utils.plugins.functions import print_result

def configure_interface(task: Task, interface_name: str, ip_address: str, subnet_mask: str) -> Result:
    """
    Configures an interface on the network device.

    Args:
        task (Task): Nornir task object
        interface_name (str): Name of the interface (e.g., 'GigabitEthernet0/1')
        ip_address (str): IP address to assign to the interface
        subnet_mask (str): Subnet mask for the IP address

    Returns:
        Result: Nornir task result
    """
    # Construct configuration commands
    config_commands = [
        f"interface {interface_name}",
        f"ip address {ip_address} {subnet_mask}",
        "no shutdown"
    ]

    # Send configuration to the device
    task_result = task.run(
        task=netmiko_send_config,
        config_commands=config_commands
    )

    return task_result

def main():
    # Initialize Nornir with default configuration
    nr = InitNornir(config_file="config.yaml")
    
    # Run the configure_interface task against all hosts
    result = nr.run(
        task=configure_interface,
        interface_name="GigabitEthernet0/1",
        ip_address="192.168.1.10",
        subnet_mask="255.255.255.0"
    )

    # Print the result of the configuration task
    print_result(result)

if __name__ == "__main__":
    main()