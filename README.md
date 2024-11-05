```markdown
# Nmap TCP & UDP Port Scanning Script

This Bash script automates a series of Nmap scans on a target IP address, covering both TCP and UDP ports. It performs the following steps:

1. Runs a full TCP port scan to identify open TCP ports.
2. Runs a UDP scan on the top 1000 common UDP ports to identify open UDP ports.
3. For any detected open TCP or UDP ports, it performs detailed version and script scans to gather additional information on services running on those ports.

## Requirements

- **Nmap**: Ensure Nmap is installed. You can install it on most Linux distributions using:
  ```bash
  sudo apt-get install nmap   # Debian/Ubuntu
  sudo yum install nmap       # CentOS/RHEL
  ```

## Usage

1. **Clone or Download the Script**
   
   Save the script to your preferred directory.

2. **Make the Script Executable**
   ```bash
   chmod +x nmap_tcp_udp_scan.sh
   ```

3. **Run the Script**

   Provide the target IP address as an argument:
   ```bash
   ./nmap_tcp_udp_scan.sh <target IP>
   ```

   Example:
   ```bash
   ./nmap_tcp_udp_scan.sh 192.168.1.10
   ```

## Script Workflow

- **Step 1**: Runs a full TCP port scan with `nmap -p- <target IP> -T5` to find all open TCP ports.
- **Step 2**: Extracts the list of open TCP ports and displays them.
- **Step 3**: Runs a UDP scan with `nmap -sU --top-ports 1000 <target IP> -T5` on the 1000 most common UDP ports.
- **Step 4**: Extracts the list of open UDP ports and displays them.
- **Step 5**: For open TCP ports, performs a version and script scan using `nmap -p <open TCP ports> -sV -sC <target IP> -T5`.
- **Step 6**: For open UDP ports, performs a version scan using `nmap -sU -p <open UDP ports> -sV <target IP> -T5`.

## Example Output

```bash
Running full TCP port scan on 192.168.1.10...
Open TCP ports found: 22,80,443

Running version and script scan on open TCP ports...
# (Detailed Nmap output)

Running UDP scan on common ports on 192.168.1.10...
Open UDP ports found: 161,500

Running version scan on open UDP ports...
# (Detailed Nmap output)
```

## Customizing the Script

- **Adjust UDP Port Range**: By default, the script scans the top 1000 UDP ports. You can modify the `--top-ports 1000` option in the UDP scan command to cover more or fewer ports as needed.

## Notes

- The script uses the `-T5` timing option for faster scans, but this may be adjusted based on network conditions and required accuracy.
- Always obtain permission before scanning a target network, as unauthorized scans may be illegal or violate network policies.

## License

This script is provided under the MIT License. Use at your own risk.
```

### Save as `README.md`

This file provides an overview of the script’s purpose, usage instructions, and detailed information on each step.
