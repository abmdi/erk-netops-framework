python  
from nornir import InitNornir  
from nornir.plugins.tasks.networking import netmiko_send_config  
from nornir.plugins.functions.text import print_result  

def configure_interface(task, interface_name, description, ip_address, subnet_mask):  
    """  
    Configure a network interface with a description, IP address, and subnet mask.  
    """  
    # Create the configuration commands  
    config_commands = [  
        f"interface {interface_name}",  
        f"description {description}",  
        f"ip address {ip_address} {subnet_mask}",  
        "no shutdown"  
    ]  

    # Send configuration commands to the device  
    task.run(task=netmiko_send_config, config_commands=config_commands)  

if __name__ == "__main__":  
    # Initialize Nornir with the default configuration file  
    nr = InitNornir(config_file="config.yaml")  
    
    # Define the parameters for the interface configuration  
    interface_params = {  
        "interface_name": "GigabitEthernet0/1",  
        "description": "Uplink to Core Switch",  
        "ip_address": "192.168.1.1",  
        "subnet_mask": "255.255.255.0"  
    }  
    
    # Run the Nornir task to configure the interface across all devices  
    result = nr.run(task=configure_interface, **interface_params)  
    print_result(result)
