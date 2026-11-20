from nornir import InitNornir
from nornir.core.task import Task, Result
from nornir_netmiko.tasks import netmiko_send_config

def configure_vlan(task: Task, vlan_id: int, vlan_name: str) -> Result:
    """
    Configures a VLAN on a network device using Netmiko via Nornir.

    :param task: Nornir Task object containing host information.
    :param vlan_id: Integer VLAN ID to configure.
    :param vlan_name: String VLAN name to configure.
    :return: Nornir Result object with the outcome of the configuration.
    """
    # Generate configuration commands for the VLAN
    commands = [
        f"vlan {vlan_id}",
        f"name {vlan_name}"
    ]

    # Send configuration commands to the device
    result = task.run(
        task=netmiko_send_config,
        config_commands=commands
    )

    # Return the result of the configuration task
    return Result(
        host=task.host,
        result=result.result
    )

def main():
    # Initialize Nornir with inventory and configuration settings
    nr = InitNornir(config_file="config.yaml")

    # Define VLAN ID and name to configure
    vlan_id = 100
    vlan_name = "Production"

    # Run the configure_vlan task for all hosts in the inventory
    result = nr.run(
        task=configure_vlan,
        vlan_id=vlan_id,
        vlan_name=vlan_name
    )

    # Print the result for each host
    for host, task_result in result.items():
        print(f"{host}: {task_result.result}")

if __name__ == "__main__":
    main()