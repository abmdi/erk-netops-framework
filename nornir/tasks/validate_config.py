from nornir import InitNornir
from nornir.core.task import Task, Result
from nornir.plugins.tasks.networking import netmiko_send_command

def validate_device_config(task: Task) -> Result:
    """
    Task function to validate configuration of a network device.
    """
    # Send a command to retrieve the current running configuration
    running_config_result = task.run(
        task=netmiko_send_command,
        command_string="show running-config"
    )
    
    # Retrieve the expected configuration from a predefined source
    with open(f"expected_configs/{task.host}.txt", "r") as file:
        expected_config = file.read()

    # Compare the running configuration with the expected configuration
    running_config = running_config_result.result
    if running_config.strip() == expected_config.strip():
        return Result(
            host=task.host,
            result="Configuration is valid.",
            changed=False
        )
    else:
        return Result(
            host=task.host,
            result="Configuration mismatch detected!",
            changed=True
        )

def main():
    # Initialize Nornir with configuration file
    nr = InitNornir(config_file="config.yaml")
    
    # Run the validation task on all hosts
    result = nr.run(task=validate_device_config)
    
    # Print the results of the validation
    for host, task_results in result.items():
        for task_result in task_results:
            print(f"{host}: {task_result.result}")

if __name__ == "__main__":
    main()