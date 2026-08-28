python
from nornir import InitNornir
from nornir_netmiko.tasks import netmiko_send_command
from nornir_utils.plugins.tasks.files import write_file
from nornir.core.filter import F
from datetime import datetime
import os

def backup_network_configurations(task):
    # Send command to get the running configuration
    result = task.run(task=netmiko_send_command, command_string="show running-config")
    
    # Generate backup directory if it doesn't exist
    backup_dir = f"backups/{task.host.name}"
    os.makedirs(backup_dir, exist_ok=True)
    
    # Create filename with timestamp
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    filename = f"{backup_dir}/running_config_{timestamp}.txt"
    
    # Write the configuration to a file
    task.run(task=write_file, content=result.result, filename=filename)

def run_nornir_backup():
    # Initialize Nornir with default configuration
    nr = InitNornir(config_file="config.yaml")
    
    # Filter hosts with a role of 'core-switch'
    core_switches = nr.filter(F(role="core-switch"))
    
    # Run the backup task on the filtered hosts
    results = core_switches.run(task=backup_network_configurations)
    
    # Print summary results
    for host, result in results.items():
        print(f"Backup for {host} completed with status: {result[0].failed}")
        
if __name__ == "__main__":
    run_nornir_backup()
