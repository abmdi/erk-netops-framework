from nornir import InitNornir
from nornir.plugins.tasks.networking import napalm_get
from nornir.plugins.functions.text import print_result

def backup_device_config(task):
    """
    Task to backup the running configuration of a network device using NAPALM.
    """
    # Use napalm_get to retrieve the running config from the device
    result = task.run(task=napalm_get, getters=["config"])
    
    # Extract the running configuration
    running_config = result.result["config"]["running"]
    
    # Define a file path to save the backup configuration
    backup_file = f"backups/{task.host.name}_running_config.txt"
    
    # Write the backup configuration to a file
    with open(backup_file, "w") as file:
        file.write(running_config)
    
    # Log backup completion
    print(f"Backup saved for {task.host.name} at {backup_file}")

def main():
    """
    Main function to initialize Nornir and run the backup task on all hosts.
    """
    # Initialize Nornir with the default configuration
    nr = InitNornir(config_file="config.yaml")
    
    # Run the backup_device_config task on all hosts
    result = nr.run(task=backup_device_config)
    
    # Print the result of the task execution
    print_result(result)

if __name__ == "__main__":
    main()