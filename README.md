# server-stats
# Server Performance Statistics Script

## Project URL: https://github.com/ank404/server-stats

A bash script to analyze and display various server performance metrics including CPU usage, memory usage, disk usage, and process information.

## Features

- CPU usage monitoring
- Memory usage statistics (in GB with percentage)
- Disk usage information
- Top 5 CPU-consuming processes
- Top 5 memory-consuming processes
- Additional system information:
  - OS version
  - System uptime
  - Load average
  - Logged-in users
  - Recent failed login attempts

## Prerequisites

- Linux-based operating system
- Bash shell
- Basic system utilities (top, free, df, ps, who)
- sudo privileges (for accessing certain log files)

## Installation

1. Clone this repository:
```bash
git clone https://github.com/YOUR_USERNAME/server-stats.git
```

2. Navigate to the project directory:
```bash
cd server-stats
```

3. Make the script executable:
```bash
chmod +x server-stats.sh
```

## Usage

Run the script:
```bash
./server-stats.sh
```

To get full information including system logs:
```bash
sudo ./server-stats.sh
```

## Sample Output

```
Server Statistics Report - Generated on: Wed Nov 13 2024 14:30:45 EDT
+----------------------------------------+--------------------------------------------------+
| OS Information                          | Ubuntu 22.04.3 LTS                               |
+----------------------------------------+--------------------------------------------------+
| System Uptime                          | 7 days, 3 hours                                  |
+----------------------------------------+--------------------------------------------------+
| CPU Usage                              | 23.5%                                            |
+----------------------------------------+--------------------------------------------------+
| Memory Usage                           | 3.2/15.7 GB (20.4%)                             |
+----------------------------------------+--------------------------------------------------+
```

## Contributing

Feel free to open issues and pull requests for any improvements you can think of!

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
