from nornir import InitNornir
from nornir.core.task import Task, Result
from nornir_netmiko.tasks import netmiko_send_command

def collect_interface_status(task: Task) -> Result:
    """
    Nornir task to collect interface status from a network device using Netmiko.
    """
    # Command to retrieve interface status
    command = "show interfaces status"

    # Use Netmiko to send the command to the device
    result = task.run(task=netmiko_send_command, command_string=command)

    # Return the command output as the result
    return Result(
        host=task.host,
        result=result.result,
    )

def main():
    # Initialize Nornir with configuration
    nr = InitNornir(config_file="config.yaml")

    # Run the collect_interface_status task against all devices
    results = nr.run(task=collect_interface_status)

    # Print the results for each device
    for host, result in results.items():
        print(f"Host: {host}")
        print(result.result)

if __name__ == "__main__":
    main()