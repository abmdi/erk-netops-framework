from nornir import InitNornir
from nornir.plugins.tasks.networking import netmiko_send_config
from nornir.plugins.functions.text import print_result

def configure_vlan(task, vlan_id, vlan_name):
    """
    Configures a VLAN on a network device.
    
    :param task: Nornir task object
    :param vlan_id: ID of the VLAN to be configured
    :param vlan_name: Name of the VLAN to be configured
    """
    # Define the commands to create a VLAN with a name
    commands = [
        f"vlan {vlan_id}",
        f"name {vlan_name}"
    ]
    
    # Send the configuration commands to the device
    task.run(task=netmiko_send_config, config_commands=commands)

def main():
    # Initialize Nornir with the default configuration
    nr = InitNornir(config_file="config.yaml")
    
    # Set the VLAN ID and Name
    vlan_id = 10
    vlan_name = "Engineering"

    # Run the configuration task on all devices in the inventory
    result = nr.run(task=configure_vlan, vlan_id=vlan_id, vlan_name=vlan_name)

    # Print the result of the configuration task
    print_result(result)

if __name__ == "__main__":
    main()