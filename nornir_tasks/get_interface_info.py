python
from nornir import InitNornir
from nornir.core.task import Task, Result
from nornir_netmiko.tasks import netmiko_send_command
from typing import Dict, Any

def get_interface_info(task: Task) -> Result:
    """
    Nornir task to gather interface information from a network device using Netmiko.
    """
    # Send command to retrieve interface information
    interface_info = task.run(
        task=netmiko_send_command,
        command_string="show interfaces"
    ).result
    
    # Process the output if needed, here we just return the raw output
    return Result(
        host=task.host,
        result=interface_info
    )

def main() -> None:
    """
    Main function to initialize Nornir and run the get_interface_info task.
    """
    # Initialize Nornir with default configuration
    nr = InitNornir(config_file="config.yaml")
    
    # Run the custom Nornir task across all devices
    result = nr.run(task=get_interface_info)
    
    # Print results for each host
    for host, task_result in result.items():
        print(f"Host: {host} - Interface Info:\n{task_result.result}")

if __name__ == "__main__":
    main()
