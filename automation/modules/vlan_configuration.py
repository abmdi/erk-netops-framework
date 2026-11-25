python
from nornir import InitNornir
from nornir.core.filter import F
from nornir_netmiko.tasks import netmiko_send_config

def configure_vlan(task, vlan_id, vlan_name):
    """
    Configure a VLAN on a network device.
    
    :param task: Nornir task object
    :param vlan_id: VLAN ID to configure
    :param vlan_name: VLAN name to assign
    """
    # Construct VLAN configuration commands
    commands = [
        f"vlan {vlan_id}",
        f"name {vlan_name}"
    ]
    
    # Send configuration commands to the device
    task.run(task=netmiko_send_config, config_commands=commands)

def main():
    # Initialize Nornir with default configuration
    nr = InitNornir(config_file="config.yaml")
    
    # Filter devices where VLAN needs to be configured
    target_devices = nr.filter(F(role="switch") & F(site="datacenter"))

    # Define VLAN details
    vlan_id = 10
    vlan_name = "PRODUCTION"

    # Execute the VLAN configuration task on the filtered devices
    result = target_devices.run(task=configure_vlan, vlan_id=vlan_id, vlan_name=vlan_name)

    # Print the result of the task execution
    for host, host_result in result.items():
        print(f"{host}: {host_result[1].result}")

if __name__ == "__main__":
    main()
