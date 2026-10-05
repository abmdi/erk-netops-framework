python
from nornir import InitNornir
from nornir.core.task import Task, Result
from nornir_netmiko import netmiko_send_config

def configure_vlan(task: Task, vlan_id: int, vlan_name: str) -> Result:
    """
    Configure a VLAN on a network device using Netmiko via Nornir.
    
    :param task: Nornir task object
    :param vlan_id: VLAN ID to configure
    :param vlan_name: Name of the VLAN
    :return: Result of the configuration task
    """
    # Prepare configuration commands
    commands = [
        f"vlan {vlan_id}",          # Enter VLAN configuration mode
        f"name {vlan_name}"         # Set the VLAN name
    ]

    # Send configuration commands to the device
    result = task.run(
        task=netmiko_send_config,
        config_commands=commands
    )

    # Return the result of the configuration task
    return Result(
        host=task.host,
        result=f"Configured VLAN {vlan_id} with name {vlan_name}"
    )

def main():
    # Initialize Nornir with the configuration file
    nr = InitNornir(config_file="config.yaml")

    # Filter devices (optional: customize your filter criteria)
    targets = nr.filter(F(groups__contains="network_devices"))

    # Run VLAN configuration task on filtered devices
    result = targets.run(
        task=configure_vlan,
        vlan_id=10,
        vlan_name="Production"
    )

    # Print the results
    print(result)

if __name__ == "__main__":
    main()
