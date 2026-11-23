from nornir import InitNornir
from nornir.core.task import Task, Result
from nornir_netmiko.tasks import netmiko_send_config

def configure_vlan(task: Task, vlan_id: int, vlan_name: str):
    """
    Configures a VLAN on a network device using the provided VLAN ID and name.

    :param task: Nornir Task object
    :param vlan_id: VLAN ID to configure
    :param vlan_name: VLAN name to configure
    """
    # Construct VLAN configuration commands
    commands = [
        f"vlan {vlan_id}",
        f"name {vlan_name}"
    ]
    
    # Send configuration commands to the device
    result = task.run(
        task=netmiko_send_config,
        config_commands=commands,
        name=f"Configuring VLAN {vlan_id}"
    )
    
    return Result(
        host=task.host,
        result=f"VLAN {vlan_id} configured on {task.host.name}"
    )

def main():
    # Initialize Nornir with configuration file
    nr = InitNornir(config_file="config.yaml")
    
    # Define VLAN ID and name
    vlan_id = 10
    vlan_name = "Production"
    
    # Run the configure_vlan task on all devices
    result = nr.run(
        task=configure_vlan,
        vlan_id=vlan_id,
        vlan_name=vlan_name
    )
    
    # Print the result summary
    print_result(result)

if __name__ == "__main__":
    main()