# pyvenv - Python Virtual Environment Manager

A powerful and user-friendly Python virtual environment management tool with multi-language interface and rich environment management features.

[🌐 Switch to Chinese document / 切换到中文文档](./README.md)

---

## 🎄 Demo:
![pyvenv Interface Demo](https://github.com/user-attachments/assets/377d5be7-bfd4-4eef-a326-decdf3e51277)

## ✨ Features

- 🌍 **Bilingual Interface** - Supports Chinese and English interfaces, automatically detects system language
- 🚀 **Quick Creation** - Create and activate virtual environments with one click
- 🔧 **Flexible Configuration** - Support for specifying Python version or path
- 📦 **Package Management** - Easily update all outdated packages in the environment
- 💾 **Backup & Restore** - Complete environment backup and recovery functionality
- 🗑️ **Safe Deletion** - Multiple confirmations to prevent accidental operations
- 🔍 **Detailed Information** - Display environment details, package lists, and disk usage
- 🎯 **Smart Completion** - Bash and Zsh automatic command completion
- 📊 **Status Display** - Clearly marks currently activated environment
- ⚡ **Command Aliases** - Support for custom command aliases to improve efficiency
- 🔒 **Conflict Detection** - Intelligent detection of command name conflicts to avoid overwriting existing commands

## 📦 Installation

### One-click Installation (Recommended)

```bash
# Default Chinese interface
curl -fsSL https://raw.githubusercontent.com/eraycc/pyvenv/main/pyvenv.sh | bash -s -- install

# English interface
curl -fsSL https://raw.githubusercontent.com/eraycc/pyvenv/main/pyvenv.sh | bash -s -- install en

# Force reinstallation
curl -fsSL https://raw.githubusercontent.com/eraycc/pyvenv/main/pyvenv.sh | bash -s -- install --force
```

During installation, you will be prompted to set a command alias (default is `pyv`). You can:
- Press Enter to use the default alias `pyv`
- Enter a custom alias
- Enter `-` to skip alias setup
- After setting an alias, you can use it instead of the default `pyvenv` command

After installation, reopen your terminal or run:

```bash
source ~/.bashrc  # or source ~/.zshrc
```

### Manual Installation

1. Clone the repository:

```bash
git clone https://github.com/eraycc/pyvenv.git
```

2. Run the installation script:

```bash
cd pyvenv
./pyvenv.sh install
```

## 🚀 Quick Start

### Create and Activate Environment

```bash
# Create an environment named myproject
pyvenv new myproject

# Create environment with Python 3.11
pyvenv new ai -p 3.11

# Create environment using specified Python path
pyvenv new demo -p ~/.pyenv/versions/3.12.1/bin/python
```

### Manage Environments

```bash
# List all environments
pyvenv list

# Activate environment
pyvenv use myproject

# Deactivate current environment
pyvenv off

# View environment details
pyvenv info myproject
```

### Package Management

```bash
# Update all packages in current environment
pyvenv update

# Run command in environment (without activation)
pyvenv run myproject -- pip list
```

### Backup & Restore

```bash
# Backup environment
pyvenv backup myproject

# List all backups
pyvenv backups

# Restore environment
pyvenv restore myproject_20241215_143022.tar.gz
```

### Command Aliases

```bash
# Set alias (default alias after installation is pyv)
pyvenv setalias pyv

# View current alias
pyvenv setalias

# Remove alias
pyvenv setalias --remove
```

## 📖 Complete Command Reference

### Basic Commands

| Command | Aliases | Description |
|---------|---------|-------------|
| `list` | `ls` | List all virtual environments |
| `new` | `add` | Create and immediately activate new environment |
| `use` | `on`, `start`, `activate`, `workon` | Activate environment |
| `off` | `exit`, `quit`, `stop`, `deactivate` | Deactivate current environment |

### Environment Management

| Command | Description |
|---------|-------------|
| `create <name> [-p version/path]` | Create environment (without activation) |
| `rm <name>` | Remove environment |
| `rm-all` | Remove all environments |
| `reset [name]` | Reset environment (remove all packages) |
| `info [name]` | Show detailed environment information |
| `where [name]` | Show full path of an environment |
| `run <name> -- <command>` | Run command in an environment |

### Package Management

| Command | Description |
|---------|-------------|
| `update` | Update all outdated packages |

### Backup & Restore

| Command | Description |
|---------|-------------|
| `backup [name]` | Backup environment to tar.gz file |
| `backups` | List all backup files |
| `restore <file>` | Restore environment from backup |
| `rm-backup <file>` | Remove backup file |
| `rm-all-backups` | Remove all backup files |

### Other Commands

| Command | Description |
|---------|-------------|
| `lang [cn/en]` | Set interface language |
| `setalias [alias]` | Set/modify/remove command alias |
| `uninstall` | Uninstall pyvenv |
| `help` | Show help message |
| `version` | Show version information |

## 🗂️ Directory Structure

```
~/.pyvenv/          # Configuration directory
├── pyvenv.sh      # Main script
├── config         # Configuration file (language and alias settings)
└── backups/       # Backup files storage

~/pyvenv/          # Virtual environments storage directory
├── env1/         # Environment 1
├── env2/         # Environment 2
└── ...
```

## 🔧 Configuration

### Language Settings

```bash
# Switch to English
pyvenv lang en

# Switch to Chinese
pyvenv lang cn

# View current language
pyvenv lang
```

### Command Aliases

```bash
# Set alias (e.g., set to pyv)
pyvenv setalias pyv

# View current alias
pyvenv setalias

# Remove alias
pyvenv setalias --remove
```

Alias setup automatically detects conflicts to avoid overwriting existing external commands, shell built-ins, functions, etc.

### Python Version Support
- Supports Python 3.3 and above
- Does not support Python 2.x
- Automatically detects system Python versions
- Supports specifying specific version numbers (e.g., 3.11) or full paths

## 🛠️ Development

### Script Locations

```bash
# Main script
~/.pyvenv/pyvenv.sh

# Configuration file
~/.pyvenv/config
```

### Uninstallation

```bash
# Uninstall via command
pyvenv uninstall

# Or use curl to uninstall
curl -fsSL https://raw.githubusercontent.com/eraycc/pyvenv/main/pyvenv.sh | bash -s -- uninstall
```

Uninstallation options:
1. Uninstall pyvenv only - Keep all virtual environments
2. Complete uninstall - Remove pyvenv and all environments
3. Cancel uninstallation

## 📋 Requirements

- Operating System: Linux, macOS, WSL
- Shell: Bash 4.0+ or Zsh
- Python: 3.3 or higher
- Tools: curl, tar

## 🤝 Contributing

Welcome to contribute code, report issues, or make suggestions!

1. Fork this repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

Thanks to all developers who have contributed to this project!

## 📞 Support

If you encounter issues, please:
1. Check [Issues](https://github.com/eraycc/pyvenv/issues)
2. View help (`pyvenv help`)
3. Open a new Issue

---

## 🔄 Changelog

### v1.9.1 (Latest Version)
- ✅ **Enhanced Command Alias System** - Supports interactive alias setup and intelligent conflict detection
- ✅ **Improved Python Interpreter Resolution** - More accurate version and path recognition
- ✅ **Better Error Handling** - Detailed error messages and validation mechanisms
- ✅ **Optimized Installation Experience** - Improved installation process and prompts
- ✅ **Performance Optimization** - Faster environment creation and listing
- ✅ **Documentation Improvements** - Updated documentation and examples

### v1.9.0
- 🌍 Bilingual interface support
- 📦 Package management features
- 💾 Backup and restore system
- 🔍 Detailed environment information
- 🎯 Smart command completion
- ⚡ Command alias support

### Earlier Versions
- 🚀 Basic virtual environment management
- 🔧 Python version selection support
- 📊 Environment status display
- 🛡️ Safe deletion confirmations
