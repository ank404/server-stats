#!/bin/bash

# Function to create table separator
print_separator() {
    printf "+%*s+%*s+\n" -40 "$(printf '%.0s-' {1..40})" -50 "$(printf '%.0s-' {1..50})"
}

# Function to print table row
print_row() {
    printf "| %-38s | %-48s |\n" "$1" "$2"
}

# Function to get OS information
get_os_info() {
    local os_name=$(cat /etc/os-release | grep "PRETTY_NAME" | cut -d'"' -f2)
    print_row "OS Information" "$os_name"
}

# Function to get uptime and load average
get_uptime() {
    local uptime_info=$(uptime | sed 's/.*up \([^,]*\), .*/\1/')
    local load_avg=$(uptime | awk -F'load average:' '{print $2}')
    print_row "System Uptime" "$uptime_info"
    print_row "Load Average" "$load_avg"
}

# Function to get CPU usage
get_cpu_usage() {
    local cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{printf "%.1f%%", $2 + $4}')
    print_row "CPU Usage" "$cpu_usage"
}

# Function to get memory usage
get_memory_usage() {
    # Converting MB to GB and calculating percentages
    local mem_info=$(free -m | awk 'NR==2{printf "%.1f/%.1f GB (%.1f%%)", $3/1024,$2/1024,$3*100/$2}')
    print_row "Memory Usage" "$mem_info"
}

# Function to get disk usage
get_disk_usage() {
    local disk_info=$(df -h | awk '$NF=="/"{printf "%s/%s (%s)", $3,$2,$5}')
    print_row "Disk Usage (Root)" "$disk_info"
}

# Function to get top 5 CPU-consuming processes
get_top_cpu_processes() {
    print_row "Top 5 CPU-Consuming Processes" ""
    local processes=$(ps aux | sort -nr -k 3 | head -5 | awk '{printf "%.1f%% - %s\n", $3,$11}')
    while IFS= read -r process; do
        print_row "" "$process"
    done <<< "$processes"
}

# Function to get top 5 memory-consuming processes
get_top_memory_processes() {
    print_row "Top 5 Memory-Consuming Processes" ""
    local processes=$(ps aux | sort -nr -k 4 | head -5 | awk '{printf "%.1f%% - %s\n", $4,$11}')
    while IFS= read -r process; do
        print_row "" "$process"
    done <<< "$processes"
}

# Function to get logged-in users
get_logged_users() {
    print_row "Currently Logged-in Users" ""
    local users=$(who | awk '{printf "%s (%s)\n", $1,$2}')
    if [ -z "$users" ]; then
        print_row "" "No users currently logged in"
    else
        while IFS= read -r user; do
            print_row "" "$user"
        done <<< "$users"
    fi
}

# Function to get failed login attempts
get_failed_logins() {
    print_row "Recent Failed Login Attempts" ""
    local failed_logins=""
    if [ -f "/var/log/auth.log" ]; then
        failed_logins=$(grep "Failed password" /var/log/auth.log | tail -5 | awk '{print $1,$2,$3,$(NF-3)}')
    elif [ -f "/var/log/secure" ]; then
        failed_logins=$(grep "Failed password" /var/log/secure | tail -5 | awk '{print $1,$2,$3,$(NF-3)}')
    else
        failed_logins="Cannot access authentication logs"
    fi
    
    if [ -z "$failed_logins" ]; then
        print_row "" "No failed login attempts found"
    else
        while IFS= read -r attempt; do
            print_row "" "$attempt"
        done <<< "$failed_logins"
    fi
}

# Main execution
clear  # Clear the screen before starting
echo "Server Statistics Report - Generated on: $(date)"
echo

# Print initial separator
print_separator

# Call all functions with separators between sections
get_os_info
print_separator
get_uptime
print_separator
get_cpu_usage
print_separator
get_memory_usage
print_separator
get_disk_usage
print_separator
get_top_cpu_processes
print_separator
get_top_memory_processes
print_separator
get_logged_users
print_separator
get_failed_logins
print_separator
