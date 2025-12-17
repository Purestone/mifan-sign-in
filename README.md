# Mifan Sign-In

Automated daily sign-in script for mifan.61.com (米饭签到)

## Description

This is a Zsh script that automates the daily sign-in process for multiple accounts on mifan.61.com. The script handles login authentication using MD5 password encryption and performs automated daily sign-ins for configured accounts.

## Features

- 🔐 Secure MD5 password encryption
- 👥 Multiple account support
- 🕒 Automated daily sign-in
- 📱 Mobile user-agent emulation
- 🍪 Cookie-based session management
- 📊 Real-time sign-in results

## Dependencies

The script requires the following tools to be installed on your system:

### Required

- **Zsh** - Z shell (script interpreter)
- **curl** - Command-line tool for HTTP requests
- **openssl** - Cryptographic library (for MD5 hashing)
- **python3** - Python 3.x (for JSON parsing)
- **awk** - Text processing tool

### Installation of Dependencies

#### macOS
```bash
# Zsh and curl are usually pre-installed
# Install openssl (if not present)
brew install openssl

# Install Python 3
brew install python3
```

#### Ubuntu/Debian
```bash
sudo apt update
sudo apt install zsh curl openssl python3 gawk
```

#### Fedora/RHEL/CentOS
```bash
sudo dnf install zsh curl openssl python3 gawk
```

#### Arch Linux
```bash
sudo pacman -S zsh curl openssl python3 gawk
```

## Installation

1. Clone the repository:
```bash
git clone https://github.com/Purestone/mifan-sign-in.git
cd mifan-sign-in
```

2. Make the script executable:
```bash
chmod +x mifan_sign.zsh
```

## Configuration

Edit the `mifan_sign.zsh` file and update the `accounts` array with your credentials:

```zsh
accounts=(
  "YOUR_USERNAME1" "YOUR_PASSWORD1"
  "YOUR_USERNAME2" "YOUR_PASSWORD2"
  "YOUR_USERNAME3" "YOUR_PASSWORD3"
)
```

- Replace `YOUR_USERNAME1`, `YOUR_USERNAME2`, etc. with your actual usernames
- Replace `YOUR_PASSWORD1`, `YOUR_PASSWORD2`, etc. with your actual passwords
- You can add or remove account pairs as needed

⚠️ **Security Notes**: 
- Keep your credentials secure. Do not commit your actual credentials to version control.
- Credentials are stored in plain text within the script file. Ensure proper file permissions are set:
  ```bash
  chmod 700 mifan_sign.zsh  # Only the owner can read, write, and execute
  ```
- Store the script in a secure location with restricted access.

## Usage

Run the script directly:
```bash
./mifan_sign.zsh
```

Or using zsh:
```bash
zsh mifan_sign.zsh
```

### Output Example

```
18:27:13 ACCOUNT1 签到结果: 签到成功
18:27:15 ACCOUNT2 签到结果: 今日已签到
18:27:17 ACCOUNT3 签到结果: 签到成功
```

### Automated Scheduling with Cron

To run the script automatically every day, add it to your crontab:

```bash
# Edit crontab
crontab -e

# Add this line to run daily at 8:00 AM
0 8 * * * /path/to/mifan-sign-in/mifan_sign.zsh >> /path/to/mifan-sign-in/sign.log 2>&1
```

## How It Works

1. **MD5 Encryption**: Passwords are hashed using MD5 before transmission (⚠️ Note: MD5 is cryptographically weak and vulnerable to attacks, but is used here as required by the target service)
2. **Login**: The script logs in to mifan.61.com using HTTP POST request with form data
3. **Session Management**: Cookies are stored in temporary files for session management
4. **Sign-In**: Uses the authenticated session to perform daily sign-in
5. **JSON Parsing**: Python is used to parse JSON responses and extract results
6. **Cleanup**: Temporary cookie files are automatically removed after each sign-in

## Security Considerations

- **MD5 Hashing**: The script uses MD5 for password hashing as required by the mifan.61.com API. MD5 is cryptographically insecure and vulnerable to collision attacks and rainbow table attacks. However, this limitation is imposed by the service itself.
- **Plain Text Storage**: Credentials are stored in plain text within the script. Ensure you set restrictive file permissions (e.g., `chmod 700`) to prevent unauthorized access.
- **HTTPS**: The script uses HTTPS for all communications, which provides transport layer security.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

Copyright (c) 2025 Puyan

## Disclaimer

This script is for educational purposes only. Please ensure you comply with the terms of service of mifan.61.com when using this automation tool.
