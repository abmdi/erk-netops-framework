from nornir import InitNornir
from nornir.core.filter import F
from nornir.plugins.tasks.networking import netmiko_send_config
from nornir.plugins.functions.text import print_result

def update_device_config(task, config_commands):
    # Send configuration commands to the device
    task.run(task=netmiko_send_config, config_commands=config_commands)

def main():
    # Initialize Nornir with the configuration file
    nr = InitNornir(config_file="config.yaml")
    
    # Filter devices by role or any specific criteria
    # Here, we're filtering devices with the role 'edge_router'
    devices = nr.filter(F(role="edge_router"))

    # Define the configuration commands to be sent
    config_commands = [
        "interface GigabitEthernet0/1",
        "description Configured by Nornir",
        "no shutdown"
    ]

    # Run the update_device_config task
    result = devices.run(task=update_device_config, config_commands=config_commands)

    # Print the result of the task execution
    print_result(result)

if __name__ == "__main__":
    main()