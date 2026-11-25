python
from nornir import InitNornir
from nornir.core.task import Task, Result
from nornir_netmiko import netmiko_send_config

def configure_vlan(task: Task, vlan_id: int, vlan_name: str) -> Result:
    """
    Configure VLAN on a Cisco IOS device using Nornir and Netmiko.

    :param task: Nornir Task object
    :param vlan_id: Integer representing VLAN ID
    :param vlan_name: String representing VLAN name
    :return: Nornir Result object
    """
    # Define the configuration commands for the VLAN
    commands = [
        f"vlan {vlan_id}",
        f"name {vlan_name}",
        "exit"
    ]

    # Execute the configuration commands on the device
    result = task.run(
        task=netmiko_send_config,
        config_commands=commands
    )

    # Return the result of the task execution
    return Result(
        host=task.host,
        result=result
    )

if __name__ == "__main__":
    # Initialize Nornir with a configuration file
    nr = InitNornir(config_file="config.yaml")

    # Filter devices by a specific criterion, e.g., all Cisco IOS devices
    ios_devices = nr.filter(platform="ios")

    # Run the configure_vlan task on filtered devices with specified VLAN parameters
    result = ios_devices.run(
        task=configure_vlan,
        vlan_id=10,
        vlan_name="SALES"
    )

    # Print the result of the task execution
    print(result)
