# Docker Data Optimization Script

## Description

This PowerShell script is designed to optimize Docker Desktop's performance on Windows by stopping the Docker service, exporting the Docker data, compacting the `ext4.vhdx` file, and re-importing the Docker data. The script aims to reduce the size of Docker's virtual disk, improving disk space usage and potentially enhancing performance.

## Prerequisites

Before running the script, make sure you meet the following requirements:

- **Windows OS**: This script is designed for use on Windows systems.
- **Docker Desktop**: Docker Desktop must be installed.
- **PowerShell**: Ensure you are running PowerShell with administrative privileges.
- **WSL 2**: Windows Subsystem for Linux 2 (WSL 2) must be enabled and in use by Docker Desktop.
- **Administrator Privileges**: The script requires administrator privileges to stop/start services and manipulate the Docker data files.

## Steps to Execute the Script

1. **Download the Script**: Save the PowerShell script to a convenient location on your local machine.

2. **Open PowerShell as Administrator**:
   - Press `Win + X` and select **Windows PowerShell (Admin)** or **Terminal (Admin)**, depending on your setup.

3. **Execute the Script**:
   - Navigate to the directory where the script is saved:
     ```powershell
     cd path\to\your\script
     ```
   - Run the script with the desired export path. By default, the export path is set to `C:\`. You can specify a custom path as well:
     ```powershell
     .\DockerOptimizationScript.ps1 -ExportPath "D:\Backup"
     ```

4. **Wait for Completion**:
   - The script will stop Docker, export the Docker data, compact the VHDX file, re-import the data, and restart Docker. The progress will be displayed in the terminal.

5. **Script Completion**:
   - Once completed, Docker will restart and the exported files will be deleted automatically.

## Open Source License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.