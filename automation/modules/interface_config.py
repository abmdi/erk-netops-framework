from nornir import InitNornir
from nornir.core.task import Task, Result
from nornir_netmiko import netmiko_send_config

def configure_interface(task: Task, interface: str, description: str, ip_address: str, subnet_mask: str) -> Result:
    """
    Configures the network interface with the provided settings.
    
    :param task: Nornir Task object
    :param interface: Interface to configure (e.g., 'GigabitEthernet0/1')
    :param description: Description for the interface
    :param ip_address: IP address to assign to the interface
    :param subnet_mask: Subnet mask for the IP address
    :return: Result object indicating success or failure
    """
    # Create a list of configuration commands to send to the device
    config_commands = [
        f"interface {interface}",
        f"description {description}",
        f"ip address {ip_address} {subnet_mask}",
        "no shutdown"
    ]

    # Use Nornir's netmiko plugin to send the configuration commands
    result = task.run(
        task=netmiko_send_config,
        config_commands=config_commands
    )

    return result

def main():
    # Initialize Nornir with default configuration
    nr = InitNornir(config_file="config.yaml")

    # Define interface configuration parameters
    interface = "GigabitEthernet0/1"
    description = "Uplink to Core Router"
    ip_address = "192.168.1.1"
    subnet_mask = "255.255.255.0"

    # Run the configure_interface task across all devices
    result = nr.run(
        task=configure_interface,
        interface=interface,
        description=description,
        ip_address=ip_address,
        subnet_mask=subnet_mask
    )

    # Print the result of the configuration
    print_result(result)

if __name__ == "__main__":
    main()