from nornir import InitNornir
from nornir.core.task import Task, Result
from nornir_netmiko.tasks import netmiko_send_command
from nornir_utils.plugins.functions import print_result

def fetch_interface_status(task: Task) -> Result:
    """
    Task function to fetch the status of interfaces on network devices.
    """
    # Execute the 'show ip interface brief' command to get interface status
    command = "show ip interface brief"
    result = task.run(task=netmiko_send_command, command_string=command)
    
    # Return the result of the command execution
    return Result(
        host=task.host,
        result=result.result
    )

def main():
    """
    Main function to initialize Nornir and execute the fetch_interface_status task.
    """
    # Initialize Nornir with default configuration
    nr = InitNornir(config_file="config.yaml")
    
    # Run the fetch_interface_status task on all hosts
    results = nr.run(task=fetch_interface_status)
    
    # Print the results of the task execution
    print_result(results)

if __name__ == "__main__":
    main()