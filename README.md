# Docker Data Optimization Script

## Description

This PowerShell script is designed to optimize Docker Desktop's performance on Windows by stopping the Docker service, exporting the Docker data, compacting the `ext4.vhdx` file, and re-importing the Docker data. The script aims to reduce the size of Docker's virtual disk, improving disk space usage and potentially enhancing performance.

## How This Script Helps

### Issues It Solves:
1. **High Disk Usage**:
   - Over time, Docker's virtual disk (`ext4.vhdx`) grows due to containers, images, and volumes that are created and removed. This can lead to high disk usage, even when unused data is not actively occupying space. By compacting the VHDX file, the script helps reclaim unused disk space.

2. **Slow Docker Performance**:
   - A bloated virtual disk may slow down Docker’s performance. Compacting the VHDX file can improve performance by reducing unnecessary file sizes, leading to quicker startup and execution times for Docker containers.

3. **Docker Data Management**:
   - If you frequently work with containers, images, and volumes, managing disk usage is important to ensure that Docker remains efficient and doesn't consume excessive resources. The export, compact, and import process optimizes the overall management of Docker data.

4. **System Resource Optimization**:
   - By freeing up disk space, the overall system may experience improved performance, especially if you're running multiple containers or resource-intensive applications.

5. **Prevention of Docker Desktop Corruption**:
   - In rare cases, a heavily used Docker installation might experience data corruption or other issues due to large or unmanaged data files. Regularly optimizing and managing the virtual disk can prevent such problems.

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