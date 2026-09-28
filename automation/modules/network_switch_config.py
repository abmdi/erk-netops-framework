from nornir import InitNornir
from nornir.core.filter import F
from nornir_netmiko.tasks import netmiko_send_config
from nornir_utils.plugins.functions import print_result

def configure_switch_interfaces(interface_configurations):
    """
    Automate the configuration of network switch interfaces using Nornir and Netmiko.

    :param interface_configurations: Dictionary containing switch hostnames and their interface configurations
    :type interface_configurations: dict
    """
    # Initialize Nornir with default configuration file
    nr = InitNornir(config_file="config.yaml")

    # Iterate over the provided interface configurations
    for host, config in interface_configurations.items():
        # Filter to target specific host
        targeted_host = nr.filter(F(name=host))

        # Send interface configuration to the targeted host
        result = targeted_host.run(
            task=netmiko_send_config,
            config_commands=config
        )

        # Print the result of the configuration task
        print_result(result)

# Example usage
if __name__ == "__main__":
    # Define interface configurations for each switch
    interface_configs = {
        "switch1": [
            "interface GigabitEthernet0/1",
            "description Link to Router",
            "switchport mode access",
            "switchport access vlan 10",
            "no shutdown"
        ],
        "switch2": [
            "interface GigabitEthernet0/1",
            "description Link to Core Switch",
            "switchport mode trunk",
            "switchport trunk allowed vlan 10,20,30",
            "no shutdown"
        ]
    }

    # Call the function to apply configurations
    configure_switch_interfaces(interface_configs)